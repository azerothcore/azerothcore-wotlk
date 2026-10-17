-- DB update 2025_07_20_01 -> 2025_07_20_02
-- Stackable debuffs
SET @flag := 4194304;

-- Utgarde Pinnacle
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (48880,59239,49165,61549,59608,31551,59605,50535,61460,33661,61509,61510,49710,58461,52352,58758,69130,50661,70393,69579,57759,27807,54326,30113,54772,28467);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(48880, @flag), -- Rend
(59239, @flag),
(49165, @flag), -- Shred
(61549, @flag),
--  Utgarde Keep
(59608, @flag), -- Sunder Armor (H only, N already has it)
(31551, @flag), -- Piercing Jab
(59605, @flag),
-- Oculus
(50535, @flag), -- Power Sap (also used by creatures around the entrance of the dungeon)
-- Old Kingdom
(61460, @flag), -- Aura of Lost Hope
-- Halls of Stone
(33661, @flag), -- Crush Armor (used in a bunch of other dungeons/raids too)
-- Halls of Lightnin
(61509, @flag), -- Melt Armor (N/H)
(61510, @flag),
-- Drak\'Tharon Keep
(49710, @flag), -- Gut Rip
-- Violet Hold
(58461, @flag), -- Sunder Armor
-- The Culling of Stratholme
(52352, @flag), -- Devour Flesh (N/H)
(58758, @flag),
-- Forge of Souls
(69130, @flag), -- Soul Siphon
-- Pit of Saron
(50661, @flag), -- Weakened Resolve
(70393, @flag), -- Devour Flesh
(69579, @flag), -- Arcing Slice
-- Obsidian Sanctum
(57759, @flag), -- Hammer Drop
-- Naxxramas (10/25)
(27807, @flag), -- Bile Vomit
(54326, @flag),
(30113, @flag), -- Putrid Bite
(54772, @flag),
(28467, @flag); -- Mortal Wound
