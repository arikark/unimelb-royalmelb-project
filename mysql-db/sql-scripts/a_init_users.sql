-- This script initalises the users for the db upon startup

CREATE ROLE 'db_writer_role';
CREATE ROLE 'db_reader_role';
CREATE ROLE 'db_admin_role';

GRANT ALL ON aa_audit.* TO 'db_admin_role';
GRANT SELECT ON aa_audit.* TO 'db_reader_role';
GRANT INSERT, UPDATE, DELETE ON aa_audit.* TO 'db_writer_role';

CREATE USER 'webapp_user'
    IDENTIFIED WITH mysql_native_password BY 'webapp_password' 
    DEFAULT ROLE 'db_writer_role'
    COMMENT 'User for webapp';

CREATE USER 'jupyter_user' 
    IDENTIFIED WITH mysql_native_password BY 'jupyter_password' 
    DEFAULT ROLE 'db_reader_role'
    COMMENT 'User for jupyter';

CREATE USER 'dbmaintainer_user' 
    IDENTIFIED WITH mysql_native_password BY 'dbmaintainer_password'
    DEFAULT ROLE 'db_admin_role'
    COMMENT 'User for db maintenance';

SET DEFAULT ROLE ALL TO
  'webapp_user',
  'jupyter_user',
  'dbmaintainer_user';