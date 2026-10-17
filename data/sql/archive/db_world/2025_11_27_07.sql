-- DB update 2025_11_27_06 -> 2025_11_27_07
-- Following the same rule as the herbs, ores and fishing for the everfrost to be visible by all possible, they all use phase 255.
UPDATE `gameobject` SET `phaseMask` = 255 WHERE `id` = 193997;
