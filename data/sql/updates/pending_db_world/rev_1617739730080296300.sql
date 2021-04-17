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

-- Garr texts
DELETE FROM `creature_text` WHERE `CreatureID`=12057 AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(12057, 0, 0, '%s forces one of his Firesworn minions to erupt!', 41, 0, 100, 0, 0, 0, 8254, 0, 'Garr EMOTE_MASS_ERRUPTION');

-- Timers update for NPC "Flamewaker"
UPDATE `smart_scripts` SET `event_param1`='3000', `event_param2`='6000', `event_param3`='10000', `event_param4`='13000' WHERE  `entryorguid`=11661 AND `source_type`=0 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`='3000', `event_param3`='4000', `event_param4`='6000' WHERE  `entryorguid`=11661 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`='4000', `event_param2`='9000', `event_param3`='5000', `event_param4`='8000' WHERE  `entryorguid`=11661 AND `source_type`=0 AND `id`=2 AND `link`=0;

-- Removed C++ script from "Son of Flame"
update creature_template SET `ScriptName`='' WHERE entry=12143;

-- Renamed Core Hound script
update creature_template set `ScriptName`='npc_mc_core_hound' WHERE entry=11671;
