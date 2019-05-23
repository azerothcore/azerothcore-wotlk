INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558616423152525700');

-- Using free entry (175590)
DELETE FROM `gameobject_template` WHERE `entry`=175590;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(175590, 6, 0, 'Spire Spider Egg Trap', '', '', '', 1, 0, 0, 0, 16453, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', -18019);

-- Free guid from gameobject table (267000)
DELETE FROM `gameobject` WHERE `guid`=267000;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(267000, 175590, 229, 0, 0, 1, 1, -139.772, -526.945, 6.41529, 1.5574, -0, -0, -0.702354, -0.711828, 300, 0, 1, '', 0);
