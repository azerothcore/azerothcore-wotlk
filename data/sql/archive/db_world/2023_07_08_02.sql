-- DB update 2023_07_08_01 -> 2023_07_08_02
--
UPDATE `smart_scripts` SET `action_param1` = 9739 WHERE `entryorguid` = 7235 AND `source_type` = 0; -- action_param1 was 5177 AKA wrong Wrath
