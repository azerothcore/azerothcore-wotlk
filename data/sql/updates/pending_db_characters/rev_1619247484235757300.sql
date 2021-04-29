INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1619247484235757300');

ALTER TABLE `pet_aura`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`guid`, `casterGuid`, `spell`, `effectMask`);
