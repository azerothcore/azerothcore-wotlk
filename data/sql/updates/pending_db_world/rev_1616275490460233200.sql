INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616275490460233200');

-- raid bosses
-- Molten Core
-- Lucifron 35 -> 16
UPDATE `creature_template` SET `DamageModifier`='16' WHERE  `entry`=12118;
-- magmadar 35-> 17
UPDATE `creature_template` SET `DamageModifier`='17' WHERE  `entry`=11982;
-- golemagg 35-> 20
UPDATE `creature_template` SET `DamageModifier`='20' WHERE  `entry`=11988;
-- gehennas 35-> 16
UPDATE `creature_template` SET `DamageModifier`='16' WHERE  `entry`=12259;
-- shazzrah 35-> 16
UPDATE `creature_template` SET `DamageModifier`='16' WHERE  `entry`=12264;
-- baron geddon 35->14
UPDATE `creature_template` SET `DamageModifier`='14' WHERE  `entry`=12056;
-- Garr 35->18
UPDATE `creature_template` SET `DamageModifier`='18' WHERE  `entry`=12057;
-- Sulfuron Harbinger 35->16
UPDATE `creature_template` SET `DamageModifier`='16' WHERE  `entry`=12098;
-- Majordomo 35->14
UPDATE `creature_template` SET `DamageModifier`='14' WHERE  `entry`=12018;
-- Ragnaros 35-> 13 (fire)
UPDATE `creature_template` SET `DamageModifier`='13' WHERE  `entry`=11502;
-- MC trash
UPDATE `creature_template` SET `DamageModifier`='12' WHERE  `entry`=11668; -- firelord 7.5->12
UPDATE `creature_template` SET `DamageModifier`='14' WHERE  `entry`=12099; -- firesworn 7.5->14
UPDATE `creature_template` SET `DamageModifier`='10' WHERE  `entry`=11667; -- flameguard 7.5->10
UPDATE `creature_template` SET `DamageModifier`='10' WHERE  `entry`=11666; -- firewalker 7.5->10
UPDATE `creature_template` SET `DamageModifier`='18' WHERE  `entry`=11665; -- lava annihilator 7.5->18
UPDATE `creature_template` SET `DamageModifier`='16' WHERE  `entry`=12100; -- lava reaver 7.5->16
UPDATE `creature_template` SET `DamageModifier`='5' WHERE  `entry`=12265;  -- lava spawn 7.5->5
UPDATE `creature_template` SET `DamageModifier`='12' WHERE  `entry`=12076; -- lava elemental 7.5->12
UPDATE `creature_template` SET `DamageModifier`='13' WHERE  `entry`=12101; -- lava surger 7.5->13
UPDATE `creature_template` SET `DamageModifier`='15' WHERE  `entry`=11658; -- molten giant 7.5->15
UPDATE `creature_template` SET `DamageModifier`='16' WHERE  `entry`=11659; -- molten destroyer 7.5->16
UPDATE `creature_template` SET `DamageModifier`='12' WHERE  `entry`=12143; -- son of flame 7.5->13
UPDATE `creature_template` SET `DamageModifier`='13' WHERE  `entry`=11661; -- flamewaker 7.5->13
UPDATE `creature_template` SET `DamageModifier`='13' WHERE  `entry`=11662; -- Flamewaker Priest 7.5->13
UPDATE `creature_template` SET `DamageModifier`='12' WHERE  `entry`=11663; -- Flamewaker Healer 7.5->12
UPDATE `creature_template` SET `DamageModifier`='14' WHERE  `entry`=11664; -- Flamewaker Elite 7.5->14
UPDATE `creature_template` SET `DamageModifier`='13' WHERE  `entry`=12119; -- Flamewaker Protector 7.5->12
UPDATE `creature_template` SET `DamageModifier`='10' WHERE  `entry`=12142; -- Flamewaker Guardian 7.5->10
UPDATE `creature_template` SET `DamageModifier`='10' WHERE  `entry`=11671; -- core hound 7.5->10
UPDATE `creature_template` SET `DamageModifier`='16' WHERE  `entry`=11673; -- ancient core hound 7.5->16
UPDATE `creature_template` SET `DamageModifier`='14' WHERE  `entry`=11672; -- core rager 7.5->14


-- Blackwing lair
-- Razorgore 35-> 22 
UPDATE `creature_template` SET `DamageModifier`='22' WHERE  `entry`=12435;
-- broodlord 35 ->25
UPDATE `creature_template` SET `DamageModifier`='25' WHERE  `entry`=12017;
-- firemaw 35->25
UPDATE `creature_template` SET `DamageModifier`='25' WHERE  `entry`=11983;
-- ebonroc 35->25
UPDATE `creature_template` SET `DamageModifier`='25', `BaseAttackTime`='2000' WHERE  `entry`=14601;
-- flamegor 35->25
UPDATE `creature_template` SET `DamageModifier`='25' WHERE  `entry`=11981;
-- chromaggus 35-> 30
UPDATE `creature_template` SET `DamageModifier`='30' WHERE  `entry`=14020;
-- nefarian 35 : no change

