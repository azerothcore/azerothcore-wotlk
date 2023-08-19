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
SET @SAVE_THIS_WORLD_TEXT := 'Have you come to save this world? To cleanse it?';

SET @IT_BEGINS_ID := 1;
SET @IT_BEGINS_BROADCAST_ID := 12383;
SET @IT_BEGINS_TEXT := 'And so it begins...';

SET @ASHBRINGER_ID := 2;
SET @ASHBRINGER_BROADCAST_ID := 12378;
SET @ASHBRINGER_TEXT := 'Ashbringer...';

SET @KNEEL_BEFORE_ID := 3;
SET @KNEEL_BEFORE_BROADCAST_ID := 12379;
SET @KNEEL_BEFORE_TEXT := 'Kneel! Kneel before the Ashbringer!';

SET @INFIDELS_ID := 4;
SET @INFIDELS_BROADCAST_ID := 12382;
SET @INFIDELS_TEXT := 'My $g Lord:Lady;, please allow me to live long enough to see you purge this world of the infidels.';

SET @TAKE_ME_ID := 5;
SET @TAKE_ME_BROADCAST_ID := 12384;
SET @TAKE_ME_TEXT := 'Take me with you, $g sir:ma''am;.';

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
SET @UNWORTHY_TEXT := 'I am unworthy, $g sir:ma''am;.';

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
SET @MOGRAINE_BOW_DOWN_TEXT := 'Bow down! Kneel before the Ashbringer! A new dawn approaches, brothers and sisters! Our message will be delivered to the filth of this world through the chosen one!';

-- For reapplicability
DELETE FROM `creature_text`
    WHERE `GroupID` = 6 AND `ID` = 0 AND `CreatureID` = @MOGRAINE_ID;

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
     (@MOGRAINE_ID, 6, 0, @MOGRAINE_BOW_DOWN_TEXT, 14, 0, 100.0, 0, 0, 0, @MOGRAINE_BROADCAST_ID, 3,'Ashbringer event intro yell');

-- --
-- Commander Mograine's talk upon being approached by player

SET @MOGRAINE_APPROACH_BROADCAST_ID := 12390;
SET @MOGRAINE_APPROACH_TEXT := 'You hold my father''s blade, $n. My soldiers are yours to control, my $g Lord:Lady;. Take them... Lead them... The impure must be purged. They must be cleansed of their taint.';

UPDATE `creature_text`
    SET `Text` = @MOGRAINE_APPROACH_TEXT, `BroadcastTextId` = @MOGRAINE_APPROACH_BROADCAST_ID, `Emote` = 1
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
SET @TAINT_SCOURGE_BROADCAST_ID = 2625;
SET @TAINT_SCOURGE_TEXT = 'You carry the taint of the Scourge.  Prepare to enter the Twisting Nether.';

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
SET @NO_ESCAPE_BROADCAST_ID = 2626;
SET @NO_ESCAPE_TEXT = 'There is no escape for you.  The Crusade shall destroy all who carry the Scourge''s taint.';

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
SET @LIGHT_CONDEMNS_BROADCAST_ID = 2627;
SET @LIGHT_CONDEMNS_TEXT = 'The Light condemns all who harbor evil.  Now you will die!';

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
SET @SMITE_WICKED_BROADCAST_ID = 2628;
SET @SMITE_WICKED_TEXT = 'The Scarlet Crusade shall smite the wicked and drive evil from these lands!';

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
SET @MOGRAINE_UNWORTHY_TEXT = 'Unworthy.';

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

-- --
-- Move Commander Mograine's emote to creature_text and play the correct
-- emote (he used to kneel).

SET @EMOTE_BEG := 20;

SET @FORGIVE_ME_GROUP_ID := 5;
SET @FORGIVE_ME_BROADCAST_ID := 12472;

UPDATE `creature_text`
    SET `BroadcastTextId` = @FORGIVE_ME_BROADCAST_ID, `Emote` = @EMOTE_BEG
    WHERE `GroupID` = @FORGIVE_ME_GROUP_ID AND `ID` = 0 AND `CreatureID` = @MOGRAINE_ID;

SET @EMOTE_QUESTION := 6;

SET @BUT_HOW_GROUP_ID := 4;
SET @BUT_HOW_BROADCAST_ID := 12470;

UPDATE `creature_text`
    SET `BroadcastTextId` = @BUT_HOW_BROADCAST_ID, `Emote` = @EMOTE_QUESTION
    WHERE `GroupID` = @BUT_HOW_GROUP_ID AND `ID` = 0 AND `CreatureID` = @MOGRAINE_ID;

