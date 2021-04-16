INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618600341183458700');

DELETE FROM `spell_dbc` WHERE `ID`=20253;
INSERT INTO `spell_dbc` (`ID`, `DefenseType`, `Attributes`, `SpellLevel`) VALUES
(20253,2,8192,0);
DELETE FROM `spell_dbc` WHERE `ID`=58620;
DELETE FROM `spell_dbc` WHERE `ID`=58621;
INSERT INTO `spell_dbc` (`ID`, `DefenseType`, `SpellLevel`) VALUES
(58620,1,0),
(58621,1,0);
DELETE FROM `spell_dbc` WHERE `ID`=64382;
DELETE FROM `spell_dbc` WHERE `ID`=20252;
DELETE FROM `spell_dbc` WHERE `ID`=20616;
DELETE FROM `spell_dbc` WHERE `ID`=20617;
DELETE FROM `spell_dbc` WHERE `ID`=25272;
DELETE FROM `spell_dbc` WHERE `ID`=25275;
INSERT INTO `spell_dbc` (`ID`, `Attributes`) VALUES
(64382,8192),
(20252,8192),
(20616,8192),
(20617,8192),
(25272,8192),
(25275,8192);