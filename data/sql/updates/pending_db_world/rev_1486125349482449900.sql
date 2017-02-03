INSERT INTO version_db_world (`sql_rev`) VALUES ('1486125349482449900');

DELETE FROM `creature` WHERE `guid` = "1978829";
DELETE FROM `creature` WHERE `guid` = "1978828";
DELETE FROM `linked_respawn` WHERE `guid` = "79283";
DELETE FROM `linked_respawn` WHERE `guid` = "79284";
DELETE FROM `linked_respawn` WHERE `guid` = "79285";
DELETE FROM `linked_respawn` WHERE `guid` = "79368";
DELETE FROM `linked_respawn` WHERE `guid` = "79378";
DELETE FROM `linked_respawn` WHERE `guid` = "79379";
DELETE FROM `linked_respawn` WHERE `guid` = "79380";
DELETE FROM `linked_respawn` WHERE `guid` = "79383";
UPDATE `quest_template_addon` SET `SpecialFlags` = "2" WHERE `ID` = "10409";