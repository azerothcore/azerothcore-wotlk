-- Update zhCN ; from WowHead WOTLK+ / Retail
-- OLD subname : NPC
-- Source : https://www.wowhead.com/wotlk/cn/npc=19
UPDATE `creature_template_locale` SET `Title` = '非玩家角色' WHERE `locale` = 'zhCN' AND `entry` = 19;
-- OLD name : Kanrethad, subname : Master of Death
-- Source : https://www.wowhead.com/wotlk/cn/npc=29
UPDATE `creature_template_locale` SET `Name` = 'Dragon Spawn',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29;
-- OLD name : 暴徒
-- Source : https://www.wowhead.com/wotlk/cn/npc=38
UPDATE `creature_template_locale` SET `Name` = '迪菲亚暴徒' WHERE `locale` = 'zhCN' AND `entry` = 38;
-- OLD name : [UNUSED] Lower Class Citizen (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=70
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 70;
-- OLD subname : Questgiver
-- Source : https://www.wowhead.com/wotlk/cn/npc=73
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 73;
-- OLD name : [UNUSED] Vashaum Nightwither (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=75
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 75;
-- OLD name : [UNUSED] Luglar the Clogger (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=81
UPDATE `creature_template_locale` SET `Name` = '节日 - 万圣节 -要塞 - 幽灵啤酒' WHERE `locale` = 'zhCN' AND `entry` = 81;
-- OLD name : 小偷
-- Source : https://www.wowhead.com/wotlk/cn/npc=94
UPDATE `creature_template_locale` SET `Name` = '迪菲亚小偷' WHERE `locale` = 'zhCN' AND `entry` = 94;
-- OLD name : 强盗
-- Source : https://www.wowhead.com/wotlk/cn/npc=116
UPDATE `creature_template_locale` SET `Name` = '迪菲亚强盗' WHERE `locale` = 'zhCN' AND `entry` = 116;
-- OLD name : [UNUSED] Small Black Dragon Whelp (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=149
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 149;
-- OLD name : [UNUSED] Ander the Monk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=161
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 161;
-- OLD name : [UNUSED] Destitute Farmer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=163
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 163;
-- OLD name : [UNUSED] Small Child (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=165
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 165;
-- OLD name : Ice Troll
-- Source : https://www.wowhead.com/wotlk/cn/npc=192
UPDATE `creature_template_locale` SET `Name` = '冰雪巨魔' WHERE `locale` = 'zhCN' AND `entry` = 192;
-- OLD name : 腐烂恐魔
-- Source : https://www.wowhead.com/wotlk/cn/npc=202
UPDATE `creature_template_locale` SET `Name` = '恐怖骸骨' WHERE `locale` = 'zhCN' AND `entry` = 202;
-- OLD name : [UNUSED] Cackle Flamebone (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=204
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 204;
-- OLD name : [UNUSED] Riverpaw Hideflayer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=207
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 207;
-- OLD name : [UNUSED] Riverpaw Pack Warder (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=208
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 208;
-- OLD name : [UNUSED] Riverpaw Bone Chanter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=209
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 209;
-- OLD name : Thornton Fellwood, subname : Woodcrafter
-- Source : https://www.wowhead.com/wotlk/cn/npc=230
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 230;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (230, 'zhCN','索恩顿·菲尔伍德','木工');
-- OLD name : 治安官格里安·斯托曼
-- Source : https://www.wowhead.com/wotlk/cn/npc=234
UPDATE `creature_template_locale` SET `Name` = '格里安·斯托曼' WHERE `locale` = 'zhCN' AND `entry` = 234;
-- OLD name : [UNUSED] Elwynn Tower Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=260
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 260;
-- OLD name : [DND] Wounded Lion's Footman
-- Source : https://www.wowhead.com/wotlk/cn/npc=262
UPDATE `creature_template_locale` SET `Name` = '被吃掉一半的尸体' WHERE `locale` = 'zhCN' AND `entry` = 262;
-- OLD name : [UNUSED] Goodmother Jans (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=296
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 296;
-- OLD name : 幼狼
-- Source : https://www.wowhead.com/wotlk/cn/npc=299
UPDATE `creature_template_locale` SET `Name` = '染病的幼狼' WHERE `locale` = 'zhCN' AND `entry` = 299;
-- OLD name : [UNUSED] Brog'Mud (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=301
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 301;
-- OLD name : 白马
-- Source : https://www.wowhead.com/wotlk/cn/npc=305
UPDATE `creature_template_locale` SET `Name` = '骑乘用马（白色）' WHERE `locale` = 'zhCN' AND `entry` = 305;
-- OLD name : 褐色马
-- Source : https://www.wowhead.com/wotlk/cn/npc=306
UPDATE `creature_template_locale` SET `Name` = '骑乘用马（褐色）' WHERE `locale` = 'zhCN' AND `entry` = 306;
-- OLD name : 黑马
-- Source : https://www.wowhead.com/wotlk/cn/npc=308
UPDATE `creature_template_locale` SET `Name` = '骑乘用马（黑色）' WHERE `locale` = 'zhCN' AND `entry` = 308;
-- OLD name : "Buried Upside-Down" Vehicle
-- Source : https://www.wowhead.com/wotlk/cn/npc=309
UPDATE `creature_template_locale` SET `Name` = '罗尔夫的尸体' WHERE `locale` = 'zhCN' AND `entry` = 309;
-- OLD name : [UNUSED] Brother Akil (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=318
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 318;
-- OLD name : [UNUSED] Brother Benthas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=319
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 319;
-- OLD name : [UNUSED] Brother Cryus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=320
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 320;
-- OLD name : [UNUSED] Brother Deros (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=321
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 321;
-- OLD name : [UNUSED] Brother Enoch (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=322
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 322;
-- OLD name : [UNUSED] Brother Farthing (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=323
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 323;
-- OLD name : [UNUSED] Brother Greishan (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=324
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 324;
-- OLD name : [UNUSED] Brother Ictharin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=326
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 326;
-- OLD name : 马迪亚斯·肖尔大师
-- Source : https://www.wowhead.com/wotlk/cn/npc=332
UPDATE `creature_template_locale` SET `Name` = '马迪亚斯·肖尔' WHERE `locale` = 'zhCN' AND `entry` = 332;
-- OLD name : [UNUSED] Edwardo the Jester (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=333
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 333;
-- OLD name : [UNUSED] Rin Tal'Vara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=336
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 336;
-- OLD name : [UNUSED] Helgor the Pugilist (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=339
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 339;
-- OLD name : 森林狼
-- Source : https://www.wowhead.com/wotlk/cn/npc=358
UPDATE `creature_template_locale` SET `Name` = '骑乘用狼（棕色）' WHERE `locale` = 'zhCN' AND `entry` = 358;
-- OLD name : 冬狼
-- Source : https://www.wowhead.com/wotlk/cn/npc=359
UPDATE `creature_template_locale` SET `Name` = '骑乘用狼（白色）' WHERE `locale` = 'zhCN' AND `entry` = 359;
-- OLD name : 达希·帕克, subname : 女招待
-- Source : https://www.wowhead.com/wotlk/cn/npc=379
UPDATE `creature_template_locale` SET `Name` = '达希',`Title` = '女服务生' WHERE `locale` = 'zhCN' AND `entry` = 379;
-- OLD name : [UNUSED] Waldin Thorbatt (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=380
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 380;
-- OLD name : 大魔导师杜内
-- Source : https://www.wowhead.com/wotlk/cn/npc=397
UPDATE `creature_template_locale` SET `Name` = '莫甘斯' WHERE `locale` = 'zhCN' AND `entry` = 397;
-- OLD name : Chubbs (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=444
UPDATE `creature_template_locale` SET `Name` = '小猪大人' WHERE `locale` = 'zhCN' AND `entry` = 444;
-- OLD name : 卫兵队长帕克
-- Source : https://www.wowhead.com/wotlk/cn/npc=464
UPDATE `creature_template_locale` SET `Name` = '卫兵帕克' WHERE `locale` = 'zhCN' AND `entry` = 464;
-- OLD name : [UNUSED] Scribe Colburg (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=470
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 470;
-- OLD name : 流浪巫师
-- Source : https://www.wowhead.com/wotlk/cn/npc=474
UPDATE `creature_template_locale` SET `Name` = '迪菲亚流浪巫师' WHERE `locale` = 'zhCN' AND `entry` = 474;
-- OLD name : [UNUSED] Watcher Kleeman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=496
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 496;
-- OLD name : [UNUSED] Watcher Benjamin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=497
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 497;
-- OLD name : [UNUSED] Watcher Larsen (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=498
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 498;
-- OLD name : [UNUSED] Long Fang (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=509
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 509;
-- OLD name : [UNUSED] Riverpaw Hunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=516
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 516;
-- OLD name : [UNUSED] Savar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=535
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 535;
-- OLD name : [UNUSED] Rhal'Del (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=536
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 536;
-- OLD name : [UNUSED] Buk'Cha (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=538
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 538;
-- OLD subname : 兽栏管理员
-- Source : https://www.wowhead.com/wotlk/cn/npc=543
UPDATE `creature_template_locale` SET `Title` = '宠物训练师' WHERE `locale` = 'zhCN' AND `entry` = 543;
-- OLD name : 伏击者
-- Source : https://www.wowhead.com/wotlk/cn/npc=583
UPDATE `creature_template_locale` SET `Name` = '迪菲亚伏击者' WHERE `locale` = 'zhCN' AND `entry` = 583;
-- OLD name : [UNUSED] Watcher Kern (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=586
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 586;
-- OLD name : [UNUSED] Defias Arsonist (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=592
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 592;
-- OLD name : 魔理莎·杜派格
-- Source : https://www.wowhead.com/wotlk/cn/npc=599
UPDATE `creature_template_locale` SET `Name` = '玛里莎·杜派格' WHERE `locale` = 'zhCN' AND `entry` = 599;
-- OLD name : [UNUSED] Rabid Gina Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=610
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 610;
-- OLD subname : Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=693
UPDATE `creature_template_locale` SET `Title` = '训练师' WHERE `locale` = 'zhCN' AND `entry` = 693;
-- OLD name : 范高雷将军
-- Source : https://www.wowhead.com/wotlk/cn/npc=703
UPDATE `creature_template_locale` SET `Name` = '范高雷中尉' WHERE `locale` = 'zhCN' AND `entry` = 703;
-- OLD name : 霜鬃巨魔新兵
-- Source : https://www.wowhead.com/wotlk/cn/npc=706
UPDATE `creature_template_locale` SET `Name` = '霜鬃巨魔幼崽' WHERE `locale` = 'zhCN' AND `entry` = 706;
-- OLD name : 壮实的石腭穴居人
-- Source : https://www.wowhead.com/wotlk/cn/npc=724
UPDATE `creature_template_locale` SET `Name` = '壮实的石腭怪' WHERE `locale` = 'zhCN' AND `entry` = 724;
-- OLD name : 龙人长者
-- Source : https://www.wowhead.com/wotlk/cn/npc=746
UPDATE `creature_template_locale` SET `Name` = '刃鳞龙人长者' WHERE `locale` = 'zhCN' AND `entry` = 746;
-- OLD name : [UNUSED] Rebel Soldier (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=753
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 753;
-- OLD name : 反叛军哨兵
-- Source : https://www.wowhead.com/wotlk/cn/npc=754
UPDATE `creature_template_locale` SET `Name` = '叛军哨兵' WHERE `locale` = 'zhCN' AND `entry` = 754;
-- OLD subname : 弓箭商
-- Source : https://www.wowhead.com/wotlk/cn/npc=789
UPDATE `creature_template_locale` SET `Title` = '造箭师' WHERE `locale` = 'zhCN' AND `entry` = 789;
-- OLD name : 自由的飓风
-- Source : https://www.wowhead.com/wotlk/cn/npc=832
UPDATE `creature_template_locale` SET `Name` = '尘魔' WHERE `locale` = 'zhCN' AND `entry` = 832;
-- OLD name : Harl Cutter, subname : Woodcrafting Supplies
-- Source : https://www.wowhead.com/wotlk/cn/npc=841
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 841;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (841, 'zhCN','哈尔·卡特','木工物资供应商');
-- OLD name : 悲伤沼泽织网蛛
-- Source : https://www.wowhead.com/wotlk/cn/npc=858
UPDATE `creature_template_locale` SET `Name` = '沼泽纺丝蛛' WHERE `locale` = 'zhCN' AND `entry` = 858;
-- OLD name : [UNUSED] Lesser Arachnid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=924
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 924;
-- OLD name : 艾瑞克·都德斯三世
-- Source : https://www.wowhead.com/wotlk/cn/npc=996
UPDATE `creature_template_locale` SET `Name` = '高级裁缝' WHERE `locale` = 'zhCN' AND `entry` = 996;
-- OLD name : Unkillable Test Dummy, subname : NONE
-- Source : https://www.wowhead.com/wotlk/cn/npc=1000
UPDATE `creature_template_locale` SET `Name` = '守夜人布洛伯格',`Title` = '守夜人' WHERE `locale` = 'zhCN' AND `entry` = 1000;
-- OLD name : 野蛮的安纳希克, subname : 劈颅部族酋长
-- Source : https://www.wowhead.com/wotlk/cn/npc=1059
UPDATE `creature_template_locale` SET `Name` = '残忍的安纳希克',`Title` = '碎颅酋长' WHERE `locale` = 'zhCN' AND `entry` = 1059;
-- OLD subname : 劈颅部族巫医
-- Source : https://www.wowhead.com/wotlk/cn/npc=1060
UPDATE `creature_template_locale` SET `Title` = '碎颅部族巫医' WHERE `locale` = 'zhCN' AND `entry` = 1060;
-- OLD name : 翡翠龙
-- Source : https://www.wowhead.com/wotlk/cn/npc=1063
UPDATE `creature_template_locale` SET `Name` = '玉龙' WHERE `locale` = 'zhCN' AND `entry` = 1063;
-- OLD name : 坚毅者长须
-- Source : https://www.wowhead.com/wotlk/cn/npc=1071
UPDATE `creature_template_locale` SET `Name` = '布莱德·长须' WHERE `locale` = 'zhCN' AND `entry` = 1071;
-- OLD name : 锤脊
-- Source : https://www.wowhead.com/wotlk/cn/npc=1119
UPDATE `creature_template_locale` SET `Name` = '雪盲石腭怪' WHERE `locale` = 'zhCN' AND `entry` = 1119;
-- OLD name : 黑熊
-- Source : https://www.wowhead.com/wotlk/cn/npc=1186
UPDATE `creature_template_locale` SET `Name` = '老黑熊' WHERE `locale` = 'zhCN' AND `entry` = 1186;
-- OLD name : 老黑炭
-- Source : https://www.wowhead.com/wotlk/cn/npc=1225
UPDATE `creature_template_locale` SET `Name` = '奥尔苏迪' WHERE `locale` = 'zhCN' AND `entry` = 1225;
-- OLD subname : 弓箭商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=1298
UPDATE `creature_template_locale` SET `Title` = '弓箭商' WHERE `locale` = 'zhCN' AND `entry` = 1298;
-- OLD name : 劳伦斯·瑟尼德
-- Source : https://www.wowhead.com/wotlk/cn/npc=1300
UPDATE `creature_template_locale` SET `Name` = '劳伦斯·斯涅德' WHERE `locale` = 'zhCN' AND `entry` = 1300;
-- OLD name : 巡山人雷矛
-- Source : https://www.wowhead.com/wotlk/cn/npc=1343
UPDATE `creature_template_locale` SET `Name` = '巡山人卡尔·雷矛' WHERE `locale` = 'zhCN' AND `entry` = 1343;
-- OLD name : [UNUSED] Kern the Enforcer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=1361
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 1361;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=1382
UPDATE `creature_template_locale` SET `Title` = '高级厨师' WHERE `locale` = 'zhCN' AND `entry` = 1382;
-- OLD name : 卡布
-- Source : https://www.wowhead.com/wotlk/cn/npc=1425
UPDATE `creature_template_locale` SET `Name` = '格瑞兹拉克' WHERE `locale` = 'zhCN' AND `entry` = 1425;
-- OLD name : 雷玛·施涅德
-- Source : https://www.wowhead.com/wotlk/cn/npc=1428
UPDATE `creature_template_locale` SET `Name` = '雷玛·斯涅德' WHERE `locale` = 'zhCN' AND `entry` = 1428;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=1430
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 1430;
-- OLD subname : Fletching Supplies
-- Source : https://www.wowhead.com/wotlk/cn/npc=1455
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 1455;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (1455, 'zhCN',NULL,'造箭师');
-- OLD subname : 弓箭商
-- Source : https://www.wowhead.com/wotlk/cn/npc=1462
UPDATE `creature_template_locale` SET `Title` = '造箭师' WHERE `locale` = 'zhCN' AND `entry` = 1462;
-- OLD name : 切割者摩卡什
-- Source : https://www.wowhead.com/wotlk/cn/npc=1493
UPDATE `creature_template_locale` SET `Name` = '摩卡什' WHERE `locale` = 'zhCN' AND `entry` = 1493;
-- OLD name : 无脑的食尸鬼
-- Source : https://www.wowhead.com/wotlk/cn/npc=1502
UPDATE `creature_template_locale` SET `Name` = '丑陋的僵尸' WHERE `locale` = 'zhCN' AND `entry` = 1502;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=1518
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 1518;
-- OLD name : 送葬者摩尔多
-- Source : https://www.wowhead.com/wotlk/cn/npc=1568
UPDATE `creature_template_locale` SET `Name` = '管理员摩尔多' WHERE `locale` = 'zhCN' AND `entry` = 1568;
-- OLD name : Slim's Test Rogue
-- Source : https://www.wowhead.com/wotlk/cn/npc=1601
UPDATE `creature_template_locale` SET `Name` = 'Rogue 40' WHERE `locale` = 'zhCN' AND `entry` = 1601;
-- OLD name : [UNUSED] Elwynn Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=1643
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 1643;
-- OLD name : [UNUSED] Redridge Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=1644
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 1644;
-- OLD subname : Cook
-- Source : https://www.wowhead.com/wotlk/cn/npc=1677
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 1677;
-- OLD name : 囚徒
-- Source : https://www.wowhead.com/wotlk/cn/npc=1706
UPDATE `creature_template_locale` SET `Name` = '迪菲亚囚徒' WHERE `locale` = 'zhCN' AND `entry` = 1706;
-- OLD name : 罪犯
-- Source : https://www.wowhead.com/wotlk/cn/npc=1711
UPDATE `creature_template_locale` SET `Name` = '迪菲亚罪犯' WHERE `locale` = 'zhCN' AND `entry` = 1711;
-- OLD name : 叛军
-- Source : https://www.wowhead.com/wotlk/cn/npc=1715
UPDATE `creature_template_locale` SET `Name` = '迪菲亚叛军' WHERE `locale` = 'zhCN' AND `entry` = 1715;
-- OLD name : 亡灵卫兵莫里斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=1745
UPDATE `creature_template_locale` SET `Name` = '亡灵卫兵莫瑞斯' WHERE `locale` = 'zhCN' AND `entry` = 1745;
-- OLD name : 疯狂的座狼
-- Source : https://www.wowhead.com/wotlk/cn/npc=1766
UPDATE `creature_template_locale` SET `Name` = '杂斑座狼' WHERE `locale` = 'zhCN' AND `entry` = 1766;
-- OLD name : 掠网阔步蛛
-- Source : https://www.wowhead.com/wotlk/cn/npc=1780
UPDATE `creature_template_locale` SET `Name` = '苔藓阔步者' WHERE `locale` = 'zhCN' AND `entry` = 1780;
-- OLD name : 掠网潜伏者
-- Source : https://www.wowhead.com/wotlk/cn/npc=1781
UPDATE `creature_template_locale` SET `Name` = '迷雾爬行者' WHERE `locale` = 'zhCN' AND `entry` = 1781;
-- OLD name : 疯狂的巨熊
-- Source : https://www.wowhead.com/wotlk/cn/npc=1797
UPDATE `creature_template_locale` SET `Name` = '巨型灰斑熊' WHERE `locale` = 'zhCN' AND `entry` = 1797;
-- OLD name : 天灾秃鹫
-- Source : https://www.wowhead.com/wotlk/cn/npc=1811
UPDATE `creature_template_locale` SET `Name` = '瘟疫秃鹫' WHERE `locale` = 'zhCN' AND `entry` = 1811;
-- OLD name : 天灾潜伏者
-- Source : https://www.wowhead.com/wotlk/cn/npc=1824
UPDATE `creature_template_locale` SET `Name` = '瘟疫潜伏者' WHERE `locale` = 'zhCN' AND `entry` = 1824;
-- OLD name : 安伯米尔卫士
-- Source : https://www.wowhead.com/wotlk/cn/npc=1888
UPDATE `creature_template_locale` SET `Name` = '达拉然卫士' WHERE `locale` = 'zhCN' AND `entry` = 1888;
-- OLD name : 安伯米尔巫师
-- Source : https://www.wowhead.com/wotlk/cn/npc=1889
UPDATE `creature_template_locale` SET `Name` = '达拉然巫师' WHERE `locale` = 'zhCN' AND `entry` = 1889;
-- OLD name : 安伯米尔保卫者
-- Source : https://www.wowhead.com/wotlk/cn/npc=1912
UPDATE `creature_template_locale` SET `Name` = '达拉然保卫者' WHERE `locale` = 'zhCN' AND `entry` = 1912;
-- OLD name : 安伯米尔守卫
-- Source : https://www.wowhead.com/wotlk/cn/npc=1913
UPDATE `creature_template_locale` SET `Name` = '达拉然守卫' WHERE `locale` = 'zhCN' AND `entry` = 1913;
-- OLD name : 安伯米尔魔导师
-- Source : https://www.wowhead.com/wotlk/cn/npc=1914
UPDATE `creature_template_locale` SET `Name` = '达拉然法师' WHERE `locale` = 'zhCN' AND `entry` = 1914;
-- OLD name : 安伯米尔咒术师
-- Source : https://www.wowhead.com/wotlk/cn/npc=1915
UPDATE `creature_template_locale` SET `Name` = '达拉然咒术师' WHERE `locale` = 'zhCN' AND `entry` = 1915;
-- OLD name : 安伯米尔书记员
-- Source : https://www.wowhead.com/wotlk/cn/npc=1920
UPDATE `creature_template_locale` SET `Name` = '达拉然书记员' WHERE `locale` = 'zhCN' AND `entry` = 1920;
-- OLD subname : Immune to Fire
-- Source : https://www.wowhead.com/wotlk/cn/npc=1925
UPDATE `creature_template_locale` SET `Title` = '对火焰免疫' WHERE `locale` = 'zhCN' AND `entry` = 1925;
-- OLD subname : Immune to Frost
-- Source : https://www.wowhead.com/wotlk/cn/npc=1926
UPDATE `creature_template_locale` SET `Title` = '对冰霜免疫' WHERE `locale` = 'zhCN' AND `entry` = 1926;
-- OLD subname : Immune to Holy
-- Source : https://www.wowhead.com/wotlk/cn/npc=1927
UPDATE `creature_template_locale` SET `Title` = '对神圣免疫' WHERE `locale` = 'zhCN' AND `entry` = 1927;
-- OLD subname : Immune to Shadow
-- Source : https://www.wowhead.com/wotlk/cn/npc=1928
UPDATE `creature_template_locale` SET `Title` = '对暗影免疫' WHERE `locale` = 'zhCN' AND `entry` = 1928;
-- OLD subname : Immune to Nature
-- Source : https://www.wowhead.com/wotlk/cn/npc=1929
UPDATE `creature_template_locale` SET `Title` = '对自然免疫' WHERE `locale` = 'zhCN' AND `entry` = 1929;
-- OLD subname : Immune to Physical
-- Source : https://www.wowhead.com/wotlk/cn/npc=1930
UPDATE `creature_template_locale` SET `Title` = '对物理免疫' WHERE `locale` = 'zhCN' AND `entry` = 1930;
-- OLD name : 被俘虏的血色狂热者
-- Source : https://www.wowhead.com/wotlk/cn/npc=1931
UPDATE `creature_template_locale` SET `Name` = '血色十字军俘虏' WHERE `locale` = 'zhCN' AND `entry` = 1931;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=1937
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 1937;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=2055
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 2055;
-- OLD name : 伊尔萨莱恩
-- Source : https://www.wowhead.com/wotlk/cn/npc=2079
UPDATE `creature_template_locale` SET `Name` = '管理员伊尔萨莱恩' WHERE `locale` = 'zhCN' AND `entry` = 2079;
-- OLD name : 被诅咒的上层精灵
-- Source : https://www.wowhead.com/wotlk/cn/npc=2176
UPDATE `creature_template_locale` SET `Name` = '被诅咒的贵族' WHERE `locale` = 'zhCN' AND `entry` = 2176;
-- OLD name : 痛苦的上层精灵
-- Source : https://www.wowhead.com/wotlk/cn/npc=2177
UPDATE `creature_template_locale` SET `Name` = '挣扎的贵族' WHERE `locale` = 'zhCN' AND `entry` = 2177;
-- OLD name : 哀嚎的上层精灵鬼魂
-- Source : https://www.wowhead.com/wotlk/cn/npc=2178
UPDATE `creature_template_locale` SET `Name` = '哀嚎的贵族' WHERE `locale` = 'zhCN' AND `entry` = 2178;
-- OLD name : [UNUSED] Crier Kirton (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=2197
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2197;
-- OLD name : [UNUSED] Crier Backus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=2199
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2199;
-- OLD name : [UNUSED] Crier Pierce (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=2200
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2200;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=2216
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 2216;
-- OLD subname : Blacksmith Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=2220
UPDATE `creature_template_locale` SET `Title` = '锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 2220;
-- OLD subname : Cooking Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=2223
UPDATE `creature_template_locale` SET `Title` = '烹饪训练师' WHERE `locale` = 'zhCN' AND `entry` = 2223;
-- OLD name : 玛格拉克
-- Source : https://www.wowhead.com/wotlk/cn/npc=2258
UPDATE `creature_template_locale` SET `Name` = '狂怒的石元素' WHERE `locale` = 'zhCN' AND `entry` = 2258;
-- OLD name : 辛迪加盗贼
-- Source : https://www.wowhead.com/wotlk/cn/npc=2260
UPDATE `creature_template_locale` SET `Name` = '辛迪加潜行者' WHERE `locale` = 'zhCN' AND `entry` = 2260;
-- OLD name : 琳妮·羽歌
-- Source : https://www.wowhead.com/wotlk/cn/npc=2303
UPDATE `creature_template_locale` SET `Name` = '琳妮·梅' WHERE `locale` = 'zhCN' AND `entry` = 2303;
-- OLD name : [UNUSED] Kir'Nazz (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=2313
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2313;
-- OLD subname : 急救训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=2326
UPDATE `creature_template_locale` SET `Title` = '医师' WHERE `locale` = 'zhCN' AND `entry` = 2326;
-- OLD subname : 急救训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=2329
UPDATE `creature_template_locale` SET `Title` = '医师' WHERE `locale` = 'zhCN' AND `entry` = 2329;
-- OLD name : 被驯养的食苔蛛
-- Source : https://www.wowhead.com/wotlk/cn/npc=2349
UPDATE `creature_template_locale` SET `Name` = '巨型食苔蛛' WHERE `locale` = 'zhCN' AND `entry` = 2349;
-- OLD name : 森林爬行者
-- Source : https://www.wowhead.com/wotlk/cn/npc=2350
UPDATE `creature_template_locale` SET `Name` = '森林食苔蛛' WHERE `locale` = 'zhCN' AND `entry` = 2350;
-- OLD name : 凋零灰熊
-- Source : https://www.wowhead.com/wotlk/cn/npc=2351
UPDATE `creature_template_locale` SET `Name` = '灰熊' WHERE `locale` = 'zhCN' AND `entry` = 2351;
-- OLD name : 丘陵猎手
-- Source : https://www.wowhead.com/wotlk/cn/npc=2385
UPDATE `creature_template_locale` SET `Name` = '野生山地狮' WHERE `locale` = 'zhCN' AND `entry` = 2385;
-- OLD name : 联盟卫兵
-- Source : https://www.wowhead.com/wotlk/cn/npc=2386
UPDATE `creature_template_locale` SET `Name` = '南海镇卫兵' WHERE `locale` = 'zhCN' AND `entry` = 2386;
-- OLD name : 格什哈尔迪
-- Source : https://www.wowhead.com/wotlk/cn/npc=2476
UPDATE `creature_template_locale` SET `Name` = '大型洛克鳄' WHERE `locale` = 'zhCN' AND `entry` = 2476;
-- OLD name : 舰队指挥官卡拉·海角
-- Source : https://www.wowhead.com/wotlk/cn/npc=2487
UPDATE `creature_template_locale` SET `Name` = '舰队指挥官海角' WHERE `locale` = 'zhCN' AND `entry` = 2487;
-- OLD name : “海狼”马克基雷
-- Source : https://www.wowhead.com/wotlk/cn/npc=2501
UPDATE `creature_template_locale` SET `Name` = '"海狼"马克基雷' WHERE `locale` = 'zhCN' AND `entry` = 2501;
-- OLD name : “病鬼”菲利普
-- Source : https://www.wowhead.com/wotlk/cn/npc=2502
UPDATE `creature_template_locale` SET `Name` = '"病鬼"菲利普' WHERE `locale` = 'zhCN' AND `entry` = 2502;
-- OLD subname : 赞吉尔的使节
-- Source : https://www.wowhead.com/wotlk/cn/npc=2530
UPDATE `creature_template_locale` SET `Title` = '暗矛部族人质' WHERE `locale` = 'zhCN' AND `entry` = 2530;
-- OLD name : 杜内的爪牙
-- Source : https://www.wowhead.com/wotlk/cn/npc=2531
UPDATE `creature_template_locale` SET `Name` = '莫甘斯的爪牙' WHERE `locale` = 'zhCN' AND `entry` = 2531;
-- OLD name : “畸形足”玛雷·维尔金斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=2535
UPDATE `creature_template_locale` SET `Name` = '"畸形足"玛雷·维尔金斯' WHERE `locale` = 'zhCN' AND `entry` = 2535;
-- OLD name : 安伯米尔毒蛇
-- Source : https://www.wowhead.com/wotlk/cn/npc=2540
UPDATE `creature_template_locale` SET `Name` = '达拉然毒蛇' WHERE `locale` = 'zhCN' AND `entry` = 2540;
-- OLD name : 激流堡士兵
-- Source : https://www.wowhead.com/wotlk/cn/npc=2585
UPDATE `creature_template_locale` SET `Name` = '激流堡仲裁者' WHERE `locale` = 'zhCN' AND `entry` = 2585;
-- OLD subname : Shadow Council Warlock
-- Source : https://www.wowhead.com/wotlk/cn/npc=2598
UPDATE `creature_template_locale` SET `Title` = '暗影议会术士' WHERE `locale` = 'zhCN' AND `entry` = 2598;
-- OLD name : [UNUSED] Archmage Detrae (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=2617
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2617;
-- OLD name : Port Master Szik, subname : Boat Vendor
-- Source : https://www.wowhead.com/wotlk/cn/npc=2662
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2662;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2662, 'zhCN','码头管理员斯奇克','船商');
-- OLD name : 弗拉德·飞轮
-- Source : https://www.wowhead.com/wotlk/cn/npc=2682
UPDATE `creature_template_locale` SET `Name` = '弗拉德' WHERE `locale` = 'zhCN' AND `entry` = 2682;
-- OLD subname : 远古巨石卫士
-- Source : https://www.wowhead.com/wotlk/cn/npc=2748
UPDATE `creature_template_locale` SET `Title` = '远古石卫士' WHERE `locale` = 'zhCN' AND `entry` = 2748;
-- OLD name : 路障
-- Source : https://www.wowhead.com/wotlk/cn/npc=2749
UPDATE `creature_template_locale` SET `Name` = '攻城傀儡' WHERE `locale` = 'zhCN' AND `entry` = 2749;
-- OLD name : 麦格尼·铜须国王, subname : 铁炉堡之王
-- Source : https://www.wowhead.com/wotlk/cn/npc=2784
UPDATE `creature_template_locale` SET `Name` = '国王麦格尼·铜须',`Title` = '铁炉堡国王' WHERE `locale` = 'zhCN' AND `entry` = 2784;
-- OLD name : “巧手”雷尼·麦考伊
-- Source : https://www.wowhead.com/wotlk/cn/npc=2795
UPDATE `creature_template_locale` SET `Name` = '"巧手"雷尼·麦考伊' WHERE `locale` = 'zhCN' AND `entry` = 2795;
-- OLD subname : 杂货供应商
-- Source : https://www.wowhead.com/wotlk/cn/npc=2808
UPDATE `creature_template_locale` SET `Title` = '杂货商' WHERE `locale` = 'zhCN' AND `entry` = 2808;
-- OLD name : 口渴的兀鹫
-- Source : https://www.wowhead.com/wotlk/cn/npc=2830
UPDATE `creature_template_locale` SET `Name` = '秃鹫' WHERE `locale` = 'zhCN' AND `entry` = 2830;
-- OLD name : [PH] Tallstrider Trainer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=2871
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2871;
-- OLD name : [PH] Raptor Trainer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=2873
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2873;
-- OLD name : [PH] Horse Trainer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=2874
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2874;
-- OLD name : [PH] Gorilla Trainer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=2875
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2875;
-- OLD subname : Crocilisk Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=2876
UPDATE `creature_template_locale` SET `Title` = '鳄鱼训练师' WHERE `locale` = 'zhCN' AND `entry` = 2876;
-- OLD name : [PH] Crawler Trainer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=2877
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2877;
-- OLD subname : Ranged Skills Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=2886
UPDATE `creature_template_locale` SET `Title` = '远程武器训练师' WHERE `locale` = 'zhCN' AND `entry` = 2886;
-- OLD name : 首席考古学家杜瑟·灰胡
-- Source : https://www.wowhead.com/wotlk/cn/npc=2912
UPDATE `creature_template_locale` SET `Name` = '首席考古学家杜瑟·灰须' WHERE `locale` = 'zhCN' AND `entry` = 2912;
-- OLD name : 勘察员雷塔维
-- Source : https://www.wowhead.com/wotlk/cn/npc=2917
UPDATE `creature_template_locale` SET `Name` = '勘察员雷姆塔维尔' WHERE `locale` = 'zhCN' AND `entry` = 2917;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/cn/npc=2935
UPDATE `creature_template_locale` SET `Title` = '恶魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 2935;
-- OLD subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=2938
UPDATE `creature_template_locale` SET `Title` = '野熊训练师' WHERE `locale` = 'zhCN' AND `entry` = 2938;
-- OLD name : Jackson Bayne, subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=2939
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 2939;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2939, 'zhCN','杰克逊·贝恩','野猪训练师');
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=2942
UPDATE `creature_template_locale` SET `Title` = '狼训练师' WHERE `locale` = 'zhCN' AND `entry` = 2942;
-- OLD name : 刺背入侵者
-- Source : https://www.wowhead.com/wotlk/cn/npc=2952
UPDATE `creature_template_locale` SET `Name` = '刺背野猪人' WHERE `locale` = 'zhCN' AND `entry` = 2952;
-- OLD name : 年幼的斗猪
-- Source : https://www.wowhead.com/wotlk/cn/npc=2966
UPDATE `creature_template_locale` SET `Name` = '斗猪' WHERE `locale` = 'zhCN' AND `entry` = 2966;
-- OLD subname : 裁缝供应商
-- Source : https://www.wowhead.com/wotlk/cn/npc=3005
UPDATE `creature_template_locale` SET `Title` = '制皮和裁缝供应商' WHERE `locale` = 'zhCN' AND `entry` = 3005;
-- OLD subname : 制皮供应商
-- Source : https://www.wowhead.com/wotlk/cn/npc=3008
UPDATE `creature_template_locale` SET `Title` = '初级制皮师' WHERE `locale` = 'zhCN' AND `entry` = 3008;
-- OLD name : 泰戈·晨行者
-- Source : https://www.wowhead.com/wotlk/cn/npc=3011
UPDATE `creature_template_locale` SET `Name` = '泰戈·黎明行者' WHERE `locale` = 'zhCN' AND `entry` = 3011;
-- OLD name : 霍高尔·雷蹄
-- Source : https://www.wowhead.com/wotlk/cn/npc=3018
UPDATE `creature_template_locale` SET `Name` = '霍高尔·雷角' WHERE `locale` = 'zhCN' AND `entry` = 3018;
-- OLD name : 德尔贡·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=3019
UPDATE `creature_template_locale` SET `Name` = '德尔贡·狂暴图腾' WHERE `locale` = 'zhCN' AND `entry` = 3019;
-- OLD name : 伊图·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=3020
UPDATE `creature_template_locale` SET `Name` = '伊图·狂暴图腾' WHERE `locale` = 'zhCN' AND `entry` = 3020;
-- OLD name : 卡德·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=3021
UPDATE `creature_template_locale` SET `Name` = '卡德·狂暴图腾' WHERE `locale` = 'zhCN' AND `entry` = 3021;
-- OLD name : 苏恩·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=3022
UPDATE `creature_template_locale` SET `Name` = '苏恩·狂暴图腾' WHERE `locale` = 'zhCN' AND `entry` = 3022;
-- OLD name : 托姆·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=3041
UPDATE `creature_template_locale` SET `Name` = '托姆·狂暴图腾' WHERE `locale` = 'zhCN' AND `entry` = 3041;
-- OLD name : 萨尔克·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=3042
UPDATE `creature_template_locale` SET `Name` = '萨尔克·狂暴图腾' WHERE `locale` = 'zhCN' AND `entry` = 3042;
-- OLD name : 科尔·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=3043
UPDATE `creature_template_locale` SET `Name` = '科尔·狂暴图腾' WHERE `locale` = 'zhCN' AND `entry` = 3043;
-- OLD name : 扎尔曼·双月
-- Source : https://www.wowhead.com/wotlk/cn/npc=3054
UPDATE `creature_template_locale` SET `Name` = '扎尔曼-双月' WHERE `locale` = 'zhCN' AND `entry` = 3054;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=3067
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 3067;
-- OLD subname : 中级炼金师
-- Source : https://www.wowhead.com/wotlk/cn/npc=3070
UPDATE `creature_template_locale` SET `Title` = '炼金师' WHERE `locale` = 'zhCN' AND `entry` = 3070;
-- OLD subname : 草药学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=3071
UPDATE `creature_template_locale` SET `Title` = '采药人' WHERE `locale` = 'zhCN' AND `entry` = 3071;
-- OLD name : 海浪蟹
-- Source : https://www.wowhead.com/wotlk/cn/npc=3106
UPDATE `creature_template_locale` SET `Name` = '小海浪蟹' WHERE `locale` = 'zhCN' AND `entry` = 3106;
-- OLD name : 成熟海浪蟹
-- Source : https://www.wowhead.com/wotlk/cn/npc=3107
UPDATE `creature_template_locale` SET `Name` = '海浪蟹' WHERE `locale` = 'zhCN' AND `entry` = 3107;
-- OLD subname : 舵手 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=3151
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 3151;
-- OLD subname : 舵手
-- Source : https://www.wowhead.com/wotlk/cn/npc=3152
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 3152;
-- OLD name : Scott Mercer
-- Source : https://www.wowhead.com/wotlk/cn/npc=3201
UPDATE `creature_template_locale` SET `Name` = 'SM Test Mob' WHERE `locale` = 'zhCN' AND `entry` = 3201;
-- OLD name : 费滋尔·黑爪
-- Source : https://www.wowhead.com/wotlk/cn/npc=3203
UPDATE `creature_template_locale` SET `Name` = '费索·暗雷' WHERE `locale` = 'zhCN' AND `entry` = 3203;
-- OLD name : 尖叫者刺鬃
-- Source : https://www.wowhead.com/wotlk/cn/npc=3229
UPDATE `creature_template_locale` SET `Name` = '尖叫者索恩曼图' WHERE `locale` = 'zhCN' AND `entry` = 3229;
-- OLD name : 钢鬃掠夺者
-- Source : https://www.wowhead.com/wotlk/cn/npc=3267
UPDATE `creature_template_locale` SET `Name` = '钢鬃寻水者' WHERE `locale` = 'zhCN' AND `entry` = 3267;
-- OLD name : 淤泥畸体
-- Source : https://www.wowhead.com/wotlk/cn/npc=3295
UPDATE `creature_template_locale` SET `Name` = '淤泥兽' WHERE `locale` = 'zhCN' AND `entry` = 3295;
-- OLD subname : 布甲商
-- Source : https://www.wowhead.com/wotlk/cn/npc=3317
UPDATE `creature_template_locale` SET `Title` = '轻甲商' WHERE `locale` = 'zhCN' AND `entry` = 3317;
-- OLD subname : 弓箭和枪械商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=3322
UPDATE `creature_template_locale` SET `Title` = '枪械和弹药商' WHERE `locale` = 'zhCN' AND `entry` = 3322;
-- OLD subname : 材料与毒药
-- Source : https://www.wowhead.com/wotlk/cn/npc=3405
UPDATE `creature_template_locale` SET `Title` = '草药学供应商' WHERE `locale` = 'zhCN' AND `entry` = 3405;
-- OLD name : 双辫将军
-- Source : https://www.wowhead.com/wotlk/cn/npc=3414
UPDATE `creature_template_locale` SET `Name` = '塔文布莱德将军' WHERE `locale` = 'zhCN' AND `entry` = 3414;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=3419
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 3419;
-- OLD subname : 独立承包人
-- Source : https://www.wowhead.com/wotlk/cn/npc=3442
UPDATE `creature_template_locale` SET `Title` = '工匠协会' WHERE `locale` = 'zhCN' AND `entry` = 3442;
-- OLD name : 老艾玛
-- Source : https://www.wowhead.com/wotlk/cn/npc=3520
UPDATE `creature_template_locale` SET `Name` = '艾玛' WHERE `locale` = 'zhCN' AND `entry` = 3520;
-- OLD name : 安伯米尔酿酒师
-- Source : https://www.wowhead.com/wotlk/cn/npc=3577
UPDATE `creature_template_locale` SET `Name` = '达拉然酿酒师' WHERE `locale` = 'zhCN' AND `entry` = 3577;
-- OLD name : 安伯米尔矿工
-- Source : https://www.wowhead.com/wotlk/cn/npc=3578
UPDATE `creature_template_locale` SET `Name` = '达拉然矿工' WHERE `locale` = 'zhCN' AND `entry` = 3578;
-- OLD name : [UNUSED] Kolkar Observer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=3651
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 3651;
-- OLD name : 安娜雅·晨行者
-- Source : https://www.wowhead.com/wotlk/cn/npc=3667
UPDATE `creature_template_locale` SET `Name` = '安娜雅·晨路' WHERE `locale` = 'zhCN' AND `entry` = 3667;
-- OLD name : 被折磨的上层精灵的灵魂
-- Source : https://www.wowhead.com/wotlk/cn/npc=3668
UPDATE `creature_template_locale` SET `Name` = '被折磨的贵族精灵的灵魂' WHERE `locale` = 'zhCN' AND `entry` = 3668;
-- OLD name : 穆约
-- Source : https://www.wowhead.com/wotlk/cn/npc=3678
UPDATE `creature_template_locale` SET `Name` = '纳拉雷克斯的信徒' WHERE `locale` = 'zhCN' AND `entry` = 3678;
-- OLD name : Kyln Longclaw, subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=3697
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 3697;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (3697, 'zhCN','凯林·长爪','野猪训练师');
-- OLD subname : Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=3698
UPDATE `creature_template_locale` SET `Title` = '宠物训练师' WHERE `locale` = 'zhCN' AND `entry` = 3698;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=3699
UPDATE `creature_template_locale` SET `Title` = '豹训练师' WHERE `locale` = 'zhCN' AND `entry` = 3699;
-- OLD name : 兽人监工
-- Source : https://www.wowhead.com/wotlk/cn/npc=3734
UPDATE `creature_template_locale` SET `Name` = '亡灵暴徒' WHERE `locale` = 'zhCN' AND `entry` = 3734;
-- OLD name : 萨维亚盗贼
-- Source : https://www.wowhead.com/wotlk/cn/npc=3752
UPDATE `creature_template_locale` SET `Name` = '萨维亚潜行者' WHERE `locale` = 'zhCN' AND `entry` = 3752;
-- OLD name : 魔草盗贼
-- Source : https://www.wowhead.com/wotlk/cn/npc=3759
UPDATE `creature_template_locale` SET `Name` = '魔草潜行者' WHERE `locale` = 'zhCN' AND `entry` = 3759;
-- OLD name : 被烧焦的沼泽兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=3780
UPDATE `creature_template_locale` SET `Name` = '食苔沼泽兽' WHERE `locale` = 'zhCN' AND `entry` = 3780;
-- OLD name : 特尔迪娜·月羽
-- Source : https://www.wowhead.com/wotlk/cn/npc=3841
UPDATE `creature_template_locale` SET `Name` = '凯莱斯·月羽' WHERE `locale` = 'zhCN' AND `entry` = 3841;
-- OLD name : 痛苦的军官
-- Source : https://www.wowhead.com/wotlk/cn/npc=3873
UPDATE `creature_template_locale` SET `Name` = '痛苦的文官' WHERE `locale` = 'zhCN' AND `entry` = 3873;
-- OLD name : 珍奈·羽风
-- Source : https://www.wowhead.com/wotlk/cn/npc=3957
UPDATE `creature_template_locale` SET `Name` = '詹奈·轻羽微风' WHERE `locale` = 'zhCN' AND `entry` = 3957;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=3966
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 3966;
-- OLD subname : 毒药商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=3969
UPDATE `creature_template_locale` SET `Title` = '工具和补给品' WHERE `locale` = 'zhCN' AND `entry` = 3969;
-- OLD name : 风险投资公司顽徒
-- Source : https://www.wowhead.com/wotlk/cn/npc=3992
UPDATE `creature_template_locale` SET `Name` = '风险投资公司工程师' WHERE `locale` = 'zhCN' AND `entry` = 3992;
-- OLD name : 堕落的腐蚀兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=4021
UPDATE `creature_template_locale` SET `Name` = '腐蚀性的腐蚀兽' WHERE `locale` = 'zhCN' AND `entry` = 4021;
-- OLD name : JEFF CHOW TEST
-- Source : https://www.wowhead.com/wotlk/cn/npc=4045
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhCN' AND `entry` = 4045;
-- OLD name : 玛加萨·恐怖图腾, subname : 巫婆长老
-- Source : https://www.wowhead.com/wotlk/cn/npc=4046
UPDATE `creature_template_locale` SET `Name` = '玛加萨·野性图腾',`Title` = '长者' WHERE `locale` = 'zhCN' AND `entry` = 4046;
-- OLD name : 尖啸的鹰身人
-- Source : https://www.wowhead.com/wotlk/cn/npc=4100
UPDATE `creature_template_locale` SET `Name` = '尖啸鹰身人' WHERE `locale` = 'zhCN' AND `entry` = 4100;
-- OLD name : 尖啸的游荡者
-- Source : https://www.wowhead.com/wotlk/cn/npc=4101
UPDATE `creature_template_locale` SET `Name` = '尖啸游荡者' WHERE `locale` = 'zhCN' AND `entry` = 4101;
-- OLD name : 克尔克斯克
-- Source : https://www.wowhead.com/wotlk/cn/npc=4132
UPDATE `creature_template_locale` SET `Name` = '异种破坏者' WHERE `locale` = 'zhCN' AND `entry` = 4132;
-- OLD subname : Foraging Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=4149
UPDATE `creature_template_locale` SET `Title` = '食物搜寻训练师' WHERE `locale` = 'zhCN' AND `entry` = 4149;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=4153
UPDATE `creature_template_locale` SET `Title` = '豹训练师' WHERE `locale` = 'zhCN' AND `entry` = 4153;
-- OLD name : zzOLDKitari Farseeker, subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=4157
UPDATE `creature_template_locale` SET `Name` = '基塔利',`Title` = '制图训练师' WHERE `locale` = 'zhCN' AND `entry` = 4157;
-- OLD name : 埃莉萨·杜马斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=4165
UPDATE `creature_template_locale` SET `Name` = '埃莉萨' WHERE `locale` = 'zhCN' AND `entry` = 4165;
-- OLD name : Siannai, subname : Arrow Merchant
-- Source : https://www.wowhead.com/wotlk/cn/npc=4174
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 4174;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4174, 'zhCN','希亚奈恩','弓箭商');
-- OLD name : 莎尔蒂
-- Source : https://www.wowhead.com/wotlk/cn/npc=4185
UPDATE `creature_template_locale` SET `Name` = '沙尔迪恩' WHERE `locale` = 'zhCN' AND `entry` = 4185;
-- OLD name : 玛芙琳
-- Source : https://www.wowhead.com/wotlk/cn/npc=4186
UPDATE `creature_template_locale` SET `Name` = '马弗拉林' WHERE `locale` = 'zhCN' AND `entry` = 4186;
-- OLD subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=4206
UPDATE `creature_template_locale` SET `Title` = '野熊训练师' WHERE `locale` = 'zhCN' AND `entry` = 4206;
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=4207
UPDATE `creature_template_locale` SET `Title` = '狼训练师' WHERE `locale` = 'zhCN' AND `entry` = 4207;
-- OLD name : Talegon, subname : Cartography Supplies
-- Source : https://www.wowhead.com/wotlk/cn/npc=4224
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 4224;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4224, 'zhCN','塔雷贡','制图供应商');
-- OLD name : 灰狼
-- Source : https://www.wowhead.com/wotlk/cn/npc=4268
UPDATE `creature_template_locale` SET `Name` = '骑乘用狼（灰色）' WHERE `locale` = 'zhCN' AND `entry` = 4268;
-- OLD name : 栗色马
-- Source : https://www.wowhead.com/wotlk/cn/npc=4269
UPDATE `creature_template_locale` SET `Name` = '骑乘用马（栗色）' WHERE `locale` = 'zhCN' AND `entry` = 4269;
-- OLD name : 赤狼
-- Source : https://www.wowhead.com/wotlk/cn/npc=4270
UPDATE `creature_template_locale` SET `Name` = '骑乘用狼（红色）' WHERE `locale` = 'zhCN' AND `entry` = 4270;
-- OLD name : 恐狼
-- Source : https://www.wowhead.com/wotlk/cn/npc=4271
UPDATE `creature_template_locale` SET `Name` = '骑乘用狼（暗灰色）' WHERE `locale` = 'zhCN' AND `entry` = 4271;
-- OLD name : 棕狼
-- Source : https://www.wowhead.com/wotlk/cn/npc=4272
UPDATE `creature_template_locale` SET `Name` = '骑乘用狼（暗棕色）' WHERE `locale` = 'zhCN' AND `entry` = 4272;
-- OLD name : 高尔姆·恐怖图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=4309
UPDATE `creature_template_locale` SET `Name` = '高尔姆·野性图腾' WHERE `locale` = 'zhCN' AND `entry` = 4309;
-- OLD name : 考尔·恐怖图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=4310
UPDATE `creature_template_locale` SET `Name` = '考尔·野性图腾' WHERE `locale` = 'zhCN' AND `entry` = 4310;
-- OLD name : [UNUSED] [PH] Ambassador Saylaton Gravehoof (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=4313
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 4313;
-- OLD name : Wazza, subname : Totem Merchent
-- Source : https://www.wowhead.com/wotlk/cn/npc=4443
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 4443;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4443, 'zhCN','瓦萨','图腾商人');
-- OLD name : 黑腮寒冰召唤者
-- Source : https://www.wowhead.com/wotlk/cn/npc=4460
UPDATE `creature_template_locale` SET `Name` = '黑腮首领' WHERE `locale` = 'zhCN' AND `entry` = 4460;
-- OLD name : 莫雷·贝茨
-- Source : https://www.wowhead.com/wotlk/cn/npc=4571
UPDATE `creature_template_locale` SET `Name` = '莫雷·巴特斯' WHERE `locale` = 'zhCN' AND `entry` = 4571;
-- OLD subname : 裁缝训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=4578
UPDATE `creature_template_locale` SET `Title` = '大师级暗纹裁缝' WHERE `locale` = 'zhCN' AND `entry` = 4578;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=4579
UPDATE `creature_template_locale` SET `Title` = '制图训练师' WHERE `locale` = 'zhCN' AND `entry` = 4579;
-- OLD subname : Raptor Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=4621
UPDATE `creature_template_locale` SET `Title` = '迅猛龙训练师' WHERE `locale` = 'zhCN' AND `entry` = 4621;
-- OLD name : 怨怒盗贼
-- Source : https://www.wowhead.com/wotlk/cn/npc=4670
UPDATE `creature_template_locale` SET `Name` = '怨怒潜行者' WHERE `locale` = 'zhCN' AND `entry` = 4670;
-- OLD name : 拉乌·峭壁信使
-- Source : https://www.wowhead.com/wotlk/cn/npc=4722
UPDATE `creature_template_locale` SET `Name` = '劳恩·峭壁行者' WHERE `locale` = 'zhCN' AND `entry` = 4722;
-- OLD name : 霜山羊
-- Source : https://www.wowhead.com/wotlk/cn/npc=4778
UPDATE `creature_template_locale` SET `Name` = '骑乘用山羊（蓝色）' WHERE `locale` = 'zhCN' AND `entry` = 4778;
-- OLD name : 黑山羊
-- Source : https://www.wowhead.com/wotlk/cn/npc=4780
UPDATE `creature_template_locale` SET `Name` = '骑乘用山羊（黑色）' WHERE `locale` = 'zhCN' AND `entry` = 4780;
-- OLD name : 斥候塞尔瑞德, subname : The Argent Dawn
-- Source : https://www.wowhead.com/wotlk/cn/npc=4787
UPDATE `creature_template_locale` SET `Name` = '银月守卫塞尔瑞德',`Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 4787;
-- OLD name : “沼泽之眼”加尔
-- Source : https://www.wowhead.com/wotlk/cn/npc=4792
UPDATE `creature_template_locale` SET `Name` = '"沼泽之眼"加尔' WHERE `locale` = 'zhCN' AND `entry` = 4792;
-- OLD name : 暮光领主克尔里斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=4832
UPDATE `creature_template_locale` SET `Name` = '梦游者克尔里斯' WHERE `locale` = 'zhCN' AND `entry` = 4832;
-- OLD subname : Turtle Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=4881
UPDATE `creature_template_locale` SET `Title` = '海龟训练师' WHERE `locale` = 'zhCN' AND `entry` = 4881;
-- OLD subname : 护甲和武器供应商
-- Source : https://www.wowhead.com/wotlk/cn/npc=4886
UPDATE `creature_template_locale` SET `Title` = '护甲和盾牌供应商' WHERE `locale` = 'zhCN' AND `entry` = 4886;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=4888
UPDATE `creature_template_locale` SET `Title` = '武器锻造师' WHERE `locale` = 'zhCN' AND `entry` = 4888;
-- OLD subname : 猎人训练师兼弓箭商
-- Source : https://www.wowhead.com/wotlk/cn/npc=4892
UPDATE `creature_template_locale` SET `Title` = '弓箭商' WHERE `locale` = 'zhCN' AND `entry` = 4892;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=4894
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 4894;
-- OLD subname : 杂货和材料商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=4896
UPDATE `creature_template_locale` SET `Title` = '杂货商' WHERE `locale` = 'zhCN' AND `entry` = 4896;
-- OLD name : 塞拉摩训练假人
-- Source : https://www.wowhead.com/wotlk/cn/npc=4952
UPDATE `creature_template_locale` SET `Name` = '塞拉摩训练假人 1' WHERE `locale` = 'zhCN' AND `entry` = 4952;
-- OLD name : 水蛇
-- Source : https://www.wowhead.com/wotlk/cn/npc=4953
UPDATE `creature_template_locale` SET `Name` = '噬鱼蛇' WHERE `locale` = 'zhCN' AND `entry` = 4953;
-- OLD name : 塞拉摩训练假人
-- Source : https://www.wowhead.com/wotlk/cn/npc=4957
UPDATE `creature_template_locale` SET `Name` = '塞拉摩训练假人 4' WHERE `locale` = 'zhCN' AND `entry` = 4957;
-- OLD name : “干柴”塔伯克·贾恩
-- Source : https://www.wowhead.com/wotlk/cn/npc=4962
UPDATE `creature_template_locale` SET `Name` = '"干柴"塔伯克·贾恩' WHERE `locale` = 'zhCN' AND `entry` = 4962;
-- OLD subname : Wolf Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=4994
UPDATE `creature_template_locale` SET `Title` = '狼训练师' WHERE `locale` = 'zhCN' AND `entry` = 4994;
-- OLD subname : Bird Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5001
UPDATE `creature_template_locale` SET `Title` = '猛禽训练师' WHERE `locale` = 'zhCN' AND `entry` = 5001;
-- OLD subname : Boar Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5002
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5002;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (5002, 'zhCN',NULL,'野猪训练师');
-- OLD subname : Cat Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5003
UPDATE `creature_template_locale` SET `Title` = '豹训练师' WHERE `locale` = 'zhCN' AND `entry` = 5003;
-- OLD subname : Crawler Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5004
UPDATE `creature_template_locale` SET `Title` = '螃蟹训练师' WHERE `locale` = 'zhCN' AND `entry` = 5004;
-- OLD subname : Crocodile Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5005
UPDATE `creature_template_locale` SET `Title` = '鳄鱼训练师' WHERE `locale` = 'zhCN' AND `entry` = 5005;
-- OLD name : World Demon Trainer - old, subname : NONE
-- Source : https://www.wowhead.com/wotlk/cn/npc=5006
UPDATE `creature_template_locale` SET `Name` = 'World Demon Trainer',`Title` = '恶魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 5006;
-- OLD subname : Gorilla Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5008
UPDATE `creature_template_locale` SET `Title` = '猩猩训练师' WHERE `locale` = 'zhCN' AND `entry` = 5008;
-- OLD subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5009
UPDATE `creature_template_locale` SET `Title` = '马训练师' WHERE `locale` = 'zhCN' AND `entry` = 5009;
-- OLD subname : Raptor Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5011
UPDATE `creature_template_locale` SET `Title` = '迅猛龙训练师' WHERE `locale` = 'zhCN' AND `entry` = 5011;
-- OLD subname : Scorpid Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5012
UPDATE `creature_template_locale` SET `Title` = '蝎子训练师' WHERE `locale` = 'zhCN' AND `entry` = 5012;
-- OLD subname : Spider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5013
UPDATE `creature_template_locale` SET `Title` = '蜘蛛训练师' WHERE `locale` = 'zhCN' AND `entry` = 5013;
-- OLD subname : Tallstrider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5015
UPDATE `creature_template_locale` SET `Title` = '陆行鸟训练师' WHERE `locale` = 'zhCN' AND `entry` = 5015;
-- OLD subname : Turtle Pet Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5017
UPDATE `creature_template_locale` SET `Title` = '海龟训练师' WHERE `locale` = 'zhCN' AND `entry` = 5017;
-- OLD subname : Horse Riding Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5026
UPDATE `creature_template_locale` SET `Title` = '马骑术训练师' WHERE `locale` = 'zhCN' AND `entry` = 5026;
-- OLD subname : Lockpicking Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5027
UPDATE `creature_template_locale` SET `Title` = '开锁训练师' WHERE `locale` = 'zhCN' AND `entry` = 5027;
-- OLD subname : Survival Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5029
UPDATE `creature_template_locale` SET `Title` = '生存技能训练师' WHERE `locale` = 'zhCN' AND `entry` = 5029;
-- OLD subname : Tiger Riding Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5030
UPDATE `creature_template_locale` SET `Title` = '豹骑术训练师' WHERE `locale` = 'zhCN' AND `entry` = 5030;
-- OLD subname : Brewing Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5034
UPDATE `creature_template_locale` SET `Title` = '酿酒训练师' WHERE `locale` = 'zhCN' AND `entry` = 5034;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5035
UPDATE `creature_template_locale` SET `Title` = '制图训练师' WHERE `locale` = 'zhCN' AND `entry` = 5035;
-- OLD subname : 术士训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=5039
UPDATE `creature_template_locale` SET `Title` = '追踪训练商' WHERE `locale` = 'zhCN' AND `entry` = 5039;
-- OLD name : 暴徒
-- Source : https://www.wowhead.com/wotlk/cn/npc=5043
UPDATE `creature_template_locale` SET `Name` = '迪菲亚暴徒' WHERE `locale` = 'zhCN' AND `entry` = 5043;
-- OLD subname : 公会徽章设计师
-- Source : https://www.wowhead.com/wotlk/cn/npc=5047
UPDATE `creature_template_locale` SET `Title` = '公会徽章商人' WHERE `locale` = 'zhCN' AND `entry` = 5047;
-- OLD name : World Guild Tabard Vendor
-- Source : https://www.wowhead.com/wotlk/cn/npc=5061
UPDATE `creature_template_locale` SET `Name` = 'World Guild Tabbard Vendor' WHERE `locale` = 'zhCN' AND `entry` = 5061;
-- OLD name : 出纳员兰德里
-- Source : https://www.wowhead.com/wotlk/cn/npc=5083
UPDATE `creature_template_locale` SET `Name` = '书记员伦德瑞' WHERE `locale` = 'zhCN' AND `entry` = 5083;
-- OLD subname : Gun Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5104
UPDATE `creature_template_locale` SET `Title` = '枪械训练师' WHERE `locale` = 'zhCN' AND `entry` = 5104;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=5164
UPDATE `creature_template_locale` SET `Title` = '护甲锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 5164;
-- OLD subname : 战袍商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=5191
UPDATE `creature_template_locale` SET `Title` = '公会徽章商人' WHERE `locale` = 'zhCN' AND `entry` = 5191;
-- OLD subname : 战袍商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=5192
UPDATE `creature_template_locale` SET `Title` = '公会徽章商人' WHERE `locale` = 'zhCN' AND `entry` = 5192;
-- OLD name : 极地座狼
-- Source : https://www.wowhead.com/wotlk/cn/npc=5198
UPDATE `creature_template_locale` SET `Name` = '白毛座狼' WHERE `locale` = 'zhCN' AND `entry` = 5198;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=5204
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 5204;
-- OLD name : Jeremy's Test Monster
-- Source : https://www.wowhead.com/wotlk/cn/npc=5326
UPDATE `creature_template_locale` SET `Name` = '海滩响钳龙虾人' WHERE `locale` = 'zhCN' AND `entry` = 5326;
-- OLD name : 因格·绒套, subname : 珠宝加工训练师兼供应商
-- Source : https://www.wowhead.com/wotlk/cn/npc=5388
UPDATE `creature_template_locale` SET `Name` = '因格',`Title` = '探险者协会' WHERE `locale` = 'zhCN' AND `entry` = 5388;
-- OLD name : 白马
-- Source : https://www.wowhead.com/wotlk/cn/npc=5403
UPDATE `creature_template_locale` SET `Name` = '白马坐骑' WHERE `locale` = 'zhCN' AND `entry` = 5403;
-- OLD name : 被奴役的收割者
-- Source : https://www.wowhead.com/wotlk/cn/npc=5409
UPDATE `creature_template_locale` SET `Name` = '工蝎群' WHERE `locale` = 'zhCN' AND `entry` = 5409;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=5414
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 5414;
-- OLD subname : Tallstrider Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=5507
UPDATE `creature_template_locale` SET `Title` = '陆行鸟训练师' WHERE `locale` = 'zhCN' AND `entry` = 5507;
-- OLD name : [UNUSED] Yuriv Adhem (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5544
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5544;
-- OLD name : [PH] Mine Boss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5548
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5548;
-- OLD name : [PH] Mine Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5549
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5549;
-- OLD name : [PH] PVP Peasent (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5550
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5550;
-- OLD name : [PH] PVP Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5552
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5552;
-- OLD name : [PH] PVP Wildlife (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5554
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5554;
-- OLD name : [PH] Alliance Commander (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5556
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5556;
-- OLD name : [PH] Horde Commander (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5557
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5557;
-- OLD name : [PH] Alliance Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5558
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5558;
-- OLD name : [PH] Horde Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5559
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5559;
-- OLD name : [PH] Alliance Raider (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5560
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5560;
-- OLD name : [PH] Horde Raider (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5561
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5561;
-- OLD name : [PH] Alliance Archer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5562
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5562;
-- OLD name : [PH] Horde Archer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5563
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5563;
-- OLD name : [PH] Alliance Mine Boss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5587
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5587;
-- OLD name : [PH] Alliance Mine Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5588
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5588;
-- OLD name : [PH] Horde Mine Boss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5589
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5589;
-- OLD name : [PH] Horde Mine Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5590
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5590;
-- OLD name : [UNUSED] [PH] Orcish Barfly (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5604
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5604;
-- OLD name : 科马·韦拉德
-- Source : https://www.wowhead.com/wotlk/cn/npc=5683
UPDATE `creature_template_locale` SET `Name` = '科玛·韦拉德' WHERE `locale` = 'zhCN' AND `entry` = 5683;
-- OLD subname : 杰勒德的奴仆
-- Source : https://www.wowhead.com/wotlk/cn/npc=5697
UPDATE `creature_template_locale` SET `Title` = '杰勒德的实验品' WHERE `locale` = 'zhCN' AND `entry` = 5697;
-- OLD name : 耶瑟莉的地狱战马
-- Source : https://www.wowhead.com/wotlk/cn/npc=5727
UPDATE `creature_template_locale` SET `Name` = '耶瑟莉的梦魇' WHERE `locale` = 'zhCN' AND `entry` = 5727;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=5731
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 5731;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=5732
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 5732;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=5733
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 5733;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=5734
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 5734;
-- OLD name : [PH] Party Bot (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5801
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5801;
-- OLD name : 科提斯中士
-- Source : https://www.wowhead.com/wotlk/cn/npc=5809
UPDATE `creature_template_locale` SET `Name` = '指挥官萨拉菲尔' WHERE `locale` = 'zhCN' AND `entry` = 5809;
-- OLD name : “跳跃者”塔克
-- Source : https://www.wowhead.com/wotlk/cn/npc=5842
UPDATE `creature_template_locale` SET `Name` = '"跳跃者"塔克' WHERE `locale` = 'zhCN' AND `entry` = 5842;
-- OLD subname : Far Watch Sparrer (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=5876
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 5876;
-- OLD name : [UNUSED] Yar'luk, subname : Far Watch Sparrer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=5877
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 5877;
-- OLD name : 元素抵抗图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=5927
UPDATE `creature_template_locale` SET `Name` = '抗火图腾' WHERE `locale` = 'zhCN' AND `entry` = 5927;
-- OLD name : 流放者阿切鲁斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=5933
UPDATE `creature_template_locale` SET `Name` = '被流放的阿切鲁斯' WHERE `locale` = 'zhCN' AND `entry` = 5933;
-- OLD name : 锐爪飞心
-- Source : https://www.wowhead.com/wotlk/cn/npc=5934
UPDATE `creature_template_locale` SET `Name` = '哈特拉斯' WHERE `locale` = 'zhCN' AND `entry` = 5934;
-- OLD name : 拾骨邪饲者
-- Source : https://www.wowhead.com/wotlk/cn/npc=5983
UPDATE `creature_template_locale` SET `Name` = '拾骨者' WHERE `locale` = 'zhCN' AND `entry` = 5983;
-- OLD name : 魔誓仪祭师
-- Source : https://www.wowhead.com/wotlk/cn/npc=6004
UPDATE `creature_template_locale` SET `Name` = '魔誓祭司' WHERE `locale` = 'zhCN' AND `entry` = 6004;
-- OLD name : 条纹霜刃豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=6074
UPDATE `creature_template_locale` SET `Name` = '骑乘用虎（乳白色）' WHERE `locale` = 'zhCN' AND `entry` = 6074;
-- OLD name : 绿色迅猛龙
-- Source : https://www.wowhead.com/wotlk/cn/npc=6075
UPDATE `creature_template_locale` SET `Name` = '骑乘用迅猛龙（绿色）' WHERE `locale` = 'zhCN' AND `entry` = 6075;
-- OLD name : 亚考罗克的仆从
-- Source : https://www.wowhead.com/wotlk/cn/npc=6143
UPDATE `creature_template_locale` SET `Name` = '阿考洛克的仆从' WHERE `locale` = 'zhCN' AND `entry` = 6143;
-- OLD name : [UNUSED] Briton Kilras (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=6183
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 6183;
-- OLD name : 雷加什萨特
-- Source : https://www.wowhead.com/wotlk/cn/npc=6200
UPDATE `creature_template_locale` SET `Name` = '雷加斯萨特' WHERE `locale` = 'zhCN' AND `entry` = 6200;
-- OLD name : 雷加什盗贼
-- Source : https://www.wowhead.com/wotlk/cn/npc=6201
UPDATE `creature_template_locale` SET `Name` = '雷加斯潜行者' WHERE `locale` = 'zhCN' AND `entry` = 6201;
-- OLD name : 雷加什唤魔者
-- Source : https://www.wowhead.com/wotlk/cn/npc=6202
UPDATE `creature_template_locale` SET `Name` = '雷加斯唤魔者' WHERE `locale` = 'zhCN' AND `entry` = 6202;
-- OLD name : 耗子
-- Source : https://www.wowhead.com/wotlk/cn/npc=6271
UPDATE `creature_template_locale` SET `Name` = '老鼠' WHERE `locale` = 'zhCN' AND `entry` = 6271;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=6286
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 6286;
-- OLD name : 骸骨军马
-- Source : https://www.wowhead.com/wotlk/cn/npc=6346
UPDATE `creature_template_locale` SET `Name` = '骸骨战马' WHERE `locale` = 'zhCN' AND `entry` = 6346;
-- OLD name : 赫纳·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=6393
UPDATE `creature_template_locale` SET `Name` = '赫纳·狂暴图腾' WHERE `locale` = 'zhCN' AND `entry` = 6393;
-- OLD name : 鲁迦·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=6394
UPDATE `creature_template_locale` SET `Name` = '鲁迦·狂暴图腾' WHERE `locale` = 'zhCN' AND `entry` = 6394;
-- OLD name : 黑色骸骨军马
-- Source : https://www.wowhead.com/wotlk/cn/npc=6486
UPDATE `creature_template_locale` SET `Name` = '骑乘用骸骨战马（黑色）' WHERE `locale` = 'zhCN' AND `entry` = 6486;
-- OLD name : 勇敢的强生
-- Source : https://www.wowhead.com/wotlk/cn/npc=6626
UPDATE `creature_template_locale` SET `Name` = '胆大的约翰森' WHERE `locale` = 'zhCN' AND `entry` = 6626;
-- OLD name : 护门者拉格罗尔
-- Source : https://www.wowhead.com/wotlk/cn/npc=6651
UPDATE `creature_template_locale` SET `Name` = '拉格罗尔' WHERE `locale` = 'zhCN' AND `entry` = 6651;
-- OLD name : 强生的人类形态
-- Source : https://www.wowhead.com/wotlk/cn/npc=6666
UPDATE `creature_template_locale` SET `Name` = '约翰森的人类形态' WHERE `locale` = 'zhCN' AND `entry` = 6666;
-- OLD subname : 宗师级盗贼
-- Source : https://www.wowhead.com/wotlk/cn/npc=6707
UPDATE `creature_template_locale` SET `Title` = '祖师级潜行者' WHERE `locale` = 'zhCN' AND `entry` = 6707;
-- OLD name : 旅店老板贝茨
-- Source : https://www.wowhead.com/wotlk/cn/npc=6739
UPDATE `creature_template_locale` SET `Name` = '旅店老板拜特斯' WHERE `locale` = 'zhCN' AND `entry` = 6739;
-- OLD name : 艾玛
-- Source : https://www.wowhead.com/wotlk/cn/npc=6749
UPDATE `creature_template_locale` SET `Name` = '旅店老板艾玛' WHERE `locale` = 'zhCN' AND `entry` = 6749;
-- OLD subname : 刺客联盟的宗师级盗贼
-- Source : https://www.wowhead.com/wotlk/cn/npc=6767
UPDATE `creature_template_locale` SET `Title` = '刺客联盟的祖师级潜行者' WHERE `locale` = 'zhCN' AND `entry` = 6767;
-- OLD name : 罗瑞克·贝尔姆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=6783
UPDATE `creature_template_locale` SET `Name` = 'Gorgrond Smokebelcher Depot NPC Invisible Stalker "Our Gun''s Bigger" Quest Target ELM' WHERE `locale` = 'zhCN' AND `entry` = 6783;
-- OLD name : 海湾蟹
-- Source : https://www.wowhead.com/wotlk/cn/npc=6827
UPDATE `creature_template_locale` SET `Name` = '螃蟹' WHERE `locale` = 'zhCN' AND `entry` = 6827;
-- OLD name : 码头主管
-- Source : https://www.wowhead.com/wotlk/cn/npc=6846
UPDATE `creature_template_locale` SET `Name` = '迪菲亚码头主管' WHERE `locale` = 'zhCN' AND `entry` = 6846;
-- OLD name : 雅尔达
-- Source : https://www.wowhead.com/wotlk/cn/npc=6887
UPDATE `creature_template_locale` SET `Name` = '哈尔伦' WHERE `locale` = 'zhCN' AND `entry` = 6887;
-- OLD name : 码头工人
-- Source : https://www.wowhead.com/wotlk/cn/npc=6927
UPDATE `creature_template_locale` SET `Name` = '迪菲亚码头工人' WHERE `locale` = 'zhCN' AND `entry` = 6927;
-- OLD name : “剃刀”雷吉克
-- Source : https://www.wowhead.com/wotlk/cn/npc=6946
UPDATE `creature_template_locale` SET `Name` = '"剃刀"雷吉克' WHERE `locale` = 'zhCN' AND `entry` = 6946;
-- OLD name : 黑石卫士
-- Source : https://www.wowhead.com/wotlk/cn/npc=7013
UPDATE `creature_template_locale` SET `Name` = '黑石狂暴者' WHERE `locale` = 'zhCN' AND `entry` = 7013;
-- OLD name : 黑色龙人
-- Source : https://www.wowhead.com/wotlk/cn/npc=7041
UPDATE `creature_template_locale` SET `Name` = '火鳞龙人' WHERE `locale` = 'zhCN' AND `entry` = 7041;
-- OLD name : 火鳞龙人
-- Source : https://www.wowhead.com/wotlk/cn/npc=7042
UPDATE `creature_template_locale` SET `Name` = '黑色龙族' WHERE `locale` = 'zhCN' AND `entry` = 7042;
-- OLD name : 风险投资公司闲工
-- Source : https://www.wowhead.com/wotlk/cn/npc=7067
UPDATE `creature_template_locale` SET `Name` = '风险投资公司雄蜂' WHERE `locale` = 'zhCN' AND `entry` = 7067;
-- OLD name : 碧火盗贼
-- Source : https://www.wowhead.com/wotlk/cn/npc=7106
UPDATE `creature_template_locale` SET `Name` = '碧火潜行者' WHERE `locale` = 'zhCN' AND `entry` = 7106;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7174
UPDATE `creature_template_locale` SET `Title` = '铸甲训练师' WHERE `locale` = 'zhCN' AND `entry` = 7174;
-- OLD name : 远古巨石卫士
-- Source : https://www.wowhead.com/wotlk/cn/npc=7206
UPDATE `creature_template_locale` SET `Name` = '古代的石头看守者' WHERE `locale` = 'zhCN' AND `entry` = 7206;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7230
UPDATE `creature_template_locale` SET `Title` = '护甲锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 7230;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7231
UPDATE `creature_template_locale` SET `Title` = '武器铸造训练师' WHERE `locale` = 'zhCN' AND `entry` = 7231;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7232
UPDATE `creature_template_locale` SET `Title` = '武器铸造训练师' WHERE `locale` = 'zhCN' AND `entry` = 7232;
-- OLD name : 黑色夜刃豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=7322
UPDATE `creature_template_locale` SET `Name` = '骑乘用虎（黑色）' WHERE `locale` = 'zhCN' AND `entry` = 7322;
-- OLD name : 无瑕的德莱尼水晶球
-- Source : https://www.wowhead.com/wotlk/cn/npc=7364
UPDATE `creature_template_locale` SET `Name` = '无暇的德莱尼水晶球' WHERE `locale` = 'zhCN' AND `entry` = 7364;
-- OLD name : 无瑕的德莱尼水晶碎片
-- Source : https://www.wowhead.com/wotlk/cn/npc=7365
UPDATE `creature_template_locale` SET `Name` = '无暇的德莱尼水晶碎片' WHERE `locale` = 'zhCN' AND `entry` = 7365;
-- OLD name : 幽暗城蟑螂
-- Source : https://www.wowhead.com/wotlk/cn/npc=7395
UPDATE `creature_template_locale` SET `Name` = '蟑螂' WHERE `locale` = 'zhCN' AND `entry` = 7395;
-- OLD name : 泰姆·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=7427
UPDATE `creature_template_locale` SET `Name` = '泰姆·狂暴图腾' WHERE `locale` = 'zhCN' AND `entry` = 7427;
-- OLD name : 幼霜刃豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=7430
UPDATE `creature_template_locale` SET `Name` = '霜刃豹幼崽' WHERE `locale` = 'zhCN' AND `entry` = 7430;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7525
UPDATE `creature_template_locale` SET `Title` = '龙鳞制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 7525;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7526
UPDATE `creature_template_locale` SET `Title` = '元素制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 7526;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7528
UPDATE `creature_template_locale` SET `Title` = '部族制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 7528;
-- OLD name : Cottontail Rabbit
-- Source : https://www.wowhead.com/wotlk/cn/npc=7558
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 7558;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7558, 'zhCN','黄毛兔',NULL);
-- OLD name : Spotted Rabbit
-- Source : https://www.wowhead.com/wotlk/cn/npc=7559
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 7559;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7559, 'zhCN','斑点兔',NULL);
-- OLD name : Slim's Test Death Knight
-- Source : https://www.wowhead.com/wotlk/cn/npc=7624
UPDATE `creature_template_locale` SET `Name` = 'Test Death Knight' WHERE `locale` = 'zhCN' AND `entry` = 7624;
-- OLD name : 猎豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=7684
UPDATE `creature_template_locale` SET `Name` = '骑乘用虎（黄色）' WHERE `locale` = 'zhCN' AND `entry` = 7684;
-- OLD name : 丛林虎
-- Source : https://www.wowhead.com/wotlk/cn/npc=7686
UPDATE `creature_template_locale` SET `Name` = '骑乘用虎（红色）' WHERE `locale` = 'zhCN' AND `entry` = 7686;
-- OLD name : 斑点霜刃豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=7687
UPDATE `creature_template_locale` SET `Name` = '骑乘用虎（雪白色）' WHERE `locale` = 'zhCN' AND `entry` = 7687;
-- OLD name : 斑点夜刃豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=7689
UPDATE `creature_template_locale` SET `Name` = '骑乘用虎（黑色斑点）' WHERE `locale` = 'zhCN' AND `entry` = 7689;
-- OLD name : 黑色迅猛龙
-- Source : https://www.wowhead.com/wotlk/cn/npc=7703
UPDATE `creature_template_locale` SET `Name` = '骑乘用迅猛龙（黑色）' WHERE `locale` = 'zhCN' AND `entry` = 7703;
-- OLD name : 杂斑红色迅猛龙
-- Source : https://www.wowhead.com/wotlk/cn/npc=7704
UPDATE `creature_template_locale` SET `Name` = '骑乘用迅猛龙（红色）' WHERE `locale` = 'zhCN' AND `entry` = 7704;
-- OLD name : 白色迅猛龙
-- Source : https://www.wowhead.com/wotlk/cn/npc=7706
UPDATE `creature_template_locale` SET `Name` = '骑乘用迅猛龙（黄色）' WHERE `locale` = 'zhCN' AND `entry` = 7706;
-- OLD name : 青色迅猛龙
-- Source : https://www.wowhead.com/wotlk/cn/npc=7707
UPDATE `creature_template_locale` SET `Name` = '骑乘用迅猛龙（绿色）' WHERE `locale` = 'zhCN' AND `entry` = 7707;
-- OLD name : 比鲁拉, subname : 前旅店老板
-- Source : https://www.wowhead.com/wotlk/cn/npc=7714
UPDATE `creature_template_locale` SET `Name` = '旅店老板比鲁拉',`Title` = '旅店老板' WHERE `locale` = 'zhCN' AND `entry` = 7714;
-- OLD name : 红色机械陆行鸟
-- Source : https://www.wowhead.com/wotlk/cn/npc=7739
UPDATE `creature_template_locale` SET `Name` = '骑乘用机械陆行鸟（黄色）' WHERE `locale` = 'zhCN' AND `entry` = 7739;
-- OLD name : 蓝色机械陆行鸟
-- Source : https://www.wowhead.com/wotlk/cn/npc=7749
UPDATE `creature_template_locale` SET `Name` = '骑乘用机械陆行鸟（蓝色）' WHERE `locale` = 'zhCN' AND `entry` = 7749;
-- OLD name : 机械师瑟玛普拉格
-- Source : https://www.wowhead.com/wotlk/cn/npc=7800
UPDATE `creature_template_locale` SET `Name` = '麦克尼尔·瑟玛普拉格' WHERE `locale` = 'zhCN' AND `entry` = 7800;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7866
UPDATE `creature_template_locale` SET `Title` = '龙鳞制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 7866;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7867
UPDATE `creature_template_locale` SET `Title` = '龙鳞制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 7867;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7868
UPDATE `creature_template_locale` SET `Title` = '元素制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 7868;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7869
UPDATE `creature_template_locale` SET `Title` = '元素制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 7869;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7870
UPDATE `creature_template_locale` SET `Title` = '部族制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 7870;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7871
UPDATE `creature_template_locale` SET `Title` = '部族制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 7871;
-- OLD subname : 骑术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=7954
UPDATE `creature_template_locale` SET `Title` = '机械陆行鸟驾驶员' WHERE `locale` = 'zhCN' AND `entry` = 7954;
-- OLD name : 纳拉其营地卫士
-- Source : https://www.wowhead.com/wotlk/cn/npc=7975
UPDATE `creature_template_locale` SET `Name` = '莫高雷卫士' WHERE `locale` = 'zhCN' AND `entry` = 7975;
-- OLD name : 月溪旅卫士
-- Source : https://www.wowhead.com/wotlk/cn/npc=8096
UPDATE `creature_template_locale` SET `Name` = '人民军卫兵' WHERE `locale` = 'zhCN' AND `entry` = 8096;
-- OLD name : 余烬之翼
-- Source : https://www.wowhead.com/wotlk/cn/npc=8207
UPDATE `creature_template_locale` SET `Name` = '巨型火鸟' WHERE `locale` = 'zhCN' AND `entry` = 8207;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=8306
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 8306;
-- OLD name : 卡拉然·温布雷
-- Source : https://www.wowhead.com/wotlk/cn/npc=8479
UPDATE `creature_template_locale` SET `Name` = '威拉罗克·温布雷' WHERE `locale` = 'zhCN' AND `entry` = 8479;
-- OLD name : 天灾破坏者
-- Source : https://www.wowhead.com/wotlk/cn/npc=8520
UPDATE `creature_template_locale` SET `Name` = '瘟疫破坏者' WHERE `locale` = 'zhCN' AND `entry` = 8520;
-- OLD name : 天灾水元素
-- Source : https://www.wowhead.com/wotlk/cn/npc=8522
UPDATE `creature_template_locale` SET `Name` = '瘟疫水元素' WHERE `locale` = 'zhCN' AND `entry` = 8522;
-- OLD subname : 诅咒教派
-- Source : https://www.wowhead.com/wotlk/cn/npc=8547
UPDATE `creature_template_locale` SET `Title` = '诅咒神教' WHERE `locale` = 'zhCN' AND `entry` = 8547;
-- OLD subname : 诅咒教派
-- Source : https://www.wowhead.com/wotlk/cn/npc=8549
UPDATE `creature_template_locale` SET `Title` = '诅咒神教' WHERE `locale` = 'zhCN' AND `entry` = 8549;
-- OLD subname : 诅咒教派
-- Source : https://www.wowhead.com/wotlk/cn/npc=8550
UPDATE `creature_template_locale` SET `Title` = '诅咒神教' WHERE `locale` = 'zhCN' AND `entry` = 8550;
-- OLD subname : 诅咒教派
-- Source : https://www.wowhead.com/wotlk/cn/npc=8552
UPDATE `creature_template_locale` SET `Title` = '诅咒神教' WHERE `locale` = 'zhCN' AND `entry` = 8552;
-- OLD subname : 诅咒教派
-- Source : https://www.wowhead.com/wotlk/cn/npc=8553
UPDATE `creature_template_locale` SET `Title` = '诅咒神教' WHERE `locale` = 'zhCN' AND `entry` = 8553;
-- OLD name : 锋牙·刺鬃酋长
-- Source : https://www.wowhead.com/wotlk/cn/npc=8554
UPDATE `creature_template_locale` SET `Name` = '刺鬃酋长' WHERE `locale` = 'zhCN' AND `entry` = 8554;
-- OLD name : 失心的护林者
-- Source : https://www.wowhead.com/wotlk/cn/npc=8563
UPDATE `creature_template_locale` SET `Name` = '护林者' WHERE `locale` = 'zhCN' AND `entry` = 8563;
-- OLD name : 失心的游侠
-- Source : https://www.wowhead.com/wotlk/cn/npc=8564
UPDATE `creature_template_locale` SET `Name` = '游侠' WHERE `locale` = 'zhCN' AND `entry` = 8564;
-- OLD name : 失心的巡路者
-- Source : https://www.wowhead.com/wotlk/cn/npc=8565
UPDATE `creature_template_locale` SET `Name` = '巡路者' WHERE `locale` = 'zhCN' AND `entry` = 8565;
-- OLD name : 天灾巨犬
-- Source : https://www.wowhead.com/wotlk/cn/npc=8599
UPDATE `creature_template_locale` SET `Name` = '瘟疫巨犬' WHERE `locale` = 'zhCN' AND `entry` = 8599;
-- OLD name : 烈日行者赛恩
-- Source : https://www.wowhead.com/wotlk/cn/npc=8664
UPDATE `creature_template_locale` SET `Name` = '赛恩' WHERE `locale` = 'zhCN' AND `entry` = 8664;
-- OLD name : 朱比·加基斯宾
-- Source : https://www.wowhead.com/wotlk/cn/npc=8678
UPDATE `creature_template_locale` SET `Name` = '朱比' WHERE `locale` = 'zhCN' AND `entry` = 8678;
-- OLD name : 怒炉将军
-- Source : https://www.wowhead.com/wotlk/cn/npc=9033
UPDATE `creature_template_locale` SET `Name` = '安格弗将军' WHERE `locale` = 'zhCN' AND `entry` = 9033;
-- OLD name : 格尔洛普
-- Source : https://www.wowhead.com/wotlk/cn/npc=9176
UPDATE `creature_template_locale` SET `Name` = '戈泰什' WHERE `locale` = 'zhCN' AND `entry` = 9176;
-- OLD name : 出土的化石
-- Source : https://www.wowhead.com/wotlk/cn/npc=9397
UPDATE `creature_template_locale` SET `Name` = '活风暴' WHERE `locale` = 'zhCN' AND `entry` = 9397;
-- OLD name : [UNUSED] dun garok test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=9557
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 9557;
-- OLD name : Stormwind Talent Master
-- Source : https://www.wowhead.com/wotlk/cn/npc=9576
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhCN' AND `entry` = 9576;
-- OLD name : Ironforge Talent Master
-- Source : https://www.wowhead.com/wotlk/cn/npc=9578
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhCN' AND `entry` = 9578;
-- OLD subname : 天赋大师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=9579
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 9579;
-- OLD subname : 天赋大师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=9580
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 9580;
-- OLD subname : 天赋大师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=9581
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 9581;
-- OLD subname : 天赋大师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=9582
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 9582;
-- OLD subname : 裁缝训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=9584
UPDATE `creature_template_locale` SET `Title` = '大师级暗纹裁缝' WHERE `locale` = 'zhCN' AND `entry` = 9584;
-- OLD name : [PH] TESTTAUREN (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=9686
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 9686;
-- OLD name : [UNUSED] [PH] Cheese Servant Floh (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=9820
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 9820;
-- OLD subname : 前兽栏管理员
-- Source : https://www.wowhead.com/wotlk/cn/npc=9983
UPDATE `creature_template_locale` SET `Title` = '兽栏管理员' WHERE `locale` = 'zhCN' AND `entry` = 9983;
-- OLD name : [PH] Raid Testing Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=10044
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 10044;
-- OLD name : 荧光机械陆行鸟
-- Source : https://www.wowhead.com/wotlk/cn/npc=10178
UPDATE `creature_template_locale` SET `Name` = '骑乘用机械陆行鸟（粉绿色）' WHERE `locale` = 'zhCN' AND `entry` = 10178;
-- OLD name : 白色机械陆行鸟B型
-- Source : https://www.wowhead.com/wotlk/cn/npc=10179
UPDATE `creature_template_locale` SET `Name` = '骑乘用机械陆行鸟（黑色）' WHERE `locale` = 'zhCN' AND `entry` = 10179;
-- OLD name : 尤尔, subname : NONE
-- Source : https://www.wowhead.com/wotlk/cn/npc=10237
UPDATE `creature_template_locale` SET `Name` = 'Yor',`Title` = 'UNUSED' WHERE `locale` = 'zhCN' AND `entry` = 10237;
-- OLD subname : Dagger Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=10292
UPDATE `creature_template_locale` SET `Title` = '匕首训练师' WHERE `locale` = 'zhCN' AND `entry` = 10292;
-- OLD subname : Fist Weapons Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=10294
UPDATE `creature_template_locale` SET `Title` = '拳套训练师' WHERE `locale` = 'zhCN' AND `entry` = 10294;
-- OLD name : 阿克莱德
-- Source : https://www.wowhead.com/wotlk/cn/npc=10296
UPDATE `creature_template_locale` SET `Name` = '维埃兰' WHERE `locale` = 'zhCN' AND `entry` = 10296;
-- OLD subname : Bow Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=10297
UPDATE `creature_template_locale` SET `Title` = '弓箭训练师' WHERE `locale` = 'zhCN' AND `entry` = 10297;
-- OLD name : 阿克莱德
-- Source : https://www.wowhead.com/wotlk/cn/npc=10299
UPDATE `creature_template_locale` SET `Name` = '裂盾渗透者' WHERE `locale` = 'zhCN' AND `entry` = 10299;
-- OLD name : 加隆·塑石者
-- Source : https://www.wowhead.com/wotlk/cn/npc=10301
UPDATE `creature_template_locale` SET `Name` = '加隆·石矛' WHERE `locale` = 'zhCN' AND `entry` = 10301;
-- OLD name : 古代霜刃豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=10322
UPDATE `creature_template_locale` SET `Name` = 'Riding Tiger (White)' WHERE `locale` = 'zhCN' AND `entry` = 10322;
-- OLD name : 原始猎豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=10336
UPDATE `creature_template_locale` SET `Name` = 'Riding Tiger (Leopard)' WHERE `locale` = 'zhCN' AND `entry` = 10336;
-- OLD name : 茶色刃齿豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=10337
UPDATE `creature_template_locale` SET `Name` = 'Riding Tiger (Orange)' WHERE `locale` = 'zhCN' AND `entry` = 10337;
-- OLD name : 金色锋刃豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=10338
UPDATE `creature_template_locale` SET `Name` = 'Riding Tiger (Gold)' WHERE `locale` = 'zhCN' AND `entry` = 10338;
-- OLD name : [UNUSED] Xur'gyl (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=10370
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 10370;
-- OLD name : 奥索巴·暴怒图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=10379
UPDATE `creature_template_locale` SET `Name` = '奥索巴·狂怒图腾' WHERE `locale` = 'zhCN' AND `entry` = 10379;
-- OLD name : [UNUSED] Thuzadin Shadow Lord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=10401
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 10401;
-- OLD name : [UNUSED] Cannibal Wight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=10402
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 10402;
-- OLD name : [UNUSED] Devouring Wight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=10403
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 10403;
-- OLD name : 复生的卫兵
-- Source : https://www.wowhead.com/wotlk/cn/npc=10418
UPDATE `creature_template_locale` SET `Name` = '红衣卫兵' WHERE `locale` = 'zhCN' AND `entry` = 10418;
-- OLD name : 复生的魔术师
-- Source : https://www.wowhead.com/wotlk/cn/npc=10419
UPDATE `creature_template_locale` SET `Name` = '红衣魔术师' WHERE `locale` = 'zhCN' AND `entry` = 10419;
-- OLD name : 复生的新兵
-- Source : https://www.wowhead.com/wotlk/cn/npc=10420
UPDATE `creature_template_locale` SET `Name` = '红衣新兵' WHERE `locale` = 'zhCN' AND `entry` = 10420;
-- OLD name : 复生的防御者
-- Source : https://www.wowhead.com/wotlk/cn/npc=10421
UPDATE `creature_template_locale` SET `Name` = '红衣防御者' WHERE `locale` = 'zhCN' AND `entry` = 10421;
-- OLD name : 复生的法术师
-- Source : https://www.wowhead.com/wotlk/cn/npc=10422
UPDATE `creature_template_locale` SET `Name` = '红衣法术师' WHERE `locale` = 'zhCN' AND `entry` = 10422;
-- OLD name : 复生的牧师
-- Source : https://www.wowhead.com/wotlk/cn/npc=10423
UPDATE `creature_template_locale` SET `Name` = '红衣牧师' WHERE `locale` = 'zhCN' AND `entry` = 10423;
-- OLD name : 复生的豪侠
-- Source : https://www.wowhead.com/wotlk/cn/npc=10424
UPDATE `creature_template_locale` SET `Name` = '红衣豪侠' WHERE `locale` = 'zhCN' AND `entry` = 10424;
-- OLD name : 复生的战斗法师
-- Source : https://www.wowhead.com/wotlk/cn/npc=10425
UPDATE `creature_template_locale` SET `Name` = '红衣战斗法师' WHERE `locale` = 'zhCN' AND `entry` = 10425;
-- OLD name : 复生的审查者
-- Source : https://www.wowhead.com/wotlk/cn/npc=10426
UPDATE `creature_template_locale` SET `Name` = '红衣审查者' WHERE `locale` = 'zhCN' AND `entry` = 10426;
-- OLD name : 帕奥卡·迅山
-- Source : https://www.wowhead.com/wotlk/cn/npc=10427
UPDATE `creature_template_locale` SET `Name` = '波卡·雨山' WHERE `locale` = 'zhCN' AND `entry` = 10427;
-- OLD name : 天灾鼠
-- Source : https://www.wowhead.com/wotlk/cn/npc=10441
UPDATE `creature_template_locale` SET `Name` = '瘟疫鼠' WHERE `locale` = 'zhCN' AND `entry` = 10441;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=10446
UPDATE `creature_template_locale` SET `Title` = '弩训练师' WHERE `locale` = 'zhCN' AND `entry` = 10446;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=10450
UPDATE `creature_template_locale` SET `Title` = '弩训练师' WHERE `locale` = 'zhCN' AND `entry` = 10450;
-- OLD subname : Mace Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=10452
UPDATE `creature_template_locale` SET `Title` = '锤训练师' WHERE `locale` = 'zhCN' AND `entry` = 10452;
-- OLD subname : Axe Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=10453
UPDATE `creature_template_locale` SET `Title` = '斧训练师' WHERE `locale` = 'zhCN' AND `entry` = 10453;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=10454
UPDATE `creature_template_locale` SET `Title` = '弩训练师' WHERE `locale` = 'zhCN' AND `entry` = 10454;
-- OLD name : 天灾虫
-- Source : https://www.wowhead.com/wotlk/cn/npc=10461
UPDATE `creature_template_locale` SET `Name` = '瘟疫虫' WHERE `locale` = 'zhCN' AND `entry` = 10461;
-- OLD name : 通灵学院新生
-- Source : https://www.wowhead.com/wotlk/cn/npc=10470
UPDATE `creature_template_locale` SET `Name` = '通灵学院新学徒' WHERE `locale` = 'zhCN' AND `entry` = 10470;
-- OLD name : 阿雷克斯·巴罗夫领主
-- Source : https://www.wowhead.com/wotlk/cn/npc=10504
UPDATE `creature_template_locale` SET `Name` = '阿雷克斯·巴罗夫' WHERE `locale` = 'zhCN' AND `entry` = 10504;
-- OLD name : 天灾软泥怪
-- Source : https://www.wowhead.com/wotlk/cn/npc=10510
UPDATE `creature_template_locale` SET `Name` = '瘟疫软泥怪' WHERE `locale` = 'zhCN' AND `entry` = 10510;
-- OLD name : 天灾蛆
-- Source : https://www.wowhead.com/wotlk/cn/npc=10536
UPDATE `creature_template_locale` SET `Name` = '瘟疫蛆' WHERE `locale` = 'zhCN' AND `entry` = 10536;
-- OLD subname : 见习巫医
-- Source : https://www.wowhead.com/wotlk/cn/npc=10578
UPDATE `creature_template_locale` SET `Title` = '训练中的巫医' WHERE `locale` = 'zhCN' AND `entry` = 10578;
-- OLD name : [UNUSED] Siralnaya (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=10607
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 10607;
-- OLD subname : 皇家药剂师协会
-- Source : https://www.wowhead.com/wotlk/cn/npc=10665
UPDATE `creature_template_locale` SET `Title` = '皇家药剂师学会' WHERE `locale` = 'zhCN' AND `entry` = 10665;
-- OLD name : 天灾龙崽
-- Source : https://www.wowhead.com/wotlk/cn/npc=10678
UPDATE `creature_template_locale` SET `Name` = '瘟疫龙崽' WHERE `locale` = 'zhCN' AND `entry` = 10678;
-- OLD name : [UNUSED] Deathcaller Majestis (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=10810
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 10810;
-- OLD name : 督军塔雷金
-- Source : https://www.wowhead.com/wotlk/cn/npc=10822
UPDATE `creature_template_locale` SET `Name` = '塔雷什森' WHERE `locale` = 'zhCN' AND `entry` = 10822;
-- OLD name : 死亡猎人霍克斯比尔
-- Source : https://www.wowhead.com/wotlk/cn/npc=10824
UPDATE `creature_template_locale` SET `Name` = '游侠之王霍克斯比尔' WHERE `locale` = 'zhCN' AND `entry` = 10824;
-- OLD name : 莉尼亚·阿比迪斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=10828
UPDATE `creature_template_locale` SET `Name` = '阿比迪斯将军' WHERE `locale` = 'zhCN' AND `entry` = 10828;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=10839
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 10839;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=10840
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 10840;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=10857
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 10857;
-- OLD name : 希望破坏者威利
-- Source : https://www.wowhead.com/wotlk/cn/npc=10997
UPDATE `creature_template_locale` SET `Name` = '炮手威利' WHERE `locale` = 'zhCN' AND `entry` = 10997;
-- OLD name : 冬泉霜刃豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=11021
UPDATE `creature_template_locale` SET `Name` = 'Riding Tiger (Winterspring)' WHERE `locale` = 'zhCN' AND `entry` = 11021;
-- OLD name : 指挥官玛洛尔
-- Source : https://www.wowhead.com/wotlk/cn/npc=11032
UPDATE `creature_template_locale` SET `Name` = '狂热的玛洛尔' WHERE `locale` = 'zhCN' AND `entry` = 11032;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=11034
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 11034;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=11036
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 11036;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=11039
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 11039;
-- OLD name : 复生的僧侣
-- Source : https://www.wowhead.com/wotlk/cn/npc=11043
UPDATE `creature_template_locale` SET `Name` = '红衣僧侣' WHERE `locale` = 'zhCN' AND `entry` = 11043;
-- OLD name : 复生的火枪手
-- Source : https://www.wowhead.com/wotlk/cn/npc=11054
UPDATE `creature_template_locale` SET `Name` = '红衣火枪手' WHERE `locale` = 'zhCN' AND `entry` = 11054;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=11063
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 11063;
-- OLD name : [PH[ Combat Tester (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=11080
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 11080;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=11102
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 11102;
-- OLD name : 复生的铸锤师
-- Source : https://www.wowhead.com/wotlk/cn/npc=11120
UPDATE `creature_template_locale` SET `Name` = '红衣铸锤师' WHERE `locale` = 'zhCN' AND `entry` = 11120;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=11146
UPDATE `creature_template_locale` SET `Title` = '武器铸造训练师' WHERE `locale` = 'zhCN' AND `entry` = 11146;
-- OLD name : 绿色机械陆行鸟
-- Source : https://www.wowhead.com/wotlk/cn/npc=11147
UPDATE `creature_template_locale` SET `Name` = 'Riding MechaStrider (Green/Gray)' WHERE `locale` = 'zhCN' AND `entry` = 11147;
-- OLD name : 紫色机械陆行鸟
-- Source : https://www.wowhead.com/wotlk/cn/npc=11148
UPDATE `creature_template_locale` SET `Name` = 'Riding MechaStrider (Purple)' WHERE `locale` = 'zhCN' AND `entry` = 11148;
-- OLD name : 红蓝两色机械陆行鸟
-- Source : https://www.wowhead.com/wotlk/cn/npc=11149
UPDATE `creature_template_locale` SET `Name` = 'Riding MechaStrider (Red/Blue)' WHERE `locale` = 'zhCN' AND `entry` = 11149;
-- OLD name : 冰蓝色机械陆行鸟A型
-- Source : https://www.wowhead.com/wotlk/cn/npc=11150
UPDATE `creature_template_locale` SET `Name` = 'Riding MechaStrider (Icy Blue)' WHERE `locale` = 'zhCN' AND `entry` = 11150;
-- OLD name : 红色骸骨军马
-- Source : https://www.wowhead.com/wotlk/cn/npc=11153
UPDATE `creature_template_locale` SET `Name` = 'Riding Skeletal Horse (Red)' WHERE `locale` = 'zhCN' AND `entry` = 11153;
-- OLD name : 蓝色骸骨军马
-- Source : https://www.wowhead.com/wotlk/cn/npc=11154
UPDATE `creature_template_locale` SET `Name` = 'Riding Skeletal Horse (Blue)' WHERE `locale` = 'zhCN' AND `entry` = 11154;
-- OLD name : 棕色骸骨军马
-- Source : https://www.wowhead.com/wotlk/cn/npc=11155
UPDATE `creature_template_locale` SET `Name` = 'Riding Skeletal Horse (Brown)' WHERE `locale` = 'zhCN' AND `entry` = 11155;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=11177
UPDATE `creature_template_locale` SET `Title` = '护甲锻造师' WHERE `locale` = 'zhCN' AND `entry` = 11177;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=11178
UPDATE `creature_template_locale` SET `Title` = '武器锻造师' WHERE `locale` = 'zhCN' AND `entry` = 11178;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=11194
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 11194;
-- OLD name : 死亡战马
-- Source : https://www.wowhead.com/wotlk/cn/npc=11195
UPDATE `creature_template_locale` SET `Name` = '黑色骸骨战马' WHERE `locale` = 'zhCN' AND `entry` = 11195;
-- OLD name : 跳虫
-- Source : https://www.wowhead.com/wotlk/cn/npc=11327
UPDATE `creature_template_locale` SET `Name` = '跳跳虫' WHERE `locale` = 'zhCN' AND `entry` = 11327;
-- OLD subname : 劈颅巨魔大使
-- Source : https://www.wowhead.com/wotlk/cn/npc=11390
UPDATE `creature_template_locale` SET `Title` = '碎颅巨魔大使' WHERE `locale` = 'zhCN' AND `entry` = 11390;
-- OLD subname : 辛德拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=11466
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 11466;
-- OLD name : 奥术恐兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=11479
UPDATE `creature_template_locale` SET `Name` = '奥术恶兽' WHERE `locale` = 'zhCN' AND `entry` = 11479;
-- OLD subname : 辛德拉的统治者
-- Source : https://www.wowhead.com/wotlk/cn/npc=11486
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 11486;
-- OLD name : 荒野变形者奥兹恩
-- Source : https://www.wowhead.com/wotlk/cn/npc=11492
UPDATE `creature_template_locale` SET `Name` = '奥兹恩' WHERE `locale` = 'zhCN' AND `entry` = 11492;
-- OLD name : 沮丧的斯卡尔
-- Source : https://www.wowhead.com/wotlk/cn/npc=11498
UPDATE `creature_template_locale` SET `Name` = '无敌的斯卡尔' WHERE `locale` = 'zhCN' AND `entry` = 11498;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=11536
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 11536;
-- OLD name : [UNUSED] Molten Colossus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=11660
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 11660;
-- OLD name : 火妖
-- Source : https://www.wowhead.com/wotlk/cn/npc=11661
UPDATE `creature_template_locale` SET `Name` = '烈焰行者' WHERE `locale` = 'zhCN' AND `entry` = 11661;
-- OLD name : 火妖祭司
-- Source : https://www.wowhead.com/wotlk/cn/npc=11662
UPDATE `creature_template_locale` SET `Name` = '烈焰行者祭司' WHERE `locale` = 'zhCN' AND `entry` = 11662;
-- OLD name : 火妖医师
-- Source : https://www.wowhead.com/wotlk/cn/npc=11663
UPDATE `creature_template_locale` SET `Name` = '烈焰行者医师' WHERE `locale` = 'zhCN' AND `entry` = 11663;
-- OLD name : 火妖精英
-- Source : https://www.wowhead.com/wotlk/cn/npc=11664
UPDATE `creature_template_locale` SET `Name` = '烈焰行者精英' WHERE `locale` = 'zhCN' AND `entry` = 11664;
-- OLD name : [UNUSED] Flame Shrieker (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=11670
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 11670;
-- OLD name : 熔火恶犬
-- Source : https://www.wowhead.com/wotlk/cn/npc=11673
UPDATE `creature_template_locale` SET `Name` = '上古熔火恶犬' WHERE `locale` = 'zhCN' AND `entry` = 11673;
-- OLD name : 战歌伐木工
-- Source : https://www.wowhead.com/wotlk/cn/npc=11681
UPDATE `creature_template_locale` SET `Name` = '部落伐木工' WHERE `locale` = 'zhCN' AND `entry` = 11681;
-- OLD name : 地精伐木机
-- Source : https://www.wowhead.com/wotlk/cn/npc=11684
UPDATE `creature_template_locale` SET `Name` = '战歌伐木机' WHERE `locale` = 'zhCN' AND `entry` = 11684;
-- OLD name : 棕色科多兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=11689
UPDATE `creature_template_locale` SET `Name` = '骑乘用科多兽（棕色）' WHERE `locale` = 'zhCN' AND `entry` = 11689;
-- OLD name : 黑木追踪者
-- Source : https://www.wowhead.com/wotlk/cn/npc=11713
UPDATE `creature_template_locale` SET `Name` = '黑幕追踪者' WHERE `locale` = 'zhCN' AND `entry` = 11713;
-- OLD name : 塞雷布拉斯姐妹
-- Source : https://www.wowhead.com/wotlk/cn/npc=11794
UPDATE `creature_template_locale` SET `Name` = '塞雷布拉斯的姐妹' WHERE `locale` = 'zhCN' AND `entry` = 11794;
-- OLD name : 格鲁迪格·黑云
-- Source : https://www.wowhead.com/wotlk/cn/npc=11858
UPDATE `creature_template_locale` SET `Name` = '格鲁迪格·暗云' WHERE `locale` = 'zhCN' AND `entry` = 11858;
-- OLD name : 滚岩护石者
-- Source : https://www.wowhead.com/wotlk/cn/npc=11915
UPDATE `creature_template_locale` SET `Name` = '高戈护石者' WHERE `locale` = 'zhCN' AND `entry` = 11915;
-- OLD name : 滚岩地卜师
-- Source : https://www.wowhead.com/wotlk/cn/npc=11917
UPDATE `creature_template_locale` SET `Name` = '高戈地卜师' WHERE `locale` = 'zhCN' AND `entry` = 11917;
-- OLD name : 滚岩裂石者
-- Source : https://www.wowhead.com/wotlk/cn/npc=11918
UPDATE `creature_template_locale` SET `Name` = '高戈裂石者' WHERE `locale` = 'zhCN' AND `entry` = 11918;
-- OLD name : [PH] Northshire Gift Dispenser (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=11926
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 11926;
-- OLD subname : 炼金术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=12020
UPDATE `creature_template_locale` SET `Title` = '高级炼金师' WHERE `locale` = 'zhCN' AND `entry` = 12020;
-- OLD name : 格蕾拉·石拳
-- Source : https://www.wowhead.com/wotlk/cn/npc=12036
UPDATE `creature_template_locale` SET `Name` = '鹰巢山杂货商人' WHERE `locale` = 'zhCN' AND `entry` = 12036;
-- OLD name : 布朗尼克·铁胃
-- Source : https://www.wowhead.com/wotlk/cn/npc=12040
UPDATE `creature_template_locale` SET `Name` = '鹰巢山锁甲商' WHERE `locale` = 'zhCN' AND `entry` = 12040;
-- OLD name : 火妖护卫
-- Source : https://www.wowhead.com/wotlk/cn/npc=12119
UPDATE `creature_template_locale` SET `Name` = '烈焰行者护卫' WHERE `locale` = 'zhCN' AND `entry` = 12119;
-- OLD name : 天灾白蚁
-- Source : https://www.wowhead.com/wotlk/cn/npc=12120
UPDATE `creature_template_locale` SET `Name` = '瘟疫白蚁' WHERE `locale` = 'zhCN' AND `entry` = 12120;
-- OLD name : 德拉卡
-- Source : https://www.wowhead.com/wotlk/cn/npc=12121
UPDATE `creature_template_locale` SET `Name` = '德拉坎' WHERE `locale` = 'zhCN' AND `entry` = 12121;
-- OLD name : 火妖卫兵
-- Source : https://www.wowhead.com/wotlk/cn/npc=12142
UPDATE `creature_template_locale` SET `Name` = '烈焰行者卫兵' WHERE `locale` = 'zhCN' AND `entry` = 12142;
-- OLD name : 蓝色科多兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=12148
UPDATE `creature_template_locale` SET `Name` = 'Riding Kodo (Teal)' WHERE `locale` = 'zhCN' AND `entry` = 12148;
-- OLD name : 灰色科多兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=12149
UPDATE `creature_template_locale` SET `Name` = '骑乘用科多兽（灰色）' WHERE `locale` = 'zhCN' AND `entry` = 12149;
-- OLD name : 绿色科多兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=12151
UPDATE `creature_template_locale` SET `Name` = '骑乘用科多兽（绿色）' WHERE `locale` = 'zhCN' AND `entry` = 12151;
-- OLD name : 人类徽记
-- Source : https://www.wowhead.com/wotlk/cn/npc=12202
UPDATE `creature_template_locale` SET `Name` = '人类颅骨' WHERE `locale` = 'zhCN' AND `entry` = 12202;
-- OLD name : 杂斑赤色迅猛龙
-- Source : https://www.wowhead.com/wotlk/cn/npc=12345
UPDATE `creature_template_locale` SET `Name` = '红色迅猛龙' WHERE `locale` = 'zhCN' AND `entry` = 12345;
-- OLD name : 绿色迅猛龙坐骑
-- Source : https://www.wowhead.com/wotlk/cn/npc=12346
UPDATE `creature_template_locale` SET `Name` = '绿色迅猛龙' WHERE `locale` = 'zhCN' AND `entry` = 12346;
-- OLD name : 青色迅猛龙坐骑
-- Source : https://www.wowhead.com/wotlk/cn/npc=12349
UPDATE `creature_template_locale` SET `Name` = '青色迅猛龙' WHERE `locale` = 'zhCN' AND `entry` = 12349;
-- OLD name : 紫色骑乘迅猛龙
-- Source : https://www.wowhead.com/wotlk/cn/npc=12350
UPDATE `creature_template_locale` SET `Name` = '紫色迅猛龙' WHERE `locale` = 'zhCN' AND `entry` = 12350;
-- OLD name : 骑乘用条纹夜刃豹
-- Source : https://www.wowhead.com/wotlk/cn/npc=12360
UPDATE `creature_template_locale` SET `Name` = '骑乘用斑纹夜刃豹' WHERE `locale` = 'zhCN' AND `entry` = 12360;
-- OLD name : 暗网编织者克雷希斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=12433
UPDATE `creature_template_locale` SET `Name` = '克雷希斯' WHERE `locale` = 'zhCN' AND `entry` = 12433;
-- OLD name : 死爪龙人护卫
-- Source : https://www.wowhead.com/wotlk/cn/npc=12460
UPDATE `creature_template_locale` SET `Name` = '黑翼龙人护卫' WHERE `locale` = 'zhCN' AND `entry` = 12460;
-- OLD name : 死爪监工
-- Source : https://www.wowhead.com/wotlk/cn/npc=12461
UPDATE `creature_template_locale` SET `Name` = '黑翼监工' WHERE `locale` = 'zhCN' AND `entry` = 12461;
-- OLD name : 翡翠智者
-- Source : https://www.wowhead.com/wotlk/cn/npc=12476
UPDATE `creature_template_locale` SET `Name` = '翡翠圣贤' WHERE `locale` = 'zhCN' AND `entry` = 12476;
-- OLD name : 尖爪
-- Source : https://www.wowhead.com/wotlk/cn/npc=12676
UPDATE `creature_template_locale` SET `Name` = '沙普塔隆' WHERE `locale` = 'zhCN' AND `entry` = 12676;
-- OLD name : 猎影
-- Source : https://www.wowhead.com/wotlk/cn/npc=12677
UPDATE `creature_template_locale` SET `Name` = '萨杜布拉' WHERE `locale` = 'zhCN' AND `entry` = 12677;
-- OLD name : 潘兰希尔女士
-- Source : https://www.wowhead.com/wotlk/cn/npc=12792
UPDATE `creature_template_locale` SET `Name` = '帕兰蒂尔' WHERE `locale` = 'zhCN' AND `entry` = 12792;
-- OLD name : [PH] TEST Fire God (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=12804
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 12804;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/cn/npc=12807
UPDATE `creature_template_locale` SET `Title` = '恶魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 12807;
-- OLD name : 碎木岗哨守卫
-- Source : https://www.wowhead.com/wotlk/cn/npc=12903
UPDATE `creature_template_locale` SET `Name` = '碎木岗哨卫兵' WHERE `locale` = 'zhCN' AND `entry` = 12903;
-- OLD subname : 急救训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=12939
UPDATE `creature_template_locale` SET `Title` = '外科医疗队' WHERE `locale` = 'zhCN' AND `entry` = 12939;
-- OLD name : 布里莫·加基斯宾
-- Source : https://www.wowhead.com/wotlk/cn/npc=12957
UPDATE `creature_template_locale` SET `Name` = '布里莫' WHERE `locale` = 'zhCN' AND `entry` = 12957;
-- OLD name : 戈多克猎犬
-- Source : https://www.wowhead.com/wotlk/cn/npc=13036
UPDATE `creature_template_locale` SET `Name` = '戈多克驯狼' WHERE `locale` = 'zhCN' AND `entry` = 13036;
-- OLD name : Commander Dardosh <old>
-- Source : https://www.wowhead.com/wotlk/cn/npc=13140
UPDATE `creature_template_locale` SET `Name` = '指挥官达多什' WHERE `locale` = 'zhCN' AND `entry` = 13140;
-- OLD name : Lieutenant Murp <old>
-- Source : https://www.wowhead.com/wotlk/cn/npc=13146
UPDATE `creature_template_locale` SET `Name` = '莫普中尉' WHERE `locale` = 'zhCN' AND `entry` = 13146;
-- OLD name : 乔雷克·铁盾
-- Source : https://www.wowhead.com/wotlk/cn/npc=13219
UPDATE `creature_template_locale` SET `Name` = '耶克里·弗兰迪' WHERE `locale` = 'zhCN' AND `entry` = 13219;
-- OLD name : 小青蛙
-- Source : https://www.wowhead.com/wotlk/cn/npc=13321
UPDATE `creature_template_locale` SET `Name` = '青蛙' WHERE `locale` = 'zhCN' AND `entry` = 13321;
-- OLD name : 赞巴莱, subname : 德鲁伊训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=13476
UPDATE `creature_template_locale` SET `Name` = '巴莱·洛克维',`Title` = '药剂、卷轴和材料' WHERE `locale` = 'zhCN' AND `entry` = 13476;
-- OLD name : 讨厌的格林奇
-- Source : https://www.wowhead.com/wotlk/cn/npc=13602
UPDATE `creature_template_locale` SET `Name` = '格林奇' WHERE `locale` = 'zhCN' AND `entry` = 13602;
-- OLD name : [PH] Graveyard Herald (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=14181
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 14181;
-- OLD subname : 辛德拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=14358
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 14358;
-- OLD subname : 辛德拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=14364
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 14364;
-- OLD subname : 辛德拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=14368
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 14368;
-- OLD subname : 辛德拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=14369
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 14369;
-- OLD subname : 辛德拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=14371
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 14371;
-- OLD subname : 辛德拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=14381
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 14381;
-- OLD subname : 辛德拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=14382
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 14382;
-- OLD subname : 辛德拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=14383
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 14383;
-- OLD name : 暴怒图腾捕猎者
-- Source : https://www.wowhead.com/wotlk/cn/npc=14441
UPDATE `creature_template_locale` SET `Name` = '捕猎者拉图特' WHERE `locale` = 'zhCN' AND `entry` = 14441;
-- OLD name : 维尔玛克中尉
-- Source : https://www.wowhead.com/wotlk/cn/npc=14445
UPDATE `creature_template_locale` SET `Name` = '维尔玛克将军' WHERE `locale` = 'zhCN' AND `entry` = 14445;
-- OLD name : 被感染的农夫
-- Source : https://www.wowhead.com/wotlk/cn/npc=14485
UPDATE `creature_template_locale` SET `Name` = '感染瘟疫的农夫' WHERE `locale` = 'zhCN' AND `entry` = 14485;
-- OLD subname : 克尔苏加德的爪牙
-- Source : https://www.wowhead.com/wotlk/cn/npc=14486
UPDATE `creature_template_locale` SET `Title` = '科尔苏加德的爪牙' WHERE `locale` = 'zhCN' AND `entry` = 14486;
-- OLD name : 雷角中士
-- Source : https://www.wowhead.com/wotlk/cn/npc=14581
UPDATE `creature_template_locale` SET `Name` = '军士霍斯·雷角' WHERE `locale` = 'zhCN' AND `entry` = 14581;
-- OLD name : [PH] Horde spell thrower (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=14641
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 14641;
-- OLD name : [PH] Alliance Spell thrower (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=14642
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 14642;
-- OLD name : [PH] Alliance Herald (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=14643
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 14643;
-- OLD name : [PH] Horde Herald (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=14644
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 14644;
-- OLD name : 萨杜瓦尔王子
-- Source : https://www.wowhead.com/wotlk/cn/npc=14688
UPDATE `creature_template_locale` SET `Name` = '萨杜瓦尔' WHERE `locale` = 'zhCN' AND `entry` = 14688;
-- OLD name : 蛛魔织网者
-- Source : https://www.wowhead.com/wotlk/cn/npc=14705
UPDATE `creature_template_locale` SET `Name` = '尼拉布织网者' WHERE `locale` = 'zhCN' AND `entry` = 14705;
-- OLD name : [PH] Alliance Tower Lieutenant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=14719
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 14719;
-- OLD name : 艾法希比元帅
-- Source : https://www.wowhead.com/wotlk/cn/npc=14721
UPDATE `creature_template_locale` SET `Name` = '斯托布里奇元帅' WHERE `locale` = 'zhCN' AND `entry` = 14721;
-- OLD name : [PH] Horde Tower Lieutenant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=14746
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 14746;
-- OLD subname : 纪念品与玩具奖励
-- Source : https://www.wowhead.com/wotlk/cn/npc=14828
UPDATE `creature_template_locale` SET `Title` = '暗月马戏团奖券兑换员' WHERE `locale` = 'zhCN' AND `entry` = 14828;
-- OLD subname : 饮料商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=14844
UPDATE `creature_template_locale` SET `Title` = '暗月马戏团饮料商' WHERE `locale` = 'zhCN' AND `entry` = 14844;
-- OLD subname : 食品商
-- Source : https://www.wowhead.com/wotlk/cn/npc=14845
UPDATE `creature_template_locale` SET `Title` = '暗月马戏团食品商' WHERE `locale` = 'zhCN' AND `entry` = 14845;
-- OLD subname : 宠物与坐骑奖励
-- Source : https://www.wowhead.com/wotlk/cn/npc=14846
UPDATE `creature_template_locale` SET `Title` = '暗月马戏团特殊商品' WHERE `locale` = 'zhCN' AND `entry` = 14846;
-- OLD subname : 暗月卡片商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=14847
UPDATE `creature_template_locale` SET `Title` = '暗月马戏团卡片和特殊商品销售员' WHERE `locale` = 'zhCN' AND `entry` = 14847;
-- OLD name : 暗月艺人
-- Source : https://www.wowhead.com/wotlk/cn/npc=14849
UPDATE `creature_template_locale` SET `Name` = '暗月马戏团艺人' WHERE `locale` = 'zhCN' AND `entry` = 14849;
-- OLD name : 迷你鸡蛇兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=14869
UPDATE `creature_template_locale` SET `Name` = '派格米' WHERE `locale` = 'zhCN' AND `entry` = 14869;
-- OLD subname : 新潮服装设计师
-- Source : https://www.wowhead.com/wotlk/cn/npc=15165
UPDATE `creature_template_locale` SET `Title` = '新潮设计师' WHERE `locale` = 'zhCN' AND `entry` = 15165;
-- OLD name : [PH] Luis Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15167
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15167;
-- OLD name : 希尔瓦娜斯·风行者
-- Source : https://www.wowhead.com/wotlk/cn/npc=15193
UPDATE `creature_template_locale` SET `Name` = '女妖之王' WHERE `locale` = 'zhCN' AND `entry` = 15193;
-- OLD name : 梦境之雾
-- Source : https://www.wowhead.com/wotlk/cn/npc=15224
UPDATE `creature_template_locale` SET `Name` = '梦雾' WHERE `locale` = 'zhCN' AND `entry` = 15224;
-- OLD name : [UNUSED] Vekniss Hiveshaper (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15227
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15227;
-- OLD name : [UNUSED] Vekniss Wellborer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15228
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15228;
-- OLD name : [UNUSED] Vekniss Patroller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15231
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15231;
-- OLD name : [UNUSED] Vekniss Eradicator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15232
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15232;
-- OLD name : 玛克希玛·雷管
-- Source : https://www.wowhead.com/wotlk/cn/npc=15303
UPDATE `creature_template_locale` SET `Name` = '玛克希玛' WHERE `locale` = 'zhCN' AND `entry` = 15303;
-- OLD name : [UNUSED] Hive'Zara Ambusher (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15322
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15322;
-- OLD name : [UNUSED] Hive'Zara Swarmer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15326
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15326;
-- OLD name : [UNUSED] Hive'Zara Scout (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15329
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15329;
-- OLD name : [UNUSED] Sand Borer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15330
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15330;
-- OLD name : [UNUSED] Dune Tunneler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15331
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15331;
-- OLD name : [UNUSED] Crystal Feeder (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15332
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15332;
-- OLD name : [UNUSED] Sand Mold (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15337
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15337;
-- OLD name : [UNUSED] Sphinx (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15342
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15342;
-- OLD name : [UNUSED] Daughter of Hecate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15345
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15345;
-- OLD name : [UNUSED] Qiraji Wasprider (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15346
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15346;
-- OLD name : [UNUSED] Qiraji Wasplord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15347
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15347;
-- OLD name : RC Blimp <PH>, subname : NONE
-- Source : https://www.wowhead.com/wotlk/cn/npc=15349
UPDATE `creature_template_locale` SET `Name` = 'RC Blimp',`Title` = 'PH' WHERE `locale` = 'zhCN' AND `entry` = 15349;
-- OLD name : RC Mortar Tank <PH>, subname : NONE
-- Source : https://www.wowhead.com/wotlk/cn/npc=15364
UPDATE `creature_template_locale` SET `Name` = 'RC Mortar Tank',`Title` = 'PH' WHERE `locale` = 'zhCN' AND `entry` = 15364;
-- OLD name : 阿瑞苟斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=15380
UPDATE `creature_template_locale` SET `Name` = '亚雷戈斯' WHERE `locale` = 'zhCN' AND `entry` = 15380;
-- OLD name : 阿瑞苟斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=15411
UPDATE `creature_template_locale` SET `Name` = '亚雷戈斯龙类形态' WHERE `locale` = 'zhCN' AND `entry` = 15411;
-- OLD name : [UNUSED] Deep Ooze (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15472
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15472;
-- OLD name : 甲虫
-- Source : https://www.wowhead.com/wotlk/cn/npc=15475
UPDATE `creature_template_locale` SET `Name` = '甲壳虫' WHERE `locale` = 'zhCN' AND `entry` = 15475;
-- OLD name : 火焰新星图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=15483
UPDATE `creature_template_locale` SET `Name` = '火焰新星图腾 VII' WHERE `locale` = 'zhCN' AND `entry` = 15483;
-- OLD name : 石头守卫陶蹄
-- Source : https://www.wowhead.com/wotlk/cn/npc=15532
UPDATE `creature_template_locale` SET `Name` = '尼根·陶蹄' WHERE `locale` = 'zhCN' AND `entry` = 15532;
-- OLD name : 长者伊萨·麦蹄
-- Source : https://www.wowhead.com/wotlk/cn/npc=15580
UPDATE `creature_template_locale` SET `Name` = '傲角长者' WHERE `locale` = 'zhCN' AND `entry` = 15580;
-- OLD name : 星眼长者
-- Source : https://www.wowhead.com/wotlk/cn/npc=15584
UPDATE `creature_template_locale` SET `Name` = '星灵长者' WHERE `locale` = 'zhCN' AND `entry` = 15584;
-- OLD name : 晨行者长者
-- Source : https://www.wowhead.com/wotlk/cn/npc=15585
UPDATE `creature_template_locale` SET `Name` = '晨行长者' WHERE `locale` = 'zhCN' AND `entry` = 15585;
-- OLD name : 迷雾行者长者
-- Source : https://www.wowhead.com/wotlk/cn/npc=15587
UPDATE `creature_template_locale` SET `Name` = '迷雾长者' WHERE `locale` = 'zhCN' AND `entry` = 15587;
-- OLD name : 袭月长者
-- Source : https://www.wowhead.com/wotlk/cn/npc=15594
UPDATE `creature_template_locale` SET `Name` = '月击长者' WHERE `locale` = 'zhCN' AND `entry` = 15594;
-- OLD name : 刃叶长者
-- Source : https://www.wowhead.com/wotlk/cn/npc=15595
UPDATE `creature_template_locale` SET `Name` = '锋叶长者' WHERE `locale` = 'zhCN' AND `entry` = 15595;
-- OLD name : 月卫长者
-- Source : https://www.wowhead.com/wotlk/cn/npc=15597
UPDATE `creature_template_locale` SET `Name` = '月光长者' WHERE `locale` = 'zhCN' AND `entry` = 15597;
-- OLD name : 塞纳里奥斥候加莉亚
-- Source : https://www.wowhead.com/wotlk/cn/npc=15611
UPDATE `creature_template_locale` SET `Name` = '塞纳里奥斥候佳莉亚' WHERE `locale` = 'zhCN' AND `entry` = 15611;
-- OLD name : 加洛德·影歌
-- Source : https://www.wowhead.com/wotlk/cn/npc=15627
UPDATE `creature_template_locale` SET `Name` = '亚罗德·影歌' WHERE `locale` = 'zhCN' AND `entry` = 15627;
-- OLD subname : 艾露恩的高阶女祭司
-- Source : https://www.wowhead.com/wotlk/cn/npc=15633
UPDATE `creature_template_locale` SET `Title` = '艾露恩的高阶祭司' WHERE `locale` = 'zhCN' AND `entry` = 15633;
-- OLD name : [Unused] Auctioneer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=15672
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15672;
-- OLD name : Blue Qiraji Battle Tank
-- Source : https://www.wowhead.com/wotlk/cn/npc=15713
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 15713;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15713, 'zhCN','蓝色其拉作战坦克',NULL);
-- OLD name : Resonating Crystal Formation 31 - 40
-- Source : https://www.wowhead.com/wotlk/cn/npc=15769
UPDATE `creature_template_locale` SET `Name` = '小型共鸣水晶' WHERE `locale` = 'zhCN' AND `entry` = 15769;
-- OLD name : Resonating Crystal Formation 41 - 50
-- Source : https://www.wowhead.com/wotlk/cn/npc=15770
UPDATE `creature_template_locale` SET `Name` = '强效共鸣水晶' WHERE `locale` = 'zhCN' AND `entry` = 15770;
-- OLD name : Resonating Crystal Formation 51 - 60
-- Source : https://www.wowhead.com/wotlk/cn/npc=15771
UPDATE `creature_template_locale` SET `Name` = '大型共鸣水晶' WHERE `locale` = 'zhCN' AND `entry` = 15771;
-- OLD name : Resonating Crystal Formation 21-30
-- Source : https://www.wowhead.com/wotlk/cn/npc=15804
UPDATE `creature_template_locale` SET `Name` = '次级共鸣水晶' WHERE `locale` = 'zhCN' AND `entry` = 15804;
-- OLD name : Resonating Crystal Formation 10 - 20
-- Source : https://www.wowhead.com/wotlk/cn/npc=15805
UPDATE `creature_template_locale` SET `Name` = '小型共鸣水晶' WHERE `locale` = 'zhCN' AND `entry` = 15805;
-- OLD subname : 辛德拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=16032
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 16032;
-- OLD name : [UNUSED] Bog Beast B [PH]
-- Source : https://www.wowhead.com/wotlk/cn/npc=16035
UPDATE `creature_template_locale` SET `Name` = 'Bog Beast B [PH]' WHERE `locale` = 'zhCN' AND `entry` = 16035;
-- OLD name : [UNUSED] Deathhound
-- Source : https://www.wowhead.com/wotlk/cn/npc=16038
UPDATE `creature_template_locale` SET `Name` = '死亡犬' WHERE `locale` = 'zhCN' AND `entry` = 16038;
-- OLD name : [PH] Alex's Test DPS Mob (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=16077
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 16077;
-- OLD name : 幽灵狮鹫
-- Source : https://www.wowhead.com/wotlk/cn/npc=16081
UPDATE `creature_template_locale` SET `Name` = '鬼灵狮鹫' WHERE `locale` = 'zhCN' AND `entry` = 16081;
-- OLD name : 十字军指挥官科尔法克斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=16112
UPDATE `creature_template_locale` SET `Name` = '科尔法克斯，圣光之勇士' WHERE `locale` = 'zhCN' AND `entry` = 16112;
-- OLD name : 十字军指挥官埃里戈尔·黎明使者
-- Source : https://www.wowhead.com/wotlk/cn/npc=16115
UPDATE `creature_template_locale` SET `Name` = '指挥官埃里戈尔·黎明使者' WHERE `locale` = 'zhCN' AND `entry` = 16115;
-- OLD name : [UNUSED] Scourge Invasion Guardian (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=16138
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 16138;
-- OLD name : [UNUSED] Necropolis Crystal, Buttress (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=16140
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 16140;
-- OLD name : [UNUSED] Buttress Channeler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=16188
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 16188;
-- OLD name : 天灾毒虫
-- Source : https://www.wowhead.com/wotlk/cn/npc=16233
UPDATE `creature_template_locale` SET `Name` = '瘟疫毒虫' WHERE `locale` = 'zhCN' AND `entry` = 16233;
-- OLD name : 天灾血肉触须
-- Source : https://www.wowhead.com/wotlk/cn/npc=16235
UPDATE `creature_template_locale` SET `Name` = '瘟疫血肉触须' WHERE `locale` = 'zhCN' AND `entry` = 16235;
-- OLD subname : Rogue Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=16279
UPDATE `creature_template_locale` SET `Title` = '潜行者训练师' WHERE `locale` = 'zhCN' AND `entry` = 16279;
-- OLD name : 变形蟑螂
-- Source : https://www.wowhead.com/wotlk/cn/npc=16374
UPDATE `creature_template_locale` SET `Name` = '小强' WHERE `locale` = 'zhCN' AND `entry` = 16374;
-- OLD subname : 银色北伐军
-- Source : https://www.wowhead.com/wotlk/cn/npc=16378
UPDATE `creature_template_locale` SET `Title` = '银色黎明' WHERE `locale` = 'zhCN' AND `entry` = 16378;
-- OLD name : 大法师塔希斯·基莫迪尔
-- Source : https://www.wowhead.com/wotlk/cn/npc=16381
UPDATE `creature_template_locale` SET `Name` = '大法师塔希斯-基莫迪尔' WHERE `locale` = 'zhCN' AND `entry` = 16381;
-- OLD name : 调酒师日灼
-- Source : https://www.wowhead.com/wotlk/cn/npc=16442
UPDATE `creature_template_locale` SET `Name` = '调酒师桑塔基德' WHERE `locale` = 'zhCN' AND `entry` = 16442;
-- OLD name : [UNUSED] Death Knight Vindicator
-- Source : https://www.wowhead.com/wotlk/cn/npc=16451
UPDATE `creature_template_locale` SET `Name` = '死亡骑士辩护者' WHERE `locale` = 'zhCN' AND `entry` = 16451;
-- OLD name : 妖女
-- Source : https://www.wowhead.com/wotlk/cn/npc=16461
UPDATE `creature_template_locale` SET `Name` = '狂热情人' WHERE `locale` = 'zhCN' AND `entry` = 16461;
-- OLD subname : 草药学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=16527
UPDATE `creature_template_locale` SET `Title` = '宗师级草药学训练师' WHERE `locale` = 'zhCN' AND `entry` = 16527;
-- OLD name : 接种疫苗的木巢枭兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=16534
UPDATE `creature_template_locale` SET `Name` = '感染的木巢枭兽' WHERE `locale` = 'zhCN' AND `entry` = 16534;
-- OLD name : 扭扭先生
-- Source : https://www.wowhead.com/wotlk/cn/npc=16548
UPDATE `creature_template_locale` SET `Name` = '哼哼先生' WHERE `locale` = 'zhCN' AND `entry` = 16548;
-- OLD name : 蘑菇兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=16565
UPDATE `creature_template_locale` SET `Name` = 'Myconite Warrior (PH)' WHERE `locale` = 'zhCN' AND `entry` = 16565;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=16583
UPDATE `creature_template_locale` SET `Title` = '宗师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 16583;
-- OLD name : 药剂师安东尼维奇, subname : 炼金术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=16588
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 16588;
-- OLD name : Bri's Test Character
-- Source : https://www.wowhead.com/wotlk/cn/npc=16605
UPDATE `creature_template_locale` SET `Name` = 'Brianna Schneider' WHERE `locale` = 'zhCN' AND `entry` = 16605;
-- OLD name : [PH] Goblin Savage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=16608
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 16608;
-- OLD name : 拍卖师伊西利安, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/cn/npc=16627
UPDATE `creature_template_locale` SET `Name` = '伊西利安',`Title` = '拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 16627;
-- OLD name : 拍卖师塞多里, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/cn/npc=16628
UPDATE `creature_template_locale` SET `Name` = '塞多里',`Title` = '拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 16628;
-- OLD name : 拍卖师坦德隆, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/cn/npc=16629
UPDATE `creature_template_locale` SET `Name` = '坦德隆',`Title` = '拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 16629;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=16676
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 16676;
-- OLD name : 拍卖师艾欧克, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/cn/npc=16707
UPDATE `creature_template_locale` SET `Name` = '艾欧克',`Title` = '拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 16707;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=16719
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 16719;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/cn/npc=16720
UPDATE `creature_template_locale` SET `Title` = '恶魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 16720;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/cn/npc=16773
UPDATE `creature_template_locale` SET `Title` = '武器大师' WHERE `locale` = 'zhCN' AND `entry` = 16773;
-- OLD name : 天灾软泥（蓝）
-- Source : https://www.wowhead.com/wotlk/cn/npc=16783
UPDATE `creature_template_locale` SET `Name` = '瘟疫软泥（蓝）' WHERE `locale` = 'zhCN' AND `entry` = 16783;
-- OLD name : 天灾软泥（红）
-- Source : https://www.wowhead.com/wotlk/cn/npc=16784
UPDATE `creature_template_locale` SET `Name` = '瘟疫软泥（红）' WHERE `locale` = 'zhCN' AND `entry` = 16784;
-- OLD name : 天灾软泥（绿）
-- Source : https://www.wowhead.com/wotlk/cn/npc=16785
UPDATE `creature_template_locale` SET `Name` = '瘟疫软泥（绿）' WHERE `locale` = 'zhCN' AND `entry` = 16785;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=16823
UPDATE `creature_template_locale` SET `Title` = '大师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 16823;
-- OLD name : [UNUSED] Death Lord
-- Source : https://www.wowhead.com/wotlk/cn/npc=16861
UPDATE `creature_template_locale` SET `Name` = '死亡领主' WHERE `locale` = 'zhCN' AND `entry` = 16861;
-- OLD name : 闻巽
-- Source : https://www.wowhead.com/wotlk/cn/npc=16868
UPDATE `creature_template_locale` SET `Name` = '嘲颅斩杀者' WHERE `locale` = 'zhCN' AND `entry` = 16868;
-- OLD name : 纪辛
-- Source : https://www.wowhead.com/wotlk/cn/npc=16869
UPDATE `creature_template_locale` SET `Name` = '嘲颅新兵' WHERE `locale` = 'zhCN' AND `entry` = 16869;
-- OLD name : [Unused] Marauding Crust Burster Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=16914
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 16914;
-- OLD name : 天灾卫士
-- Source : https://www.wowhead.com/wotlk/cn/npc=16981
UPDATE `creature_template_locale` SET `Name` = '瘟疫卫士' WHERE `locale` = 'zhCN' AND `entry` = 16981;
-- OLD name : 天灾构造体
-- Source : https://www.wowhead.com/wotlk/cn/npc=16982
UPDATE `creature_template_locale` SET `Name` = '瘟疫构造体' WHERE `locale` = 'zhCN' AND `entry` = 16982;
-- OLD name : [Unused] Crust Burster Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=17001
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 17001;
-- OLD name : “利爪”安吉拉·凯斯提尔
-- Source : https://www.wowhead.com/wotlk/cn/npc=17002
UPDATE `creature_template_locale` SET `Name` = '"利爪"安吉拉·凯斯提尔' WHERE `locale` = 'zhCN' AND `entry` = 17002;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/cn/npc=17005
UPDATE `creature_template_locale` SET `Title` = '武器大师' WHERE `locale` = 'zhCN' AND `entry` = 17005;
-- OLD name : 顾问萨苏恩·誓日
-- Source : https://www.wowhead.com/wotlk/cn/npc=17100
UPDATE `creature_template_locale` SET `Name` = '顾问萨苏恩·火盟' WHERE `locale` = 'zhCN' AND `entry` = 17100;
-- OLD subname : Mage Trainer
-- Source : https://www.wowhead.com/wotlk/cn/npc=17105
UPDATE `creature_template_locale` SET `Title` = '法师训练师' WHERE `locale` = 'zhCN' AND `entry` = 17105;
-- OLD name : [Unused] Tunneler Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=17234
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 17234;
-- OLD name : [PH] Plaguelands Herald (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=17239
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 17239;
-- OLD subname : 锻造训练师与供应商
-- Source : https://www.wowhead.com/wotlk/cn/npc=17245
UPDATE `creature_template_locale` SET `Title` = '锻造训练师和商人' WHERE `locale` = 'zhCN' AND `entry` = 17245;
-- OLD name : “曲奇”米维克索斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=17246
UPDATE `creature_template_locale` SET `Name` = '"曲奇"米维克索斯' WHERE `locale` = 'zhCN' AND `entry` = 17246;
-- OLD name : 天灾波
-- Source : https://www.wowhead.com/wotlk/cn/npc=17293
UPDATE `creature_template_locale` SET `Name` = '瘟疫波' WHERE `locale` = 'zhCN' AND `entry` = 17293;
-- OLD name : Slim's Unkillable Test Dummy
-- Source : https://www.wowhead.com/wotlk/cn/npc=17313
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy Spammer' WHERE `locale` = 'zhCN' AND `entry` = 17313;
-- OLD name : [UNUSED] Shadowmoon Firestarter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=17463
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 17463;
-- OLD name : 地狱火训练假人
-- Source : https://www.wowhead.com/wotlk/cn/npc=17578
UPDATE `creature_template_locale` SET `Name` = '训练假人' WHERE `locale` = 'zhCN' AND `entry` = 17578;
-- OLD name : [PH] Captain Obvious Jr. (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=17597
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 17597;
-- OLD subname : Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/cn/npc=17598
UPDATE `creature_template_locale` SET `Title` = '军火商' WHERE `locale` = 'zhCN' AND `entry` = 17598;
-- OLD name : 拍卖师耶纳斯, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/cn/npc=17627
UPDATE `creature_template_locale` SET `Name` = '耶纳斯',`Title` = '拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 17627;
-- OLD name : 拍卖师维纳, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/cn/npc=17628
UPDATE `creature_template_locale` SET `Name` = '维纳',`Title` = '拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 17628;
-- OLD name : 拍卖师菲恩娜, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/cn/npc=17629
UPDATE `creature_template_locale` SET `Name` = '菲恩娜',`Title` = '拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 17629;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=17634
UPDATE `creature_template_locale` SET `Title` = '大师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 17634;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=17637
UPDATE `creature_template_locale` SET `Title` = '宗师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 17637;
-- OLD name : [UNUSED] Lykul Larva (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=17733
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 17733;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (17733, 'zhCN','NPC',NULL);
-- OLD name : [UNUSED] Lost Goblin [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=17813
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 17813;
-- OLD name : [DND]Sunhawk Portal Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=17886
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 17886;
-- OLD name : [UNUSED] Coilfang Watcher [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=17939
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 17939;
-- OLD subname : 艾露恩的高阶女祭司
-- Source : https://www.wowhead.com/wotlk/cn/npc=17948
UPDATE `creature_template_locale` SET `Title` = '艾露恩的高阶祭司' WHERE `locale` = 'zhCN' AND `entry` = 17948;
-- OLD name : Open Portal Target
-- Source : https://www.wowhead.com/wotlk/cn/npc=17965
UPDATE `creature_template_locale` SET `Name` = 'Dark Portal Target UNUSED' WHERE `locale` = 'zhCN' AND `entry` = 17965;
-- OLD name : Doomfire Spirit
-- Source : https://www.wowhead.com/wotlk/cn/npc=18104
UPDATE `creature_template_locale` SET `Name` = 'Doomfire Targeting' WHERE `locale` = 'zhCN' AND `entry` = 18104;
-- OLD name : 堕落新星图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=18179
UPDATE `creature_template_locale` SET `Name` = '腐化新星图腾' WHERE `locale` = 'zhCN' AND `entry` = 18179;
-- OLD name : “好儿子”沙度·远行者
-- Source : https://www.wowhead.com/wotlk/cn/npc=18200
UPDATE `creature_template_locale` SET `Name` = '"好儿子"沙度·远行者' WHERE `locale` = 'zhCN' AND `entry` = 18200;
-- OLD name : “伯爵”昂古拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=18285
UPDATE `creature_template_locale` SET `Name` = '"伯爵"昂古拉' WHERE `locale` = 'zhCN' AND `entry` = 18285;
-- OLD name : 迷失的占卜者
-- Source : https://www.wowhead.com/wotlk/cn/npc=18319
UPDATE `creature_template_locale` SET `Name` = '迷时的占卜者' WHERE `locale` = 'zhCN' AND `entry` = 18319;
-- OLD name : 迷失的暗影法师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18320
UPDATE `creature_template_locale` SET `Name` = '迷时的暗影法师' WHERE `locale` = 'zhCN' AND `entry` = 18320;
-- OLD name : 迷失的控制者
-- Source : https://www.wowhead.com/wotlk/cn/npc=18327
UPDATE `creature_template_locale` SET `Name` = '迷时的控制者' WHERE `locale` = 'zhCN' AND `entry` = 18327;
-- OLD name : [UNUSED] Sethekk Magelord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=18329
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 18329;
-- OLD name : 拍卖师凡尼, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/cn/npc=18348
UPDATE `creature_template_locale` SET `Name` = '凡尼',`Title` = '拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 18348;
-- OLD name : 拍卖师伊蕾萨, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/cn/npc=18349
UPDATE `creature_template_locale` SET `Name` = '伊蕾萨',`Title` = '拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 18349;
-- OLD name : [UNUSED] Dusty Skeleton [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=18355
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 18355;
-- OLD name : 迅捷紫色狮鹫
-- Source : https://www.wowhead.com/wotlk/cn/npc=18362
UPDATE `creature_template_locale` SET `Name` = 'Outland Gryphon Mount Armored (Purple)' WHERE `locale` = 'zhCN' AND `entry` = 18362;
-- OLD name : 蓝色驭风者
-- Source : https://www.wowhead.com/wotlk/cn/npc=18364
UPDATE `creature_template_locale` SET `Name` = 'Outland Wyvern Mount (Blue)' WHERE `locale` = 'zhCN' AND `entry` = 18364;
-- OLD name : 绿色驭风者
-- Source : https://www.wowhead.com/wotlk/cn/npc=18365
UPDATE `creature_template_locale` SET `Name` = 'Outland Wyvern Mount (Green)' WHERE `locale` = 'zhCN' AND `entry` = 18365;
-- OLD name : [UNUSED] Draenei Spirit [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=18367
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 18367;
-- OLD name : 迅捷红色驭风者
-- Source : https://www.wowhead.com/wotlk/cn/npc=18377
UPDATE `creature_template_locale` SET `Name` = 'Outland Wyvern Mount Armored (Standard)' WHERE `locale` = 'zhCN' AND `entry` = 18377;
-- OLD name : 迅捷绿色驭风者
-- Source : https://www.wowhead.com/wotlk/cn/npc=18378
UPDATE `creature_template_locale` SET `Name` = 'Outland Wyvern Mount Armored (Green)' WHERE `locale` = 'zhCN' AND `entry` = 18378;
-- OLD name : 迅捷紫色驭风者
-- Source : https://www.wowhead.com/wotlk/cn/npc=18379
UPDATE `creature_template_locale` SET `Name` = 'Outland Wyvern Mount Armored (Purple)' WHERE `locale` = 'zhCN' AND `entry` = 18379;
-- OLD name : 迅捷黄色驭风者
-- Source : https://www.wowhead.com/wotlk/cn/npc=18380
UPDATE `creature_template_locale` SET `Name` = 'Outland Wyvern Mount Armored (Yellow)' WHERE `locale` = 'zhCN' AND `entry` = 18380;
-- OLD name : 迅捷蓝色狮鹫
-- Source : https://www.wowhead.com/wotlk/cn/npc=18406
UPDATE `creature_template_locale` SET `Name` = 'Outland Gryphon Mount Armored (Standard)' WHERE `locale` = 'zhCN' AND `entry` = 18406;
-- OLD name : 奥的灰烬
-- Source : https://www.wowhead.com/wotlk/cn/npc=18545
UPDATE `creature_template_locale` SET `Name` = 'Peep the Outland Phoenix' WHERE `locale` = 'zhCN' AND `entry` = 18545;
-- OLD name : [UNUSED]Anchorite Lyteera (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=18674
UPDATE `creature_template_locale` SET `Name` = '召唤炸药包' WHERE `locale` = 'zhCN' AND `entry` = 18674;
-- OLD subname : 采矿训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18747
UPDATE `creature_template_locale` SET `Title` = '大师级采矿训练师' WHERE `locale` = 'zhCN' AND `entry` = 18747;
-- OLD subname : 草药学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18748
UPDATE `creature_template_locale` SET `Title` = '大师级草药学训练师' WHERE `locale` = 'zhCN' AND `entry` = 18748;
-- OLD subname : 裁缝训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18749
UPDATE `creature_template_locale` SET `Title` = '大师级裁缝训练师' WHERE `locale` = 'zhCN' AND `entry` = 18749;
-- OLD subname : 珠宝加工训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18751
UPDATE `creature_template_locale` SET `Title` = '大师级珠宝加工训练师' WHERE `locale` = 'zhCN' AND `entry` = 18751;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18752
UPDATE `creature_template_locale` SET `Title` = '宗师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 18752;
-- OLD subname : 附魔训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18753
UPDATE `creature_template_locale` SET `Title` = '大师级附魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 18753;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18754
UPDATE `creature_template_locale` SET `Title` = '大师级制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 18754;
-- OLD subname : 剥皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18755
UPDATE `creature_template_locale` SET `Title` = '大师级剥皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 18755;
-- OLD name : 拍卖师达莉丝, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/cn/npc=18761
UPDATE `creature_template_locale` SET `Name` = '达莉丝',`Title` = '拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 18761;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18771
UPDATE `creature_template_locale` SET `Title` = '大师级制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 18771;
-- OLD subname : 裁缝训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18772
UPDATE `creature_template_locale` SET `Title` = '大师级裁缝训练师' WHERE `locale` = 'zhCN' AND `entry` = 18772;
-- OLD subname : 附魔训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18773
UPDATE `creature_template_locale` SET `Title` = '大师级附魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 18773;
-- OLD subname : 珠宝加工训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18774
UPDATE `creature_template_locale` SET `Title` = '大师级珠宝加工训练师' WHERE `locale` = 'zhCN' AND `entry` = 18774;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18775
UPDATE `creature_template_locale` SET `Title` = '大师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 18775;
-- OLD subname : 草药学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18776
UPDATE `creature_template_locale` SET `Title` = '大师级草药学训练师' WHERE `locale` = 'zhCN' AND `entry` = 18776;
-- OLD subname : 剥皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18777
UPDATE `creature_template_locale` SET `Title` = '大师级剥皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 18777;
-- OLD subname : 采矿训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18779
UPDATE `creature_template_locale` SET `Title` = '大师级采矿训练师' WHERE `locale` = 'zhCN' AND `entry` = 18779;
-- OLD subname : 炼金术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18802
UPDATE `creature_template_locale` SET `Title` = '大师级炼金术训练师' WHERE `locale` = 'zhCN' AND `entry` = 18802;
-- OLD name : “国王”唐金
-- Source : https://www.wowhead.com/wotlk/cn/npc=18897
UPDATE `creature_template_locale` SET `Name` = '"国王"唐金' WHERE `locale` = 'zhCN' AND `entry` = 18897;
-- OLD name : 伊克普罗迪·菲兹普特, subname : 竞技场商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=18898
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 18898;
-- OLD subname : 钓鱼训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18911
UPDATE `creature_template_locale` SET `Title` = '大师级钓鱼训练师' WHERE `locale` = 'zhCN' AND `entry` = 18911;
-- OLD name : [PH] Gossip NPC, Human Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=18935
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 18935;
-- OLD name : [PH] Gossip NPC, Human Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=18936
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 18936;
-- OLD name : [PH] Gossip NPC, Human, Specific Look (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=18941
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 18941;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18987
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 18987;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18988
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 18988;
-- OLD subname : 急救训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18990
UPDATE `creature_template_locale` SET `Title` = '医师' WHERE `locale` = 'zhCN' AND `entry` = 18990;
-- OLD subname : 急救训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=18991
UPDATE `creature_template_locale` SET `Title` = '医师' WHERE `locale` = 'zhCN' AND `entry` = 18991;
-- OLD subname : 烹饪训练师和商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=18993
UPDATE `creature_template_locale` SET `Title` = '烹饪供应商' WHERE `locale` = 'zhCN' AND `entry` = 18993;
-- OLD subname : 炼金术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19052
UPDATE `creature_template_locale` SET `Title` = '大师级炼金术训练师' WHERE `locale` = 'zhCN' AND `entry` = 19052;
-- OLD name : [PH] Gossip NPC Human Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19057
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19057;
-- OLD name : [PH] Gossip NPC Human Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19058
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19058;
-- OLD name : [PH] Gossip NPC Human Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19059
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19059;
-- OLD name : [PH] Gossip NPC Human Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19060
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19060;
-- OLD subname : 珠宝加工训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19063
UPDATE `creature_template_locale` SET `Title` = '大师级珠宝加工训练师' WHERE `locale` = 'zhCN' AND `entry` = 19063;
-- OLD name : [PH] Gossip NPC Dwarf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19078
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19078;
-- OLD name : [PH] Gossip NPC Dwarf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19079
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19079;
-- OLD name : [PH] Gossip NPC Night Elf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19080
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19080;
-- OLD name : [PH] Gossip NPC Night Elf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19081
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19081;
-- OLD name : [PH] Gossip NPC Draenei Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19082
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19082;
-- OLD name : [PH] Gossip NPC Draenei Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19083
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19083;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19084
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19084;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19085
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19085;
-- OLD name : [PH] Gossip NPC Orc Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19086
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19086;
-- OLD name : [PH] Gossip NPC Orc Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19087
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19087;
-- OLD name : [PH] Gossip NPC Tauren Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19088
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19088;
-- OLD name : [PH] Gossip NPC Tauren Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19089
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19089;
-- OLD name : [PH] Gossip NPC Undead Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19090
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19090;
-- OLD name : [PH] Gossip NPC Undead Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19091
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19091;
-- OLD name : [PH] Gossip NPC Dwarf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19092
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19092;
-- OLD name : [PH] Gossip NPC Night Elf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19093
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19093;
-- OLD name : [PH] Gossip NPC Draenei Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19094
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19094;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19095
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19095;
-- OLD name : [PH] Gossip NPC Orc Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19096
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19096;
-- OLD name : [PH] Gossip NPC Tauren Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19097
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19097;
-- OLD name : [PH] Gossip NPC Undead Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19098
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19098;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19099
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19099;
-- OLD name : [PH] Gossip NPC Draenei Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19100
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19100;
-- OLD name : [PH] Gossip NPC Dwarf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19101
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19101;
-- OLD name : [PH] Gossip NPC Night Elf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19102
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19102;
-- OLD name : [PH] Gossip NPC Orc Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19103
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19103;
-- OLD name : [PH] Gossip NPC Tauren Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19104
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19104;
-- OLD name : [PH] Gossip NPC Undead Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19105
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19105;
-- OLD name : [PH] Gossip NPC, Blood Elf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19106
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19106;
-- OLD name : [PH] Gossip NPC, Draenei Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19107
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19107;
-- OLD name : [PH] Gossip NPC, Dwarf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19108
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19108;
-- OLD name : [PH] Gossip NPC, Orc Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19109
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19109;
-- OLD name : [PH] Gossip NPC, Undead Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19110
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19110;
-- OLD name : [PH] Gossip NPC, Tauren Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19111
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19111;
-- OLD name : [PH] Gossip NPC, Night Elf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19112
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19112;
-- OLD name : [PH] Gossip NPC, Blood Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19113
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19113;
-- OLD name : [PH] Gossip NPC, Draenei Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19114
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19114;
-- OLD name : [PH] Gossip NPC, Dwarf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19115
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19115;
-- OLD name : [PH] Gossip NPC, Night Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19116
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19116;
-- OLD name : [PH] Gossip NPC, Orc Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19117
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19117;
-- OLD name : [PH] Gossip NPC, Tauren Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19118
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19118;
-- OLD name : [PH] Gossip NPC, Undead Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19119
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19119;
-- OLD name : [PH] Gossip NPC, Gnome Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19121
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19121;
-- OLD name : [PH] Gossip NPC, Gnome Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19122
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19122;
-- OLD name : [PH] Gossip NPC, Troll Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19123
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19123;
-- OLD name : [PH] Gossip NPC, Troll Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19124
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19124;
-- OLD name : [PH] Gossip NPC Gnome Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19125
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19125;
-- OLD name : [PH] Gossip NPC Gnome Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19126
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19126;
-- OLD name : [PH] Gossip NPC Troll Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19127
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19127;
-- OLD name : [PH] Gossip NPC Troll Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19128
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19128;
-- OLD name : [PH] Gossip NPC Gnome Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19129
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19129;
-- OLD name : [PH] Gossip NPC Troll Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19130
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19130;
-- OLD name : [PH] Gossip NPC Gnome Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19131
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19131;
-- OLD name : [PH] Gossip NPC Troll Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19132
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19132;
-- OLD name : “猎枪”琼斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=19137
UPDATE `creature_template_locale` SET `Name` = '"猎枪"琼斯' WHERE `locale` = 'zhCN' AND `entry` = 19137;
-- OLD subname : 剥皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19180
UPDATE `creature_template_locale` SET `Title` = '大师级剥皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 19180;
-- OLD subname : 急救训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19184
UPDATE `creature_template_locale` SET `Title` = '医师' WHERE `locale` = 'zhCN' AND `entry` = 19184;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19185
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 19185;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19187
UPDATE `creature_template_locale` SET `Title` = '大师级制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 19187;
-- OLD name : 熔岩涌动图腾
-- Source : https://www.wowhead.com/wotlk/cn/npc=19222
UPDATE `creature_template_locale` SET `Name` = '熔岩喷涌图腾' WHERE `locale` = 'zhCN' AND `entry` = 19222;
-- OLD subname : 附魔训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19252
UPDATE `creature_template_locale` SET `Title` = '宗师级附魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 19252;
-- OLD name : Barnu Cragcrush, subname : Stable Master
-- Source : https://www.wowhead.com/wotlk/cn/npc=19325
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19325;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (19325, 'zhCN','巴儿努·碎岩','兽栏管理员');
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19341
UPDATE `creature_template_locale` SET `Title` = '宗师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 19341;
-- OLD subname : 枪械商
-- Source : https://www.wowhead.com/wotlk/cn/npc=19351
UPDATE `creature_template_locale` SET `Title` = '枪械和弹药商' WHERE `locale` = 'zhCN' AND `entry` = 19351;
-- OLD name : “尖嗓子”斯克里·拉克希德
-- Source : https://www.wowhead.com/wotlk/cn/npc=19367
UPDATE `creature_template_locale` SET `Name` = '"尖嗓子"斯克里·拉克希德' WHERE `locale` = 'zhCN' AND `entry` = 19367;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19369
UPDATE `creature_template_locale` SET `Title` = '厨师' WHERE `locale` = 'zhCN' AND `entry` = 19369;
-- OLD name : “暗眼”格里洛克
-- Source : https://www.wowhead.com/wotlk/cn/npc=19457
UPDATE `creature_template_locale` SET `Name` = '"暗眼"格里洛克' WHERE `locale` = 'zhCN' AND `entry` = 19457;
-- OLD subname : 投掷武器商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=19473
UPDATE `creature_template_locale` SET `Title` = '投掷武器和弹药' WHERE `locale` = 'zhCN' AND `entry` = 19473;
-- OLD subname : 兽栏管理员
-- Source : https://www.wowhead.com/wotlk/cn/npc=19491
UPDATE `creature_template_locale` SET `Title` = '马骑术训练师' WHERE `locale` = 'zhCN' AND `entry` = 19491;
-- OLD subname : 兽栏管理员
-- Source : https://www.wowhead.com/wotlk/cn/npc=19492
UPDATE `creature_template_locale` SET `Title` = '马骑术训练师' WHERE `locale` = 'zhCN' AND `entry` = 19492;
-- OLD subname : 珠宝加工训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19539
UPDATE `creature_template_locale` SET `Title` = '大师级珠宝加工训练师' WHERE `locale` = 'zhCN' AND `entry` = 19539;
-- OLD subname : 附魔训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19540
UPDATE `creature_template_locale` SET `Title` = '大师级附魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 19540;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=19576
UPDATE `creature_template_locale` SET `Title` = '大师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 19576;
-- OLD name : [PH]Sunfury Caster - Sunfury Hold (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19650
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19650;
-- OLD name : 重型精英雷象
-- Source : https://www.wowhead.com/wotlk/cn/npc=19659
UPDATE `creature_template_locale` SET `Name` = '重型雷象' WHERE `locale` = 'zhCN' AND `entry` = 19659;
-- OLD name : “杂学家”玛姆迪
-- Source : https://www.wowhead.com/wotlk/cn/npc=19669
UPDATE `creature_template_locale` SET `Name` = '"杂学家"玛姆迪' WHERE `locale` = 'zhCN' AND `entry` = 19669;
-- OLD name : “上尉”卡弗提兹
-- Source : https://www.wowhead.com/wotlk/cn/npc=19676
UPDATE `creature_template_locale` SET `Name` = '"上尉"卡弗提兹' WHERE `locale` = 'zhCN' AND `entry` = 19676;
-- OLD name : “瘦子”
-- Source : https://www.wowhead.com/wotlk/cn/npc=19679
UPDATE `creature_template_locale` SET `Name` = '"瘦子"' WHERE `locale` = 'zhCN' AND `entry` = 19679;
-- OLD name : “脏鬼”拉瑞
-- Source : https://www.wowhead.com/wotlk/cn/npc=19720
UPDATE `creature_template_locale` SET `Name` = '"脏鬼"拉瑞' WHERE `locale` = 'zhCN' AND `entry` = 19720;
-- OLD name : “史诗”马龙
-- Source : https://www.wowhead.com/wotlk/cn/npc=19725
UPDATE `creature_template_locale` SET `Name` = '"史诗"马龙' WHERE `locale` = 'zhCN' AND `entry` = 19725;
-- OLD name : 纳斯雷兹姆顾问
-- Source : https://www.wowhead.com/wotlk/cn/npc=19743
UPDATE `creature_template_locale` SET `Name` = '纳斯雷兹姆议员' WHERE `locale` = 'zhCN' AND `entry` = 19743;
-- OLD name : 日蚀百夫长
-- Source : https://www.wowhead.com/wotlk/cn/npc=19792
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 19792;
-- OLD name : [PH] Illidari Overseer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19819
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19819;
-- OLD name : 黑暗教团乌鸦卫士
-- Source : https://www.wowhead.com/wotlk/cn/npc=19827
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 19827;
-- OLD name : [PH] Horn Ghost (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=19846
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 19846;
-- OLD name : 卡翠欧娜·沃宁迪女伯爵
-- Source : https://www.wowhead.com/wotlk/cn/npc=19872
UPDATE `creature_template_locale` SET `Name` = '卡翠欧娜·冯因迪女伯爵' WHERE `locale` = 'zhCN' AND `entry` = 19872;
-- OLD name : 拉弗·德鲁格尔男爵
-- Source : https://www.wowhead.com/wotlk/cn/npc=19874
UPDATE `creature_template_locale` SET `Name` = '拉弗·杜格尔男爵' WHERE `locale` = 'zhCN' AND `entry` = 19874;
-- OLD name : 杜萝希·米尔斯迪普女伯爵
-- Source : https://www.wowhead.com/wotlk/cn/npc=19875
UPDATE `creature_template_locale` SET `Name` = '杜萝希·米尔斯提女伯爵' WHERE `locale` = 'zhCN' AND `entry` = 19875;
-- OLD name : 罗宾·达尼斯伯爵
-- Source : https://www.wowhead.com/wotlk/cn/npc=19876
UPDATE `creature_template_locale` SET `Name` = '罗宾·达瑞斯伯爵' WHERE `locale` = 'zhCN' AND `entry` = 19876;
-- OLD name : 白色树苗
-- Source : https://www.wowhead.com/wotlk/cn/npc=19958
UPDATE `creature_template_locale` SET `Name` = '白色幼苗' WHERE `locale` = 'zhCN' AND `entry` = 19958;
-- OLD name : 蓝色树苗
-- Source : https://www.wowhead.com/wotlk/cn/npc=19962
UPDATE `creature_template_locale` SET `Name` = '蓝色幼苗' WHERE `locale` = 'zhCN' AND `entry` = 19962;
-- OLD name : 红色树苗
-- Source : https://www.wowhead.com/wotlk/cn/npc=19964
UPDATE `creature_template_locale` SET `Name` = '红色幼苗' WHERE `locale` = 'zhCN' AND `entry` = 19964;
-- OLD name : 绿色树苗
-- Source : https://www.wowhead.com/wotlk/cn/npc=19969
UPDATE `creature_template_locale` SET `Name` = '绿色幼苗' WHERE `locale` = 'zhCN' AND `entry` = 19969;
-- OLD name : 萨拉斯战马
-- Source : https://www.wowhead.com/wotlk/cn/npc=20029
UPDATE `creature_template_locale` SET `Name` = '奎尔萨拉斯军马' WHERE `locale` = 'zhCN' AND `entry` = 20029;
-- OLD name : 萨拉斯军马
-- Source : https://www.wowhead.com/wotlk/cn/npc=20030
UPDATE `creature_template_locale` SET `Name` = '奎尔萨拉斯战马' WHERE `locale` = 'zhCN' AND `entry` = 20030;
-- OLD name : [PH] Gossip NPC Goblin Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=20103
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 20103;
-- OLD name : [PH] Gossip NPC, Goblin Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=20104
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 20104;
-- OLD name : [PH] Gossip NPC Goblin Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=20105
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 20105;
-- OLD name : [PH] Gossip NPC Goblin Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=20106
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 20106;
-- OLD name : [PH] Gossip NPC, Goblin Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=20107
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 20107;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=20124
UPDATE `creature_template_locale` SET `Title` = '武器铸造训练师' WHERE `locale` = 'zhCN' AND `entry` = 20124;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=20125
UPDATE `creature_template_locale` SET `Title` = '护甲锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 20125;
-- OLD subname : 传承竞技场护甲
-- Source : https://www.wowhead.com/wotlk/cn/npc=20278
UPDATE `creature_template_locale` SET `Title` = '野蛮竞技场商人' WHERE `locale` = 'zhCN' AND `entry` = 20278;
-- OLD subname : 驭风者饲养员
-- Source : https://www.wowhead.com/wotlk/cn/npc=20494
UPDATE `creature_template_locale` SET `Title` = '驭风者管理员' WHERE `locale` = 'zhCN' AND `entry` = 20494;
-- OLD subname : 飞行训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=20500
UPDATE `creature_template_locale` SET `Title` = '骑术训练师' WHERE `locale` = 'zhCN' AND `entry` = 20500;
-- OLD name : 雪色狮鹫坐骑
-- Source : https://www.wowhead.com/wotlk/cn/npc=20505
UPDATE `creature_template_locale` SET `Name` = '雪色狮鹫' WHERE `locale` = 'zhCN' AND `entry` = 20505;
-- OLD name : 迅捷绿色骑乘狮鹫
-- Source : https://www.wowhead.com/wotlk/cn/npc=20506
UPDATE `creature_template_locale` SET `Name` = '迅捷绿色狮鹫' WHERE `locale` = 'zhCN' AND `entry` = 20506;
-- OLD name : 迅捷紫色骑乘狮鹫
-- Source : https://www.wowhead.com/wotlk/cn/npc=20507
UPDATE `creature_template_locale` SET `Name` = '迅捷紫色狮鹫' WHERE `locale` = 'zhCN' AND `entry` = 20507;
-- OLD name : 迅捷红色骑乘狮鹫
-- Source : https://www.wowhead.com/wotlk/cn/npc=20508
UPDATE `creature_template_locale` SET `Name` = '迅捷红色狮鹫' WHERE `locale` = 'zhCN' AND `entry` = 20508;
-- OLD name : 迅捷蓝色骑乘狮鹫
-- Source : https://www.wowhead.com/wotlk/cn/npc=20509
UPDATE `creature_template_locale` SET `Name` = '迅捷蓝色狮鹫' WHERE `locale` = 'zhCN' AND `entry` = 20509;
-- OLD subname : 飞行训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=20511
UPDATE `creature_template_locale` SET `Title` = '骑术训练师' WHERE `locale` = 'zhCN' AND `entry` = 20511;
-- OLD name : 阿拉加的幼崽
-- Source : https://www.wowhead.com/wotlk/cn/npc=20615
UPDATE `creature_template_locale` SET `Name` = '暗喉山猫幼崽' WHERE `locale` = 'zhCN' AND `entry` = 20615;
-- OLD name : Coilfang Door Controller
-- Source : https://www.wowhead.com/wotlk/cn/npc=20926
UPDATE `creature_template_locale` SET `Name` = 'Invisible Stalker Coilfang Doors' WHERE `locale` = 'zhCN' AND `entry` = 20926;
-- OLD name : QA Test Dummy 73 Raid Debuff (High Armor)
-- Source : https://www.wowhead.com/wotlk/cn/npc=21003
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy 73 Raid Debuffed Warrior' WHERE `locale` = 'zhCN' AND `entry` = 21003;
-- OLD name : [PH] Arcane Guardian (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=21031
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21031;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=21087
UPDATE `creature_template_locale` SET `Title` = '大师级制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 21087;
-- OLD name : 欧鲁诺克·裂心
-- Source : https://www.wowhead.com/wotlk/cn/npc=21183
UPDATE `creature_template_locale` SET `Name` = '欧鲁诺克-裂心' WHERE `locale` = 'zhCN' AND `entry` = 21183;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=21209
UPDATE `creature_template_locale` SET `Title` = '大师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 21209;
-- OLD name : “背刺者”宾度·盖布
-- Source : https://www.wowhead.com/wotlk/cn/npc=21235
UPDATE `creature_template_locale` SET `Name` = '"背刺者"宾度·盖布' WHERE `locale` = 'zhCN' AND `entry` = 21235;
-- OLD name : 埃米
-- Source : https://www.wowhead.com/wotlk/cn/npc=21317
UPDATE `creature_template_locale` SET `Name` = '艾米' WHERE `locale` = 'zhCN' AND `entry` = 21317;
-- OLD name : [PH]Test Skunk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=21333
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21333;
-- OLD name : 炽热战马
-- Source : https://www.wowhead.com/wotlk/cn/npc=21354
UPDATE `creature_template_locale` SET `Name` = '火焰战马' WHERE `locale` = 'zhCN' AND `entry` = 21354;
-- OLD name : 漂浮的徽记
-- Source : https://www.wowhead.com/wotlk/cn/npc=21365
UPDATE `creature_template_locale` SET `Name` = '漂浮的颅骨' WHERE `locale` = 'zhCN' AND `entry` = 21365;
-- OLD name : [UNUSED]Test Nether Whelp (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=21378
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21378;
-- OLD name : Tempixx Finagler
-- Source : https://www.wowhead.com/wotlk/cn/npc=21444
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21444;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21444, 'zhCN','泰匹希·芬纳格',NULL);
-- OLD name : [Unused] Greater Crust Burster Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=21457
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21457;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/cn/npc=21483
UPDATE `creature_template_locale` SET `Title` = '弹药商人' WHERE `locale` = 'zhCN' AND `entry` = 21483;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/cn/npc=21488
UPDATE `creature_template_locale` SET `Title` = '弹药商人' WHERE `locale` = 'zhCN' AND `entry` = 21488;
-- OLD name : [DND]Kaliri Aura Dispel (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=21511
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21511;
-- OLD name : Forest Strider
-- Source : https://www.wowhead.com/wotlk/cn/npc=21634
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21634;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21634, 'zhCN','森林阔步者',NULL);
-- OLD name : 森林陆行鸟
-- Source : https://www.wowhead.com/wotlk/cn/npc=21635
UPDATE `creature_template_locale` SET `Name` = '阿弗拉斯森林陆行鸟' WHERE `locale` = 'zhCN' AND `entry` = 21635;
-- OLD name : [UNUSED]Death's Deliverer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=21658
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21658;
-- OLD name : 欧鲁诺克·裂心
-- Source : https://www.wowhead.com/wotlk/cn/npc=21685
UPDATE `creature_template_locale` SET `Name` = '欧鲁诺克-裂心' WHERE `locale` = 'zhCN' AND `entry` = 21685;
-- OLD name : [DND]Mok'Nathal Wand 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=21713
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21713;
-- OLD name : [DND]Mok'Nathal Wand 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=21714
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21714;
-- OLD name : [DND]Mok'Nathal Wand 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=21715
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21715;
-- OLD name : [DND]Mok'Nathal Wand 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=21716
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 21716;
-- OLD name : 大型爆盐炸弹
-- Source : https://www.wowhead.com/wotlk/cn/npc=21848
UPDATE `creature_template_locale` SET `Name` = 'ZZOLD - Bone Burster Visual[PH]' WHERE `locale` = 'zhCN' AND `entry` = 21848;
-- OLD name : 加姆·狼脉
-- Source : https://www.wowhead.com/wotlk/cn/npc=21950
UPDATE `creature_template_locale` SET `Name` = '加姆·狼兄' WHERE `locale` = 'zhCN' AND `entry` = 21950;
-- OLD name : [DND]Spirit 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22023
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22023;
-- OLD name : [PH] bat target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22039
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22039;
-- OLD name : [ph] cave ant [not used] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22048
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22048;
-- OLD name : Coilfang Raid Control Emote Stalker
-- Source : https://www.wowhead.com/wotlk/cn/npc=22057
UPDATE `creature_template_locale` SET `Name` = 'Invisible Stalker Coilfang Raid Console Emotes' WHERE `locale` = 'zhCN' AND `entry` = 22057;
-- OLD name : [DND]Whisper Spying Credit Marker 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22116
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22116;
-- OLD name : [DND]Whisper Spying Credit Marker 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22117
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22117;
-- OLD name : [DND]Whisper Spying Credit Marker 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22118
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22118;
-- OLD subname : 月布裁缝大师
-- Source : https://www.wowhead.com/wotlk/cn/npc=22208
UPDATE `creature_template_locale` SET `Title` = '月布大师' WHERE `locale` = 'zhCN' AND `entry` = 22208;
-- OLD subname : 暗纹裁缝大师
-- Source : https://www.wowhead.com/wotlk/cn/npc=22212
UPDATE `creature_template_locale` SET `Title` = '暗纹大师' WHERE `locale` = 'zhCN' AND `entry` = 22212;
-- OLD subname : 魔焰裁缝大师
-- Source : https://www.wowhead.com/wotlk/cn/npc=22213
UPDATE `creature_template_locale` SET `Title` = '魔焰大师' WHERE `locale` = 'zhCN' AND `entry` = 22213;
-- OLD name : [PH] Wrath Clefthoof [not used] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22284
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22284;
-- OLD name : [DND]Green Spot Grog Keg Relay (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22349
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22349;
-- OLD name : [DND]Green Spot Grog Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22356
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22356;
-- OLD name : [DND]Ripe Moonshine Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22367
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22367;
-- OLD name : [DND]Fermented Seed Beer Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22368
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22368;
-- OLD name : [DND]Bloodmaul Chatter Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22383
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22383;
-- OLD name : [PH]Altar of Shadows target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22395
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22395;
-- OLD name : [PH]Altar of Shadows caster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22417
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22417;
-- OLD name : [DND]Ogre Pike Planted Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22434
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22434;
-- OLD name : [DND]Rexxar's Wyvern Freed Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22435
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22435;
-- OLD name : [DND]Sablemane's Trap Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22447
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22447;
-- OLD name : 暗色骑乘塔布羊
-- Source : https://www.wowhead.com/wotlk/cn/npc=22511
UPDATE `creature_template_locale` SET `Name` = '黑暗骑乘塔布羊' WHERE `locale` = 'zhCN' AND `entry` = 22511;
-- OLD name : [DND]Prophecy 1 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22798
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22798;
-- OLD name : [DND]Prophecy 2 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22799
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22799;
-- OLD name : [DND]Prophecy 3 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22800
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22800;
-- OLD name : [DND]Prophecy 4 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22801
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22801;
-- OLD subname : 猛禽德鲁伊
-- Source : https://www.wowhead.com/wotlk/cn/npc=22832
UPDATE `creature_template_locale` SET `Title` = '利爪德鲁伊' WHERE `locale` = 'zhCN' AND `entry` = 22832;
-- OLD name : 神殿女妖
-- Source : https://www.wowhead.com/wotlk/cn/npc=22939
UPDATE `creature_template_locale` SET `Name` = '神殿助祭' WHERE `locale` = 'zhCN' AND `entry` = 22939;
-- OLD name : 妩媚女妖
-- Source : https://www.wowhead.com/wotlk/cn/npc=22955
UPDATE `creature_template_locale` SET `Name` = '有魅力的客人' WHERE `locale` = 'zhCN' AND `entry` = 22955;
-- OLD name : 痛苦之女
-- Source : https://www.wowhead.com/wotlk/cn/npc=22956
UPDATE `creature_template_locale` SET `Name` = '苦痛祭司' WHERE `locale` = 'zhCN' AND `entry` = 22956;
-- OLD name : 狂乱祭司
-- Source : https://www.wowhead.com/wotlk/cn/npc=22957
UPDATE `creature_template_locale` SET `Name` = '狂乱女士' WHERE `locale` = 'zhCN' AND `entry` = 22957;
-- OLD name : 缚法随从
-- Source : https://www.wowhead.com/wotlk/cn/npc=22959
UPDATE `creature_template_locale` SET `Name` = '热忱的招待' WHERE `locale` = 'zhCN' AND `entry` = 22959;
-- OLD name : [UNUSED] Harem Girl 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=22961
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 22961;
-- OLD name : 欢愉祭司
-- Source : https://www.wowhead.com/wotlk/cn/npc=22962
UPDATE `creature_template_locale` SET `Name` = '悲伤女士' WHERE `locale` = 'zhCN' AND `entry` = 22962;
-- OLD name : 快乐之女
-- Source : https://www.wowhead.com/wotlk/cn/npc=22964
UPDATE `creature_template_locale` SET `Name` = '欢愉祭司' WHERE `locale` = 'zhCN' AND `entry` = 22964;
-- OLD name : 被奴役的仆从
-- Source : https://www.wowhead.com/wotlk/cn/npc=22965
UPDATE `creature_template_locale` SET `Name` = '虔诚的管家' WHERE `locale` = 'zhCN' AND `entry` = 22965;
-- OLD name : [PH]Knockdown Fel Cannon Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23077
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23077;
-- OLD name : 萨尔拉
-- Source : https://www.wowhead.com/wotlk/cn/npc=23108
UPDATE `creature_template_locale` SET `Name` = '萨拉' WHERE `locale` = 'zhCN' AND `entry` = 23108;
-- OLD name : [PH]Fel Hound (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23138
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23138;
-- OLD name : 负法奴仆
-- Source : https://www.wowhead.com/wotlk/cn/npc=23154
UPDATE `creature_template_locale` SET `Name` = '法力奴仆' WHERE `locale` = 'zhCN' AND `entry` = 23154;
-- OLD name : 破坏魔刺客
-- Source : https://www.wowhead.com/wotlk/cn/npc=23220
UPDATE `creature_template_locale` SET `Name` = '希瓦魔刺客' WHERE `locale` = 'zhCN' AND `entry` = 23220;
-- OLD name : [UNUSED] Mutant Commander [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23238
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23238;
-- OLD name : [PH]Wrath Hound Transform (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23276
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23276;
-- OLD name : Akama Event Stalker
-- Source : https://www.wowhead.com/wotlk/cn/npc=23288
UPDATE `creature_template_locale` SET `Name` = 'Invisible Stalker (Akama)' WHERE `locale` = 'zhCN' AND `entry` = 23288;
-- OLD name : 矿车
-- Source : https://www.wowhead.com/wotlk/cn/npc=23289
UPDATE `creature_template_locale` SET `Name` = 'Mine Cart' WHERE `locale` = 'zhCN' AND `entry` = 23289;
-- OLD name : [PH] PvP Cannon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23314
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23314;
-- OLD name : [PH] PvP Cannon Shot Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23315
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23315;
-- OLD name : [PH] PvP Cannon Targetting Reticle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23317
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23317;
-- OLD subname : 经典旧世联盟锁甲及板甲
-- Source : https://www.wowhead.com/wotlk/cn/npc=23396
UPDATE `creature_template_locale` SET `Title` = '竞技场商人' WHERE `locale` = 'zhCN' AND `entry` = 23396;
-- OLD name : 饥饿灵魂碎块
-- Source : https://www.wowhead.com/wotlk/cn/npc=23401
UPDATE `creature_template_locale` SET `Name` = '饥饿的灵魂碎块' WHERE `locale` = 'zhCN' AND `entry` = 23401;
-- OLD name : Flaskataur, subname : NONE
-- Source : https://www.wowhead.com/wotlk/cn/npc=23405
UPDATE `creature_template_locale` SET `Name` = '弗拉斯卡托',`Title` = '测试服消耗品' WHERE `locale` = 'zhCN' AND `entry` = 23405;
-- OLD name : 乌鸦之神
-- Source : https://www.wowhead.com/wotlk/cn/npc=23408
UPDATE `creature_template_locale` SET `Name` = '迅捷鸦神坐骑' WHERE `locale` = 'zhCN' AND `entry` = 23408;
-- OLD name : [PH] Brewfest Dwarf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23479
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23479;
-- OLD name : [PH] Brewfest Human Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23480
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23480;
-- OLD name : [PH] Brewfest Garden D Vendor (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23532
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23532;
-- OLD name : [PH] Brewfest Goblin Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23540
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23540;
-- OLD name : 巴德
-- Source : https://www.wowhead.com/wotlk/cn/npc=23559
UPDATE `creature_template_locale` SET `Name` = '巴德·奈德雷克' WHERE `locale` = 'zhCN' AND `entry` = 23559;
-- OLD subname : 潜行者训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=23566
UPDATE `creature_template_locale` SET `Title` = '军情七处' WHERE `locale` = 'zhCN' AND `entry` = 23566;
-- OLD name : 美酒节座羊
-- Source : https://www.wowhead.com/wotlk/cn/npc=23588
UPDATE `creature_template_locale` SET `Name` = '座羊（美酒节）' WHERE `locale` = 'zhCN' AND `entry` = 23588;
-- OLD name : [PH] New Hinterlands NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23599
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23599;
-- OLD name : 日灼的学徒
-- Source : https://www.wowhead.com/wotlk/cn/npc=23606
UPDATE `creature_template_locale` SET `Name` = '血精灵酿酒学徒' WHERE `locale` = 'zhCN' AND `entry` = 23606;
-- OLD name : [PH] Brewfest Orc Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23607
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23607;
-- OLD name : [PH] Brewfest Tauren Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23608
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23608;
-- OLD name : [PH] Brewfest Troll Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23609
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23609;
-- OLD name : [PH] Brewfest Blood Elf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23610
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23610;
-- OLD name : [PH] Brewfest Undead Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23611
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23611;
-- OLD name : [PH] Brewfest Draenei Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23613
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23613;
-- OLD name : [PH] Brewfest Gnome Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23614
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23614;
-- OLD name : [PH] Brewfest Night Elf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23615
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23615;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23629
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23629;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE B (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23630
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23630;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE C (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23631
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23631;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE D (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23632
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23632;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE E (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23633
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23633;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE F (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23634
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23634;
-- OLD name : 斯克恩长矛手 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23653
UPDATE `creature_template_locale` SET `Name` = '蔑冬长矛手' WHERE `locale` = 'zhCN' AND `entry` = 23653;
-- OLD name : 斯克恩碾骨者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23655
UPDATE `creature_template_locale` SET `Name` = '蔑冬碾骨者' WHERE `locale` = 'zhCN' AND `entry` = 23655;
-- OLD name : 斯克恩吟游诗人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23657
UPDATE `creature_template_locale` SET `Name` = '蔑冬吟游诗人' WHERE `locale` = 'zhCN' AND `entry` = 23657;
-- OLD name : 斯克恩预言者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23669
UPDATE `creature_template_locale` SET `Name` = '蔑冬预言者' WHERE `locale` = 'zhCN' AND `entry` = 23669;
-- OLD name : 斯克恩长者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23670
UPDATE `creature_template_locale` SET `Name` = '蔑冬长者' WHERE `locale` = 'zhCN' AND `entry` = 23670;
-- OLD subname : 斯克恩的领主 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23671
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 23671;
-- OLD name : [DND] Brewfest Dark Iron Event Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23703
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23703;
-- OLD subname : QA (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23715
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 23715;
-- OLD subname : 急救训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=23734
UPDATE `creature_template_locale` SET `Title` = '宗师级急救训练师' WHERE `locale` = 'zhCN' AND `entry` = 23734;
-- OLD name : 库塞尔
-- Source : https://www.wowhead.com/wotlk/cn/npc=23748
UPDATE `creature_template_locale` SET `Name` = '库尔基' WHERE `locale` = 'zhCN' AND `entry` = 23748;
-- OLD subname : 皇家药剂师协会 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23781
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 23781;
-- OLD subname : 皇家药剂师协会 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23782
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 23782;
-- OLD subname : 皇家药剂师协会 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23784
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 23784;
-- OLD name : [DND] Brewfest Keg Move to Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23808
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23808;
-- OLD subname : 蝙蝠管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=23816
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 23816;
-- OLD name : [PH] Brewfest Dwarf Male Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23819
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23819;
-- OLD name : [PH] Brewfest Dwarf Female Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23820
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23820;
-- OLD name : [PH] Brewfest Goblin Female Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23824
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23824;
-- OLD name : [PH] Brewfest Goblin Male Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23825
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23825;
-- OLD name : [DND] L70ETC FX Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23830
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23830;
-- OLD name : [DND] L70ETC Bergrisst Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23845
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23845;
-- OLD name : [DND] L70ETC Concert Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23850
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23850;
-- OLD name : [DND] L70ETC Mai'Kyl Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23852
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23852;
-- OLD name : [DND] L70ETC Samuro Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23853
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23853;
-- OLD name : [DND] L70ETC Sig Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23854
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23854;
-- OLD name : [DND] L70ETC Chief Thunder-Skins Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23855
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23855;
-- OLD name : [DND] Brewfest Dark Iron Spawn Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23894
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23894;
-- OLD name : “脏鬼”迈克尔·克罗维, subname : 钓鱼训练师兼鱼商
-- Source : https://www.wowhead.com/wotlk/cn/npc=23896
UPDATE `creature_template_locale` SET `Name` = '"脏鬼"迈克尔·克罗维',`Title` = '鱼商' WHERE `locale` = 'zhCN' AND `entry` = 23896;
-- OLD name : [DNT]TEST Pet Moth (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=23936
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 23936;
-- OLD name : 掠夺者因格瓦尔
-- Source : https://www.wowhead.com/wotlk/cn/npc=23954
UPDATE `creature_template_locale` SET `Name` = '劫掠者因格瓦尔' WHERE `locale` = 'zhCN' AND `entry` = 23954;
-- OLD name : 幽灵虎
-- Source : https://www.wowhead.com/wotlk/cn/npc=24003
UPDATE `creature_template_locale` SET `Name` = '幽灵狼' WHERE `locale` = 'zhCN' AND `entry` = 24003;
-- OLD name : 围城工人
-- Source : https://www.wowhead.com/wotlk/cn/npc=24005
UPDATE `creature_template_locale` SET `Name` = '磨坊工人' WHERE `locale` = 'zhCN' AND `entry` = 24005;
-- OLD name : 斯克恩防御者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24015
UPDATE `creature_template_locale` SET `Name` = '蔑冬防御者' WHERE `locale` = 'zhCN' AND `entry` = 24015;
-- OLD subname : 萨莱因 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24041
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24041;
-- OLD name : 掷杯训练器, subname : 掷杯训练器
-- Source : https://www.wowhead.com/wotlk/cn/npc=24108
UPDATE `creature_template_locale` SET `Name` = '自动搅拌工具',`Title` = '烈酒' WHERE `locale` = 'zhCN' AND `entry` = 24108;
-- OLD name : [DND] Brewfest Target Dummy Move To Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24109
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24109;
-- OLD subname : 斯克恩的领主 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24119
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24119;
-- OLD name : [DND] Darkmoon Faire Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24171
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24171;
-- OLD name : [UNUSED]Ghost of Explorer Jaren (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24181
UPDATE `creature_template_locale` SET `Name` = '召唤炸药包' WHERE `locale` = 'zhCN' AND `entry` = 24181;
-- OLD name : [DND] Brewfest Barker Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24202
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24202;
-- OLD name : [DND] Brewfest Barker Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24203
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24203;
-- OLD name : [DND] Brewfest Barker Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24204
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24204;
-- OLD name : [DND] Brewfest Barker Bunny 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24205
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24205;
-- OLD name : 亡者大军
-- Source : https://www.wowhead.com/wotlk/cn/npc=24207
UPDATE `creature_template_locale` SET `Name` = '亡者军团食尸鬼' WHERE `locale` = 'zhCN' AND `entry` = 24207;
-- OLD name : “小个子”洛戈克
-- Source : https://www.wowhead.com/wotlk/cn/npc=24208
UPDATE `creature_template_locale` SET `Name` = '"小个子"洛戈克' WHERE `locale` = 'zhCN' AND `entry` = 24208;
-- OLD name : [DND] Darkmoon Faire Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24220
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24220;
-- OLD subname : 斯克恩的酋长 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24238
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24238;
-- OLD name : [DND] Brewfest Speed Bunny Green (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24263
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24263;
-- OLD name : [DND] Brewfest Speed Bunny Yellow (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24264
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24264;
-- OLD name : [DND] Brewfest Speed Bunny Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24265
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24265;
-- OLD subname : Winterskorn Chieftain (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24275
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24275;
-- OLD subname : Winterskorn Chieftain (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24276
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24276;
-- OLD name : [PH] Gossip NPC Human Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24292
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24292;
-- OLD name : [PH] Gossip NPC Human Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24293
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24293;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24294
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24294;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24295
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24295;
-- OLD name : [PH] Gossip NPC Draenei Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24296
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24296;
-- OLD name : [PH] Gossip NPC Draenei Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24297
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24297;
-- OLD name : [PH] Gossip NPC Dwarf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24298
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24298;
-- OLD name : [PH] Gossip NPC Dwarf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24299
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24299;
-- OLD name : [PH] Gossip NPC Undead Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24300
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24300;
-- OLD name : [PH] Gossip NPC Undead Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24301
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24301;
-- OLD name : [PH] Gossip NPC Gnome Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24302
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24302;
-- OLD name : [PH] Gossip NPC Gnome Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24303
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24303;
-- OLD name : [PH] Gossip NPC Goblin Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24304
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24304;
-- OLD name : [PH] Gossip NPC Goblin Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24305
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24305;
-- OLD name : [PH] Gossip NPC Night Elf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24306
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24306;
-- OLD name : [PH] Gossip NPC Night Elf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24307
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24307;
-- OLD name : [PH] Gossip NPC Orc Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24308
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24308;
-- OLD name : [PH] Gossip NPC Orc Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24309
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24309;
-- OLD name : [PH] Gossip NPC Tauren Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24310
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24310;
-- OLD name : [PH] Gossip NPC Tauren Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24311
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24311;
-- OLD name : [DND] Brewfest Delivery Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24337
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24337;
-- OLD subname : 商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24341
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24341;
-- OLD subname : 旅店老板 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24342
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24342;
-- OLD subname : 屠夫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24343
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24343;
-- OLD subname : 护甲锻造师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24347
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24347;
-- OLD subname : 杂货商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24348
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24348;
-- OLD subname : 材料和毒药商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24349
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24349;
-- OLD subname : 兽栏管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24350
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24350;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24351
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24351;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24352
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24352;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24360
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24360;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24361
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24361;
-- OLD name : 哈里森的尸体
-- Source : https://www.wowhead.com/wotlk/cn/npc=24365
UPDATE `creature_template_locale` SET `Name` = '威利的尸体' WHERE `locale` = 'zhCN' AND `entry` = 24365;
-- OLD name : 迅捷美酒节赛羊
-- Source : https://www.wowhead.com/wotlk/cn/npc=24368
UPDATE `creature_template_locale` SET `Name` = '迅捷座羊（美酒节）' WHERE `locale` = 'zhCN' AND `entry` = 24368;
-- OLD name : [UNUSED]Vazruden Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24377
UPDATE `creature_template_locale` SET `Name` = '召唤炸药包' WHERE `locale` = 'zhCN' AND `entry` = 24377;
-- OLD name : [UNUSED]Nazan Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24378
UPDATE `creature_template_locale` SET `Name` = '"Back To Bladespire Fortress" Flight Kill Credit' WHERE `locale` = 'zhCN' AND `entry` = 24378;
-- OLD name : [VO]Nalorakk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24382
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24382;
-- OLD name : [VO]Akil'Zon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24383
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24383;
-- OLD name : [VO]Halazzi (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24384
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24384;
-- OLD name : [VO]Jan'alai (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24386
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24386;
-- OLD name : 雷尼·“招牌微笑”·斯莫
-- Source : https://www.wowhead.com/wotlk/cn/npc=24392
UPDATE `creature_template_locale` SET `Name` = '雷尼·斯莫' WHERE `locale` = 'zhCN' AND `entry` = 24392;
-- OLD subname : 竞技场商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=24395
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24395;
-- OLD name : Invisible Man - No Weapons (Server Only/Hide Body)
-- Source : https://www.wowhead.com/wotlk/cn/npc=24417
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 24417;
-- OLD name : 霍莉
-- Source : https://www.wowhead.com/wotlk/cn/npc=24455
UPDATE `creature_template_locale` SET `Name` = '霍里' WHERE `locale` = 'zhCN' AND `entry` = 24455;
-- OLD name : [PH] Maldonado's Test Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24470
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24470;
-- OLD name : 熔炉火焰
-- Source : https://www.wowhead.com/wotlk/cn/npc=24471
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 24471;
-- OLD name : 塞纳里奥作战角鹰兽
-- Source : https://www.wowhead.com/wotlk/cn/npc=24488
UPDATE `creature_template_locale` SET `Name` = '绿色装甲角鹰兽' WHERE `locale` = 'zhCN' AND `entry` = 24488;
-- OLD name : [UNUSED] Riplash Flayer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24575
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24575;
-- OLD name : [UNUSED] Riplash Tidehunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24577
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24577;
-- OLD name : [UNUSED] Riplash Serpent Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24578
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24578;
-- OLD name : [UNUSED] Riplash Tidelord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24579
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24579;
-- OLD name : [UNUSED] Tundra Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24617
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24617;
-- OLD name : [UNUSED] Tundra Wolf Alpha (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24620
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24620;
-- OLD subname : 伪装大师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24643
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24643;
-- OLD name : [PH] BLB Blue Blood Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24658
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24658;
-- OLD name : [UNUSED] Riplash Hydra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24661
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24661;
-- OLD name : 约格莫夫·冰锤中尉
-- Source : https://www.wowhead.com/wotlk/cn/npc=24665
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 24665;
-- OLD subname : 探险者协会 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24717
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24717;
-- OLD subname : 探险者协会 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24718
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24718;
-- OLD subname : 探险者协会 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24719
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24719;
-- OLD subname : 探险者协会 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24720
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24720;
-- OLD subname : 希达尔格的伙伴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24751
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24751;
-- OLD name : 小丸子
-- Source : https://www.wowhead.com/wotlk/cn/npc=24753
UPDATE `creature_template_locale` SET `Name` = '粉色小雷象' WHERE `locale` = 'zhCN' AND `entry` = 24753;
-- OLD name : [DND] Brewfest Face Me Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24766
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24766;
-- OLD name : “鼠胆船长”托格雷
-- Source : https://www.wowhead.com/wotlk/cn/npc=24833
UPDATE `creature_template_locale` SET `Name` = '"鼠胆船长"托格雷' WHERE `locale` = 'zhCN' AND `entry` = 24833;
-- OLD name : 女性迪菲亚海盗
-- Source : https://www.wowhead.com/wotlk/cn/npc=24860
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 24860;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=24868
UPDATE `creature_template_locale` SET `Title` = '宗师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 24868;
-- OLD subname : 格雷兹克斯的大副 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=24897
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 24897;
-- OLD name : [PH]Avalanche (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=24912
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 24912;
-- OLD name : 弗拉斯卡萨, subname : Mate of the Flaskataur
-- Source : https://www.wowhead.com/wotlk/cn/npc=24982
UPDATE `creature_template_locale` SET `Name` = '弗拉斯卡托夫人',`Title` = '测试服附魔' WHERE `locale` = 'zhCN' AND `entry` = 24982;
-- OLD name : 小孢子蝠
-- Source : https://www.wowhead.com/wotlk/cn/npc=25062
UPDATE `creature_template_locale` SET `Name` = '迷你孢子蝠' WHERE `locale` = 'zhCN' AND `entry` = 25062;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=25099
UPDATE `creature_template_locale` SET `Title` = '宗师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 25099;
-- OLD name : [PH] Bri's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=25139
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25139;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/cn/npc=25195
UPDATE `creature_template_locale` SET `Title` = '特殊弹药商' WHERE `locale` = 'zhCN' AND `entry` = 25195;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/cn/npc=25196
UPDATE `creature_template_locale` SET `Title` = '特殊弹药商' WHERE `locale` = 'zhCN' AND `entry` = 25196;
-- OLD name : [PH] Torch Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=25218
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25218;
-- OLD subname : 铭文训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=25263
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 25263;
-- OLD subname : 双足飞龙管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=25288
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 25288;
-- OLD subname : 图波尔的伙伴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=25290
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 25290;
-- OLD name : 烈焰舞娘
-- Source : https://www.wowhead.com/wotlk/cn/npc=25305
UPDATE `creature_template_locale` SET `Name` = '火焰舞娘' WHERE `locale` = 'zhCN' AND `entry` = 25305;
-- OLD subname : 施法材料与毒药商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=25312
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 25312;
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/cn/npc=25323
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25323;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25323, 'zhCN',NULL,'软件工程师');
-- OLD name : 碾压者格尔基
-- Source : https://www.wowhead.com/wotlk/cn/npc=25329
UPDATE `creature_template_locale` SET `Name` = 'Annihilator Grek''lor' WHERE `locale` = 'zhCN' AND `entry` = 25329;
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/cn/npc=25406
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25406;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25406, 'zhCN',NULL,'软件工程师');
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/cn/npc=25411
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25411;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25411, 'zhCN',NULL,'软件工程师');
-- OLD name : [PH] Festival Fire Juggler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=25515
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25515;
-- OLD subname : 兽栏管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=25519
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 25519;
-- OLD name : [DNT] Torch Tossing Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=25535
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25535;
-- OLD name : [DNT] Torch Tossing Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=25536
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25536;
-- OLD name : Craig's Test Human A
-- Source : https://www.wowhead.com/wotlk/cn/npc=25537
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25537;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25537, 'zhCN','Craig''s Test Human',NULL);
-- OLD subname : 材料供应商
-- Source : https://www.wowhead.com/wotlk/cn/npc=25633
UPDATE `creature_template_locale` SET `Title` = '材料商' WHERE `locale` = 'zhCN' AND `entry` = 25633;
-- OLD subname : 大地之环
-- Source : https://www.wowhead.com/wotlk/cn/npc=25697
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 25697;
-- OLD name : 灼烧焰灵
-- Source : https://www.wowhead.com/wotlk/cn/npc=25706
UPDATE `creature_template_locale` SET `Name` = '灼烧元素' WHERE `locale` = 'zhCN' AND `entry` = 25706;
-- OLD name : 考达拉鳞誓龙人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=25717
UPDATE `creature_template_locale` SET `Name` = '考达拉鳞誓龙兽' WHERE `locale` = 'zhCN' AND `entry` = 25717;
-- OLD name : [ph] Coldarra Blue Dragon Patroller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=25723
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25723;
-- OLD name : 晋升法师猎手
-- Source : https://www.wowhead.com/wotlk/cn/npc=25724
UPDATE `creature_template_locale` SET `Name` = '晋升的法师猎手' WHERE `locale` = 'zhCN' AND `entry` = 25724;
-- OLD name : [PH] Coldarra Leyliner, subname : PH MODEL: TASK 23362 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=25734
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25734;
-- OLD name : [PH] Ahune Summon Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=25745
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25745;
-- OLD name : [PH] Ahune Loot Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=25746
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 25746;
-- OLD subname : 大地之环
-- Source : https://www.wowhead.com/wotlk/cn/npc=25754
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 25754;
-- OLD subname : 母狼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=25774
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 25774;
-- OLD name : 影刃狂暴者
-- Source : https://www.wowhead.com/wotlk/cn/npc=25798
UPDATE `creature_template_locale` SET `Name` = '暗誓狂暴者' WHERE `locale` = 'zhCN' AND `entry` = 25798;
-- OLD name : 影刃怒火法师
-- Source : https://www.wowhead.com/wotlk/cn/npc=25799
UPDATE `creature_template_locale` SET `Name` = '暗誓怒火法师' WHERE `locale` = 'zhCN' AND `entry` = 25799;
-- OLD name : 荆棘谷海角护火者
-- Source : https://www.wowhead.com/wotlk/cn/npc=25915
UPDATE `creature_template_locale` SET `Name` = '荆棘谷护火者' WHERE `locale` = 'zhCN' AND `entry` = 25915;
-- OLD name : 荆棘谷海角护焰者
-- Source : https://www.wowhead.com/wotlk/cn/npc=25920
UPDATE `creature_template_locale` SET `Name` = '荆棘谷护焰者' WHERE `locale` = 'zhCN' AND `entry` = 25920;
-- OLD name : 北贫瘠之地护焰者
-- Source : https://www.wowhead.com/wotlk/cn/npc=25943
UPDATE `creature_template_locale` SET `Name` = '贫瘠之地护焰者' WHERE `locale` = 'zhCN' AND `entry` = 25943;
-- OLD name : 可驯服的猛禽
-- Source : https://www.wowhead.com/wotlk/cn/npc=26028
UPDATE `creature_template_locale` SET `Name` = '可驯服的猫头鹰' WHERE `locale` = 'zhCN' AND `entry` = 26028;
-- OLD subname : 诺格的机械商店 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26078
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26078;
-- OLD name : Craig's Test Human B (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26080
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26080;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26080, 'zhCN','NPC',NULL);
-- OLD subname : 退休人员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26081
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26081;
-- OLD name : 黑暗堕落者亡刃骑士
-- Source : https://www.wowhead.com/wotlk/cn/npc=26103
UPDATE `creature_template_locale` SET `Name` = '黑暗堕落者弗伦·亡刃' WHERE `locale` = 'zhCN' AND `entry` = 26103;
-- OLD name : [PH] Tom Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26176
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26176;
-- OLD name : [PH] Torch Catching Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26188
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26188;
-- OLD name : [PH] Spank Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26190
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26190;
-- OLD name : X-51虚空火箭
-- Source : https://www.wowhead.com/wotlk/cn/npc=26192
UPDATE `creature_template_locale` SET `Name` = '蓝色火箭坐骑' WHERE `locale` = 'zhCN' AND `entry` = 26192;
-- OLD name : [PH] Ghost of Ahune (Disguise) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26241
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26241;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26258
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26258;
-- OLD name : 大型烈焰舞娘
-- Source : https://www.wowhead.com/wotlk/cn/npc=26267
UPDATE `creature_template_locale` SET `Name` = '烈焰舞娘' WHERE `locale` = 'zhCN' AND `entry` = 26267;
-- OLD subname : 皮货商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26269
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26269;
-- OLD name : [PH] Dragonblight Ancient (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26274
UPDATE `creature_template_locale` SET `Name` = '龙骨荒野古树' WHERE `locale` = 'zhCN' AND `entry` = 26274;
-- OLD name : [PH] Dragonblight Black Dragon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26275
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26275;
-- OLD name : [PH] Dragonblight Green Dragon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26278
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26278;
-- OLD name : [PH] Dragonblight Elemental Obsidian Dragonshire (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26285
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26285;
-- OLD name : Forgotten Shore Event Trigger
-- Source : https://www.wowhead.com/wotlk/cn/npc=26288
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 26288;
-- OLD name : [PH] Dragonblight Scourge Carrion Fields (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26292
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26292;
-- OLD name : [PH] Dragonblight Magma Wyrm (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26294
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26294;
-- OLD name : [PH] Dragonblight Scarlet Onslaught (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26296
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26296;
-- OLD name : 杂货商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=26304
UPDATE `creature_template_locale` SET `Name` = '物资商人' WHERE `locale` = 'zhCN' AND `entry` = 26304;
-- OLD name : 板甲商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=26305
UPDATE `creature_template_locale` SET `Name` = '皮甲商人' WHERE `locale` = 'zhCN' AND `entry` = 26305;
-- OLD name : 皮甲商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=26306
UPDATE `creature_template_locale` SET `Name` = '锁甲商人' WHERE `locale` = 'zhCN' AND `entry` = 26306;
-- OLD name : 锁甲商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=26308
UPDATE `creature_template_locale` SET `Name` = '板甲商人' WHERE `locale` = 'zhCN' AND `entry` = 26308;
-- OLD name : [PH] Dragonblight Taunka (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26311
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26311;
-- OLD name : [PH] Dragonblight Taunka Spirit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26312
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26312;
-- OLD name : [PH] Dragonblight Treant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26313
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26313;
-- OLD name : [PH] Dragonblight Scourge Galakrond Rest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26317
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26317;
-- OLD name : [PH] Dragonblight Scourge Obsidian Dragonshire (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26318
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26318;
-- OLD name : [PH] Dragonblight Scourge Ruby Dragonshrine (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26320
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26320;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - H (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26355
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26355;
-- OLD name : Test - Brutallus Craig (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26376
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26376;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26376, 'zhCN','NPC',NULL);
-- OLD name : 伊维·考伯斯宾, subname : 竞技场商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=26378
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26378;
-- OLD name : 格里金·考伯斯宾, subname : 竞技场商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=26383
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26383;
-- OLD name : 弗里克·布拉斯图, subname : 竞技场商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=26384
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26384;
-- OLD name : [PH] Ice Chest Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26391
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26391;
-- OLD subname : 丹厄古尔的领主 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26405
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26405;
-- OLD subname : 弗雷哈默尔的卫士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26406
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26406;
-- OLD subname : 赌徒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26442
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26442;
-- OLD subname : 战歌之子 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26486
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26486;
-- OLD name : [PH] Dragonblight Carrion Field Necromancer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26489
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26489;
-- OLD name : [PH] Dragonblight Carrion Field Zombie (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26490
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26490;
-- OLD name : [PH] Dragonblight Carrion Field Gargoyle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26491
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26491;
-- OLD name : 拉格纳罗斯精魂
-- Source : https://www.wowhead.com/wotlk/cn/npc=26502
UPDATE `creature_template_locale` SET `Name` = '拉格纳罗斯的烟雾' WHERE `locale` = 'zhCN' AND `entry` = 26502;
-- OLD subname : 探险者协会 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26514
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26514;
-- OLD name : [Demo] Craig Amai (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26535
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26535;
-- OLD subname : 嚎风峡湾飞艇管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26541
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26541;
-- OLD subname : 北风苔原飞艇管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26542
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26542;
-- OLD subname : 码头管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26551
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26551;
-- OLD subname : 码头管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26552
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26552;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26564
UPDATE `creature_template_locale` SET `Title` = '宗师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 26564;
-- OLD name : [PH] Justin's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26576
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26576;
-- OLD name : [PH] Named Condor Shirrak (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26665
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26665;
-- OLD name : Rabid Dire Bear *Unused* (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26671
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26671;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26671, 'zhCN','NPC',NULL);
-- OLD name : 银溪镇猎人
-- Source : https://www.wowhead.com/wotlk/cn/npc=26679
UPDATE `creature_template_locale` SET `Name` = '银溪镇猎户' WHERE `locale` = 'zhCN' AND `entry` = 26679;
-- OLD name : 雪原徒工
-- Source : https://www.wowhead.com/wotlk/cn/npc=26705
UPDATE `creature_template_locale` SET `Name` = '冰原徒工' WHERE `locale` = 'zhCN' AND `entry` = 26705;
-- OLD name : [DND] TAR Pedestal - Armor, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26724
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26724;
-- OLD name : [dnd] Fizzcrank Paratrooper Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26732
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26732;
-- OLD name : [DND] TAR Pedestal - Accessories (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26738
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26738;
-- OLD name : [DND] TAR Pedestal - Enchantments (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26739
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26739;
-- OLD name : [DND] TAR Pedestal - Gems (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26740
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26740;
-- OLD name : [DND] TAR Pedestal - General Goods (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26741
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26741;
-- OLD name : [DND] TAR Pedestal - Armor, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26742
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26742;
-- OLD name : [DND] TAR Pedestal - Glyph, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26743
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26743;
-- OLD name : [DND] TAR Pedestal - Glyph, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26744
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26744;
-- OLD name : [DND] TAR Pedestal - Weapons (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26745
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26745;
-- OLD name : [DND] TAR Pedestal - Arena Organizer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26747
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26747;
-- OLD name : [DND] TAR Pedestal - Beastmaster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26748
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26748;
-- OLD name : [DND] TAR Pedestal - Paymaster (-> Monk) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26749
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26749;
-- OLD name : [DND] TAR Pedestal - Teleporter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26750
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26750;
-- OLD name : [DND] TAR Pedestal - Trainer, Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26751
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26751;
-- OLD name : [DND] TAR Pedestal - Trainer, Hunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26752
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26752;
-- OLD name : [DND] TAR Pedestal - Trainer, Mage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26753
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26753;
-- OLD name : [DND] TAR Pedestal - Trainer, Paladin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26754
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26754;
-- OLD name : [DND] TAR Pedestal - Trainer, Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26755
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26755;
-- OLD name : [DND] TAR Pedestal - Trainer, Rogue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26756
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26756;
-- OLD name : [DND] TAR Pedestal - Trainer, Shaman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26757
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26757;
-- OLD name : [DND] TAR Pedestal - Trainer, Warlock (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26758
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26758;
-- OLD name : [DND] TAR Pedestal - Trainer, Warrior (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26759
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26759;
-- OLD name : [DND] TAR Pedestal - Fight Promoter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26765
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26765;
-- OLD name : [PH] Dragonblight Shoveltusk Scavenger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26835
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26835;
-- OLD name : [PH] Dragonblight Named Frost Wyrm Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26840
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26840;
-- OLD name : [PH] Vanguard Landing Flight Master, subname : 双足飞龙管理员 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=26842
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 26842;
-- OLD subname : 双足飞龙管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26846
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26846;
-- OLD subname : 炼金术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26903
UPDATE `creature_template_locale` SET `Title` = '宗师级炼金术训练师' WHERE `locale` = 'zhCN' AND `entry` = 26903;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26904
UPDATE `creature_template_locale` SET `Title` = '宗师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 26904;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26905
UPDATE `creature_template_locale` SET `Title` = '宗师级烹饪训练师' WHERE `locale` = 'zhCN' AND `entry` = 26905;
-- OLD subname : 附魔训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26906
UPDATE `creature_template_locale` SET `Title` = '宗师级附魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 26906;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26907
UPDATE `creature_template_locale` SET `Title` = '宗师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 26907;
-- OLD subname : 钓鱼训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26909
UPDATE `creature_template_locale` SET `Title` = '宗师级钓鱼训练师' WHERE `locale` = 'zhCN' AND `entry` = 26909;
-- OLD subname : 草药学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26910
UPDATE `creature_template_locale` SET `Title` = '宗师级草药学训练师' WHERE `locale` = 'zhCN' AND `entry` = 26910;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26911
UPDATE `creature_template_locale` SET `Title` = '宗师级制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 26911;
-- OLD subname : 采矿训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26912
UPDATE `creature_template_locale` SET `Title` = '宗师级采矿训练师' WHERE `locale` = 'zhCN' AND `entry` = 26912;
-- OLD subname : 剥皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26913
UPDATE `creature_template_locale` SET `Title` = '宗师级剥皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 26913;
-- OLD subname : 裁缝训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26914
UPDATE `creature_template_locale` SET `Title` = '宗师级裁缝训练师' WHERE `locale` = 'zhCN' AND `entry` = 26914;
-- OLD subname : 珠宝加工训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26915
UPDATE `creature_template_locale` SET `Title` = '宗师级珠宝加工训练师' WHERE `locale` = 'zhCN' AND `entry` = 26915;
-- OLD subname : 铭文训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26916
UPDATE `creature_template_locale` SET `Title` = '宗师级铭文训练师' WHERE `locale` = 'zhCN' AND `entry` = 26916;
-- OLD subname : 探险者协会供给员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26934
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26934;
-- OLD subname : 自救教材商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26947
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26947;
-- OLD subname : 炼金术训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26951
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26951;
-- OLD subname : 锻造训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26952
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26952;
-- OLD subname : 烹饪训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26953
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26953;
-- OLD subname : 附魔训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26954
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26954;
-- OLD subname : 工程学训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26955
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26955;
-- OLD subname : 急救训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26956
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26956;
-- OLD subname : 钓鱼训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26957
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26957;
-- OLD subname : 草药学训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26958
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26958;
-- OLD subname : 铭文训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26959
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26959;
-- OLD subname : 珠宝加工训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26960
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26960;
-- OLD subname : 制皮训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26961
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26961;
-- OLD subname : 采矿训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26962
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26962;
-- OLD subname : 剥皮训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26963
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26963;
-- OLD subname : 裁缝训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=26964
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 26964;
-- OLD subname : 剥皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26986
UPDATE `creature_template_locale` SET `Title` = '宗师级剥皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 26986;
-- OLD subname : 炼金术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26987
UPDATE `creature_template_locale` SET `Title` = '宗师级炼金术训练师' WHERE `locale` = 'zhCN' AND `entry` = 26987;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26989
UPDATE `creature_template_locale` SET `Title` = '宗师级烹饪训练师' WHERE `locale` = 'zhCN' AND `entry` = 26989;
-- OLD subname : 附魔训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26990
UPDATE `creature_template_locale` SET `Title` = '宗师级附魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 26990;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26991
UPDATE `creature_template_locale` SET `Title` = '宗师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 26991;
-- OLD subname : 急救训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26992
UPDATE `creature_template_locale` SET `Title` = '宗师级急救训练师' WHERE `locale` = 'zhCN' AND `entry` = 26992;
-- OLD subname : 钓鱼训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26993
UPDATE `creature_template_locale` SET `Title` = '宗师级钓鱼训练师' WHERE `locale` = 'zhCN' AND `entry` = 26993;
-- OLD subname : 草药学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26994
UPDATE `creature_template_locale` SET `Title` = '宗师级草药学训练师' WHERE `locale` = 'zhCN' AND `entry` = 26994;
-- OLD subname : 铭文训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26995
UPDATE `creature_template_locale` SET `Title` = '宗师级铭文训练师' WHERE `locale` = 'zhCN' AND `entry` = 26995;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26996
UPDATE `creature_template_locale` SET `Title` = '宗师级制皮匠' WHERE `locale` = 'zhCN' AND `entry` = 26996;
-- OLD subname : 珠宝加工训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26997
UPDATE `creature_template_locale` SET `Title` = '宗师级珠宝加工训练师' WHERE `locale` = 'zhCN' AND `entry` = 26997;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26998
UPDATE `creature_template_locale` SET `Title` = '宗师级制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 26998;
-- OLD subname : 采矿训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=26999
UPDATE `creature_template_locale` SET `Title` = '宗师级采矿训练师' WHERE `locale` = 'zhCN' AND `entry` = 26999;
-- OLD subname : 剥皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=27000
UPDATE `creature_template_locale` SET `Title` = '宗师级剥皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 27000;
-- OLD subname : 裁缝训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=27001
UPDATE `creature_template_locale` SET `Title` = '宗师级裁缝训练师' WHERE `locale` = 'zhCN' AND `entry` = 27001;
-- OLD subname : 炼金术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=27023
UPDATE `creature_template_locale` SET `Title` = '大师级炼金术训练师' WHERE `locale` = 'zhCN' AND `entry` = 27023;
-- OLD subname : 商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27026
UPDATE `creature_template_locale` SET `Title` = '材料供应商' WHERE `locale` = 'zhCN' AND `entry` = 27026;
-- OLD subname : 探险者协会 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27114
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27114;
-- OLD subname : 探险者协会 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27115
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27115;
-- OLD name : 雪掌
-- Source : https://www.wowhead.com/wotlk/cn/npc=27119
UPDATE `creature_template_locale` SET `Name` = '雪爪' WHERE `locale` = 'zhCN' AND `entry` = 27119;
-- OLD subname : 食物与饮料 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27137
UPDATE `creature_template_locale` SET `Title` = '餐饮供应商' WHERE `locale` = 'zhCN' AND `entry` = 27137;
-- OLD subname : 材料供应商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27138
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27138;
-- OLD name : 无头骑士的坐骑
-- Source : https://www.wowhead.com/wotlk/cn/npc=27152
UPDATE `creature_template_locale` SET `Name` = 'Headless Horseman Mount, Player' WHERE `locale` = 'zhCN' AND `entry` = 27152;
-- OLD name : 无头骑士的坐骑
-- Source : https://www.wowhead.com/wotlk/cn/npc=27153
UPDATE `creature_template_locale` SET `Name` = 'Headless Horseman Mount, Player, Ground' WHERE `locale` = 'zhCN' AND `entry` = 27153;
-- OLD name : [PH] New Hearthglen Scarlet Footman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=27205
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 27205;
-- OLD name : [PH] New Hearthglen Scarlet Commander (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=27208
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 27208;
-- OLD name : 拷问者里克拉夫
-- Source : https://www.wowhead.com/wotlk/cn/npc=27209
UPDATE `creature_template_locale` SET `Name` = '拷问者阿方斯' WHERE `locale` = 'zhCN' AND `entry` = 27209;
-- OLD name : [PH] New Hearthglen Scarlet Scout (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=27218
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 27218;
-- OLD subname : Assured Quality (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27231
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27231;
-- OLD name : 雪原狂战士
-- Source : https://www.wowhead.com/wotlk/cn/npc=27278
UPDATE `creature_template_locale` SET `Name` = '冰原狂战士' WHERE `locale` = 'zhCN' AND `entry` = 27278;
-- OLD name : 雪原萨满祭司
-- Source : https://www.wowhead.com/wotlk/cn/npc=27279
UPDATE `creature_template_locale` SET `Name` = '冰原萨满祭司' WHERE `locale` = 'zhCN' AND `entry` = 27279;
-- OLD subname : 蝙蝠管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27344
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27344;
-- OLD name : [DND] Stabled Pet Appearance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=27368
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 27368;
-- OLD name : 首席抄写员巴里加
-- Source : https://www.wowhead.com/wotlk/cn/npc=27378
UPDATE `creature_template_locale` SET `Name` = '首席抄写员基尼迪乌斯' WHERE `locale` = 'zhCN' AND `entry` = 27378;
-- OLD name : Wintergarde Inner Gate Attack Trigger
-- Source : https://www.wowhead.com/wotlk/cn/npc=27380
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 27380;
-- OLD name : 黄昏使者塞尔赞
-- Source : https://www.wowhead.com/wotlk/cn/npc=27384
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 27384;
-- OLD name : [DND] Valiance Keep Footman Spectator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=27387
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 27387;
-- OLD name : 纳兹戈林中士
-- Source : https://www.wowhead.com/wotlk/cn/npc=27388
UPDATE `creature_template_locale` SET `Name` = '纳兹格利姆中士' WHERE `locale` = 'zhCN' AND `entry` = 27388;
-- OLD name : Utgarde Duo Trigger
-- Source : https://www.wowhead.com/wotlk/cn/npc=27404
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 27404;
-- OLD name : Clayton Dubin - TEST COPY DATA (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27527
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 27527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (27527, 'zhCN','NPC',NULL);
-- OLD name : 阿弗拉沙斯塔兹
-- Source : https://www.wowhead.com/wotlk/cn/npc=27575
UPDATE `creature_template_locale` SET `Name` = '德弗雷斯塔兹领主' WHERE `locale` = 'zhCN' AND `entry` = 27575;
-- OLD subname : 阿鲁高之手 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27579
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27579;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27586
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27586;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27590
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27590;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27591
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27591;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27592
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27592;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27595
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27595;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27596
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27596;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27599
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27599;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27601
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27601;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27609
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27609;
-- OLD name : [UNUSED] Wrath Gate Crypt Fiend (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=27630
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 27630;
-- OLD subname : 拜狼教新兵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27632
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27632;
-- OLD name : [DND] Aldor Mailbox Malfunction Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=27723
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 27723;
-- OLD subname : 风险硬币商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27730
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27730;
-- OLD subname : 风险硬币商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27760
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27760;
-- OLD subname : 第七军团 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27833
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27833;
-- OLD name : Patty's test vehicle (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27862
UPDATE `creature_template_locale` SET `Name` = 'PattyMack''s test vehicle TEST' WHERE `locale` = 'zhCN' AND `entry` = 27862;
-- OLD subname : 死亡骑士训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27916
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27916;
-- OLD subname : PH MODEL: TASK 17271 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=27968
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 27968;
-- OLD name : [PH] Warp Stalker Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=27976
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 27976;
-- OLD name : 约格莫夫·冰锤中尉
-- Source : https://www.wowhead.com/wotlk/cn/npc=27994
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 27994;
-- OLD subname : 远征队领袖 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28088
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28088;
-- OLD subname : 泰坦的意志 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28115
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28115;
-- OLD name : [ph] exploding barrel (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28173
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28173;
-- OLD name : [ph] Goblin Construction Crew (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28180
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28180;
-- OLD name : [DND] under water construction crew (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28184
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28184;
-- OLD subname : 萨莱因 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28189
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28189;
-- OLD name : [DND] L70ETC Drums (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28206
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28206;
-- OLD subname : 医师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28245
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28245;
-- OLD name : Searing Gaze
-- Source : https://www.wowhead.com/wotlk/cn/npc=28265
UPDATE `creature_template_locale` SET `Name` = '灼热凝视' WHERE `locale` = 'zhCN' AND `entry` = 28265;
-- OLD name : [DND] taxi flavor eagle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28292
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28292;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28310
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28310;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28311
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28311;
-- OLD name : 大战熊
-- Source : https://www.wowhead.com/wotlk/cn/npc=28363
UPDATE `creature_template_locale` SET `Name` = '大型战熊' WHERE `locale` = 'zhCN' AND `entry` = 28363;
-- OLD name : 第七军团攻城坦克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28370
UPDATE `creature_template_locale` SET `Name` = '第七军团攻城技师' WHERE `locale` = 'zhCN' AND `entry` = 28370;
-- OLD subname : 制皮训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28400
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28400;
-- OLD name : [UNUSED]Altar of Quetz'lun Gateway - Real World (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28469
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28469;
-- OLD subname : 冰霜女王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28499
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28499;
-- OLD name : Ronakada (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28501
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28501;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (28501, 'zhCN','NPC',NULL);
-- OLD name : 拷问者里克拉夫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28554
UPDATE `creature_template_locale` SET `Name` = '拷问者阿方斯' WHERE `locale` = 'zhCN' AND `entry` = 28554;
-- OLD subname : 码头管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28650
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28650;
-- OLD name : 奎丝鲁恩先知
-- Source : https://www.wowhead.com/wotlk/cn/npc=28671
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 28671;
-- OLD subname : 银行职员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28678
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28678;
-- OLD subname : 银行职员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28679
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28679;
-- OLD subname : 银行职员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28680
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28680;
-- OLD subname : 附魔训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28693
UPDATE `creature_template_locale` SET `Title` = '宗师级附魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 28693;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28694
UPDATE `creature_template_locale` SET `Title` = '宗师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 28694;
-- OLD subname : 剥皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28696
UPDATE `creature_template_locale` SET `Title` = '宗师级剥皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 28696;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28697
UPDATE `creature_template_locale` SET `Title` = '宗师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 28697;
-- OLD subname : 采矿训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28698
UPDATE `creature_template_locale` SET `Title` = '宗师级采矿训练师' WHERE `locale` = 'zhCN' AND `entry` = 28698;
-- OLD subname : 裁缝训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28699
UPDATE `creature_template_locale` SET `Title` = '宗师级裁缝训练师' WHERE `locale` = 'zhCN' AND `entry` = 28699;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28700
UPDATE `creature_template_locale` SET `Title` = '宗师级制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 28700;
-- OLD subname : 珠宝加工训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28701
UPDATE `creature_template_locale` SET `Title` = '宗师级珠宝加工训练师' WHERE `locale` = 'zhCN' AND `entry` = 28701;
-- OLD subname : 铭文训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28702
UPDATE `creature_template_locale` SET `Title` = '宗师级铭文训练师' WHERE `locale` = 'zhCN' AND `entry` = 28702;
-- OLD subname : 炼金术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28703
UPDATE `creature_template_locale` SET `Title` = '宗师级炼金术训练师' WHERE `locale` = 'zhCN' AND `entry` = 28703;
-- OLD subname : 草药学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28704
UPDATE `creature_template_locale` SET `Title` = '宗师级草药学训练师' WHERE `locale` = 'zhCN' AND `entry` = 28704;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28705
UPDATE `creature_template_locale` SET `Title` = '宗师级烹饪训练师' WHERE `locale` = 'zhCN' AND `entry` = 28705;
-- OLD subname : 急救训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=28706
UPDATE `creature_template_locale` SET `Title` = '宗师级急救训练师' WHERE `locale` = 'zhCN' AND `entry` = 28706;
-- OLD subname : Hit Me! (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28712
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28712;
-- OLD subname : Hit Me! (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28720
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28720;
-- OLD subname : 钓鱼训练师和供应商
-- Source : https://www.wowhead.com/wotlk/cn/npc=28742
UPDATE `creature_template_locale` SET `Title` = '宗师级钓鱼训练师和补给商' WHERE `locale` = 'zhCN' AND `entry` = 28742;
-- OLD name : 哈古斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=28760
UPDATE `creature_template_locale` SET `Name` = '恶鬼哈古斯' WHERE `locale` = 'zhCN' AND `entry` = 28760;
-- OLD name : [Phase 1] Scarlet Crusade Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28763
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28763;
-- OLD name : [Phase 1] Citizen of Havenshire Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28764
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28764;
-- OLD name : [Phase 1] Havenshrie Horse Credit, Step 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28767
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28767;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/cn/npc=28800
UPDATE `creature_template_locale` SET `Title` = '弹药' WHERE `locale` = 'zhCN' AND `entry` = 28800;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/cn/npc=28813
UPDATE `creature_template_locale` SET `Title` = '弹药' WHERE `locale` = 'zhCN' AND `entry` = 28813;
-- OLD subname : Designer Extraordinaire (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28944
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28944;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28949
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28949;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28950
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28950;
-- OLD name : [Chapter II] Scarlet Crusader Test Dummy Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28957
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28957;
-- OLD name : [Chapter II] Scarlet Crusader Proxy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=28984
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 28984;
-- OLD subname : 守夜人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=28987
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 28987;
-- OLD name : [DND] Dockhand w/Bag (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=29020
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 29020;
-- OLD name : [609] Ebon Hold Duel Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=29025
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 29025;
-- OLD name : [Chapter II] Torch Toss Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=29038
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 29038;
-- OLD name : [UNUSED] [ph] Stormwind Gryphon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=29039
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 29039;
-- OLD subname : 部落 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29045
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29045;
-- OLD subname : 部落 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29046
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29046;
-- OLD name : 库格·铁腭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29072
UPDATE `creature_template_locale` SET `Name` = '库格·铁颚' WHERE `locale` = 'zhCN' AND `entry` = 29072;
-- OLD subname : 食物与饮料 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29121
UPDATE `creature_template_locale` SET `Title` = '餐饮供应商' WHERE `locale` = 'zhCN' AND `entry` = 29121;
-- OLD subname : 食物与饮料 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29122
UPDATE `creature_template_locale` SET `Title` = '餐饮供应商' WHERE `locale` = 'zhCN' AND `entry` = 29122;
-- OLD subname : 银色黎明 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29174
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29174;
-- OLD name : [Chapter IV] Chapter IV Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=29192
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 29192;
-- OLD subname : 材料商
-- Source : https://www.wowhead.com/wotlk/cn/npc=29203
UPDATE `creature_template_locale` SET `Title` = '尸尘商人' WHERE `locale` = 'zhCN' AND `entry` = 29203;
-- OLD name : 通往暗影界的传送门 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29218
UPDATE `creature_template_locale` SET `Name` = '通往暗影领域的传送门' WHERE `locale` = 'zhCN' AND `entry` = 29218;
-- OLD subname : 急救训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29233
UPDATE `creature_template_locale` SET `Title` = '绷带训练师' WHERE `locale` = 'zhCN' AND `entry` = 29233;
-- OLD name : [Chapter IV] Light of Dawn Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=29245
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 29245;
-- OLD subname : 兽栏管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29250
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29250;
-- OLD subname : 兽栏管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29251
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29251;
-- OLD subname : 锻造供应商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29252
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29252;
-- OLD subname : 锻造供应商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29253
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29253;
-- OLD subname : 二手攻城车商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29260
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29260;
-- OLD subname : 二手攻城车商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29262
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29262;
-- OLD subname : Hit Me! (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29265
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29265;
-- OLD subname : 银行职员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29283
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29283;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29318
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29318;
-- OLD subname : 炼金术与毒药供应商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29339
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29339;
-- OLD subname : 炼金术与毒药供应商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29348
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29348;
-- OLD name : [PH]TEST Skater (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=29361
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 29361;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29381
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29381;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29383
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29383;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29385
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29385;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29386
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29386;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29387
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29387;
-- OLD subname : 银色黎明 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29441
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29441;
-- OLD subname : 银色黎明 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29442
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29442;
-- OLD subname : Specialty Ammunition
-- Source : https://www.wowhead.com/wotlk/cn/npc=29493
UPDATE `creature_template_locale` SET `Title` = '特殊弹药商人' WHERE `locale` = 'zhCN' AND `entry` = 29493;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=29505
UPDATE `creature_template_locale` SET `Title` = '武器锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 29505;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=29506
UPDATE `creature_template_locale` SET `Title` = '护甲锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 29506;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=29507
UPDATE `creature_template_locale` SET `Title` = '元素制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 29507;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=29508
UPDATE `creature_template_locale` SET `Title` = '龙鳞制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 29508;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=29509
UPDATE `creature_template_locale` SET `Title` = '部族制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 29509;
-- OLD name : “伯爵夫人”莱娜, subname : 竞技场组织者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29534
UPDATE `creature_template_locale` SET `Name` = '“男爵夫人”莱娜',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29534;
-- OLD subname : 精锐竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29539
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29539;
-- OLD subname : 竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29540
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29540;
-- OLD subname : 见习竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29541
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29541;
-- OLD name : 艾美
-- Source : https://www.wowhead.com/wotlk/cn/npc=29548
UPDATE `creature_template_locale` SET `Name` = '艾蜜' WHERE `locale` = 'zhCN' AND `entry` = 29548;
-- OLD subname : 暴风城国王
-- Source : https://www.wowhead.com/wotlk/cn/npc=29611
UPDATE `creature_template_locale` SET `Title` = '暴风城的国王' WHERE `locale` = 'zhCN' AND `entry` = 29611;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=29631
UPDATE `creature_template_locale` SET `Title` = '宗师级烹饪训练师' WHERE `locale` = 'zhCN' AND `entry` = 29631;
-- OLD name : 高阶奥术师西瓦
-- Source : https://www.wowhead.com/wotlk/cn/npc=29657
UPDATE `creature_template_locale` SET `Name` = '高阶奥术师达斯克·阿尔希斯' WHERE `locale` = 'zhCN' AND `entry` = 29657;
-- OLD subname : 阿卡里的高阶先知 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29681
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29681;
-- OLD subname : PH Texture (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29734
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29734;
-- OLD subname : 犸托斯的高阶先知 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29741
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29741;
-- OLD subname : 飞行管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29749
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29749;
-- OLD subname : 双足飞龙管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29762
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29762;
-- OLD name : [DND] Dalaran Toy Store Plane String Hook (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=29807
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 29807;
-- OLD name : [DND] Dalaran Toy Store Plane String Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=29812
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 29812;
-- OLD subname : 斯巴索克的骄傲与快乐 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29841
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29841;
-- OLD subname : 幽灵之狼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29850
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29850;
-- OLD subname : 风暴巨人之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29884
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29884;
-- OLD subname : 希望的终结者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29895
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29895;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=29924
UPDATE `creature_template_locale` SET `Title` = '宗师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 29924;
-- OLD subname : PH: Name, Model (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29933
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29933;
-- OLD name : [UNUSED] [ph] Ulduar Camp (H) Flight Master, subname : 飞行管理员 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=29952
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 29952;
-- OLD subname : 兽栏管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29967
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29967;
-- OLD subname : 毒药与材料 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29968
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29968;
-- OLD subname : 锻造供应商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29969
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29969;
-- OLD subname : 杂货商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29970
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29970;
-- OLD subname : 旅店老板 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=29971
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 29971;
-- OLD name : [DND]Wyrmrest Temple Beam Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30078
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30078;
-- OLD name : 暮光新教徒
-- Source : https://www.wowhead.com/wotlk/cn/npc=30114
UPDATE `creature_template_locale` SET `Name` = '暮光新兵' WHERE `locale` = 'zhCN' AND `entry` = 30114;
-- OLD subname : 诅咒教派 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30149
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30149;
-- OLD subname : 兽栏管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30155
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30155;
-- OLD name : [DND] Anguish Spectator Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30156
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30156;
-- OLD subname : 杰希卡·莫里斯的伙伴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30157
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30157;
-- OLD subname : 妮可·莫里斯的伙伴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30158
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30158;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30171
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30171;
-- OLD subname : 霜脉矮人之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30182
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30182;
-- OLD subname : 食物与饮料 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30254
UPDATE `creature_template_locale` SET `Title` = '餐饮供应商' WHERE `locale` = 'zhCN' AND `entry` = 30254;
-- OLD subname : 洛肯的仆从 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30296
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30296;
-- OLD subname : 旅店老板 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30308
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30308;
-- OLD subname : 食物与饮料 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30309
UPDATE `creature_template_locale` SET `Title` = '餐饮供应商' WHERE `locale` = 'zhCN' AND `entry` = 30309;
-- OLD subname : 商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30311
UPDATE `creature_template_locale` SET `Title` = '材料供应商' WHERE `locale` = 'zhCN' AND `entry` = 30311;
-- OLD subname : 见证者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30381
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30381;
-- OLD subname : 霜脉矮人之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30408
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30408;
-- OLD subname : 铁炉堡国王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30411
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30411;
-- OLD subname : 女妖之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30426
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30426;
-- OLD subname : 女妖之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30427
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30427;
-- OLD subname : 女妖之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30428
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30428;
-- OLD subname : 洛肯的仆从 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30429
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30429;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/cn/npc=30437
UPDATE `creature_template_locale` SET `Title` = '弹药' WHERE `locale` = 'zhCN' AND `entry` = 30437;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30476
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30476;
-- OLD name : [UNUSED] Wrathstrike Gargoyle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30545
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30545;
-- OLD name : [UNUSED] Reanimated Crusader, subname : PH MODEL: Task 25946 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30546
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30546;
-- OLD name : 弗拉斯·希亚比
-- Source : https://www.wowhead.com/wotlk/cn/npc=30552
UPDATE `creature_template_locale` SET `Name` = '艾兹拉·格里姆' WHERE `locale` = 'zhCN' AND `entry` = 30552;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30559
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30559;
-- OLD subname : 远古海滩军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30578
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30578;
-- OLD subname : 远古海滩军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30579
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30579;
-- OLD subname : 远古海滩军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30580
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30580;
-- OLD subname : 远古海滩军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30581
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30581;
-- OLD subname : 远古海滩军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30583
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30583;
-- OLD subname : 远古海滩军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30584
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30584;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30588
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30588;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30589
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30589;
-- OLD subname : 远古海滩军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30590
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30590;
-- OLD name : [UNUSED] Forgotten Depths High Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30594
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30594;
-- OLD subname : 莫洛戈的宠物 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30613
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30613;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30640
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30640;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Even (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30646
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30646;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30649
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30649;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Odd (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30651
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30651;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30655
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30655;
-- OLD subname : 问讯员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30678
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30678;
-- OLD name : [DND] Icecrown Airship (H) - Flak Cannon, Odd (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30690
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30690;
-- OLD name : [DND] Icecrown Airship (H) - Flak Cannon, Even (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30699
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30699;
-- OLD name : [DND] Icecrown Airship (H) - Cannon, Neutral (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30700
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30700;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30707
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30707;
-- OLD subname : 铭文训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=30721
UPDATE `creature_template_locale` SET `Title` = '大师级铭文训练师' WHERE `locale` = 'zhCN' AND `entry` = 30721;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30749
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30749;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=30832
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 30832;
-- OLD subname : 诅咒教派 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30835
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30835;
-- OLD subname : 古代英雄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30884
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30884;
-- OLD subname : 传承竞技场护甲
-- Source : https://www.wowhead.com/wotlk/cn/npc=30885
UPDATE `creature_template_locale` SET `Title` = '饮料商人' WHERE `locale` = 'zhCN' AND `entry` = 30885;
-- OLD subname : 古代英雄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30886
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30886;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30888
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30888;
-- OLD subname : 古代英雄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30924
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30924;
-- OLD subname : 冰霜骑士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=30956
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 30956;
-- OLD name : [UNUSED] The Lich King (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=31014
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 31014;
-- OLD subname : 尤顿海姆的主宰 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31016
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31016;
-- OLD subname : 女招待 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31026
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31026;
-- OLD name : Russell Bernau Test NPC (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31060
UPDATE `creature_template_locale` SET `Name` = 'Ali Garchanter [TEST]' WHERE `locale` = 'zhCN' AND `entry` = 31060;
-- OLD subname : Emporium of AWESOME (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31076
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31076;
-- OLD subname : Emporium of AWESOME (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31116
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31116;
-- OLD name : 血腥的肉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31119
UPDATE `creature_template_locale` SET `Name` = '血淋淋的肉' WHERE `locale` = 'zhCN' AND `entry` = 31119;
-- OLD name : Reinforced Training Dummy (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31143
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 31143;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31143, 'zhCN','NPC',NULL);
-- OLD name : 训练假人
-- Source : https://www.wowhead.com/wotlk/cn/npc=31144
UPDATE `creature_template_locale` SET `Name` = '宗师的训练假人' WHERE `locale` = 'zhCN' AND `entry` = 31144;
-- OLD name : 团队副本训练假人
-- Source : https://www.wowhead.com/wotlk/cn/npc=31146
UPDATE `creature_template_locale` SET `Name` = '英雄训练假人' WHERE `locale` = 'zhCN' AND `entry` = 31146;
-- OLD subname : 邪恶骑士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31160
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31160;
-- OLD subname : 冰霜骑士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31161
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31161;
-- OLD subname : 萨芙的坐骑 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31163
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31163;
-- OLD subname : 贝洛克的坐骑 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31221
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31221;
-- OLD subname : 萨芙的坐骑 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31224
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31224;
-- OLD name : 林地活木
-- Source : https://www.wowhead.com/wotlk/cn/npc=31228
UPDATE `creature_template_locale` SET `Name` = '林地行者' WHERE `locale` = 'zhCN' AND `entry` = 31228;
-- OLD subname : Emporium of AWESOME (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31234
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31234;
-- OLD name : [DND] Icecrown Airship Cannon Explosion Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=31246
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 31246;
-- OLD subname : 飞行训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=31247
UPDATE `creature_template_locale` SET `Title` = '寒冷天气飞行训练师' WHERE `locale` = 'zhCN' AND `entry` = 31247;
-- OLD subname : 飞行训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31248
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31248;
-- OLD subname : 死亡一击 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31277
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31277;
-- OLD subname : 传承正义军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31300
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31300;
-- OLD subname : 英雄纹章军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31302
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31302;
-- OLD subname : 传承正义军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31305
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31305;
-- OLD subname : 黑锋骑士团 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31306
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31306;
-- OLD subname : 勇气纹章军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31307
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31307;
-- OLD subname : Emporium of AWESOME (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31331
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31331;
-- OLD name : [DND] Icecrown Airship (N) - Attack Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=31353
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 31353;
-- OLD subname : 枪械商
-- Source : https://www.wowhead.com/wotlk/cn/npc=31423
UPDATE `creature_template_locale` SET `Title` = '枪械和弹药商' WHERE `locale` = 'zhCN' AND `entry` = 31423;
-- OLD subname : 荣誉军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31545
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31545;
-- OLD subname : 精锐荣誉军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31549
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31549;
-- OLD subname : 精锐荣誉军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31551
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31551;
-- OLD subname : 荣誉军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31552
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31552;
-- OLD subname : 炮手 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31648
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31648;
-- OLD name : Bronze Drake (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31696
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 31696;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31696, 'zhCN','NPC',NULL);
-- OLD name : 暮光幼龙
-- Source : https://www.wowhead.com/wotlk/cn/npc=31698
UPDATE `creature_template_locale` SET `Name` = '暮光幼龙坐骑' WHERE `locale` = 'zhCN' AND `entry` = 31698;
-- OLD subname : Hit Me! (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31744
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31744;
-- OLD subname : 绿背岛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31804
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31804;
-- OLD subname : 绿背岛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31806
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31806;
-- OLD name : 蓝龙卵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31836
UPDATE `creature_template_locale` SET `Name` = '蓝龙蛋' WHERE `locale` = 'zhCN' AND `entry` = 31836;
-- OLD subname : 炮手 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31839
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31839;
-- OLD name : 纳格尔·拉斯克, subname : 精锐竞技场商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=31863
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31863;
-- OLD name : 佐姆·波克, subname : 见习竞技场商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=31865
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31865;
-- OLD subname : Emporium of AWESOME (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=31872
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 31872;
-- OLD name : 堕落英雄之魂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32149
UPDATE `creature_template_locale` SET `Name` = '陨落英雄之魂' WHERE `locale` = 'zhCN' AND `entry` = 32149;
-- OLD name : 迷失始祖幼龙 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32153
UPDATE `creature_template_locale` SET `Name` = '迷时始祖幼龙' WHERE `locale` = 'zhCN' AND `entry` = 32153;
-- OLD name : [DND] Icecrown Airship Bomb (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=32193
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 32193;
-- OLD subname : 诅咒教派 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32293
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32293;
-- OLD subname : 诅咒教派 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32300
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32300;
-- OLD subname : 暴风城国王
-- Source : https://www.wowhead.com/wotlk/cn/npc=32303
UPDATE `creature_template_locale` SET `Title` = '暴风城的国王' WHERE `locale` = 'zhCN' AND `entry` = 32303;
-- OLD name : [DND] Dalaran Sewer Arena - Controller - Death (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=32328
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 32328;
-- OLD subname : 竞技场组织者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32329
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32329;
-- OLD name : [DND] Dalaran Sewer Arena - Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=32339
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 32339;
-- OLD subname : 塞拉摩的统治者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32346
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32346;
-- OLD name : 雷尼·“招牌微笑”·斯莫
-- Source : https://www.wowhead.com/wotlk/cn/npc=32354
UPDATE `creature_template_locale` SET `Name` = '雷尼·斯莫' WHERE `locale` = 'zhCN' AND `entry` = 32354;
-- OLD name : 阿吉克斯·艾鲁加, subname : 精锐竞技场商人
-- Source : https://www.wowhead.com/wotlk/cn/npc=32359
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32359;
-- OLD subname : 塞拉摩的统治者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32364
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32364;
-- OLD subname : 女妖之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32365
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32365;
-- OLD subname : 珠宝加工军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32384
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32384;
-- OLD name : 桃丽丝·沃兰休斯, subname : 精锐护甲军需官
-- Source : https://www.wowhead.com/wotlk/cn/npc=32385
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32385;
-- OLD subname : 暴风城国王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32401
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32401;
-- OLD subname : 塞拉摩的统治者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32402
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32402;
-- OLD subname : 冰霜女王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32446
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32446;
-- OLD name : 迷失始祖幼龙 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32491
UPDATE `creature_template_locale` SET `Name` = '迷时始祖幼龙' WHERE `locale` = 'zhCN' AND `entry` = 32491;
-- OLD subname : 酋长 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32518
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32518;
-- OLD name : [UNUSED] Spirit Healer (WGA) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=32536
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 32536;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32556
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32556;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32557
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32557;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32558
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32558;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32559
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32559;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32560
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32560;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32561
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32561;
-- OLD subname : 部落远征军军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32565
UPDATE `creature_template_locale` SET `Title` = '部落先遣军军需官' WHERE `locale` = 'zhCN' AND `entry` = 32565;
-- OLD name : [DND] Cosmetic Book (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=32606
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 32606;
-- OLD subname : 旅行商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32649
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32649;
-- OLD subname : 破霜号的船长 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32657
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32657;
-- OLD subname : 优雅女神号的船长 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32658
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32658;
-- OLD subname : 运棺船的船长 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32659
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32659;
-- OLD subname : 荒芜使者号的船长 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32660
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32660;
-- OLD name : 训练假人
-- Source : https://www.wowhead.com/wotlk/cn/npc=32666
UPDATE `creature_template_locale` SET `Name` = '专家的训练假人' WHERE `locale` = 'zhCN' AND `entry` = 32666;
-- OLD name : 训练假人
-- Source : https://www.wowhead.com/wotlk/cn/npc=32667
UPDATE `creature_template_locale` SET `Name` = '大师的训练假人' WHERE `locale` = 'zhCN' AND `entry` = 32667;
-- OLD name : 克拉提库斯·曼比德尔
-- Source : https://www.wowhead.com/wotlk/cn/npc=32686
UPDATE `creature_template_locale` SET `Name` = '托马斯·里约加因' WHERE `locale` = 'zhCN' AND `entry` = 32686;
-- OLD subname : 死亡骑士雕文
-- Source : https://www.wowhead.com/wotlk/cn/npc=32753
UPDATE `creature_template_locale` SET `Title` = '死亡骑士补给' WHERE `locale` = 'zhCN' AND `entry` = 32753;
-- OLD subname : 德鲁伊雕文
-- Source : https://www.wowhead.com/wotlk/cn/npc=32754
UPDATE `creature_template_locale` SET `Title` = '德鲁伊补给' WHERE `locale` = 'zhCN' AND `entry` = 32754;
-- OLD subname : 猎人雕文
-- Source : https://www.wowhead.com/wotlk/cn/npc=32755
UPDATE `creature_template_locale` SET `Title` = '猎人补给' WHERE `locale` = 'zhCN' AND `entry` = 32755;
-- OLD subname : 法师雕文
-- Source : https://www.wowhead.com/wotlk/cn/npc=32756
UPDATE `creature_template_locale` SET `Title` = '法师补给' WHERE `locale` = 'zhCN' AND `entry` = 32756;
-- OLD subname : 圣骑士雕文
-- Source : https://www.wowhead.com/wotlk/cn/npc=32757
UPDATE `creature_template_locale` SET `Title` = '圣骑士补给' WHERE `locale` = 'zhCN' AND `entry` = 32757;
-- OLD subname : 牧师雕文
-- Source : https://www.wowhead.com/wotlk/cn/npc=32758
UPDATE `creature_template_locale` SET `Title` = '牧师补给' WHERE `locale` = 'zhCN' AND `entry` = 32758;
-- OLD subname : 潜行者雕文
-- Source : https://www.wowhead.com/wotlk/cn/npc=32759
UPDATE `creature_template_locale` SET `Title` = '潜行者补给' WHERE `locale` = 'zhCN' AND `entry` = 32759;
-- OLD subname : 萨满祭司雕文
-- Source : https://www.wowhead.com/wotlk/cn/npc=32760
UPDATE `creature_template_locale` SET `Title` = '萨满祭司补给' WHERE `locale` = 'zhCN' AND `entry` = 32760;
-- OLD subname : 术士雕文
-- Source : https://www.wowhead.com/wotlk/cn/npc=32761
UPDATE `creature_template_locale` SET `Title` = '术士补给' WHERE `locale` = 'zhCN' AND `entry` = 32761;
-- OLD subname : 战士雕文
-- Source : https://www.wowhead.com/wotlk/cn/npc=32762
UPDATE `creature_template_locale` SET `Title` = '战士补给' WHERE `locale` = 'zhCN' AND `entry` = 32762;
-- OLD subname : 部落远征军军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32774
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32774;
-- OLD name : Web Wrap Visual
-- Source : https://www.wowhead.com/wotlk/cn/npc=32785
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 32785;
-- OLD subname : QA Punching Bag (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32794
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32794;
-- OLD name : [PH] Pilgrim's Bounty Table - Turkey (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=32824
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 32824;
-- OLD name : [PH] Pilgrim's Bounty Table - Yams (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=32825
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 32825;
-- OLD name : [PH] Pilgrim's Bounty Table - Cranberry Sauce (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=32827
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 32827;
-- OLD name : [PH] Pilgrim's Bounty Table - Pie (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=32829
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 32829;
-- OLD name : [PH] Pilgrim's Bounty Table - Stuffing (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=32831
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 32831;
-- OLD name : 骑士中尉袭月
-- Source : https://www.wowhead.com/wotlk/cn/npc=32834
UPDATE `creature_template_locale` SET `Name` = '骑士中尉穆斯塔克' WHERE `locale` = 'zhCN' AND `entry` = 32834;
-- OLD subname : 牧师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32848
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32848;
-- OLD subname : Warrior (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32849
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32849;
-- OLD subname : 剑圣 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=32870
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 32870;
-- OLD name : 坍缩之星
-- Source : https://www.wowhead.com/wotlk/cn/npc=32955
UPDATE `creature_template_locale` SET `Name` = '坍缩星' WHERE `locale` = 'zhCN' AND `entry` = 32955;
-- OLD name : [ph] justin test backstab target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33049
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33049;
-- OLD name : [PH] Joust Horse (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33130
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33130;
-- OLD name : [PH] Joust Knight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33135
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33135;
-- OLD name : [DND] TAR Pedestal - Trainer, Death Knight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33252
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33252;
-- OLD subname : The Cutest McWeaksauce (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33290
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33290;
-- OLD name : [DND] Tournament - TEST NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33305
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33305;
-- OLD name : [DND] Tournament - Ranged Target Dummy - Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33339
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33339;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Charge Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33340
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33340;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Block Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33341
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33341;
-- OLD name : Morgan Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33351
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33351;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (33351, 'zhCN','NPC',NULL);
-- OLD name : [ph] Tournament War Elekk - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33415
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33415;
-- OLD subname : 暴风城的骑士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33439
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33439;
-- OLD name : [ph] Tournament War Kodo - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33450
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33450;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 01 - Weak Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33489
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33489;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 02 -Speedy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33490
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33490;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 03 - Block Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33491
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33491;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 04 - Strong Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33492
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33492;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 05 - Ultimate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33493
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33493;
-- OLD name : [ph] Tournament - Daily Combatant Summoner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33501
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33501;
-- OLD name : [ph] Tournament - Mounted Combatant - Valiant Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33520
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33520;
-- OLD name : [ph] Tournament - Mounted Combatant - Champion Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33521
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33521;
-- OLD subname : 诅咒教派 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33537
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33537;
-- OLD subname : 裁缝训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33580
UPDATE `creature_template_locale` SET `Title` = '宗师级裁缝训练师' WHERE `locale` = 'zhCN' AND `entry` = 33580;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33581
UPDATE `creature_template_locale` SET `Title` = '宗师级制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 33581;
-- OLD subname : 附魔训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33583
UPDATE `creature_template_locale` SET `Title` = '宗师级附魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 33583;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33586
UPDATE `creature_template_locale` SET `Title` = '宗师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 33586;
-- OLD subname : 烹饪训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33587
UPDATE `creature_template_locale` SET `Title` = '宗师级烹饪训练师' WHERE `locale` = 'zhCN' AND `entry` = 33587;
-- OLD subname : 炼金术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33588
UPDATE `creature_template_locale` SET `Title` = '宗师级炼金训练师' WHERE `locale` = 'zhCN' AND `entry` = 33588;
-- OLD subname : 急救训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33589
UPDATE `creature_template_locale` SET `Title` = '宗师级急救训练师' WHERE `locale` = 'zhCN' AND `entry` = 33589;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33591
UPDATE `creature_template_locale` SET `Title` = '宗师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 33591;
-- OLD subname : 珠宝供应商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33602
UPDATE `creature_template_locale` SET `Title` = '珠宝加工供应商' WHERE `locale` = 'zhCN' AND `entry` = 33602;
-- OLD subname : 铭文训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33603
UPDATE `creature_template_locale` SET `Title` = '宗师级铭文训练师' WHERE `locale` = 'zhCN' AND `entry` = 33603;
-- OLD name : 急救 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33621
UPDATE `creature_template_locale` SET `Name` = '绷带图样' WHERE `locale` = 'zhCN' AND `entry` = 33621;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33631
UPDATE `creature_template_locale` SET `Title` = '大师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 33631;
-- OLD subname : 附魔训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33633
UPDATE `creature_template_locale` SET `Title` = '大师级附魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 33633;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33634
UPDATE `creature_template_locale` SET `Title` = '大师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 33634;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33635
UPDATE `creature_template_locale` SET `Title` = '大师级制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 33635;
-- OLD subname : 裁缝训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33636
UPDATE `creature_template_locale` SET `Title` = '大师级裁缝训练师' WHERE `locale` = 'zhCN' AND `entry` = 33636;
-- OLD subname : 珠宝加工训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33637
UPDATE `creature_template_locale` SET `Title` = '大师级珠宝加工训练师' WHERE `locale` = 'zhCN' AND `entry` = 33637;
-- OLD subname : 铭文训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33638
UPDATE `creature_template_locale` SET `Title` = '大师级铭文训练师' WHERE `locale` = 'zhCN' AND `entry` = 33638;
-- OLD subname : 采矿训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33640
UPDATE `creature_template_locale` SET `Title` = '大师级采矿训练师' WHERE `locale` = 'zhCN' AND `entry` = 33640;
-- OLD subname : 剥皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33641
UPDATE `creature_template_locale` SET `Title` = '大师级剥皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 33641;
-- OLD name : 阿玛里尔·誓日
-- Source : https://www.wowhead.com/wotlk/cn/npc=33658
UPDATE `creature_template_locale` SET `Name` = '阿玛里尔·火盟' WHERE `locale` = 'zhCN' AND `entry` = 33658;
-- OLD subname : Shirt of Uber Vendor (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33665
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33665;
-- OLD subname : 企鹅王子 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33673
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33673;
-- OLD subname : 炼金术训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33674
UPDATE `creature_template_locale` SET `Title` = '大师级炼金术训练师' WHERE `locale` = 'zhCN' AND `entry` = 33674;
-- OLD subname : 锻造训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33675
UPDATE `creature_template_locale` SET `Title` = '大师级锻造训练师' WHERE `locale` = 'zhCN' AND `entry` = 33675;
-- OLD subname : 附魔训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33676
UPDATE `creature_template_locale` SET `Title` = '大师级附魔训练师' WHERE `locale` = 'zhCN' AND `entry` = 33676;
-- OLD subname : 工程学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33677
UPDATE `creature_template_locale` SET `Title` = '大师级工程学训练师' WHERE `locale` = 'zhCN' AND `entry` = 33677;
-- OLD subname : 草药学训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33678
UPDATE `creature_template_locale` SET `Title` = '大师级草药学训练师' WHERE `locale` = 'zhCN' AND `entry` = 33678;
-- OLD subname : 铭文训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33679
UPDATE `creature_template_locale` SET `Title` = '大师级铭文训练师' WHERE `locale` = 'zhCN' AND `entry` = 33679;
-- OLD subname : 珠宝加工训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33680
UPDATE `creature_template_locale` SET `Title` = '大师级珠宝加工训练师' WHERE `locale` = 'zhCN' AND `entry` = 33680;
-- OLD subname : 制皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33681
UPDATE `creature_template_locale` SET `Title` = '大师级制皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 33681;
-- OLD subname : 采矿训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33682
UPDATE `creature_template_locale` SET `Title` = '大师级采矿训练师' WHERE `locale` = 'zhCN' AND `entry` = 33682;
-- OLD subname : 剥皮训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33683
UPDATE `creature_template_locale` SET `Title` = '大师级剥皮训练师' WHERE `locale` = 'zhCN' AND `entry` = 33683;
-- OLD subname : 裁缝训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=33684
UPDATE `creature_template_locale` SET `Title` = '大师级裁缝训练师' WHERE `locale` = 'zhCN' AND `entry` = 33684;
-- OLD subname : 钓鱼大师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33685
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33685;
-- OLD name : 银色冠军 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33707
UPDATE `creature_template_locale` SET `Name` = '银色勇士' WHERE `locale` = 'zhCN' AND `entry` = 33707;
-- OLD subname : 烈酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33708
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33708;
-- OLD name : [ph] test tournament charger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=33784
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 33784;
-- OLD name : Mimiron Focus Points
-- Source : https://www.wowhead.com/wotlk/cn/npc=33835
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 33835;
-- OLD subname : 饮料商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33867
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33867;
-- OLD subname : 精锐竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33915
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33915;
-- OLD subname : 竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33916
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33916;
-- OLD subname : 见习竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33917
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33917;
-- OLD subname : 精锐竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33918
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33918;
-- OLD subname : 见习竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33919
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33919;
-- OLD subname : 竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33920
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33920;
-- OLD subname : 精锐竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33921
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33921;
-- OLD subname : 竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33922
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33922;
-- OLD subname : 见习竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33923
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33923;
-- OLD subname : 精锐竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33924
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33924;
-- OLD subname : 见习竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33925
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33925;
-- OLD subname : 竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33926
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33926;
-- OLD subname : 精锐竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33927
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33927;
-- OLD subname : 竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33928
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33928;
-- OLD subname : 见习竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33929
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33929;
-- OLD subname : 见习竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33930
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33930;
-- OLD subname : 精锐竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33931
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33931;
-- OLD subname : 竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33932
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33932;
-- OLD subname : 竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33933
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33933;
-- OLD subname : 见习竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33934
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33934;
-- OLD subname : 竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33935
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33935;
-- OLD subname : 精锐竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33936
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33936;
-- OLD subname : 竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33937
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33937;
-- OLD subname : 见习竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33938
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33938;
-- OLD subname : 精锐竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33939
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33939;
-- OLD subname : 精锐竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33940
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33940;
-- OLD subname : 见习竞技场商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33941
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33941;
-- OLD subname : Emporium of AWESOME (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33946
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33946;
-- OLD name : 爆炸的地精凿石器
-- Source : https://www.wowhead.com/wotlk/cn/npc=33958
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 33958;
-- OLD subname : 钓鱼大师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=33992
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 33992;
-- OLD subname : 见习护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34036
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34036;
-- OLD subname : 见习护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34037
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34037;
-- OLD subname : 见习护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34038
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34038;
-- OLD subname : 珠宝加工军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34039
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34039;
-- OLD subname : 珠宝加工军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34040
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34040;
-- OLD subname : Designer Extraordinaire (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34042
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34042;
-- OLD name : 布莱恩·铜须的电台
-- Source : https://www.wowhead.com/wotlk/cn/npc=34054
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 34054;
-- OLD subname : 精锐护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34058
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34058;
-- OLD subname : 精锐护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34059
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34059;
-- OLD subname : 精锐护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34060
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34060;
-- OLD subname : 诺森德护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34061
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34061;
-- OLD subname : 诺森德护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34062
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34062;
-- OLD subname : 诺森德护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34063
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34063;
-- OLD subname : 见习护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34073
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34073;
-- OLD subname : 见习护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34074
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34074;
-- OLD subname : 见习护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34075
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34075;
-- OLD subname : 精锐护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34076
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34076;
-- OLD subname : 精锐护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34077
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34077;
-- OLD subname : 精锐护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34078
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34078;
-- OLD subname : 珠宝加工军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34080
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34080;
-- OLD subname : 珠宝加工军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34081
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34081;
-- OLD subname : 护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34082
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34082;
-- OLD subname : 诺森德护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34083
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34083;
-- OLD subname : 诺森德护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34084
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34084;
-- OLD subname : 优质竞技场装备 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34087
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34087;
-- OLD subname : 优质竞技场装备 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34088
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34088;
-- OLD subname : 优质竞技场装备 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34089
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34089;
-- OLD subname : 优质竞技场装备 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34090
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34090;
-- OLD subname : 优质竞技场装备 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34091
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34091;
-- OLD subname : 优质竞技场装备 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34092
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34092;
-- OLD subname : 优质竞技场装备 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34093
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34093;
-- OLD subname : 优质竞技场装备 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34094
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34094;
-- OLD subname : 优质竞技场装备 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34095
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34095;
-- OLD subname : Ulduar 10 Vehicle Test Gear (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34168
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34168;
-- OLD subname : The Flaming Falcon (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34172
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34172;
-- OLD subname : Future Loot Tier Vendor (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34173
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34173;
-- OLD name : 黑色骸骨军马
-- Source : https://www.wowhead.com/wotlk/cn/npc=34238
UPDATE `creature_template_locale` SET `Name` = '黑色骷髅战马' WHERE `locale` = 'zhCN' AND `entry` = 34238;
-- OLD name : [DND]Azeroth Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34281
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34281;
-- OLD name : [DND] Champion Go-To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34319
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34319;
-- OLD name : [DND]Northrend Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34381
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34381;
-- OLD subname : 萨满祭司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34444
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34444;
-- OLD subname : 法师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34449
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34449;
-- OLD subname : 德鲁伊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34451
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34451;
-- OLD subname : 圣骑士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34456
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34456;
-- OLD subname : 德鲁伊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34460
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34460;
-- OLD subname : 死亡骑士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34461
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34461;
-- OLD subname : 圣骑士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34465
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34465;
-- OLD subname : 猎人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34467
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34467;
-- OLD subname : 萨满祭司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34470
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34470;
-- OLD subname : 圣骑士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34471
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34471;
-- OLD subname : 牧师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34473
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34473;
-- OLD subname : 战士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34475
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34475;
-- OLD name : ScottM Test Creature (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34533
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34533;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (34533, 'zhCN','NPC',NULL);
-- OLD name : 白骨战马 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34552
UPDATE `creature_template_locale` SET `Name` = '白色骷髅战马' WHERE `locale` = 'zhCN' AND `entry` = 34552;
-- OLD name : 迅捷灰色战马 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34557
UPDATE `creature_template_locale` SET `Name` = '迅捷灰马' WHERE `locale` = 'zhCN' AND `entry` = 34557;
-- OLD name : [DND] Stink Bomb Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34562
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34562;
-- OLD name : [DND] Battle-Bot - Blue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34588
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34588;
-- OLD name : [DND] Battle-Bot - Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34589
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34589;
-- OLD name : 爱德华·文斯洛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34644
UPDATE `creature_template_locale` SET `Name` = '爱德华·温斯洛' WHERE `locale` = 'zhCN' AND `entry` = 34644;
-- OLD subname : 烹饪训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34712
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34712;
-- OLD subname : 烹饪训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34714
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34714;
-- OLD subname : 西风号
-- Source : https://www.wowhead.com/wotlk/cn/npc=34715
UPDATE `creature_template_locale` SET `Title` = '塞菲尔' WHERE `locale` = 'zhCN' AND `entry` = 34715;
-- OLD subname : 西风号
-- Source : https://www.wowhead.com/wotlk/cn/npc=34717
UPDATE `creature_template_locale` SET `Title` = '塞菲尔' WHERE `locale` = 'zhCN' AND `entry` = 34717;
-- OLD subname : 西风号
-- Source : https://www.wowhead.com/wotlk/cn/npc=34718
UPDATE `creature_template_locale` SET `Title` = '塞菲尔' WHERE `locale` = 'zhCN' AND `entry` = 34718;
-- OLD subname : 西风号
-- Source : https://www.wowhead.com/wotlk/cn/npc=34719
UPDATE `creature_template_locale` SET `Title` = '塞菲尔' WHERE `locale` = 'zhCN' AND `entry` = 34719;
-- OLD subname : 西风号
-- Source : https://www.wowhead.com/wotlk/cn/npc=34721
UPDATE `creature_template_locale` SET `Title` = '塞菲尔' WHERE `locale` = 'zhCN' AND `entry` = 34721;
-- OLD subname : 西风号
-- Source : https://www.wowhead.com/wotlk/cn/npc=34723
UPDATE `creature_template_locale` SET `Title` = '塞菲尔' WHERE `locale` = 'zhCN' AND `entry` = 34723;
-- OLD subname : 西风号
-- Source : https://www.wowhead.com/wotlk/cn/npc=34730
UPDATE `creature_template_locale` SET `Title` = '塞菲尔' WHERE `locale` = 'zhCN' AND `entry` = 34730;
-- OLD name : [DND] Magic Rooster (Draenei Male) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34731
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34731;
-- OLD name : [DND] Magic Rooster (Tauren Male) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34732
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34732;
-- OLD name : 瓦萨林·赤晨
-- Source : https://www.wowhead.com/wotlk/cn/npc=34772
UPDATE `creature_template_locale` SET `Name` = '瓦萨林·彤曦' WHERE `locale` = 'zhCN' AND `entry` = 34772;
-- OLD subname : 烹饪训练师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34786
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34786;
-- OLD subname : 感恩节商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34787
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34787;
-- OLD name : 狗头人奴隶 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34800
UPDATE `creature_template_locale` SET `Name` = '雪地狗头人奴隶' WHERE `locale` = 'zhCN' AND `entry` = 34800;
-- OLD name : 糖心甜薯席位
-- Source : https://www.wowhead.com/wotlk/cn/npc=34824
UPDATE `creature_template_locale` SET `Name` = '糖心甜土豆席位' WHERE `locale` = 'zhCN' AND `entry` = 34824;
-- OLD name : [ph] Argent Raid Spectator - FX - Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34883
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34883;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34887
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34887;
-- OLD name : [PH] Goss Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34889
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34889;
-- OLD name : [PH] Tournament Hippogryph Quest Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34891
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34891;
-- OLD name : [PH] Stabled Argent Hippogryph (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34893
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34893;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34895
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34895;
-- OLD name : [ph] Argent Raid Spectator - FX - Human (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34900
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34900;
-- OLD name : [ph] Argent Raid Spectator - FX - Orc (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34901
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34901;
-- OLD name : [ph] Argent Raid Spectator - FX - Troll (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34902
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34902;
-- OLD name : [ph] Argent Raid Spectator - FX - Tauren (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34903
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34903;
-- OLD name : [ph] Argent Raid Spectator - FX - Blood Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34904
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34904;
-- OLD name : [ph] Argent Raid Spectator - FX - Undead (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34905
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34905;
-- OLD name : [ph] Argent Raid Spectator - FX - Dwarf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34906
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34906;
-- OLD name : [ph] Argent Raid Spectator - FX - Draenei (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34908
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34908;
-- OLD name : [ph] Argent Raid Spectator - FX - Night Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34909
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34909;
-- OLD name : [ph] Argent Raid Spectator - FX - Gnome (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=34910
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 34910;
-- OLD subname : 第七军团 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34924
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34924;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34971
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34971;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34972
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34972;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34973
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34973;
-- OLD subname : 破海者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34980
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34980;
-- OLD subname : 暴风城国王
-- Source : https://www.wowhead.com/wotlk/cn/npc=34990
UPDATE `creature_template_locale` SET `Title` = '暴风城的国王' WHERE `locale` = 'zhCN' AND `entry` = 34990;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=34993
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 34993;
-- OLD name : [ph] Argent Raid Spectator - Generic Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=35016
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 35016;
-- OLD subname : 征服之岛战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35017
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35017;
-- OLD subname : 征服之岛战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35019
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35019;
-- OLD subname : 征服之岛战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35020
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35020;
-- OLD subname : 征服之岛战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35021
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35021;
-- OLD subname : 征服之岛战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35022
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35022;
-- OLD subname : 征服之岛战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35023
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35023;
-- OLD subname : 征服之岛战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35024
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35024;
-- OLD subname : 征服之岛战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35025
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35025;
-- OLD subname : 征服之岛战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35026
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35026;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance Fireworks NOT USED (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=35066
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 35066;
-- OLD subname : 飞行训练师
-- Source : https://www.wowhead.com/wotlk/cn/npc=35100
UPDATE `creature_template_locale` SET `Title` = '骑术训练师' WHERE `locale` = 'zhCN' AND `entry` = 35100;
-- OLD subname : 诅咒神教 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35116
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35116;
-- OLD subname : 诅咒神教 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35127
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35127;
-- OLD subname : 感恩节供应商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35341
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35341;
-- OLD subname : 感恩节供应商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35343
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35343;
-- OLD name : 地精技师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35346
UPDATE `creature_template_locale` SET `Name` = '地精机械师' WHERE `locale` = 'zhCN' AND `entry` = 35346;
-- OLD name : 库卡隆的精英卫士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35460
UPDATE `creature_template_locale` SET `Name` = '库卡隆精英' WHERE `locale` = 'zhCN' AND `entry` = 35460;
-- OLD name : 特拉格·高山 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35462
UPDATE `creature_template_locale` SET `Name` = '特拉格·高岭' WHERE `locale` = 'zhCN' AND `entry` = 35462;
-- OLD subname : 西风号 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35492
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35492;
-- OLD name : 魔导师维莎拉, subname : 凯旋纹章军需官
-- Source : https://www.wowhead.com/wotlk/cn/npc=35495
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35495;
-- OLD subname : 银月城的总冠军 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35569
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35569;
-- OLD subname : 奥格瑞玛的总冠军 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35572
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35572;
-- OLD subname : 凯旋护甲商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35573
UPDATE `creature_template_locale` SET `Title` = '传承正义军需官' WHERE `locale` = 'zhCN' AND `entry` = 35573;
-- OLD subname : 凯旋护甲商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35574
UPDATE `creature_template_locale` SET `Title` = '传承正义军需官' WHERE `locale` = 'zhCN' AND `entry` = 35574;
-- OLD name : 银色守卫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35587
UPDATE `creature_template_locale` SET `Name` = '银色维和者' WHERE `locale` = 'zhCN' AND `entry` = 35587;
-- OLD subname : 冬拥湖战斗法师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35600
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35600;
-- OLD subname : 蒸汽动能拍卖师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35607
UPDATE `creature_template_locale` SET `Title` = '蒸汽动力拍卖师' WHERE `locale` = 'zhCN' AND `entry` = 35607;
-- OLD name : [DND] Dalaran Argent Tournament Herald Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=35608
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 35608;
-- OLD subname : 冬拥湖战斗法师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35611
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35611;
-- OLD subname : 冬拥湖战斗法师 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35612
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35612;
-- OLD subname : 银色演武场统领 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35895
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35895;
-- OLD subname : 银色演武场统领 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35909
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35909;
-- OLD subname : 银色演武场统领 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=35910
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 35910;
-- OLD name : [DNT] Test Dragonhawk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=35983
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 35983;
-- OLD name : [DND] Argent Charger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36071
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36071;
-- OLD name : [DND] Swift Burgundy Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36072
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36072;
-- OLD name : [DND] Swift Horde Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36074
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36074;
-- OLD name : [DND] White Stallion (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36075
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36075;
-- OLD name : [DND] Swift Alliance Steed (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36076
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36076;
-- OLD name : [DND] Forsaken Mariner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36148
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36148;
-- OLD name : [DND] Valgarde Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36154
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36154;
-- OLD name : 库卡隆掠夺者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36164
UPDATE `creature_template_locale` SET `Name` = '库卡隆劫掠者' WHERE `locale` = 'zhCN' AND `entry` = 36164;
-- OLD name : [DND] Bor'gorok Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36167
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36167;
-- OLD name : [DND] Bor'gorok Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36169
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36169;
-- OLD name : [DND]Northrend Children's Week Trigger 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36209
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36209;
-- OLD name : [DND] Crazed Apothecary Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36212
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36212;
-- OLD name : 库卡隆监视者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36213
UPDATE `creature_template_locale` SET `Name` = '幽暗城守护者' WHERE `locale` = 'zhCN' AND `entry` = 36213;
-- OLD name : 监督者克拉加什 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36217
UPDATE `creature_template_locale` SET `Name` = '残缺的躯体' WHERE `locale` = 'zhCN' AND `entry` = 36217;
-- OLD subname : 库拉隆将领 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36273
UPDATE `creature_template_locale` SET `Title` = '酋长之手' WHERE `locale` = 'zhCN' AND `entry` = 36273;
-- OLD subname : 银行职员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36284
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 36284;
-- OLD subname : 银行职员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36351
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 36351;
-- OLD subname : 银行职员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36352
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 36352;
-- OLD subname : 科瑞克的奴仆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36476
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 36476;
-- OLD name : [DND] Valentine Boss - Vial Bunny (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36530
UPDATE `creature_template_locale` SET `Name` = '情人节首领' WHERE `locale` = 'zhCN' AND `entry` = 36530;
-- OLD name : [DND] Valentine Boss Manager (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36643
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36643;
-- OLD subname : 大酋长 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36648
UPDATE `creature_template_locale` SET `Title` = '牛头人大酋长' WHERE `locale` = 'zhCN' AND `entry` = 36648;
-- OLD name : [DND] Apothecary Table (Spell Effect) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36710
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36710;
-- OLD name : [PH] Icecrown Reanimated Crusader (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36726
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36726;
-- OLD subname : 暗夜精灵莫霍克的小伙伴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36778
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 36778;
-- OLD subname : 诅咒教派 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36788
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 36788;
-- OLD name : [PH] Unused Quarry Overseer (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36792
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36792;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36792, 'zhCN','NPC',NULL);
-- OLD name : 天灾领主泰兰努斯
-- Source : https://www.wowhead.com/wotlk/cn/npc=36795
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhCN' AND `entry` = 36795;
-- OLD name : [DND] Love Boat Summoner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36817
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36817;
-- OLD name : 奥妮克希亚座龙 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36837
UPDATE `creature_template_locale` SET `Name` = '奥妮克希亚幼龙' WHERE `locale` = 'zhCN' AND `entry` = 36837;
-- OLD name : [PH] Icecrown Gauntlet Ghoul (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36875
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36875;
-- OLD name : Gryphon Hatchling 3.3.0 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36904
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36904;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36904, 'zhCN','NPC',NULL);
-- OLD name : [PH] Scaling Fire Elemental (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36949
UPDATE `creature_template_locale` SET `Name` = '灼热元素' WHERE `locale` = 'zhCN' AND `entry` = 36949;
-- OLD name : 破天号陆战队员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36950
UPDATE `creature_template_locale` SET `Name` = '破天号士兵' WHERE `locale` = 'zhCN' AND `entry` = 36950;
-- OLD name : 库卡隆收割者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36957
UPDATE `creature_template_locale` SET `Name` = '库卡隆劫掠者' WHERE `locale` = 'zhCN' AND `entry` = 36957;
-- OLD name : [DND] World Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=36966
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 36966;
-- OLD subname : 女妖之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=36990
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 36990;
-- OLD name : [DND]Ground Cover Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37039
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37039;
-- OLD name : [PH] Icecrown Shade (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37128
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37128;
-- OLD name : [DND] Summon Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37168
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37168;
-- OLD name : 伯瓦尔·弗塔根公爵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37183
UPDATE `creature_template_locale` SET `Name` = '大领主伯瓦尔·弗塔根' WHERE `locale` = 'zhCN' AND `entry` = 37183;
-- OLD name : [PH] Ice Stone 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37191
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37191;
-- OLD name : [PH] Ice Stone 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37192
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37192;
-- OLD name : [DND] Summon Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37201
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37201;
-- OLD name : [DND] Summon Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37202
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37202;
-- OLD subname : 女妖之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37223
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37223;
-- OLD subname : 白银之手骑士团 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37225
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37225;
-- OLD subname : 游侠将军 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37527
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37527;
-- OLD name : [DND] Shaker (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37543
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37543;
-- OLD name : [DND]Something Stinks Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37558
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37558;
-- OLD name : [DND] Shaker - Small (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37574
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37574;
-- OLD subname : 银色北伐军军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37693
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37693;
-- OLD subname : 诅咒教派 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37712
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37712;
-- OLD subname : 诅咒教派 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37713
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37713;
-- OLD subname : 冰霜女王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37755
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37755;
-- OLD subname : 奎尔萨拉斯的摄政王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37764
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37764;
-- OLD subname : 高等精灵代表 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37765
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37765;
-- OLD name : [PH] Runner Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37788
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37788;
-- OLD name : [TEST] High Overlord Omar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37820
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37820;
-- OLD subname : 巨龙的女王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37829
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37829;
-- OLD name : [PH] Captain (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37831
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37831;
-- OLD subname : 萨莱因 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37846
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37846;
-- OLD subname : 杂货商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37935
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37935;
-- OLD subname : 铁匠 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37936
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 37936;
-- OLD name : [DND] Love Boat Summoner 02 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37964
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37964;
-- OLD name : [DND] Love Boat Summoner 03 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37981
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37981;
-- OLD name : [DND] Sample Quest Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=37990
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 37990;
-- OLD name : 黑锋骑士团勇士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=37996
UPDATE `creature_template_locale` SET `Name` = '黑锋勇士' WHERE `locale` = 'zhCN' AND `entry` = 37996;
-- OLD subname : 皇冠药剂公司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38040
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 38040;
-- OLD subname : 皇冠药剂公司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38043
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 38043;
-- OLD subname : 皇冠药剂公司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38044
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 38044;
-- OLD subname : 血骑士领袖 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38052
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 38052;
-- OLD name : [DND] Fire Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38053
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38053;
-- OLD name : [PH] Captain (Orgrimmar) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38164
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38164;
-- OLD subname : 女妖之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38189
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 38189;
-- OLD name : 银色盟约专员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38200
UPDATE `creature_template_locale` SET `Name` = '银色盟约密探' WHERE `locale` = 'zhCN' AND `entry` = 38200;
-- OLD name : 爱情火箭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38207
UPDATE `creature_template_locale` SET `Name` = 'X-45偷心火箭' WHERE `locale` = 'zhCN' AND `entry` = 38207;
-- OLD name : [DND] Fire Wall - No Scaling (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38226
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38226;
-- OLD name : [DND] Fire Wall (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38230
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38230;
-- OLD name : [DND] Fire Strat (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38236
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38236;
-- OLD subname : 风险投资公司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38334
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 38334;
-- OLD subname : 风险投资公司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38335
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 38335;
-- OLD subname : 风险投资公司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38336
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 38336;
-- OLD name : [DND] Holiday - Love - Bank Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38340
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38340;
-- OLD name : [DND] Holiday - Love - AH Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38341
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38341;
-- OLD name : [DND] Holiday - Love - Barber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38342
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38342;
-- OLD name : 黑锋骑士团骑士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38505
UPDATE `creature_template_locale` SET `Name` = '黑锋骑士' WHERE `locale` = 'zhCN' AND `entry` = 38505;
-- OLD name : [PH] Matt Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38580
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38580;
-- OLD name : [PH] Matt Test NPC 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38581
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38581;
-- OLD subname : 烈酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38595
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 38595;
-- OLD name : 乌瑟尔·光明使者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38608
UPDATE `creature_template_locale` SET `Name` = '光明使者乌瑟尔' WHERE `locale` = 'zhCN' AND `entry` = 38608;
-- OLD subname : 灰烬使者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38610
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 38610;
-- OLD name : [PH] Grimtotem Protector (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38830
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38830;
-- OLD name : [PH] Grimtotem Collector (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38843
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38843;
-- OLD name : [PH] Slain Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38846
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38846;
-- OLD subname : 寒冰纹章军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38858
UPDATE `creature_template_locale` SET `Title` = '传承正义军需官' WHERE `locale` = 'zhCN' AND `entry` = 38858;
-- OLD name : [DND] Dark Iron Guard Move To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38870
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38870;
-- OLD name : [DND] Mole Machine Spawner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38882
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38882;
-- OLD name : ScottG Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=38883
UPDATE `creature_template_locale` SET `Name` = 'Idle Before Scaling' WHERE `locale` = 'zhCN' AND `entry` = 38883;
-- OLD name : [PH] Grimtotem Vendor (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38905
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38905;
-- OLD name : [PH] Grimtotem Banker, subname : 银行职员 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38919
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38919;
-- OLD name : [PH] Grimtotem Banker 2, subname : 银行职员 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38920
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38920;
-- OLD name : [PH] Grimtotem Banker 3, subname : 银行职员 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=38921
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 38921;
-- OLD name : [DND] TB Event Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39023
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39023;
-- OLD name : [DND] Fire Strat Auto (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39057
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39057;
-- OLD name : [PH] Orc Firefighter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39058
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39058;
-- OLD subname : 大地之环 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=39090
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 39090;
-- OLD subname : 暮光之锤 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=39103
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 39103;
-- OLD name : [DND] Flying Machine (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39229
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39229;
-- OLD subname : 侏儒之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=39271
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 39271;
-- OLD subname : 军医主任 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=39273
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 39273;
-- OLD subname : 大地之环 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=39283
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 39283;
-- OLD name : [DND] Salute Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39355
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39355;
-- OLD name : [DND] Roar Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39356
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39356;
-- OLD name : [DND] Dance Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39361
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39361;
-- OLD name : [DND] Cheer Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39362
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39362;
-- OLD name : [DND] Probe Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39420
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39420;
-- OLD name : 森金哨兵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=39633
UPDATE `creature_template_locale` SET `Name` = '森金村卫兵' WHERE `locale` = 'zhCN' AND `entry` = 39633;
-- OLD subname : 撰稿人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=39678
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 39678;
-- OLD name : [DND] Quest Credit Bunny - Eject (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39683
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39683;
-- OLD name : [DND] Quest Credit Bunny - Move 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39691
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39691;
-- OLD name : [DND] Quest Credit Bunny - Move 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39692
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39692;
-- OLD name : [DND] Quest Credit Bunny - Move 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39695
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39695;
-- OLD name : [DND] Quest Credit Bunny - Attack (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39703
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39703;
-- OLD name : [DND] Attack Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39707
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39707;
-- OLD subname : 侏儒之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=39712
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 39712;
-- OLD name : [DND] GT Bomber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39743
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39743;
-- OLD name : [DND] GT Bomber Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39744
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39744;
-- OLD name : [PH] Mother Trogg (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39798
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39798;
-- OLD subname : 暮光之锤首领 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=39807
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 39807;
-- OLD name : [DND] Summoning Pad (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39817
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39817;
-- OLD name : [DND] Boom Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=39841
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 39841;
-- OLD subname : 暮光之锤 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=39940
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 39940;
-- OLD name : 霜娃娃
-- Source : https://www.wowhead.com/wotlk/cn/npc=40198
UPDATE `creature_template_locale` SET `Name` = '雪孩子' WHERE `locale` = 'zhCN' AND `entry` = 40198;
-- OLD subname : 蝙蝠管理员 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40204
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40204;
-- OLD subname : 荣誉军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40205
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40205;
-- OLD subname : 征服军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40206
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40206;
-- OLD subname : 精锐征服军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40207
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40207;
-- OLD subname : 荣誉军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40208
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40208;
-- OLD subname : 征服军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40210
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40210;
-- OLD subname : 精锐征服军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40211
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40211;
-- OLD subname : 传承竞技场武器
-- Source : https://www.wowhead.com/wotlk/cn/npc=40212
UPDATE `creature_template_locale` SET `Title` = '优质竞技场装备' WHERE `locale` = 'zhCN' AND `entry` = 40212;
-- OLD subname : 荣誉军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40213
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40213;
-- OLD subname : 征服军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40214
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40214;
-- OLD subname : 精锐征服军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40215
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40215;
-- OLD subname : 传承竞技场武器 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40216
UPDATE `creature_template_locale` SET `Title` = '残忍角斗士' WHERE `locale` = 'zhCN' AND `entry` = 40216;
-- OLD name : 暗矛勇士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40241
UPDATE `creature_template_locale` SET `Name` = '暗矛战士' WHERE `locale` = 'zhCN' AND `entry` = 40241;
-- OLD name : [DND] Zen'tabra Cat Form (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=40265
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 40265;
-- OLD name : 蓝色发条战士
-- Source : https://www.wowhead.com/wotlk/cn/npc=40295
UPDATE `creature_template_locale` SET `Name` = '发条战士' WHERE `locale` = 'zhCN' AND `entry` = 40295;
-- OLD name : [DND] Zen'tabra Travel Form (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=40354
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 40354;
-- OLD name : 暗矛勇士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40392
UPDATE `creature_template_locale` SET `Name` = '暗矛战士' WHERE `locale` = 'zhCN' AND `entry` = 40392;
-- OLD subname : 邱碧特的宠物 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40404
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40404;
-- OLD subname : 战场军官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40413
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40413;
-- OLD name : [DND] Quest Credit Bunny - ET Battle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=40428
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 40428;
-- OLD name : 斯提姆维多·塞斯特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40438
UPDATE `creature_template_locale` SET `Name` = '热砂港讼棍' WHERE `locale` = 'zhCN' AND `entry` = 40438;
-- OLD subname : 纳迦异教徒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40446
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40446;
-- OLD subname : 沃金的鼓手 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40492
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40492;
-- OLD subname : 诺森德护甲军需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40607
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40607;
-- OLD name : [DND] Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=40617
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 40617;
-- OLD name : 红玉龙兽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40627
UPDATE `creature_template_locale` SET `Name` = '红玉幼龙' WHERE `locale` = 'zhCN' AND `entry` = 40627;
-- OLD subname : Do Not Spawn (RETAIL DATAS)
-- Source : https://www.wowhead.com/cn/npc=40724
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhCN' AND `entry` = 40724;
-- OLD name : [DND] Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/cn/npc=41839
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN' AND `entry` = 41839;

-- List of entries using retail datas :
-- 81,444,3151,5876,6783,9579,9580,9581,9582,17733,18674,23653,23655,23657,23669,23670,23671,23715,23781,23782,23784,23816,24015,24041,24119,24181,24238,24275,24276,24341,24342,24343,24347,24348,24349,24350,24377,24378,24643,24717,24718,24719,24720,24751,24897,25263,25288,25290,25312,25519,25717,25774,26078,26080,26081,26269,26274,26376,26405,26406,26442,26486,26514,26541,26542,26551,26552,26671,26846,26934,26947,26951,26952,26953,26954,26955,26956,26957,26958,26959,26960,26961,26962,26963,26964,27026,27114,27115,27137,27138,27231,27344,27527,27579,27586,27590,27591,27592,27595,27596,27599,27601,27609,27632,27730,27760,27833,27862,27916,27968,28088,28115,28189,28245,28310,28311,28370,28400,28499,28501,28554,28650,28678,28679,28680,28712,28720,28944,28949,28950,28987,29045,29046,29072,29121,29122,29174,29218,29233,29250,29251,29252,29253,29260,29262,29265,29283,29318,29339,29348,29381,29383,29385,29386,29387,29441,29442,29534,29539,29540,29541,29681,29734,29741,29749,29762,29841,29850,29884,29895,29933,29967,29968,29969,29970,29971,30149,30155,30157,30158,30171,30182,30254,30296,30308,30309,30311,30381,30408,30411,30426,30427,30428,30429,30578,30579,30580,30581,30583,30584,30590,30613,30678,30835,30884,30886,30888,30924,30956,31016,31026,31060,31076,31116,31119,31143,31160,31161,31163,31221,31224,31234,31248,31277,31300,31302,31305,31306,31307,31331,31545,31549,31551,31552,31648,31696,31744,31804,31806,31836,31839,31872,32149,32153,32293,32300,32329,32346,32364,32365,32384,32401,32402,32446,32491,32518,32556,32557,32558,32559,32560,32561,32565,32649,32657,32658,32659,32660,32774,32794,32848,32849,32870,33290,33351,33439,33537,33602,33621,33665,33673,33685,33707,33708,33867,33915,33916,33917,33918,33919,33920,33921,33922,33923,33924,33925,33926,33927,33928,33929,33930,33931,33932,33933,33934,33935,33936,33937,33938,33939,33940,33941,33946,33992,34036,34037,34038,34039,34040,34042,34058,34059,34060,34061,34062,34063,34073,34074,34075,34076,34077,34078,34080,34081,34082,34083,34084,34087,34088,34089,34090,34091,34092,34093,34094,34095,34168,34172,34173,34444,34449,34451,34456,34460,34461,34465,34467,34470,34471,34473,34475,34533,34552,34557,34644,34712,34714,34786,34787,34800,34895,34924,34971,34972,34973,34980,34993,35017,35019,35020,35021,35022,35023,35024,35025,35026,35116,35127,35341,35343,35346,35460,35462,35492,35569,35572,35573,35574,35587,35600,35607,35611,35612,35895,35909,35910,36164,36213,36217,36273,36284,36351,36352,36476,36530,36648,36778,36788,36792,36837,36904,36949,36950,36957,36990,37183,37223,37225,37527,37693,37712,37713,37755,37764,37765,37829,37846,37935,37936,37996,38040,38043,38044,38052,38189,38200,38207,38334,38335,38336,38505,38595,38608,38610,38858,38883,39090,39103,39271,39273,39283,39633,39678,39712,39807,39940,40204,40205,40206,40207,40208,40210,40211,40213,40214,40215,40216,40241,40392,40404,40413,40438,40446,40492,40607,40627,40724
-- END
