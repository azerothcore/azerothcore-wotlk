INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609119138728662700');

/* Anub'Rekhan */

-- Fix enrage for Crypt Guard
UPDATE `smart_scripts` SET `event_phase_mask`=0, `event_flags`=1, `event_param2`=29, `event_param3`=0, `event_param4`=0, `comment`='Crypt Guard - On 30% HP - CastSelf Frenzy' WHERE `entryorguid`=16573 AND `source_type`=0 AND `id`=3 AND `link`=0;
-- Add Frenzy emote for Crypt Guard
DELETE FROM `smart_scripts` WHERE `entryorguid`= 16573, `source_type`= 0 AND `id`= 5;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(16573, 0, 5, 0, 2, 0, 100, 1, 0, 29, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard - On 30% HP - Say EMOTE_FRENZY');