-- --
-- Use sniffed data for Fairbanks's gossip texts

-- 1
SET @CURSE_LIFTED_BROADCAST_ID := 12480;
SET @CURSE_LIFTED_TEXT := 'At last, the curse is lifted. Thank you, hero.';

UPDATE acore_world.npc_text
    SET text0_0=@CURSE_LIFTED_TEXT, BroadcastTextID0=@CURSE_LIFTED_BROADCAST_ID
    WHERE ID=100100;

-- 2
SET @YOU_DONT_KNOW_BROADCAST_ID := 12482;
SET @YOU_DONT_KNOW_TEXT := 'You mean, you don''t know? The sword that you carry on your back - it is known as Ashbringer; named after its original owner.';

UPDATE acore_world.npc_text
    SET text0_0=@YOU_DONT_KNOW_TEXT, BroadcastTextID0=@YOU_DONT_KNOW_BROADCAST_ID
    WHERE ID=100101;

-- 3
SET @AYE_HIGHLORD_BROADCAST_ID := 12484;
SET @AYE_HIGHLORD_TEXT := 'Aye, the Highlord Mograine: A founder of the original order of the Scarlet Crusade. A knight of unwavering faith and purity; Mograine would be betrayed by his own son and slain by Kel''Thuzad''s forces inside Stratholme. It is how I ended up here...';

UPDATE acore_world.npc_text
    SET text0_0=@AYE_HIGHLORD_TEXT, BroadcastTextID0=@AYE_HIGHLORD_BROADCAST_ID
    WHERE ID=100102;

-- 4
SET @CRUSADE_WAS_NOBLE_BROADCAST_ID := 12486;
SET @CRUSADE_WAS_NOBLE_TEXT := 'It was High General Abbendis, High Inquisitor Isillien, and Highlord Mograine that formed the Crusade. In its infancy, the Crusade was a noble order. The madness and insane zealotry that you see now did not exist. It was not until the one known as the Grand Crusader appeared that the wheels of corruption were set in motion.';

UPDATE acore_world.npc_text
    SET text0_0=@CRUSADE_WAS_NOBLE_TEXT, BroadcastTextID0=@CRUSADE_WAS_NOBLE_BROADCAST_ID
    WHERE ID=100103;

-- 5
SET @HIGHLORD_LYNCHPIN_BROADCAST_ID := 12488;
SET @HIGHLORD_LYNCHPIN_TEXT := 'The Highlord was the lynchpin of the Crusade. Aye, Mograine was called the Ashbringer because of his exploits versus the armies of the Lich King. With only blade and faith, Mograine would walk into whole battalions of undead and emerge unscathed - the ashes of his foes being the only indication that he had been there at all. Do you not understand? The very face of death feared him! It trembled in his presence!';

UPDATE acore_world.npc_text
    SET text0_0=@HIGHLORD_LYNCHPIN_TEXT, BroadcastTextID0=@HIGHLORD_LYNCHPIN_BROADCAST_ID
    WHERE ID=100104;

-- 6
SET @ONLY_WAY_BROADCAST_ID := 12490;
SET @ONLY_WAY_TEXT := 'The only way a hero can die, $r: Through tragedy. The Grand Crusader struck a deal with Kel''Thuzad himself! An ambush would be staged that would result in the death of Mograine. The type of betrayal that could only be a result of the actions of one''s most trusted and loved companions.';

UPDATE acore_world.npc_text
    SET text0_0=@ONLY_WAY_TEXT, BroadcastTextID0=@ONLY_WAY_BROADCAST_ID
    WHERE ID=100105;

-- 7
SET @FAIRBANKS_NODS_BROADCAST_ID := 12492;
SET @FAIRBANKS_NODS_TEXT := '<High Inquisitor Fairbanks nods.>$B$BAye, the lesser Mograine, the one known as the Scarlet Commander, through - what I suspect - the dealings of the Grand Crusader. He led his father to the ambush like a lamb to the slaughter.';

UPDATE acore_world.npc_text
    SET text0_0=@FAIRBANKS_NODS_TEXT, BroadcastTextID0=@FAIRBANKS_NODS_BROADCAST_ID
    WHERE ID=100106;

