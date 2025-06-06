-- DB update 2023_05_01_00 -> 2023_05_03_00
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (34798, 34797, 34644, 34359, 34358, 27637, 34254, 34642, 34641);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(34798, 34798, 39121),
(34797, 34797, 39120),
(34644, 34644, 39122),
(34359, 34359, 39128),
(34358, 34358, 39127),
(27637, 27637, 39125),
(34254, 34254, 39126),
(34642, 34642, 39347),
(34641, 34641, 39129);

-- Small Updates
UPDATE `smart_scripts` SET `event_param1` = 7300, `event_param2` = 15350, `event_param3` = 18200, `event_param4` = 25700 WHERE (`entryorguid` = 19505) AND (`source_type` = 0) AND (`id` IN (1)); -- Sunseeker Channeler

-- Complete Rewrites
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (18419, 17993, 18405, 19633, 18404, 19608, 19486, 18422, 19507, 18421, 19557, 19508, 19509, 19512, 19598, 20078, 20083, 19958, 19843, 25354));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18419, 0, 0, 0, 0, 0, 100, 0, 8550, 20050, 13200, 20050, 0, 11, 34800, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Greenkeeper - In Combat - Cast \'Impending Coma\''),
(18419, 0, 1, 0, 0, 0, 100, 0, 1200, 2400, 2400, 3600, 0, 11, 34798, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Greenkeeper - In Combat - Cast \'Greenkeeper`s Fury\''),
(18419, 0, 2, 0, 0, 0, 100, 0, 8550, 15200, 7250, 17000, 0, 11, 34797, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Greenkeeper - In Combat - Cast \'Nature Shock\''),
(17993, 0, 0, 0, 74, 0, 100, 1, 0, 50, 0, 0, 25, 11, 34784, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On Friendly Between 0-50% Health - Cast \'Intervene\' (No Repeat)'),
(17993, 0, 1, 0, 0, 0, 100, 0, 5250, 17800, 1200, 21200, 0, 11, 29765, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - In Combat - Cast \'Crystal Strike\''),
(17993, 0, 2, 0, 2, 0, 100, 1, 0, 20, 0, 0, 0, 11, 35399, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - Between 0-20% Health - Cast \'Spell Reflection\' (No Repeat)'),
(18405, 0, 0, 0, 0, 0, 100, 0, 7600, 16400, 15700, 25300, 0, 11, 34793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - In Combat - Cast \'Arcane Blast\''),
(18405, 0, 1, 0, 0, 0, 100, 0, 9700, 16200, 7300, 19400, 0, 11, 34791, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - In Combat - Cast \'Arcane Explosion\''),
(18405, 0, 2, 0, 0, 0, 100, 0, 6050, 15000, 18250, 26700, 0, 11, 34785, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - In Combat - Cast \'Arcane Volley\''),
(19633, 0, 0, 0, 0, 0, 100, 2, 7350, 13950, 12150, 15750, 0, 11, 17194, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Mender - In Combat - Cast \'Mind Blast\' (Normal Dungeon)'),
(19633, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2000, 3000, 0, 11, 17287, 64, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Mender - In Combat - Cast \'Mind Blast\' (Heroic Dungeon)'),
(19633, 0, 2, 0, 74, 0, 100, 0, 0, 75, 10000, 10000, 40, 11, 35096, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Mender - On Friendly Between 0-75% Health - Cast \'Greater Heal\''),
(19633, 0, 3, 0, 23, 0, 100, 0, 34809, 0, 3600, 3600, 0, 11, 34809, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Mender - On Aura \'Holy Fury\' Missing - Cast \'Holy Fury\''),
(19633, 0, 4, 0, 16, 0, 100, 0, 34809, 30, 12150, 15750, 1, 11, 34809, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Mender - On Friendly Unit Missing Buff \'Holy Fury\' - Cast \'Holy Fury\''),
(18404, 0, 0, 0, 0, 0, 100, 0, 14350, 23050, 17000, 29150, 0, 11, 34821, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Steward - In Combat - Cast \'Arcane Flurry\''),
(19608, 0, 0, 0, 0, 0, 100, 0, 3850, 11250, 1050, 14350, 0, 11, 34644, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Frayer Wildling - In Combat - Cast \'Lash\''),
(19486, 0, 0, 0, 0, 0, 100, 0, 12150, 28750, 12150, 28750, 0, 11, 34359, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Chemist - In Combat - Cast \'Fire Breath Potion\''),
(19486, 0, 1, 0, 0, 0, 100, 0, 6900, 15800, 18250, 29650, 0, 11, 34358, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Chemist - In Combat - Cast \'Vial of Poison\''),
(18422, 0, 0, 0, 74, 0, 100, 0, 0, 60, 13300, 35100, 40, 11, 34361, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Botanist - On Friendly Between 0-60% Health - Cast \'Regrowth\''),
(18422, 0, 1, 0, 0, 0, 100, 0, 8500, 20600, 15800, 20600, 0, 11, 34350, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Botanist - In Combat - Cast \'Nature`s Rage\''),
(19507, 0, 0, 0, 0, 0, 100, 0, 8500, 13350, 19350, 27650, 0, 11, 34642, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Gene-Splicer - In Combat - Cast \'Death & Decay\''),
(19507, 0, 1, 0, 0, 0, 100, 0, 21850, 25500, 35000, 35000, 0, 11, 34247, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Gene-Splicer - In Combat - Cast \'Summon Lasher Beast\''),
(18421, 0, 0, 0, 0, 0, 100, 0, 14200, 27900, 120300, 125150, 0, 11, 34355, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - In Combat - Cast \'Poison Shield\''),
(18421, 0, 1, 0, 0, 0, 100, 0, 6050, 15750, 6050, 15750, 0, 87, 1842101, 1842102, 1842103, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - In Combat - Cast Random Spell'),
(19557, 0, 0, 0, 0, 0, 100, 0, 3950, 12050, 1200, 13600, 0, 11, 34644, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greater Frayer - In Combat - Cast \'Lash\''),
(19508, 0, 0, 0, 0, 0, 50, 0, 0, 0, 2200, 3800, 0, 11, 34641, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Herbalist - In Combat - Cast \'Spade Toss\''),
(19508, 0, 1, 0, 0, 0, 100, 0, 8350, 12150, 13350, 26750, 0, 11, 22127, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Herbalist - In Combat - Cast \'Entangling Roots\''),
(19509, 0, 0, 0, 0, 0, 100, 0, 6050, 19500, 7300, 23100, 0, 11, 34640, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Harvester - In Combat - Cast \'Wilting Touch\''),
(19509, 0, 1, 0, 0, 0, 100, 0, 6100, 14450, 16950, 46200, 0, 11, 34639, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Harvester - In Combat - Cast \'Polymorph\''),
(19512, 0, 0, 0, 0, 0, 100, 0, 6100, 13350, 1200, 22300, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Reaper - In Combat - Cast \'Cleave\''),
(19512, 0, 1, 0, 0, 0, 100, 4, 17200, 22600, 21200, 26400, 0, 11, 34626, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Reaper - In Combat - Cast \'Pale Death\' (Heroic Dungeon)'),
(19512, 0, 2, 0, 8, 0, 100, 0, 34222, 0, 1200, 1200, 0, 11, 34173, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Reaper - On Spellhit \'Sunseeker Blessing\' - Cast \'Sunseeker Blessing\''),
(19512, 0, 3, 0, 8, 0, 100, 0, 34200, 0, 1200, 1200, 0, 11, 34173, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Reaper - On Spellhit \'Crystal Channel\' - Cast \'Sunseeker Blessing\''),
(19598, 0, 0, 0, 0, 0, 100, 0, 4850, 13350, 1100, 17900, 0, 11, 34351, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mutate Fleshlasher - In Combat - Cast \'Vicious Bite\''),
(20078, 0, 0, 0, 0, 0, 100, 0, 10100, 14900, 1200, 23100, 0, 11, 34820, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Reservist - In Combat - Cast \'Arcane Strike\''),
(20083, 0, 0, 0, 23, 0, 100, 0, 34809, 0, 3600, 3600, 0, 11, 34809, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Mender - On Aura \'Holy Fury\' Missing - Cast \'Holy Fury\''),
(20083, 0, 1, 0, 0, 0, 100, 2, 12100, 16200, 15750, 18450, 0, 11, 17194, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Mender - In Combat - Cast \'Mind Blast\' (Normal Dungeon)'),
(20083, 0, 2, 0, 0, 0, 100, 4, 12100, 16200, 2000, 3000, 0, 11, 17287, 0, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Mender - In Combat - Cast \'Mind Blast\' (Heroic Dungeon)'),
(20083, 0, 3, 0, 74, 0, 100, 0, 0, 75, 10000, 10000, 40, 11, 35096, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Mender - On Friendly Between 0-75% Health - Cast \'Greater Heal\''),
(20083, 0, 4, 0, 16, 0, 100, 0, 34809, 30, 13300, 18200, 1, 11, 34809, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Summoned Bloodwarder Mender - On Friendly Unit Missing Buff \'Holy Fury\' - Cast \'Holy Fury\''),
(19958, 0, 0, 0, 0, 0, 100, 0, 5750, 7000, 4550, 13150, 0, 11, 34752, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'White Seedling - In Combat - Cast \'Freezing Touch\''),
(19958, 0, 1, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'White Seedling - On Initialize - Cast \'Plant Spawn Effect\''),
(19843, 0, 0, 0, 67, 0, 100, 0, 1150, 13350, 0, 0, 0, 11, 34614, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Trickster - On Behind Target - Cast \'Backstab\''),
(25354, 0, 0, 0, 0, 0, 100, 0, 4700, 13100, 1150, 17250, 0, 11, 34351, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mutate Fleshlasher - In Combat - Cast \'Vicious Bite\'');

-- Partial Rewrites
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17994) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17994, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Falconer - In Combat - Say Line 1');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17994) AND (`source_type` = 0) AND (`id` IN (0, 2, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17994, 0, 0, 1, 0, 0, 100, 512, 12150, 12150, 6050, 15750, 0, 64, 1, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Falconer - In Combat - Store Targetlist'),
(17994, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Falconer - In Combat - Say Line 1'),
(17994, 0, 5, 0, 0, 0, 100, 0, 8500, 10900, 14150, 21850, 0, 11, 32908, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Falconer - In Combat - Cast \'Wing Clip\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1842101, 1842102, 1842103));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1842101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34352, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - Actionlist Random Cast - Cast \'Mind Shock\''),
(1842102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34353, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - Actionlist Random Cast - Cast \'Frost Shock\''),
(1842103, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 34354, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunseeker Researcher - Actionlist Random Cast - Cast \'Flame Shock\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19511) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19511, 0, 0, 0, 0, 0, 100, 0, 6100, 19900, 20000, 24000, 0, 11, 34616, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Inciter - In Combat - Cast \'Deadly Poison\''),
(19511, 0, 1, 0, 0, 0, 100, 0, 4300, 9700, 21700, 38600, 0, 11, 34615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Inciter - In Combat - Cast \'Mind-numbing Poison\''),
(19511, 0, 2, 0, 0, 0, 100, 0, 13400, 20600, 20600, 29000, 0, 11, 30621, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nethervine Inciter - In Combat - Cast \'Kidney Shot\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19513;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19513);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19513, 0, 0, 0, 0, 0, 100, 0, 8000, 24000, 28000, 36000, 0, 11, 30584, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mutate Fear-Shrieker - In Combat - Cast \'Fear\'');

DELETE FROM `creature_template_addon` WHERE (`entry` IN (19843, 21565));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(19843, 0, 0, 0, 1, 0, 0, '30991'),
(21565, 0, 0, 0, 1, 0, 0, '30991');
