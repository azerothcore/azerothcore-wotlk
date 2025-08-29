-- DB update 2025_08_28_00 -> 2025_08_29_00
-- Necrotic Runes
DELETE FROM `creature_loot_template` WHERE `Item` = 22484;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14697, 22484, 0, 100, 0, 1, 0, 2, 3, 'Lumbering Horror - Necrotic Rune'),
(16379, 22484, 0, 100, 0, 1, 0, 2, 3, 'Spirit of the Damned - Necrotic Rune'),
(16380, 22484, 0, 100, 0, 1, 0, 2, 3, 'Bone Witch - Necrotic Rune'),
(16143, 22484, 0, 100, 0, 1, 0, 30, 30, 'Shadow of Doom - Necrotic Rune'),
(16141, 22484, 0, 33.33, 0, 1, 0, 1, 1, 'Ghoul Berserker - Necrotic Rune'),
(16298, 22484, 0, 33.33, 0, 1, 0, 1, 1, 'Spectral Soldier - Necrotic Rune'),
(16299, 22484, 0, 33.33, 0, 1, 0, 1, 1, 'Skeletal Shocktrooper - Necrotic Rune'),
(16383, 22484, 0, 33.33, 0, 1, 0, 1, 1, 'Flameshocker - Necrotic Rune');

-- Sealed Research Report items
DELETE FROM `creature_loot_template` WHERE `Item` IN (22970, 22972, 22973, 22974, 22975, 22977);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16141, 22970, 0, 2, 0, 1, 1, 1, 1, 'Ghoul Berserker - A Bloodstained Envelope'),
(16141, 22972, 0, 2, 0, 1, 1, 1, 1, 'Ghoul Berserker - A Careworn Note'),
(16141, 22973, 0, 2, 0, 1, 1, 1, 1, 'Ghoul Berserker - A Crumpled Missive'),
(16141, 22974, 0, 2, 0, 1, 1, 1, 1, 'Ghoul Berserker - A Ragged Page'),
(16141, 22975, 0, 2, 0, 1, 1, 1, 1, 'Ghoul Berserker - A Smudged Document'),
(16141, 22977, 0, 2, 0, 1, 1, 1, 1, 'Ghoul Berserker - A Torn Letter'),
(16298, 22970, 0, 2, 0, 1, 1, 1, 1, 'Spectral Soldier - A Bloodstained Envelope'),
(16298, 22972, 0, 2, 0, 1, 1, 1, 1, 'Spectral Soldier - A Careworn Note'),
(16298, 22973, 0, 2, 0, 1, 1, 1, 1, 'Spectral Soldier - A Crumpled Missive'),
(16298, 22974, 0, 2, 0, 1, 1, 1, 1, 'Spectral Soldier - A Ragged Page'),
(16298, 22975, 0, 2, 0, 1, 1, 1, 1, 'Spectral Soldier - A Smudged Document'),
(16298, 22977, 0, 2, 0, 1, 1, 1, 1, 'Spectral Soldier - A Torn Letter'),
(16299, 22970, 0, 2, 0, 1, 1, 1, 1, 'Skeletal Shocktrooper - A Bloodstained Envelope'),
(16299, 22972, 0, 2, 0, 1, 1, 1, 1, 'Skeletal Shocktrooper - A Careworn Note'),
(16299, 22973, 0, 2, 0, 1, 1, 1, 1, 'Skeletal Shocktrooper - A Crumpled Missive'),
(16299, 22974, 0, 2, 0, 1, 1, 1, 1, 'Skeletal Shocktrooper - A Ragged Page'),
(16299, 22975, 0, 2, 0, 1, 1, 1, 1, 'Skeletal Shocktrooper - A Smudged Document'),
(16299, 22977, 0, 2, 0, 1, 1, 1, 1, 'Skeletal Shocktrooper - A Torn Letter'),
(16383, 22970, 0, 2, 0, 1, 1, 1, 1, 'Flameshocker - A Bloodstained Envelope'),
(16383, 22972, 0, 2, 0, 1, 1, 1, 1, 'Flameshocker - A Careworn Note'),
(16383, 22973, 0, 2, 0, 1, 1, 1, 1, 'Flameshocker - A Crumpled Missive'),
(16383, 22974, 0, 2, 0, 1, 1, 1, 1, 'Flameshocker - A Ragged Page'),
(16383, 22975, 0, 2, 0, 1, 1, 1, 1, 'Flameshocker - A Smudged Document'),
(16383, 22977, 0, 2, 0, 1, 1, 1, 1, 'Flameshocker - A Torn Letter');

-- Dim Necrotic Stone
UPDATE `creature_loot_template` SET `Chance` = 25 WHERE `Item` = 22892;
