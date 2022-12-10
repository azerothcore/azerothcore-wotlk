-- DB update 2021_10_08_10 -> 2021_10_08_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_08_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_08_10 2021_10_08_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632342398795739900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632342398795739900');

-- Coren Direbrew Implementation
SET @CGUID := 240000;
UPDATE `creature` SET `position_x`=891.8394, `position_y`=-129.1829, `position_z`=-49.65985, `orientation`=5.253441, `MovementType`=2 WHERE `guid`=@CGUID;
DELETE FROM `creature_addon` WHERE `guid`=@CGUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(@CGUID,@CGUID*10,0,0,1,0,NULL);

DELETE FROM `waypoint_data` WHERE `id` IN (@CGUID*10);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`action`,`action_chance`,`wpguid`) VALUES
(@CGUID*10,0,888.4606, -130.909, -49.7434,0,0,0,100,0),
(@CGUID*10,1,895.4048, -126.9586, -49.74198,0,0,0,100,0);

UPDATE `gameobject_template` SET `data2`=10000, `ScriptName`='go_direbrew_mole_machine' WHERE `entry`=188508;
UPDATE `gameobject_template` SET `displayId`=1287, `data4`=2, `VerifiedBuild`=0 WHERE `entry`=188509;
UPDATE `creature_template` SET `unit_flags`=33024 WHERE `entry`=23795;
UPDATE `creature_template` SET `ScriptName`='npc_direbrew_antagonist' WHERE `entry`=23795;
UPDATE `creature_template` SET `ScriptName`='npc_direbrew_minion' WHERE `entry`=26776;
UPDATE `creature_template` SET `ScriptName`='npc_coren_direbrew_sisters' WHERE `entry` IN(26764,26822);
UPDATE `creature_template` SET `unit_flags`=256, `ScriptName`='npc_coren_direbrew' WHERE `entry`=23872;

DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=50313;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0,50313,64,0,0,'Disable LOS for Spell Mole Machine Emerge');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN(47344,52850);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,47344,0,0,31,0,3,26764,0,0,0,0,'','Spell Request Second mug targets Ilsa Direbrew'),
(13,1,52850,0,0,31,0,3,23872,0,0,0,0,'','Spell Port to Coren target Coren Direbrew');

DELETE FROM `creature_template_addon` WHERE `entry` IN (26764,26822);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(26764, 0, 0, 0, 1, 0, '47759 47760'),
(26822, 0, 0, 0, 1, 0, '47759 47760');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN (
'spell_direbrew_summon_mole_machine_target_picker',
'spell_direbrew_disarm',
'spell_send_mug_control_aura',
'spell_send_mug_target_picker',
'spell_request_second_mug',
'spell_barreled_control_aura');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(47407,'spell_direbrew_disarm'),
(47691,'spell_direbrew_summon_mole_machine_target_picker'),
(47369,'spell_send_mug_control_aura'),
(47370,'spell_send_mug_target_picker'),
(47344,'spell_request_second_mug'),
(50278,'spell_barreled_control_aura');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_08_11' WHERE sql_rev = '1632342398795739900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
