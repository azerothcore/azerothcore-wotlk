-- DB update 2026_08_31_00 -> 2026_08_31_01
-- Hurl Pyrite Barrel (62490) drains the Demolisher Mechanic Seat's pyrite through its own
-- DBC effect now (trigger of the serverside power-burn spell 62474), so the linked-spell
-- workaround would burn the seat twice.
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 62490 AND `spell_effect` = 62474;
