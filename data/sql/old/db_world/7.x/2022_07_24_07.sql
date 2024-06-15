-- DB update 2022_07_24_06 -> 2022_07_24_07
--
UPDATE `gameobject_template` SET `ScriptName` = 'go_sand_trap' WHERE `entry` = 180647;

UPDATE `creature_text` SET `TextRange` = 3 WHERE `CreatureID` = 15339 AND `GroupID` = 5;
