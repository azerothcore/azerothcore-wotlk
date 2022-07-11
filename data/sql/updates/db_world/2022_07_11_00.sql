-- DB update 2022_07_10_04 -> 2022_07_11_00
--
UPDATE `smart_scripts` SET `link`=0 WHERE `entryorguid`=28665 AND `source_type`=0 AND `id`=0;
UPDATE `smart_scripts` SET `event_type`=27 WHERE `entryorguid`=28665 AND `source_type`=0 AND `id`=1;
UPDATE `smart_scripts` SET `event_flags`=`event_flags`|512 WHERE `entryorguid`=2866500 AND `source_type`=9;
