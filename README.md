# D&DB

#### Dungeons & Dragons DB Manager written in Flask

<a name="readme-top"></a>

<!-- D&DB Gif -->
![ddb gif](https://github.com/UreshiiPanda/ddb/assets/39992411/20b02b37-bfe8-41b9-8f10-db552834da5d)


<!-- ABOUT THE PROJECT -->
## About The Project
The primary purpose of this app is to help manage the database of a program which allows 
D&D players to manage their D&D data, as well as to create new characters, dungeons, items, 
spells, and abilities. This Flask app thus takes an Admin perspective for helping maintain
a MySQL database which stores all of the D&D data for players. Since characters are the 
primary role/creation in D&D, the database features a "character-first" construction, where
all other info (eg. Dungeons) are linked/created either directly or indirectly to the 
characters. Users will thus own characters, and those characters will be linked to various
dungeons, items, spells, and abilities as each player wishes. Players are free to create their
own characters, dungeons, items, spells, and abilities a la D&D style.

<h4>Tech Stack:</h4>  Flask/MySQL/HTML/CSS/Javascript<br><br>


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting Started:<br>

1. Clone all project files into a root working directory.
    ```sh
        git clone https://github.com/UreshiiPanda/ddb.git
    ```

2. Store environment variables by creating ```/env/credentials.py``` in the working directory.<br>
   Place these environment variable definitions into this file:<br>
      ```py
        ENV_HOST = 'your_mysql_host'
        ENV_USERNAME = 'your_mysql_username'
        ENV_PASSWORD = 'your_mysql_password'
        ENV_DATABASE = 'your_mysql_database'
        session_key = 'any_string'
      ```

      NOTE:   "your_mysql_" variables are custom-defined and depend on your own mysql database credentials<br>
      NOTE:   the session_key variable can be set to <i>any</i> string value<br>

3. Start up your mysql and load the DB tables in your local MySQL with default data (or create your own data)
   ```sh
      source db/ddl.sql
   ```
   NOTE:  MySQL must be started from the working directory since this is a relative path
      
4. Set global variable ```APP_PORT``` within app.py to the port you would like app.py to run on.
   The default app_port is set to: ```APP_PORT = 33333```
   
5. In the working directory, setup a Python virtual environment:
    ```sh
      pip3 install --user virtualenv
      python3 -m venv venv
      source venv/bin/activate
    ```
    
6. Install dependencies listed in requirements.txt:
    ```sh
      pip3 install -r requirements.txt
    ```
    NOTE:  packages may need to be updated or installed individually. Sometimes
           pip will try to install dependencies from cache, so the following
           --no-cache-dir flag is sometimes needed to avoid this problem
      ```sh
         pip3 install --no-cache-dir mysqlclient
      ```

8. Start the Flask app:
   ```sh
     python3 app.py
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

