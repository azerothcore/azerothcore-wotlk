INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633815134238678267');

DELETE FROM `gameobject_template` WHERE `entry`=187558;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES (187558, 7, 91, 'Officer\'s Blythe\'s Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);

DELETE FROM `gameobject_template_addon` WHERE `entry` IN (187558, 186839, 186841);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `mingold`, `maxgold`) VALUES 
(187558, 0, 16, 0, 0),
(186839, 0, 16, 0, 0),
(186841, 0, 16, 0, 0);
