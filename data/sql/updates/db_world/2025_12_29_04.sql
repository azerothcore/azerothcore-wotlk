-- DB update 2025_12_29_03 -> 2025_12_29_04
-- Adds AIName SAI to the following:
-- Huntress Ravenoak and Leafrunner
-- Hunter Sagewind, Ragetotem and Thunderhorn
-- Dark Ranger Clea, Anya, Cyndia
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (14379, 14380, 14440, 14441, 14442, 36224, 36225, 36226, 14378);

-- Bluff Watcher, Darnassus Sentinel, Ancient of War and Exodar Peacekeeper were fixed with the removal of: https://github.com/azerothcore/azerothcore-wotlk/blob/f4bbbf34dd0e0227fc2a800396b182c33a3a1c27/src/server/game/AI/CoreAI/GuardAI.cpp#L36 in this PR

-- For those that should have the aura "Invisibility and Stealth Detection" clears the SAI for those that have it.
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `event_type` = 25 AND `action_type` = 11 AND `action_param1` = 41634 AND `entryorguid` IN (14375, 14376, 14377, 14402, 14403, 14404, 36224, 36225, 14442, 14440, 14441, 14423, 14438, 14439, 14363, 14367, 14365, 14379, 14380, 36226, 14378);

-- Adds "Hooked Net" to all Stealth Detectors, Init 3.25 - 12.75 sec and repeats 12.5 - 22.25 secs.
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `id` = 0 AND `entryorguid` IN (14375, 14376, 14377, 14402, 14403, 14404, 36224, 36225, 14442, 14440, 14441, 14423, 14438, 14439, 14363, 14367, 14365, 14379, 14380, 36226, 14378);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Dark Ranger Cyndia
(36226, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Ranger Cyndia - In Combat - Cast \'Hooked Net\''),
-- Dark Ranger Anya
(36225, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Ranger Anya - In Combat - Cast \'Hooked Net\''),
-- Dark Ranger Clea
(36224, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Ranger Clea - In Combat - Cast \'Hooked Net\''),
-- Hunter Ragetotem
(14441, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hunter Ragetotem - In Combat - Cast \'Hooked Net\''),
-- Hunter Sagewind
(14440, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hunter Sagewind - In Combat - Cast \'Hooked Net\''),
-- Hunter Thunderhorn
(14442, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hunter Thunderhorn - In Combat - Cast \'Hooked Net\''),
-- Huntress Skymane
(14378, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Huntress Skymane - In Combat - Cast \'Hooked Net\''),
-- Huntress Leafrunner
(14380, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Huntress Leafrunner - In Combat - Cast \'Hooked Net\''),
-- Huntress Ravenoak
(14379, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Huntress Ravenoak - In Combat - Cast \'Hooked Net\''),
-- Officer Brady
(14439, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Officer Brady - In Combat - Cast \'Hooked Net\''),
-- Officer Jaxon
(14423, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Officer Jaxon - In Combat - Cast \'Hooked Net\''),
-- Officer Pomeroy
(14438, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Officer Pomeroy - In Combat - Cast \'Hooked Net\''),
-- Scout Manslayer
(14376, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scout Manslayer - In Combat - Cast \'Hooked Net\''),
-- Scout Stronghand
(14375, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scout Stronghand - In Combat - Cast \'Hooked Net\''),
-- Scout Tharr
(14377, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scout Tharr - In Combat - Cast \'Hooked Net\''),
-- Seeker Cromwell
(14402, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Seeker Cromwell - In Combat - Cast \'Hooked Net\''),
-- Seeker Nahr
(14403, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Seeker Nahr - In Combat - Cast \'Hooked Net\''),
-- Seeker Thompson
(14404, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Seeker Thompson - In Combat - Cast \'Hooked Net\''),
-- Thief Catcher Farmountain
(14365, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thief Catcher Farmountain - In Combat - Cast \'Hooked Net\''),
-- Thief Catcher Shadowdelve
(14363, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thief Catcher Shadowdelve - In Combat - Cast \'Hooked Net\''),
-- Thief Catcher Thunderbrew
(14367, 0, 0, 0, 0, 0, 100, 0, 3250, 12750, 12500, 22250, 0, 0, 11, 14030, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thief Catcher Thunderbrew - In Combat - Cast \'Hooked Net\'');

-- Adds "Invisibility and Stealth Detection" (18950) to creatures:
UPDATE `creature_addon` SET `auras` = '18950' WHERE `guid` IN (6496, 6495, 6494, 203394, 203420, 24786, 24782, 24785, 79818, 90484, 79768, 109, 1814, 91, 46219, 46220, 203395, 46216);

-- Adds "Invisibility and Stealth Detection" (18950) to creature's templates:
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE `entry` IN (14402, 14403, 14404);

-- For Testing use, will freeze them in place
-- UPDATE `creature_addon` SET `auras` = '18950 39258' WHERE `guid` IN (6496, 6495, 6494, 203394, 203420, 24786, 24782, 24785, 79818, 90484, 79768, 109, 1814, 91, 46219, 46220, 203395, 46216);
