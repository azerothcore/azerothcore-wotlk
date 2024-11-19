-- DB update 2022_08_15_08 -> 2022_08_16_00
--
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags` | 1 WHERE `id` IN (8805, 8807);

SET @ENTRY := 21132;
DELETE FROM `item_loot_template` WHERE `Entry` = @ENTRY;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@ENTRY, 20939, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment II - Alliance"),
(@ENTRY, 21257, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment IV"),
(@ENTRY, 21259, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment V"),
(@ENTRY, 21260, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment VI"),
(@ENTRY, 21263, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment VII"),
(@ENTRY, 20806, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment X");

SET @ENTRY := 21266;
DELETE FROM `item_loot_template` WHERE `Entry` = @ENTRY;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@ENTRY, 21379, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment II - Horde"),
(@ENTRY, 21258, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment IV - Horde"),
(@ENTRY, 21382, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment V - Horde"),
(@ENTRY, 21261, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment VI - Horde"),
(@ENTRY, 21264, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment VII - Horde"),
(@ENTRY, 21385, 0, 0, 0, 1, 1, 1, 1, "Logistics Assigment X - Horde");


SET @ENTRY := 20805;
DELETE FROM `item_loot_template` WHERE `Entry` = @ENTRY;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@ENTRY, 20807, 0, 0, 0, 1, 1, 1, 1, "Logistics Assignment I - Alliance"),
(@ENTRY, 20940, 0, 0, 0, 1, 1, 1, 1, "Logistics Assignment III - Alliance"),
(@ENTRY, 21262, 0, 0, 0, 1, 1, 1, 1, "Logistics Assignment VIII - Alliance"),
(@ENTRY, 21265, 0, 0, 0, 1, 1, 1, 1, "Logistics Assignment IX - Alliance"),
(@ENTRY, 21514, 0, 0, 0, 1, 1, 1, 1, "Logistics Assignment XI - Alliance");

SET @ENTRY := 21386;
DELETE FROM `item_loot_template` WHERE `Entry` = @ENTRY;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@ENTRY, 21378, 0, 0, 0, 1, 1, 1, 1, "Logistics Assignment I - Horde"),
(@ENTRY, 21380, 0, 0, 0, 1, 1, 1, 1, "Logistics Assignment III - Horde"),
(@ENTRY, 21384, 0, 0, 0, 1, 1, 1, 1, "Logistics Assignment VIII - Horde"),
(@ENTRY, 21381, 0, 0, 0, 1, 1, 1, 1, "Logistics Assignment IX - Horde"),
(@ENTRY, 21514, 0, 0, 0, 1, 1, 1, 1, "Logistics Assignment XI - Horde");

SET @ENTRY := 20809;
DELETE FROM `item_loot_template` WHERE `Entry` = @ENTRY;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@ENTRY, 21245, 0, 0, 0, 1, 1, 1, 1, "Tactical Assignment I - Horde"),
(@ENTRY, 21751, 0, 0, 0, 1, 1, 1, 1, "Tactical Assignment III - Horde"),
(@ENTRY, 21165, 0, 0, 0, 1, 1, 1, 1, "Tactical Assignment VI - Horde"),
(@ENTRY, 21166, 0, 0, 0, 1, 1, 1, 1, "Tactical Assignment VII - Horde"),
(@ENTRY, 20944, 0, 0, 0, 1, 1, 1, 1, "Tactical Assignment IX - Horde");

SET @ENTRY := 21133;
DELETE FROM `item_loot_template` WHERE `Entry` = @ENTRY;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@ENTRY, 20945, 0, 0, 0, 1, 1, 1, 1, "Tactical Assignment  II - Horde"),
(@ENTRY, 20947, 0, 0, 0, 1, 1, 1, 1, "Tactical Assignment  IV - Horde"),
(@ENTRY, 20948, 0, 0, 0, 1, 1, 1, 1, "Tactical Assignment  V - Horde"),
(@ENTRY, 21167, 0, 0, 0, 1, 1, 1, 1, "Tactical Assignment  VIII - Horde"),
(@ENTRY, 20943, 0, 0, 0, 1, 1, 1, 1, "Tactical Assignment  X - Horde");
