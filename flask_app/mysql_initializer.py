"""
Separate the mysql connection so that it can be imported in both ../app.py
and the .py files in ../routes directory.
This prevents circular import error if it were to be initialized in app.py
"""

from flask_mysqldb import MySQL

mysql = MySQL()          # Now mysql can be imported by app.py and any other .py files
