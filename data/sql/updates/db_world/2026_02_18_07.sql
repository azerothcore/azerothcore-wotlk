-- DB update 2026_02_18_06 -> 2026_02_18_07
--
-- The Lightning Capacitor, Thunder Capacitor, Reign of the Dead/Unliving trinkets
DELETE FROM `spell_script_names` WHERE `spell_id` IN (37657, 54841, 67712, 67758);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37657, 'spell_item_lightning_capacitor'),
(54841, 'spell_item_thunder_capacitor'),
(67712, 'spell_item_toc25_caster_trinket_normal'),
(67758, 'spell_item_toc25_caster_trinket_heroic');
