-- DB update 2020_03_04_00 -> 2020_03_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_03_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_03_04_00 2020_03_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1581083846978148700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1581083846978148700');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceGroup`=0 AND `SourceEntry`=43732;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,43732,0,0,31,1,3,24396,0,0,0,0,"","Remove Amani Curse - should only be usable on Forest Frog"),
(17,0,43732,0,0,36,1,0,0,0,0,0,0,"","use only one item per target (Forest Frog)");

DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 24407);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(24407, 1, 0, 12745, 0, 0);
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 24406);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(24406, 1, 0, 12745, 0, 0);

DELETE FROM `gameobject` WHERE (`id` = 187359);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(20584, 187359, 568, 0, 0, 1, 1, 134.009, 1642.8, 42.0841, 3.14159, 0, 0, -1, 0, 25, 255, 1, '', 0);

-- add restriction for Amani Charm buffs
DELETE FROM `spell_area` WHERE `area`= 3805 AND `spell` IN (43822,43816,43820,43818);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(43822, 3805, 0, 0, 0, 0, 0, 0, 0, 0), -- Charm of the Raging Defender
(43816, 3805, 0, 0, 0, 0, 0, 0, 0, 0), -- Charm of the Bloodletter
(43820, 3805, 0, 0, 0, 0, 0, 0, 0, 0), -- Charm of the Witch Doctor
(43818, 3805, 0, 0, 0, 0, 0, 0, 0, 0); -- Charm of Mighty Mojo

-- Money Bag
UPDATE `gameobject_template_addon` SET `mingold` = 11*100*100, `maxgold` = 19*100*100 WHERE (`entry` = 186736); -- approximately 11 - 19 gold?

-- Mannuth https://wow.gamepedia.com/Mawago
SET @ENTRY := 24397;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Greetings, kind stranger, and thank you for your selfless act.', 12, 0, 100, 1, 0, 0, 23346, 0, 'SAY_MANNUTH_0'),
(@ENTRY, 1, 0, 'These heathens have robbed me of my belongings, but I can offer you this charm I took from my captors.', 12, 0, 100, 1, 0, 0, 23347, 0, 'SAY_MANNUTH_1'),
(@ENTRY, 2, 0, 'May it serve you well, $n.', 12, 0, 100, 1, 0, 0, 23369, 0, 'SAY_MANNUTH_2'),
(@ENTRY, 3, 0, 'Farewell.', 12, 0, 100, 1, 0, 0, 23348, 0, 'SAY_MANNUTH_3');

-- Deez https://wow.gamepedia.com/Kaldrick
SET @ENTRY := 24403;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Hmm, thank you stranger.', 12, 0, 100, 1, 0, 0, 23373, 0, 'SAY_DEEZ_0'),
(@ENTRY, 1, 0, 'I fear I have nothing but this old chest I discovered here. You\'re welcome to it.', 12, 0, 100, 1, 0, 0, 23374, 0, 'SAY_DEEZ_1'),
(@ENTRY, 2, 0, 'I hope you find its contents... useful.', 12, 0, 100, 1, 0, 0, 23375, 0, 'SAY_DEEZ_2'),
(@ENTRY, 3, 0, 'Until we next meet....', 12, 0, 100, 1, 0, 0, 23376, 0, 'SAY_DEEZ_3');

-- Galathryn https://wow.gamepedia.com/Melasong
SET @ENTRY := 24404;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Oooh! It\'s about time someone rescued me....', 12, 0, 100, 1, 0, 0, 23379, 0, 'SAY_GALATHRYN_0'),
(@ENTRY, 1, 0, 'I suppose I should be grateful. Please, take this. I want nothing to remind me of this place.', 12, 0, 100, 1, 0, 0, 23380, 0, 'SAY_GALATHRYN_1'),
(@ENTRY, 2, 0, 'I took it from one of these trolls as I was captured. Maybe you can find a way to use it against them.', 12, 0, 100, 1, 0, 0, 23381, 0, 'SAY_GALATHRYN_2'),
(@ENTRY, 3, 0, 'I\'ve had quite enough of this place. Goodbye.', 12, 0, 100, 1, 0, 0, 23382, 0, 'SAY_GALATHRYN_3');

