-- Remove UNIT_FLAG_IMMUNE_TO_PC (256) instead of UNIT_FLAG_IMMUNE_TO_NPC (512)
UPDATE `smart_scripts` SET `action_param1`=256 WHERE `entryorguid`=2795900 AND `source_type`=9 AND `id`=9;
