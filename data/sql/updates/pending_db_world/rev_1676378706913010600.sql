-- Populate creature_text for Highlord Tirion Fordring (ToC5) from ToC25 (34996) Should probably be 34996 for both, needs a sniff.
DELETE FROM `creature_text` WHERE `CreatureID`=33628;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33628, 21, 0, 'Welcome, champions. Today, before the eyes of your leaders and peers, you will prove yourselves worthy combatants.', 14, 0, 100, 1, 0, 0, 35321, 0, 'Highlord Tirion Fordring - SAY_TIRION_CHAMPION_INTRO_1'),
(33628, 22, 0, 'You will first be facing three of the Grand Champions of the Tournament! These fierce contenders have beaten out all others to reach the pinnacle of skill in the joust.', 14, 0, 100, 0, 0, 0, 35330, 0, 'Highlord Tirion Fordring - SAY_TIRION_CHAMPION_INTRO_2'),
(33628, 23, 0, 'Begin!', 14, 0, 100, 0, 0, 8574, 35331, 0, 'Highlord Tirion Fordring - SAY_TIRION_CHAMPION_BEGIN'),
(33628, 24, 0, 'Well fought! Your next challenge comes from the Crusade\'s own ranks. You will be tested against their considerable prowess.', 14, 0, 100, 0, 0, 15882, 35541, 0, 'Highlord Tirion Fordring - SAY_TIRION_PALETRESS_INTRO_1'),
(33628, 31, 0, 'Well done. You have proven yourself today-', 14, 0, 100, 0, 0, 0, 35544, 0, 'Highlord Tirion Fordring - SAY_TIRION_KNIGHT_INTRO_2'),
(33628, 34, 0, 'What is the meaning of this?', 14, 0, 100, 0, 0, 0, 35547, 0, 'Highlord Tirion Fordring - SAY_TIRION_KNIGHT_INTRO_2'),
(33628, 41, 0, 'You may begin!', 14, 0, 100, 22, 0, 8574, 35677, 0, 'Highlord Tirion Fordring - SAY_TIRION_YOU_MAY_BEGIN');

-- Alliance Announcer - Arelas Brightstar
DELETE FROM `creature_text` WHERE `creatureID`=35005;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(35005, 0, 0, 'Entering the arena, a paladin who is no stranger to the battlefield or tournament ground, the Grand Champion of the Argent Crusade, Eadric the Pure!', 14, 0, 100, 0, 0, 8574, 35542, 0, 'Arelas Brightstar - SAY_EADRIC_INTRO'),
(35005, 1, 0, 'The next combatant is second to none in her passion for upholding the Light. I give you Argent Confessor Paletress!', 14, 0, 100, 0, 0, 8574, 35543, 0, 'Arelas Brightstar - SAY_ARELAS_PALETRESS_INTRO'),
(35005, 2, 0, 'The Silver Covenant is pleased to present their contenders for this event, Highlord.', 14, 0, 100, 396, 0, 8574, 35259, 0, 'Arelas Brightstar - SAY_ARELAS_GRAND_CHAMPIONS_INTRO_1'),
(35005, 3, 0, 'Coming out of the gate is Eressea Dawnsinger, skilled mage and Grand Champion of Silvermoon!\n', 12, 0, 100, 0, 0, 8573, 35338, 0, 'Arelas Brightstar - SAY_ARELAS_GRAND_CHAMPIONS_INTRO_2'),
(35005, 4, 0, 'Entering the arena is the lean and dangerous Zul\'tore, Grand Champion of Sen\'jin!\n', 12, 0, 100, 0, 0, 8573, 35335, 0, 'Arelas Brightstar - SAY_ARELAS_GRAND_CHAMPIONS_INTRO_2'),
(35005, 5, 0, 'Presenting the fierce Grand Champion of Orgrimmar, Mokra the Skullcrusher!\n', 12, 0, 100, 0, 0, 8573, 35334, 0, 'Arelas Brightstar - SAY_ARELAS_GRAND_CHAMPIONS_INTRO_2'),
(35005, 6, 0, 'Representing the tenacity of the Forsaken, here is the Grand Champion of the Undercity, Deathstalker Visceri!\n', 12, 0, 100, 0, 0, 8573, 35337, 0, 'Arelas Brightstar - SAY_ARELAS_GRAND_CHAMPIONS_INTRO_2'),
(35005, 7, 0, 'Tall in the saddle of his kodo, here is the venerable Runok Wildmane, Grand Champion of Thunder Bluff!\n', 12, 0, 100, 0, 0, 8573, 35336, 0, 'Arelas Brightstar - SAY_ARELAS_GRAND_CHAMPIONS_INTRO_2'),
(35005, 8, 0, 'What\'s that, up near the rafters?', 12, 0, 100, 25, 0, 0, 35545, 0, 'Arelas Brightstar - SAY_ARELAS_KNIGHT_INTRO');

