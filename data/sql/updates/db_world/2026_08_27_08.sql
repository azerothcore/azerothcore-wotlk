-- DB update 2026_08_27_07 -> 2026_08_27_08
--
-- MAX_AGGRO_RADIUS 45.0f
UPDATE `creature_template` SET `detection_range` = 45 WHERE (`entry` IN (33113, 34003));
