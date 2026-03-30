-- DB update 2024_07_13_00 -> 2024_07_13_01
-- add flag CU_DURATION_REAL_TIME to 21174 'Empty Festive Mug'
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 21174);
