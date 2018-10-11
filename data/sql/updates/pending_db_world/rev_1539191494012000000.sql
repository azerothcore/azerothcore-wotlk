INSERT INTO version_db_world (`sql_rev`) VALUES ('1539191494012000000');

-- Auriaya emote and say
DELETE FROM `creature_text` WHERE `entry`=33515;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextID`,`TextRange`,`comment`) VALUES (33515,0,0,'Some things are better left alone!',14,0,100,0,0,15473,34341,0,'Auriaya SAY_AGGRO');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextID`,`TextRange`,`comment`) VALUES (33515,1,1,'The secret dies with you.',14,0,100,0,0,15474,34354,0,'Auriaya SAY_SLAY_1');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextID`,`TextRange`,`comment`) VALUES (33515,1,2,'There is no escape!',14,0,100,0,0,15475,37177,0,'Auriaya SAY_SLAY_2');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextID`,`TextRange`,`comment`) VALUES (33515,2,0,'Auriaya screams in agony.',16,0,100,0,0,15476,0,0,'Auriaya SAY_DEATH');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextID`,`TextRange`,`comment`) VALUES (33515,3,0,'You waste my time!',14,0,100,0,0,15477,34358,0,'Auriaya SAY_BERSERK');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextID`,`TextRange`,`comment`) VALUES (33515,4,0,'%s begins to cast Terrifying Screech.',41,0,100,0,0,0,34450,0,'Auriaya EMOTE_FEAR');
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`BroadcastTextID`,`TextRange`,`comment`) VALUES (33515,5,0,'%s begins to activate the Feral Defender!',41,0,100,0,0,0,34162,0,'Auriaya EMOTE_DEFENDER');


-- Locales text
DELETE FROM `locales_creature_text` WHERE `entry`=33515;
INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc1`,`text_loc2`,`text_loc3`,`text_loc4`,`text_loc5`,`text_loc6`,`text_loc7`,`text_loc8`) VALUES (33515,0,0,NULL,NULL,NULL,'留在这里吧','留在这里吧',NULL,NULL,'');
INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc1`,`text_loc2`,`text_loc3`,`text_loc4`,`text_loc5`,`text_loc6`,`text_loc7`,`text_loc8`) VALUES (33515,1,1,NULL,NULL,NULL,'秘密会和你一同死去','秘密会和你一同死去',NULL,NULL,'');
INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc1`,`text_loc2`,`text_loc3`,`text_loc4`,`text_loc5`,`text_loc6`,`text_loc7`,`text_loc8`) VALUES (33515,1,2,NULL,NULL,NULL,'跑不了的！','跑不了的！',NULL,NULL,'');
INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc1`,`text_loc2`,`text_loc3`,`text_loc4`,`text_loc5`,`text_loc6`,`text_loc7`,`text_loc8`) VALUES (33515,2,0,NULL,NULL,NULL,'Auriaya痛苦地尖叫。','Auriaya痛苦地尖叫。',NULL,NULL,'Ауриайя кричит в агонии.');
INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc1`,`text_loc2`,`text_loc3`,`text_loc4`,`text_loc5`,`text_loc6`,`text_loc7`,`text_loc8`) VALUES (33515,3,0,NULL,NULL,NULL,'你在浪费我的时间！','你在浪费我的时间！',NULL,NULL,'');
INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc1`,`text_loc2`,`text_loc3`,`text_loc4`,`text_loc5`,`text_loc6`,`text_loc7`,`text_loc8`) VALUES (33515,4,0,NULL,NULL,NULL,'％s开始施放恐怖尖叫','％s开始施放恐怖尖叫',NULL,NULL,'');
INSERT INTO `locales_creature_text` (`entry`,`groupid`,`id`,`text_loc1`,`text_loc2`,`text_loc3`,`text_loc4`,`text_loc5`,`text_loc6`,`text_loc7`,`text_loc8`) VALUES (33515,5,0,NULL,NULL,NULL,'％s开始激活野性护卫！','％s开始激活野性护卫！',NULL,NULL,'');
