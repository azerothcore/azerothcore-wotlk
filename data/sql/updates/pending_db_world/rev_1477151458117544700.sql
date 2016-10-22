INSERT INTO version_db_world(`sql_rev`) VALUES (`1477151458117544700`);

DELETE FROM `creature_loot_template` WHERE `entry` IN (6501, 6502, 6503, 6504, 9162, 9163, 9164) AND `item`=11114;

INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`) VALUES
(6501, 11114, 30),
(6502, 11114, 30),
(6503, 11114, 30),
(6504, 11114, 30),
(9162, 11114, 30),
(9163, 11114, 30),
(9164, 11114, 30);
