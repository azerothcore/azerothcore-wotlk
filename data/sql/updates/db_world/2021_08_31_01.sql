-- DB update 2021_08_31_00 -> 2021_08_31_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_31_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_31_00 2021_08_31_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629740472149311140'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629740472149311140');

-- Fixed the quest skill needed and moved the spectral chalice near Gloomrel instead of near Angerrel
UPDATE `quest_template_addon` SET `RequiredSkillID` = 186, `RequiredSkillPoints` = 230 WHERE (`ID` = 4083);
UPDATE `gameobject` SET `position_x` = 1225.07, `position_y` = -244.98, `position_z` = -85.67  WHERE (`id` = 164869) AND (`guid` IN (67871));

-- Changed the text of the introductory gossip
UPDATE `gossip_menu` SET `textid` = 2598 WHERE `menuid` = 1945;

-- Fix the text and broadcast option of the gossip texts
UPDATE `gossip_menu_option` SET `OptionText` = 'I have paid your price, Gloom''rel.  Now, teach me your secrets!', `OptionBroadcastTextID` = 4900 WHERE (`MenuID` = 1945) AND (`OptionID` IN (0));
UPDATE `gossip_menu_option` SET `OptionText` = 'Gloom''rel, tell me your secrets!', `OptionBroadcastTextID` = 4897 WHERE (`MenuID` = 1945) AND (`OptionID` IN (1));

-- Fixed the completion and the reward text, they were switched
UPDATE `quest_offer_reward` SET `RewardText` = 'The gems make no sound as they fall into depths of the chalice...' WHERE (`ID` = 4083);
UPDATE `quest_request_items` SET `CompletionText` = 'The spectral chalice floats in the air, slowing rising and falling... as if to the beat of a dying heart.' WHERE (`ID` = 4083);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_31_01' WHERE sql_rev = '1629740472149311140';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
