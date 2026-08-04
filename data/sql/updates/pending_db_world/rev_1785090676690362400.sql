-- Sudden Death (52437) was consuming itself when Execute finished casting rather than when it
-- landed, so a missed or dodged Execute burned the buff without granting anything.
UPDATE `spell_proc` SET `SpellPhaseMask` = 2 WHERE `SpellId` = 52437;
