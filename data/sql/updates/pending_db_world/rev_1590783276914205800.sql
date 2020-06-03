INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590783276914205800');

-- Update gossip_menu table to allow bigger MenuIDs 
-- (needs core change since the var size is limited, returning false when trying to add bigger id values)
ALTER TABLE `gossip_menu` CHANGE COLUMN `MenuID` `MenuID` INT UNSIGNED NOT NULL DEFAULT 0 FIRST;
ALTER TABLE `gossip_menu_option` CHANGE COLUMN `MenuID` `MenuID` INT UNSIGNED NOT NULL DEFAULT 0 FIRST;

DELETE FROM `gossip_menu` WHERE `MenuID`=50000 AND `MenuID`=50001 AND `MenuID`=50002 AND `MenuID`=50003;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (50000, 2693),
(50001, 2694),
(50002, 2695),
(50003, 2696);

-- Lady Katrana: template gossip menu
UPDATE `creature_template` SET `gossip_menu_id`=50000 WHERE  `entry`=1749;

-- Lady Katrana: Gossip menu options
DELETE FROM `gossip_menu_option` WHERE `MenuID`=50000 AND `MenuID`=50001 AND `MenuID`=50002 AND `MenuID`=50003;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES 
(50003, 0, 0, 'Thank you for your time, Lady Prestor.', 0, 1, 3, 0, 0, 0, 0, NULL, 0, 0),
(50002, 0, 0, 'Begging your pardon, Lady Prestor. That was not my intent.', 0, 1, 3, 50003, 0, 0, 0, NULL, 0, 0),
(50001, 0, 0, 'My apologies, Lady Prestor.', 0, 1, 3, 50002, 0, 0, 0, NULL, 0, 0),
(50000, 0, 0, 'Pardon the intrusion, Lady Prestor, but Highlord Bolvar suggested that I seek your advice.', 0, 1, 3, 50001, 0, 0, 0, NULL, 0, 0);


-- Gossip_menu_option condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=50000 AND `SourceEntry`=0 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=9 AND `ConditionTarget`=0 AND `ConditionValue1`=4185 AND `ConditionValue2`=0 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES (15, 50000, 0, 0, 0, 9, 0, 4185, 0, 0, 0, 0, 0, '', NULL);

-- Lady Katrana: smart script
SET @ENTRY := 1749;
DELETE FROM smart_scripts WHERE entryOrGuid = 1749 AND source_type = 0;
UPDATE creature_template SET AIName="SmartAI" WHERE entry= @ENTRY;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(@ENTRY, 0, 0, 1, 62, 0, 100, 0, 50003, 0, 0, 0, 15, 4185, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On gossip action 0 from menu 50003 selected - Action invoker: Call quest 4185 group event happened"),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "On link - Action invoker: Close gossip");
