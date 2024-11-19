-- DB update 2019_03_22_01 -> 2019_03_22_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_22_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_22_01 2019_03_22_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1553120573757251500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553120573757251500');

-- NPC "Emerald Skytalon" entering/leaving combat and doesn't fly down to attack player (Fix)
DELETE FROM `creature` WHERE `guid` = 105757;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES(105757, 27244, 571, 0, 0, 1, 1, 24453, 0, 2801.95, 7.25871, 4.26567, 4.96257, 300, 0, 0, 9940, 0, 0, 0, 0, 0, '', 0);

-- NPC "Geirrvif" flying too high. The players cant interact with NPC (Fix)
DELETE FROM `creature` WHERE `guid`= 123494;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES(123494, 31135, 571, 0, 0, 1, 1, 27074, 0, 8216.64, 3516.06, 624.996, 3.57661, 300, 0, 0, 12600, 0, 0, 0, 0, 0, '', 0);

-- The Wastewander Rogue should be in stealth while patroling there (Fix)
SET @ENTRY := 5615;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 11, 8218, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When out of combat and timer at the begining between 1000 and 1000 ms (and later repeats every 0 and 0 ms) - Self: Cast spell Sneak (8218) on Self"),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 6000, 10000, 11, 8721, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "When in combat and timer at the begining between 3000 and 6000 ms (and later repeats every 6000 and 10000 ms) - Self: Cast spell Backstab (8721) on Victim");

-- NPC Sunfury Nethermancer" doesn't have/missing attack Ai (Fix)
SET @ENTRY := 20248;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 300000, 300000, 11, 36477, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When out of combat and timer at the begining between 1000 and 1000 ms (and later repeats every 300000 and 300000 ms) - Self: Cast spell Summon Mana Beast (36477) on Self. Sunfury Nethermancer - Out of Combat - Disable Combat Movement"),
(@ENTRY, 0, 1, 0, 9, 0, 100, 0, 0, 30, 3400, 4800, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "When victim in range 0 - 30 yards (check every 3400 - 4800 ms) - Self: Cast spell Shadow Bolt (9613) on Victim. Sunfury Nethermancer - Out of Combat - Cast 'Summon Mana Beast'"),
(@ENTRY, 0, 2, 0, 0, 0, 100, 0, 0, 0, 30000, 35000, 11, 35778, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When in combat and timer at the begining between 0 and 0 ms (and later repeats every 30000 and 35000 ms) - Self: Cast spell Bloodcrystal Surge (35778) on Self. Sunfury Nethermancer - On Aggro - Cast 'Bloodcrystal Surge' (No Repeat)"),
(@ENTRY, 0, 3, 0, 2, 0, 100, 0, 0, 75, 15000, 20000, 11, 17173, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "When health between 0% and 75% (check every 15000 - 20000 ms) - Self: Cast spell Drain Life (17173) on Victim. Sunfury Nethermancer - On Aggro - Cast 'Shadow Bolt' (No Repeat)"),
(@ENTRY, 0, 4, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "When health between 0% and 15% (check every 0 - 0 ms) - Self: Flee for assist. Sunfury Nethermancer - On Aggro - Increment Phase By 1 (No Repeat)"),
(@ENTRY, 0, 5, 0, 1, 0, 50, 0, 10000, 20000, 15000, 30000, 11, 34397, 0, 0, 0, 0, 0, 19, 19421, 30, 0, 0, 0, 0, 0, "When out of combat and timer at the begining between 10000 and 20000 ms (and later repeats every 15000 and 30000 ms) (50% chance) - Self: Cast spell Red Beam (34397) on Closest alive creature Netherstorm Crystal Target (19421) in 30 yards. 20248 - Ooc - Cast Red Beam");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
