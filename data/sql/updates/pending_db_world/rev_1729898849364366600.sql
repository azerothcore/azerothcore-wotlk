-- Remove Iron Rune Laborers from creature_addon
DELETE FROM `creature_addon`
WHERE `guid` IN (
    110933, 110859, 110843, 110890, 110842, 110913,
    110840, 110858, 110869, 110928, 110889, 110845,
    110846, 110850, 110857, 110870
);
-- Add mining emote for Iron Rune Laborers in creature_addon
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES
(110933, 0, 0, 0, 1, 233, 0, NULL),
(110859, 0, 0, 0, 1, 233, 0, NULL),
(110843, 0, 0, 0, 1, 233, 0, NULL),
(110890, 0, 0, 0, 1, 233, 0, NULL),
(110842, 0, 0, 0, 1, 233, 0, NULL),
(110913, 0, 0, 0, 1, 233, 0, NULL),
(110840, 0, 0, 0, 1, 233, 0, NULL),
(110858, 0, 0, 0, 1, 233, 0, NULL),
(110869, 0, 0, 0, 1, 233, 0, NULL),
(110928, 0, 0, 0, 1, 233, 0, NULL),
(110889, 0, 0, 0, 1, 233, 0, NULL),
(110845, 0, 0, 0, 1, 233, 0, NULL),
(110846, 0, 0, 0, 1, 233, 0, NULL),
(110850, 0, 0, 0, 1, 233, 0, NULL),
(110857, 0, 0, 0, 1, 233, 0, NULL),
(110870, 0, 0, 0, 1, 233, 0, NULL);
