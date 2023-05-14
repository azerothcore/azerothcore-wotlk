-- DB update 2023_04_22_07 -> 2023_04_22_08
--

/* Does not drop from any other creatures */
DELETE FROM `creature_loot_template` WHERE `Item` = 6366;
/*
By Managos (2,236 – 5·11) on 2021/03/18 (Classic)
After killing over 3,769 worgs in Tirisfal Glades, with stringy wolf meat x2000,
discolored worg hearts x2946, and many useless greens... I got my DARKWOOD POLE.
Now to say that its better than the quest pole for horde would be a lie, however..
Its pretty neat to see. Good luck to those still grinding it out!
*/
/*
By Karasukami on 2005/01/21 (Patch 1.2.1)
Subject: "hmm"
I have read that Bloodsnout Worgs in silverpine drop this..
I guess I'll try and see if that is so. :\
*/
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(1765, 6366, 0.005, 0, 1, 1), -- Worg
(1766, 6366, 0.005, 0, 1, 1), -- Mottled Worg
(1923, 6366, 0.005, 0, 1, 1); -- Bloodsnout Worg

/*
By bilcosby on 2006/08/11 (Patch 1.11.2)
Subject: "i got one"
i got one from a random mob in duskwood was a worg i was just running thro to get to ZG and i killed for fun and it droped
*/
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(628, 6366, 0.005, 0, 1, 1), -- Black Ravager
(923, 6366, 0.005, 0, 1, 1); -- Young Black Ravager
