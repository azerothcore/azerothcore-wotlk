-- DB update 2023_08_06_08 -> 2023_08_06_09
--
UPDATE `creature_template` SET `spell_school_immune_mask` = 0 WHERE (`entry` = 16488);
