-- DB update 2023_11_19_04 -> 2023_11_19_05
-- Ethereal Spellfilcher
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|32768, `mechanic_immune_mask` = `mechanic_immune_mask`|579026775, `detection_range` = 24 WHERE `entry` = 16545;
