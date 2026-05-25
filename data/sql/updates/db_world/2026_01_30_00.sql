-- DB update 2026_01_29_03 -> 2026_01_30_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (56072, 56070);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(56072, 'spell_wyrmrest_skytalon_ride_red_dragon_buddy_trigger'),
(56070, 'spell_wyrmrest_skytalon_summon_red_dragon_buddy');
