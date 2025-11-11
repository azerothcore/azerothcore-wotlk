--
-- remove `DISABLE_MOVE`
UPDATE `creature_template` SET `unit_flags` = `unit_flags` & ~4 WHERE (`entry` = 28998);
