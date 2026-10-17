-- DB update 2025_07_08_01 -> 2025_07_09_00

-- Edit Spell_Area
UPDATE `spell_area` SET `quest_start` = 12801, `quest_start_status` = `quest_start_status` &~ 10 WHERE `spell` = 58354;

-- Add the second Darion Mograine quest starter
DELETE FROM `creature_queststarter` WHERE (`quest` = 13165) AND (`id` IN (31084));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(31084, 13165);
