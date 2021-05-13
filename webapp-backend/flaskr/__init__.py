import os

from flask import Flask
from flask_cors import CORS
from flaskr import settings 

def create_app(test_config=None):
    """Create and configure an instance of the Flask application."""
    app = Flask(__name__, instance_relative_config=True)
    CORS(app)
    app.config['CORS_HEADERS'] = 'Content-Type'

    app.config.from_mapping(
        # a default secret that should be overridden by instance config
        SECRET_KEY="dev",
        # store the database in the instance folder
        DATABASE= {
            'user': settings.DB_USERNAME,
            'password': settings.DB_PASSWORD,
            'host': settings.DB_HOST,
            'port': settings.DB_PORT,
            'database': settings.DATABASE_NAME,
            'auth_plugin':'mysql_native_password'
        },
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile("config.py", silent=True)
    else:
        # load the test config if passed in
        app.config.update(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass
    # register the database commands
    from flaskr import db

    db.init_app(app)

    # apply the blueprints to the app
    from flaskr import injestion, auth

    app.register_blueprint(injestion.bp)
    app.register_blueprint(auth.bp)

    app.add_url_rule("/", endpoint="index")

    return app
