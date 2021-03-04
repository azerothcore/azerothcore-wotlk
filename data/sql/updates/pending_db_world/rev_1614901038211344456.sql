INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1614901038211344456');

DELETE FROM `broadcast_text` WHERE `ID`=5140;
DELETE FROM `broadcast_text_locale` WHERE `ID`=5140;
DELETE FROM `creature_text` WHERE `CreatureID`=620 AND `GroupID`=1 AND `BroadcastTextId`=5140;
UPDATE `creature_text` SET `comment`='cluck EMOTE_HELLO' WHERE `CreatureID`=620 AND `GroupID`=0;

