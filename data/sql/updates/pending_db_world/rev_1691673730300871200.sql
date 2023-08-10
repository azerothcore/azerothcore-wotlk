#######################creature_template  ###################
##fairbanks Use gossip_menu_id 7283
##add gossip menu flag  Prevent red errors when the server starts
UPDATE `creature_template` SET `gossip_menu_id` = 7283, `npcflag` = 1
WHERE (`entry` = 4542);

######gossip_menu#####
##cmangos and vmangos gossip_menuID##
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

#######gossip_menu_option#####
##Using the MenuID in vmangos and cmangos
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

###########npc_text###########
##cmangos npc_text_broadcast_text
There is no 8611
DELETE FROM `npc_text` WHERE `ID` BETWEEN 8595 AND 8610;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(8595, '\r\nAT LAST, the curse IS lifted. Thank you, hero.', NULL, 12480, 0, 1, 0, 1, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8596, 'You mean, you don\'t know? The sword that you carry on your back - it is known as Ashbringer; named after its original owner.', NULL, 12482, 0, 1, 0, 6, 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8597, 'Aye, the Highlord Mograine: A founder of the original order of the Scarlet Crusade. A knight of unwavering faith and purity; Mograine would be betrayed by his own son and slain by Kel\'Thuzad\'s forces inside Stratholme. It is how I ended up here...', NULL, 12484, 0, 1, 0, 273, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8598, 'It was High General Abbendis, High Inquisitor Isillien, and Highlord Mograine that formed the Crusade. In its infancy, the Crusade was a noble order. The madness and insane zealotry that you see now did not exist. It was not until the one known as the Grand Crusader appeared that the wheels of corruption were set in motion.', NULL, 12486, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8599, 'The Highlord was the lynchpin of the Crusade. Aye, Mograine was called the Ashbringer because of his exploits versus the armies of the Lich King. With only blade and faith, Mograine would walk into whole battalions of undead and emerge unscathed - the ashes of his foes being the only indication that he had been there at all. Do you not understand? The very face of death feared him! It trembled in his presence!', NULL, 12488, 0, 1, 0, 1, 0, 273, 0, 5, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8600, 'The only way a hero can die, $r: Through tragedy. The Grand Crusader struck a deal with Kel\'Thuzad himself! An ambush would be staged that would result in the death of Mograine. The TYPE of betrayal that could only be a result of the actions of one\'s most trusted and loved companions.', NULL, 12490, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8601, '<High Inquisitor Fairbanks nods.>$B$BAye, the lesser Mograine, the one known as the Scarlet Commander, through - what I suspect - the dealings of the Grand Crusader. He led his father to the ambush like a lamb to the slaughter.', NULL, 12492, 0, 1, 0, 273, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8602, '<High Inquisitor Fairbanks lifts up his tabard revealing several gruesome scars.>$B$BBecause I was there... I was the Highlord\'s most trusted advisor. I should have known... I felt that something was amiss yet I allowed it TO happen. Would you believe that there were a thousand OR more Scourge?', NULL, 12494, 0, 1, 0, 1, 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8603, 'This was the Ashbringer, fool! AS the Scourge began TO materialize around us, Mograine\'s blade began to glow... to hum... the younger Mograine would take that as a sign to make his escape. They descended upon us with a hunger the likes of which I had never seen. Yet...', NULL, 12496, 0, 1, 0, 5, 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8604, 'It was not enough.$B$B<Fairbanks smirks briefly, lost in a memory.>$B$BA thousand came and a thousand died. By the Light! By the might of Mograine! He would smite them down as fast as they could come. Through the chaos, I noticed that the lesser Mograine was still there, off in the distance. I called to him, " HELP us, Renault! HELP your father, boy!"', NULL, 12498, 0, 1, 0, 1, 0, 22, 0, 22, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8605, '<High Inquisitor Fairbanks shakes his head.>$B$BNo... He stood in the background, watching as the legion of undead descended upon us. Soon after, my powers were exhausted. I was the first to fall... Surely they would tear me limb from limb as I lay there unconscious; but they ignored me completely, focusing all of their attention on the Highlord. ', NULL, 12500, 0, 1, 0, 274, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8606, 'It was all I could do to feign death as the corpses of the Scourge piled upon me. There was darkness and only the muffled sounds of the battle above me. The clashing of iron, the gnashing and grinding... gruesome, terrible sounds. And then there was silence. He called to me! "Fairbanks! Fairbanks\r\nWHERE are you? Talk TO me Fairbanks!" And then came the sound of incredulousness. The bite of betrayal, $r...', NULL, 12502, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8607, 'The boy had picked up the Ashbringer and driven it through his father\'s heart AS his back was turned. His LAST words will haunt me forever: "What have you done, Renault? Why would you do this?"', NULL, 12504, 0, 1, 0, 1, 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8608, 'The blade AND Mograine were a singular entity. DO you understand? This act corrupted the blade AND LEAD TO Mograine\'s own corruption as a death knight of Kel\'Thuzad. I swore that if I lived, I would expose the perpetrators of this heinous crime. FOR two days I remained under the rot AND contagion of Scourge - gathering AS much strength AS possible TO ESCAPE the razed city.\n', NULL, 12506, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, 0, 0, 100, 1, 1, 1, 0, 0, 0, NULL, NULL, 0, 0, 100, 1, 1, 1, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8609, 'Aye, I did. Much TO the dismay of the lesser Mograine, I made my way back TO the Scarlet Monastery. I shouted AND screamed. I told the tale TO ANY that would listen. AND I would be murdered in cold blood FOR my actions, dragged TO this chamber - the dark secret of the order. But SOME did listen... SOME heard my words. Thus was born the Argent Dawn...', NULL, 12508, 0, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(8610, 'I\'m afraid that the blade which you hold in your hands is beyond saving. The hatred runs too deep. But do not lose hope, $c. Where one chapter has ended, a new one begins.$B$BFind his son - a more devout and pious man you may never meet. It is rumored that he is able to build the Ashbringer anew, without requiring the old, tainted blade.', NULL, 12510, 0, 1, 0, 1, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);

DELETE FROM `npc_text` WHERE `ID`=8612;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES 
(8612, '<High Inquisitor Fairbanks shakes his head.>$B$BNo, $r; only one of his sons is dead. The other lives...$B$B<High Inquisitor Fairbanks points to the sky.>$B$BThe Outland... Find him there... ', NULL, 12512, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);