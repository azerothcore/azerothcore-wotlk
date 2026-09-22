-- Elune's Wrath (64823): only consume the buff when it actually made the Starfire cast instant.
UPDATE `spell_proc` SET `AttributesMask` = `AttributesMask`|8 WHERE `SpellId` = 64823;
-- Firestarter (54741): only consume the buff when it actually made the Flamestrike cast instant/free.
UPDATE `spell_proc` SET `AttributesMask` = `AttributesMask`|8 WHERE `SpellId` = 54741;
-- Netherwind Focus (22008): only consume the buff when it actually made the cast instant.
UPDATE `spell_proc` SET `AttributesMask` = `AttributesMask`|8 WHERE `SpellId` = 22008;
