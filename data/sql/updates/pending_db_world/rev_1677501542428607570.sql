SET @SORCERER_ID = 4294;
SET @MYRMIDON_ID = 4295;
SET @DEFENDER_ID = 4298;
SET @CHAPLAIN_ID = 4299;
SET @WIZARD_ID = 4300;
SET @CENTURION_ID = 4301;
SET @CHAMPION_ID = 4302;
SET @ABBOT_ID = 4303;
SET @MONK_ID = 4540;

SET @RP_TEXTS_GROUP_ID := 0;

SET @SAVE_THIS_WORLD_ID := 0;
SET @SAVE_THIS_WORLD_BROADCAST_ID := 12381;
SET @SAVE_THIS_WORLD_TEXT := (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID`=@SAVE_THIS_WORLD_BROADCAST_ID);

SET @IT_BEGINS_ID := 1;
SET @IT_BEGINS_BROADCAST_ID := 12383;
SET @IT_BEGINS_TEXT := (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID`=@IT_BEGINS_BROADCAST_ID);

SET @ASHBRINGER_ID := 2;
SET @ASHBRINGER_BROADCAST_ID := 12378;
SET @ASHBRINGER_TEXT := (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID`=@ASHBRINGER_BROADCAST_ID);

SET @KNEEL_BEFORE_ID := 3;
SET @KNEEL_BEFORE_BROADCAST_ID := 12379;
SET @KNEEL_BEFORE_TEXT := (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID`=@KNEEL_BEFORE_BROADCAST_ID);

SET @INFIDELS_ID := 4;
SET @INFIDELS_BROADCAST_ID := 12382;
SET @INFIDELS_TEXT := (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID`=@INFIDELS_BROADCAST_ID);

SET @TAKE_ME_ID := 5;
SET @TAKE_ME_BROADCAST_ID := 12384;
SET @TAKE_ME_TEXT := (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID`=@TAKE_ME_BROADCAST_ID);

-- --
-- Separate Wizard's combat texts from event texts and add missing event texts.

UPDATE `creature_text`
    SET `GroupID` = 1
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `CreatureID` = @WIZARD_ID AND `Language` = 7
    AND `ID` IN (@SAVE_THIS_WORLD_ID, @IT_BEGINS_ID, @ASHBRINGER_ID, @KNEEL_BEFORE_ID);

-- For reapplicability
DELETE FROM `creature_text`
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `CreatureID` = @WIZARD_ID
    AND `ID` IN (@SAVE_THIS_WORLD_ID, @IT_BEGINS_ID, @ASHBRINGER_ID, @KNEEL_BEFORE_ID);

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
     (@WIZARD_ID, @RP_TEXTS_GROUP_ID, @SAVE_THIS_WORLD_ID, @SAVE_THIS_WORLD_TEXT, 12, 0, 100.0, 0, 0, 0, @SAVE_THIS_WORLD_BROADCAST_ID, 0, ''),
     (@WIZARD_ID, @RP_TEXTS_GROUP_ID, @IT_BEGINS_ID, @IT_BEGINS_TEXT, 12, 0, 100.0, 0, 0, 0, @IT_BEGINS_BROADCAST_ID, 0, ''),
     (@WIZARD_ID, @RP_TEXTS_GROUP_ID, @ASHBRINGER_ID, @ASHBRINGER_TEXT, 12, 0, 100.0, 0, 0, 0, @ASHBRINGER_BROADCAST_ID, 0, ''),
     (@WIZARD_ID, @RP_TEXTS_GROUP_ID, @KNEEL_BEFORE_ID, @KNEEL_BEFORE_TEXT, 12, 0, 100.0, 0, 0, 0, @KNEEL_BEFORE_BROADCAST_ID, 0, '');

-- --
-- Separate Myrmidon's Ashbringer event texts from combat texts, update script
-- to use new `GroupID` and add missing event text.

UPDATE `creature_text`
    SET `GroupID` = 2
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `CreatureID` = @MYRMIDON_ID AND `Type` = 16
    AND `ID` = @SAVE_THIS_WORLD_ID;

