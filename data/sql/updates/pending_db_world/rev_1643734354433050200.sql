INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643734354433050200');

UPDATE `creature_template` SET `gossip_menu_id` = 61026 WHERE `entry` = 3567;
DELETE FROM `npc_text` WHERE `ID` = 50032;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (50032,
        'Well met, $N. It is good to see that $cs like yourself are taking an active part in protecting the groves.',
        'Well met, $N. It is good to see that $cs like yourself are taking an active part in protecting the groves.', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = 61026 AND `TextID` = 50032;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(61026, 50032);
