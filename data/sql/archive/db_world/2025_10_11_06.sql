-- DB update 2025_10_11_05 -> 2025_10_11_06
-- Correctly uses Option0 instead of Option1 to summon the Terokk
UPDATE `smart_scripts` SET `event_param2` = 0 WHERE `entryorguid` = 185928 AND `source_type` = 1 AND `id` = 0;

-- Removes the duplicated option.
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 8687 AND `OptionID` = 1;
