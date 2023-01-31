-- DB update 2022_09_28_00 -> 2022_09_28_01
-- Update current loot
UPDATE `item_loot_template` SET `Chance`=0, `GroupId`=2 WHERE `Item` IN (4715,6268,6336,6536,6537,6538,6539,6540,6541,6542,6563,6566,6567,6568,6569,6573,6575,6577,6579,6580,6583,6584,6585,6586,6587,6588,6590,6591,6592,6593,6594,6595,6596,6597,6600,6601,6602,6604,6605,6607,7332,7407,7408,7409,7411,7413,7414,7417,7418,7420,7421,7423,7430,7431,7432,7433,7434,7435,7436,7437,7438,7439,7440,7441,7443,7444,7445,7446,7447,7448,7468,7469,7474,7476,7477,7483,7519,7520,7521,7522,7523,7524,7525,7526,7528,7529,7530,7531,7532,7533,7534,7535,8120,9286,9289,9291,9746,9747,9748,9749,9755,9756,9757,9759,9762,9763,9765,9766,9767,9768,9770,9771,9775,9776,9777,9779,9780,9782,9791,9792,9793,9794,9795,9796,9797,9799,9801,9802,9803,9805,9806,9807,9808,9809,9810,9811,9813,9814,9815,9817,9818,9819,9822,9823,9825,9826,9831,9835,9836,9837,9838,9839,9840,9864,9865,9866,9867,9868,9869,9870,9871,9872,9875,9876,9877,9879,9880,9881,9884,9896,9898,9900,9901,9902,9905,9906,9907,9910,9911,9912,9913,9915,9928,9929,9930,9932,9933,9934,9966,9967,9969,9970,9971,10057,10059,10060,10064,10067,10069,10070,10071,10074,10086,10087,10088,10089,10090,10091,10092,10094,10118,10119,10121,10122,10123,10124,10125,10126,10128,10129,10131,10132,10145,10148,10156,10159,10164,10165,10166,10167,10168,10169,10170,10171,10172,10173,10175,10176,10177,10179,10181,10211,10212,10213,10214,10216,10221,10222,10223,10224,10225,10228,10229,10230,10231,10232,10233,10234,10235,10236,10237,10240,10241,10244,10275,10276,10277,10278,10279,10280,10281,10282,10373,10387,10391,10404,13010,13029,13081,13131,13145) AND `entry` BETWEEN 21509 AND 21513;

