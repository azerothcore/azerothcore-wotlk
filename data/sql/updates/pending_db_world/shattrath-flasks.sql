DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-41608, -41609, -41610, -41611, -46837, -46839, -45373);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-41609, -41607, 0, 'Shattrath Flask of Fortification'),
(-41610, -41605, 0, 'Shattrath Flask of Mighty Restoration'),
(-41611, -41604, 0, 'Shattrath Flask of Supreme Power'),
(-41608, -41606, 0, 'Shattrath Flask of Relentless Assault'),
(-46837, -46838, 0, 'Shattrath Flask of Pure Death'),
(-46839, -46840, 0, 'Shattrath Flask of Blinding Light'),
(-45373, -45374, 0, 'Bloodberry Elixir');

UPDATE `spell_area` SET `spell` = 41607, `aura_spell` = 41609, `autocast` = 1 WHERE `spell` = 41609;
UPDATE `spell_area` SET `spell` = 41605, `aura_spell` = 41610, `autocast` = 1 WHERE `spell` = 41610;
UPDATE `spell_area` SET `spell` = 41604, `aura_spell` = 41611, `autocast` = 1 WHERE `spell` = 41611;
UPDATE `spell_area` SET `spell` = 41606, `aura_spell` = 41608, `autocast` = 1 WHERE `spell` = 41608;
UPDATE `spell_area` SET `spell` = 46838, `aura_spell` = 46837, `autocast` = 1 WHERE `spell` = 46837;
UPDATE `spell_area` SET `spell` = 46840, `aura_spell` = 46839, `autocast` = 1 WHERE `spell` = 46839;
UPDATE `spell_area` SET `spell` = 45374, `aura_spell` = 45373, `autocast` = 1 WHERE `spell` = 45373;
