-- DB update 2021_09_20_01 -> 2021_09_20_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_20_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_20_01 2021_09_20_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631643504019542275'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631643504019542275');

-- Add aura of slowing poison to Defias Night Blade and remove the casting of wrong spell 
UPDATE `creature_template_addon` SET `auras` = '8601' WHERE (`entry` = 909);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 909) AND (`source_type` = 0) AND (`id` IN (1));

-- Add aura of Weak Poison Proc to Webwood Spider
UPDATE `creature_template_addon` SET `auras` = '6752' WHERE (`entry` = 1986);

-- Add aura of Slowing Poison and Poison Proc to Shadra
UPDATE `creature_template_addon` SET `auras` = '8601 13299' WHERE (`entry` = 2707);

-- Add aura of Fevered Fatigue to Mangy Silvermane and remove the casting of Fevered Fatigue
UPDATE `creature_template_addon` SET `auras` = '18847' WHERE (`entry` = 2923);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2923) AND (`source_type` = 0);

-- Add aura of Nature Channeling to Lady Anacondra
UPDATE `creature_template_addon` SET `auras` = '13236' WHERE (`entry` = 3671);

-- Add aura of Curse of the Bleakheart Proc to Bleakheart Satyr
UPDATE `creature_template_addon` SET `auras` = '6947' WHERE (`entry` = 3765);

-- Add aura of Thrash to Fardel Dabyrie and removed the casting of Thrash
UPDATE `creature_template_addon` SET `auras` = '8876' WHERE (`entry` = 4479);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4479) AND (`source_type` = 0) AND (`id` IN (0));

-- Add aura of Shield Spike to Nightmare Scalebane
UPDATE `creature_template_addon` SET `auras` = '12099' WHERE (`entry` = 5277);

-- Add aura of Azrethoc's Flight and enrage to Lord Azrethoc
UPDATE `creature_template_addon` SET `auras` = '7974 15097' WHERE (`entry` = 5760);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_20_02' WHERE sql_rev = '1631643504019542275';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
