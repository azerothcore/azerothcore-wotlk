-- DB update 2026_01_29_02 -> 2026_01_29_03
-- Wotlk armor value
UPDATE `creature_classlevelstats` SET `basearmor`=10643 WHERE `level`=83 AND `class`=1;
UPDATE `creature_classlevelstats` SET `basearmor`=10643 WHERE `level`=83 AND `class`=2;
