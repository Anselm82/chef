CREATE DATABASE IF NOT EXISTS <%= default["mysql"]["database"] %>;
CREATE USER IF NOT EXISTS <%= default["mysql"]["user"] %>@localhost IDENTIFIED BY '<%= default["mysql"]["password"] %>';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON <%= default["mysql"]["database"] %>.* TO <%= default["mysql"]["database"] %>@localhost;
FLUSH PRIVILEGES;