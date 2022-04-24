INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650744666752700000');

UPDATE `spell_dbc` SET `AttributesEx3`=`AttributesEx3`|0x00100000 WHERE `id` IN (22282,22283,22285,22286,22287,22288);
UPDATE `smart_scripts` SET `event_type`=11 WHERE `entryorguid`=12460 AND `source_type`=0 AND `id`=1;

DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (22282,22283,22285,22286,22287,22288);
INSERT INTO `spell_custom_attr` VALUES
(22282,0x00000800),
(22283,0x00000800),
(22285,0x00000800),
(22286,0x00000800),
(22287,0x00000800),
(22288,0x00000800);
