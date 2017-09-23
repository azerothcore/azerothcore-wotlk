INSERT INTO version_db_world (`sql_rev`) VALUES ('1504433338685092700');
-- Scarlet Commander Mograine SAI
SET @ENTRY := 3976;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_commander_mograine' WHERE `entry`='3976';
-- High Inquisitor Whitemane SAI
SET @ENTRY := 3977;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
SET @ENTRY := 397700;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='boss_high_inquisitor_whitemane' WHERE `entry`='3977';