-- Add reference loot
DELETE FROM `reference_loot_template` WHERE `entry` IN (21509, 21510, 21512, 21513) AND `Item` IN (954,955,1180,1181,1477,1478,1711,1712,2289,2290,3012,3013,4419,4421,4422,4424,4425,4426,10305,10306,10307,10308,10309,10310);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Chance`, `GroupId`, `MaxCount`, `Comment`) VALUES
(21509, 954, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Strength'),
(21509, 955, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Intellect'),
(21509, 1180, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Stamina'),
(21509, 1181, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Spirit'),
(21509, 3012, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Agility'),
(21509, 3013, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Protection'),
(21510, 1477, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Agility II'),
(21510, 1478, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Protection II'),
(21510, 1711, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Stamina II'),
(21510, 1712, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Spirit II'),
(21510, 2289, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Strength II'),
(21510, 2290, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Intellect II'),
(21512, 4419, 0, 1, 2, 'Ahn\'Qiraj War Effort Supplies - Scroll of Intellect III'),
(21512, 4421, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Protection III'),
(21512, 4422, 0, 1, 2, 'Ahn\'Qiraj War Effort Supplies - Scroll of Stamina III'),
(21512, 4424, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Scroll of Spirit III'),
(21512, 4425, 0, 1, 2, 'Ahn\'Qiraj War Effort Supplies - Scroll of Agility III'),
(21512, 4426, 0, 1, 2, 'Ahn\'Qiraj War Effort Supplies - Scroll of Strength III'),
(21513, 10305, 0, 1, 2, 'Ahn\'Qiraj War Effort Supplies - Scroll of Protection IV'),
(21513, 10306, 0, 1, 2, 'Ahn\'Qiraj War Effort Supplies - Scroll of Spirit IV'),
(21513, 10307, 0, 1, 2, 'Ahn\'Qiraj War Effort Supplies - Scroll of Stamina IV'),
(21513, 10308, 0, 1, 2, 'Ahn\'Qiraj War Effort Supplies - Scroll of Intellect IV'),
(21513, 10309, 0, 1, 2, 'Ahn\'Qiraj War Effort Supplies - Scroll of Agility IV'),
(21513, 10310, 0, 1, 2, 'Ahn\'Qiraj War Effort Supplies - Scroll of Strength IV');

-- Add Missing Loot
DELETE FROM `item_loot_template` WHERE (`Entry` = 21509) AND (`Item` IN (21509));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21509, 21509, 21509, 100, 0, 1, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Reference Table (21509)');
DELETE FROM `item_loot_template` WHERE (`Entry` = 21510) AND (`Item` IN (21510));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21510, 21510, 21510, 100, 0, 1, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Reference Loot (21510)');
DELETE FROM `item_loot_template` WHERE (`Entry` = 21511) AND (`Item` IN (937, 21510));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21511, 937, 0, 0, 0, 1, 2, 1, 1, 'Black Duskwood Staff'),
(21511, 21510, 21510, 100, 0, 1, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Reference Loot (21510)');
DELETE FROM `item_loot_template` WHERE (`Entry` = 21512) AND (`Item` IN (21512, 754, 4091, 9434, 13012, 13021, 13076, 13115, 13117, 13128));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21512, 21512, 21512, 100, 0, 1, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Reference Loot (21512)'),
(21512, 754, 0, 0, 0, 1, 2, 1, 1, 'Shortsword of Vengeance'),
(21512, 4091, 0, 0, 0, 1, 2, 1, 1, 'Widowmaker'),
(21512, 9434, 0, 0, 0, 1, 2, 1, 1, 'Elemental Raiment'),
(21512, 13012, 0, 0, 0, 1, 2, 1, 1, 'Yorgen Bracers'),
(21512, 13021, 0, 0, 0, 1, 2, 1, 1, 'Needle Threader'),
(21512, 13076, 0, 0, 0, 1, 2, 1, 1, 'Giantslayer Bracers'),
(21512, 13115, 0, 0, 0, 1, 2, 1, 1, 'Sheepshear Mantle'),
(21512, 13117, 0, 0, 0, 1, 2, 1, 1, 'Ogron\'s Sash'),
(21512, 13128, 0, 0, 0, 1, 2, 1, 1, 'High Bergg Helm');
DELETE FROM `item_loot_template` WHERE (`Entry` = 21513) AND (`Item` IN (21513, 5266, 13002, 13022, 13027, 13030, 13070, 13077, 13120, 13135, 24222));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21513, 21513, 21513, 100, 0, 1, 0, 1, 1, 'Ahn\'Qiraj War Effort Supplies - Reference Loot (21513)'),
(21513, 5266, 0, 0, 0, 1, 2, 1, 1, 'Eye of Adaegus'),
(21513, 13002, 0, 0, 0, 1, 2, 1, 1, 'Lady Alizabeth\'s Pendant'),
(21513, 13022, 0, 0, 0, 1, 2, 1, 1, 'Gryphonwing Long Bow'),
(21513, 13027, 0, 0, 0, 1, 2, 1, 1, 'Bonesnapper'),
(21513, 13030, 0, 0, 0, 1, 2, 1, 1, 'Basilisk Bone'),
(21513, 13070, 0, 0, 0, 1, 2, 1, 1, 'Sapphiron\'s Scale Boots'),
(21513, 13077, 0, 0, 0, 1, 2, 1, 1, 'Girdle of Uther'),
(21513, 13120, 0, 0, 0, 1, 2, 1, 1, 'Deepfury Bracers'),
(21513, 13135, 0, 0, 0, 1, 2, 1, 1, 'Lordly Armguards'),
(21513, 24222, 0, 0, 0, 1, 2, 1, 1, 'The Shadowfoot Stabber');
