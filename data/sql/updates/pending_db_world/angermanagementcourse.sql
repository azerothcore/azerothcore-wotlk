-- Remove Garrick Padfoot rage generation
UPDATE `creature_template` SET `ManaModifier` = 0 WHERE (`entry` = 103);
