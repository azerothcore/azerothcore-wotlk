-- DB update 2026_03_28_03 -> 2026_03_29_00
-- Move gossip handling from C++ scripts to database for Augustus the Touched,
-- Parqual Fintallas, and Lokhtos Darkbargainer.
-- Augustus migration based on TC work by dr-j (commit cefed89c38bc)
-- Parqual migration based on TC work by offl (issue #24993, commit 7908b00311)

-- =============================================================================
-- 1. Augustus the Touched (entry 12384)
--    Conditional vendor option if quest 6164 (Augustus' Receipt Book) rewarded.
--    Two gossip texts: 4979 before quest, 4980 after quest.
-- =============================================================================

-- Remove C++ ScriptName
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 12384;

-- Add gossip_menu entry for post-quest text 4980
DELETE FROM `gossip_menu` WHERE `MenuID` = 4085 AND `TextID` = 4980;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (4085, 4980);

-- Conditions on gossip_menu text: 4979 before quest, 4980 after quest
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 4085 AND `SourceEntry` IN (4979, 4980);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 4085, 4979, 0, 0, 8, 0, 6164, 0, 0, 1, 0, 0, '', 'Augustus the Touched - Show text 4979 if quest 6164 NOT rewarded'),
(14, 4085, 4980, 0, 0, 8, 0, 6164, 0, 0, 0, 0, 0, '', 'Augustus the Touched - Show text 4980 if quest 6164 rewarded');

-- Condition: show vendor option (MenuID 4085, OptionID 0) only if quest 6164 rewarded
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 4085 AND `SourceEntry` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 4085, 0, 0, 0, 8, 0, 6164, 0, 0, 0, 0, 0, '', 'Augustus the Touched - Show vendor option only if quest 6164 rewarded');

-- =============================================================================
-- 2. Parqual Fintallas (entry 4488)
--    Test of Lore quiz: 4 answers, wrong ones cast Shame, correct completes quest.
-- =============================================================================

-- Remove C++ ScriptName, set SmartAI
UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` = 4488;

-- Add gossip_menu entry for quiz text (5822) shown during quiz
DELETE FROM `gossip_menu` WHERE `MenuID` = 4764 AND `TextID` = 5822;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (4764, 5822);

-- Condition on gossip_menu text 5822: quest 6628 taken + no Shame aura
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 4764 AND `SourceEntry` = 5822;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 4764, 5822, 0, 0, 9, 0, 6628, 0, 0, 0, 0, 0, '', 'Parqual Fintallas - Show quiz text 5822 if quest 6628 taken'),
(14, 4764, 5822, 0, 0, 1, 0, 6767, 0, 0, 1, 0, 0, '', 'Parqual Fintallas - Show quiz text 5822 if player does not have Mark of Shame aura');

-- Conditions on quiz options 0, 1, 2, 3: quest 6628 taken + no Shame aura
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 4764 AND `SourceEntry` IN (0, 1, 2, 3);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Option 0: Kel'Thuzad (wrong answer)
(15, 4764, 0, 0, 0, 9, 0, 6628, 0, 0, 0, 0, 0, '', 'Parqual Fintallas - Show option 0 if quest 6628 taken'),
(15, 4764, 0, 0, 0, 1, 0, 6767, 0, 0, 1, 0, 0, '', 'Parqual Fintallas - Show option 0 if no Mark of Shame aura'),
-- Option 1: Gul'dan (wrong answer)
(15, 4764, 1, 0, 0, 9, 0, 6628, 0, 0, 0, 0, 0, '', 'Parqual Fintallas - Show option 1 if quest 6628 taken'),
(15, 4764, 1, 0, 0, 1, 0, 6767, 0, 0, 1, 0, 0, '', 'Parqual Fintallas - Show option 1 if no Mark of Shame aura'),
-- Option 2: Kil'jaeden (wrong answer)
(15, 4764, 2, 0, 0, 9, 0, 6628, 0, 0, 0, 0, 0, '', 'Parqual Fintallas - Show option 2 if quest 6628 taken'),
(15, 4764, 2, 0, 0, 1, 0, 6767, 0, 0, 1, 0, 0, '', 'Parqual Fintallas - Show option 2 if no Mark of Shame aura'),
-- Option 3: Ner'zhul (correct answer)
(15, 4764, 3, 0, 0, 9, 0, 6628, 0, 0, 0, 0, 0, '', 'Parqual Fintallas - Show option 3 if quest 6628 taken'),
(15, 4764, 3, 0, 0, 1, 0, 6767, 0, 0, 1, 0, 0, '', 'Parqual Fintallas - Show option 3 if no Mark of Shame aura');

-- SAI for Parqual Fintallas
DELETE FROM `smart_scripts` WHERE `entryorguid` = 4488 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Option 0 (Kel'Thuzad - wrong): close gossip, then cast Mark of Shame
(4488, 0, 0, 1, 62, 0, 100, 0, 4764, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Parqual Fintallas - On Gossip Select 0 (Kel''Thuzad) - Close Gossip'),
(4488, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 6767, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Parqual Fintallas - Linked - Cast Mark of Shame on Invoker'),
-- Option 1 (Gul'dan - wrong): close gossip, then cast Mark of Shame
(4488, 0, 2, 3, 62, 0, 100, 0, 4764, 1, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Parqual Fintallas - On Gossip Select 1 (Gul''dan) - Close Gossip'),
(4488, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 6767, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Parqual Fintallas - Linked - Cast Mark of Shame on Invoker'),
-- Option 2 (Kil'jaeden - wrong): close gossip, then cast Mark of Shame
(4488, 0, 4, 5, 62, 0, 100, 0, 4764, 2, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Parqual Fintallas - On Gossip Select 2 (Kil''jaeden) - Close Gossip'),
(4488, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 6767, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Parqual Fintallas - Linked - Cast Mark of Shame on Invoker'),
-- Option 3 (Ner'zhul - correct): close gossip, then credit quest 6628
(4488, 0, 6, 7, 62, 0, 100, 0, 4764, 3, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Parqual Fintallas - On Gossip Select 3 (Ner''zhul) - Close Gossip'),
(4488, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 6628, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Parqual Fintallas - Linked - Area Explored Or Event Happens Quest 6628');

-- =============================================================================
-- 3. Lokhtos Darkbargainer (entry 12944)
--    Rep-gated vendor + conditional Thorium Brotherhood contract creation.
-- =============================================================================

-- Remove C++ ScriptName, set SmartAI
UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` = 12944;

