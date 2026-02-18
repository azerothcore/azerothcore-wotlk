-- DB update 2026_02_18_02 -> 2026_02_18_03
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (52179, 16246, 16191, -30881, 55278, 55328, 55329, 55330, 55332, 55333, 55335, 58589, 58590, 58591, 28820);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(52179, 'spell_sha_astral_shift_visual_dummy'),
(16246, 'spell_sha_clearcasting'),
(16191, 'spell_sha_mana_tide'),
(-30881, 'spell_sha_nature_guardian'),
(55278, 'spell_sha_stoneclaw_totem'),
(55328, 'spell_sha_stoneclaw_totem'),
(55329, 'spell_sha_stoneclaw_totem'),
(55330, 'spell_sha_stoneclaw_totem'),
(55332, 'spell_sha_stoneclaw_totem'),
(55333, 'spell_sha_stoneclaw_totem'),
(55335, 'spell_sha_stoneclaw_totem'),
(58589, 'spell_sha_stoneclaw_totem'),
(58590, 'spell_sha_stoneclaw_totem'),
(58591, 'spell_sha_stoneclaw_totem'),
(28820, 'spell_sha_t3_8p_bonus');
