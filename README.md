# D&DB

#### Dungeons & Dragons DB Manager CRUD app written in Flask

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

<h4>Tech Stack:</h4>  Flask ~ MySQL ~ HTML ~ CSS ~ Javascript ~ Material Design Lite  <br><br>


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED WITH DOCKER -->
## Getting Started With Docker:<br>

0. If you already have Docker installed on your machine, then this app can be simply run with the
   following instructions. The docker-compose.yml contains all of the Docker info needed
   to understand the context in which the app runs, including: builds, ports, network, volume
   storage, and environment variables. Note that these environment variables can also be moved into
   a .env file and more can be read about how to do that here:
   [Docker Env Vars](https://docs.docker.com/compose/environment-variables/set-environment-variables/)

1. Clone all project files into a root working directory.
    ```sh
        git clone https://github.com/UreshiiPanda/ddb.git
    ```
    NOTE: the SQL script in ```flask_app/db/ddl.sql``` has been setup to load the app with dummy data
          solely for demo purposes. Feel free to remove these statements from the script if you wish
          to start the app without any demo data.
    
3. From that root directory, run docker compose:
    ```sh
        docker compose up
    ```
    
4. To stop the app, stop docker compose from another terminal:
    ```sh
        docker compose down
    ```


<br><br>
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED WITHOUT DOCKER -->
## Getting Started Without Docker:<br>

1. Clone all project files into a root working directory.
    ```sh
        git clone https://github.com/UreshiiPanda/ddb.git
    ```

2. Start up your mysql and load the DB tables in your local MySQL with default data (or create your own data)
   ```sh
      source flask_app/db/ddl.sql
   ```
   NOTE:  MySQL must be started from the root working directory since this is a relative path
   
3. In the flask_app directory, setup a Python virtual environment:
    ```sh
      cd flask_app
      pip3 install --user virtualenv
      python3 -m venv venv
      source venv/bin/activate
    ```
    
4. Install dependencies listed in requirements.txt:
    ```sh
      pip3 install -r requirements.txt
    ```
    NOTE:  packages may need to be updated or installed individually. Sometimes
           pip will try to install dependencies from cache, so the following
           --no-cache-dir flag is sometimes needed to avoid this problem
      ```sh
         pip3 install --no-cache-dir mysqlclient
      ```

5. Setup the required environment variables. Note that this can also be done via a
    ```.env``` file and appropriate import statements.
   ```sh
       export MYSQL_HOST='your_mysql_host'
       export MYSQL_USER='your_mysql_username'
       export MYSQL_PASSWORD='your_mysql_password'
       export MYSQL_DB='your_mysql_database'
       export SESSION_KEY='any_string'
       export MYSQL_PORT=3306
       export APP_PORT=8000
   ```
      NOTE:   "your_mysql_" variables are custom-defined and depend on your own mysql database credentials<br>
      NOTE:   the session_key variable can be set to <i>any</i> string value<br>
   
6. Start the Flask app:
   ```sh
     python3 app.py
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

