
-- Add No_Taunt flag
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256 WHERE (`entry` = 25315);
