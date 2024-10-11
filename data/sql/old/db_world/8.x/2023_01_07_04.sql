-- DB update 2023_01_07_03 -> 2023_01_07_04
--
DELETE FROM `creature_text` WHERE `CreatureID`=23577;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23577,0,0,'Get on ya knees and bow.... to da fang and claw!',14,0,100,0,0,12020,0,0,'Halazzi - SAY_AGGRO'),
(23577,1,0,'You can\t fight da power!',14,0,100,0,0,12026,0,0,'Halazzi - SAY_KILL'),
(23577,1,1,'Ya all gonna fail!',14,0,100,0,0,12027,0,0,'Halazzi - SAY_KILL'),
(23577,2,0,'Me gonna carve ya now!',14,0,100,0,0,12023,0,0,'Halazzi - SAY_SABER'),
(23577,2,1,'You gonna leave in pieces!',14,0,100,0,0,12024,0,0,'Halazzi - SAY_SABER'),
(23577,3,0,'I fight wit\ untamed spirit....',14,0,100,0,0,12021,0,0,'Halazzi - SAY_SPLIT'),
(23577,4,0,'Spirit, come back to me!',14,0,100,0,0,12022,0,0,'Halazzi - SAY_MERGE'),
(23577,5,0,'Chaga... choka\jinn.',14,0,100,0,0,12028,0,0,'Halazzi - SAY_DEATH');