-- Horde Announcer - Jaeren Sunsworn, reverse matching the BroadcastTextId
DELETE FROM `creature_text` WHERE `creatureID`=35004;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(35004, 0, 0, 'Entering the arena, a paladin who is no stranger to the battlefield or tournament ground, the Grand Champion of the Argent Crusade, Eadric the Pure!', 14, 0, 100, 0, 0, 8574, 35542, 0, 'Jaeren Sunsworn - SAY_JAEREN_INTRO'),
(35004, 1, 0, 'The next combatant is second to none in her passion for upholding the Light. I give you Argent Confessor Paletress!', 14, 0, 100, 0, 0, 8574, 35543, 0, 'Jaeren Sunsworn - SAY_JAEREN_PALETRESS_INTRO'),
(35004, 2, 0, 'The Sunreavers are proud to present their representatives in this trial by combat.', 14, 0, 100, 396, 0, 8574, 35260, 0, 'Jaeren Sunsworn - SAY_JAEREN_GRAND_CHAMPIONS_INTRO_1'),
(35004, 3, 0, 'Here comes the small but deadly Ambrose Boltspark, Grand Champion of Gnomeregan!', 12, 0, 100, 0, 0, 8573, 35248, 0, 'Jaeren Sunsworn - SAY_JAEREN_GRAND_CHAMPIONS_INTRO_2'),
(35004, 4, 0, 'Entering the arena is the Grand Champion of Darnassus, the skilled sentinel Jaelyne Evensong!', 12, 0, 100, 0, 0, 8573, 35249, 0, 'Jaeren Sunsworn - SAY_JAEREN_GRAND_CHAMPIONS_INTRO_2'),
(35004, 5, 0, 'Proud and strong, give a cheer for Marshal Jacob Alerius, the Grand Champion of Stormwind!', 12, 0, 100, 0, 0, 8573, 35245, 0, 'Jaeren Sunsworn - SAY_JAEREN_GRAND_CHAMPIONS_INTRO_2'),
(35004, 6, 0, 'The might of the dwarves is represented today by the Grand Champion of Ironforge, Lana Stouthammer!', 12, 0, 100, 0, 0, 8573, 35246, 0, 'Jaeren Sunsworn - SAY_JAEREN_GRAND_CHAMPIONS_INTRO_2'),
(35004, 7, 0, 'Coming out of the gate is Colosos, the towering Grand Champion of the Exodar!', 12, 0, 100, 0, 0, 8573, 35247, 0, 'Jaeren Sunsworn - SAY_JAEREN_GRAND_CHAMPIONS_INTRO_2'),
(35004, 8, 0, 'What\'s that, up near the rafters?', 12, 0, 100, 25, 0, 0, 35545, 0, 'Jaeren Sunsworn - SAY_JAEREN_KNIGHT_INTRO');

-- Argent Confessor Paletress remove empty BroadcastTextId duplicates
DELETE FROM `creature_text` WHERE `CreatureID`=34928;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(34928, 0, 0, 'Thank you, good herald. Your words are too kind.', 12, 0, 100, 2, 0, 16245, 35762, 0, 'Argent Confessor Paletress - SAY_INTRO_1'),
(34928, 1, 0, 'May the Light give me strength to provide a worthy challenge.', 12, 0, 100, 16, 0, 16246, 35763, 0, 'Argent Confessor Paletress - SAY_INTRO_2'),
(34928, 2, 0, 'Well, then. Let us begin.', 14, 0, 100, 0, 0, 16247, 35229, 0, 'Argent Confessor Paletress - SAY_AGGRO'),
(34928, 3, 0, 'Take this time to consider your past deeds.', 14, 0, 100, 0, 0, 16248, 35764, 0, 'Argent Confessor Paletress - SAY_MEMORY_SUMMON'),
(34928, 4, 0, 'Even the darkest memory fades when confronted!', 14, 0, 100, 0, 0, 16249, 35231, 0, 'Argent Confessor Paletress - SAY_MEMORY_DEATH'),
(34928, 5, 0, 'Take your rest.', 14, 0, 100, 0, 0, 16250, 35765, 0, 'Argent Confessor Paletress - SAY_KILL_PLAYER'),
(34928, 5, 1, 'Be at ease.', 14, 0, 100, 0, 0, 16251, 35766, 0, 'Argent Confessor Paletress - SAY_KILL_PLAYER'),
(34928, 6, 0, 'Excellent work!', 14, 0, 100, 0, 0, 16252, 35232, 0, 'Argent Confessor Paletress - SAY_DEFEATED');

