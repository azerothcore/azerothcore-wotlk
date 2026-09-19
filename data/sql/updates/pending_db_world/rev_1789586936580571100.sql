--
-- Grizzly Hills Trapper faction turns hostile after Escape from Silverbrook
DELETE FROM `spell_area` WHERE `spell` = 49640 AND `area` = 394 AND `quest_start` = 12308 AND `aura_spell` = 0 AND `racemask` = 0 AND `gender` = 2;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(49640, 394, 12308, 0, 0, 0, 2, 1, 64, 11);
