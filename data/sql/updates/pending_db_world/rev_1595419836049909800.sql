INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595419836049909800');

ALTER TABLE `achievement_dbc` 
MODIFY COLUMN `Description_Lang_enUS` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Title_Lang_Mask`,
MODIFY COLUMN `Description_Lang_enGB` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enUS`,
MODIFY COLUMN `Description_Lang_koKR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enGB`,
MODIFY COLUMN `Description_Lang_frFR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_koKR`,
MODIFY COLUMN `Description_Lang_deDE` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_frFR`,
MODIFY COLUMN `Description_Lang_enCN` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_deDE`,
MODIFY COLUMN `Description_Lang_zhCN` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enCN`,
MODIFY COLUMN `Description_Lang_enTW` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_zhCN`,
MODIFY COLUMN `Description_Lang_zhTW` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enTW`,
MODIFY COLUMN `Description_Lang_esES` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_zhTW`,
MODIFY COLUMN `Description_Lang_esMX` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_esES`,
MODIFY COLUMN `Description_Lang_ruRU` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_esMX`,
MODIFY COLUMN `Description_Lang_ptPT` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ruRU`,
MODIFY COLUMN `Description_Lang_ptBR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ptPT`,
MODIFY COLUMN `Description_Lang_itIT` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ptBR`;

ALTER TABLE `faction_dbc` 
MODIFY COLUMN `Description_Lang_enUS` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Name_Lang_Mask`,
MODIFY COLUMN `Description_Lang_enGB` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enUS`,
MODIFY COLUMN `Description_Lang_koKR` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enGB`,
MODIFY COLUMN `Description_Lang_frFR` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_koKR`,
MODIFY COLUMN `Description_Lang_deDE` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_frFR`,
MODIFY COLUMN `Description_Lang_enCN` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_deDE`,
MODIFY COLUMN `Description_Lang_zhCN` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enCN`,
MODIFY COLUMN `Description_Lang_enTW` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_zhCN`,
MODIFY COLUMN `Description_Lang_zhTW` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enTW`,
MODIFY COLUMN `Description_Lang_esES` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_zhTW`,
MODIFY COLUMN `Description_Lang_esMX` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_esES`,
MODIFY COLUMN `Description_Lang_ruRU` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_esMX`,
MODIFY COLUMN `Description_Lang_ptPT` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ruRU`,
MODIFY COLUMN `Description_Lang_ptBR` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ptPT`,
MODIFY COLUMN `Description_Lang_itIT` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ptBR`;

ALTER TABLE `gameobjectdisplayinfo_dbc` 
MODIFY COLUMN `ModelName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `ID`;

ALTER TABLE `lfgdungeons_dbc` 
MODIFY COLUMN `Description_Lang_enUS` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Group_Id`,
MODIFY COLUMN `Description_Lang_enGB` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enUS`,
MODIFY COLUMN `Description_Lang_koKR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enGB`,
MODIFY COLUMN `Description_Lang_frFR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_koKR`,
MODIFY COLUMN `Description_Lang_deDE` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_frFR`,
MODIFY COLUMN `Description_Lang_enCN` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_deDE`,
MODIFY COLUMN `Description_Lang_zhCN` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enCN`,
MODIFY COLUMN `Description_Lang_enTW` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_zhCN`,
MODIFY COLUMN `Description_Lang_zhTW` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enTW`,
MODIFY COLUMN `Description_Lang_esES` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_zhTW`,
MODIFY COLUMN `Description_Lang_esMX` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_esES`,
MODIFY COLUMN `Description_Lang_ruRU` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_esMX`,
MODIFY COLUMN `Description_Lang_ptPT` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ruRU`,
MODIFY COLUMN `Description_Lang_ptBR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ptPT`,
MODIFY COLUMN `Description_Lang_itIT` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ptBR`;

