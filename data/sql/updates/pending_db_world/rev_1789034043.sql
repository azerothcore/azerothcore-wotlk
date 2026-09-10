
-- Set Extra_Flag Cannot Enter Combat.
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |819 WHERE (`entry` = 34001);
