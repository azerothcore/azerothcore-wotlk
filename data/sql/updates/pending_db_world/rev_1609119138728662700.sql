INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609119138728662700');

/* Anub'Rekhan */

-- Fix enrage for Crypt Guard
UPDATE `smart_scripts` SET `event_phase_mask`=0, `event_flags`=1, `event_param2`=29, `event_param3`=0, `event_param4`=0, `comment`='Crypt Guard - On 30% HP - CastSelf Frenzy' WHERE `entryorguid`=16573 AND `source_type`=0 AND `id`=3 AND `link`=0;
-- Add Frenzy emote for Crypt Guard
DELETE FROM `smart_scripts` WHERE `entryorguid`= 16573 AND `source_type`= 0 AND `id`= 5;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(16573, 0, 5, 0, 2, 0, 100, 1, 0, 29, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard - On 30% HP - Say EMOTE_FRENZY');


/* Heigan the Unclean */

-- Enable random movement and adjust orientation
UPDATE `creature` SET `orientation`=2.40, `wander_distance`=4, `MovementType`=1 WHERE `guid`=127789;
-- Fix EMOTE_DEATH
UPDATE `creature_text` SET `Text`='%s takes his last breath.', `Type`=16, `BroadcastTextId`=13044, `comment`='heigan EMOTE_DEATH' WHERE `CreatureID`=15936 AND `GroupID`=3 AND `ID`=0;


/* Loatheb */

-- Useless, workaround implemented in boss_loatheb.cpp
DELETE FROM `spell_script_names` WHERE `spell_id`=59481;
-- Adjust movement speed for Spores
UPDATE `creature_template` SET `speed_walk`=0.4, `speed_run`=0.4 WHERE `entry` IN (16286, 30068);


/* Instructor Razuvious */

-- Fix texts and emotes
UPDATE `creature_text` SET `GroupID`=2, `ID`=3, `comment`='Razuvious SAY_TAUNTED #4' WHERE `CreatureID`=16061 AND `GroupID`=1 AND `ID`=1;
UPDATE `broadcast_text_locale` SET `MaleText`='%s suelta un grito triunfal.' WHERE `ID`=13082 AND `locale` IN ('esES', 'esMX');
UPDATE `creature_text` SET `Type`=16, `comment`='Razuvious SAY_SLAY' WHERE `CreatureID`=16061 AND `GroupID`=4 AND `ID`=0;
UPDATE `creature_text` SET `comment`='Razuvious SAY_AGGRO #4' WHERE `CreatureID`=16061 AND `GroupID`=0 AND `ID`=3;
UPDATE `creature_text` SET `GroupID`=2, `ID`=4, `comment`='Razuvious SAY_TAUNTED #5' WHERE `CreatureID`=16061 AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `Probability`=20 WHERE `CreatureID`=16061 AND `GroupID`=2 AND `ID` IN (0, 1, 2, 3, 4);
UPDATE `creature_text` SET `Probability`=25 WHERE `CreatureID`=16061 AND `GroupID`=0 AND `ID` IN (0, 1, 2, 3);
UPDATE `creature_text` SET `Sound`=8862 WHERE `CreatureID`=16061 AND `GroupID`=2 AND `ID`=4;
UPDATE `creature_text` SET `GroupID`=1 WHERE `CreatureID`=16061 AND `GroupID`=4 AND `ID`=0;
UPDATE `creature_text` SET `Sound`=8863 WHERE `CreatureID`=16061 AND `GroupID`=1 AND `ID`=0;

