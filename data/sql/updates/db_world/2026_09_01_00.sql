-- DB update 2026_08_31_07 -> 2026_09_01_00
-- Mechanolift 304-A (33214) can never fight back, and its default VehicleAI has no
-- evade logic, so damaging one without killing it kept the attacker in combat with
-- it until it died. Give it a passive SmartAI that stops combat 10 seconds after
-- the last hit, staying on its flight path (no full evade: that would fly the lift
-- home and reinstall a grabbed Pyrite Safety Container through the vehicle kit).
-- Timer shape: On Aggro seeds one timed event; each On Damaged then removes and
-- recreates it, which nets to a refresh because the removal is deferred to the end
-- of the next update tick and erases the oldest stored event with that id. The
-- seed row is required: without a standing event, remove+create nets to nothing
-- (the deferred removal deletes the freshly created event).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33214 AND `AIName` = '';

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33214);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33214, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanolift 304-A - On Reset - Set Reactstate Passive'),
(33214, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 2, 10000, 10000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanolift 304-A - On Aggro - Create Timed Event 2'),
(33214, 0, 2, 3, 32, 0, 100, 0, 1, 1000000, 0, 0, 0, 0, 74, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanolift 304-A - On Damaged - Remove Timed Event 2'),
(33214, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 2, 10000, 10000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanolift 304-A - On Link - Create Timed Event 2'),
(33214, 0, 4, 0, 59, 0, 100, 0, 2, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanolift 304-A - On Timed Event 2 Triggered - Stop Combat'),
(33214, 0, 5, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanolift 304-A - On Evade - Remove Timed Event 2'),
(33214, 0, 6, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mechanolift 304-A - On Just Died - Remove Timed Event 2');
