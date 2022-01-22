-- DB update 2021_04_22_01 -> 2021_04_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_22_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_22_01 2021_04_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1615627556897035768'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615627556897035768');

UPDATE `creature_template` SET `BaseAttackTime`=2500  WHERE `entry`=485;   -- Blackrock Outrunner, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2800  WHERE `entry`=584;   -- Kazon, was 1425
UPDATE `creature_template` SET `BaseAttackTime`=1500  WHERE `entry`=947;   -- Rohh the Silent, was 1425
UPDATE `creature_template` SET `BaseAttackTime`=2200  WHERE `entry`=2271;  -- Dalaran Shield Guard, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1300  WHERE `entry`=2275;  -- Enraged Stanley, was 1770
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=2475;  -- Sloth, was 1700
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=2479;  -- Sludge, was 1700
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=2502;  -- "Shaky" Phillipe, was 2400
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=2713;  -- Kinelory, was 2500
UPDATE `creature_template` SET `BaseAttackTime`=1000  WHERE `entry`=2850;  -- Broken Tooth, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=4049;  -- Seereth Stonebreak, was 1750
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=4400;  -- Mudrock Snapjaw, was 1600
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=5399;  -- Veyzhak the Cannibal, was 1250
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=5400;  -- Zekkis, was 1250
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=5781;  -- Silithid Creeper Egg, was 1800
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=5809;  -- Watch Commander Zalaphil, was 1575
UPDATE `creature_template` SET `BaseAttackTime`=2700  WHERE `entry`=5827;  -- Brontus, was 1425
UPDATE `creature_template` SET `BaseAttackTime`=1300  WHERE `entry`=5828;  -- Humar the Pridelord, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500  WHERE `entry`=5865;  -- Dishu, was 1525
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=6239;  -- Cyclonian, was 1300
UPDATE `creature_template` SET `BaseAttackTime`=1625  WHERE `entry`=6913;  -- Lost One Rift Traveler, was 1760
UPDATE `creature_template` SET `BaseAttackTime`=4000  WHERE `entry`=7226;  -- Sand Storm, was 1570
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=7846;  -- Teremus the Devourer, was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2800  WHERE `entry`=7895;  -- Ambassador Bloodrage, was 1350
UPDATE `creature_template` SET `BaseAttackTime`=2600  WHERE `entry`=8215;  -- Grimungous, was 1233
UPDATE `creature_template` SET `BaseAttackTime`=1300  WHERE `entry`=8300;  -- Ravage, was 1216
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=8585;  -- Frost Spectre, was 1600
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=8932;  -- Borer Beetle, was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1800  WHERE `entry`=9027;  -- Gorosh the Dervish, was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2400  WHERE `entry`=9032;  -- Hedrum the Creeper, was 1208
UPDATE `creature_template` SET `BaseAttackTime`=1300  WHERE `entry`=9236;  -- Shadow Hunter Vosh'gajin, was 800
UPDATE `creature_template` SET `BaseAttackTime`=1300  WHERE `entry`=9264;  -- Firebrand Pyromancer, was 1158
UPDATE `creature_template` SET `BaseAttackTime`=2400  WHERE `entry`=9456;  -- Warlord Krom'zar, was 1770
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=9462;  -- Chieftain Bloodmaw, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=9568;  -- Overlord Wyrmthalak, was 800
UPDATE `creature_template` SET `BaseAttackTime`=2600  WHERE `entry`=9605;  -- Blackrock Raider, was 1420
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=10184; -- Onyxia, was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1100  WHERE `entry`=10220; -- Halycon, was 1175
UPDATE `creature_template` SET `BaseAttackTime`=1400  WHERE `entry`=10261; -- Burning Felhound, was 1470
UPDATE `creature_template` SET `BaseAttackTime`=2300  WHERE `entry`=10263; -- Burning Felguard, was 1175
UPDATE `creature_template` SET `BaseAttackTime`=1500  WHERE `entry`=10374; -- Spire Spider, was 1175
UPDATE `creature_template` SET `BaseAttackTime`=1500  WHERE `entry`=10375; -- Spire Spiderling, was 1480
UPDATE `creature_template` SET `BaseAttackTime`=1500  WHERE `entry`=10376; -- Crystal Fang, was 1150
UPDATE `creature_template` SET `BaseAttackTime`=3000  WHERE `entry`=10506; -- Kirtonos the Herald, was 1600
UPDATE `creature_template` SET `BaseAttackTime`=3200  WHERE `entry`=10584; -- Urok Doomhowl, was 1166
UPDATE `creature_template` SET `BaseAttackTime`=1500  WHERE `entry`=10596; -- Mother Smolderweb, was 1100
UPDATE `creature_template` SET `BaseAttackTime`=2200  WHERE `entry`=11347; -- Zealot Lor'Khan, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1600  WHERE `entry`=11467; -- Tsu'zee, was 1166
UPDATE `creature_template` SET `BaseAttackTime`=3000  WHERE `entry`=11627; -- Tamed Kodo, was 1660
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=11677; -- Taskmaster Snivvle, was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=11949; -- Captain Balinda Stonehearth, was 2400
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=11981; -- Flamegor, was 1300
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=12121; -- Drakan, was 1846
UPDATE `creature_template` SET `BaseAttackTime`=2400  WHERE `entry`=12467; -- Death Talon Captain, was 1091
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=12756; -- Lady Onyxia, was 850
UPDATE `creature_template` SET `BaseAttackTime`=2660  WHERE `entry`=12860; -- Duriel Moonfire, was 1710
UPDATE `creature_template` SET `BaseAttackTime`=2800  WHERE `entry`=12865; -- Ambassador Malcin, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=13020; -- Vaelastrasz the Corrupt, was 1600
UPDATE `creature_template` SET `BaseAttackTime`=2500  WHERE `entry`=13147; -- Lieutenant Lewis, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=13456; -- Noxxion's Spawn, was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=14020; -- Chromaggus, was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1000  WHERE `entry`=14370; -- Cadaverous Worm, was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2800  WHERE `entry`=14372; -- Winterfall Ambusher, was 1450
UPDATE `creature_template` SET `BaseAttackTime`=10000 WHERE `entry`=14396; -- Eye of Immol'thar, was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=14484; -- Injured Peasant, was 1500
UPDATE `creature_template` SET `BaseAttackTime`=900   WHERE `entry`=14490; -- Rippa, was 1283
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=14601; -- Ebonroc, was 1100
UPDATE `creature_template` SET `BaseAttackTime`=2700  WHERE `entry`=14603; -- Zapped Shore Strider, was 1530
UPDATE `creature_template` SET `BaseAttackTime`=2600  WHERE `entry`=14604; -- Zapped Land Walker, was 1510
UPDATE `creature_template` SET `BaseAttackTime`=2500  WHERE `entry`=14638; -- Zapped Wave Strider, was 1520
UPDATE `creature_template` SET `BaseAttackTime`=2700  WHERE `entry`=14639; -- Zapped Deep Strider, was 1520
UPDATE `creature_template` SET `BaseAttackTime`=2700  WHERE `entry`=14640; -- Zapped Cliff Giant, was 1510
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=14890; -- Taerar, was 1000
UPDATE `creature_template` SET `BaseAttackTime`=1000  WHERE `entry`=14965; -- Frenzied Bloodseeker Bat, was 1440
UPDATE `creature_template` SET `BaseAttackTime`=1400  WHERE `entry`=15041; -- Spawn of Mar'li, was 1440
UPDATE `creature_template` SET `BaseAttackTime`=2500  WHERE `entry`=15085; -- Wushoolay, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1600  WHERE `entry`=15101; -- Zulian Prowler, was 1440
UPDATE `creature_template` SET `BaseAttackTime`=3000  WHERE `entry`=15195; -- Wickerman Guardian, was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=15334; -- Giant Eye Tentacle, was 1000
UPDATE `creature_template` SET `BaseAttackTime`=2700  WHERE `entry`=15517; -- Ouro, was 1750
UPDATE `creature_template` SET `BaseAttackTime`=1500  WHERE `entry`=15721; -- Mechanical Greench, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1000  WHERE `entry`=15725; -- Claw Tentacle, was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1000  WHERE `entry`=15726; -- Eye Tentacle, was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2500  WHERE `entry`=15728; -- Giant Claw Tentacle, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2400  WHERE `entry`=15742; -- Colossus of Ashi, was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000  WHERE `entry`=15802; -- Flesh Tentacle, was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1800  WHERE `entry`=15952; -- Maexxna, was 2000
UPDATE `creature_template` SET `BaseAttackTime`=750   WHERE `entry`=16028; -- Patchwerk, was 1200

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