-- 8
SET @FAIRBANKS_TABARD_BROADCAST_ID := 12494;
SET @FAIRBANKS_TABARD_TEXT := '<High Inquisitor Fairbanks lifts up his tabard revealing several gruesome scars.>$B$BBecause I was there... I was the Highlord''s most trusted advisor. I should have known... I felt that something was amiss yet I allowed it to happen. Would you believe that there were a thousand or more Scourge?';

UPDATE acore_world.npc_text
    SET text0_0=@FAIRBANKS_TABARD_TEXT, BroadcastTextID0=@FAIRBANKS_TABARD_BROADCAST_ID
    WHERE ID=100107;

-- 9
SET @ASHBRINGER_FOOL_BROADCAST_ID := 12496;
SET @ASHBRINGER_FOOL_TEXT := 'This was the Ashbringer, fool! As the Scourge began to materialize around us, Mograine''s blade began to glow... to hum... the younger Mograine would take that as a sign to make his escape. They descended upon us with a hunger the likes of which I had never seen. Yet...';

UPDATE acore_world.npc_text
    SET text0_0=@ASHBRINGER_FOOL_TEXT, BroadcastTextID0=@ASHBRINGER_FOOL_BROADCAST_ID
    WHERE ID=100108;

-- 10
SET @NOT_ENOUGH_BROADCAST_ID := 12498;
SET @NOT_ENOUGH_TEXT := 'It was not enough.$B$B<Fairbanks smirks briefly, lost in a memory.>$B$BA thousand came and a thousand died. By the Light! By the might of Mograine! He would smite them down as fast as they could come. Through the chaos, I noticed that the lesser Mograine was still there, off in the distance. I called to him, "Help us, Renault! Help your father, boy!"';

UPDATE acore_world.npc_text
    SET text0_0=@NOT_ENOUGH_TEXT, BroadcastTextID0=@NOT_ENOUGH_BROADCAST_ID
    WHERE ID=100109;

-- 11
SET @FAIRBANKS_SHAKES_HEAD_BROADCAST_ID := 12500;
SET @FAIRBANKS_SHAKES_HEAD_TEXT := '<High Inquisitor Fairbanks shakes his head.>$B$BNo... He stood in the background, watching as the legion of undead descended upon us. Soon after, my powers were exhausted. I was the first to fall... Surely they would tear me limb from limb as I lay there unconscious; but they ignored me completely, focusing all of their attention on the Highlord. ';

UPDATE acore_world.npc_text
    SET text0_0=@FAIRBANKS_SHAKES_HEAD_TEXT, BroadcastTextID0=@FAIRBANKS_SHAKES_HEAD_BROADCAST_ID
    WHERE ID=100110;

-- 12
SET @FEIGN_DEATH_BROADCAST_ID := 12502;
SET @FEIGN_DEATH_TEXT := 'It was all I could do to feign death as the corpses of the Scourge piled upon me. There was darkness and only the muffled sounds of the battle above me. The clashing of iron, the gnashing and grinding... gruesome, terrible sounds. And then there was silence. He called to me! "Fairbanks! Fairbanks where are you? Talk to me Fairbanks!" And then came the sound of incredulousness. The bite of betrayal, $r...';

UPDATE acore_world.npc_text
    SET text0_0=@FEIGN_DEATH_TEXT, BroadcastTextID0=@FEIGN_DEATH_BROADCAST_ID
    WHERE ID=100111;

-- 13
SET @BOY_PICKED_UP_BROADCAST_ID := 12504;
SET @BOY_PICKED_UP_TEXT := 'The boy had picked up the Ashbringer and driven it through his father''s heart as his back was turned. His last words will haunt me forever: "What have you done, Renault? Why would you do this?"';

UPDATE acore_world.npc_text
    SET text0_0=@BOY_PICKED_UP_TEXT, BroadcastTextID0=@BOY_PICKED_UP_BROADCAST_ID
    WHERE ID=100112;

-- 14
SET @BLADE_AND_MOGRAINE_BROADCAST_ID := 12506;
SET @BLADE_AND_MOGRAINE_TEXT := 'The blade and Mograine were a singular entity. Do you understand? This act corrupted the blade and lead to Mograine''s own corruption as a death knight of Kel''Thuzad. I swore that if I lived, I would expose the perpetrators of this heinous crime. For two days I remained under the rot and contagion of Scourge - gathering as much strength as possible to escape the razed city.\n';

UPDATE acore_world.npc_text
    SET text0_0=@BLADE_AND_MOGRAINE_TEXT, BroadcastTextID0=@BLADE_AND_MOGRAINE_BROADCAST_ID
    WHERE ID=100113;

