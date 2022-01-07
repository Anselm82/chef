CREATE DATABASE IF NOT EXISTS <%= node["mysql"]["database"] %>;
CREATE USER IF NOT EXISTS <%= node["mysql"]["user"] %>@localhost IDENTIFIED BY '<%= node["mysql"]["password"] %>';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON <%= node["mysql"]["database"] %>.* TO <%= node["mysql"]["database"] %>@localhost;
FLUSH PRIVILEGES;