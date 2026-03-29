-- Fix Ashtongue Channeler saved health (was incorrectly 1)
UPDATE `creature` SET `curhealth` = 87973 WHERE `id1` = 23421;
