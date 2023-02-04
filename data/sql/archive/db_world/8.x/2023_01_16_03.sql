-- DB update 2023_01_16_02 -> 2023_01_16_03
--
UPDATE `smart_scripts` SET `event_type`=74, `event_flags`=`event_flags`&~1, `event_param3`=2500, `event_param4`=2500, `event_param5`=40 WHERE `entryorguid`=17871 AND `source_type`=0 AND `id` IN (2,3);
