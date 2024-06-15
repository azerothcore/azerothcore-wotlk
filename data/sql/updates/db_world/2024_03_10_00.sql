-- DB update 2024_03_09_00 -> 2024_03_10_00
-- update 44844 'Turkey Caller' - add flagsCustom - CU_DURATION_REAL_TIME
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 44844);
