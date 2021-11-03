INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631974777295481100');
UPDATE `creature_template` SET `flags_extra` = 0, `faction` = 40 WHERE (`entry` IN (10601, 10602));

-- extend duration of mobs alive, without increasing Urok. spawn all circles at once
SET @despawnTime := 120000;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17558400) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17558400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -27.43, -372.86, 49.36, 0, 'Script9 - Summon GO'),
(17558400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -19.78, -372.75, 49.25, 0, 'Script9 - Summon GO'),
(17558400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -31.67, -385.91, 48.65, 0, 'Script9 - Summon GO'),
(17558400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -37.13, -369.65, 50.63, 0, 'Script9 - Summon GO'),
(17558400, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 175571, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -46.26, -376.98, 50.51, 0, 'Script9 - Summon GO'),
(17558400, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 12, 10601, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -19.78, -372.75, 49.25, 0, 'Script9 - Summon Creature ogre'),
(17558400, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 10601, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -31.67, -385.91, 48.65, 0, 'Script9 - Summon Creature ogre'),
(17558400, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 10602, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -37.13, -369.65, 50.63, 0, 'Script9 - Summon Creature ogre'),
(17558400, 9, 9, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 12, 10601, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -14.36, -389.37, 48.78, 0, 'Script9 - Summon Creature ogre'),
(17558400, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 10602, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -27.43, -372.86, 49.36, 0, 'Script9 - Summon Creature ogre'),
(17558400, 9, 11, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 12, 10602, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -31.67, -385.91, 48.65, 0, 'Script9 - Summon Creature ogre'),
(17558400, 9, 12, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 12, 10601, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -46.26, -376.98, 50.51, 0, 'Script9 - Summon Creature ogre'),
(17558400, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 10602, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -37.13, -369.65, 50.63, 0, 'Script9 - Summon Creature ogre'),
(17558400, 9, 14, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 12, 10601, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -27.43, -372.86, 49.36, 0, 'Script9 - Summon Creature ogre'),
(17558400, 9, 15, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 12, 10602, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -46.26, -376.98, 50.51, 0, 'Script9 - Summon Creature ogre'),
(17558400, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 10601, 4, @despawnTime, 0, 0, 0, 8, 0, 0, 0, 0, -14.36, -389.37, 48.78, 0, 'Script9 - Summon Creature ogre');

-- add urok data fail + despawn to urok enforcer and ogre magus
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10601;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10601) AND (`source_type` = 0) AND (`id` IN (1, 2, 20));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10601, 0, 1, 2, 1, 0, 100, 0, 30000, 30000, 0, 0, 0, 34, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'OOC update - Set Urok fail after timer'),
(10601, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Link - despawn self after fail'),
(10601, 0, 20, 21, 54, 0, 100, 1, 0, 0, 0, 0, 0, 11, 12980, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Update - Cast Spell');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10602;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10602) AND (`source_type` = 0) AND (`id` IN (4, 3, 20));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10602, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Link - self despawn'),
(10602, 0, 3, 4, 1, 0, 100, 0, 30000, 30000, 0, 0, 0, 34, 4, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'OOC update - set Urok to fail'),
(10602, 0, 20, 21, 54, 0, 100, 1, 0, 0, 0, 0, 0, 11, 12980, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On spawn - Cast Spell');

-- despawn circles after 2 minutes
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 175571;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 175571) AND (`source_type` = 1) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(175571, 1, 0, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 41, 120000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '');
