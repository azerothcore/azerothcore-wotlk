-- DB update 2022_03_13_00 -> 2022_03_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_13_00 2022_03_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643424341492582600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643424341492582600');

DELETE FROM `npc_text` WHERE `ID` IN (10303, 10304);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`) VALUES
(10303, 'Forgetting tribal leatherworking is not something to do lightly.  If you choose to abandon it you will forget all recipes that require tribal leatherworking as well!', 'Forgetting tribal leatherworking is not something to do lightly.  If you choose to abandon it you will forget all recipes that require tribal leatherworking as well!', 18974),
(10304, 'Forgetting dragonscale leatherworking is not something to do lightly.  If you choose to abandon it you will forget all recipes that require dragonscale leatherworking as well!', 'Forgetting dragonscale leatherworking is not something to do lightly.  If you choose to abandon it you will forget all recipes that require dragonscale leatherworking as well!', 18976);

DELETE FROM `gossip_menu` WHERE `MenuID` IN (3068, 3069, 3073) AND `TextID` IN (3802, 3803, 3806);
DELETE FROM `gossip_menu` WHERE `MenuID` IN (3075, 3076, 3077) AND `TextID` IN (10302, 10303, 10304);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(3068, 3802),
(3069, 3803),
(3073, 3806),
(3075, 10304), -- dragonscale
(3076, 10302), -- elemental
(3077, 10303); -- tribal

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (3067, 3068, 3069, 3070, 3072, 3073) AND `OptionID` = 0;
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (3067, 3068, 3069, 3070, 3072, 3073, 3075, 3076, 3077) AND `OptionID` = 1;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(3067, 0, 3, 'I would like to train.', 5597, 5, 16, 0, 0, 0, 0, '', 0, 0),
(3067, 1, 0, 'I wish to unlearn dragonscale leatherworking!', 18977, 1, 1, 3075, 0, 0, 0, '', 0, 0),
(3068, 0, 3, 'I would like to train.', 5597, 5, 16, 0, 0, 0, 0, '', 0, 0),
(3068, 1, 0, 'I wish to unlearn dragonscale leatherworking!', 18977, 1, 1, 3075, 0, 0, 0, '', 0, 0),
(3069, 0, 3, 'I would like to train.', 5597, 5, 16, 0, 0, 0, 0, '', 0, 0),
(3069, 1, 0, 'I wish to unlearn elemental leatherworking!', 18917, 1, 1, 3076, 0, 0, 0, '', 0, 0),
(3070, 0, 3, 'I would like to train.', 5597, 5, 16, 0, 0, 0, 0, '', 0, 0),
(3070, 1, 0, 'I wish to unlearn elemental leatherworking!', 18917, 1, 1, 3076, 0, 0, 0, '', 0, 0),
(3072, 0, 3, 'I would like to train.', 5597, 5, 16, 0, 0, 0, 0, '', 0, 0),
(3072, 1, 0, 'I wish to unlearn tribal leatherworking!', 18975, 1, 1, 3077, 0, 0, 0, '', 0, 0),
(3073, 0, 3, 'I would like to train.', 5597, 5, 16, 0, 0, 0, 0, '', 0, 0),
(3073, 1, 0, 'I wish to unlearn tribal leatherworking!', 18975, 1, 1, 3077, 0, 0, 0, '', 0, 0),
(3075, 1, 0, 'I wish to unlearn dragonscale leatherworking!', 18977, 1, 1, 0, 0, 0, 0, 'Do you really want to unlearn your leatherworking specialty and lose all associated recipes?', 18969, 0),
(3076, 1, 0, 'I wish to unlearn elemental leatherworking!', 18917, 1, 1, 0, 0, 0, 0, 'Do you really want to unlearn your leatherworking specialty and lose all associated recipes?', 18969, 0),
(3077, 1, 0, 'I wish to unlearn tribal leatherworking!', 18975, 1, 1, 0, 0, 0, 0, 'Do you really want to unlearn your leatherworking specialty and lose all associated recipes?', 18969, 0);


UPDATE `creature_template` SET `gossip_menu_id` = 3068, `npcflag` = `npcflag`|1 WHERE `entry` = 7867; -- Thorkaf Dragoneye
UPDATE `creature_template` SET `gossip_menu_id` = 3069, `npcflag` = `npcflag`|1 WHERE `entry` = 7869; -- Mrumn Winterhoof
UPDATE `creature_template` SET `gossip_menu_id` = 3073, `npcflag` = `npcflag`|1 WHERE `entry` = 7871; -- Se'Jib

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_14_00' WHERE sql_rev = '1643424341492582600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
