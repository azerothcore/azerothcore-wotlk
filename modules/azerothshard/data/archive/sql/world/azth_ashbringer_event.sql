UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_myrmidon' WHERE  `entry`=4295;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_defender' WHERE  `entry`=4298;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_centurion' WHERE  `entry`=4301;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_sorcerer' WHERE  `entry`=4294;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_wizard' WHERE  `entry`=4300;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_abbot' WHERE  `entry`=4303;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_monk' WHERE  `entry`=4540;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_champion' WHERE  `entry`=4302;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_scarlet_chaplain' WHERE  `entry`=4299;


DELETE FROM `smart_scripts` WHERE `entryorguid`IN (4301, 4295, 4298, 4300, 4540, 4302, 4299, 4294, 4303);

-- one
DELETE FROM `creature_text` WHERE `entry`=4298;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4298, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4298, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4298, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4298, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4298, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4298, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');

-- two
DELETE FROM `creature_text` WHERE `entry`=4295;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4295, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4295, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4295, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4295, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4295, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4295, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, ''),
(4295, 1, 0, 'There is no escape for you.  The Crusade shall destroy all who carry the scourge\'s taint.', 12, 7, 0, 0, 0, 0, 'Scarlet Myrmidon - Talk on low HP');

-- three
DELETE FROM `creature_text` WHERE `entry`=4301;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4301, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4301, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4301, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4301, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4301, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4301, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');
-- four
DELETE FROM `creature_text` WHERE `entry`=4294;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4294, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4294, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4294, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4294, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4294, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4294, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');
-- five
DELETE FROM `creature_text` WHERE `entry`=4300;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4300, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4300, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4300, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4300, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4300, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4300, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');
-- six
DELETE FROM `creature_text` WHERE `entry`=4303;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4303, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4303, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4303, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4303, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4303, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4303, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');
-- seven
DELETE FROM `creature_text` WHERE `entry`=4540;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4540, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4540, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4540, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4540, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4540, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4540, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');
-- eight
DELETE FROM `creature_text` WHERE `entry`=4302;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4302, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4302, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4302, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4302, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4302, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4302, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');
-- ninetails
DELETE FROM `creature_text` WHERE `entry`=4299;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES 
(4299, 0, 0, 'Have you come to save the world? To cleanse it?', 12, 0, 100, 0, 0, 0, ''),
(4299, 0, 1, 'And it begins...', 12, 0, 100, 0, 0, 0, ''),
(4299, 0, 2, 'Ashbringer...', 12, 0, 100, 0, 0, 0, ''),
(4299, 0, 3, 'Kneel! Kneel before the Ashbringer!', 12, 0, 100, 0, 0, 0, ''),
(4299, 0, 4, 'My Lord, please allow me to live long enough to see you purge this world of the infidles.', 12, 0, 100, 0, 0, 0, ''),
(4299, 0, 5, 'Take me with you, Sir.', 12, 0, 100, 0, 0, 0, '');