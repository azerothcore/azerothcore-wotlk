-- DB update 2022_09_02_03 -> 2022_09_02_04
-- Gurubashi Axe Thrower (11350) & Zulian Crocolisk (15043)
UPDATE `creature_template` SET `DamageModifier` = 4.05, `ArmorModifier` = 1.1 WHERE `entry` IN (11350,15043);
-- Hakkari Priest (11830)
UPDATE `creature_template` SET `DamageModifier` = 5.05, `ArmorModifier` = 1.1 WHERE (`entry` = 11830);
-- Razzashi Serpent (11371)
UPDATE `creature_template` SET `DamageModifier` = 4, `ArmorModifier` = 1.1 WHERE (`entry` = 11371);
-- Razzashi Adder (11372)
UPDATE `creature_template` SET `DamageModifier` = 4.2, `ArmorModifier` = 1.1 WHERE (`entry` = 11372);
-- Hooktooth Frenzy (11374)
UPDATE `creature_template` SET `DamageModifier` = 2.4, `ArmorModifier` = 1.1 WHERE (`entry` = 11374);
-- Gurubashi Headhunter (11351)
UPDATE `creature_template` SET `DamageModifier` = 5, `ArmorModifier` = 1.1 WHERE (`entry` = 11351);
-- Hakkari Witch Doctor (11831)
UPDATE `creature_template` SET `DamageModifier` = 6.05, `ArmorModifier` = 1.1 WHERE (`entry` = 11831);
-- Bloodseeker Bat (11368)
UPDATE `creature_template` SET `DamageModifier` = 1.25, `ArmorModifier` = 1.1 WHERE (`entry` = 11368);
-- Gurubashi Bat Rider (14750)
UPDATE `creature_template` SET `DamageModifier` = 10, `ArmorModifier` = 1.15 WHERE (`entry` = 14750);
-- High Priestess Jeklik (14517)
UPDATE `creature_template` SET `ArmorModifier` = 1.3 WHERE (`entry` = 14517);
-- Gurubashi Berserker (11352)
UPDATE `creature_template` SET `DamageModifier` = 14, `ArmorModifier` = 1.2 WHERE (`entry` = 11352);
-- Sandfury Speaker (11387)
UPDATE `creature_template` SET `DamageModifier` = 9.05, `ArmorModifier` = 1.15 WHERE (`entry` = 11387);
-- Razzashi Cobra (11373)
UPDATE `creature_template` SET `DamageModifier` = 9.4, `ArmorModifier` = 1.1 WHERE (`entry` = 11373);
-- High Priest Venoxis (14507)
UPDATE `creature_template` SET `DamageModifier` = 14.05, `ArmorModifier` = 1.3 WHERE (`entry` = 14507);
-- Razzashi Skitterer (14880)
UPDATE `creature_template` SET `DamageModifier` = 4.15 WHERE (`entry` = 14880);
-- Razzashi Broodwidow (11370)
UPDATE `creature_template` SET `DamageModifier` = 10.25, `ArmorModifier` = 1.15 WHERE (`entry` = 11370);
-- Hakkari Shadowcaster (11338)
UPDATE `creature_template` SET `DamageModifier` = 8, `ArmorModifier` = 1.15 WHERE (`entry` = 11338);
-- Razzashi Venombrood (14532)
UPDATE `creature_template` SET `DamageModifier` = 10, `ArmorModifier` = 1.1 WHERE (`entry` = 14532);
-- Witherbark Speaker (11388)
UPDATE `creature_template` SET `DamageModifier` = 7.4, `ArmorModifier` = 1.55 WHERE (`entry` = 11388);
-- High Priestess Mar'li (14510)
UPDATE `creature_template` SET `DamageModifier` = 14.05, `ArmorModifier` = 1.3 WHERE (`entry` = 14510);
-- Spawn of Mar'li (15041)
UPDATE `creature_template` SET `DamageModifier` = 4.85, `ArmorModifier` = 1.1 WHERE (`entry` = 15041);
-- Gurubashi Blood Drinker (11353)
UPDATE `creature_template` SET `DamageModifier` = 9, `ArmorModifier` = 1.1 WHERE (`entry` = 11353);
-- Razzashi Raptor (14821)
UPDATE `creature_template` SET `DamageModifier` = 8, `ArmorModifier` = 1.1 WHERE (`entry` = 14821);
-- Gurubashi Champion (11356)
UPDATE `creature_template` SET `DamageModifier` = 7, `ArmorModifier` = 1.15 WHERE (`entry` = 11356);
-- Vilebranch Speaker (11391)
UPDATE `creature_template` SET `DamageModifier` = 9.05, `ArmorModifier` = 1.25 WHERE (`entry` = 11391);
-- Bloodlord Mandokir (11382)
UPDATE `creature_template` SET `DamageModifier` = 21.25, `ArmorModifier` = 1.3 WHERE (`entry` = 11382);
-- Ohgan (14988)
UPDATE `creature_template` SET `DamageModifier` = 13.6, `ArmorModifier` = 1.1 WHERE (`entry` = 14988);
-- Zanza the Restless (15042)
UPDATE `creature_template` SET `DamageModifier` = 2.55, `ArmorModifier` = 1.1 WHERE (`entry` = 15042);
-- Mad Servant (15111)
UPDATE `creature_template` SET `DamageModifier` = 7.45, `ArmorModifier` = 1.15 WHERE (`entry` = 15111);
-- Mad Voidwalker (15146)
UPDATE `creature_template` SET `dmgschool` = 5, `DamageModifier` = 5 WHERE (`entry` = 15146);
-- Hakkari Blood Priest (11340)
UPDATE `creature_template` SET `DamageModifier` = 6, `ArmorModifier` = 1.15 WHERE (`entry` = 11340);
-- Gri'lek (15082)
UPDATE `creature_template` SET `DamageModifier` = 22.5, `ArmorModifier` = 1.3 WHERE (`entry` = 15082);
-- Wushoolay (15085)
UPDATE `creature_template` SET `DamageModifier` = 22.5, `ArmorModifier` = 1.3 WHERE (`entry` = 15085);
-- Renataki (15084)
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 1.57143, `DamageModifier` = 15.05, `BaseAttackTime` = 1500, `ArmorModifier` = 1.3 WHERE (`entry` = 15084);
-- Hazza'rah (15083)
UPDATE `creature_template` SET `DamageModifier` = 22.5, `ArmorModifier` = 1.3 WHERE (`entry` = 15083);
-- Nightmare Illusion (15163)
UPDATE `creature_template` SET `DamageModifier` = 51.95, `ArmorModifier` = 1.1 WHERE (`entry` = 15163);
-- Zulian Tiger (11361)
UPDATE `creature_template` SET `DamageModifier` = 8.85, `ArmorModifier` = 1.1 WHERE (`entry` = 11361);
-- Zulian Cub (11360)
UPDATE `creature_template` SET `DamageModifier` = 3.1, `ArmorModifier` = 1.1 WHERE (`entry` = 11360);
-- Zealot Zath (11348)
UPDATE `creature_template` SET `DamageModifier` = 12.2, `ArmorModifier` = 1.2 WHERE (`entry` = 11348);
-- Zealot Lor'Khan (11347)
UPDATE `creature_template` SET `DamageModifier` = 14.2, `ArmorModifier` = 1.5 WHERE (`entry` = 11347);
-- High Priest Thekal (14509)
UPDATE `creature_template` SET `DamageModifier` = 17.55, `ArmorModifier` = 1.3 WHERE (`entry` = 14509);
-- Zulian Guardian (15068)
UPDATE `creature_template` SET `DamageModifier` = 3, `ArmorModifier` = 1.2 WHERE (`entry` = 15068);
-- Gahz'ranka (15114)
UPDATE `creature_template` SET `DamageModifier` = 20.05, `ArmorModifier` = 1.3 WHERE (`entry` = 15114);
-- Voodoo Spirit (15009)
UPDATE `creature_template` SET `DamageModifier` = 0.1, `ArmorModifier` = 1.1 WHERE (`entry` = 15009);
-- Zulian Panther (11365)
UPDATE `creature_template` SET `DamageModifier` = 15.7, `ArmorModifier` = 1.1 WHERE (`entry` = 11365);
-- Hakkari Shadow Hunter (11339)
UPDATE `creature_template` SET `DamageModifier` = 6, `ArmorModifier` = 1.15 WHERE (`entry` = 11339);
-- Zulian Stalker (15067)
UPDATE `creature_template` SET `DamageModifier` = 6.2, `ArmorModifier` = 1.15 WHERE (`entry` = 15067);
-- High Priestess Arlokk (14515)
UPDATE `creature_template` SET `ArmorModifier` = 1.3 WHERE (`entry` = 14515);
-- Zulian Prowler (15101)
UPDATE `creature_template` SET `DamageModifier` = 2.25, `ArmorModifier` = 1.1 WHERE (`entry` = 15101);
-- Voodoo Slave (14883)
UPDATE `creature_template` SET `DamageModifier` = 10.3, `ArmorModifier` = 1.1 WHERE (`entry` = 14883);
-- Withered Mistress (14825)
UPDATE `creature_template` SET `DamageModifier` = 11.7, `ArmorModifier` = 1.1 WHERE (`entry` = 14825);
-- Atal'ai Mistress (14882)
UPDATE `creature_template` SET `DamageModifier` = 9.6, `ArmorModifier` = 1.1 WHERE (`entry` = 14882);
-- Sacrificed Troll (14826)
UPDATE `creature_template` SET `DamageModifier` = 1.5, `ArmorModifier` = 1.05 WHERE (`entry` = 14826);
-- Jin'do the Hexxer (11380)
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 2.14286, `DamageModifier` = 17.05, `ArmorModifier` = 1.3 WHERE (`entry` = 11380);
-- Soulflayer (11359)
UPDATE `creature_template` SET `DamageModifier` = 12, `ArmorModifier` = 1.15 WHERE (`entry` = 11359);
-- Son of Hakkar (11357)
UPDATE `creature_template` SET `DamageModifier` = 7.15, `ArmorModifier` = 1.65 WHERE (`entry` = 11357);
-- Bloodscalp Speaker (11389)
UPDATE `creature_template` SET `DamageModifier` = 5, `ArmorModifier` = 1.15 WHERE (`entry` = 11389);
-- Skullsplitter Speaker (11390)
UPDATE `creature_template` SET `gossip_menu_id` = 0, `DamageModifier` = 5, `ArmorModifier` = 1.15 WHERE (`entry` = 11390);
-- Hakkar (14834)
UPDATE `creature_template` SET `ArmorModifier` = 1.3 WHERE (`entry` = 14834);

