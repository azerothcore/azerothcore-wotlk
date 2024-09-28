--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` & ~2048 WHERE `entry` IN (
3672,  -- Boahn
20783, -- Porfus the Gem Gorger
21639, -- Illidari Slayer
21717, -- Dragonmaw Wrangler
12100, -- Lava Reaver
22076, -- Torloth the Magnificent
22004  -- Leoroxx
);
