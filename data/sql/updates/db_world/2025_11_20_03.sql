-- DB update 2025_11_20_02 -> 2025_11_20_03
--
UPDATE `creature_template` SET `AIName` = '', `npcflag` = 16777216 WHERE `entry` = 26809;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 26809) AND (`source_type` = 0);

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 26809;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(26809, 47416, 2, 1);

UPDATE `spell_dbc` SET `Effect_1` = 24, `EffectBasePoints_1` = 1, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 36765 WHERE `id` = 47416;
