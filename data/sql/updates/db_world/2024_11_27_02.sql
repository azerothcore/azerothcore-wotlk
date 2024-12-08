-- DB update 2024_11_27_01 -> 2024_11_27_02
-- add flag CU_DURATION_REAL_TIME to Pilgrim's Bounty items
-- Wild Turkey
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 44834);
-- Recipe: Cranberry Chutney
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 44858);
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 46805);
-- Recipe: Candied Sweet Potato
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 44859);
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 46806);
-- Recipe: Spice Bread Stuffing
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 44860);
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 46803);
-- Recipe: Slow-Roasted Turkey
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 44861);
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 46807);
-- Recipe: Pumpkin Pie
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 44862);
UPDATE `item_template` SET `flagsCustom` = (`flagsCustom` | 1) WHERE (`entry` = 46804);

-- set duration to 7 days
UPDATE `item_template` SET `duration` = 604800 WHERE (`entry` IN (44858, 46805, 44859, 46806, 44860, 46803, 44861, 46807, 44862, 46804));
