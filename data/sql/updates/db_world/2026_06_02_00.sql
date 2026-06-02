-- DB update 2026_06_01_02 -> 2026_06_02_00
-- Adjust Scarlet Champion (NPC ID 29080, GUID 129992)
-- Set Idle
-- Set Wander Dist to 0
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id1` = 29080) AND (`guid` IN (129992));
