-- Lock and Load (-56342): fix SpellPhaseMask from HIT (2) to FINISH (4)
UPDATE `spell_proc` SET `SpellPhaseMask` = 4 WHERE `SpellId` = -56342;
