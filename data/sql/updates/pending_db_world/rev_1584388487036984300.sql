INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584388487036984300');

UPDATE `creature_template` SET `npcflag`=`npcflag`&~2 WHERE `entry` IN (15350,15351);
DELETE FROM `creature_queststarter` WHERE `quset` IN (8388,13475,8371,8385,13477,13478,13476,8367);
DELETE FROM `creature_questender` WHERE `quest` IN (8388,13475,8371,8385,13477,13478,13476,8367);
DELETE FROM `disables` WHERE `sourceType`=1 AND `entry` IN (8388,13475,8371,8385,13477,13478,13476,8367);
INSERT INTO `disables` (`sourceType`,`entry`,`flags`,`params_0`,`params_1`,`comment`) VALUES
(1,8388,0,'','','Deprecated Quest: For Great Honor'),
(1,13475,0,'','','Deprecated Quest: For Great Honor'),
(1,13476,0,'','','Deprecated Quest: For Great Honor'),
(1,8367,0,'','','Deprecated Quest: For Great Honor'),
(1,8371,0,'','','Deprecated Quest: Concerted Efforts'),
(1,8385,0,'','','Deprecated Quest: Concerted Efforts'),
(1,13477,0,'','','Deprecated Quest: Concerted Efforts'),
(1,13478,0,'','','Deprecated Quest: Concerted Efforts');
