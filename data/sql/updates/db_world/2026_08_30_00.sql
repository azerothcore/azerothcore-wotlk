-- DB update 2026_08_28_02 -> 2026_08_30_00
--
-- Thorim: the pre-fight pack, the Dark Rune casters and the Iron Ring/Honor Guards all inherit the shared
-- boss set -361 (interrupt, every CC and knockback immune) from AC's original base data, and the Dark Rune
-- Warbringer sits on -359 (the same minus charm). Classic Wrath footage shows the Dark Rune Acolytes
-- interrupted and knocked back, the pre-fight Acolyte Death Gripped, the pre-fight mercenaries Mind
-- Controlled/sheeped/feared (the fight starts when the last pack member dies, so one can be kept CC'd),
-- the Iron Ring Guards stunned and slowed, and the Warbringer stunned and slowed by a hunter trap.
-- Clear the immunities:
-- Dark Rune Acolyte 32886/33159 (arena), 33110/33161 (gauntlet), Dark Rune Evoker 32878/33156,
-- Dark Rune Warbringer 32877/33155 (stays Mind Controllable for its Aura of Celerity), Dark Rune
-- Commoner 32904/33157 and Dark Rune Champion 32876/33158 (arena adds, same unsourced mask),
-- Captured Mercenary Soldier 32885/33153 + 32883/33152, Captured Mercenary Captain 32908/33151 + 32907/33150,
-- Iron Ring Guard 32874/33162, Iron Honor Guard 32875/33163.
-- Jormungar Behemoth, Runic Colossus and Ancient Rune Giant stay.
UPDATE `creature_template` SET `CreatureImmunitiesId` = 0 WHERE `entry` IN
(32886,33159,33110,33161,32878,33156,32877,33155,32904,33157,32876,33158,
32885,33153,32883,33152,32908,33151,32907,33150,32874,33162,32875,33163);
