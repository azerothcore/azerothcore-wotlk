-- Sniffed from 50664 Build
UPDATE `creature_template` SET `unit_flags` = `unit_flags`&~(2|131072), `unit_flags` = `unit_flags`|256 WHERE (`entry` IN (31079, 31492));
