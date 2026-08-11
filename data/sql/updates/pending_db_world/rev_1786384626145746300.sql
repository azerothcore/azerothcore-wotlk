-- No spell has these as credit, so the flag is likely correct here
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2097152 WHERE (`entry` IN (29978, 29984));
