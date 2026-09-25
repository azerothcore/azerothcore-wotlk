-- DB update 2026_07_22_03 -> 2026_07_22_04
-- Majestic Dragon Figurine (60524): allow instant HoT casts to trigger the item proc.
UPDATE `spell_proc` SET `SpellTypeMask` = 7 WHERE `SpellId` = 60524;
