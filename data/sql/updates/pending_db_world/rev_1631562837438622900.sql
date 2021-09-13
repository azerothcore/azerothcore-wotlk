-- Terrowulf Packlord Fix
-- Lushen#4800 @ Discord

-- Rev Add
INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631562837438622900');

-- This is deleting the Old Entry and adds the new one with the corrected Walking Speed.
DELETE FROM `creature_template` WHERE `entry`=3792;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (3792, 0, 0, 0, 0, 0, 522, 0, 0, 0, 'Terrowulf Packlord', NULL, NULL, 0, 31, 32, 0, 16, 0, 1, 1.14286, 20, 1, 4, 0, 1, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 3792, 0, 3792, 0, 0, 49, 69, 'SmartAI', 0, 3, 1, 1.1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);

-- This is deleting the Old Entry in the creature Table and adds the new one with a 21h Spawntimer, since thats what the most people
-- expierienced him to spawn at. (approx)
DELETE FROM `creature` WHERE `guid`=3792;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (3792, 5996, 0, 0, 0, 1, 1, 6721, 1, -10610.2, -3506.41, 0.812838, 3.28122, 75600, 0, 0, 2488, 0, 0, 0, 0, 0, '', 0);
