-- DB update 2024_11_15_01 -> 2024_11_15_02
-- remove trigger flag from 26594 Spiritual Insight Transform
UPDATE `creature_template` SET `flags_extra` = (`flags_extra` & ~128) WHERE (`entry` = 26594);
