-- DB update 2026_06_18_00 -> 2026_06_18_01
-- Ulduar: Flame Leviathan - give the Salvaged Chopper its "Grab Pyrite" hook ability (spell 67372 -> 67387).
-- Mirrors the Salvaged Demolisher's "Grab Crate" (62479 -> 62482).

-- Add "Grab Pyrite" (67372) to the Salvaged Chopper (33062) vehicle action bar.
DELETE FROM `creature_template_spell` WHERE `CreatureID`=33062 AND `Index`=4;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(33062, 4, 67372, 0);

-- Bind the chopper's "Grab Crate" (67387, triggered by 67372) to the existing grab-pyrite script.
DELETE FROM `spell_script_names` WHERE `spell_id`=67387 AND `ScriptName`='spell_vehicle_grab_pyrite';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(67387, 'spell_vehicle_grab_pyrite');