-- Replace gossip_menu text: remove default 5834, add rep-conditional texts 3673/3677
DELETE FROM `gossip_menu` WHERE `MenuID` = 4781 AND `TextID` IN (5834, 3673, 3677);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(4781, 3673),
(4781, 3677);

-- Conditions on gossip_menu text: 3673 below Friendly, 3677 at Friendly+
-- Friendly(4)=16, Honored(5)=32, Revered(6)=64, Exalted(7)=128 => mask 240
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 4781 AND `SourceEntry` IN (3673, 3677);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 4781, 3673, 0, 0, 5, 0, 59, 240, 0, 1, 0, 0, '', 'Lokhtos Darkbargainer - Show text 3673 if Thorium Brotherhood rep < Friendly'),
(14, 4781, 3677, 0, 0, 5, 0, 59, 240, 0, 0, 0, 0, '', 'Lokhtos Darkbargainer - Show text 3677 if Thorium Brotherhood rep >= Friendly');

-- Condition on vendor option (MenuID 4781, OptionID 0): rep >= Friendly
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 4781 AND `SourceEntry` IN (0, 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Option 0 (vendor): requires Friendly rep
(15, 4781, 0, 0, 0, 5, 0, 59, 240, 0, 0, 0, 0, '', 'Lokhtos Darkbargainer - Show vendor option if Thorium Brotherhood rep >= Friendly'),
-- Option 1 (contract): requires quest 7604 NOT rewarded + no item 18628 (incl. bank) + has item 17203
(15, 4781, 1, 0, 0, 8, 0, 7604, 0, 0, 1, 0, 0, '', 'Lokhtos Darkbargainer - Show contract option if quest 7604 NOT rewarded'),
(15, 4781, 1, 0, 0, 2, 0, 18628, 1, 1, 1, 0, 0, '', 'Lokhtos Darkbargainer - Show contract option if player does NOT have Thorium Brotherhood Contract'),
(15, 4781, 1, 0, 0, 2, 0, 17203, 1, 0, 0, 0, 0, '', 'Lokhtos Darkbargainer - Show contract option if player has Sulfuron Ingot');

-- SAI for Lokhtos Darkbargainer: contract spell on gossip select option 1
DELETE FROM `smart_scripts` WHERE `entryorguid` = 12944 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Option 1 (Get contract): close gossip, then invoker casts contract creation spell
(12944, 0, 0, 1, 62, 0, 100, 0, 4781, 1, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lokhtos Darkbargainer - On Gossip Select 1 (Contract) - Close Gossip'),
(12944, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 23059, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lokhtos Darkbargainer - Linked - Invoker Cast Create Thorium Brotherhood Contract');
