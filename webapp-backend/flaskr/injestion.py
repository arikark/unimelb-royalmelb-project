from flask import Flask, request, jsonify, Response, abort, make_response, Blueprint, g, flash
from json import dumps
from flaskr.db import get_db
import sys
import math
import MySQLdb
import  mysql.connector
import pandas as pd
from flaskr.auth import auth_decorator
from flask_cors import CORS, cross_origin
import json

bp = Blueprint("injestion", __name__)
CORS(bp)

@bp.route("/")
def index():
    return "Welcome to ingestion"

@bp.route("/csv", methods=["POST"])
@auth_decorator()
def csvInjestion() -> str:
    files = request.files
    get_db().start_transaction()
    order_of_files = {
        "jsons": [],
        "results": [],
        "facilities": []
    }
    try:
        for key in files:
            if key.endswith(".csv"):
                df_csv = pd.read_csv(files[key], dtype=object)
                if "results" in key:
                    order_of_files["results"].append(df_csv)
                elif "facility_stated" in key:
                    order_of_files["facilities"].append(df_csv)
            elif key.endswith(".json"):
                order_of_files["jsons"].append(files[key])
            else:
                return create_error_400("Invalid file. Files must include either: '.json', or csvs with 'results' or 'facility_stated' in the filenames")
        for json in order_of_files["jsons"]:
            process_meta_data(json)
        for results in order_of_files["results"]:
            process_results_csv(results)
        for facilities in order_of_files["facilities"]:
            process_facility_stated_csv(facilities)
        get_db().commit()
    except mysql.connector.Error as err:
        print(err)
        print("Error Code:", err.errno)
        print("SQLSTATE", err.sqlstate)
        print("Message", err.msg)
        get_db().rollback()
        return create_error_400(err.msg)
  
    return make_response({"message": "Successfully added data"}, 200)

def process_results_csv(results_df):
    columns = list(results_df.columns)
    cursor = get_db().cursor(buffered=True)
    dataToInsert = []
    for _, result in results_df.iterrows():
        valueList = []
        for column in columns:
            if (isinstance(result[column], float) and math.isnan(result[column ])):
                valueList.append(None)
            else:
                valueList.append(result[column])
        dataToInsert.append(tuple(valueList))
    stmt = "INSERT INTO results (" + ", ".join(columns) + ") VALUES ( " + ("%s," * len(columns))[:-1] + ")"
    cursor.executemany(stmt, dataToInsert)
    cursor.close()
    return

def process_facility_stated_csv(f_df):
    columns = list(f_df.columns)
    cursor = get_db().cursor(buffered=True)
    dataToInsert = []
    for _, result in f_df.iterrows():
        valueList = []
        for column in columns:
            if (isinstance(result[column ], float) and math.isnan(result[column ])):
                valueList.append(None)
            else:
                valueList.append(result[column])
        dataToInsert.append(tuple(valueList))
    
    stmt = "INSERT INTO facility_stated (" + ", ".join(columns) + ") VALUES ( " + ("%s," * len(columns))[:-1] + ")"
    print(stmt)
    cursor.executemany(stmt, dataToInsert)
    cursor.close()
    return

def process_meta_data(meta_json):
    meta_data = json.load(meta_json)
    addBulkFields(meta_data, False)
    return

@bp.route("/table-fields", methods=["GET"])
@auth_decorator()
def getAllTableAndFields():
    from collections import defaultdict
    connection = get_db()
    cursor = connection.cursor(buffered=True)
    db_cursor = connection.cursor(buffered=True)
    db_cursor.execute("SELECT DATABASE();")
    db_name = db_cursor.fetchone()[0]
    cursor.execute("SHOW TABLES")

    tableWithFields = defaultdict(lambda : [])
    for (table,) in cursor.fetchall():
        attrCursor = connection.cursor(buffered=True)
        print(f'SHOW COLUMNS FROM {db_name}.{table};')
        try: 
            decodedTable = table
            if isinstance(table, bytearray):
                decodedTable = table.decode('UTF-8')
            attrCursor.execute(f'SHOW COLUMNS FROM {db_name}.{str(decodedTable)};')
        except mysql.connector.Error as err:
            print(err)
            print("Error Code:", err.errno)
            print("SQLSTATE", err.sqlstate)
            print("Message", err.msg)
            get_db().rollback()
            return create_error_400(f'SHOW COLUMNS FROM {db_name}.{str(decodedTable)};')

        for columnDetails in attrCursor.fetchall():
            tableWithFields[table].append({
                "field":columnDetails[0],
                "type":columnDetails[1].decode('UTF-8')
            })
        attrCursor.close()

    return make_response(tableWithFields, 200)

