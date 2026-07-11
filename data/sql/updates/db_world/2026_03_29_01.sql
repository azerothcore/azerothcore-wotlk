-- DB update 2026_03_29_00 -> 2026_03_29_01
-- Fix Ashtongue Channeler saved health (was incorrectly 1)
UPDATE `creature` SET `curhealth` = 87973 WHERE `id1` = 23421;
