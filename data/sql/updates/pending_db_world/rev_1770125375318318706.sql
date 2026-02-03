-- Light's Grace (31834) - Remove erroneous spell_proc entry that caused buff to consume itself immediately
-- The buff should passively reduce Holy Light cast time while active, not have proc behavior
DELETE FROM `spell_proc` WHERE `SpellId` = 31834;
