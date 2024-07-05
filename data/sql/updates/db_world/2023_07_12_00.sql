-- DB update 2023_07_11_03 -> 2023_07_12_00
-- Mosh'Ogg Witch Doctor SAI flag correction
UPDATE `smart_scripts` SET `event_flags`=0 WHERE `entryorguid`=1144 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid`=1144 AND `source_type`=0 AND `id`=1 AND `link`=0;
