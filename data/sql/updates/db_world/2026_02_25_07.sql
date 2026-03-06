-- DB update 2026_02_25_06 -> 2026_02_25_07
-- Remove erroneous reference from disenchant entry 67 that causes double Void Crystal drops
-- Entry 67 already guarantees 1 Void Crystal (GroupId=0, 100% chance)
-- The reference to table 44012 (GroupId=1, 67% chance) added a second Void Crystal
DELETE FROM `disenchant_loot_template` WHERE `Entry` = 67 AND `Item` = 44012;
DELETE FROM `reference_loot_template` WHERE (`Entry` = 44012);

DELETE FROM `reference_loot_template` WHERE (`Entry` = 34097);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34097, 29765, 0, 0, 0, 1, 1, 1, 1, 'Leggings of the Fallen Hero'),
(34097, 29766, 0, 0, 0, 1, 1, 1, 1, 'Leggings of the Fallen Champion'),
(34097, 29767, 0, 0, 0, 1, 1, 1, 1, 'Leggings of the Fallen Defender');
