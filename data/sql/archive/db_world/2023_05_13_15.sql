-- DB update 2023_05_13_14 -> 2023_05_13_15
DELETE FROM `creature_text` WHERE `CreatureID` = 16807;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16807, 0, 0, 'You wish to fight us all at once? This should be amusing!\n', 14, 0, 100, 0, 0, 10262, 15594, 0, 'Netherkurse AGGRO_1'),
(16807, 1, 0, 'Thank you for saving me the trouble. Now it\'s my turn to have some fun!\n', 14, 0, 100, 0, 0, 10270, 15589, 0, 'Netherkurse AGGRO_2'),
(16807, 2, 0, 'You can have that one, I no longer need him!', 14, 0, 100, 0, 0, 10263, 15569, 0, 'Netherkurse PEON_ATTACK_1'),
(16807, 2, 1, 'Yes, beat him mercilessly! His skull is as thick as an ogre\'s!\n', 14, 0, 100, 0, 0, 10264, 15575, 0, 'Netherkurse PEON_ATTACK_2'),
(16807, 2, 2, 'Don\'t waste your time on that one, he\'s weak!', 14, 0, 100, 0, 0, 10265, 15573, 0, 'Netherkurse PEON_ATTACK_3'),
(16807, 2, 3, 'You want him? Very well, take him!', 14, 0, 100, 0, 0, 10266, 15572, 0, 'Netherkurse PEON_ATTACK_4'),
(16807, 3, 0, 'One pitiful wretch down. Go on, take another one! ', 14, 0, 100, 0, 0, 10267, 15579, 0, 'Netherkurse PEON_DIE_1'),
(16807, 3, 1, 'Ah, what a waste... next!', 14, 0, 100, 0, 0, 10268, 15584, 0, 'Netherkurse PEON_DIE_2'),
(16807, 3, 2, 'I was going to kill him anyway!', 14, 0, 100, 0, 0, 10269, 15582, 0, 'Netherkurse PEON_DIE_3'),
(16807, 4, 0, 'Beg for your pitiful life!', 14, 0, 100, 0, 0, 10259, 14130, 0, 'Netherkurse SAY_SHADOW_SEAR'),
(16807, 5, 0, 'Your pain amuses me!', 14, 0, 100, 0, 0, 10261, 14148, 0, 'Netherkurse SAY_SHADOW_FISSURE'),
(16807, 6, 0, 'Run, coward, run!   ', 14, 0, 100, 0, 0, 10260, 14132, 0, 'Netherkurse SAY_DEATH_COIL'),
(16807, 7, 0, 'I\'m already bored!', 14, 0, 100, 0, 0, 10271, 16864, 0, 'Netherkurse SAY_SLAY_1'),
(16807, 7, 1, 'Come on, show me a real fight!', 14, 0, 100, 0, 0, 10272, 15595, 0, 'Netherkurse SAY_SLAY_2'),
(16807, 7, 2, 'I had more fun torturing the peons!', 14, 0, 100, 0, 0, 10273, 16863, 0, 'Netherkurse SAY_SLAY_3'),
(16807, 7, 3, 'You lose.', 14, 0, 100, 0, 0, 10274, 16865, 0, 'Netherkurse SAY_SLAY_4'),
(16807, 7, 4, 'Oh, just die!', 14, 0, 100, 0, 0, 10275, 16866, 0, 'Netherkurse SAY_SLAY_5'),
(16807, 8, 0, 'What... a shame.', 14, 0, 100, 0, 0, 10276, 16862, 0, 'Netherkurse SAY_DIE');

-- Auras for Shadow Fissures
DELETE FROM `creature_template_addon` WHERE `entry` IN (18370, 20598);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(18370, 0, 0, 0, 0, 0, 0, '32250'),
(20598, 0, 0, 0, 0, 0, 0, '32250'); -- Same aura in heroic
