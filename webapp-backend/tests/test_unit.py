from flaskr.injestion import necessaryFieldsMissingNotIncludingTable, necessaryFieldsMissing

def test_necessaryFieldsMissingNotIncludingTable_pass():
    sample_data = {
        "fields": ["field1"],
        "values": ["value1"],
    }
    assert necessaryFieldsMissingNotIncludingTable(sample_data) == False

def test_necessaryFieldsMissingNotIncludingTable_fail_on_fields():
    sample_data = {
        "fields": "",
        "values": [],
    }
    assert necessaryFieldsMissingNotIncludingTable(sample_data) == True

def test_necessaryFieldsMissingNotIncludingTable_fail_on_values():
    sample_data = {
        "fields": [],
        "values": "",
    }
    assert necessaryFieldsMissingNotIncludingTable(sample_data) == True

def test_necessaryFieldsMissingNotIncludingTable_fail_on_incorrect_size():
    sample_data = {
        "fields": ["field1"],
        "values": [],
    }
    assert necessaryFieldsMissingNotIncludingTable(sample_data) == True

def test_necessaryFieldsMissing_pass():
    sample_data = {
        "fields": ["field1"],
        "values": ["value1"],
        "table": "sample_table"
    }
    assert necessaryFieldsMissing(sample_data) == False

def test_necessaryFieldsMissing_fail_on_fields():
    sample_data = {
        "fields": "",
        "values": [],
        "table": "sample_table"
    }
    assert necessaryFieldsMissing(sample_data) == True

def test_necessaryFieldsMissing_fail_on_values():
    sample_data = {
        "fields": [],
        "values": "",
        "table": "sample_table"
    }
    assert necessaryFieldsMissing(sample_data) == True

def test_necessaryFieldsMissing_fail_on_tables():
    sample_data = {
        "fields": [],
        "values": ["table"],
        "table": [] 
    }
    assert necessaryFieldsMissing(sample_data) == True

def test_necessaryFieldsMissing_fail_on_incorrect_size():
    sample_data = {
        "fields": ["field1"],
        "values": [],
        "table": "sample_table" 
    }
    assert necessaryFieldsMissing(sample_data) == True