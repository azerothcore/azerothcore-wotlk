-- DB update 2025_07_19_00 -> 2025_07_19_01
--
-- Bone Witch
UPDATE `creature_template` SET `minlevel` = 71, `maxlevel` = 71 WHERE (`entry` = 16380);

UPDATE `quest_template_addon` SET `RewardMailDelay`=2*24*3600 WHERE `ID` IN (9295, 9299, 9300, 9301, 9302, 9304);

-- Delete rare loot (lvl 60) and add epic loot (copied from Bone Witch - 16380)
DELETE FROM `creature_loot_template` WHERE (`Entry` = 16143) AND `Item` IN (23085, 23087, 22484, 23090, 23091, 23092, 23093);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16143, 22484, 0, 50.12, 0, 1, 0, 1, 1, 'Shadow of Doom - Necrotic Rune'),
(16143, 23090, 0, 20.68, 0, 1, 0, 1, 1, 'Shadow of Doom - Bracers of Undead Slaying'),
(16143, 23091, 0, 20.68, 0, 1, 0, 1, 1, 'Shadow of Doom - Bracers of Undead Cleansing'),
(16143, 23092, 0, 20.63, 0, 1, 0, 1, 1, 'Shadow of Doom - Wristguards of Undead Slaying'),
(16143, 23093, 0, 20.82, 0, 1, 0, 1, 1, 'Shadow of Doom - Wristwraps of Undead Slaying');
