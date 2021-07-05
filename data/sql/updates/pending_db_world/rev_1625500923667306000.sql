INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625500923667306000');

/* Add new gossip */
INSERT INTO `npc_text`(`ID`,`text0_0`,`text0_1`,`BroadcastTextID0`,
`lang0`,`Probability0`)
VALUES
(50031,
"Alas $N, I am much too busy to talk. As I mentioned, I need time to think on the situation at hand.$B$BI wish you luck in your travels. Good day.",
"Alas $N, I am much too busy to talk. As I mentioned, I need time to think on the situation at hand.$B$BI wish you luck in your travels. Good day.",0,0,0);

/* Create new gossip menuID */
DELETE FROM `gossip_menu` WHERE (`MenuID` = 61023) AND (`TextID` IN (15296, 50031));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(61023, 15296),
(61023, 50031);

/* Add condition for the second gossip */
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 61023) AND (`SourceEntry` = 50031) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 28) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 8336) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 61023, 50031, 0, 0, 8, 0, 8336, 0, 0, 0, 0, 0, '', '');

/* Link creature_template with new gossip menuID */
UPDATE `creature_template` SET `gossip_menu_id` = 61023 WHERE (`entry` = 15296);
