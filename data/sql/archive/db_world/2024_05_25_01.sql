-- DB update 2024_05_25_00 -> 2024_05_25_01
UPDATE `creature_loot_template` SET `Reference` = 1080007 WHERE `Reference` = 1080008 AND `Comment` = 'World Drop - Profession Recipes - NPC Levels ~50-63';
DELETE FROM `reference_loot_template` WHERE `Entry` = 1080008;
