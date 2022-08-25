-- Obsidian Eradicator (15262)
UPDATE `creature_template` SET `DamageModifier` = 22.5, `ArmorModifier` = 1.55 WHERE (`entry` = 15262);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15262) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15262, 2, 75, 0),
(15262, 3, 75, 0),
(15262, 4, 75, 0),
(15262, 5, 75, 0),
(15262, 6, 75, 0);

-- Anubisath Sentinel (15264)
UPDATE `creature_template` SET `DamageModifier` = 17, `ArmorModifier` = 1.15 WHERE (`entry` = 15264);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15264) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15264, 2, 75, 0),
(15264, 3, 75, 0),
(15264, 4, 75, 0),
(15264, 5, 75, 0),
(15264, 6, 75, 0);

-- The Prophet Skeram (15263) 20
UPDATE `creature_template` SET `DamageModifier` = 20.05, `ArmorModifier` = 1.3 WHERE (`entry` = 15263);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15263) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15263, 2, 75, 0),
(15263, 3, 75, 0),
(15263, 4, 75, 0),
(15263, 5, 75, 0),
(15263, 6, 75, 0);

-- Qiraji Brainwasher (15247)
UPDATE `creature_template` SET `DamageModifier` = 12, `ArmorModifier` = 1.15 WHERE (`entry` = 15247);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15247) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15247, 2, 75, 0),
(15247, 3, 75, 0),
(15247, 4, 75, 0),
(15247, 5, 75, 0),
(15247, 6, 75, 0);

-- Vekniss Guardian (15233)
UPDATE `creature_template` SET `DamageModifier` = 15, `ArmorModifier` = 1.35 WHERE (`entry` = 15233);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15233) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15233, 2, 75, 0),
(15233, 3, 75, 0),
(15233, 4, 75, 0),
(15233, 5, 75, 0),
(15233, 6, 75, 0);

-- Vekniss Warrior (15230)
UPDATE `creature_template` SET `DamageModifier` = 12, `ArmorModifier` = 1.15 WHERE (`entry` = 15230);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15230) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15230, 2, 75, 0),
(15230, 3, 75, 0),
(15230, 4, 75, 0),
(15230, 5, 75, 0),
(15230, 6, 75, 0);

-- Vem (15544)
UPDATE `creature_template` SET `DamageModifier` = 22.5, `ArmorModifier` = 1.3 WHERE (`entry` = 15544);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15544) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15544, 2, 75, 0),
(15544, 3, 75, 0),
(15544, 4, 75, 0),
(15544, 5, 75, 0),
(15544, 6, 75, 0);

-- Lord Kri (15511)
UPDATE `creature_template` SET `DamageModifier` = 31.25, `ArmorModifier` = 1.3 WHERE (`entry` = 15511);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15511) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15511, 2, 75, 0),
(15511, 3, 75, 0),
(15511, 4, 75, 0),
(15511, 5, 75, 0),
(15511, 6, 75, 0);

-- Princess Yauj (15543)
UPDATE `creature_template` SET `DamageModifier` = 20.05, `ArmorModifier` = 1.3 WHERE (`entry` = 15543);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15543) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15543, 2, 75, 0),
(15543, 3, 75, 0),
(15543, 4, 75, 0),
(15543, 5, 75, 0),
(15543, 6, 75, 0);

-- Yauj Brood (15621)
UPDATE `creature_template` SET `DamageModifier` = 3.3, `ArmorModifier` = 1.1 WHERE (`entry` = 15621);

-- Battleguard Sartura (15516)
UPDATE `creature_template` SET `DamageModifier` = 18, `ArmorModifier` = 1.3 WHERE (`entry` = 15516);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15516) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15516, 2, 75, 0),
(15516, 3, 75, 0),
(15516, 4, 75, 0),
(15516, 5, 75, 0),
(15516, 6, 75, 0);

-- Sartura's Royal Guard (15984)
UPDATE `creature_template` SET `speed_run` = 2.14286, `DamageModifier` = 14.4, `ArmorModifier` = 1.15 WHERE (`entry` = 15984);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15984) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15984, 2, 15, 0),
(15984, 3, 15, 0),
(15984, 4, 15, 0),
(15984, 5, 15, 0),
(15984, 6, 15, 0);

-- Vekniss Drone (15300)
UPDATE `creature_template` SET `DamageModifier` = 2.05, `ArmorModifier` = 1.1 WHERE (`entry` = 15300);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15300) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15300, 2, 75, 0),
(15300, 3, 75, 0),
(15300, 4, 75, 0),
(15300, 5, 75, 0),
(15300, 6, 75, 0);

