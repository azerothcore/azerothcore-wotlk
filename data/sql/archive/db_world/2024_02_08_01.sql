-- DB update 2024_02_08_00 -> 2024_02_08_01
--
UPDATE `creature_template` SET `spell_school_immune_mask` = `spell_school_immune_mask`|4 WHERE `entry` IN (19514, 19551);
