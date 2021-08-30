INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630318500363217970');

-- Set Webwood spiders(1986) and Githyiss the Vile(1994) neutral to the player instead of aggresive
UPDATE `creature_template` SET `flags_extra` = 2, `faction` = 7 WHERE (`entry` IN (1986, 1994

