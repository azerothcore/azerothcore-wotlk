-- DB update 2026_05_17_04 -> 2026_05_17_05
--
-- Scourgebane Infusion (item 22778 -> spell 28488) and Scourgebane Draught
-- (item 22779 -> spell 28486) are not battle elixirs. Remove them from the
-- Battle Elixir spell group(1) so they stack with each other and other
-- flasks/elixirs.
--
DELETE FROM `spell_group` WHERE `id` = 1 AND `spell_id` IN (28486, 28488);
