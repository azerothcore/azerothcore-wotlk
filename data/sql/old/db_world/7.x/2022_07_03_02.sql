-- DB update 2022_07_03_01 -> 2022_07_03_02
--
UPDATE `smart_scripts` SET `event_flags`=512 WHERE `entryorguid`=28750 AND `source_type`=0 AND `id`=5;
UPDATE `smart_scripts` SET `event_flags`=512 WHERE `entryorguid`=2875000 AND `source_type`=9;
