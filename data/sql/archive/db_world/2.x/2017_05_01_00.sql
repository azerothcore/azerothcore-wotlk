-- DB update 2017_03_04_20 -> 2017_05_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_03_04_20';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_03_04_20 2017_05_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1481933990013483700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1481933990013483700');

UPDATE `creature_template` SET `ScriptName`='npc_scarlet_guard' WHERE `entry`=4295;

UPDATE `creature_template` SET `ScriptName`='npc_scarlet_guard' WHERE `entry`=4298;
UPDATE `creature_template` SET `ScriptName`='npc_scarlet_guard' WHERE `entry`=4301;
UPDATE `creature_template` SET `ScriptName`='npc_scarlet_guard' WHERE `entry`=4294;
UPDATE `creature_template` SET `ScriptName`='npc_scarlet_guard' WHERE `entry`=4300;
UPDATE `creature_template` SET `ScriptName`='npc_scarlet_guard' WHERE `entry`=4303;
UPDATE `creature_template` SET `ScriptName`='npc_scarlet_guard' WHERE `entry`=4540;
UPDATE `creature_template` SET `ScriptName`='npc_scarlet_guard' WHERE `entry`=4302;
UPDATE `creature_template` SET `ScriptName`='npc_scarlet_guard' WHERE `entry`=4299;
UPDATE `creature_template` SET `ScriptName`='npc_fairbanks' WHERE `entry`=4542;
UPDATE `creature_template` SET `ScriptName`='npc_scarlet_commander_mograine' WHERE `entry`=3976;

DELETE FROM `creature_text` WHERE `entry`=4298;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4298, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4298, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4298, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4298, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4298, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4298, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');

DELETE FROM `creature_text` WHERE `entry`=4295;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4295, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4295, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4295, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4295, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4295, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4295, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, ''),
(4295, 1, 0, 'There is no escape for you. The Crusade shall destroy all who carry the scourge\'s taint.', 12, 7, 0, 0, 0, 0, 'Scarlet Myrmidon - Talk on low HP');

DELETE FROM `creature_text` WHERE `entry`=4301;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4301, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4301, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4301, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4301, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4301, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4301, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');

DELETE FROM `creature_text` WHERE `entry`=4294;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4294, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4294, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4294, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4294, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4294, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4294, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');

DELETE FROM `creature_text` WHERE `entry`=4300;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4300, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4300, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4300, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4300, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4300, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4300, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');

DELETE FROM `creature_text` WHERE `entry`=4303;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4303, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4303, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4303, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4303, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4303, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4303, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');

DELETE FROM `creature_text` WHERE `entry`=4540;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4540, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4540, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4540, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4540, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4540, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4540, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');

DELETE FROM `creature_text` WHERE `entry`=4302;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4302, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4302, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4302, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4302, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4302, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4302, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');

DELETE FROM `creature_text` WHERE `entry`=4299;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4299, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4299, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4299, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4299, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4299, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4299, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');

