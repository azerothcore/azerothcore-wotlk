DELETE FROM `areatrigger_scripts` WHERE `entry` = 4896;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(4896,'SmartTrigger');

-- AreaTrigger
DELETE FROM `smart_scripts` WHERE `entryorguid`=4896 AND `source_type`=2 AND `id`=0 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(4896, 2, 0, 0, 46, 0, 100, 0, 4896, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 114932, 25802, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Set Data 0 1');


DELETE FROM `smart_scripts` WHERE `entryorguid`=25802 AND `source_type`=0 AND `id`=1 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(25802, 0, 1, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 80, 2580200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw - On Data Set 0 1 - Run Script');

-- Kaw
UPDATE `creature_template` SET unit_flags=0, AIName='SmartAI' WHERE entry=25802;

DELETE FROM `smart_scripts` WHERE entryorguid=25802 AND source_type=0;
DELETE FROM `smart_scripts` WHERE entryorguid=25802*100 AND source_type=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(25802, 0, 0, 0, 6,  0, 100, 0, 0, 0, 0, 0, 0, 11, 46310, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,0, 'Kaw - On Death - Cast Drop War Halberd'),
(25802, 0, 1, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 80, 2580200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw - On Data Set 0 1 - Run Script'),
(25802, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaw - On Death - Force Despawn Self'),

 
(25802*100, 9, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,0, 'Kaw - Timed - Yell'),
(25802*100, 9, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,0,  'Kaw - Timed - Enable Running'),
(25802*100, 9, 2, 0, 0, 0, 100, 1, 3000, 3000, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0,0, 3974.17, 5476.31, 35.602, 5.564, 'Kaw - Timed - Move to Moria'),
(25802*100, 9, 3, 0, 0, 0, 100, 1, 2500, 2500, 0, 0, 0, 11, 46260, 2, 0, 0, 0, 0, 19, 25881, 50, 0, 0, 0, 0, 0,0,  'Kaw - Timed - Mount to Moria');

DELETE FROM `creature_loot_template` WHERE `Entry`=25802 AND `Item`=35234 AND `Reference`=0 AND `GroupId`=0;

-- Moria
UPDATE `creature_template` SET unit_flags=0, AIName='SmartAI' WHERE entry=25881;

DELETE FROM `smart_scripts` WHERE entryorguid=25881 AND source_type=0;
DELETE FROM `smart_scripts` WHERE entryorguid=25881*100 AND source_type=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(25881, 0, 0, 0, 8, 0, 100, 1, 46315, 0, 0, 0, 0, 80, 25881*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,0,  'Moria - On spell hit - Start Event'),
(25881, 0, 1, 0, 8, 0, 100, 1, 46317, 0, 0, 0, 0, 80, 25881*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,0,  'Moria - On spell hit - Start Event'),
(25881, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 19, 33536, 0, 0, 0, 0, 0, 19, 25802, 30, 0, 0, 0, 0, 0,0, 'Moria - On death - Make Kaw attackable'),
(25881, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,0,  'Moria - Reset - Set passive'),
(25881, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,0, 'Moria - Reset - Dismount Kaw'),
(25881, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Moria - On Death - Force Despawn Self'),

(25881*100, 9, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 11, 17683, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,0,  'Moria - Timed - Heal self'),
(25881*100, 9, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 80, 25802*100, 2, 0, 0, 0, 0, 19, 25802, 80, 0, 0, 0, 0, 0, 0, 'Moria - Timed - Activate Kaw script'),
(25881*100, 9, 2, 0, 0, 0, 100, 1, 5500, 5500, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,0,  'Moria - Timed - Set aggresive'),
(25881*100, 9, 3, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 11, 17683, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,0,  'Moria - Timed - Heal self');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 4896 AND `SourceId` = 2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,4896,2,0,9,0,11879,0,0,0,0,0,'','Execute Event if player has taken quest');
