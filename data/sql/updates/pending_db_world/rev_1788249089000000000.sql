-- Remove erroneous Relentless Strikes spell_proc override that was incorrectly assigned to Remorseless Attacks
DELETE FROM `spell_proc` WHERE `SpellId` = -14143;

-- Remorseless Attacks: Bind AuraScript to prevent charge consumption on Mutilate MH/OH,
-- so both sub-spells benefit from the critical strike bonus before being consumed in AfterCast.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_rog_remorseless_attacks' AND `spell_id` IN (14143, 14149);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(14143, 'spell_rog_remorseless_attacks'),
(14149, 'spell_rog_remorseless_attacks');
