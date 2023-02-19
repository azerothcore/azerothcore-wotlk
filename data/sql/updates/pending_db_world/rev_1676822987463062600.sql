-- add NO_MOVEMENT_UPDATE flag

UPDATE `creature_template` SET `flags_extra` = 512 WHERE (`entry` = 10506);