-- Adarrah https://wow.gamepedia.com/Melissa
SET @ENTRY := 24405;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Thank you!', 12, 0, 100, 17, 0, 0, 37237, 0, 'Adarrah'), -- is registered with DB
(@ENTRY, 1, 1, 'Ahhh, finally!', 12, 0, 100, 1, 0, 0, 23383, 0, 'SAY_ADARRAH_0'),
(@ENTRY, 2, 1, 'Say, I found this charm just before they caught me. Maybe it\'ll do you some good here....', 12, 0, 100, 1, 0, 0, 23384, 0, 'SAY_ADARRAH_1'),
(@ENTRY, 3, 1, 'I hope it helps. These vile beasts simply must be stopped!', 12, 0, 100, 1, 0, 0, 23385, 0, 'SAY_ADARRAH_2'),
(@ENTRY, 4, 1, 'Good luck to you!', 12, 0, 100, 1, 0, 0, 23386, 0, 'SAY_ADARRAH_3');

-- Darwen https://wow.gamepedia.com/Arinoth
SET @ENTRY := 24407;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Well, now. What a pleasant turn of events.', 12, 0, 100, 1, 0, 0, 23387, 0, 'SAY_DARWEN_0'),
(@ENTRY, 1, 0, 'It\'s most fortunate for you that you rescued me, and not one of these other poor sots.', 12, 0, 100, 1, 0, 0, 23388, 0, 'SAY_DARWEN_1'),
(@ENTRY, 2, 0, 'Please accept my payment, as well as my gratitude, for your trouble.', 12, 0, 100, 1, 0, 0, 23389, 0, 'SAY_DARWEN_2'),
(@ENTRY, 3, 0, 'Be well, $n.', 12, 0, 100, 1, 0, 0, 23390, 0, 'SAY_DARWEN_3');

-- Fudgerick https://wow.gamepedia.com/Lenzo
SET @ENTRY := 24406;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Woohoo! I\'m saved! I thank you, $n.', 12, 0, 100, 1, 0, 0, 23391, 0, 'SAY_FUDGERICK_0'),
(@ENTRY, 1, 0, 'Oh, my. What IS that smell - oh wait, heh, whoops! Guess my senses will take a little time to get readjusted.', 12, 0, 100, 1, 0, 0, 23392, 0, 'SAY_FUDGERICK_1'),
(@ENTRY, 2, 0, 'My apologies, friends. Here, now. This should help to cover the expenses involved in my rescue.', 12, 0, 100, 1, 0, 0, 23393, 0, 'SAY_FUDGERICK_2'),
(@ENTRY, 3, 0, 'See ya later!', 12, 0, 100, 1, 0, 0, 23394, 0, 'SAY_FUDGERICK_3');

-- Gunter Food Vendor https://wow.gamepedia.com/Harald
SET @ENTRY := 24408;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Oh, can it be? I... I\'m free of that hideous curse?', 12, 0, 100, 1, 0, 0, 23401, 0, 'SAY_GUNTER_0'),
(@ENTRY, 1, 0, 'Words cannot express my gratitude, $n. Thank you for your kindness.', 12, 0, 100, 1, 0, 0, 23402, 0, 'SAY_GUNTER_1'),
(@ENTRY, 2, 0, 'As you can see, I have but little after these savages got hold of me, but you\'re welcome to what I have. Come, have a look.', 12, 0, 100, 1, 0, 0, 23403, 0, 'SAY_GUNTER_2');

-- Kyren Reagents https://wow.gamepedia.com/Eulinda
SET @ENTRY := 24409;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Mmmm, flies! Even better now that I can taste them.', 12, 0, 100, 1, 0, 0, 23405, 0, 'SAY_KYREN_0'),
(@ENTRY, 1, 0, 'Nice to be back among the unliving, thanks to you.', 12, 0, 100, 1, 0, 0, 23406, 0, 'SAY_KYREN_1'),
(@ENTRY, 2, 0, 'Perhaps I am able to offer something of interest to you? Come, see if there\'s anything you like.', 12, 0, 100, 1, 0, 0, 23407, 0, 'SAY_KYREN_2');