-- Vekniss Soldier (15229)
UPDATE `creature_template` SET `DamageModifier` = 8, `ArmorModifier` = 1.15 WHERE (`entry` = 15229);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15229) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15229, 2, 75, 0),
(15229, 3, 75, 0),
(15229, 4, 75, 0),
(15229, 5, 75, 0),
(15229, 6, 75, 0);

-- Fankriss the Unyielding (15510)
UPDATE `creature_template` SET `DamageModifier` = 20.05, `ArmorModifier` = 1.3 WHERE (`entry` = 15510);	

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15510) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15510, 2, 75, 0),
(15510, 3, 75, 0),
(15510, 4, 75, 0),
(15510, 5, 75, 0),
(15510, 6, 75, 0);

-- Spawn of Fankriss (15630)
UPDATE `creature_template` SET `DamageModifier` = 26.05, `ArmorModifier` = 1.3 WHERE (`entry` = 15630);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15630) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15630, 2, 15, 0),
(15630, 3, 15, 0),
(15630, 4, 15, 0),
(15630, 5, 15, 0),
(15630, 6, 15, 0);

-- Vekniss Hatchling (15962)
UPDATE `creature_template` SET `DamageModifier` = 7.95, `ArmorModifier` = 1.1 WHERE (`entry` = 15962);

-- Viscidus (15299)
UPDATE `creature_template` SET `DamageModifier` = 21.45, `ArmorModifier` = 1.3 WHERE (`entry` = 15299);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15299) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15299, 2, 75, 0),
(15299, 3, 75, 0),
(15299, 4, 75, 0),
(15299, 5, 75, 0),
(15299, 6, 75, 0);

-- Glob of Viscidus (15667)
UPDATE `creature_template` SET `DamageModifier` = 4.65, `ArmorModifier` = 1.1 WHERE (`entry` = 15667);

-- Vekniss Hive Crawler (15240)
UPDATE `creature_template` SET `DamageModifier` = 20, `ArmorModifier` = 1.2 WHERE (`entry` = 15240);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15240) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15240, 2, 75, 0),
(15240, 3, 75, 0),
(15240, 4, 75, 0),
(15240, 5, 75, 0),
(15240, 6, 75, 0);

-- Vekniss Stinger (15235)
UPDATE `creature_template` SET `DamageModifier` = 12, `ArmorModifier` = 1.2 WHERE (`entry` = 15235);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15235) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15235, 2, 75, 0),
(15235, 3, 75, 0),
(15235, 4, 75, 0),
(15235, 5, 75, 0),
(15235, 6, 75, 0);

-- Vekniss Wasp (15236)
UPDATE `creature_template` SET `DamageModifier` = 8, `ArmorModifier` = 1.1 WHERE (`entry` = 15236);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15236) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15236, 2, 75, 0),
(15236, 3, 75, 0),
(15236, 4, 75, 0),
(15236, 5, 75, 0),
(15236, 6, 75, 0);

-- Qiraji Lasher (15249)
UPDATE `creature_template` SET `DamageModifier` = 14.4, `ArmorModifier` = 1.15 WHERE (`entry` = 15249);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15249) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15249, 2, 75, 0),
(15249, 3, 75, 0),
(15249, 4, 75, 0),
(15249, 5, 75, 0),
(15249, 6, 75, 0);

-- Princess Huhuran (15509)
UPDATE `creature_template` SET `ArmorModifier` = 1.3 WHERE (`entry` = 15509);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15509) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15509, 2, 75, 0),
(15509, 3, 75, 0),
(15509, 4, 75, 0),
(15509, 5, 75, 0),
(15509, 6, 75, 0);

-- Anubisath Defender (15277)
UPDATE `creature_template` SET `DamageModifier` = 30.05, `ArmorModifier` = 1.2 WHERE (`entry` = 15277);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15277) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15277, 2, 75, 0),
(15277, 3, 75, 0),
(15277, 4, 75, 0),
(15277, 5, 75, 0),
(15277, 6, 75, 0);

-- Emperor Vek'nilash (15275)
UPDATE `creature_template` SET `ArmorModifier` = 1.3 WHERE (`entry` = 15275);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15275) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15275, 2, 75, 0),
(15275, 3, 75, 0),
(15275, 4, 75, 0),
(15275, 5, 75, 0),
(15275, 6, 75, 0);

-- Emperor Vek'lor (15276)
UPDATE `creature_template` SET `DamageModifier` = 30.05, `ArmorModifier` = 1.6 WHERE (`entry` = 15276);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15276) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15276, 2, 75, 0),
(15276, 3, 75, 0),
(15276, 4, 75, 0),
(15276, 5, 75, 0),
(15276, 6, 75, 0);

-- Qiraji Champion (15252)
UPDATE `creature_template` SET `DamageModifier` = 25, `ArmorModifier` = 1.3 WHERE (`entry` = 15252);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15252) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15252, 2, 75, 0),
(15252, 3, 75, 0),
(15252, 4, 75, 0),
(15252, 5, 75, 0),
(15252, 6, 75, 0);

