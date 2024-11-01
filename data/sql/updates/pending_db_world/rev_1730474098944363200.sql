-- Syndicate Thief
UPDATE `creature_template` SET `unit_flags` = `unit_flags`&~(262144) WHERE (`entry` = 24477);
