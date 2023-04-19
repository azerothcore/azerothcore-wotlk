-- 20668 (Fiendling Flesh Beast)
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 20668;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 20668 AND `source_type` = 0;
