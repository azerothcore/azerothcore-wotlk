-- Increase Fists of fury proc chance to approx. 5%
UPDATE `spell_proc_event` SET `ppmRate` = 1.5 WHERE (`entry` = 41989);
