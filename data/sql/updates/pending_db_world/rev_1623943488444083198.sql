INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623943488444083198');

-- Remove Claw (cat ability and sound) from SmartAI for Non-Cat creatures:
-- Mottled Raptor (1020), Highland Strider (2559), Young Mesa Buzzard (2578)
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1020, 2559, 2578)  AND `id`=0;
