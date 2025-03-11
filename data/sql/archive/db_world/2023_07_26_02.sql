-- DB update 2023_07_26_01 -> 2023_07_26_02
--
UPDATE `item_template` SET `spellcooldown_1` = -1 WHERE (`entry` = 37111);
UPDATE `item_template` SET `spellcooldown_1` = -1, `spellcategorycooldown_1` = 2000 WHERE (`entry` = 47477);
UPDATE `item_template` SET `spellcooldown_1` = -1, `spellcategorycooldown_1` = 2000 WHERE (`entry` = 47316);
UPDATE `item_template` SET `spellcooldown_1` = -1, `spellcooldown_2` = -1, `spellcooldown_3` = -1 WHERE (`entry` = 45507);
UPDATE `item_template` SET `spellcooldown_2` = -1, `spellcooldown_3` = -1 WHERE (`entry` = 45522);
UPDATE `item_template` SET `spellcooldown_2` = -1, `spellcooldown_3` = -1 WHERE (`entry` = 45929);
UPDATE `item_template` SET `spellcooldown_2` = -1, `spellcooldown_3` = -1 WHERE (`entry` = 45931);
UPDATE `item_template` SET `spelltrigger_2` = 0, `spellcooldown_2` = -1, `spellcooldown_3` = -1 WHERE (`entry` = 45866);
UPDATE `item_template` SET `spellcooldown_1` = -1, `spellcategorycooldown_1` = 45000 WHERE (`entry` = 40255);
UPDATE `item_template` SET `spellcooldown_1` = -1 WHERE (`entry` = 40373);
UPDATE `item_template` SET `spellcooldown_1` = 0, `spellcategorycooldown_1` = -1 WHERE (`entry` = 37835);
UPDATE `item_template` SET `spellcooldown_1` = 0, `spellcategorycooldown_1` = -1 WHERE (`entry` = 39229);
UPDATE `item_template` SET `spellcooldown_1` = 0 WHERE (`entry` = 37390);
UPDATE `item_template` SET `spellcooldown_1` = 0 WHERE (`entry` = 37657);
UPDATE `item_template` SET `spellcooldown_1` = 0 WHERE (`entry` = 37660);

UPDATE `item_template` SET `spellppmRate_1` = 0 WHERE (`entry` = 50348);
UPDATE `item_template` SET `spellppmRate_1` = 0 WHERE (`entry` = 50353);
UPDATE `item_template` SET `spellppmRate_1` = 0 WHERE (`entry` = 54588);

UPDATE `spell_proc_event` SET `CustomChance` = 45 WHERE `entry` = 71545;  
UPDATE `spell_proc_event` SET `CustomChance` = 35 WHERE `entry` = 71562;

UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 71585;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 64738;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 64792;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 62114;
UPDATE `spell_proc_event` SET `Cooldown` = 45000 WHERE `entry` = 58901;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 33648;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 49622;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 65013;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 65002;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 62115;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 67672;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 33648;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 60221;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 60519;
UPDATE `spell_proc_event` SET `Cooldown` = 50000 WHERE `entry` = 63251;

DELETE FROM `spell_proc_event` WHERE `entry` IN (75474, 71602, 64764);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `procPhase`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(75474,0,0,0,0,0,0,0,0,0,0,50000),
(64764,0,0,0,0,0,0,0,0,0,0,50000),
(71602,0,0,0,0,0,0,0,0,0,0,45000);
