--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_command_argent_skytalon';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_ride_freed_proto_drake';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_onslaught_gryphon';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_bone_gryphon';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_ride_flamebringer';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_wyrmrest_defender_mount';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_wintergarde_gryphon_commander';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_purge_vehicle_control';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43813, 'spell_gen_purge_vehicle_control'),
(48205, 'spell_gen_purge_vehicle_control'),
(48367, 'spell_gen_purge_vehicle_control'),
(48706, 'spell_gen_purge_vehicle_control'),
(49087, 'spell_gen_purge_vehicle_control'),
(50068, 'spell_gen_purge_vehicle_control'),
(48365, 'spell_wintergarde_gryphon_commander'),
(49256, 'spell_wyrmrest_defender_mount'),
(48600, 'spell_ride_flamebringer'),
(21745, 'spell_bone_gryphon'),
(49641, 'spell_onslaught_gryphon'),
(55029, 'spell_ride_freed_proto_drake'),
(56678, 'spell_command_argent_skytalon');

SET @NPC_FLAMRBRINGER := 27292;
DELETE FROM `creature_text` WHERE `CreatureID`=@NPC_FLAMRBRINGER;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NPC_FLAMRBRINGER, 0, 0, 'Flamebringer attempts to throw you from his back. Return to Voidrune!', 42, 0, 100, 0, 0, 0, 26546, 0, 'Area Warning');

SET @NPC_WYRMREST_DEFENDER := 27629;
DELETE FROM `creature_text` WHERE `CreatureID`=@NPC_WYRMREST_DEFENDER;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NPC_WYRMREST_DEFENDER, 0, 0, 'Turn around and get back in the fight flight or i\'ll have to drop you off!', 42, 0, 100, 0, 0, 0, 27342, 0, 'Area Warning');

SET @NPC_WINTERGARDE_GRYPHON := 27258;
DELETE FROM `creature_text` WHERE `CreatureID`=@NPC_WINTERGARDE_GRYPHON;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NPC_WINTERGARDE_GRYPHON, 0, 0, 'Return to Wintergarde or the Carrion Fields or your gryphon will drop you!', 42, 0, 100, 0, 0, 0, 26372, 0, 'Area Warning');

SET @NPC_BONE_GRYPHON := 29414;
DELETE FROM `creature_text` WHERE `CreatureID`=@NPC_BONE_GRYPHON;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NPC_BONE_GRYPHON, 0, 0, 'Return to Onslaught Harbor or lose your Bone Gryphon!', 42, 0, 100, 0, 0, 0, 30115, 0, 'Area Warning');

SET @NPC_ONSLAUGHT_GRYPHON := 29403;
DELETE FROM `creature_text` WHERE `CreatureID`=@NPC_ONSLAUGHT_GRYPHON;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NPC_ONSLAUGHT_GRYPHON, 0, 0, 'Return to Icecrown or lose the Onslaught Gryphon!', 42, 0, 100, 0, 0, 0, 30114, 0, 'Area Warning');

SET @FREED_PROTO_DRAKE := 29709;
UPDATE `creature_text` SET `GroupID`='1', `ID`='0' WHERE  `CreatureID`=@FREED_PROTO_DRAKE AND `GroupID`=0 AND `ID`=1;

