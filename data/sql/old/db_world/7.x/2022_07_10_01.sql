-- DB update 2022_07_10_00 -> 2022_07_10_01
--
UPDATE `smart_scripts` SET `event_flags`=`event_flags`|512 WHERE `entryorguid`=3040300 AND `source_type`=9;
