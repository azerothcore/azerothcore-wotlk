DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9500) OR (`source_type` = 9 AND `entryorguid` = 950000);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_mistress_nagmara' WHERE `entry` = 9500;
UPDATE `creature_text` SET `Type` = 16 WHERE `CreatureID` = 9500 AND `GroupID` = 3 AND `ID` = 0;
UPDATE `creature_text` SET `Type` = 16 WHERE `CreatureID` = 9503 AND `GroupID` = 5 AND `ID` = 0;
