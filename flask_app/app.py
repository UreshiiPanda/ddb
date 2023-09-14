from flask import Flask
import os
from os import environ
from datetime import timedelta

# Route imports:
import routes.characters
import routes.dungeons
import routes.items
import routes.reload_db
import routes.single_views
import routes.spells_abilities
import routes.users
import routes.inventory


# Separate out MySQL connector so that python files in routes can import it too
from mysql_initializer import mysql

app = Flask(__name__)

# Custom variables defined below:
# Please create env/credentials.py to define these 6 ENV variables
app.config['MYSQL_HOST'] = environ.get('MYSQL_HOST')
app.config['MYSQL_USER'] = environ.get('MYSQL_USER')
app.config['MYSQL_PASSWORD'] = environ.get('MYSQL_PASSWORD')
app.config['MYSQL_DB'] = environ.get('MYSQL_DB')
app.config['MYSQL_PORT'] = int(environ.get('MYSQL_PORT'))
app.config['APP_PORT'] = int(environ.get('APP_PORT'))

# "session_key" is defined in env/credentials.py
# And may be any string
app.secret_key = environ.get('SESSION_KEY')
app.permanent_session_lifetime = timedelta(hours=1)


# Initialize MySQL connector from mysql_initializer.py
mysql.init_app(app)

# Load in the route Blueprints:
app.register_blueprint(routes.characters.characters_bp)
app.register_blueprint(routes.dungeons.dungeons_bp)
app.register_blueprint(routes.items.items_bp)
app.register_blueprint(routes.inventory.inventory_bp)
app.register_blueprint(routes.reload_db.reload_database_bp)
app.register_blueprint(routes.users.users_bp)
app.register_blueprint(routes.single_views.single_views_bp)
app.register_blueprint(routes.spells_abilities.spells_abilities_bp)

# Populate the DB once on startup:
with app.app_context():
    # Comment generate_ddl() during development to save some time:
    # generate_ddl()
    pass

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=environ.get('APP_PORT'), debug=True)
