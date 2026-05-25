-- DB update 2026_01_05_03 -> 2026_01_05_04
--
UPDATE `gameobject` SET `position_z` = 864.1913, `Comment` = 'original position_z: 870.297', `VerifiedBuild` = -47720 WHERE `guid` IN (5710989, 5710990, 5710991) AND `id` IN (189980, 189981, 191133);
