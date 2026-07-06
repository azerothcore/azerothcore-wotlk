-- DB update 2026_07_05_02 -> 2026_07_06_00
-- Move Marksman Bova to the correct position and model.

UPDATE `creature` SET `position_x` = -1721.4673, `position_y` = 5637.9883, `position_z` = 128.10652, `orientation` = 2.321287870407104492 WHERE `guid` = 85406 AND `id` = 25195;

DELETE FROM `creature_template_model` WHERE `CreatureID` = 25195;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(25195, 0, 18743, 1, 1, 51831),
(25195, 1, 18742, 1, 0, 51831),
(25195, 2, 18741, 1, 0, 51831),
(25195, 3, 18740, 1, 0, 51831);
