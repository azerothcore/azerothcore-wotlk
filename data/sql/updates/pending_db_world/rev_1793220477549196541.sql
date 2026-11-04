--
-- Warrior: Sword Specialization (-12281) and Sudden Death (-29723) must also proc from melee
-- abilities that require a main-hand weapon but deal no direct damage (Hamstring, Rend,
-- Sunder Armor, Execute): SpellTypeMask 0x1 (damage) -> 0x5 (damage | no damage/heal).
UPDATE `spell_proc` SET `SpellTypeMask` = 0x5 WHERE `SpellId` IN (-12281, -29723);

-- Warrior: the Sudden Death proc buff (52437) is spent by a landed Execute hit, not by the cast
-- finishing: SpellPhaseMask 0x4 (finish) -> 0x2 (hit).
UPDATE `spell_proc` SET `SpellPhaseMask` = 0x2 WHERE `SpellId` = 52437;

-- Weapon-requirement gate for both talent auras (negative id = all ranks)
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-12281, -29723) AND `ScriptName` = 'spell_warr_weapon_required_proc';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-12281, 'spell_warr_weapon_required_proc'),
(-29723, 'spell_warr_weapon_required_proc');