SET @ARGENT_SKYTALON := 30228;
DELETE FROM `creature_text` WHERE `CreatureID`=@ARGENT_SKYTALON;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ARGENT_SKYTALON, 0, 0, 'You may only fly in the Argent Vanguard, Valley of Echoes and Scourgeholme.', 42, 0, 100, 0, 0, 0, 31131, 0, 'Area Warning');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 16 AND `SourceGroup` = 0 AND `SourceEntry` = 29414 AND `SourceId` = 0 AND `ElseGroup` = 0 AND `ConditionTypeOrReference` = 23 AND `ConditionTarget` = 0 AND `ConditionValue1` = 4417 AND `ConditionValue2` = 0 AND `ConditionValue3` = 0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 16 AND `SourceGroup` = 0 AND `SourceEntry` = 27292 AND `SourceId` = 0 AND `ElseGroup` = 0 AND `ConditionTypeOrReference` = 23 AND `ConditionTarget` = 0 AND `ConditionValue1` = 4207 AND `ConditionValue2` = 0 AND `ConditionValue3` = 0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 16 AND `SourceGroup` = 0 AND `SourceEntry` = 27629 AND `SourceId` = 0 AND `ElseGroup` = 0 AND `ConditionTypeOrReference` = 4 AND `ConditionTarget` = 0 AND `ConditionValue1` = 65 AND `ConditionValue2` = 0 AND `ConditionValue3` = 0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 16 AND `SourceGroup` = 0 AND `SourceEntry` = 27258 AND `SourceId` = 0 AND `ElseGroup` = 0 AND `ConditionTypeOrReference` = 23 AND `ConditionTarget` = 0 AND `ConditionValue1`= 4188 AND `ConditionValue2` = 0 AND `ConditionValue3` = 0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 16 AND `SourceGroup` = 0 AND `SourceEntry` = 27258 AND `SourceId` = 0 AND `ElseGroup` = 1 AND `ConditionTypeOrReference` = 23 AND `ConditionTarget` = 0 AND `ConditionValue1`= 4177 AND `ConditionValue2` = 0 AND `ConditionValue3` = 0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 16 AND `SourceGroup` = 0 AND `SourceEntry` = 27258 AND `SourceId` = 0 AND `ElseGroup` = 2 AND `ConditionTypeOrReference` = 23 AND `ConditionTarget` = 0 AND `ConditionValue1`= 4178 AND `ConditionValue2` = 0 AND `ConditionValue3` = 0;

-- https://www.wowhead.com/spell=51272/boundary-warning
-- Duration: 11 seconds
/* mod */
-- Effect_2: Apply Aura Periodically Trigger Spell with Value Purge Vehicle Control 
-- Value: 123 every 10,5 seconds
INSERT IGNORE INTO `spell_dbc` VALUES
(51272, 0, 0, 0, 603979776, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2207, 0, 0, 'Boundary Warning', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712172, 'This vehicle is out of bounds. Return to the field of battle at once!', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 'This vehicle is out of bounds. Return to the field of battle at once!', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);

UPDATE `spell_dbc` SET `Effect_2` = 6, `EffectDieSides_2` = 1, `EffectBasePoints_2` = 122, `ImplicitTargetA_2` = 1, `EffectAura_2` = 227, `EffectAuraPeriod_2` = 10500, `EffectTriggerSpell_2` = 50068 WHERE (`ID` = 51272);

-- https://www.wowhead.com/spell=51259/boundary-warning
-- Duration: 16 seconds
/* mod */
-- Effect_2: Apply Aura Periodically Trigger Spell with Value Purge Vehicle Control 
-- Value: 123 every 15,5 seconds
INSERT IGNORE INTO `spell_dbc` VALUES
(51259, 0, 0, 0, 603979776, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 387, 0, 0, 0, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2207, 0, 0, 'Boundary Warning', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712172, 'This vehicle is out of bounds. Return to the field of battle at once!', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 'This vehicle is out of bounds. Return to the field of battle at once!', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);

UPDATE `spell_dbc` SET `Effect_2` = 6, `EffectDieSides_2` = 1, `EffectBasePoints_2` = 122, `ImplicitTargetA_2` = 1, `EffectAura_2` = 227, `EffectAuraPeriod_2` = 15500, `EffectTriggerSpell_2` = 50068 WHERE (`ID` = 51259);

-- https://www.wowhead.com/spell=56966/boundary-warning
-- Duration: 16 seconds
/* mod */
-- Effect_3: Apply Aura Periodically Trigger Spell with Value Purge Vehicle Control
-- Value: 123 every 15,5 seconds
INSERT IGNORE INTO `spell_dbc` VALUES
(56966, 0, 0, 0, 603979776, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 387, 0, 0, 0, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2207, 0, 0, 'Boundary Warning', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712172, 'This vehicle is out of bounds. Return to the field of battle at once!', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 'This vehicle is out of bounds. Return to the field of battle at once!', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);

UPDATE `spell_dbc` SET `Effect_3` = 6, `EffectDieSides_3` = 1, `EffectBasePoints_3` = 122, `ImplicitTargetA_3` = 1, `EffectAura_3` = 227, `EffectAuraPeriod_3` = 15500, `EffectTriggerSpell_3` = 50068 WHERE (`ID` = 56966);