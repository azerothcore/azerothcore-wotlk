INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650152443729183400');

-- Update to CONDITION_QUESTREWARDED as CONDITION_QUEST_COMPLETE is wrong for this.
UPDATE `conditions` SET `ConditionTypeOrReference` = 8, `Comment` = 'Show Gossip Menu - If Quest: What the Flux? is Rewarded' WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 5962 AND `SourceEntry` = 7115 AND `ConditionTypeOrReference` = 28;
-- Add Honored\Revered condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 5962 AND `SourceEntry` = 7121;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(14, 5962, 7121, 0, 0, 5, 0, 59, 96, 0, 0, 0, 0, '', 'Show Gossip Menu - If player is Honored\Revered with Thorium Brotherhood (59)');
