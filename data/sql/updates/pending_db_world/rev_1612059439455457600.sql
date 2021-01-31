INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612059439455457600');

-- SPELL_SCHOOL_FIRE
UPDATE `creature_template` SET `spell_school_immune_mask` = 4 WHERE `entry` IN (17267,15438);

-- SPELL_SCHOOL_NATURE
UPDATE `creature_template` SET `spell_school_immune_mask` = 8 WHERE `entry` IN (30258,31463,15352);

-- SPELL_SCHOOL_FROST
UPDATE `creature_template` SET `spell_school_immune_mask` = 16 WHERE `entry` IN (37994,510,17167);

-- School ALL
UPDATE `creature_template` SET `spell_school_immune_mask`=`spell_school_immune_mask`|1|2|4|8|16|32|64 WHERE `entry` IN (28912);
