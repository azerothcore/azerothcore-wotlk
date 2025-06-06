-- DB update 2023_06_01_01 -> 2023_06_01_02
--
UPDATE `smart_scripts` SET `action_param1` = 768 WHERE `entryorguid` IN (-151090, -151091, -151092, -151093) AND `source_type` = 0;
