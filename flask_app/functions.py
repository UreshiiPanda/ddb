"""
 global app functions

"""

from mysql_initializer import mysql
from flask import flash, session

def flash_err(e):
    """
    Provides more details for flash() messages on Exception
    :param e: type() Exception
    """
    if len(e.args) > 1:  # This will give more info back to the UX
        flash(f"Row insertion error: {e.args[1]}", "error")
    elif e.args:
        flash(f"Column: {e.args[0]}: {e}", "error")
    else:
        flash(f"Row insertion error: {e}", "error")

def generate_ddl():
    """
    Executes ddl.sql DB Schema.
    Drops all tables and recreates default DB with sample data
    """
    cur = mysql.connection.cursor()
    schema = open('db/ddl.sql', mode='r')
    statement_so_far = ''
    # Convert multiline SQL statements into single line statements:
    for line in schema.readlines():
        line = line.rstrip()
        statement_so_far += '\r\n' + line
        # Execute a SQL statement when we encounter a ';' in the DDL
        if line.endswith(';'):
            print(statement_so_far)
            cur.execute(statement_so_far)
            mysql.connection.commit()
            statement_so_far = ''
    session['username'] = None
    cur.close()