@bp.route("/fields", methods=["POST"])
@auth_decorator()
def insert_field():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    if necessaryFieldsMissing(body):
        return create_error_400("Missing field: 'table', 'fields' or 'values'")
    cursor = get_db().cursor(buffered=True)
    try:
        insertTableFields(body, cursor, updateOrReplace)
    except mysql.connector.Error as err:
        print(err)
        print("Error Code:", err.errno)
        print("SQLSTATE", err.sqlstate)
        print("Message", err.msg)
        get_db().rollback()
        return create_error_400(err.msg)
    except:
        get_db().rollback()
        return create_error_400("Failed to add data")
    return make_response({"message": "Successfully added field data"}, 200)

@bp.route("/bulk-fields", methods=["POST"])
@auth_decorator()
def bulk_fields():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    get_db().start_transaction()
    addBulkFields(body, updateOrReplace)
    get_db().commit()
    return make_response({"message": "Successfully added bulk data"}, 200)

def addBulkFields(body, updateOrReplace):
    cursor = get_db().cursor(buffered=True)
    for item in body:
        if necessaryFieldsMissing(item):
            get_db().rollback()
            return create_error_400("Missing field: 'table', 'fields' or 'values'")
        try:
            insertTableFields(item, cursor, updateOrReplace)
        except mysql.connector.Error as err:
            print(err)
            print("Error Code:", err.errno)
            print("SQLSTATE", err.sqlstate)
            print("Message", err.msg)
            get_db().rollback()
            return create_error_400(err.msg)
        except:
            get_db().rollback()
            return create_error_400("Failed to add data")        
    return 

@bp.route("/bulk-tables", methods=["POST"])
@auth_decorator()
def bulk():
    updateOrReplace = request.args.get('updateOrReplace') == "true"
    body = request.get_json()
    
    if not isinstance(body, list):
        return create_error_400("Invalid Payload")
    get_db().start_transaction()
    cursor = get_db().cursor(buffered=True)
    set_of_tables = set()
    list_of_tables = []
    for tableItem in body:
        if not isinstance(tableItem, dict):
            get_db().rollback()
            return create_error_400("Invalid Payload")
        if ("table" not in tableItem) or ("insertions" not in tableItem):
            get_db().rollback()
            return create_error_400("Invalid Payload")
        if not isinstance(tableItem["insertions"], list):
            get_db().rollback()
            return create_error_400("Invalid Payload")
        for insertion in tableItem["insertions"]:
            if necessaryFieldsMissingNotIncludingTable(insertion):
                get_db().rollback()
                return create_error_400("Missing field: 'fields' or 'values'")
        set_of_tables.add(tableItem["table"])
        list_of_tables.append(tableItem["table"])

    if not (len(list_of_tables) == len(set_of_tables)):
        get_db().rollback()
        return create_error_400("You put duplicate table insertions")
    for tableItem in body:
        for insertion in tableItem["insertions"]:
            try:    
                insertTableFields({
                    "table": tableItem["table"],
                    "fields": insertion["fields"],
                    "values": insertion["values"]
                }, cursor, updateOrReplace)
            except mysql.connector.Error as err:
                print(err)
                print("Error Code:", err.errno)
                print("SQLSTATE", err.sqlstate)
                print("Message", err.msg)
                get_db().rollback()
                return create_error_400(err.msg)
            except:
                get_db().rollback()
                return create_error_400("Failed to add data")
    get_db().commit()
    return make_response({"message": "Successfully added bulk data"}, 200)


def insertTableFields(body, cursor, updateOrReplace):
    vals = [ "'" + val + "'" if val else "NULL" for  val in body["values"]]
    stmt = f'{"REPLACE" if updateOrReplace else "INSERT"} INTO {body["table"]} ({", ".join(body["fields"])}) VALUES ({", ".join(vals)});'
    cursor.execute(stmt)
    return

def necessaryFieldsMissing(body):
    if not isinstance(body, dict):
        return True
    return (not ("fields" in body and isinstance(body["fields"], list)) or not ("values" in body and isinstance(body["values"], list)) or not ("table" in body) or not(len(body["fields"]) == len(body["values"])) )

def necessaryFieldsMissingNotIncludingTable(body):
    if not isinstance(body, dict):
        return True
    return (not ("fields" in body and isinstance(body["fields"], list)) or not ("values" in body and isinstance(body["values"], list))  or not(len(body["fields"]) == len(body["values"])) )

def create_error_400(errorMessage):
    abort(make_response(jsonify(message=errorMessage), 400))