-- add flag CU_DURATION_REAL_TIME to 21174 'Empty Festive Mug'
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 21174);
