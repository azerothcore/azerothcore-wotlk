INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628102220316360200');

-- Changed the armor value to 1.5X for Gath'Ilzogg (334)
UPDATE `creature_template` SET `ArmorModifier` = 1.5 WHERE (`entry` = 334);

