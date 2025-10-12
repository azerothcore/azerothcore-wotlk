-- DB update 2025_10_12_01 -> 2025_10_12_02
--
-- GM Utility Spell Scripts
DELETE FROM `spell_script_names` WHERE `spell_id` IN (456, 2765, 1509, 18139, 6147, 2763, 20115, 20114, 24676, 24675);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(456, 'spell_gen_showlabel_off'),
(2765, 'spell_gen_showlabel_on'),
(1509, 'spell_gen_gm_off'),
(18139, 'spell_gen_gm_on'),
(6147, 'spell_gen_invis_off'),
(2763, 'spell_gen_invis_on'),
(20115, 'spell_gen_bm_on'),
(20114, 'spell_gen_bm_off'),
(24676, 'spell_gen_bm_on'),
(24675, 'spell_gen_bm_off');

DELETE FROM `acore_string` WHERE `entry` = 1186;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(1186, 'Beastmaster mode is {}', NULL, NULL, 'Der Beastmaster mode ist an ({})!', '兽王模式：{}', NULL, NULL, NULL, NULL);

DELETE FROM `command` WHERE `name`='bm';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('bm', 3, 'Syntax: .bm [on/off]\nEnable or Disable in game Beastmaster mode or show current state if on/off not provided.');
