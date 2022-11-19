-- DB update 2022_07_25_08 -> 2022_07_26_00
--

UPDATE `creature_template` SET `mingold`=0, `maxgold`=0, `AIName`='SmartAI' WHERE `entry`=15527;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15527 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `target_type`, `comment`) VALUES 
(15527, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 6000, 6000, 11, 25679, 2, 2, 'Mana Fiend - In Combat - Cast Arcane Explosion'),
(15527, 0, 1, 0, 13, 0, 100, 0, 10000, 20000, 0, 0, 11, 15122, 0, 2, 'Mana Fiend - In Combat - Cast Counterspell');

