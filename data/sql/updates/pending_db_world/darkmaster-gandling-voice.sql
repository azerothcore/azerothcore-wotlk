-- Fix Darkmaster Gandling in Scholomance voice lines
-- Now will pronounce "School is in session!" when spawning
  
UPDATE `creature_text` SET `Sound` = 27477 WHERE `CreatureID` = 1853 AND `BroadcastTextId` = 7145;