-- Temple Of Ahn Quiraj (AQ 40)
-- The Prophet Skeram 35->20
UPDATE `creature_template` SET `DamageModifier`='20' WHERE  `entry`=15263;
-- Lord Kri 35->25
UPDATE `creature_template` SET `DamageModifier`='25' WHERE  `entry`=15511;
-- Vem 35->18
UPDATE `creature_template` SET `DamageModifier`='18' WHERE  `entry`=15544;
-- Princess Yauj 35->20
UPDATE `creature_template` SET `DamageModifier`='20' WHERE  `entry`=15543;
-- Fankriss the Unyielding 35->20
UPDATE `creature_template` SET `DamageModifier`='20' WHERE  `entry`=15510;
-- Princess Huhuran 35->25
UPDATE `creature_template` SET `DamageModifier`='25' WHERE  `entry`=15509;
-- battleguard sartura 35->30
UPDATE `creature_template` SET `DamageModifier`='30' WHERE  `entry`=15516;
-- viscidus 35->33
UPDATE `creature_template` SET `DamageModifier`='33' WHERE  `entry`=15299;
-- emperor vek'lor 35->30
UPDATE `creature_template` SET `DamageModifier`='30' WHERE  `entry`=15276;
-- Emperor Vek'nilash 35->30
UPDATE `creature_template` SET `DamageModifier`='30' WHERE  `entry`=15275;
-- Ouro 35, no change
-- C'thun tentacles. those are an estimate as I couldn't find it in book, based on vmangos dmg.
-- giant claw tentacle 7.5 ->32
UPDATE `creature_template` SET `DamageModifier`='32' WHERE  `entry`=15728;
-- claw tentacle 1->4
UPDATE `creature_template` SET `DamageModifier`='4' WHERE  `entry`=15725;
-- eye tentacle 1->4
UPDATE `creature_template` SET `DamageModifier`='4' WHERE  `entry`=15726;
-- giant eye tentacle
UPDATE `creature_template` SET `DamageModifier`='10' WHERE  `entry`=15334;

-- Random creatures I started fixing by ID.
-- checked all creatures by id that have dmgModifier =/= 1, fixed those that were wrong by book values
UPDATE `creature_template` SET `DamageModifier`='3.5' WHERE  `entry`=1492;
UPDATE `creature_template` SET `DamageModifier`='4.25' WHERE  `entry`=1493;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=1730;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=1805;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=1836;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=1846;
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=1850;
UPDATE `creature_template` SET `DamageModifier`='2' WHERE  `entry`=1852;
UPDATE `creature_template` SET `DamageModifier`='2.3' WHERE  `entry`=1853;
UPDATE `creature_template` SET `DamageModifier`='1.75' WHERE  `entry`=2417;
UPDATE `creature_template` SET `DamageModifier`='2' WHERE  `entry`=2520;
UPDATE `creature_template` SET `DamageModifier`='2.7' WHERE  `entry`=2748;
UPDATE `creature_template` SET `DamageModifier`='3.75' WHERE  `entry`=2754;
UPDATE `creature_template` SET `DamageModifier`='1.4' WHERE  `entry`=2749;
UPDATE `creature_template` SET `DamageModifier`='2.3' WHERE  `entry`=2937;
UPDATE `creature_template` SET `DamageModifier`='2.25' WHERE  `entry`=3586;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=3642;
UPDATE `creature_template` SET `DamageModifier`='2.4' WHERE  `entry`=3654;
UPDATE `creature_template` SET `DamageModifier`='2.3' WHERE  `entry`=3669;
UPDATE `creature_template` SET `DamageModifier`='2.7' WHERE  `entry`=3670;
UPDATE `creature_template` SET `DamageModifier`='2.7' WHERE  `entry`=3673;
UPDATE `creature_template` SET `DamageModifier`='2' WHERE  `entry`=3674;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=3865;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=3876;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=3869;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=3870;
UPDATE `creature_template` SET `DamageModifier`='2.5' WHERE  `entry`=3886;
UPDATE `creature_template` SET `DamageModifier`='3.3' WHERE  `entry`=3927;
UPDATE `creature_template` SET `DamageModifier`='2.6' WHERE  `entry`=3976;
UPDATE `creature_template` SET `DamageModifier`='2.2' WHERE  `entry`=3977;
UPDATE `creature_template` SET `DamageModifier`='3.8' WHERE  `entry`=3975;
UPDATE `creature_template` SET `DamageModifier`='2' WHERE  `entry`=3983;
UPDATE `creature_template` SET `DamageModifier`='3.3' WHERE  `entry`=4274;
UPDATE `creature_template` SET `DamageModifier`='5.7' WHERE  `entry`=4275; -- archmage arugal
UPDATE `creature_template` SET `DamageModifier`='2.3' WHERE  `entry`=4278;
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=4283;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4286;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4287;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4288;
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=4289;
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=4291;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4292;
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=4293;
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=4294;
UPDATE `creature_template` SET `DamageModifier`='2' WHERE  `entry`=4295;
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=4296;
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=4297;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4298;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4299;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4300;
UPDATE `creature_template` SET `DamageModifier`='2.7' WHERE  `entry`=4301;
UPDATE `creature_template` SET `DamageModifier`='1.9' WHERE  `entry`=4302;
UPDATE `creature_template` SET `DamageModifier`='1.9' WHERE  `entry`=4303;
UPDATE `creature_template` SET `DamageModifier`='2' WHERE  `entry`=4306;
UPDATE `creature_template` SET `DamageModifier`='2.5' WHERE  `entry`=4339;
UPDATE `creature_template` SET `DamageModifier`='4' WHERE  `entry`=4364;
UPDATE `creature_template` SET `DamageModifier`='4.2' WHERE  `entry`=4366;
UPDATE `creature_template` SET `DamageModifier`='3.9' WHERE  `entry`=4370;
UPDATE `creature_template` SET `DamageModifier`='4.2' WHERE  `entry`=4368;
UPDATE `creature_template` SET `DamageModifier`='3.9' WHERE  `entry`=4371;
UPDATE `creature_template` SET `DamageModifier`='4' WHERE  `entry`=4374;
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=4416;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4516;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4515;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4517;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4518;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4519;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4520;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4522;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4525;
UPDATE `creature_template` SET `DamageModifier`='2.85' WHERE  `entry`=4542;
UPDATE `creature_template` SET `DamageModifier`='1.7' WHERE  `entry`=4543;
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=4625;
