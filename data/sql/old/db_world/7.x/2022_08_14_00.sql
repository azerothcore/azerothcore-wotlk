-- DB update 2022_08_12_01 -> 2022_08_14_00
--
UPDATE `creature_formations` SET `dist`=5 WHERE `memberGUID` IN (87649,87650,87651);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=26084 AND `spell_effect`=25174 AND `type`=1;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES 
(26084, 25174, 1, 'Battleguard Sartura - OnHit Whirlwind - Apply Sundering Cleave');

