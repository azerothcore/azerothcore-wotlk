-- Lesser (19297) and Greater (19296) Darkmoon Prize: one item per opening, current item weights kept
UPDATE `item_loot_template` SET `GroupId` = 1, `Chance` = 0
WHERE `Entry` = 19297 AND `Item` IN (1529, 4042, 4074, 4078, 4729, 5009, 6402, 6405, 6413, 6418, 6420, 7429, 7431,
  7432, 7434, 7443, 7445, 7447, 7474, 7483, 9879, 9880, 11971, 11972, 12010, 13145, 15929);
UPDATE `item_loot_template` SET `GroupId` = 1, `Chance` = 4.57
WHERE `Entry` = 19297 AND `Item` IN (7437, 7438, 7556, 7909, 11997, 12020);
UPDATE `item_loot_template` SET `GroupId` = 1, `Chance` = 6.76
WHERE `Entry` = 19297 AND `Item` IN (1725, 4731);
UPDATE `item_loot_template` SET `Chance` = 0
WHERE `Entry` = 19296 AND `Item` IN (8106, 8119, 8246, 8247, 8253, 8254, 8272, 8286, 8316, 10064, 10065, 10070, 10072,
  10074, 10122, 10133, 10165, 10172, 10173, 10179, 10180, 10231, 10238, 10245, 11976, 11989, 12002, 12014, 12055,
  13120);
UPDATE `item_loot_template` SET `Chance` = 1.19
WHERE `Entry` = 19296 AND `Item` IN (7909, 7910, 8249, 8256, 8262, 8269, 8270, 8274, 8314, 8317, 10057, 10061, 10126,
  10167, 10242, 10244, 11977, 12025, 13030);
UPDATE `item_loot_template` SET `Chance` = 1.72
WHERE `Entry` = 19296 AND `Item` IN (10098, 10187, 12689, 15217, 15228);
UPDATE `item_loot_template` SET `Chance` = 1.83
WHERE `Entry` = 19296 AND `Item` IN (8250, 8251, 8260, 8311);
UPDATE `item_loot_template` SET `Chance` = 2.37
WHERE `Entry` = 19296 AND `Item` IN (10174, 10243);
UPDATE `item_loot_template` SET `Chance` = 3.02
WHERE `Entry` = 19296 AND `Item` = 8261;
UPDATE `item_loot_template` SET `Chance` = 3.45
WHERE `Entry` = 19296 AND `Item` IN (8297, 10084, 14489, 15229, 15275, 15280, 15291, 15295);
UPDATE `item_loot_template` SET `Chance` = 6.79
WHERE `Entry` = 19296 AND `Item` = 10189;
