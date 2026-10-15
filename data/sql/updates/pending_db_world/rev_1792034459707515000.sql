--
-- Summon Aqueous Spawn (serverside): the Aqueous Lord summons one Aqueous Spawn (22883) per cast
UPDATE `spell_dbc` SET `Effect_1` = 28, `ImplicitTargetA_1` = 32, `EffectRadiusIndex_1` = 15, `EffectMiscValue_1` = 22883, `EffectMiscValueB_1` = 61 WHERE `ID` = 40101;

-- Aqueous Lord: the spell does the summon now, drop the linked Summon Creature workaround
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22878 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22878, 0, 0, 0, 0, 0, 100, 0, 7000, 11000, 9000, 13000, 0, 0, 11, 40100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aqueous Lord - In Combat - Cast ''Crashing Wave'''),
(22878, 0, 1, 0, 0, 0, 100, 0, 9000, 15000, 6000, 12000, 0, 0, 11, 40099, 0, 0, 0, 0, 0, 5, 100, 1, 0, 0, 0, 0, 0, 0, 'Aqueous Lord - In Combat - Cast ''Vile Slime'''),
(22878, 0, 2, 0, 0, 0, 100, 0, 14000, 18000, 30000, 40000, 0, 0, 11, 40101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aqueous Lord - In Combat - Cast ''Summon Aqueous Spawn''');

-- Translocate (serverside): Orb of Translocation casts, script effect on the user
UPDATE `spell_dbc` SET `Effect_1` = 77, `ImplicitTargetA_1` = 25 WHERE `ID` IN (45367, 45370);
