-- testing purposes from https://github.com/azerothcore/azerothcore-wotlk/pull/22676/files
-- Fix Heb''Drakkar Headhunter waypoints error in server console
UPDATE waypoint_data
SET action = 0
WHERE id = 1133640 AND point = 3;

INSERT INTO smart_scripts (
  entryorguid, source_type, id, `link`,
  event_type, event_param1, event_param2, event_param3, event_param4,
  action_type, action_param1, action_param2, action_param3,
  target_type, comment
) VALUES (
  28600, 0, 0, 0,
  40, 3, 0, 0, 0,        -- SMART_EVENT_WAYPOINT_REACHED, point 3
  11, 52059, 0, 0,       -- SMART_ACTION_CAST, spell 52059
  1, 'Heb''Drakkar Headhunter - WP3 - Cast 52059 on self'  -- SMART_TARGET_SELF
);

-- Joseph Wilson  waypoints error in server console

-- 1) Add a delay (4000 ms) at step 4
UPDATE waypoints
SET delay = 4000
WHERE entry = 33589 AND pointid = 4;

-- 2) Remove the redundant pause + the linked action
DELETE FROM smart_scripts
WHERE source_type = 0 AND entryorguid = 33589 AND id IN (2,3);

-- From 0 (all) to 690 (only horde)
UPDATE `quest_template` SET `AllowableRaces` = 690 WHERE `ID` = 2283;

-- 3) Recreate the orientation as a direct event on WP 4
INSERT INTO smart_scripts (
  entryorguid, source_type, id, `link`,
  event_type, event_param1, event_param2, event_param3, event_param4,
  action_type, action_param1, action_param2, action_param3,
  target_type, comment
) VALUES (
  33589, 0, 2, 0,
  40, 4, 0, 0, 0,             -- SMART_EVENT_WAYPOINT_REACHED, point 4
  66, 3, 0, 0,                -- SMART_ACTION_SET_ORIENTATION, orientation 3
  8, 'Joseph Wilson - On WP 4 Reached - Set Orientation 3'--


-- Example 1: creature_template with mechanic_immune_mask
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299803 WHERE `entry` = 7727;

-- Example 2: item_template with Flags
UPDATE `item_template` SET `Flags` = 2048 WHERE `entry` = 12345;

-- Example 3: creature with unit_flags
UPDATE `creature` SET `unit_flags` = 768 WHERE `guid` = 98765;

-- Example 4: quest_template with Flags
UPDATE `quest_template` SET `Flags` = 4194304 WHERE `ID` = 54321;

-- Example 5: INSERT with hardcoded values
INSERT INTO `creature_template` (`entry`, `mechanic_immune_mask`) VALUES (12345, 617299803);

-- 1. Using Bitwise OR to Add Flags
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|64|256|1024 WHERE `entry` = 7727;
UPDATE `item_template` SET `Flags`=`Flags`|2048 WHERE `entry` = 12345;
UPDATE `creature` SET `unit_flags`=`unit_flags`|(256|512) WHERE `guid` = 98765;

-- 2. Using Bitwise AND with NOT to Remove Flags
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`&~(64|256|1024) WHERE `entry` = 7727;
UPDATE `item_template` SET `Flags`=`Flags`&~2048 WHERE `entry` = 12345;
UPDATE `creature` SET `unit_flags`=`unit_flags`&~(256|512|1024) WHERE `guid` = 98765;

-- 3. Using Left/Right Shift Operators
UPDATE `item_template` SET `Flags` = 1<<11 WHERE `entry` = 12345;
UPDATE `creature_template` SET `type_flags` = 1024>>2 WHERE `entry` = 7727;
UPDATE `quest_template` SET `Flags` = (1<<22)|(1<<10) WHERE `ID` = 54321;

-- 4. Using XOR Operator
UPDATE `creature` SET `unit_flags`=`unit_flags`^256 WHERE `guid` = 98765;
UPDATE `spell_proc` SET `ProcFlags`=`ProcFlags`^(64|128) WHERE `SpellID` = 12345;

-- 5. Special Allowed Values
UPDATE `creature_template` SET `mechanic_immune_mask` = 0 WHERE `entry` = 7727;
UPDATE `item_template` SET `Flags` = NULL WHERE `entry` = 12345;
UPDATE `creature` SET `unit_flags` = null WHERE `guid` = 98765;

-- 6. Variables and Function Calls (Allowed)
UPDATE `creature_template` SET `mechanic_immune_mask` = @some_mask_variable WHERE `entry` = 7727;
UPDATE `item_template` SET `Flags` = CALCULATE_FLAGS() WHERE `entry` = 12345;
UPDATE `creature` SET `unit_flags` = `some_column` WHERE `guid` = 98765;

-- 7. Complex Bitwise Combinations
UPDATE `creature_template` SET `mechanic_immune_mask`=(`mechanic_immune_mask`|64)&~256 WHERE `entry` = 7727;
UPDATE `spell_proc` SET `SchoolMask`=~0 WHERE `SpellID` = 12345;
UPDATE `quest_template` SET `Flags`=(1<<10)|(1<<15)&~(1<<5) WHERE `ID` = 54321;

-- 8. INSERT Examples (Also Pass)
INSERT INTO `creature_template` (`entry`, `mechanic_immune_mask`) VALUES (12345, 64|256|1024);
INSERT INTO `item_template` (`entry`, `Flags`) VALUES (98765, 1<<11);
INSERT INTO `creature` (`guid`, `unit_flags`) VALUES (12345, 0);
INSERT INTO `quest_template` (`ID`, `Flags`) VALUES (54321, @quest_flags);
INSERT INTO `spell_proc` (`SpellID`, `ProcFlags`) VALUES (12345, (1<<5)|(1<<10));

UPDATE `creature` SET `unit_flags` = 489;