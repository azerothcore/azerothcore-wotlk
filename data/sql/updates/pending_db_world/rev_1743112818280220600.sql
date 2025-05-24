-- Removes `Quest Giver` from template and adds `Hide Nameplate` (this requires clear cache if seen before)
UPDATE `creature_template` SET `npcflag` = `npcflag` &~ 2, `type_flags` = `type_flags` | 1048576 WHERE (`entry` = 17600);

-- Adds the `Quest Giver` to the only NPC (by GUID) that allow you to deliver the quest.
UPDATE `creature` SET `npcflag` = `npcflag` | 2 WHERE (`id1` = 17600 AND `guid` = 84427);