ALTER TABLE `mailtemplate_dbc` 
MODIFY COLUMN `Body_Lang_enUS` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Subject_Lang_Mask`,
MODIFY COLUMN `Body_Lang_enGB` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_enUS`,
MODIFY COLUMN `Body_Lang_koKR` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_enGB`,
MODIFY COLUMN `Body_Lang_frFR` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_koKR`,
MODIFY COLUMN `Body_Lang_deDE` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_frFR`,
MODIFY COLUMN `Body_Lang_enCN` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_deDE`,
MODIFY COLUMN `Body_Lang_zhCN` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_enCN`,
MODIFY COLUMN `Body_Lang_enTW` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_zhCN`,
MODIFY COLUMN `Body_Lang_zhTW` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_enTW`,
MODIFY COLUMN `Body_Lang_esES` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_zhTW`,
MODIFY COLUMN `Body_Lang_esMX` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_esES`,
MODIFY COLUMN `Body_Lang_ruRU` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_esMX`,
MODIFY COLUMN `Body_Lang_ptPT` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_ruRU`,
MODIFY COLUMN `Body_Lang_ptBR` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_ptPT`,
MODIFY COLUMN `Body_Lang_itIT` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Body_Lang_ptBR`;

ALTER TABLE `map_dbc` 
MODIFY COLUMN `MapDescription0_Lang_enUS` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AreaTableID`,
MODIFY COLUMN `MapDescription0_Lang_enGB` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_enUS`,
MODIFY COLUMN `MapDescription0_Lang_koKR` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_enGB`,
MODIFY COLUMN `MapDescription0_Lang_frFR` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_koKR`,
MODIFY COLUMN `MapDescription0_Lang_deDE` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_frFR`,
MODIFY COLUMN `MapDescription0_Lang_enCN` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_deDE`,
MODIFY COLUMN `MapDescription0_Lang_zhCN` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_enCN`,
MODIFY COLUMN `MapDescription0_Lang_enTW` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_zhCN`,
MODIFY COLUMN `MapDescription0_Lang_zhTW` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_enTW`,
MODIFY COLUMN `MapDescription0_Lang_esES` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_zhTW`,
MODIFY COLUMN `MapDescription0_Lang_esMX` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_esES`,
MODIFY COLUMN `MapDescription0_Lang_ruRU` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_esMX`,
MODIFY COLUMN `MapDescription0_Lang_ptPT` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_ruRU`,
MODIFY COLUMN `MapDescription0_Lang_ptBR` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_ptPT`,
MODIFY COLUMN `MapDescription0_Lang_itIT` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_ptBR`,

MODIFY COLUMN `MapDescription1_Lang_enUS` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription0_Lang_Mask`,
MODIFY COLUMN `MapDescription1_Lang_enGB` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_enUS`,
MODIFY COLUMN `MapDescription1_Lang_koKR` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_enGB`,
MODIFY COLUMN `MapDescription1_Lang_frFR` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_koKR`,
MODIFY COLUMN `MapDescription1_Lang_deDE` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_frFR`,
MODIFY COLUMN `MapDescription1_Lang_enCN` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_deDE`,
MODIFY COLUMN `MapDescription1_Lang_zhCN` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_enCN`,
MODIFY COLUMN `MapDescription1_Lang_enTW` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_zhCN`,
MODIFY COLUMN `MapDescription1_Lang_zhTW` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_enTW`,
MODIFY COLUMN `MapDescription1_Lang_esES` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_zhTW`,
MODIFY COLUMN `MapDescription1_Lang_esMX` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_esES`,
MODIFY COLUMN `MapDescription1_Lang_ruRU` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_esMX`,
MODIFY COLUMN `MapDescription1_Lang_ptPT` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_ruRU`,
MODIFY COLUMN `MapDescription1_Lang_ptBR` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_ptPT`,
MODIFY COLUMN `MapDescription1_Lang_itIT` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `MapDescription1_Lang_ptBR`;

