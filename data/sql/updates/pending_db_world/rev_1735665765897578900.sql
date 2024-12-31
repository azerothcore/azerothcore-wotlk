--
-- Allows the loot from `Tactical Assignment` and `Followup Tactical Assignment` to always show. (not an empty bag). 
UPDATE `item_template` SET `flagsCustom` = `flagsCustom` | 2 WHERE `entry` IN (20943, 20944, 20946, 20947, 20948, 21165, 21166, 21167, 21245, 21751);
