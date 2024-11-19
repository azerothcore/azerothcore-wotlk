-- DB update 2022_07_24_05 -> 2022_07_24_06

-- Immune to Taunt
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|256 WHERE `entry`=15370;

-- Disable exp on Buru egg / Hive'zara hatchling
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|64 WHERE `entry` IN (15514,15521);

-- New smartAI - despawn
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=15521;
DELETE FROM `smart_scripts` WHERE `entryorguid`= 15521 AND `source_type`= 0 AND `id`= 0;
INSERT INTO `smart_scripts` (`entryorguid`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES 
(15521, 1, 1, 10000, 10000, 41, 500, 1, 'Hive\'Zara Hatchling - Out of Combat - Despawn (No Repeat)');

-- Root egg properly - avoid reset
DELETE FROM `creature_template_movement` WHERE `CreatureId`=15514;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`) VALUES 
(15514, 1, 1, 0, 1, 0, 0);

