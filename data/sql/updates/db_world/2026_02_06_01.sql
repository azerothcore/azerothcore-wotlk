-- DB update 2026_02_06_00 -> 2026_02_06_01
-- Recalculate quaternion rotation from orientation for unverified gameobjects
UPDATE `gameobject` SET `rotation2` = SIN(`orientation` / 2), `rotation3` = COS(`orientation` / 2) WHERE `rotation0` = 0 AND `rotation1` = 0 AND (`VerifiedBuild` IS NULL OR `VerifiedBuild` = 0);