-- Eadric the Pure remove empty BroadcastTextId duplicates
DELETE FROM `creature_text` WHERE `CreatureID`=35119;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(35119, 0, 0, 'Are you up to the challenge? I will not hold back.', 12, 0, 100, 397, 0, 16134, 35347, 0, 'Eadric the Pure - SAY_INTRO'),
(35119, 1, 0, 'Prepare yourselves!', 14, 0, 100, 0, 0, 16135, 35758, 0, 'Eadric the Pure - SAY_AGGRO'),
(35119, 2, 0, '%s begins to radiate light. Shield your eyes!', 41, 0, 100, 0, 0, 0, 35415, 0, 'Eadric the Pure - EMOTE_RADIANCE'),
(35119, 3, 0, '%s targets $n with the Hammer of the Righteous!', 41, 0, 100, 0, 0, 16136, 35408, 0, 'Eadric the Pure - EMOTE_HAMMER_RIGHTEOUS'),
(35119, 4, 0, 'Hammer of the Righteous!', 14, 0, 100, 0, 0, 16136, 35442, 0, 'Eadric the Pure - SAY_HAMMER_RIGHTEOUS'),
(35119, 5, 0, 'You! You need more practice.', 14, 0, 100, 0, 0, 16137, 35759, 0, 'Eadric the Pure - SAY_KILL_PLAYER'),
(35119, 5, 1, 'Nay, nay, and I say yet again nay! Not good enough.', 14, 0, 100, 0, 0, 16138, 35760, 0, 'Eadric the Pure - SAY_KILL_PLAYER'),
(35119, 6, 0, 'I yield! I submit. Excellent work. May I run away now?', 14, 0, 100, 0, 0, 16139, 35761, 0, 'Eadric the Pure - SAY_DEFEATED');

-- The Black Knight remove empty BroadcastTextId duplicates
DELETE FROM `creature_text` WHERE `CreatureID`=35451;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(35451, 0, 0, 'You spoiled my grand entrance, rat.', 12, 0, 100, 0, 0, 16256, 35546, 0, 'The Black Knight - SAY_INTRO_1'),
(35451, 1, 0, 'Did you honestly think an agent of the Lich King would be bested on the field of your pathetic little tournament?', 12, 0, 100, 396, 0, 16257, 35548, 0, 'The Black Knight - SAY_INTRO_2'),
(35451, 2, 0, 'I\'ve come to finish my task.', 12, 0, 100, 396, 0, 16258, 35549, 0, 'The Black Knight - SAY_INTRO_3'),
(35451, 3, 0, 'This farce ends here!', 14, 0, 100, 0, 0, 16259, 35767, 0, 'The Black Knight - SAY_AGGRO'),
(35451, 4, 0, 'My rotting flesh was just getting in the way!', 14, 0, 100, 0, 0, 16262, 35771, 0, 'The Black Knight - SAY_PHASE_2'),
(35451, 5, 0, 'I have no need for bones to best you!', 14, 0, 100, 0, 0, 16263, 35772, 0, 'The Black Knight - SAY_PHASE_3'),
(35451, 6, 0, 'Pathetic.', 14, 0, 100, 0, 0, 16260, 35768, 0, 'The Black Knight - SAY_KILL_PLAYER'),
(35451, 6, 1, 'A waste of flesh.', 14, 0, 100, 0, 0, 16261, 35769, 0, 'The Black Knight - SAY_KILL_PLAYER'),
(35451, 7, 0, 'No! I must not fail... again...', 14, 0, 100, 0, 0, 16264, 35770, 0, 'The Black Knight - SAY_DEATH');
