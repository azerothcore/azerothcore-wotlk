-- DB update 2026_01_05_02 -> 2026_01_05_03
--
DELETE FROM `spell_area` WHERE `spell` = 55858 AND `quest_start` = 12967;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(55858, 4437, 12967, 0, 0, 0, 2, 1, 64, 11),
(55858, 4438, 12967, 0, 0, 0, 2, 1, 64, 11),
(55858, 4439, 12967, 0, 0, 0, 2, 1, 64, 11),
(55858, 4440, 12967, 0, 0, 0, 2, 1, 64, 11),
(55858, 4455, 12967, 0, 0, 0, 2, 1, 64, 11);
