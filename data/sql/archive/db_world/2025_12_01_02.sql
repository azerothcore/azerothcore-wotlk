-- DB update 2025_12_01_01 -> 2025_12_01_02

-- Set HP
UPDATE `creature` SET `curhealth` = 8982 WHERE (`id1` = 26523) AND (`guid` IN (150213, 150214, 150215, 150216, 150217));