-- Mitzi https://wow.gamepedia.com/Rosa
SET @ENTRY := 24445;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Weee! I\'m a girl again!', 12, 0, 100, 1, 0, 0, 23411, 0, 'SAY_MITZI_0'),
(@ENTRY, 1, 0, 'Thank you for rescuing me. I simply hate being a yucky frog!', 12, 0, 100, 1, 0, 0, 23412, 0, 'SAY_MITZI_1'),
(@ENTRY, 2, 0, 'I\'m really not supposed to talk to strangers, but you\'ve been so nice to me. Here\'s a special something I found just before I was kidnapped.', 12, 0, 100, 1, 0, 0, 23413, 0, 'SAY_MITZI_2'),
(@ENTRY, 3, 0, 'I should go now. Be careful!', 12, 0, 100, 1, 0, 0, 23414, 0, 'SAY_MITZI_3');

-- Christian https://wow.gamepedia.com/Micah
SET @ENTRY := 24448;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Aww, nuts! You\'ve ruined everything!', 12, 0, 100, 1, 0, 0, 23417, 0, 'SAY_CHRISTIAN_0'),
(@ENTRY, 1, 0, 'Do you have any idea how neat it is to hop that far?', 12, 0, 100, 1, 0, 0, 23418, 0, 'SAY_CHRISTIAN_1'),
(@ENTRY, 2, 0, 'Oh well, I was starting to miss my pals anyway - they\'re not gunna believe this! Oh, here - you can have this, I found it playin\' hide and seek.', 12, 0, 100, 1, 0, 0, 23419, 0, 'SAY_CHRISTIAN_2'),
(@ENTRY, 3, 0, 'Let\'s see if I can still make that sound....', 12, 0, 100, 1, 0, 0, 23420, 0, 'SAY_CHRISTIAN_3');

-- Brennan https://wow.gamepedia.com/Tyllan
SET @ENTRY := 24453;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Hrmmph. Thanks all the same, but I didn\'t need any help.', 12, 0, 100, 1, 0, 0, 23421, 0, 'SAY_BRENNAN_0'),
(@ENTRY, 1, 0, 'I was working on a cantrip that would counteract my predicament and I was very close to finding a <CROOAAK>... Oh my!', 12, 0, 100, 1, 0, 0, 23422, 0, 'SAY_BRENNAN_1'),
(@ENTRY, 2, 0, 'Well, I suppose I do owe you a little something - here, take one of these. I\'ve got lots.', 12, 0, 100, 1, 0, 0, 23423, 0, 'SAY_BRENNAN_2'),
(@ENTRY, 3, 0, 'You may want to consider leaving this place. I think being transformed into a frog is one of the better things that can happen to one here.', 12, 0, 100, 1, 0, 0, 23424, 0, 'SAY_BRENNAN_3');

-- Hollee https://wow.gamepedia.com/Relissa
SET @ENTRY := 24455;
DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, 'Oh! Back to my beautiful self? How lovely! I thought I would be a frog forever.', 12, 0, 100, 1, 0, 0, 23425, 0, 'SAY_HOLLEE_0'),
(@ENTRY, 1, 0, 'It was just terrible. I was all slimy, and I kept licking my eyes!', 12, 0, 100, 1, 0, 0, 23426, 0, 'SAY_HOLLEE_1'),
(@ENTRY, 2, 0, 'Thank goodness you came along when you did. Please, take one of these troll boxes to remember me by.', 12, 0, 100, 1, 0, 0, 23427, 0, 'SAY_HOLLEE_2'),
(@ENTRY, 3, 0, 'I never want to see this nasty pond again. Thank you, $n. I\'ll never forget you!', 12, 0, 100, 1, 0, 0, 23428, 0, 'SAY_HOLLEE_3');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
