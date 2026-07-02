-- Fix Venture Co. Ruffian spawn (guid 133027, Sholazar Basin ~34,46) rendering
-- as a rotting corpse texture at rest, returning to normal on taking damage.
-- creature_addon.auras was set to 51270 (SPELL_DK_CORPSE_EXPLOSION_VISUAL),
-- a Death Knight visual spell that has no relation to this NPC and was
-- permanently applied at spawn. Every other spawn of entry 28124 has no auras.
-- https://github.com/azerothcore/azerothcore-wotlk/issues/26403
DELETE FROM `creature_addon` WHERE `guid` = 133027;
INSERT INTO `creature_addon`
    (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`)
VALUES
    (133027, 0, 0, 0, 1, 0, 0, NULL);
