INSERT INTO version_db_world (`sql_rev`) VALUES ('1515648036333645900');

/* Create the command. */
DELETE FROM `command` WHERE `name` = "mutehistory";
INSERT INTO `command` (`name`,`security`,`help`) VALUES ('mutehistory', 2, "Syntax: .mutehistory $accountName. Shows mute history for an account.");
