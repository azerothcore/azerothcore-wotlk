-- Dun Niffelem (area 4495): add missing spell_area entry so spell 55858 continues
-- to apply after quest 12967 (Battling the Elements) is rewarded.
-- All surrounding areas (4437-4440, 4455) have two entries for spell 55858:
--   one for while quest 12924 is active, and one for after quest 12967 is rewarded.
-- Area 4495 only had the first entry (with quest_end=12967 removing it on completion),
-- causing players who finished Battling the Elements to lose the phase needed to
-- interact with NPCs and pick up follow-up quests in Dun Niffelem.
-- Fixes: https://github.com/azerothcore/azerothcore-wotlk/issues/25365
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`)
VALUES (55858, 4495, 12967, 0, 0, 0, 2, 1, 64, 11);
