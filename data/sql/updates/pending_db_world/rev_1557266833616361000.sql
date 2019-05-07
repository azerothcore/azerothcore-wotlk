INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1557266833616361000');


UPDATE `creature_template` SET `ScriptName`='npc_burning_spirit' WHERE `entry`=9178;

DELETE FROM `creature_text` WHERE `CreatureID` = 9156;
INSERT INTO `creature_text` (`CreatureID`, `Text`, `Type`, `Probability`, `comment`) VALUES ('9156', 'Your reign of terror ends now! Face your doom mortals!', '14', '100', 'Ambassador_flamelash_aggro');
