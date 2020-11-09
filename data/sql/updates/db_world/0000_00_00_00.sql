
-- Blackwing Mage [12420]
SET @BWL_MAGE = 12420;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=@BWL_MAGE;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @BWL_MAGE;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@BWL_MAGE, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3400, 4700, 0, 11, 17290, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Fireball'),
(@BWL_MAGE, 0, 1, 0, 9, 0, 100, 0, 0, 10, 15000, 25000, 0, 11, 22271, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Arcane Explosion on Close');
