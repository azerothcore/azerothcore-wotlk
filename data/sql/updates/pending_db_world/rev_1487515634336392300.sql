INSERT INTO version_db_world (`sql_rev`) VALUES ('1487515634336392300');
DELETE FROM `spell_area` WHERE `spell`=60197 AND `area`=3752;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(60197, 3752, 10528, 0, 0, 0, 2, 1, 64, 0);

DELETE FROM `spell_area` WHERE `spell`=60194 AND `area`=3752;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(60194, 3752, 0, 10528, 0, 0, 2, 1, 0, 11);