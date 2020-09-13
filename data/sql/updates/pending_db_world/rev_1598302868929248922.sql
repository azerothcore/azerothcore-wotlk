INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598302868929248922');
UPDATE `gameobject_loot_template` SET `QuestRequired` = 0 WHERE `item` = 43059;
DELETE FROM `spell_target_position` WHERE `ID` = 57553;
INSERT INTO `spell_target_position` VALUES
(57553, 0, 571, 5875.43, -1981.37, 234.671, 0, 0); -- Escape Voltarus
