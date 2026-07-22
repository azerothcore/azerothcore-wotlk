-- Majestic Dragon Figurine (60524): allow instant HoT casts to trigger the item proc.
UPDATE `spell_proc` SET `SpellTypeMask` = 7 WHERE `SpellId` = 60524;
