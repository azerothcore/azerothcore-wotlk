-- DB update 2025_07_22_02 -> 2025_07_22_03

-- Update position, orientation and Verified Build (Sniffed).
UPDATE `creature` SET `position_x` = 8216.233, `position_y` = 3516.222, `position_z` = 630.9635, `orientation` = 3.83972, `VerifiedBuild` = 61967 WHERE (`id1` = 31135) AND (`guid` = 123494);
