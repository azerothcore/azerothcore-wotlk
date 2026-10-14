-- DB update 2026_10_03_09 -> 2026_10_03_10
-- Kickin' Nass and Takin' Manes (12630): cast Summon Nass (51865) triggered so it works while mounted
UPDATE `spell_scripts` SET `dataint` = 1
WHERE `id` IN (51864, 51889) AND `effIndex` = 0 AND `command` = 15 AND `datalong` = 51865;
