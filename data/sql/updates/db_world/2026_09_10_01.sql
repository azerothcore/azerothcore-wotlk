-- DB update 2026_09_10_00 -> 2026_09_10_01
--
DELETE FROM `reference_loot_template` WHERE `Entry`=24077 AND `Item`=1958;

DELETE FROM `creature_loot_template` WHERE (`Entry` = 625) AND (`Item` IN (1958));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(625, 1958, 0, 5, 0, 1, 0, 1, 1, 'Undead Dynamiter - Petrified Shinbone');
