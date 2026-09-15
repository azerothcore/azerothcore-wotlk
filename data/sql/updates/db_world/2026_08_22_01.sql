-- DB update 2026_08_22_00 -> 2026_08_22_01
-- Only the summoned entries take the script: GetScriptId() resolves through GetEntry(), not the difficulty row.
UPDATE `creature_template` SET `ScriptName` = 'npc_putricide_mutated_abomination' WHERE `entry` IN (37672, 38285);

-- Stats come from DifficultyEntry, so only these four templates are ever instantiated; the rest stay at 7.5.
-- Values put the average hit near retail: ~5500 (10N), ~7400 (10H), ~9500 (25N), ~13500 (25H).
UPDATE `creature_template` SET `DamageModifier` = 17 WHERE `entry` = 37672; -- 10N
UPDATE `creature_template` SET `DamageModifier` = 23 WHERE `entry` = 38786; -- 10H
UPDATE `creature_template` SET `DamageModifier` = 30 WHERE `entry` = 38788; -- 25N
UPDATE `creature_template` SET `DamageModifier` = 42 WHERE `entry` = 38790; -- 25H
