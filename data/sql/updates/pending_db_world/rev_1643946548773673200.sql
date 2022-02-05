INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643946548773673200');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_class_call_handler', 'spell_corrupted_totems', 'spell_class_call_polymorph', 'aura_class_call_wild_magic', 'aura_class_call_siphon_blessing', 'aura_class_call_berserk');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(23410, 'spell_class_call_handler'), -- Mage
(23397, 'spell_class_call_handler'), -- Warrior
(23398, 'spell_class_call_handler'), -- Druid
(23401, 'spell_class_call_handler'), -- Priest
(23418, 'spell_class_call_handler'), -- Paladin
(23425, 'spell_class_call_handler'), -- Shaman
(23427, 'spell_class_call_handler'), -- Warlock
(23436, 'spell_class_call_handler'), -- Hunter
(23414, 'spell_class_call_handler'), -- Rogue
(23424, 'spell_corrupted_totems'),
(23603, 'spell_class_call_polymorph'),
(23410, 'aura_class_call_wild_magic'),
(23418, 'aura_class_call_siphon_blessing'),
(23397, 'aura_class_call_berserk');

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|2|256|131072|33554432, `flags_extra` = `flags_extra`|128|256 WHERE `entry` = 14667;

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|131072, `flags_extra` = `flags_extra`|1|256|16384|4194304, `mechanic_immune_mask`=`mechanic_immune_mask`|1|2|4|8|16|128|256|512|1024|2048|4096|8192|16384|65536|131072|4194304|8388608|33554432|67108864|536870912 , `ScriptName` = 'npc_corrupted_totem' WHERE `entry` IN (14662, 14663, 14664, 14666);

UPDATE `creature_template` SET `mingold` = 0, `maxgold` = 0 WHERE `entry` = 14668;

DELETE FROM `creature_loot_template` WHERE `entry` = 11583 AND `Item` = 19364;
