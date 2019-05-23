INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558616423152525700');

-- Using free entry (175590)
DELETE FROM `gameobject_template` WHERE `entry`=175590;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(175590, 6, 0, 'Spire Spider Egg Trap', '', '', '', 1, 0, 0, 0, 16453, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', -18019);

-- Free guid from gameobject table (267000)
DELETE FROM `gameobject` WHERE `guid`=267000;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(267000, 175590, 229, 0, 0, 1, 1, -139.772, -526.945, 6.41529, 1.5574, -0, -0, -0.702354, -0.711828, 300, 0, 1, '', 0);

-- Spire Spiderling SAI
SET @ENTRY := 10375;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,1,0,100,0,0,0,0,0,89,15,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Spire Spiderling - Out of Combat - Random Move"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,0,0,0,0,8,0,0,0,0,0,0,17,5,10,0,0.0,0.0,0.0,0.0,"Spire Spiderling - In combat - Set React state "),
(@ENTRY,@SOURCETYPE,2,0,7,0,100,0,0,0,0,0,41,150,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Spide Spiderling - On Evade - Despawn");
