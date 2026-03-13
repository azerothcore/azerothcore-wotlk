-- DB update 2024_09_28_00 -> 2024_09_28_01
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` & ~2048 WHERE (`entry` = 22056);
