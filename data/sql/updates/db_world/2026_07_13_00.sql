-- DB update 2026_07_12_02 -> 2026_07_13_00
-- Hodir helpers (#26330): swap PACIFIED (131072) for IMMUNE_TO_NPC (512) per sniffs, so Freya's
-- instance-wide Ground Tremor can't tag them and block her reset. SWIMMING kept where set;
-- immunity is cleared on Hodir engage (boss_hodir.cpp).
UPDATE `creature_template` SET `unit_flags` = (`unit_flags` & ~131072) | 512 WHERE `entry` IN (32893, 32897, 32900, 32901, 32941, 32946, 32948, 32950, 33325, 33326, 33327, 33328, 33330, 33331, 33332, 33333);