UPDATE `smart_scripts`
    SET `action_param1` = 2, `comment` = 'Scarlet Myrmidon - Between 0-40% Health - Say Line 2' -- TODO: Verify this on video
    WHERE (`entryorguid` = @MYRMIDON_ID) AND (`source_type` = 0) AND (`id` = 2);

-- For reapplicability
DELETE FROM `creature_text`
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `CreatureID` = @MYRMIDON_ID
    AND `ID` = @SAVE_THIS_WORLD_ID;

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
     (@MYRMIDON_ID, @RP_TEXTS_GROUP_ID, @SAVE_THIS_WORLD_ID, @SAVE_THIS_WORLD_TEXT, 12, 0, 100.0, 0, 0, 0, @SAVE_THIS_WORLD_BROADCAST_ID, 0, '');

-- --
-- Update existing, incorrect texts for Scarlet Monastery Ashbringer
-- event

UPDATE `creature_text`
    SET `Text` = @SAVE_THIS_WORLD_TEXT, `BroadcastTextId` = @SAVE_THIS_WORLD_BROADCAST_ID
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `ID` = @SAVE_THIS_WORLD_ID
    AND `CreatureID` in (@SORCERER_ID, @DEFENDER_ID, @CHAPLAIN_ID, @CENTURION_ID, @CHAMPION_ID, @MONK_ID);

-- For reapplicability
DELETE FROM `creature_text`
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `CreatureID` = @ABBOT_ID
    AND `ID` = @SAVE_THIS_WORLD_ID;

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
     (@ABBOT_ID, @RP_TEXTS_GROUP_ID, @SAVE_THIS_WORLD_ID, @SAVE_THIS_WORLD_TEXT, 12, 0, 100.0, 0, 0, 0, @SAVE_THIS_WORLD_BROADCAST_ID, 0, '');

UPDATE `creature_text`
    SET `Text` = @IT_BEGINS_TEXT, `BroadcastTextId` = @IT_BEGINS_BROADCAST_ID
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `ID` = @IT_BEGINS_ID
    AND `CreatureID` in (@SORCERER_ID, @MYRMIDON_ID, @DEFENDER_ID, @CHAPLAIN_ID, @CENTURION_ID, @CHAMPION_ID, @ABBOT_ID, @MONK_ID);

UPDATE `creature_text`
    SET `BroadcastTextId` = @ASHBRINGER_BROADCAST_ID
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `ID` = @ASHBRINGER_ID
    AND `CreatureID` in (@SORCERER_ID, @MYRMIDON_ID, @DEFENDER_ID, @CHAPLAIN_ID, @CENTURION_ID, @CHAMPION_ID, @ABBOT_ID, @MONK_ID);

UPDATE `creature_text`
    SET `BroadcastTextId` = @KNEEL_BEFORE_BROADCAST_ID
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `ID` = @KNEEL_BEFORE_ID
    AND `CreatureID` in (@SORCERER_ID, @MYRMIDON_ID, @DEFENDER_ID, @CHAPLAIN_ID, @CENTURION_ID, @CHAMPION_ID, @ABBOT_ID, @MONK_ID);

UPDATE `creature_text`
    SET `Text` = @INFIDELS_TEXT, `BroadcastTextId` = @INFIDELS_BROADCAST_ID
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `ID` = @INFIDELS_ID
    AND `CreatureID` in (@SORCERER_ID, @MYRMIDON_ID, @DEFENDER_ID, @CHAPLAIN_ID, @WIZARD_ID, @CENTURION_ID, @CHAMPION_ID, @ABBOT_ID, @MONK_ID);

UPDATE `creature_text`
    SET `Text` = @TAKE_ME_TEXT, `BroadcastTextId` = @TAKE_ME_BROADCAST_ID
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `ID` = @TAKE_ME_ID
    AND `CreatureID` in (@SORCERER_ID, @MYRMIDON_ID, @DEFENDER_ID, @CHAPLAIN_ID, @WIZARD_ID, @CENTURION_ID, @CHAMPION_ID, @ABBOT_ID, @MONK_ID);

