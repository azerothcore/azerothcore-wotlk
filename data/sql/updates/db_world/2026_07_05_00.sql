-- DB update 2026_07_04_06 -> 2026_07_05_00
--
-- General Vezax (33271) must resist spell-haste debuffs (Curse of Tongues, Mind-numbing Poison,
-- Slow, core hound Lava Breath). They inflate his Shadow Crash / Searing Flames cast times and
-- trivialize the encounter. He already uses shared CC set -287; a single creature can reference only
-- one immunity set, so give him a dedicated superset that keeps -287's immunities and adds
-- aura 216 (HASTE_SPELLS). Other -287 users are left untouched.
DELETE FROM `creature_immunities` WHERE `ID`=-427;
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(-427, 0, 0, 1234599678, '98,114,124,144,145', '11,216', 0, 0, 'General Vezax: -287 (CC/knockback/taunt, auras=11(MOD_TAUNT)) + auras=216(HASTE_SPELLS) so cast-time slows do not trivialize the fight');

UPDATE `creature_template` SET `CreatureImmunitiesId`=-427 WHERE `entry`=33271;
