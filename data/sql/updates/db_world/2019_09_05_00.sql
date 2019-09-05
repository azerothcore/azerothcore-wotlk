-- DB update 2019_09_04_00 -> 2019_09_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_09_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_09_04_00 2019_09_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1566945787997948952'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1566945787997948952');

DELETE FROM `spell_script_names` WHERE `spell_id` IN
(19597,19677,19676,19678,19679,19680,19684,19681,19682,19683,19685,19686,30647,30648,30652,30100,30103,30104,
 19548,19674,19687,19688,19689,19692,19693,19694,19696,19697,19699,19700,30646,30653,30654,30099,30102,30105);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`)
VALUES
(19597,'spell_hun_taming_the_beast'), -- Tame Ice Claw Bear         (NPC  1196, Quest 6085)
(19548,'spell_hun_tame_beast'),
(19677,'spell_hun_taming_the_beast'), -- Tame Large Crag Boar       (NPC  1126, Quest 6064)
(19674,'spell_hun_tame_beast'),
(19676,'spell_hun_taming_the_beast'), -- Tame Snow Leopard          (NPC  1201, Quest 6084)
(19687,'spell_hun_tame_beast'),
(19678,'spell_hun_taming_the_beast'), -- Tame Adult Plainstrider    (NPC  2956, Quest 6061)
(19688,'spell_hun_tame_beast'),
(19679,'spell_hun_taming_the_beast'), -- Tame Prairie Stalker       (NPC  2959, Quest 6087)
(19689,'spell_hun_tame_beast'),
(19680,'spell_hun_taming_the_beast'), -- Tame Swoop                 (NPC  2970, Quest 6088)
(19692,'spell_hun_tame_beast'),
(19684,'spell_hun_taming_the_beast'), -- Tame Webwood Lurker        (NPC  1998, Quest 6063)
(19693,'spell_hun_tame_beast'),
(19681,'spell_hun_taming_the_beast'), -- Tame Dire Mottled Boar     (NPC  3099, Quest 6062)
(19694,'spell_hun_tame_beast'),
(19682,'spell_hun_taming_the_beast'), -- Tame Surf Crawler          (NPC  3107, Quest 6083)
(19696,'spell_hun_tame_beast'),
(19683,'spell_hun_taming_the_beast'), -- Tame Armored Scorpid       (NPC  3126, Quest 6082)
(19697,'spell_hun_tame_beast'),
(19685,'spell_hun_taming_the_beast'), -- Tame Nightsaber Stalker    (NPC  2043, Quest 6101)
(19699,'spell_hun_tame_beast'),
(19686,'spell_hun_taming_the_beast'), -- Tame Strigid Screecher     (NPC  1996, Quest 6102)
(19700,'spell_hun_tame_beast'),
(30647,'spell_hun_taming_the_beast'), -- Tame Barbed Crawler        (NPC 17217, Quest 9591)
(30646,'spell_hun_tame_beast'),
(30648,'spell_hun_taming_the_beast'), -- Tame Greater Timberstrider (NPC 17374, Quest 9592)
(30653,'spell_hun_tame_beast'),
(30652,'spell_hun_taming_the_beast'), -- Tame Nightstalker          (NPC 17203, Quest 9593)
(30654,'spell_hun_tame_beast'),
(30100,'spell_hun_taming_the_beast'), -- Tame Crazed Dragonhawk     (NPC 15650, Quest 9484)
(30099,'spell_hun_tame_beast'),
(30103,'spell_hun_taming_the_beast'), -- Tame Elder Springpaw       (NPC 15652, Quest 9486)
(30102,'spell_hun_tame_beast'),
(30104,'spell_hun_taming_the_beast'), -- Tame Mistbat               (NPC 16353, Quest 9485)
(30105,'spell_hun_tame_beast');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
