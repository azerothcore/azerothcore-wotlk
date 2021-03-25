INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616493761104943765');

-- Less blues from Mottled Razormaw/Scytheclaw
UPDATE `creature_loot_template` SET `Chance`=0.5 WHERE `Entry`=1022 AND `Reference` IN (24065,24067);
