--
-- Update Flesh Eating Worms in Duskwood to attack on spawn. Previously, they would ignore users in melee range when they spawn in, and the field for AIName was empty. 
UPDATE `creature_template` SET `AIName` = 'AggressorAI' WHERE (`entry` = 2462);
