-- DB update 2023_12_12_03 -> 2023_12_12_04
--
UPDATE `command` SET `help`='Syntax: .wpgps\r\nOutput current position to sql developer log as partial SQL query to be used in pathing (formated for waypoint_data table).\r\nUse .wpgps sai for waypoint (SAI) table format.' WHERE `name`='wpgps';
