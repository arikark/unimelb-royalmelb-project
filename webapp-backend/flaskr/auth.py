import requests
from flask import Flask, request, jsonify, Response,abort,make_response, flash, Blueprint
from functools import wraps
from flask_cors import CORS

bp = Blueprint("auth", __name__, url_prefix="/")
CORS(bp)
@bp.route("/login", methods=["POST"])
def login():
    user_details = request.get_json()
    url = "http://jupyterhub:8000/hub/api/authorizations/token"
    headers = {'content-type': 'application/json'}
    res = requests.post(url, json=user_details, headers=headers)
    if (not res.ok):
        abort(make_response(jsonify(message="Access Forbidden"), 401))
    return make_response(res.json(),200)


def auth_decorator():
    def _auth_decorator(f):
        @wraps(f)
        def __auth_decorator(*args, **kwargs):
            if ("Authorization" not in request.headers):
                abort(make_response(jsonify(message="Access Forbidden"), 401))
            
            token = request.headers["Authorization"]
            if not token:
                abort(make_response(jsonify(message="Access Forbidden"), 401))
            url = "http://jupyterhub:8000/hub/api/user"
            headers = {
                "content-type": "application/json",
                "Authorization": token
            }
            res = requests.get(url, headers=headers)
            
            if (not res.ok):
                abort(make_response(jsonify(message="Access Forbidden"), 401))
            return  f(*args, **kwargs)
        return __auth_decorator
    return _auth_decorator