-- Remove wrong aura (SPELL_DK_CORPSE_EXPLOSION_VISUAL) from Venture Co. Ruffian
-- https://github.com/azerothcore/azerothcore-wotlk/issues/26403
UPDATE `creature_addon` SET `auras` = NULL WHERE `guid` = 133027;
