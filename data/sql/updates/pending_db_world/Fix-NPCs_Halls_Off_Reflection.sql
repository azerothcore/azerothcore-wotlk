/*  
SQL Dark Ranger Loralen emote
*/  
UPDATE `creature_template_addon` SET `emote` = 0 WHERE (`entry` = 37779);

/*  
SQL LK Boss final
*/  
UPDATE `creature` SET `guid`=1972025, `id1`=36954, `id2`=0, `id3`=0, `map`=668, `zoneId`=0, `areaId`=0, `spawnMask`=3, `phaseMask`=1, `equipment_id`=1, `position_x`=5553.48, `position_y`=2262.91, `position_z`=733.012, `orientation`=4.03979, `spawntimesecs`=86400, `wander_distance`=0, `currentwaypoint`=0, `curhealth`=27890000, `curmana`=0, `MovementType`=0, `npcflag`=0, `unit_flags`=0, `dynamicflags`=0, `ScriptName`='', `VerifiedBuild`=0 WHERE `guid`=1972025;

/*  
SQL LK Boss final
*/
UPDATE `creature` SET `guid`=1972026, `id1`=37554, `id2`=0, `id3`=0, `map`=668, `zoneId`=0, `areaId`=0, `spawnMask`=1, `phaseMask`=1, `equipment_id`=1, `position_x`=5554.73, `position_y`=2259.63, `position_z`=733.011, `orientation`=1.78626, `spawntimesecs`=300, `wander_distance`=0, `currentwaypoint`=0, `curhealth`=5040000, `curmana`=881400, `MovementType`=0, `npcflag`=0, `unit_flags`=0, `dynamicflags`=0, `ScriptName`='', `VerifiedBuild`=NULL WHERE `guid`=1972026;

/*  
Add Gossip Sylvanas Final
*/  
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (10931, 15190);












