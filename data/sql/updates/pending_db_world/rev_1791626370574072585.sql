--
-- Set Disable Gravity - Black Knight's Skeletal Gryphon
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 35491;
INSERT INTO `creature_template_movement` (`CreatureId`,`Ground`,`Flight`,`Swim`,`Rooted`) VALUES (35491, 1, 1, 0, 0);
