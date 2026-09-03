
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_brann_radio' WHERE (`entry` = 34054);
DELETE FROM `areatrigger_scripts` WHERE (`entry` IN (5414, 5415, 5416, 5417, 5442, 5443));
DELETE FROM `smart_scripts` WHERE (`source_type` = 2) AND (`entryorguid` IN (5414, 5415, 5416, 5417, 5442, 5443));
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-1975198, -1975199, -1975200, -1975201, -1975202, -1975203));
