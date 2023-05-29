-- DB update 2022_06_02_01 -> 2022_06_03_00

DELETE FROM `spell_proc_event` WHERE `entry` = '71602';
DELETE FROM `spell_proc_event` WHERE `entry` = '75465';
DELETE FROM `spell_proc_event` WHERE `entry` = '71845';
DELETE FROM `spell_proc_event` WHERE `entry` = '71846';
DELETE FROM `spell_proc_event` WHERE `entry` = '72419';
DELETE FROM `spell_proc_event` WHERE `entry` = '75474';

UPDATE `item_template` SET `spellppmRate_1` = 10 WHERE (`entry` = 50353);
UPDATE `item_template` SET `spellppmRate_1` = 10 WHERE (`entry` = 50348);
UPDATE `item_template` SET `spellppmRate_1` = 2 WHERE (`entry` = 49992);
UPDATE `item_template` SET `spellppmRate_1` = 2 WHERE (`entry` = 50648);
UPDATE `item_template` SET `spellppmRate_1` = 10 WHERE (`entry` = 50400);
UPDATE `item_template` SET `spellppmRate_1` = 10 WHERE (`entry` = 50399);
UPDATE `item_template` SET `spellppmRate_1` = 10 WHERE (`entry` = 54572);
UPDATE `item_template` SET `spellppmRate_1` = 10 WHERE (`entry` = 54588);
