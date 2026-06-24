-- DB update 2026_06_17_00 -> 2026_06_18_00
--
-- Ignis the Furnace Master: bind the Brittle aura proc script (spell_ignis_brittle_aura)
-- to both raid difficulty variants so Iron Constructs shatter at the correct,
-- tooltip-accurate damage threshold (62382 = 10m/5000, 67114 = 25m/3000).
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62382, 67114);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62382, 'spell_ignis_brittle_aura'),
(67114, 'spell_ignis_brittle_aura');
