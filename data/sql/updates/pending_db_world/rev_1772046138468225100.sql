--
DELETE FROM `spell_proc` WHERE `SpellId` IN (21747,24256,27997,28460,33511,33522,38319,40303,43730,43983,44546,44548,44549,45396,45398,45444,49027,49542,49543,55717);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `ProcFlags`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(21747, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50000, 0), -- Lawbringer
(24256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240000, 0), -- Primal Blessing Trigger DND
(27997, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50000, 0), -- Spellsurge Trigger
(28460, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5000, 0), -- Wail of Souls
(33511, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17000, 0), -- Mana Restore
(33522, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25000, 0), -- Mana Restore 2
(38319, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50000, 0), -- Forgotten Knowledge
(40303, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1000, 0), -- Spell Bomb
(43730, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 8000, 0), -- Stormchops
(43983, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 500, 0), -- Energy Storm
(44546, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3000, 0), -- Brain Freeze
(44548, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3000, 0), -- Brain Freeze
(44549, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3000, 0), -- Brain Freeze
(45396, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 45000, 0), -- Blessed Weapon Coating
(45398, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45000, 0), -- Righteous Weapon Coating
(45444, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45000, 0), -- Bonfire's Blessing
(49027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20000, 0), -- Bloodworms
(49542, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20000, 0), -- Bloodworms
(49543, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20000, 0), -- Bloodworms
(55717, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5000, 0); -- Wail of Souls
