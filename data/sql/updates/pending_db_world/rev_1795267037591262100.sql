-- Refurbished Shredder (27496): vehicle spells and Self Destruct script
DELETE FROM `creature_template_spell` WHERE `CreatureID` = 27496;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`) VALUES
    (27496, 0, 48984),
    (27496, 1, 49063),
    (27496, 2, 74608),
    (27496, 3, 49025);

DELETE FROM `spell_script_names` WHERE `spell_id` = 49025;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(49025, 'spell_refurbished_shredder_self_destruct_aura');
