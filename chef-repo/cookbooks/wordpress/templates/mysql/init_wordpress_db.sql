ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '<%= node["mysql"]["password"] %>';
CREATE DATABASE IF NOT EXISTS <%= node["mysql"]["database"] %>;
CREATE USER IF NOT EXISTS <%= node["mysql"]["user"] %>@localhost IDENTIFIED WITH mysql_native_password BY '<%= node["mysql"]["password"] %>';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON <%= node["mysql"]["database"] %>.* TO <%= node["mysql"]["database"] %>@<%= node["mysql"]["ip"] %>;
FLUSH PRIVILEGES;