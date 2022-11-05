-- DB update 2022_11_04_02 -> 2022_11_05_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` & 0xFFFFFF7F;