-- 15
SET @DISMAY_LESSER_BROADCAST_ID := 12508;
SET @DISMAY_LESSER_TEXT := 'Aye, I did. Much to the dismay of the lesser Mograine, I made my way back to the Scarlet Monastery. I shouted and screamed. I told the tale to any that would listen. And I would be murdered in cold blood for my actions, dragged to this chamber - the dark secret of the order. But some did listen... some heard my words. Thus was born the Argent Dawn...';

UPDATE acore_world.npc_text
    SET text0_0=@DISMAY_LESSER_TEXT, BroadcastTextID0=@DISMAY_LESSER_BROADCAST_ID
    WHERE ID=100114;

-- 16
SET @BLADE_BEYOND_SAVING_BROADCAST_ID := 12510;
SET @BLADE_BEYOND_SAVING_TEXT := 'I''m afraid that the blade which you hold in your hands is beyond saving. The hatred runs too deep. But do not lose hope, $c. Where one chapter has ended, a new one begins.$B$BFind his son - a more devout and pious man you may never meet. It is rumored that he is able to build the Ashbringer anew, without requiring the old, tainted blade.';

UPDATE acore_world.npc_text
    SET text0_0=@BLADE_BEYOND_SAVING_TEXT, BroadcastTextID0=@BLADE_BEYOND_SAVING_BROADCAST_ID
    WHERE ID=100115;

-- 17
SET @THE_OTHER_LIVES_BROADCAST_ID := 12512;
SET @THE_OTHER_LIVES_TEXT := '<High Inquisitor Fairbanks shakes his head.>$B$BNo, $r; only one of his sons is dead. The other lives...$B$B<High Inquisitor Fairbanks points to the sky.>$B$BThe Outland... Find him there... ';

UPDATE acore_world.npc_text
    SET text0_0=@THE_OTHER_LIVES_TEXT, BroadcastTextID0=@THE_OTHER_LIVES_BROADCAST_ID
    WHERE ID=100116;


-- --
-- Player gossip options when talking to Fairbanks

-- 1
SET @WHATS_GOING_ON_MENU_ID := 5873;
SET @WHATS_GOING_ON_BROADCAST_ID := 12481;
SET @WHATS_GOING_ON_TEXT := 'Curse? What''s going on here, Fairbanks?';

