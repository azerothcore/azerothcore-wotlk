INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609118876085874200');

DELETE FROM `gameobject` WHERE (`id` = 192011 and `guid` IN (99732, 2134518));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(99732, 192011, 571, 0, 0, 1, 1, 8426.94, 2921.13, 606.259, 1.61609, 0, 0, -0.722938, -0.690913, 25, 0, 1, '', 0),
(2134518, 192011, 571, 0, 0, 1, 1, 8427.42, 2910.6, 606.259, 1.61609, 0, 0, -0.722938, -0.690913, 300, 0, 1, '', 0);

DELETE FROM `gameobject_template` WHERE (`entry` = 192011);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(192011, 8, 0, 'Thane Ufrang the Mighty\'s Spell Focus', '', '', '', 1, 1571, 17, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', -18019);
