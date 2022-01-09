CREATE DATABASE IF NOT EXISTS <%= node["mysql"]["database"] %>;
GRANT ALL ON *.* TO '<%= node["mysql"]["user"] %>'@'localhost';
SET PASSWORD FOR '<%= node["mysql"]["user"] %>'@'localhost' = PASSWORD('<%= node["mysql"]["password"] %>');
FLUSH PRIVILEGES;