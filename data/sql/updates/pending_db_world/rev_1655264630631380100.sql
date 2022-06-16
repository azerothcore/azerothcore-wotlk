--
DELETE FROM `creature_addon` WHERE `guid`=144632;
INSERT INTO `creature_addon` (`guid`, `auras`) VALUES 
(144632, '8876'); -- Triggers SPELL_THRASH = 3391

-- Immune to Taunt
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|256 WHERE `entry` IN 
(15339, -- Ossirian
15370, -- Buru
15369); -- Ayamiss

