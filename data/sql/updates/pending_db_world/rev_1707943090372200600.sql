-- update 44844 'Turkey Caller' - add flagsCustom - CU_DURATION_REAL_TIME
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 44844);