-- Resistances
DELETE FROM `creature_template_resistance` WHERE `CreatureID` IN (11370,14880,14507,11373,11387,11352,14517,14750,11368,11831,11351,11374,15043,11372,11371,11830,11350,14532,11338,11388,14510,11353,14821,11356,11391,11382,14988,15111,15146,11340,15085,15082,15084,15083,15163,11361,11360,11348,11347,14509,15114,11365,15067,14515,14883,14825,14882,11359,11357,11389,11390,14834,11339,11380);
INSERT INTO `creature_template_resistance` (`CreatureID`, `School`, `Resistance`, `VerifiedBuild`) VALUES
(11370, 2, 15, 0),
(11370, 3, 15, 0),
(11370, 4, 15, 0),
(11370, 5, 15, 0),
(11370, 6, 15, 0),
(14880, 2, 15, 0),
(14880, 3, 15, 0),
(14880, 4, 15, 0),
(14880, 5, 15, 0),
(14880, 6, 15, 0),
(14507, 2, 15, 0),
(14507, 3, 15, 0),
(14507, 4, 15, 0),
(14507, 5, 15, 0),
(14507, 6, 15, 0),
(11373, 2, 15, 0),
(11373, 3, 15, 0),
(11373, 4, 15, 0),
(11373, 5, 15, 0),
(11373, 6, 15, 0),
(11387, 2, 15, 0),
(11387, 3, 15, 0),
(11387, 4, 15, 0),
(11387, 5, 15, 0),
(11387, 6, 15, 0),
(11352, 2, 15, 0),
(11352, 3, 15, 0),
(11352, 4, 15, 0),
(11352, 5, 15, 0),
(11352, 6, 15, 0),
(14517, 2, 15, 0),
(14517, 3, 15, 0),
(14517, 4, 15, 0),
(14517, 5, 15, 0),
(14517, 6, 15, 0),
(14750, 2, 15, 0),
(14750, 3, 15, 0),
(14750, 4, 15, 0),
(14750, 5, 15, 0),
(14750, 6, 15, 0),
(11368, 2, 15, 0),
(11368, 3, 15, 0),
(11368, 4, 15, 0),
(11368, 5, 15, 0),
(11368, 6, 15, 0),
(11831, 2, 15, 0),
(11831, 3, 15, 0),
(11831, 4, 15, 0),
(11831, 5, 15, 0),
(11831, 6, 15, 0),
(11351, 2, 15, 0),
(11351, 3, 15, 0),
(11351, 4, 15, 0),
(11351, 5, 15, 0),
(11351, 6, 15, 0),
(11374, 2, 15, 0),
(11374, 3, 15, 0),
(11374, 4, 15, 0),
(11374, 5, 15, 0),
(11374, 6, 15, 0),
(15043, 2, 15, 0),
(15043, 3, 15, 0),
(15043, 4, 15, 0),
(15043, 5, 15, 0),
(15043, 6, 15, 0),
(11372, 2, 15, 0),
(11372, 3, 15, 0),
(11372, 4, 15, 0),
(11372, 5, 15, 0),
(11372, 6, 15, 0),
(11371, 2, 15, 0),
(11371, 3, 15, 0),
(11371, 4, 15, 0),
(11371, 5, 15, 0),
(11371, 6, 15, 0),
(11830, 2, 15, 0),
(11830, 3, 15, 0),
(11830, 4, 15, 0),
(11830, 5, 15, 0),
(11830, 6, 15, 0),
(11350, 2, 15, 0),
(11350, 3, 15, 0),
(11350, 4, 15, 0),
(11350, 5, 15, 0),
(11350, 6, 15, 0),
(11338, 2, 15, 0),
(11338, 3, 15, 0),
(11338, 4, 15, 0),
(11338, 5, 15, 0),
(11338, 6, 15, 0),
(14532, 2, 15, 0),
(14532, 3, 15, 0),
(14532, 4, 15, 0),
(14532, 5, 15, 0),
(14532, 6, 15, 0),
(11388, 2, 15, 0),
(11388, 3, 15, 0),
(11388, 4, 15, 0),
(11388, 5, 15, 0),
(11388, 6, 15, 0),
(14510, 2, 15, 0),
(14510, 3, 15, 0),
(14510, 4, 15, 0),
(14510, 5, 15, 0),
(14510, 6, 15, 0),
(11353, 2, 15, 0),
(11353, 3, 15, 0),
(11353, 4, 15, 0),
(11353, 5, 15, 0),
(11353, 6, 15, 0),
(14821, 2, 15, 0),
(14821, 3, 15, 0),
(14821, 4, 15, 0),
(14821, 5, 15, 0),
(14821, 6, 15, 0),
(11356, 2, 15, 0),
(11356, 3, 15, 0),
(11356, 4, 15, 0),
(11356, 5, 15, 0),
(11356, 6, 15, 0),
(11391, 2, 15, 0),
(11391, 3, 15, 0),
(11391, 4, 15, 0),
(11391, 5, 15, 0),
(11391, 6, 15, 0),
(11382, 2, 15, 0),
(11382, 3, 15, 0),
(11382, 4, 15, 0),
(11382, 5, 15, 0),
(11382, 6, 15, 0),
(14988, 2, 15, 0),
(14988, 3, 15, 0),
(14988, 4, 15, 0),
(14988, 5, 15, 0),
(14988, 6, 15, 0),
(15111, 6, 15, 0),
(15111, 2, 15, 0),
(15111, 3, 15, 0),
(15111, 4, 15, 0),
(15111, 5, 15, 0),
(15146, 2, 60, 0),
(15146, 3, 60, 0),
(15146, 4, 60, 0),
(15146, 5, 60, 0),
(15146, 6, 60, 0),
(11340, 2, 15, 0),
(11340, 3, 15, 0),
(11340, 4, 15, 0),
(11340, 5, 15, 0),
(11340, 6, 15, 0),
(15082, 2, 20, 0),
(15082, 3, 20, 0),
(15082, 4, 20, 0),
(15082, 5, 20, 0),
(15082, 6, 20, 0),
(15085, 2, 20, 0),
(15085, 3, 20, 0),
(15085, 4, 20, 0),
(15085, 5, 20, 0),
(15085, 6, 20, 0),
(15084, 2, 20, 0),
(15084, 3, 20, 0),
(15084, 4, 20, 0),
(15084, 5, 20, 0),
(15084, 6, 20, 0),
(15083, 2, 15, 0),
(15083, 3, 20, 0),
(15083, 4, 20, 0),
(15083, 5, 20, 0),
(15083, 6, 20, 0),
(15163, 2, 15, 0),
(15163, 3, 15, 0),
(15163, 4, 15, 0),
(15163, 5, 15, 0),
(15163, 6, 15, 0),
(11361, 2, 15, 0),
(11361, 3, 15, 0),
(11361, 4, 15, 0),
(11361, 5, 15, 0),
(11361, 6, 15, 0),
(11360, 2, 15, 0),
(11360, 3, 15, 0),
(11360, 4, 15, 0),
(11360, 5, 15, 0),
(11360, 6, 15, 0),
(11348, 2, 15, 0),
(11348, 3, 15, 0),
(11348, 4, 15, 0),
(11348, 5, 15, 0),
(11348, 6, 15, 0),
(11347, 2, 15, 0),
(11347, 3, 15, 0),
(11347, 4, 15, 0),
(11347, 5, 15, 0),
(11347, 6, 15, 0),
(14509, 2, 15, 0),
(14509, 3, 15, 0),
(14509, 4, 15, 0),
(14509, 5, 15, 0),
(14509, 6, 15, 0),
(15114, 2, 15, 0),
(15114, 3, 15, 0),
(15114, 4, 15, 0),
(15114, 5, 15, 0),
(15114, 6, 15, 0),
(11365, 2, 15, 0),
(11365, 3, 15, 0),
(11365, 4, 15, 0),
(11365, 5, 15, 0),
(11365, 6, 15, 0),
(11339, 2, 15, 0),
(11339, 3, 15, 0),
(11339, 4, 15, 0),
(11339, 5, 15, 0),
(11339, 6, 15, 0),
(15067, 2, 15, 0),
(15067, 3, 15, 0),
(15067, 4, 15, 0),
(15067, 5, 15, 0),
(15067, 6, 15, 0),
(14515, 2, 15, 0),
(14515, 3, 15, 0),
(14515, 4, 15, 0),
(14515, 5, 15, 0),
(14515, 6, 15, 0),
(14883, 2, 15, 0),
(14883, 3, 15, 0),
(14883, 4, 15, 0),
(14883, 5, 15, 0),
(14883, 6, 15, 0),
(14825, 2, 15, 0),
(14825, 3, 15, 0),
(14825, 4, 15, 0),
(14825, 5, 15, 0),
(14825, 6, 15, 0),
(14882, 2, 15, 0),
(14882, 3, 15, 0),
(14882, 4, 15, 0),
(14882, 5, 15, 0),
(14882, 6, 15, 0),
(11380, 2, 15, 0),
(11380, 3, 15, 0),
(11380, 4, 15, 0),
(11380, 5, 15, 0),
(11380, 6, 15, 0),
(11359, 2, 15, 0),
(11359, 3, 15, 0),
(11359, 4, 15, 0),
(11359, 5, 15, 0),
(11359, 6, 15, 0),
(11357, 2, 15, 0),
(11357, 3, 15, 0),
(11357, 4, 15, 0),
(11357, 5, 15, 0),
(11357, 6, 15, 0),
(11389, 2, 15, 0),
(11389, 3, 15, 0),
(11389, 4, 15, 0),
(11389, 5, 15, 0),
(11389, 6, 15, 0),
(11390, 2, 15, 0),
(11390, 3, 15, 0),
(11390, 4, 15, 0),
(11390, 5, 15, 0),
(11390, 6, 15, 0),
(14834, 2, 15, 0),
(14834, 3, 15, 0),
(14834, 4, 15, 0),
(14834, 5, 15, 0),
(14834, 6, 15, 0);
