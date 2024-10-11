-- DB update 2023_07_10_03 -> 2023_07_11_00
-- Old Hillsbrad Foothills
UPDATE `creature_loot_template` SET `GroupID` = 7 WHERE `Entry` = 20531 AND `Item` IN (
27904, -- Resounding Ring of Glory
28401, -- Hauberk of Desolation
28191, -- Mana-Etched Vestments
28344, -- Wyrmfury Pauldrons
27911, -- Epoch's Whispering Cinch
28224  -- Wastewalker Helm
);
-- Mana-Tombs
UPDATE `creature_loot_template` SET `GroupID` = 6 WHERE `Entry` = 20266 AND `Item` IN (
27843, -- Glyph-Lined Sash
27798, -- Gauntlets of Vindication
27842, -- Grand Scepter of the Nexus-Kings
28400, -- Warp-Storm Warblade
27844, -- Pauldrons of Swift Retribution
27840  -- Scepter of Shatar
);
-- The Underbog
DELETE FROM `creature_loot_template` WHERE (`Entry` = 20184) AND (`Item` = 43001) AND (`Reference` = 43001);
DELETE FROM `reference_loot_template` WHERE (`Entry` = 43001);
DELETE FROM `creature_loot_template` WHERE `Item` IN (27768,27769,27770,27771,27772,27773,27779,27780,27781,27896,27907,27938);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20184, 27768, 0, 0, 0, 1, 5, 1, 1, 'The Black Stalker (1) - Oracle Belt of Timeless Mystery'),
(20184, 27769, 0, 0, 0, 1, 5, 1, 1, 'The Black Stalker (1) - Endbringer'),
(20184, 27770, 0, 0, 0, 1, 5, 1, 1, 'The Black Stalker (1) - Argussian Compass'),
(20184, 27771, 0, 0, 0, 1, 5, 1, 1, 'The Black Stalker (1) - Doomplate Shoulderguards'),
(20184, 27772, 0, 0, 0, 1, 5, 1, 1, 'The Black Stalker (1) - Stormshield of Renewal'),
(20184, 27773, 0, 0, 0, 1, 5, 1, 1, 'The Black Stalker (1) - Barbaric Legstraps'),
(20184, 27779, 0, 0, 0, 1, 2, 1, 1, 'The Black Stalker (1) - Bone Chain Necklace'),
(20184, 27780, 0, 0, 0, 1, 2, 1, 1, 'The Black Stalker (1) - Ring of Fabled Hope'),
(20184, 27781, 0, 0, 0, 1, 2, 1, 1, 'The Black Stalker (1) - Demonfang Ritual Helm'),
(20184, 27896, 0, 0, 0, 1, 2, 1, 1, 'The Black Stalker (1) - Alembic of Infernal Power'),
(20184, 27907, 0, 0, 0, 1, 2, 1, 1, 'The Black Stalker (1) - Mana-Etched Pantaloons'),
(20184, 27938, 0, 0, 0, 1, 2, 1, 1, 'The Black Stalker (1) - Savage Mask of the Lynx Lord');
-- The Slave Pens
DELETE FROM `creature_loot_template` WHERE (`Entry` = 19894) AND (`Item` IN (31882, 31892, 31901, 31910));
UPDATE `creature_loot_template` SET `GroupID` = 5 WHERE `Entry` = 19894 AND `Item` IN (
27741, -- Bleeding Hollow Warhammer
27742, -- Mage-Fury Girdle
27800, -- Earthsoul Britches
28337, -- Breastplate of Righteous Fury
27796, -- Mana-Etched Spaulders
27740  -- Band of Ursol
);
-- The Blood Furnace
UPDATE `creature_loot_template` SET `GroupID` = 6 WHERE `Entry` = 18607 AND `Item` IN (
27494, -- Emerald Eye Bracer
27505, -- Ruby Helm of the Just
27507, -- Adamantine Repeater
27495, -- Soldier's Dog Tag
27497, -- Doomplate Gauntlets
27506  -- Robe of Effervescent Light
);
-- Hellfire Ramparts / Omor the Breaker
UPDATE `creature_loot_template` SET `GroupID` = 5 WHERE `Entry` = 18433 AND `Item` IN (
27463, -- Terror Flame Dagger
27465, -- Mana-Etched Gloves
27464, -- Omor's Unyielding Will
27462, -- Crimson Bracers of Gloom
27466, -- Headdress of Alacricity
27467  -- Silent-Strider Kneeboots
);
-- Hellfire Ramparts / Reinforced Fel Iron Chest
DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 21764) AND (`Item` IN (1, 2, 3, 4));
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21764, 1, 35093, 100, 0, 1, 1, 1, 2, 'Reinforced Fel Iron Chest - (ReferenceTable)'),
(21764, 2, 35093, 100, 0, 1, 2, 1, 1, 'Reinforced Fel Iron Chest - (ReferenceTable)'),
(21764, 3, 35094, 30, 0, 1, 0, 1, 1, 'Reinforced Fel Iron Chest - (ReferenceTable)'),
(21764, 4, 25009, 100, 0, 1, 0, 1, 1, 'Reinforced Fel Iron Chest - (ReferenceTable)');
UPDATE `reference_loot_template` SET `GroupID` = 2 WHERE `Entry` = 35093 AND `Item` IN (
27455, -- Irondrake Faceguard
27453, -- Averinn's Ring of Slaying
27452, -- Light Scribe Bands
27454, -- Volcanic Pauldrons
27456  -- Raiments of Nature's Breath
);
