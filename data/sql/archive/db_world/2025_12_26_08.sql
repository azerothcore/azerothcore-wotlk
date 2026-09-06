-- DB update 2025_12_26_07 -> 2025_12_26_08
--
UPDATE `gameobject` SET `position_z` = -6.5780087, `comment` = 'Original position_z: -15.8641', `VerifiedBuild` = -52237 WHERE `guid` IN (208397, 208414, 208431) AND `id` IN (2040, 1734, 2047);
