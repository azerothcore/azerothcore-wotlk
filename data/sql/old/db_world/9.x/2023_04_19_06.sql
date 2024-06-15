-- DB update 2023_04_19_05 -> 2023_04_19_06
-- Cyrukh the Firelord (21181)
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|42090322 WHERE `entry` = 21181;
