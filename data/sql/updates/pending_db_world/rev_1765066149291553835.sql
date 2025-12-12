--
UPDATE `creature_template` SET `ScriptName` = 'npc_oathbound_warder' WHERE `entry` = 30270;

DELETE FROM `creature_template_spell` WHERE `CreatureID` = 30270;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(30270, 0, 56491, 12340),
(30270, 1, 56425, 12340),
(30270, 2, 56451, 12340),
(30270, 3, 56506, 12340);
