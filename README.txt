Reservation and Sales System
This project is a web application developed in Flask, using a MySQL database. Below are the steps required to configure and run the system locally or on any server.


Prerequisites
A system with Python 3.10+ and pip installed.
MySQL or MariaDB installed locally or on the server.
Project files compressed in proyectofinal.tar.
dump.sql and procedures.sql files available in the same folder as the project.


Steps to Run the System
1. Extract the Project Files
Place the proyectofinal.tar file in a desired directory and extract its contents:
tar -xvf proyectofinal.tar  
cd proyectofinal

2. Set Up the Database

Log into MySQL as root:
mysql -u root -p

Create the database:
CREATE DATABASE restaurantes;

Create a user with appropriate permissions:
CREATE USER 'user_01'@'localhost' IDENTIFIED BY '666';  
GRANT ALL PRIVILEGES ON restaurantes.* TO 'user_01'@'localhost';  
FLUSH PRIVILEGES;

Exit MySQL and load the database dump:
mysql -u user_01 -p restaurantes < dump.sql

Load the stored procedures:
mysql -u user_01 -p restaurantes < procedures.sql

3. Install Python Dependencies
Navigate to the project folder and install the required Python libraries using pip:
pip install -r requirements.txt

4. Configure the Flask Environment
Set the Flask app environment variable:
export FLASK_APP=app.py

5. Run the Application
Start the Flask application:
flask run --host=0.0.0.0

By default, Flask runs on port 5000. If needed, specify a different port using the --port flag:

flask run --host=0.0.0.0 --port=8080

Access the System
In a web browser, navigate to:
http://localhost:5000
or replace localhost with your server's IP address if running on a remote machine.

Important Notes
Ensure the port you are using (default is 5000) is not blocked by a firewall if running the system on a server.
You can adapt the Flask environment for production by using a WSGI server like Gunicorn or deploying on platforms like Docker or Heroku.
