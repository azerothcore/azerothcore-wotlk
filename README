* Copyright (C) 2007 - 2015 Hyperweb2 All rights reserved.
* GNU General Public License version 3; see www.hyperweb2.com/terms/

#
# HOW TO USE MYSQL_* tools
#

Before starting to dump/import, please rename mysql_config.dist in mysql_config and change infos using your configurations
If you are using AppArmor , edit /etc/apparmor.d/usr.sbin.mysqld and add directory that must be used by the dump

to easy dump/import the database, use ./mysql-tools command that includes dump and import scripts, instead if you need to separate the functions ,
 use ./mysql-dump and ./mysql-import.

mysql-tools utilization:

#  This script automatically dump and import sql files
#
#	syntax: ./mysql_tools <opt> <database> <tables> <method> <configpath>
#	OPT -> dump/import   ( export / import tables )
#	TABLES -> use "," to separate table names; ex: mysql_dump "" "table1,table2..tableN". Leave blank to dump all tables.
#	DATABASE -> specify database to process, use "" for default ( see in mysql-config )
#	METHOD -> 0/1 (0: no fulldb,1: use fulldb) default: ( see in mysql-config )
#	CONFIGPATH -> specify alternative path of config file, use "" to check in source folder
#


mysql-dump utilization: 

# This script will export all tables from specified db and tables in separated sql files
# it can also export the full db in a single sql file.
#
# syntax: ./mysql_dump <database> <tables> <method> <configpath>
# options are not required, because values can be defined in config file:
# DATABASE -> specify database to dump, use "" for default ( see in mysql-config )
# TABLES -> use "" to dump all tables. Use "," to separate table names; ex: mysql_dump "" "table1,table2..tableN" 
# METHOD -> 0/1 (0: no fulldb,1: with fulldb) default: ( see in mysql-config )
# CONFIGPATH -> specify alternative path for config file, use "" to check in source folder.
#


mysql-import utilization:

# This script will import the contents of the sql/ directory to the MySQL database.
# You can choose to import table by table, or the entire db
#
# syntax: ./mysql_import <database> <tables> <method> <configpath>
# options are not required, because values can be defined in config file:
#
# DATABASE -> specify database to dump, use "" for default ( see in mysql-config )
# TABLES -> use "," to separate table names; ex: mysql_dump "" "table1,table2..tableN"    ..OR use "" to dump all tables.
# METHOD -> 1/0  ( 1: by folder, 0: by full dump) default: ( see in mysql-config )
# CONFIGPATH -> specify alternative path for config file, use "" to check in source folder.
#
