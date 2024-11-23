--
-- Adds "Disarm" immunity to Creautre (Boss) "Halazzi" - [Zul'Aman]
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 4 WHERE `entry` = 23577;
