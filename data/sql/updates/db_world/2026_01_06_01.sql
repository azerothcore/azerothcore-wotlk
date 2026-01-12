-- DB update 2026_01_06_00 -> 2026_01_06_01
-- Bonestripper Vulture, Castflag 0 to 32 "Only casts the spell if the target does not have an aura from the spell"
UPDATE `smart_scripts` SET `action_param2` = `action_param2` | 32 WHERE `entryorguid` = 16973 AND `source_type` = 0 AND `id` = 0;