ALTER TABLE `mapdifficulty_dbc` 
MODIFY COLUMN `Message_Lang_enUS` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Difficulty`,
MODIFY COLUMN `Message_Lang_enGB` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_enUS`,
MODIFY COLUMN `Message_Lang_koKR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_enGB`,
MODIFY COLUMN `Message_Lang_frFR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_koKR`,
MODIFY COLUMN `Message_Lang_deDE` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_frFR`,
MODIFY COLUMN `Message_Lang_enCN` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_deDE`,
MODIFY COLUMN `Message_Lang_zhCN` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_enCN`,
MODIFY COLUMN `Message_Lang_enTW` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_zhCN`,
MODIFY COLUMN `Message_Lang_zhTW` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_enTW`,
MODIFY COLUMN `Message_Lang_esES` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_zhTW`,
MODIFY COLUMN `Message_Lang_esMX` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_esES`,
MODIFY COLUMN `Message_Lang_ruRU` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_esMX`,
MODIFY COLUMN `Message_Lang_ptPT` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_ruRU`,
MODIFY COLUMN `Message_Lang_ptBR` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_ptPT`,
MODIFY COLUMN `Message_Lang_itIT` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Message_Lang_ptBR`;

ALTER TABLE `skillline_dbc` 
MODIFY COLUMN `Description_Lang_enUS` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `DisplayName_Lang_Mask`,
MODIFY COLUMN `Description_Lang_enGB` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enUS`,
MODIFY COLUMN `Description_Lang_koKR` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enGB`,
MODIFY COLUMN `Description_Lang_frFR` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_koKR`,
MODIFY COLUMN `Description_Lang_deDE` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_frFR`,
MODIFY COLUMN `Description_Lang_enCN` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_deDE`,
MODIFY COLUMN `Description_Lang_zhCN` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enCN`,
MODIFY COLUMN `Description_Lang_enTW` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_zhCN`,
MODIFY COLUMN `Description_Lang_zhTW` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_enTW`,
MODIFY COLUMN `Description_Lang_esES` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_zhTW`,
MODIFY COLUMN `Description_Lang_esMX` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_esES`,
MODIFY COLUMN `Description_Lang_ruRU` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_esMX`,
MODIFY COLUMN `Description_Lang_ptPT` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ruRU`,
MODIFY COLUMN `Description_Lang_ptBR` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ptPT`,
MODIFY COLUMN `Description_Lang_itIT` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_ptBR`;

ALTER TABLE `spell_dbc` 
MODIFY COLUMN `AuraDescription_Lang_enUS` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `Description_Lang_Mask`,
MODIFY COLUMN `AuraDescription_Lang_enGB` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_enUS`,
MODIFY COLUMN `AuraDescription_Lang_koKR` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_enGB`,
MODIFY COLUMN `AuraDescription_Lang_frFR` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_koKR`,
MODIFY COLUMN `AuraDescription_Lang_deDE` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_frFR`,
MODIFY COLUMN `AuraDescription_Lang_enCN` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_deDE`,
MODIFY COLUMN `AuraDescription_Lang_zhCN` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_enCN`,
MODIFY COLUMN `AuraDescription_Lang_enTW` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_zhCN`,
MODIFY COLUMN `AuraDescription_Lang_zhTW` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_enTW`,
MODIFY COLUMN `AuraDescription_Lang_esES` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_zhTW`,
MODIFY COLUMN `AuraDescription_Lang_esMX` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_esES`,
MODIFY COLUMN `AuraDescription_Lang_ruRU` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_esMX`,
MODIFY COLUMN `AuraDescription_Lang_ptPT` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_ruRU`,
MODIFY COLUMN `AuraDescription_Lang_ptBR` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_ptPT`,
MODIFY COLUMN `AuraDescription_Lang_itIT` varchar(550) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `AuraDescription_Lang_ptBR`;

ALTER TABLE `spelldifficulty_dbc` 
MODIFY COLUMN `ID` int(11) NOT NULL DEFAULT 0 FIRST,
MODIFY COLUMN `DifficultySpellID_1` int(11) NOT NULL DEFAULT 0 AFTER `ID`,
MODIFY COLUMN `DifficultySpellID_2` int(11) NOT NULL DEFAULT 0 AFTER `DifficultySpellID_1`,
MODIFY COLUMN `DifficultySpellID_3` int(11) NOT NULL DEFAULT 0 AFTER `DifficultySpellID_2`;
