-- DB update 2026_03_08_04 -> 2026_03_09_00
-- Update .npc info help text for optional GUID support
UPDATE `command` SET `help` = 'Syntax: .npc info [#creature_guid]\r\n\r\nDisplay a list of details for the selected creature, or for the creature with the given GUID if no target is selected.\r\n\r\nWhen a creature is targeted or found in the current map, the list includes:\r\n- GUID, Faction, NPC flags, Entry ID, Model ID,\r\n- Level,\r\n- Health (current/maximum),\r\n- Field flags, dynamic flags, faction template,\r\n- Position information,\r\n- and the creature type, e.g. if the creature is a vendor.\r\n\r\nWhen only a GUID is given and the creature is not in the current map, DB-stored data is shown (spawn ID, entry, phase, position, map, etc.).'
WHERE `name` = 'npc info';
