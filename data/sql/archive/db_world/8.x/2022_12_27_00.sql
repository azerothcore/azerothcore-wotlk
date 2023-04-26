-- DB update 2022_12_26_00 -> 2022_12_27_00
--
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 180524;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 180524);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(180524, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 0, 11, 45257, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Tonk Control Console - On Gameobject State Changed - Cast \'Using Steam Tonk Controller\'');

-- Darkmoon Faire (Terokkar Forest)
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43029;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43030;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43031;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43032;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43033;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43034;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43035;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43036;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43037;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43038;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43039;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43040;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43041;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43042;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43043;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=43044;

 -- Darkmoon Faire (Elwynn Forest)
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28620;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28621;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28622;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28623;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28624;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28625;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28626;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28627;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28628;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28629;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28630;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=28631;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=12680;
UPDATE `gameobject` SET `state`=1 WHERE  `guid`=12737;
