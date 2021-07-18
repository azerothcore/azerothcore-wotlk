INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626635521387129200');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7856;

-- Changed wrong cast flags on the shoot skill, making them able to shoot while polymorphed and when fleeing.
-- Changed the target on the flee skill to mimic other that worked, changed to 7- action invoquer so they cant shoot while fleeing
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 7856);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7856, 0, 0, 0, 9, 0, 100, 0, 2, 30, 2200, 3800, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Southsea Freebooter - Within 2-30 Range - Shoot'),
(7856, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Southsea Freebooter - Between 0-15% Health - Flee For Assist (No Repeat)');
