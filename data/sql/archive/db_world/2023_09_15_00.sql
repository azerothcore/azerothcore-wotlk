-- DB update 2023_09_14_01 -> 2023_09_15_00
--
ALTER TABLE `creature`
    ADD COLUMN `Comment` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `CreateObject`;

ALTER TABLE `gameobject`
    ADD COLUMN `Comment` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci' AFTER `VerifiedBuild`;

UPDATE `creature` SET `Comment` = 'Original Orientation: 3.141592741012573242' WHERE `id1` = 18634 AND `guid` = 146209;

UPDATE `creature` SET `Comment` = 'Mechanar Bridge Event Stage 1 Wave 1' WHERE `guid` IN (138817, 138818, 138890, 138831);
UPDATE `creature` SET `Comment` = 'Mechanar Bridge Event Stage 1 Wave 2' WHERE `guid` IN (138863);
UPDATE `creature` SET `Comment` = 'Mechanar Bridge Event Stage 1 Wave 3' WHERE `guid` IN (138891, 138876, 138877);

UPDATE `creature` SET `Comment` = 'Mechanar Bridge Event Stage 2 Wave 1' WHERE `guid` IN (138819, 138892, 138878);
UPDATE `creature` SET `Comment` = 'Mechanar Bridge Event Stage 2 Wave 2' WHERE `guid` IN (138864);
UPDATE `creature` SET `Comment` = 'Mechanar Bridge Event Stage 2 Wave 3' WHERE `guid` IN (138820, 138869, 138893, 138879);

SET @CGUID := 151000;
UPDATE `creature` SET `Comment` = 'Shattered Halls Legionnaire Gauntlet Group 1' WHERE `guid` BETWEEN @CGUID+19 AND @CGUID+23;
UPDATE `creature` SET `Comment` = 'Shattered Halls Legionnaire Gauntlet Group 2' WHERE `guid` BETWEEN @CGUID+24 AND @CGUID+28;
UPDATE `creature` SET `Comment` = 'Shattered Halls Legionnaire Gauntlet Group 3' WHERE `guid` BETWEEN @CGUID+29 AND @CGUID+34;
