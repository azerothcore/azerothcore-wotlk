-- DB update 2026_02_28_07 -> 2026_02_28_08
-- Phase for accepting or having completed any of the "Rider of%" quests
DELETE FROM `spell_area` WHERE `spell` = 58863 AND `area` = 4520;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(58863, 4520, 13161, 0, 0, 0, 2, 1, 74, 11),
(58863, 4520, 13162, 0, 0, 0, 2, 1, 74, 11),
(58863, 4520, 13163, 0, 0, 0, 2, 1, 74, 11);

-- Make sure all prerequisites are completed
UPDATE `conditions` SET `ElseGroup` = 0 WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` IN (13161, 13162, 13163) AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` IN (13146, 13147, 13160);
