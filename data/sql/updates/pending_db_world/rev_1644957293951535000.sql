INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644957293951535000');

ALTER TABLE `quest_request_items` CHANGE `VerifiedBuild` `VerifiedBuild` INT(11) DEFAULT 0 NOT NULL;
ALTER TABLE `quest_details` CHANGE `VerifiedBuild` `VerifiedBuild` INT(11) DEFAULT 0 NOT NULL;
ALTER TABLE `quest_offer_reward` CHANGE `VerifiedBuild` `VerifiedBuild` INT(11) DEFAULT 0 NOT NULL;

UPDATE `quest_request_items` SET `EmoteOnComplete`=0, `EmoteOnIncomplete`=0, `VerifiedBuild`=42083 WHERE `ID`=2178;
UPDATE `quest_offer_reward` SET `Emote1`=5, `VerifiedBuild`=42083 WHERE `ID`=2178;

DELETE FROM `quest_details` WHERE `ID` = 2178;
INSERT INTO `quest_details` (`ID`, `Emote1`, `VerifiedBuild`) VALUES (2178, 1, 42083);