DELETE FROM `gossip_menu_option`
    WHERE `MenuID` = @WHATS_GOING_ON_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
     (@WHATS_GOING_ON_MENU_ID,0,0,@WHATS_GOING_ON_TEXT,@WHATS_GOING_ON_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 2
SET @MOGRAINE_QUESTION_GOSSIP_MENU_ID := 5874;
SET @MOGRAINE_QUESTION_GOSSIP_BROADCAST_ID := 12483;
SET @MOGRAINE_QUESTION_GOSSIP_TEXT := 'Mograine?';

DELETE FROM `gossip_menu_option`
    WHERE `MenuID` = @MOGRAINE_QUESTION_GOSSIP_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
     (@MOGRAINE_QUESTION_GOSSIP_MENU_ID,0,0,@MOGRAINE_QUESTION_GOSSIP_TEXT,@MOGRAINE_QUESTION_GOSSIP_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 3
SET @WDYM_MENU_ID := 5875;
SET @WDYM_BROADCAST_ID := 12485;
SET @WDYM_TEXT := 'What do you mean?';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @WDYM_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@WDYM_MENU_ID,0,0,@WDYM_TEXT,@WDYM_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 4
SET @DONT_UNDERSTAND_MENU_ID := 5876;
SET @DONT_UNDERSTAND_BROADCAST_ID := 12487;
SET @DONT_UNDERSTAND_TEXT := 'I still do not fully understand.';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @DONT_UNDERSTAND_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@DONT_UNDERSTAND_MENU_ID,0,0,@DONT_UNDERSTAND_TEXT,@DONT_UNDERSTAND_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 5
SET @INCREDIBLE_STORY_MENU_ID := 5877;
SET @INCREDIBLE_STORY_BROADCAST_ID := 12489;
SET @INCREDIBLE_STORY_TEXT := 'Incredible story. So how did he die?';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @INCREDIBLE_STORY_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@INCREDIBLE_STORY_MENU_ID,0,0,@INCREDIBLE_STORY_TEXT,@INCREDIBLE_STORY_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 6
SET @YOU_MEAN_MENU_ID := 5878;
SET @YOU_MEAN_BROADCAST_ID := 12491;
SET @YOU_MEAN_TEXT := 'You mean...';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @YOU_MEAN_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@YOU_MEAN_MENU_ID,0,0,@YOU_MEAN_TEXT,@YOU_MEAN_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 7
SET @HOW_DO_YOU_KNOW_MENU_ID := 5879;
SET @HOW_DO_YOU_KNOW_BROADCAST_ID := 12493;
SET @HOW_DO_YOU_KNOW_TEXT := 'How do you know all of this?';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @HOW_DO_YOU_KNOW_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@HOW_DO_YOU_KNOW_MENU_ID,0,0,@HOW_DO_YOU_KNOW_TEXT,@HOW_DO_YOU_KNOW_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 8
SET @A_THOUSAND_MENU_ID := 5880;
SET @A_THOUSAND_BROADCAST_ID := 12495;
SET @A_THOUSAND_TEXT := 'A thousand? For one man?';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @A_THOUSAND_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@A_THOUSAND_MENU_ID,0,0,@A_THOUSAND_TEXT,@A_THOUSAND_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 9
SET @YET_WHAT_MENU_ID := 5881;
SET @YET_WHAT_BROADCAST_ID := 12497;
SET @YET_WHAT_TEXT := 'Yet? Yet what??';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @YET_WHAT_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@YET_WHAT_MENU_ID,0,0,@YET_WHAT_TEXT,@YET_WHAT_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 10
SET @DID_HE_MENU_ID := 5882;
SET @DID_HE_BROADCAST_ID := 12499;
SET @DID_HE_TEXT := 'And did he?';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @DID_HE_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@DID_HE_MENU_ID,0,0,@DID_HE_TEXT,@DID_HE_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 11
SET @CONTINUE_PLEASE_MENU_ID := 5883;
SET @CONTINUE_PLEASE_BROADCAST_ID := 12501;
SET @CONTINUE_PLEASE_TEXT := 'Continue please, Fairbanks.';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @CONTINUE_PLEASE_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@CONTINUE_PLEASE_MENU_ID,0,0,@CONTINUE_PLEASE_TEXT,@CONTINUE_PLEASE_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 12
SET @YOU_MEAN_MENU_ID := 5884;
SET @YOU_MEAN_BROADCAST_ID := 12503;
SET @YOU_MEAN_TEXT := 'You mean...';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @YOU_MEAN_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@YOU_MEAN_MENU_ID,0,0,@YOU_MEAN_TEXT,@YOU_MEAN_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 13
SET @YOU_WERE_RIGHT_MENU_ID := 5885;
SET @YOU_WERE_RIGHT_BROADCAST_ID := 12505;
SET @YOU_WERE_RIGHT_TEXT := 'You were right, Fairbanks. That is tragic.';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @YOU_WERE_RIGHT_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@YOU_WERE_RIGHT_MENU_ID,0,0,@YOU_WERE_RIGHT_TEXT,@YOU_WERE_RIGHT_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 14
SET @AND_YOU_DID_MENU_ID := 5886;
SET @AND_YOU_DID_BROADCAST_ID := 12507;
SET @AND_YOU_DID_TEXT := 'And you did...';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @AND_YOU_DID_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@AND_YOU_DID_MENU_ID,0,0,@AND_YOU_DID_TEXT,@AND_YOU_DID_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 15
SET @BLADE_REDEMPTION_MENU_ID := 5887;
SET @BLADE_REDEMPTION_BROADCAST_ID := 12509;
SET @BLADE_REDEMPTION_TEXT := 'You tell an incredible tale, Fairbanks. What of the blade? Is it beyond redemption?';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @BLADE_REDEMPTION_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@BLADE_REDEMPTION_MENU_ID,0,0,@BLADE_REDEMPTION_TEXT,@BLADE_REDEMPTION_BROADCAST_ID,1,1,0,0,0,0,'',0,0);

-- 16
SET @BUT_SON_DEAD_MENU_ID := 5888;
SET @BUT_SON_DEAD_BROADCAST_ID := 12511;
SET @BUT_SON_DEAD_TEXT := 'But his son is dead.';

DELETE FROM `gossip_menu_option`
   WHERE `MenuID` = @BUT_SON_DEAD_MENU_ID AND `OptionID` = 0;

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
    (@BUT_SON_DEAD_MENU_ID,0,0,@BUT_SON_DEAD_TEXT,@BUT_SON_DEAD_BROADCAST_ID,1,1,0,0,0,0,'',0,0);
