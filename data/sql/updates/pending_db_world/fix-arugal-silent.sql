-- Fix Archmage Arugal is silend during Shadowfang Keep progression
-- All voices IDs were taken from Wowhead
UPDATE `creature_text` SET `Sound` = 5793 WHERE `CreatureID` = 4275 AND `BroadcastTextId` = 6115;
UPDATE `creature_text` SET `Sound` = 5791 WHERE `CreatureID` = 4275 AND `BroadcastTextId` = 1435;
UPDATE `creature_text` SET `Sound` = 5797 WHERE `CreatureID` = 4275 AND `BroadcastTextId` = 6535;
UPDATE `creature_text` SET `Sound` = 5795 WHERE `CreatureID` = 4275 AND `BroadcastTextId` = 6116;
