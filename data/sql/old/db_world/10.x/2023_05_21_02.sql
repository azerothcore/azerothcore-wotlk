-- DB update 2023_05_21_01 -> 2023_05_21_02
--
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` IN (19523, 19524);

DELETE FROM `creature_template_movement` WHERE (`CreatureId` IN (19523, 19524));
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(19523, 0, 0, 1, 1, 0, 0, 0),
(19524, 0, 0, 1, 1, 0, 0, 0);

DELETE FROM `creature_text` WHERE `CreatureID` IN (16809, 19523, 19524);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16809, 0, 0, '%s roars!', 16, 0, 100, 0, 0, 0, 14029, 0, 'O\'mrogg Burning Maul'),

(19523, 0, 0, 'Smash!', 14, 0, 100, 0, 0, 10306, 14046, 0, 'O\'mrogg Left Head Aggro 1'),
(19523, 1, 0, 'If you nice me let you live.', 14, 0, 100, 0, 0, 10308, 14048, 0, 'O\'mrogg Left Head Aggro 2'),
(19523, 2, 0, 'Me hungry!', 14, 0, 100, 0, 0, 10309, 16918, 0, 'O\'mrogg Left Head Aggro 3'),

(19523, 3, 0, 'You stay here.  Me go kill someone else!', 14, 0, 100, 0, 0, 10303, 16898, 0, 'O\'mrogg Left Head Beatdown'),
(19523, 3, 1, 'We kill someone else!', 14, 0, 100, 0, 0, 10302, 16895, 0, 'O\'mrogg Left Head Beatdown'),
(19523, 3, 2, 'Me not like this one...', 14, 0, 100, 0, 0, 10300, 14043, 0, 'O\'mrogg Left Head Beatdown'),
(19523, 3, 3, 'We kill his friend!', 14, 0, 100, 0, 0, 10301, 14045, 0, 'O\'mrogg Left Head Beatdown'),

(19523, 4, 0, 'Me get bored.', 14, 0, 100, 0, 0, 10305, 16902, 0, 'O\'mrogg Left Head Beatdown Reply'),
(19523, 5, 0, 'Ha ha ha.', 14, 0, 100, 0, 0, 10304, 16900, 0, 'O\'mrogg Left Head Beatdown Reply'),

(19523, 6, 0, 'Hey...', 14, 0, 100, 0, 0, 10307, 16917, 0, 'O\'mrogg Left Head Kill Reply'),
(19523, 7, 0, 'This one die easy!', 14, 0, 100, 0, 0, 10310, 16922, 0, 'O\'mrogg Left Head Kill'),

(19523, 8, 0, 'This all... your fault!', 14, 0, 100, 0, 0, 10311, 16924, 0, 'O\'mrogg Left Head Death'),

(19524, 0, 0, 'Why don\'t you let me do the talking?', 14, 0, 100, 0, 0, 10317, 14047, 0, 'O\'mrogg Right Head Aggro 1'),
(19524, 1, 0, 'No, we will NOT let you live.', 14, 0, 100, 0, 0, 10318, 16916, 0, 'O\'mrogg Right Head Aggro 2'),
(19524, 2, 0, 'You\'re always hungry.  That\'s why we so fat!', 14, 0, 100, 0, 0, 10319, 16919, 0, 'O\'mrogg Right Head Aggro 3'),

(19524, 3, 0, 'What are you doing?', 14, 0, 100, 0, 0, 10315, 16901, 0, 'O\'mrogg Right Head Beatdown'),
(19524, 3, 1, 'I\'m not done yet, idiot!', 14, 0, 100, 0, 0, 10313, 16896, 0, 'O\'mrogg Right Head Beatdown'),
(19524, 3, 2, 'Hey, you numbskull!', 14, 0, 100, 0, 0, 10312, 14044, 0, 'O\'mrogg Right Head Beatdown'),

(19524, 4, 0, 'Bored? He was almost dead!', 14, 0, 100, 0, 0, 10316, 16903, 0, 'O\'mrogg Right Head Beatdown Reply'),
(19524, 5, 0, 'That\'s not funny!', 14, 0, 100, 0, 0, 10314, 16899, 0, 'O\'mrogg Right Head Beatdown Reply'),

(19524, 6, 0, 'I\'m tired.  You kill next one!', 14, 0, 100, 0, 0, 10320, 16921, 0, 'O\'mrogg Right Head Kill'),
(19524, 7, 0, 'That\'s because I do all the hard work!', 14, 0, 100, 0, 0, 10321, 16923, 0, 'O\'mrogg Right Head Kill Reply'),

(19524, 8, 0, 'I... hate... you.', 14, 0, 100, 0, 0, 10322, 16925, 0, 'O\'mrogg Right Head Death');

DELETE FROM `spell_script_names` WHERE `spell_id` = 30598 AND `ScriptName` = 'spell_burning_maul';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(30598, 'spell_burning_maul');
