-- Remove SmartAI from dark fiend to ScriptedAI (c++)
UPDATE `creature_template` SET
  `AIName` = '',
  `ScriptName` = 'npc_dark_fiend'
WHERE `entry` = 25744;

DELETE FROM `creature_template_spell` WHERE `CreatureID` = 25744 AND `Index` = 0;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(25744, 0, 45944, 0); -- Dark Fiend spell
