-- DB update 2020_05_29_00 -> 2020_05_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_29_00 2020_05_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588269002996885593'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588269002996885593');

-- Fix Kalec msg on Felmyst death
UPDATE `creature_text` SET
`Text` = 'Madrigosa deserved a far better fate. You did what had to be done, but this battle is far from over!',
`Sound` = '12439',
`comment` = 'kalec - SAY_GOOD_MADRIGOSA - when you kill Felmyst'
WHERE `CreatureID` = '24891' AND `GroupID` = '3' AND `ID` = '0';

UPDATE `broadcast_text` SET `MaleText` = 'Madrigosa deserved a far better fate. You did what had to be done, but this battle is far from over!', `SoundId` = '12439' WHERE `ID` = '24993';

-- CORRECT TRANSLATION
UPDATE `broadcast_text_locale` SET `MaleText` = 'Madrigosa hat ein besseres Schicksal verdient. Ihr habt getan, was getan werden musste - doch diese Schlacht ist noch lange nicht vorbei!' WHERE `ID` = '24993' AND `locale` = 'deDE';
UPDATE `broadcast_text_locale` SET `MaleText` = 'Madrigosa merecía un destino mejor. Hicisteis lo que teníais que hacer, pero esta batalla aún no ha acabado.' WHERE `ID` = '24993' AND `locale` = 'esES';
UPDATE `broadcast_text_locale` SET `MaleText` = 'Madrigosa merecía un destino mejor. Hicisteis lo que teníais que hacer, pero esta batalla aún no ha acabado.' WHERE `ID` = '24993' AND `locale` = 'esMX';
UPDATE `broadcast_text_locale` SET `MaleText` = 'Madrigosa méritait un sort plus clément. Vous avez fait ce qu''il fallait, mais cette bataille est loin d''être terminée !' WHERE `ID` = '24993' AND `locale` = 'frFR';
UPDATE `broadcast_text_locale` SET `MaleText` = '운명은 마드리고사에게 너무 가혹했습니다. 해야 할 일을 하셨지만, 이 전투가 끝나려면 멀었습니다!' WHERE `ID` = '24993' AND `locale` = 'koKR';
UPDATE `broadcast_text_locale` SET `MaleText` = 'Мадригоса не заслужила такой участи... Вы сделали то, что должны были сделать... но эта битва еще не окончена!' WHERE `ID` = '24993' AND `locale` = 'ruRU';
UPDATE `broadcast_text_locale` SET `MaleText` = '虽然玛蒂苟萨的命运不该如此悲惨，你们的所作所为仍然是必须和必要的，不过，这场战争远未结束！' WHERE `ID` = '24993' AND `locale` = 'zhCN';
UPDATE `broadcast_text_locale` SET `MaleText` = '瑪卓苟莎的命運不該如此悲慘。但你們只盡了自己的本分，而這場戰爭尚未結束!' WHERE `ID` = '24993' AND `locale` = 'zhTW';


-- fix Felmyst not displaying her emote and displaying complete bullshit instead (who the fuck did that)
UPDATE `creature_text` SET
`Text` = '%s takes a deep breath...',
`Type` = '16',
`TextRange` = '2',
`Sound` = 0,
`comment` = 'felmyst - EMOTE_BREATH - When she flies and casts'
WHERE `CreatureID` = '25038' AND `GroupID` = '6' AND `ID` = '0';

-- Fix the duplicate line in broadcast shit
UPDATE `broadcast_text` SET
`MaleText` = '%s takes a deep breath...',
`SoundId` = 0
WHERE `ID` = '25261';

-- Translation taken from existing rows so it's all good, i just fixed the "..."
UPDATE `broadcast_text_locale` SET `MaleText` = '%s holt tief Luft...' WHERE `ID` = '25261' AND `locale` = 'deDE';
UPDATE `broadcast_text_locale` SET `MaleText` = '%s toma aliento...' WHERE `ID` = '25261' AND `locale` = 'esES';
UPDATE `broadcast_text_locale` SET `MaleText` = '%s toma aliento...' WHERE `ID` = '25261' AND `locale` = 'esMX';
UPDATE `broadcast_text_locale` SET `MaleText` = '%s inspire profondément...' WHERE `ID` = '25261' AND `locale` = 'frFR';
UPDATE `broadcast_text_locale` SET `MaleText` = '%s|1이;가; 숨을 깊게 들이쉽니다' WHERE `ID` = '25261' AND `locale` = 'koKR';
UPDATE `broadcast_text_locale` SET `MaleText` = '%s делает глубокий вдох...' WHERE `ID` = '25261' AND `locale` = 'ruRU';
UPDATE `broadcast_text_locale` SET `MaleText` = '%s深深地吸了一口气' WHERE `ID` = '25261' AND `locale` = 'zhCN';
UPDATE `broadcast_text_locale` SET `MaleText` = '%s深深地吸了一口氣' WHERE `ID` = '25261' AND `locale` = 'zhTW';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
