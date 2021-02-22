INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1614017601996735000');
SET @ID := 1500;
DELETE FROM `spell_group` WHERE (`id` = @ID);
INSERT INTO `spell_group` (`Id`, `spell_id`) VALUES
(@ID, 14204),
(@ID, 14203),
(@ID, 14202),
(@ID, 14201),
(@ID, 12880),
(@ID, 57521),
(@ID, 57520),
(@ID, 57519),
(@ID, 57518),
(@ID, 57522);
DELETE FROM `spell_group_stack_rules` WHERE (`group_id` = @ID);
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
(@ID, 1);
