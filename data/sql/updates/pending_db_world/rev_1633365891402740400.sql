INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633365891402740400');

UPDATE `quest_template` SET `AllowableRaces`=690 WHERE `ID`=5405;
UPDATE `quest_template` SET `AllowableRaces`=1101 WHERE `ID`=5401;
UPDATE `creature_queststarter` SET `id`=11039 WHERE `quest`=5503;
UPDATE `creature_questender` SET `id`=11039 WHERE `quest`=5503;
