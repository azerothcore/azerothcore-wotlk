-- DB update 2023_09_17_11 -> 2023_09_17_12
-- ---------------------creature_template  -------------------
-- fairbanks Use gossip_menu_id 7283
-- add gossip menu flag  Prevent red errors when the server starts
UPDATE `creature_template` SET `gossip_menu_id` = 7283, `npcflag` = 1
WHERE (`entry` = 4542);

-- ----gossip_menu-----
-- cmangos and vmangos gossip_menuID--
DELETE
FROM `gossip_menu`
WHERE `MenuID` BETWEEN 7268 AND 7284;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7268, 8610),
(7269, 8609),
(7270, 8608),
(7271, 8607),
(7272, 8606),
(7273, 8605),
(7274, 8604),
(7275, 8603),
(7276, 8602),
(7277, 8601),
(7278, 8600),
(7279, 8599),
(7280, 8598),
(7281, 8597),
(7282, 8596),
(7283, 8595),
(7284, 8612);

-- -----gossip_menu_option-----
-- Using the MenuID in vmangos and cmangos
DELETE
FROM `gossip_menu_option`
WHERE `MenuID` BETWEEN 7268 AND 7283;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7268, 0, 0, 'But his son is dead.', 12511, 1, 1, 7284, 0, 0, 0, '', 0, 0),
(7269, 0, 0, 'You tell an incredible tale, Fairbanks. What of the blade? Is it beyond redemption?', 12509, 1, 1, 7268, 0, 0, 0, '', 0, 0),
(7270, 0, 0, 'And you did...', 12507, 1, 1, 7269, 0, 0, 0, '', 0, 0),
(7271, 0, 0, 'You were right, Fairbanks. That is tragic.', 12505, 1, 1, 7270, 0, 0, 0, '', 0, 0),
(7272, 0, 0, 'You mean...', 12503, 1, 1, 7271, 0, 0, 0, '', 0, 0),
(7273, 0, 0, 'Continue please, Fairbanks.', 12501, 1, 1, 7272, 0, 0, 0, '', 0, 0),
(7274, 0, 0, 'And did he?', 12499, 1, 1, 7273, 0, 0, 0, '', 0, 0),
(7275, 0, 0, 'Yet? Yet what??', 12497, 1, 1, 7274, 0, 0, 0, '', 0, 0),
(7276, 0, 0, 'A thousand? For one man?', 12495, 1, 1, 7275, 0, 0, 0, '', 0, 0),
(7277, 0, 0, 'How do you know all of this?', 12493, 1, 1, 7276, 0, 0, 0, '', 0, 0),
(7278, 0, 0, 'You mean...', 12491, 1, 1, 7277, 0, 0, 0, '', 0, 0),
(7279, 0, 0, 'Incredible story. So how did he die?', 12489, 1, 1, 7278, 0, 0, 0, '', 0, 0),
(7280, 0, 0, 'I still do not fully understand.', 12487, 1, 1, 7279, 0, 0, 0, '', 0, 0),
(7281, 0, 0, 'What do you mean?', 12485, 1, 1, 7280, 0, 0, 0, '', 0, 0),
(7282, 0, 0, 'Mograine?', 12483, 1, 1, 7281, 0, 0, 0, '', 0, 0),
(7283, 0, 0, 'Curse? What\'s going ON here, Fairbanks?', 12481, 1, 1, 7282, 0, 0, 0, '', 0, 0);

-- ---------npc_text-----------
-- cmangos npc_text_broa*dcast_text
DELETE FROM `npc_text` WHERE `ID` BETWEEN 8595 AND 8610;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(8595, '\r\nAT LAST, the curse IS lifted. Thank you, hero.', NULL, 12480, 0, 1, 0, 1, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8596, 'You mean, you don\'t know? The sword that you carry on your back - it is known as Ashbringer; named after its original owner.', NULL, 12482, 0, 1, 0, 6, 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),

-- Emoji 273 Holding a weapon in your hand is different from the Blizzard plan 
(8597, 'Aye, the Highlord Mograine: A founder of the original order of the Scarlet Crusade. A knight of unwavering faith and purity; Mograine would be betrayed by his own son and slain by Kel\'Thuzad\'s forces inside Stratholme. It is how I ended up here...', NULL, 12484, 0, 1, 0, 273, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),

