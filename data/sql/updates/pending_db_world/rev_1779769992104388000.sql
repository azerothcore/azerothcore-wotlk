--
-- Rokmar the Crackler - drop Grievous Wound script binding.
--
-- An earlier revision of this file mapped spells 31956 / 38801 to the
-- AuraScript spell_rokmar_grievous_wound, which has since been removed
-- from boss_rokmar_the_crackler.cpp (the bleed cast itself is also
-- removed from his rotation). Strip any leftover binding so the
-- worldserver doesn't print "Script named '...' is assigned in the
-- database, but has no code!" on startup. No-op on fresh databases.

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_rokmar_grievous_wound';
