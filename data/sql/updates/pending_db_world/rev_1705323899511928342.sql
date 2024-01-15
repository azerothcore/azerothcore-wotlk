UPDATE `disables` SET `params_0` = '30,489,529', `comment` = 'Disable of Ritual of Summoning on Alterac Valley, Warsong Gulch and Arathi Basin' WHERE `sourceType` = 0 AND `entry` = 698;
DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = 28148;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `comment`) VALUES (0, 28148, 17, '30,489,529', 'Disable Portal: Karazhan on Alterac Valley, Warsong Gulch and Arathi Basin');
