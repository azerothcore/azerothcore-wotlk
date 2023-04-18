DELETE FROM `smart_scripts` WHERE `entryorguid`=25418 AND `source_type`=0;

INSERT INTO `smart_scripts` VALUES (25416, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Simmer - On Aggro - Say Line 0');
INSERT INTO `smart_scripts` VALUES (25416, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 42, 0, 5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Simmer - On Respawn - Set Invincibility Hp 5%');
INSERT INTO `smart_scripts` VALUES (25416, 0, 2, 0, 0, 0, 100, 1, 5000, 5000, 5000, 5000, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Simmer - In Combat - Say Line 2');
INSERT INTO `smart_scripts` VALUES (25416, 0, 3, 4, 0, 0, 100, 1, 10000, 10000, 10000, 10000, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Simmer - In Combat - Say Line 3');
INSERT INTO `smart_scripts` VALUES (25416, 0, 4, 5, 61, 0, 100, 1, 0, 0, 0, 0, 0, 134, 45599, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 'Simmer - Between 0-5% Health - Invoker Cast &apos;Boiling Point: Simmer Kill Credit&apos; (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25416, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Simmer - Between 0-5% Health - Say Line 1 (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25416, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Simmer - Between 0-5% Health - Set Faction 35 (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25416, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Simmer - Between 0-5% Health - Evade (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25416, 0, 8, 0, 1, 0, 100, 512, 120000, 120000, 120000, 120000, 0, 2, 1983, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Simmer - Out of Combat - Set Faction 1983 (No Repeat)');

DELETE FROM `smart_scripts` WHERE `entryorguid`=25416 AND `source_type`=0;
INSERT INTO `smart_scripts` VALUES (25418, 0, 0, 0, 0, 0, 100, 0, 5300, 5300, 9900, 9900, 0, 11, 50206, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Churn - In Combat - Cast &apos;Scalding Steam&apos; (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25418, 0, 1, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 42, 0, 5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Churn - On Aggro - Set Invincibility Hp 5% (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25418, 0, 2, 0, 0, 0, 100, 1, 5000, 5000, 5000, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Churn - In Combat - Say Line 0 (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25418, 0, 3, 4, 0, 0, 100, 1, 10000, 10000, 10000, 10000, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Churn - In Combat - Say Line 1 (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25418, 0, 4, 5, 61, 0, 100, 1, 0, 0, 0, 0, 0, 134, 45598, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 'Churn - Between 0-5% Health - Invoker Cast &apos;Boiling Point: Churn Kill Credit&apos; (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25418, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Churn - Between 0-5% Health - Say Line 2 (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25418, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Churn - Between 0-5% Health - Set Faction 35 (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25418, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Churn - Between 0-5% Health - Evade (No Repeat)');
INSERT INTO `smart_scripts` VALUES (25418, 0, 8, 0, 1, 0, 100, 512, 120000, 120000, 120000, 120000, 0, 2, 1984, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Churn - Out of Combat - Set Faction 1984 (No Repeat)');
