-- DB update 2024_07_17_00 -> 2024_07_17_01
-- Ashtongue Feral Spirit can't see through Invisiblity
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 22849);
-- Illidari Defiler missing Interrupt Immunity
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|256|4194304|33554432 WHERE (`entry` = 22853);
-- Illidari Boneslicer missing Stun immunity
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|256|2048|4194304|33554432 WHERE (`entry` = 22869);
-- Illidari Heartseeker missing Stun immunity
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|256|2048|4194304|33554432 WHERE (`entry` = 23339);
-- Illidari Nightlord missing Taunt immunity
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|256 WHERE (`entry` = 22855);
