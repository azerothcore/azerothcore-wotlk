-- Set immune to taunt
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256 WHERE (`entry` = 25840);
