-- DB update 2023_03_31_01 -> 2023_03_31_02
--
UPDATE `smart_scripts` SET `action_param2` = 2 WHERE `id` = 3 AND `entryorguid` IN (-28368, -27554, -27555, -27794);
