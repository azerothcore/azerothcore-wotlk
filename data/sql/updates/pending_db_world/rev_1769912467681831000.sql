-- Fix Toughness (Mining) applying incorrect stamina after relogin
-- Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/10097
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_toughness';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(53040, 'spell_gen_toughness'),  -- Rank 6: +60 Stamina
(53120, 'spell_gen_toughness'),  -- Rank 1: +3 Stamina
(53121, 'spell_gen_toughness'),  -- Rank 2: +5 Stamina
(53122, 'spell_gen_toughness'),  -- Rank 3: +7 Stamina
(53123, 'spell_gen_toughness'),  -- Rank 4: +10 Stamina
(53124, 'spell_gen_toughness');  -- Rank 5: +30 Stamina
