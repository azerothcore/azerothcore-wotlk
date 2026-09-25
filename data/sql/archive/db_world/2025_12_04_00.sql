-- DB update 2025_12_02_04 -> 2025_12_04_00

UPDATE `creature_template` SET `exp` = 2 WHERE (`entry` = 32263);
UPDATE `creature` SET `curhealth` = 10080 WHERE (`id1` = 32263) AND `guid` = 85056;
