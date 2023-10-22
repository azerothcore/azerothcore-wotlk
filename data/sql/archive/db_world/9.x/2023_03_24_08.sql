-- DB update 2023_03_24_07 -> 2023_03_24_08
--
-- Slows the repeat behavior of NPCs 237 (Verna Furlbrow) and 238 (Farmer Furlbrow) dialogue to be authentic
UPDATE `smart_scripts` SET `event_param3`=1202000, `event_param4`=1202000 WHERE `entryorguid`=237 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param3`=1666000, `event_param4`=1666000 WHERE `entryorguid`=238 AND `source_type`=0 AND `id`=0 AND `link`=0;
