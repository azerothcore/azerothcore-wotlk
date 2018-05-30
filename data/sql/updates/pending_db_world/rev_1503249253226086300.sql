INSERT INTO version_db_world (`sql_rev`) VALUES ('1503249253226086300');

-- Auriaya emote and say
DELETE FROM `creature_text` WHERE `entry`=33515;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`probability`,`sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(33515, 0, 0, 'Some things are better left alone!', 14, 100, 34341, 15473, 3, 'Auriaya SAY_AGGRO'),
(33515, 1, 1, 'The secret dies with you.', 14, 100, 34354, 15474, 3, 'Auriaya SAY_SLAY_1'),
(33515, 1, 2, 'There is no escape!', 14, 100, 34355, 15475, 3, 'Auriaya SAY_SLAY_2'),
(33515, 2, 0, 'Auriaya screams in agony.', 16, 100, 15476, 0, 3, 'Auriaya SAY_DEATH'),
(33515, 3, 0, 'You waste my time!', 14, 100, 34358, 15477, 3, 'Auriaya SAY_BERSERK'),
(33515, 4, 0, '%s begins to cast Terrifying Screech.', 41, 100, 0, 34450, 3, 'Auriaya EMOTE_FEAR'),
(33515, 5, 0, '%s begins to activate the Feral Defender!', 41, 100, 0, 34162, 3, 'Auriaya EMOTE_DEFENDER');

-- Locales text
DELETE FROM `locales_creature_text` WHERE `entry`=33515;
INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc8`) VALUES
(33515, 2, 0, 'Ауриайя кричит в агонии.');
