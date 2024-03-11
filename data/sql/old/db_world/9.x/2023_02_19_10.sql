-- DB update 2023_02_19_09 -> 2023_02_19_10
-- add NO_MOVEMENT_UPDATE flag

UPDATE `creature_template` SET `flags_extra` = 512 WHERE (`entry` = 10506);
