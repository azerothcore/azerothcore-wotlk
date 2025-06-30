-- DB update 2025_05_09_00 -> 2025_05_09_01
--
UPDATE `creature` SET `spawnMask` = `spawnMask`&~(1) WHERE `guid` IN (68283,68284) AND `id1` = 31104;
