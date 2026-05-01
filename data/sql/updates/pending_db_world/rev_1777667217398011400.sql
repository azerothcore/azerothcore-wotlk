--
-- Fix: Doctor Sabnok (NPC 30992) attackable by player during quest 13152 'A visit to the doctor'.
-- The OnSpawn SAI was setting only UNIT_FLAG_NOT_SELECTABLE (256), which hides the target frame
-- but does not block damage. Adding UNIT_FLAG_IMMUNE_TO_PC (512) so only Patches can damage him.
-- Closes issue #25668.
--

UPDATE `smart_scripts`
SET `action_param1` = 768
WHERE `entryorguid` = 30992 AND `source_type` = 0 AND `id` = 6
  AND `event_type` = 11 AND `action_type` = 18 AND `action_param1` = 256;
