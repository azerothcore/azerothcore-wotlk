-- DB update 2026_11_26_00 -> 2026_11_28_00
-- Now is the Time!, Pendulum of Telluric Currents, Flame of the Heavens: also proc from harmful spells that deal no damage on hit (DoT applications)
UPDATE `spell_proc` SET `SpellTypeMask` = 0x5 WHERE `SpellId` IN (60063, 60482, 64714);
-- Now is the Time!: its DBC proc flags also take done positive magic spells, which the type mask above would let through
UPDATE `spell_proc` SET `ProcFlags` = 0x10000 WHERE `SpellId` = 60063;
