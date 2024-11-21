-- DB update 2023_08_06_00 -> 2023_08_06_01
-- https://www.wowhead.com/wotlk/quest=9433/
UPDATE `creature_template` SET `ScriptName`='npc_controller' WHERE `entry` IN (17178, 19405);
