INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634143017202196500');

-- remove setinstancedata from bosses using SAI
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (9034, 9035, 9036)) AND (`source_type` = 0) AND (`id` IN (4));
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (9038, 9040)) AND (`source_type` = 0) AND (`id` IN (5));

-- remove the "cannot assist" unit flag
UPDATE `creature_template` SET  `unit_flags` = 32832 WHERE `entry` IN (9034, 9035, 9036, 9037, 9038, 9039, 9040);

-- add doomrel text
DELETE FROM `creature_text` WHERE `CreatureID` = 9039;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`COMMENT`) VALUES
(9039,0,0,'You have challenged the Seven, and now you will die!',12,0,100,0,0,0,4894,0,'start event');
