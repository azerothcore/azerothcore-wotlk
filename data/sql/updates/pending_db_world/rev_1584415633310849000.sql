INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584415633310849000');

-- =--------------------------------------------------------------------------------------------------------------------------------=
-- All boss/creature DMG Values and additional changes enlisted below were gathered from the official 'World of Warcraft: Beastiary'
-- =--------------------------------------------------------------------------------------------------------------------------------=


-- Black Temple (70 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- High Warlord Naj'entus
UPDATE `creature_template` SET `mindmg` = 11152, `maxdmg` = 15768, `DamageModifier` = 1 WHERE `entry` = 22887;
-- Supremus
UPDATE `creature_template` SET `mindmg` = 14936, `maxdmg` = 21118, `DamageModifier` = 1 WHERE `entry` = 22898;
-- Shade of Akama
UPDATE `creature_template` SET `mindmg` = 23898, `maxdmg` = 33789, `DamageModifier` = 1 WHERE `entry` = 22841;
-- Teron Gorefiend
UPDATE `creature_template` SET `mindmg` = 19702, `maxdmg` = 27828, `DamageModifier` = 1 WHERE `entry` = 22871;
-- Gurtogg Bloodboil
UPDATE `creature_template` SET `mindmg` = 11949, `maxdmg` = 16895, `DamageModifier` = 1 WHERE `entry` = 22948;
-- Mother Shahraz
UPDATE `creature_template` SET `mindmg` = 22165, `maxdmg` = 31306, `DamageModifier` = 1 WHERE `entry` = 22947;

-- | - - - - - - - - - - - - - T h e  I l l i d a r i  C o u n c i l - - - - - - - - - - -  - - - - - - - - - - |
-- Gathios the Shatterer
UPDATE `creature_template` SET `mindmg` = 18470, `maxdmg` = 26088, `DamageModifier` = 1 WHERE `entry` = 22949;
-- High Nethermancer Zerevor
UPDATE `creature_template` SET `mindmg` = 3940, `maxdmg` = 5565, `DamageModifier` = 1 WHERE `entry` = 22950;
-- Lady Malande
UPDATE `creature_template` SET `mindmg` = 6156, `maxdmg` = 8696, `DamageModifier` = 1 WHERE `entry` = 22951;
-- Veras Darkshadow
UPDATE `creature_template` SET `mindmg` = 10621, `maxdmg` = 15017, `DamageModifier` = 1 WHERE `entry` = 22952;
-- | - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |

-- Illidan Stormrage
UPDATE `creature_template` SET `mindmg` = 19914, `maxdmg` = 28157, `DamageModifier` = 1 WHERE `entry` = 22917;
-- ===================================================================================================================


-- Coilfang: Serpentshrine Cavern (70 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Hydross the Unstable
UPDATE `creature_template` SET `mindmg` = 5974, `maxdmg` = 8447, `DamageModifier` = 1 WHERE `entry` = 21216;
-- The Lurker Below
UPDATE `creature_template` SET `mindmg` = 11949, `maxdmg` = 16895, `DamageModifier` = 1 WHERE `entry` = 21217;
-- Leotheras the Blind
UPDATE `creature_template` SET `mindmg` = 7169, `maxdmg` = 10136, `DamageModifier` = 1 WHERE `entry` = 21215;
-- Shadow of Leotheras
UPDATE `creature_template` SET `mindmg` = 7169, `maxdmg` = 10136, `DamageModifier` = 1 WHERE `entry` = 21875;
-- Fathom-Lord Karathress
UPDATE `creature_template` SET `mindmg` = 8866, `maxdmg` = 12522, `DamageModifier` = 1 WHERE `entry` = 21214;

-- | - - - - - - - - - - - - - G u a r d s  o f  K a r a t h r e s s - - - - - - - - -  - - - -  - - - - - - - - - |
-- Fathom-Guard Sharkkis
UPDATE `creature_template` SET `mindmg` = 5956, `maxdmg` = 8416, `DamageModifier` = 1 WHERE `entry` = 21966;
-- Fathom-Guard Tidalvess
UPDATE `creature_template` SET `mindmg` = 10005, `maxdmg` = 14138, `DamageModifier` = 1 WHERE `entry` = 21965;
-- Fathom-Guard Caribdis
UPDATE `creature_template` SET `mindmg` = 5956, `maxdmg` = 8416, `DamageModifier` = 1 WHERE `entry` = 21964;
-- | - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |

-- Morogrim Tidewalker
UPDATE `creature_template` SET `mindmg` = 12745, `maxdmg` = 18021, `DamageModifier` = 1 WHERE `entry` = 21213;
-- Lady Vashj
UPDATE `creature_template` SET `mindmg` = 11082, `maxdmg` = 15653, `DamageModifier` = 1 WHERE `entry` = 21212;
-- Tainted Elemental [Lady Vashj encounter]
UPDATE `creature_template` SET `mindmg` = 770, `maxdmg` = 1089, `DamageModifier` = 1 WHERE `entry` = 22009;
-- ===================================================================================================================


-- Gruul's Lair (70 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- High King Maulgar
UPDATE `creature_template` SET `mindmg` = 12214, `maxdmg` = 17270, `DamageModifier` = 1 WHERE `entry` = 18831;

-- | - - - - - - - - - - - - - C o u n c i l  M e m b e r s - - - - - - - - - - -  - - - -  - - - - - - - - - |
-- Kiggler the Crazed
UPDATE `creature_template` SET `mindmg` = 6834, `maxdmg` = 9653, `DamageModifier` = 1 WHERE `entry` = 18835;
-- Blindeye the Seer
UPDATE `creature_template` SET `mindmg` = 1724, `maxdmg` = 2435, `DamageModifier` = 1 WHERE `entry` = 18836;
-- Olm the Summoner
UPDATE `creature_template` SET `mindmg` = 4101, `maxdmg` = 5792, `DamageModifier` = 1 WHERE `entry` = 18834;
-- Krosh Firehand
UPDATE `creature_template` SET `mindmg` = 4101, `maxdmg` = 5792, `DamageModifier` = 1 WHERE `entry` = 18832;
-- | - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |

-- Gruul the Dragonkiller
UPDATE `creature_template` SET `mindmg` = 6904, `maxdmg` = 9761, `DamageModifier` = 1 WHERE `entry` = 19044;
-- Lair Brute [Gruul minion]
UPDATE `creature_template` SET `mindmg` = 7842, `maxdmg` = 11090, `DamageModifier` = 1 WHERE `entry` = 19389;
-- ===================================================================================================================


-- Karazhan (70 - 73)
-- -------------------------------------------------------------------------------------------------------------------

-- | - - - - - - - - - - - - - S e r v a n t  Q u a r t e r s - - - - - - - - - - -  - - - -  - - - - - - - - - |
-- Rokad the Ravager
UPDATE `creature_template` SET `mindmg` = 3585, `maxdmg` = 5068, `DamageModifier` = 1 WHERE `entry` = 16181;
-- Shadikith the Glider
UPDATE `creature_template` SET `mindmg` = 4780, `maxdmg` = 6758, `DamageModifier` = 1 WHERE `entry` = 16180;
-- Hyakiss the Lurker
UPDATE `creature_template` SET `mindmg` = 4780, `maxdmg` = 6758, `DamageModifier` = 1 WHERE `entry` = 16179;
-- | - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |

-- Attumen the Huntsman
UPDATE `creature_template` SET `mindmg` = 4715, `maxdmg` = 7508, `DamageModifier` = 1 WHERE `entry` = 16152;
-- Midnight
UPDATE `creature_template` SET `mindmg` = 4248, `maxdmg` = 6007, `DamageModifier` = 1 WHERE `entry` = 16151;

-- Moroes
UPDATE `creature_template` SET `mindmg` = 4780, `maxdmg` = 6758, `DamageModifier` = 1 WHERE `entry` = 15687;

-- | - - - - - - - - - - - - - M o r o e s'  D i n n e r  G u e s t s - - - - - - -  - - - -  - - - - - - - - - |
-- Baroness Dorothea Millstipe
UPDATE `creature_template` SET `mindmg` = 2109, `maxdmg` = 2980, `DamageModifier` = 1 WHERE `entry` = 19875;
-- Baron Rafe Dreuger
UPDATE `creature_template` SET `mindmg` = 2109, `maxdmg` = 2980, `DamageModifier` = 1 WHERE `entry` = 19874;
-- Lady Catriona Von'Indi
UPDATE `creature_template` SET `mindmg` = 2109, `maxdmg` = 2980, `DamageModifier` = 1 WHERE `entry` = 19872;
-- Lady Keira Berrybuck
UPDATE `creature_template` SET `mindmg` = 2109, `maxdmg` = 2980, `DamageModifier` = 1 WHERE `entry` = 17007;
-- Lord Robin Daris
UPDATE `creature_template` SET `mindmg` = 2272, `maxdmg` = 3213, `DamageModifier` = 1 WHERE `entry` = 19876;
-- Lord Crispin Ference
UPDATE `creature_template` SET `mindmg` = 2272, `maxdmg` = 3213, `DamageModifier` = 1 WHERE `entry` = 19873;
-- | - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |

-- Maiden of Virtue
UPDATE `creature_template` SET `mindmg` = 6157, `maxdmg` = 8696, `DamageModifier` = 1 WHERE `entry` = 16457;

-- | - - - - - - - - - - - - - T h e  O p e r a  E v e n t - - - - - - -  - - - -  - - - - - - - - - |

-- = = = = W i z a r d  o f  O z = = = =
-- Dorothee
UPDATE `creature_template` SET `mindmg` = 2463, `maxdmg` = 3478, `DamageModifier` = 1 WHERE `entry` = 17535;
-- Tito
UPDATE `creature_template` SET `mindmg` = 841, `maxdmg` = 1189, `DamageModifier` = 1 WHERE `entry` = 17548;
-- Strawman
UPDATE `creature_template` SET `mindmg` = 4182, `maxdmg` = 5915, `DamageModifier` = 1 WHERE `entry` = 17543;
-- Tinhead
UPDATE `creature_template` SET `mindmg` = 4182, `maxdmg` = 5915, `DamageModifier` = 1 WHERE `entry` = 17547;
-- Roar
UPDATE `creature_template` SET `mindmg` = 2509, `maxdmg` = 3549, `DamageModifier` = 1 WHERE `entry` = 17546;
-- The Crone
UPDATE `creature_template` SET `mindmg` = 4925, `maxdmg` = 6957, `DamageModifier` = 1 WHERE `entry` = 18168;
-- = = = = = = = = = = = = = = = = = =

-- = = = = R e d  R i d i n g  H o o d = = = =
-- The Big Bad Wolf
UPDATE `creature_template` SET `mindmg` = 4142, `maxdmg` = 5857, `DamageModifier` = 1 WHERE `entry` = 17521;
-- = = = = = = = = = = = = = = = = = = = = = =

-- = = = = W i z a r d  o f  O z = = = =
-- Romulo
UPDATE `creature_template` SET `mindmg` = 3983, `maxdmg` = 5632, `DamageModifier` = 1 WHERE `entry` = 17533;
-- Julianne
UPDATE `creature_template` SET `mindmg` = 2955, `maxdmg` = 4174, `DamageModifier` = 1 WHERE `entry` = 17534;
-- = = = = = = = = = = = = = = = = = = =
-- | - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |

-- The Curator
UPDATE `creature_template` SET `mindmg` = 5467, `maxdmg` = 7722, `DamageModifier` = 1 WHERE `entry` = 15691;
-- Terestian Illhoof
UPDATE `creature_template` SET `mindmg` = 5050, `maxdmg` = 7140, `DamageModifier` = 1 WHERE `entry` = 15688;
-- Kil'rek [Minion of Terestian]
UPDATE `creature_template` SET `mindmg` = 1874, `maxdmg` = 2852, `DamageModifier` = 1 WHERE `entry` = 17229;
-- Shade of Aran
UPDATE `creature_template` SET `mindmg` = 2063, `maxdmg` = 2992, `DamageModifier` = 1 WHERE `entry` = 16524;
-- Netherspite
UPDATE `creature_template` SET `mindmg` = 7515, `maxdmg` = 8186, `DamageModifier` = 1 WHERE `entry` = 15689;
-- Nightbane
UPDATE `creature_template` SET `mindmg` = 9028, `maxdmg` = 12765, `DamageModifier` = 1 WHERE `entry` = 17225;
-- Prince Malchezaar
UPDATE `creature_template` SET `mindmg` = 6638, `maxdmg` = 9386, `DamageModifier` = 1 WHERE `entry` = 15690;
-- ===================================================================================================================


-- Magtheridon Lair (70 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Magtheridon
UPDATE `creature_template` SET `mindmg` = 14604, `maxdmg` = 20649, `DamageModifier` = 1 WHERE `entry` = 17257;
-- ===================================================================================================================


-- Tempest Keep (70 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Void Reaver
UPDATE `creature_template` SET `mindmg` = 8866, `maxdmg` = 12522, `DamageModifier` = 1 WHERE `entry` = 19516;
-- High Astromancer Solarian
UPDATE `creature_template` SET `mindmg` = 6157, `maxdmg` = 8696, `DamageModifier` = 1 WHERE `entry` = 18805;

-- | - - - - - - - - - - - - - K a e l' t h a s  A d v i s o r s - - - - - - -  - - - -  - - - - - - - - - |
-- Thaladred the Darkener
UPDATE `creature_template` SET `mindmg` = 9559, `maxdmg` = 13516, `DamageModifier` = 1 WHERE `entry` = 20064;
-- Lord Sanguinar
UPDATE `creature_template` SET `mindmg` = 8497, `maxdmg` = 12014, `DamageModifier` = 1 WHERE `entry` = 20060;
-- Grand Astromancer Capernian
UPDATE `creature_template` SET `mindmg` = 2475, `maxdmg` = 3590, `DamageModifier` = 1 WHERE `entry` = 20062;
-- Master Engineer Telonicus
UPDATE `creature_template` SET `mindmg` = 2475, `maxdmg` = 3590, `DamageModifier` = 1 WHERE `entry` = 20062;
-- | - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |

-- Kael'thas Sunstrider
UPDATE `creature_template` SET `mindmg` = 11083, `maxdmg` = 15653, `DamageModifier` = 1 WHERE `entry` = 19622;
-- ===================================================================================================================


-- Hyjal Summit (66 - 73)
-- -------------------------------------------------------------------------------------------------------------------
-- Rage Winterchill
UPDATE `creature_template` SET `mindmg` = 11082, `maxdmg` = 15653, `DamageModifier` = 1 WHERE `entry` = 17767;
-- Anetheron
UPDATE `creature_template` SET `mindmg` = 12314, `maxdmg` = 17392, `DamageModifier` = 1 WHERE `entry` = 17808;
-- Kaz'rogal
UPDATE `creature_template` SET `mindmg` = 12314, `maxdmg` = 17392, `DamageModifier` = 1 WHERE `entry` = 17888;
-- Azgalor
UPDATE `creature_template` SET `mindmg` = 20934, `maxdmg` = 29567, `DamageModifier` = 1 WHERE `entry` = 17842;
-- Archimonde
UPDATE `creature_template` SET `mindmg` = 20318, `maxdmg` = 28697, `DamageModifier` = 1 WHERE `entry` = 17968;
-- ===================================================================================================================