(8598, 'It was High General Abbendis, High Inquisitor Isillien, and Highlord Mograine that formed the Crusade. In its infancy, the Crusade was a noble order. The madness and insane zealotry that you see now did not exist. It was not until the one known as the Grand Crusader appeared that the wheels of corruption were set in motion.', NULL, 12486, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),

-- Emoji 273 Holding a weapon in your hand is different from the Blizzard plan
(8599, 'The Highlord was the lynchpin of the Crusade. Aye, Mograine was called the Ashbringer because of his exploits versus the armies of the Lich King. With only blade and faith, Mograine would walk into whole battalions of undead and emerge unscathed - the ashes of his foes being the only indication that he had been there at all. Do you not understand? The very face of death feared him! It trembled in his presence!', NULL, 12488, 0, 1, 0, 1, 0, 273, 0, 5, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),

(8600, 'The only way a hero can die, $r: Through tragedy. The Grand Crusader struck a deal with Kel\'Thuzad himself! An ambush would be staged that would result in the death of Mograine. The TYPE of betrayal that could only be a result of the actions of one\'s most trusted and loved companions.', NULL, 12490, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Emoji 273 Holding a weapon in your hand is different from the Blizzard plan
(8601, '<High Inquisitor Fairbanks nods.>$B$BAye, the lesser Mograine, the one known as the Scarlet Commander, through - what I suspect - the dealings of the Grand Crusader. He led his father to the ambush like a lamb to the slaughter.', NULL, 12492, 0, 1, 0, 273, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8602, '<High Inquisitor Fairbanks lifts up his tabard revealing several gruesome scars.>$B$BBecause I was there... I was the Highlord\'s most trusted advisor. I should have known... I felt that something was amiss yet I allowed it TO happen. Would you believe that there were a thousand OR more Scourge?', NULL, 12494, 0, 1, 0, 1, 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8603, 'This was the Ashbringer, fool! AS the Scourge began TO materialize around us, Mograine\'s blade began to glow... to hum... the younger Mograine would take that as a sign to make his escape. They descended upon us with a hunger the likes of which I had never seen. Yet...', NULL, 12496, 0, 1, 0, 5, 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8604, 'It was not enough.$B$B<Fairbanks smirks briefly, lost in a memory.>$B$BA thousand came and a thousand died. By the Light! By the might of Mograine! He would smite them down as fast as they could come. Through the chaos, I noticed that the lesser Mograine was still there, off in the distance. I called to him, " HELP us, Renault! HELP your father, boy!"', NULL, 12498, 0, 1, 0, 1, 0, 22, 0, 22, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Emoji 274 Holding a weapon in your hand is different from the Blizzard plan
(8605, '<High Inquisitor Fairbanks shakes his head.>$B$BNo... He stood in the background, watching as the legion of undead descended upon us. Soon after, my powers were exhausted. I was the first to fall... Surely they would tear me limb from limb as I lay there unconscious; but they ignored me completely, focusing all of their attention on the Highlord. ', NULL, 12500, 0, 1, 0, 274, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8606, 'It was all I could do to feign death as the corpses of the Scourge piled upon me. There was darkness and only the muffled sounds of the battle above me. The clashing of iron, the gnashing and grinding... gruesome, terrible sounds. And then there was silence. He called to me! "Fairbanks! Fairbanks\r\nWHERE are you? Talk TO me Fairbanks!" And then came the sound of incredulousness. The bite of betrayal, $r...', NULL, 12502, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8607, 'The boy had picked up the Ashbringer and driven it through his father\'s heart AS his back was turned. His LAST words will haunt me forever: "What have you done, Renault? Why would you do this?"', NULL, 12504, 0, 1, 0, 1, 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8608, 'The blade AND Mograine were a singular entity. DO you understand? This act corrupted the blade AND LEAD TO Mograine\'s own corruption as a death knight of Kel\'Thuzad. I swore that if I lived, I would expose the perpetrators of this heinous crime. FOR two days I remained under the rot AND contagion of Scourge - gathering AS much strength AS possible TO ESCAPE the razed city.\n', NULL, 12506, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, 0, 0, 100, 1, 1, 1, 0, 0, 0, NULL, NULL, 0, 0, 100, 1, 1, 1, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8609, 'Aye, I did. Much TO the dismay of the lesser Mograine, I made my way back TO the Scarlet Monastery. I shouted AND screamed. I told the tale TO ANY that would listen. AND I would be murdered in cold blood FOR my actions, dragged TO this chamber - the dark secret of the order. But SOME did listen... SOME heard my words. Thus was born the Argent Dawn...', NULL, 12508, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8610, 'I\'m afraid that the blade which you hold in your hands is beyond saving. The hatred runs too deep. But do not lose hope, $c. Where one chapter has ended, a new one begins.$B$BFind his son - a more devout and pious man you may never meet. It is rumored that he is able to build the Ashbringer anew, without requiring the old, tainted blade.', NULL, 12510, 0, 1, 0, 1, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);

-- Emoji 274 and 397 Holding a weapon in your hand is different from the Blizzard plan
DELETE FROM `npc_text` WHERE `ID`=8612;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES 
(8612, '<High Inquisitor Fairbanks shakes his head.>$B$BNo, $r; only one of his sons is dead. The other lives...$B$B<High Inquisitor Fairbanks points to the sky.>$B$BThe Outland... Find him there... ', NULL, 12512, 0, 1, 0, 271, 0, 1, 0, 397, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);

-- ---------npc_text-----------
-- Get ready to trigger emoticons with SmartAI
-- use smart_ai emto  8597 8599 8601 8605 8612 
UPDATE `npc_text` SET `em0_1`=0,`em0_3`=0, `em0_5`=0
WHERE `ID`=8597;
UPDATE `npc_text` SET `em0_1`=0,`em0_3`=0, `em0_5`=0
WHERE `ID`=8599;
UPDATE `npc_text` SET `em0_1`=0,`em0_3`=0, `em0_5`=0
WHERE `ID`=8601;
UPDATE `npc_text` SET `em0_1`=0,`em0_3`=0, `em0_5`=0
WHERE `ID`=8605;
UPDATE `npc_text` SET `em0_1`=0,`em0_3`=0, `em0_5`=0
WHERE `ID`=8612;

-- -------------------SMARTSCRIPT START---------------
-- ---------------------------------------------------
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4542;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 4542);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4542, 0, 0, 0, 0, 0, 100, 0, 7000, 11000, 30000, 40000, 0, 11, 8282, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - In Combat - Cast Curse of Blood'),
(4542, 0, 1, 0, 0, 0, 100, 0, 6000, 11000, 15000, 20000, 0, 11, 15090, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - In Combat - Cast Dispel Magic'),
(4542, 0, 2, 0, 0, 0, 100, 0, 0, 3000, 20000, 20000, 0, 11, 11647, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - In Combat - Cast Power Word: Shield'),
(4542, 0, 3, 0, 0, 0, 100, 0, 10000, 15000, 20000, 20000, 0, 11, 12039, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Fairbanks - In Combat - Cast Heal'),
(4542, 0, 4, 5, 37, 0, 100, 1, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'fairbanks - initializes -Remove UNIT_NPC_FLAG_GOSSIP'),
(4542, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'fairbanks - initializes - set_sheath ‘SHEATH_STATE_MELEE’'),

-- Do not hold a weapon in your hand when making expressions
(4542, 0, 6, 0, 62, 0, 100, 0, 7282, 0, 0, 0, 0, 80, 454200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'fairbanks- Gossip_Select 7282 - emto (273 ,1,1)'),
(4542, 0, 7, 0, 62, 0, 100, 0, 7280, 0, 0, 0, 0, 80, 454201, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'fairbanks - Gossip_Select 7280 -emto (1,273,5)'),
(4542, 0, 8, 0, 62, 0, 100, 0, 7278, 0, 0, 0, 0, 80, 454202, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'fairbanks - Gossip_Select 7278 - emto (273,1,1)'),
(4542, 0, 9, 0, 62, 0, 100, 0, 7274, 0, 0, 0, 0, 80, 454203, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'fairbanks - Gossip_Select 7274 - emto (274,1,1)'),
(4542, 0, 10, 0, 62, 0, 100, 0, 7268, 0, 0, 0, 0, 80, 454204, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'fairbanks - Gossip_Select 7268 - emto (274,1,397)');

-- -------- TIMED_ACTIONLIST EMOTE
-- fairbanks - Menuid - 7282 emto(273, 1, 1)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 454200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(454200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Set Sheath ‘SHEATH_STATE_UNARMED’'),
(454200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fairbanks - On Script - Play Emote 273'),
(454200, 9, 3, 0, 0, 0, 100, 0, 2200, 2200, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '  Fairbanks - On Script - Set Sheath ‘SHEATH_STATE_MELEE’'),
(454200, 9, 4, 0, 0, 0, 100, 0, 700, 700, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fairbanks - On Script - Play Emote 1'),
(454200, 9, 6, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fairbanks - On Script - Play Emote 1');

-- fairbanks - Menuid - 7280 emto(1, 273, 5)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 454201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(454201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Play Emote 1'),
(454201, 9, 1, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Set Sheath ‘SHEATH_STATE_UNARMED’'),
(454201, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Play Emote 273'),
(454201, 9, 3, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '  Fairbanks - On Script - Set Sheath  ‘SHEATH_STATE_MELEE’'),
(454201, 9, 5, 0, 0, 0, 100, 0, 700, 700, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Set Sheath ‘SHEATH_STATE_UNARMED’'),
(454201, 9, 6, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fairbanks - On Script - Play Emote 5'),
(454201, 9, 7, 0, 0, 0, 100, 0, 2200, 2200, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Set Sheath  ‘SHEATH_STATE_MELEE’');

-- fairbanks - Menuid - 7278 emto(273, 1, 1)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 454202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(454202, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Set Sheath‘SHEATH_STATE_UNARMED’'),
(454202, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 273, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Play Emote 273'),
(454202, 9, 2, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '  Fairbanks - On Script - Set Sheath  ‘SHEATH_STATE_MELEE’'),
(454202, 9, 3, 0, 0, 0, 100, 0, 700, 700, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Play Emote 1'),
(454202, 9, 4, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Play Emote 1');

-- fairbanks - Menuid - 7274 emto(274, 1, 1)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 454203);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(454203, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  ' Fairbanks - On Script - Set Sheath ‘SHEATH_STATE_UNARMED’'),
(454203, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fairbanks - On Script - Play Emote 274'),
(454203, 9, 2, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '  Fairbanks - On Script - Set Sheath  ‘SHEATH_STATE_MELEE’'),
(454203, 9, 3, 0, 0, 0, 100, 0, 700, 700, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Play Emote 1'),
(454203, 9, 4, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Play Emote 1');

-- fairbanks - Menuid - 7268(END) emto(274, 1, 397)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 454204);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(454204, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Set Sheath ‘SHEATH_STATE_UNARMED’'),
(454204, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Play Emote 274'),
(454204, 9, 2, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '  Fairbanks - On Script - Set Sheath  ‘SHEATH_STATE_MELEE’'),
(454204, 9, 3, 0, 0, 0, 100, 0, 700, 700, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Play Emote 1'),
(454204, 9, 4, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Set Sheath  ‘SHEATH_STATE_UNARMED’'),
(454204, 9, 5, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 5, 397, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Play Emote 397'),
(454204, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ' Fairbanks - On Script - Set Sheath  ‘SHEATH_STATE_MELEE’');


-- ----------conditions------------
-- cmangos and vmangos conditions
DELETE
FROM `conditions`
WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 7283) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 2) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 22691) AND (`ConditionValue2` = 1) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7283, 0, 0, 0, 2, 0, 22691, 1, 0, 0, 0, 0, '', 'the gossip menu is only displayed if the player inventory "ASHBRINGER"--ASHBRINGER');

-- Clean up 100100 - 100116 data
DELETE
FROM `npc_text`
WHERE `ID` BETWEEN 100100 AND 100116;