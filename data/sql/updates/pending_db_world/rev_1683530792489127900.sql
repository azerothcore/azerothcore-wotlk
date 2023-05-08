--
UPDATE `creature_template` SET `minlevel`=63, `maxlevel`=63, `AIName`='SmartAI' WHERE  `entry`=16383;

DELETE FROM `creature_template_addon` WHERE entry=16383;
INSERT INTO `creature_template_addon` (`entry`, `auras`) VALUES (16383, '28330');

DELETE FROM `smart_scripts` WHERE `entryorguid`=16383;
INSERT INTO `smart_scripts` (`entryorguid`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES 
(16383, 2000, 2000, 30000, 45000, 11, 28314, 2, 'Flameshocker - In Combat - Cast Victim `Flameshocker\'s Touch`');
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `action_type`, `action_param1`, `action_param2`, `target_type`, `comment`) VALUES 
(16383, 1, 6, 11, 28323, 2, 1, 'Flameshocker - On Death - Cast Victim `Flameshocker\'s Revenge`');

