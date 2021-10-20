-- DB update 2021_06_17_06 -> 2021_06_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_17_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_17_06 2021_06_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1616275490460233200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

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

-- BWL trash (was 7.5 for all)
-- blackwing guardsman
UPDATE `creature_template` SET `DamageModifier`='14' WHERE  `entry`=14456;
-- Blackwing Legionnaire
UPDATE `creature_template` SET `DamageModifier`='7' WHERE  `entry`=12416;
-- blackwing mage
UPDATE `creature_template` SET `DamageModifier`='4' WHERE  `entry`=12420;
-- Blackwing Spellbinder
UPDATE `creature_template` SET `DamageModifier`='15' WHERE  `entry`=12457;
-- blackwing taskmaster
UPDATE `creature_template` SET `DamageModifier`='15' WHERE  `entry`=12458;
-- blackwing technician
UPDATE `creature_template` SET `DamageModifier`='5' WHERE  `entry`=13996;
-- Blackwing Warlock
UPDATE `creature_template` SET `DamageModifier`='15' WHERE  `entry`=12459;
-- Death Talon Captain
UPDATE `creature_template` SET `DamageModifier`='24' WHERE  `entry`=12467;
-- Death Talon Dragonspawn
UPDATE `creature_template` SET `DamageModifier`='14' WHERE  `entry`=12422;
-- Death Talon Wyrmguard
UPDATE `creature_template` SET `DamageModifier`='25' WHERE  `entry`=12460;
-- death talon overseer
UPDATE `creature_template` SET `DamageModifier`='22' WHERE  `entry`=12461;
-- Death Talon Flamescale
UPDATE `creature_template` SET `DamageModifier`='18' WHERE  `entry`=12463;
-- Death Talon Seether
UPDATE `creature_template` SET `DamageModifier`='20' WHERE  `entry`=12464;
-- death talon wyrmkin
UPDATE `creature_template` SET `DamageModifier`='18' WHERE  `entry`=12465;
-- Death Talon Hatcher
UPDATE `creature_template` SET `DamageModifier`='20' WHERE  `entry`=12468;
-- nefarian drakonids
UPDATE `creature_template` SET `DamageModifier`='5' WHERE  `entry`=14261;
UPDATE `creature_template` SET `DamageModifier`='5' WHERE  `entry`=14262;
UPDATE `creature_template` SET `DamageModifier`='5' WHERE  `entry`=14263;
UPDATE `creature_template` SET `DamageModifier`='5' WHERE  `entry`=14264;
UPDATE `creature_template` SET `DamageModifier`='5' WHERE  `entry`=14265;
-- Chromatic Drakonid
UPDATE `creature_template` SET `DamageModifier`='6' WHERE  `entry`=14302;
-- corrupted whelps (was 1)
UPDATE `creature_template` SET `DamageModifier`='3' WHERE  `entry`=14022;
UPDATE `creature_template` SET `DamageModifier`='3' WHERE  `entry`=14023;
UPDATE `creature_template` SET `DamageModifier`='3' WHERE  `entry`=14024;
UPDATE `creature_template` SET `DamageModifier`='3' WHERE  `entry`=14025;

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

-- update creatures that had modifier 7.5 (placeholder value). 
-- Just chose some names that are important(mostly dungeon bosses/mobs), there are 1051 total to fix.
-- SELECT  `entry`,  `name`, baseattacktime, unit_class,  `DamageModifier`, maxlevel FROM `creature_template` WHERE DamageModifier = '7.5' AND lootid > 1 ORDER BY entry
-- stitches
UPDATE `creature_template` SET `DamageModifier`='3.25' WHERE  `entry`=412;
-- edwin van cleef
UPDATE `creature_template` SET `DamageModifier`='2.45' WHERE  `entry`=639;
-- negolash
UPDATE `creature_template` SET `DamageModifier`='4.5' WHERE  `entry`=1494;
-- Sneed
UPDATE `creature_template` SET `DamageModifier`='3.3' WHERE  `entry`=643;
-- sneed's shredder
UPDATE `creature_template` SET `DamageModifier`='3.3' WHERE  `entry`=642;
-- Grand Inquisitor Isillien
UPDATE `creature_template` SET `DamageModifier`='8' WHERE  `entry`=1840;
-- Weaver
UPDATE `creature_template` SET `DamageModifier`='2' WHERE  `entry`=5720;
-- dreamscythe
UPDATE `creature_template` SET `DamageModifier`='3.5' WHERE  `entry`=5721;
-- Gahz'rilla
UPDATE `creature_template` SET `DamageModifier`='3.5' WHERE  `entry`=7273;
-- Warchief Rend Blackhand
UPDATE `creature_template` SET `DamageModifier`='6.5' WHERE  `entry`=10429;
-- Ramstein the Gorger
UPDATE `creature_template` SET `DamageModifier`='9' WHERE  `entry`=10439;
-- the unforgiven
UPDATE `creature_template` SET `DamageModifier`='3.7' WHERE  `entry`=10516;
-- timmy the cruel
UPDATE `creature_template` SET `DamageModifier`='13' WHERE  `entry`=10808;
-- balnazzar
UPDATE `creature_template` SET `DamageModifier`='9' WHERE  `entry`=10813;
-- somnus
UPDATE `creature_template` SET `DamageModifier`='9' WHERE  `entry`=12900;
-- Panzor the Invincible
UPDATE `creature_template` SET `DamageModifier`='6' WHERE  `entry`=8923;
-- mr. smite, 1.7->2.45 plus correct attack speed
UPDATE `creature_template` SET `DamageModifier`='2.45', `BaseAttackTime`='2000' WHERE  `entry`=646;
-- defias miner 1.7->1
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=598;

-- dire maul north
-- king gordok 5->6
UPDATE `creature_template` SET `DamageModifier`='6' WHERE  `entry`=11501;
-- hyenas 1->3.5
UPDATE `creature_template` SET `DamageModifier`='3.9' WHERE  `entry`=13036;
-- gordok brute 5->6.5
UPDATE `creature_template` SET `DamageModifier`='6.5' WHERE  `entry`=11441;
-- captain
UPDATE `creature_template` SET `DamageModifier`='6' WHERE  `entry`=11445;
-- gordok mauler 5->1 (outside)
UPDATE `creature_template` SET `DamageModifier`='1' WHERE  `entry`=11442;

-- some deadmines bosses
-- ogre
UPDATE `creature_template` SET `DamageModifier`='2.5' WHERE  `entry`=644;
-- greenskin and cookie
UPDATE `creature_template` SET `DamageModifier`='2.45' WHERE  `entry` IN (647, 645);

-- Ragefire chasm
-- Oggleflint 1.7 -> 2.2 
UPDATE `creature_template` SET `DamageModifier`='2.2' WHERE  `entry`=11517;
-- Taragaman the Hungerer 1.7 -> 2.4
UPDATE `creature_template` SET `DamageModifier`='2.4' WHERE  `entry`=11520;
-- Jergosh the Invoker 1.7 -> 2.4
UPDATE `creature_template` SET `DamageModifier`='2.4' WHERE  `entry`=11518;
-- bazzalan 1.7 -> 2.2
UPDATE `creature_template` SET `DamageModifier`='2.2' WHERE  `entry`=11519;
-- trash, was 1.7
UPDATE `creature_template` SET `DamageModifier`='1.5' WHERE  `entry`=11320;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_00' WHERE sql_rev = '1616275490460233200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
