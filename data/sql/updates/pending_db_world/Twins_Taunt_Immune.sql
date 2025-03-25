
-- Taunt Immune
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256 WHERE `entry` IN (25166, 25165);
