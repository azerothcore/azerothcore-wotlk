-- DB update 2022_12_29_05 -> 2022_12_29_06
-- 
UPDATE `smart_scripts` SET `event_flags`=`event_flags`&~512 WHERE `entryorguid`=4962 AND `source_type`=0;