-- -- highlord mograine AI
SET @ENTRY := 16440; 
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,1,0,0,0,0,53,0,@ENTRY,0,0,0,0,1,0,0,0,0,0,0,0,"Highlord Mograine Transform - On Reset - Start Waypoint (No Repeat)"),
(@ENTRY, 0, 1, 0, 40, 0, 100, 0, 5, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine Transform - On Waypoint 5 Reached - Stop Waypoint');

UPDATE creature_template SET AIname = 'SmartAI' WHERE scriptname = 'npc_scarlet_guard' OR entry = @ENTRY;

-- renault mograine waypoints
DELETE FROM `waypoints` WHERE `entry`=@ENTRY;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(@ENTRY, 1, 1084.703857, 1399.461548, 30.30381, 'Renault'),
(@ENTRY, 2, 1103.323486, 1399.347778, 30.306072, 'Renault'),
(@ENTRY, 3, 1137.175415, 1399.250854, 30.307892, 'Renault'),
(@ENTRY, 4, 1145.000122, 1399.300293, 31.820765, 'Renault'),
(@ENTRY, 5, 1148.536377, 1398.986938, 31.972290, 'Renault');

-- renault text
DELETE FROM `creature_text` WHERE `entry`=3976 AND `groupid`>=3;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(3976, 3, 0, 'You hold my father\'s blade. My soldiers are yours to control, my Lord. Take them... Lead them... The impure must be purged. They must be cleansed of their taint.', 12, 0, 100, 0, 0, 0, 'mograine SAY_ASHBRINGER_ONE'),
(3976, 4, 0, 'Father... But... How?', 12, 0, 100, 0, 0, 0, 'mograine SAY_ASHBRINGER_TWO'),
(3976, 5, 0, 'Forgive me, father! Please...', 12, 0, 100, 0, 0, 0, 'mograine SAY_ASHBRINGER_THREE');

-- highlord mograine text
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(@ENTRY, 0, 0, 'Renault...', 12, 0, 100, 0, 0, 0, 'mograine MOGRAINE_ONE'),
(@ENTRY, 1, 0, 'Did you think that your betrayal would be forgotten? Lost in the carefully planned cover up of my death? Blood of my blood, the blade felt your cruelty long after my heart had stopped beating. And in death, I knew what you had done. But now, the chains of Kel\'thuzad hold me no more. I come to serve justice. I AM ASHBRINGER.', 12, 0, 100, 0, 0, 0, 'mograine MOGRAINE_TWO'),
(@ENTRY, 2, 0, 'You are forgiven...', 12, 0, 100, 0, 0, 0, 'mograine MOGRAINE_THREE');

-- fairbank gossip
DELETE FROM `npc_text` WHERE ID BETWEEN 100100 AND 100116;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES
(100100, "At last, the curse is lifted. Thank you hero."),
(100101, "You mean, you don't know? The sword that you carry on your back - it is known as Ashbringer; named after its original owner."),
(100102, "Aye, the Highlord Mograine: A founder of the original order of the Scarlet Crusade. A knight of unwavering faith and purity; Mograine would be betrayed by his own son and slain by Kel'Thuzad's forces inside Stratholme. It is how I ended up here..."),
(100103, "It was High General Abbendis, High Inquisitor Isillien, and Highlord Mograine that formed the Crusade. In its infancy, the Crusade was a noble order. The madness and insane zealotry that you see now did not exist. It was not until the one known as Grand Crusader appeared that the wheels of corruption were set in motion."),
(100104, "The Highlord was the lynchpin of the Crusade. Aye, Mograine was called the Ashbringer because of his exploits versus the armies of the Lich King. With only blade and faith, Mograine would walk into whole battalions of undead and emerge unscathed - the ashes of his foes being the only indication that he had been there at all. Do you not understand? The very face of death feared him! It trembled in his presence!"),
(100105, "The only way a hero can die, $R: Through tragedy. The Grand Crusader struck a deal with Kel'Thuzad himself! An ambush would be staged that would result in the death of Mograine. The type of betrayal that could only be a result of the actions of one's most trusted and loved companions."),
(100106, "<High Inquisitor Fairbanks nods.>\n\nAye, the lesser Mograine, the one known as the Scarlet Commander, through - what I suspect - the dealings of the Grand Crusader. He led his father to the ambush like a lamb to the slaughter."),
(100107, "<High Inquisitor Fairbanks lifts up his tabard revealing several gruesome scars.>\n\nBecause I was there... I was the Highlord's most trusted advisor. I should have known... I felt that something was amiss yet I allowed it to happen. Would you believe that there were a thousand or more Scourge?"),
(100108, "This was the Ashbringer, fool! As the Scourge began to materialize around us, Mograine's blade began to glow... to hum... the younger Mograine would take that as a sign to make his escape. They descended upon us with a hunger the likes of which I had never seen. Yet..."),
(100109, "It was not enough.\n\n<Fairbanks smirks briefly, lost in a memory.>\n\nA thousand came and a thousand died. By the Light! By the might of Mograine! He would smite them down as fast as they could come. Through the chaos, I noticed that the lesser Mograine was still there, off in the distance. I called him, 'Help us, Renault! Help your father, boy!'"),
(100110, "<High Inquisitor Fairbanks shakes his head.>\n\nNo... He stood in the background, watching as the legion of undead descended upon us. Soon after, my powers were exhausted. I was the first to fall... Surely they would tear me limb from limb as I lay there unconscious; but they ignored me completely, focusing all of their attention on the Highlord."),
(100111, "It was all I could do to feign death as the corpses of the Scourge piled upon me. There was darkness and only the muffled sounds of the battle above me. The clashing of iron, the gnashing and grinding... gruesome, terrible sounds. And then there was silence. He called to me! 'Fairbanks!Fairbanks, where are you ? Talk to me, Fairbanks!' And then came the sound of incredulousness. The bite of betrayal, $R..."),
(100112, "The boy had picked up Ashbringer and driven it through his father's heart as his back was turned. His last words will haunt me forever: 'What have you done, Renault? Why would you do this?'"),
(100113, "The blade and Mograine were a singular entity. Do you understand? This act corrupted the blade and lead to Mograine's own corruption as a death knight of Kel'Thuzad. I swore that if I lived, I would expose the perpetrators of this heinous crime. For two days I remained under the rot and contagion of Scourge - gathering as much strength as possible to escape the razed city."),
(100114, "Aye, I did. Much to the dismay of the lesser Mograine, I made my way back to the Scarlet Monastery. I shouted and screamed. I told the tale to any that would listen. And I would be murdered in cold blood for my actions, dragged to this chamber - the dark secret of the order. But some did listen... some heard my words. Thus was born the Argent Dawn..."),
(100115, "I'm afraid that the blade which you hold in your hands is beyond saving. The hatred runs too deep. But do not lose hope, hero. Where one chapter has ended, a new one begins. $B Find his son - a more devout and pious man you may never meet.It is rumored that he is able to build the Ashbringer anew, without requiring the old, tainted blade."),
(100116, "<High Inquisitor Fairbanks shakes his head.>\n\nNo, $C; only one of his sons is dead. The other lives...\n\n<High Inquisitor Fairbanks points to the sky>\n\nThe Outland... Find him there...");
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
