-- DB update 2025_04_01_03 -> 2025_04_01_04

-- Add Charm, Disoriented, Distract, Fear, Sleep, Banish immunities for Berserkers and Fury Mages.
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` |131611 WHERE (`entry` IN(25798, 25799));

-- Add Charm, Disoriented, Distract, Fear, Root, Slow Attack, Silence, Sleep, Snare, Stun, Freeze, Knockout, Polymorph, Banish, Interrupt, Daze, Sapped immunities for Void Sentinel.
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` |637747163 WHERE (`entry` = 25772);
