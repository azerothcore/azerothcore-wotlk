--
UPDATE `creature_template` SET `ScriptName`='npc_anubisath_defender', `AiName`='' WHERE `entry`=15277;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15277 AND `source_type`=0;
