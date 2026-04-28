-- DB update 2026_04_27_02 -> 2026_04_27_03
-- Disable player resurrection spells.
-- Uses `disables` with SPELL_DISABLE_PLAYER (flags = 1).

DELETE FROM `disables`
WHERE `sourceType` = 0
  AND `entry` IN (
    -- Priest: Resurrection
    2006, 2010, 10880, 10881, 20770, 25435, 48171,
    -- Paladin: Redemption
    7328, 10322, 10324, 20772, 20773, 48949, 48950,
    -- Shaman: Ancestral Spirit
    2008, 20609, 20610, 20776, 20777, 25590, 49277, 49278,
    -- Druid: Rebirth (combat resurrection)
    20484, 20739, 20742, 20747, 20748, 26994, 48477,
    -- Death Knight: Raise Ally (combat resurrection)
    61999,
    -- Self-resurrection: Shaman Reincarnation
    20608,
    -- Self-resurrection: Warlock Soulstone use effects
    3026, 20707, 20762, 20763, 20764, 20765, 27239, 47883, 47882
  );

INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
-- Priest: Resurrection
(0, 2006, 1, '', '', 'Disable Resurrection rank 1 for players'),
(0, 2010, 1, '', '', 'Disable Resurrection rank 2 for players'),
(0, 10880, 1, '', '', 'Disable Resurrection rank 3 for players'),
(0, 10881, 1, '', '', 'Disable Resurrection rank 4 for players'),
(0, 20770, 1, '', '', 'Disable Resurrection rank 5 for players'),
(0, 25435, 1, '', '', 'Disable Resurrection rank 6 for players'),
(0, 48171, 1, '', '', 'Disable Resurrection rank 7 for players'),
-- Paladin: Redemption
(0, 7328, 1, '', '', 'Disable Redemption rank 1 for players'),
(0, 10322, 1, '', '', 'Disable Redemption rank 2 for players'),
(0, 10324, 1, '', '', 'Disable Redemption rank 3 for players'),
(0, 20772, 1, '', '', 'Disable Redemption rank 4 for players'),
(0, 20773, 1, '', '', 'Disable Redemption rank 5 for players'),
(0, 48949, 1, '', '', 'Disable Redemption rank 6 for players'),
(0, 48950, 1, '', '', 'Disable Redemption rank 7 for players'),
-- Shaman: Ancestral Spirit
(0, 2008, 1, '', '', 'Disable Ancestral Spirit rank 1 for players'),
(0, 20609, 1, '', '', 'Disable Ancestral Spirit rank 2 for players'),
(0, 20610, 1, '', '', 'Disable Ancestral Spirit rank 3 for players'),
(0, 20776, 1, '', '', 'Disable Ancestral Spirit rank 4 for players'),
(0, 20777, 1, '', '', 'Disable Ancestral Spirit rank 5 for players'),
(0, 25590, 1, '', '', 'Disable Ancestral Spirit rank 6 for players'),
(0, 49277, 1, '', '', 'Disable Ancestral Spirit rank 7 for players'),
(0, 49278, 1, '', '', 'Disable Ancestral Spirit rank 8 for players'),
-- Druid: Rebirth (combat resurrection)
(0, 20484, 1, '', '', 'Disable Rebirth rank 1 for players'),
(0, 20739, 1, '', '', 'Disable Rebirth rank 2 for players'),
(0, 20742, 1, '', '', 'Disable Rebirth rank 3 for players'),
(0, 20747, 1, '', '', 'Disable Rebirth rank 4 for players'),
(0, 20748, 1, '', '', 'Disable Rebirth rank 5 for players'),
(0, 26994, 1, '', '', 'Disable Rebirth rank 6 for players'),
(0, 48477, 1, '', '', 'Disable Rebirth rank 7 for players'),
-- Death Knight: Raise Ally (combat resurrection)
(0, 61999, 1, '', '', 'Disable Raise Ally for players'),
-- Self-resurrection: Shaman Reincarnation
(0, 20608, 1, '', '', 'Disable Reincarnation for players'),
-- Self-resurrection: Warlock Soulstone use effects
(0, 3026, 1, '', '', 'Disable Use Soulstone for players'),
(0, 20707, 1, '', '', 'Disable Soulstone effect rank 1 for players'),
(0, 20762, 1, '', '', 'Disable Soulstone effect rank 2 for players'),
(0, 20763, 1, '', '', 'Disable Soulstone effect rank 3 for players'),
(0, 20764, 1, '', '', 'Disable Soulstone effect rank 4 for players'),
(0, 20765, 1, '', '', 'Disable Soulstone effect rank 5 for players'),
(0, 27239, 1, '', '', 'Disable Soulstone effect rank 6 for players'),
(0, 47883, 1, '', '', 'Disable Soulstone effect rank 7 for players'),
(0, 47882, 1, '', '', 'Disable Soulstone effect rank 8 for players');
