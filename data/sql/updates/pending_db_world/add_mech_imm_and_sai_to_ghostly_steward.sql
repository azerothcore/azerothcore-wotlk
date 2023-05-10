--
-- mechanical immunities changes
UPDATE `creature_template`
SET `mechanic_immune_mask` = `mechanic_immune_mask`|2|16|64|256|512|1024|2048|4096|8192|131072|524288|4194304|8388608|33554432, `flags_extra` = `flags_extra`|256 WHERE `entry` = 16414;

-- smart scripts changes
UPDATE `smart_scripts`
SET `event_param1` = 50, `event_param2` = 50, `comment` = 'Ghostly Steward - At Health 50% - Cast Frenzy'
WHERE `entryorguid` = 16414 AND `source_type` = 0 AND `id` = 4;

UPDATE `smart_scripts`
SET `link` = 6, `comment` = 'Ghostly Steward - At Health 50% - Say Line 3'
WHERE `entryorguid` = 16414 AND `source_type` = 0 AND `id` = 5;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 16414 AND `source_type` = 0 AND `id` = 6;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16414,0,6,0,61,0,100,0,0,0,0,0,0,14,0,100,0,0,0,24,0,0,0,0,0,0,0,'Ghostly Steward - At Health 50% - Wipe Raid Threat');
