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
