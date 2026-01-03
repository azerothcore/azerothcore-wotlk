-- DB update 2026_01_02_04 -> 2026_01_03_00
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` & ~(1 | 2 | 4 | 8 | 16 | 64 | 128 | 2048 | 4096 | 8192 | 65536 | 524288 | 4194304 | 8388608 | 33554432 | 67108864 | 536870912) WHERE `entry` IN (30511, 30512, 30513);
