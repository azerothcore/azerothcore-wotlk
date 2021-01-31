-- DB update 2020_06_17_00 -> 2020_06_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_17_00 2020_06_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1590187354352733700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590187354352733700');

DELETE FROM `spell_custom_attr` WHERE `entry` IN (99, 1735, 5729, 9490, 9497, 9898, 26998, 48559, 48560, 1130,1725,3600,14323,14324,14325,32375,32592,35009,39897,42650,43263,43264,53338,59667,58831,58832,58833,58834,58838,64695,29858,32835,10576,12323,23600,38256,43530,52744);
INSERT INTO `spell_custom_attr` (`entry`, `attributes`) VALUES
(1130, 64), -- Hunter spell 1130, Hunter's Mark Rank 1
(1725, 64),  -- Rogue spell 1725, Distract
(3600, 64),  -- Greater Earthbind Totem spell 3600, Earthbind
(5729, 64),  -- Stoneclaw totem effect
(14323, 64), -- Hunter spell 14323, Hunter's Mark Rank 2
(14324, 64), -- Hunter spell 14324, Hunter's Mark Rank 3
(14325, 64), -- Hunter spell 14325, Hunter's Mark Rank 4
(32375, 64), -- Priest Discipline spell 32375, Mass Dispel
(32592, 64), -- Priest Discipline spell 32592, Mass Dispel
(35009, 64), -- Triggered by Mage Invisibility (Level 68), spells 66 & 67765
(39897, 64), -- Priest Discipline spell 39897, Mass Dispel
(42650, 64), -- Death Knight Unholy spell 42650, Army of the Dead
(43263, 64), -- Ghoul level 66 spell 43263, Ghoul Taunt
(43264, 64), -- Periodic Taunt, Trigger for Ghoul Taunt
(53338, 64), -- Hunter spell 53338, Hunter's Mark Rank 5 
(58831, 64), -- Mirror Image, spawns left Mirror Image NPC
(58832, 64), -- Mirror Image, Triggers 58831,58833,58834
(58833, 64), -- Mirror Image, spawns center Mirror Image NPC
(58834, 64), -- Mirror Image, spawns right Mirror Image NPC
(58838, 64), -- Inherit Master's Threat List
(64695, 64), -- Earthgrab (Xinef fix for Totem)
(59667, 64), -- Intervine trigger
(29858, 64), -- Soulshatter from warlock
(32835, 64),
(10576, 64), -- Piercing Howls
(12323, 64),
(23600, 64),
(38256, 64),
(43530, 64),
(52744, 64),
(99, 64),    -- Druid Demoralizing roars (spellInfo->SpellFamilyFlags[0] & 0x8)
(1735, 64),
(9490, 64),
(9497, 64),
(9898, 64),
(26998, 64),
(48559, 64),
(48560, 64);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
