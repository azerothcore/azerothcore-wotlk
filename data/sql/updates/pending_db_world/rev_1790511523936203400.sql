-- Onyxian Whelp
UPDATE `creature_template` SET `ScriptName` = 'npc_onyxian_whelp' WHERE `entry` = 11262;

-- Onyxia Egg
UPDATE `gameobject` SET `spawntimesecs` = 30, `VerifiedBuild` = 69933 WHERE `id` = 176511 AND `guid` BETWEEN 150444 AND 150562;
