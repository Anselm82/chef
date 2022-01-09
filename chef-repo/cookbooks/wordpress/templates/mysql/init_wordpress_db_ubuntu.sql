CREATE DATABASE IF NOT EXISTS <%= node["mysql"]["database"] %>;
CREATE USER IF NOT EXISTS '<%= node["mysql"]["user"] %>'@'localhost' IDENTIFIED BY '<%= node["mysql"]["password"] %>';
GRANT ALL ON <%= node["mysql"]["database"] %>.* TO '<%= node["mysql"]["user"] %>'@'localhost';
FLUSH PRIVILEGES;