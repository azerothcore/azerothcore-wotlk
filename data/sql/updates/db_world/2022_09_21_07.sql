-- DB update 2022_09_21_06 -> 2022_09_21_07
SET @VAELASTRASZ_UBRS     := 10538;
SET @VAELASTRASZ_THE_RED  := 10340;
SET @NEFARIUS             := 10162;
SET @CALL_OF_VAELASTRASZ  := 16349;
SET @CHROMATIC_PROTECTION := 16372;
-- Add missing creature text: Vaelastrasz The Red, Vaelastrasz, Nefarius
DELETE FROM `creature_text` WHERE `CreatureID` = @VAELASTRASZ_THE_RED AND `GroupID` IN (0,1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(@VAELASTRASZ_THE_RED, 0, 0, 'All is not lost! Battle these beasts without fear. Your wounds I shall heal, bones I shall mend. Be renewed, heroes!', 14, 0, 100.0, 5, 0, 0, 5748, 0, 'Vaelastrasz the Red'),
(@VAELASTRASZ_THE_RED, 1, 0, 'You have come too far to fail. Stand back, mortals.',                                                                  14, 0, 100.0, 5, 0, 0, 5760, 0, 'Vaelastrasz the Red');
DELETE FROM `creature_text` WHERE `CreatureID` = @VAELASTRASZ_UBRS AND `GroupID` IN (0,1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(@VAELASTRASZ_UBRS, 0, 0, 'You will suffer in this defeat, Nefarian!',                                  14, 0, 100.0, 5, 0, 0, 5761, 0, 'Vaelastrasz'),
(@VAELASTRASZ_UBRS, 1, 0, 'You merely destroy an image, fool. I shall hunt you until the end of days.', 14, 0, 100.0, 5, 0, 0, 5778, 0, 'Vaelastrasz');
DELETE FROM `creature_text` WHERE `CreatureID` = @NEFARIUS AND `GroupID` IN (15,16,17);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(@NEFARIUS, 15, 0, 'Enough! Playtime is over!',                                                                 14, 0, 100.0, 22, 0, 0, 5596, 0, 'Lord Victor Nefarius (UBRS)'),
(@NEFARIUS, 16, 0, 'Vaelastrasz, when this world belongs to the black flight, your flight shall know its end.', 14, 0, 100.0, 22, 0, 0, 5776, 0, 'Lord Victor Nefarius (UBRS)'),
(@NEFARIUS, 17, 0, 'But for now, your death will have to suffice...',                                           14, 0, 100.0, 0,  0, 0, 5777, 0, 'Lord Victor Nefarius (UBRS)');

-- Handle Seal of Ascension and passive aura proc Chromatic Protection with script
DELETE FROM `event_scripts` WHERE `id`=4622;
DELETE FROM `spell_script_names` WHERE `spell_id` IN (@CALL_OF_VAELASTRASZ, @CHROMATIC_PROTECTION);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES
(@CALL_OF_VAELASTRASZ, 'spell_blackrock_spire_call_of_vaelastrasz'),
(@CHROMATIC_PROTECTION, 'spell_gyth_chromatic_protection');

-- Ring of Ascension only usable when inside Blackrock Spire AND Rend event started
-- Show error message "SPELL_FAILED_INCORRECT_AREA" when not in BRS
-- Show no error when trying to use the ring when not doing Rend event
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = @CALL_OF_VAELASTRASZ);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(17, 0, @CALL_OF_VAELASTRASZ, 0, 0, 4,  0, 1583, 0, 0, 0, 39,  0, '', 'Ring of Ascension on-use-effect only if inside Blackrock Spire'),
(17, 0, @CALL_OF_VAELASTRASZ, 0, 0, 13, 0, 10,   1, 2, 0, 172, 0, '', 'Ring of Ascension on-use-effect only if boss state 10 (Rend) is IN_PROGRESS.'),
(17, 0, @CALL_OF_VAELASTRASZ, 0, 0, 13, 0, 25,   0, 0, 0, 172, 0, '', 'Ring of Ascension on-use-effect only if boss state 25 (Vaelastrasz) is NOT_STARTED.');

-- Set ScriptName Vaelastrasz the Red
UPDATE `creature_template` SET `ScriptName`='npc_vaelastrasz_the_red' WHERE `entry` = @VAELASTRASZ_THE_RED;

-- Chromatic Protection
-- PROC_EX_NORMAL_HIT 	1 	0x0000001
-- PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG 	131072 	0x00020000 	Taken negative spell that has dmg class magic
DELETE FROM `spell_proc_event` WHERE `entry` = @CHROMATIC_PROTECTION;
INSERT INTO `spell_proc_event`
(`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`)
VALUES
(@CHROMATIC_PROTECTION, 0, 0, 0, 0, 0, 131072, 1, 0, 0.0, 100.0, 0);

-- Allow corruption to be cast on Vaelastrasz
-- Update comment to specify Vaelastrasz the Corrupt (BWL)
SET @CORRUPTION:= 23642;
UPDATE `conditions` SET `Comment` = 'Nefarius Corruption only affects Vaelastrasz the Corrupt'
WHERE (`SourceTypeOrReferenceId` = 17) AND
(`SourceGroup` = 0) AND (`SourceEntry` = @CORRUPTION) AND (`SourceId` = 0) AND
(`ElseGroup` = 0);
-- Add ElseGroup to also allow corruption to cast on Vaelastrasz (UBRS)
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND
(`SourceGroup` = 0) AND (`SourceEntry` = @CORRUPTION) AND (`SourceId` = 0) AND
(`ElseGroup` = 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(17, 0, @CORRUPTION, 0, 1, 31, 1, 3, 10538, 0, 0, 0, 0, '', 'Nefarius Corruption only affects Vaelastrasz');

-- Vaelastrasz the Red, Vaelastrasz
-- Update mechanic immune mask, same as Vaelastrasz the Corrupt
-- Update flags_extra to 1073742080 IMMUNITY_KNOCKBACK - creature is immune to knockback effects
-- Immune to PC interaction (256) and NPC interaction (512)
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854239, `unit_flags` = 256|512, `type_flags` = 0, `flags_extra` = 1073741824 WHERE `entry` IN (@VAELASTRASZ_THE_RED, @VAELASTRASZ_UBRS);
