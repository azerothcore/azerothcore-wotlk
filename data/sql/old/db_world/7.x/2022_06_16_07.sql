-- DB update 2022_06_16_06 -> 2022_06_16_07

UPDATE `creature_template` SET `AIName`='SmartAI',`flags_extra`=2 WHERE `entry`=14989;
DELETE FROM `smart_scripts` WHERE `entryorguid`= 14989 AND `source_type`= 0 AND `id`= 0;
INSERT INTO `smart_scripts` (`entryorguid`, `event_type`, `event_flags`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES 
(14989, 54, 1, 11, 26744, 1, 'Poisonous Cloud - OOC - Cast \'Serverside - Poisonous Blood\'');

DELETE FROM `smart_scripts` WHERE `entryorguid`= 11357 AND `source_type`= 0 AND `id`= 2;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_flags`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `target_type`, `comment`) VALUES 
(11357, 2, 6, 512, 12, 14989, 3, 10000, 1, 'Son of Hakkar - On Just Died - Summon \'Poisonous Cloud\'');

