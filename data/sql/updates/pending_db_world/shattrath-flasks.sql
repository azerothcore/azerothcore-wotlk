DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-41608, -41609, -41610, -41611, -46837, -46839, -45373);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-41609, -41607, 0, 'Shattrath Flask of Fortification'),
(-41610, -41605, 0, 'Shattrath Flask of Mighty Restoration'),
(-41611, -41604, 0, 'Shattrath Flask of Supreme Power'),
(-41608, -41606, 0, 'Shattrath Flask of Relentless Assault'),
(-46837, -46838, 0, 'Shattrath Flask of Pure Death'),
(-46839, -46840, 0, 'Shattrath Flask of Blinding Light'),
(-45373, -45374, 0, 'Bloodberry Elixir');
