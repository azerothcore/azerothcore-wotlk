INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617739730080296300');

-- Added missing aura for Magmadar
UPDATE `creature_template_addon` SET `auras`='19449' WHERE  `entry`=11982;

-- 19411 Lava Bomb (used by Magmadar)
DELETE FROM `spell_script_names` WHERE `spell_id` IN (19411, 20474) AND `ScriptName`='spell_magmadar_lava_bomb';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(19411, 'spell_magmadar_lava_bomb'),
(20474, 'spell_magmadar_lava_bomb');

-- Condition for spell "20482 Firesworn Eruption Trigger (SERVERSIDE)"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=3 AND `SourceEntry`=20482 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=12099 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 20482, 0, 0, 31, 0, 3, 12099, 0, 0, 0, 0, '', 'Firesworn Eruption Trigger - should target only Fireworn');

-- Timers update for NPC "Flamewaker Protector"
UPDATE `smart_scripts` SET `event_param1`='5000', `event_param2`='5000', `event_param3`='6500', `event_param4`='6500' WHERE  `entryorguid`=12119 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`='5000', `event_param2`='10000', `event_param3`='7000', `event_param4`='7000' WHERE  `entryorguid`=12119 AND `source_type`=0 AND `id`=1 AND `link`=0;
