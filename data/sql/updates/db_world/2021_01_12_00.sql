-- DB update 2021_01_10_00 -> 2021_01_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_10_00 2021_01_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601843049417097700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601843049417097700');

UPDATE `creature_template` SET `npcflag`= 2 WHERE `entry` IN (27657, 27658, 27659);

DELETE FROM `gossip_menu_option` WHERE `MenuID`= 9708 AND `OptionID`= 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES 
(9708, 0, 0, 'So where do we go from here?', 28427, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `gossip_menu_option` WHERE `MenuID`= 9575 AND `OptionID`= 3;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES 
(9575, 3, 0, 'What abilities do ruby drakes have?', 28085, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `gossip_menu_option` WHERE `MenuID`= 9574 AND `OptionID` IN (2, 3);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES 
(9574, 2, 0, 'I want to exchange my Amber Essence for Emerald Essence.', 27038, 1, 1, 0, 0, 0, 0, '', 0, 0),
(9574, 3, 0, 'I want to exchange my Ruby Essence for Emerald Essence.', 27039, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `npc_text` WHERE `ID`= 12916;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES 
(12916, 'Varos Cloudstrider and his ring guardians protect the second ring.  Your drakes are more than a match for the ring guardians, but Varos stands behind an impenetrable shield created from the energy of the Oculus itself.  Ten centrifuge constructs power the shield from the ring and platforms above.  Destroy them and Varos will be vulnerable.$B$BI can grant you the power to call upon a drake from the red flight.  Speak to Eternos or Verdisa if you prefer to draw on the power of the bronze or the green.', '', 26950, 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 12340);

DELETE FROM `broadcast_text` WHERE `ID` IN (26950, 29536);
INSERT INTO `broadcast_text` (`ID`, `Language`, `MaleText`, `FemaleText`, `EmoteID0`, `EmoteID1`, `EmoteID2`, `EmoteDelay0`, `EmoteDelay1`, `EmoteDelay2`, `SoundId`, `Unk1`, `Unk2`, `VerifiedBuild`) VALUES 
(26950, 0, 'Varos Cloudstrider and his ring guardians protect the second ring.  Your drakes are more than a match for the ring guardians, but Varos stands behind an impenetrable shield created from the energy of the Oculus itself.  Ten centrifuge constructs power the shield from the ring and platforms above.  Destroy them and Varos will be vulnerable.$B$BI can grant you the power to call upon a drake from the red flight.  Speak to Eternos or Verdisa if you prefer to draw on the power of the bronze or the green.', '', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019),(29536, 0, 'Varos Cloudstrider and his ring guardians protect the second ring.  Your drakes are more than a match for the ring guardians, but Varos stands behind an impenetrable shield created from the energy of the Oculus itself.  Ten centrifuge constructs power the shield from the ring and platforms above.  Destroy them and Varos will be vulnerable.', 'Varos Cloudstrider and his ring guardians protect the second ring.  Your drakes are more than a match for the ring guardians, but Varos stands behind an impenetrable shield created from the energy of the Oculus itself.  Ten centrifuge constructs power the shield from the ring and platforms above.  Destroy them and Varos will be vulnerable.', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
