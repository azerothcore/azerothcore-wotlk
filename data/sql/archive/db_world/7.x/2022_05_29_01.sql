-- DB update 2022_05_29_00 -> 2022_05_29_01
-- Quest 8891 "Abandoned Investigations" turn in script

-- Magister Duskwither SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=15951;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (15951) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (159510) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(15951,0,0,0,20,0,100,0,8891,0,0,0,0,80,159510,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Magister Duskwither - ON Quest Reward (Abandoned Investigations)  - Run Script'),
(159510,9,0,0,0,0,100,0,0,0,0,0,0,83,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Magister Duskwither - Script - Remove npc flags'),
(159510,9,1,0,0,0,100,0,3000,3000,0,0,0,71,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Magister Duskwither - Script - Update equipment to book'),
(159510,9,2,0,0,0,100,0,1500,1500,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0.61086523,'Magister Duskwither - Script - Set facing'),
(159510,9,3,0,0,0,100,0,8000,8000,0,0,0,5,61,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Magister Duskwither - Script - Play emote OneShotAttackThrown'),
(159510,9,4,0,0,0,100,0,0,0,0,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Magister Duskwither - Script - Update equipment to none'),
(159510,9,5,0,0,0,100,0,1000,1000,0,0,0,50,181012,16,0,0,0,0,8,0,0,0,0,9049.71,-7434.27,84.6563,2.09439,'Magister Duskwither - Script  - Spawn Magister Duskwithers Journal'),
(159510,9,6,0,0,0,100,0,6000,6000,0,0,0,11,26660,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Magister Duskwither - Script  - CAST Duskwither''s Fireball'),
(159510,9,7,0,0,0,100,0,4000,4000,0,0,0,50,181013,12,0,0,0,0,8,0,0,0,0,9049.428,-7434.1753,85.13704,1.2566359,'Magister Duskwither - Script  - Spawn Fire'),
(159510,9,8,0,0,0,100,0,2000,2000,0,0,0,71,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Magister Duskwither - Script - Update equipment to staff'),
(159510,9,9,0,0,0,100,0,300,300,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Magister Duskwither - Script  - Say Line 1'),
(159510,9,10,0,0,0,100,0,6000,6000,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,5.1487212,'Magister Duskwither - Script - Set facing'),
(159510,9,11,0,0,0,100,0,2000,2000,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Magister Duskwither - Script - Set npc flags');

-- Add Missing book equipment
DELETE FROM `creature_equip_template` WHERE `CreatureID`=15951 AND `ID`=2;
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`,`VerifiedBuild`) VALUES (15951,2,12751,0,0,0);

-- Add missing spell target position
DELETE FROM `spell_target_position` WHERE `ID`=26660;
INSERT INTO `spell_target_position` (`ID`,`EffectIndex`,`MapID`,`PositionX`,`PositionY`,`PositionZ`,`Orientation`,`VerifiedBuild`) VALUES
(26660,0,530,9050,-7434,85,0,0);
