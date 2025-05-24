--
UPDATE `creature_template` SET `ScriptName` = 'npc_lor_themar_theron' WHERE (`entry` = 16802);
UPDATE `creature_template` SET `ScriptName` = 'npc_king_varian_wrynn' WHERE (`entry` = 29611);
UPDATE `creature_template` SET `ScriptName` = 'npc_tyrande_whisperwind' WHERE (`entry` = 7999);
UPDATE `creature_template` SET `ScriptName` = 'npc_king_magni_bronzebeard', `AIName` = '' WHERE (`entry` = 2784);
UPDATE `creature_template` SET `ScriptName` = 'npc_prophet_velen', `AIName` = '' WHERE (`entry` = 17468);

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (2784,17468)) AND (`source_type` = 0);