-- --
-- Add missing texts

SET @UNWORTHY_ID := 6;
SET @UNWORTHY_BROADCAST_ID := 12380;
SET @UNWORTHY_TEXT := (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID`=@UNWORTHY_BROADCAST_ID);

-- For reapplicability
DELETE FROM `creature_text`
    WHERE `GroupID` = @RP_TEXTS_GROUP_ID AND `ID` = @UNWORTHY_ID
    AND `CreatureID` in (@SORCERER_ID, @MYRMIDON_ID, @DEFENDER_ID, @CHAPLAIN_ID, @WIZARD_ID, @CENTURION_ID, @CHAMPION_ID, @ABBOT_ID, @MONK_ID);

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
     (@SORCERER_ID, @RP_TEXTS_GROUP_ID, @UNWORTHY_ID, @UNWORTHY_TEXT, 12, 0, 100.0, 0, 0, 0, @UNWORTHY_BROADCAST_ID, 0, ''),
     (@MYRMIDON_ID, @RP_TEXTS_GROUP_ID, @UNWORTHY_ID, @UNWORTHY_TEXT, 12, 0, 100.0, 0, 0, 0, @UNWORTHY_BROADCAST_ID, 0, ''),
     (@DEFENDER_ID, @RP_TEXTS_GROUP_ID, @UNWORTHY_ID, @UNWORTHY_TEXT, 12, 0, 100.0, 0, 0, 0, @UNWORTHY_BROADCAST_ID, 0, ''),
     (@CHAPLAIN_ID, @RP_TEXTS_GROUP_ID, @UNWORTHY_ID, @UNWORTHY_TEXT, 12, 0, 100.0, 0, 0, 0, @UNWORTHY_BROADCAST_ID, 0, ''),
     (@WIZARD_ID, @RP_TEXTS_GROUP_ID, @UNWORTHY_ID, @UNWORTHY_TEXT, 12, 0, 100.0, 0, 0, 0, @UNWORTHY_BROADCAST_ID, 0, ''),
     (@CENTURION_ID, @RP_TEXTS_GROUP_ID, @UNWORTHY_ID, @UNWORTHY_TEXT, 12, 0, 100.0, 0, 0, 0, @UNWORTHY_BROADCAST_ID, 0, ''),
     (@CHAMPION_ID, @RP_TEXTS_GROUP_ID, @UNWORTHY_ID, @UNWORTHY_TEXT, 12, 0, 100.0, 0, 0, 0, @UNWORTHY_BROADCAST_ID, 0, ''),
     (@ABBOT_ID, @RP_TEXTS_GROUP_ID, @UNWORTHY_ID, @UNWORTHY_TEXT, 12, 0, 100.0, 0, 0, 0, @UNWORTHY_BROADCAST_ID, 0, ''),
     (@MONK_ID, @RP_TEXTS_GROUP_ID, @UNWORTHY_ID, @UNWORTHY_TEXT, 12, 0, 100.0, 0, 0, 0, @UNWORTHY_BROADCAST_ID, 0, '');

-- --
-- Set up area trigger for event intro
-- For reapplicability
DELETE FROM `areatrigger_scripts`
    WHERE `entry` = 4089;

INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
     (4089, 'at_scarlet_monastery_cathedral_entrance');

-- --
-- Commander Mograine's intro yell

SET @MOGRAINE_ID := 3976;
SET @MOGRAINE_BROADCAST_ID := 12389;

-- For reapplicability
DELETE FROM `creature_text`
    WHERE `GroupID` = 6 AND `ID` = 0 AND `CreatureID` = @MOGRAINE_ID;

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
     (@MOGRAINE_ID, 6, 0, (SELECT `MaleText` FROM `broadcast_text` WHERE `ID`=@MOGRAINE_BROADCAST_ID), 14, 0, 100.0, 0, 0, 0, @MOGRAINE_BROADCAST_ID, 3,'Ashbringer event intro yell');

-- --
-- Commander Mograine's talk upon being approached by player

SET @MOGRAINE_APPROACH_BROADCAST_ID := 12390;
SET @MOGRAINE_APPROACH_TEXT := (SELECT `MaleText` FROM `broadcast_text` WHERE `ID`=@MOGRAINE_APPROACH_BROADCAST_ID);

UPDATE `creature_text`
    SET `Text` = @MOGRAINE_APPROACH_TEXT, `BroadcastTextId` = @MOGRAINE_APPROACH_BROADCAST_ID
    WHERE `GroupID` = 3 AND `ID` = 0 AND `CreatureID` = @MOGRAINE_ID;

-- --
-- And while I am doing this, fix the non-Ashbringer texts for the NPCs too,
-- some of them exist in the DB but there's no script to say them, some of
-- them are missing, and Centurion says Ashbringer texts on aggro.
--
-- Speaking of Centurion, its smart script that says the Ashbringer texts on
-- aggro was used as the basis for the scripts for saying the correct on
-- aggro texts for all of these NPCs.
-- Scarlet Wizard has the texts -> copy the texts from Wizard's creature_text.

-- Move Abbot's emote to a different group.

SET @COMBAT_TEXTS_GROUP_ID = 1;

UPDATE `creature_text`
    SET `GroupID` = 2
    WHERE `GroupID` = @COMBAT_TEXTS_GROUP_ID AND `CreatureID` = @ABBOT_ID AND `Type` = 16
    AND `ID` = 0;

UPDATE `smart_scripts`
    SET `action_param1` = 2, `comment` = 'Scarlet Abbot - Between 0-40% Health - Say Line 2'
    WHERE (`entryorguid` = @ABBOT_ID) AND (`source_type` = 0) AND (`id` = 4);

-- Add missing texts

SET @TAINT_SCOURGE_ID = 0;
SET @TAINT_SCOURGE_BROADCAST_ID = (SELECT `BroadcastTextId` FROM `creature_text`
                                    WHERE `CreatureID` = @WIZARD_ID
                                    AND `GroupID` = @COMBAT_TEXTS_GROUP_ID
                                    AND `ID` = @TAINT_SCOURGE_ID);
SET @TAINT_SCOURGE_TEXT = (SELECT `Text` FROM `creature_text`
                            WHERE `CreatureID` = @WIZARD_ID
                            AND `GroupID` = @COMBAT_TEXTS_GROUP_ID
                            AND `ID` = @TAINT_SCOURGE_ID);

DELETE FROM `creature_text`
    WHERE `GroupID` = @COMBAT_TEXTS_GROUP_ID AND `ID` = @TAINT_SCOURGE_ID
    AND `CreatureID` IN (@SORCERER_ID, @DEFENDER_ID, @CHAPLAIN_ID, @CENTURION_ID, @CHAMPION_ID, @ABBOT_ID, @MONK_ID);

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
     (@SORCERER_ID, @COMBAT_TEXTS_GROUP_ID, @TAINT_SCOURGE_ID, @TAINT_SCOURGE_TEXT, 12, 7, 25.0, 0, 0, 0, @TAINT_SCOURGE_BROADCAST_ID, 0, 'Scarlet Sorcerer'),
     (@DEFENDER_ID, @COMBAT_TEXTS_GROUP_ID, @TAINT_SCOURGE_ID, @TAINT_SCOURGE_TEXT, 12, 7, 25.0, 0, 0, 0, @TAINT_SCOURGE_BROADCAST_ID, 0, 'Scarlet Defender'),
     (@CHAPLAIN_ID, @COMBAT_TEXTS_GROUP_ID, @TAINT_SCOURGE_ID, @TAINT_SCOURGE_TEXT, 12, 7, 25.0, 0, 0, 0, @TAINT_SCOURGE_BROADCAST_ID, 0, 'Scarlet Chaplain'),
     (@CENTURION_ID, @COMBAT_TEXTS_GROUP_ID, @TAINT_SCOURGE_ID, @TAINT_SCOURGE_TEXT, 12, 7, 25.0, 0, 0, 0, @TAINT_SCOURGE_BROADCAST_ID, 0, 'Scarlet Centurion'),
     (@CHAMPION_ID, @COMBAT_TEXTS_GROUP_ID, @TAINT_SCOURGE_ID, @TAINT_SCOURGE_TEXT, 12, 7, 25.0, 0, 0, 0, @TAINT_SCOURGE_BROADCAST_ID, 0, 'Scarlet Champion'),
     (@ABBOT_ID, @COMBAT_TEXTS_GROUP_ID, @TAINT_SCOURGE_ID, @TAINT_SCOURGE_TEXT, 12, 7, 25.0, 0, 0, 0, @TAINT_SCOURGE_BROADCAST_ID, 0, 'Scarlet Abbot'),
     (@MONK_ID, @COMBAT_TEXTS_GROUP_ID, @TAINT_SCOURGE_ID, @TAINT_SCOURGE_TEXT, 12, 7, 25.0, 0, 0, 0, @TAINT_SCOURGE_BROADCAST_ID, 0, 'Scarlet Monk');

SET @NO_ESCAPE_ID = 1;
SET @NO_ESCAPE_BROADCAST_ID = (SELECT `BroadcastTextId` FROM `creature_text`
                                WHERE `CreatureID` = @WIZARD_ID
                                AND `GroupID` = @COMBAT_TEXTS_GROUP_ID
                                AND `ID` = @NO_ESCAPE_ID);
SET @NO_ESCAPE_TEXT = (SELECT `Text` FROM `creature_text`
                        WHERE `CreatureID` = @WIZARD_ID
                        AND `GroupID` = @COMBAT_TEXTS_GROUP_ID
                        AND `ID` = @NO_ESCAPE_ID);

DELETE FROM `creature_text`
    WHERE `GroupID` = @COMBAT_TEXTS_GROUP_ID AND `ID` = @NO_ESCAPE_ID
    AND `CreatureID` IN (@SORCERER_ID, @DEFENDER_ID, @CHAPLAIN_ID, @CENTURION_ID, @CHAMPION_ID, @ABBOT_ID, @MONK_ID);

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
     (@SORCERER_ID, @COMBAT_TEXTS_GROUP_ID, @NO_ESCAPE_ID, @NO_ESCAPE_TEXT, 12, 7, 25.0, 0, 0, 0, @NO_ESCAPE_BROADCAST_ID, 0, 'Scarlet Sorcerer'),
     (@DEFENDER_ID, @COMBAT_TEXTS_GROUP_ID, @NO_ESCAPE_ID, @NO_ESCAPE_TEXT, 12, 7, 25.0, 0, 0, 0, @NO_ESCAPE_BROADCAST_ID, 0, 'Scarlet Defender'),
     (@CHAPLAIN_ID, @COMBAT_TEXTS_GROUP_ID, @NO_ESCAPE_ID, @NO_ESCAPE_TEXT, 12, 7, 25.0, 0, 0, 0, @NO_ESCAPE_BROADCAST_ID, 0, 'Scarlet Chaplain'),
     (@CENTURION_ID, @COMBAT_TEXTS_GROUP_ID, @NO_ESCAPE_ID, @NO_ESCAPE_TEXT, 12, 7, 25.0, 0, 0, 0, @NO_ESCAPE_BROADCAST_ID, 0, 'Scarlet Centurion'),
     (@CHAMPION_ID, @COMBAT_TEXTS_GROUP_ID, @NO_ESCAPE_ID, @NO_ESCAPE_TEXT, 12, 7, 25.0, 0, 0, 0, @NO_ESCAPE_BROADCAST_ID, 0, 'Scarlet Champion'),
     (@ABBOT_ID, @COMBAT_TEXTS_GROUP_ID, @NO_ESCAPE_ID, @NO_ESCAPE_TEXT, 12, 7, 25.0, 0, 0, 0, @NO_ESCAPE_BROADCAST_ID, 0, 'Scarlet Abbot'),
     (@MONK_ID, @COMBAT_TEXTS_GROUP_ID, @NO_ESCAPE_ID, @NO_ESCAPE_TEXT, 12, 7, 25.0, 0, 0, 0, @NO_ESCAPE_BROADCAST_ID, 0, 'Scarlet Monk');

SET @LIGHT_CONDEMNS_ID = 2;
SET @LIGHT_CONDEMNS_BROADCAST_ID = (SELECT `BroadcastTextId` FROM `creature_text`
                                        WHERE `CreatureID` = @WIZARD_ID
                                        AND `GroupID` = @COMBAT_TEXTS_GROUP_ID
                                        AND `ID` = @LIGHT_CONDEMNS_ID);
SET @LIGHT_CONDEMNS_TEXT = (SELECT `Text` FROM `creature_text`
                                WHERE `CreatureID` = @WIZARD_ID
                                AND `GroupID` = @COMBAT_TEXTS_GROUP_ID
                                AND `ID` = @LIGHT_CONDEMNS_ID);

DELETE FROM `creature_text`
    WHERE `GroupID` = @COMBAT_TEXTS_GROUP_ID AND `ID` = @LIGHT_CONDEMNS_ID
    AND `CreatureID` IN (@SORCERER_ID, @DEFENDER_ID, @CHAPLAIN_ID, @CENTURION_ID, @CHAMPION_ID, @ABBOT_ID, @MONK_ID);

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
     (@SORCERER_ID, @COMBAT_TEXTS_GROUP_ID, @LIGHT_CONDEMNS_ID, @LIGHT_CONDEMNS_TEXT, 12, 7, 25.0, 0, 0, 0, @LIGHT_CONDEMNS_BROADCAST_ID, 0, 'Scarlet Sorcerer'),
     (@DEFENDER_ID, @COMBAT_TEXTS_GROUP_ID, @LIGHT_CONDEMNS_ID, @LIGHT_CONDEMNS_TEXT, 12, 7, 25.0, 0, 0, 0, @LIGHT_CONDEMNS_BROADCAST_ID, 0, 'Scarlet Defender'),
     (@CHAPLAIN_ID, @COMBAT_TEXTS_GROUP_ID, @LIGHT_CONDEMNS_ID, @LIGHT_CONDEMNS_TEXT, 12, 7, 25.0, 0, 0, 0, @LIGHT_CONDEMNS_BROADCAST_ID, 0, 'Scarlet Chaplain'),
     (@CENTURION_ID, @COMBAT_TEXTS_GROUP_ID, @LIGHT_CONDEMNS_ID, @LIGHT_CONDEMNS_TEXT, 12, 7, 25.0, 0, 0, 0, @LIGHT_CONDEMNS_BROADCAST_ID, 0, 'Scarlet Centurion'),
     (@CHAMPION_ID, @COMBAT_TEXTS_GROUP_ID, @LIGHT_CONDEMNS_ID, @LIGHT_CONDEMNS_TEXT, 12, 7, 25.0, 0, 0, 0, @LIGHT_CONDEMNS_BROADCAST_ID, 0, 'Scarlet Champion'),
     (@ABBOT_ID, @COMBAT_TEXTS_GROUP_ID, @LIGHT_CONDEMNS_ID, @LIGHT_CONDEMNS_TEXT, 12, 7, 25.0, 0, 0, 0, @LIGHT_CONDEMNS_BROADCAST_ID, 0, 'Scarlet Abbot'),
     (@MONK_ID, @COMBAT_TEXTS_GROUP_ID, @LIGHT_CONDEMNS_ID, @LIGHT_CONDEMNS_TEXT, 12, 7, 25.0, 0, 0, 0, @LIGHT_CONDEMNS_BROADCAST_ID, 0, 'Scarlet Monk');

SET @SMITE_WICKED_ID = 3;
SET @SMITE_WICKED_BROADCAST_ID = (SELECT `BroadcastTextId` FROM `creature_text`
                                    WHERE `CreatureID` = @WIZARD_ID
                                    AND `GroupID` = @COMBAT_TEXTS_GROUP_ID
                                    AND `ID` = @SMITE_WICKED_ID);
SET @SMITE_WICKED_TEXT = (SELECT `Text` FROM `creature_text`
                            WHERE `CreatureID` = @WIZARD_ID
                            AND `GroupID` = @COMBAT_TEXTS_GROUP_ID
                            AND `ID` = @SMITE_WICKED_ID);

DELETE FROM `creature_text`
    WHERE `GroupID` = @COMBAT_TEXTS_GROUP_ID AND `ID` = @SMITE_WICKED_ID
    AND `CreatureID` IN (@SORCERER_ID, @DEFENDER_ID, @CHAPLAIN_ID, @CENTURION_ID, @CHAMPION_ID, @ABBOT_ID, @MONK_ID);

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
     (@SORCERER_ID, @COMBAT_TEXTS_GROUP_ID, @SMITE_WICKED_ID, @SMITE_WICKED_TEXT, 12, 7, 25.0, 0, 0, 0, @SMITE_WICKED_BROADCAST_ID, 0, 'Scarlet Sorcerer'),
     (@DEFENDER_ID, @COMBAT_TEXTS_GROUP_ID, @SMITE_WICKED_ID, @SMITE_WICKED_TEXT, 12, 7, 25.0, 0, 0, 0, @SMITE_WICKED_BROADCAST_ID, 0, 'Scarlet Defender'),
     (@CHAPLAIN_ID, @COMBAT_TEXTS_GROUP_ID, @SMITE_WICKED_ID, @SMITE_WICKED_TEXT, 12, 7, 25.0, 0, 0, 0, @SMITE_WICKED_BROADCAST_ID, 0, 'Scarlet Chaplain'),
     (@CENTURION_ID, @COMBAT_TEXTS_GROUP_ID, @SMITE_WICKED_ID, @SMITE_WICKED_TEXT, 12, 7, 25.0, 0, 0, 0, @SMITE_WICKED_BROADCAST_ID, 0, 'Scarlet Centurion'),
     (@CHAMPION_ID, @COMBAT_TEXTS_GROUP_ID, @SMITE_WICKED_ID, @SMITE_WICKED_TEXT, 12, 7, 25.0, 0, 0, 0, @SMITE_WICKED_BROADCAST_ID, 0, 'Scarlet Champion'),
     (@ABBOT_ID, @COMBAT_TEXTS_GROUP_ID, @SMITE_WICKED_ID, @SMITE_WICKED_TEXT, 12, 7, 25.0, 0, 0, 0, @SMITE_WICKED_BROADCAST_ID, 0, 'Scarlet Abbot'),
     (@MONK_ID, @COMBAT_TEXTS_GROUP_ID, @SMITE_WICKED_ID, @SMITE_WICKED_TEXT, 12, 7, 25.0, 0, 0, 0, @SMITE_WICKED_BROADCAST_ID, 0, 'Scarlet Monk');

-- Add smart scripts to say the combat lines

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@SORCERER_ID, @MYRMIDON_ID, @WIZARD_ID, @CHAMPION_ID, @ABBOT_ID, @CENTURION_ID) AND (`source_type` = 0) AND (`id` = 0);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@DEFENDER_ID, @CHAPLAIN_ID, @MONK_ID) AND (`source_type` = 0) AND (`id` = 1);

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
     (@SORCERER_ID, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sorcerer - On Aggro - Say Line 1'),
     (@MYRMIDON_ID, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Myrmidon - On Aggro - Say Line 1'),
     (@DEFENDER_ID, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Defender - On Aggro - Say Line 1'),
     (@CHAPLAIN_ID, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Chaplain - On Aggro - Say Line 1'),
     (@WIZARD_ID, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Wizard - On Aggro - Say Line 1'),
     (@CENTURION_ID, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Centurion - On Aggro - Say Line 1'),
     (@CHAMPION_ID, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Champion - On Aggro - Say Line 1'),
     (@ABBOT_ID, 0, 0, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - On Aggro - Say Line 1'),
     (@MONK_ID, 0, 1, 0, 4, 0, 20, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - On Aggro - Say Line 1');

-- --
-- And it seems that the yell Mograine does when he kills a player is broken.
-- Let's fix that too.

SET @MOGRAINE_UNWORTHY_GROUP_ID = 1;
SET @MOGRAINE_UNWORTHY_BROADCAST_ID = 6197;
SET @MOGRAINE_UNWORTHY_TEXT = (SELECT `MaleText` FROM `broadcast_text` WHERE `ID`=@MOGRAINE_UNWORTHY_BROADCAST_ID);

UPDATE `creature_text`
    SET `Text` = @MOGRAINE_UNWORTHY_TEXT, `BroadcastTextId` = @MOGRAINE_UNWORTHY_BROADCAST_ID
    WHERE `GroupID` = @MOGRAINE_UNWORTHY_GROUP_ID AND `ID` = 0 AND `CreatureID` = @MOGRAINE_ID;

-- --
-- Fix Highlord Mograine's waypoints so that he ends up standing at a more
-- blizzlike position.
SET @HIGHLORD_MOGRAINE_ID := 16440;

DELETE FROM `waypoints` WHERE `entry` = @HIGHLORD_MOGRAINE_ID AND `pointid` IN (4, 5);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
	 (@HIGHLORD_MOGRAINE_ID,4,1149.0,1399.3,31.97,NULL,0,'Renault'),
	 (@HIGHLORD_MOGRAINE_ID,5,1150.5,1398.4,32.25,NULL,0,'Renault');

-- Have Highlord Mograine wait five seconds before moving, and have him
-- end up facing Renault.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16440) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
     (@HIGHLORD_MOGRAINE_ID, 0, 1, 2, 40, 0, 100, 0, 5, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine Transform - On Waypoint 5 Reached - Set Rooted On'),
     (@HIGHLORD_MOGRAINE_ID, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 3976, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine Transform - On Waypoint 5 Reached - Set Orientation Closest Creature \'Scarlet Commander Mograine\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16440) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
     (@HIGHLORD_MOGRAINE_ID, 0, 0, 1, 25, 0, 100, 513, 0, 0, 0, 0, 0, 53, 0, 16440, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine Transform - On Reset - Start Waypoint (No Repeat)'),
     (@HIGHLORD_MOGRAINE_ID, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 54, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine Transform - On Reset - Pause Waypoint (No Repeat)'),
     (@HIGHLORD_MOGRAINE_ID, 0, 2, 3, 40, 0, 100, 0, 5, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine Transform - On Waypoint 5 Reached - Set Rooted On'),
     (@HIGHLORD_MOGRAINE_ID, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 3976, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine Transform - On Waypoint 5 Reached - Set Orientation Closest Creature \'Scarlet Commander Mograine\'');

-- --
-- Update Highlord Mograine's texts with broadcast IDs and move some of his
-- emotes from code to data.

SET @EMOTE_POINT := 25;
SET @EMOTE_TALK := 1;

SET @TEXT_RENAULT_GROUP_ID := 0;
SET @TEXT_RENAULT_BROADCAST_ID := 12469;

SET @TEXT_BETRAYAL_GROUP_ID := 1;
SET @TEXT_BETRAYAL_BROADCAST_ID := 12471;

SET @TEXT_FORGIVEN_GROUP_ID := 2;
SET @TEXT_FORGIVEN_BROADCAST_ID := 12473;

UPDATE `creature_text`
    SET `BroadcastTextId` = @TEXT_RENAULT_BROADCAST_ID, `Emote` = @EMOTE_POINT
    WHERE `GroupID` = @TEXT_RENAULT_GROUP_ID AND `ID` = 0 AND `CreatureID` = @HIGHLORD_MOGRAINE_ID;

UPDATE `creature_text`
    SET `BroadcastTextId` = @TEXT_BETRAYAL_BROADCAST_ID, `Emote` = @EMOTE_TALK
    WHERE `GroupID` = @TEXT_BETRAYAL_GROUP_ID AND `ID` = 0 AND `CreatureID` = @HIGHLORD_MOGRAINE_ID;

UPDATE `creature_text`
    SET `BroadcastTextId` = @TEXT_FORGIVEN_BROADCAST_ID
    WHERE `GroupID` = @TEXT_FORGIVEN_GROUP_ID AND `ID` = 0 AND `CreatureID` = @HIGHLORD_MOGRAINE_ID;
