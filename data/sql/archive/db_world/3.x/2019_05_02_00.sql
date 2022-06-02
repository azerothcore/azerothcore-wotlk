-- DB update 2019_05_01_00 -> 2019_05_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_01_00 2019_05_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1555998926077008658'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555998926077008658');

-- Cleanup phasing after quest "Return To Angrathar" is rewarded
DELETE FROM `spell_area` WHERE `spell` = 58932;
INSERT INTO `spell_area` (`spell`,`area`,`quest_start`,`quest_end`,`aura_spell`,`racemask`,`gender`,`autocast`,`quest_start_status`,`quest_end_status`)
VALUES
(58932,4169,12499,0,0,0,2,1,64,0), -- Fordragon Hold - Post-Wrath Gate Phase - After Quest "Return To Angrathar" (Alliance) is Rewarded
(58932,4169,12500,0,0,0,2,1,64,0), -- Fordragon Hold - Post-Wrath Gate Phase - After Quest "Return To Angrathar" (Horde) is Rewarded
(58932,4170,12499,0,0,0,2,1,64,0), -- Kor'kron Vanguard - Post-Wrath Gate Phase - After Quest "Return To Angrathar" (Alliance) is Rewarded
(58932,4170,12500,0,0,0,2,1,64,0), -- Kor'kron Vanguard - Post-Wrath Gate Phase - After Quest "Return To Angrathar" (Horde) is Rewarded
(58932,4171,12499,0,0,0,2,1,64,0), -- The Court of Skulls - Post-Wrath Gate Phase - After Quest "Return To Angrathar" (Alliance) is Rewarded
(58932,4171,12500,0,0,0,2,1,64,0), -- The Court of Skulls - Post-Wrath Gate Phase - After Quest "Return To Angrathar" (Horde) is Rewarded
(58932,4172,12499,0,0,0,2,1,64,0), -- Angrathar the Wrathgate - Post-Wrath Gate Phase - After Quest "Return To Angrathar" (Alliance) is Rewarded
(58932,4172,12500,0,0,0,2,1,64,0); -- Angrathar the Wrathgate - Post-Wrath Gate Phase - After Quest "Return To Angrathar" (Horde) is Rewarded


-- Fleeing Horde Soldier - Run around and cower in fear
UPDATE `creature` SET `MovementType` = 1, `spawndist` = 10 WHERE `id` IN (31328,31330);

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (31328,31330);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(31328,0,0,1,11,0,100,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Horde Soldier - On Spawn - Set Run On'),
(31328,0,1,0,61,0,100,0,0,0,0,0,0,17,431,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Horde Soldier - On Spawn - Set Emote State ''STATE_COWER'''),
(31328,0,2,0,1,0,100,0,0,3000,1000,3000,0,87,3131000,3131001,3131002,3131003,3131004,0,1,0,0,0,0,0,0,0,0,'Fleeing Horde Soldier - OOC - Run Random Script'),
(31328,0,3,0,1,0,100,0,1000,2000,3000,6000,0,46,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Horde Soldier - OOC - Move Forward'),
(31328,0,4,0,1,0,100,0,12000,24000,12000,24000,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Horde Soldier - OOC - Evade'),
(31330,0,0,1,11,0,100,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Horde Soldier - On Spawn - Set Run On'),
(31330,0,1,0,61,0,100,0,0,0,0,0,0,17,431,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Horde Soldier - On Spawn - Set Emote State ''STATE_COWER'''),
(31330,0,2,0,1,0,100,0,0,3000,1000,3000,0,87,3131005,3131006,3131007,3131008,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Horde Soldier - OOC - Run Random Script'),
(31330,0,3,0,1,0,100,0,1000,2000,3000,6000,0,46,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Horde Soldier - OOC - Move Forward'),
(31330,0,4,0,1,0,100,0,12000,24000,12000,24000,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Horde Soldier - OOC - Evade');


-- Fleeing Alliance Soldier - Run around and cower in fear
UPDATE `creature` SET `MovementType` = 1, `spawndist` = 10 WHERE `id` IN (31310,31313);

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (31310,31313);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(31310,0,0,1,11,0,100,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Alliance Soldier - On Spawn - Set Run On'),
(31310,0,1,0,61,0,100,0,0,0,0,0,0,17,431,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Alliance Soldier - On Spawn - Set Emote State ''STATE_COWER'''),
(31310,0,2,0,1,0,100,0,0,3000,1000,3000,0,87,3131000,3131001,3131002,3131003,3131004,0,1,0,0,0,0,0,0,0,0,'Fleeing Alliance Soldier - OOC - Run Random Script'),
(31310,0,3,0,1,0,100,0,1000,2000,3000,6000,0,46,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Alliance Soldier - OOC - Move Forward'),
(31310,0,4,0,1,0,100,0,12000,24000,12000,24000,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Alliance Soldier - OOC - Evade'),
(31313,0,0,1,11,0,100,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Alliance Soldier - On Spawn - Set Run On'),
(31313,0,1,0,61,0,100,0,0,0,0,0,0,17,431,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Alliance Soldier - On Spawn - Set Emote State ''STATE_COWER'''),
(31313,0,2,0,1,0,100,0,0,3000,1000,3000,0,87,3131005,3131006,3131007,3131008,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Alliance Soldier - OOC - Run Random Script'),
(31313,0,3,0,1,0,100,0,1000,2000,3000,6000,0,46,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Alliance Soldier - OOC - Move Forward'),
(31313,0,4,0,1,0,100,0,12000,24000,12000,24000,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fleeing Alliance Soldier - OOC - Evade');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
