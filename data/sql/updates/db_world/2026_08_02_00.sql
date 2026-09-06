-- DB update 2026_08_01_03 -> 2026_08_02_00

-- Set Right Emotes.
UPDATE `creature_text` SET `Emote` = 1 WHERE (`CreatureID` IN (29032, 29061, 29065, 29067, 29068, 29070, 29071, 29072, 29073, 29074)) AND (`GroupID` IN (0, 2, 3, 4, 5, 6, 7, 8));
UPDATE `creature_text` SET `Emote` = 25 WHERE (`CreatureID` IN (29032, 29061, 29065, 29067, 29068, 29070, 29071, 29072, 29073, 29074)) AND (`GroupID` IN (1));

-- Deactive RegenHealth.
UPDATE `creature_template` SET `RegenHealth` = 0 WHERE (`entry` IN (29032, 29061, 29065, 29067, 29068, 29070, 29071, 29072, 29073, 29074));

-- Set Curhealth to 30%.
UPDATE `creature` SET `curhealth` = 3 WHERE (`id` IN (29032, 29061, 29065, 29067, 29068, 29070, 29071, 29072, 29073, 29074));

-- Remove Script Name and Enable SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` IN (29032, 29061, 29065, 29067, 29068, 29070, 29071, 29072, 29073, 29074));

-- Set SAI.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (29032, 29061, 29065, 29067, 29068, 29070, 29071, 29072, 29073, 29074));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29032, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malar Bravehorn - On Respawn - Set Flags Immune To Players'),
(29032, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malar Bravehorn - On Respawn - Set Flag Standstate Kneel'),
(29032, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malar Bravehorn - On Respawn - Set Event Phase 1'),
(29032, 0, 3, 4, 10, 0, 100, 257, 1, 3, 0, 0, 1, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Malar Bravehorn - On Out of Combat LoS - Store Targetlist (No Repeat)'),
(29032, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malar Bravehorn - On Out of Combat LoS - Set Event Phase 2 (No Repeat)'),
(29032, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malar Bravehorn - On Out of Combat LoS - Run Script (No Repeat)'),
(29032, 0, 6, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malar Bravehorn - Out of Combat - Play Emote 18 (Phase 1)'),
(29061, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ellen Stanbridge - On Respawn - Set Flags Immune To Players'),
(29061, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ellen Stanbridge - On Respawn - Set Flag Standstate Kneel'),
(29061, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ellen Stanbridge - On Respawn - Set Event Phase 1'),
(29061, 0, 3, 4, 10, 0, 100, 257, 1, 3, 0, 0, 1, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ellen Stanbridge - On Out of Combat LoS - Store Targetlist (No Repeat)'),
(29061, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ellen Stanbridge - On Out of Combat LoS - Set Event Phase 2 (No Repeat)'),
(29061, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ellen Stanbridge - On Out of Combat LoS - Run Script (No Repeat)'),
(29061, 0, 6, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ellen Stanbridge - Out of Combat - Play Emote 18 (Phase 1)'),
(29065, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yazmina Oakenthorn - On Respawn - Set Flags Immune To Players'),
(29065, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yazmina Oakenthorn - On Respawn - Set Flag Standstate Kneel'),
(29065, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yazmina Oakenthorn - On Respawn - Set Event Phase 1'),
(29065, 0, 3, 4, 10, 0, 100, 257, 1, 3, 0, 0, 1, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Yazmina Oakenthorn - On Out of Combat LoS - Store Targetlist (No Repeat)'),
(29065, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yazmina Oakenthorn - On Out of Combat LoS - Set Event Phase 2 (No Repeat)'),
(29065, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yazmina Oakenthorn - On Out of Combat LoS - Run Script (No Repeat)'),
(29065, 0, 6, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yazmina Oakenthorn - Out of Combat - Play Emote 18 (Phase 1)'),
(29067, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Donovan Pulfrost - On Respawn - Set Flags Immune To Players'),
(29067, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Donovan Pulfrost - On Respawn - Set Flag Standstate Kneel'),
(29067, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Donovan Pulfrost - On Respawn - Set Event Phase 1'),
(29067, 0, 3, 4, 10, 0, 100, 257, 1, 3, 0, 0, 1, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Donovan Pulfrost - On Out of Combat LoS - Store Targetlist (No Repeat)'),
(29067, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Donovan Pulfrost - On Out of Combat LoS - Set Event Phase 2 (No Repeat)'),
(29067, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Donovan Pulfrost - On Out of Combat LoS - Run Script (No Repeat)'),
(29067, 0, 6, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Donovan Pulfrost - Out of Combat - Play Emote 18 (Phase 1)'),
(29068, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goby Blastenheimer - On Respawn - Set Flags Immune To Players'),
(29068, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goby Blastenheimer - On Respawn - Set Flag Standstate Kneel'),
(29068, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goby Blastenheimer - On Respawn - Set Event Phase 1'),
(29068, 0, 3, 4, 10, 0, 100, 257, 1, 3, 0, 0, 1, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Goby Blastenheimer - On Out of Combat LoS - Store Targetlist (No Repeat)'),
(29068, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goby Blastenheimer - On Out of Combat LoS - Set Event Phase 2 (No Repeat)'),
(29068, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goby Blastenheimer - On Out of Combat LoS - Run Script (No Repeat)'),
(29068, 0, 6, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Goby Blastenheimer - Out of Combat - Play Emote 18 (Phase 1)'),
(29070, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valok the Righteous - On Respawn - Set Flags Immune To Players'),
(29070, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valok the Righteous - On Respawn - Set Flag Standstate Kneel'),
(29070, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valok the Righteous - On Respawn - Set Event Phase 1'),
(29070, 0, 3, 4, 10, 0, 100, 257, 1, 3, 0, 0, 1, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Valok the Righteous - On Out of Combat LoS - Store Targetlist (No Repeat)'),
(29070, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valok the Righteous - On Out of Combat LoS - Set Event Phase 2 (No Repeat)'),
(29070, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valok the Righteous - On Out of Combat LoS - Run Script (No Repeat)'),
(29070, 0, 6, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Valok the Righteous - Out of Combat - Play Emote 18 (Phase 1)'),
(29071, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antoine Brack - On Respawn - Set Flags Immune To Players'),
(29071, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antoine Brack - On Respawn - Set Flag Standstate Kneel'),
(29071, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antoine Brack - On Respawn - Set Event Phase 1'),
(29071, 0, 3, 4, 10, 0, 100, 257, 1, 3, 0, 0, 1, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Antoine Brack - On Out of Combat LoS - Store Targetlist (No Repeat)'),
(29071, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antoine Brack - On Out of Combat LoS - Set Event Phase 2 (No Repeat)'),
(29071, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antoine Brack - On Out of Combat LoS - Run Script (No Repeat)'),
(29071, 0, 6, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Antoine Brack - Out of Combat - Play Emote 18 (Phase 1)'),
(29072, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kug Ironjaw - On Respawn - Set Flags Immune To Players'),
(29072, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kug Ironjaw - On Respawn - Set Flag Standstate Kneel'),
(29072, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kug Ironjaw - On Respawn - Set Event Phase 1'),
(29072, 0, 3, 4, 10, 0, 100, 257, 1, 3, 0, 0, 1, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kug Ironjaw - On Out of Combat LoS - Store Targetlist (No Repeat)'),
(29072, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kug Ironjaw - On Out of Combat LoS - Set Event Phase 2 (No Repeat)'),
(29072, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kug Ironjaw - On Out of Combat LoS - Run Script (No Repeat)'),
(29072, 0, 6, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kug Ironjaw - Out of Combat - Play Emote 18 (Phase 1)'),
(29073, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iggy Darktusk - On Respawn - Set Flags Immune To Players'),
(29073, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iggy Darktusk - On Respawn - Set Flag Standstate Kneel'),
(29073, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iggy Darktusk - On Respawn - Set Event Phase 1'),
(29073, 0, 3, 4, 10, 0, 100, 257, 1, 3, 0, 0, 1, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Iggy Darktusk - On Out of Combat LoS - Store Targetlist (No Repeat)'),
(29073, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iggy Darktusk - On Out of Combat LoS - Set Event Phase 2 (No Repeat)'),
(29073, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iggy Darktusk - On Out of Combat LoS - Run Script (No Repeat)'),
(29073, 0, 6, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iggy Darktusk - Out of Combat - Play Emote 18 (Phase 1)'),
(29074, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - On Respawn - Set Flags Immune To Players'),
(29074, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - On Respawn - Set Flag Standstate Kneel'),
(29074, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - On Respawn - Set Event Phase 1'),
(29074, 0, 3, 4, 10, 0, 100, 257, 1, 3, 0, 0, 1, 0, 64, 25, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - On Out of Combat LoS - Store Targetlist (No Repeat)'),
(29074, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - On Out of Combat LoS - Set Event Phase 2 (No Repeat)'),
(29074, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2907400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - On Out of Combat LoS - Run Script (No Repeat)'),
(29074, 0, 6, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Out of Combat - Play Emote 18 (Phase 1)');

-- Set Action List (Used by all the Creatures).
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2907400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2907400, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Say Line 0'),
(2907400, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Remove FlagStandstate Kneel'),
(2907400, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Say Line 1'),
(2907400, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Say Line 2'),
(2907400, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Say Line 3'),
(2907400, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Say Line 4'),
(2907400, 9, 6, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Say Line 5'),
(2907400, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 5, 274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Play Emote 274'),
(2907400, 9, 8, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Say Line 6'),
(2907400, 9, 9, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Play Emote 5'),
(2907400, 9, 10, 0, 0, 0, 100, 0, 4500, 4500, 0, 0, 0, 0, 100, 25, 0, 0, 0, 0, 0, 10, 129947, 29053, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Send Target 25'),
(2907400, 9, 11, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 223, 25, 0, 0, 0, 0, 0, 10, 129947, 29053, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Do Action ID 25'),
(2907400, 9, 12, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Say Line 7'),
(2907400, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Set Reactstate Passive'),
(2907400, 9, 14, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Play Emote 18'),
(2907400, 9, 15, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Set Flag Standstate Kneel'),
(2907400, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Remove Flags Immune To Players'),
(2907400, 9, 17, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Say Line 8'),
(2907400, 9, 18, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Say Line 9'),
(2907400, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Eonys - Actionlist - Kill Self');

-- Set Plaguefist SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29053;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29053);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29053, 0, 0, 0, 72, 0, 100, 0, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 25, 0, 0, 0, 0, 0, 0, 0, 'Knight Commander Plaguefist - On Action 25 Done - Say Line 0');

-- Set Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 4) AND (`SourceEntry` IN (29032, 29061, 29065, 29067, 29068, 29070, 29071, 29072, 29073, 29074)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47) AND (`ConditionTarget` = 0) AND (`ConditionValue1` IN (12739, 12742, 12743, 12744, 12745, 12746, 12750, 12748, 12749, 12747)) AND (`ConditionValue2` = 8) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 4, 29032, 0, 0, 47, 0, 12739, 8, 0, 0, 0, 0, '', 'The event will only occur when the player has the "A Special Surprise" (Tauren) quest incomplete.'),
(22, 4, 29061, 0, 0, 47, 0, 12742, 8, 0, 0, 0, 0, '', 'The event will only occur when the player has the "A Special Surprise" (Human) quest incomplete.'),
(22, 4, 29065, 0, 0, 47, 0, 12743, 8, 0, 0, 0, 0, '', 'The event will only occur when the player has the "A Special Surprise" (Night Elf) quest incomplete.'),
(22, 4, 29067, 0, 0, 47, 0, 12744, 8, 0, 0, 0, 0, '', 'The event will only occur when the player has the "A Special Surprise" (Dwarf) quest incomplete.'),
(22, 4, 29068, 0, 0, 47, 0, 12745, 8, 0, 0, 0, 0, '', 'The event will only occur when the player has the "A Special Surprise" (Gnome) quest incomplete.'),
(22, 4, 29070, 0, 0, 47, 0, 12746, 8, 0, 0, 0, 0, '', 'The event will only occur when the player has the "A Special Surprise" (Draenei) quest incomplete.'),
(22, 4, 29071, 0, 0, 47, 0, 12750, 8, 0, 0, 0, 0, '', 'The event will only occur when the player has the "A Special Surprise" (Undead) quest incomplete.'),
(22, 4, 29072, 0, 0, 47, 0, 12748, 8, 0, 0, 0, 0, '', 'The event will only occur when the player has the "A Special Surprise" (Orc) quest incomplete.'),
(22, 4, 29073, 0, 0, 47, 0, 12749, 8, 0, 0, 0, 0, '', 'The event will only occur when the player has the "A Special Surprise" (Troll) quest incomplete.'),
(22, 4, 29074, 0, 0, 47, 0, 12747, 8, 0, 0, 0, 0, '', 'The event will only occur when the player has the "A Special Surprise" (Blood Elf) quest incomplete.');
