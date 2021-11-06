ALTER TABLE world_db_version CHANGE COLUMN 2016_08_14_00 2016_08_14_01 bit;

-- Hellscream's Warsong
UPDATE `spell_area` SET `spell`='73822'
WHERE `spell`='73818' AND `area`='4812' AND `quest_start`='0' AND `aura_spell`='0' AND `racemask`='690' AND `gender`='2';
-- Strength of Wrynn
UPDATE `spell_area` SET `spell`='73828'
WHERE `spell`='73824' AND `area`='4812' AND `quest_start`='0' AND `aura_spell`='0' AND `racemask`='1101' AND `gender`='2';
