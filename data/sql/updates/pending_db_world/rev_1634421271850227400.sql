INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634421271850227400');

-- Remove spawns of Ogre Remains trap.
DELETE FROM `gameobject` WHERE `guid` IN (13618, 13650, 13753, 13755, 14669, 14921, 30216, 30218, 30220, 30222, 32867, 32869, 32871, 32883, 33559, 40761, 40763, 40765, 40767, 40795, 40799, 40801, 40803, 40805, 40808, 40812, 40815, 40817);
DELETE FROM `gameobject_addon` WHERE `guid` IN (13618, 13650, 13753, 13755, 14669, 14921, 30216, 30218, 30220, 30222, 32867, 32869, 32871, 32883, 33559, 40761, 40763, 40765, 40767, 40795, 40799, 40801, 40803, 40805, 40808, 40812, 40815, 40817);

-- Remove spawns of Blood of Heroes trap.
DELETE FROM `gameobject` WHERE `guid` IN (45513, 45515, 45854, 45869, 45935, 45937) AND `id` = 176214;
DELETE FROM `gameobject_addon` WHERE `guid` IN (45513, 45515, 45854, 45869, 45935, 45937);

-- Insert missing gameobject...
DELETE FROM `gameobject_template` WHERE `entry` = 195641;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(195641, 6, 0, 'Brazier', '', '', '',  1, 0, 1, 1, 7897, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', -18019);
