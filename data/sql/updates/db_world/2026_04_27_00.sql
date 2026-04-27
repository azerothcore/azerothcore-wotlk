-- DB update 2026_04_27_00
-- Alliance (900001) and Horde (900002) Death Knight class trainers (TrainerId 13).
-- 3.3.5a: four Alliance and four Horde racial starting areas each; four capitals per faction
-- (SW, Ironforge, Darnassus, Exodar — Orgrimmar, Undercity, Thunder Bluff, Silvermoon).
-- Display models: Lady Alistra (Alliance) and Lord Thorval (Horde).

SET @ENTRY_ALLIANCE := 900001;
SET @ENTRY_HORDE := 900002;

DELETE FROM `creature` WHERE `Comment` = 'Ebon Blade roaming DK trainer' AND `id1` IN (@ENTRY_ALLIANCE, @ENTRY_HORDE);
DELETE FROM `creature_default_trainer` WHERE `CreatureId` IN (@ENTRY_ALLIANCE, @ENTRY_HORDE);
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (@ENTRY_ALLIANCE, @ENTRY_HORDE);
DELETE FROM `creature_template` WHERE `entry` IN (@ENTRY_ALLIANCE, @ENTRY_HORDE);

-- Cloned from 28471 / 28472 (Acherus DK trainers) so the column set matches 2026_03_22_03
-- (no `scale`/immune mask columns; `CreatureImmunitiesId` instead). Override identity, levels,
-- faction, trainer `npcflag`, `unit_flags`, no loot, no immunities, no SmartAI. Display: `creature_template_model`.
INSERT INTO `creature_template` (
  `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
)
SELECT
  @ENTRY_ALLIANCE, t.`difficulty_entry_1`, t.`difficulty_entry_2`, t.`difficulty_entry_3`, t.`KillCredit1`, t.`KillCredit2`, 'Sylvian Nightblade', 'Ebon Blade Trainer', t.`IconName`, 0, 60, 60, 0, 11, 19, t.`speed_walk`, t.`speed_run`, t.`speed_swim`, t.`speed_flight`, t.`detection_range`, t.`rank`, t.`dmgschool`, t.`DamageModifier`, t.`BaseAttackTime`, t.`RangeAttackTime`, t.`BaseVariance`, t.`RangeVariance`, t.`unit_class`, 0, t.`unit_flags2`, t.`dynamicflags`, t.`family`, t.`type`, t.`type_flags`, 0, 0, 0, 0, 0, 0, 0, '', t.`MovementType`, 1, 1, 1, 1, 1, t.`RacialLeader`, t.`movementId`, t.`RegenHealth`, 0, t.`flags_extra`, '', t.`VerifiedBuild`
FROM `creature_template` t WHERE t.`entry` = 28471;

INSERT INTO `creature_template` (
  `entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`
)
SELECT
  @ENTRY_HORDE, t.`difficulty_entry_1`, t.`difficulty_entry_2`, t.`difficulty_entry_3`, t.`KillCredit1`, t.`KillCredit2`, 'Gorth\'rok Felblade', 'Ebon Blade Trainer', t.`IconName`, 0, 60, 60, 0, 85, 19, t.`speed_walk`, t.`speed_run`, t.`speed_swim`, t.`speed_flight`, t.`detection_range`, t.`rank`, t.`dmgschool`, t.`DamageModifier`, t.`BaseAttackTime`, t.`RangeAttackTime`, t.`BaseVariance`, t.`RangeVariance`, t.`unit_class`, 0, t.`unit_flags2`, t.`dynamicflags`, t.`family`, t.`type`, t.`type_flags`, 0, 0, 0, 0, 0, 0, 0, '', t.`MovementType`, 1, 1, 1, 1, 1, t.`RacialLeader`, t.`movementId`, t.`RegenHealth`, 0, t.`flags_extra`, '', t.`VerifiedBuild`
FROM `creature_template` t WHERE t.`entry` = 28472;

INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(@ENTRY_ALLIANCE,0,25458,1,1,12340),
(@ENTRY_HORDE,0,25459,1,1,12340);

INSERT INTO `creature_default_trainer` (`CreatureId`, `TrainerId`) VALUES
(@ENTRY_ALLIANCE,13),
(@ENTRY_HORDE,13);

-- 8 + 8 = 16 spawns (4 racial starts + 4 capitals per side). Positions: near `playercreateinfo` defaults with small offset.
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
-- Alliance: racial starting areas (4)
(5302000, @ENTRY_ALLIANCE,0,0,0,12,0,1,1,0,-8942.0,-128.0,84.0,3.2,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302001, @ENTRY_ALLIANCE,0,0,0,1,0,1,1,0,-6228.0,330.0,382.5,4.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302002, @ENTRY_ALLIANCE,0,0,1,141,0,1,1,0,10298.0,826.0,1322.0,0.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302003, @ENTRY_ALLIANCE,0,0,530,3524,0,1,1,0,-3965.0,-13924.0,100.0,0.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
-- Alliance: capitals (4)
(5302004, @ENTRY_ALLIANCE,0,0,0,1519,0,1,1,0,-8960.0,520.0,96.5,0.5,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302005, @ENTRY_ALLIANCE,0,0,0,1537,0,1,1,0,-4835.0,-1160.0,502.0,1.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302006, @ENTRY_ALLIANCE,0,0,1,1657,0,1,1,0,10185.0,2563.0,1326.0,0.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302007, @ENTRY_ALLIANCE,0,0,530,3559,0,1,1,0,-4006.0,-11558.0,6.0,4.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
-- Horde: racial starting areas (4)
(5302008, @ENTRY_HORDE,0,0,1,14,0,1,1,0,-620.0,-4245.0,38.0,0.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302009, @ENTRY_HORDE,0,0,0,85,0,1,1,0,1680.0,1670.0,120.0,0.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302010, @ENTRY_HORDE,0,0,1,215,0,1,1,0,-2912.0,-256.0,53.0,0.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302011, @ENTRY_HORDE,0,0,530,3430,0,1,1,0,10355.0,-6355.0,33.0,0.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
-- Horde: capitals (4)
(5302012, @ENTRY_HORDE,0,0,1,1637,0,1,1,0,1604.0,-4405.0,8.0,2.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302013, @ENTRY_HORDE,0,0,0,1497,0,1,1,0,1634.0,240.0,52.0,2.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302014, @ENTRY_HORDE,0,0,1,1638,0,1,1,0,-1282.0,180.0,131.0,0.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer'),
(5302015, @ENTRY_HORDE,0,0,530,3487,0,1,1,0,9502.0,-7235.0,15.0,3.0,300,0,0,0,0,0,0,0,0,'',0,0,'Ebon Blade roaming DK trainer');
