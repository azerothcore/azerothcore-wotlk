-- DB update 2023_10_10_05 -> 2023_10_10_06
-- Quest: Cuergo's Gold
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `ScriptName` = '' WHERE `entry` = 142189;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 142189);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(142189, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 14218900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Inconspicuous Landmark - On Gameobject State Changed - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 14218900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14218900, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 50, 142194, 300, 0, 0, 0, 0, 1, 0, 0, 0, 0, -2, -3, 0, 0, 'Inconspicuous Landmark - Actionlist - Summon Gameobject \'Pirate\'s Treasure!\''),
(14218900, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 12, 7898, 3, 5000, 0, 0, 0, 1, 0, 0, 0, 0, -2, -3, 0, 0, 'Inconspicuous Landmark - Actionlist - Summon Creature \'Pirate treasure trigger mob\'');

DELETE FROM `gameobject` WHERE `id` = 142189;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(17231, 142189, 1, 0, 0, 1, 1, -10249.2, -3981.8, 1.66783, -0.750491, 0, 0, -0.366501, 0.930418, 600, 100, 1, '', NULL, NULL),
(17232, 142189, 1, 0, 0, 1, 1, -10119.7, -4052.46, 5.33005, -0.366519, 0, 0, -0.182235, 0.983255, 600, 100, 1, '', NULL, NULL),
(17233, 142189, 1, 0, 0, 1, 1, -10050.8, -3717.16, 5.44262, 2.65289, 0, 0, 0.970295, 0.241925, 600, 100, 1, '', NULL, NULL),
(17234, 142189, 1, 0, 0, 1, 1, -10154.2, -3948.64, 7.74473, 2.65289, 0, 0, 0, 0, 600, 100, 1, '', NULL, NULL),
(17235, 142189, 1, 0, 0, 1, 1, -10285.8, -3881.83, 1.07085, -2.26893, 0, 0, -0.906307, 0.422619, 600, 100, 1, '', NULL, NULL),
(17236, 142189, 1, 0, 0, 1, 1, -10217, -3817.65, 1.35298, 2.65289, 0, 0, 0.970295, 0.241925, 600, 100, 1, '', NULL, NULL);

DELETE FROM `pool_template` WHERE `entry` IN (355,112);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (112, 1, 'Tanaris - Inconspicuous Landmark Pool');

DELETE FROM `pool_gameobject` WHERE `pool_entry` IN (355,112);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(17231, 112, 0, 'Inconspicuous Landmark'),
(17232, 112, 0, 'Inconspicuous Landmark'),
(17233, 112, 0, 'Inconspicuous Landmark'),
(17234, 112, 0, 'Inconspicuous Landmark'),
(17235, 112, 0, 'Inconspicuous Landmark'),
(17236, 112, 0, 'Inconspicuous Landmark');

-- Pirate treasure trigger mob
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|128 WHERE `entry` = 7898;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7898) AND (`source_type` = 0);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 789800) AND (`source_type` = 9);

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7898, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 7899, 1, 300000, 0, 0, 0, 202, 25, 2, 1, 0, 0, 0, 0, 0, 'Pirate treasure trigger mob - On Just Summoned - Summon Creature \'Treasure Hunting Pirate\''),
(7898, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 7902, 1, 300000, 0, 0, 0, 202, 25, 2, 1, 0, 0, 0, 0, 0, 'Pirate treasure trigger mob - On Just Summoned - Summon Creature \'Treasure Hunting Buccaneer\''),
(7898, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 7901, 1, 300000, 0, 0, 0, 202, 25, 1, 1, 0, 0, 0, 0, 0, 'Pirate treasure trigger mob - On Just Summoned - Summon Creature \'Treasure Hunting Swashbuckler\'');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (7899,7901,7902);
DELETE FROM `smart_scripts` WHERE `source_type` = 0  AND `entryorguid` IN (7899,7901,7902);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Treasure Hunting Pirate
(7899, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 1, 3, 0, 0, 20, 142194, 0, 0, 0, 0, 0, 0, 0, 'Treasure Hunting Pirate - On Just Summoned - Move To Closest Creature \'Pirate\'s Treasure!\''),
(7899, 0, 1, 0, 34, 0, 100, 0, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Treasure Hunting Pirate - On Reached Point 0 - Say Line 0'),
(7899, 0, 2, 0, 0, 0, 100, 0, 3000, 7000, 8200, 18100, 0, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Treasure Hunting Pirate - In Combat - Cast \'Strike\''),
-- Treasure Hunting Swashbuckler
(7901, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 1, 3, 0, 0, 20, 142194, 0, 0, 0, 0, 0, 0, 0, 'Treasure Hunting Swashbuckler - On Just Summoned - Move To Closest Creature \'Pirate\'s Treasure!\''),
(7901, 0, 1, 0, 34, 0, 100, 0, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Treasure Hunting Swashbuckler - On Reached Point 0 - Say Line 0'),
(7901, 0, 2, 0, 0, 0, 100, 0, 10200, 23100, 21900, 28400, 0, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Treasure Hunting Swashbuckler - In Combat - Cast \'Disarm\''),
-- Treasure Hunting Buccaneer
(7902, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 1, 3, 0, 0, 20, 142194, 0, 0, 0, 0, 0, 0, 0, 'Treasure Hunting Buccaneer - On Just Summoned - Move To Closest Creature \'Pirate\'s Treasure!\''),
(7902, 0, 1, 0, 34, 0, 100, 0, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Treasure Hunting Buccaneer - On Reached Point 0 - Say Line 0'),
(7902, 0, 2, 0, 0, 0, 100, 0, 3000, 7000, 8200, 18100, 0, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Treasure Hunting Buccaneer - In Combat - Cast \'Strike\'');

DELETE FROM `creature_text` WHERE `CreatureID` IN (7899,7901,7902);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(7899,0,0,'Hey!  Get away from our treasure!',12,0,100,0,0,0,3931,0,'Treasure Hunting Pirate'),
(7899,0,1,'That\'s our treasure, you lubber!',12,0,100,0,0,0,3931,0,'Treasure Hunting Pirate'),
(7899,0,2,'We didn\'t hide this stuff just you could steal it!',12,0,100,0,0,0,3931,0,'Treasure Hunting Pirate'),
(7901,0,0,'Hey!  Get away from our treasure!',12,0,100,0,0,0,3931,0,'Treasure Hunting Swashbuckler'),
(7901,0,1,'That\'s our treasure, you lubber!',12,0,100,0,0,0,3931,0,'Treasure Hunting Swashbuckler'),
(7901,0,2,'We didn\'t hide this stuff just you could steal it!',12,0,100,0,0,0,3931,0,'Treasure Hunting Swashbuckler'),
(7902,0,0,'Hey!  Get away from our treasure!',12,0,100,0,0,0,3931,0,'Treasure Hunting Buccaneer'),
(7902,0,1,'That\'s our treasure, you lubber!',12,0,100,0,0,0,3931,0,'Treasure Hunting Buccaneer'),
(7902,0,2,'We didn\'t hide this stuff just you could steal it!',12,0,100,0,0,0,3931,0,'Treasure Hunting Buccaneer');
