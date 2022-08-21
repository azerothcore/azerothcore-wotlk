-- DB update 2022_05_18_01 -> 2022_05_21_00
-- Ulduar / Thorim
DELETE FROM `creature_text` WHERE `CreatureID`=32865;

-- Thorim - SPECIAL 1 and 3 have no BroadcastTextId
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(32865, 0,0,'Interlopers! You mortals who dare to interfere with my sport will pay... Wait--you...',14,0,100,0,0,15733,33145,0,'Thorim SAY_AGGRO_1'),
(32865, 1,0,'I remember you... In the mountains... But you... what is this? Where am--',14,0,100,0,0,15734,33270,0,'Thorim SAY_AGGRO_2'),
(32865, 2,0,'Behold the power of the storms and despair!',14,0,100,0,0,15735,0,0,'Thorim SAY_SPECIAL_1'),
(32865, 3,0,'Do not hold back! Destroy them!',14,0,100,0,0,15736,34241,0,'Thorim SAY_SPECIAL_2'),
(32865, 4,0,'Have you begun to regret your intrusion?',14,0,100,0,0,15737,0,0,'Thorim SAY_SPECIAL_3'),
(32865, 5,0,'Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!',14,0,100,0,0,15738,33148,0,'Thorim SAY_JUMPDOWN'),
(32865, 6,0,'Can''t you at least put up a fight!?',14,0,100,0,0,15739,34239,0,'Thorim SAY_SLAY_1'),
(32865, 6,1,'Pathetic.',14,0,100,0,0,15740,35768,0,'Thorim SAY_SLAY_2'),
(32865, 7,0,'My patience has reached its limit!',14,0,100,0,0,15741,33365,0,'Thorim SAY_BERSERK'),
(32865, 8,0,'Failures! Weaklings!',14,0,100,0,0,15742,33274,0,'Thorim SAY_WIPE'),
(32865, 9,0,'Stay your arms! I yield!',14,0,100,0,0,15743,33948,0,'Thorim SAY_DEATH'),
(32865,10,0,'I feel as though I am awakening from a nightmare, but the shadows in this place yet linger.',14,0,100,0,0,15744,33949,0,'Thorim SAY_END_NORMAL_1'),
(32865,11,0,'Sif... was Sif here? Impossible--she died by my brother''s hand. A dark nightmare indeed....',14,0,100,0,0,15745,33950,0,'Thorim SAY_END_NORMAL_2'),
(32865,12,0,'I need time to reflect.... I will aid your cause if you should require it. I owe you at least that much. Farewell.',14,0,100,0,0,15746,33951,0,'Thorim SAY_END_NORMAL_3'),
(32865,13,0,'You! Fiend! You are not my beloved! Be gone!',14,0,100,0,0,15747,33952,0,'Thorim SAY_END_HARD_1'),
(32865,14,0,'Behold the hand behind all the evil that has befallen Ulduar, left my kingdom in ruins, corrupted my brother, and slain my wife.',14,0,100,0,0,15748,33953,0,'Thorim SAY_END_HARD_2'),
(32865,15,0,'And now it falls to you, champions, to avenge us all. The task before you is great, but I will lend you my aid as I am able. You must prevail.',14,0,100,0,0,15749,33954,0,'Thorim SAY_END_HARD_3');

-- Set Thorim's traps trigger creature(s) flag
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 128 WHERE `entry` IN (33054,33725);