-- Qiraji Slayer (15250)
UPDATE `creature_template` SET `DamageModifier` = 20, `ArmorModifier` = 1.15 WHERE (`entry` = 15250);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15250) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15250, 2, 75, 0),
(15250, 3, 75, 0),
(15250, 4, 75, 0),
(15250, 5, 75, 0),
(15250, 6, 75, 0);

-- Obsidian Nullifier (15312)
UPDATE `creature_template` SET `DamageModifier` = 23.2, `ArmorModifier` = 1.45 WHERE (`entry` = 15312);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15312) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15312, 2, 75, 0),
(15312, 3, 75, 0),
(15312, 4, 75, 0),
(15312, 5, 75, 0),
(15312, 6, 75, 0);

-- Anubisath Warder (15311)
UPDATE `creature_template` SET `DamageModifier` = 28, `ArmorModifier` = 1.3 WHERE (`entry` = 15311);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15311) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15311, 2, 75, 0),
(15311, 3, 75, 0),
(15311, 4, 75, 0),
(15311, 5, 75, 0),
(15311, 6, 75, 0);

-- Ouro (15517)
UPDATE `creature_template` SET `DamageModifier` = 47.3, `ArmorModifier` = 1.3 WHERE (`entry` = 15517);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15517) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15517, 2, 75, 0),
(15517, 3, 75, 0),
(15517, 4, 75, 0),
(15517, 5, 75, 0),
(15517, 6, 75, 0);

-- Ouro Scarab (15718)
UPDATE `creature_template` SET `DamageModifier` = 2.25, `ArmorModifier` = 0.7 WHERE (`entry` = 15718);

-- C'Thun (15727)
UPDATE `creature_template` SET `DamageModifier` = 1.05, `ArmorModifier` = 1.3 WHERE (`entry` = 15727);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15727) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15727, 2, 75, 0),
(15727, 3, 75, 0),
(15727, 4, 75, 0),
(15727, 5, 75, 0),
(15727, 6, 75, 0);

-- Eye of C'Thun (15589)
UPDATE `creature_template` SET `DamageModifier` = 14.85, `ArmorModifier` = 1.3 WHERE (`entry` = 15589);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15589) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15589, 2, 75, 0),
(15589, 3, 75, 0),
(15589, 4, 75, 0),
(15589, 5, 75, 0),
(15589, 6, 75, 0);

-- Giant Eye Tentacle (15334)
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 1, `DamageModifier` = 9.95, `ArmorModifier` = 1.35 WHERE (`entry` = 15334);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15334) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15334, 2, 75, 0),
(15334, 3, 75, 0),
(15334, 4, 75, 0),
(15334, 5, 75, 0),
(15334, 6, 75, 0);

-- Claw Tentacle (15725)
UPDATE `creature_template` SET `DamageModifier` = 2, `ArmorModifier` = 1.35 WHERE (`entry` = 15725);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15725) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15725, 2, 75, 0),
(15725, 3, 75, 0),
(15725, 4, 75, 0),
(15725, 5, 75, 0),
(15725, 6, 75, 0);

-- Eye Tentacle (15726)
UPDATE `creature_template` SET `DamageModifier` = 2, `ArmorModifier` = 1.35 WHERE (`entry` = 15726);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15726) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15726, 2, 75, 0),
(15726, 3, 75, 0),
(15726, 4, 75, 0),
(15726, 5, 75, 0),
(15726, 6, 75, 0);

-- Giant Claw Tentacle (15728)
UPDATE `creature_template` SET `DamageModifier` = 39.55, `ArmorModifier` = 1.35 WHERE (`entry` = 15728);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15728) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15728, 2, 75, 0),
(15728, 3, 75, 0),
(15728, 4, 75, 0),
(15728, 5, 75, 0),
(15728, 6, 75, 0);

-- Flesh Tentacle (15802)
UPDATE `creature_template` SET `DamageModifier` = 3.75, `ArmorModifier` = 1.35 WHERE (`entry` = 15802);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15802) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15802, 2, 75, 0),
(15802, 3, 75, 0),
(15802, 4, 75, 0),
(15802, 5, 75, 0),
(15802, 6, 75, 0);

-- Vekniss Borer (15622)
UPDATE `creature_template` SET `DamageModifier` = 7.05, `ArmorModifier` = 1.1 WHERE (`entry` = 15622);

DELETE FROM `creature_template_resistance` WHERE (`CreatureID` = 15622) AND (`School` IN (2, 3, 4, 5, 6));
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(15622, 2, 75, 0),
(15622, 3, 75, 0),
(15622, 4, 75, 0),
(15622, 5, 75, 0),
(15622, 6, 75, 0);
