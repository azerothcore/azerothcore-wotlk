DELETE FROM `creature_text`
WHERE (`CreatureID`, `GroupID`, `ID`) IN ((28936, 1, 0), (28936, 1, 1), (28936, 1, 2), (28936, 1, 3), (28936, 1, 4), (28936, 1, 5), (28936, 2, 0), (28936, 3, 0), (28936, 4, 0), (28936, 5, 0), (28936, 6, 0), (28936, 7, 0), (28936, 8, 0), (28936, 8, 1), (28936, 8, 2), (28936, 8, 3), (28936, 8, 4), (28936, 8, 5), (28936, 8, 6));
INSERT INTO `creature_text`
(`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES(28936, 1, 0, 'You''ll be hanging in the gallows shortly, Scourge fiend!', 12, 0, 100.0, 0, 0, 0, 29160, 0, 'crusader SAY_CURSADER1'),
(28936, 1, 1, 'You''ll have to kill me, monster. I will tell you NOTHING!', 12, 0, 100.0, 0, 0, 0, 29142, 0, 'crusader SAY_CURSADER2'),
(28936, 1, 2, 'You hit like a girl. Honestly. Is that the best you can do?', 12, 0, 100.0, 0, 0, 0, 29146, 0, 'crusader SAY_CURSADER3'),
(28936, 1, 3, 'ARGH! You burned my last good tabard!', 12, 0, 100.0, 0, 0, 0, 29162, 0, 'crusader SAY_CURSADER4'),
(28936, 1, 4, 'Argh... The pain... The pain is almost as unbearable as the lashings I received in grammar school when I was but a child.', 12, 0, 100.0, 0, 0, 0, 29143, 0, 'crusader SAY_CURSADER5'),
(28936, 1, 5, 'I used to work for Grand Inquisitor Isillien! Your idea of pain is a normal mid-afternoon for me!', 12, 0, 100.0, 0, 0, 0, 29161, 0, 'crusader SAY_CURSADER6'),
(28936, 2, 0, 'I''ll tell you everything! STOP! PLEASE!', 12, 0, 100.0, 0, 0, 0, 29149, 0, 'break crusader SAY_PERSUADED1'),
(28936, 3, 0, 'We... We have only been told that the "Crimson Dawn" is an awakening. You... You see, the Light speaks to the High General. It is the Light...', 12, 0, 100.0, 0, 0, 0, 29150, 0, 'break crusader SAY_PERSUADED2'),
(28936, 4, 0, 'The Light that guides us. This movement was set in motion before you came... We... We do as we are told. It is what must be done.', 12, 0, 100.0, 0, 0, 0, 29151, 0, 'break crusader SAY_PERSUADED3'),
(28936, 5, 0, 'I know very litte else... The High General chooses who may go and who must stay behind. There''s nothing else... You must believe me!', 12, 0, 100.0, 0, 0, 0, 29152, 0, 'break crusader SAY_PERSUADED4'),
(28936, 6, 0, 'LIES! The pain you are about to endure will be talked about for years to come!', 12, 0, 100.0, 0, 0, 0, 29163, 0, 'break crusader SAY_PERSUADED5'),
(28936, 7, 0, 'NO! PLEASE! There is one more thing that I forgot to mention... A courier comes soon... From Hearthglen. It...', 12, 0, 100.0, 0, 0, 0, 29153, 0, 'break crusader SAY_PERSUADED6'),
(28936, 8, 0, 'I''ll tear the secrets from your soul! Tell me about the "Crimson Dawn" and your life may be spared!', 12, 0, 100.0, 0, 0, 0, 29138, 0, 'player SAY_PERSUADE1'),
(28936, 8, 1, 'Tell me what you know about "Crimson Dawn" or the beatings will continue!', 12, 0, 100.0, 0, 0, 0, 29134, 0, 'player SAY_PERSUADE2'),
(28936, 8, 2, 'I''m through being courteous with your kind, human! What is the "Crimson Dawn?"', 12, 0, 100.0, 0, 0, 0, 29135, 0, 'player SAY_PERSUADE3'),
(28936, 8, 3, 'Is your life worth so little? Just tell me what I need to know about "Crimson Dawn" and I''ll end your suffering quickly.', 12, 0, 100.0, 0, 0, 0, 29139, 0, 'player SAY_PERSUADE4'),
(28936, 8, 4, 'I can keep this up for a very long time, Scarlet dog! Tell me about the "Crimson Dawn!"', 12, 0, 100.0, 0, 0, 0, 29137, 0, 'player SAY_PERSUADE'),
(28936, 8, 5, 'What is the "Crimson Dawn?"', 12, 0, 100.0, 0, 0, 0, 29133, 0, 'player SAY_PERSUADE6'),
(28936, 8, 6, '"Crimson Dawn!" What is it! Speak!', 12, 0, 100.0, 0, 0, 0, 29136, 0, 'player SAY_PERSUADE7');

UPDATE `creature_template` SET `ScriptName` = 'npc_crusade_persuaded' WHERE (`entry` = 28940);

UPDATE `item_template` SET `spellppmRate_1` = 8 WHERE (`entry` = 39371);
