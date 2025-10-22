-- DB update 2025_09_11_01 -> 2025_09_11_02
--
-- Sword Specialization: Hamstring 0x0002, Rend 0x0020, Sunder Armor 0x4000
UPDATE `spell_proc_event` SET `SpellFamilyMask0`=`SpellFamilyMask0` | (0x0002 | 0x0020 | 0x4000) WHERE `entry`=-12281;

-- Sudden Death: copy FamilyMask from Sword Specialization
DELETE FROM `spell_proc_event` WHERE `entry`=-29723;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procPhase`) VALUES
(-29723, 0, 4, 2858435686, 4194565, 0, 2|4);

DELETE FROM `spell_script_names` WHERE `spell_id` = -29723 AND `ScriptName` = 'spell_war_sudden_death_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(-29723, 'spell_war_sudden_death_aura');
