-- DB update 2026_02_23_01 -> 2026_02_23_02
-- Darkmoon Card: Illusion - remove duplicate mana restore (handled by C++ script)
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -57350 AND `spell_effect` = 60242;
