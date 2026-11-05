--
-- Add missing TextID entries
DELETE FROM `gossip_menu` WHERE `MenuID` = 10614 AND `TextID` IN (14757, 15043);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(10614, 14757),
(10614, 15043);

UPDATE `gossip_menu_option` SET `OptionType` = 1, `OptionNpcFlag` = 1 WHERE (`MenuID` = 10614) AND (`OptionID` = 2);

-- GOSSIP_MENU_STAGE      = 10614,
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 10614) AND (`SourceEntry` IN (14688, 14737, 14757, 14738, 15043)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- NPC_TEXT_CHALLENGE_1   = 14688,
(14, 10614, 14688, 0, 0, 13, 1, 4, 0, 0, 0, 0, 0, '', 'DATA_INSTANCE_PROGRESS must be INSTANCE_PROGRESS_INITIAL'),
-- NPC_TEXT_CHALLENGE_2   = 14737,
(14, 10614, 14737, 0, 0, 13, 1, 4, 6, 0, 0, 0, 0, '', 'DATA_INSTANCE_PROGRESS must be INSTANCE_PROGRESS_CHAMPIONS_DEAD'),
-- NPC_TEXT_NOT_MOUNTED_A = 14757,  // Alliance text
(14, 10614, 14757, 0, 0, 13, 1, 4, 0, 0, 0, 0, 0, '', 'DATA_INSTANCE_PROGRESS must be INSTANCE_PROGRESS_INITIAL'),
(14, 10614, 14757, 0, 0, 13, 1, 13, 1, 0, 1, 0, 0, '', 'DATA_TEAMID_IN_INSTANCE must not be TEAM_HORDE'),
(14, 10614, 14757, 0, 0, 1, 0, 67830, 1, 0, 1, 0, 0, '', 'must not have aura \'Ride Vehicle\''),
-- NPC_TEXT_CHALLENGE_3   = 14738,
(14, 10614, 14738, 0, 0, 13, 1, 4, 8, 0, 0, 0, 0, '', 'DATA_INSTANCE_PROGRESS must be INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED'),
-- NPC_TEXT_NOT_MOUNTED_H = 15043,  // Horde text
(14, 10614, 15043, 0, 0, 13, 1, 4, 0, 0, 0, 0, 0, '', 'DATA_INSTANCE_PROGRESS must be INSTANCE_PROGRESS_INITIAL'),
(14, 10614, 15043, 0, 0, 13, 1, 13, 1, 0, 0, 0, 0, '', 'DATA_TEAMID_IN_INSTANCE must be TEAM_HORDE'),
(14, 10614, 15043, 0, 0, 1, 0, 67830, 1, 0, 1, 0, 0, '', 'must not have aura \'Ride Vehicle\'');

-- GOSSIP_START_EVENT_1A  = 0,
-- GOSSIP_START_EVENT_1B  = 3, // Skip roleplay
-- GOSSIP_START_EVENT_2   = 1,
-- GOSSIP_START_EVENT_3   = 2,
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 10614) AND (`SourceEntry` IN (0, 1, 2, 3)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElSeGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 10614, 0, 0, 0, 13, 1, 4, 0, 0, 0, 0, 0, '', 'DATA_INSTANCE_PROGRESS must be INSTANCE_PROGRESS_INITIAL'),
(15, 10614, 0, 0, 0, 1, 0, 67830, 1, 0, 0, 0, 0, '', 'must have aura \'Ride Vehicle\''),
(15, 10614, 3, 0, 0, 13, 1, 4, 0, 0, 0, 0, 0, '', 'DATA_INSTANCE_PROGRESS must be INSTANCE_PROGRESS_INITIAL'),
(15, 10614, 3, 0, 0, 1, 0, 67830, 1, 0, 0, 0, 0, '', 'must have aura \'Ride Vehicle\''),
(15, 10614, 1, 0, 0, 13, 1, 4, 6, 0, 0, 0, 0, '', 'DATA_INSTANCE_PROGRESS must be INSTANCE_PROGRESS_CHAMPIONS_DEAD'),
(15, 10614, 2, 0, 0, 13, 1, 4, 8, 0, 0, 0, 0, '', 'DATA_INSTANCE_PROGRESS must be INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED');
