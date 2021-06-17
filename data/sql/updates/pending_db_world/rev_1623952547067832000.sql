INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623952547067832000');

-- note: this is not ideal, it should be instead:
-- - an INSERT IGNORE containing the default DBC values
-- - and an UPDATE containing only the change
-- but the original author is gone and I do not know what fields are changing, so I'll leave it as it is
DELETE FROM `spell_dbc` WHERE (`ID` = 4511);
INSERT INTO `spell_dbc` VALUES (4511, 0, 0, 0, 301989888, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 10000, 0, 0, 4, 0, 0, 101, 0, 0, 12, 12, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 6, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72, 0, 211, 122, 0, 'Phase Shift','','','','','','','','', 0, 0, 0, 0, 0, 0, 0, 16712190,'','','','','','','','','', 0, 0, 0, 0, 0, 0, 0, 16712190, 'Shifts the imp out of phase with the world, making it unattackable unless it attacks.', null, null, null, null, null, null, null, null, 0, 0, 0, 0, 0, 0, 0, 16712190, 'Unattackable.','','','','','','','','', 0, 0, 0, 0, 0, 0, 0, 16712190, 0, 133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);

UPDATE `creature_template` SET `faction` = 73, `type_flags` = 4096, `ScriptName` = '' WHERE (`entry` = 416);
