-- DB update 2021_09_23_02 -> 2021_09_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_23_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_23_02 2021_09_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632254602577940300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632254602577940300');

SET @ENTRY := 24484;
SET @SPELL_THROW_MUG := 50696;
SET @SPELL_CREATE_MUG := 42518;
SET @SPELL_TOAST := 41586;
UPDATE `creature_template` SET `unit_flags`=0, `AIName`='SmartAI', `ScriptName`='', `flags_extra`=`flags_extra`|2 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100,@ENTRY*1001); -- We are adding new lines so don't remove complete SAI
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,22,0,100,0,101,5000,5000,0,11,@SPELL_CREATE_MUG,2,0,0,0,0,7,0,0,0,0,0,0,0,"Brewfest Reveler - Emote Receive 'Wave' - Cast Create Complimentary Brewfest Sampler"),
(@ENTRY,0,1,0,22,0,100,0,35,5000,5000,0,11,@SPELL_TOAST,2,0,0,0,0,7,0,0,0,0,0,0,0,"Brewfest Reveler - Emote Receive 'Drink' - Cast Brewfest Toast"),
(@ENTRY,0,2,0,1,0,100,0,4000,11000,15000,20000,10,92,1,4,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - Out of Combat - Play Random Emote"),
-- Dun Morogh
(@ENTRY,0,3,0,38,0,100,0,0,0,0,0,80,@ENTRY*100,0,2,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Data Set - Run Script"),
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,53,1,@ENTRY,0,0,0,2,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Script - Start WP"),
(@ENTRY*100,9,1,0,0,0,100,0,1000,5000,5000,5000,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Script - Say Line 0 (random)"),
(@ENTRY*100,9,2,0,0,0,100,0,0,0,0,0,11,@SPELL_THROW_MUG,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Script - Cast Throw Mug"),
(@ENTRY,0,4,0,58,0,100,0,3,@ENTRY,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On WP 3 - Despawn"),
-- Durotar
(@ENTRY,0,5,0,38,0,100,0,0,1,0,0,80,@ENTRY*1001,0,2,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Data Set - Run Script"),
(@ENTRY*1001,9,0,0,0,0,100,0,0,0,0,0,53,1,@ENTRY*10,0,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Script - Start WP"),
(@ENTRY*1001,9,1,0,0,0,100,0,1000,5000,5000,5000,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Script - Say Line 0 (random)"),
(@ENTRY*1001,9,2,0,0,0,100,0,1000,3000,3000,3000,11,@SPELL_THROW_MUG,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On Script - Cast Throw Mug"),
(@ENTRY,0,6,0,58,0,100,0,4,@ENTRY*10,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Brewfest Reveler - On WP 4 - Despawn");

-- Text
DELETE FROM `creature_text` WHERE `creatureid`=@ENTRY;
INSERT INTO `creature_text` (`creatureid`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@ENTRY,0,0,"Dark Iron dwarves!",12,0,100,0,0,0,"Brewfest Reveler"),
(@ENTRY,0,1,"Run! It's the Dark Iron dwarves!",12,0,100,0,0,0,"Brewfest Reveler"),
(@ENTRY,0,2,"They're after the beer!",12,0,100,0,0,0,"Brewfest Reveler"),
(@ENTRY,0,3,"Someone has to save the beer!",12,0,100,0,0,0,"Brewfest Reveler"),
(@ENTRY,0,4,"If you value your beer, run for it!",12,0,100,0,0,0,"Brewfest Reveler");

-- Waypoints
DELETE FROM `waypoints` WHERE `entry` IN (@ENTRY,@ENTRY*10);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
-- Dun Morogh
(@ENTRY,1,-5184.680176,-562.372009,397.260010,'Brewfest Reveler'),
(@ENTRY,2,-5192.152832,-547.358459,397.177094,'Brewfest Reveler'),
(@ENTRY,3,-5198.825684,-530.586243,392.940155,'Brewfest Reveler'),
-- Durotar
(@ENTRY*10,1,1209.775879,-4342.093750,21.295063,'Brewfest Reveler'),
(@ENTRY*10,2,1203.770874,-4356.925781,21.967909,'Brewfest Reveler'),
(@ENTRY*10,3,1202.042725,-4370.892578,24.852894,'Brewfest Reveler'),
(@ENTRY*10,4,1199.489868,-4389.286621,23.865566,'Brewfest Reveler');

SET @ENTRY1 := 23702; -- Thunderbrew Festive Keg
SET @ENTRY2 := 23700; -- Barleybrew Festive Keg
SET @ENTRY3 := 23706; -- Gordok Festive Keg
SET @ENTRY4 := 24373; -- T'chalis's Festive Keg
SET @ENTRY5 := 24372; -- Drohn's Festive Keg
UPDATE `creature_template` SET `AIName`='SmartAI',`unit_flags`=`unit_flags`|256,`RegenHealth`=0 WHERE `entry` IN (@ENTRY1,@ENTRY2,@ENTRY3,@ENTRY4,@ENTRY5);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY1,@ENTRY2,@ENTRY3,@ENTRY4,@ENTRY5);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Thunderbrew Festive Keg
(@ENTRY1,0,0,0,6,0,100,0,0,0,0,0,9,0,0,0,0,0,0,15,186184,100,0,0,0,0,0,"Thunderbrew Festive Keg - On Death - Set Data Thunderbrew Festive Keg (OBJECT)"),
(@ENTRY1,0,1,0,25,0,100,0,0,0,0,0,32,0,0,0,0,0,0,15,186184,100,0,0,0,0,0,"Thunderbrew Festive Keg - On Reset - Set Data Thunderbrew Festive Keg (OBJECT)"),
-- Barleybrew Festive Keg
(@ENTRY2,0,0,0,6,0,100,0,0,0,0,0,9,0,0,0,0,0,0,15,186183,100,0,0,0,0,0,"Barleybrew Festive Keg - On Death - Set Data Barleybrew Festive Keg (OBJECT)"),
(@ENTRY2,0,1,0,25,0,100,0,0,0,0,0,32,0,0,0,0,0,0,15,186183,100,0,0,0,0,0,"Barleybrew Festive Keg - On Reset - Set Data Barleybrew Festive Keg (OBJECT)"),
-- Gordok Festive Keg
(@ENTRY3,0,0,0,6,0,100,0,0,0,0,0,9,0,0,0,0,0,0,15,186185,100,0,0,0,0,0,"Gordok Festive Keg - On Death - Set Data Gordok Festive Keg (OBJECT)"),
(@ENTRY3,0,1,0,25,0,100,0,0,0,0,0,32,0,0,0,0,0,0,15,186185,100,0,0,0,0,0,"Gordok Festive Keg - On Reset - Set Data Gordok Festive Keg (OBJECT)"),
-- T'chalis's Festive Keg
(@ENTRY4,0,0,0,6,0,100,0,0,0,0,0,9,0,0,0,0,0,0,15,186187,100,0,0,0,0,0,"T'chalis's Festive Keg - On Death - Set Data T'chalis's Festive Keg (OBJECT)"),
(@ENTRY4,0,1,0,25,0,100,0,0,0,0,0,32,0,0,0,0,0,0,15,186187,100,0,0,0,0,0,"T'chalis's Festive Keg - On Reset - Set Data T'chalis's Festive Keg (OBJECT)"),
-- Drohn's Festive Keg
(@ENTRY5,0,0,0,6,0,100,0,0,0,0,0,9,0,0,0,0,0,0,15,186186,100,0,0,0,0,0,"Drohn's Festive Keg - On Death - Set Data Drohn's Festive Keg (OBJECT)"),
(@ENTRY5,0,1,0,25,0,100,0,0,0,0,0,32,0,0,0,0,0,0,15,186186,100,0,0,0,0,0,"Drohn's Festive Keg - On Reset - Set Data Drohn's Festive Keg (OBJECT)");

DELETE FROM `creature_equip_template` WHERE `CreatureID`=24484;
INSERT INTO `creature_equip_template` VALUES
(24484,1,2703,0,0,0),
(24484,2,2705,0,0,0),
(24484,3,33963,0,0,0),
(24484,4,2703,0,13859,0),
(24484,5,46733,0,0,0),
(24484,6,13861,0,0,0),
(24484,7,2704,0,0,0),
(24484,8,37059,0,0,0);

UPDATE `creature` SET `equipment_id`=-1 WHERE `id`=24484;

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_brewfest_reveler_transform';
INSERT INTO `spell_script_names` VALUES
(43907,'spell_brewfest_reveler_transform'),
(43908,'spell_brewfest_reveler_transform'),
(43909,'spell_brewfest_reveler_transform'),
(43910,'spell_brewfest_reveler_transform'),
(43911,'spell_brewfest_reveler_transform'),
(43912,'spell_brewfest_reveler_transform'),
(43913,'spell_brewfest_reveler_transform'),
(43914,'spell_brewfest_reveler_transform'),
(43915,'spell_brewfest_reveler_transform'),
(43916,'spell_brewfest_reveler_transform'),
(43917,'spell_brewfest_reveler_transform'),
(44003,'spell_brewfest_reveler_transform'),
(44004,'spell_brewfest_reveler_transform'),
(44094,'spell_brewfest_reveler_transform'),
(44096,'spell_brewfest_reveler_transform'),
(44337,'spell_brewfest_reveler_transform'),
(44338,'spell_brewfest_reveler_transform');

DELETE FROM `creature_addon` WHERE `guid` IN (28798,28799,88915,88918,88922,88936,137690,137691,137692,137693,137694,137695,137696,137697,137698,137699);
INSERT INTO `creature_addon` VALUES
(28798,0,0,0,4097,0,0,'44003'),
(28799,0,0,0,4097,0,0,'44003'),
(88915,0,0,0,4097,0,0,'44004'),
(88918,0,0,0,4097,0,0,'44003'),
(88922,0,0,0,4097,0,0,'44004'),
(88936,0,0,0,4097,0,0,'44004'),
(137690,0,0,0,4097,0,0,'44004'),
(137691,0,0,0,4097,0,0,'44003'),
(137692,0,0,0,4097,0,0,'44003'),
(137693,0,0,0,4097,0,0,'44003'),
(137694,0,0,0,4097,0,0,'44003'),
(137695,0,0,0,4097,0,0,'44003'),
(137696,0,0,0,4097,0,0,'44003'),
(137697,0,0,0,4097,0,0,'44004'),
(137698,0,0,0,4097,0,0,'44004'),
(137699,0,0,0,4097,0,0,'44003');

UPDATE `creature_addon` SET `auras`='44004' WHERE `guid`=88927;
UPDATE `creature_addon` SET `auras`='44004' WHERE `guid`=88947;
UPDATE `creature_addon` SET `auras`='44003' WHERE `guid`=88926;
UPDATE `creature_addon` SET `auras`='44003' WHERE `guid`=88921;
UPDATE `creature_addon` SET `auras`='44003' WHERE `guid`=88920;
UPDATE `creature_addon` SET `auras`='44003' WHERE `guid`=88919;
UPDATE `creature_addon` SET `auras`='44003' WHERE `guid`=88914;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_24_00' WHERE sql_rev = '1632254602577940300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
