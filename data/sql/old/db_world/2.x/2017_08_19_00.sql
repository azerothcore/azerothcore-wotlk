-- DB update 2017_08_18_03 -> 2017_08_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_18_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_18_03 2017_08_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1503072683748672200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1503072683748672200');
-- 'Clues in the Thicket' (Quest ID 9971) RewardText typo (Is it was/Is it what)
UPDATE `quest_template`
 SET `OfferRewardText`="So, I was right.  That was the corpse of one of the Broken?  And you can confirm that there was a strange object on the ground next to him?$B$BThis doesn't make any sense.  What would one of the Broken be doing here?  And what is that thing it had with him?$B$BIs it what caused all of this death?"
 WHERE `ID`=9971;
-- `An Unseen Hand` (Quest ID 10013) RewardText typo (2x "it to me")
UPDATE `quest_template`
 SET `OfferRewardText`="<Rokag takes the plans from you and looks them over.>$B$BSo Kaide was right! Those fel orc scum are up to something. I never would've guessed they were colluding with the blood elves, though.$B$BAccording to this map, the fel orcs are to keep us busy... but why? This is disturbing news, $N. You were correct in bringing it to me right away."
 WHERE `ID` = 10013;
-- 'Evil Draws Near' (Quest ID 10923) Progress typo (ben/been)
UPDATE `quest_template`
 SET `RequestItemsText` = "Has Teribus the Cursed been purged from the skies of Terokkar?"
 WHERE `ID` = 10923;
 --
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
