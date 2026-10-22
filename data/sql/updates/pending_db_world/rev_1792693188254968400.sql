--
DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (34146, 34150, 34151);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (34146, 34150, 34151) AND `spell_id` = 43671;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3414600, 3415000, 3415100) AND `source_type` = 9;
