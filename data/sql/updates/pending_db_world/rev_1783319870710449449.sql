-- Move Marksman Bova to the correct position and model.

UPDATE `creature` SET `position_x` = -1720.64, `position_y` = 5637.84, `position_z` = 128.024, `orientation` = 2.60278 WHERE `guid` = 85406 AND `id` = 25195;

DELETE FROM `creature_template_model` WHERE `CreatureID` = 25195;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(25195, 0, 18743, 1, 1, 51831),
(25195, 1, 18742, 1, 0, 51831),
(25195, 2, 18741, 1, 0, 51831),
(25195, 3, 18740, 1, 0, 51831),
