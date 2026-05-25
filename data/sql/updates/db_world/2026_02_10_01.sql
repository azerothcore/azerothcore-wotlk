-- DB update 2026_02_10_00 -> 2026_02_10_01
-- Add missing static transport parent_rotation values
DELETE FROM `gameobject_addon` WHERE `guid` IN (2837,6946,18802,18803,18804,18805,18806,18807,56162,56163);
INSERT INTO `gameobject_addon` (`guid`,`parent_rotation0`,`parent_rotation1`,`parent_rotation2`,`parent_rotation3`,`invisibilityType`,`invisibilityValue`) VALUES
(2837,0,0,0.996917,-0.078459,0,0),
(6946,0,0,0.992005,-0.126199,0,0),
(18802,0,0,1,0,0,0),
(18803,0,0,1,0,0,0),
(18804,0,0,1,0,0,0),
(18805,0,0,1,0,0,0),
(18806,0,0,1,0,0,0),
(18807,0,0,1,0,0,0),
(56162,0,0,1,-4.37114e-08,0,0),
(56163,0,0,1,-4.37114e-08,0,0);
