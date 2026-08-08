-- The dailies were gated on the mount quest being incomplete, but that status runs off a cached
-- counter that can disagree with the bags, and then the last tooth can never be obtained. Carrying
-- the hatchling lasts exactly as long as the quest and cannot drift.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceGroup` = 0 AND `SourceEntry` IN (13889, 13903, 13904, 13905, 13914, 13915, 13916, 13917);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 13889, 0, 0, 2, 0, 46362, 1, 0, 0, 0, 0, '', 'Show quest \'Hungry, Hungry Hatchling\' only while carrying the Venomhide Hatchling'),
(19, 0, 13915, 0, 0, 2, 0, 46362, 1, 0, 0, 0, 0, '', 'Show quest \'Hungry, Hungry Hatchling\' only while carrying the Venomhide Hatchling'),
(19, 0, 13903, 0, 0, 2, 0, 46362, 1, 0, 0, 0, 0, '', 'Show quest \'Gorishi Grub\' only while carrying the Venomhide Hatchling'),
(19, 0, 13917, 0, 0, 2, 0, 46362, 1, 0, 0, 0, 0, '', 'Show quest \'Gorishi Grub\' only while carrying the Venomhide Hatchling'),
(19, 0, 13904, 0, 0, 2, 0, 46362, 1, 0, 0, 0, 0, '', 'Show quest \'Poached, Scrambled, Or Raw?\' only while carrying the Venomhide Hatchling'),
(19, 0, 13916, 0, 0, 2, 0, 46362, 1, 0, 0, 0, 0, '', 'Show quest \'Poached, Scrambled, Or Raw?\' only while carrying the Venomhide Hatchling'),
(19, 0, 13905, 0, 0, 2, 0, 46362, 1, 0, 0, 0, 0, '', 'Show quest \'Searing Roc Feathers\' only while carrying the Venomhide Hatchling'),
(19, 0, 13914, 0, 0, 2, 0, 46362, 1, 0, 0, 0, 0, '', 'Show quest \'Searing Roc Feathers\' only while carrying the Venomhide Hatchling');
