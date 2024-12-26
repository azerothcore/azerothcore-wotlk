-- Add interrupt immunity to Illidari Nightlord
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 33554432 WHERE (`entry` = 22855);
