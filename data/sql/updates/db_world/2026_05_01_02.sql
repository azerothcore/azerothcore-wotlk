-- DB update 2026_05_01_01 -> 2026_05_01_02

-- Set Aura for Scarlet Inquisitor (corpse)
UPDATE `creature_template_addon` SET `auras` = '29266 52951' WHERE `entry` = 29029;

-- Set Aura for Death Knights and Dummy
UPDATE `creature_template_addon` SET `auras` = '52951' WHERE `entry` IN (29030, 29031, 29038);

-- Set Aura for Plaguefist and Prisoners
UPDATE `creature_addon` SET `auras` = '52951' WHERE (`guid` IN (129947, 129905, 129950, 129955, 129959, 129961, 129964, 129965, 129966, 129967, 129968));
