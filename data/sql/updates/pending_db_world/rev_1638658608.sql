INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638658608');

/* Zul'Farrak Shallow Grave TRAP - Made invisible */
DELETE FROM `gameobject_template` WHERE (`entry` = 128972);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(128972, 6, 0, 'Shallow Grave TRAP', '', '', '', 1, 0, 0, 0, 10247, 1, 0, -1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', -18019);

/* Zul'Farrak Shallow Grave - Despawn on Gossip Hello */
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 128308);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(128308, 1, 0, 0, 64, 0, 100, 257, 0, 0, 0, 0, 0, 11, 10247, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shallow Grave - On Gossip Hello - Cast Summon Zul\'Farrak Zombies'),
(128308, 1, 1, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shallow Grave - On Gossip Hello - Despawn');
