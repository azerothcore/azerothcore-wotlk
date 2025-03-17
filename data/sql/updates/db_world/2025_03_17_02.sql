-- DB update 2025_03_17_01 -> 2025_03_17_02
-- Fix double cast of Scourge Disguise
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28669);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28669, 0, 0, 1, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 51966, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Just Summoned - Remove \'Scourge Disguise[51966]\''),
(28669, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 52191, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Just Summoned - Cast \'Scourge Disguise[52191]\''),
(28669, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2866900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Just Summoned - Run Script'),
(28669, 0, 3, 0, 40, 0, 100, 512, 62, 28669, 0, 0, 0, 0, 11, 52220, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Waypoint 62 Reached - Cast \'Kill Credit\''),
(28669, 0, 4, 5, 40, 0, 100, 512, 63, 28669, 0, 0, 0, 0, 28, 52191, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Waypoint 63 Reached - Remove \'Scourge Disguise[52191]\''),
(28669, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 75, 52192, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Waypoint 63 Reached - Cast \'Scourge Disguise[52192]\''),
(28669, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 75, 51971, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Waypoint 63 Reached - Cast \'Scourge Disguise Instability[51971]\''),
(28669, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50630, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Waypoint 63 Reached - Cast \'Eject All Passengers\'');

-- Add or Remove linked to Scourge Disguise spells
DELETE FROM `spell_linked_spell` WHERE (`spell_trigger` IN ( -52010, -52192, -51966, 51966, 52192));
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-52010, -52192, 0, 'Remove Scourge Disguise [52192]'),
(-52010, -51966, 0, 'Remove Scourge Disguise [51966]'),
(-51966, -51971, 0, 'Remove Scourge Disguise Instability [51971]'),
(-52192, -51971, 0, 'Remove Scourge Disguise Instability [51971]'),
(51966, -52192, 0, 'Remove Scourge Disguise [52192]'),
(52192, -51966, 0, 'Remove Scourge Disguise [51966]'),
(51966, 51971, 0, 'Add Scourge Disguise Instability [51971]'),
(52192, 51971, 0, 'Add Scourge Disguise Instability [51971]');

-- Attach script to Scourge Disguise Instability
DELETE FROM `spell_script_names` WHERE `spell_id` = 51971;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(51971, 'spell_scourge_disguise_instability');

-- Update Blightguard AI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=28603;

-- Update Blightguard scripts: cast invisibility, remove aura from target, cast Shadowstrike
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28603);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28603, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 52060, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blightguard - On Reset - Cast \'Invisibility\''),
(28603, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52060, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blightguard - On Aggro - Remove Aura \'Invisibility\''),
(28603, 0, 2, 0, 0, 0, 100, 0, 6000, 6000, 10000, 10000, 0, 0, 11, 33914, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blightguard - In Combat - Cast \'Shadowstrike\''),
(28603, 0, 3, 0, 24, 0, 100, 0, 51966, 0, 100, 100, 0, 0, 28, 51966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blightguard - On Target Has \'Scourge Disguise\' Aura - Remove \'Scourge Disguise\'[51966]'),
(28603, 0, 4, 0, 24, 0, 100, 0, 52192, 0, 100, 100, 0, 0, 28, 52192, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Blightguard - On Target Has \'Scourge Disguise\' Aura - Remove \'Scourge Disguise\'[52192]');

-- Original commit: https://github.com/TrinityCore/TrinityCore/commit/d96482b2d49c61fe26533def461276a8038db4ab
-- Update Blightguard spawn location (thanks to @Killyana)
DELETE FROM `creature` WHERE (`id1` = 28603 AND `guid` IN (113672, 52812, 52813, 52814, 52815, 52816, 52817, 52818, 52819, 52820, 52821, 52822, 52823, 52824, 52825, 52826, 52827, 52828, 52829, 52830, 52831, 52832, 52833) );
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(52812, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6022.67, -2049.14, 238.189, 1.46482, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52813, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6042.88, -2119.83, 239.522, 5.55282, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52814, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6101.08, -2157.18, 239.578, 5.52926, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52815, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6176.72, -2208.48, 241.65, 0.110007, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52816, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6227.74, -2193.69, 236.211, 0.66371, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52817, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6270.34, -2053.92, 238.548, 1.23705, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52818, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6069.51, -1913.87, 236.212, 2.78429, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52819, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6017.94, -1903.71, 239.384, 3.56183, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52820, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 5981.49, -1963.15, 237.669, 4.15088, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52821, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6017.39, -2106.46, 243.382, 5.40752, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52822, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 5275.12, -1678.04, 236.349, 1.1703, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52823, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 5224.69, -1751.98, 235.717, 3.17306, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52824, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 5154.48, -1745.88, 238.291, 3.26731, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52825, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 5082.87, -1725.64, 235.624, 3.55791, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52826, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 5034.49, -1655.17, 240.16, 1.8693, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52827, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 5069.11, -1540.09, 240.561, 6.1183, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52828, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 5099.29, -1559.64, 238.941, 0.624444, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52829, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6183.62, -2102.73, 235.653, 3.42675, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52830, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6113.59, -2105.41, 234.909, 0.441447, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52831, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6091.98, -2019.44, 235.639, 1.6706, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52832, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6199.66, -1957.45, 234.049, 1.20721, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL),
(52833, 28603, 0, 0, 571, 0, 0, 1, 1, 0, 6242.41, -2003.27, 234.282, 4.15089, 600, 10, 0, 0, 0, 1, 0, 0, 0, '', 0, 0, NULL);
