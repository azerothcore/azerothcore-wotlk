-- DB update 2022_05_08_09 -> 2022_05_09_00
-- Clear Auriaya's creature_text (duplicate and EMOTE_DEATH missing), CN locale is also wrong
DELETE FROM `creature_text` WHERE `CreatureID`=33515;

-- EMOTE_DEATH has no BroadcastTextID
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33515, 0, 0, 'Some things are better left alone!', 14, 0, 100, 0, 0, 15473, 34341, 0, 'Auriaya SAY_AGGRO'),
(33515, 1, 0, 'The secret dies with you.', 14, 0, 100, 0, 0, 15474, 34354, 0, 'Auriaya SAY_SLAY_1'),
(33515, 1, 1, 'There is no escape!', 14, 0, 100, 0, 0, 15475, 37177, 0, 'Auriaya SAY_SLAY_2'),
(33515, 2, 0, 'You waste my time!', 14, 0, 100, 0, 0, 15477, 34358, 0, 'Auriaya SAY_BERSERK'),
(33515, 3, 0, '%s screams in agony.', 16, 0, 100, 0, 0, 15476, 0, 0, 'Auriaya EMOTE_DEATH'),
(33515, 4, 0, '%s begins to cast Terrifying Screech.', 41, 0, 100, 0, 0, 0, 34450, 0, 'Auriaya EMOTE_FEAR'),
(33515, 5, 0, '%s begins to activate the Feral Defender!', 41, 0, 100, 0, 0, 0, 34162, 0, 'Auriaya EMOTE_DEFENDER');
