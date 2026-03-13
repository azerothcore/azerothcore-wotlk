-- DB update 2026_01_04_00 -> 2026_01_04_01
--
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (12758, 12759, 12760);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `groupAI`) VALUES
(12758, 12758, 7),
(12758, 12762, 7),
(12758, 12761, 7),
(12759, 12759, 7),
(12759, 12763, 7),
(12759, 12764, 7),
(12760, 12760, 7),
(12760, 12765, 7),
(12760, 12766, 7);

DELETE FROM `linked_respawn` WHERE `linkedGuid` = 127214 AND `linkType` = 0;
INSERT INTO `linked_respawn` (`guid`, `linkedGuid`, `linkType`) VALUES
(12758, 127214, 0),
(12759, 127214, 0),
(12760, 127214, 0),
(12761, 127214, 0),
(12762, 127214, 0),
(12763, 127214, 0),
(12764, 127214, 0),
(12765, 127214, 0),
(12766, 127214, 0);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28729) AND (`source_type` = 0) AND (`id` IN (5));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28730) AND (`source_type` = 0) AND (`id` IN (4));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28731) AND (`source_type` = 0) AND (`id` IN (5));
