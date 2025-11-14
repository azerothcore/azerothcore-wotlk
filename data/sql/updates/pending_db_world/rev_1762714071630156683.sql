-- Update zhTW ; from WowHead WOTLK+ / Retail
-- OLD name : 狗頭人惡黨
-- Source : https://www.wowhead.com/wotlk/tw/npc=6
UPDATE `creature_template_locale` SET `Name` = '狗頭人歹徒' WHERE `locale` = 'zhTW' AND `entry` = 6;
-- OLD name : 本尼任務給予者, subname : 測試
-- Source : https://www.wowhead.com/wotlk/tw/npc=19
UPDATE `creature_template_locale` SET `Name` = '班尼發給任務者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 19;
-- OLD name : 坎瑞薩德, subname : 死亡大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=29
UPDATE `creature_template_locale` SET `Name` = 'Dragon Spawn',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 29;
-- OLD name : 低劣暴徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=38
UPDATE `creature_template_locale` SET `Name` = '迪菲亞暴徒' WHERE `locale` = 'zhTW' AND `entry` = 38;
-- OLD name : 陷捕者魯克拉爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=60
UPDATE `creature_template_locale` SET `Name` = '礦工魯克拉爾' WHERE `locale` = 'zhTW' AND `entry` = 60;
-- OLD name : 染病的森林狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=69
UPDATE `creature_template_locale` SET `Name` = '森林狼' WHERE `locale` = 'zhTW' AND `entry` = 69;
-- OLD name : [UNUSED] Lower Class Citizen (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=70
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 70;
-- OLD subname : 任務給予者
-- Source : https://www.wowhead.com/wotlk/tw/npc=73
UPDATE `creature_template_locale` SET `Title` = 'tgiver' WHERE `locale` = 'zhTW' AND `entry` = 73;
-- OLD name : [UNUSED] Vashaum Nightwither (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=75
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 75;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=78
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 78;
-- OLD name : [UNUSED] Luglar the Clogger (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=81
UPDATE `creature_template_locale` SET `Name` = 'Holiday - Hallow''s End - Garrison - Spectral Alemental' WHERE `locale` = 'zhTW' AND `entry` = 81;
-- OLD name : 加瑞克·護足
-- Source : https://www.wowhead.com/wotlk/tw/npc=103
UPDATE `creature_template_locale` SET `Name` = '加瑞克·帕德弗特' WHERE `locale` = 'zhTW' AND `entry` = 103;
-- OLD name : 強盜
-- Source : https://www.wowhead.com/wotlk/tw/npc=116
UPDATE `creature_template_locale` SET `Name` = '迪菲亞強盜' WHERE `locale` = 'zhTW' AND `entry` = 116;
-- OLD name : 森林潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=120
UPDATE `creature_template_locale` SET `Name` = '森林捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 120;
-- OLD subname : Testing
-- Source : https://www.wowhead.com/wotlk/tw/npc=128
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 128;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (128, 'zhTW',NULL,'ing');
-- OLD name : [UNUSED] Small Black Dragon Whelp (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=149
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 149;
-- OLD subname : 魚人寶寶兌換商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=153
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 153;
-- OLD name : [UNUSED] Ander the Monk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=161
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 161;
-- OLD name : [UNUSED] Destitute Farmer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=163
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 163;
-- OLD name : [UNUSED] Small Child (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=165
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 165;
-- OLD name : 鬆散的骷髏
-- Source : https://www.wowhead.com/wotlk/tw/npc=201
UPDATE `creature_template_locale` SET `Name` = 'Brittlebones Skeleton UNUSED' WHERE `locale` = 'zhTW' AND `entry` = 201;
-- OLD name : 腐爛的恐怖殭屍
-- Source : https://www.wowhead.com/wotlk/tw/npc=202
UPDATE `creature_template_locale` SET `Name` = '恐怖骷髏' WHERE `locale` = 'zhTW' AND `entry` = 202;
-- OLD name : [UNUSED] Cackle Flamebone (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=204
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 204;
-- OLD name : [UNUSED] Riverpaw Hideflayer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=207
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 207;
-- OLD name : [UNUSED] Riverpaw Pack Warder (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=208
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 208;
-- OLD name : [UNUSED] Riverpaw Bone Chanter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=209
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 209;
-- OLD name : 飢餓的恐狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=213
UPDATE `creature_template_locale` SET `Name` = '饑餓的恐狼' WHERE `locale` = 'zhTW' AND `entry` = 213;
-- OLD subname : 商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=221
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 221;
-- OLD subname : 武器商
-- Source : https://www.wowhead.com/wotlk/tw/npc=224
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 224;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=225
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 225;
-- OLD name : Thornton Fellwood
-- Source : https://www.wowhead.com/wotlk/tw/npc=230
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 230;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (230, 'zhTW','索恩頓·菲爾伍德',NULL);
-- OLD name : 格里安·斯托曼保安官
-- Source : https://www.wowhead.com/wotlk/tw/npc=234
UPDATE `creature_template_locale` SET `Name` = '格里安·斯托曼' WHERE `locale` = 'zhTW' AND `entry` = 234;
-- OLD name : [UNUSED] Greeby Mudwhisker TEST (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=243
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 243;
-- OLD name : 傑勒德·提勒
-- Source : https://www.wowhead.com/wotlk/tw/npc=255
UPDATE `creature_template_locale` SET `Name` = '葛拉德·提勒' WHERE `locale` = 'zhTW' AND `entry` = 255;
-- OLD name : [UNUSED] Elwynn Tower Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=260
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 260;
-- OLD name : 守衛湯瑪斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=261
UPDATE `creature_template_locale` SET `Name` = '衛兵湯瑪斯' WHERE `locale` = 'zhTW' AND `entry` = 261;
-- OLD name : 伊娃夫人
-- Source : https://www.wowhead.com/wotlk/tw/npc=265
UPDATE `creature_template_locale` SET `Name` = '艾娃夫人' WHERE `locale` = 'zhTW' AND `entry` = 265;
-- OLD subname : 佔地觸發器
-- Source : https://www.wowhead.com/wotlk/tw/npc=280
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 280;
-- OLD name : 棕馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=284
UPDATE `creature_template_locale` SET `Name` = '騎乘用馬（棕色）' WHERE `locale` = 'zhTW' AND `entry` = 284;
-- OLD subname : 佔地觸發器
-- Source : https://www.wowhead.com/wotlk/tw/npc=290
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 290;
-- OLD subname : 佔地者!
-- Source : https://www.wowhead.com/wotlk/tw/npc=291
UPDATE `creature_template_locale` SET `Title` = 'eholder!' WHERE `locale` = 'zhTW' AND `entry` = 291;
-- OLD name : [UNUSED] Goodmother Jans (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=296
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 296;
-- OLD subname : <Needs Texture>
-- Source : https://www.wowhead.com/wotlk/tw/npc=298
UPDATE `creature_template_locale` SET `Title` = 'ds Texture>' WHERE `locale` = 'zhTW' AND `entry` = 298;
-- OLD name : [UNUSED] Brog'Mud (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=301
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 301;
-- OLD subname : 自己想像
-- Source : https://www.wowhead.com/wotlk/tw/npc=303
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 303;
-- OLD name : 惡魔戰馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=304
UPDATE `creature_template_locale` SET `Name` = '騎乘用馬（夢魘）' WHERE `locale` = 'zhTW' AND `entry` = 304;
-- OLD name : 白馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=305
UPDATE `creature_template_locale` SET `Name` = '騎乘用馬（白色）' WHERE `locale` = 'zhTW' AND `entry` = 305;
-- OLD name : 褐色馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=306
UPDATE `creature_template_locale` SET `Name` = '騎乘用馬（褐色）' WHERE `locale` = 'zhTW' AND `entry` = 306;
-- OLD name : 雜色馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=307
UPDATE `creature_template_locale` SET `Name` = '騎乘用馬（雜色）' WHERE `locale` = 'zhTW' AND `entry` = 307;
-- OLD name : 黑馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=308
UPDATE `creature_template_locale` SET `Name` = '騎乘用馬（黑色）' WHERE `locale` = 'zhTW' AND `entry` = 308;
-- OLD name : 「翻覆掩埋」的車輛
-- Source : https://www.wowhead.com/wotlk/tw/npc=309
UPDATE `creature_template_locale` SET `Name` = '羅爾夫的屍體' WHERE `locale` = 'zhTW' AND `entry` = 309;
-- OLD subname : 阿祖拉之塔的法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=313
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 313;
-- OLD subname : 藏屍者的新娘
-- Source : https://www.wowhead.com/wotlk/tw/npc=314
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 314;
-- OLD name : [UNUSED] Brother Akil (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=318
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 318;
-- OLD name : [UNUSED] Brother Benthas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=319
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 319;
-- OLD name : [UNUSED] Brother Cryus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=320
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 320;
-- OLD name : [UNUSED] Brother Deros (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=321
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 321;
-- OLD name : [UNUSED] Brother Enoch (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=322
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 322;
-- OLD name : [UNUSED] Brother Farthing (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=323
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 323;
-- OLD name : [UNUSED] Brother Greishan (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=324
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 324;
-- OLD name : [UNUSED] Brother Ictharin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=326
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 326;
-- OLD name : 馬迪亞斯·肖爾大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=332
UPDATE `creature_template_locale` SET `Name` = '馬迪亞斯·肖爾' WHERE `locale` = 'zhTW' AND `entry` = 332;
-- OLD name : [UNUSED] Edwardo the Jester (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=333
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 333;
-- OLD subname : 黑石氏族督軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=334
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 334;
-- OLD name : [UNUSED] Rin Tal'Vara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=336
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 336;
-- OLD name : [UNUSED] Helgor the Pugilist (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=339
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 339;
-- OLD name : 農民
-- Source : https://www.wowhead.com/wotlk/tw/npc=351
UPDATE `creature_template_locale` SET `Name` = '農夫' WHERE `locale` = 'zhTW' AND `entry` = 351;
-- OLD subname : 魚人寶寶兌換商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=353
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 353;
-- OLD name : 黑狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=356
UPDATE `creature_template_locale` SET `Name` = '騎乘用狼（黑色）' WHERE `locale` = 'zhTW' AND `entry` = 356;
-- OLD name : 森林狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=358
UPDATE `creature_template_locale` SET `Name` = '騎乘用狼（棕色）' WHERE `locale` = 'zhTW' AND `entry` = 358;
-- OLD name : 冬狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=359
UPDATE `creature_template_locale` SET `Name` = '騎乘用狼（白色）' WHERE `locale` = 'zhTW' AND `entry` = 359;
-- OLD subname : 薩滿訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=373
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 373;
-- OLD subname : Waitress
-- Source : https://www.wowhead.com/wotlk/tw/npc=379
UPDATE `creature_template_locale` SET `Title` = '女服務生' WHERE `locale` = 'zhTW' AND `entry` = 379;
-- OLD name : [UNUSED] Waldin Thorbatt (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=380
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 380;
-- OLD name : 治安官瑪瑞斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=382
UPDATE `creature_template_locale` SET `Name` = '治安官馬瑞斯' WHERE `locale` = 'zhTW' AND `entry` = 382;
-- OLD name : 薩繆爾領主, subname : 高階聖騎士
-- Source : https://www.wowhead.com/wotlk/tw/npc=387
UPDATE `creature_template_locale` SET `Name` = '薩繆爾公爵',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 387;
-- OLD subname : 高階聖騎士
-- Source : https://www.wowhead.com/wotlk/tw/npc=388
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 388;
-- OLD name : 蘭迪加領主, subname : 高階聖騎士
-- Source : https://www.wowhead.com/wotlk/tw/npc=389
UPDATE `creature_template_locale` SET `Name` = '蘭迪加公爵',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 389;
-- OLD name : 隨行小豬
-- Source : https://www.wowhead.com/wotlk/tw/npc=390
UPDATE `creature_template_locale` SET `Name` = '公主的隨從' WHERE `locale` = 'zhTW' AND `entry` = 390;
-- OLD name : 溫馴的狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=393
UPDATE `creature_template_locale` SET `Name` = '被馴服的狼' WHERE `locale` = 'zhTW' AND `entry` = 393;
-- OLD name : 馬可仕
-- Source : https://www.wowhead.com/wotlk/tw/npc=395
UPDATE `creature_template_locale` SET `Name` = '瑪庫斯' WHERE `locale` = 'zhTW' AND `entry` = 395;
-- OLD name : 大魔導師度恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=397
UPDATE `creature_template_locale` SET `Name` = '莫甘斯' WHERE `locale` = 'zhTW' AND `entry` = 397;
-- OLD subname : 藏屍者的禮物
-- Source : https://www.wowhead.com/wotlk/tw/npc=412
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 412;
-- OLD name : 次級虛無行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=418
UPDATE `creature_template_locale` SET `Name` = '次級虛空行者' WHERE `locale` = 'zhTW' AND `entry` = 418;
-- OLD name : 赤脊山盜獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=424
UPDATE `creature_template_locale` SET `Name` = '赤脊山偷獵者' WHERE `locale` = 'zhTW' AND `entry` = 424;
-- OLD name : 影皮暗織者
-- Source : https://www.wowhead.com/wotlk/tw/npc=429
UPDATE `creature_template_locale` SET `Name` = '暗皮巫師' WHERE `locale` = 'zhTW' AND `entry` = 429;
-- OLD name : 赤脊山秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=430
UPDATE `creature_template_locale` SET `Name` = '赤脊山秘法師' WHERE `locale` = 'zhTW' AND `entry` = 430;
-- OLD name : 影皮殺手
-- Source : https://www.wowhead.com/wotlk/tw/npc=431
UPDATE `creature_template_locale` SET `Name` = '暗皮殺手' WHERE `locale` = 'zhTW' AND `entry` = 431;
-- OLD name : 影皮蠻卒
-- Source : https://www.wowhead.com/wotlk/tw/npc=432
UPDATE `creature_template_locale` SET `Name` = '暗皮蠻兵' WHERE `locale` = 'zhTW' AND `entry` = 432;
-- OLD name : 影皮豺狼人
-- Source : https://www.wowhead.com/wotlk/tw/npc=433
UPDATE `creature_template_locale` SET `Name` = '暗皮豺狼人' WHERE `locale` = 'zhTW' AND `entry` = 433;
-- OLD name : 瘋狂的影皮豺狼人
-- Source : https://www.wowhead.com/wotlk/tw/npc=434
UPDATE `creature_template_locale` SET `Name` = '瘋狂的暗皮豺狼人' WHERE `locale` = 'zhTW' AND `entry` = 434;
-- OLD name : 黑石暗影施法者
-- Source : https://www.wowhead.com/wotlk/tw/npc=436
UPDATE `creature_template_locale` SET `Name` = '黑石暗影法師' WHERE `locale` = 'zhTW' AND `entry` = 436;
-- OLD name : 恰布斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=444
UPDATE `creature_template_locale` SET `Name` = 'Lord Piglet' WHERE `locale` = 'zhTW' AND `entry` = 444;
-- OLD name : 原生赤脊山豺狼人
-- Source : https://www.wowhead.com/wotlk/tw/npc=445
UPDATE `creature_template_locale` SET `Name` = '赤脊山突擊隊員' WHERE `locale` = 'zhTW' AND `entry` = 445;
-- OLD name : 河爪秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=453
UPDATE `creature_template_locale` SET `Name` = '河爪秘法師' WHERE `locale` = 'zhTW' AND `entry` = 453;
-- OLD name : 魚人小神諭者
-- Source : https://www.wowhead.com/wotlk/tw/npc=456
UPDATE `creature_template_locale` SET `Name` = '小魚人智者' WHERE `locale` = 'zhTW' AND `entry` = 456;
-- OLD subname : 術士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=460
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 460;
-- OLD subname : 術士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=461
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 461;
-- OLD name : 警衛隊長派克
-- Source : https://www.wowhead.com/wotlk/tw/npc=464
UPDATE `creature_template_locale` SET `Name` = '衛兵派克' WHERE `locale` = 'zhTW' AND `entry` = 464;
-- OLD name : [UNUSED] Scribe Colburg (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=470
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 470;
-- OLD name : 流浪巫師
-- Source : https://www.wowhead.com/wotlk/tw/npc=474
UPDATE `creature_template_locale` SET `Name` = '迪菲亞流浪巫師' WHERE `locale` = 'zhTW' AND `entry` = 474;
-- OLD name : 生鏽的麥田魔像
-- Source : https://www.wowhead.com/wotlk/tw/npc=480
UPDATE `creature_template_locale` SET `Name` = '生銹的麥田魔像' WHERE `locale` = 'zhTW' AND `entry` = 480;
-- OLD name : [UNUSED] Watcher Kleeman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=496
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 496;
-- OLD name : [UNUSED] Watcher Benjamin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=497
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 497;
-- OLD name : [UNUSED] Watcher Larsen (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=498
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 498;
-- OLD name : 迪菲亞陷捕者
-- Source : https://www.wowhead.com/wotlk/tw/npc=504
UPDATE `creature_template_locale` SET `Name` = '迪菲亞捕獸者' WHERE `locale` = 'zhTW' AND `entry` = 504;
-- OLD name : [UNUSED] Long Fang (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=509
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 509;
-- OLD name : 鐵匠阿古斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=514
UPDATE `creature_template_locale` SET `Name` = '鐵匠阿格斯' WHERE `locale` = 'zhTW' AND `entry` = 514;
-- OLD name : 魚人劫掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=515
UPDATE `creature_template_locale` SET `Name` = '魚人襲擊者' WHERE `locale` = 'zhTW' AND `entry` = 515;
-- OLD name : [UNUSED] Riverpaw Hunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=516
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 516;
-- OLD name : [UNUSED]薩瓦爾 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=535
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 535;
-- OLD name : [UNUSED]拉迪爾 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=536
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 536;
-- OLD name : [UNUSED]布克查 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=538
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 538;
-- OLD name : 深林的卡利菲克斯, subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=542
UPDATE `creature_template_locale` SET `Name` = '卡利菲克斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 542;
-- OLD name : 納雷塞特·野性使者, subname : 獸欄管理員
-- Source : https://www.wowhead.com/wotlk/tw/npc=543
UPDATE `creature_template_locale` SET `Name` = '納雷塞特',`Title` = '寵物訓練師' WHERE `locale` = 'zhTW' AND `entry` = 543;
-- OLD name : 影皮戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=568
UPDATE `creature_template_locale` SET `Name` = '暗皮戰士' WHERE `locale` = 'zhTW' AND `entry` = 568;
-- OLD name : 敵人收割者4000
-- Source : https://www.wowhead.com/wotlk/tw/npc=573
UPDATE `creature_template_locale` SET `Name` = '死神4000型' WHERE `locale` = 'zhTW' AND `entry` = 573;
-- OLD name : 影皮刺客
-- Source : https://www.wowhead.com/wotlk/tw/npc=579
UPDATE `creature_template_locale` SET `Name` = '暗皮刺客' WHERE `locale` = 'zhTW' AND `entry` = 579;
-- OLD name : 伏擊者
-- Source : https://www.wowhead.com/wotlk/tw/npc=583
UPDATE `creature_template_locale` SET `Name` = '迪菲亞伏擊者' WHERE `locale` = 'zhTW' AND `entry` = 583;
-- OLD name : [UNUSED] Watcher Kern (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=586
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 586;
-- OLD name : [UNUSED] Defias Arsonist (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=592
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 592;
-- OLD name : 守財奴卡波爾 [UNUSED]
-- Source : https://www.wowhead.com/wotlk/tw/npc=601
UPDATE `creature_template_locale` SET `Name` = '守財奴卡波爾' WHERE `locale` = 'zhTW' AND `entry` = 601;
-- OLD name : 瘟疫散佈者
-- Source : https://www.wowhead.com/wotlk/tw/npc=604
UPDATE `creature_template_locale` SET `Name` = '瘟疫食屍鬼' WHERE `locale` = 'zhTW' AND `entry` = 604;
-- OLD name : [UNUSED] Mr. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=605
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 605;
-- OLD name : [UNUSED] Mrs. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=606
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 606;
-- OLD name : [UNUSED] Johnny Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=607
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 607;
-- OLD name : [UNUSED] Grandpa Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=609
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 609;
-- OLD name : [UNUSED] Rabid Gina Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=610
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 610;
-- OLD name : [UNUSED] Rabid Mr. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=611
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 611;
-- OLD name : [UNUSED] Rabid Mrs. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=612
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 612;
-- OLD name : [UNUSED] Rabid Johnny Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=613
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 613;
-- OLD name : [UNUSED] Rabid Grandpa Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=614
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 614;
-- OLD name : 迪菲亞監督者
-- Source : https://www.wowhead.com/wotlk/tw/npc=634
UPDATE `creature_template_locale` SET `Name` = '迪菲亞監工' WHERE `locale` = 'zhTW' AND `entry` = 634;
-- OLD name : 迪菲亞黑衣衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=636
UPDATE `creature_template_locale` SET `Name` = '迪菲亞黑衣衛兵' WHERE `locale` = 'zhTW' AND `entry` = 636;
-- OLD subname : 迪菲亞兄弟會首腦
-- Source : https://www.wowhead.com/wotlk/tw/npc=639
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 639;
-- OLD subname : 伐木工頭
-- Source : https://www.wowhead.com/wotlk/tw/npc=642
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 642;
-- OLD subname : 伐木工頭
-- Source : https://www.wowhead.com/wotlk/tw/npc=643
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 643;
-- OLD subname : 工頭
-- Source : https://www.wowhead.com/wotlk/tw/npc=644
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 644;
-- OLD name : 廚師, subname : 船上的廚師
-- Source : https://www.wowhead.com/wotlk/tw/npc=645
UPDATE `creature_template_locale` SET `Name` = '曲奇',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 645;
-- OLD subname : 船上的大副
-- Source : https://www.wowhead.com/wotlk/tw/npc=646
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 646;
-- OLD name : 迪菲亞海賊
-- Source : https://www.wowhead.com/wotlk/tw/npc=657
UPDATE `creature_template_locale` SET `Name` = '迪菲亞海盜' WHERE `locale` = 'zhTW' AND `entry` = 657;
-- OLD subname : 黑暗死亡小雞
-- Source : https://www.wowhead.com/wotlk/tw/npc=659
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 659;
-- OLD name : 班傑明·卡爾文
-- Source : https://www.wowhead.com/wotlk/tw/npc=664
UPDATE `creature_template_locale` SET `Name` = '本傑明·卡爾文' WHERE `locale` = 'zhTW' AND `entry` = 664;
-- OLD name : 風險投資公司勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=676
UPDATE `creature_template_locale` SET `Name` = '風險投資公司勘探員' WHERE `locale` = 'zhTW' AND `entry` = 676;
-- OLD name : Words Written
-- Source : https://www.wowhead.com/wotlk/tw/npc=693
UPDATE `creature_template_locale` SET `Name` = '第二技能訓練師' WHERE `locale` = 'zhTW' AND `entry` = 693;
-- OLD name : 血頂秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=701
UPDATE `creature_template_locale` SET `Name` = '血頂秘法師' WHERE `locale` = 'zhTW' AND `entry` = 701;
-- OLD name : 范高雷將軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=703
UPDATE `creature_template_locale` SET `Name` = '范高雷中尉' WHERE `locale` = 'zhTW' AND `entry` = 703;
-- OLD name : 石齶穴居怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=707
UPDATE `creature_template_locale` SET `Name` = '石齶穴居人' WHERE `locale` = 'zhTW' AND `entry` = 707;
-- OLD name : 壯實的石齶穴居怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=724
UPDATE `creature_template_locale` SET `Name` = '壯實的石齶怪' WHERE `locale` = 'zhTW' AND `entry` = 724;
-- OLD name : [UNUSED]骷髏執行者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=725
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 725;
-- OLD name : 龍人長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=746
UPDATE `creature_template_locale` SET `Name` = '刃鱗龍人長者' WHERE `locale` = 'zhTW' AND `entry` = 746;
-- OLD name : 沼澤魚人神諭者
-- Source : https://www.wowhead.com/wotlk/tw/npc=752
UPDATE `creature_template_locale` SET `Name` = '沼澤魚人智者' WHERE `locale` = 'zhTW' AND `entry` = 752;
-- OLD name : [UNUSED] Rebel Soldier (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=753
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 753;
-- OLD name : 反抗軍警備兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=754
UPDATE `creature_template_locale` SET `Name` = '反抗軍哨兵' WHERE `locale` = 'zhTW' AND `entry` = 754;
-- OLD name : 劈顱秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=780
UPDATE `creature_template_locale` SET `Name` = '劈顱秘法師' WHERE `locale` = 'zhTW' AND `entry` = 780;
-- OLD name : 骷髏護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=785
UPDATE `creature_template_locale` SET `Name` = '骷髏守衛' WHERE `locale` = 'zhTW' AND `entry` = 785;
-- OLD subname : 弓箭商
-- Source : https://www.wowhead.com/wotlk/tw/npc=789
UPDATE `creature_template_locale` SET `Title` = '造箭師' WHERE `locale` = 'zhTW' AND `entry` = 789;
-- OLD name : 凱倫·泰勒
-- Source : https://www.wowhead.com/wotlk/tw/npc=790
UPDATE `creature_template_locale` SET `Name` = '卡倫·泰勒' WHERE `locale` = 'zhTW' AND `entry` = 790;
-- OLD subname : 草藥學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=812
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 812;
-- OLD name : 書呆子赫洛德
-- Source : https://www.wowhead.com/wotlk/tw/npc=815
UPDATE `creature_template_locale` SET `Name` = '書呆子赫羅德' WHERE `locale` = 'zhTW' AND `entry` = 815;
-- OLD name : 丹努文上尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=821
UPDATE `creature_template_locale` SET `Name` = '丹努文隊長' WHERE `locale` = 'zhTW' AND `entry` = 821;
-- OLD name : 維里中士
-- Source : https://www.wowhead.com/wotlk/tw/npc=823
UPDATE `creature_template_locale` SET `Name` = '維里副隊長' WHERE `locale` = 'zhTW' AND `entry` = 823;
-- OLD subname : 雜貨供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=829
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 829;
-- OLD name : 無縛的颶風
-- Source : https://www.wowhead.com/wotlk/tw/npc=832
UPDATE `creature_template_locale` SET `Name` = '塵魔' WHERE `locale` = 'zhTW' AND `entry` = 832;
-- OLD subname : 布甲和皮甲商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=836
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 836;
-- OLD subname : 牧師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=837
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 837;
-- OLD name : Harl Cutter
-- Source : https://www.wowhead.com/wotlk/tw/npc=841
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 841;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (841, 'zhTW','哈爾·卡特',NULL);
-- OLD name : 吉娜·馬克格里高
-- Source : https://www.wowhead.com/wotlk/tw/npc=843
UPDATE `creature_template_locale` SET `Name` = '吉娜·馬克葛瑞格' WHERE `locale` = 'zhTW' AND `entry` = 843;
-- OLD name : 納森
-- Source : https://www.wowhead.com/wotlk/tw/npc=847
UPDATE `creature_template_locale` SET `Name` = '南森' WHERE `locale` = 'zhTW' AND `entry` = 847;
-- OLD name : 野性之魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=852
UPDATE `creature_template_locale` SET `Name` = '野性幽魂' WHERE `locale` = 'zhTW' AND `entry` = 852;
-- OLD name : 幼年叢林潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=854
UPDATE `creature_template_locale` SET `Name` = '幼年叢林捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 854;
-- OLD name : 悲傷紡織者
-- Source : https://www.wowhead.com/wotlk/tw/npc=858
UPDATE `creature_template_locale` SET `Name` = '沼澤紡絲蛛' WHERE `locale` = 'zhTW' AND `entry` = 858;
-- OLD name : 守衛伯爾頓
-- Source : https://www.wowhead.com/wotlk/tw/npc=859
UPDATE `creature_template_locale` SET `Name` = '衛兵伯爾頓' WHERE `locale` = 'zhTW' AND `entry` = 859;
-- OLD name : 骸骨施法者
-- Source : https://www.wowhead.com/wotlk/tw/npc=882
UPDATE `creature_template_locale` SET `Name` = '白骨法師' WHERE `locale` = 'zhTW' AND `entry` = 882;
-- OLD name : 守夜人喬丹
-- Source : https://www.wowhead.com/wotlk/tw/npc=887
UPDATE `creature_template_locale` SET `Name` = '守夜人約丹' WHERE `locale` = 'zhTW' AND `entry` = 887;
-- OLD name : 幼鹿
-- Source : https://www.wowhead.com/wotlk/tw/npc=890
UPDATE `creature_template_locale` SET `Name` = '小鹿' WHERE `locale` = 'zhTW' AND `entry` = 890;
-- OLD subname : 獵人訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=895
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 895;
-- OLD subname : 皮甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=896
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 896;
-- OLD name : 守衛豪維
-- Source : https://www.wowhead.com/wotlk/tw/npc=903
UPDATE `creature_template_locale` SET `Name` = '衛兵豪維' WHERE `locale` = 'zhTW' AND `entry` = 903;
-- OLD name : [UNUSED]雷格納·庫恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=904
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 904;
-- OLD name : 萊恩·拜舍爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=911
UPDATE `creature_template_locale` SET `Name` = '萊尼·拜舍爾' WHERE `locale` = 'zhTW' AND `entry` = 911;
-- OLD subname : 戰士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=912
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 912;
-- OLD subname : 盜賊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=916
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 916;
-- OLD name : [UNUSED] Lesser Arachnid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=924
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 924;
-- OLD subname : 聖騎士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=926
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 926;
-- OLD name : 驚懼領主瑪爾加尼斯, subname : 惡魔之王
-- Source : https://www.wowhead.com/wotlk/tw/npc=929
UPDATE `creature_template_locale` SET `Name` = '恐懼魔王瑪爾加尼斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 929;
-- OLD name : 守衛阿什洛克
-- Source : https://www.wowhead.com/wotlk/tw/npc=932
UPDATE `creature_template_locale` SET `Name` = '衛兵阿什洛克' WHERE `locale` = 'zhTW' AND `entry` = 932;
-- OLD name : 守衛海特
-- Source : https://www.wowhead.com/wotlk/tw/npc=933
UPDATE `creature_template_locale` SET `Name` = '衛兵海特' WHERE `locale` = 'zhTW' AND `entry` = 933;
-- OLD name : 守衛克拉克
-- Source : https://www.wowhead.com/wotlk/tw/npc=934
UPDATE `creature_template_locale` SET `Name` = '衛兵克拉克' WHERE `locale` = 'zhTW' AND `entry` = 934;
-- OLD name : 守衛皮爾斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=935
UPDATE `creature_template_locale` SET `Name` = '衛兵皮爾斯' WHERE `locale` = 'zhTW' AND `entry` = 935;
-- OLD name : 守衛亞當斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=936
UPDATE `creature_template_locale` SET `Name` = '衛兵亞當斯' WHERE `locale` = 'zhTW' AND `entry` = 936;
-- OLD subname : 法師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=944
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 944;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=945
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 945;
-- OLD name : 霜鬃新兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=946
UPDATE `creature_template_locale` SET `Name` = '霜鬃食人妖新兵' WHERE `locale` = 'zhTW' AND `entry` = 946;
-- OLD subname : Librarian
-- Source : https://www.wowhead.com/wotlk/tw/npc=951
UPDATE `creature_template_locale` SET `Title` = '圖書管理員' WHERE `locale` = 'zhTW' AND `entry` = 951;
-- OLD subname : TEST MOB
-- Source : https://www.wowhead.com/wotlk/tw/npc=953
UPDATE `creature_template_locale` SET `Title` = 'MOB' WHERE `locale` = 'zhTW' AND `entry` = 953;
-- OLD subname : 皮甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=954
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 954;
-- OLD subname : 士氣軍官
-- Source : https://www.wowhead.com/wotlk/tw/npc=955
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 955;
-- OLD name : 唐恩·亮星
-- Source : https://www.wowhead.com/wotlk/tw/npc=958
UPDATE `creature_template_locale` SET `Name` = '當恩·布賴特斯塔' WHERE `locale` = 'zhTW' AND `entry` = 958;
-- OLD name : 『第三』艾力克·道茨, subname : 裁縫訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=996
UPDATE `creature_template_locale` SET `Name` = '高級裁縫',`Title` = 'sy Test Tailor' WHERE `locale` = 'zhTW' AND `entry` = 996;
-- OLD name : 殺不死的測試假人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1000
UPDATE `creature_template_locale` SET `Name` = '守夜人布洛伯格' WHERE `locale` = 'zhTW' AND `entry` = 1000;
-- OLD subname : 守夜人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1001
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1001;
-- OLD name : 蘚皮陷捕者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1011
UPDATE `creature_template_locale` SET `Name` = '蘚皮捕獸者' WHERE `locale` = 'zhTW' AND `entry` = 1011;
-- OLD name : 蘚皮秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=1013
UPDATE `creature_template_locale` SET `Name` = '蘚皮秘法師' WHERE `locale` = 'zhTW' AND `entry` = 1013;
-- OLD name : 原生蘚皮豺狼人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1014
UPDATE `creature_template_locale` SET `Name` = '蘚皮突擊隊員' WHERE `locale` = 'zhTW' AND `entry` = 1014;
-- OLD name : 藍鰓神諭者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1029
UPDATE `creature_template_locale` SET `Name` = '藍腮智者' WHERE `locale` = 'zhTW' AND `entry` = 1029;
-- OLD name : 龍喉暗衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1038
UPDATE `creature_template_locale` SET `Name` = '龍喉暗影守衛' WHERE `locale` = 'zhTW' AND `entry` = 1038;
-- OLD name : 沼地蠕行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1040
UPDATE `creature_template_locale` SET `Name` = '沼地爬行者' WHERE `locale` = 'zhTW' AND `entry` = 1040;
-- OLD name : 迷路的幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=1043
UPDATE `creature_template_locale` SET `Name` = '迷路的雛龍' WHERE `locale` = 'zhTW' AND `entry` = 1043;
-- OLD name : 噴火幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=1044
UPDATE `creature_template_locale` SET `Name` = '噴火雛龍' WHERE `locale` = 'zhTW' AND `entry` = 1044;
-- OLD name : 紅色龍裔
-- Source : https://www.wowhead.com/wotlk/tw/npc=1045
UPDATE `creature_template_locale` SET `Name` = '紅色龍人' WHERE `locale` = 'zhTW' AND `entry` = 1045;
-- OLD name : 紅色龍人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1046
UPDATE `creature_template_locale` SET `Name` = '紅色龍族' WHERE `locale` = 'zhTW' AND `entry` = 1046;
-- OLD name : 紅色逆鱗龍人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1047
UPDATE `creature_template_locale` SET `Name` = '紅色刃鱗龍人' WHERE `locale` = 'zhTW' AND `entry` = 1047;
-- OLD name : 逆鱗龍人副官
-- Source : https://www.wowhead.com/wotlk/tw/npc=1048
UPDATE `creature_template_locale` SET `Name` = '刃鱗龍人副官' WHERE `locale` = 'zhTW' AND `entry` = 1048;
-- OLD name : 烈焰龍人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1049
UPDATE `creature_template_locale` SET `Name` = '烈焰龍族' WHERE `locale` = 'zhTW' AND `entry` = 1049;
-- OLD name : 逆鱗皇家守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1050
UPDATE `creature_template_locale` SET `Name` = '刃鱗皇家衛士' WHERE `locale` = 'zhTW' AND `entry` = 1050;
-- OLD name : 黑鐵爆破兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=1054
UPDATE `creature_template_locale` SET `Name` = '黑鐵爆破手' WHERE `locale` = 'zhTW' AND `entry` = 1054;
-- OLD name : 龍喉骸骨護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1057
UPDATE `creature_template_locale` SET `Name` = '龍喉骸骨守衛' WHERE `locale` = 'zhTW' AND `entry` = 1057;
-- OLD name : [UNUSED] 特魯伊克 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=1058
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 1058;
-- OLD subname : 劈顱酋長
-- Source : https://www.wowhead.com/wotlk/tw/npc=1059
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1059;
-- OLD subname : UNUSED
-- Source : https://www.wowhead.com/wotlk/tw/npc=1066
UPDATE `creature_template_locale` SET `Title` = 'ED' WHERE `locale` = 'zhTW' AND `entry` = 1066;
-- OLD name : 赤紅幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=1069
UPDATE `creature_template_locale` SET `Name` = '深紅雛龍' WHERE `locale` = 'zhTW' AND `entry` = 1069;
-- OLD name : 尖齒鱷魚
-- Source : https://www.wowhead.com/wotlk/tw/npc=1082
UPDATE `creature_template_locale` SET `Name` = '鋸齒鱷魚' WHERE `locale` = 'zhTW' AND `entry` = 1082;
-- OLD name : 小尖齒鱷魚
-- Source : https://www.wowhead.com/wotlk/tw/npc=1084
UPDATE `creature_template_locale` SET `Name` = '小鋸齒鱷魚' WHERE `locale` = 'zhTW' AND `entry` = 1084;
-- OLD subname : 守夜人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1100
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1100;
-- OLD subname : 護甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=1104
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1104;
-- OLD name : 吸血潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1111
UPDATE `creature_template_locale` SET `Name` = '吸血捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 1111;
-- OLD name : 飢餓的冬狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=1133
UPDATE `creature_template_locale` SET `Name` = '饑餓的冬狼' WHERE `locale` = 'zhTW' AND `entry` = 1133;
-- OLD name : 飢餓的雪怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=1137
UPDATE `creature_template_locale` SET `Name` = '饑餓的雪怪' WHERE `locale` = 'zhTW' AND `entry` = 1137;
-- OLD name : 雪地搜蹤狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=1138
UPDATE `creature_template_locale` SET `Name` = '雪狼' WHERE `locale` = 'zhTW' AND `entry` = 1138;
-- OLD name : 石裂穴居怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=1161
UPDATE `creature_template_locale` SET `Name` = '碎石穴居人' WHERE `locale` = 'zhTW' AND `entry` = 1161;
-- OLD name : 石裂斥候
-- Source : https://www.wowhead.com/wotlk/tw/npc=1162
UPDATE `creature_template_locale` SET `Name` = '碎石怪斥候' WHERE `locale` = 'zhTW' AND `entry` = 1162;
-- OLD name : 石裂擊顱者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1163
UPDATE `creature_template_locale` SET `Name` = '碎石怪擊顱者' WHERE `locale` = 'zhTW' AND `entry` = 1163;
-- OLD name : 石裂斷骨者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1164
UPDATE `creature_template_locale` SET `Name` = '碎石怪斷骨者' WHERE `locale` = 'zhTW' AND `entry` = 1164;
-- OLD name : 石裂地卜師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1165
UPDATE `creature_template_locale` SET `Name` = '碎石怪地卜師' WHERE `locale` = 'zhTW' AND `entry` = 1165;
-- OLD name : 石裂先知
-- Source : https://www.wowhead.com/wotlk/tw/npc=1166
UPDATE `creature_template_locale` SET `Name` = '碎石怪先知' WHERE `locale` = 'zhTW' AND `entry` = 1166;
-- OLD name : 石裂掘地工
-- Source : https://www.wowhead.com/wotlk/tw/npc=1167
UPDATE `creature_template_locale` SET `Name` = '碎石怪掘地工' WHERE `locale` = 'zhTW' AND `entry` = 1167;
-- OLD name : 坑道鼠惡黨
-- Source : https://www.wowhead.com/wotlk/tw/npc=1172
UPDATE `creature_template_locale` SET `Name` = '坑道鼠歹徒' WHERE `locale` = 'zhTW' AND `entry` = 1172;
-- OLD name : 坑道鼠勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=1177
UPDATE `creature_template_locale` SET `Name` = '坑道鼠勘探員' WHERE `locale` = 'zhTW' AND `entry` = 1177;
-- OLD name : 莫格羅什蠻卒
-- Source : https://www.wowhead.com/wotlk/tw/npc=1180
UPDATE `creature_template_locale` SET `Name` = '莫格羅什蠻兵' WHERE `locale` = 'zhTW' AND `entry` = 1180;
-- OLD name : 莫格羅什秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=1183
UPDATE `creature_template_locale` SET `Name` = '莫格羅什秘法師' WHERE `locale` = 'zhTW' AND `entry` = 1183;
-- OLD name : 黑熊
-- Source : https://www.wowhead.com/wotlk/tw/npc=1186
UPDATE `creature_template_locale` SET `Name` = '老黑熊' WHERE `locale` = 'zhTW' AND `entry` = 1186;
-- OLD name : 石裂薩滿
-- Source : https://www.wowhead.com/wotlk/tw/npc=1197
UPDATE `creature_template_locale` SET `Name` = '碎石怪薩滿' WHERE `locale` = 'zhTW' AND `entry` = 1197;
-- OLD subname : 守夜人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1203
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1203;
-- OLD subname : 守夜人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1204
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1204;
-- OLD subname : 魚人寶寶兌換商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1227
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1227;
-- OLD name : [UNUSED]萊克辛·黑茲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=1230
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 1230;
-- OLD name : [UNUSED]珊希斯·橡木 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=1233
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 1233;
-- OLD name : [UNUSED]瑪爾揚·紫足 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=1235
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 1235;
-- OLD name : 波蘭·鐵欄
-- Source : https://www.wowhead.com/wotlk/tw/npc=1240
UPDATE `creature_template_locale` SET `Name` = '伯蘭·鐵欄' WHERE `locale` = 'zhTW' AND `entry` = 1240;
-- OLD subname : 槍械商
-- Source : https://www.wowhead.com/wotlk/tw/npc=1243
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1243;
-- OLD name : 『綠意守望者』雷希耶爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=1244
UPDATE `creature_template_locale` SET `Name` = '『綠色守衛者』雷希耶爾' WHERE `locale` = 'zhTW' AND `entry` = 1244;
-- OLD subname : 雜貨與貿易供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=1250
UPDATE `creature_template_locale` SET `Title` = '一般與貿易供應商' WHERE `locale` = 'zhTW' AND `entry` = 1250;
-- OLD name : 白山羊X型
-- Source : https://www.wowhead.com/wotlk/tw/npc=1262
UPDATE `creature_template_locale` SET `Name` = '白山羊' WHERE `locale` = 'zhTW' AND `entry` = 1262;
-- OLD name : 老冰鬚
-- Source : https://www.wowhead.com/wotlk/tw/npc=1271
UPDATE `creature_template_locale` SET `Name` = '冰鬚' WHERE `locale` = 'zhTW' AND `entry` = 1271;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1273
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 1273;
-- OLD name : 安柏·凱許 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=1293
UPDATE `creature_template_locale` SET `Name` = '安柏‧凱許' WHERE `locale` = 'zhTW' AND `entry` = 1293;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1296
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 1296;
-- OLD subname : 弓箭商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1298
UPDATE `creature_template_locale` SET `Title` = '弓箭商' WHERE `locale` = 'zhTW' AND `entry` = 1298;
-- OLD name : 李斯貝·施耐德
-- Source : https://www.wowhead.com/wotlk/tw/npc=1299
UPDATE `creature_template_locale` SET `Name` = '利斯貝·斯涅德' WHERE `locale` = 'zhTW' AND `entry` = 1299;
-- OLD name : 勞倫斯·施耐德
-- Source : https://www.wowhead.com/wotlk/tw/npc=1300
UPDATE `creature_template_locale` SET `Name` = '勞倫斯·瑟尼德' WHERE `locale` = 'zhTW' AND `entry` = 1300;
-- OLD name : 茱莉亞·加林納
-- Source : https://www.wowhead.com/wotlk/tw/npc=1301
UPDATE `creature_template_locale` SET `Name` = '朱莉安·加林納' WHERE `locale` = 'zhTW' AND `entry` = 1301;
-- OLD subname : 酒保
-- Source : https://www.wowhead.com/wotlk/tw/npc=1305
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1305;
-- OLD name : 布萊恩·克羅斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=1319
UPDATE `creature_template_locale` SET `Name` = '布賴恩·克羅斯' WHERE `locale` = 'zhTW' AND `entry` = 1319;
-- OLD name : [UNUSED] Kern the Enforcer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=1361
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 1361;
-- OLD name : 布蘭登
-- Source : https://www.wowhead.com/wotlk/tw/npc=1370
UPDATE `creature_template_locale` SET `Name` = '布蘭頓' WHERE `locale` = 'zhTW' AND `entry` = 1370;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1382
UPDATE `creature_template_locale` SET `Title` = '高級廚師' WHERE `locale` = 'zhTW' AND `entry` = 1382;
-- OLD subname : 採礦訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1384
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1384;
-- OLD name : 狂暴穴居怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=1393
UPDATE `creature_template_locale` SET `Name` = '狂暴穴居人' WHERE `locale` = 'zhTW' AND `entry` = 1393;
-- OLD subname : 石裂酋長
-- Source : https://www.wowhead.com/wotlk/tw/npc=1398
UPDATE `creature_template_locale` SET `Title` = '碎石酋長' WHERE `locale` = 'zhTW' AND `entry` = 1398;
-- OLD subname : 石裂部族薩滿
-- Source : https://www.wowhead.com/wotlk/tw/npc=1399
UPDATE `creature_template_locale` SET `Title` = '碎石部落薩滿' WHERE `locale` = 'zhTW' AND `entry` = 1399;
-- OLD name : 塔波·麥克納布
-- Source : https://www.wowhead.com/wotlk/tw/npc=1402
UPDATE `creature_template_locale` SET `Name` = '托普·麥克納布' WHERE `locale` = 'zhTW' AND `entry` = 1402;
-- OLD subname : 戰士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1403
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1403;
-- OLD subname : 薩滿訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1406
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1406;
-- OLD name : 索拉格, subname : 術士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1408
UPDATE `creature_template_locale` SET `Name` = '斯拉格',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1408;
-- OLD name : 摩拉恩·風暴之蹄, subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1409
UPDATE `creature_template_locale` SET `Name` = '摩拉恩·雷蹄',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1409;
-- OLD name : 火翼血衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1410
UPDATE `creature_template_locale` SET `Name` = '火翼血守衛' WHERE `locale` = 'zhTW' AND `entry` = 1410;
-- OLD name : 暴風城守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1423
UPDATE `creature_template_locale` SET `Name` = '暴風城衛兵' WHERE `locale` = 'zhTW' AND `entry` = 1423;
-- OLD name : 庫布
-- Source : https://www.wowhead.com/wotlk/tw/npc=1425
UPDATE `creature_template_locale` SET `Name` = '格瑞茲拉克' WHERE `locale` = 'zhTW' AND `entry` = 1425;
-- OLD name : 雷瑪·施耐德
-- Source : https://www.wowhead.com/wotlk/tw/npc=1428
UPDATE `creature_template_locale` SET `Name` = '雷瑪·施涅德' WHERE `locale` = 'zhTW' AND `entry` = 1428;
-- OLD name : 薩爾曼·施耐德
-- Source : https://www.wowhead.com/wotlk/tw/npc=1429
UPDATE `creature_template_locale` SET `Name` = '薩爾曼·斯涅德' WHERE `locale` = 'zhTW' AND `entry` = 1429;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1430
UPDATE `creature_template_locale` SET `Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 1430;
-- OLD name : 米奈希爾哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1434
UPDATE `creature_template_locale` SET `Name` = '米奈希爾哨兵' WHERE `locale` = 'zhTW' AND `entry` = 1434;
-- OLD name : 『黑爪』加爾德斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=1435
UPDATE `creature_template_locale` SET `Name` = '黑爪加爾德斯' WHERE `locale` = 'zhTW' AND `entry` = 1435;
-- OLD name : 巴拉克·唐納德, subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1441
UPDATE `creature_template_locale` SET `Name` = '布拉克·唐納德',`Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 1441;
-- OLD name : 尼爾·艾倫, subname : 工程學和雜貨商
-- Source : https://www.wowhead.com/wotlk/tw/npc=1448
UPDATE `creature_template_locale` SET `Name` = '尼爾·奧雷',`Title` = '工程學和雜貨供應商' WHERE `locale` = 'zhTW' AND `entry` = 1448;
-- OLD name : 德溫·閃曦
-- Source : https://www.wowhead.com/wotlk/tw/npc=1453
UPDATE `creature_template_locale` SET `Name` = '德溫·晨光' WHERE `locale` = 'zhTW' AND `entry` = 1453;
-- OLD name : [UNUSED] Grummar Thunk (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=1455
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 1455;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (1455, 'zhTW','NPC',NULL);
-- OLD subname : 弓箭商
-- Source : https://www.wowhead.com/wotlk/tw/npc=1462
UPDATE `creature_template_locale` SET `Title` = '造箭師' WHERE `locale` = 'zhTW' AND `entry` = 1462;
-- OLD subname : 護甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=1468
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1468;
-- OLD name : 米奈希爾守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1475
UPDATE `creature_template_locale` SET `Name` = '米奈希爾衛兵' WHERE `locale` = 'zhTW' AND `entry` = 1475;
-- OLD name : 艾迪斯·布羅姆
-- Source : https://www.wowhead.com/wotlk/tw/npc=1478
UPDATE `creature_template_locale` SET `Name` = '艾迪斯·布洛姆' WHERE `locale` = 'zhTW' AND `entry` = 1478;
-- OLD name : 提摩西·克拉克
-- Source : https://www.wowhead.com/wotlk/tw/npc=1479
UPDATE `creature_template_locale` SET `Name` = '提蒙西·克拉克' WHERE `locale` = 'zhTW' AND `entry` = 1479;
-- OLD name : 『斬擊者』摩卡什
-- Source : https://www.wowhead.com/wotlk/tw/npc=1493
UPDATE `creature_template_locale` SET `Name` = '摩卡什' WHERE `locale` = 'zhTW' AND `entry` = 1493;
-- OLD name : 亡靈守衛林奈
-- Source : https://www.wowhead.com/wotlk/tw/npc=1495
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵林奈' WHERE `locale` = 'zhTW' AND `entry` = 1495;
-- OLD name : 亡靈守衛迪林格爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=1496
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵迪林格爾' WHERE `locale` = 'zhTW' AND `entry` = 1496;
-- OLD name : 悲慘的食屍鬼
-- Source : https://www.wowhead.com/wotlk/tw/npc=1502
UPDATE `creature_template_locale` SET `Name` = '醜陋的殭屍' WHERE `locale` = 'zhTW' AND `entry` = 1502;
-- OLD name : 血色皈依者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1506
UPDATE `creature_template_locale` SET `Name` = '血色信徒' WHERE `locale` = 'zhTW' AND `entry` = 1506;
-- OLD name : 亡靈守衛希米爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=1519
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵希米爾' WHERE `locale` = 'zhTW' AND `entry` = 1519;
-- OLD name : 格雷森·戴德瑪
-- Source : https://www.wowhead.com/wotlk/tw/npc=1521
UPDATE `creature_template_locale` SET `Name` = '格莉絲·戴瑪' WHERE `locale` = 'zhTW' AND `entry` = 1521;
-- OLD name : 暗眼骸骨法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1522
UPDATE `creature_template_locale` SET `Name` = '暗眼骷髏法師' WHERE `locale` = 'zhTW' AND `entry` = 1522;
-- OLD name : 飢餓的死屍
-- Source : https://www.wowhead.com/wotlk/tw/npc=1527
UPDATE `creature_template_locale` SET `Name` = '饑餓的死屍' WHERE `locale` = 'zhTW' AND `entry` = 1527;
-- OLD name : 蹣跚的恐獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=1528
UPDATE `creature_template_locale` SET `Name` = '蹣跚的血殭屍' WHERE `locale` = 'zhTW' AND `entry` = 1528;
-- OLD name : 痛苦之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=1533
UPDATE `creature_template_locale` SET `Name` = '痛苦的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 1533;
-- OLD name : 血色先鋒
-- Source : https://www.wowhead.com/wotlk/tw/npc=1540
UPDATE `creature_template_locale` SET `Name` = '血色前鋒' WHERE `locale` = 'zhTW' AND `entry` = 1540;
-- OLD name : 邪鰭小神諭者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1544
UPDATE `creature_template_locale` SET `Name` = '邪鰭先知' WHERE `locale` = 'zhTW' AND `entry` = 1544;
-- OLD name : [UNUSED]克納爾·薩恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=1546
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 1546;
-- OLD name : 鐵顎蜥蜴
-- Source : https://www.wowhead.com/wotlk/tw/npc=1551
UPDATE `creature_template_locale` SET `Name` = '鐵齶蜥蜴' WHERE `locale` = 'zhTW' AND `entry` = 1551;
-- OLD name : Slim's Test Rogue
-- Source : https://www.wowhead.com/wotlk/tw/npc=1601
UPDATE `creature_template_locale` SET `Name` = 'Rogue 40' WHERE `locale` = 'zhTW' AND `entry` = 1601;
-- OLD name : [UNUSED] Elwynn Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=1643
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 1643;
-- OLD name : [UNUSED] Redridge Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=1644
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 1644;
-- OLD subname : 武器鍛造大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1645
UPDATE `creature_template_locale` SET `Title` = '武器鑄造大師' WHERE `locale` = 'zhTW' AND `entry` = 1645;
-- OLD subname : Reuse Me
-- Source : https://www.wowhead.com/wotlk/tw/npc=1649
UPDATE `creature_template_locale` SET `Title` = 'e Me' WHERE `locale` = 'zhTW' AND `entry` = 1649;
-- OLD name : 亡靈守衛伯吉斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=1652
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵伯吉斯' WHERE `locale` = 'zhTW' AND `entry` = 1652;
-- OLD name : 戴弗林·阿加曼德
-- Source : https://www.wowhead.com/wotlk/tw/npc=1657
UPDATE `creature_template_locale` SET `Name` = '代弗林·阿加曼德' WHERE `locale` = 'zhTW' AND `entry` = 1657;
-- OLD name : 達高爾上尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=1658
UPDATE `creature_template_locale` SET `Name` = '達高爾隊長' WHERE `locale` = 'zhTW' AND `entry` = 1658;
-- OLD subname : NEEDS MODEL
-- Source : https://www.wowhead.com/wotlk/tw/npc=1659
UPDATE `creature_template_locale` SET `Title` = 'S MODEL' WHERE `locale` = 'zhTW' AND `entry` = 1659;
-- OLD name : 見習者艾蕾絲
-- Source : https://www.wowhead.com/wotlk/tw/npc=1661
UPDATE `creature_template_locale` SET `Name` = '新兵艾爾雷斯' WHERE `locale` = 'zhTW' AND `entry` = 1661;
-- OLD name : 威廉·馬克格里高
-- Source : https://www.wowhead.com/wotlk/tw/npc=1668
UPDATE `creature_template_locale` SET `Name` = '威廉·馬克葛瑞格' WHERE `locale` = 'zhTW' AND `entry` = 1668;
-- OLD subname : 水果商
-- Source : https://www.wowhead.com/wotlk/tw/npc=1671
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1671;
-- OLD name : 洛爾甘·伊娃
-- Source : https://www.wowhead.com/wotlk/tw/npc=1672
UPDATE `creature_template_locale` SET `Name` = '洛爾甘·伊瓦' WHERE `locale` = 'zhTW' AND `entry` = 1672;
-- OLD name : 艾莉莎·伊娃
-- Source : https://www.wowhead.com/wotlk/tw/npc=1673
UPDATE `creature_template_locale` SET `Name` = '艾莉莎·伊瓦' WHERE `locale` = 'zhTW' AND `entry` = 1673;
-- OLD name : [UNUSED] Curtis Ashlock (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=1677
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 1677;
-- OLD subname : 釣魚訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1683
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1683;
-- OLD subname : 釣魚供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=1684
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1684;
-- OLD name : 艾琳·穩擊, subname : 槍械商
-- Source : https://www.wowhead.com/wotlk/tw/npc=1686
UPDATE `creature_template_locale` SET `Name` = '埃倫',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1686;
-- OLD subname : 弓箭商
-- Source : https://www.wowhead.com/wotlk/tw/npc=1687
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1687;
-- OLD name : 夜行蜘蛛族母
-- Source : https://www.wowhead.com/wotlk/tw/npc=1688
UPDATE `creature_template_locale` SET `Name` = '夜行雌蜘蛛' WHERE `locale` = 'zhTW' AND `entry` = 1688;
-- OLD subname : 見習武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1698
UPDATE `creature_template_locale` SET `Title` = '見習武器匠' WHERE `locale` = 'zhTW' AND `entry` = 1698;
-- OLD name : 囚犯
-- Source : https://www.wowhead.com/wotlk/tw/npc=1706
UPDATE `creature_template_locale` SET `Name` = '迪菲亞囚犯' WHERE `locale` = 'zhTW' AND `entry` = 1706;
-- OLD name : 叛軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=1715
UPDATE `creature_template_locale` SET `Name` = '迪菲亞叛軍' WHERE `locale` = 'zhTW' AND `entry` = 1715;
-- OLD name : 石齶劫掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1718
UPDATE `creature_template_locale` SET `Name` = '石齶襲擊者' WHERE `locale` = 'zhTW' AND `entry` = 1718;
-- OLD name : 暴風城居民, subname : 佔地者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1723
UPDATE `creature_template_locale` SET `Name` = '暴風城平民',`Title` = 'eholder' WHERE `locale` = 'zhTW' AND `entry` = 1723;
-- OLD name : 暴風城男性居民, subname : 佔地者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1724
UPDATE `creature_template_locale` SET `Name` = '暴風城男性平民',`Title` = 'eholder' WHERE `locale` = 'zhTW' AND `entry` = 1724;
-- OLD name : 迪菲亞警備兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=1725
UPDATE `creature_template_locale` SET `Name` = '迪菲亞衛兵' WHERE `locale` = 'zhTW' AND `entry` = 1725;
-- OLD name : 迪菲亞塑能師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1729
UPDATE `creature_template_locale` SET `Name` = '迪菲亞招魂師' WHERE `locale` = 'zhTW' AND `entry` = 1729;
-- OLD subname : 加爾德斯的爪牙
-- Source : https://www.wowhead.com/wotlk/tw/npc=1733
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1733;
-- OLD name : 亡靈守衛亞伯拉罕
-- Source : https://www.wowhead.com/wotlk/tw/npc=1735
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵亞伯拉罕' WHERE `locale` = 'zhTW' AND `entry` = 1735;
-- OLD name : 亡靈守衛藍道夫
-- Source : https://www.wowhead.com/wotlk/tw/npc=1736
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵藍道夫' WHERE `locale` = 'zhTW' AND `entry` = 1736;
-- OLD name : 亡靈守衛奧利佛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1737
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵奧利佛' WHERE `locale` = 'zhTW' AND `entry` = 1737;
-- OLD name : 亡靈守衛特倫斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=1738
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵特倫斯' WHERE `locale` = 'zhTW' AND `entry` = 1738;
-- OLD name : 亡靈守衛菲力浦
-- Source : https://www.wowhead.com/wotlk/tw/npc=1739
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵菲力浦' WHERE `locale` = 'zhTW' AND `entry` = 1739;
-- OLD name : 亡靈守衛薩爾坦
-- Source : https://www.wowhead.com/wotlk/tw/npc=1740
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵薩爾坦' WHERE `locale` = 'zhTW' AND `entry` = 1740;
-- OLD name : 亡靈守衛巴特蘭德
-- Source : https://www.wowhead.com/wotlk/tw/npc=1741
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵巴特蘭德' WHERE `locale` = 'zhTW' AND `entry` = 1741;
-- OLD name : 亡靈守衛巴薩羅繆
-- Source : https://www.wowhead.com/wotlk/tw/npc=1742
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵巴薩羅繆' WHERE `locale` = 'zhTW' AND `entry` = 1742;
-- OLD name : 亡靈守衛勞倫斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=1743
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵勞倫斯' WHERE `locale` = 'zhTW' AND `entry` = 1743;
-- OLD name : 亡靈守衛莫特
-- Source : https://www.wowhead.com/wotlk/tw/npc=1744
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵莫特' WHERE `locale` = 'zhTW' AND `entry` = 1744;
-- OLD name : 亡靈守衛莫里斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=1745
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵莫瑞斯' WHERE `locale` = 'zhTW' AND `entry` = 1745;
-- OLD name : 亡靈守衛塞勒斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=1746
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵塞勒斯' WHERE `locale` = 'zhTW' AND `entry` = 1746;
-- OLD name : 安杜因·烏瑞恩, subname : 暴風城王子
-- Source : https://www.wowhead.com/wotlk/tw/npc=1747
UPDATE `creature_template_locale` SET `Name` = '安度因·烏瑞恩國王',`Title` = '暴風城的國王' WHERE `locale` = 'zhTW' AND `entry` = 1747;
-- OLD name : 傑塔瑞斯上將
-- Source : https://www.wowhead.com/wotlk/tw/npc=1750
UPDATE `creature_template_locale` SET `Name` = '傑塔瑞斯將軍' WHERE `locale` = 'zhTW' AND `entry` = 1750;
-- OLD name : 卡雷德拉·曦風
-- Source : https://www.wowhead.com/wotlk/tw/npc=1752
UPDATE `creature_template_locale` SET `Name` = '卡雷德拉·晨風' WHERE `locale` = 'zhTW' AND `entry` = 1752;
-- OLD name : 格里高·萊斯科瓦領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=1754
UPDATE `creature_template_locale` SET `Name` = '葛瑞格·萊斯科瓦公爵' WHERE `locale` = 'zhTW' AND `entry` = 1754;
-- OLD name : 『沉默之刃』馬爾松
-- Source : https://www.wowhead.com/wotlk/tw/npc=1755
UPDATE `creature_template_locale` SET `Name` = '沉默之刃馬爾松' WHERE `locale` = 'zhTW' AND `entry` = 1755;
-- OLD name : 暴風城皇家守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1756
UPDATE `creature_template_locale` SET `Name` = '暴風城皇家衛兵' WHERE `locale` = 'zhTW' AND `entry` = 1756;
-- OLD subname : 熔煉師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1763
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 1763;
-- OLD name : 瘋狂的座狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=1766
UPDATE `creature_template_locale` SET `Name` = '雜斑座狼' WHERE `locale` = 'zhTW' AND `entry` = 1766;
-- OLD name : 腐皮秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=1773
UPDATE `creature_template_locale` SET `Name` = '腐皮秘法師' WHERE `locale` = 'zhTW' AND `entry` = 1773;
-- OLD name : 蛛網打擊者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1780
UPDATE `creature_template_locale` SET `Name` = '苔蘚闊步者' WHERE `locale` = 'zhTW' AND `entry` = 1780;
-- OLD name : 蛛網潛伏者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1781
UPDATE `creature_template_locale` SET `Name` = '迷霧爬行者' WHERE `locale` = 'zhTW' AND `entry` = 1781;
-- OLD name : 巨型狂熊
-- Source : https://www.wowhead.com/wotlk/tw/npc=1797
UPDATE `creature_template_locale` SET `Name` = '巨型灰斑熊' WHERE `locale` = 'zhTW' AND `entry` = 1797;
-- OLD name : 受折磨的靈魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=1798
UPDATE `creature_template_locale` SET `Name` = '被折磨的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 1798;
-- OLD name : 寒冰怨靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=1800
UPDATE `creature_template_locale` SET `Name` = '寒冰鬼魂' WHERE `locale` = 'zhTW' AND `entry` = 1800;
-- OLD name : 鮮血怨靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=1801
UPDATE `creature_template_locale` SET `Name` = '鮮血鬼魂' WHERE `locale` = 'zhTW' AND `entry` = 1801;
-- OLD name : 飢餓的怨靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=1802
UPDATE `creature_template_locale` SET `Name` = '饑餓的怨靈' WHERE `locale` = 'zhTW' AND `entry` = 1802;
-- OLD name : 可憎的泥漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=1806
UPDATE `creature_template_locale` SET `Name` = '可憎的軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 1806;
-- OLD name : 吞噬軟泥怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=1808
UPDATE `creature_template_locale` SET `Name` = '吞噬淤泥怪' WHERE `locale` = 'zhTW' AND `entry` = 1808;
-- OLD name : 腐爛的兀鷹
-- Source : https://www.wowhead.com/wotlk/tw/npc=1810
UPDATE `creature_template_locale` SET `Name` = '腐爛的禿鷲' WHERE `locale` = 'zhTW' AND `entry` = 1810;
-- OLD name : 瘟疫禿鷹
-- Source : https://www.wowhead.com/wotlk/tw/npc=1811
UPDATE `creature_template_locale` SET `Name` = '瘟疫禿鷲' WHERE `locale` = 'zhTW' AND `entry` = 1811;
-- OLD name : 凋零的恐獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=1813
UPDATE `creature_template_locale` SET `Name` = '枯萎的恐獸' WHERE `locale` = 'zhTW' AND `entry` = 1813;
-- OLD name : 染病的黑熊
-- Source : https://www.wowhead.com/wotlk/tw/npc=1815
UPDATE `creature_template_locale` SET `Name` = '生病的黑熊' WHERE `locale` = 'zhTW' AND `entry` = 1815;
-- OLD name : 染病的灰熊
-- Source : https://www.wowhead.com/wotlk/tw/npc=1816
UPDATE `creature_template_locale` SET `Name` = '生病的灰熊' WHERE `locale` = 'zhTW' AND `entry` = 1816;
-- OLD name : 血色哨兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=1827
UPDATE `creature_template_locale` SET `Name` = '血色徘徊者' WHERE `locale` = 'zhTW' AND `entry` = 1827;
-- OLD name : 血色塑能師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1835
UPDATE `creature_template_locale` SET `Name` = '血色召現師' WHERE `locale` = 'zhTW' AND `entry` = 1835;
-- OLD name : 血色審問者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1838
UPDATE `creature_template_locale` SET `Name` = '血色質問者' WHERE `locale` = 'zhTW' AND `entry` = 1838;
-- OLD name : 大審判官伊森利恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=1840
UPDATE `creature_template_locale` SET `Name` = '大檢察官伊森利恩' WHERE `locale` = 'zhTW' AND `entry` = 1840;
-- OLD name : 提里奧·弗丁
-- Source : https://www.wowhead.com/wotlk/tw/npc=1855
UPDATE `creature_template_locale` SET `Name` = '提里恩·弗丁' WHERE `locale` = 'zhTW' AND `entry` = 1855;
-- OLD subname : 測試
-- Source : https://www.wowhead.com/wotlk/tw/npc=1857
UPDATE `creature_template_locale` SET `Title` = 'ed Vendor' WHERE `locale` = 'zhTW' AND `entry` = 1857;
-- OLD subname : 測試
-- Source : https://www.wowhead.com/wotlk/tw/npc=1858
UPDATE `creature_template_locale` SET `Title` = 'ed Vendor' WHERE `locale` = 'zhTW' AND `entry` = 1858;
-- OLD name : [UNUSED] 奈恩·長風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=1859
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 1859;
-- OLD name : 強效虛無行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1861
UPDATE `creature_template_locale` SET `Name` = '強效虛空行者' WHERE `locale` = 'zhTW' AND `entry` = 1861;
-- OLD name : 次級虛空行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1862
UPDATE `creature_template_locale` SET `Name` = '次級虛無行者' WHERE `locale` = 'zhTW' AND `entry` = 1862;
-- OLD name : 鴉爪劫掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1865
UPDATE `creature_template_locale` SET `Name` = '鴉爪襲擊者' WHERE `locale` = 'zhTW' AND `entry` = 1865;
-- OLD name : 伊莉莎的守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1871
UPDATE `creature_template_locale` SET `Name` = '伊莉莎的衛兵' WHERE `locale` = 'zhTW' AND `entry` = 1871;
-- OLD name : 安伯米爾看守者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1888
UPDATE `creature_template_locale` SET `Name` = '達拉然衛士' WHERE `locale` = 'zhTW' AND `entry` = 1888;
-- OLD name : 安伯米爾巫師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1889
UPDATE `creature_template_locale` SET `Name` = '達拉然巫師' WHERE `locale` = 'zhTW' AND `entry` = 1889;
-- OLD name : 月怒哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1893
UPDATE `creature_template_locale` SET `Name` = '月怒哨兵' WHERE `locale` = 'zhTW' AND `entry` = 1893;
-- OLD name : 焚木村哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1894
UPDATE `creature_template_locale` SET `Name` = '焚木村哨兵' WHERE `locale` = 'zhTW' AND `entry` = 1894;
-- OLD name : 安伯米爾保衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1912
UPDATE `creature_template_locale` SET `Name` = '達拉然保衛者' WHERE `locale` = 'zhTW' AND `entry` = 1912;
-- OLD name : 安伯米爾護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=1913
UPDATE `creature_template_locale` SET `Name` = '達拉然守衛' WHERE `locale` = 'zhTW' AND `entry` = 1913;
-- OLD name : 安伯米爾博學者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1914
UPDATE `creature_template_locale` SET `Name` = '達拉然法師' WHERE `locale` = 'zhTW' AND `entry` = 1914;
-- OLD name : 安伯米爾咒術師
-- Source : https://www.wowhead.com/wotlk/tw/npc=1915
UPDATE `creature_template_locale` SET `Name` = '達拉然咒術師' WHERE `locale` = 'zhTW' AND `entry` = 1915;
-- OLD name : 史蒂芬·巴爾泰克
-- Source : https://www.wowhead.com/wotlk/tw/npc=1916
UPDATE `creature_template_locale` SET `Name` = '斯蒂芬·巴爾泰克' WHERE `locale` = 'zhTW' AND `entry` = 1916;
-- OLD name : 安伯米爾法術抄寫員
-- Source : https://www.wowhead.com/wotlk/tw/npc=1920
UPDATE `creature_template_locale` SET `Name` = '達拉然書記員' WHERE `locale` = 'zhTW' AND `entry` = 1920;
-- OLD subname : 對火焰傷害免疫
-- Source : https://www.wowhead.com/wotlk/tw/npc=1925
UPDATE `creature_template_locale` SET `Title` = 'ne to Fire' WHERE `locale` = 'zhTW' AND `entry` = 1925;
-- OLD subname : 對冰霜傷害免疫
-- Source : https://www.wowhead.com/wotlk/tw/npc=1926
UPDATE `creature_template_locale` SET `Title` = 'ne to Frost' WHERE `locale` = 'zhTW' AND `entry` = 1926;
-- OLD subname : 對神聖傷害免疫
-- Source : https://www.wowhead.com/wotlk/tw/npc=1927
UPDATE `creature_template_locale` SET `Title` = 'ne to Holy' WHERE `locale` = 'zhTW' AND `entry` = 1927;
-- OLD subname : 對暗影傷害免疫
-- Source : https://www.wowhead.com/wotlk/tw/npc=1928
UPDATE `creature_template_locale` SET `Title` = 'ne to Shadow' WHERE `locale` = 'zhTW' AND `entry` = 1928;
-- OLD subname : 對自然傷害免疫
-- Source : https://www.wowhead.com/wotlk/tw/npc=1929
UPDATE `creature_template_locale` SET `Title` = 'ne to Nature' WHERE `locale` = 'zhTW' AND `entry` = 1929;
-- OLD subname : 對物理傷害免疫
-- Source : https://www.wowhead.com/wotlk/tw/npc=1930
UPDATE `creature_template_locale` SET `Title` = 'ne to Physical' WHERE `locale` = 'zhTW' AND `entry` = 1930;
-- OLD name : 被俘虜的血色狂熱者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1931
UPDATE `creature_template_locale` SET `Name` = '血色十字軍俘虜' WHERE `locale` = 'zhTW' AND `entry` = 1931;
-- OLD name : 腐皮蠻卒
-- Source : https://www.wowhead.com/wotlk/tw/npc=1939
UPDATE `creature_template_locale` SET `Name` = '腐皮蠻兵' WHERE `locale` = 'zhTW' AND `entry` = 1939;
-- OLD name : 腐皮蠻族
-- Source : https://www.wowhead.com/wotlk/tw/npc=1942
UPDATE `creature_template_locale` SET `Name` = '腐皮暴徒' WHERE `locale` = 'zhTW' AND `entry` = 1942;
-- OLD name : 盛怒的腐皮豺狼人
-- Source : https://www.wowhead.com/wotlk/tw/npc=1943
UPDATE `creature_template_locale` SET `Name` = '暴怒的腐皮豺狼人' WHERE `locale` = 'zhTW' AND `entry` = 1943;
-- OLD subname : 亡靈哨兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=1950
UPDATE `creature_template_locale` SET `Title` = '亡靈偵察兵' WHERE `locale` = 'zhTW' AND `entry` = 1950;
-- OLD subname : 亡靈哨兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=1951
UPDATE `creature_template_locale` SET `Title` = '亡靈偵察兵' WHERE `locale` = 'zhTW' AND `entry` = 1951;
-- OLD name : 高階執行官哈德瑞克
-- Source : https://www.wowhead.com/wotlk/tw/npc=1952
UPDATE `creature_template_locale` SET `Name` = '高級執行官哈德瑞克' WHERE `locale` = 'zhTW' AND `entry` = 1952;
-- OLD name : 湖岸蠕行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1955
UPDATE `creature_template_locale` SET `Name` = '湖岸爬行者' WHERE `locale` = 'zhTW' AND `entry` = 1955;
-- OLD name : 老邁的湖岸蠕行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=1956
UPDATE `creature_template_locale` SET `Name` = '老邁的湖岸爬行者' WHERE `locale` = 'zhTW' AND `entry` = 1956;
-- OLD name : 蒼白的格瑞姆森
-- Source : https://www.wowhead.com/wotlk/tw/npc=1972
UPDATE `creature_template_locale` SET `Name` = '白毛狼人格瑞姆森' WHERE `locale` = 'zhTW' AND `entry` = 1972;
-- OLD name : 兇惡劣魔
-- Source : https://www.wowhead.com/wotlk/tw/npc=2005
UPDATE `creature_template_locale` SET `Name` = '邪惡劣魔' WHERE `locale` = 'zhTW' AND `entry` = 2005;
-- OLD name : 血羽女王
-- Source : https://www.wowhead.com/wotlk/tw/npc=2021
UPDATE `creature_template_locale` SET `Name` = '血羽女族長' WHERE `locale` = 'zhTW' AND `entry` = 2021;
-- OLD name : 樹精泥濘獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=2029
UPDATE `creature_template_locale` SET `Name` = '林精泥濘獸' WHERE `locale` = 'zhTW' AND `entry` = 2029;
-- OLD name : 樹精長老
-- Source : https://www.wowhead.com/wotlk/tw/npc=2030
UPDATE `creature_template_locale` SET `Name` = '林精長老' WHERE `locale` = 'zhTW' AND `entry` = 2030;
-- OLD name : 古樹保衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2041
UPDATE `creature_template_locale` SET `Name` = '守護古樹' WHERE `locale` = 'zhTW' AND `entry` = 2041;
-- OLD subname : 模型與結構
-- Source : https://www.wowhead.com/wotlk/tw/npc=2051
UPDATE `creature_template_locale` SET `Title` = 'l and Texture' WHERE `locale` = 'zhTW' AND `entry` = 2051;
-- OLD name : 鴉爪亡魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=2056
UPDATE `creature_template_locale` SET `Name` = '鴉爪幽靈' WHERE `locale` = 'zhTW' AND `entry` = 2056;
-- OLD subname : 焚木村議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=2060
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2060;
-- OLD subname : 焚木村議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=2061
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2061;
-- OLD subname : 焚木村議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=2062
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2062;
-- OLD subname : 焚木村議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=2063
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2063;
-- OLD subname : 焚木村議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=2064
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2064;
-- OLD subname : 焚木村議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=2065
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2065;
-- OLD subname : 焚木村議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=2066
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2066;
-- OLD subname : 焚木村議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=2067
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2067;
-- OLD subname : 焚木村議長
-- Source : https://www.wowhead.com/wotlk/tw/npc=2068
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2068;
-- OLD name : 月巡虎
-- Source : https://www.wowhead.com/wotlk/tw/npc=2069
UPDATE `creature_template_locale` SET `Name` = '月夜猛虎' WHERE `locale` = 'zhTW' AND `entry` = 2069;
-- OLD name : 小月巡虎
-- Source : https://www.wowhead.com/wotlk/tw/npc=2070
UPDATE `creature_template_locale` SET `Name` = '小月夜猛虎' WHERE `locale` = 'zhTW' AND `entry` = 2070;
-- OLD name : 月巡雌虎
-- Source : https://www.wowhead.com/wotlk/tw/npc=2071
UPDATE `creature_template_locale` SET `Name` = '月夜虎族母' WHERE `locale` = 'zhTW' AND `entry` = 2071;
-- OLD name : 伊爾薩萊恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=2079
UPDATE `creature_template_locale` SET `Name` = '管理員伊爾薩萊恩' WHERE `locale` = 'zhTW' AND `entry` = 2079;
-- OLD name : [UNUSED]安伯米爾居民 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2087
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2087;
-- OLD subname : 別相信我!我叫比利!
-- Source : https://www.wowhead.com/wotlk/tw/npc=2095
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2095;
-- OLD name : 龍喉蠻兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=2102
UPDATE `creature_template_locale` SET `Name` = '龍喉步兵' WHERE `locale` = 'zhTW' AND `entry` = 2102;
-- OLD name : 阿基巴德·卡瓦
-- Source : https://www.wowhead.com/wotlk/tw/npc=2113
UPDATE `creature_template_locale` SET `Name` = '阿基班德·卡瓦' WHERE `locale` = 'zhTW' AND `entry` = 2113;
-- OLD subname : 見習武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2117
UPDATE `creature_template_locale` SET `Title` = '見習武器匠' WHERE `locale` = 'zhTW' AND `entry` = 2117;
-- OLD name : 黑暗教士杜斯騰
-- Source : https://www.wowhead.com/wotlk/tw/npc=2123
UPDATE `creature_template_locale` SET `Name` = '黑暗教士杜斯滕' WHERE `locale` = 'zhTW' AND `entry` = 2123;
-- OLD name : 奧利佛·德沃爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=2136
UPDATE `creature_template_locale` SET `Name` = '奧利弗·德沃爾' WHERE `locale` = 'zhTW' AND `entry` = 2136;
-- OLD name : 黑鐵劫掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2149
UPDATE `creature_template_locale` SET `Name` = '黑鐵襲擊者' WHERE `locale` = 'zhTW' AND `entry` = 2149;
-- OLD name : 月之女祭司阿瑪拉
-- Source : https://www.wowhead.com/wotlk/tw/npc=2151
UPDATE `creature_template_locale` SET `Name` = '哨兵阿瑪拉·夜行者' WHERE `locale` = 'zhTW' AND `entry` = 2151;
-- OLD subname : 模型與結構
-- Source : https://www.wowhead.com/wotlk/tw/npc=2154
UPDATE `creature_template_locale` SET `Title` = 'l and Texture' WHERE `locale` = 'zhTW' AND `entry` = 2154;
-- OLD name : 砂石地卜師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2160
UPDATE `creature_template_locale` SET `Name` = '砂石地占師' WHERE `locale` = 'zhTW' AND `entry` = 2160;
-- OLD name : 雌性森林陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=2172
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 2172;
-- OLD name : 悲苦的精靈貴族
-- Source : https://www.wowhead.com/wotlk/tw/npc=2177
UPDATE `creature_template_locale` SET `Name` = '掙扎的精靈貴族' WHERE `locale` = 'zhTW' AND `entry` = 2177;
-- OLD name : [UNUSED] Crier Kirton (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2197
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2197;
-- OLD name : [UNUSED] Crier Backus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2199
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2199;
-- OLD name : [UNUSED] Crier Pierce (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2200
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2200;
-- OLD name : 亡靈守衛加文
-- Source : https://www.wowhead.com/wotlk/tw/npc=2209
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵加文' WHERE `locale` = 'zhTW' AND `entry` = 2209;
-- OLD name : 亡靈守衛羅亞恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=2210
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵羅亞恩' WHERE `locale` = 'zhTW' AND `entry` = 2210;
-- OLD name : 高階執行官達薩利亞
-- Source : https://www.wowhead.com/wotlk/tw/npc=2215
UPDATE `creature_template_locale` SET `Name` = '高級執行官達薩利亞' WHERE `locale` = 'zhTW' AND `entry` = 2215;
-- OLD subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2217
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2217;
-- OLD subname : 獵人訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2218
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2218;
-- OLD subname : 薩滿訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2219
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2219;
-- OLD name : [UNUSED] Undead Blacksmith Trainer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2220
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2220;
-- OLD subname : 裁縫訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2221
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2221;
-- OLD subname : 採礦訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2222
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2222;
-- OLD name : [UNUSED] 不死族烹飪訓練師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2223
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2223;
-- OLD name : 盛怒的暗礁蟹
-- Source : https://www.wowhead.com/wotlk/tw/npc=2236
UPDATE `creature_template_locale` SET `Name` = '狂暴暗礁蟹' WHERE `locale` = 'zhTW' AND `entry` = 2236;
-- OLD name : 月巡雄虎
-- Source : https://www.wowhead.com/wotlk/tw/npc=2237
UPDATE `creature_template_locale` SET `Name` = '月夜雄虎' WHERE `locale` = 'zhTW' AND `entry` = 2237;
-- OLD name : 辛迪加哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=2243
UPDATE `creature_template_locale` SET `Name` = '辛迪加哨兵' WHERE `locale` = 'zhTW' AND `entry` = 2243;
-- OLD name : 瑪加拉克
-- Source : https://www.wowhead.com/wotlk/tw/npc=2258
UPDATE `creature_template_locale` SET `Name` = '狂怒的石元素' WHERE `locale` = 'zhTW' AND `entry` = 2258;
-- OLD name : 辛迪加警備兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=2261
UPDATE `creature_template_locale` SET `Name` = '辛迪加衛士' WHERE `locale` = 'zhTW' AND `entry` = 2261;
-- OLD name : 希爾斯布萊德哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=2270
UPDATE `creature_template_locale` SET `Name` = '希爾斯布萊德哨兵' WHERE `locale` = 'zhTW' AND `entry` = 2270;
-- OLD name : 博學大師迪布斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=2277
UPDATE `creature_template_locale` SET `Name` = '博學者迪布斯' WHERE `locale` = 'zhTW' AND `entry` = 2277;
-- OLD name : 聯盟戰地衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=2279
UPDATE `creature_template_locale` SET `Name` = '聯盟衛兵' WHERE `locale` = 'zhTW' AND `entry` = 2279;
-- OLD name : 部落戰地衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=2280
UPDATE `creature_template_locale` SET `Name` = '部落衛兵' WHERE `locale` = 'zhTW' AND `entry` = 2280;
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2281
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2281;
-- OLD name : Bow Guy
-- Source : https://www.wowhead.com/wotlk/tw/npc=2286
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2286;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2286, 'zhTW','弓箭手',NULL);
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2289
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2289;
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2290
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2290;
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2291
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2291;
-- OLD name : 雷吉納德·拜瑞, subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2292
UPDATE `creature_template_locale` SET `Name` = '雷納德·拜瑞',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2292;
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2294
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2294;
-- OLD name : [UNUSED] 巴托克·鋼骨 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=2295
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 2295;
-- OLD name : [UNUSED] 弗加爾·冰爐 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=2296
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 2296;
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2298
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2298;
-- OLD name : [UNUSED]奈瑞克·沙尤爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=2301
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 2301;
-- OLD name : 艾薩拉斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=2302
UPDATE `creature_template_locale` SET `Name` = '艾薩拉斯·克羅維爾' WHERE `locale` = 'zhTW' AND `entry` = 2302;
-- OLD name : 瓦杜斯男爵
-- Source : https://www.wowhead.com/wotlk/tw/npc=2306
UPDATE `creature_template_locale` SET `Name` = '巴隆·瓦杜斯' WHERE `locale` = 'zhTW' AND `entry` = 2306;
-- OLD subname : <Needs Model>
-- Source : https://www.wowhead.com/wotlk/tw/npc=2312
UPDATE `creature_template_locale` SET `Title` = 'ds Model>' WHERE `locale` = 'zhTW' AND `entry` = 2312;
-- OLD name : [UNUSED] Kir'Nazz (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2313
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2313;
-- OLD name : 森林陸行鳥雛鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=2321
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 2321;
-- OLD name : 森林陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=2322
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 2322;
-- OLD name : 兇猛的森林陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=2323
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 2323;
-- OLD subname : 急救訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2325
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2325;
-- OLD subname : 急救訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2326
UPDATE `creature_template_locale` SET `Title` = '醫師' WHERE `locale` = 'zhTW' AND `entry` = 2326;
-- OLD subname : 急救訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2329
UPDATE `creature_template_locale` SET `Title` = '醫師' WHERE `locale` = 'zhTW' AND `entry` = 2329;
-- OLD name : 伯恩塞德鎮長
-- Source : https://www.wowhead.com/wotlk/tw/npc=2335
UPDATE `creature_template_locale` SET `Name` = '波恩塞德鎮長' WHERE `locale` = 'zhTW' AND `entry` = 2335;
-- OLD name : 暮光侍徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=2338
UPDATE `creature_template_locale` SET `Name` = '暮光信徒' WHERE `locale` = 'zhTW' AND `entry` = 2338;
-- OLD name : 丹加洛克步槍兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=2345
UPDATE `creature_template_locale` SET `Name` = '丹加洛克火槍手' WHERE `locale` = 'zhTW' AND `entry` = 2345;
-- OLD name : 被馴養的食苔蛛
-- Source : https://www.wowhead.com/wotlk/tw/npc=2349
UPDATE `creature_template_locale` SET `Name` = '巨型食苔蛛' WHERE `locale` = 'zhTW' AND `entry` = 2349;
-- OLD name : 荒疫熊
-- Source : https://www.wowhead.com/wotlk/tw/npc=2351
UPDATE `creature_template_locale` SET `Name` = '灰熊' WHERE `locale` = 'zhTW' AND `entry` = 2351;
-- OLD name : 兇惡灰熊
-- Source : https://www.wowhead.com/wotlk/tw/npc=2354
UPDATE `creature_template_locale` SET `Name` = '邪惡的灰熊' WHERE `locale` = 'zhTW' AND `entry` = 2354;
-- OLD name : 刺脊潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2368
UPDATE `creature_template_locale` SET `Name` = '刺脊捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 2368;
-- OLD name : 飢餓的山地獅
-- Source : https://www.wowhead.com/wotlk/tw/npc=2384
UPDATE `creature_template_locale` SET `Name` = '饑餓的山地獅' WHERE `locale` = 'zhTW' AND `entry` = 2384;
-- OLD name : 聯盟守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=2386
UPDATE `creature_template_locale` SET `Name` = '南海鎮衛兵' WHERE `locale` = 'zhTW' AND `entry` = 2386;
-- OLD name : 德拉克·夜暮
-- Source : https://www.wowhead.com/wotlk/tw/npc=2397
UPDATE `creature_template_locale` SET `Name` = '德拉克·奈特弗' WHERE `locale` = 'zhTW' AND `entry` = 2397;
-- OLD name : 克瑞格·赫維特
-- Source : https://www.wowhead.com/wotlk/tw/npc=2400
UPDATE `creature_template_locale` SET `Name` = '克萊格·赫維特' WHERE `locale` = 'zhTW' AND `entry` = 2400;
-- OLD name : 夏拉·布拉森
-- Source : https://www.wowhead.com/wotlk/tw/npc=2402
UPDATE `creature_template_locale` SET `Name` = '莎拉·布拉森' WHERE `locale` = 'zhTW' AND `entry` = 2402;
-- OLD name : 塔倫米爾亡靈守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=2405
UPDATE `creature_template_locale` SET `Name` = '塔倫米爾亡靈衛兵' WHERE `locale` = 'zhTW' AND `entry` = 2405;
-- OLD name : 破碎嶺盜掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2416
UPDATE `creature_template_locale` SET `Name` = '破碎嶺掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 2416;
-- OLD name : 亡靈守衛沙穆薩
-- Source : https://www.wowhead.com/wotlk/tw/npc=2418
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵沙穆薩' WHERE `locale` = 'zhTW' AND `entry` = 2418;
-- OLD name : 亡靈守衛亨伯特
-- Source : https://www.wowhead.com/wotlk/tw/npc=2419
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵亨伯特' WHERE `locale` = 'zhTW' AND `entry` = 2419;
-- OLD name : 公會銀行職員, subname : 公會銀行職員
-- Source : https://www.wowhead.com/wotlk/tw/npc=2424
UPDATE `creature_template_locale` SET `Name` = 'Test Banker',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2424;
-- OLD name : 達爾拉·哈里斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=2432
UPDATE `creature_template_locale` SET `Name` = '達爾拉·哈瑞斯' WHERE `locale` = 'zhTW' AND `entry` = 2432;
-- OLD name : 守衛者貝瓦里爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=2437
UPDATE `creature_template_locale` SET `Name` = '看守者貝瓦里爾' WHERE `locale` = 'zhTW' AND `entry` = 2437;
-- OLD name : [UNUSED]南海鎮居民 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2441
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2441;
-- OLD name : 骷髏魔(暴怒狀態)
-- Source : https://www.wowhead.com/wotlk/tw/npc=2454
UPDATE `creature_template_locale` SET `Name` = '骸骨魔(暴怒狀態)' WHERE `locale` = 'zhTW' AND `entry` = 2454;
-- OLD name : 火鱗飛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=2472
UPDATE `creature_template_locale` SET `Name` = '火鱗幼龍' WHERE `locale` = 'zhTW' AND `entry` = 2472;
-- OLD name : 戈許哈爾迪爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=2476
UPDATE `creature_template_locale` SET `Name` = '大型洛克鱷' WHERE `locale` = 'zhTW' AND `entry` = 2476;
-- OLD subname : 高級武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2482
UPDATE `creature_template_locale` SET `Title` = '高級鑄劍師' WHERE `locale` = 'zhTW' AND `entry` = 2482;
-- OLD subname : 高級製斧師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2483
UPDATE `creature_template_locale` SET `Title` = '高級制斧師' WHERE `locale` = 'zhTW' AND `entry` = 2483;
-- OLD name : 艦隊指揮官海角
-- Source : https://www.wowhead.com/wotlk/tw/npc=2487
UPDATE `creature_template_locale` SET `Name` = '艦隊指揮官卡拉·海角' WHERE `locale` = 'zhTW' AND `entry` = 2487;
-- OLD name : 『海狼』麥克基雷
-- Source : https://www.wowhead.com/wotlk/tw/npc=2501
UPDATE `creature_template_locale` SET `Name` = '『海狼』馬克基雷' WHERE `locale` = 'zhTW' AND `entry` = 2501;
-- OLD name : 遙控魔像
-- Source : https://www.wowhead.com/wotlk/tw/npc=2520
UPDATE `creature_template_locale` SET `Name` = '遙控傀儡' WHERE `locale` = 'zhTW' AND `entry` = 2520;
-- OLD subname : 贊吉爾特使
-- Source : https://www.wowhead.com/wotlk/tw/npc=2530
UPDATE `creature_template_locale` SET `Title` = '暗矛部族人質' WHERE `locale` = 'zhTW' AND `entry` = 2530;
-- OLD name : 度恩的爪牙
-- Source : https://www.wowhead.com/wotlk/tw/npc=2531
UPDATE `creature_template_locale` SET `Name` = '莫甘斯的爪牙' WHERE `locale` = 'zhTW' AND `entry` = 2531;
-- OLD name : 多娜
-- Source : https://www.wowhead.com/wotlk/tw/npc=2532
UPDATE `creature_template_locale` SET `Name` = '朵娜' WHERE `locale` = 'zhTW' AND `entry` = 2532;
-- OLD name : 安伯米爾毒蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=2540
UPDATE `creature_template_locale` SET `Name` = '達拉然毒蛇' WHERE `locale` = 'zhTW' AND `entry` = 2540;
-- OLD name : 大法師安斯雷姆·織符者, subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=2543
UPDATE `creature_template_locale` SET `Name` = '大法師安斯雷姆·魯因維沃爾',`Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 2543;
-- OLD name : 枯鬚勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=2573
UPDATE `creature_template_locale` SET `Name` = '枯鬚勘探員' WHERE `locale` = 'zhTW' AND `entry` = 2573;
-- OLD name : 達比雷苦力
-- Source : https://www.wowhead.com/wotlk/tw/npc=2582
UPDATE `creature_template_locale` SET `Name` = '達比雷勞工' WHERE `locale` = 'zhTW' AND `entry` = 2582;
-- OLD name : 激流堡食人妖獵人
-- Source : https://www.wowhead.com/wotlk/tw/npc=2583
UPDATE `creature_template_locale` SET `Name` = '激流堡獵食人妖者' WHERE `locale` = 'zhTW' AND `entry` = 2583;
-- OLD name : 激流堡士兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=2585
UPDATE `creature_template_locale` SET `Name` = '激流堡仲裁者' WHERE `locale` = 'zhTW' AND `entry` = 2585;
-- OLD name : 劣質石元素
-- Source : https://www.wowhead.com/wotlk/tw/npc=2593
UPDATE `creature_template_locale` SET `Name` = '糙石元素' WHERE `locale` = 'zhTW' AND `entry` = 2593;
-- OLD subname : Shadow Council Warlock
-- Source : https://www.wowhead.com/wotlk/tw/npc=2598
UPDATE `creature_template_locale` SET `Title` = '暗影議會術士' WHERE `locale` = 'zhTW' AND `entry` = 2598;
-- OLD name : 詠唱者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2600
UPDATE `creature_template_locale` SET `Name` = '歌唱者' WHERE `locale` = 'zhTW' AND `entry` = 2600;
-- OLD subname : 黑水強盜
-- Source : https://www.wowhead.com/wotlk/tw/npc=2610
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2610;
-- OLD name : [UNUSED] Archmage Detrae (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2617
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2617;
-- OLD name : 上古之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=2623
UPDATE `creature_template_locale` SET `Name` = '上古之魂' WHERE `locale` = 'zhTW' AND `entry` = 2623;
-- OLD name : 老鉗嘴鱷魚
-- Source : https://www.wowhead.com/wotlk/tw/npc=2635
UPDATE `creature_template_locale` SET `Name` = '老海鱷' WHERE `locale` = 'zhTW' AND `entry` = 2635;
-- OLD name : 黑水水手
-- Source : https://www.wowhead.com/wotlk/tw/npc=2636
UPDATE `creature_template_locale` SET `Name` = '黑水船工' WHERE `locale` = 'zhTW' AND `entry` = 2636;
-- OLD name : 辛迪加幽靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=2638
UPDATE `creature_template_locale` SET `Name` = '辛迪加鬼魂' WHERE `locale` = 'zhTW' AND `entry` = 2638;
-- OLD name : 邪枝精英守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=2648
UPDATE `creature_template_locale` SET `Name` = '邪枝精英衛兵' WHERE `locale` = 'zhTW' AND `entry` = 2648;
-- OLD name : Port Master Szik
-- Source : https://www.wowhead.com/wotlk/tw/npc=2662
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2662;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2662, 'zhTW','碼頭管理員斯奇克',NULL);
-- OLD name : 弗拉德·迅輪
-- Source : https://www.wowhead.com/wotlk/tw/npc=2682
UPDATE `creature_template_locale` SET `Name` = '弗拉德' WHERE `locale` = 'zhTW' AND `entry` = 2682;
-- OLD subname : 工程學供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=2683
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2683;
-- OLD subname : 工程學供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=2688
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2688;
-- OLD name : 丘陵巨人守望者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2690
UPDATE `creature_template_locale` SET `Name` = '丘陵巨人衛兵' WHERE `locale` = 'zhTW' AND `entry` = 2690;
-- OLD name : 醉鬼麥克里爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=2696
UPDATE `creature_template_locale` SET `Name` = '醉鬼馬克里爾' WHERE `locale` = 'zhTW' AND `entry` = 2696;
-- OLD subname : 製皮供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=2697
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2697;
-- OLD subname : 製皮供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=2698
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2698;
-- OLD name : 惡魔獵犬訓練師, subname : UNUSED
-- Source : https://www.wowhead.com/wotlk/tw/npc=2702
UPDATE `creature_template_locale` SET `Name` = '地獄獵犬訓練師',`Title` = 'ED' WHERE `locale` = 'zhTW' AND `entry` = 2702;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=2704
UPDATE `creature_template_locale` SET `Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 2704;
-- OLD subname : UNUSED
-- Source : https://www.wowhead.com/wotlk/tw/npc=2709
UPDATE `creature_template_locale` SET `Title` = 'ED' WHERE `locale` = 'zhTW' AND `entry` = 2709;
-- OLD name : 虛無行者訓練師, subname : UNUSED
-- Source : https://www.wowhead.com/wotlk/tw/npc=2710
UPDATE `creature_template_locale` SET `Name` = '虛空行者訓練師',`Title` = 'ED' WHERE `locale` = 'zhTW' AND `entry` = 2710;
-- OLD name : 石頭魔像
-- Source : https://www.wowhead.com/wotlk/tw/npc=2723
UPDATE `creature_template_locale` SET `Name` = '石頭傀儡' WHERE `locale` = 'zhTW' AND `entry` = 2723;
-- OLD name : 滾燙幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=2725
UPDATE `creature_template_locale` SET `Name` = '滾燙的雛龍' WHERE `locale` = 'zhTW' AND `entry` = 2725;
-- OLD name : 山脊巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2731
UPDATE `creature_template_locale` SET `Name` = '山脊巡行者' WHERE `locale` = 'zhTW' AND `entry` = 2731;
-- OLD name : 山脊巡者族王
-- Source : https://www.wowhead.com/wotlk/tw/npc=2734
UPDATE `creature_template_locale` SET `Name` = '山脊巡行者族王' WHERE `locale` = 'zhTW' AND `entry` = 2734;
-- OLD name : 影爐隧道工
-- Source : https://www.wowhead.com/wotlk/tw/npc=2739
UPDATE `creature_template_locale` SET `Name` = '暗爐隧道工' WHERE `locale` = 'zhTW' AND `entry` = 2739;
-- OLD name : 影爐暗織者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2740
UPDATE `creature_template_locale` SET `Name` = '暗爐巫師' WHERE `locale` = 'zhTW' AND `entry` = 2740;
-- OLD name : 影爐挖掘者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2741
UPDATE `creature_template_locale` SET `Name` = '暗爐挖掘者' WHERE `locale` = 'zhTW' AND `entry` = 2741;
-- OLD name : 影爐吟唱者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2742
UPDATE `creature_template_locale` SET `Name` = '暗爐吟唱者' WHERE `locale` = 'zhTW' AND `entry` = 2742;
-- OLD name : 影爐戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=2743
UPDATE `creature_template_locale` SET `Name` = '暗爐戰士' WHERE `locale` = 'zhTW' AND `entry` = 2743;
-- OLD name : 影爐指揮官
-- Source : https://www.wowhead.com/wotlk/tw/npc=2744
UPDATE `creature_template_locale` SET `Name` = '暗爐指揮官' WHERE `locale` = 'zhTW' AND `entry` = 2744;
-- OLD name : 石窟守望者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2746
UPDATE `creature_template_locale` SET `Name` = '石窟守衛' WHERE `locale` = 'zhTW' AND `entry` = 2746;
-- OLD subname : 遠古石之看守者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2748
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2748;
-- OLD name : 戰爭魔像
-- Source : https://www.wowhead.com/wotlk/tw/npc=2751
UPDATE `creature_template_locale` SET `Name` = '作戰魔像' WHERE `locale` = 'zhTW' AND `entry` = 2751;
-- OLD subname : Reuse Me
-- Source : https://www.wowhead.com/wotlk/tw/npc=2756
UPDATE `creature_template_locale` SET `Title` = 'e Me' WHERE `locale` = 'zhTW' AND `entry` = 2756;
-- OLD name : 燃燒的流放者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2760
UPDATE `creature_template_locale` SET `Name` = '烈焰流放者' WHERE `locale` = 'zhTW' AND `entry` = 2760;
-- OLD subname : 黑水強盜
-- Source : https://www.wowhead.com/wotlk/tw/npc=2766
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2766;
-- OLD subname : 黑水強盜
-- Source : https://www.wowhead.com/wotlk/tw/npc=2767
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2767;
-- OLD subname : 黑水強盜
-- Source : https://www.wowhead.com/wotlk/tw/npc=2768
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2768;
-- OLD name : 鋼膽船長, subname : 黑水強盜
-- Source : https://www.wowhead.com/wotlk/tw/npc=2769
UPDATE `creature_template_locale` SET `Name` = '斯迪加特船長',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2769;
-- OLD subname : 黑水強盜
-- Source : https://www.wowhead.com/wotlk/tw/npc=2774
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2774;
-- OLD subname : 黑水強盜
-- Source : https://www.wowhead.com/wotlk/tw/npc=2778
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2778;
-- OLD name : 麥格尼·銅鬚國王
-- Source : https://www.wowhead.com/wotlk/tw/npc=2784
UPDATE `creature_template_locale` SET `Name` = '國王麥格尼·銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 2784;
-- OLD name : 召喚的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2794
UPDATE `creature_template_locale` SET `Name` = '守護者' WHERE `locale` = 'zhTW' AND `entry` = 2794;
-- OLD subname : 魚人寶寶兌換商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=2797
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2797;
-- OLD subname : 魚人寶寶兌換商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=2801
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2801;
-- OLD name : 蘇珊·提林加斯特
-- Source : https://www.wowhead.com/wotlk/tw/npc=2802
UPDATE `creature_template_locale` SET `Name` = '蘇珊·提林哈斯特' WHERE `locale` = 'zhTW' AND `entry` = 2802;
-- OLD subname : 施法材料
-- Source : https://www.wowhead.com/wotlk/tw/npc=2805
UPDATE `creature_template_locale` SET `Title` = '卷軸和藥劑' WHERE `locale` = 'zhTW' AND `entry` = 2805;
-- OLD subname : 雜貨供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=2808
UPDATE `creature_template_locale` SET `Title` = '雜貨商' WHERE `locale` = 'zhTW' AND `entry` = 2808;
-- OLD name : 飢餓的禿鷲
-- Source : https://www.wowhead.com/wotlk/tw/npc=2829
UPDATE `creature_template_locale` SET `Name` = '饑餓的禿鷲' WHERE `locale` = 'zhTW' AND `entry` = 2829;
-- OLD name : 乾枯的禿鷲
-- Source : https://www.wowhead.com/wotlk/tw/npc=2830
UPDATE `creature_template_locale` SET `Name` = '禿鷲' WHERE `locale` = 'zhTW' AND `entry` = 2830;
-- OLD subname : 獅鷲獸管理員
-- Source : https://www.wowhead.com/wotlk/tw/npc=2833
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 2833;
-- OLD subname : 高級製弓師
-- Source : https://www.wowhead.com/wotlk/tw/npc=2839
UPDATE `creature_template_locale` SET `Title` = '高級制弓師' WHERE `locale` = 'zhTW' AND `entry` = 2839;
-- OLD name : 被奴役的猛禽德魯伊
-- Source : https://www.wowhead.com/wotlk/tw/npc=2852
UPDATE `creature_template_locale` SET `Name` = '被俘虜的猛禽德魯伊' WHERE `locale` = 'zhTW' AND `entry` = 2852;
-- OLD name : [UNUSED]亨里亞·德斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=2870
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 2870;
-- OLD name : [PH]  陸行鳥訓練師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2871
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2871;
-- OLD name : [UNUSED]瓦拉克·達本克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=2872
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 2872;
-- OLD name : [PH] 迅猛龍訓練師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2873
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2873;
-- OLD name : [PH] 馬匹訓練師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2874
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2874;
-- OLD name : [PH] 猩猩訓練師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2875
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2875;
-- OLD name : [PH] 巨鉗蟹訓練師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2877
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2877;
-- OLD subname : Monster Slayer Trainer
-- Source : https://www.wowhead.com/wotlk/tw/npc=2883
UPDATE `creature_template_locale` SET `Title` = 'ter Slayer Trainer' WHERE `locale` = 'zhTW' AND `entry` = 2883;
-- OLD name : 稜石流放者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2887
UPDATE `creature_template_locale` SET `Name` = '石棱流放者' WHERE `locale` = 'zhTW' AND `entry` = 2887;
-- OLD name : 石窟穴居怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=2889
UPDATE `creature_template_locale` SET `Name` = '石窟穴居人' WHERE `locale` = 'zhTW' AND `entry` = 2889;
-- OLD subname : Magic Skill Trainer *Temp*
-- Source : https://www.wowhead.com/wotlk/tw/npc=2896
UPDATE `creature_template_locale` SET `Title` = 'c Skill Trainer *Temp*' WHERE `locale` = 'zhTW' AND `entry` = 2896;
-- OLD subname : Toughness/Resist Trainer *Temp*
-- Source : https://www.wowhead.com/wotlk/tw/npc=2899
UPDATE `creature_template_locale` SET `Title` = 'hness/Resist Trainer *Temp*' WHERE `locale` = 'zhTW' AND `entry` = 2899;
-- OLD name : 火煙秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=2907
UPDATE `creature_template_locale` SET `Name` = '火煙秘法師' WHERE `locale` = 'zhTW' AND `entry` = 2907;
-- OLD name : 歷史學家卡尼克
-- Source : https://www.wowhead.com/wotlk/tw/npc=2916
UPDATE `creature_template_locale` SET `Name` = '史學家卡尼克' WHERE `locale` = 'zhTW' AND `entry` = 2916;
-- OLD name : 銀鬃潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2926
UPDATE `creature_template_locale` SET `Name` = '銀鬃捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 2926;
-- OLD name : 兇惡梟獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=2927
UPDATE `creature_template_locale` SET `Name` = '邪惡的梟獸' WHERE `locale` = 'zhTW' AND `entry` = 2927;
-- OLD name : 哨兵戈琳達·納希亞
-- Source : https://www.wowhead.com/wotlk/tw/npc=2930
UPDATE `creature_template_locale` SET `Name` = '哨兵戈琳達·納希恩' WHERE `locale` = 'zhTW' AND `entry` = 2930;
-- OLD name : 守衛者貝爾杜加
-- Source : https://www.wowhead.com/wotlk/tw/npc=2934
UPDATE `creature_template_locale` SET `Name` = '看守者貝爾杜加' WHERE `locale` = 'zhTW' AND `entry` = 2934;
-- OLD name : [PH] 惡魔大師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=2935
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2935;
-- OLD name : Jackson Bayne
-- Source : https://www.wowhead.com/wotlk/tw/npc=2939
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 2939;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2939, 'zhTW','傑克遜·貝恩',NULL);
-- OLD name : [UNUSED]弗蘭克·瓦爾德 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=2940
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 2940;
-- OLD name : 白鬃盜獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2951
UPDATE `creature_template_locale` SET `Name` = '白鬃偷獵者' WHERE `locale` = 'zhTW' AND `entry` = 2951;
-- OLD name : 刺背入侵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2952
UPDATE `creature_template_locale` SET `Name` = '刺背野豬人' WHERE `locale` = 'zhTW' AND `entry` = 2952;
-- OLD name : 平原陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=2955
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 2955;
-- OLD name : 成年平原陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=2956
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 2956;
-- OLD name : 老平原陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=2957
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 2957;
-- OLD name : 小鬥豬
-- Source : https://www.wowhead.com/wotlk/tw/npc=2966
UPDATE `creature_template_locale` SET `Name` = '鬥豬' WHERE `locale` = 'zhTW' AND `entry` = 2966;
-- OLD name : 多恩·平原巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=2986
UPDATE `creature_template_locale` SET `Name` = '多恩·平原行者' WHERE `locale` = 'zhTW' AND `entry` = 2986;
-- OLD name : 主母鷹風
-- Source : https://www.wowhead.com/wotlk/tw/npc=2991
UPDATE `creature_template_locale` SET `Name` = '鷹風酋長的母親' WHERE `locale` = 'zhTW' AND `entry` = 2991;
-- OLD subname : 裁縫供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3005
UPDATE `creature_template_locale` SET `Title` = '製皮供應商' WHERE `locale` = 'zhTW' AND `entry` = 3005;
-- OLD subname : 製皮供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3008
UPDATE `creature_template_locale` SET `Title` = '見習製皮師' WHERE `locale` = 'zhTW' AND `entry` = 3008;
-- OLD name : 霍高爾·雷蹄
-- Source : https://www.wowhead.com/wotlk/tw/npc=3018
UPDATE `creature_template_locale` SET `Name` = '霍高爾·雷角' WHERE `locale` = 'zhTW' AND `entry` = 3018;
-- OLD name : 麥爾斯·威爾許
-- Source : https://www.wowhead.com/wotlk/tw/npc=3044
UPDATE `creature_template_locale` SET `Name` = '麥爾斯·威爾什' WHERE `locale` = 'zhTW' AND `entry` = 3044;
-- OLD subname : 牛頭人酋長
-- Source : https://www.wowhead.com/wotlk/tw/npc=3057
UPDATE `creature_template_locale` SET `Title` = '大酋長' WHERE `locale` = 'zhTW' AND `entry` = 3057;
-- OLD subname : 戰士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3059
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3059;
-- OLD subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3060
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3060;
-- OLD subname : 獵人訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3061
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3061;
-- OLD subname : 薩滿訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3062
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3062;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3067
UPDATE `creature_template_locale` SET `Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 3067;
-- OLD name : 馬茲拉納奇
-- Source : https://www.wowhead.com/wotlk/tw/npc=3068
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 3068;
-- OLD subname : 雜貨商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3072
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3072;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3073
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3073;
-- OLD subname : 皮甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3074
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3074;
-- OLD subname : 護甲和盾牌製造商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3075
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3075;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3077
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 3077;
-- OLD name : [UNUSED] Narache Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=3082
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 3082;
-- OLD name : 榮譽守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=3083
UPDATE `creature_template_locale` SET `Name` = '榮譽衛兵' WHERE `locale` = 'zhTW' AND `entry` = 3083;
-- OLD name : 葛羅莉雅·菲米爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=3085
UPDATE `creature_template_locale` SET `Name` = '格勞瑞亞·菲米爾' WHERE `locale` = 'zhTW' AND `entry` = 3085;
-- OLD name : 格雷森·沃格爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=3086
UPDATE `creature_template_locale` SET `Name` = '格雷徹·沃格爾' WHERE `locale` = 'zhTW' AND `entry` = 3086;
-- OLD name : 富蘭克林·哈瑪
-- Source : https://www.wowhead.com/wotlk/tw/npc=3091
UPDATE `creature_template_locale` SET `Name` = '佛蘭克林·哈瑪' WHERE `locale` = 'zhTW' AND `entry` = 3091;
-- OLD name : 被俘虜的阿祖拉的僕從, subname : 特殊裁縫供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3096
UPDATE `creature_template_locale` SET `Name` = '阿祖拉的僕從',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3096;
-- OLD subname : 皮甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3097
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3097;
-- OLD name : 惡魔潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3102
UPDATE `creature_template_locale` SET `Name` = '地獄捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 3102;
-- OLD name : 響鉗龍蝦人
-- Source : https://www.wowhead.com/wotlk/tw/npc=3103
UPDATE `creature_template_locale` SET `Name` = '巨鉗龍蝦人' WHERE `locale` = 'zhTW' AND `entry` = 3103;
-- OLD name : 海浪蟹
-- Source : https://www.wowhead.com/wotlk/tw/npc=3106
UPDATE `creature_template_locale` SET `Name` = '小海浪蟹' WHERE `locale` = 'zhTW' AND `entry` = 3106;
-- OLD name : 成年海浪蟹
-- Source : https://www.wowhead.com/wotlk/tw/npc=3107
UPDATE `creature_template_locale` SET `Name` = '海浪蟹' WHERE `locale` = 'zhTW' AND `entry` = 3107;
-- OLD name : 剃鬃野豬人
-- Source : https://www.wowhead.com/wotlk/tw/npc=3111
UPDATE `creature_template_locale` SET `Name` = '鋼鬃野豬人' WHERE `locale` = 'zhTW' AND `entry` = 3111;
-- OLD name : 剃鬃斥候
-- Source : https://www.wowhead.com/wotlk/tw/npc=3112
UPDATE `creature_template_locale` SET `Name` = '鋼鬃斥候' WHERE `locale` = 'zhTW' AND `entry` = 3112;
-- OLD name : 剃鬃傳令兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=3113
UPDATE `creature_template_locale` SET `Name` = '鋼鬃傳令兵' WHERE `locale` = 'zhTW' AND `entry` = 3113;
-- OLD name : 剃鬃戰地衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=3114
UPDATE `creature_template_locale` SET `Name` = '鋼鬃戰地衛士' WHERE `locale` = 'zhTW' AND `entry` = 3114;
-- OLD name : 塵風蠻族
-- Source : https://www.wowhead.com/wotlk/tw/npc=3117
UPDATE `creature_template_locale` SET `Name` = '塵風暴徒' WHERE `locale` = 'zhTW' AND `entry` = 3117;
-- OLD name : 瑪特·強森
-- Source : https://www.wowhead.com/wotlk/tw/npc=3137
UPDATE `creature_template_locale` SET `Name` = '瑪特·約翰森' WHERE `locale` = 'zhTW' AND `entry` = 3137;
-- OLD name : 史考特·卡爾文
-- Source : https://www.wowhead.com/wotlk/tw/npc=3138
UPDATE `creature_template_locale` SET `Name` = '斯考特·卡爾文' WHERE `locale` = 'zhTW' AND `entry` = 3138;
-- OLD name : 祖雷薩·遠凝
-- Source : https://www.wowhead.com/wotlk/tw/npc=3145
UPDATE `creature_template_locale` SET `Name` = '祖雷薩' WHERE `locale` = 'zhTW' AND `entry` = 3145;
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3146
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3146;
-- OLD subname : 舵手
-- Source : https://www.wowhead.com/wotlk/tw/npc=3151
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3151;
-- OLD subname : 舵手
-- Source : https://www.wowhead.com/wotlk/tw/npc=3152
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3152;
-- OLD subname : 盜賊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3155
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3155;
-- OLD subname : 術士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3156
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3156;
-- OLD subname : 薩滿訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3157
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3157;
-- OLD subname : 雜貨商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3158
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3158;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3159
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3159;
-- OLD subname : 布甲和皮甲商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=3160
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3160;
-- OLD subname : 護甲和盾牌製造商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3161
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3161;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3163
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 3163;
-- OLD subname : 矮人武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3177
UPDATE `creature_template_locale` SET `Title` = '矮人武器商' WHERE `locale` = 'zhTW' AND `entry` = 3177;
-- OLD subname : 特殊貨物
-- Source : https://www.wowhead.com/wotlk/tw/npc=3180
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3180;
-- OLD subname : 鍊金術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3184
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3184;
-- OLD subname : 草藥學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3185
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3185;
-- OLD subname : 雜貨商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3186
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3186;
-- OLD subname : 貿易供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3187
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3187;
-- OLD name : 燃刃暴徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=3195
UPDATE `creature_template_locale` SET `Name` = '火刃暴徒' WHERE `locale` = 'zhTW' AND `entry` = 3195;
-- OLD name : 燃刃新兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=3196
UPDATE `creature_template_locale` SET `Name` = '火刃新兵' WHERE `locale` = 'zhTW' AND `entry` = 3196;
-- OLD name : 燃刃祭司
-- Source : https://www.wowhead.com/wotlk/tw/npc=3199
UPDATE `creature_template_locale` SET `Name` = '火刃祭司' WHERE `locale` = 'zhTW' AND `entry` = 3199;
-- OLD name : Eric's AAA Special Vendor
-- Source : https://www.wowhead.com/wotlk/tw/npc=3200
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 3200;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (3200, 'zhTW','艾力克的AAA特別商人',NULL);
-- OLD name : 史考特·毛瑟
-- Source : https://www.wowhead.com/wotlk/tw/npc=3201
UPDATE `creature_template_locale` SET `Name` = 'SM Test Mob' WHERE `locale` = 'zhTW' AND `entry` = 3201;
-- OLD subname : 測試
-- Source : https://www.wowhead.com/wotlk/tw/npc=3202
UPDATE `creature_template_locale` SET `Title` = 'EST' WHERE `locale` = 'zhTW' AND `entry` = 3202;
-- OLD name : 菲茲爾·暗爪
-- Source : https://www.wowhead.com/wotlk/tw/npc=3203
UPDATE `creature_template_locale` SET `Name` = '費索·暗雷' WHERE `locale` = 'zhTW' AND `entry` = 3203;
-- OLD name : 被施妖術的食人妖
-- Source : https://www.wowhead.com/wotlk/tw/npc=3207
UPDATE `creature_template_locale` SET `Name` = '妖術食人妖' WHERE `locale` = 'zhTW' AND `entry` = 3207;
-- OLD name : 勇者風羽
-- Source : https://www.wowhead.com/wotlk/tw/npc=3209
UPDATE `creature_template_locale` SET `Name` = '衛兵維薩羅·風羽' WHERE `locale` = 'zhTW' AND `entry` = 3209;
-- OLD name : 勇者傲角
-- Source : https://www.wowhead.com/wotlk/tw/npc=3210
UPDATE `creature_template_locale` SET `Name` = '衛兵奧塔克·傲角' WHERE `locale` = 'zhTW' AND `entry` = 3210;
-- OLD name : 勇者雷角
-- Source : https://www.wowhead.com/wotlk/tw/npc=3211
UPDATE `creature_template_locale` SET `Name` = '衛兵提拉穆克·雷角' WHERE `locale` = 'zhTW' AND `entry` = 3211;
-- OLD name : 勇者鐵角
-- Source : https://www.wowhead.com/wotlk/tw/npc=3212
UPDATE `creature_template_locale` SET `Name` = '衛兵科埃薩·鐵角' WHERE `locale` = 'zhTW' AND `entry` = 3212;
-- OLD name : 勇者奔狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=3213
UPDATE `creature_template_locale` SET `Name` = '衛兵沃納古·奔狼' WHERE `locale` = 'zhTW' AND `entry` = 3213;
-- OLD name : 勇者巨蹄
-- Source : https://www.wowhead.com/wotlk/tw/npc=3214
UPDATE `creature_template_locale` SET `Name` = '衛兵泰頓·巨蹄' WHERE `locale` = 'zhTW' AND `entry` = 3214;
-- OLD name : 勇者硬蹄
-- Source : https://www.wowhead.com/wotlk/tw/npc=3215
UPDATE `creature_template_locale` SET `Name` = '衛兵凱布克·硬蹄' WHERE `locale` = 'zhTW' AND `entry` = 3215;
-- OLD name : 勇者疾風
-- Source : https://www.wowhead.com/wotlk/tw/npc=3218
UPDATE `creature_template_locale` SET `Name` = '勇者迅風' WHERE `locale` = 'zhTW' AND `entry` = 3218;
-- OLD name : 勇者暗日
-- Source : https://www.wowhead.com/wotlk/tw/npc=3220
UPDATE `creature_template_locale` SET `Name` = '衛兵卡多·暗日' WHERE `locale` = 'zhTW' AND `entry` = 3220;
-- OLD name : 勇者石角
-- Source : https://www.wowhead.com/wotlk/tw/npc=3221
UPDATE `creature_template_locale` SET `Name` = '衛兵印卡斯·石角' WHERE `locale` = 'zhTW' AND `entry` = 3221;
-- OLD name : 勇者野蹄
-- Source : https://www.wowhead.com/wotlk/tw/npc=3222
UPDATE `creature_template_locale` SET `Name` = '衛兵薩拉莫尼·野蹄' WHERE `locale` = 'zhTW' AND `entry` = 3222;
-- OLD name : 勇者追雨
-- Source : https://www.wowhead.com/wotlk/tw/npc=3223
UPDATE `creature_template_locale` SET `Name` = '衛兵霍隆斯·追雨' WHERE `locale` = 'zhTW' AND `entry` = 3223;
-- OLD name : 勇者雲鬃
-- Source : https://www.wowhead.com/wotlk/tw/npc=3224
UPDATE `creature_template_locale` SET `Name` = '衛兵亞魯納·雲鬃' WHERE `locale` = 'zhTW' AND `entry` = 3224;
-- OLD name : 博識者諾拉·暴雨圖騰
-- Source : https://www.wowhead.com/wotlk/tw/npc=3233
UPDATE `creature_template_locale` SET `Name` = '博學者諾拉·暴雨圖騰' WHERE `locale` = 'zhTW' AND `entry` = 3233;
-- OLD name : 巨型平原陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=3244
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 3244;
-- OLD name : 暴躁的平原陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=3245
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 3245;
-- OLD name : 敏捷的平原陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=3246
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 3246;
-- OLD name : 雷鷹雛鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=3247
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 3247;
-- OLD name : 巨型雷鷹
-- Source : https://www.wowhead.com/wotlk/tw/npc=3249
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 3249;
-- OLD name : 日鱗鞭尾龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=3254
UPDATE `creature_template_locale` SET `Name` = '赤鱗鞭尾龍' WHERE `locale` = 'zhTW' AND `entry` = 3254;
-- OLD name : 日鱗尖嘯龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=3255
UPDATE `creature_template_locale` SET `Name` = '赤鱗尖嘯龍' WHERE `locale` = 'zhTW' AND `entry` = 3255;
-- OLD name : 日鱗鐮爪龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=3256
UPDATE `creature_template_locale` SET `Name` = '赤鱗鐮爪龍' WHERE `locale` = 'zhTW' AND `entry` = 3256;
-- OLD name : 刺背防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3259
UPDATE `creature_template_locale` SET `Name` = '刺背防禦者' WHERE `locale` = 'zhTW' AND `entry` = 3259;
-- OLD name : 刺背秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=3262
UPDATE `creature_template_locale` SET `Name` = '刺背秘法師' WHERE `locale` = 'zhTW' AND `entry` = 3262;
-- OLD name : 剃鬃獵手
-- Source : https://www.wowhead.com/wotlk/tw/npc=3265
UPDATE `creature_template_locale` SET `Name` = '鋼鬃獵手' WHERE `locale` = 'zhTW' AND `entry` = 3265;
-- OLD name : 剃鬃防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3266
UPDATE `creature_template_locale` SET `Name` = '鋼鬃防衛者' WHERE `locale` = 'zhTW' AND `entry` = 3266;
-- OLD name : 剃鬃盜掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3267
UPDATE `creature_template_locale` SET `Name` = '鋼鬃尋水者' WHERE `locale` = 'zhTW' AND `entry` = 3267;
-- OLD name : 剃鬃織棘者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3268
UPDATE `creature_template_locale` SET `Name` = '鋼鬃織棘者' WHERE `locale` = 'zhTW' AND `entry` = 3268;
-- OLD name : 剃鬃地卜師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3269
UPDATE `creature_template_locale` SET `Name` = '鋼鬃地卜師' WHERE `locale` = 'zhTW' AND `entry` = 3269;
-- OLD name : 秘術使拉佐斯諾特
-- Source : https://www.wowhead.com/wotlk/tw/npc=3270
UPDATE `creature_template_locale` SET `Name` = '秘法師拉佐斯諾特' WHERE `locale` = 'zhTW' AND `entry` = 3270;
-- OLD name : 剃鬃秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=3271
UPDATE `creature_template_locale` SET `Name` = '鋼鬃秘法師' WHERE `locale` = 'zhTW' AND `entry` = 3271;
-- OLD name : 明希納之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=3289
UPDATE `creature_template_locale` SET `Name` = '明希納的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 3289;
-- OLD name : 淤泥異常體
-- Source : https://www.wowhead.com/wotlk/tw/npc=3295
UPDATE `creature_template_locale` SET `Name` = '淤泥獸' WHERE `locale` = 'zhTW' AND `entry` = 3295;
-- OLD name : 加布雷·切斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=3298
UPDATE `creature_template_locale` SET `Name` = '加布雷·凱斯' WHERE `locale` = 'zhTW' AND `entry` = 3298;
-- OLD subname : 布甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3317
UPDATE `creature_template_locale` SET `Title` = '輕甲商' WHERE `locale` = 'zhTW' AND `entry` = 3317;
-- OLD subname : 弓箭和槍械商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3322
UPDATE `creature_template_locale` SET `Title` = '槍械和彈藥' WHERE `locale` = 'zhTW' AND `entry` = 3322;
-- OLD name : 卡德里斯·尋夢者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3344
UPDATE `creature_template_locale` SET `Name` = '卡德里斯' WHERE `locale` = 'zhTW' AND `entry` = 3344;
-- OLD name : 奧瑪克·邪擊, subname : 獵人訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3352
UPDATE `creature_template_locale` SET `Name` = '奧瑪克',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3352;
-- OLD name : 奧古納羅·狼行者, subname : 馴狼者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3362
UPDATE `creature_template_locale` SET `Name` = '奧古納羅',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3362;
-- OLD name : 巴爾丹步槍兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=3377
UPDATE `creature_template_locale` SET `Name` = '巴爾丹火槍手' WHERE `locale` = 'zhTW' AND `entry` = 3377;
-- OLD name : 燃刃衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=3379
UPDATE `creature_template_locale` SET `Name` = '火刃衛士' WHERE `locale` = 'zhTW' AND `entry` = 3379;
-- OLD name : 燃刃侍僧
-- Source : https://www.wowhead.com/wotlk/tw/npc=3380
UPDATE `creature_template_locale` SET `Name` = '火刃侍僧' WHERE `locale` = 'zhTW' AND `entry` = 3380;
-- OLD name : 南海盜匪
-- Source : https://www.wowhead.com/wotlk/tw/npc=3381
UPDATE `creature_template_locale` SET `Name` = '南海歹徒' WHERE `locale` = 'zhTW' AND `entry` = 3381;
-- OLD name : 南海砲手
-- Source : https://www.wowhead.com/wotlk/tw/npc=3382
UPDATE `creature_template_locale` SET `Name` = '南海砲兵' WHERE `locale` = 'zhTW' AND `entry` = 3382;
-- OLD subname : 施法材料和毒藥
-- Source : https://www.wowhead.com/wotlk/tw/npc=3405
UPDATE `creature_template_locale` SET `Title` = '草藥學供應商' WHERE `locale` = 'zhTW' AND `entry` = 3405;
-- OLD name : 草原雌獅
-- Source : https://www.wowhead.com/wotlk/tw/npc=3415
UPDATE `creature_template_locale` SET `Name` = '雌性草原獅' WHERE `locale` = 'zhTW' AND `entry` = 3415;
-- OLD name : 活焰元素
-- Source : https://www.wowhead.com/wotlk/tw/npc=3417
UPDATE `creature_template_locale` SET `Name` = '活火' WHERE `locale` = 'zhTW' AND `entry` = 3417;
-- OLD name : [UNUSED]先祖看守者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=3420
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 3420;
-- OLD name : 被流放的費格雷(Old)
-- Source : https://www.wowhead.com/wotlk/tw/npc=3421
UPDATE `creature_template_locale` SET `Name` = '被流放的費格雷' WHERE `locale` = 'zhTW' AND `entry` = 3421;
-- OLD name : 雷鷹碎雲者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3424
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 3424;
-- OLD name : [UNUSED] Kendur (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=3427
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 3427;
-- OLD name : [UNUSED]先祖賢者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=3440
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 3440;
-- OLD subname : 特約承包商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3442
UPDATE `creature_template_locale` SET `Title` = '技工協會' WHERE `locale` = 'zhTW' AND `entry` = 3442;
-- OLD name : 迪菲亞鸚鵡夥伴
-- Source : https://www.wowhead.com/wotlk/tw/npc=3450
UPDATE `creature_template_locale` SET `Name` = '迪菲亞鸚鵡' WHERE `locale` = 'zhTW' AND `entry` = 3450;
-- OLD name : 砲手斯密瑟
-- Source : https://www.wowhead.com/wotlk/tw/npc=3454
UPDATE `creature_template_locale` SET `Name` = '砲兵斯密瑟' WHERE `locale` = 'zhTW' AND `entry` = 3454;
-- OLD name : 砲手維桑恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=3455
UPDATE `creature_template_locale` SET `Name` = '炮兵維桑恩' WHERE `locale` = 'zhTW' AND `entry` = 3455;
-- OLD name : 剃鬃探路者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3456
UPDATE `creature_template_locale` SET `Name` = '鋼鬃探路者' WHERE `locale` = 'zhTW' AND `entry` = 3456;
-- OLD name : 剃鬃潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3457
UPDATE `creature_template_locale` SET `Name` = '鋼鬃潛獵者' WHERE `locale` = 'zhTW' AND `entry` = 3457;
-- OLD name : 剃鬃先知
-- Source : https://www.wowhead.com/wotlk/tw/npc=3458
UPDATE `creature_template_locale` SET `Name` = '鋼鬃先知' WHERE `locale` = 'zhTW' AND `entry` = 3458;
-- OLD name : 剃鬃戰狂
-- Source : https://www.wowhead.com/wotlk/tw/npc=3459
UPDATE `creature_template_locale` SET `Name` = '鋼鬃戰爭狂熱者' WHERE `locale` = 'zhTW' AND `entry` = 3459;
-- OLD name : 朗紹爾男爵
-- Source : https://www.wowhead.com/wotlk/tw/npc=3467
UPDATE `creature_template_locale` SET `Name` = '巴隆·朗紹爾' WHERE `locale` = 'zhTW' AND `entry` = 3467;
-- OLD name : 技工斯尼格斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=3471
UPDATE `creature_template_locale` SET `Name` = '工匠斯尼格斯' WHERE `locale` = 'zhTW' AND `entry` = 3471;
-- OLD name : 瓦希塔帕恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=3472
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 3472;
-- OLD subname : 皮貨和鎖甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3483
UPDATE `creature_template_locale` SET `Title` = '皮貨和護甲商' WHERE `locale` = 'zhTW' AND `entry` = 3483;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3491
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 3491;
-- OLD name : 部落守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=3501
UPDATE `creature_template_locale` SET `Name` = '部落衛兵' WHERE `locale` = 'zhTW' AND `entry` = 3501;
-- OLD name : 異種保衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3503
UPDATE `creature_template_locale` SET `Name` = '異種護衛者' WHERE `locale` = 'zhTW' AND `entry` = 3503;
-- OLD name : 史蒂芬
-- Source : https://www.wowhead.com/wotlk/tw/npc=3511
UPDATE `creature_template_locale` SET `Name` = '斯蒂文' WHERE `locale` = 'zhTW' AND `entry` = 3511;
-- OLD name : 哨兵阿瑞尼亞·裂雲
-- Source : https://www.wowhead.com/wotlk/tw/npc=3519
UPDATE `creature_template_locale` SET `Name` = '哨兵阿瑞尼亞·碎雲' WHERE `locale` = 'zhTW' AND `entry` = 3519;
-- OLD subname : 見習衣商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3522
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3522;
-- OLD subname : 裁縫訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3523
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3523;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3534
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3534;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3539
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 3539;
-- OLD subname : 寵物訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3545
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3545;
-- OLD name : 塞巴斯汀·米洛奇
-- Source : https://www.wowhead.com/wotlk/tw/npc=3553
UPDATE `creature_template_locale` SET `Name` = '塞巴斯蒂安·米洛奇' WHERE `locale` = 'zhTW' AND `entry` = 3553;
-- OLD name : 臨時毒藥商人矮人, subname : 毒藥供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3559
UPDATE `creature_template_locale` SET `Name` = 'Temp毒藥商人矮人',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3559;
-- OLD name : 臨時施法材料商矮人, subname : 施法材料
-- Source : https://www.wowhead.com/wotlk/tw/npc=3564
UPDATE `creature_template_locale` SET `Name` = 'Temp試劑商人矮人',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3564;
-- OLD name : 騎乘用蝙蝠
-- Source : https://www.wowhead.com/wotlk/tw/npc=3574
UPDATE `creature_template_locale` SET `Name` = '蝙蝠' WHERE `locale` = 'zhTW' AND `entry` = 3574;
-- OLD subname : 蝙蝠管理員
-- Source : https://www.wowhead.com/wotlk/tw/npc=3575
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3575;
-- OLD name : 安伯米爾釀酒師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3577
UPDATE `creature_template_locale` SET `Name` = '達拉然釀酒師' WHERE `locale` = 'zhTW' AND `entry` = 3577;
-- OLD name : 安伯米爾礦工
-- Source : https://www.wowhead.com/wotlk/tw/npc=3578
UPDATE `creature_template_locale` SET `Name` = '達拉然礦工' WHERE `locale` = 'zhTW' AND `entry` = 3578;
-- OLD name : 下水道猛獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=3581
UPDATE `creature_template_locale` SET `Name` = '下水道生物' WHERE `locale` = 'zhTW' AND `entry` = 3581;
-- OLD name : 礦工強森
-- Source : https://www.wowhead.com/wotlk/tw/npc=3586
UPDATE `creature_template_locale` SET `Name` = '礦工約翰森' WHERE `locale` = 'zhTW' AND `entry` = 3586;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3588
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 3588;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3609
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 3609;
-- OLD name : 羅德隆居民
-- Source : https://www.wowhead.com/wotlk/tw/npc=3617
UPDATE `creature_template_locale` SET `Name` = '羅德隆平民' WHERE `locale` = 'zhTW' AND `entry` = 3617;
-- OLD name : 史蒂芬·洛漢
-- Source : https://www.wowhead.com/wotlk/tw/npc=3628
UPDATE `creature_template_locale` SET `Name` = '史蒂文·洛漢' WHERE `locale` = 'zhTW' AND `entry` = 3628;
-- OLD name : 變異曲蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=3630
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 3630;
-- OLD name : 變異刺鞭蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=3631
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 3631;
-- OLD name : 變異蠕行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3632
UPDATE `creature_template_locale` SET `Name` = '變異爬行者' WHERE `locale` = 'zhTW' AND `entry` = 3632;
-- OLD name : 變異潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3634
UPDATE `creature_template_locale` SET `Name` = '變異捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 3634;
-- OLD name : 變異劫毀者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3636
UPDATE `creature_template_locale` SET `Name` = '變異破壞者' WHERE `locale` = 'zhTW' AND `entry` = 3636;
-- OLD name : [UNUSED] Kolkar Observer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=3651
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 3651;
-- OLD name : 『吞噬者』穆坦努斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=3654
UPDATE `creature_template_locale` SET `Name` = '吞噬者穆坦努斯' WHERE `locale` = 'zhTW' AND `entry` = 3654;
-- OLD name : 受折磨的精靈貴族靈魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=3668
UPDATE `creature_template_locale` SET `Name` = '被折磨的貴族精靈的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 3668;
-- OLD name : 考布萊恩領主, subname : 毒牙之王
-- Source : https://www.wowhead.com/wotlk/tw/npc=3669
UPDATE `creature_template_locale` SET `Name` = '考布萊恩',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3669;
-- OLD name : 皮薩斯領主, subname : 毒牙之王
-- Source : https://www.wowhead.com/wotlk/tw/npc=3670
UPDATE `creature_template_locale` SET `Name` = '皮薩斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3670;
-- OLD name : 安娜科德拉女士, subname : 毒牙之王
-- Source : https://www.wowhead.com/wotlk/tw/npc=3671
UPDATE `creature_template_locale` SET `Name` = '安娜科德拉',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3671;
-- OLD name : 瑟芬迪斯領主, subname : 毒牙之王
-- Source : https://www.wowhead.com/wotlk/tw/npc=3673
UPDATE `creature_template_locale` SET `Name` = '瑟芬迪斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3673;
-- OLD name : 繆幽
-- Source : https://www.wowhead.com/wotlk/tw/npc=3678
UPDATE `creature_template_locale` SET `Name` = '納拉雷克斯的信徒' WHERE `locale` = 'zhTW' AND `entry` = 3678;
-- OLD subname : 武器鍛造和護甲
-- Source : https://www.wowhead.com/wotlk/tw/npc=3682
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3682;
-- OLD subname : 時髦服飾
-- Source : https://www.wowhead.com/wotlk/tw/npc=3683
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3683;
-- OLD subname : 皮甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3684
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3684;
-- OLD name : 卡爾·雷詠
-- Source : https://www.wowhead.com/wotlk/tw/npc=3690
UPDATE `creature_template_locale` SET `Name` = '卡爾·雷歌' WHERE `locale` = 'zhTW' AND `entry` = 3690;
-- OLD name : Kyln Longclaw
-- Source : https://www.wowhead.com/wotlk/tw/npc=3697
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 3697;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (3697, 'zhTW','凱林·長爪',NULL);
-- OLD name : 艾蘭妲莉安·夜歌
-- Source : https://www.wowhead.com/wotlk/tw/npc=3702
UPDATE `creature_template_locale` SET `Name` = '奧蘭達利亞·夜歌' WHERE `locale` = 'zhTW' AND `entry` = 3702;
-- OLD subname : 牧師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3707
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3707;
-- OLD name : 暗灘教徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=3725
UPDATE `creature_template_locale` SET `Name` = '暗灘祭司' WHERE `locale` = 'zhTW' AND `entry` = 3725;
-- OLD name : 亡靈搜尋者[UNUSED]
-- Source : https://www.wowhead.com/wotlk/tw/npc=3732
UPDATE `creature_template_locale` SET `Name` = '亡靈搜尋者' WHERE `locale` = 'zhTW' AND `entry` = 3732;
-- OLD name : 獸人監督者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3734
UPDATE `creature_template_locale` SET `Name` = '亡靈暴徒' WHERE `locale` = 'zhTW' AND `entry` = 3734;
-- OLD name : 黑暗殺戮者摩迪沙爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=3736
UPDATE `creature_template_locale` SET `Name` = '屠殺者摩迪沙爾' WHERE `locale` = 'zhTW' AND `entry` = 3736;
-- OLD name : 次級惡魔守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=3772
UPDATE `creature_template_locale` SET `Name` = '燃燒軍團士兵' WHERE `locale` = 'zhTW' AND `entry` = 3772;
-- OLD name : 艾麗沙, subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3777
UPDATE `creature_template_locale` SET `Name` = '艾麗薩',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3777;
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3778
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3778;
-- OLD name : 焦黑跛行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3780
UPDATE `creature_template_locale` SET `Name` = '食苔沼澤獸' WHERE `locale` = 'zhTW' AND `entry` = 3780;
-- OLD subname : NEED MODEL
-- Source : https://www.wowhead.com/wotlk/tw/npc=3831
UPDATE `creature_template_locale` SET `Title` = 'MODEL' WHERE `locale` = 'zhTW' AND `entry` = 3831;
-- OLD name : 騎乘用角鷹獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=3837
UPDATE `creature_template_locale` SET `Name` = '角鷹獸' WHERE `locale` = 'zhTW' AND `entry` = 3837;
-- OLD name : 虛無鞭笞者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3839
UPDATE `creature_template_locale` SET `Name` = '虛空鞭笞者' WHERE `locale` = 'zhTW' AND `entry` = 3839;
-- OLD name : 泰狄拉·月羽
-- Source : https://www.wowhead.com/wotlk/tw/npc=3841
UPDATE `creature_template_locale` SET `Name` = '凱萊斯·月羽' WHERE `locale` = 'zhTW' AND `entry` = 3841;
-- OLD name : 奧蘭迪爾·闊葉
-- Source : https://www.wowhead.com/wotlk/tw/npc=3847
UPDATE `creature_template_locale` SET `Name` = '奧雷迪爾·闊葉' WHERE `locale` = 'zhTW' AND `entry` = 3847;
-- OLD name : 巫士阿克魯比
-- Source : https://www.wowhead.com/wotlk/tw/npc=3850
UPDATE `creature_template_locale` SET `Name` = '巫師阿克魯比' WHERE `locale` = 'zhTW' AND `entry` = 3850;
-- OLD name : [UNUSED]影牙血嘯者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3852
UPDATE `creature_template_locale` SET `Name` = '影牙血嘯者' WHERE `locale` = 'zhTW' AND `entry` = 3852;
-- OLD name : 影牙狼人守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=3854
UPDATE `creature_template_locale` SET `Name` = '影牙狼人衛兵' WHERE `locale` = 'zhTW' AND `entry` = 3854;
-- OLD name : 影牙黑暗之魂狼人
-- Source : https://www.wowhead.com/wotlk/tw/npc=3855
UPDATE `creature_template_locale` SET `Name` = '影牙魔魂狼人' WHERE `locale` = 'zhTW' AND `entry` = 3855;
-- OLD name : [UNUSED]影牙墮落者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3860
UPDATE `creature_template_locale` SET `Name` = '影牙墮落者' WHERE `locale` = 'zhTW' AND `entry` = 3860;
-- OLD name : 荒狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=3861
UPDATE `creature_template_locale` SET `Name` = '灰色座狼' WHERE `locale` = 'zhTW' AND `entry` = 3861;
-- OLD name : 魔化戰馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=3864
UPDATE `creature_template_locale` SET `Name` = '地獄戰馬' WHERE `locale` = 'zhTW' AND `entry` = 3864;
-- OLD name : 暗影戰騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=3865
UPDATE `creature_template_locale` SET `Name` = '暗影戰馬' WHERE `locale` = 'zhTW' AND `entry` = 3865;
-- OLD name : 痛苦的軍官
-- Source : https://www.wowhead.com/wotlk/tw/npc=3873
UPDATE `creature_template_locale` SET `Name` = '痛苦的文官' WHERE `locale` = 'zhTW' AND `entry` = 3873;
-- OLD name : [UNUSED]受傷的靈魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=3876
UPDATE `creature_template_locale` SET `Name` = '受傷的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 3876;
-- OLD name : 哀嚎的衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=3877
UPDATE `creature_template_locale` SET `Name` = '哀嚎的衛兵' WHERE `locale` = 'zhTW' AND `entry` = 3877;
-- OLD subname : 屠夫
-- Source : https://www.wowhead.com/wotlk/tw/npc=3882
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3882;
-- OLD name : 穆恩丹·日穀, subname : 麵包師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3883
UPDATE `creature_template_locale` SET `Name` = '穆恩丹·秋谷',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3883;
-- OLD name : 『屠夫』銳爪
-- Source : https://www.wowhead.com/wotlk/tw/npc=3886
UPDATE `creature_template_locale` SET `Name` = '屠夫拉佐克勞' WHERE `locale` = 'zhTW' AND `entry` = 3886;
-- OLD name : 布萊克歐·死亡使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3890
UPDATE `creature_template_locale` SET `Name` = '布萊克歐·死亡召喚者' WHERE `locale` = 'zhTW' AND `entry` = 3890;
-- OLD name : 蕾拉·白月
-- Source : https://www.wowhead.com/wotlk/tw/npc=3892
UPDATE `creature_template_locale` SET `Name` = '蕾拉·懷特姆恩' WHERE `locale` = 'zhTW' AND `entry` = 3892;
-- OLD name : 皮爾圖拉斯·白月
-- Source : https://www.wowhead.com/wotlk/tw/npc=3894
UPDATE `creature_template_locale` SET `Name` = '皮爾圖拉斯·懷特姆恩' WHERE `locale` = 'zhTW' AND `entry` = 3894;
-- OLD subname : 舵手
-- Source : https://www.wowhead.com/wotlk/tw/npc=3895
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3895;
-- OLD subname : 舵手
-- Source : https://www.wowhead.com/wotlk/tw/npc=3896
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3896;
-- OLD name : 庫羅格
-- Source : https://www.wowhead.com/wotlk/tw/npc=3897
UPDATE `creature_template_locale` SET `Name` = '克羅格' WHERE `locale` = 'zhTW' AND `entry` = 3897;
-- OLD name : 『折磨者』奧利加爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=3898
UPDATE `creature_template_locale` SET `Name` = '折磨者奧利加爾' WHERE `locale` = 'zhTW' AND `entry` = 3898;
-- OLD subname : 牢房守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=3914
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3914;
-- OLD name : 夏爾德琳
-- Source : https://www.wowhead.com/wotlk/tw/npc=3916
UPDATE `creature_template_locale` SET `Name` = '莎爾蒂恩' WHERE `locale` = 'zhTW' AND `entry` = 3916;
-- OLD subname : 屠夫
-- Source : https://www.wowhead.com/wotlk/tw/npc=3933
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3933;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=3934
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 3934;
-- OLD subname : 基拉的守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=3938
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3938;
-- OLD name : 剃鬃狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=3939
UPDATE `creature_template_locale` SET `Name` = '鋼鬃狼' WHERE `locale` = 'zhTW' AND `entry` = 3939;
-- OLD name : 坦尼爾·暗木
-- Source : https://www.wowhead.com/wotlk/tw/npc=3940
UPDATE `creature_template_locale` SET `Name` = '坦尼爾·黑木' WHERE `locale` = 'zhTW' AND `entry` = 3940;
-- OLD name : 小型水元素守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3950
UPDATE `creature_template_locale` SET `Name` = '小型水元素護衛' WHERE `locale` = 'zhTW' AND `entry` = 3950;
-- OLD name : 詹奈·羽風, subname : 烹飪供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3957
UPDATE `creature_template_locale` SET `Name` = '詹奈·輕羽微風',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3957;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=3966
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 3966;
-- OLD subname : 毒藥商
-- Source : https://www.wowhead.com/wotlk/tw/npc=3969
UPDATE `creature_template_locale` SET `Title` = '工具和補給品' WHERE `locale` = 'zhTW' AND `entry` = 3969;
-- OLD name : 高階審判官懷特邁恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=3977
UPDATE `creature_template_locale` SET `Name` = '高等審判官懷特邁恩' WHERE `locale` = 'zhTW' AND `entry` = 3977;
-- OLD name : 風險投資公司頑抗者
-- Source : https://www.wowhead.com/wotlk/tw/npc=3992
UPDATE `creature_template_locale` SET `Name` = '風險投資公司工程師' WHERE `locale` = 'zhTW' AND `entry` = 3992;
-- OLD name : 守衛者奧巴格姆
-- Source : https://www.wowhead.com/wotlk/tw/npc=3994
UPDATE `creature_template_locale` SET `Name` = '守護者奧巴格姆' WHERE `locale` = 'zhTW' AND `entry` = 3994;
-- OLD name : 風剪惡黨
-- Source : https://www.wowhead.com/wotlk/tw/npc=3998
UPDATE `creature_template_locale` SET `Name` = '風剪歹徒' WHERE `locale` = 'zhTW' AND `entry` = 3998;
-- OLD name : 風剪主宰
-- Source : https://www.wowhead.com/wotlk/tw/npc=4004
UPDATE `creature_template_locale` SET `Name` = '風剪霸主' WHERE `locale` = 'zhTW' AND `entry` = 4004;
-- OLD name : 盛怒的峭壁雷鳴蜥蜴
-- Source : https://www.wowhead.com/wotlk/tw/npc=4009
UPDATE `creature_template_locale` SET `Name` = '狂怒的峭壁雷鳴蜥蜴' WHERE `locale` = 'zhTW' AND `entry` = 4009;
-- OLD name : 液行怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=4020
UPDATE `creature_template_locale` SET `Name` = '腐蝕獸' WHERE `locale` = 'zhTW' AND `entry` = 4020;
-- OLD name : 腐化的液行怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=4021
UPDATE `creature_template_locale` SET `Name` = '腐蝕性的腐蝕獸' WHERE `locale` = 'zhTW' AND `entry` = 4021;
-- OLD name : 狂怒的古樹
-- Source : https://www.wowhead.com/wotlk/tw/npc=4030
UPDATE `creature_template_locale` SET `Name` = '狂怒的樹人' WHERE `locale` = 'zhTW' AND `entry` = 4030;
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4039
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4039;
-- OLD name : 洞穴潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4040
UPDATE `creature_template_locale` SET `Name` = '洞穴捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 4040;
-- OLD name : JEFF CHOW TEST, subname : No Clothes NPC
-- Source : https://www.wowhead.com/wotlk/tw/npc=4045
UPDATE `creature_template_locale` SET `Name` = NULL,`Title` = 'lothes NPC' WHERE `locale` = 'zhTW' AND `entry` = 4045;
-- OLD name : 法芬德爾·道衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=4048
UPDATE `creature_template_locale` SET `Name` = '法芬德爾' WHERE `locale` = 'zhTW' AND `entry` = 4048;
-- OLD name : 暗色守衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4056
UPDATE `creature_template_locale` SET `Name` = '暗色守護者' WHERE `locale` = 'zhTW' AND `entry` = 4056;
-- OLD name : 黑石哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=4065
UPDATE `creature_template_locale` SET `Name` = '黑石哨兵' WHERE `locale` = 'zhTW' AND `entry` = 4065;
-- OLD subname : 護甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4085
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4085;
-- OLD subname : 風險投資公司商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=4086
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4086;
-- OLD name : Galak Wrangler
-- Source : https://www.wowhead.com/wotlk/tw/npc=4093
UPDATE `creature_template_locale` SET `Name` = '加拉克爭吵者' WHERE `locale` = 'zhTW' AND `entry` = 4093;
-- OLD name : Galak Scout
-- Source : https://www.wowhead.com/wotlk/tw/npc=4094
UPDATE `creature_template_locale` SET `Name` = '加拉克斥候' WHERE `locale` = 'zhTW' AND `entry` = 4094;
-- OLD name : Galak Mauler
-- Source : https://www.wowhead.com/wotlk/tw/npc=4095
UPDATE `creature_template_locale` SET `Name` = '加拉克虐待者' WHERE `locale` = 'zhTW' AND `entry` = 4095;
-- OLD name : Galak Windchaser
-- Source : https://www.wowhead.com/wotlk/tw/npc=4096
UPDATE `creature_template_locale` SET `Name` = '加拉克逐風者' WHERE `locale` = 'zhTW' AND `entry` = 4096;
-- OLD name : Galak Stormer
-- Source : https://www.wowhead.com/wotlk/tw/npc=4097
UPDATE `creature_template_locale` SET `Name` = '加拉克狂怒者' WHERE `locale` = 'zhTW' AND `entry` = 4097;
-- OLD name : Galak Pack Runner
-- Source : https://www.wowhead.com/wotlk/tw/npc=4098
UPDATE `creature_template_locale` SET `Name` = '加拉克馴犬者' WHERE `locale` = 'zhTW' AND `entry` = 4098;
-- OLD name : Galak Marauder
-- Source : https://www.wowhead.com/wotlk/tw/npc=4099
UPDATE `creature_template_locale` SET `Name` = '加拉克掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 4099;
-- OLD name : 風巢飛龍族王
-- Source : https://www.wowhead.com/wotlk/tw/npc=4110
UPDATE `creature_template_locale` SET `Name` = '雌性風巢飛龍' WHERE `locale` = 'zhTW' AND `entry` = 4110;
-- OLD subname : <Needs Scale>
-- Source : https://www.wowhead.com/wotlk/tw/npc=4115
UPDATE `creature_template_locale` SET `Title` = 'ds Scale>' WHERE `locale` = 'zhTW' AND `entry` = 4115;
-- OLD name : 砂齒勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=4116
UPDATE `creature_template_locale` SET `Name` = '砂齒勘探員' WHERE `locale` = 'zhTW' AND `entry` = 4116;
-- OLD name : 風蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=4117
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4117;
-- OLD name : 毒性風蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=4118
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4118;
-- OLD name : 老風蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=4119
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4119;
-- OLD name : 亂齒土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4127
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4127;
-- OLD name : 亂齒潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4128
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4128;
-- OLD name : 亂齒狂吠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4129
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4129;
-- OLD name : Silithid Searcher
-- Source : https://www.wowhead.com/wotlk/tw/npc=4130
UPDATE `creature_template_locale` SET `Name` = '異種搜尋者' WHERE `locale` = 'zhTW' AND `entry` = 4130;
-- OLD name : Silithid Invader
-- Source : https://www.wowhead.com/wotlk/tw/npc=4131
UPDATE `creature_template_locale` SET `Name` = '異種侵略者' WHERE `locale` = 'zhTW' AND `entry` = 4131;
-- OLD name : 克爾基斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=4132
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4132;
-- OLD name : Silithid Hive Drone
-- Source : https://www.wowhead.com/wotlk/tw/npc=4133
UPDATE `creature_template_locale` SET `Name` = '異種築巢蠍' WHERE `locale` = 'zhTW' AND `entry` = 4133;
-- OLD name : 吉恩拉·夜行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4138
UPDATE `creature_template_locale` SET `Name` = '吉恩拉' WHERE `locale` = 'zhTW' AND `entry` = 4138;
-- OLD name : 恐蠍劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4140
UPDATE `creature_template_locale` SET `Name` = '恐蠍搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 4140;
-- OLD name : Sparkleshell Tortoise
-- Source : https://www.wowhead.com/wotlk/tw/npc=4142
UPDATE `creature_template_locale` SET `Name` = '鹽殼龜' WHERE `locale` = 'zhTW' AND `entry` = 4142;
-- OLD name : Sparkleshell Snapper
-- Source : https://www.wowhead.com/wotlk/tw/npc=4143
UPDATE `creature_template_locale` SET `Name` = '鹽殼鉗嘴龜' WHERE `locale` = 'zhTW' AND `entry` = 4143;
-- OLD name : Sparkleshell Borer
-- Source : https://www.wowhead.com/wotlk/tw/npc=4144
UPDATE `creature_template_locale` SET `Name` = '鹽殼掘地龜' WHERE `locale` = 'zhTW' AND `entry` = 4144;
-- OLD name : 蹬羚
-- Source : https://www.wowhead.com/wotlk/tw/npc=4166
UPDATE `creature_template_locale` SET `Name` = '瞪羚' WHERE `locale` = 'zhTW' AND `entry` = 4166;
-- OLD name : Siannai
-- Source : https://www.wowhead.com/wotlk/tw/npc=4174
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 4174;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4174, 'zhTW','希亞奈恩',NULL);
-- OLD subname : 布甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4176
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4176;
-- OLD subname : 鎖甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4178
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4178;
-- OLD subname : 盾牌商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4179
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4179;
-- OLD name : 瑪芙拉琳, subname : 皮甲與製皮供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4186
UPDATE `creature_template_locale` SET `Name` = '馬弗拉林',`Title` = '製皮供應商' WHERE `locale` = 'zhTW' AND `entry` = 4186;
-- OLD name : 哈隆·棘衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=4187
UPDATE `creature_template_locale` SET `Name` = '哈隆·棘甲' WHERE `locale` = 'zhTW' AND `entry` = 4187;
-- OLD name : 艾琳迪雅
-- Source : https://www.wowhead.com/wotlk/tw/npc=4191
UPDATE `creature_template_locale` SET `Name` = '奧林迪雅' WHERE `locale` = 'zhTW' AND `entry` = 4191;
-- OLD name : Talegon
-- Source : https://www.wowhead.com/wotlk/tw/npc=4224
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 4224;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4224, 'zhTW','塔雷貢',NULL);
-- OLD subname : 皮甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4237
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4237;
-- OLD subname : 皮甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4239
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4239;
-- OLD subname : 瓦耶爾的寵物
-- Source : https://www.wowhead.com/wotlk/tw/npc=4245
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4245;
-- OLD subname : 凱珊迪亞的寵物
-- Source : https://www.wowhead.com/wotlk/tw/npc=4246
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4246;
-- OLD subname : 塔拉爾的寵物
-- Source : https://www.wowhead.com/wotlk/tw/npc=4247
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4247;
-- OLD name : 雜毛土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4248
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4248;
-- OLD name : 雜毛嚎叫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4249
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4249;
-- OLD name : 加拉克獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=4250
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4250;
-- OLD name : 熊形態(牛頭人德魯伊)
-- Source : https://www.wowhead.com/wotlk/tw/npc=4261
UPDATE `creature_template_locale` SET `Name` = '熊形態 (牛頭人德魯伊)' WHERE `locale` = 'zhTW' AND `entry` = 4261;
-- OLD name : 深苔蜘蛛族母
-- Source : https://www.wowhead.com/wotlk/tw/npc=4264
UPDATE `creature_template_locale` SET `Name` = '深苔雌蜘蛛' WHERE `locale` = 'zhTW' AND `entry` = 4264;
-- OLD name : 灰狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4268
UPDATE `creature_template_locale` SET `Name` = '騎乘用狼（灰色）' WHERE `locale` = 'zhTW' AND `entry` = 4268;
-- OLD name : 栗色馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=4269
UPDATE `creature_template_locale` SET `Name` = '騎乘用馬（栗色）' WHERE `locale` = 'zhTW' AND `entry` = 4269;
-- OLD name : 紅狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4270
UPDATE `creature_template_locale` SET `Name` = '騎乘用狼（紅色）' WHERE `locale` = 'zhTW' AND `entry` = 4270;
-- OLD name : 恐狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4271
UPDATE `creature_template_locale` SET `Name` = '騎乘用狼（暗灰色）' WHERE `locale` = 'zhTW' AND `entry` = 4271;
-- OLD name : 棕狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4272
UPDATE `creature_template_locale` SET `Name` = '騎乘用狼（暗棕色）' WHERE `locale` = 'zhTW' AND `entry` = 4272;
-- OLD name : 守衛者奧達努斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=4273
UPDATE `creature_template_locale` SET `Name` = '守護者奧達努斯' WHERE `locale` = 'zhTW' AND `entry` = 4273;
-- OLD name : 『吞噬者』芬魯斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=4274
UPDATE `creature_template_locale` SET `Name` = '吞噬者芬魯斯' WHERE `locale` = 'zhTW' AND `entry` = 4274;
-- OLD subname : 風險投資公司
-- Source : https://www.wowhead.com/wotlk/tw/npc=4276
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4276;
-- OLD name : 『盲眼守衛』奧杜
-- Source : https://www.wowhead.com/wotlk/tw/npc=4279
UPDATE `creature_template_locale` SET `Name` = '盲眼守衛奧杜' WHERE `locale` = 'zhTW' AND `entry` = 4279;
-- OLD name : 血色侍徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=4285
UPDATE `creature_template_locale` SET `Name` = '血色追隨者' WHERE `locale` = 'zhTW' AND `entry` = 4285;
-- OLD name : 血色衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=4290
UPDATE `creature_template_locale` SET `Name` = '血色衛兵' WHERE `locale` = 'zhTW' AND `entry` = 4290;
-- OLD name : 血色院牧
-- Source : https://www.wowhead.com/wotlk/tw/npc=4299
UPDATE `creature_template_locale` SET `Name` = '血色牧師' WHERE `locale` = 'zhTW' AND `entry` = 4299;
-- OLD name : 血色捕獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=4304
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4304;
-- OLD name : [UNUSED] [PH] Ambassador Saylaton Gravehoof (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=4313
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 4313;
-- OLD subname : 雙足飛龍管理員
-- Source : https://www.wowhead.com/wotlk/tw/npc=4314
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4314;
-- OLD name : [UNUSED]加斯林·暗蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=4315
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 4315;
-- OLD name : 科卡爾獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=4316
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4316;
-- OLD name : Delyka (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=4318
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 4318;
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4322
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4322;
-- OLD name : 灼熱雛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=4323
UPDATE `creature_template_locale` SET `Name` = '灼熱幼龍' WHERE `locale` = 'zhTW' AND `entry` = 4323;
-- OLD subname : 靈魂醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4340
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4340;
-- OLD name : 毒素撕掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4346
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4346;
-- OLD name : 毒性劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4347
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4347;
-- OLD name : 毒性切割者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4348
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4348;
-- OLD name : 沼鰭污水魚人
-- Source : https://www.wowhead.com/wotlk/tw/npc=4358
UPDATE `creature_template_locale` SET `Name` = '黑鰭污水魚人' WHERE `locale` = 'zhTW' AND `entry` = 4358;
-- OLD name : 沼鰭戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=4360
UPDATE `creature_template_locale` SET `Name` = '黑鰭戰士' WHERE `locale` = 'zhTW' AND `entry` = 4360;
-- OLD name : 斯塔莎茲部屬
-- Source : https://www.wowhead.com/wotlk/tw/npc=4368
UPDATE `creature_template_locale` SET `Name` = '斯塔莎茲侍從' WHERE `locale` = 'zhTW' AND `entry` = 4368;
-- OLD name : 枯藤蠕行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4382
UPDATE `creature_template_locale` SET `Name` = '枯藤爬行者' WHERE `locale` = 'zhTW' AND `entry` = 4382;
-- OLD name : 猛怒沼澤軟泥怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=4395
UPDATE `creature_template_locale` SET `Name` = '發熱的沼澤軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 4395;
-- OLD name : 守門者克杜魯斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=4409
UPDATE `creature_template_locale` SET `Name` = '守門人克杜魯斯' WHERE `locale` = 'zhTW' AND `entry` = 4409;
-- OLD name : 暗牙蠕行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4412
UPDATE `creature_template_locale` SET `Name` = '暗牙爬行者' WHERE `locale` = 'zhTW' AND `entry` = 4412;
-- OLD name : 迪菲亞監工
-- Source : https://www.wowhead.com/wotlk/tw/npc=4417
UPDATE `creature_template_locale` SET `Name` = '迪菲亞工頭' WHERE `locale` = 'zhTW' AND `entry` = 4417;
-- OLD name : 盛怒的阿迦賽羅斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=4422
UPDATE `creature_template_locale` SET `Name` = '暴怒的阿迦賽羅斯' WHERE `locale` = 'zhTW' AND `entry` = 4422;
-- OLD name : 結界守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4427
UPDATE `creature_template_locale` SET `Name` = '結界衛士' WHERE `locale` = 'zhTW' AND `entry` = 4427;
-- OLD name : 剃刀沼澤守望者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4437
UPDATE `creature_template_locale` SET `Name` = '剃刀沼澤衛兵' WHERE `locale` = 'zhTW' AND `entry` = 4437;
-- OLD name : Wazza
-- Source : https://www.wowhead.com/wotlk/tw/npc=4443
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 4443;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4443, 'zhTW','瓦薩',NULL);
-- OLD name : 亡靈哨兵文森
-- Source : https://www.wowhead.com/wotlk/tw/npc=4444
UPDATE `creature_template_locale` SET `Name` = '亡靈哨兵文森特' WHERE `locale` = 'zhTW' AND `entry` = 4444;
-- OLD subname : 票商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4445
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4445;
-- OLD name : Mazzer Stripscrew, subname : 票商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4446
UPDATE `creature_template_locale` SET `Name` = '瑪茲爾',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4446;
-- OLD name : 克拉索·滑鏈, subname : 地精獎券商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4449
UPDATE `creature_template_locale` SET `Name` = '克拉茲·滑鏈',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4449;
-- OLD subname : 哥布林獎券商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4450
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4450;
-- OLD name : 黑鰓寒冰使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4460
UPDATE `creature_template_locale` SET `Name` = '黑腮首領' WHERE `locale` = 'zhTW' AND `entry` = 4460;
-- OLD name : 邪枝預卜者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4467
UPDATE `creature_template_locale` SET `Name` = '邪枝占卜者' WHERE `locale` = 'zhTW' AND `entry` = 4467;
-- OLD name : 菲羅·鐵手
-- Source : https://www.wowhead.com/wotlk/tw/npc=4484
UPDATE `creature_template_locale` SET `Name` = '費羅·艾隆漢' WHERE `locale` = 'zhTW' AND `entry` = 4484;
-- OLD subname : 舵手
-- Source : https://www.wowhead.com/wotlk/tw/npc=4497
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4497;
-- OLD name : 血帆水手
-- Source : https://www.wowhead.com/wotlk/tw/npc=4505
UPDATE `creature_template_locale` SET `Name` = '血帆槳手' WHERE `locale` = 'zhTW' AND `entry` = 4505;
-- OLD name : 盛怒的阿迦瑪
-- Source : https://www.wowhead.com/wotlk/tw/npc=4514
UPDATE `creature_template_locale` SET `Name` = '暴怒的阿迦瑪' WHERE `locale` = 'zhTW' AND `entry` = 4514;
-- OLD name : 被馴服的土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4534
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4534;
-- OLD name : 高階審判官法爾班克斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=4542
UPDATE `creature_template_locale` SET `Name` = '高等審判官法爾班克斯' WHERE `locale` = 'zhTW' AND `entry` = 4542;
-- OLD name : 鋼齒土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4548
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4548;
-- OLD name : 蘿倫·紐科布
-- Source : https://www.wowhead.com/wotlk/tw/npc=4558
UPDATE `creature_template_locale` SET `Name` = '勞倫·紐科布' WHERE `locale` = 'zhTW' AND `entry` = 4558;
-- OLD name : 提摩西·威爾頓
-- Source : https://www.wowhead.com/wotlk/tw/npc=4559
UPDATE `creature_template_locale` SET `Name` = '提莫斯·威爾頓' WHERE `locale` = 'zhTW' AND `entry` = 4559;
-- OLD name : 凱利斯蒂亞·仇恨使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4566
UPDATE `creature_template_locale` SET `Name` = '凱利斯蒂亞' WHERE `locale` = 'zhTW' AND `entry` = 4566;
-- OLD subname : 裁縫訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4578
UPDATE `creature_template_locale` SET `Title` = '大師級影紋裁縫' WHERE `locale` = 'zhTW' AND `entry` = 4578;
-- OLD name : 亞歷山大·李斯特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=4579
UPDATE `creature_template_locale` SET `Name` = 'zzOLD亞歷山大‧李斯特' WHERE `locale` = 'zhTW' AND `entry` = 4579;
-- OLD subname : 盜賊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4582
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4582;
-- OLD subname : 盜賊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4583
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4583;
-- OLD name : 葛列格里·查理斯, subname : 盜賊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4584
UPDATE `creature_template_locale` SET `Name` = '格雷戈·查理斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4584;
-- OLD name : 艾澤基爾·格拉夫斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=4585
UPDATE `creature_template_locale` SET `Name` = '艾澤基爾·格瑞烏斯' WHERE `locale` = 'zhTW' AND `entry` = 4585;
-- OLD name : 法蘭西斯·埃洛特
-- Source : https://www.wowhead.com/wotlk/tw/npc=4601
UPDATE `creature_template_locale` SET `Name` = '弗蘭克西斯·埃洛特' WHERE `locale` = 'zhTW' AND `entry` = 4601;
-- OLD name : 藏寶海灣衛兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=4624
UPDATE `creature_template_locale` SET `Name` = '藏寶海灣哥布林衛兵' WHERE `locale` = 'zhTW' AND `entry` = 4624;
-- OLD name : 亡首結界守衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4625
UPDATE `creature_template_locale` SET `Name` = '亡首結界守護者' WHERE `locale` = 'zhTW' AND `entry` = 4625;
-- OLD name : 阿魯高的虛無行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4627
UPDATE `creature_template_locale` SET `Name` = '阿魯高的虛空行者' WHERE `locale` = 'zhTW' AND `entry` = 4627;
-- OLD name : 瑪格拉姆風暴者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4642
UPDATE `creature_template_locale` SET `Name` = '瑪格拉姆狂怒者' WHERE `locale` = 'zhTW' AND `entry` = 4642;
-- OLD name : 瑪洛迪風暴者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4658
UPDATE `creature_template_locale` SET `Name` = '瑪洛迪狂怒者' WHERE `locale` = 'zhTW' AND `entry` = 4658;
-- OLD name : 瑪洛迪骨爪土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4660
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4660;
-- OLD name : 瑪格拉姆骨爪土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4662
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4662;
-- OLD name : 燃刃咒術師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4669
UPDATE `creature_template_locale` SET `Name` = '火刃咒術師' WHERE `locale` = 'zhTW' AND `entry` = 4669;
-- OLD name : 末日護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=4677
UPDATE `creature_template_locale` SET `Name` = '末日守衛' WHERE `locale` = 'zhTW' AND `entry` = 4677;
-- OLD name : 末日護衛隊長
-- Source : https://www.wowhead.com/wotlk/tw/npc=4680
UPDATE `creature_template_locale` SET `Name` = '末日守衛隊長' WHERE `locale` = 'zhTW' AND `entry` = 4680;
-- OLD name : 末日護衛領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=4683
UPDATE `creature_template_locale` SET `Name` = '末日看守領主' WHERE `locale` = 'zhTW' AND `entry` = 4683;
-- OLD name : 骨爪土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4688
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4688;
-- OLD name : 飢餓的骨爪土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4689
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4689;
-- OLD name : 瘋狂的骨爪土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4690
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4690;
-- OLD name : 殘忍的骨爪土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=4691
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4691;
-- OLD name : 恐怖禿鷹
-- Source : https://www.wowhead.com/wotlk/tw/npc=4693
UPDATE `creature_template_locale` SET `Name` = '恐怖飛鳥' WHERE `locale` = 'zhTW' AND `entry` = 4693;
-- OLD name : 盛怒的科多獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=4703
UPDATE `creature_template_locale` SET `Name` = '暴怒的科多獸' WHERE `locale` = 'zhTW' AND `entry` = 4703;
-- OLD name : 燃刃塑能師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4705
UPDATE `creature_template_locale` SET `Name` = '火刃塑能師' WHERE `locale` = 'zhTW' AND `entry` = 4705;
-- OLD name : 灰山羊
-- Source : https://www.wowhead.com/wotlk/tw/npc=4710
UPDATE `creature_template_locale` SET `Name` = '騎乘用山羊（灰色）' WHERE `locale` = 'zhTW' AND `entry` = 4710;
-- OLD name : 滑刃巫女
-- Source : https://www.wowhead.com/wotlk/tw/npc=4712
UPDATE `creature_template_locale` SET `Name` = '滑刃巫師' WHERE `locale` = 'zhTW' AND `entry` = 4712;
-- OLD name : 滑刃部屬
-- Source : https://www.wowhead.com/wotlk/tw/npc=4714
UPDATE `creature_template_locale` SET `Name` = '滑刃侍從' WHERE `locale` = 'zhTW' AND `entry` = 4714;
-- OLD name : 滑刃獵潮者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4716
UPDATE `creature_template_locale` SET `Name` = '滑刃潮行者' WHERE `locale` = 'zhTW' AND `entry` = 4716;
-- OLD name : 滑刃神諭者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4718
UPDATE `creature_template_locale` SET `Name` = '滑刃智者' WHERE `locale` = 'zhTW' AND `entry` = 4718;
-- OLD name : Rau Cliffrunner
-- Source : https://www.wowhead.com/wotlk/tw/npc=4722
UPDATE `creature_template_locale` SET `Name` = '勞恩·峭壁行者' WHERE `locale` = 'zhTW' AND `entry` = 4722;
-- OLD name : 沙漠陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=4724
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4724;
-- OLD name : 瘋狂的沙漠陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=4725
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4725;
-- OLD name : 盛怒的雷霆蜥蜴
-- Source : https://www.wowhead.com/wotlk/tw/npc=4726
UPDATE `creature_template_locale` SET `Name` = '暴怒的雷霆蜥蜴' WHERE `locale` = 'zhTW' AND `entry` = 4726;
-- OLD subname : 騎術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4752
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4752;
-- OLD name : 騎乘用白山羊
-- Source : https://www.wowhead.com/wotlk/tw/npc=4777
UPDATE `creature_template_locale` SET `Name` = '騎乘用山羊（白色）' WHERE `locale` = 'zhTW' AND `entry` = 4777;
-- OLD name : 冰霜山羊
-- Source : https://www.wowhead.com/wotlk/tw/npc=4778
UPDATE `creature_template_locale` SET `Name` = '騎乘用山羊（藍色）' WHERE `locale` = 'zhTW' AND `entry` = 4778;
-- OLD name : 棕山羊
-- Source : https://www.wowhead.com/wotlk/tw/npc=4779
UPDATE `creature_template_locale` SET `Name` = '騎乘用山羊(棕色)' WHERE `locale` = 'zhTW' AND `entry` = 4779;
-- OLD name : 黑山羊
-- Source : https://www.wowhead.com/wotlk/tw/npc=4780
UPDATE `creature_template_locale` SET `Name` = '騎乘用山羊（黑色）' WHERE `locale` = 'zhTW' AND `entry` = 4780;
-- OLD name : 虛幻夢魘獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=4785
UPDATE `creature_template_locale` SET `Name` = '幻影夢魘獸' WHERE `locale` = 'zhTW' AND `entry` = 4785;
-- OLD name : 斥候塞爾瑞德
-- Source : https://www.wowhead.com/wotlk/tw/npc=4787
UPDATE `creature_template_locale` SET `Name` = '銀月守衛塞爾瑞德' WHERE `locale` = 'zhTW' AND `entry` = 4787;
-- OLD name : 黑澗深淵海潮祭司
-- Source : https://www.wowhead.com/wotlk/tw/npc=4802
UPDATE `creature_template_locale` SET `Name` = '黑暗深淵海潮祭司' WHERE `locale` = 'zhTW' AND `entry` = 4802;
-- OLD name : 黑澗深淵神諭者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4803
UPDATE `creature_template_locale` SET `Name` = '黑暗深淵神諭者' WHERE `locale` = 'zhTW' AND `entry` = 4803;
-- OLD name : 黑澗深淵海巫
-- Source : https://www.wowhead.com/wotlk/tw/npc=4805
UPDATE `creature_template_locale` SET `Name` = '黑暗深淵海巫' WHERE `locale` = 'zhTW' AND `entry` = 4805;
-- OLD name : 黑澗深淵僕從
-- Source : https://www.wowhead.com/wotlk/tw/npc=4807
UPDATE `creature_template_locale` SET `Name` = '黑暗深淵僕從' WHERE `locale` = 'zhTW' AND `entry` = 4807;
-- OLD name : 暮光劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4810
UPDATE `creature_template_locale` SET `Name` = '暮光劫掠者' WHERE `locale` = 'zhTW' AND `entry` = 4810;
-- OLD name : 暮光暗影法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4813
UPDATE `creature_template_locale` SET `Name` = '暮光暗法師' WHERE `locale` = 'zhTW' AND `entry` = 4813;
-- OLD name : 老瑟拉吉斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=4830
UPDATE `creature_template_locale` SET `Name` = '瑟拉吉斯' WHERE `locale` = 'zhTW' AND `entry` = 4830;
-- OLD name : 薩利維絲女士
-- Source : https://www.wowhead.com/wotlk/tw/npc=4831
UPDATE `creature_template_locale` SET `Name` = '薩利維絲' WHERE `locale` = 'zhTW' AND `entry` = 4831;
-- OLD name : 暮光領主克爾里斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=4832
UPDATE `creature_template_locale` SET `Name` = '夢遊者克爾里斯' WHERE `locale` = 'zhTW' AND `entry` = 4832;
-- OLD name : 影爐勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=4844
UPDATE `creature_template_locale` SET `Name` = '暗爐勘探員' WHERE `locale` = 'zhTW' AND `entry` = 4844;
-- OLD name : 影爐惡棍
-- Source : https://www.wowhead.com/wotlk/tw/npc=4845
UPDATE `creature_template_locale` SET `Name` = '暗爐惡棍' WHERE `locale` = 'zhTW' AND `entry` = 4845;
-- OLD name : 影爐掘地工
-- Source : https://www.wowhead.com/wotlk/tw/npc=4846
UPDATE `creature_template_locale` SET `Name` = '暗爐掘地工' WHERE `locale` = 'zhTW' AND `entry` = 4846;
-- OLD name : 影爐發掘者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4847
UPDATE `creature_template_locale` SET `Name` = '暗爐發掘者' WHERE `locale` = 'zhTW' AND `entry` = 4847;
-- OLD name : 影爐黑暗法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4848
UPDATE `creature_template_locale` SET `Name` = '暗爐暗法師' WHERE `locale` = 'zhTW' AND `entry` = 4848;
-- OLD name : 影爐考古學家
-- Source : https://www.wowhead.com/wotlk/tw/npc=4849
UPDATE `creature_template_locale` SET `Name` = '暗爐考古學家' WHERE `locale` = 'zhTW' AND `entry` = 4849;
-- OLD name : 石窟地卜師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4853
UPDATE `creature_template_locale` SET `Name` = '石窟地占師' WHERE `locale` = 'zhTW' AND `entry` = 4853;
-- OLD subname : 石窟酋長
-- Source : https://www.wowhead.com/wotlk/tw/npc=4854
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4854;
-- OLD name : 石窟打鬥者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4855
UPDATE `creature_template_locale` SET `Name` = '石窟爭鬥者' WHERE `locale` = 'zhTW' AND `entry` = 4855;
-- OLD name : 石之守衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4857
UPDATE `creature_template_locale` SET `Name` = '石頭看守者' WHERE `locale` = 'zhTW' AND `entry` = 4857;
-- OLD name : 加恩·高臺
-- Source : https://www.wowhead.com/wotlk/tw/npc=4876
UPDATE `creature_template_locale` SET `Name` = '加恩·高塔' WHERE `locale` = 'zhTW' AND `entry` = 4876;
-- OLD name : Montarr, subname : 博識者
-- Source : https://www.wowhead.com/wotlk/tw/npc=4878
UPDATE `creature_template_locale` SET `Name` = '莫塔爾',`Title` = '博學者' WHERE `locale` = 'zhTW' AND `entry` = 4878;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4884
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 4884;
-- OLD name : 格里高·馬克凡斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=4885
UPDATE `creature_template_locale` SET `Name` = '格瑞戈·瑪克溫斯' WHERE `locale` = 'zhTW' AND `entry` = 4885;
-- OLD subname : 護甲和武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4886
UPDATE `creature_template_locale` SET `Title` = '護甲和盾牌供應商' WHERE `locale` = 'zhTW' AND `entry` = 4886;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4888
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 4888;
-- OLD subname : 武器鍛造和護甲
-- Source : https://www.wowhead.com/wotlk/tw/npc=4890
UPDATE `creature_template_locale` SET `Title` = '武器和護甲' WHERE `locale` = 'zhTW' AND `entry` = 4890;
-- OLD subname : 獵人訓練師和弓箭商
-- Source : https://www.wowhead.com/wotlk/tw/npc=4892
UPDATE `creature_template_locale` SET `Title` = '弓箭商' WHERE `locale` = 'zhTW' AND `entry` = 4892;
-- OLD name : 克瑞格·諾瓦德, subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4894
UPDATE `creature_template_locale` SET `Name` = '克萊格·諾瓦德',`Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 4894;
-- OLD subname : 雜貨商和施法材料
-- Source : https://www.wowhead.com/wotlk/tw/npc=4896
UPDATE `creature_template_locale` SET `Title` = '雜貨商' WHERE `locale` = 'zhTW' AND `entry` = 4896;
-- OLD name : 守衛拜倫
-- Source : https://www.wowhead.com/wotlk/tw/npc=4921
UPDATE `creature_template_locale` SET `Name` = '衛兵拜倫' WHERE `locale` = 'zhTW' AND `entry` = 4921;
-- OLD name : 守衛愛德華
-- Source : https://www.wowhead.com/wotlk/tw/npc=4922
UPDATE `creature_template_locale` SET `Name` = '衛兵愛德華' WHERE `locale` = 'zhTW' AND `entry` = 4922;
-- OLD name : 守衛賈拉德
-- Source : https://www.wowhead.com/wotlk/tw/npc=4923
UPDATE `creature_template_locale` SET `Name` = '衛兵賈拉德' WHERE `locale` = 'zhTW' AND `entry` = 4923;
-- OLD subname : Test
-- Source : https://www.wowhead.com/wotlk/tw/npc=4942
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4942;
-- OLD name : 塞拉摩見習守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=4951
UPDATE `creature_template_locale` SET `Name` = '塞拉摩見習衛兵' WHERE `locale` = 'zhTW' AND `entry` = 4951;
-- OLD name : 水蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=4953
UPDATE `creature_template_locale` SET `Name` = '噬魚蛇' WHERE `locale` = 'zhTW' AND `entry` = 4953;
-- OLD name : 冤魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=4958
UPDATE `creature_template_locale` SET `Name` = '不散的怨靈' WHERE `locale` = 'zhTW' AND `entry` = 4958;
-- OLD subname : 塞拉摩之主
-- Source : https://www.wowhead.com/wotlk/tw/npc=4968
UPDATE `creature_template_locale` SET `Title` = '塞拉摩的統治者' WHERE `locale` = 'zhTW' AND `entry` = 4968;
-- OLD name : 卡古隆
-- Source : https://www.wowhead.com/wotlk/tw/npc=4972
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 4972;
-- OLD name : 守衛萊斯特
-- Source : https://www.wowhead.com/wotlk/tw/npc=4973
UPDATE `creature_template_locale` SET `Name` = '衛兵萊斯特' WHERE `locale` = 'zhTW' AND `entry` = 4973;
-- OLD subname : 公會外袍設計師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4976
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4976;
-- OLD name : 塞拉摩守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=4979
UPDATE `creature_template_locale` SET `Name` = '塞拉摩衛兵' WHERE `locale` = 'zhTW' AND `entry` = 4979;
-- OLD subname : 祭壇助手
-- Source : https://www.wowhead.com/wotlk/tw/npc=4982
UPDATE `creature_template_locale` SET `Title` = '祭台助手' WHERE `locale` = 'zhTW' AND `entry` = 4982;
-- OLD name : 阿茍斯·夜語
-- Source : https://www.wowhead.com/wotlk/tw/npc=4984
UPDATE `creature_template_locale` SET `Name` = '阿古斯·夜語' WHERE `locale` = 'zhTW' AND `entry` = 4984;
-- OLD subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4985
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4985;
-- OLD subname : 獵人訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4986
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4986;
-- OLD subname : 法師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4987
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4987;
-- OLD subname : 聖騎士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4988
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4988;
-- OLD subname : 牧師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4989
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4989;
-- OLD subname : 盜賊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4990
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4990;
-- OLD subname : 薩滿訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4991
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4991;
-- OLD subname : 戰士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4992
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4992;
-- OLD subname : 術士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4993
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4993;
-- OLD subname : 釣魚訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4997
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4997;
-- OLD subname : 草藥學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4998
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4998;
-- OLD subname : 採礦訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=4999
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 4999;
-- OLD subname : 獵人野獸訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5000
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5000;
-- OLD name : World Boar Trainer
-- Source : https://www.wowhead.com/wotlk/tw/npc=5002
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5002;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (5002, 'zhTW','世界野豬訓練師',NULL);
-- OLD name : 世界惡魔訓練師 - 舊
-- Source : https://www.wowhead.com/wotlk/tw/npc=5006
UPDATE `creature_template_locale` SET `Name` = '世界惡魔訓練師' WHERE `locale` = 'zhTW' AND `entry` = 5006;
-- OLD name : 世界惡魔獵犬訓練師, subname : UNUSED
-- Source : https://www.wowhead.com/wotlk/tw/npc=5007
UPDATE `creature_template_locale` SET `Name` = '世界地獄獵犬訓練師',`Title` = 'ED' WHERE `locale` = 'zhTW' AND `entry` = 5007;
-- OLD subname : UNUSED
-- Source : https://www.wowhead.com/wotlk/tw/npc=5010
UPDATE `creature_template_locale` SET `Title` = 'ED' WHERE `locale` = 'zhTW' AND `entry` = 5010;
-- OLD subname : UNUSED
-- Source : https://www.wowhead.com/wotlk/tw/npc=5014
UPDATE `creature_template_locale` SET `Title` = 'ED' WHERE `locale` = 'zhTW' AND `entry` = 5014;
-- OLD name : 世界虛無行者訓練師, subname : UNUSED
-- Source : https://www.wowhead.com/wotlk/tw/npc=5016
UPDATE `creature_template_locale` SET `Name` = '世界虛空行者訓練師',`Title` = 'ED' WHERE `locale` = 'zhTW' AND `entry` = 5016;
-- OLD name : 世界傳送門:達納蘇斯訓練師, subname : 傳送門:達納蘇斯訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5018
UPDATE `creature_template_locale` SET `Name` = '世界傳送門：達納蘇斯訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5018;
-- OLD name : 世界傳送門:鐵爐堡訓練師, subname : 傳送門:鐵爐堡訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5019
UPDATE `creature_template_locale` SET `Name` = '世界傳送門：鐵爐堡訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5019;
-- OLD name : 世界傳送門:奧格瑪訓練師, subname : 傳送門:奧格瑪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5020
UPDATE `creature_template_locale` SET `Name` = '世界傳送門：奧格瑪訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5020;
-- OLD name : 世界傳送門:暴風城訓練師, subname : 傳送門:暴風城訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5021
UPDATE `creature_template_locale` SET `Name` = '世界傳送門：暴風城訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5021;
-- OLD name : 世界傳送門:雷霆崖訓練師, subname : 傳送門:雷霆崖訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5022
UPDATE `creature_template_locale` SET `Name` = '世界傳送門：雷霆崖訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5022;
-- OLD name : 世界傳送門:幽暗城訓練師, subname : 傳送門:幽暗城訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5023
UPDATE `creature_template_locale` SET `Name` = '世界傳送門：幽暗城訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5023;
-- OLD subname : 急救訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5024
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5024;
-- OLD name : [PH] Mogu Pain Barrier
-- Source : https://www.wowhead.com/wotlk/tw/npc=5027
UPDATE `creature_template_locale` SET `Name` = '世界開鎖訓練師' WHERE `locale` = 'zhTW' AND `entry` = 5027;
-- OLD subname : 山羊騎術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5028
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5028;
-- OLD name : 吉明
-- Source : https://www.wowhead.com/wotlk/tw/npc=5029
UPDATE `creature_template_locale` SET `Name` = '世界生存訓練師' WHERE `locale` = 'zhTW' AND `entry` = 5029;
-- OLD subname : 狼騎術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5031
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5031;
-- OLD name : 世界鍊金術訓練師, subname : 鍊金術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5032
UPDATE `creature_template_locale` SET `Name` = '世界煉金術訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5032;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5033
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5033;
-- OLD name : 溫瓦
-- Source : https://www.wowhead.com/wotlk/tw/npc=5034
UPDATE `creature_template_locale` SET `Name` = '世界釀酒訓練師' WHERE `locale` = 'zhTW' AND `entry` = 5034;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5036
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5036;
-- OLD subname : 工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5037
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5037;
-- OLD subname : 附魔訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5038
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5038;
-- OLD name : DEPRECATED世界術士訓練師, subname : 術士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5039
UPDATE `creature_template_locale` SET `Name` = '世界追蹤訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5039;
-- OLD subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5040
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5040;
-- OLD subname : 裁縫訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5041
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5041;
-- OLD name : 暴民
-- Source : https://www.wowhead.com/wotlk/tw/npc=5043
UPDATE `creature_template_locale` SET `Name` = '迪菲亞暴民' WHERE `locale` = 'zhTW' AND `entry` = 5043;
-- OLD subname : 公會外袍設計師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5047
UPDATE `creature_template_locale` SET `Title` = '外袍設計師' WHERE `locale` = 'zhTW' AND `entry` = 5047;
-- OLD name : 無毒飛蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=5048
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5048;
-- OLD subname : 外袍商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=5049
UPDATE `creature_template_locale` SET `Title` = '公會外袍商人' WHERE `locale` = 'zhTW' AND `entry` = 5049;
-- OLD name : 變異尖牙風蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=5056
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5056;
-- OLD subname : 銀行職員
-- Source : https://www.wowhead.com/wotlk/tw/npc=5060
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5060;
-- OLD name : 世界公會外袍商人, subname : 公會外袍商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=5061
UPDATE `creature_template_locale` SET `Name` = '世界公會長袍商人',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5061;
-- OLD name : 世界施法材料商, subname : 施法材料和圖騰商
-- Source : https://www.wowhead.com/wotlk/tw/npc=5062
UPDATE `creature_template_locale` SET `Name` = '世界試劑商人',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5062;
-- OLD name : 世界貿易供應商, subname : 貿易供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=5064
UPDATE `creature_template_locale` SET `Name` = '世界貿易補給',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5064;
-- OLD name : 出納員倫德瑞
-- Source : https://www.wowhead.com/wotlk/tw/npc=5083
UPDATE `creature_template_locale` SET `Name` = '書記員倫德瑞' WHERE `locale` = 'zhTW' AND `entry` = 5083;
-- OLD name : 警戒崗哨守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=5085
UPDATE `creature_template_locale` SET `Name` = '警戒崗哨衛兵' WHERE `locale` = 'zhTW' AND `entry` = 5085;
-- OLD name : 魏摩爾上尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=5086
UPDATE `creature_template_locale` SET `Name` = '衛摩爾上尉' WHERE `locale` = 'zhTW' AND `entry` = 5086;
-- OLD name : 守衛卡希爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=5091
UPDATE `creature_template_locale` SET `Name` = '衛兵卡希爾' WHERE `locale` = 'zhTW' AND `entry` = 5091;
-- OLD name : 守衛拉娜
-- Source : https://www.wowhead.com/wotlk/tw/npc=5092
UPDATE `creature_template_locale` SET `Name` = '衛兵拉娜' WHERE `locale` = 'zhTW' AND `entry` = 5092;
-- OLD name : 守衛娜里莎
-- Source : https://www.wowhead.com/wotlk/tw/npc=5093
UPDATE `creature_template_locale` SET `Name` = '衛兵娜里莎' WHERE `locale` = 'zhTW' AND `entry` = 5093;
-- OLD name : 守衛塔克
-- Source : https://www.wowhead.com/wotlk/tw/npc=5094
UPDATE `creature_template_locale` SET `Name` = '衛兵塔克' WHERE `locale` = 'zhTW' AND `entry` = 5094;
-- OLD name : [UNUSED]古弗雷·石鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=5098
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 5098;
-- OLD subname : 輕甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=5105
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5105;
-- OLD name : [UNUSED]基倫·泰恩加德 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=5131
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 5131;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5164
UPDATE `creature_template_locale` SET `Title` = '護甲鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 5164;
-- OLD name : 塞拉摩哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=5184
UPDATE `creature_template_locale` SET `Name` = '塞拉摩哨兵' WHERE `locale` = 'zhTW' AND `entry` = 5184;
-- OLD name : 南海火砲
-- Source : https://www.wowhead.com/wotlk/tw/npc=5187
UPDATE `creature_template_locale` SET `Name` = '南海火炮' WHERE `locale` = 'zhTW' AND `entry` = 5187;
-- OLD name : [UNUSED]尼爾斯·石眉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=5192
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 5192;
-- OLD name : 黑色狼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=5194
UPDATE `creature_template_locale` SET `Name` = '黑毛座狼' WHERE `locale` = 'zhTW' AND `entry` = 5194;
-- OLD name : 棕色狼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=5195
UPDATE `creature_template_locale` SET `Name` = '棕狼坐騎' WHERE `locale` = 'zhTW' AND `entry` = 5195;
-- OLD name : 灰色狼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=5196
UPDATE `creature_template_locale` SET `Name` = '灰色座狼' WHERE `locale` = 'zhTW' AND `entry` = 5196;
-- OLD name : 紅色狼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=5197
UPDATE `creature_template_locale` SET `Name` = '紅毛座狼' WHERE `locale` = 'zhTW' AND `entry` = 5197;
-- OLD name : 白色狼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=5198
UPDATE `creature_template_locale` SET `Name` = '白毛座狼' WHERE `locale` = 'zhTW' AND `entry` = 5198;
-- OLD name : 黑暗滑行蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=5224
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5224;
-- OLD name : 黑暗粘液蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=5225
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5225;
-- OLD name : 木爪陷捕者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5251
UPDATE `creature_template_locale` SET `Name` = '木爪捕獸者' WHERE `locale` = 'zhTW' AND `entry` = 5251;
-- OLD name : 木爪秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=5254
UPDATE `creature_template_locale` SET `Name` = '木爪秘法師' WHERE `locale` = 'zhTW' AND `entry` = 5254;
-- OLD name : 木爪劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5255
UPDATE `creature_template_locale` SET `Name` = '木爪搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 5255;
-- OLD name : 原生木爪豺狼人
-- Source : https://www.wowhead.com/wotlk/tw/npc=5258
UPDATE `creature_template_locale` SET `Name` = '木爪突擊隊員' WHERE `locale` = 'zhTW' AND `entry` = 5258;
-- OLD name : 哈卡萊霜翼飛蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=5291
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5291;
-- OLD name : 怒痕雪人
-- Source : https://www.wowhead.com/wotlk/tw/npc=5296
UPDATE `creature_template_locale` SET `Name` = '狂暴的怒痕雪人' WHERE `locale` = 'zhTW' AND `entry` = 5296;
-- OLD name : 年老的怒痕雪人
-- Source : https://www.wowhead.com/wotlk/tw/npc=5297
UPDATE `creature_template_locale` SET `Name` = '老年怒痕雪人' WHERE `locale` = 'zhTW' AND `entry` = 5297;
-- OLD name : 亂羽天颶
-- Source : https://www.wowhead.com/wotlk/tw/npc=5305
UPDATE `creature_template_locale` SET `Name` = '亂羽鳴天者' WHERE `locale` = 'zhTW' AND `entry` = 5305;
-- OLD name : 山谷尖嘯者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5307
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5307;
-- OLD name : 遊蕩的山谷尖嘯者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5308
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5308;
-- OLD name : 加德米爾龍裔
-- Source : https://www.wowhead.com/wotlk/tw/npc=5315
UPDATE `creature_template_locale` SET `Name` = '加德米爾龍人' WHERE `locale` = 'zhTW' AND `entry` = 5315;
-- OLD name : 加德米爾樹木護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=5319
UPDATE `creature_template_locale` SET `Name` = '加德米爾樹木守衛' WHERE `locale` = 'zhTW' AND `entry` = 5319;
-- OLD name : 加德米爾守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=5320
UPDATE `creature_template_locale` SET `Name` = '加德米爾衛兵' WHERE `locale` = 'zhTW' AND `entry` = 5320;
-- OLD name : 傑洛米的測試怪物
-- Source : https://www.wowhead.com/wotlk/tw/npc=5326
UPDATE `creature_template_locale` SET `Name` = '海灘響鉗龍蝦人' WHERE `locale` = 'zhTW' AND `entry` = 5326;
-- OLD name : 憎世部屬
-- Source : https://www.wowhead.com/wotlk/tw/npc=5334
UPDATE `creature_template_locale` SET `Name` = '憎世侍從' WHERE `locale` = 'zhTW' AND `entry` = 5334;
-- OLD name : 『潛獵者』血吼
-- Source : https://www.wowhead.com/wotlk/tw/npc=5346
UPDATE `creature_template_locale` SET `Name` = '『潛行者』血吼' WHERE `locale` = 'zhTW' AND `entry` = 5346;
-- OLD name : 阿拉瑟希斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=5349
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5349;
-- OLD name : 樹瘤·葉伴
-- Source : https://www.wowhead.com/wotlk/tw/npc=5354
UPDATE `creature_template_locale` SET `Name` = '格納爾·葉伴' WHERE `locale` = 'zhTW' AND `entry` = 5354;
-- OLD name : 侍僧迪利斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=5386
UPDATE `creature_template_locale` SET `Name` = '隨從迪利斯' WHERE `locale` = 'zhTW' AND `entry` = 5386;
-- OLD subname : 珠寶設計訓練師和供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=5388
UPDATE `creature_template_locale` SET `Title` = '探險者協會' WHERE `locale` = 'zhTW' AND `entry` = 5388;
-- OLD name : 赫蘭薩可汗
-- Source : https://www.wowhead.com/wotlk/tw/npc=5402
UPDATE `creature_template_locale` SET `Name` = '赫魯薩可汗' WHERE `locale` = 'zhTW' AND `entry` = 5402;
-- OLD name : 被奴役的收割者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5409
UPDATE `creature_template_locale` SET `Name` = '工蠍群' WHERE `locale` = 'zhTW' AND `entry` = 5409;
-- OLD name : 飢餓的皰爪土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=5425
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5425;
-- OLD name : 皰爪土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=5426
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5426;
-- OLD name : 瘋狂的皰爪土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=5427
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5427;
-- OLD name : 被馴服的角斑馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=5443
UPDATE `creature_template_locale` SET `Name` = '被馴服的斑馬' WHERE `locale` = 'zhTW' AND `entry` = 5443;
-- OLD name : 哈札里沙奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5454
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5454;
-- OLD name : 森提帕爾沙奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5460
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5460;
-- OLD name : 盛怒的沙丘重擊者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5470
UPDATE `creature_template_locale` SET `Name` = '暴怒的沙丘重擊者' WHERE `locale` = 'zhTW' AND `entry` = 5470;
-- OLD name : 史蒂芬·雷百克
-- Source : https://www.wowhead.com/wotlk/tw/npc=5482
UPDATE `creature_template_locale` SET `Name` = '斯蒂芬·雷百克' WHERE `locale` = 'zhTW' AND `entry` = 5482;
-- OLD name : 班傑明修士
-- Source : https://www.wowhead.com/wotlk/tw/npc=5484
UPDATE `creature_template_locale` SET `Name` = '本傑明修士' WHERE `locale` = 'zhTW' AND `entry` = 5484;
-- OLD subname : 術士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5495
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5495;
-- OLD subname : 術士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5496
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5496;
-- OLD subname : 草藥學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5502
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5502;
-- OLD subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5504
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5504;
-- OLD subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5505
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5505;
-- OLD subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5506
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5506;
-- OLD subname : 護甲商
-- Source : https://www.wowhead.com/wotlk/tw/npc=5508
UPDATE `creature_template_locale` SET `Title` = '鑄甲師' WHERE `locale` = 'zhTW' AND `entry` = 5508;
-- OLD subname : 塞爾摩瑞丹的寵物
-- Source : https://www.wowhead.com/wotlk/tw/npc=5521
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5521;
-- OLD subname : 斯塔諾爾的寵物
-- Source : https://www.wowhead.com/wotlk/tw/npc=5522
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5522;
-- OLD name : [UNUSED] Yuriv Adhem (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5544
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5544;
-- OLD name : [PH] 礦坑首領 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5548
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5548;
-- OLD name : [PH] 礦坑守衛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=5549
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 5549;
-- OLD name : [PH] PVP農夫 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5550
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5550;
-- OLD name : [PH] PVP勞工 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5552
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5552;
-- OLD name : [PH]商隊斥候 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5553
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5553;
-- OLD name : [PH] PVP野生動物 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5554
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5554;
-- OLD name : [PH]巨魔商隊馱馬 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5555
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5555;
-- OLD name : [PH] 聯盟指揮官 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5556
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5556;
-- OLD name : [PH] 部落指揮官 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5557
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5557;
-- OLD name : [PH] 聯盟守衛 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5558
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5558;
-- OLD name : [PH] 部落守衛 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5559
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5559;
-- OLD name : [PH] 聯盟劫掠者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5560
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5560;
-- OLD name : [PH] 部落劫掠者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5561
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5561;
-- OLD name : [PH] 聯盟弓箭手 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5562
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5562;
-- OLD name : [PH] 部落弓箭手 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5563
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5563;
-- OLD name : 吉莉安·坦納爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=5565
UPDATE `creature_template_locale` SET `Name` = '基利安·坦納爾' WHERE `locale` = 'zhTW' AND `entry` = 5565;
-- OLD name : 菲斯巴恩·轟鳴
-- Source : https://www.wowhead.com/wotlk/tw/npc=5569
UPDATE `creature_template_locale` SET `Name` = '菲斯巴恩' WHERE `locale` = 'zhTW' AND `entry` = 5569;
-- OLD name : [PH] 聯盟礦坑首領 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5587
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5587;
-- OLD name : [PH] 聯盟礦坑守衛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=5588
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 5588;
-- OLD name : [PH] 部落礦坑首領 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5589
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5589;
-- OLD name : [PH] 部落礦坑守衛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=5590
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 5590;
-- OLD name : [UNUSED] [PH] Orcish Barfly (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5604
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5604;
-- OLD name : 強尼
-- Source : https://www.wowhead.com/wotlk/tw/npc=5627
UPDATE `creature_template_locale` SET `Name` = '約翰尼' WHERE `locale` = 'zhTW' AND `entry` = 5627;
-- OLD subname : 大族長
-- Source : https://www.wowhead.com/wotlk/tw/npc=5635
UPDATE `creature_template_locale` SET `Title` = '男爵族長' WHERE `locale` = 'zhTW' AND `entry` = 5635;
-- OLD name : [UNUSED]勞倫斯·薩葉爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=5671
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 5671;
-- OLD name : [UNUSED]查理斯·布魯頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=5672
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 5672;
-- OLD name : 召喚的魅魔
-- Source : https://www.wowhead.com/wotlk/tw/npc=5677
UPDATE `creature_template_locale` SET `Name` = '魅魔' WHERE `locale` = 'zhTW' AND `entry` = 5677;
-- OLD name : [UNUSED] Deathstalker Vincent DEBUG (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5678
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5678;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=5688
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 5688;
-- OLD name : 克萊德·凱雷恩, subname : 釣魚訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5690
UPDATE `creature_template_locale` SET `Name` = '克萊德·凱林',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5690;
-- OLD subname : 傑勒德的奴僕
-- Source : https://www.wowhead.com/wotlk/tw/npc=5697
UPDATE `creature_template_locale` SET `Title` = '傑勒德的實驗體' WHERE `locale` = 'zhTW' AND `entry` = 5697;
-- OLD name : 珊曼莎·沙克爾頓
-- Source : https://www.wowhead.com/wotlk/tw/npc=5700
UPDATE `creature_template_locale` SET `Name` = '薩曼塔·沙克爾頓' WHERE `locale` = 'zhTW' AND `entry` = 5700;
-- OLD name : 埃迪安·巴特勒
-- Source : https://www.wowhead.com/wotlk/tw/npc=5704
UPDATE `creature_template_locale` SET `Name` = '埃迪安·巴特萊特' WHERE `locale` = 'zhTW' AND `entry` = 5704;
-- OLD name : 哈卡的後代
-- Source : https://www.wowhead.com/wotlk/tw/npc=5708
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5708;
-- OLD name : 伊蘭尼庫斯之影
-- Source : https://www.wowhead.com/wotlk/tw/npc=5709
UPDATE `creature_template_locale` SET `Name` = '伊蘭尼庫斯的陰影' WHERE `locale` = 'zhTW' AND `entry` = 5709;
-- OLD name : 亡靈守衛倫德瑪克
-- Source : https://www.wowhead.com/wotlk/tw/npc=5725
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵倫德瑪克' WHERE `locale` = 'zhTW' AND `entry` = 5725;
-- OLD subname : 漁夫
-- Source : https://www.wowhead.com/wotlk/tw/npc=5748
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5748;
-- OLD name : 吉娜·蘭格
-- Source : https://www.wowhead.com/wotlk/tw/npc=5750
UPDATE `creature_template_locale` SET `Name` = '吉娜·朗恩' WHERE `locale` = 'zhTW' AND `entry` = 5750;
-- OLD name : 瑪莎·斯坦恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=5753
UPDATE `creature_template_locale` SET `Name` = '馬爾薩·斯坦恩' WHERE `locale` = 'zhTW' AND `entry` = 5753;
-- OLD name : 劇毒飛蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=5755
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5755;
-- OLD name : 變異劇毒風蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=5756
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5756;
-- OLD name : 莉莉
-- Source : https://www.wowhead.com/wotlk/tw/npc=5757
UPDATE `creature_template_locale` SET `Name` = '莉蕾' WHERE `locale` = 'zhTW' AND `entry` = 5757;
-- OLD name : 變異跛行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5761
UPDATE `creature_template_locale` SET `Name` = '變異蹣跚者' WHERE `locale` = 'zhTW' AND `entry` = 5761;
-- OLD name : 弱毒飛蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=5762
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5762;
-- OLD name : 夢魘軟漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=5763
UPDATE `creature_template_locale` SET `Name` = '噩夢軟漿怪' WHERE `locale` = 'zhTW' AND `entry` = 5763;
-- OLD subname : 納拉雷克斯的侍徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=5767
UPDATE `creature_template_locale` SET `Title` = '納拉雷克斯的信徒' WHERE `locale` = 'zhTW' AND `entry` = 5767;
-- OLD subname : 納拉雷克斯的侍徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=5768
UPDATE `creature_template_locale` SET `Title` = '納拉雷克斯的信徒' WHERE `locale` = 'zhTW' AND `entry` = 5768;
-- OLD name : 阿茲雷索克領主的影像
-- Source : https://www.wowhead.com/wotlk/tw/npc=5772
UPDATE `creature_template_locale` SET `Name` = '魔王阿茲雷索克的幻影' WHERE `locale` = 'zhTW' AND `entry` = 5772;
-- OLD name : 祖格卡的影像
-- Source : https://www.wowhead.com/wotlk/tw/npc=5773
UPDATE `creature_template_locale` SET `Name` = '祖格卡的幻影' WHERE `locale` = 'zhTW' AND `entry` = 5773;
-- OLD name : 永生的沃爾丹
-- Source : https://www.wowhead.com/wotlk/tw/npc=5775
UPDATE `creature_template_locale` SET `Name` = '永生者沃爾丹' WHERE `locale` = 'zhTW' AND `entry` = 5775;
-- OLD name : 大型軟漿怪(紅)
-- Source : https://www.wowhead.com/wotlk/tw/npc=5776
UPDATE `creature_template_locale` SET `Name` = '大型軟漿怪（紅）' WHERE `locale` = 'zhTW' AND `entry` = 5776;
-- OLD name : 大型軟漿怪(綠)
-- Source : https://www.wowhead.com/wotlk/tw/npc=5777
UPDATE `creature_template_locale` SET `Name` = '大型軟漿怪（綠）' WHERE `locale` = 'zhTW' AND `entry` = 5777;
-- OLD name : 大型軟漿怪(黑)
-- Source : https://www.wowhead.com/wotlk/tw/npc=5778
UPDATE `creature_template_locale` SET `Name` = '大型軟漿怪（黑）' WHERE `locale` = 'zhTW' AND `entry` = 5778;
-- OLD name : 召喚的毒蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=5779
UPDATE `creature_template_locale` SET `Name` = '毒蛇' WHERE `locale` = 'zhTW' AND `entry` = 5779;
-- OLD name : 複製的軟漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=5780
UPDATE `creature_template_locale` SET `Name` = '克隆軟漿怪' WHERE `locale` = 'zhTW' AND `entry` = 5780;
-- OLD name : 異種蠕行者的卵
-- Source : https://www.wowhead.com/wotlk/tw/npc=5781
UPDATE `creature_template_locale` SET `Name` = '異種爬行者的卵' WHERE `locale` = 'zhTW' AND `entry` = 5781;
-- OLD name : 暴矛
-- Source : https://www.wowhead.com/wotlk/tw/npc=5786
UPDATE `creature_template_locale` SET `Name` = '斷矛' WHERE `locale` = 'zhTW' AND `entry` = 5786;
-- OLD subname : 鐵爐堡勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=5788
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5788;
-- OLD subname : 鐵爐堡勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=5789
UPDATE `creature_template_locale` SET `Title` = '鐵爐堡勘察隊' WHERE `locale` = 'zhTW' AND `entry` = 5789;
-- OLD subname : 鐵爐堡勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=5790
UPDATE `creature_template_locale` SET `Title` = '鐵爐堡勘察隊' WHERE `locale` = 'zhTW' AND `entry` = 5790;
-- OLD subname : 尖牙德魯伊
-- Source : https://www.wowhead.com/wotlk/tw/npc=5791
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5791;
-- OLD subname : 聯盟保安官
-- Source : https://www.wowhead.com/wotlk/tw/npc=5793
UPDATE `creature_template_locale` SET `Title` = '聯盟保安部隊' WHERE `locale` = 'zhTW' AND `entry` = 5793;
-- OLD subname : 聯盟保安官
-- Source : https://www.wowhead.com/wotlk/tw/npc=5794
UPDATE `creature_template_locale` SET `Title` = '聯盟保安部隊' WHERE `locale` = 'zhTW' AND `entry` = 5794;
-- OLD subname : 聯盟保安官
-- Source : https://www.wowhead.com/wotlk/tw/npc=5795
UPDATE `creature_template_locale` SET `Title` = '聯盟保安部隊' WHERE `locale` = 'zhTW' AND `entry` = 5795;
-- OLD name : [PH] Party Bot (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=5801
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 5801;
-- OLD name : 指揮官柯堤斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=5809
UPDATE `creature_template_locale` SET `Name` = '指揮官薩拉菲爾' WHERE `locale` = 'zhTW' AND `entry` = 5809;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=5814
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 5814;
-- OLD subname : 戰地衛士隊長
-- Source : https://www.wowhead.com/wotlk/tw/npc=5824
UPDATE `creature_template_locale` SET `Title` = '戰地衛兵隊長' WHERE `locale` = 'zhTW' AND `entry` = 5824;
-- OLD name : 『土狼』斯諾特
-- Source : https://www.wowhead.com/wotlk/tw/npc=5829
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5829;
-- OLD name : 『天刃』艾澤里
-- Source : https://www.wowhead.com/wotlk/tw/npc=5834
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5834;
-- OLD name : 煉獄元素
-- Source : https://www.wowhead.com/wotlk/tw/npc=5852
UPDATE `creature_template_locale` SET `Name` = '地獄元素' WHERE `locale` = 'zhTW' AND `entry` = 5852;
-- OLD name : 溫和的戰爭魔像
-- Source : https://www.wowhead.com/wotlk/tw/npc=5853
UPDATE `creature_template_locale` SET `Name` = '溫和的作戰魔像' WHERE `locale` = 'zhTW' AND `entry` = 5853;
-- OLD name : 重型戰爭魔像
-- Source : https://www.wowhead.com/wotlk/tw/npc=5854
UPDATE `creature_template_locale` SET `Name` = '重型作戰魔像' WHERE `locale` = 'zhTW' AND `entry` = 5854;
-- OLD name : 岩漿元素
-- Source : https://www.wowhead.com/wotlk/tw/npc=5855
UPDATE `creature_template_locale` SET `Name` = '熔岩元素' WHERE `locale` = 'zhTW' AND `entry` = 5855;
-- OLD subname : Far Watch Sparrer
-- Source : https://www.wowhead.com/wotlk/tw/npc=5876
UPDATE `creature_template_locale` SET `Title` = 'Watch Sparrer' WHERE `locale` = 'zhTW' AND `entry` = 5876;
-- OLD subname : Far Watch Sparrer
-- Source : https://www.wowhead.com/wotlk/tw/npc=5877
UPDATE `creature_template_locale` SET `Title` = 'Watch Sparrer' WHERE `locale` = 'zhTW' AND `entry` = 5877;
-- OLD subname : 法師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5880
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5880;
-- OLD subname : 法師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5884
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5884;
-- OLD name : 先知鴉羽
-- Source : https://www.wowhead.com/wotlk/tw/npc=5888
UPDATE `creature_template_locale` SET `Name` = '鴉羽先知' WHERE `locale` = 'zhTW' AND `entry` = 5888;
-- OLD name : 紅雲大地之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=5889
UPDATE `creature_template_locale` SET `Name` = '紅雲地靈' WHERE `locale` = 'zhTW' AND `entry` = 5889;
-- OLD name : 紅石大地之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=5890
UPDATE `creature_template_locale` SET `Name` = '紅石地靈' WHERE `locale` = 'zhTW' AND `entry` = 5890;
-- OLD name : 小型大地之靈體
-- Source : https://www.wowhead.com/wotlk/tw/npc=5891
UPDATE `creature_template_locale` SET `Name` = '大地之魂' WHERE `locale` = 'zhTW' AND `entry` = 5891;
-- OLD name : 小型火焰之靈體
-- Source : https://www.wowhead.com/wotlk/tw/npc=5893
UPDATE `creature_template_locale` SET `Name` = '火焰之魂' WHERE `locale` = 'zhTW' AND `entry` = 5893;
-- OLD name : 墮落的小型水之靈體
-- Source : https://www.wowhead.com/wotlk/tw/npc=5894
UPDATE `creature_template_locale` SET `Name` = '墮落的水之魂' WHERE `locale` = 'zhTW' AND `entry` = 5894;
-- OLD name : 小型水之靈體
-- Source : https://www.wowhead.com/wotlk/tw/npc=5895
UPDATE `creature_template_locale` SET `Name` = '水之魂' WHERE `locale` = 'zhTW' AND `entry` = 5895;
-- OLD name : 風靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=5898
UPDATE `creature_template_locale` SET `Name` = '空氣之魂' WHERE `locale` = 'zhTW' AND `entry` = 5898;
-- OLD name : 小型空氣之靈體
-- Source : https://www.wowhead.com/wotlk/tw/npc=5902
UPDATE `creature_template_locale` SET `Name` = '空氣之魂' WHERE `locale` = 'zhTW' AND `entry` = 5902;
-- OLD subname : 魚人寶寶兌換商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=5903
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5903;
-- OLD name : [UNUSED]哈爾·坎斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=5904
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 5904;
-- OLD name : 薩尼斯·織焰者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5906
UPDATE `creature_template_locale` SET `Name` = '薩尼斯·織火' WHERE `locale` = 'zhTW' AND `entry` = 5906;
-- OLD name : 蠻兵多格蘭
-- Source : https://www.wowhead.com/wotlk/tw/npc=5908
UPDATE `creature_template_locale` SET `Name` = '步兵多格蘭' WHERE `locale` = 'zhTW' AND `entry` = 5908;
-- OLD name : 淨化圖騰
-- Source : https://www.wowhead.com/wotlk/tw/npc=5924
UPDATE `creature_template_locale` SET `Name` = '祛病圖騰' WHERE `locale` = 'zhTW' AND `entry` = 5924;
-- OLD name : 元素抗性圖騰
-- Source : https://www.wowhead.com/wotlk/tw/npc=5927
UPDATE `creature_template_locale` SET `Name` = '抗火圖騰' WHERE `locale` = 'zhTW' AND `entry` = 5927;
-- OLD name : 『放逐者』阿基里歐斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=5933
UPDATE `creature_template_locale` SET `Name` = '被流放的阿切魯斯' WHERE `locale` = 'zhTW' AND `entry` = 5933;
-- OLD name : 虎鯨
-- Source : https://www.wowhead.com/wotlk/tw/npc=5936
UPDATE `creature_template_locale` SET `Name` = '逆戟鯨' WHERE `locale` = 'zhTW' AND `entry` = 5936;
-- OLD subname : 釣魚訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5938
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5938;
-- OLD subname : 釣魚訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5941
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5941;
-- OLD subname : 釣魚供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=5942
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5942;
-- OLD name : 貓頭鷹夥伴
-- Source : https://www.wowhead.com/wotlk/tw/npc=5945
UPDATE `creature_template_locale` SET `Name` = '貓頭鷹' WHERE `locale` = 'zhTW' AND `entry` = 5945;
-- OLD name : 女性海賊
-- Source : https://www.wowhead.com/wotlk/tw/npc=5948
UPDATE `creature_template_locale` SET `Name` = '女性海盜' WHERE `locale` = 'zhTW' AND `entry` = 5948;
-- OLD name : 男性海賊
-- Source : https://www.wowhead.com/wotlk/tw/npc=5949
UPDATE `creature_template_locale` SET `Name` = '男性海盜' WHERE `locale` = 'zhTW' AND `entry` = 5949;
-- OLD name : Shade (Deprecated)
-- Source : https://www.wowhead.com/wotlk/tw/npc=5954
UPDATE `creature_template_locale` SET `Name` = '影魔' WHERE `locale` = 'zhTW' AND `entry` = 5954;
-- OLD subname : 戰士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5959
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5959;
-- OLD subname : 盜賊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5960
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5960;
-- OLD subname : 法師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5961
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5961;
-- OLD subname : 術士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5962
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5962;
-- OLD subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5963
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5963;
-- OLD subname : 牧師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5964
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5964;
-- OLD subname : 薩滿訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5965
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5965;
-- OLD subname : 戰士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5966
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5966;
-- OLD subname : 戰士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5967
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5967;
-- OLD subname : 盜賊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5968
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5968;
-- OLD subname : 法師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5969
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5969;
-- OLD subname : 術士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5970
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5970;
-- OLD subname : 薩滿訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5971
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5971;
-- OLD subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5972
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5972;
-- OLD subname : 牧師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=5973
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 5973;
-- OLD name : 拾骨膽汁餵食者
-- Source : https://www.wowhead.com/wotlk/tw/npc=5983
UPDATE `creature_template_locale` SET `Name` = '拾骨者' WHERE `locale` = 'zhTW' AND `entry` = 5983;
-- OLD name : 飢餓的彎牙土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=5984
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5984;
-- OLD name : 彎牙土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=5985
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5985;
-- OLD name : 瘋狂的彎牙土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=5986
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 5986;
-- OLD name : 厚甲鞭尾蠍
-- Source : https://www.wowhead.com/wotlk/tw/npc=5989
UPDATE `creature_template_locale` SET `Name` = '厚甲長尾蠍' WHERE `locale` = 'zhTW' AND `entry` = 5989;
-- OLD name : 影誓祭儀師
-- Source : https://www.wowhead.com/wotlk/tw/npc=6004
UPDATE `creature_template_locale` SET `Name` = '影誓祭司' WHERE `locale` = 'zhTW' AND `entry` = 6004;
-- OLD name : 影誓織懼者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6009
UPDATE `creature_template_locale` SET `Name` = '影誓恐法師' WHERE `locale` = 'zhTW' AND `entry` = 6009;
-- OLD name : 惡魔守衛哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=6011
UPDATE `creature_template_locale` SET `Name` = '惡魔守衛哨兵' WHERE `locale` = 'zhTW' AND `entry` = 6011;
-- OLD name : [UNUSED]高茲文·粗鏈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=6046
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 6046;
-- OLD name : 水生守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6047
UPDATE `creature_template_locale` SET `Name` = '水中護衛' WHERE `locale` = 'zhTW' AND `entry` = 6047;
-- OLD name : [UNUSED]莫瑞特·赫里恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=6067
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 6067;
-- OLD name : 軍團獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=6071
UPDATE `creature_template_locale` SET `Name` = '惡魔指揮官' WHERE `locale` = 'zhTW' AND `entry` = 6071;
-- OLD name : 條紋霜刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=6074
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎（乳白色）' WHERE `locale` = 'zhTW' AND `entry` = 6074;
-- OLD name : 翡翠迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=6075
UPDATE `creature_template_locale` SET `Name` = '騎乘用迅猛龍（綠色）' WHERE `locale` = 'zhTW' AND `entry` = 6075;
-- OLD name : 騎乘用陸行鳥(白色)
-- Source : https://www.wowhead.com/wotlk/tw/npc=6076
UPDATE `creature_template_locale` SET `Name` = '騎乘用陸行鳥（黃色）' WHERE `locale` = 'zhTW' AND `entry` = 6076;
-- OLD name : 奧伯丁哨兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=6086
UPDATE `creature_template_locale` SET `Name` = '奧伯丁衛兵' WHERE `locale` = 'zhTW' AND `entry` = 6086;
-- OLD name : 德黎菈
-- Source : https://www.wowhead.com/wotlk/tw/npc=6091
UPDATE `creature_template_locale` SET `Name` = '德林拉爾' WHERE `locale` = 'zhTW' AND `entry` = 6091;
-- OLD name : 小型魅靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=6092
UPDATE `creature_template_locale` SET `Name` = '小型幻影' WHERE `locale` = 'zhTW' AND `entry` = 6092;
-- OLD name : 次級魅靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=6106
UPDATE `creature_template_locale` SET `Name` = '次級幻影' WHERE `locale` = 'zhTW' AND `entry` = 6106;
-- OLD name : 陰影
-- Source : https://www.wowhead.com/wotlk/tw/npc=6107
UPDATE `creature_template_locale` SET `Name` = '幻影' WHERE `locale` = 'zhTW' AND `entry` = 6107;
-- OLD name : 巨型魅靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=6108
UPDATE `creature_template_locale` SET `Name` = '巨型幻影' WHERE `locale` = 'zhTW' AND `entry` = 6108;
-- OLD name : 『黑暗縛靈師』加金
-- Source : https://www.wowhead.com/wotlk/tw/npc=6122
UPDATE `creature_template_locale` SET `Name` = '黑暗縛靈者加科因' WHERE `locale` = 'zhTW' AND `entry` = 6122;
-- OLD subname : 黑鐵上尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=6124
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 6124;
-- OLD name : 亞考羅克的僕從
-- Source : https://www.wowhead.com/wotlk/tw/npc=6143
UPDATE `creature_template_locale` SET `Name` = '阿考洛克的僕從' WHERE `locale` = 'zhTW' AND `entry` = 6143;
-- OLD name : 史蒂芬妮·特納
-- Source : https://www.wowhead.com/wotlk/tw/npc=6174
UPDATE `creature_template_locale` SET `Name` = '斯蒂芬妮·特納' WHERE `locale` = 'zhTW' AND `entry` = 6174;
-- OLD name : 迪菲亞劫掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6180
UPDATE `creature_template_locale` SET `Name` = '迪菲亞襲擊者' WHERE `locale` = 'zhTW' AND `entry` = 6180;
-- OLD name : [UNUSED] Briton Kilras (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=6183
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 6183;
-- OLD name : 木喉巢穴守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=6187
UPDATE `creature_template_locale` SET `Name` = '木喉守衛' WHERE `locale` = 'zhTW' AND `entry` = 6187;
-- OLD name : 惡鞭部屬
-- Source : https://www.wowhead.com/wotlk/tw/npc=6196
UPDATE `creature_template_locale` SET `Name` = '惡鞭侍從' WHERE `locale` = 'zhTW' AND `entry` = 6196;
-- OLD name : 惡鞭巫女
-- Source : https://www.wowhead.com/wotlk/tw/npc=6197
UPDATE `creature_template_locale` SET `Name` = '惡鞭巫師' WHERE `locale` = 'zhTW' AND `entry` = 6197;
-- OLD name : 洞窟掠取者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6210
UPDATE `creature_template_locale` SET `Name` = '洞窟搶劫者' WHERE `locale` = 'zhTW' AND `entry` = 6210;
-- OLD name : 洞窟劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6211
UPDATE `creature_template_locale` SET `Name` = '洞窟劫掠者' WHERE `locale` = 'zhTW' AND `entry` = 6211;
-- OLD name : 麻瘋防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6223
UPDATE `creature_template_locale` SET `Name` = '麻瘋防禦者' WHERE `locale` = 'zhTW' AND `entry` = 6223;
-- OLD name : 保安防護組件
-- Source : https://www.wowhead.com/wotlk/tw/npc=6230
UPDATE `creature_template_locale` SET `Name` = '動力保安裝甲' WHERE `locale` = 'zhTW' AND `entry` = 6230;
-- OLD name : 秘法剋星X-21
-- Source : https://www.wowhead.com/wotlk/tw/npc=6232
UPDATE `creature_template_locale` SET `Name` = '施法者剋星X-21' WHERE `locale` = 'zhTW' AND `entry` = 6232;
-- OLD name : 機械哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=6233
UPDATE `creature_template_locale` SET `Name` = '機械哨兵' WHERE `locale` = 'zhTW' AND `entry` = 6233;
-- OLD subname : 島民
-- Source : https://www.wowhead.com/wotlk/tw/npc=6236
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 6236;
-- OLD name : 挑戰者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6240
UPDATE `creature_template_locale` SET `Name` = '挑釁者' WHERE `locale` = 'zhTW' AND `entry` = 6240;
-- OLD subname : 剝皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=6242
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 6242;
-- OLD subname : 廣播員
-- Source : https://www.wowhead.com/wotlk/tw/npc=6248
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 6248;
-- OLD name : 侍僧瑪迦茲
-- Source : https://www.wowhead.com/wotlk/tw/npc=6252
UPDATE `creature_template_locale` SET `Name` = '隨從瑪迦茲' WHERE `locale` = 'zhTW' AND `entry` = 6252;
-- OLD name : 侍僧芬里克
-- Source : https://www.wowhead.com/wotlk/tw/npc=6253
UPDATE `creature_template_locale` SET `Name` = '隨從芬里克' WHERE `locale` = 'zhTW' AND `entry` = 6253;
-- OLD name : 侍僧溫圖拉
-- Source : https://www.wowhead.com/wotlk/tw/npc=6254
UPDATE `creature_template_locale` SET `Name` = '隨從溫圖拉' WHERE `locale` = 'zhTW' AND `entry` = 6254;
-- OLD name : 侍僧伯瑞納
-- Source : https://www.wowhead.com/wotlk/tw/npc=6267
UPDATE `creature_template_locale` SET `Name` = '助手伯瑞納' WHERE `locale` = 'zhTW' AND `entry` = 6267;
-- OLD name : 召喚的惡魔獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=6268
UPDATE `creature_template_locale` SET `Name` = '地獄獵犬' WHERE `locale` = 'zhTW' AND `entry` = 6268;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=6286
UPDATE `creature_template_locale` SET `Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 6286;
-- OLD subname : 剝皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=6295
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 6295;
-- OLD name : 艾麗薩·鋼手
-- Source : https://www.wowhead.com/wotlk/tw/npc=6300
UPDATE `creature_template_locale` SET `Name` = '艾麗薩·鋼拳' WHERE `locale` = 'zhTW' AND `entry` = 6300;
-- OLD subname : 獅鷲獸騎士
-- Source : https://www.wowhead.com/wotlk/tw/npc=6326
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 6326;
-- OLD subname : 獅鷲獸騎士
-- Source : https://www.wowhead.com/wotlk/tw/npc=6327
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 6327;
-- OLD name : 輻射掠取者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6329
UPDATE `creature_template_locale` SET `Name` = '輻射搶劫者' WHERE `locale` = 'zhTW' AND `entry` = 6329;
-- OLD name : 幼年碎浪多頭蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=6347
UPDATE `creature_template_locale` SET `Name` = '幼年碎浪多頭怪' WHERE `locale` = 'zhTW' AND `entry` = 6347;
-- OLD name : 雷首天颶
-- Source : https://www.wowhead.com/wotlk/tw/npc=6378
UPDATE `creature_template_locale` SET `Name` = '雷首天鳴者' WHERE `locale` = 'zhTW' AND `entry` = 6378;
-- OLD name : 亡靈守衛博迪瑞格
-- Source : https://www.wowhead.com/wotlk/tw/npc=6389
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵博迪瑞格' WHERE `locale` = 'zhTW' AND `entry` = 6389;
-- OLD name : 頑抗的戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=6391
UPDATE `creature_template_locale` SET `Name` = '躲起來的戰士' WHERE `locale` = 'zhTW' AND `entry` = 6391;
-- OLD name : 頑抗的醫師
-- Source : https://www.wowhead.com/wotlk/tw/npc=6392
UPDATE `creature_template_locale` SET `Name` = '躲起來的醫師' WHERE `locale` = 'zhTW' AND `entry` = 6392;
-- OLD name : 頑抗的技師
-- Source : https://www.wowhead.com/wotlk/tw/npc=6407
UPDATE `creature_template_locale` SET `Name` = '躲起來的技師' WHERE `locale` = 'zhTW' AND `entry` = 6407;
-- OLD name : 黑色骸骨戰馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=6486
UPDATE `creature_template_locale` SET `Name` = '騎乘用骸骨戰馬 (黑色)' WHERE `locale` = 'zhTW' AND `entry` = 6486;
-- OLD name : Brivelthwerp
-- Source : https://www.wowhead.com/wotlk/tw/npc=6496
UPDATE `creature_template_locale` SET `Name` = '布里維普' WHERE `locale` = 'zhTW' AND `entry` = 6496;
-- OLD name : 血瓣花陷捕者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6512
UPDATE `creature_template_locale` SET `Name` = '血瓣花捕獸者' WHERE `locale` = 'zhTW' AND `entry` = 6512;
-- OLD name : 黑鐵步槍兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=6523
UPDATE `creature_template_locale` SET `Name` = '黑鐵火槍手' WHERE `locale` = 'zhTW' AND `entry` = 6523;
-- OLD name : 焦油蠕行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6527
UPDATE `creature_template_locale` SET `Name` = '焦油爬行者' WHERE `locale` = 'zhTW' AND `entry` = 6527;
-- OLD name : 格里什劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6553
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 6553;
-- OLD name : 黏稠的軟泥怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=6559
UPDATE `creature_template_locale` SET `Name` = '粘稠的軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 6559;
-- OLD name : 石頭守望者
-- Source : https://www.wowhead.com/wotlk/tw/npc=6561
UPDATE `creature_template_locale` SET `Name` = '石頭看守者' WHERE `locale` = 'zhTW' AND `entry` = 6561;
-- OLD name : 獵豹形態(夜精靈德魯伊)
-- Source : https://www.wowhead.com/wotlk/tw/npc=6571
UPDATE `creature_template_locale` SET `Name` = '獵豹形態 (夜精靈德魯伊)' WHERE `locale` = 'zhTW' AND `entry` = 6571;
-- OLD name : 獵豹形態(牛頭人德魯伊)
-- Source : https://www.wowhead.com/wotlk/tw/npc=6572
UPDATE `creature_template_locale` SET `Name` = '獵豹形態 (牛頭人德魯伊)' WHERE `locale` = 'zhTW' AND `entry` = 6572;
-- OLD name : 血色受訓員
-- Source : https://www.wowhead.com/wotlk/tw/npc=6575
UPDATE `creature_template_locale` SET `Name` = '血色預備兵' WHERE `locale` = 'zhTW' AND `entry` = 6575;
-- OLD name : 賓格斯·布萊頓海默
-- Source : https://www.wowhead.com/wotlk/tw/npc=6577
UPDATE `creature_template_locale` SET `Name` = '賓格斯·布拉斯坦海默' WHERE `locale` = 'zhTW' AND `entry` = 6577;
-- OLD name : 農民 (木柴)
-- Source : https://www.wowhead.com/wotlk/tw/npc=6578
UPDATE `creature_template_locale` SET `Name` = '農夫 (木柴)' WHERE `locale` = 'zhTW' AND `entry` = 6578;
-- OLD name : 薩瓦絲女王
-- Source : https://www.wowhead.com/wotlk/tw/npc=6582
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 6582;
-- OLD name : 暴龍之王莫什
-- Source : https://www.wowhead.com/wotlk/tw/npc=6584
UPDATE `creature_template_locale` SET `Name` = '暴龍之王摩什' WHERE `locale` = 'zhTW' AND `entry` = 6584;
-- OLD name : 大膽的強森
-- Source : https://www.wowhead.com/wotlk/tw/npc=6626
UPDATE `creature_template_locale` SET `Name` = '大膽的約翰森' WHERE `locale` = 'zhTW' AND `entry` = 6626;
-- OLD name : 守門者暴吼
-- Source : https://www.wowhead.com/wotlk/tw/npc=6651
UPDATE `creature_template_locale` SET `Name` = '拉格羅爾' WHERE `locale` = 'zhTW' AND `entry` = 6651;
-- OLD name : 強森的人類形態
-- Source : https://www.wowhead.com/wotlk/tw/npc=6666
UPDATE `creature_template_locale` SET `Name` = '約翰森的人類形態' WHERE `locale` = 'zhTW' AND `entry` = 6666;
-- OLD name : Jinky Twizzlefixxit
-- Source : https://www.wowhead.com/wotlk/tw/npc=6730
UPDATE `creature_template_locale` SET `Name` = '金克·鐵鉤' WHERE `locale` = 'zhTW' AND `entry` = 6730;
-- OLD name : 哈魯恩·暗織, subname : 製皮供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=6731
UPDATE `creature_template_locale` SET `Name` = '哈魯恩·暗紋',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 6731;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=6737
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 6737;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=6741
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 6741;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=6746
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 6746;
-- OLD name : 拉文霍德守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=6766
UPDATE `creature_template_locale` SET `Name` = '拉文霍德衛兵' WHERE `locale` = 'zhTW' AND `entry` = 6766;
-- OLD subname : 刺客聯盟宗師
-- Source : https://www.wowhead.com/wotlk/tw/npc=6767
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 6767;
-- OLD name : [UNUSED]羅瑞克·貝爾姆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=6783
UPDATE `creature_template_locale` SET `Name` = 'Gorgrond Smokebelcher Depot NPC Invisible Stalker "Our Gun''s Bigger" Quest Target ELM' WHERE `locale` = 'zhTW' AND `entry` = 6783;
-- OLD name : 旅店老闆崔萊妮
-- Source : https://www.wowhead.com/wotlk/tw/npc=6790
UPDATE `creature_template_locale` SET `Name` = '旅店老闆崔萊尼' WHERE `locale` = 'zhTW' AND `entry` = 6790;
-- OLD name : 海濱螃蟹
-- Source : https://www.wowhead.com/wotlk/tw/npc=6827
UPDATE `creature_template_locale` SET `Name` = '螃蟹' WHERE `locale` = 'zhTW' AND `entry` = 6827;
-- OLD name : 碼頭管理員
-- Source : https://www.wowhead.com/wotlk/tw/npc=6846
UPDATE `creature_template_locale` SET `Name` = '迪菲亞碼頭主管' WHERE `locale` = 'zhTW' AND `entry` = 6846;
-- OLD name : 尋跡犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=6867
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 6867;
-- OLD name : 雅爾達
-- Source : https://www.wowhead.com/wotlk/tw/npc=6887
UPDATE `creature_template_locale` SET `Name` = '哈爾倫' WHERE `locale` = 'zhTW' AND `entry` = 6887;
-- OLD name : 碼頭工人
-- Source : https://www.wowhead.com/wotlk/tw/npc=6927
UPDATE `creature_template_locale` SET `Name` = '迪菲亞碼頭工人' WHERE `locale` = 'zhTW' AND `entry` = 6927;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=6929
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 6929;
-- OLD subname : Free Bug 001
-- Source : https://www.wowhead.com/wotlk/tw/npc=6931
UPDATE `creature_template_locale` SET `Title` = 'Bug 001' WHERE `locale` = 'zhTW' AND `entry` = 6931;
-- OLD name : 黑石劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7008
UPDATE `creature_template_locale` SET `Name` = '黑石劫掠者' WHERE `locale` = 'zhTW' AND `entry` = 7008;
-- OLD name : 黑石守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=7013
UPDATE `creature_template_locale` SET `Name` = '黑石狂暴者' WHERE `locale` = 'zhTW' AND `entry` = 7013;
-- OLD name : 影爐地質學家
-- Source : https://www.wowhead.com/wotlk/tw/npc=7030
UPDATE `creature_template_locale` SET `Name` = '暗爐地質學家' WHERE `locale` = 'zhTW' AND `entry` = 7030;
-- OLD name : 戰爭劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7039
UPDATE `creature_template_locale` SET `Name` = '戰爭搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 7039;
-- OLD name : 迪菲亞閒工
-- Source : https://www.wowhead.com/wotlk/tw/npc=7050
UPDATE `creature_template_locale` SET `Name` = '迪菲亞苦工' WHERE `locale` = 'zhTW' AND `entry` = 7050;
-- OLD name : 醜陋的迪菲亞閒工
-- Source : https://www.wowhead.com/wotlk/tw/npc=7051
UPDATE `creature_template_locale` SET `Name` = '醜陋的迪菲亞懶漢' WHERE `locale` = 'zhTW' AND `entry` = 7051;
-- OLD name : 迪菲亞哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=7056
UPDATE `creature_template_locale` SET `Name` = '迪菲亞哨兵' WHERE `locale` = 'zhTW' AND `entry` = 7056;
-- OLD name : 風險投資公司閒工
-- Source : https://www.wowhead.com/wotlk/tw/npc=7067
UPDATE `creature_template_locale` SET `Name` = '風險投資公司雄蜂' WHERE `locale` = 'zhTW' AND `entry` = 7067;
-- OLD name : 有罪的教士
-- Source : https://www.wowhead.com/wotlk/tw/npc=7070
UPDATE `creature_template_locale` SET `Name` = '有罪的牧師' WHERE `locale` = 'zhTW' AND `entry` = 7070;
-- OLD name : 被詛咒的阿拉杜斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=7073
UPDATE `creature_template_locale` SET `Name` = '可憎的阿拉杜斯' WHERE `locale` = 'zhTW' AND `entry` = 7073;
-- OLD name : 黏性輻射塵
-- Source : https://www.wowhead.com/wotlk/tw/npc=7079
UPDATE `creature_template_locale` SET `Name` = '粘性輻射塵' WHERE `locale` = 'zhTW' AND `entry` = 7079;
-- OLD name : 影爐伏擊者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7091
UPDATE `creature_template_locale` SET `Name` = '暗爐伏擊者' WHERE `locale` = 'zhTW' AND `entry` = 7091;
-- OLD name : 加德納爾教徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=7112
UPDATE `creature_template_locale` SET `Name` = '加德納爾祭司' WHERE `locale` = 'zhTW' AND `entry` = 7112;
-- OLD name : 加德納爾織懼者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7116
UPDATE `creature_template_locale` SET `Name` = '加德納爾恐怖法師' WHERE `locale` = 'zhTW' AND `entry` = 7116;
-- OLD name : 加德納爾暗織者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7118
UPDATE `creature_template_locale` SET `Name` = '加德納爾暗法師' WHERE `locale` = 'zhTW' AND `entry` = 7118;
-- OLD name : 暗影議會大領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=7124
UPDATE `creature_template_locale` SET `Name` = '暗影議會成員' WHERE `locale` = 'zhTW' AND `entry` = 7124;
-- OLD name : 加德納爾潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7127
UPDATE `creature_template_locale` SET `Name` = '加德納爾捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 7127;
-- OLD name : 加德納爾噬法犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=7128
UPDATE `creature_template_locale` SET `Name` = '加德納爾噬魔犬' WHERE `locale` = 'zhTW' AND `entry` = 7128;
-- OLD name : 被奴役的虛無行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7129
UPDATE `creature_template_locale` SET `Name` = '被奴役的虛空行者' WHERE `locale` = 'zhTW' AND `entry` = 7129;
-- OLD name : 虛無行者奴僕
-- Source : https://www.wowhead.com/wotlk/tw/npc=7130
UPDATE `creature_template_locale` SET `Name` = '虛空行者奴僕' WHERE `locale` = 'zhTW' AND `entry` = 7130;
-- OLD name : 虛無行者守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7131
UPDATE `creature_template_locale` SET `Name` = '虛空行者守衛' WHERE `locale` = 'zhTW' AND `entry` = 7131;
-- OLD name : 毒性撕掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7134
UPDATE `creature_template_locale` SET `Name` = '毒性掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 7134;
-- OLD name : 煉獄火保鏢
-- Source : https://www.wowhead.com/wotlk/tw/npc=7135
UPDATE `creature_template_locale` SET `Name` = '地獄火保鏢' WHERE `locale` = 'zhTW' AND `entry` = 7135;
-- OLD name : 煉獄火哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=7136
UPDATE `creature_template_locale` SET `Name` = '地獄火哨兵' WHERE `locale` = 'zhTW' AND `entry` = 7136;
-- OLD name : 凋零的樹人
-- Source : https://www.wowhead.com/wotlk/tw/npc=7143
UPDATE `creature_template_locale` SET `Name` = '腐朽的樹人' WHERE `locale` = 'zhTW' AND `entry` = 7143;
-- OLD name : 枯萎的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7150
UPDATE `creature_template_locale` SET `Name` = '枯萎的守衛者' WHERE `locale` = 'zhTW' AND `entry` = 7150;
-- OLD name : 死木巢穴守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=7156
UPDATE `creature_template_locale` SET `Name` = '死木守衛' WHERE `locale` = 'zhTW' AND `entry` = 7156;
-- OLD name : 諾甘農博識者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7172
UPDATE `creature_template_locale` SET `Name` = '諾甘農的看門人' WHERE `locale` = 'zhTW' AND `entry` = 7172;
-- OLD subname : 武器鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7173
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7173;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7174
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7174;
-- OLD name : 上古石之守衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7206
UPDATE `creature_template_locale` SET `Name` = '古代的石頭看守者' WHERE `locale` = 'zhTW' AND `entry` = 7206;
-- OLD name : 蔚藍龍裔
-- Source : https://www.wowhead.com/wotlk/tw/npc=7227
UPDATE `creature_template_locale` SET `Name` = '蔚藍龍人' WHERE `locale` = 'zhTW' AND `entry` = 7227;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7230
UPDATE `creature_template_locale` SET `Title` = '護甲鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 7230;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7231
UPDATE `creature_template_locale` SET `Title` = '武器鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 7231;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7232
UPDATE `creature_template_locale` SET `Title` = '武器鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 7232;
-- OLD name : 監工費蘇勒
-- Source : https://www.wowhead.com/wotlk/tw/npc=7233
UPDATE `creature_template_locale` SET `Name` = '工頭費蘇勒' WHERE `locale` = 'zhTW' AND `entry` = 7233;
-- OLD name : 瘤背秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=7235
UPDATE `creature_template_locale` SET `Name` = '瘤背秘法師' WHERE `locale` = 'zhTW' AND `entry` = 7235;
-- OLD subname : 測試
-- Source : https://www.wowhead.com/wotlk/tw/npc=7236
UPDATE `creature_template_locale` SET `Title` = 'a test, don''t bug me' WHERE `locale` = 'zhTW' AND `entry` = 7236;
-- OLD name : 沙怒守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7268
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 7268;
-- OLD name : 影爐狙擊手
-- Source : https://www.wowhead.com/wotlk/tw/npc=7290
UPDATE `creature_template_locale` SET `Name` = '暗爐狙擊手' WHERE `locale` = 'zhTW' AND `entry` = 7290;
-- OLD name : [UNUSED]德拉伊 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=7293
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 7293;
-- OLD name : 風險投資公司看守者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7307
UPDATE `creature_template_locale` SET `Name` = '風險投資公司看守' WHERE `locale` = 'zhTW' AND `entry` = 7307;
-- OLD name : 變異風險投資公司閒工
-- Source : https://www.wowhead.com/wotlk/tw/npc=7310
UPDATE `creature_template_locale` SET `Name` = '變異風險投資公司工人' WHERE `locale` = 'zhTW' AND `entry` = 7310;
-- OLD subname : 戰場軍官
-- Source : https://www.wowhead.com/wotlk/tw/npc=7314
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7314;
-- OLD name : 薩絲拉女士
-- Source : https://www.wowhead.com/wotlk/tw/npc=7319
UPDATE `creature_template_locale` SET `Name` = '薩絲拉' WHERE `locale` = 'zhTW' AND `entry` = 7319;
-- OLD name : 石窟織焰者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7321
UPDATE `creature_template_locale` SET `Name` = '石窟織炎者' WHERE `locale` = 'zhTW' AND `entry` = 7321;
-- OLD name : 黑色夜刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=7322
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎（黑色）' WHERE `locale` = 'zhTW' AND `entry` = 7322;
-- OLD name : 康大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7325
UPDATE `creature_template_locale` SET `Name` = '康恩' WHERE `locale` = 'zhTW' AND `entry` = 7325;
-- OLD name : 憔悴的劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7328
UPDATE `creature_template_locale` SET `Name` = '憔悴的搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 7328;
-- OLD name : 骷髏暗影施法者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7340
UPDATE `creature_template_locale` SET `Name` = '骷髏暗影法師' WHERE `locale` = 'zhTW' AND `entry` = 7340;
-- OLD name : 骷髏織霜者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7341
UPDATE `creature_template_locale` SET `Name` = '骷髏冰霜法師' WHERE `locale` = 'zhTW' AND `entry` = 7341;
-- OLD name : 墓穴魔蛛
-- Source : https://www.wowhead.com/wotlk/tw/npc=7349
UPDATE `creature_template_locale` SET `Name` = '墓穴魔' WHERE `locale` = 'zhTW' AND `entry` = 7349;
-- OLD name : 墓穴劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7351
UPDATE `creature_template_locale` SET `Name` = '墓穴搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 7351;
-- OLD name : 無瑕的德萊尼水晶球
-- Source : https://www.wowhead.com/wotlk/tw/npc=7364
UPDATE `creature_template_locale` SET `Name` = '無暇的德萊尼水晶球' WHERE `locale` = 'zhTW' AND `entry` = 7364;
-- OLD name : 無瑕的德萊尼水晶碎片
-- Source : https://www.wowhead.com/wotlk/tw/npc=7365
UPDATE `creature_template_locale` SET `Name` = '無暇的德萊尼水晶碎片' WHERE `locale` = 'zhTW' AND `entry` = 7365;
-- OLD name : 尋仇的怨靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=7374
UPDATE `creature_template_locale` SET `Name` = '尋仇的鬼魂' WHERE `locale` = 'zhTW' AND `entry` = 7374;
-- OLD name : 憤怒之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=7375
UPDATE `creature_template_locale` SET `Name` = '憤怒之魂' WHERE `locale` = 'zhTW' AND `entry` = 7375;
-- OLD name : 末日劫毀者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7377
UPDATE `creature_template_locale` SET `Name` = '末日破壞者' WHERE `locale` = 'zhTW' AND `entry` = 7377;
-- OLD name : 暹羅貓
-- Source : https://www.wowhead.com/wotlk/tw/npc=7380
UPDATE `creature_template_locale` SET `Name` = '黑尾白貓' WHERE `locale` = 'zhTW' AND `entry` = 7380;
-- OLD name : 銀色虎斑貓
-- Source : https://www.wowhead.com/wotlk/tw/npc=7381
UPDATE `creature_template_locale` SET `Name` = '黑斑白貓' WHERE `locale` = 'zhTW' AND `entry` = 7381;
-- OLD name : 橘色虎斑貓
-- Source : https://www.wowhead.com/wotlk/tw/npc=7382
UPDATE `creature_template_locale` SET `Name` = '虎皮貓' WHERE `locale` = 'zhTW' AND `entry` = 7382;
-- OLD name : 黑色虎斑貓
-- Source : https://www.wowhead.com/wotlk/tw/npc=7383
UPDATE `creature_template_locale` SET `Name` = '黑紋灰貓' WHERE `locale` = 'zhTW' AND `entry` = 7383;
-- OLD name : 孟買貓
-- Source : https://www.wowhead.com/wotlk/tw/npc=7385
UPDATE `creature_template_locale` SET `Name` = '灰貓' WHERE `locale` = 'zhTW' AND `entry` = 7385;
-- OLD name : 幽暗城蟑螂
-- Source : https://www.wowhead.com/wotlk/tw/npc=7395
UPDATE `creature_template_locale` SET `Name` = '蟑螂' WHERE `locale` = 'zhTW' AND `entry` = 7395;
-- OLD name : 土靈碎石者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7396
UPDATE `creature_template_locale` SET `Name` = '土靈破石者' WHERE `locale` = 'zhTW' AND `entry` = 7396;
-- OLD name : Galak Flame Guard
-- Source : https://www.wowhead.com/wotlk/tw/npc=7404
UPDATE `creature_template_locale` SET `Name` = '加拉克烈焰守衛' WHERE `locale` = 'zhTW' AND `entry` = 7404;
-- OLD name : 首席工程師膨嘯
-- Source : https://www.wowhead.com/wotlk/tw/npc=7407
UPDATE `creature_template_locale` SET `Name` = '首席工程師比格維茲' WHERE `locale` = 'zhTW' AND `entry` = 7407;
-- OLD name : 薩絲拉之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=7411
UPDATE `creature_template_locale` SET `Name` = '薩絲拉之魂' WHERE `locale` = 'zhTW' AND `entry` = 7411;
-- OLD name : 鈷藍龍人
-- Source : https://www.wowhead.com/wotlk/tw/npc=7435
UPDATE `creature_template_locale` SET `Name` = '深藍色龍人' WHERE `locale` = 'zhTW' AND `entry` = 7435;
-- OLD name : 鈷藍逆鱗龍人
-- Source : https://www.wowhead.com/wotlk/tw/npc=7436
UPDATE `creature_template_locale` SET `Name` = '深藍色逆鱗龍人' WHERE `locale` = 'zhTW' AND `entry` = 7436;
-- OLD name : 鈷藍龍人法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7437
UPDATE `creature_template_locale` SET `Name` = '深藍色龍人法師' WHERE `locale` = 'zhTW' AND `entry` = 7437;
-- OLD name : 盛怒的梟獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=7451
UPDATE `creature_template_locale` SET `Name` = '狂怒的梟獸' WHERE `locale` = 'zhTW' AND `entry` = 7451;
-- OLD name : 月觸梟獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=7453
UPDATE `creature_template_locale` SET `Name` = '月光梟獸' WHERE `locale` = 'zhTW' AND `entry` = 7453;
-- OLD name : 赫達琳法力獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=7462
UPDATE `creature_template_locale` SET `Name` = '赫達琳魔行者' WHERE `locale` = 'zhTW' AND `entry` = 7462;
-- OLD subname : 法師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7488
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7488;
-- OLD name : 銀松森林亡靈守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=7489
UPDATE `creature_template_locale` SET `Name` = '銀松森林亡靈衛兵' WHERE `locale` = 'zhTW' AND `entry` = 7489;
-- OLD name : 世界製皮龍麟訓練師(NO LONGER IMPLEMENTED), subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7525
UPDATE `creature_template_locale` SET `Name` = '世界製皮龍麟訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7525;
-- OLD subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7526
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7526;
-- OLD name : 世界製皮部族訓練師(NO LONGER WORKING), subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7528
UPDATE `creature_template_locale` SET `Name` = '世界製皮部族訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7528;
-- OLD name : 翡翠龍寶寶
-- Source : https://www.wowhead.com/wotlk/tw/npc=7545
UPDATE `creature_template_locale` SET `Name` = '綠龍寶寶' WHERE `locale` = 'zhTW' AND `entry` = 7545;
-- OLD name : Cottontail Rabbit
-- Source : https://www.wowhead.com/wotlk/tw/npc=7558
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 7558;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7558, 'zhTW','黃毛兔',NULL);
-- OLD name : Spotted Rabbit
-- Source : https://www.wowhead.com/wotlk/tw/npc=7559
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 7559;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7559, 'zhTW','斑點兔',NULL);
-- OLD name : 白腳兔
-- Source : https://www.wowhead.com/wotlk/tw/npc=7560
UPDATE `creature_template_locale` SET `Name` = '黃紋兔' WHERE `locale` = 'zhTW' AND `entry` = 7560;
-- OLD name : 白化蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=7561
UPDATE `creature_template_locale` SET `Name` = '白鱗蛇' WHERE `locale` = 'zhTW' AND `entry` = 7561;
-- OLD name : 精靈幽光
-- Source : https://www.wowhead.com/wotlk/tw/npc=7570
UPDATE `creature_template_locale` SET `Name` = '小精靈' WHERE `locale` = 'zhTW' AND `entry` = 7570;
-- OLD name : Slim's Test Death Knight
-- Source : https://www.wowhead.com/wotlk/tw/npc=7624
UPDATE `creature_template_locale` SET `Name` = 'Test Death Knight' WHERE `locale` = 'zhTW' AND `entry` = 7624;
-- OLD name : 豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=7684
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎（黃色）' WHERE `locale` = 'zhTW' AND `entry` = 7684;
-- OLD name : 孟加拉虎
-- Source : https://www.wowhead.com/wotlk/tw/npc=7686
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎（紅色）' WHERE `locale` = 'zhTW' AND `entry` = 7686;
-- OLD name : 斑點霜刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=7687
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎（雪白色）' WHERE `locale` = 'zhTW' AND `entry` = 7687;
-- OLD name : 斑點夜刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=7689
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎（黑色斑點）' WHERE `locale` = 'zhTW' AND `entry` = 7689;
-- OLD name : 條紋夜刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=7690
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎（黑色斑紋）' WHERE `locale` = 'zhTW' AND `entry` = 7690;
-- OLD name : 黑色迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=7703
UPDATE `creature_template_locale` SET `Name` = '騎乘用迅猛龍（黑色）' WHERE `locale` = 'zhTW' AND `entry` = 7703;
-- OLD name : 雜斑紅色迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=7704
UPDATE `creature_template_locale` SET `Name` = '騎乘用迅猛龍（紅色）' WHERE `locale` = 'zhTW' AND `entry` = 7704;
-- OLD name : 白色迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=7706
UPDATE `creature_template_locale` SET `Name` = '騎乘用迅猛龍（黃色）' WHERE `locale` = 'zhTW' AND `entry` = 7706;
-- OLD name : 青色迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=7707
UPDATE `creature_template_locale` SET `Name` = '騎乘用迅猛龍（綠色）' WHERE `locale` = 'zhTW' AND `entry` = 7707;
-- OLD name : 紫色迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=7708
UPDATE `creature_template_locale` SET `Name` = '騎乘用迅猛龍（紫色）' WHERE `locale` = 'zhTW' AND `entry` = 7708;
-- OLD name : 騎乘用陸行鳥(棕色)
-- Source : https://www.wowhead.com/wotlk/tw/npc=7709
UPDATE `creature_template_locale` SET `Name` = '騎乘用陸行鳥（棕色）' WHERE `locale` = 'zhTW' AND `entry` = 7709;
-- OLD name : 騎乘用陸行鳥(灰色)
-- Source : https://www.wowhead.com/wotlk/tw/npc=7710
UPDATE `creature_template_locale` SET `Name` = '騎乘用陸行鳥（灰色）' WHERE `locale` = 'zhTW' AND `entry` = 7710;
-- OLD name : 騎乘用陸行鳥(粉紅色)
-- Source : https://www.wowhead.com/wotlk/tw/npc=7711
UPDATE `creature_template_locale` SET `Name` = '騎乘用陸行鳥（粉色）' WHERE `locale` = 'zhTW' AND `entry` = 7711;
-- OLD name : 騎乘用陸行鳥(紫色)
-- Source : https://www.wowhead.com/wotlk/tw/npc=7712
UPDATE `creature_template_locale` SET `Name` = '騎乘用陸行鳥（紫色）' WHERE `locale` = 'zhTW' AND `entry` = 7712;
-- OLD name : 騎乘用陸行鳥(綠色)
-- Source : https://www.wowhead.com/wotlk/tw/npc=7713
UPDATE `creature_template_locale` SET `Name` = '騎乘用陸行鳥（綠色）' WHERE `locale` = 'zhTW' AND `entry` = 7713;
-- OLD name : 比魯拉, subname : 前旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=7714
UPDATE `creature_template_locale` SET `Name` = '旅店老闆比魯拉',`Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 7714;
-- OLD name : 高級勘測員菲茲杜瑟
-- Source : https://www.wowhead.com/wotlk/tw/npc=7724
UPDATE `creature_template_locale` SET `Name` = '高級勘探員菲茲杜瑟' WHERE `locale` = 'zhTW' AND `entry` = 7724;
-- OLD name : 石爪蠻兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=7730
UPDATE `creature_template_locale` SET `Name` = '石爪山蠻兵' WHERE `locale` = 'zhTW' AND `entry` = 7730;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=7731
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 7731;
-- OLD subname : 靈魂守衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7734
UPDATE `creature_template_locale` SET `Title` = '靈魂守護者' WHERE `locale` = 'zhTW' AND `entry` = 7734;
-- OLD name : 紅色機械陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=7739
UPDATE `creature_template_locale` SET `Name` = '騎乘用機械陸行鳥（黃色）' WHERE `locale` = 'zhTW' AND `entry` = 7739;
-- OLD name : 世界不死族骸骨戰馬騎術訓練師, subname : 亡靈馬騎術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7743
UPDATE `creature_template_locale` SET `Name` = '世界不死族骸骨戰馬騎乘訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7743;
-- OLD name : 世界迅猛龍騎術訓練師, subname : 迅猛龍騎術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7745
UPDATE `creature_template_locale` SET `Name` = '世界迅猛龍騎乘訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7745;
-- OLD name : 世界機械陸行鳥騎術訓練師, subname : 機械陸行鳥騎術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7746
UPDATE `creature_template_locale` SET `Name` = '世界機械陸行鳥騎乘訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7746;
-- OLD subname : 坐騎商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=7747
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7747;
-- OLD subname : 養馬人
-- Source : https://www.wowhead.com/wotlk/tw/npc=7748
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7748;
-- OLD name : 藍色機械陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=7749
UPDATE `creature_template_locale` SET `Name` = '騎乘用機械陸行鳥（藍色）' WHERE `locale` = 'zhTW' AND `entry` = 7749;
-- OLD name : 溫基
-- Source : https://www.wowhead.com/wotlk/tw/npc=7770
UPDATE `creature_template_locale` SET `Name` = '維克' WHERE `locale` = 'zhTW' AND `entry` = 7770;
-- OLD name : 『殉教者』塞卡變形
-- Source : https://www.wowhead.com/wotlk/tw/npc=7791
UPDATE `creature_template_locale` SET `Name` = '瑟卡' WHERE `locale` = 'zhTW' AND `entry` = 7791;
-- OLD name : 耐克倫·嚼腸者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7796
UPDATE `creature_template_locale` SET `Name` = '耐克魯姆' WHERE `locale` = 'zhTW' AND `entry` = 7796;
-- OLD name : 機電師瑟瑪普拉格
-- Source : https://www.wowhead.com/wotlk/tw/npc=7800
UPDATE `creature_template_locale` SET `Name` = '麥克尼爾·瑟瑪普拉格' WHERE `locale` = 'zhTW' AND `entry` = 7800;
-- OLD name : 南海掠劫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7856
UPDATE `creature_template_locale` SET `Name` = '南海劫掠者' WHERE `locale` = 'zhTW' AND `entry` = 7856;
-- OLD name : 蠻錘哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=7865
UPDATE `creature_template_locale` SET `Name` = '蠻錘哨兵' WHERE `locale` = 'zhTW' AND `entry` = 7865;
-- OLD subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7866
UPDATE `creature_template_locale` SET `Title` = '龍鱗製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 7866;
-- OLD subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7867
UPDATE `creature_template_locale` SET `Title` = '龍鱗製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 7867;
-- OLD subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7868
UPDATE `creature_template_locale` SET `Title` = '元素製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 7868;
-- OLD name : 布魯姆·冬蹄, subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7869
UPDATE `creature_template_locale` SET `Name` = '布魯姆·冰蹄',`Title` = '元素製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 7869;
-- OLD subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7870
UPDATE `creature_template_locale` SET `Title` = '部族製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 7870;
-- OLD subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7871
UPDATE `creature_template_locale` SET `Title` = '部族製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 7871;
-- OLD name : 剃刀沼澤戰地衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=7873
UPDATE `creature_template_locale` SET `Name` = '剃刀沼澤護衛者' WHERE `locale` = 'zhTW' AND `entry` = 7873;
-- OLD name : 奎恩提斯·炎癮
-- Source : https://www.wowhead.com/wotlk/tw/npc=7879
UPDATE `creature_template_locale` SET `Name` = '奎恩提斯' WHERE `locale` = 'zhTW' AND `entry` = 7879;
-- OLD name : 安全主管膨嘯
-- Source : https://www.wowhead.com/wotlk/tw/npc=7882
UPDATE `creature_template_locale` SET `Name` = '安全主管比格維茲' WHERE `locale` = 'zhTW' AND `entry` = 7882;
-- OLD name : 弗拉加爾·雷皮
-- Source : https://www.wowhead.com/wotlk/tw/npc=7884
UPDATE `creature_template_locale` SET `Name` = '弗拉加爾' WHERE `locale` = 'zhTW' AND `entry` = 7884;
-- OLD name : 南海海盜
-- Source : https://www.wowhead.com/wotlk/tw/npc=7896
UPDATE `creature_template_locale` SET `Name` = '南海冒險家' WHERE `locale` = 'zhTW' AND `entry` = 7896;
-- OLD name : 海賊寶藏觸發器怪物
-- Source : https://www.wowhead.com/wotlk/tw/npc=7898
UPDATE `creature_template_locale` SET `Name` = '海盜寶藏觸發器怪物' WHERE `locale` = 'zhTW' AND `entry` = 7898;
-- OLD name : 閃金鎮守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=7906
UPDATE `creature_template_locale` SET `Name` = '閃金鎮衛兵' WHERE `locale` = 'zhTW' AND `entry` = 7906;
-- OLD name : 諾甘農的石之看守者
-- Source : https://www.wowhead.com/wotlk/tw/npc=7918
UPDATE `creature_template_locale` SET `Name` = '諾甘農的石衛兵' WHERE `locale` = 'zhTW' AND `entry` = 7918;
-- OLD name : 諾姆瑞根 - Matrix Punchograph 3005-A
-- Source : https://www.wowhead.com/wotlk/tw/npc=7919
UPDATE `creature_template_locale` SET `Name` = '諾姆瑞根 - 母體Punchograph 3005-A' WHERE `locale` = 'zhTW' AND `entry` = 7919;
-- OLD name : 大工匠梅卡托克
-- Source : https://www.wowhead.com/wotlk/tw/npc=7937
UPDATE `creature_template_locale` SET `Name` = '高等技工梅卡托克' WHERE `locale` = 'zhTW' AND `entry` = 7937;
-- OLD subname : 迅猛龍飼養員
-- Source : https://www.wowhead.com/wotlk/tw/npc=7952
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7952;
-- OLD name : 札爾提, subname : 騎術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7953
UPDATE `creature_template_locale` SET `Name` = '克薩爾迪',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 7953;
-- OLD subname : 騎術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=7954
UPDATE `creature_template_locale` SET `Title` = '機械陸行鳥駕駛員' WHERE `locale` = 'zhTW' AND `entry` = 7954;
-- OLD name : 納拉其營地勇士
-- Source : https://www.wowhead.com/wotlk/tw/npc=7975
UPDATE `creature_template_locale` SET `Name` = '莫高雷衛士' WHERE `locale` = 'zhTW' AND `entry` = 7975;
-- OLD name : 精英亡靈守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=7980
UPDATE `creature_template_locale` SET `Name` = '精英亡靈衛兵' WHERE `locale` = 'zhTW' AND `entry` = 7980;
-- OLD name : 『守衛者』奇爾嘉
-- Source : https://www.wowhead.com/wotlk/tw/npc=7996
UPDATE `creature_template_locale` SET `Name` = '『守護者』奇爾加' WHERE `locale` = 'zhTW' AND `entry` = 7996;
-- OLD name : 爆破專家艾米·短路
-- Source : https://www.wowhead.com/wotlk/tw/npc=7998
UPDATE `creature_template_locale` SET `Name` = '爆破專家艾米·短線' WHERE `locale` = 'zhTW' AND `entry` = 7998;
-- OLD name : 貧瘠之地守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=8016
UPDATE `creature_template_locale` SET `Name` = '貧瘠之地衛兵' WHERE `locale` = 'zhTW' AND `entry` = 8016;
-- OLD name : 森金村守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8017
UPDATE `creature_template_locale` SET `Name` = '森金村守衛者' WHERE `locale` = 'zhTW' AND `entry` = 8017;
-- OLD name : 蘇薩斯沙行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8095
UPDATE `creature_template_locale` SET `Name` = '蘇利薩斯沙行者' WHERE `locale` = 'zhTW' AND `entry` = 8095;
-- OLD name : 西荒兵團守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=8096
UPDATE `creature_template_locale` SET `Name` = '人民軍衛兵' WHERE `locale` = 'zhTW' AND `entry` = 8096;
-- OLD subname : 節日煙火商
-- Source : https://www.wowhead.com/wotlk/tw/npc=8116
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8116;
-- OLD name : 維茲班恩·轟鳴, subname : 節日煙火商
-- Source : https://www.wowhead.com/wotlk/tw/npc=8117
UPDATE `creature_template_locale` SET `Name` = '維茲班',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8117;
-- OLD subname : 節日煙火商
-- Source : https://www.wowhead.com/wotlk/tw/npc=8118
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8118;
-- OLD name : 蘇薩斯憎惡獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=8120
UPDATE `creature_template_locale` SET `Name` = '蘇利薩斯憎惡' WHERE `locale` = 'zhTW' AND `entry` = 8120;
-- OLD subname : 節日煙火商
-- Source : https://www.wowhead.com/wotlk/tw/npc=8121
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8121;
-- OLD subname : 節日煙火商
-- Source : https://www.wowhead.com/wotlk/tw/npc=8122
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8122;
-- OLD name : 蘇薩斯幼雛
-- Source : https://www.wowhead.com/wotlk/tw/npc=8130
UPDATE `creature_template_locale` SET `Name` = '蘇利薩斯幼雛' WHERE `locale` = 'zhTW' AND `entry` = 8130;
-- OLD name : 小蘇薩斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=8138
UPDATE `creature_template_locale` SET `Name` = '小蘇利薩斯' WHERE `locale` = 'zhTW' AND `entry` = 8138;
-- OLD name : 希恩德拉·勁草
-- Source : https://www.wowhead.com/wotlk/tw/npc=8145
UPDATE `creature_template_locale` SET `Name` = '希恩德拉·深草' WHERE `locale` = 'zhTW' AND `entry` = 8145;
-- OLD name : 魯烏
-- Source : https://www.wowhead.com/wotlk/tw/npc=8146
UPDATE `creature_template_locale` SET `Name` = '拉烏' WHERE `locale` = 'zhTW' AND `entry` = 8146;
-- OLD name : 莫沙徹營地勇士
-- Source : https://www.wowhead.com/wotlk/tw/npc=8147
UPDATE `creature_template_locale` SET `Name` = '莫沙徹營地衛兵' WHERE `locale` = 'zhTW' AND `entry` = 8147;
-- OLD name : 洼爾格, subname : 食物和飲料
-- Source : https://www.wowhead.com/wotlk/tw/npc=8148
UPDATE `creature_template_locale` SET `Name` = '瓦爾格',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8148;
-- OLD name : 蘇薩斯護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=8149
UPDATE `creature_template_locale` SET `Name` = '蘇利薩斯衛士' WHERE `locale` = 'zhTW' AND `entry` = 8149;
-- OLD name : 鬼旅崗哨勇士
-- Source : https://www.wowhead.com/wotlk/tw/npc=8154
UPDATE `creature_template_locale` SET `Name` = '鬼旅崗哨勇者' WHERE `locale` = 'zhTW' AND `entry` = 8154;
-- OLD name : 『瘋子』塞科洛克
-- Source : https://www.wowhead.com/wotlk/tw/npc=8202
UPDATE `creature_template_locale` SET `Name` = '瘋狂的塞科洛克' WHERE `locale` = 'zhTW' AND `entry` = 8202;
-- OLD name : 『吞噬者』索利德
-- Source : https://www.wowhead.com/wotlk/tw/npc=8204
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 8204;
-- OLD name : 貪婪的哈爾卡
-- Source : https://www.wowhead.com/wotlk/tw/npc=8205
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 8205;
-- OLD name : 燼翼
-- Source : https://www.wowhead.com/wotlk/tw/npc=8207
UPDATE `creature_template_locale` SET `Name` = '巨型火鳥' WHERE `locale` = 'zhTW' AND `entry` = 8207;
-- OLD name : 殘忍的皰爪土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=8208
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 8208;
-- OLD name : 未完善的戰爭魔像
-- Source : https://www.wowhead.com/wotlk/tw/npc=8279
UPDATE `creature_template_locale` SET `Name` = '未完善的作戰魔像' WHERE `locale` = 'zhTW' AND `entry` = 8279;
-- OLD name : 劫掠
-- Source : https://www.wowhead.com/wotlk/tw/npc=8300
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 8300;
-- OLD name : 『劫奪者』科拉克
-- Source : https://www.wowhead.com/wotlk/tw/npc=8301
UPDATE `creature_template_locale` SET `Name` = '『搶奪者』科拉克' WHERE `locale` = 'zhTW' AND `entry` = 8301;
-- OLD subname : 藥劑和草藥
-- Source : https://www.wowhead.com/wotlk/tw/npc=8305
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8305;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=8306
UPDATE `creature_template_locale` SET `Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 8306;
-- OLD subname : 獵人訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=8308
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8308;
-- OLD subname : 特遣小組
-- Source : https://www.wowhead.com/wotlk/tw/npc=8320
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8320;
-- OLD name : 哈卡萊挖掘者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8336
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 8336;
-- OLD name : 凡妮莎·貝蒂斯船長
-- Source : https://www.wowhead.com/wotlk/tw/npc=8380
UPDATE `creature_template_locale` SET `Name` = '瓦妮莎·貝蒂斯船長' WHERE `locale` = 'zhTW' AND `entry` = 8380;
-- OLD name : 地平線輕帆號工程師
-- Source : https://www.wowhead.com/wotlk/tw/npc=8389
UPDATE `creature_template_locale` SET `Name` = '地平線輕帆號技師' WHERE `locale` = 'zhTW' AND `entry` = 8389;
-- OLD name : 羅蘭·滑釘
-- Source : https://www.wowhead.com/wotlk/tw/npc=8394
UPDATE `creature_template_locale` SET `Name` = '羅蘭德·滑釘' WHERE `locale` = 'zhTW' AND `entry` = 8394;
-- OLD name : 薩納斯·黎姆攸
-- Source : https://www.wowhead.com/wotlk/tw/npc=8395
UPDATE `creature_template_locale` SET `Name` = '薩納斯' WHERE `locale` = 'zhTW' AND `entry` = 8395;
-- OLD name : 腐化的瑪科隆
-- Source : https://www.wowhead.com/wotlk/tw/npc=8407
UPDATE `creature_template_locale` SET `Name` = '瑪科隆' WHERE `locale` = 'zhTW' AND `entry` = 8407;
-- OLD name : 菲拉·賢風
-- Source : https://www.wowhead.com/wotlk/tw/npc=8418
UPDATE `creature_template_locale` SET `Name` = '菲拉·古風' WHERE `locale` = 'zhTW' AND `entry` = 8418;
-- OLD name : 杜里奧斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=8421
UPDATE `creature_template_locale` SET `Name` = '杜瑞奧斯' WHERE `locale` = 'zhTW' AND `entry` = 8421;
-- OLD name : 哈卡萊爪牙
-- Source : https://www.wowhead.com/wotlk/tw/npc=8437
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 8437;
-- OLD name : 哈卡萊血之守衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8438
UPDATE `creature_template_locale` SET `Name` = '哈卡萊護血者' WHERE `locale` = 'zhTW' AND `entry` = 8438;
-- OLD subname : 尼莉絲的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8441
UPDATE `creature_template_locale` SET `Title` = '尼莉絲的衛士' WHERE `locale` = 'zhTW' AND `entry` = 8441;
-- OLD name : 暗影蛛絲盜獵者, subname : 暗黑拍賣會
-- Source : https://www.wowhead.com/wotlk/tw/npc=8442
UPDATE `creature_template_locale` SET `Name` = '暗影蛛絲偷獵者',`Title` = '黑市' WHERE `locale` = 'zhTW' AND `entry` = 8442;
-- OLD subname : 暗黑拍賣會
-- Source : https://www.wowhead.com/wotlk/tw/npc=8444
UPDATE `creature_template_locale` SET `Title` = '黑市' WHERE `locale` = 'zhTW' AND `entry` = 8444;
-- OLD subname : 暗黑拍賣會
-- Source : https://www.wowhead.com/wotlk/tw/npc=8447
UPDATE `creature_template_locale` SET `Title` = '黑市' WHERE `locale` = 'zhTW' AND `entry` = 8447;
-- OLD name : 卡拉然·溫布雷
-- Source : https://www.wowhead.com/wotlk/tw/npc=8479
UPDATE `creature_template_locale` SET `Name` = '維拉若克‧溫布雷' WHERE `locale` = 'zhTW' AND `entry` = 8479;
-- OLD name : 黑鐵哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=8504
UPDATE `creature_template_locale` SET `Name` = '黑鐵斥候' WHERE `locale` = 'zhTW' AND `entry` = 8504;
-- OLD name : 侍從瑪特拉克
-- Source : https://www.wowhead.com/wotlk/tw/npc=8509
UPDATE `creature_template_locale` SET `Name` = '侍衛瑪特拉克' WHERE `locale` = 'zhTW' AND `entry` = 8509;
-- OLD name : 貝尼斯塔茲
-- Source : https://www.wowhead.com/wotlk/tw/npc=8516
UPDATE `creature_template_locale` SET `Name` = '貝尼斯特拉茲' WHERE `locale` = 'zhTW' AND `entry` = 8516;
-- OLD name : 『鑰匙大師』琳薩瑞爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=8518
UPDATE `creature_template_locale` SET `Name` = '琳薩瑞爾' WHERE `locale` = 'zhTW' AND `entry` = 8518;
-- OLD name : 被詛咒的法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=8524
UPDATE `creature_template_locale` SET `Name` = '詛咒法師' WHERE `locale` = 'zhTW' AND `entry` = 8524;
-- OLD name : 天譴護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=8525
UPDATE `creature_template_locale` SET `Name` = '天譴守衛' WHERE `locale` = 'zhTW' AND `entry` = 8525;
-- OLD name : 天譴守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=8527
UPDATE `creature_template_locale` SET `Name` = '天譴衛兵' WHERE `locale` = 'zhTW' AND `entry` = 8527;
-- OLD name : 染病的撕掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8532
UPDATE `creature_template_locale` SET `Name` = '生病的撕掠者' WHERE `locale` = 'zhTW' AND `entry` = 8532;
-- OLD name : 死亡詠手
-- Source : https://www.wowhead.com/wotlk/tw/npc=8542
UPDATE `creature_template_locale` SET `Name` = '死亡歌手' WHERE `locale` = 'zhTW' AND `entry` = 8542;
-- OLD subname : 詛咒神教
-- Source : https://www.wowhead.com/wotlk/tw/npc=8552
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8552;
-- OLD name : 地穴潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8555
UPDATE `creature_template_locale` SET `Name` = '地穴捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 8555;
-- OLD name : 地穴恐蛛
-- Source : https://www.wowhead.com/wotlk/tw/npc=8557
UPDATE `creature_template_locale` SET `Name` = '地穴恐魔' WHERE `locale` = 'zhTW' AND `entry` = 8557;
-- OLD name : 不死奈幽蛛怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=8559
UPDATE `creature_template_locale` SET `Name` = '不死族蜘蛛怪' WHERE `locale` = 'zhTW' AND `entry` = 8559;
-- OLD name : 悲慘的護林者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8563
UPDATE `creature_template_locale` SET `Name` = '護林者' WHERE `locale` = 'zhTW' AND `entry` = 8563;
-- OLD name : 悲慘的遊俠
-- Source : https://www.wowhead.com/wotlk/tw/npc=8564
UPDATE `creature_template_locale` SET `Name` = '遊俠' WHERE `locale` = 'zhTW' AND `entry` = 8564;
-- OLD name : 悲慘的巡路者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8565
UPDATE `creature_template_locale` SET `Name` = '巡路者' WHERE `locale` = 'zhTW' AND `entry` = 8565;
-- OLD name : 魔導師雷姆托里
-- Source : https://www.wowhead.com/wotlk/tw/npc=8578
UPDATE `creature_template_locale` SET `Name` = '大法師雷姆托里' WHERE `locale` = 'zhTW' AND `entry` = 8578;
-- OLD name : 血精靈防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8581
UPDATE `creature_template_locale` SET `Name` = '血精靈防禦者' WHERE `locale` = 'zhTW' AND `entry` = 8581;
-- OLD name : 『靈語者』昂布蘭希
-- Source : https://www.wowhead.com/wotlk/tw/npc=8588
UPDATE `creature_template_locale` SET `Name` = '靈語者阿姆布蘭希' WHERE `locale` = 'zhTW' AND `entry` = 8588;
-- OLD name : 大型瘟疫獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=8599
UPDATE `creature_template_locale` SET `Name` = '瘟疫巨犬' WHERE `locale` = 'zhTW' AND `entry` = 8599;
-- OLD name : 發怒的煉獄火
-- Source : https://www.wowhead.com/wotlk/tw/npc=8608
UPDATE `creature_template_locale` SET `Name` = '發怒的地獄火' WHERE `locale` = 'zhTW' AND `entry` = 8608;
-- OLD name : 奧齊
-- Source : https://www.wowhead.com/wotlk/tw/npc=8613
UPDATE `creature_template_locale` SET `Name` = '奧奇' WHERE `locale` = 'zhTW' AND `entry` = 8613;
-- OLD name : 秘銀幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=8615
UPDATE `creature_template_locale` SET `Name` = '祕銀幼龍' WHERE `locale` = 'zhTW' AND `entry` = 8615;
-- OLD name : 煉獄火僕從
-- Source : https://www.wowhead.com/wotlk/tw/npc=8616
UPDATE `creature_template_locale` SET `Name` = '地獄火僕從' WHERE `locale` = 'zhTW' AND `entry` = 8616;
-- OLD name : 『守衛者』莫塔加亞
-- Source : https://www.wowhead.com/wotlk/tw/npc=8636
UPDATE `creature_template_locale` SET `Name` = '『守護者』莫塔加亞' WHERE `locale` = 'zhTW' AND `entry` = 8636;
-- OLD name : 黑鐵警備兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=8637
UPDATE `creature_template_locale` SET `Name` = '黑鐵巡邏兵' WHERE `locale` = 'zhTW' AND `entry` = 8637;
-- OLD name : 日行者賽恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=8664
UPDATE `creature_template_locale` SET `Name` = '賽恩·傲行者' WHERE `locale` = 'zhTW' AND `entry` = 8664;
-- OLD name : 惡魔尋蹤犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=8668
UPDATE `creature_template_locale` SET `Name` = '地獄尋蹤犬' WHERE `locale` = 'zhTW' AND `entry` = 8668;
-- OLD name : 魔化犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=8675
UPDATE `creature_template_locale` SET `Name` = '惡魔犬獸' WHERE `locale` = 'zhTW' AND `entry` = 8675;
-- OLD subname : 地精工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=8676
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8676;
-- OLD subname : 哥布林工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=8677
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8677;
-- OLD name : 朱比·機簧
-- Source : https://www.wowhead.com/wotlk/tw/npc=8678
UPDATE `creature_template_locale` SET `Name` = '朱比' WHERE `locale` = 'zhTW' AND `entry` = 8678;
-- OLD name : 大型煉獄火
-- Source : https://www.wowhead.com/wotlk/tw/npc=8680
UPDATE `creature_template_locale` SET `Name` = '巨型地獄火' WHERE `locale` = 'zhTW' AND `entry` = 8680;
-- OLD name : 驚懼領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=8716
UPDATE `creature_template_locale` SET `Name` = '恐懼魔王' WHERE `locale` = 'zhTW' AND `entry` = 8716;
-- OLD subname : 洛拉姆斯的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8756
UPDATE `creature_template_locale` SET `Title` = '洛拉姆斯的衛士' WHERE `locale` = 'zhTW' AND `entry` = 8756;
-- OLD subname : 洛拉姆斯的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8757
UPDATE `creature_template_locale` SET `Title` = '洛拉姆斯的衛士' WHERE `locale` = 'zhTW' AND `entry` = 8757;
-- OLD subname : 洛拉姆斯的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8758
UPDATE `creature_template_locale` SET `Title` = '洛拉姆斯的衛士' WHERE `locale` = 'zhTW' AND `entry` = 8758;
-- OLD name : 森林蠕行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8765
UPDATE `creature_template_locale` SET `Name` = '森林爬行者' WHERE `locale` = 'zhTW' AND `entry` = 8765;
-- OLD name : 翡翠幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=8776
UPDATE `creature_template_locale` SET `Name` = '翡翠雛龍' WHERE `locale` = 'zhTW' AND `entry` = 8776;
-- OLD subname : 剝皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=8777
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 8777;
-- OLD name : 鐵怒守望者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8890
UPDATE `creature_template_locale` SET `Name` = '鐵怒衛兵' WHERE `locale` = 'zhTW' AND `entry` = 8890;
-- OLD name : 影爐農民
-- Source : https://www.wowhead.com/wotlk/tw/npc=8896
UPDATE `creature_template_locale` SET `Name` = '暗爐農夫' WHERE `locale` = 'zhTW' AND `entry` = 8896;
-- OLD name : 影爐居民
-- Source : https://www.wowhead.com/wotlk/tw/npc=8902
UPDATE `creature_template_locale` SET `Name` = '暗爐居民' WHERE `locale` = 'zhTW' AND `entry` = 8902;
-- OLD name : 影爐議員
-- Source : https://www.wowhead.com/wotlk/tw/npc=8904
UPDATE `creature_template_locale` SET `Name` = '暗爐議員' WHERE `locale` = 'zhTW' AND `entry` = 8904;
-- OLD name : 熔火戰爭魔像
-- Source : https://www.wowhead.com/wotlk/tw/npc=8908
UPDATE `creature_template_locale` SET `Name` = '熔岩作戰魔像' WHERE `locale` = 'zhTW' AND `entry` = 8908;
-- OLD name : 洞穴爬蛛
-- Source : https://www.wowhead.com/wotlk/tw/npc=8933
UPDATE `creature_template_locale` SET `Name` = '洞穴爬行者' WHERE `locale` = 'zhTW' AND `entry` = 8933;
-- OLD name : 尼達
-- Source : https://www.wowhead.com/wotlk/tw/npc=8962
UPDATE `creature_template_locale` SET `Name` = '希拉蕊' WHERE `locale` = 'zhTW' AND `entry` = 8962;
-- OLD name : 失控的劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8981
UPDATE `creature_template_locale` SET `Name` = '失控的搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 8981;
-- OLD name : 鐵手守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=8982
UPDATE `creature_template_locale` SET `Name` = '鐵手衛士' WHERE `locale` = 'zhTW' AND `entry` = 8982;
-- OLD name : 戈薩拉·夜語
-- Source : https://www.wowhead.com/wotlk/tw/npc=8997
UPDATE `creature_template_locale` SET `Name` = '戈沙拉·夜語' WHERE `locale` = 'zhTW' AND `entry` = 8997;
-- OLD name : 高階審問者格斯塔恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=9018
UPDATE `creature_template_locale` SET `Name` = '審訊官格斯塔恩' WHERE `locale` = 'zhTW' AND `entry` = 9018;
-- OLD name : 火占師羅格雷恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=9024
UPDATE `creature_template_locale` SET `Name` = '控火師羅格雷恩' WHERE `locale` = 'zhTW' AND `entry` = 9024;
-- OLD name : 『修行者』高羅什
-- Source : https://www.wowhead.com/wotlk/tw/npc=9027
UPDATE `creature_template_locale` SET `Name` = '修行者高羅什' WHERE `locale` = 'zhTW' AND `entry` = 9027;
-- OLD name : 『破壞者』奧科索爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=9030
UPDATE `creature_template_locale` SET `Name` = '破壞者奧科索爾' WHERE `locale` = 'zhTW' AND `entry` = 9030;
-- OLD name : 『蠕行者』赫杜姆
-- Source : https://www.wowhead.com/wotlk/tw/npc=9032
UPDATE `creature_template_locale` SET `Name` = '爬行者赫杜姆' WHERE `locale` = 'zhTW' AND `entry` = 9032;
-- OLD name : 護衛斯迪爾基斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=9041
UPDATE `creature_template_locale` SET `Name` = '守衛斯迪爾基斯' WHERE `locale` = 'zhTW' AND `entry` = 9041;
-- OLD name : 裂盾哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=9044
UPDATE `creature_template_locale` SET `Name` = '裂盾哨兵' WHERE `locale` = 'zhTW' AND `entry` = 9044;
-- OLD subname : 裂盾軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9045
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9045;
-- OLD name : 新兵阿瑪卡
-- Source : https://www.wowhead.com/wotlk/tw/npc=9085
UPDATE `creature_template_locale` SET `Name` = '新兵阿瑪卡爾' WHERE `locale` = 'zhTW' AND `entry` = 9085;
-- OLD name : 狂爪龍裔
-- Source : https://www.wowhead.com/wotlk/tw/npc=9096
UPDATE `creature_template_locale` SET `Name` = '狂爪龍人' WHERE `locale` = 'zhTW' AND `entry` = 9096;
-- OLD name : 裂盾軍團士兵, subname : 裂盾軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9097
UPDATE `creature_template_locale` SET `Name` = '裂盾軍團戰士',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9097;
-- OLD name : 裂盾縛法者, subname : 裂盾軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9098
UPDATE `creature_template_locale` SET `Name` = '裂盾縛法師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9098;
-- OLD name : 戰馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=9158
UPDATE `creature_template_locale` SET `Name` = '騎乘用馬（戰馬）' WHERE `locale` = 'zhTW' AND `entry` = 9158;
-- OLD name : 戈洛普
-- Source : https://www.wowhead.com/wotlk/tw/npc=9176
UPDATE `creature_template_locale` SET `Name` = '戈泰什' WHERE `locale` = 'zhTW' AND `entry` = 9176;
-- OLD name : 燃靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=9178
UPDATE `creature_template_locale` SET `Name` = '燃靈術' WHERE `locale` = 'zhTW' AND `entry` = 9178;
-- OLD name : 尖石秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=9198
UPDATE `creature_template_locale` SET `Name` = '尖石秘法師' WHERE `locale` = 'zhTW' AND `entry` = 9198;
-- OLD name : 尖石劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=9200
UPDATE `creature_template_locale` SET `Name` = '尖石劫掠者' WHERE `locale` = 'zhTW' AND `entry` = 9200;
-- OLD name : 尖石巨魔魔導師
-- Source : https://www.wowhead.com/wotlk/tw/npc=9201
UPDATE `creature_template_locale` SET `Name` = '尖石巨魔法師' WHERE `locale` = 'zhTW' AND `entry` = 9201;
-- OLD name : 尖石督軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=9216
UPDATE `creature_template_locale` SET `Name` = '尖石軍閥' WHERE `locale` = 'zhTW' AND `entry` = 9216;
-- OLD name : 將領沃恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=9237
UPDATE `creature_template_locale` SET `Name` = '指揮官沃恩' WHERE `locale` = 'zhTW' AND `entry` = 9237;
-- OLD name : 燃棘秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=9239
UPDATE `creature_template_locale` SET `Name` = '燃棘秘法師' WHERE `locale` = 'zhTW' AND `entry` = 9239;
-- OLD subname : 裂盾軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9257
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9257;
-- OLD name : 裂盾劫掠者, subname : 裂盾軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9258
UPDATE `creature_template_locale` SET `Name` = '裂盾襲擊者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9258;
-- OLD name : 火印蠻兵, subname : 火印軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9259
UPDATE `creature_template_locale` SET `Name` = '火印步兵',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9259;
-- OLD name : 火印軍團士兵, subname : 火印軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9260
UPDATE `creature_template_locale` SET `Name` = '火印軍團戰士',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9260;
-- OLD name : 火印暗織者, subname : 火印軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9261
UPDATE `creature_template_locale` SET `Name` = '火印暗法師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9261;
-- OLD name : 火印塑能師, subname : 火印軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9262
UPDATE `creature_template_locale` SET `Name` = '火印祈求者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9262;
-- OLD name : 火印織懼者, subname : 火印軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9263
UPDATE `creature_template_locale` SET `Name` = '火印恐法師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9263;
-- OLD name : 火印火占師, subname : 火印軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9264
UPDATE `creature_template_locale` SET `Name` = '火印炎術師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9264;
-- OLD name : 暴怒的雙足飛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=9297
UPDATE `creature_template_locale` SET `Name` = '暴怒的飛龍' WHERE `locale` = 'zhTW' AND `entry` = 9297;
-- OLD name : 出土化石
-- Source : https://www.wowhead.com/wotlk/tw/npc=9397
UPDATE `creature_template_locale` SET `Name` = '活風暴' WHERE `locale` = 'zhTW' AND `entry` = 9397;
-- OLD name : 黑暗守衛者沃弗克
-- Source : https://www.wowhead.com/wotlk/tw/npc=9437
UPDATE `creature_template_locale` SET `Name` = '黑暗守護者沃弗克' WHERE `locale` = 'zhTW' AND `entry` = 9437;
-- OLD name : 黑暗守衛者比塞克
-- Source : https://www.wowhead.com/wotlk/tw/npc=9438
UPDATE `creature_template_locale` SET `Name` = '黑暗守護者比塞克' WHERE `locale` = 'zhTW' AND `entry` = 9438;
-- OLD name : 黑暗守衛者尤格爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=9439
UPDATE `creature_template_locale` SET `Name` = '黑暗守護者尤格爾' WHERE `locale` = 'zhTW' AND `entry` = 9439;
-- OLD name : 黑暗守衛者希姆雷爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=9441
UPDATE `creature_template_locale` SET `Name` = '黑暗守護者希姆雷爾' WHERE `locale` = 'zhTW' AND `entry` = 9441;
-- OLD name : 黑暗守衛者奧弗加特
-- Source : https://www.wowhead.com/wotlk/tw/npc=9442
UPDATE `creature_template_locale` SET `Name` = '黑暗守護者奧弗加特' WHERE `locale` = 'zhTW' AND `entry` = 9442;
-- OLD name : 黑暗守衛者佩沃爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=9443
UPDATE `creature_template_locale` SET `Name` = '黑暗守護者佩沃爾' WHERE `locale` = 'zhTW' AND `entry` = 9443;
-- OLD name : 黑暗守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=9445
UPDATE `creature_template_locale` SET `Name` = '黑暗衛兵' WHERE `locale` = 'zhTW' AND `entry` = 9445;
-- OLD name : 血色護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=9447
UPDATE `creature_template_locale` SET `Name` = '血色守衛' WHERE `locale` = 'zhTW' AND `entry` = 9447;
-- OLD name : 警備兵毀握
-- Source : https://www.wowhead.com/wotlk/tw/npc=9476
UPDATE `creature_template_locale` SET `Name` = '衛兵杜格瑞普' WHERE `locale` = 'zhTW' AND `entry` = 9476;
-- OLD name : 複製的軟泥怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=9477
UPDATE `creature_template_locale` SET `Name` = '克隆軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 9477;
-- OLD name : 普拉格·史帕齊林
-- Source : https://www.wowhead.com/wotlk/tw/npc=9499
UPDATE `creature_template_locale` SET `Name` = '普拉格' WHERE `locale` = 'zhTW' AND `entry` = 9499;
-- OLD name : 暴怒的魔化蝙蝠
-- Source : https://www.wowhead.com/wotlk/tw/npc=9521
UPDATE `creature_template_locale` SET `Name` = '狂怒的地獄蝙蝠' WHERE `locale` = 'zhTW' AND `entry` = 9521;
-- OLD name : 亂風崗勇士
-- Source : https://www.wowhead.com/wotlk/tw/npc=9525
UPDATE `creature_template_locale` SET `Name` = '亂風崗衛士' WHERE `locale` = 'zhTW' AND `entry` = 9525;
-- OLD name : 霍爾雷·黑息
-- Source : https://www.wowhead.com/wotlk/tw/npc=9537
UPDATE `creature_template_locale` SET `Name` = '霍爾雷·黑鬚' WHERE `locale` = 'zhTW' AND `entry` = 9537;
-- OLD name : 高階劊子手努茲拉克, subname : 卡加斯遠征軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=9538
UPDATE `creature_template_locale` SET `Name` = '執行官努茲拉克',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9538;
-- OLD subname : 卡加斯遠征軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=9539
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9539;
-- OLD name : 黑息的親信
-- Source : https://www.wowhead.com/wotlk/tw/npc=9541
UPDATE `creature_template_locale` SET `Name` = '黑鬚的親信' WHERE `locale` = 'zhTW' AND `entry` = 9541;
-- OLD name : 卡溫德·準星
-- Source : https://www.wowhead.com/wotlk/tw/npc=9548
UPDATE `creature_template_locale` SET `Name` = '卡溫德' WHERE `locale` = 'zhTW' AND `entry` = 9548;
-- OLD name : 惡魔犬爪牙
-- Source : https://www.wowhead.com/wotlk/tw/npc=9556
UPDATE `creature_template_locale` SET `Name` = '小地獄犬' WHERE `locale` = 'zhTW' AND `entry` = 9556;
-- OLD name : [UNUSED] dun garok test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=9557
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 9557;
-- OLD name : 麥斯威爾元帥
-- Source : https://www.wowhead.com/wotlk/tw/npc=9560
UPDATE `creature_template_locale` SET `Name` = '麥克斯韋爾元帥' WHERE `locale` = 'zhTW' AND `entry` = 9560;
-- OLD name : 瑪亞拉·亮翼
-- Source : https://www.wowhead.com/wotlk/tw/npc=9565
UPDATE `creature_template_locale` SET `Name` = '瑪亞拉·布萊特文' WHERE `locale` = 'zhTW' AND `entry` = 9565;
-- OLD name : 維姆薩拉克主宰
-- Source : https://www.wowhead.com/wotlk/tw/npc=9568
UPDATE `creature_template_locale` SET `Name` = '維姆薩拉克' WHERE `locale` = 'zhTW' AND `entry` = 9568;
-- OLD subname : 天賦大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=9576
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9576;
-- OLD name : [UNUSED] Gorilla Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=9577
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 9577;
-- OLD subname : 天賦大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=9578
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9578;
-- OLD subname : 天賦大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=9579
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9579;
-- OLD subname : 天賦大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=9580
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9580;
-- OLD subname : 天賦大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=9581
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9581;
-- OLD subname : 天賦大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=9582
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9582;
-- OLD subname : 血斧軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9583
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9583;
-- OLD subname : 裁縫訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=9584
UPDATE `creature_template_locale` SET `Title` = '大師級影紋裁縫' WHERE `locale` = 'zhTW' AND `entry` = 9584;
-- OLD name : 黑石劫掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=9605
UPDATE `creature_template_locale` SET `Name` = '黑石襲擊者' WHERE `locale` = 'zhTW' AND `entry` = 9605;
-- OLD name : [UNUSED]埃亞·莫爾克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=9617
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 9617;
-- OLD name : 卡爾納·雷姆塔維爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=9618
UPDATE `creature_template_locale` SET `Name` = '卡爾納·雷塔維' WHERE `locale` = 'zhTW' AND `entry` = 9618;
-- OLD name : 艾米01
-- Source : https://www.wowhead.com/wotlk/tw/npc=9623
UPDATE `creature_template_locale` SET `Name` = '艾米 01' WHERE `locale` = 'zhTW' AND `entry` = 9623;
-- OLD name : 炸彈寵物
-- Source : https://www.wowhead.com/wotlk/tw/npc=9656
UPDATE `creature_template_locale` SET `Name` = '小型步行炸彈' WHERE `locale` = 'zhTW' AND `entry` = 9656;
-- OLD subname : 工程學供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=9676
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9676;
-- OLD name : 托比亞斯·希切爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=9679
UPDATE `creature_template_locale` SET `Name` = '圖比亞斯·希切爾' WHERE `locale` = 'zhTW' AND `entry` = 9679;
-- OLD name : [PH] TESTTAUREN (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=9686
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 9686;
-- OLD name : 血斧劫掠者, subname : 血斧軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9692
UPDATE `creature_template_locale` SET `Name` = '血斧襲擊者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9692;
-- OLD name : 血斧塑能師, subname : 血斧軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9693
UPDATE `creature_template_locale` SET `Name` = '血斧招魂師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9693;
-- OLD name : [UNUSED]格盧爾克
-- Source : https://www.wowhead.com/wotlk/tw/npc=9702
UPDATE `creature_template_locale` SET `Name` = '格盧爾克' WHERE `locale` = 'zhTW' AND `entry` = 9702;
-- OLD name : [UNUSED]伊爾蘇克
-- Source : https://www.wowhead.com/wotlk/tw/npc=9703
UPDATE `creature_template_locale` SET `Name` = '伊爾蘇克' WHERE `locale` = 'zhTW' AND `entry` = 9703;
-- OLD name : [UNUSED]拉莫爾克
-- Source : https://www.wowhead.com/wotlk/tw/npc=9704
UPDATE `creature_template_locale` SET `Name` = '拉莫爾克' WHERE `locale` = 'zhTW' AND `entry` = 9704;
-- OLD name : 虛幻睡夢守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=9705
UPDATE `creature_template_locale` SET `Name` = '睡夢守衛的幻象' WHERE `locale` = 'zhTW' AND `entry` = 9705;
-- OLD subname : 血斧軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9716
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9716;
-- OLD subname : 血斧軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9717
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9717;
-- OLD subname : 血斧軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9736
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9736;
-- OLD name : 黑手織懼者, subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9817
UPDATE `creature_template_locale` SET `Name` = '黑手恐法師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9817;
-- OLD subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9818
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9818;
-- OLD subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=9819
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9819;
-- OLD name : [UNUSED] [PH] Cheese Servant Floh (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=9820
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 9820;
-- OLD subname : 獸欄管理員
-- Source : https://www.wowhead.com/wotlk/tw/npc=9896
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9896;
-- OLD name : 影爐火焰持護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=9956
UPDATE `creature_template_locale` SET `Name` = '暗爐火焰守護者' WHERE `locale` = 'zhTW' AND `entry` = 9956;
-- OLD subname : 獸欄管理員
-- Source : https://www.wowhead.com/wotlk/tw/npc=9977
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 9977;
-- OLD name : 潘妮
-- Source : https://www.wowhead.com/wotlk/tw/npc=9982
UPDATE `creature_template_locale` SET `Name` = '本尼' WHERE `locale` = 'zhTW' AND `entry` = 9982;
-- OLD name : 湖畔鎮守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=10037
UPDATE `creature_template_locale` SET `Name` = '湖畔鎮衛兵' WHERE `locale` = 'zhTW' AND `entry` = 10037;
-- OLD name : 格里什蟲巢衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=10040
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 10040;
-- OLD name : 腐化的刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=10042
UPDATE `creature_template_locale` SET `Name` = '被腐蝕的刃豹' WHERE `locale` = 'zhTW' AND `entry` = 10042;
-- OLD name : [PH] Alex's Raid Testing Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=10044
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 10044;
-- OLD name : 科爾克·麥斯威爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=10045
UPDATE `creature_template_locale` SET `Name` = '科爾克·麥克斯韋爾' WHERE `locale` = 'zhTW' AND `entry` = 10045;
-- OLD name : 史蒂芬·布萊克
-- Source : https://www.wowhead.com/wotlk/tw/npc=10062
UPDATE `creature_template_locale` SET `Name` = '斯蒂文·布萊克' WHERE `locale` = 'zhTW' AND `entry` = 10062;
-- OLD name : 狂爪幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=10084
UPDATE `creature_template_locale` SET `Name` = '狂爪雛龍' WHERE `locale` = 'zhTW' AND `entry` = 10084;
-- OLD subname : 寵物訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10088
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10088;
-- OLD name : 受折磨的奴隸
-- Source : https://www.wowhead.com/wotlk/tw/npc=10117
UPDATE `creature_template_locale` SET `Name` = '被折磨的奴隸' WHERE `locale` = 'zhTW' AND `entry` = 10117;
-- OLD name : 寶庫護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=10120
UPDATE `creature_template_locale` SET `Name` = '寶庫護衛者' WHERE `locale` = 'zhTW' AND `entry` = 10120;
-- OLD subname : TEST, Don't BUG
-- Source : https://www.wowhead.com/wotlk/tw/npc=10156
UPDATE `creature_template_locale` SET `Title` = ', Don''t BUG' WHERE `locale` = 'zhTW' AND `entry` = 10156;
-- OLD name : 盛怒的月夜梟獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=10160
UPDATE `creature_template_locale` SET `Name` = '狂暴的月夜梟獸' WHERE `locale` = 'zhTW' AND `entry` = 10160;
-- OLD name : 群居幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=10161
UPDATE `creature_template_locale` SET `Name` = '群居雛龍' WHERE `locale` = 'zhTW' AND `entry` = 10161;
-- OLD name : 維克多·奈法利斯領主, subname : 黑石之王
-- Source : https://www.wowhead.com/wotlk/tw/npc=10162
UPDATE `creature_template_locale` SET `Name` = '奈法利斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10162;
-- OLD name : 綠色螢光機械陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=10178
UPDATE `creature_template_locale` SET `Name` = '騎乘用機械陸行鳥（粉綠色）' WHERE `locale` = 'zhTW' AND `entry` = 10178;
-- OLD name : 白色機械陸行鳥B型
-- Source : https://www.wowhead.com/wotlk/tw/npc=10179
UPDATE `creature_template_locale` SET `Name` = '騎乘用機械陸行鳥（黑色）' WHERE `locale` = 'zhTW' AND `entry` = 10179;
-- OLD name : 未塗色機械陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=10180
UPDATE `creature_template_locale` SET `Name` = '騎乘用機械陸行鳥（青灰色）' WHERE `locale` = 'zhTW' AND `entry` = 10180;
-- OLD name : 『劫奪者』卡蘇克
-- Source : https://www.wowhead.com/wotlk/tw/npc=10198
UPDATE `creature_template_locale` SET `Name` = '『搶奪者』卡蘇克' WHERE `locale` = 'zhTW' AND `entry` = 10198;
-- OLD name : 葛溫妮絲·布萊雷剛德
-- Source : https://www.wowhead.com/wotlk/tw/npc=10219
UPDATE `creature_template_locale` SET `Name` = '溫尼斯·布萊葛' WHERE `locale` = 'zhTW' AND `entry` = 10219;
-- OLD name : 約兒, subname : NONE
-- Source : https://www.wowhead.com/wotlk/tw/npc=10237
UPDATE `creature_template_locale` SET `Name` = 'Yor',`Title` = 'UNUSED' WHERE `locale` = 'zhTW' AND `entry` = 10237;
-- OLD name : 群居守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=10258
UPDATE `creature_template_locale` SET `Name` = '群居守衛者' WHERE `locale` = 'zhTW' AND `entry` = 10258;
-- OLD name : 燃燒惡魔犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=10261
UPDATE `creature_template_locale` SET `Name` = '燃燒地獄犬' WHERE `locale` = 'zhTW' AND `entry` = 10261;
-- OLD name : 『奴役者』基茲盧爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=10268
UPDATE `creature_template_locale` SET `Name` = '奴役者基茲盧爾' WHERE `locale` = 'zhTW' AND `entry` = 10268;
-- OLD subname : 戰士訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10291
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10291;
-- OLD subname : 法杖訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10295
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10295;
-- OLD name : 阿克萊德
-- Source : https://www.wowhead.com/wotlk/tw/npc=10296
UPDATE `creature_template_locale` SET `Name` = '維埃蘭' WHERE `locale` = 'zhTW' AND `entry` = 10296;
-- OLD subname : 投擲武器訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10298
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10298;
-- OLD name : 阿克萊德, subname : 裂盾軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=10299
UPDATE `creature_template_locale` SET `Name` = '裂盾滲透者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10299;
-- OLD subname : Explorers' League
-- Source : https://www.wowhead.com/wotlk/tw/npc=10301
UPDATE `creature_template_locale` SET `Title` = '探險者協會' WHERE `locale` = 'zhTW' AND `entry` = 10301;
-- OLD name : 奧蘿拉·天喚者
-- Source : https://www.wowhead.com/wotlk/tw/npc=10304
UPDATE `creature_template_locale` SET `Name` = '奧蘿拉' WHERE `locale` = 'zhTW' AND `entry` = 10304;
-- OLD name : 烏米·浪博史尼克
-- Source : https://www.wowhead.com/wotlk/tw/npc=10305
UPDATE `creature_template_locale` SET `Name` = '烏米' WHERE `locale` = 'zhTW' AND `entry` = 10305;
-- OLD subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=10316
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10316;
-- OLD subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=10317
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10317;
-- OLD subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=10318
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10318;
-- OLD subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=10319
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10319;
-- OLD name : 上古霜刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=10322
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎  (白色)' WHERE `locale` = 'zhTW' AND `entry` = 10322;
-- OLD name : 遠古豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=10336
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎  (豹)' WHERE `locale` = 'zhTW' AND `entry` = 10336;
-- OLD name : 褐色刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=10337
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎  (橘黃色)' WHERE `locale` = 'zhTW' AND `entry` = 10337;
-- OLD name : 金色刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=10338
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎  (金色)' WHERE `locale` = 'zhTW' AND `entry` = 10338;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10361
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 10361;
-- OLD subname : 武器商
-- Source : https://www.wowhead.com/wotlk/tw/npc=10369
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10369;
-- OLD name : [UNUSED] Xur'gyl (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=10370
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 10370;
-- OLD name : 懷恨的魅影
-- Source : https://www.wowhead.com/wotlk/tw/npc=10388
UPDATE `creature_template_locale` SET `Name` = '懷恨的幻影' WHERE `locale` = 'zhTW' AND `entry` = 10388;
-- OLD name : 狂怒的魅影
-- Source : https://www.wowhead.com/wotlk/tw/npc=10389
UPDATE `creature_template_locale` SET `Name` = '狂怒的幻影' WHERE `locale` = 'zhTW' AND `entry` = 10389;
-- OLD name : 黑衣衛哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=10394
UPDATE `creature_template_locale` SET `Name` = '黑衣守衛斥候' WHERE `locale` = 'zhTW' AND `entry` = 10394;
-- OLD name : [UNUSED]黑衣衛戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=10395
UPDATE `creature_template_locale` SET `Name` = '黑衣守衛戰士' WHERE `locale` = 'zhTW' AND `entry` = 10395;
-- OLD name : [UNUSED]黑衣衛劊子手
-- Source : https://www.wowhead.com/wotlk/tw/npc=10397
UPDATE `creature_template_locale` SET `Name` = '黑衣守衛劊子手' WHERE `locale` = 'zhTW' AND `entry` = 10397;
-- OLD name : [UNUSED] Thuzadin Shadow Lord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=10401
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 10401;
-- OLD name : [UNUSED] Cannibal Wight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=10402
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 10402;
-- OLD name : [UNUSED] Devouring Wight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=10403
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 10403;
-- OLD name : 剝肉食屍鬼
-- Source : https://www.wowhead.com/wotlk/tw/npc=10407
UPDATE `creature_template_locale` SET `Name` = '鮮肉食屍鬼' WHERE `locale` = 'zhTW' AND `entry` = 10407;
-- OLD name : 復活的衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=10418
UPDATE `creature_template_locale` SET `Name` = '紅衣衛兵' WHERE `locale` = 'zhTW' AND `entry` = 10418;
-- OLD name : 復活的咒術師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10419
UPDATE `creature_template_locale` SET `Name` = '紅衣魔術師' WHERE `locale` = 'zhTW' AND `entry` = 10419;
-- OLD name : 復活的新兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=10420
UPDATE `creature_template_locale` SET `Name` = '紅衣新兵' WHERE `locale` = 'zhTW' AND `entry` = 10420;
-- OLD name : 復活的防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=10421
UPDATE `creature_template_locale` SET `Name` = '紅衣防禦者' WHERE `locale` = 'zhTW' AND `entry` = 10421;
-- OLD name : 復活的巫士
-- Source : https://www.wowhead.com/wotlk/tw/npc=10422
UPDATE `creature_template_locale` SET `Name` = '紅衣法術師' WHERE `locale` = 'zhTW' AND `entry` = 10422;
-- OLD name : 復活的牧師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10423
UPDATE `creature_template_locale` SET `Name` = '紅衣牧師' WHERE `locale` = 'zhTW' AND `entry` = 10423;
-- OLD name : 復活的豪俠
-- Source : https://www.wowhead.com/wotlk/tw/npc=10424
UPDATE `creature_template_locale` SET `Name` = '紅衣豪俠' WHERE `locale` = 'zhTW' AND `entry` = 10424;
-- OLD name : 復活的戰鬥法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10425
UPDATE `creature_template_locale` SET `Name` = '紅衣戰鬥法師' WHERE `locale` = 'zhTW' AND `entry` = 10425;
-- OLD name : 復活的審判官
-- Source : https://www.wowhead.com/wotlk/tw/npc=10426
UPDATE `creature_template_locale` SET `Name` = '紅衣審查者' WHERE `locale` = 'zhTW' AND `entry` = 10426;
-- OLD name : 格里高·格雷斯通
-- Source : https://www.wowhead.com/wotlk/tw/npc=10431
UPDATE `creature_template_locale` SET `Name` = '格雷戈·格雷斯通' WHERE `locale` = 'zhTW' AND `entry` = 10431;
-- OLD name : 奈幽布恩坎
-- Source : https://www.wowhead.com/wotlk/tw/npc=10437
UPDATE `creature_template_locale` SET `Name` = '奈魯布恩坎' WHERE `locale` = 'zhTW' AND `entry` = 10437;
-- OLD name : 『暴食者』拉姆斯登
-- Source : https://www.wowhead.com/wotlk/tw/npc=10439
UPDATE `creature_template_locale` SET `Name` = '吞嚥者拉姆斯登' WHERE `locale` = 'zhTW' AND `entry` = 10439;
-- OLD name : 染疫鼠
-- Source : https://www.wowhead.com/wotlk/tw/npc=10441
UPDATE `creature_template_locale` SET `Name` = '瘟疫鼠' WHERE `locale` = 'zhTW' AND `entry` = 10441;
-- OLD name : 炫彩幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=10442
UPDATE `creature_template_locale` SET `Name` = '多彩雛龍' WHERE `locale` = 'zhTW' AND `entry` = 10442;
-- OLD subname : 暗月馬戲團諮詢處
-- Source : https://www.wowhead.com/wotlk/tw/npc=10445
UPDATE `creature_template_locale` SET `Title` = '暗月馬戲團諮詢員' WHERE `locale` = 'zhTW' AND `entry` = 10445;
-- OLD name : [UNUSED] Elliott Jacks (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=10446
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 10446;
-- OLD name : 炫彩龍裔
-- Source : https://www.wowhead.com/wotlk/tw/npc=10447
UPDATE `creature_template_locale` SET `Name` = '多彩龍人' WHERE `locale` = 'zhTW' AND `entry` = 10447;
-- OLD name : [UNUSED] 拉切爾·維卡 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=10448
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 10448;
-- OLD name : 艾蜜莉·維卡, subname : 長柄武器訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10449
UPDATE `creature_template_locale` SET `Name` = '艾米莉·維卡',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10449;
-- OLD name : [UNUSED] Paul Burges (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=10450
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 10450;
-- OLD subname : 法杖訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10451
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10451;
-- OLD name : 費利維克·羽嘶
-- Source : https://www.wowhead.com/wotlk/tw/npc=10454
UPDATE `creature_template_locale` SET `Name` = '費利維克' WHERE `locale` = 'zhTW' AND `entry` = 10454;
-- OLD name : 染疫蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=10461
UPDATE `creature_template_locale` SET `Name` = '瘟疫蟲' WHERE `locale` = 'zhTW' AND `entry` = 10461;
-- OLD subname : 特殊貨物商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=10466
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10466;
-- OLD name : 通靈學院暗影施法者
-- Source : https://www.wowhead.com/wotlk/tw/npc=10473
UPDATE `creature_template_locale` SET `Name` = '通靈學院暗影法師' WHERE `locale` = 'zhTW' AND `entry` = 10473;
-- OLD name : 再活化的屍體
-- Source : https://www.wowhead.com/wotlk/tw/npc=10481
UPDATE `creature_template_locale` SET `Name` = '複生的屍體' WHERE `locale` = 'zhTW' AND `entry` = 10481;
-- OLD name : 復活的僕人
-- Source : https://www.wowhead.com/wotlk/tw/npc=10482
UPDATE `creature_template_locale` SET `Name` = '復活的侍從' WHERE `locale` = 'zhTW' AND `entry` = 10482;
-- OLD name : 復活的撕掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=10483
UPDATE `creature_template_locale` SET `Name` = '復活的搶劫者' WHERE `locale` = 'zhTW' AND `entry` = 10483;
-- OLD name : 復活的守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=10489
UPDATE `creature_template_locale` SET `Name` = '復活的衛兵' WHERE `locale` = 'zhTW' AND `entry` = 10489;
-- OLD name : 復活的骸骨護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=10491
UPDATE `creature_template_locale` SET `Name` = '復活的骸骨守衛' WHERE `locale` = 'zhTW' AND `entry` = 10491;
-- OLD name : 復活的巫士
-- Source : https://www.wowhead.com/wotlk/tw/npc=10493
UPDATE `creature_template_locale` SET `Name` = '復活的巫師' WHERE `locale` = 'zhTW' AND `entry` = 10493;
-- OLD name : 染病的食屍鬼
-- Source : https://www.wowhead.com/wotlk/tw/npc=10495
UPDATE `creature_template_locale` SET `Name` = '生病的食屍鬼' WHERE `locale` = 'zhTW' AND `entry` = 10495;
-- OLD name : 染疫泥漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=10510
UPDATE `creature_template_locale` SET `Name` = '瘟疫軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 10510;
-- OLD name : 染疫蛆
-- Source : https://www.wowhead.com/wotlk/tw/npc=10536
UPDATE `creature_template_locale` SET `Name` = '瘟疫蛆' WHERE `locale` = 'zhTW' AND `entry` = 10536;
-- OLD name : 峭壁看守者長角
-- Source : https://www.wowhead.com/wotlk/tw/npc=10537
UPDATE `creature_template_locale` SET `Name` = '峭壁衛兵圖林·長角' WHERE `locale` = 'zhTW' AND `entry` = 10537;
-- OLD name : 爐邊歌手弗瑞斯坦
-- Source : https://www.wowhead.com/wotlk/tw/npc=10558
UPDATE `creature_template_locale` SET `Name` = '弗雷斯特恩' WHERE `locale` = 'zhTW' AND `entry` = 10558;
-- OLD name : 幼年阿利卡拉
-- Source : https://www.wowhead.com/wotlk/tw/npc=10581
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 10581;
-- OLD name : 烏洛克·末日嚎
-- Source : https://www.wowhead.com/wotlk/tw/npc=10584
UPDATE `creature_template_locale` SET `Name` = '烏洛克' WHERE `locale` = 'zhTW' AND `entry` = 10584;
-- OLD name : 哈夫納·石騰
-- Source : https://www.wowhead.com/wotlk/tw/npc=10599
UPDATE `creature_template_locale` SET `Name` = '哈夫納·巨石圖騰' WHERE `locale` = 'zhTW' AND `entry` = 10599;
-- OLD name : 烏洛克魔導師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10602
UPDATE `creature_template_locale` SET `Name` = '烏洛克法師' WHERE `locale` = 'zhTW' AND `entry` = 10602;
-- OLD name : 女獵手雅里瑞拉
-- Source : https://www.wowhead.com/wotlk/tw/npc=10606
UPDATE `creature_template_locale` SET `Name` = '女獵人雅里瑞拉' WHERE `locale` = 'zhTW' AND `entry` = 10606;
-- OLD name : [UNUSED] Siralnaya (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=10607
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 10607;
-- OLD name : 血色祭司
-- Source : https://www.wowhead.com/wotlk/tw/npc=10608
UPDATE `creature_template_locale` SET `Name` = '血色神父' WHERE `locale` = 'zhTW' AND `entry` = 10608;
-- OLD subname : 矮人迫擊砲小隊
-- Source : https://www.wowhead.com/wotlk/tw/npc=10610
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10610;
-- OLD subname : 矮人迫擊砲小隊
-- Source : https://www.wowhead.com/wotlk/tw/npc=10611
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10611;
-- OLD name : 守衛瓦查比
-- Source : https://www.wowhead.com/wotlk/tw/npc=10612
UPDATE `creature_template_locale` SET `Name` = '衛兵瓦查比' WHERE `locale` = 'zhTW' AND `entry` = 10612;
-- OLD name : Galak Messenger
-- Source : https://www.wowhead.com/wotlk/tw/npc=10617
UPDATE `creature_template_locale` SET `Name` = '加拉克信差' WHERE `locale` = 'zhTW' AND `entry` = 10617;
-- OLD subname : 雷沃的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=10619
UPDATE `creature_template_locale` SET `Title` = '雷沃的衛士' WHERE `locale` = 'zhTW' AND `entry` = 10619;
-- OLD name : 科多馱運獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=10636
UPDATE `creature_template_locale` SET `Name` = '牛頭人的科多獸' WHERE `locale` = 'zhTW' AND `entry` = 10636;
-- OLD name : 惡魔獵犬守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=10656
UPDATE `creature_template_locale` SET `Name` = '護衛惡魔獵犬' WHERE `locale` = 'zhTW' AND `entry` = 10656;
-- OLD name : 腐化的貓
-- Source : https://www.wowhead.com/wotlk/tw/npc=10657
UPDATE `creature_template_locale` SET `Name` = '被腐蝕的貓' WHERE `locale` = 'zhTW' AND `entry` = 10657;
-- OLD name : 鈷藍幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=10659
UPDATE `creature_template_locale` SET `Name` = '深藍色幼龍' WHERE `locale` = 'zhTW' AND `entry` = 10659;
-- OLD name : 鈷藍小龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=10660
UPDATE `creature_template_locale` SET `Name` = '深藍色小龍' WHERE `locale` = 'zhTW' AND `entry` = 10660;
-- OLD name : 染疫幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=10678
UPDATE `creature_template_locale` SET `Name` = '瘟疫幼龍' WHERE `locale` = 'zhTW' AND `entry` = 10678;
-- OLD name : 被召喚的黑手織懼者, subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=10680
UPDATE `creature_template_locale` SET `Name` = '被召喚的黑手恐法師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10680;
-- OLD subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=10681
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10681;
-- OLD name : 綠汁泥漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=10697
UPDATE `creature_template_locale` SET `Name` = '綠汁軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 10697;
-- OLD name : Galak Assassin
-- Source : https://www.wowhead.com/wotlk/tw/npc=10720
UPDATE `creature_template_locale` SET `Name` = '加拉克刺客' WHERE `locale` = 'zhTW' AND `entry` = 10720;
-- OLD subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=10742
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10742;
-- OLD name : Grimtotem Stomper
-- Source : https://www.wowhead.com/wotlk/tw/npc=10759
UPDATE `creature_template_locale` SET `Name` = '恐怖圖騰踐踏者' WHERE `locale` = 'zhTW' AND `entry` = 10759;
-- OLD name : Grimtotem Geomancer
-- Source : https://www.wowhead.com/wotlk/tw/npc=10760
UPDATE `creature_template_locale` SET `Name` = '恐怖圖騰地卜師' WHERE `locale` = 'zhTW' AND `entry` = 10760;
-- OLD name : Grimtotem Reaver
-- Source : https://www.wowhead.com/wotlk/tw/npc=10761
UPDATE `creature_template_locale` SET `Name` = '恐怖圖騰劫奪者' WHERE `locale` = 'zhTW' AND `entry` = 10761;
-- OLD subname : 被詛咒者
-- Source : https://www.wowhead.com/wotlk/tw/npc=10799
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10799;
-- OLD name : 『守衛者』希坦亞
-- Source : https://www.wowhead.com/wotlk/tw/npc=10802
UPDATE `creature_template_locale` SET `Name` = '『看守者』希坦亞' WHERE `locale` = 'zhTW' AND `entry` = 10802;
-- OLD name : 步槍兵維勒
-- Source : https://www.wowhead.com/wotlk/tw/npc=10803
UPDATE `creature_template_locale` SET `Name` = '火槍手維勒' WHERE `locale` = 'zhTW' AND `entry` = 10803;
-- OLD name : 步槍兵米德凱普
-- Source : https://www.wowhead.com/wotlk/tw/npc=10804
UPDATE `creature_template_locale` SET `Name` = '火槍手米德凱普' WHERE `locale` = 'zhTW' AND `entry` = 10804;
-- OLD name : 殘忍的提米
-- Source : https://www.wowhead.com/wotlk/tw/npc=10808
UPDATE `creature_template_locale` SET `Name` = '悲慘的提米' WHERE `locale` = 'zhTW' AND `entry` = 10808;
-- OLD name : [UNUSED] Deathcaller Majestis (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=10810
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 10810;
-- OLD name : 古卷管理者加爾福特
-- Source : https://www.wowhead.com/wotlk/tw/npc=10811
UPDATE `creature_template_locale` SET `Name` = '檔案管理員加爾福特' WHERE `locale` = 'zhTW' AND `entry` = 10811;
-- OLD name : 炫彩精英衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=10814
UPDATE `creature_template_locale` SET `Name` = '多彩精英衛士' WHERE `locale` = 'zhTW' AND `entry` = 10814;
-- OLD name : 亡靈獵手霍克斯比爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=10824
UPDATE `creature_template_locale` SET `Name` = '遊俠之王霍克斯比爾' WHERE `locale` = 'zhTW' AND `entry` = 10824;
-- OLD name : 亡頌者塞倫德
-- Source : https://www.wowhead.com/wotlk/tw/npc=10827
UPDATE `creature_template_locale` SET `Name` = '亡語者塞倫德' WHERE `locale` = 'zhTW' AND `entry` = 10827;
-- OLD name : 琳恩妮雅·阿比迪斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=10828
UPDATE `creature_template_locale` SET `Name` = '大將軍阿比迪斯' WHERE `locale` = 'zhTW' AND `entry` = 10828;
-- OLD name : 高階執行官德靈頓
-- Source : https://www.wowhead.com/wotlk/tw/npc=10837
UPDATE `creature_template_locale` SET `Name` = '高級執行官德靈頓' WHERE `locale` = 'zhTW' AND `entry` = 10837;
-- OLD subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=10839
UPDATE `creature_template_locale` SET `Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 10839;
-- OLD name : 銀白軍官普爾哈特, subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=10840
UPDATE `creature_template_locale` SET `Name` = '銀色黎明軍官普爾哈特',`Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 10840;
-- OLD name : 銀白軍需官萊斯巴克, subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=10857
UPDATE `creature_template_locale` SET `Name` = '銀色黎明軍需官萊斯巴克',`Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 10857;
-- OLD name : 不死甲蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=10876
UPDATE `creature_template_locale` SET `Name` = '不死族甲蟲' WHERE `locale` = 'zhTW' AND `entry` = 10876;
-- OLD name : 喚戰者高拉克
-- Source : https://www.wowhead.com/wotlk/tw/npc=10880
UPDATE `creature_template_locale` SET `Name` = '公告員高拉克' WHERE `locale` = 'zhTW' AND `entry` = 10880;
-- OLD name : 阿利卡拉, subname : 復仇
-- Source : https://www.wowhead.com/wotlk/tw/npc=10882
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10882;
-- OLD subname : 黑手軍團
-- Source : https://www.wowhead.com/wotlk/tw/npc=10898
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10898;
-- OLD name : 博識者普克爾特
-- Source : https://www.wowhead.com/wotlk/tw/npc=10901
UPDATE `creature_template_locale` SET `Name` = '博學者普克爾特' WHERE `locale` = 'zhTW' AND `entry` = 10901;
-- OLD name : 奧里爾斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=10917
UPDATE `creature_template_locale` SET `Name` = '奧里克斯' WHERE `locale` = 'zhTW' AND `entry` = 10917;
-- OLD name : 科雷克·天衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=10920
UPDATE `creature_template_locale` SET `Name` = '科雷克·望天' WHERE `locale` = 'zhTW' AND `entry` = 10920;
-- OLD subname : 獵人訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10930
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10930;
-- OLD name : 黑衣馬杜克
-- Source : https://www.wowhead.com/wotlk/tw/npc=10939
UPDATE `creature_template_locale` SET `Name` = '黑衣瑪杜克' WHERE `locale` = 'zhTW' AND `entry` = 10939;
-- OLD name : 白銀之手侍徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=10949
UPDATE `creature_template_locale` SET `Name` = '白銀之手成員' WHERE `locale` = 'zhTW' AND `entry` = 10949;
-- OLD name : 血色獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=10979
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 10979;
-- OLD subname : 工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=10993
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 10993;
-- OLD name : 威利·希望破除者
-- Source : https://www.wowhead.com/wotlk/tw/npc=10997
UPDATE `creature_template_locale` SET `Name` = '炮手威利' WHERE `locale` = 'zhTW' AND `entry` = 10997;
-- OLD name : 冬泉霜刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=11021
UPDATE `creature_template_locale` SET `Name` = '騎乘用虎 (冬泉谷)' WHERE `locale` = 'zhTW' AND `entry` = 11021;
-- OLD name : 富蘭克林·洛伊德
-- Source : https://www.wowhead.com/wotlk/tw/npc=11031
UPDATE `creature_template_locale` SET `Name` = '弗蘭克林·洛伊德' WHERE `locale` = 'zhTW' AND `entry` = 11031;
-- OLD name : 指揮官瑪洛爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=11032
UPDATE `creature_template_locale` SET `Name` = '狂熱的瑪洛爾' WHERE `locale` = 'zhTW' AND `entry` = 11032;
-- OLD name : 麥斯威爾·泰羅索斯領主, subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=11034
UPDATE `creature_template_locale` SET `Name` = '麥克斯韋爾·泰羅索斯領主',`Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 11034;
-- OLD subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=11036
UPDATE `creature_template_locale` SET `Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 11036;
-- OLD subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=11039
UPDATE `creature_template_locale` SET `Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 11039;
-- OLD name : 復活的僧侶
-- Source : https://www.wowhead.com/wotlk/tw/npc=11043
UPDATE `creature_template_locale` SET `Name` = '紅衣僧侶' WHERE `locale` = 'zhTW' AND `entry` = 11043;
-- OLD name : 提摩西·沃森特
-- Source : https://www.wowhead.com/wotlk/tw/npc=11052
UPDATE `creature_template_locale` SET `Name` = '提莫斯·沃森特' WHERE `locale` = 'zhTW' AND `entry` = 11052;
-- OLD name : 復活的步槍兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=11054
UPDATE `creature_template_locale` SET `Name` = '紅衣火槍手' WHERE `locale` = 'zhTW' AND `entry` = 11054;
-- OLD subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=11063
UPDATE `creature_template_locale` SET `Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 11063;
-- OLD subname : 附魔訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11073
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11073;
-- OLD name : [PH[ Combat Tester (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11080
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11080;
-- OLD name : 銀色黎明衛士, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=11099
UPDATE `creature_template_locale` SET `Name` = '銀色衛士',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11099;
-- OLD name : 銀白騎兵, subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=11102
UPDATE `creature_template_locale` SET `Name` = '銀色黎明騎兵',`Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 11102;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=11106
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 11106;
-- OLD name : Innkeeper Abeqwa
-- Source : https://www.wowhead.com/wotlk/tw/npc=11116
UPDATE `creature_template_locale` SET `Name` = '旅店老闆埃比克瓦' WHERE `locale` = 'zhTW' AND `entry` = 11116;
-- OLD name : 紅衣錘類鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11120
UPDATE `creature_template_locale` SET `Name` = '紅衣鑄錘師' WHERE `locale` = 'zhTW' AND `entry` = 11120;
-- OLD name : 黑衣衛劍類鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11121
UPDATE `creature_template_locale` SET `Name` = '黑衣守衛鑄劍師' WHERE `locale` = 'zhTW' AND `entry` = 11121;
-- OLD name : 郵政局長瑪羅恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=11143
UPDATE `creature_template_locale` SET `Name` = '郵差瑪羅恩' WHERE `locale` = 'zhTW' AND `entry` = 11143;
-- OLD name : 神諭之球
-- Source : https://www.wowhead.com/wotlk/tw/npc=11144
UPDATE `creature_template_locale` SET `Name` = '預言之球' WHERE `locale` = 'zhTW' AND `entry` = 11144;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11146
UPDATE `creature_template_locale` SET `Title` = '武器鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 11146;
-- OLD name : 綠色機械陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=11147
UPDATE `creature_template_locale` SET `Name` = '騎乘用機械陸行鳥  (綠色/灰色)' WHERE `locale` = 'zhTW' AND `entry` = 11147;
-- OLD name : 紫色機械陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=11148
UPDATE `creature_template_locale` SET `Name` = '騎乘用機械陸行鳥  (紫色)' WHERE `locale` = 'zhTW' AND `entry` = 11148;
-- OLD name : 紅色/藍色機械陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=11149
UPDATE `creature_template_locale` SET `Name` = '騎乘用機械陸行鳥  (紅色/藍色)' WHERE `locale` = 'zhTW' AND `entry` = 11149;
-- OLD name : 冰藍色機械陸行鳥A型
-- Source : https://www.wowhead.com/wotlk/tw/npc=11150
UPDATE `creature_template_locale` SET `Name` = '騎乘用機械陸行鳥  (冷藍色)' WHERE `locale` = 'zhTW' AND `entry` = 11150;
-- OLD name : 天譴大鍋
-- Source : https://www.wowhead.com/wotlk/tw/npc=11152
UPDATE `creature_template_locale` SET `Name` = '天譴之鍋' WHERE `locale` = 'zhTW' AND `entry` = 11152;
-- OLD name : 紅色骸骨戰馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=11153
UPDATE `creature_template_locale` SET `Name` = '騎乘用骸骨戰馬 (紅色)' WHERE `locale` = 'zhTW' AND `entry` = 11153;
-- OLD name : 藍色骸骨戰馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=11154
UPDATE `creature_template_locale` SET `Name` = '騎乘用骸骨戰馬 (藍色)' WHERE `locale` = 'zhTW' AND `entry` = 11154;
-- OLD name : 棕色骸骨戰馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=11155
UPDATE `creature_template_locale` SET `Name` = '騎乘用骸骨戰馬 (棕色)' WHERE `locale` = 'zhTW' AND `entry` = 11155;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11177
UPDATE `creature_template_locale` SET `Title` = '護甲鍛造師' WHERE `locale` = 'zhTW' AND `entry` = 11177;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11178
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 11178;
-- OLD name : 血毒崗哨勇者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11180
UPDATE `creature_template_locale` SET `Name` = '血毒崗哨衛士' WHERE `locale` = 'zhTW' AND `entry` = 11180;
-- OLD subname : 武器鍛造和護甲
-- Source : https://www.wowhead.com/wotlk/tw/npc=11184
UPDATE `creature_template_locale` SET `Title` = '武器和槍械' WHERE `locale` = 'zhTW' AND `entry` = 11184;
-- OLD name : 瑟里爾·天譴剋星
-- Source : https://www.wowhead.com/wotlk/tw/npc=11193
UPDATE `creature_template_locale` SET `Name` = '亡靈殺手瑟里爾' WHERE `locale` = 'zhTW' AND `entry` = 11193;
-- OLD name : 銀白防衛者, subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=11194
UPDATE `creature_template_locale` SET `Name` = '銀色黎明防衛者',`Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 11194;
-- OLD name : 死亡戰騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=11195
UPDATE `creature_template_locale` SET `Name` = '黑色骸骨戰馬' WHERE `locale` = 'zhTW' AND `entry` = 11195;
-- OLD name : 紅衣火砲
-- Source : https://www.wowhead.com/wotlk/tw/npc=11199
UPDATE `creature_template_locale` SET `Name` = '紅衣火炮' WHERE `locale` = 'zhTW' AND `entry` = 11199;
-- OLD name : 伊娃·薩克霍夫
-- Source : https://www.wowhead.com/wotlk/tw/npc=11216
UPDATE `creature_template_locale` SET `Name` = '艾瓦·薩克霍夫' WHERE `locale` = 'zhTW' AND `entry` = 11216;
-- OLD name : 盧希恩·薩克霍夫
-- Source : https://www.wowhead.com/wotlk/tw/npc=11217
UPDATE `creature_template_locale` SET `Name` = '盧森·薩克霍夫' WHERE `locale` = 'zhTW' AND `entry` = 11217;
-- OLD name : 克羅尼安·恆影
-- Source : https://www.wowhead.com/wotlk/tw/npc=11218
UPDATE `creature_template_locale` SET `Name` = '克羅尼亞·恒影' WHERE `locale` = 'zhTW' AND `entry` = 11218;
-- OLD name : 北郡農民
-- Source : https://www.wowhead.com/wotlk/tw/npc=11260
UPDATE `creature_template_locale` SET `Name` = '北郡農夫' WHERE `locale` = 'zhTW' AND `entry` = 11260;
-- OLD name : 瑟爾林·卡斯迪諾夫醫生
-- Source : https://www.wowhead.com/wotlk/tw/npc=11261
UPDATE `creature_template_locale` SET `Name` = '瑟爾林·卡斯迪諾夫教授' WHERE `locale` = 'zhTW' AND `entry` = 11261;
-- OLD name : 奧妮克希亞幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=11262
UPDATE `creature_template_locale` SET `Name` = '奧妮克希亞雛龍' WHERE `locale` = 'zhTW' AND `entry` = 11262;
-- OLD name : 凱爾達隆砲手
-- Source : https://www.wowhead.com/wotlk/tw/npc=11280
UPDATE `creature_template_locale` SET `Name` = '凱爾達隆砲兵' WHERE `locale` = 'zhTW' AND `entry` = 11280;
-- OLD name : 爛苔狂戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=11292
UPDATE `creature_template_locale` SET `Name` = '爛苔狂暴者' WHERE `locale` = 'zhTW' AND `entry` = 11292;
-- OLD name : 怒焰穴居怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=11318
UPDATE `creature_template_locale` SET `Name` = '怒焰穴居人' WHERE `locale` = 'zhTW' AND `entry` = 11318;
-- OLD name : 熔岩元素
-- Source : https://www.wowhead.com/wotlk/tw/npc=11321
UPDATE `creature_template_locale` SET `Name` = '熔火元素' WHERE `locale` = 'zhTW' AND `entry` = 11321;
-- OLD name : 灼刃信徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=11322
UPDATE `creature_template_locale` SET `Name` = '燃刃信徒' WHERE `locale` = 'zhTW' AND `entry` = 11322;
-- OLD name : 灼刃執行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11323
UPDATE `creature_template_locale` SET `Name` = '燃刃執行者' WHERE `locale` = 'zhTW' AND `entry` = 11323;
-- OLD name : 灼刃術士
-- Source : https://www.wowhead.com/wotlk/tw/npc=11324
UPDATE `creature_template_locale` SET `Name` = '燃刃術士' WHERE `locale` = 'zhTW' AND `entry` = 11324;
-- OLD name : 異化蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=11327
UPDATE `creature_template_locale` SET `Name` = '跳跳蟲' WHERE `locale` = 'zhTW' AND `entry` = 11327;
-- OLD name : 哈卡萊暗影施法者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11338
UPDATE `creature_template_locale` SET `Name` = '哈卡萊暗影法師' WHERE `locale` = 'zhTW' AND `entry` = 11338;
-- OLD name : [UNUSED] 哈卡狂戰士 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11341
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11341;
-- OLD name : [UNUSED] Hakkar Warlord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11343
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11343;
-- OLD name : [UNUSED] Gurubashi Warlord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11354
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11354;
-- OLD name : 哈卡之子
-- Source : https://www.wowhead.com/wotlk/tw/npc=11357
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 11357;
-- OLD name : [UNUSED]哈卡之女 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11358
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11358;
-- OLD name : 奪魂者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11359
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 11359;
-- OLD name : [UNUSED]祖利安雌虎 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11364
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11364;
-- OLD name : [UNUSED]祖利安雌虎王 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11366
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11366;
-- OLD name : [UNUSED]祖利安虎王 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11367
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11367;
-- OLD name : [UNUSED] 隱匿的覓血蝙蝠 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11369
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11369;
-- OLD name : 拉札希毒蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=11371
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 11371;
-- OLD name : 拉札希奎蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=11372
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 11372;
-- OLD name : 拉札希眼鏡蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=11373
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 11373;
-- OLD name : [UNUSED] 札克斯 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11375
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11375;
-- OLD name : [UNUSED] 洛克漢 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11376
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11376;
-- OLD name : [UNUSED] 靈魂獵手哈克薩爾 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11377
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11377;
-- OLD name : [UNUSED] 尼克雷斯 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11379
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11379;
-- OLD name : 金恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=11381
UPDATE `creature_template_locale` SET `Name` = '吉恩' WHERE `locale` = 'zhTW' AND `entry` = 11381;
-- OLD name : [UNUSED] 提卡沙長老 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11384
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11384;
-- OLD name : [UNUSED] 無情的莫格維 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11385
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11385;
-- OLD name : [UNUSED] 狂怒者加努克 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11386
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11386;
-- OLD name : 沙怒演講者, subname : 沙怒食人妖大使
-- Source : https://www.wowhead.com/wotlk/tw/npc=11387
UPDATE `creature_template_locale` SET `Name` = '沙怒部族演講者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11387;
-- OLD name : 枯木演講者, subname : 枯木食人妖大使
-- Source : https://www.wowhead.com/wotlk/tw/npc=11388
UPDATE `creature_template_locale` SET `Name` = '枯木部族演講者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11388;
-- OLD name : 血頂演講者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11389
UPDATE `creature_template_locale` SET `Name` = '血頂部族演講者' WHERE `locale` = 'zhTW' AND `entry` = 11389;
-- OLD name : 劈顱演講者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11390
UPDATE `creature_template_locale` SET `Name` = '劈顱部族演講者' WHERE `locale` = 'zhTW' AND `entry` = 11390;
-- OLD name : 邪枝演講者, subname : 邪枝食人妖大使
-- Source : https://www.wowhead.com/wotlk/tw/npc=11391
UPDATE `creature_template_locale` SET `Name` = '邪枝部族演講者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11391;
-- OLD name : 蘿倫·普瑞斯頓
-- Source : https://www.wowhead.com/wotlk/tw/npc=11394
UPDATE `creature_template_locale` SET `Name` = '勞倫·普雷斯通' WHERE `locale` = 'zhTW' AND `entry` = 11394;
-- OLD subname : 牧師訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11397
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11397;
-- OLD name : 迪隆·格里高
-- Source : https://www.wowhead.com/wotlk/tw/npc=11404
UPDATE `creature_template_locale` SET `Name` = '迪隆·格雷戈' WHERE `locale` = 'zhTW' AND `entry` = 11404;
-- OLD name : 文森·維爾弗克
-- Source : https://www.wowhead.com/wotlk/tw/npc=11413
UPDATE `creature_template_locale` SET `Name` = '文森特·維爾弗克' WHERE `locale` = 'zhTW' AND `entry` = 11413;
-- OLD name : 小型煉獄火
-- Source : https://www.wowhead.com/wotlk/tw/npc=11437
UPDATE `creature_template_locale` SET `Name` = '小型地獄火' WHERE `locale` = 'zhTW' AND `entry` = 11437;
-- OLD name : 戈多克蠻卒
-- Source : https://www.wowhead.com/wotlk/tw/npc=11441
UPDATE `creature_template_locale` SET `Name` = '戈多克蠻兵' WHERE `locale` = 'zhTW' AND `entry` = 11441;
-- OLD name : 戈多克法師領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=11444
UPDATE `creature_template_locale` SET `Name` = '戈多克大法師' WHERE `locale` = 'zhTW' AND `entry` = 11444;
-- OLD name : [UNUSED] 戈多克戰鬥法師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11449
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11449;
-- OLD name : 戈多克劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11450
UPDATE `creature_template_locale` SET `Name` = '戈多克掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 11450;
-- OLD name : 荒野巡影者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11456
UPDATE `creature_template_locale` SET `Name` = '荒野暗影行者' WHERE `locale` = 'zhTW' AND `entry` = 11456;
-- OLD name : 鐵桉保衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11459
UPDATE `creature_template_locale` SET `Name` = '埃隆巴克保護者' WHERE `locale` = 'zhTW' AND `entry` = 11459;
-- OLD name : [UNUSED] 扭木搜尋者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11463
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11463;
-- OLD name : 精靈貴族召喚者, subname : 辛德拉之屋
-- Source : https://www.wowhead.com/wotlk/tw/npc=11466
UPDATE `creature_template_locale` SET `Name` = '高等精靈召喚者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11466;
-- OLD name : [UNUSED] 艾德雷斯幽靈 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11468
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11468;
-- OLD name : 艾德雷斯巫士
-- Source : https://www.wowhead.com/wotlk/tw/npc=11470
UPDATE `creature_template_locale` SET `Name` = '艾德雷斯巫師' WHERE `locale` = 'zhTW' AND `entry` = 11470;
-- OLD name : 艾德雷斯亡魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=11471
UPDATE `creature_template_locale` SET `Name` = '艾德雷斯鬼怪' WHERE `locale` = 'zhTW' AND `entry` = 11471;
-- OLD name : 艾德雷斯幽靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=11473
UPDATE `creature_template_locale` SET `Name` = '艾德雷斯妖靈' WHERE `locale` = 'zhTW' AND `entry` = 11473;
-- OLD name : 艾德雷斯怨靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=11474
UPDATE `creature_template_locale` SET `Name` = '艾德雷斯鬼魂' WHERE `locale` = 'zhTW' AND `entry` = 11474;
-- OLD name : 艾德雷斯魅靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=11475
UPDATE `creature_template_locale` SET `Name` = '艾德雷斯幻象' WHERE `locale` = 'zhTW' AND `entry` = 11475;
-- OLD name : 精靈貴族骷髏
-- Source : https://www.wowhead.com/wotlk/tw/npc=11476
UPDATE `creature_template_locale` SET `Name` = '高等精靈骷髏' WHERE `locale` = 'zhTW' AND `entry` = 11476;
-- OLD name : 腐爛的精靈貴族
-- Source : https://www.wowhead.com/wotlk/tw/npc=11477
UPDATE `creature_template_locale` SET `Name` = '腐爛的高等精靈' WHERE `locale` = 'zhTW' AND `entry` = 11477;
-- OLD name : [UNUSED] 法力野獸 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11478
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11478;
-- OLD name : [UNUSED]秘法惡獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=11479
UPDATE `creature_template_locale` SET `Name` = '祕法惡獸' WHERE `locale` = 'zhTW' AND `entry` = 11479;
-- OLD name : 秘法畸獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=11480
UPDATE `creature_template_locale` SET `Name` = '祕法畸獸' WHERE `locale` = 'zhTW' AND `entry` = 11480;
-- OLD name : [UNUSED]秘法恐獸 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11481
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11481;
-- OLD subname : 辛德拉統治者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11486
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11486;
-- OLD name : 博學者卡雷迪斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=11487
UPDATE `creature_template_locale` SET `Name` = '卡雷迪斯鎮長' WHERE `locale` = 'zhTW' AND `entry` = 11487;
-- OLD name : 伊琳娜·鴉橡
-- Source : https://www.wowhead.com/wotlk/tw/npc=11488
UPDATE `creature_template_locale` SET `Name` = '伊琳娜·暗木' WHERE `locale` = 'zhTW' AND `entry` = 11488;
-- OLD name : 老鐵桉
-- Source : https://www.wowhead.com/wotlk/tw/npc=11491
UPDATE `creature_template_locale` SET `Name` = '埃隆巴克' WHERE `locale` = 'zhTW' AND `entry` = 11491;
-- OLD name : [UNUSED] 森提烏斯 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11493
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11493;
-- OLD name : [UNUSED] 埃維杜斯 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11495
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11495;
-- OLD name : 傷殘的斯卡爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=11498
UPDATE `creature_template_locale` SET `Name` = '無敵的斯卡爾' WHERE `locale` = 'zhTW' AND `entry` = 11498;
-- OLD name : [UNUSED] 指揮官格莫爾 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11499
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11499;
-- OLD name : [UNUSED] 巴格羅什 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11500
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11500;
-- OLD name : 木喉護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=11516
UPDATE `creature_template_locale` SET `Name` = '木喉守衛' WHERE `locale` = 'zhTW' AND `entry` = 11516;
-- OLD subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=11536
UPDATE `creature_template_locale` SET `Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 11536;
-- OLD name : 木喉秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=11552
UPDATE `creature_template_locale` SET `Name` = '木喉秘法師' WHERE `locale` = 'zhTW' AND `entry` = 11552;
-- OLD name : 基澤爾頓商隊科多獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=11564
UPDATE `creature_template_locale` SET `Name` = '基澤爾頓車隊科多獸' WHERE `locale` = 'zhTW' AND `entry` = 11564;
-- OLD name : 暴風元素
-- Source : https://www.wowhead.com/wotlk/tw/npc=11579
UPDATE `creature_template_locale` SET `Name` = '泰匹斯特' WHERE `locale` = 'zhTW' AND `entry` = 11579;
-- OLD name : 『板手』挖掘者維里圖斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=11617
UPDATE `creature_template_locale` SET `Name` = '維里圖斯' WHERE `locale` = 'zhTW' AND `entry` = 11617;
-- OLD name : 天譴召喚水晶
-- Source : https://www.wowhead.com/wotlk/tw/npc=11623
UPDATE `creature_template_locale` SET `Name` = '天災召喚水晶' WHERE `locale` = 'zhTW' AND `entry` = 11623;
-- OLD name : 凋零的屍體
-- Source : https://www.wowhead.com/wotlk/tw/npc=11628
UPDATE `creature_template_locale` SET `Name` = '乾枯的屍體' WHERE `locale` = 'zhTW' AND `entry` = 11628;
-- OLD name : 潔西卡·雷德帕斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=11629
UPDATE `creature_template_locale` SET `Name` = '傑希卡·雷德帕斯' WHERE `locale` = 'zhTW' AND `entry` = 11629;
-- OLD name : 熔火巨人
-- Source : https://www.wowhead.com/wotlk/tw/npc=11658
UPDATE `creature_template_locale` SET `Name` = '熔核巨人' WHERE `locale` = 'zhTW' AND `entry` = 11658;
-- OLD name : 熔火摧毀者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11659
UPDATE `creature_template_locale` SET `Name` = '熔核摧毀者' WHERE `locale` = 'zhTW' AND `entry` = 11659;
-- OLD name : [UNUSED] Molten Colossus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11660
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11660;
-- OLD name : 喚焰者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11661
UPDATE `creature_template_locale` SET `Name` = '烈焰行者' WHERE `locale` = 'zhTW' AND `entry` = 11661;
-- OLD name : 喚焰者祭司
-- Source : https://www.wowhead.com/wotlk/tw/npc=11662
UPDATE `creature_template_locale` SET `Name` = '烈焰行者祭司' WHERE `locale` = 'zhTW' AND `entry` = 11662;
-- OLD name : 喚焰者醫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11663
UPDATE `creature_template_locale` SET `Name` = '烈焰行者醫師' WHERE `locale` = 'zhTW' AND `entry` = 11663;
-- OLD name : 喚焰者精英
-- Source : https://www.wowhead.com/wotlk/tw/npc=11664
UPDATE `creature_template_locale` SET `Name` = '烈焰行者精英' WHERE `locale` = 'zhTW' AND `entry` = 11664;
-- OLD name : [UNUSED] Flame Shrieker (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11670
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11670;
-- OLD name : 熔核犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=11671
UPDATE `creature_template_locale` SET `Name` = '熔火惡犬' WHERE `locale` = 'zhTW' AND `entry` = 11671;
-- OLD name : 熔核怒犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=11672
UPDATE `creature_template_locale` SET `Name` = '熔火怒犬' WHERE `locale` = 'zhTW' AND `entry` = 11672;
-- OLD name : 熔核犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=11673
UPDATE `creature_template_locale` SET `Name` = '上古熔核犬' WHERE `locale` = 'zhTW' AND `entry` = 11673;
-- OLD name : 戰歌伐木工
-- Source : https://www.wowhead.com/wotlk/tw/npc=11681
UPDATE `creature_template_locale` SET `Name` = '部落伐木工' WHERE `locale` = 'zhTW' AND `entry` = 11681;
-- OLD name : 哥布林砍樹工
-- Source : https://www.wowhead.com/wotlk/tw/npc=11684
UPDATE `creature_template_locale` SET `Name` = '戰歌伐木機' WHERE `locale` = 'zhTW' AND `entry` = 11684;
-- OLD name : 棕色科多獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=11689
UPDATE `creature_template_locale` SET `Name` = '科多獸坐騎 (棕色)' WHERE `locale` = 'zhTW' AND `entry` = 11689;
-- OLD subname : 冬刃豹訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11696
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11696;
-- OLD subname : 暴風之王
-- Source : https://www.wowhead.com/wotlk/tw/npc=11699
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11699;
-- OLD subname : 暴掠龍訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11701
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11701;
-- OLD subname : 暴掠龍訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11702
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11702;
-- OLD name : 拉亞恩·升曦
-- Source : https://www.wowhead.com/wotlk/tw/npc=11705
UPDATE `creature_template_locale` SET `Name` = '拉亞恩·晨光' WHERE `locale` = 'zhTW' AND `entry` = 11705;
-- OLD name : 黑木追蹤者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11713
UPDATE `creature_template_locale` SET `Name` = '黑幕追蹤者' WHERE `locale` = 'zhTW' AND `entry` = 11713;
-- OLD name : 欺詐的瑪洛什
-- Source : https://www.wowhead.com/wotlk/tw/npc=11714
UPDATE `creature_template_locale` SET `Name` = '瑪洛什' WHERE `locale` = 'zhTW' AND `entry` = 11714;
-- OLD name : 亞什沙巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11723
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 11723;
-- OLD name : 佐拉劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11728
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 11728;
-- OLD name : 雷戈伏擊者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11730
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 11730;
-- OLD name : 雷戈主宰
-- Source : https://www.wowhead.com/wotlk/tw/npc=11734
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 11734;
-- OLD name : 掠沙誘捕者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11738
UPDATE `creature_template_locale` SET `Name` = '掠沙蜘蛛' WHERE `locale` = 'zhTW' AND `entry` = 11738;
-- OLD name : 灰燼風暴者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11744
UPDATE `creature_template_locale` SET `Name` = '灰塵風暴' WHERE `locale` = 'zhTW' AND `entry` = 11744;
-- OLD name : 珊曼莎·迅蹄
-- Source : https://www.wowhead.com/wotlk/tw/npc=11748
UPDATE `creature_template_locale` SET `Name` = '薩曼莎·迅蹄' WHERE `locale` = 'zhTW' AND `entry` = 11748;
-- OLD name : 裂影雷鳴者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11779
UPDATE `creature_template_locale` SET `Name` = '暗影碎片雷鳴者' WHERE `locale` = 'zhTW' AND `entry` = 11779;
-- OLD name : 琥珀裂片狂怒者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11780
UPDATE `creature_template_locale` SET `Name` = '琥珀碎片暴怒者' WHERE `locale` = 'zhTW' AND `entry` = 11780;
-- OLD name : 瑟萊德絲守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11784
UPDATE `creature_template_locale` SET `Name` = '瑟萊德絲衛士' WHERE `locale` = 'zhTW' AND `entry` = 11784;
-- OLD name : 岩石鑽孔蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=11787
UPDATE `creature_template_locale` SET `Name` = '岩孔蟲' WHERE `locale` = 'zhTW' AND `entry` = 11787;
-- OLD name : 塞雷布拉斯之女
-- Source : https://www.wowhead.com/wotlk/tw/npc=11794
UPDATE `creature_template_locale` SET `Name` = '瑟雷布萊之女' WHERE `locale` = 'zhTW' AND `entry` = 11794;
-- OLD name : 暮光守衛者巴靈頓·埃克斯特
-- Source : https://www.wowhead.com/wotlk/tw/npc=11803
UPDATE `creature_template_locale` SET `Name` = '暮光守護者巴靈頓·埃克斯特' WHERE `locale` = 'zhTW' AND `entry` = 11803;
-- OLD name : 暮光守衛者哈弗斯·靈刃
-- Source : https://www.wowhead.com/wotlk/tw/npc=11804
UPDATE `creature_template_locale` SET `Name` = '暮光守護者哈弗斯·靈刃' WHERE `locale` = 'zhTW' AND `entry` = 11804;
-- OLD name : 珂爾·鐵眼
-- Source : https://www.wowhead.com/wotlk/tw/npc=11813
UPDATE `creature_template_locale` SET `Name` = '科爾·鐵眼' WHERE `locale` = 'zhTW' AND `entry` = 11813;
-- OLD name : 月光林地守望者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11822
UPDATE `creature_template_locale` SET `Name` = '月光林地守衛' WHERE `locale` = 'zhTW' AND `entry` = 11822;
-- OLD name : 守衛者雷姆洛斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=11832
UPDATE `creature_template_locale` SET `Name` = '守護者雷姆洛斯' WHERE `locale` = 'zhTW' AND `entry` = 11832;
-- OLD name : 蠻爪秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=11838
UPDATE `creature_template_locale` SET `Name` = '蠻爪秘法師' WHERE `locale` = 'zhTW' AND `entry` = 11838;
-- OLD name : 原生蠻爪豺狼人
-- Source : https://www.wowhead.com/wotlk/tw/npc=11840
UPDATE `creature_template_locale` SET `Name` = '蠻爪突擊隊員' WHERE `locale` = 'zhTW' AND `entry` = 11840;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=11863
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11863;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=11865
UPDATE `creature_template_locale` SET `Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 11865;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=11866
UPDATE `creature_template_locale` SET `Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 11866;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=11867
UPDATE `creature_template_locale` SET `Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 11867;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=11868
UPDATE `creature_template_locale` SET `Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 11868;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=11869
UPDATE `creature_template_locale` SET `Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 11869;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=11870
UPDATE `creature_template_locale` SET `Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 11870;
-- OLD name : 迫擊砲小隊活動假人
-- Source : https://www.wowhead.com/wotlk/tw/npc=11875
UPDATE `creature_template_locale` SET `Name` = '迫擊炮小隊活動假人' WHERE `locale` = 'zhTW' AND `entry` = 11875;
-- OLD name : 荒疫獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=11885
UPDATE `creature_template_locale` SET `Name` = '荒蕪犬' WHERE `locale` = 'zhTW' AND `entry` = 11885;
-- OLD name : 蘇菲亞
-- Source : https://www.wowhead.com/wotlk/tw/npc=11906
UPDATE `creature_template_locale` SET `Name` = '索菲亞' WHERE `locale` = 'zhTW' AND `entry` = 11906;
-- OLD name : 恐怖圖騰巫士
-- Source : https://www.wowhead.com/wotlk/tw/npc=11913
UPDATE `creature_template_locale` SET `Name` = '恐怖圖騰巫師' WHERE `locale` = 'zhTW' AND `entry` = 11913;
-- OLD name : 滾岩岩石守衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11915
UPDATE `creature_template_locale` SET `Name` = '高戈護石者' WHERE `locale` = 'zhTW' AND `entry` = 11915;
-- OLD name : 滾岩地卜師
-- Source : https://www.wowhead.com/wotlk/tw/npc=11917
UPDATE `creature_template_locale` SET `Name` = '高戈地卜師' WHERE `locale` = 'zhTW' AND `entry` = 11917;
-- OLD name : 滾岩搗石者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11918
UPDATE `creature_template_locale` SET `Name` = '高戈裂石者' WHERE `locale` = 'zhTW' AND `entry` = 11918;
-- OLD name : [PH] 北郡禮物分配者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11926
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11926;
-- OLD name : 惡魔之門守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=11937
UPDATE `creature_template_locale` SET `Name` = '惡魔之門衛士' WHERE `locale` = 'zhTW' AND `entry` = 11937;
-- OLD name : 年輕的提里奧
-- Source : https://www.wowhead.com/wotlk/tw/npc=11938
UPDATE `creature_template_locale` SET `Name` = '年輕的提里恩' WHERE `locale` = 'zhTW' AND `entry` = 11938;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=11958
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 11958;
-- OLD name : [UNUSED] 黑曜石毀滅者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=11959
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 11959;
-- OLD name : [NOT USED]奈薩里奧
-- Source : https://www.wowhead.com/wotlk/tw/npc=11978
UPDATE `creature_template_locale` SET `Name` = '奈薩里安' WHERE `locale` = 'zhTW' AND `entry` = 11978;
-- OLD name : 幼龍領主勒西雷爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=12017
UPDATE `creature_template_locale` SET `Name` = '龍領主勒西雷爾' WHERE `locale` = 'zhTW' AND `entry` = 12017;
-- OLD name : 月光林地鍊金術訓練師, subname : 鍊金術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=12020
UPDATE `creature_template_locale` SET `Name` = '月光林地煉金術訓練師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 12020;
-- OLD subname : 採礦訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=12035
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 12035;
-- OLD name : 葛瑞拉·石拳, subname : 雜貨商
-- Source : https://www.wowhead.com/wotlk/tw/npc=12036
UPDATE `creature_template_locale` SET `Name` = '鷹巢山雜貨商人',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 12036;
-- OLD name : 厄索洛克
-- Source : https://www.wowhead.com/wotlk/tw/npc=12037
UPDATE `creature_template_locale` SET `Name` = '烏索洛克' WHERE `locale` = 'zhTW' AND `entry` = 12037;
-- OLD subname : 屠夫
-- Source : https://www.wowhead.com/wotlk/tw/npc=12039
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 12039;
-- OLD subname : 護甲鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=12040
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 12040;
-- OLD name : 日石鍛造供應商, subname : 鍛造和採礦供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=12044
UPDATE `creature_template_locale` SET `Name` = '日石鐵匠補給',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 12044;
-- OLD name : 霜狼守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12053
UPDATE `creature_template_locale` SET `Name` = '霜狼守衛者' WHERE `locale` = 'zhTW' AND `entry` = 12053;
-- OLD name : 曦逐者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12054
UPDATE `creature_template_locale` SET `Name` = '晨逐者' WHERE `locale` = 'zhTW' AND `entry` = 12054;
-- OLD name : 熔岩劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12100
UPDATE `creature_template_locale` SET `Name` = '熔岩掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 12100;
-- OLD name : 喚焰者保衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12119
UPDATE `creature_template_locale` SET `Name` = '烈焰行者護衛' WHERE `locale` = 'zhTW' AND `entry` = 12119;
-- OLD name : 提里奧·弗丁領主, subname : 白銀之手騎士團
-- Source : https://www.wowhead.com/wotlk/tw/npc=12126
UPDATE `creature_template_locale` SET `Name` = '提里恩·弗丁',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 12126;
-- OLD name : 雷矛衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=12127
UPDATE `creature_template_locale` SET `Name` = '雷矛衛兵' WHERE `locale` = 'zhTW' AND `entry` = 12127;
-- OLD name : 奧妮克希亞護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=12129
UPDATE `creature_template_locale` SET `Name` = '奧妮克希亞守衛' WHERE `locale` = 'zhTW' AND `entry` = 12129;
-- OLD name : 斯納爾克
-- Source : https://www.wowhead.com/wotlk/tw/npc=12136
UPDATE `creature_template_locale` SET `Name` = '思娜克‧迅扣' WHERE `locale` = 'zhTW' AND `entry` = 12136;
-- OLD name : 伊露恩的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12140
UPDATE `creature_template_locale` SET `Name` = '伊露恩的衛士' WHERE `locale` = 'zhTW' AND `entry` = 12140;
-- OLD name : 喚焰者守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12142
UPDATE `creature_template_locale` SET `Name` = '烈焰行者衛兵' WHERE `locale` = 'zhTW' AND `entry` = 12142;
-- OLD name : 科多獸坐騎 (橄欖綠)
-- Source : https://www.wowhead.com/wotlk/tw/npc=12146
UPDATE `creature_template_locale` SET `Name` = '科多獸坐騎 (橄欖色)' WHERE `locale` = 'zhTW' AND `entry` = 12146;
-- OLD name : 藍色科多獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=12148
UPDATE `creature_template_locale` SET `Name` = '科多獸坐騎 (藍綠色)' WHERE `locale` = 'zhTW' AND `entry` = 12148;
-- OLD name : 灰色科多獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=12149
UPDATE `creature_template_locale` SET `Name` = '科多獸坐騎 (灰色)' WHERE `locale` = 'zhTW' AND `entry` = 12149;
-- OLD name : 綠色科多獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=12151
UPDATE `creature_template_locale` SET `Name` = '科多獸坐騎 (綠色)' WHERE `locale` = 'zhTW' AND `entry` = 12151;
-- OLD name : 『血怒者』科爾拉克
-- Source : https://www.wowhead.com/wotlk/tw/npc=12159
UPDATE `creature_template_locale` SET `Name` = '血怒者科爾拉克' WHERE `locale` = 'zhTW' AND `entry` = 12159;
-- OLD name : 受折磨的德魯伊
-- Source : https://www.wowhead.com/wotlk/tw/npc=12178
UPDATE `creature_template_locale` SET `Name` = '被折磨的德魯伊' WHERE `locale` = 'zhTW' AND `entry` = 12178;
-- OLD name : 受折磨的哨兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=12179
UPDATE `creature_template_locale` SET `Name` = '被折磨的哨兵' WHERE `locale` = 'zhTW' AND `entry` = 12179;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=12196
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 12196;
-- OLD name : 蔚藍龍人
-- Source : https://www.wowhead.com/wotlk/tw/npc=12200
UPDATE `creature_template_locale` SET `Name` = '蔚藍龍族' WHERE `locale` = 'zhTW' AND `entry` = 12200;
-- OLD name : 惡鞭劫掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12204
UPDATE `creature_template_locale` SET `Name` = '惡鞭掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 12204;
-- OLD name : 劇毒黏液怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=12221
UPDATE `creature_template_locale` SET `Name` = '毒性軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 12221;
-- OLD name : 爬行淤泥怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=12222
UPDATE `creature_template_locale` SET `Name` = '爬行污泥怪' WHERE `locale` = 'zhTW' AND `entry` = 12222;
-- OLD name : 洞窟跛行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12224
UPDATE `creature_template_locale` SET `Name` = '洞窟遊蕩者' WHERE `locale` = 'zhTW' AND `entry` = 12224;
-- OLD name : 奧妮克希亞飛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=12260
UPDATE `creature_template_locale` SET `Name` = '奧妮克希亞幼龍' WHERE `locale` = 'zhTW' AND `entry` = 12260;
-- OLD name : 生病的蹬羚
-- Source : https://www.wowhead.com/wotlk/tw/npc=12296
UPDATE `creature_template_locale` SET `Name` = '生病的瞪羚' WHERE `locale` = 'zhTW' AND `entry` = 12296;
-- OLD name : 被治癒的蹬羚
-- Source : https://www.wowhead.com/wotlk/tw/npc=12297
UPDATE `creature_template_locale` SET `Name` = '被治癒的瞪羚' WHERE `locale` = 'zhTW' AND `entry` = 12297;
-- OLD name : 燃刃毒藥師
-- Source : https://www.wowhead.com/wotlk/tw/npc=12319
UPDATE `creature_template_locale` SET `Name` = '火刃毒藥師' WHERE `locale` = 'zhTW' AND `entry` = 12319;
-- OLD name : 燃刃鎮壓者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12320
UPDATE `creature_template_locale` SET `Name` = '火刃鎮壓者' WHERE `locale` = 'zhTW' AND `entry` = 12320;
-- OLD name : 葬影村守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12338
UPDATE `creature_template_locale` SET `Name` = '葬影村衛兵' WHERE `locale` = 'zhTW' AND `entry` = 12338;
-- OLD subname : 血色十字軍神諭者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12339
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 12339;
-- OLD name : 雜斑赤紅迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=12345
UPDATE `creature_template_locale` SET `Name` = '紅色迅猛龍' WHERE `locale` = 'zhTW' AND `entry` = 12345;
-- OLD name : 翡翠騎乘用迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=12346
UPDATE `creature_template_locale` SET `Name` = '綠色迅猛龍' WHERE `locale` = 'zhTW' AND `entry` = 12346;
-- OLD name : 青色騎乘用迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=12349
UPDATE `creature_template_locale` SET `Name` = '青色迅猛龍' WHERE `locale` = 'zhTW' AND `entry` = 12349;
-- OLD name : 紫色騎乘用迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=12350
UPDATE `creature_template_locale` SET `Name` = '紫色迅猛龍' WHERE `locale` = 'zhTW' AND `entry` = 12350;
-- OLD name : 恐狼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=12351
UPDATE `creature_template_locale` SET `Name` = '恐狼坐騎' WHERE `locale` = 'zhTW' AND `entry` = 12351;
-- OLD name : 森林狼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=12353
UPDATE `creature_template_locale` SET `Name` = '森林狼坐騎' WHERE `locale` = 'zhTW' AND `entry` = 12353;
-- OLD name : 未塗色機械陸行鳥X型
-- Source : https://www.wowhead.com/wotlk/tw/npc=12366
UPDATE `creature_template_locale` SET `Name` = '未塗色的機械陸行鳥' WHERE `locale` = 'zhTW' AND `entry` = 12366;
-- OLD name : 柯拉加魯領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=12369
UPDATE `creature_template_locale` SET `Name` = '柯拉加魯' WHERE `locale` = 'zhTW' AND `entry` = 12369;
-- OLD name : 冰霜山羊
-- Source : https://www.wowhead.com/wotlk/tw/npc=12371
UPDATE `creature_template_locale` SET `Name` = '霜山羊' WHERE `locale` = 'zhTW' AND `entry` = 12371;
-- OLD name : 騎乘用白山羊坐騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=12374
UPDATE `creature_template_locale` SET `Name` = '白色山羊坐騎' WHERE `locale` = 'zhTW' AND `entry` = 12374;
-- OLD name : 迫擊砲小隊高級假人
-- Source : https://www.wowhead.com/wotlk/tw/npc=12385
UPDATE `creature_template_locale` SET `Name` = '迫擊炮小隊高級活動假人' WHERE `locale` = 'zhTW' AND `entry` = 12385;
-- OLD name : 魔導師克亞拉
-- Source : https://www.wowhead.com/wotlk/tw/npc=12386
UPDATE `creature_template_locale` SET `Name` = '大法師克亞拉' WHERE `locale` = 'zhTW' AND `entry` = 12386;
-- OLD name : 可憎的大泥漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=12387
UPDATE `creature_template_locale` SET `Name` = '可憎的大軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 12387;
-- OLD name : 卡札克領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=12397
UPDATE `creature_template_locale` SET `Name` = '卡札克' WHERE `locale` = 'zhTW' AND `entry` = 12397;
-- OLD name : [NOT USED]死爪幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=12417
UPDATE `creature_template_locale` SET `Name` = '黑翼雛龍' WHERE `locale` = 'zhTW' AND `entry` = 12417;
-- OLD name : 戈多克土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=12418
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 12418;
-- OLD name : 仿真蟾蜍
-- Source : https://www.wowhead.com/wotlk/tw/npc=12419
UPDATE `creature_template_locale` SET `Name` = '逼真的蟾蜍' WHERE `locale` = 'zhTW' AND `entry` = 12419;
-- OLD name : 死爪龍裔
-- Source : https://www.wowhead.com/wotlk/tw/npc=12422
UPDATE `creature_template_locale` SET `Name` = '死爪龍人' WHERE `locale` = 'zhTW' AND `entry` = 12422;
-- OLD name : 守衛羅伯茲
-- Source : https://www.wowhead.com/wotlk/tw/npc=12423
UPDATE `creature_template_locale` SET `Name` = '衛兵羅伯茲' WHERE `locale` = 'zhTW' AND `entry` = 12423;
-- OLD name : 亡靈守衛科爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=12428
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵科爾' WHERE `locale` = 'zhTW' AND `entry` = 12428;
-- OLD name : 『旋影者』克雷希斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=12433
UPDATE `creature_template_locale` SET `Name` = '克雷希斯' WHERE `locale` = 'zhTW' AND `entry` = 12433;
-- OLD name : 黑翼監工
-- Source : https://www.wowhead.com/wotlk/tw/npc=12458
UPDATE `creature_template_locale` SET `Name` = '黑翼工頭' WHERE `locale` = 'zhTW' AND `entry` = 12458;
-- OLD name : 死爪龍獸守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=12460
UPDATE `creature_template_locale` SET `Name` = '黑翼龍人護衛' WHERE `locale` = 'zhTW' AND `entry` = 12460;
-- OLD name : 死爪監督者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12461
UPDATE `creature_template_locale` SET `Name` = '黑翼監工' WHERE `locale` = 'zhTW' AND `entry` = 12461;
-- OLD name : [NOT USED] Blackwing Warlord
-- Source : https://www.wowhead.com/wotlk/tw/npc=12462
UPDATE `creature_template_locale` SET `Name` = '黑翼督軍' WHERE `locale` = 'zhTW' AND `entry` = 12462;
-- OLD name : 死爪龍人
-- Source : https://www.wowhead.com/wotlk/tw/npc=12465
UPDATE `creature_template_locale` SET `Name` = '死爪老龍人' WHERE `locale` = 'zhTW' AND `entry` = 12465;
-- OLD name : [NOT USED]死爪逆鱗龍人
-- Source : https://www.wowhead.com/wotlk/tw/npc=12466
UPDATE `creature_template_locale` SET `Name` = '死爪刺鱗龍人' WHERE `locale` = 'zhTW' AND `entry` = 12466;
-- OLD name : [NOT USED]死爪震地者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12469
UPDATE `creature_template_locale` SET `Name` = '死爪震地者' WHERE `locale` = 'zhTW' AND `entry` = 12469;
-- OLD name : [NOT USED]死爪火舌龍人
-- Source : https://www.wowhead.com/wotlk/tw/npc=12470
UPDATE `creature_template_locale` SET `Name` = '死爪火舌龍人' WHERE `locale` = 'zhTW' AND `entry` = 12470;
-- OLD name : 翡翠樹林守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=12474
UPDATE `creature_template_locale` SET `Name` = '翡翠樹林衛兵' WHERE `locale` = 'zhTW' AND `entry` = 12474;
-- OLD name : 翡翠樹木護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=12475
UPDATE `creature_template_locale` SET `Name` = '翡翠樹林看守' WHERE `locale` = 'zhTW' AND `entry` = 12475;
-- OLD name : 翡翠神諭者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12476
UPDATE `creature_template_locale` SET `Name` = '翡翠聖賢' WHERE `locale` = 'zhTW' AND `entry` = 12476;
-- OLD name : 青綠守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=12477
UPDATE `creature_template_locale` SET `Name` = '青綠護衛者' WHERE `locale` = 'zhTW' AND `entry` = 12477;
-- OLD name : 青綠樹林護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=12479
UPDATE `creature_template_locale` SET `Name` = '青綠樹林守衛' WHERE `locale` = 'zhTW' AND `entry` = 12479;
-- OLD subname : 守衛隊長
-- Source : https://www.wowhead.com/wotlk/tw/npc=12480
UPDATE `creature_template_locale` SET `Title` = '衛兵隊長' WHERE `locale` = 'zhTW' AND `entry` = 12480;
-- OLD name : 幻影:黑龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=12536
UPDATE `creature_template_locale` SET `Name` = '幻象：黑龍' WHERE `locale` = 'zhTW' AND `entry` = 12536;
-- OLD name : 『控制者』葛瑞托克
-- Source : https://www.wowhead.com/wotlk/tw/npc=12557
UPDATE `creature_template_locale` SET `Name` = '黑翼控制者' WHERE `locale` = 'zhTW' AND `entry` = 12557;
-- OLD name : 諾里·激流
-- Source : https://www.wowhead.com/wotlk/tw/npc=12738
UPDATE `creature_template_locale` SET `Name` = '諾里斯·激流' WHERE `locale` = 'zhTW' AND `entry` = 12738;
-- OLD name : 奧妮克希亞的精英守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=12739
UPDATE `creature_template_locale` SET `Name` = '奧妮克希亞的精英護衛' WHERE `locale` = 'zhTW' AND `entry` = 12739;
-- OLD name : 戴格哈默上尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=12777
UPDATE `creature_template_locale` SET `Name` = '戴格哈默中尉' WHERE `locale` = 'zhTW' AND `entry` = 12777;
-- OLD subname : 外域護甲軍需官
-- Source : https://www.wowhead.com/wotlk/tw/npc=12778
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 12778;
-- OLD name : 士官長天影
-- Source : https://www.wowhead.com/wotlk/tw/npc=12780
UPDATE `creature_template_locale` SET `Name` = '赫爾特·天影' WHERE `locale` = 'zhTW' AND `entry` = 12780;
-- OLD subname : 戰爭軍需官
-- Source : https://www.wowhead.com/wotlk/tw/npc=12783
UPDATE `creature_template_locale` SET `Title` = '坐騎商人' WHERE `locale` = 'zhTW' AND `entry` = 12783;
-- OLD subname : 傳承武器軍需官
-- Source : https://www.wowhead.com/wotlk/tw/npc=12784
UPDATE `creature_template_locale` SET `Title` = '武器軍需官' WHERE `locale` = 'zhTW' AND `entry` = 12784;
-- OLD name : 士官長克萊特, subname : 傳承護甲軍需官
-- Source : https://www.wowhead.com/wotlk/tw/npc=12785
UPDATE `creature_template_locale` SET `Name` = '克萊特軍士長',`Title` = '護甲軍需官' WHERE `locale` = 'zhTW' AND `entry` = 12785;
-- OLD name : 守衛奎因
-- Source : https://www.wowhead.com/wotlk/tw/npc=12786
UPDATE `creature_template_locale` SET `Name` = '衛兵奎因' WHERE `locale` = 'zhTW' AND `entry` = 12786;
-- OLD name : 守衛哈默德
-- Source : https://www.wowhead.com/wotlk/tw/npc=12787
UPDATE `creature_template_locale` SET `Name` = '衛兵哈默德' WHERE `locale` = 'zhTW' AND `entry` = 12787;
-- OLD name : 石衛士札爾格
-- Source : https://www.wowhead.com/wotlk/tw/npc=12794
UPDATE `creature_template_locale` SET `Name` = '石頭守衛札爾格' WHERE `locale` = 'zhTW' AND `entry` = 12794;
-- OLD name : [PH] TEST Fire God (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=12804
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 12804;
-- OLD name : 岩漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=12806
UPDATE `creature_template_locale` SET `Name` = '熔岩怪' WHERE `locale` = 'zhTW' AND `entry` = 12806;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/tw/npc=12807
UPDATE `creature_template_locale` SET `Title` = '惡魔訓練師' WHERE `locale` = 'zhTW' AND `entry` = 12807;
-- OLD name : 遊蕩的古樹保衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=12836
UPDATE `creature_template_locale` SET `Name` = '遊蕩的守護古樹' WHERE `locale` = 'zhTW' AND `entry` = 12836;
-- OLD name : 幽光(只呈現鬼魂形態)
-- Source : https://www.wowhead.com/wotlk/tw/npc=12861
UPDATE `creature_template_locale` SET `Name` = '小精靈(只呈現鬼魂形態)' WHERE `locale` = 'zhTW' AND `entry` = 12861;
-- OLD name : 麥雷姆·月詠
-- Source : https://www.wowhead.com/wotlk/tw/npc=12866
UPDATE `creature_template_locale` SET `Name` = '麥雷姆·月歌' WHERE `locale` = 'zhTW' AND `entry` = 12866;
-- OLD name : 范迪姆的幻影
-- Source : https://www.wowhead.com/wotlk/tw/npc=12898
UPDATE `creature_template_locale` SET `Name` = '范迪姆的幻象' WHERE `locale` = 'zhTW' AND `entry` = 12898;
-- OLD name : 碎木崗哨守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=12903
UPDATE `creature_template_locale` SET `Name` = '碎木崗哨衛兵' WHERE `locale` = 'zhTW' AND `entry` = 12903;
-- OLD name : 救贖之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=12904
UPDATE `creature_template_locale` SET `Name` = '救贖之魂' WHERE `locale` = 'zhTW' AND `entry` = 12904;
-- OLD name : 葛列格里·維克多醫生
-- Source : https://www.wowhead.com/wotlk/tw/npc=12920
UPDATE `creature_template_locale` SET `Name` = '格里高利·維克托醫生' WHERE `locale` = 'zhTW' AND `entry` = 12920;
-- OLD subname : 急救訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=12939
UPDATE `creature_template_locale` SET `Title` = '外科醫療隊' WHERE `locale` = 'zhTW' AND `entry` = 12939;
-- OLD name : 布里莫·機簧
-- Source : https://www.wowhead.com/wotlk/tw/npc=12957
UPDATE `creature_template_locale` SET `Name` = '布里莫' WHERE `locale` = 'zhTW' AND `entry` = 12957;
-- OLD subname : 貿易供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=12958
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 12958;
-- OLD name : 科卡爾強盜
-- Source : https://www.wowhead.com/wotlk/tw/npc=12976
UPDATE `creature_template_locale` SET `Name` = '科卡爾搶劫者' WHERE `locale` = 'zhTW' AND `entry` = 12976;
-- OLD name : 戈多克獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=13036
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 13036;
-- OLD subname : 施捨者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13082
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13082;
-- OLD name : 比克斯·晃撞, subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=13084
UPDATE `creature_template_locale` SET `Name` = '比克斯',`Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 13084;
-- OLD name : 冰冷礦坑勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=13097
UPDATE `creature_template_locale` SET `Name` = '冰冷礦坑測量者' WHERE `locale` = 'zhTW' AND `entry` = 13097;
-- OLD name : 深鐵礦坑勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=13098
UPDATE `creature_template_locale` SET `Name` = '深鐵礦坑測量者' WHERE `locale` = 'zhTW' AND `entry` = 13098;
-- OLD name : 指揮官藍道夫
-- Source : https://www.wowhead.com/wotlk/tw/npc=13139
UPDATE `creature_template_locale` SET `Name` = '指揮官拉多夫' WHERE `locale` = 'zhTW' AND `entry` = 13139;
-- OLD name : 指揮官達多許<old>
-- Source : https://www.wowhead.com/wotlk/tw/npc=13140
UPDATE `creature_template_locale` SET `Name` = '指揮官達多許' WHERE `locale` = 'zhTW' AND `entry` = 13140;
-- OLD name : 猛蹄中尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=13143
UPDATE `creature_template_locale` SET `Name` = '斯托霍夫中尉' WHERE `locale` = 'zhTW' AND `entry` = 13143;
-- OLD name : 莫普中尉<old>
-- Source : https://www.wowhead.com/wotlk/tw/npc=13146
UPDATE `creature_template_locale` SET `Name` = '莫普中尉' WHERE `locale` = 'zhTW' AND `entry` = 13146;
-- OLD name : 辛迪加盜匪
-- Source : https://www.wowhead.com/wotlk/tw/npc=13149
UPDATE `creature_template_locale` SET `Name` = '雪盲強盜' WHERE `locale` = 'zhTW' AND `entry` = 13149;
-- OLD name : 辛迪加指揮官雷松
-- Source : https://www.wowhead.com/wotlk/tw/npc=13151
UPDATE `creature_template_locale` SET `Name` = '辛迪加指揮官雷爾松' WHERE `locale` = 'zhTW' AND `entry` = 13151;
-- OLD name : 亡靈哨兵密探
-- Source : https://www.wowhead.com/wotlk/tw/npc=13155
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵密探' WHERE `locale` = 'zhTW' AND `entry` = 13155;
-- OLD subname : 雷矛物資官
-- Source : https://www.wowhead.com/wotlk/tw/npc=13217
UPDATE `creature_template_locale` SET `Title` = '雷矛軍需官' WHERE `locale` = 'zhTW' AND `entry` = 13217;
-- OLD name : 傑瑞·克鐵面, subname : 霜狼物資官
-- Source : https://www.wowhead.com/wotlk/tw/npc=13219
UPDATE `creature_template_locale` SET `Name` = '耶克里·弗蘭迪',`Title` = '霜狼軍需官' WHERE `locale` = 'zhTW' AND `entry` = 13219;
-- OLD name : 『冰雪之王』洛克霍拉
-- Source : https://www.wowhead.com/wotlk/tw/npc=13256
UPDATE `creature_template_locale` SET `Name` = '冰雪之王洛克霍拉' WHERE `locale` = 'zhTW' AND `entry` = 13256;
-- OLD name : 冰冷礦坑礦工
-- Source : https://www.wowhead.com/wotlk/tw/npc=13317
UPDATE `creature_template_locale` SET `Name` = '冰冷礦坑採掘者' WHERE `locale` = 'zhTW' AND `entry` = 13317;
-- OLD name : 指揮官摩塔莫爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=13318
UPDATE `creature_template_locale` SET `Name` = '指揮官莫泰咪爾' WHERE `locale` = 'zhTW' AND `entry` = 13318;
-- OLD name : 小青蛙
-- Source : https://www.wowhead.com/wotlk/tw/npc=13321
UPDATE `creature_template_locale` SET `Name` = '青蛙' WHERE `locale` = 'zhTW' AND `entry` = 13321;
-- OLD name : 經驗豐富的衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=13324
UPDATE `creature_template_locale` SET `Name` = '經驗豐富的衛兵' WHERE `locale` = 'zhTW' AND `entry` = 13324;
-- OLD name : 經驗豐富的防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13326
UPDATE `creature_template_locale` SET `Name` = '經驗豐富的防禦者' WHERE `locale` = 'zhTW' AND `entry` = 13326;
-- OLD name : 經驗豐富的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13328
UPDATE `creature_template_locale` SET `Name` = '經驗豐富的守衛者' WHERE `locale` = 'zhTW' AND `entry` = 13328;
-- OLD name : 老練的防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13331
UPDATE `creature_template_locale` SET `Name` = '精練的防禦者' WHERE `locale` = 'zhTW' AND `entry` = 13331;
-- OLD name : 老練的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13332
UPDATE `creature_template_locale` SET `Name` = '精練的守衛者' WHERE `locale` = 'zhTW' AND `entry` = 13332;
-- OLD name : 老練的衛士
-- Source : https://www.wowhead.com/wotlk/tw/npc=13333
UPDATE `creature_template_locale` SET `Name` = '精練的衛兵' WHERE `locale` = 'zhTW' AND `entry` = 13333;
-- OLD name : 老練的軍團士兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=13334
UPDATE `creature_template_locale` SET `Name` = '精練的軍團士兵' WHERE `locale` = 'zhTW' AND `entry` = 13334;
-- OLD name : 老練的巡山人
-- Source : https://www.wowhead.com/wotlk/tw/npc=13335
UPDATE `creature_template_locale` SET `Name` = '精練的巡山人' WHERE `locale` = 'zhTW' AND `entry` = 13335;
-- OLD name : 老練的哨兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=13336
UPDATE `creature_template_locale` SET `Name` = '精練的哨兵' WHERE `locale` = 'zhTW' AND `entry` = 13336;
-- OLD name : 老練的戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=13337
UPDATE `creature_template_locale` SET `Name` = '精練的戰士' WHERE `locale` = 'zhTW' AND `entry` = 13337;
-- OLD name : 工程大師斯菲萊克斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=13377
UPDATE `creature_template_locale` SET `Name` = '首席技師斯菲萊克斯' WHERE `locale` = 'zhTW' AND `entry` = 13377;
-- OLD name : 深鐵礦坑礦工
-- Source : https://www.wowhead.com/wotlk/tw/npc=13396
UPDATE `creature_template_locale` SET `Name` = '深鐵礦坑採掘者' WHERE `locale` = 'zhTW' AND `entry` = 13396;
-- OLD name : 薩格尼·羽騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=13417
UPDATE `creature_template_locale` SET `Name` = '薩格尼' WHERE `locale` = 'zhTW' AND `entry` = 13417;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=13418
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13418;
-- OLD name : 『森林之王』伊弗斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=13419
UPDATE `creature_template_locale` SET `Name` = '森林之王伊弗斯' WHERE `locale` = 'zhTW' AND `entry` = 13419;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=13420
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13420;
-- OLD name : 勇猛的守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13421
UPDATE `creature_template_locale` SET `Name` = '勇猛的守衛者' WHERE `locale` = 'zhTW' AND `entry` = 13421;
-- OLD name : 勇猛的防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13422
UPDATE `creature_template_locale` SET `Name` = '勇猛的防禦者' WHERE `locale` = 'zhTW' AND `entry` = 13422;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=13429
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13429;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=13430
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13430;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=13431
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13431;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=13432
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13432;
-- OLD name : 烏爾莫特·叮噹口袋, subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=13433
UPDATE `creature_template_locale` SET `Name` = '烏爾莫特',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13433;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=13434
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13434;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=13435
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13435;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=13436
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 13436;
-- OLD name : 戰場元帥特拉瓦雷
-- Source : https://www.wowhead.com/wotlk/tw/npc=13446
UPDATE `creature_template_locale` SET `Name` = '指揮官特拉瓦雷' WHERE `locale` = 'zhTW' AND `entry` = 13446;
-- OLD name : 將領加瑞克
-- Source : https://www.wowhead.com/wotlk/tw/npc=13449
UPDATE `creature_template_locale` SET `Name` = '突擊隊長加瑞克' WHERE `locale` = 'zhTW' AND `entry` = 13449;
-- OLD subname : 德魯伊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=13476
UPDATE `creature_template_locale` SET `Title` = '藥劑、卷軸和施法材料' WHERE `locale` = 'zhTW' AND `entry` = 13476;
-- OLD name : 復生的古樹
-- Source : https://www.wowhead.com/wotlk/tw/npc=13496
UPDATE `creature_template_locale` SET `Name` = '複生的古樹' WHERE `locale` = 'zhTW' AND `entry` = 13496;
-- OLD name : 老練的前鋒
-- Source : https://www.wowhead.com/wotlk/tw/npc=13518
UPDATE `creature_template_locale` SET `Name` = '精練的前鋒' WHERE `locale` = 'zhTW' AND `entry` = 13518;
-- OLD name : 老練的遊俠
-- Source : https://www.wowhead.com/wotlk/tw/npc=13522
UPDATE `creature_template_locale` SET `Name` = '精練的遊俠' WHERE `locale` = 'zhTW' AND `entry` = 13522;
-- OLD name : 老練的特種兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=13526
UPDATE `creature_template_locale` SET `Name` = '精練的特種兵' WHERE `locale` = 'zhTW' AND `entry` = 13526;
-- OLD name : 霜狼劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13528
UPDATE `creature_template_locale` SET `Name` = '霜狼搶劫者' WHERE `locale` = 'zhTW' AND `entry` = 13528;
-- OLD name : 經驗豐富的劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13529
UPDATE `creature_template_locale` SET `Name` = '經驗豐富的搶劫者' WHERE `locale` = 'zhTW' AND `entry` = 13529;
-- OLD name : 老練的劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13530
UPDATE `creature_template_locale` SET `Name` = '精練的搶劫者' WHERE `locale` = 'zhTW' AND `entry` = 13530;
-- OLD name : 勇猛的劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13531
UPDATE `creature_template_locale` SET `Name` = '勇猛的搶劫者' WHERE `locale` = 'zhTW' AND `entry` = 13531;
-- OLD name : 老練的冰冷礦坑守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=13535
UPDATE `creature_template_locale` SET `Name` = '精練的冰冷礦坑守衛' WHERE `locale` = 'zhTW' AND `entry` = 13535;
-- OLD name : 經驗豐富的冰冷礦坑勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=13537
UPDATE `creature_template_locale` SET `Name` = '經驗豐富的冰冷礦坑測量者' WHERE `locale` = 'zhTW' AND `entry` = 13537;
-- OLD name : 老練的冰冷礦坑勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=13538
UPDATE `creature_template_locale` SET `Name` = '精練的冰冷礦坑測量者' WHERE `locale` = 'zhTW' AND `entry` = 13538;
-- OLD name : 勇猛的冰冷礦坑勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=13539
UPDATE `creature_template_locale` SET `Name` = '勇猛的冰冷礦坑測量者' WHERE `locale` = 'zhTW' AND `entry` = 13539;
-- OLD name : 老練的深鐵礦坑探險者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13541
UPDATE `creature_template_locale` SET `Name` = '精練的深鐵礦坑探險者' WHERE `locale` = 'zhTW' AND `entry` = 13541;
-- OLD name : 經驗豐富的深鐵礦坑劫掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13543
UPDATE `creature_template_locale` SET `Name` = '經驗豐富的深鐵礦坑掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 13543;
-- OLD name : 老練的深鐵礦坑劫掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13544
UPDATE `creature_template_locale` SET `Name` = '精練的深鐵礦坑掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 13544;
-- OLD name : 勇猛的深鐵礦坑劫掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13545
UPDATE `creature_template_locale` SET `Name` = '勇猛的深鐵礦坑掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 13545;
-- OLD name : 老練的冰冷礦坑探險者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13547
UPDATE `creature_template_locale` SET `Name` = '精練的冰冷礦坑探險者' WHERE `locale` = 'zhTW' AND `entry` = 13547;
-- OLD name : 老練的冰冷礦坑入侵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=13550
UPDATE `creature_template_locale` SET `Name` = '精練的冰冷礦坑入侵者' WHERE `locale` = 'zhTW' AND `entry` = 13550;
-- OLD name : 老練的深鐵礦坑守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=13553
UPDATE `creature_template_locale` SET `Name` = '精練的深鐵礦坑守衛' WHERE `locale` = 'zhTW' AND `entry` = 13553;
-- OLD name : 經驗豐富的深鐵礦坑勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=13555
UPDATE `creature_template_locale` SET `Name` = '經驗豐富的深鐵礦坑測量者' WHERE `locale` = 'zhTW' AND `entry` = 13555;
-- OLD name : 老練的深鐵礦坑勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=13556
UPDATE `creature_template_locale` SET `Name` = '精練的深鐵礦坑測量者' WHERE `locale` = 'zhTW' AND `entry` = 13556;
-- OLD name : 勇猛的深鐵礦坑勘測員
-- Source : https://www.wowhead.com/wotlk/tw/npc=13557
UPDATE `creature_template_locale` SET `Name` = '勇猛的深鐵礦坑測量者' WHERE `locale` = 'zhTW' AND `entry` = 13557;
-- OLD name : 雷矛爆破專家
-- Source : https://www.wowhead.com/wotlk/tw/npc=13598
UPDATE `creature_template_locale` SET `Name` = '聯盟爆破專家' WHERE `locale` = 'zhTW' AND `entry` = 13598;
-- OLD name : 圈養的奧特蘭克山羊
-- Source : https://www.wowhead.com/wotlk/tw/npc=13676
UPDATE `creature_template_locale` SET `Name` = '奧特蘭克山羊' WHERE `locale` = 'zhTW' AND `entry` = 13676;
-- OLD name : 守衛者瑪蘭迪斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=13698
UPDATE `creature_template_locale` SET `Name` = '守護者瑪蘭迪斯' WHERE `locale` = 'zhTW' AND `entry` = 13698;
-- OLD name : 提卡·血牙下士
-- Source : https://www.wowhead.com/wotlk/tw/npc=13776
UPDATE `creature_template_locale` SET `Name` = '提卡·血牙' WHERE `locale` = 'zhTW' AND `entry` = 13776;
-- OLD name : 杜爾根·雷矛中士
-- Source : https://www.wowhead.com/wotlk/tw/npc=13777
UPDATE `creature_template_locale` SET `Name` = '杜爾根·雷矛' WHERE `locale` = 'zhTW' AND `entry` = 13777;
-- OLD name : 燃刃夢魘
-- Source : https://www.wowhead.com/wotlk/tw/npc=13836
UPDATE `creature_template_locale` SET `Name` = '火刃夢魘' WHERE `locale` = 'zhTW' AND `entry` = 13836;
-- OLD name : 將領拉格隆德
-- Source : https://www.wowhead.com/wotlk/tw/npc=13840
UPDATE `creature_template_locale` SET `Name` = '拉格隆德' WHERE `locale` = 'zhTW' AND `entry` = 13840;
-- OLD subname : 雷矛守衛招募處
-- Source : https://www.wowhead.com/wotlk/tw/npc=13843
UPDATE `creature_template_locale` SET `Title` = '雷矛衛兵招募處' WHERE `locale` = 'zhTW' AND `entry` = 13843;
-- OLD subname : Click me to clear res effects
-- Source : https://www.wowhead.com/wotlk/tw/npc=13856
UPDATE `creature_template_locale` SET `Title` = 'k me to clear res effects' WHERE `locale` = 'zhTW' AND `entry` = 13856;
-- OLD subname : Click me to clear res effects
-- Source : https://www.wowhead.com/wotlk/tw/npc=13857
UPDATE `creature_template_locale` SET `Title` = 'k me to clear res effects' WHERE `locale` = 'zhTW' AND `entry` = 13857;
-- OLD name : 機電師觸發器
-- Source : https://www.wowhead.com/wotlk/tw/npc=13876
UPDATE `creature_template_locale` SET `Name` = '麥克尼爾觸發器' WHERE `locale` = 'zhTW' AND `entry` = 13876;
-- OLD name : 冰斧秘術使
-- Source : https://www.wowhead.com/wotlk/tw/npc=13956
UPDATE `creature_template_locale` SET `Name` = '冰斧秘法師' WHERE `locale` = 'zhTW' AND `entry` = 13956;
-- OLD name : 受折磨的龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=13976
UPDATE `creature_template_locale` SET `Name` = '被折磨的幼龍' WHERE `locale` = 'zhTW' AND `entry` = 13976;
-- OLD name : 『食人者』加希納克
-- Source : https://www.wowhead.com/wotlk/tw/npc=13977
UPDATE `creature_template_locale` SET `Name` = '食屍者加什納克' WHERE `locale` = 'zhTW' AND `entry` = 13977;
-- OLD name : 『鬱居者』烏夏拉克
-- Source : https://www.wowhead.com/wotlk/tw/npc=14016
UPDATE `creature_template_locale` SET `Name` = '烏什拉克' WHERE `locale` = 'zhTW' AND `entry` = 14016;
-- OLD name : 冰斧哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=14021
UPDATE `creature_template_locale` SET `Name` = '冰斧斥候' WHERE `locale` = 'zhTW' AND `entry` = 14021;
-- OLD name : 腐化的紅色幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=14022
UPDATE `creature_template_locale` SET `Name` = '腐化的紅色雛龍' WHERE `locale` = 'zhTW' AND `entry` = 14022;
-- OLD name : 腐化的綠色幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=14023
UPDATE `creature_template_locale` SET `Name` = '腐化的綠色雛龍' WHERE `locale` = 'zhTW' AND `entry` = 14023;
-- OLD name : 腐化的藍色幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=14024
UPDATE `creature_template_locale` SET `Name` = '腐化的藍色雛龍' WHERE `locale` = 'zhTW' AND `entry` = 14024;
-- OLD name : 腐化的青銅幼龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=14025
UPDATE `creature_template_locale` SET `Name` = '腐化的青銅雛龍' WHERE `locale` = 'zhTW' AND `entry` = 14025;
-- OLD subname : 莫洛加縛靈者
-- Source : https://www.wowhead.com/wotlk/tw/npc=14042
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14042;
-- OLD name : 相位鞭笞者(火焰)
-- Source : https://www.wowhead.com/wotlk/tw/npc=14061
UPDATE `creature_template_locale` SET `Name` = '相位鞭笞者（火焰）' WHERE `locale` = 'zhTW' AND `entry` = 14061;
-- OLD name : 相位鞭笞者(自然)
-- Source : https://www.wowhead.com/wotlk/tw/npc=14062
UPDATE `creature_template_locale` SET `Name` = '相位鞭笞者（自然）' WHERE `locale` = 'zhTW' AND `entry` = 14062;
-- OLD name : 相位鞭笞者(秘法)
-- Source : https://www.wowhead.com/wotlk/tw/npc=14063
UPDATE `creature_template_locale` SET `Name` = '相位鞭笞者（祕法）' WHERE `locale` = 'zhTW' AND `entry` = 14063;
-- OLD name : 暴怒的惡魔守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=14101
UPDATE `creature_template_locale` SET `Name` = '暴怒的地獄衛士' WHERE `locale` = 'zhTW' AND `entry` = 14101;
-- OLD subname : 莫洛加
-- Source : https://www.wowhead.com/wotlk/tw/npc=14143
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14143;
-- OLD subname : 莫洛加
-- Source : https://www.wowhead.com/wotlk/tw/npc=14144
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14144;
-- OLD subname : 莫洛加
-- Source : https://www.wowhead.com/wotlk/tw/npc=14145
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14145;
-- OLD subname : 莫洛加
-- Source : https://www.wowhead.com/wotlk/tw/npc=14146
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14146;
-- OLD subname : 莫洛加
-- Source : https://www.wowhead.com/wotlk/tw/npc=14147
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14147;
-- OLD subname : 莫洛加
-- Source : https://www.wowhead.com/wotlk/tw/npc=14148
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14148;
-- OLD subname : 莫洛加
-- Source : https://www.wowhead.com/wotlk/tw/npc=14161
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14161;
-- OLD subname : 100FR Arcane
-- Source : https://www.wowhead.com/wotlk/tw/npc=14162
UPDATE `creature_template_locale` SET `Title` = 'R Arcane' WHERE `locale` = 'zhTW' AND `entry` = 14162;
-- OLD name : [PH] 墓地傳令官 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=14181
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 14181;
-- OLD name : 相位鞭笞者(冰霜)
-- Source : https://www.wowhead.com/wotlk/tw/npc=14184
UPDATE `creature_template_locale` SET `Name` = '相位鞭笞者（冰霜）' WHERE `locale` = 'zhTW' AND `entry` = 14184;
-- OLD name : [UNUSED]希德·斯圖克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=14201
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 14201;
-- OLD name : 格拉夫斯·斯里諾特
-- Source : https://www.wowhead.com/wotlk/tw/npc=14221
UPDATE `creature_template_locale` SET `Name` = '格拉維斯·斯里諾特' WHERE `locale` = 'zhTW' AND `entry` = 14221;
-- OLD name : 基格勒爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=14228
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 14228;
-- OLD name : 哈尤克
-- Source : https://www.wowhead.com/wotlk/tw/npc=14234
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 14234;
-- OLD name : 軟泥蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=14237
UPDATE `creature_template_locale` SET `Name` = '泥漿蟲' WHERE `locale` = 'zhTW' AND `entry` = 14237;
-- OLD name : 贖罪的鐵桉
-- Source : https://www.wowhead.com/wotlk/tw/npc=14241
UPDATE `creature_template_locale` SET `Name` = '贖罪的埃隆巴克' WHERE `locale` = 'zhTW' AND `entry` = 14241;
-- OLD subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=14242
UPDATE `creature_template_locale` SET `Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 14242;
-- OLD name : 炫彩龍獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=14302
UPDATE `creature_template_locale` SET `Name` = '多彩龍獸' WHERE `locale` = 'zhTW' AND `entry` = 14302;
-- OLD name : 青銅龍獸生成器
-- Source : https://www.wowhead.com/wotlk/tw/npc=14311
UPDATE `creature_template_locale` SET `Name` = '青銅龍獸之子' WHERE `locale` = 'zhTW' AND `entry` = 14311;
-- OLD name : 守衛芬古斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=14321
UPDATE `creature_template_locale` SET `Name` = '衛兵芬古斯' WHERE `locale` = 'zhTW' AND `entry` = 14321;
-- OLD subname : 醉鬼
-- Source : https://www.wowhead.com/wotlk/tw/npc=14322
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14322;
-- OLD name : 守衛斯里基克
-- Source : https://www.wowhead.com/wotlk/tw/npc=14323
UPDATE `creature_template_locale` SET `Name` = '衛兵斯里基克' WHERE `locale` = 'zhTW' AND `entry` = 14323;
-- OLD name : 『觀察者』克魯什
-- Source : https://www.wowhead.com/wotlk/tw/npc=14324
UPDATE `creature_template_locale` SET `Name` = '觀察者克魯什' WHERE `locale` = 'zhTW' AND `entry` = 14324;
-- OLD name : 隊長克羅卡斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=14325
UPDATE `creature_template_locale` SET `Name` = '克羅卡斯' WHERE `locale` = 'zhTW' AND `entry` = 14325;
-- OLD name : 守衛摩爾達
-- Source : https://www.wowhead.com/wotlk/tw/npc=14326
UPDATE `creature_template_locale` SET `Name` = '衛兵摩爾達' WHERE `locale` = 'zhTW' AND `entry` = 14326;
-- OLD name : 黑色戰鬥迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=14330
UPDATE `creature_template_locale` SET `Name` = '黑色作戰迅猛龍' WHERE `locale` = 'zhTW' AND `entry` = 14330;
-- OLD name : 黑色戰駒
-- Source : https://www.wowhead.com/wotlk/tw/npc=14332
UPDATE `creature_template_locale` SET `Name` = '黑色戰馬' WHERE `locale` = 'zhTW' AND `entry` = 14332;
-- OLD name : 黑色戰羊
-- Source : https://www.wowhead.com/wotlk/tw/npc=14335
UPDATE `creature_template_locale` SET `Name` = '白色戰羊' WHERE `locale` = 'zhTW' AND `entry` = 14335;
-- OLD name : 黑色戰虎
-- Source : https://www.wowhead.com/wotlk/tw/npc=14336
UPDATE `creature_template_locale` SET `Name` = '黑色戰豹' WHERE `locale` = 'zhTW' AND `entry` = 14336;
-- OLD name : 怒掌
-- Source : https://www.wowhead.com/wotlk/tw/npc=14342
UPDATE `creature_template_locale` SET `Name` = '拉吉波爾' WHERE `locale` = 'zhTW' AND `entry` = 14342;
-- OLD name : 大地呼喚者弗蘭札爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=14348
UPDATE `creature_template_locale` SET `Name` = '弗蘭紮爾' WHERE `locale` = 'zhTW' AND `entry` = 14348;
-- OLD name : 戈多克·布斯瓦克
-- Source : https://www.wowhead.com/wotlk/tw/npc=14351
UPDATE `creature_template_locale` SET `Name` = '高多克·布斯瓦克' WHERE `locale` = 'zhTW' AND `entry` = 14351;
-- OLD subname : 瑟拉贊恩的使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=14352
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14352;
-- OLD subname : 辛德拉之屋
-- Source : https://www.wowhead.com/wotlk/tw/npc=14358
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14358;
-- OLD name : 辛德拉幽光
-- Source : https://www.wowhead.com/wotlk/tw/npc=14361
UPDATE `creature_template_locale` SET `Name` = '辛德拉小精靈' WHERE `locale` = 'zhTW' AND `entry` = 14361;
-- OLD subname : 辛德拉之屋
-- Source : https://www.wowhead.com/wotlk/tw/npc=14364
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14364;
-- OLD name : 博識者萊德羅斯, subname : 辛德拉之屋
-- Source : https://www.wowhead.com/wotlk/tw/npc=14368
UPDATE `creature_template_locale` SET `Name` = '博學者萊德羅斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14368;
-- OLD subname : 辛德拉之屋
-- Source : https://www.wowhead.com/wotlk/tw/npc=14369
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14369;
-- OLD name : 灰屍蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=14370
UPDATE `creature_template_locale` SET `Name` = '屍蟲' WHERE `locale` = 'zhTW' AND `entry` = 14370;
-- OLD name : 辛德拉補給官, subname : 辛德拉之屋
-- Source : https://www.wowhead.com/wotlk/tw/npc=14371
UPDATE `creature_template_locale` SET `Name` = '辛德拉聖職者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14371;
-- OLD name : 博識者亞沃, subname : 辛德拉之屋
-- Source : https://www.wowhead.com/wotlk/tw/npc=14381
UPDATE `creature_template_locale` SET `Name` = '博學者亞沃',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14381;
-- OLD name : 博識者麥庫斯, subname : 辛德拉之屋
-- Source : https://www.wowhead.com/wotlk/tw/npc=14382
UPDATE `creature_template_locale` SET `Name` = '博學者麥庫斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14382;
-- OLD name : 博識者基爾達斯, subname : 辛德拉之屋
-- Source : https://www.wowhead.com/wotlk/tw/npc=14383
UPDATE `creature_template_locale` SET `Name` = '博學者基爾達斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14383;
-- OLD name : 末日守衛爪牙
-- Source : https://www.wowhead.com/wotlk/tw/npc=14385
UPDATE `creature_template_locale` SET `Name` = '末日守衛' WHERE `locale` = 'zhTW' AND `entry` = 14385;
-- OLD name : 基爾羅格的漫遊之眼
-- Source : https://www.wowhead.com/wotlk/tw/npc=14386
UPDATE `creature_template_locale` SET `Name` = '遊蕩的基爾羅格之眼' WHERE `locale` = 'zhTW' AND `entry` = 14386;
-- OLD name : 洛索斯·喚隙者
-- Source : https://www.wowhead.com/wotlk/tw/npc=14387
UPDATE `creature_template_locale` SET `Name` = '洛索斯·天痕' WHERE `locale` = 'zhTW' AND `entry` = 14387;
-- OLD name : 虛空行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=14389
UPDATE `creature_template_locale` SET `Name` = '虛無行者' WHERE `locale` = 'zhTW' AND `entry` = 14389;
-- OLD name : 惡運之槌劫奪者崗哨
-- Source : https://www.wowhead.com/wotlk/tw/npc=14391
UPDATE `creature_template_locale` SET `Name` = '惡運之錘掠奪者崗哨' WHERE `locale` = 'zhTW' AND `entry` = 14391;
-- OLD name : 『觀眾』格林比克斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=14395
UPDATE `creature_template_locale` SET `Name` = '『目擊者』格林比克斯' WHERE `locale` = 'zhTW' AND `entry` = 14395;
-- OLD name : 秘法洪流
-- Source : https://www.wowhead.com/wotlk/tw/npc=14399
UPDATE `creature_template_locale` SET `Name` = '祕法洪流' WHERE `locale` = 'zhTW' AND `entry` = 14399;
-- OLD name : 秘法回饋者
-- Source : https://www.wowhead.com/wotlk/tw/npc=14400
UPDATE `creature_template_locale` SET `Name` = '祕法回饋者' WHERE `locale` = 'zhTW' AND `entry` = 14400;
-- OLD name : 棕色草原土撥鼠
-- Source : https://www.wowhead.com/wotlk/tw/npc=14421
UPDATE `creature_template_locale` SET `Name` = '棕色土撥鼠' WHERE `locale` = 'zhTW' AND `entry` = 14421;
-- OLD name : 警報機器人
-- Source : https://www.wowhead.com/wotlk/tw/npc=14434
UPDATE `creature_template_locale` SET `Name` = '報警機器人' WHERE `locale` = 'zhTW' AND `entry` = 14434;
-- OLD subname : 逐風者
-- Source : https://www.wowhead.com/wotlk/tw/npc=14435
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14435;
-- OLD name : 維爾瑪克隊長
-- Source : https://www.wowhead.com/wotlk/tw/npc=14445
UPDATE `creature_template_locale` SET `Name` = '維爾瑪克總隊長' WHERE `locale` = 'zhTW' AND `entry` = 14445;
-- OLD name : 統御寶珠
-- Source : https://www.wowhead.com/wotlk/tw/npc=14453
UPDATE `creature_template_locale` SET `Name` = '統禦寶珠' WHERE `locale` = 'zhTW' AND `entry` = 14453;
-- OLD name : 烈風劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=14454
UPDATE `creature_template_locale` SET `Name` = '烈風搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 14454;
-- OLD name : 『全能』尼比
-- Source : https://www.wowhead.com/wotlk/tw/npc=14469
UPDATE `creature_template_locale` SET `Name` = '萬能的尼比' WHERE `locale` = 'zhTW' AND `entry` = 14469;
-- OLD name : 拉普雷斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=14473
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 14473;
-- OLD subname : 甜點商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=14480
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14480;
-- OLD subname : 甜點商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=14481
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14481;
-- OLD name : 受傷的農民
-- Source : https://www.wowhead.com/wotlk/tw/npc=14484
UPDATE `creature_template_locale` SET `Name` = '受傷的農夫' WHERE `locale` = 'zhTW' AND `entry` = 14484;
-- OLD name : 染疫的農民
-- Source : https://www.wowhead.com/wotlk/tw/npc=14485
UPDATE `creature_template_locale` SET `Name` = '感染瘟疫的農夫' WHERE `locale` = 'zhTW' AND `entry` = 14485;
-- OLD name : 天譴步行兵, subname : 科爾蘇加德的爪牙
-- Source : https://www.wowhead.com/wotlk/tw/npc=14486
UPDATE `creature_template_locale` SET `Name` = '天災步兵',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14486;
-- OLD name : 天譴弓箭手
-- Source : https://www.wowhead.com/wotlk/tw/npc=14489
UPDATE `creature_template_locale` SET `Name` = '天災弓箭手' WHERE `locale` = 'zhTW' AND `entry` = 14489;
-- OLD name : 術士坐騎儀式怪物第三類，煉獄火(DND)
-- Source : https://www.wowhead.com/wotlk/tw/npc=14501
UPDATE `creature_template_locale` SET `Name` = '術士坐騎儀式怪物第三類，地獄火(DND)' WHERE `locale` = 'zhTW' AND `entry` = 14501;
-- OLD name : 恐懼戰馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=14505
UPDATE `creature_template_locale` SET `Name` = '騎乘用馬（恐懼戰馬）' WHERE `locale` = 'zhTW' AND `entry` = 14505;
-- OLD name : 高階女祭司瑪俐
-- Source : https://www.wowhead.com/wotlk/tw/npc=14510
UPDATE `creature_template_locale` SET `Name` = '高階祭司瑪俐' WHERE `locale` = 'zhTW' AND `entry` = 14510;
-- OLD name : 友好的富蘭克林
-- Source : https://www.wowhead.com/wotlk/tw/npc=14529
UPDATE `creature_template_locale` SET `Name` = '友好的弗蘭克林' WHERE `locale` = 'zhTW' AND `entry` = 14529;
-- OLD name : 『殺戮者』索倫諾爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=14530
UPDATE `creature_template_locale` SET `Name` = '屠殺者索倫諾爾' WHERE `locale` = 'zhTW' AND `entry` = 14530;
-- OLD name : 『末日使者』阿托留斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=14535
UPDATE `creature_template_locale` SET `Name` = '摧毀者阿托留斯' WHERE `locale` = 'zhTW' AND `entry` = 14535;
-- OLD name : 和藹的尼爾森
-- Source : https://www.wowhead.com/wotlk/tw/npc=14536
UPDATE `creature_template_locale` SET `Name` = '和藹的奈爾森' WHERE `locale` = 'zhTW' AND `entry` = 14536;
-- OLD name : 『吞噬者』普萊瑟斯, subname : 西蒙妮的寵物
-- Source : https://www.wowhead.com/wotlk/tw/npc=14538
UPDATE `creature_template_locale` SET `Name` = '吞噬者普萊瑟斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14538;
-- OLD name : 迅捷橄欖綠迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=14543
UPDATE `creature_template_locale` SET `Name` = '迅捷綠色迅猛龍' WHERE `locale` = 'zhTW' AND `entry` = 14543;
-- OLD name : 迅捷橘色迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=14544
UPDATE `creature_template_locale` SET `Name` = '迅捷橙色迅猛龍' WHERE `locale` = 'zhTW' AND `entry` = 14544;
-- OLD name : 迅捷曦刃豹
-- Source : https://www.wowhead.com/wotlk/tw/npc=14557
UPDATE `creature_template_locale` SET `Name` = '迅捷晨刃豹' WHERE `locale` = 'zhTW' AND `entry` = 14557;
-- OLD name : 戰騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=14565
UPDATE `creature_template_locale` SET `Name` = '騎乘用馬（戰馬）' WHERE `locale` = 'zhTW' AND `entry` = 14565;
-- OLD name : 達克雷爾的墮落戰騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=14568
UPDATE `creature_template_locale` SET `Name` = '達克雷爾的墮落戰馬' WHERE `locale` = 'zhTW' AND `entry` = 14568;
-- OLD name : 骸骨魔像
-- Source : https://www.wowhead.com/wotlk/tw/npc=14605
UPDATE `creature_template_locale` SET `Name` = '白骨魔像' WHERE `locale` = 'zhTW' AND `entry` = 14605;
-- OLD name : 艾沃奈斯·煤煙
-- Source : https://www.wowhead.com/wotlk/tw/npc=14628
UPDATE `creature_template_locale` SET `Name` = '艾沃奈斯' WHERE `locale` = 'zhTW' AND `entry` = 14628;
-- OLD name : 橄欖綠鉗嘴龜
-- Source : https://www.wowhead.com/wotlk/tw/npc=14631
UPDATE `creature_template_locale` SET `Name` = '綠色鉗嘴龜' WHERE `locale` = 'zhTW' AND `entry` = 14631;
-- OLD name : [PH] 部落施法者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=14641
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 14641;
-- OLD name : [PH] 聯盟施法者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=14642
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 14642;
-- OLD name : [PH] 聯盟傳令官 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=14643
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 14643;
-- OLD name : [PH] 部落傳令官 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=14644
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 14644;
-- OLD name : 戰歌峽谷傳令官
-- Source : https://www.wowhead.com/wotlk/tw/npc=14645
UPDATE `creature_template_locale` SET `Name` = '戰歌峽谷使者' WHERE `locale` = 'zhTW' AND `entry` = 14645;
-- OLD name : 墮落的治療之泉圖騰 V
-- Source : https://www.wowhead.com/wotlk/tw/npc=14664
UPDATE `creature_template_locale` SET `Name` = '墮落治療之泉圖騰 V' WHERE `locale` = 'zhTW' AND `entry` = 14664;
-- OLD name : 墮落煉獄火
-- Source : https://www.wowhead.com/wotlk/tw/npc=14668
UPDATE `creature_template_locale` SET `Name` = '墮落地獄火' WHERE `locale` = 'zhTW' AND `entry` = 14668;
-- OLD name : 法瑟蕾絲女士
-- Source : https://www.wowhead.com/wotlk/tw/npc=14686
UPDATE `creature_template_locale` SET `Name` = '法瑟蕾絲夫人' WHERE `locale` = 'zhTW' AND `entry` = 14686;
-- OLD name : 薩杜瓦爾親王
-- Source : https://www.wowhead.com/wotlk/tw/npc=14688
UPDATE `creature_template_locale` SET `Name` = '薩杜瓦爾' WHERE `locale` = 'zhTW' AND `entry` = 14688;
-- OLD name : 死靈使
-- Source : https://www.wowhead.com/wotlk/tw/npc=14694
UPDATE `creature_template_locale` SET `Name` = '奈克羅希斯' WHERE `locale` = 'zhTW' AND `entry` = 14694;
-- OLD name : 黑木領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=14695
UPDATE `creature_template_locale` SET `Name` = '黑木王' WHERE `locale` = 'zhTW' AND `entry` = 14695;
-- OLD name : 靜默潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=14698
UPDATE `creature_template_locale` SET `Name` = '無聲潛獵者' WHERE `locale` = 'zhTW' AND `entry` = 14698;
-- OLD name : 末日怨靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=14701
UPDATE `creature_template_locale` SET `Name` = '末日怨鬼' WHERE `locale` = 'zhTW' AND `entry` = 14701;
-- OLD name : 死亡海妖
-- Source : https://www.wowhead.com/wotlk/tw/npc=14703
UPDATE `creature_template_locale` SET `Name` = '死亡女妖' WHERE `locale` = 'zhTW' AND `entry` = 14703;
-- OLD name : 奈幽織網者
-- Source : https://www.wowhead.com/wotlk/tw/npc=14705
UPDATE `creature_template_locale` SET `Name` = '尼拉布織網者' WHERE `locale` = 'zhTW' AND `entry` = 14705;
-- OLD name : 骸骨護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=14707
UPDATE `creature_template_locale` SET `Name` = '白骨看守者' WHERE `locale` = 'zhTW' AND `entry` = 14707;
-- OLD name : 凋零的戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=14708
UPDATE `creature_template_locale` SET `Name` = '腐爛的戰士' WHERE `locale` = 'zhTW' AND `entry` = 14708;
-- OLD name : 恐怖巫士
-- Source : https://www.wowhead.com/wotlk/tw/npc=14710
UPDATE `creature_template_locale` SET `Name` = '恐怖法術師' WHERE `locale` = 'zhTW' AND `entry` = 14710;
-- OLD name : 部落苦力
-- Source : https://www.wowhead.com/wotlk/tw/npc=14718
UPDATE `creature_template_locale` SET `Name` = '部落勞工' WHERE `locale` = 'zhTW' AND `entry` = 14718;
-- OLD name : [PH] 聯盟哨塔中尉 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=14719
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 14719;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=14731
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14731;
-- OLD name : 哨兵遠歌
-- Source : https://www.wowhead.com/wotlk/tw/npc=14733
UPDATE `creature_template_locale` SET `Name` = '哨兵艾蒂亞·輕歌' WHERE `locale` = 'zhTW' AND `entry` = 14733;
-- OLD subname : 鍛造供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=14737
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14737;
-- OLD name : 秘術使雅爾金
-- Source : https://www.wowhead.com/wotlk/tw/npc=14739
UPDATE `creature_template_locale` SET `Name` = '秘法師雅爾金' WHERE `locale` = 'zhTW' AND `entry` = 14739;
-- OLD name : 『垂釣者』卡圖姆, subname : 釣魚訓練師和供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=14740
UPDATE `creature_template_locale` SET `Name` = '釣魚者卡圖姆',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14740;
-- OLD name : 霜狼嗥叫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=14744
UPDATE `creature_template_locale` SET `Name` = '霜狼坐騎' WHERE `locale` = 'zhTW' AND `entry` = 14744;
-- OLD name : [PH] 部落哨塔中尉 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=14746
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 14746;
-- OLD name : 古拉巴什蝠騎兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=14750
UPDATE `creature_template_locale` SET `Name` = '古拉巴什乘蝠者' WHERE `locale` = 'zhTW' AND `entry` = 14750;
-- OLD subname : 銀翼物資官
-- Source : https://www.wowhead.com/wotlk/tw/npc=14753
UPDATE `creature_template_locale` SET `Title` = '銀翼軍需官' WHERE `locale` = 'zhTW' AND `entry` = 14753;
-- OLD subname : 戰歌物資官
-- Source : https://www.wowhead.com/wotlk/tw/npc=14754
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14754;
-- OLD name : 東部霜狼元帥
-- Source : https://www.wowhead.com/wotlk/tw/npc=14768
UPDATE `creature_template_locale` SET `Name` = '霜狼東部元帥' WHERE `locale` = 'zhTW' AND `entry` = 14768;
-- OLD name : 西部霜狼元帥
-- Source : https://www.wowhead.com/wotlk/tw/npc=14769
UPDATE `creature_template_locale` SET `Name` = '霜狼西部元帥' WHERE `locale` = 'zhTW' AND `entry` = 14769;
-- OLD subname : 紀念品與玩具獎品
-- Source : https://www.wowhead.com/wotlk/tw/npc=14828
UPDATE `creature_template_locale` SET `Title` = '暗月馬戲團獎券兌換' WHERE `locale` = 'zhTW' AND `entry` = 14828;
-- OLD subname : 飲料商
-- Source : https://www.wowhead.com/wotlk/tw/npc=14844
UPDATE `creature_template_locale` SET `Title` = '暗月馬戲團飲料商' WHERE `locale` = 'zhTW' AND `entry` = 14844;
-- OLD subname : 食品商
-- Source : https://www.wowhead.com/wotlk/tw/npc=14845
UPDATE `creature_template_locale` SET `Title` = '暗月馬戲團食品商' WHERE `locale` = 'zhTW' AND `entry` = 14845;
-- OLD subname : 寵物與坐騎獎品
-- Source : https://www.wowhead.com/wotlk/tw/npc=14846
UPDATE `creature_template_locale` SET `Title` = '暗月馬戲團特殊商品' WHERE `locale` = 'zhTW' AND `entry` = 14846;
-- OLD subname : 暗月卡片
-- Source : https://www.wowhead.com/wotlk/tw/npc=14847
UPDATE `creature_template_locale` SET `Title` = '暗月馬戲團卡片和特殊商品銷售員' WHERE `locale` = 'zhTW' AND `entry` = 14847;
-- OLD name : 暗月工作人員
-- Source : https://www.wowhead.com/wotlk/tw/npc=14849
UPDATE `creature_template_locale` SET `Name` = '暗月馬戲團清潔工' WHERE `locale` = 'zhTW' AND `entry` = 14849;
-- OLD name : 考爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=14854
UPDATE `creature_template_locale` SET `Name` = '卡爾' WHERE `locale` = 'zhTW' AND `entry` = 14854;
-- OLD name : 守衛塔魯克
-- Source : https://www.wowhead.com/wotlk/tw/npc=14859
UPDATE `creature_template_locale` SET `Name` = '衛兵塔魯克' WHERE `locale` = 'zhTW' AND `entry` = 14859;
-- OLD name : 呱呱
-- Source : https://www.wowhead.com/wotlk/tw/npc=14867
UPDATE `creature_template_locale` SET `Name` = '啾啾' WHERE `locale` = 'zhTW' AND `entry` = 14867;
-- OLD name : 高階牧師溫諾希斯幻象
-- Source : https://www.wowhead.com/wotlk/tw/npc=14877
UPDATE `creature_template_locale` SET `Name` = '高階祭司溫諾希斯幻象' WHERE `locale` = 'zhTW' AND `entry` = 14877;
-- OLD name : 小嘓嘓
-- Source : https://www.wowhead.com/wotlk/tw/npc=14878
UPDATE `creature_template_locale` SET `Name` = '加布林' WHERE `locale` = 'zhTW' AND `entry` = 14878;
-- OLD name : 寄生蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=14884
UPDATE `creature_template_locale` SET `Name` = '寄居蛇' WHERE `locale` = 'zhTW' AND `entry` = 14884;
-- OLD name : 強納森·樂卡夫特, subname : 非凡的設計師
-- Source : https://www.wowhead.com/wotlk/tw/npc=14885
UPDATE `creature_template_locale` SET `Name` = NULL,`Title` = 'gner Extraordinaire' WHERE `locale` = 'zhTW' AND `entry` = 14885;
-- OLD name : 守衛庫拉爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=14893
UPDATE `creature_template_locale` SET `Name` = '衛兵庫拉爾' WHERE `locale` = 'zhTW' AND `entry` = 14893;
-- OLD name : 祖達薩的梅維基
-- Source : https://www.wowhead.com/wotlk/tw/npc=14904
UPDATE `creature_template_locale` SET `Name` = '祖達薩的梅維克' WHERE `locale` = 'zhTW' AND `entry` = 14904;
-- OLD subname : 贊達拉供應商和修理工
-- Source : https://www.wowhead.com/wotlk/tw/npc=14921
UPDATE `creature_template_locale` SET `Title` = '贊達拉供應商和修理者' WHERE `locale` = 'zhTW' AND `entry` = 14921;
-- OLD name : 穆維里克的戰鬥坐騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=14945
UPDATE `creature_template_locale` SET `Name` = '穆維里克的坐騎' WHERE `locale` = 'zhTW' AND `entry` = 14945;
-- OLD name : 加普·響囊, subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=14963
UPDATE `creature_template_locale` SET `Name` = '加普·吉波克',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14963;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=14964
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 14964;
-- OLD name : 高階祭司塞卡爾變形幻象
-- Source : https://www.wowhead.com/wotlk/tw/npc=14966
UPDATE `creature_template_locale` SET `Name` = '古拉巴什食腐者變形幻象' WHERE `locale` = 'zhTW' AND `entry` = 14966;
-- OLD name : 高階女祭司瑪俐變形幻象
-- Source : https://www.wowhead.com/wotlk/tw/npc=14967
UPDATE `creature_template_locale` SET `Name` = '哈卡萊安魂者變形幻象' WHERE `locale` = 'zhTW' AND `entry` = 14967;
-- OLD name : 高階祭司阿洛克變形幻象
-- Source : https://www.wowhead.com/wotlk/tw/npc=14968
UPDATE `creature_template_locale` SET `Name` = '哈卡萊先知變形幻象' WHERE `locale` = 'zhTW' AND `entry` = 14968;
-- OLD name : PvP ALT-N 榮譽記分員
-- Source : https://www.wowhead.com/wotlk/tw/npc=15005
UPDATE `creature_template_locale` SET `Name` = 'PvP ALT-S 榮譽記分員' WHERE `locale` = 'zhTW' AND `entry` = 15005;
-- OLD name : 『無眠者』贊札
-- Source : https://www.wowhead.com/wotlk/tw/npc=15042
UPDATE `creature_template_locale` SET `Name` = '無眠者贊札' WHERE `locale` = 'zhTW' AND `entry` = 15042;
-- OLD name : 金度之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=15061
UPDATE `creature_template_locale` SET `Name` = '金度之魂' WHERE `locale` = 'zhTW' AND `entry` = 15061;
-- OLD name : 祖利安潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15067
UPDATE `creature_template_locale` SET `Name` = '祖利安捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 15067;
-- OLD name : 格里雷克 [UNUSED]
-- Source : https://www.wowhead.com/wotlk/tw/npc=15081
UPDATE `creature_template_locale` SET `Name` = '格里雷克' WHERE `locale` = 'zhTW' AND `entry` = 15081;
-- OLD name : 迅捷拉札希迅猛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=15090
UPDATE `creature_template_locale` SET `Name` = '拉札希迅猛龍' WHERE `locale` = 'zhTW' AND `entry` = 15090;
-- OLD name : 禁錮之魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=15117
UPDATE `creature_template_locale` SET `Name` = '被禁錮的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 15117;
-- OLD name : 骷髏法師領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=15121
UPDATE `creature_template_locale` SET `Name` = '骷髏大法師' WHERE `locale` = 'zhTW' AND `entry` = 15121;
-- OLD name : 克里斯·吉爾哈特, subname : 非凡的設計師
-- Source : https://www.wowhead.com/wotlk/tw/npc=15123
UPDATE `creature_template_locale` SET `Name` = NULL,`Title` = 'gner Extraordinaire' WHERE `locale` = 'zhTW' AND `entry` = 15123;
-- OLD subname : 污染者物資官
-- Source : https://www.wowhead.com/wotlk/tw/npc=15126
UPDATE `creature_template_locale` SET `Title` = '污染者軍需官' WHERE `locale` = 'zhTW' AND `entry` = 15126;
-- OLD subname : 阿拉索聯軍物資官
-- Source : https://www.wowhead.com/wotlk/tw/npc=15127
UPDATE `creature_template_locale` SET `Title` = '阿拉索聯軍軍需官' WHERE `locale` = 'zhTW' AND `entry` = 15127;
-- OLD name : 炫彩座龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=15135
UPDATE `creature_template_locale` SET `Name` = '多彩座龍' WHERE `locale` = 'zhTW' AND `entry` = 15135;
-- OLD name : 瘋狂虛無行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15146
UPDATE `creature_template_locale` SET `Name` = '瘋狂虛空行者' WHERE `locale` = 'zhTW' AND `entry` = 15146;
-- OLD name : 血色審判官
-- Source : https://www.wowhead.com/wotlk/tw/npc=15162
UPDATE `creature_template_locale` SET `Name` = '血色審查官' WHERE `locale` = 'zhTW' AND `entry` = 15162;
-- OLD name : 夢魘幻影
-- Source : https://www.wowhead.com/wotlk/tw/npc=15163
UPDATE `creature_template_locale` SET `Name` = '夢魔幻象' WHERE `locale` = 'zhTW' AND `entry` = 15163;
-- OLD name : 路易士·貝瑞加 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=15166
UPDATE `creature_template_locale` SET `Name` = '威奈斯‧安東尼斯' WHERE `locale` = 'zhTW' AND `entry` = 15166;
-- OLD name : [PH] Luis Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15167
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15167;
-- OLD subname : 守衛隊長
-- Source : https://www.wowhead.com/wotlk/tw/npc=15182
UPDATE `creature_template_locale` SET `Title` = '衛兵隊長' WHERE `locale` = 'zhTW' AND `entry` = 15182;
-- OLD name : 塞納里奧城堡步兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=15184
UPDATE `creature_template_locale` SET `Name` = '諾茲多姆的子嗣' WHERE `locale` = 'zhTW' AND `entry` = 15184;
-- OLD name : 希瓦娜斯·風行者女士
-- Source : https://www.wowhead.com/wotlk/tw/npc=15193
UPDATE `creature_template_locale` SET `Name` = '女妖之王' WHERE `locale` = 'zhTW' AND `entry` = 15193;
-- OLD name : 稻草人守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15195
UPDATE `creature_template_locale` SET `Name` = '稻草人守衛者' WHERE `locale` = 'zhTW' AND `entry` = 15195;
-- OLD name : 暮光守衛者瑪恩納
-- Source : https://www.wowhead.com/wotlk/tw/npc=15200
UPDATE `creature_template_locale` SET `Name` = '暮光守護者瑪恩納' WHERE `locale` = 'zhTW' AND `entry` = 15200;
-- OLD name : 暮光烈焰劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15201
UPDATE `creature_template_locale` SET `Name` = '暮光烈焰搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 15201;
-- OLD subname : 高階深淵議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=15203
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15203;
-- OLD subname : 高階深淵議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=15204
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15204;
-- OLD subname : 高階深淵議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=15205
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15205;
-- OLD subname : 深淵議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=15206
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15206;
-- OLD subname : 深淵議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=15207
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15207;
-- OLD name : 裂石公爵, subname : 深淵議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=15208
UPDATE `creature_template_locale` SET `Name` = '碎石公爵',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15208;
-- OLD subname : 深淵議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=15209
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15209;
-- OLD subname : 深淵議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=15210
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15210;
-- OLD name : 蒼藍聖殿騎士
-- Source : https://www.wowhead.com/wotlk/tw/npc=15211
UPDATE `creature_template_locale` SET `Name` = '碧藍聖殿騎士' WHERE `locale` = 'zhTW' AND `entry` = 15211;
-- OLD name : 娜塔莉亞·瑪爾利斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=15215
UPDATE `creature_template_locale` SET `Name` = '納塔莉亞·瑪爾利斯' WHERE `locale` = 'zhTW' AND `entry` = 15215;
-- OLD name : 男性鬼魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=15216
UPDATE `creature_template_locale` SET `Name` = '男性幽靈' WHERE `locale` = 'zhTW' AND `entry` = 15216;
-- OLD name : 女性鬼魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=15217
UPDATE `creature_template_locale` SET `Name` = '女性幽靈' WHERE `locale` = 'zhTW' AND `entry` = 15217;
-- OLD subname : 深淵議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=15220
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15220;
-- OLD name : 夢境迷霧
-- Source : https://www.wowhead.com/wotlk/tw/npc=15224
UPDATE `creature_template_locale` SET `Name` = '夢霧' WHERE `locale` = 'zhTW' AND `entry` = 15224;
-- OLD name : [UNUSED]維克尼斯建築者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15226
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15226;
-- OLD name : [UNUSED] Vekniss Hiveshaper (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15227
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15227;
-- OLD name : [UNUSED] Vekniss Wellborer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15228
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15228;
-- OLD name : 維克尼斯戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=15230
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 15230;
-- OLD name : [UNSUED] Vekniss Patroller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15231
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15231;
-- OLD name : [UNUSED] Vekniss Eradicator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15232
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15232;
-- OLD name : 維克尼斯守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15233
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 15233;
-- OLD name : [UNUSED] Vekniss Swarmer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15234
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15234;
-- OLD name : [UNUSED]維克尼斯狂蜂 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15237
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15237;
-- OLD name : [UNUSED]維克尼斯劫奪者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15238
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15238;
-- OLD name : [UNUSED]維克尼斯潛伏者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15239
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15239;
-- OLD name : 蝠騎兵守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=15242
UPDATE `creature_template_locale` SET `Name` = '乘蝠者守衛' WHERE `locale` = 'zhTW' AND `entry` = 15242;
-- OLD name : [UNUSED]維克尼斯巨蜂 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15243
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15243;
-- OLD name : [UNUSED]維克尼斯劫掠者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15244
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15244;
-- OLD name : [UNUSED] Vekniss Waspguard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15245
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15245;
-- OLD name : [UNUSED]其拉屈魂者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15248
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15248;
-- OLD name : 其拉鞭擊者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15249
UPDATE `creature_template_locale` SET `Name` = '其拉怒刺蜂' WHERE `locale` = 'zhTW' AND `entry` = 15249;
-- OLD name : [UNUSED] 其拉屠殺者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15251
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15251;
-- OLD name : [UNUSED] Qiraji Champion (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15253
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15253;
-- OLD name : [UNUSED] 其拉隊長 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15254
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15254;
-- OLD name : [UNUSED] 其拉官員 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15255
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15255;
-- OLD name : [UNUSED] 其拉指揮官 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15256
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15256;
-- OLD name : [UNUSED] Qiraji Honor Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15257
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15257;
-- OLD name : [UNUSED] 其拉執政者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15258
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15258;
-- OLD name : [UNUSED] 其拉統治者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15259
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15259;
-- OLD name : 阿努比薩斯防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15277
UPDATE `creature_template_locale` SET `Name` = '阿努比薩斯防禦者' WHERE `locale` = 'zhTW' AND `entry` = 15277;
-- OLD subname : 雷戈蟲巢主宰
-- Source : https://www.wowhead.com/wotlk/tw/npc=15286
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15286;
-- OLD subname : 亞什蟲巢主宰
-- Source : https://www.wowhead.com/wotlk/tw/npc=15288
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15288;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=15289
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 15289;
-- OLD subname : 佐拉蟲巢主宰
-- Source : https://www.wowhead.com/wotlk/tw/npc=15290
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15290;
-- OLD name : 斯古恩領主, subname : 高階深淵議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=15305
UPDATE `creature_template_locale` SET `Name` = '斯古恩男爵',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15305;
-- OLD name : 阿努比薩斯護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=15311
UPDATE `creature_template_locale` SET `Name` = '阿努比薩斯守衛' WHERE `locale` = 'zhTW' AND `entry` = 15311;
-- OLD name : 札拉士兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=15320
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 15320;
-- OLD name : [UNUSED] Hive'Zara Ambusher (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15322
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15322;
-- OLD name : 札拉沙巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15323
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 15323;
-- OLD name : [UNUSED] Hive'Zara Swarmer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15326
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15326;
-- OLD name : 暗月蒸汽坦克
-- Source : https://www.wowhead.com/wotlk/tw/npc=15328
UPDATE `creature_template_locale` SET `Name` = '蒸氣坦克' WHERE `locale` = 'zhTW' AND `entry` = 15328;
-- OLD name : [UNUSED] Hive'Zara Scout (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15329
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15329;
-- OLD name : [UNUSED] Sand Borer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15330
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15330;
-- OLD name : [UNUSED] Dune Tunneler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15331
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15331;
-- OLD name : [UNUSED] Crystal Feeder (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15332
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15332;
-- OLD name : [UNUSED] Sand Mold (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15337
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15337;
-- OLD name : [UNUSED] Sphinx (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15342
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15342;
-- OLD name : [UNUSED] Daughter of Hecate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15345
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15345;
-- OLD name : [UNUSED] Qiraji Wasprider (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15346
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15346;
-- OLD name : [UNUSED] Qiraji Wasplord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15347
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15347;
-- OLD name : 玩具小型飛船, subname : NONE
-- Source : https://www.wowhead.com/wotlk/tw/npc=15349
UPDATE `creature_template_locale` SET `Name` = 'RC Blimp',`Title` = 'PH' WHERE `locale` = 'zhTW' AND `entry` = 15349;
-- OLD name : 大型土元素
-- Source : https://www.wowhead.com/wotlk/tw/npc=15352
UPDATE `creature_template_locale` SET `Name` = '強效土元素' WHERE `locale` = 'zhTW' AND `entry` = 15352;
-- OLD subname : 萬鬼節招待員
-- Source : https://www.wowhead.com/wotlk/tw/npc=15353
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15353;
-- OLD subname : 萬鬼節招待員
-- Source : https://www.wowhead.com/wotlk/tw/npc=15354
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15354;
-- OLD name : 阿努比薩斯守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15355
UPDATE `creature_template_locale` SET `Name` = '阿努比薩斯守衛者' WHERE `locale` = 'zhTW' AND `entry` = 15355;
-- OLD name : 樂奇
-- Source : https://www.wowhead.com/wotlk/tw/npc=15358
UPDATE `creature_template_locale` SET `Name` = '白色小魚人' WHERE `locale` = 'zhTW' AND `entry` = 15358;
-- OLD name : 粉紅小魚人
-- Source : https://www.wowhead.com/wotlk/tw/npc=15359
UPDATE `creature_template_locale` SET `Name` = '粉色小魚人' WHERE `locale` = 'zhTW' AND `entry` = 15359;
-- OLD name : 莫基
-- Source : https://www.wowhead.com/wotlk/tw/npc=15361
UPDATE `creature_template_locale` SET `Name` = '莫奇' WHERE `locale` = 'zhTW' AND `entry` = 15361;
-- OLD name : 玩具蒸汽坦克, subname : NONE
-- Source : https://www.wowhead.com/wotlk/tw/npc=15364
UPDATE `creature_template_locale` SET `Name` = 'RC Mortar Tank',`Title` = 'PH' WHERE `locale` = 'zhTW' AND `entry` = 15364;
-- OLD name : 『狩獵者』阿亞米斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=15369
UPDATE `creature_template_locale` SET `Name` = '狩獵者阿亞米斯' WHERE `locale` = 'zhTW' AND `entry` = 15369;
-- OLD name : 『暴食者』布魯
-- Source : https://www.wowhead.com/wotlk/tw/npc=15370
UPDATE `creature_template_locale` SET `Name` = '吞咽者布魯' WHERE `locale` = 'zhTW' AND `entry` = 15370;
-- OLD name : 萬鬼節海賊船長
-- Source : https://www.wowhead.com/wotlk/tw/npc=15373
UPDATE `creature_template_locale` SET `Name` = '萬鬼節海盜船長' WHERE `locale` = 'zhTW' AND `entry` = 15373;
-- OLD name : 萬鬼節亡靈海賊
-- Source : https://www.wowhead.com/wotlk/tw/npc=15374
UPDATE `creature_template_locale` SET `Name` = '萬鬼節亡靈海盜' WHERE `locale` = 'zhTW' AND `entry` = 15374;
-- OLD name : 萬鬼節女海賊
-- Source : https://www.wowhead.com/wotlk/tw/npc=15375
UPDATE `creature_template_locale` SET `Name` = '萬鬼節女海盜' WHERE `locale` = 'zhTW' AND `entry` = 15375;
-- OLD name : 『夢境之龍』麥琳瑟拉
-- Source : https://www.wowhead.com/wotlk/tw/npc=15378
UPDATE `creature_template_locale` SET `Name` = '夢境之龍麥琳瑟拉' WHERE `locale` = 'zhTW' AND `entry` = 15378;
-- OLD name : 凱雷斯塔茲
-- Source : https://www.wowhead.com/wotlk/tw/npc=15379
UPDATE `creature_template_locale` SET `Name` = '凱雷斯特拉茲' WHERE `locale` = 'zhTW' AND `entry` = 15379;
-- OLD name : 『上古之龍』安納克羅斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=15381
UPDATE `creature_template_locale` SET `Name` = '上古之龍安納克羅斯' WHERE `locale` = 'zhTW' AND `entry` = 15381;
-- OLD subname : 銅錠收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15383
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15383;
-- OLD name : [UNUSED] Ruins Qiraji Gladiator Named 7 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15393
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15393;
-- OLD name : 曦奔中尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=15399
UPDATE `creature_template_locale` SET `Name` = '晨路中尉' WHERE `locale` = 'zhTW' AND `entry` = 15399;
-- OLD name : 地脈看守者維蘭妮雅
-- Source : https://www.wowhead.com/wotlk/tw/npc=15401
UPDATE `creature_template_locale` SET `Name` = '牧地看守者維蘭妮雅' WHERE `locale` = 'zhTW' AND `entry` = 15401;
-- OLD name : 地脈看守者凱丹尼斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=15405
UPDATE `creature_template_locale` SET `Name` = '牧地看守者凱丹尼斯' WHERE `locale` = 'zhTW' AND `entry` = 15405;
-- OLD name : 凱雷斯塔茲龍類形態
-- Source : https://www.wowhead.com/wotlk/tw/npc=15412
UPDATE `creature_template_locale` SET `Name` = '凱雷斯特拉茲龍類形態' WHERE `locale` = 'zhTW' AND `entry` = 15412;
-- OLD name : 沙塵龍捲風
-- Source : https://www.wowhead.com/wotlk/tw/npc=15428
UPDATE `creature_template_locale` SET `Name` = '沙塵旋渦' WHERE `locale` = 'zhTW' AND `entry` = 15428;
-- OLD name : 噁心的小軟泥怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=15429
UPDATE `creature_template_locale` SET `Name` = '噁心的軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 15429;
-- OLD subname : 鐵錠收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15431
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15431;
-- OLD name : 塔文布萊德夫人, subname : 瑟銀錠收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15432
UPDATE `creature_template_locale` SET `Name` = '達米',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15432;
-- OLD name : 士兵德拉克里格, subname : 荊棘藻收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15434
UPDATE `creature_template_locale` SET `Name` = '列兵德拉里格',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15434;
-- OLD name : 鐵爐堡兵團迫擊砲手
-- Source : https://www.wowhead.com/wotlk/tw/npc=15435
UPDATE `creature_template_locale` SET `Name` = '鐵爐堡軍團迫擊炮手' WHERE `locale` = 'zhTW' AND `entry` = 15435;
-- OLD name : 迫擊砲中士斯托特·頑錘
-- Source : https://www.wowhead.com/wotlk/tw/npc=15436
UPDATE `creature_template_locale` SET `Name` = '迫擊炮中士斯托特·石錘' WHERE `locale` = 'zhTW' AND `entry` = 15436;
-- OLD subname : 紫蓮花收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15437
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15437;
-- OLD name : 大型火元素
-- Source : https://www.wowhead.com/wotlk/tw/npc=15438
UPDATE `creature_template_locale` SET `Name` = '強效火焰元素' WHERE `locale` = 'zhTW' AND `entry` = 15438;
-- OLD name : 火元素圖騰
-- Source : https://www.wowhead.com/wotlk/tw/npc=15439
UPDATE `creature_template_locale` SET `Name` = '火焰元素圖騰' WHERE `locale` = 'zhTW' AND `entry` = 15439;
-- OLD subname : 鐵爐堡兵團上尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=15440
UPDATE `creature_template_locale` SET `Title` = '鐵爐堡軍團上尉' WHERE `locale` = 'zhTW' AND `entry` = 15440;
-- OLD name : 鐵爐堡兵團步槍兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=15441
UPDATE `creature_template_locale` SET `Name` = '鐵爐堡軍團火槍手' WHERE `locale` = 'zhTW' AND `entry` = 15441;
-- OLD name : 鐵爐堡兵團步卒
-- Source : https://www.wowhead.com/wotlk/tw/npc=15442
UPDATE `creature_template_locale` SET `Name` = '鐵爐堡軍團步卒' WHERE `locale` = 'zhTW' AND `entry` = 15442;
-- OLD name : 珍妮拉·頑錘
-- Source : https://www.wowhead.com/wotlk/tw/npc=15443
UPDATE `creature_template_locale` SET `Name` = '珍妮拉·鋼錘' WHERE `locale` = 'zhTW' AND `entry` = 15443;
-- OLD subname : 阿薩斯之淚收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15445
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15445;
-- OLD subname : 輕皮收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15446
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15446;
-- OLD name : 士兵波特, subname : 中皮收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15448
UPDATE `creature_template_locale` SET `Name` = '列兵波特',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15448;
-- OLD subname : 厚皮收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15450
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15450;
-- OLD subname : 亞麻繃帶收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15451
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15451;
-- OLD subname : 絲質繃帶收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15452
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15452;
-- OLD name : 守衛者莫沙·月影, subname : 符文布繃帶收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15453
UPDATE `creature_template_locale` SET `Name` = '守護者莫沙·月影',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15453;
-- OLD subname : 彩鰭魚收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15455
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15455;
-- OLD subname : 烤迅猛龍肉收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15456
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15456;
-- OLD subname : 斑點黃尾魚收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15457
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15457;
-- OLD subname : 聯盟大使
-- Source : https://www.wowhead.com/wotlk/tw/npc=15458
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15458;
-- OLD subname : 銅錠收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15459
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15459;
-- OLD name : 蠻兵瑪烏格, subname : 錫錠收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15460
UPDATE `creature_template_locale` SET `Name` = '步兵瑪烏格',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15460;
-- OLD subname : 秘銀錠收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15469
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15469;
-- OLD name : [UNUSED]深淵軟泥怪 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15472
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15472;
-- OLD name : 甲蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=15475
UPDATE `creature_template_locale` SET `Name` = '甲殼蟲' WHERE `locale` = 'zhTW' AND `entry` = 15475;
-- OLD name : 草藥師波德·飛羽, subname : 寧神花收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15477
UPDATE `creature_template_locale` SET `Name` = '草藥學家波德·飛羽',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15477;
-- OLD name : 火焰新星圖騰
-- Source : https://www.wowhead.com/wotlk/tw/npc=15483
UPDATE `creature_template_locale` SET `Name` = '火焰新星圖騰 VII' WHERE `locale` = 'zhTW' AND `entry` = 15483;
-- OLD name : 『夢境暴君』伊蘭尼庫斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=15491
UPDATE `creature_template_locale` SET `Name` = '伊蘭尼庫斯，夢境之暴君' WHERE `locale` = 'zhTW' AND `entry` = 15491;
-- OLD name : 永夜港防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15495
UPDATE `creature_template_locale` SET `Name` = '永夜港守衛者' WHERE `locale` = 'zhTW' AND `entry` = 15495;
-- OLD subname : 瑪里苟斯的後裔
-- Source : https://www.wowhead.com/wotlk/tw/npc=15502
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15502;
-- OLD name : 坎多斯塔茲, subname : 雅立史卓莎的後裔
-- Source : https://www.wowhead.com/wotlk/tw/npc=15503
UPDATE `creature_template_locale` SET `Name` = '坎多斯特拉茲',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15503;
-- OLD subname : 伊瑟拉的後裔
-- Source : https://www.wowhead.com/wotlk/tw/npc=15504
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15504;
-- OLD name : 變形後的『暴食者』布魯
-- Source : https://www.wowhead.com/wotlk/tw/npc=15507
UPDATE `creature_template_locale` SET `Name` = '變形後的吞咽者布魯' WHERE `locale` = 'zhTW' AND `entry` = 15507;
-- OLD subname : 火焰花收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15508
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15508;
-- OLD subname : 紫蓮花收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15512
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15512;
-- OLD subname : 重皮收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15515
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15515;
-- OLD name : 戰地衛士沙爾圖拉
-- Source : https://www.wowhead.com/wotlk/tw/npc=15516
UPDATE `creature_template_locale` SET `Name` = '沙爾圖拉' WHERE `locale` = 'zhTW' AND `entry` = 15516;
-- OLD subname : 厚皮收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15522
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15522;
-- OLD subname : 硬甲皮收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15525
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15525;
-- OLD name : 醫者朗蘭納, subname : 絨線繃帶收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15528
UPDATE `creature_template_locale` SET `Name` = '醫師朗蘭納',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15528;
-- OLD name : 卡隆女士, subname : 魔紋繃帶收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15529
UPDATE `creature_template_locale` SET `Name` = '卡隆',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15529;
-- OLD name : 暮光大師薩爾沃斯, subname : 暮光之錘
-- Source : https://www.wowhead.com/wotlk/tw/npc=15530
UPDATE `creature_template_locale` SET `Name` = '暮光主宰薩爾沃斯',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15530;
-- OLD name : 石衛士陶蹄, subname : 符文布繃帶收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15532
UPDATE `creature_template_locale` SET `Name` = '尼根·陶蹄',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15532;
-- OLD subname : 瘦狼排收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15533
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15533;
-- OLD subname : 斑點黃尾魚收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15534
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15534;
-- OLD subname : 烤鮭魚收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15535
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15535;
-- OLD subname : 部落大使
-- Source : https://www.wowhead.com/wotlk/tw/npc=15539
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15539;
-- OLD name : 塞納里奧先遣騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=15545
UPDATE `creature_template_locale` SET `Name` = '塞納里奧前鋒' WHERE `locale` = 'zhTW' AND `entry` = 15545;
-- OLD name : 鬼靈戰騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=15547
UPDATE `creature_template_locale` SET `Name` = '鬼靈戰馬' WHERE `locale` = 'zhTW' AND `entry` = 15547;
-- OLD name : 深晨長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15549
UPDATE `creature_template_locale` SET `Name` = '晨深長者' WHERE `locale` = 'zhTW' AND `entry` = 15549;
-- OLD name : 鬼靈獸欄僕人
-- Source : https://www.wowhead.com/wotlk/tw/npc=15551
UPDATE `creature_template_locale` SET `Name` = '鬼靈馬廄僕人' WHERE `locale` = 'zhTW' AND `entry` = 15551;
-- OLD name : 劈石長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15556
UPDATE `creature_template_locale` SET `Name` = '碎石長者' WHERE `locale` = 'zhTW' AND `entry` = 15556;
-- OLD name : 怒嘯長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15563
UPDATE `creature_template_locale` SET `Name` = '怒吼長者' WHERE `locale` = 'zhTW' AND `entry` = 15563;
-- OLD name : 金善長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15569
UPDATE `creature_template_locale` SET `Name` = '金井長者' WHERE `locale` = 'zhTW' AND `entry` = 15569;
-- OLD name : 狂暴圖騰長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15573
UPDATE `creature_template_locale` SET `Name` = '狂怒圖騰長者' WHERE `locale` = 'zhTW' AND `entry` = 15573;
-- OLD name : 以斯拉·麥蹄長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15580
UPDATE `creature_template_locale` SET `Name` = '傲角長者' WHERE `locale` = 'zhTW' AND `entry` = 15580;
-- OLD name : 夢境先知長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15586
UPDATE `creature_template_locale` SET `Name` = '夢眼長者' WHERE `locale` = 'zhTW' AND `entry` = 15586;
-- OLD name : 風行長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15592
UPDATE `creature_template_locale` SET `Name` = '風奔長者' WHERE `locale` = 'zhTW' AND `entry` = 15592;
-- OLD name : 刃葉長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15595
UPDATE `creature_template_locale` SET `Name` = '劍葉長者' WHERE `locale` = 'zhTW' AND `entry` = 15595;
-- OLD name : 刃歌長者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15599
UPDATE `creature_template_locale` SET `Name` = '劍歌長者' WHERE `locale` = 'zhTW' AND `entry` = 15599;
-- OLD name : 維克尼斯鑽孔蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=15622
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 15622;
-- OLD name : 夢魘魅靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=15629
UPDATE `creature_template_locale` SET `Name` = '夢魘幻象' WHERE `locale` = 'zhTW' AND `entry` = 15629;
-- OLD subname : 伊露恩的高階女祭司
-- Source : https://www.wowhead.com/wotlk/tw/npc=15633
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15633;
-- OLD name : [UNUSED]法力吸血蟲 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15646
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15646;
-- OLD name : 法力巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15647
UPDATE `creature_template_locale` SET `Name` = '法力行者' WHERE `locale` = 'zhTW' AND `entry` = 15647;
-- OLD name : 鯊魚寶寶
-- Source : https://www.wowhead.com/wotlk/tw/npc=15661
UPDATE `creature_template_locale` SET `Name` = '小鯊魚' WHERE `locale` = 'zhTW' AND `entry` = 15661;
-- OLD name : 騎乘用麋鹿
-- Source : https://www.wowhead.com/wotlk/tw/npc=15665
UPDATE `creature_template_locale` SET `Name` = '麋鹿' WHERE `locale` = 'zhTW' AND `entry` = 15665;
-- OLD name : 藍色其拉作戰坦克
-- Source : https://www.wowhead.com/wotlk/tw/npc=15666
UPDATE `creature_template_locale` SET `Name` = '黑色其拉作戰坦克' WHERE `locale` = 'zhTW' AND `entry` = 15666;
-- OLD name : [Unused] Auctioneer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=15672
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15672;
-- OLD name : 拍賣師格拉夫斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=15677
UPDATE `creature_template_locale` SET `Name` = '拍賣師格拉維斯' WHERE `locale` = 'zhTW' AND `entry` = 15677;
-- OLD name : 冬天爺爺的助手
-- Source : https://www.wowhead.com/wotlk/tw/npc=15698
UPDATE `creature_template_locale` SET `Name` = '冬天爸爸的助手' WHERE `locale` = 'zhTW' AND `entry` = 15698;
-- OLD subname : 戰備指揮官
-- Source : https://www.wowhead.com/wotlk/tw/npc=15700
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15700;
-- OLD name : 戰場元帥斯諾·落雪, subname : 戰備指揮官
-- Source : https://www.wowhead.com/wotlk/tw/npc=15701
UPDATE `creature_template_locale` SET `Name` = '大元帥斯諾·落雪',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15701;
-- OLD subname : 戰備招募員
-- Source : https://www.wowhead.com/wotlk/tw/npc=15702
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15702;
-- OLD subname : 戰備招募員
-- Source : https://www.wowhead.com/wotlk/tw/npc=15703
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15703;
-- OLD subname : 戰備招募員
-- Source : https://www.wowhead.com/wotlk/tw/npc=15704
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15704;
-- OLD name : 冬天爺爺的小助手
-- Source : https://www.wowhead.com/wotlk/tw/npc=15705
UPDATE `creature_template_locale` SET `Name` = '冬天爸爸的小助手' WHERE `locale` = 'zhTW' AND `entry` = 15705;
-- OLD subname : 戰備招募員
-- Source : https://www.wowhead.com/wotlk/tw/npc=15707
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15707;
-- OLD subname : 戰備招募員
-- Source : https://www.wowhead.com/wotlk/tw/npc=15708
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15708;
-- OLD subname : 戰備招募員
-- Source : https://www.wowhead.com/wotlk/tw/npc=15709
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15709;
-- OLD name : Blue Qiraji Battle Tank
-- Source : https://www.wowhead.com/wotlk/tw/npc=15713
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 15713;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15713, 'zhTW','藍色其拉作戰坦克',NULL);
-- OLD name : 侍從萊歐倫·瑪爾迪拉斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=15722
UPDATE `creature_template_locale` SET `Name` = '萊歐倫·瑪爾迪拉斯' WHERE `locale` = 'zhTW' AND `entry` = 15722;
-- OLD name : 冬天爺爺的助手
-- Source : https://www.wowhead.com/wotlk/tw/npc=15729
UPDATE `creature_template_locale` SET `Name` = '冬天爸爸的助手' WHERE `locale` = 'zhTW' AND `entry` = 15729;
-- OLD subname : 燻木牧場
-- Source : https://www.wowhead.com/wotlk/tw/npc=15732
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15732;
-- OLD name : 次級異種撕掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15749
UPDATE `creature_template_locale` SET `Name` = '次級異種剝奪者' WHERE `locale` = 'zhTW' AND `entry` = 15749;
-- OLD name : 異種撕掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15752
UPDATE `creature_template_locale` SET `Name` = '異種剝奪者' WHERE `locale` = 'zhTW' AND `entry` = 15752;
-- OLD name : 大型異種撕掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15756
UPDATE `creature_template_locale` SET `Name` = '大型異種剝奪者' WHERE `locale` = 'zhTW' AND `entry` = 15756;
-- OLD name : 超級異種撕掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15759
UPDATE `creature_template_locale` SET `Name` = '超級異種剝奪者' WHERE `locale` = 'zhTW' AND `entry` = 15759;
-- OLD name : 聖誕版砲手威利
-- Source : https://www.wowhead.com/wotlk/tw/npc=15773
UPDATE `creature_template_locale` SET `Name` = '聖誕版炮手威利' WHERE `locale` = 'zhTW' AND `entry` = 15773;
-- OLD name : 聖誕版將領沃恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=15777
UPDATE `creature_template_locale` SET `Name` = '聖誕版指揮官沃恩' WHERE `locale` = 'zhTW' AND `entry` = 15777;
-- OLD subname : 黑手軍團護甲鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=15796
UPDATE `creature_template_locale` SET `Title` = '黑手軍團防具商' WHERE `locale` = 'zhTW' AND `entry` = 15796;
-- OLD name : 巨像研究員蘇菲亞
-- Source : https://www.wowhead.com/wotlk/tw/npc=15797
UPDATE `creature_template_locale` SET `Name` = '巨像研究員索菲亞' WHERE `locale` = 'zhTW' AND `entry` = 15797;
-- OLD name : 小型異種撕掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15808
UPDATE `creature_template_locale` SET `Name` = '初級異種剝奪者' WHERE `locale` = 'zhTW' AND `entry` = 15808;
-- OLD name : 衰老的異種撕掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15811
UPDATE `creature_template_locale` SET `Name` = '衰老的異種剝奪者' WHERE `locale` = 'zhTW' AND `entry` = 15811;
-- OLD name : 冬天爺爺的助手(大)
-- Source : https://www.wowhead.com/wotlk/tw/npc=15832
UPDATE `creature_template_locale` SET `Name` = '冬天爺爺的助手（大）' WHERE `locale` = 'zhTW' AND `entry` = 15832;
-- OLD name : 冬天爺爺的助手(大)
-- Source : https://www.wowhead.com/wotlk/tw/npc=15835
UPDATE `creature_template_locale` SET `Name` = '冬天爺爺的助手（大）' WHERE `locale` = 'zhTW' AND `entry` = 15835;
-- OLD name : 冬天爺爺的助手(大)
-- Source : https://www.wowhead.com/wotlk/tw/npc=15838
UPDATE `creature_template_locale` SET `Name` = '冬天爺爺的助手（大）' WHERE `locale` = 'zhTW' AND `entry` = 15838;
-- OLD name : 卡林多聯軍獸人蠻兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=15839
UPDATE `creature_template_locale` SET `Name` = '卡林多聯軍獸人步兵' WHERE `locale` = 'zhTW' AND `entry` = 15839;
-- OLD name : 卡林多聯軍爭鬥者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15850
UPDATE `creature_template_locale` SET `Name` = '卡林多聯軍散兵' WHERE `locale` = 'zhTW' AND `entry` = 15850;
-- OLD name : 卡林多聯軍元帥
-- Source : https://www.wowhead.com/wotlk/tw/npc=15851
UPDATE `creature_template_locale` SET `Name` = '勇猛的卡林多聯軍元帥' WHERE `locale` = 'zhTW' AND `entry` = 15851;
-- OLD name : 奧格瑪精英輕步兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=15853
UPDATE `creature_template_locale` SET `Name` = '奧格瑪精英步兵' WHERE `locale` = 'zhTW' AND `entry` = 15853;
-- OLD name : 牛頭人步槍兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=15855
UPDATE `creature_template_locale` SET `Name` = '牛頭人火槍手' WHERE `locale` = 'zhTW' AND `entry` = 15855;
-- OLD name : 牛頭人原獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15856
UPDATE `creature_template_locale` SET `Name` = '牛頭人部族祭司' WHERE `locale` = 'zhTW' AND `entry` = 15856;
-- OLD name : 鐵爐堡輕步兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=15861
UPDATE `creature_template_locale` SET `Name` = '鐵爐堡步兵' WHERE `locale` = 'zhTW' AND `entry` = 15861;
-- OLD subname : 先祖硬幣收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15864
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15864;
-- OLD name : 高階指揮官萊諾爾·風矛
-- Source : https://www.wowhead.com/wotlk/tw/npc=15866
UPDATE `creature_template_locale` SET `Name` = '指揮官萊諾爾·風矛' WHERE `locale` = 'zhTW' AND `entry` = 15866;
-- OLD name : 大領主李奧瑞克·馮·澤爾迪格
-- Source : https://www.wowhead.com/wotlk/tw/npc=15868
UPDATE `creature_template_locale` SET `Name` = '李奧瑞克·馮·澤爾迪格公爵' WHERE `locale` = 'zhTW' AND `entry` = 15868;
-- OLD name : 『謀士』瑪拉加夫
-- Source : https://www.wowhead.com/wotlk/tw/npc=15869
UPDATE `creature_template_locale` SET `Name` = '參謀瑪拉加夫' WHERE `locale` = 'zhTW' AND `entry` = 15869;
-- OLD name : 奧古斯特·敵錘公爵
-- Source : https://www.wowhead.com/wotlk/tw/npc=15870
UPDATE `creature_template_locale` SET `Name` = '奧古斯特公爵' WHERE `locale` = 'zhTW' AND `entry` = 15870;
-- OLD name : 喚戰者芬斯特爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=15878
UPDATE `creature_template_locale` SET `Name` = '戰爭召喚者芬斯特爾' WHERE `locale` = 'zhTW' AND `entry` = 15878;
-- OLD subname : 先祖硬幣收集者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15909
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 15909;
-- OLD name : 劇毒泥漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=15925
UPDATE `creature_template_locale` SET `Name` = '劇毒軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 15925;
-- OLD name : 毒雲
-- Source : https://www.wowhead.com/wotlk/tw/npc=15933
UPDATE `creature_template_locale` SET `Name` = '毒性雲霧' WHERE `locale` = 'zhTW' AND `entry` = 15933;
-- OLD name : 『不潔者』海根
-- Source : https://www.wowhead.com/wotlk/tw/npc=15936
UPDATE `creature_template_locale` SET `Name` = '『骯髒者』海根' WHERE `locale` = 'zhTW' AND `entry` = 15936;
-- OLD name : 『瘟疫使者』諾斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=15954
UPDATE `creature_template_locale` SET `Name` = '瘟疫者諾斯' WHERE `locale` = 'zhTW' AND `entry` = 15954;
-- OLD name : 恐懼蠕行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15974
UPDATE `creature_template_locale` SET `Name` = '恐懼爬行者' WHERE `locale` = 'zhTW' AND `entry` = 15974;
-- OLD name : 毒液潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15976
UPDATE `creature_template_locale` SET `Name` = '毒液捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 15976;
-- OLD name : 毒性誘捕者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15977
UPDATE `creature_template_locale` SET `Name` = '感染誘捕者' WHERE `locale` = 'zhTW' AND `entry` = 15977;
-- OLD name : 地穴劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=15978
UPDATE `creature_template_locale` SET `Name` = '地穴掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 15978;
-- OLD name : 墓穴恐蛛
-- Source : https://www.wowhead.com/wotlk/tw/npc=15979
UPDATE `creature_template_locale` SET `Name` = '墓碑之恐' WHERE `locale` = 'zhTW' AND `entry` = 15979;
-- OLD name : [PH] Valentine Reveler, Male (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=15982
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 15982;
-- OLD name : [PH] Valentine Reveler, Female (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=15983
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 15983;
-- OLD name : 沙圖拉皇家守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=15984
UPDATE `creature_template_locale` SET `Name` = '沙爾圖拉皇家衛士' WHERE `locale` = 'zhTW' AND `entry` = 15984;
-- OLD name : 亡靈守衛托爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=16003
UPDATE `creature_template_locale` SET `Name` = '亡靈衛兵托爾' WHERE `locale` = 'zhTW' AND `entry` = 16003;
-- OLD name : 憎恨者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16011
UPDATE `creature_template_locale` SET `Name` = '洛斯伯' WHERE `locale` = 'zhTW' AND `entry` = 16011;
-- OLD subname : 奇特試劑商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=16015
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16015;
-- OLD name : 縫補魔像
-- Source : https://www.wowhead.com/wotlk/tw/npc=16017
UPDATE `creature_template_locale` SET `Name` = '縫補傀儡' WHERE `locale` = 'zhTW' AND `entry` = 16017;
-- OLD name : 布拉納·雷蹄, subname : 熊貓寶寶照料者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16019
UPDATE `creature_template_locale` SET `Name` = '布拉納·雷角',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16019;
-- OLD name : 艾莉雅月影, subname : 熊貓寶寶照料者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16023
UPDATE `creature_template_locale` SET `Name` = '艾莉雅·月影',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16023;
-- OLD name : 防腐泥漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=16024
UPDATE `creature_template_locale` SET `Name` = '香油軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 16024;
-- OLD name : 縫合巨人
-- Source : https://www.wowhead.com/wotlk/tw/npc=16025
UPDATE `creature_template_locale` SET `Name` = '縫合噴吐者' WHERE `locale` = 'zhTW' AND `entry` = 16025;
-- OLD name : 活體毒化物
-- Source : https://www.wowhead.com/wotlk/tw/npc=16027
UPDATE `creature_template_locale` SET `Name` = '活毒藥' WHERE `locale` = 'zhTW' AND `entry` = 16027;
-- OLD subname : 辛德拉之屋
-- Source : https://www.wowhead.com/wotlk/tw/npc=16032
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16032;
-- OLD name : [UNUSED]Bog Beast B [PH]
-- Source : https://www.wowhead.com/wotlk/tw/npc=16035
UPDATE `creature_template_locale` SET `Name` = 'Bog Beast B [PH]' WHERE `locale` = 'zhTW' AND `entry` = 16035;
-- OLD name : 染疫蝙蝠
-- Source : https://www.wowhead.com/wotlk/tw/npc=16037
UPDATE `creature_template_locale` SET `Name` = '被感染的蝙蝠' WHERE `locale` = 'zhTW' AND `entry` = 16037;
-- OLD name : [UNUSED]死亡獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=16038
UPDATE `creature_template_locale` SET `Name` = '死亡獵犬' WHERE `locale` = 'zhTW' AND `entry` = 16038;
-- OLD name : 瓦薩拉克領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=16042
UPDATE `creature_template_locale` SET `Name` = '瓦薩拉克' WHERE `locale` = 'zhTW' AND `entry` = 16042;
-- OLD name : 染病的蛆蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=16056
UPDATE `creature_template_locale` SET `Name` = '生病的蛆蟲' WHERE `locale` = 'zhTW' AND `entry` = 16056;
-- OLD name : 大領主莫格萊尼, subname : 灰燼使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16062
UPDATE `creature_template_locale` SET `Name` = '莫格萊尼公爵',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16062;
-- OLD name : 布洛莫斯女士
-- Source : https://www.wowhead.com/wotlk/tw/npc=16065
UPDATE `creature_template_locale` SET `Name` = '布洛莫斯爵士' WHERE `locale` = 'zhTW' AND `entry` = 16065;
-- OLD name : 鬼靈刺客
-- Source : https://www.wowhead.com/wotlk/tw/npc=16066
UPDATE `creature_template_locale` SET `Name` = '鬼魂刺客' WHERE `locale` = 'zhTW' AND `entry` = 16066;
-- OLD name : 死亡戰駒
-- Source : https://www.wowhead.com/wotlk/tw/npc=16067
UPDATE `creature_template_locale` SET `Name` = '骷髏駿馬' WHERE `locale` = 'zhTW' AND `entry` = 16067;
-- OLD name : 瓦薩拉克領主之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=16073
UPDATE `creature_template_locale` SET `Name` = '瓦薩拉克的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 16073;
-- OLD name : [PH] Alex's Test DPS Mob (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=16077
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 16077;
-- OLD name : 『測試龍』奧瑪
-- Source : https://www.wowhead.com/wotlk/tw/npc=16089
UPDATE `creature_template_locale` SET `Name` = 'Omar the Test Kobold' WHERE `locale` = 'zhTW' AND `entry` = 16089;
-- OLD name : 鬼靈潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16093
UPDATE `creature_template_locale` SET `Name` = '鬼靈捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 16093;
-- OLD subname : 瑪根·長矛的寵物
-- Source : https://www.wowhead.com/wotlk/tw/npc=16095
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16095;
-- OLD name : 賈林之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=16103
UPDATE `creature_template_locale` SET `Name` = '賈林的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 16103;
-- OLD name : 索索斯之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=16104
UPDATE `creature_template_locale` SET `Name` = '索索斯的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 16104;
-- OLD subname : 皇家藥劑師學會
-- Source : https://www.wowhead.com/wotlk/tw/npc=16107
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16107;
-- OLD name : 十字軍指揮官柯菲斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=16112
UPDATE `creature_template_locale` SET `Name` = '『聖光勇士』柯菲斯' WHERE `locale` = 'zhTW' AND `entry` = 16112;
-- OLD name : 血色指揮官瑪涵
-- Source : https://www.wowhead.com/wotlk/tw/npc=16114
UPDATE `creature_template_locale` SET `Name` = '血色指揮官馬翰' WHERE `locale` = 'zhTW' AND `entry` = 16114;
-- OLD name : 十字軍指揮官艾利格·黎明使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16115
UPDATE `creature_template_locale` SET `Name` = '指揮官艾利格·攜晨者' WHERE `locale` = 'zhTW' AND `entry` = 16115;
-- OLD name : 染疫野豬
-- Source : https://www.wowhead.com/wotlk/tw/npc=16117
UPDATE `creature_template_locale` SET `Name` = '瘟疫野豬' WHERE `locale` = 'zhTW' AND `entry` = 16117;
-- OLD name : 骸骨爪牙
-- Source : https://www.wowhead.com/wotlk/tw/npc=16119
UPDATE `creature_template_locale` SET `Name` = '白骨爪牙' WHERE `locale` = 'zhTW' AND `entry` = 16119;
-- OLD name : 骸骨法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=16120
UPDATE `creature_template_locale` SET `Name` = '白骨法師' WHERE `locale` = 'zhTW' AND `entry` = 16120;
-- OLD name : 無情的受訓員
-- Source : https://www.wowhead.com/wotlk/tw/npc=16124
UPDATE `creature_template_locale` SET `Name` = '無情的訓練師' WHERE `locale` = 'zhTW' AND `entry` = 16124;
-- OLD name : 無情的死亡騎士
-- Source : https://www.wowhead.com/wotlk/tw/npc=16125
UPDATE `creature_template_locale` SET `Name` = '無情的死騎' WHERE `locale` = 'zhTW' AND `entry` = 16125;
-- OLD name : 鬼靈受訓員
-- Source : https://www.wowhead.com/wotlk/tw/npc=16127
UPDATE `creature_template_locale` SET `Name` = '鬼靈訓練師' WHERE `locale` = 'zhTW' AND `entry` = 16127;
-- OLD name : 『刺客』洛漢
-- Source : https://www.wowhead.com/wotlk/tw/npc=16131
UPDATE `creature_template_locale` SET `Name` = '『刺客』羅漢' WHERE `locale` = 'zhTW' AND `entry` = 16131;
-- OLD name : 林布拉特·碎地者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16134
UPDATE `creature_template_locale` SET `Name` = '林布拉特·大地粉碎者' WHERE `locale` = 'zhTW' AND `entry` = 16134;
-- OLD name : 亡域水晶裂片
-- Source : https://www.wowhead.com/wotlk/tw/npc=16136
UPDATE `creature_template_locale` SET `Name` = '墓地水晶碎片' WHERE `locale` = 'zhTW' AND `entry` = 16136;
-- OLD name : [UNUSED] Scourge Invasion Guardian (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=16138
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 16138;
-- OLD name : [UNUSED] Necropolis Crystal, Buttress (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=16140
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 16140;
-- OLD name : 鬼靈死亡騎士
-- Source : https://www.wowhead.com/wotlk/tw/npc=16148
UPDATE `creature_template_locale` SET `Name` = '鬼靈死騎' WHERE `locale` = 'zhTW' AND `entry` = 16148;
-- OLD name : 復活的侍從
-- Source : https://www.wowhead.com/wotlk/tw/npc=16154
UPDATE `creature_template_locale` SET `Name` = '復生的死亡騎士' WHERE `locale` = 'zhTW' AND `entry` = 16154;
-- OLD name : 暗觸戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=16156
UPDATE `creature_template_locale` SET `Name` = '被黑暗所觸碰的戰士' WHERE `locale` = 'zhTW' AND `entry` = 16156;
-- OLD name : 死闇騎士
-- Source : https://www.wowhead.com/wotlk/tw/npc=16165
UPDATE `creature_template_locale` SET `Name` = '闇騎騎士' WHERE `locale` = 'zhTW' AND `entry` = 16165;
-- OLD name : 瑟爾倫擊殺獎勵
-- Source : https://www.wowhead.com/wotlk/tw/npc=16166
UPDATE `creature_template_locale` SET `Name` = '瑟爾倫擊殺榮譽' WHERE `locale` = 'zhTW' AND `entry` = 16166;
-- OLD name : 冷霧巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16170
UPDATE `creature_template_locale` SET `Name` = '冷霧行者' WHERE `locale` = 'zhTW' AND `entry` = 16170;
-- OLD name : 受損的亡域水晶裂片
-- Source : https://www.wowhead.com/wotlk/tw/npc=16172
UPDATE `creature_template_locale` SET `Name` = '受損的墓地水晶碎片' WHERE `locale` = 'zhTW' AND `entry` = 16172;
-- OLD name : [UNUSED] 拱壁引導器 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=16188
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 16188;
-- OLD name : 賽詩倫·蒼曦
-- Source : https://www.wowhead.com/wotlk/tw/npc=16191
UPDATE `creature_template_locale` SET `Name` = '賽詩倫·藍晨' WHERE `locale` = 'zhTW' AND `entry` = 16191;
-- OLD name : 女飛行師薄暮
-- Source : https://www.wowhead.com/wotlk/tw/npc=16192
UPDATE `creature_template_locale` SET `Name` = '女飛行師·薄暮' WHERE `locale` = 'zhTW' AND `entry` = 16192;
-- OLD name : 骷髏鐵匠
-- Source : https://www.wowhead.com/wotlk/tw/npc=16193
UPDATE `creature_template_locale` SET `Name` = '骸骨鐵匠' WHERE `locale` = 'zhTW' AND `entry` = 16193;
-- OLD name : 亡域控制器
-- Source : https://www.wowhead.com/wotlk/tw/npc=16214
UPDATE `creature_template_locale` SET `Name` = '大墓地控制器' WHERE `locale` = 'zhTW' AND `entry` = 16214;
-- OLD name : 特斯拉線圈
-- Source : https://www.wowhead.com/wotlk/tw/npc=16218
UPDATE `creature_template_locale` SET `Name` = '泰斯拉·寇歐' WHERE `locale` = 'zhTW' AND `entry` = 16218;
-- OLD name : 商隊騾子
-- Source : https://www.wowhead.com/wotlk/tw/npc=16232
UPDATE `creature_template_locale` SET `Name` = '商隊騾隻' WHERE `locale` = 'zhTW' AND `entry` = 16232;
-- OLD name : 眼梗
-- Source : https://www.wowhead.com/wotlk/tw/npc=16236
UPDATE `creature_template_locale` SET `Name` = '眼柄' WHERE `locale` = 'zhTW' AND `entry` = 16236;
-- OLD name : 銀色黎明招募員, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16241
UPDATE `creature_template_locale` SET `Name` = '黎明招募員',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16241;
-- OLD name : 瘟疫泥漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=16243
UPDATE `creature_template_locale` SET `Name` = '瘟疫軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 16243;
-- OLD name : 傳染食屍鬼
-- Source : https://www.wowhead.com/wotlk/tw/npc=16244
UPDATE `creature_template_locale` SET `Name` = '會傳染的食屍鬼' WHERE `locale` = 'zhTW' AND `entry` = 16244;
-- OLD name : 戰場元帥錢柏, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16254
UPDATE `creature_template_locale` SET `Name` = '大元帥錢柏',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16254;
-- OLD name : 銀色黎明斥候, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16255
UPDATE `creature_template_locale` SET `Name` = '銀色偵察兵',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16255;
-- OLD subname : Rogue Trainer
-- Source : https://www.wowhead.com/wotlk/tw/npc=16279
UPDATE `creature_template_locale` SET `Title` = '盜賊訓練師' WHERE `locale` = 'zhTW' AND `entry` = 16279;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16281
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16281;
-- OLD name : 銀色黎明特使, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16285
UPDATE `creature_template_locale` SET `Name` = '銀色特使',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16285;
-- OLD name : 輻射泥漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=16290
UPDATE `creature_template_locale` SET `Name` = '輻射軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 16290;
-- OLD name : 骷髏突擊兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=16299
UPDATE `creature_template_locale` SET `Name` = '骸骨震擊者' WHERE `locale` = 'zhTW' AND `entry` = 16299;
-- OLD name : 鬼靈咆嘯者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16312
UPDATE `creature_template_locale` SET `Name` = '鬼靈咆哮者' WHERE `locale` = 'zhTW' AND `entry` = 16312;
-- OLD name : 達納蘇斯女獵手
-- Source : https://www.wowhead.com/wotlk/tw/npc=16332
UPDATE `creature_template_locale` SET `Name` = '達納蘇斯女獵人' WHERE `locale` = 'zhTW' AND `entry` = 16332;
-- OLD name : 天譴軍團爪牙, 重生者,鬼魂/骷髏
-- Source : https://www.wowhead.com/wotlk/tw/npc=16336
UPDATE `creature_template_locale` SET `Name` = '天譴軍團爪牙, 重生者,鬼靈/骸骨' WHERE `locale` = 'zhTW' AND `entry` = 16336;
-- OLD name : 天譴軍團爪牙, 重生者, 食屍鬼/骷髏
-- Source : https://www.wowhead.com/wotlk/tw/npc=16338
UPDATE `creature_template_locale` SET `Name` = '天譴軍團爪牙, 重生者, 食屍鬼/骸骨' WHERE `locale` = 'zhTW' AND `entry` = 16338;
-- OLD name : 秘法劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16339
UPDATE `creature_template_locale` SET `Name` = '秘法搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 16339;
-- OLD name : 銀色黎明信差, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16359
UPDATE `creature_template_locale` SET `Name` = '銀色信差',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16359;
-- OLD name : 肉身殭屍
-- Source : https://www.wowhead.com/wotlk/tw/npc=16360
UPDATE `creature_template_locale` SET `Name` = '殭屍狗頭人' WHERE `locale` = 'zhTW' AND `entry` = 16360;
-- OLD name : 指揮官湯瑪斯·海勒瑞, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16361
UPDATE `creature_template_locale` SET `Name` = '指揮官湯瑪士·海勒瑞',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16361;
-- OLD subname : 聖光兄弟會
-- Source : https://www.wowhead.com/wotlk/tw/npc=16365
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16365;
-- OLD name : 亡域侍僧
-- Source : https://www.wowhead.com/wotlk/tw/npc=16368
UPDATE `creature_template_locale` SET `Name` = '大墓地侍僧' WHERE `locale` = 'zhTW' AND `entry` = 16368;
-- OLD name : 污穢泥漿怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=16375
UPDATE `creature_template_locale` SET `Name` = '污穢軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 16375;
-- OLD name : 銀白哨衛, subname : 銀白十字軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=16378
UPDATE `creature_template_locale` SET `Name` = '銀色黎明哨兵',`Title` = '銀色黎明' WHERE `locale` = 'zhTW' AND `entry` = 16378;
-- OLD name : 骸骨女巫
-- Source : https://www.wowhead.com/wotlk/tw/npc=16380
UPDATE `creature_template_locale` SET `Name` = '骨巫' WHERE `locale` = 'zhTW' AND `entry` = 16380;
-- OLD name : 銀色黎明新兵, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16384
UPDATE `creature_template_locale` SET `Name` = '銀色黎明初心者',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16384;
-- OLD name : 亡域接替者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16386
UPDATE `creature_template_locale` SET `Name` = '大墓地接替者' WHERE `locale` = 'zhTW' AND `entry` = 16386;
-- OLD subname : 薩格拉斯之手
-- Source : https://www.wowhead.com/wotlk/tw/npc=16387
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16387;
-- OLD name : 死亡之寒僕從
-- Source : https://www.wowhead.com/wotlk/tw/npc=16390
UPDATE `creature_template_locale` SET `Name` = '戴司奇爾僕從' WHERE `locale` = 'zhTW' AND `entry` = 16390;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16395
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16395;
-- OLD name : 亡域代理人
-- Source : https://www.wowhead.com/wotlk/tw/npc=16398
UPDATE `creature_template_locale` SET `Name` = '大墓地代理人' WHERE `locale` = 'zhTW' AND `entry` = 16398;
-- OLD name : 亡域
-- Source : https://www.wowhead.com/wotlk/tw/npc=16401
UPDATE `creature_template_locale` SET `Name` = '大墓地' WHERE `locale` = 'zhTW' AND `entry` = 16401;
-- OLD name : 鬼靈僕從
-- Source : https://www.wowhead.com/wotlk/tw/npc=16407
UPDATE `creature_template_locale` SET `Name` = '鬼靈侍從' WHERE `locale` = 'zhTW' AND `entry` = 16407;
-- OLD name : 納克薩瑪斯的鬼魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=16419
UPDATE `creature_template_locale` SET `Name` = '納克薩瑪斯鬼靈' WHERE `locale` = 'zhTW' AND `entry` = 16419;
-- OLD name : 亡域生命力
-- Source : https://www.wowhead.com/wotlk/tw/npc=16421
UPDATE `creature_template_locale` SET `Name` = '大墓地生命力' WHERE `locale` = 'zhTW' AND `entry` = 16421;
-- OLD name : 骷髏士兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=16422
UPDATE `creature_template_locale` SET `Name` = '骸骨士兵' WHERE `locale` = 'zhTW' AND `entry` = 16422;
-- OLD name : 鬼靈亡魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=16423
UPDATE `creature_template_locale` SET `Name` = '鬼靈幻象' WHERE `locale` = 'zhTW' AND `entry` = 16423;
-- OLD name : 鬼靈哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=16424
UPDATE `creature_template_locale` SET `Name` = '鬼靈哨兵' WHERE `locale` = 'zhTW' AND `entry` = 16424;
-- OLD name : 冰凍荒原士兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=16427
UPDATE `creature_template_locale` SET `Name` = '冰凍荒地士兵' WHERE `locale` = 'zhTW' AND `entry` = 16427;
-- OLD name : 無法阻止的憎惡體
-- Source : https://www.wowhead.com/wotlk/tw/npc=16428
UPDATE `creature_template_locale` SET `Name` = '無法阻止的憎惡' WHERE `locale` = 'zhTW' AND `entry` = 16428;
-- OLD name : 灰燼使者啟動器
-- Source : https://www.wowhead.com/wotlk/tw/npc=16430
UPDATE `creature_template_locale` SET `Name` = '灰燼之劍啟動器' WHERE `locale` = 'zhTW' AND `entry` = 16430;
-- OLD name : 破碎的亡域水晶
-- Source : https://www.wowhead.com/wotlk/tw/npc=16431
UPDATE `creature_template_locale` SET `Name` = '破碎的墓地水晶' WHERE `locale` = 'zhTW' AND `entry` = 16431;
-- OLD name : 銀色黎明十字軍, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16433
UPDATE `creature_template_locale` SET `Name` = '銀色黎明鬥士',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16433;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16434
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16434;
-- OLD name : 銀色黎明教士, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16435
UPDATE `creature_template_locale` SET `Name` = '銀色黎明牧師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16435;
-- OLD name : 銀色黎明僧侶, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16436
UPDATE `creature_template_locale` SET `Name` = '銀色黎明神父',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16436;
-- OLD name : 骷髏裝甲兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=16438
UPDATE `creature_template_locale` SET `Name` = '骸骨裝甲兵' WHERE `locale` = 'zhTW' AND `entry` = 16438;
-- OLD name : 變身後的大領主莫格萊尼, subname : 灰燼使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16440
UPDATE `creature_template_locale` SET `Name` = '變身後的莫格萊尼公爵',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16440;
-- OLD name : 特基
-- Source : https://www.wowhead.com/wotlk/tw/npc=16445
UPDATE `creature_template_locale` SET `Name` = '魚人寶寶' WHERE `locale` = 'zhTW' AND `entry` = 16445;
-- OLD name : 染疫食屍鬼
-- Source : https://www.wowhead.com/wotlk/tw/npc=16447
UPDATE `creature_template_locale` SET `Name` = '被感染的食屍鬼' WHERE `locale` = 'zhTW' AND `entry` = 16447;
-- OLD name : 被感染的惡魔犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=16448
UPDATE `creature_template_locale` SET `Name` = '被感染的死亡獵犬' WHERE `locale` = 'zhTW' AND `entry` = 16448;
-- OLD name : 納克薩瑪斯之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=16449
UPDATE `creature_template_locale` SET `Name` = '納克薩瑪斯幽魂' WHERE `locale` = 'zhTW' AND `entry` = 16449;
-- OLD subname : 可口可樂大使
-- Source : https://www.wowhead.com/wotlk/tw/npc=16450
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16450;
-- OLD name : [UNUSED]死亡騎士復仇者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16451
UPDATE `creature_template_locale` SET `Name` = '死亡騎士復仇者' WHERE `locale` = 'zhTW' AND `entry` = 16451;
-- OLD name : 死靈巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16453
UPDATE `creature_template_locale` SET `Name` = '闇術潛行者' WHERE `locale` = 'zhTW' AND `entry` = 16453;
-- OLD subname : 可口可樂大使
-- Source : https://www.wowhead.com/wotlk/tw/npc=16454
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16454;
-- OLD subname : 可口可樂大使
-- Source : https://www.wowhead.com/wotlk/tw/npc=16455
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16455;
-- OLD name : 波雷
-- Source : https://www.wowhead.com/wotlk/tw/npc=16456
UPDATE `creature_template_locale` SET `Name` = '波利' WHERE `locale` = 'zhTW' AND `entry` = 16456;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=16458
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 16458;
-- OLD subname : 皇家藥劑師學會
-- Source : https://www.wowhead.com/wotlk/tw/npc=16464
UPDATE `creature_template_locale` SET `Title` = '皇家藥劑師協會' WHERE `locale` = 'zhTW' AND `entry` = 16464;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16478
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16478;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16484
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16484;
-- OLD name : 纏繞之網
-- Source : https://www.wowhead.com/wotlk/tw/npc=16486
UPDATE `creature_template_locale` SET `Name` = '纏繞的蜘蛛網' WHERE `locale` = 'zhTW' AND `entry` = 16486;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16490
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16490;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16493
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16493;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16494
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16494;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16495
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16495;
-- OLD name : 破碎之手哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=16507
UPDATE `creature_template_locale` SET `Name` = '破碎之手哨兵' WHERE `locale` = 'zhTW' AND `entry` = 16507;
-- OLD name : 銀色黎明座馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=16508
UPDATE `creature_template_locale` SET `Name` = '黎明座馬' WHERE `locale` = 'zhTW' AND `entry` = 16508;
-- OLD name : 銀白戰馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=16509
UPDATE `creature_template_locale` SET `Name` = '銀色黎明戰馬' WHERE `locale` = 'zhTW' AND `entry` = 16509;
-- OLD name : 銀色黎明戰騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=16510
UPDATE `creature_template_locale` SET `Name` = '黎明衝鋒座騎' WHERE `locale` = 'zhTW' AND `entry` = 16510;
-- OLD name : 銀色黎明坐騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=16511
UPDATE `creature_template_locale` SET `Name` = '黎明座騎' WHERE `locale` = 'zhTW' AND `entry` = 16511;
-- OLD name : 銀色黎明骷髏馬
-- Source : https://www.wowhead.com/wotlk/tw/npc=16512
UPDATE `creature_template_locale` SET `Name` = '黎明骷髏馬' WHERE `locale` = 'zhTW' AND `entry` = 16512;
-- OLD name : 銀色黎明死亡戰騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=16513
UPDATE `creature_template_locale` SET `Name` = '黎明骷髏戰馬' WHERE `locale` = 'zhTW' AND `entry` = 16513;
-- OLD name : 補給官衛迪克
-- Source : https://www.wowhead.com/wotlk/tw/npc=16528
UPDATE `creature_template_locale` SET `Name` = '物資供應者衛迪克' WHERE `locale` = 'zhTW' AND `entry` = 16528;
-- OLD name : 黯淡的亡域水晶
-- Source : https://www.wowhead.com/wotlk/tw/npc=16531
UPDATE `creature_template_locale` SET `Name` = '黯淡的墓地水晶' WHERE `locale` = 'zhTW' AND `entry` = 16531;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=16542
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 16542;
-- OLD name : 以太竊賊
-- Source : https://www.wowhead.com/wotlk/tw/npc=16544
UPDATE `creature_template_locale` SET `Name` = '伊斯利竊賊' WHERE `locale` = 'zhTW' AND `entry` = 16544;
-- OLD name : 以太盜法者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16545
UPDATE `creature_template_locale` SET `Name` = '伊斯利盜法者' WHERE `locale` = 'zhTW' AND `entry` = 16545;
-- OLD name : 瘋狂的水靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=16570
UPDATE `creature_template_locale` SET `Name` = '瘋狂的水之靈' WHERE `locale` = 'zhTW' AND `entry` = 16570;
-- OLD name : 地穴守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=16573
UPDATE `creature_template_locale` SET `Name` = '地室守衛' WHERE `locale` = 'zhTW' AND `entry` = 16573;
-- OLD name : 霸主殘拳
-- Source : https://www.wowhead.com/wotlk/tw/npc=16576
UPDATE `creature_template_locale` SET `Name` = '殘拳霸主' WHERE `locale` = 'zhTW' AND `entry` = 16576;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=16583
UPDATE `creature_template_locale` SET `Title` = '大師級鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 16583;
-- OLD name : 警備指揮官克朗克
-- Source : https://www.wowhead.com/wotlk/tw/npc=16584
UPDATE `creature_template_locale` SET `Name` = '警備隊長克朗克' WHERE `locale` = 'zhTW' AND `entry` = 16584;
-- OLD name : 藥劑師安拓維奇, subname : 鍊金術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=16588
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16588;
-- OLD name : 索爾瑪狼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=16600
UPDATE `creature_template_locale` SET `Name` = '索爾瑪座狼' WHERE `locale` = 'zhTW' AND `entry` = 16600;
-- OLD name : [PH] 哥布林掠奪者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=16608
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 16608;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=16618
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 16618;
-- OLD name : 賽拉娜
-- Source : https://www.wowhead.com/wotlk/tw/npc=16619
UPDATE `creature_template_locale` SET `Name` = '賽蓮娜' WHERE `locale` = 'zhTW' AND `entry` = 16619;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=16621
UPDATE `creature_template_locale` SET `Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 16621;
-- OLD name : 拍賣師伊希利安, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/tw/npc=16627
UPDATE `creature_template_locale` SET `Name` = '伊希利安',`Title` = '拍賣師' WHERE `locale` = 'zhTW' AND `entry` = 16627;
-- OLD name : 拍賣師卡多利, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/tw/npc=16628
UPDATE `creature_template_locale` SET `Name` = '卡多利',`Title` = '拍賣師' WHERE `locale` = 'zhTW' AND `entry` = 16628;
-- OLD name : 拍賣師泰莊, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/tw/npc=16629
UPDATE `creature_template_locale` SET `Name` = '泰莊',`Title` = '拍賣師' WHERE `locale` = 'zhTW' AND `entry` = 16629;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=16676
UPDATE `creature_template_locale` SET `Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 16676;
-- OLD name : 屍甲蟲
-- Source : https://www.wowhead.com/wotlk/tw/npc=16698
UPDATE `creature_template_locale` SET `Name` = '甲蟲屍體' WHERE `locale` = 'zhTW' AND `entry` = 16698;
-- OLD name : 破碎之手劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16699
UPDATE `creature_template_locale` SET `Name` = '破碎之手搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 16699;
-- OLD name : 拍賣師伊歐奇, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/tw/npc=16707
UPDATE `creature_template_locale` SET `Name` = '伊歐奇',`Title` = '拍賣師' WHERE `locale` = 'zhTW' AND `entry` = 16707;
-- OLD name : 赫曼·行者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16711
UPDATE `creature_template_locale` SET `Name` = '赫曼‧行者' WHERE `locale` = 'zhTW' AND `entry` = 16711;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=16719
UPDATE `creature_template_locale` SET `Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 16719;
-- OLD name : 費哥·迪普斯衛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16754
UPDATE `creature_template_locale` SET `Name` = '費哥‧迪普斯衛' WHERE `locale` = 'zhTW' AND `entry` = 16754;
-- OLD name : 賽瑞·鼻電 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16759
UPDATE `creature_template_locale` SET `Name` = '賽瑞‧鼻電' WHERE `locale` = 'zhTW' AND `entry` = 16759;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=16773
UPDATE `creature_template_locale` SET `Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 16773;
-- OLD name : 莫格萊尼之靈, subname : 灰燼使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16775
UPDATE `creature_template_locale` SET `Name` = '莫格萊尼之魂',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16775;
-- OLD name : 布洛莫斯之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=16776
UPDATE `creature_template_locale` SET `Name` = '布洛莫斯之魂' WHERE `locale` = 'zhTW' AND `entry` = 16776;
-- OLD name : 札里克之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=16777
UPDATE `creature_template_locale` SET `Name` = '札里克之魂' WHERE `locale` = 'zhTW' AND `entry` = 16777;
-- OLD name : 寇斯艾茲之靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=16778
UPDATE `creature_template_locale` SET `Name` = '寇斯艾茲之魂' WHERE `locale` = 'zhTW' AND `entry` = 16778;
-- OLD name : 瘟疫泥漿怪(藍色)
-- Source : https://www.wowhead.com/wotlk/tw/npc=16783
UPDATE `creature_template_locale` SET `Name` = '瘟疫軟泥怪(藍色)' WHERE `locale` = 'zhTW' AND `entry` = 16783;
-- OLD name : 瘟疫泥漿怪(紅色)
-- Source : https://www.wowhead.com/wotlk/tw/npc=16784
UPDATE `creature_template_locale` SET `Name` = '瘟疫軟泥怪(紅色)' WHERE `locale` = 'zhTW' AND `entry` = 16784;
-- OLD name : 瘟疫泥漿怪(綠色)
-- Source : https://www.wowhead.com/wotlk/tw/npc=16785
UPDATE `creature_template_locale` SET `Name` = '瘟疫軟泥怪(綠色)' WHERE `locale` = 'zhTW' AND `entry` = 16785;
-- OLD subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16786
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16786;
-- OLD name : 銀色黎明物資官, subname : 銀色黎明
-- Source : https://www.wowhead.com/wotlk/tw/npc=16787
UPDATE `creature_template_locale` SET `Name` = '黎明造型師',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16787;
-- OLD name : 鷹獵者崔娜·河風
-- Source : https://www.wowhead.com/wotlk/tw/npc=16790
UPDATE `creature_template_locale` SET `Name` = '獵鷹者崔娜·河風' WHERE `locale` = 'zhTW' AND `entry` = 16790;
-- OLD name : 補給官阿尼爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=16798
UPDATE `creature_template_locale` SET `Name` = '物資供應者阿尼爾' WHERE `locale` = 'zhTW' AND `entry` = 16798;
-- OLD name : 節慶博學大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=16817
UPDATE `creature_template_locale` SET `Name` = '節慶傳說大師' WHERE `locale` = 'zhTW' AND `entry` = 16817;
-- OLD name : 飛行管理員克利·苦色
-- Source : https://www.wowhead.com/wotlk/tw/npc=16822
UPDATE `creature_template_locale` SET `Name` = '飛行專家克利·苦色' WHERE `locale` = 'zhTW' AND `entry` = 16822;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=16823
UPDATE `creature_template_locale` SET `Title` = '大師級鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 16823;
-- OLD name : 西德·林巴迪
-- Source : https://www.wowhead.com/wotlk/tw/npc=16826
UPDATE `creature_template_locale` SET `Name` = '希德·琳巴迪' WHERE `locale` = 'zhTW' AND `entry` = 16826;
-- OLD name : 警備指揮官勒松·尼德溫
-- Source : https://www.wowhead.com/wotlk/tw/npc=16841
UPDATE `creature_template_locale` SET `Name` = '警備隊長勒松·尼德溫' WHERE `locale` = 'zhTW' AND `entry` = 16841;
-- OLD name : 補給官布克那
-- Source : https://www.wowhead.com/wotlk/tw/npc=16848
UPDATE `creature_template_locale` SET `Name` = '物資供應者布克那' WHERE `locale` = 'zhTW' AND `entry` = 16848;
-- OLD name : 安特利斯·黑 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16853
UPDATE `creature_template_locale` SET `Name` = '安特利斯‧黑' WHERE `locale` = 'zhTW' AND `entry` = 16853;
-- OLD name : [UNUSED]死亡領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=16861
UPDATE `creature_template_locale` SET `Name` = '死亡領主' WHERE `locale` = 'zhTW' AND `entry` = 16861;
-- OLD name : 血之谷術士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16872
UPDATE `creature_template_locale` SET `Name` = '噴翼' WHERE `locale` = 'zhTW' AND `entry` = 16872;
-- OLD name : 血之谷暗影施法者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16874
UPDATE `creature_template_locale` SET `Name` = '雪盲' WHERE `locale` = 'zhTW' AND `entry` = 16874;
-- OLD name : 噬骨食人者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16875
UPDATE `creature_template_locale` SET `Name` = '虛喙' WHERE `locale` = 'zhTW' AND `entry` = 16875;
-- OLD name : 魔化之血撕掠者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16882
UPDATE `creature_template_locale` SET `Name` = '數字控制臺' WHERE `locale` = 'zhTW' AND `entry` = 16882;
-- OLD name : 魔化之血飢餓者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16883
UPDATE `creature_template_locale` SET `Name` = '希拉斯的坐騎' WHERE `locale` = 'zhTW' AND `entry` = 16883;
-- OLD name : 暴風城慶祝者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16889
UPDATE `creature_template_locale` SET `Name` = '暴風城節慶司儀' WHERE `locale` = 'zhTW' AND `entry` = 16889;
-- OLD name : 鐵爐堡慶祝者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16890
UPDATE `creature_template_locale` SET `Name` = '鐵爐堡節慶司儀' WHERE `locale` = 'zhTW' AND `entry` = 16890;
-- OLD subname : 黎明低語者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16891
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16891;
-- OLD name : 達納蘇斯慶祝者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16892
UPDATE `creature_template_locale` SET `Name` = '達納蘇斯節慶司儀' WHERE `locale` = 'zhTW' AND `entry` = 16892;
-- OLD name : 奧格瑪慶祝者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16893
UPDATE `creature_template_locale` SET `Name` = '奧格瑪節慶司儀' WHERE `locale` = 'zhTW' AND `entry` = 16893;
-- OLD name : 雷霆崖慶祝者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16894
UPDATE `creature_template_locale` SET `Name` = '雷霆崖節慶司儀' WHERE `locale` = 'zhTW' AND `entry` = 16894;
-- OLD name : 幽暗城慶祝者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16895
UPDATE `creature_template_locale` SET `Name` = '幽暗城節慶司儀' WHERE `locale` = 'zhTW' AND `entry` = 16895;
-- OLD name : 猛怒腐泥怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=16901
UPDATE `creature_template_locale` SET `Name` = '憤怒的腐泥怪' WHERE `locale` = 'zhTW' AND `entry` = 16901;
-- OLD name : 猛怒小軟泥怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=16903
UPDATE `creature_template_locale` SET `Name` = '憤怒的恐泥怪' WHERE `locale` = 'zhTW' AND `entry` = 16903;
-- OLD name : 噬骨劫奪者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16908
UPDATE `creature_template_locale` SET `Name` = '亞芮艾爾‧快閃' WHERE `locale` = 'zhTW' AND `entry` = 16908;
-- OLD name : 噬骨野人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16909
UPDATE `creature_template_locale` SET `Name` = '尼科' WHERE `locale` = 'zhTW' AND `entry` = 16909;
-- OLD name : [Unused]捕食中的地殼穿刺者視覺 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=16914
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 16914;
-- OLD name : 噬骨戰狼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16926
UPDATE `creature_template_locale` SET `Name` = '薇薇卡‧星攝' WHERE `locale` = 'zhTW' AND `entry` = 16926;
-- OLD name : 原生石鐮掠奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16929
UPDATE `creature_template_locale` SET `Name` = '石鐮突擊隊員' WHERE `locale` = 'zhTW' AND `entry` = 16929;
-- OLD name : 狂怒的裂蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16930
UPDATE `creature_template_locale` SET `Name` = '巨鼠' WHERE `locale` = 'zhTW' AND `entry` = 16930;
-- OLD name : 羽牙劫毀者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16934
UPDATE `creature_template_locale` SET `Name` = '惡毒的劫毀者' WHERE `locale` = 'zhTW' AND `entry` = 16934;
-- OLD name : 相位虛無召喚者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=16941
UPDATE `creature_template_locale` SET `Name` = '相位虛無呼喚者' WHERE `locale` = 'zhTW' AND `entry` = 16941;
-- OLD name : 甘納格機電師
-- Source : https://www.wowhead.com/wotlk/tw/npc=16949
UPDATE `creature_template_locale` SET `Name` = '甘納格鍛造手' WHERE `locale` = 'zhTW' AND `entry` = 16949;
-- OLD name : 煉冶場軍團士兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=16954
UPDATE `creature_template_locale` SET `Name` = '煉冶場會員' WHERE `locale` = 'zhTW' AND `entry` = 16954;
-- OLD name : 大法師辛托
-- Source : https://www.wowhead.com/wotlk/tw/npc=16977
UPDATE `creature_template_locale` SET `Name` = '大法師辛特' WHERE `locale` = 'zhTW' AND `entry` = 16977;
-- OLD subname : 節慶供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=16979
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16979;
-- OLD name : 染疫守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16981
UPDATE `creature_template_locale` SET `Name` = '瘟疫守護者' WHERE `locale` = 'zhTW' AND `entry` = 16981;
-- OLD name : 染疫組合者
-- Source : https://www.wowhead.com/wotlk/tw/npc=16982
UPDATE `creature_template_locale` SET `Name` = '瘟疫組合者' WHERE `locale` = 'zhTW' AND `entry` = 16982;
-- OLD name : 染疫勇士
-- Source : https://www.wowhead.com/wotlk/tw/npc=16983
UPDATE `creature_template_locale` SET `Name` = '瘟疫勇士' WHERE `locale` = 'zhTW' AND `entry` = 16983;
-- OLD name : 染疫戰士
-- Source : https://www.wowhead.com/wotlk/tw/npc=16984
UPDATE `creature_template_locale` SET `Name` = '瘟疫戰士' WHERE `locale` = 'zhTW' AND `entry` = 16984;
-- OLD subname : 節慶供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=16985
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16985;
-- OLD subname : 節慶供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=16986
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 16986;
-- OLD name : 節慶營火管理者裝扮:牛頭人
-- Source : https://www.wowhead.com/wotlk/tw/npc=16987
UPDATE `creature_template_locale` SET `Name` = '節慶營火管理者裝扮：牛頭人' WHERE `locale` = 'zhTW' AND `entry` = 16987;
-- OLD name : 節慶營火管理者裝扮:人類
-- Source : https://www.wowhead.com/wotlk/tw/npc=16988
UPDATE `creature_template_locale` SET `Name` = '節慶營火管理者裝扮：人類' WHERE `locale` = 'zhTW' AND `entry` = 16988;
-- OLD name : 節慶營火管理者裝扮:食人妖
-- Source : https://www.wowhead.com/wotlk/tw/npc=16989
UPDATE `creature_template_locale` SET `Name` = '節慶營火管理者裝扮：食人妖' WHERE `locale` = 'zhTW' AND `entry` = 16989;
-- OLD name : 節慶營火管理者裝扮:矮人
-- Source : https://www.wowhead.com/wotlk/tw/npc=16990
UPDATE `creature_template_locale` SET `Name` = '節慶營火管理者裝扮：矮人' WHERE `locale` = 'zhTW' AND `entry` = 16990;
-- OLD name : 巫妖王傳令官
-- Source : https://www.wowhead.com/wotlk/tw/npc=16995
UPDATE `creature_template_locale` SET `Name` = '科爾蘇加德之口' WHERE `locale` = 'zhTW' AND `entry` = 16995;
-- OLD name : 強尼·麥克威醬, subname : 陣營測試機器人
-- Source : https://www.wowhead.com/wotlk/tw/npc=16999
UPDATE `creature_template_locale` SET `Name` = '強尼·麥克威索斯',`Title` = 'ic Test Realm Bot' WHERE `locale` = 'zhTW' AND `entry` = 16999;
-- OLD name : [Unused]地殼穿刺者視覺 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=17001
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17001;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/tw/npc=17005
UPDATE `creature_template_locale` SET `Title` = '武器大師' WHERE `locale` = 'zhTW' AND `entry` = 17005;
-- OLD name : 崔卡 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17010
UPDATE `creature_template_locale` SET `Name` = '德拉卡' WHERE `locale` = 'zhTW' AND `entry` = 17010;
-- OLD name : 奧格林·末日錘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17012
UPDATE `creature_template_locale` SET `Name` = '奧格林‧末日錘' WHERE `locale` = 'zhTW' AND `entry` = 17012;
-- OLD name : 達勒利斯·曦凝
-- Source : https://www.wowhead.com/wotlk/tw/npc=17015
UPDATE `creature_template_locale` SET `Name` = '達勒利斯·凝明' WHERE `locale` = 'zhTW' AND `entry` = 17015;
-- OLD name : 葛羅·地獄吼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17026
UPDATE `creature_template_locale` SET `Name` = '葛羅‧地獄吼' WHERE `locale` = 'zhTW' AND `entry` = 17026;
-- OLD name : 雷德·黑手 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17027
UPDATE `creature_template_locale` SET `Name` = '雷德‧黑手' WHERE `locale` = 'zhTW' AND `entry` = 17027;
-- OLD name : 麥彌·黑手 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17028
UPDATE `creature_template_locale` SET `Name` = '麥彌‧黑手' WHERE `locale` = 'zhTW' AND `entry` = 17028;
-- OLD name : 瓦爾·斷石者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17032
UPDATE `creature_template_locale` SET `Name` = '瓦爾·裂石者' WHERE `locale` = 'zhTW' AND `entry` = 17032;
-- OLD name : 暴風城節慶吐火者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17038
UPDATE `creature_template_locale` SET `Name` = '暴風城節慶噴火者' WHERE `locale` = 'zhTW' AND `entry` = 17038;
-- OLD name : 鐵爐堡節慶吐火者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17048
UPDATE `creature_template_locale` SET `Name` = '鐵爐堡節慶噴火者' WHERE `locale` = 'zhTW' AND `entry` = 17048;
-- OLD name : 達納蘇斯節慶吐火者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17049
UPDATE `creature_template_locale` SET `Name` = '達那蘇斯節慶噴火者' WHERE `locale` = 'zhTW' AND `entry` = 17049;
-- OLD name : 法力之潮圖騰 IV (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17061
UPDATE `creature_template_locale` SET `Name` = 'zzOLD法力之潮圖騰 IV' WHERE `locale` = 'zhTW' AND `entry` = 17061;
-- OLD name : 魔妾變形視覺 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17065
UPDATE `creature_template_locale` SET `Name` = '著魔情人變形視覺' WHERE `locale` = 'zhTW' AND `entry` = 17065;
-- OLD name : 密使戈莫克
-- Source : https://www.wowhead.com/wotlk/tw/npc=17072
UPDATE `creature_template_locale` SET `Name` = '密使·戈馬克' WHERE `locale` = 'zhTW' AND `entry` = 17072;
-- OLD name : 吉米·麥克威醬, subname : 很酷的人
-- Source : https://www.wowhead.com/wotlk/tw/npc=17078
UPDATE `creature_template_locale` SET `Name` = '吉米·麥克威',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 17078;
-- OLD name : 步槍兵托立克
-- Source : https://www.wowhead.com/wotlk/tw/npc=17082
UPDATE `creature_template_locale` SET `Name` = '火槍手托立克' WHERE `locale` = 'zhTW' AND `entry` = 17082;
-- OLD name : 諫言者幽曦
-- Source : https://www.wowhead.com/wotlk/tw/npc=17092
UPDATE `creature_template_locale` SET `Name` = '諫言者幽明' WHERE `locale` = 'zhTW' AND `entry` = 17092;
-- OLD name : 曦詠大使
-- Source : https://www.wowhead.com/wotlk/tw/npc=17098
UPDATE `creature_template_locale` SET `Name` = '黎歌者大使' WHERE `locale` = 'zhTW' AND `entry` = 17098;
-- OLD name : 梅拉爾·曦刃
-- Source : https://www.wowhead.com/wotlk/tw/npc=17099
UPDATE `creature_template_locale` SET `Name` = '瑪拉·曦刃' WHERE `locale` = 'zhTW' AND `entry` = 17099;
-- OLD subname : Mage Trainer
-- Source : https://www.wowhead.com/wotlk/tw/npc=17105
UPDATE `creature_template_locale` SET `Title` = '法師訓練師' WHERE `locale` = 'zhTW' AND `entry` = 17105;
-- OLD name : 瑟賽·幽詠
-- Source : https://www.wowhead.com/wotlk/tw/npc=17109
UPDATE `creature_template_locale` SET `Name` = '瑟賽·幽歌者' WHERE `locale` = 'zhTW' AND `entry` = 17109;
-- OLD name : 沃達
-- Source : https://www.wowhead.com/wotlk/tw/npc=17122
UPDATE `creature_template_locale` SET `Name` = '奧德' WHERE `locale` = 'zhTW' AND `entry` = 17122;
-- OLD name : 大地呼喚者瑞卡
-- Source : https://www.wowhead.com/wotlk/tw/npc=17123
UPDATE `creature_template_locale` SET `Name` = '大地呼喚者·瑞卡' WHERE `locale` = 'zhTW' AND `entry` = 17123;
-- OLD name : 戰槌劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17138
UPDATE `creature_template_locale` SET `Name` = '戰槌搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 17138;
-- OLD name : 湖中水靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=17153
UPDATE `creature_template_locale` SET `Name` = '湖中水之靈' WHERE `locale` = 'zhTW' AND `entry` = 17153;
-- OLD name : Wretched Magistrix Elosai (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17162
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 17162;
-- OLD name : 蟲目標 (DND)
-- Source : https://www.wowhead.com/wotlk/tw/npc=17163
UPDATE `creature_template_locale` SET `Name` = '蟲的目標(DND)' WHERE `locale` = 'zhTW' AND `entry` = 17163;
-- OLD name : 兇暴的梟獸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17188
UPDATE `creature_template_locale` SET `Name` = '凶暴的梟獸' WHERE `locale` = 'zhTW' AND `entry` = 17188;
-- OLD name : 根鬚陷捕者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17196
UPDATE `creature_template_locale` SET `Name` = '根鬚捕獸者' WHERE `locale` = 'zhTW' AND `entry` = 17196;
-- OLD name : 夜間潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17203
UPDATE `creature_template_locale` SET `Name` = '夜間潛伏者' WHERE `locale` = 'zhTW' AND `entry` = 17203;
-- OLD name : 隱士·法禔瑪, subname : 急救訓練師 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17214
UPDATE `creature_template_locale` SET `Name` = '隱士‧法禔瑪',`Title` = '繃帶訓練師' WHERE `locale` = 'zhTW' AND `entry` = 17214;
-- OLD name : 設計者戴洛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17222
UPDATE `creature_template_locale` SET `Name` = '工藝師戴洛' WHERE `locale` = 'zhTW' AND `entry` = 17222;
-- OLD name : 卡特斯·暗葉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17224
UPDATE `creature_template_locale` SET `Name` = '卡特斯‧暗葉' WHERE `locale` = 'zhTW' AND `entry` = 17224;
-- OLD name : 德萊尼技工 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17228
UPDATE `creature_template_locale` SET `Name` = '德萊尼工藝師' WHERE `locale` = 'zhTW' AND `entry` = 17228;
-- OLD name : 解碼者奧蘭
-- Source : https://www.wowhead.com/wotlk/tw/npc=17232
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 17232;
-- OLD name : [UNUSED]地殼穿刺者視覺 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=17234
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17234;
-- OLD name : [PH] 瘟疫之地傳令官 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=17239
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17239;
-- OLD name : 艦隊司令·奧迪席斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17240
UPDATE `creature_template_locale` SET `Name` = '艦隊司令‧奧迪席斯' WHERE `locale` = 'zhTW' AND `entry` = 17240;
-- OLD name : 女牧師凱玲·伊丹奈爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17241
UPDATE `creature_template_locale` SET `Name` = '女牧師凱玲‧伊丹奈爾' WHERE `locale` = 'zhTW' AND `entry` = 17241;
-- OLD name : 考古學家阿達曼·鐵心 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17242
UPDATE `creature_template_locale` SET `Name` = '考古學家阿達曼‧鐵心' WHERE `locale` = 'zhTW' AND `entry` = 17242;
-- OLD name : 藍卓·長射
-- Source : https://www.wowhead.com/wotlk/tw/npc=17249
UPDATE `creature_template_locale` SET `Name` = '藍卓‧長射' WHERE `locale` = 'zhTW' AND `entry` = 17249;
-- OLD name : 紫色巨魔裝束
-- Source : https://www.wowhead.com/wotlk/tw/npc=17258
UPDATE `creature_template_locale` SET `Name` = '紫色巨魔服裝' WHERE `locale` = 'zhTW' AND `entry` = 17258;
-- OLD name : 補給官費琳
-- Source : https://www.wowhead.com/wotlk/tw/npc=17277
UPDATE `creature_template_locale` SET `Name` = '物資供應者費琳' WHERE `locale` = 'zhTW' AND `entry` = 17277;
-- OLD subname : 廚師的鸚鵡 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17285
UPDATE `creature_template_locale` SET `Title` = '餅乾的鸚鵡' WHERE `locale` = 'zhTW' AND `entry` = 17285;
-- OLD name : 藍迪·嘯鏈
-- Source : https://www.wowhead.com/wotlk/tw/npc=17288
UPDATE `creature_template_locale` SET `Name` = '藍迪·威索洛克' WHERE `locale` = 'zhTW' AND `entry` = 17288;
-- OLD name : 步槍兵伯朗畢爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=17289
UPDATE `creature_template_locale` SET `Name` = '槍兵伯朗畢爾' WHERE `locale` = 'zhTW' AND `entry` = 17289;
-- OLD name : 奧麗娜隊長
-- Source : https://www.wowhead.com/wotlk/tw/npc=17290
UPDATE `creature_template_locale` SET `Name` = '隊長阿蓮娜' WHERE `locale` = 'zhTW' AND `entry` = 17290;
-- OLD name : 科洛格·傲鬃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17295
UPDATE `creature_template_locale` SET `Name` = '科洛格‧傲鬃' WHERE `locale` = 'zhTW' AND `entry` = 17295;
-- OLD name : 『無疤者』歐瑪爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=17308
UPDATE `creature_template_locale` SET `Name` = '無疤者歐瑪爾' WHERE `locale` = 'zhTW' AND `entry` = 17308;
-- OLD name : 樹瘤
-- Source : https://www.wowhead.com/wotlk/tw/npc=17310
UPDATE `creature_template_locale` SET `Name` = '格納' WHERE `locale` = 'zhTW' AND `entry` = 17310;
-- OLD name : Slim's Unkillable Test Dummy
-- Source : https://www.wowhead.com/wotlk/tw/npc=17313
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy Spammer' WHERE `locale` = 'zhTW' AND `entry` = 17313;
-- OLD name : 怒鱗咆嘯者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17333
UPDATE `creature_template_locale` SET `Name` = '怒鱗咆哮者' WHERE `locale` = 'zhTW' AND `entry` = 17333;
-- OLD name : 林地陸行幼鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=17372
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 17372;
-- OLD name : 林地陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=17373
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 17373;
-- OLD name : 大型林地陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=17374
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 17374;
-- OLD name : 造物者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17381
UPDATE `creature_template_locale` SET `Name` = '創造者' WHERE `locale` = 'zhTW' AND `entry` = 17381;
-- OLD name : 破碎之手殺戮者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17387
UPDATE `creature_template_locale` SET `Name` = '破碎之手屠戮者' WHERE `locale` = 'zhTW' AND `entry` = 17387;
-- OLD name : 初生的魔獄獸人
-- Source : https://www.wowhead.com/wotlk/tw/npc=17398
UPDATE `creature_template_locale` SET `Name` = '年幼的魔獄獸人' WHERE `locale` = 'zhTW' AND `entry` = 17398;
-- OLD name : 女魅魔
-- Source : https://www.wowhead.com/wotlk/tw/npc=17399
UPDATE `creature_template_locale` SET `Name` = '女媚魔' WHERE `locale` = 'zhTW' AND `entry` = 17399;
-- OLD name : 惡魔法力獵犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=17401
UPDATE `creature_template_locale` SET `Name` = '法力惡魔犬' WHERE `locale` = 'zhTW' AND `entry` = 17401;
-- OLD name : 克羅波·維茲班恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17421
UPDATE `creature_template_locale` SET `Name` = '克羅波‧維茲班恩' WHERE `locale` = 'zhTW' AND `entry` = 17421;
-- OLD name : 靜松年少者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17445
UPDATE `creature_template_locale` SET `Name` = '靜松之子' WHERE `locale` = 'zhTW' AND `entry` = 17445;
-- OLD name : 帕卡特·鋼毛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17446
UPDATE `creature_template_locale` SET `Name` = '帕卡特‧鋼毛' WHERE `locale` = 'zhTW' AND `entry` = 17446;
-- OLD name : [UNUSED] 影月起火者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=17463
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17463;
-- OLD name : 艾琳·凱利 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17487
UPDATE `creature_template_locale` SET `Name` = '艾琳‧凱利' WHERE `locale` = 'zhTW' AND `entry` = 17487;
-- OLD name : 羅根·丹尼爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17489
UPDATE `creature_template_locale` SET `Name` = '羅根‧丹尼爾' WHERE `locale` = 'zhTW' AND `entry` = 17489;
-- OLD name : 古魯曼·岩拳 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17506
UPDATE `creature_template_locale` SET `Name` = '古魯曼‧岩拳' WHERE `locale` = 'zhTW' AND `entry` = 17506;
-- OLD name : Samantha LeCraft (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17515
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17515;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (17515, 'zhTW','NPC',NULL);
-- OLD name : 地獄火哨衛, subname : 信使的哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=17517
UPDATE `creature_template_locale` SET `Name` = '地獄火哨兵',`Title` = '信使的哨兵' WHERE `locale` = 'zhTW' AND `entry` = 17517;
-- OLD name : 憤怒圖騰 I
-- Source : https://www.wowhead.com/wotlk/tw/npc=17539
UPDATE `creature_template_locale` SET `Name` = '憤怒圖騰' WHERE `locale` = 'zhTW' AND `entry` = 17539;
-- OLD name : 艾瑞克·馬婁爾夫測試人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17575
UPDATE `creature_template_locale` SET `Name` = '艾瑞克‧馬婁爾夫測試人' WHERE `locale` = 'zhTW' AND `entry` = 17575;
-- OLD name : 地獄火訓練假人
-- Source : https://www.wowhead.com/wotlk/tw/npc=17578
UPDATE `creature_template_locale` SET `Name` = '訓練假人' WHERE `locale` = 'zhTW' AND `entry` = 17578;
-- OLD name : [PH] 隊長奧伯爾斯二世 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=17597
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17597;
-- OLD name : 大酋長的傳送門
-- Source : https://www.wowhead.com/wotlk/tw/npc=17611
UPDATE `creature_template_locale` SET `Name` = '酋長的傳送門' WHERE `locale` = 'zhTW' AND `entry` = 17611;
-- OLD name : 女獵手凱拉·夜弓
-- Source : https://www.wowhead.com/wotlk/tw/npc=17614
UPDATE `creature_template_locale` SET `Name` = '女獵人凱拉·夜弓' WHERE `locale` = 'zhTW' AND `entry` = 17614;
-- OLD name : 魔獄部落護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=17621
UPDATE `creature_template_locale` SET `Name` = '希頓護衛' WHERE `locale` = 'zhTW' AND `entry` = 17621;
-- OLD name : 劫奪者護衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=17623
UPDATE `creature_template_locale` SET `Name` = '搶奪者護衛' WHERE `locale` = 'zhTW' AND `entry` = 17623;
-- OLD name : 拍賣師杰納斯, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/tw/npc=17627
UPDATE `creature_template_locale` SET `Name` = '杰納斯',`Title` = '拍賣師' WHERE `locale` = 'zhTW' AND `entry` = 17627;
-- OLD name : 拍賣師維娜, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/tw/npc=17628
UPDATE `creature_template_locale` SET `Name` = '維娜',`Title` = '拍賣師' WHERE `locale` = 'zhTW' AND `entry` = 17628;
-- OLD name : 拍賣師菲娜, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/tw/npc=17629
UPDATE `creature_template_locale` SET `Name` = '菲娜',`Title` = '拍賣師' WHERE `locale` = 'zhTW' AND `entry` = 17629;
-- OLD name : 旅店老闆喬薇雅, subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=17630
UPDATE `creature_template_locale` SET `Name` = '旅館老闆喬維亞',`Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 17630;
-- OLD subname : 工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=17634
UPDATE `creature_template_locale` SET `Title` = '大師級工程學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 17634;
-- OLD name : 麥客·戴沃, subname : 工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=17637
UPDATE `creature_template_locale` SET `Name` = '馬克·戴沃',`Title` = '大師級工程學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 17637;
-- OLD name : 煉獄火目標
-- Source : https://www.wowhead.com/wotlk/tw/npc=17644
UPDATE `creature_template_locale` SET `Name` = '地獄火目標' WHERE `locale` = 'zhTW' AND `entry` = 17644;
-- OLD name : 煉獄火接力
-- Source : https://www.wowhead.com/wotlk/tw/npc=17645
UPDATE `creature_template_locale` SET `Name` = '地獄火接力' WHERE `locale` = 'zhTW' AND `entry` = 17645;
-- OLD name : 尼德斯煉獄火
-- Source : https://www.wowhead.com/wotlk/tw/npc=17646
UPDATE `creature_template_locale` SET `Name` = '尼德斯地獄火' WHERE `locale` = 'zhTW' AND `entry` = 17646;
-- OLD name : 物流官烏賴克
-- Source : https://www.wowhead.com/wotlk/tw/npc=17657
UPDATE `creature_template_locale` SET `Name` = '物流幹部烏賴克' WHERE `locale` = 'zhTW' AND `entry` = 17657;
-- OLD name : 阿坎洛格斯獎勵標誌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17665
UPDATE `creature_template_locale` SET `Name` = '阿坎納苟斯獎勵標誌' WHERE `locale` = 'zhTW' AND `entry` = 17665;
-- OLD name : 曼那瑞·憎惡 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17679
UPDATE `creature_template_locale` SET `Name` = '曼那瑞‧憎惡' WHERE `locale` = 'zhTW' AND `entry` = 17679;
-- OLD name : 博學者阿斯塔樂·血誓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17718
UPDATE `creature_template_locale` SET `Name` = '博學者阿斯塔樂‧血誓' WHERE `locale` = 'zhTW' AND `entry` = 17718;
-- OLD name : 怒鰭部屬
-- Source : https://www.wowhead.com/wotlk/tw/npc=17726
UPDATE `creature_template_locale` SET `Name` = '怒鰭侍從' WHERE `locale` = 'zhTW' AND `entry` = 17726;
-- OLD name : 怒鰭哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=17727
UPDATE `creature_template_locale` SET `Name` = '怒鰭哨兵' WHERE `locale` = 'zhTW' AND `entry` = 17727;
-- OLD name : [UNUSED] Lykul Larva (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17733
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17733;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (17733, 'zhTW','NPC',NULL);
-- OLD name : 瑞齊·凜冬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17767
UPDATE `creature_template_locale` SET `Name` = '瑞齊‧凜冬' WHERE `locale` = 'zhTW' AND `entry` = 17767;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17772
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 17772;
-- OLD name : 機電師蒸汽操控者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17796
UPDATE `creature_template_locale` SET `Name` = '米克吉勒·蒸汽操控者' WHERE `locale` = 'zhTW' AND `entry` = 17796;
-- OLD name : 水占師希斯比亞
-- Source : https://www.wowhead.com/wotlk/tw/npc=17797
UPDATE `creature_template_locale` SET `Name` = '海法師希斯比亞' WHERE `locale` = 'zhTW' AND `entry` = 17797;
-- OLD name : 盤牙部屬
-- Source : https://www.wowhead.com/wotlk/tw/npc=17800
UPDATE `creature_template_locale` SET `Name` = '盤牙侍從' WHERE `locale` = 'zhTW' AND `entry` = 17800;
-- OLD name : [UNUSED] 迷失的哥布林 [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=17813
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17813;
-- OLD name : 羅德隆哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=17815
UPDATE `creature_template_locale` SET `Name` = '羅德隆哨兵' WHERE `locale` = 'zhTW' AND `entry` = 17815;
-- OLD name : 敦霍爾德哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=17819
UPDATE `creature_template_locale` SET `Name` = '敦霍爾德哨兵' WHERE `locale` = 'zhTW' AND `entry` = 17819;
-- OLD name : 敦霍爾德步槍兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=17820
UPDATE `creature_template_locale` SET `Name` = '敦霍爾德槍手' WHERE `locale` = 'zhTW' AND `entry` = 17820;
-- OLD name : 藍登·史帝威爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17822
UPDATE `creature_template_locale` SET `Name` = '藍登‧斯迪威爾' WHERE `locale` = 'zhTW' AND `entry` = 17822;
-- OLD name : [UNUSED]瘋狂的狼人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=17823
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17823;
-- OLD name : 敦霍爾德看守者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17833
UPDATE `creature_template_locale` SET `Name` = '敦霍爾德衛兵' WHERE `locale` = 'zhTW' AND `entry` = 17833;
-- OLD name : 時間裂隙
-- Source : https://www.wowhead.com/wotlk/tw/npc=17838
UPDATE `creature_template_locale` SET `Name` = '時間裂縫' WHERE `locale` = 'zhTW' AND `entry` = 17838;
-- OLD name : 裂隙領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=17839
UPDATE `creature_template_locale` SET `Name` = '裂縫領主' WHERE `locale` = 'zhTW' AND `entry` = 17839;
-- OLD name : 伊斯歐·風詠, subname : 遠征隊領袖
-- Source : https://www.wowhead.com/wotlk/tw/npc=17841
UPDATE `creature_template_locale` SET `Name` = '伊斯歐·風歌',`Title` = '遠征隊領導者' WHERE `locale` = 'zhTW' AND `entry` = 17841;
-- OLD name : 希利蘇斯火辣沙蟲迫擊砲目標
-- Source : https://www.wowhead.com/wotlk/tw/npc=17869
UPDATE `creature_template_locale` SET `Name` = '希利蘇斯火辣沙蟲迫擊炮目標' WHERE `locale` = 'zhTW' AND `entry` = 17869;
-- OLD name : 深幽泥沼跛行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17871
UPDATE `creature_template_locale` SET `Name` = '深幽泥沼搖晃者' WHERE `locale` = 'zhTW' AND `entry` = 17871;
-- OLD name : 黑色潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17882
UPDATE `creature_template_locale` SET `Name` = '黑色捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 17882;
-- OLD name : 縛地者瑞吉
-- Source : https://www.wowhead.com/wotlk/tw/npc=17885
UPDATE `creature_template_locale` SET `Name` = '大地束縛者瑞吉' WHERE `locale` = 'zhTW' AND `entry` = 17885;
-- OLD name : [DND]太陽之鷹傳送門控制器 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=17886
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17886;
-- OLD name : 喚風者裂爪
-- Source : https://www.wowhead.com/wotlk/tw/npc=17894
UPDATE `creature_template_locale` SET `Name` = '喚風者卡勞' WHERE `locale` = 'zhTW' AND `entry` = 17894;
-- OLD name : 維卡爾·海洛馬斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17914
UPDATE `creature_template_locale` SET `Name` = '維卡爾‧海洛馬斯' WHERE `locale` = 'zhTW' AND `entry` = 17914;
-- OLD name : [UNUSED] 盤牙哨兵 [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=17939
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 17939;
-- OLD name : 『背叛者』曼紐
-- Source : https://www.wowhead.com/wotlk/tw/npc=17941
UPDATE `creature_template_locale` SET `Name` = '背叛者曼紐' WHERE `locale` = 'zhTW' AND `entry` = 17941;
-- OLD name : 泰蘭妲·語風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17948
UPDATE `creature_template_locale` SET `Name` = '泰蘭妲‧語風' WHERE `locale` = 'zhTW' AND `entry` = 17948;
-- OLD name : 瑪法里恩·怒風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17949
UPDATE `creature_template_locale` SET `Name` = '瑪法里恩‧怒風' WHERE `locale` = 'zhTW' AND `entry` = 17949;
-- OLD name : 暗水鱷魚
-- Source : https://www.wowhead.com/wotlk/tw/npc=17952
UPDATE `creature_template_locale` SET `Name` = '黑水鱷魚' WHERE `locale` = 'zhTW' AND `entry` = 17952;
-- OLD name : 盤牙預卜者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17960
UPDATE `creature_template_locale` SET `Name` = '盤牙預言者' WHERE `locale` = 'zhTW' AND `entry` = 17960;
-- OLD name : 爆破兵勒茍索 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17982
UPDATE `creature_template_locale` SET `Name` = '爆破兵勒苟索' WHERE `locale` = 'zhTW' AND `entry` = 17982;
-- OLD name : 『爆裂者』洛克瑪
-- Source : https://www.wowhead.com/wotlk/tw/npc=17991
UPDATE `creature_template_locale` SET `Name` = '爆裂者洛克瑪' WHERE `locale` = 'zhTW' AND `entry` = 17991;
-- OLD name : 血守衛鷹獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=17994
UPDATE `creature_template_locale` SET `Name` = '血守衛獵鷹者' WHERE `locale` = 'zhTW' AND `entry` = 17994;
-- OLD name : 狼騎 (紅色，狼首) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=17997
UPDATE `creature_template_locale` SET `Name` = '狼坐騎 (紅色，狼首)' WHERE `locale` = 'zhTW' AND `entry` = 17997;
-- OLD name : 提摩西·丹尼爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=18019
UPDATE `creature_template_locale` SET `Name` = '提莫斯·丹尼爾' WHERE `locale` = 'zhTW' AND `entry` = 18019;
-- OLD name : 葛羅·地獄吼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18076
UPDATE `creature_template_locale` SET `Name` = '葛羅瑪許‧地獄吼' WHERE `locale` = 'zhTW' AND `entry` = 18076;
-- OLD name : 主母吉雅
-- Source : https://www.wowhead.com/wotlk/tw/npc=18141
UPDATE `creature_template_locale` SET `Name` = '祖母吉雅' WHERE `locale` = 'zhTW' AND `entry` = 18141;
-- OLD name : 外域希樊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18149
UPDATE `creature_template_locale` SET `Name` = '外域希娃女妖' WHERE `locale` = 'zhTW' AND `entry` = 18149;
-- OLD name : 古羅克事件控制器
-- Source : https://www.wowhead.com/wotlk/tw/npc=18196
UPDATE `creature_template_locale` SET `Name` = '古羅克事件控制者' WHERE `locale` = 'zhTW' AND `entry` = 18196;
-- OLD name : 薩杜·費茲·遠行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18200
UPDATE `creature_template_locale` SET `Name` = '薩杜費茲遠行者' WHERE `locale` = 'zhTW' AND `entry` = 18200;
-- OLD name : 哈洛德·蘭恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=18218
UPDATE `creature_template_locale` SET `Name` = '哈爾歐德·蘭恩' WHERE `locale` = 'zhTW' AND `entry` = 18218;
-- OLD name : 卡拉達爾事件控制器(先知)
-- Source : https://www.wowhead.com/wotlk/tw/npc=18228
UPDATE `creature_template_locale` SET `Name` = '卡拉達爾事件控制者(先知)' WHERE `locale` = 'zhTW' AND `entry` = 18228;
-- OLD name : 小薩魯法爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=18229
UPDATE `creature_template_locale` SET `Name` = '年輕的薩魯法爾' WHERE `locale` = 'zhTW' AND `entry` = 18229;
-- OLD name : 學徒達瑞亞斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=18255
UPDATE `creature_template_locale` SET `Name` = '學徒達瑞爾斯' WHERE `locale` = 'zhTW' AND `entry` = 18255;
-- OLD name : 布萊恩·伯明汗 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18287
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧伯明汗' WHERE `locale` = 'zhTW' AND `entry` = 18287;
-- OLD name : 燃刃柴堆 (01)
-- Source : https://www.wowhead.com/wotlk/tw/npc=18305
UPDATE `creature_template_locale` SET `Name` = '火刃柴堆 (01)' WHERE `locale` = 'zhTW' AND `entry` = 18305;
-- OLD name : 燃刃柴堆 (02)
-- Source : https://www.wowhead.com/wotlk/tw/npc=18306
UPDATE `creature_template_locale` SET `Name` = '火刃柴堆 (02)' WHERE `locale` = 'zhTW' AND `entry` = 18306;
-- OLD name : 燃刃柴堆 (03)
-- Source : https://www.wowhead.com/wotlk/tw/npc=18307
UPDATE `creature_template_locale` SET `Name` = '火刃柴堆 (03)' WHERE `locale` = 'zhTW' AND `entry` = 18307;
-- OLD name : 燃刃柴堆 (04)
-- Source : https://www.wowhead.com/wotlk/tw/npc=18308
UPDATE `creature_template_locale` SET `Name` = '火刃柴堆 (04)' WHERE `locale` = 'zhTW' AND `entry` = 18308;
-- OLD name : 以太拾荒者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18309
UPDATE `creature_template_locale` SET `Name` = '伊斯利拾荒者' WHERE `locale` = 'zhTW' AND `entry` = 18309;
-- OLD name : 以太盜墓者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18311
UPDATE `creature_template_locale` SET `Name` = '伊斯利盜墓者' WHERE `locale` = 'zhTW' AND `entry` = 18311;
-- OLD name : 以太縛法者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18312
UPDATE `creature_template_locale` SET `Name` = '伊斯利縛法者' WHERE `locale` = 'zhTW' AND `entry` = 18312;
-- OLD name : 以太巫士
-- Source : https://www.wowhead.com/wotlk/tw/npc=18313
UPDATE `creature_template_locale` SET `Name` = '伊斯利巫士' WHERE `locale` = 'zhTW' AND `entry` = 18313;
-- OLD name : 奈薩斯潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18314
UPDATE `creature_template_locale` SET `Name` = '奈薩斯捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 18314;
-- OLD name : 以太巫者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18315
UPDATE `creature_template_locale` SET `Name` = '伊斯利巫者' WHERE `locale` = 'zhTW' AND `entry` = 18315;
-- OLD name : 以太牧師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18317
UPDATE `creature_template_locale` SET `Name` = '伊斯利牧師' WHERE `locale` = 'zhTW' AND `entry` = 18317;
-- OLD name : [UNUSED]塞司克法師領主 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=18329
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 18329;
-- OLD name : 以太黑暗法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18331
UPDATE `creature_template_locale` SET `Name` = '伊斯利黑暗法師' WHERE `locale` = 'zhTW' AND `entry` = 18331;
-- OLD name : 騎乘用雙足翼龍 (納葛蘭PvP事件) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18345
UPDATE `creature_template_locale` SET `Name` = '騎乘用蠍尾獅 (納葛蘭PvP事件)' WHERE `locale` = 'zhTW' AND `entry` = 18345;
-- OLD name : 拍賣師范尼, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/tw/npc=18348
UPDATE `creature_template_locale` SET `Name` = '范尼',`Title` = '拍賣師' WHERE `locale` = 'zhTW' AND `entry` = 18348;
-- OLD name : 拍賣師艾瑞紗, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/tw/npc=18349
UPDATE `creature_template_locale` SET `Name` = '艾瑞紗',`Title` = '拍賣師' WHERE `locale` = 'zhTW' AND `entry` = 18349;
-- OLD name : 女獵手班吐克
-- Source : https://www.wowhead.com/wotlk/tw/npc=18353
UPDATE `creature_template_locale` SET `Name` = '女獵人班吐克' WHERE `locale` = 'zhTW' AND `entry` = 18353;
-- OLD name : [UNUSED]滿是灰塵的骷髏[PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=18355
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 18355;
-- OLD name : 黃褐色雙足飛龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18363
UPDATE `creature_template_locale` SET `Name` = '黃褐色蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 18363;
-- OLD name : 藍色雙足飛龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18364
UPDATE `creature_template_locale` SET `Name` = '藍色蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 18364;
-- OLD name : 綠色雙足飛龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18365
UPDATE `creature_template_locale` SET `Name` = '綠色蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 18365;
-- OLD name : UNUSED Outland Wyvern Mount (Armored) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18366
UPDATE `creature_template_locale` SET `Name` = '測試符印' WHERE `locale` = 'zhTW' AND `entry` = 18366;
-- OLD name : [UNUSED] 德萊尼靈魂 [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=18367
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 18367;
-- OLD name : 迅捷紅色雙足飛龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18377
UPDATE `creature_template_locale` SET `Name` = '迅捷紅色蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 18377;
-- OLD name : 迅捷綠色雙足飛龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18378
UPDATE `creature_template_locale` SET `Name` = '迅捷綠色蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 18378;
-- OLD name : 迅捷紫色雙足飛龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18379
UPDATE `creature_template_locale` SET `Name` = '迅捷紫色蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 18379;
-- OLD name : 迅捷黃色雙足飛龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18380
UPDATE `creature_template_locale` SET `Name` = '迅捷黃色蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 18380;
-- OLD name : 瑞蔻莉雅
-- Source : https://www.wowhead.com/wotlk/tw/npc=18385
UPDATE `creature_template_locale` SET `Name` = '瑞克利亞' WHERE `locale` = 'zhTW' AND `entry` = 18385;
-- OLD name : 以太怨靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=18394
UPDATE `creature_template_locale` SET `Name` = '伊斯利怨靈' WHERE `locale` = 'zhTW' AND `entry` = 18394;
-- OLD name : 颶風
-- Source : https://www.wowhead.com/wotlk/tw/npc=18412
UPDATE `creature_template_locale` SET `Name` = '龍卷風 (The Crone)' WHERE `locale` = 'zhTW' AND `entry` = 18412;
-- OLD name : 女獵手奇瑪
-- Source : https://www.wowhead.com/wotlk/tw/npc=18416
UPDATE `creature_template_locale` SET `Name` = '女獵人奇瑪' WHERE `locale` = 'zhTW' AND `entry` = 18416;
-- OLD name : 以太學徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=18430
UPDATE `creature_template_locale` SET `Name` = '伊斯利學徒' WHERE `locale` = 'zhTW' AND `entry` = 18430;
-- OLD name : 以太信標
-- Source : https://www.wowhead.com/wotlk/tw/npc=18431
UPDATE `creature_template_locale` SET `Name` = '伊斯利信標' WHERE `locale` = 'zhTW' AND `entry` = 18431;
-- OLD name : 柯爾奇事件控制器
-- Source : https://www.wowhead.com/wotlk/tw/npc=18444
UPDATE `creature_template_locale` SET `Name` = '柯爾奇事件控制者' WHERE `locale` = 'zhTW' AND `entry` = 18444;
-- OLD name : 縛地者塔伏格蘭
-- Source : https://www.wowhead.com/wotlk/tw/npc=18446
UPDATE `creature_template_locale` SET `Name` = '大地束縛者塔伏格蘭' WHERE `locale` = 'zhTW' AND `entry` = 18446;
-- OLD name : 扭曲巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18464
UPDATE `creature_template_locale` SET `Name` = '扭曲行者' WHERE `locale` = 'zhTW' AND `entry` = 18464;
-- OLD name : 暗織者希斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=18472
UPDATE `creature_template_locale` SET `Name` = '暗法師希斯' WHERE `locale` = 'zhTW' AND `entry` = 18472;
-- OLD name : 不死的潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18501
UPDATE `creature_template_locale` SET `Name` = '不死的捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 18501;
-- OLD name : 奧多爾瓦匠 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18552
UPDATE `creature_template_locale` SET `Name` = '奧多爾石匠' WHERE `locale` = 'zhTW' AND `entry` = 18552;
-- OLD name : 黑暗之門黑色水晶隱形巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18553
UPDATE `creature_template_locale` SET `Name` = '黑暗之門黑色水晶隱形行者' WHERE `locale` = 'zhTW' AND `entry` = 18553;
-- OLD name : 黑暗之門光束隱形巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18555
UPDATE `creature_template_locale` SET `Name` = '黑暗之門光束隱形行者' WHERE `locale` = 'zhTW' AND `entry` = 18555;
-- OLD name : 相位巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18559
UPDATE `creature_template_locale` SET `Name` = '相位行者' WHERE `locale` = 'zhTW' AND `entry` = 18559;
-- OLD name : 鞭棘者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18587
UPDATE `creature_template_locale` SET `Name` = '爭吵者' WHERE `locale` = 'zhTW' AND `entry` = 18587;
-- OLD name : 占卜者保持者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18593
UPDATE `creature_template_locale` SET `Name` = '占卜者侍從' WHERE `locale` = 'zhTW' AND `entry` = 18593;
-- OLD subname : 舞台管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18643
UPDATE `creature_template_locale` SET `Title` = '舞台經理' WHERE `locale` = 'zhTW' AND `entry` = 18643;
-- OLD name : 塔倫米爾農民
-- Source : https://www.wowhead.com/wotlk/tw/npc=18644
UPDATE `creature_template_locale` SET `Name` = '塔倫米爾農夫' WHERE `locale` = 'zhTW' AND `entry` = 18644;
-- OLD name : 『煽動者』黑心
-- Source : https://www.wowhead.com/wotlk/tw/npc=18667
UPDATE `creature_template_locale` SET `Name` = '煽動者黑心' WHERE `locale` = 'zhTW' AND `entry` = 18667;
-- OLD name : 湯瑪斯·楊斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=18672
UPDATE `creature_template_locale` SET `Name` = '湯瑪斯·陽斯' WHERE `locale` = 'zhTW' AND `entry` = 18672;
-- OLD name : [UNUSED]隱士麗蒂娜 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18674
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge A' WHERE `locale` = 'zhTW' AND `entry` = 18674;
-- OLD name : 族母卡修爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=18687
UPDATE `creature_template_locale` SET `Name` = '卡修爾母親' WHERE `locale` = 'zhTW' AND `entry` = 18687;
-- OLD name : 再活化的骸骨
-- Source : https://www.wowhead.com/wotlk/tw/npc=18700
UPDATE `creature_template_locale` SET `Name` = '重組的骸骨' WHERE `locale` = 'zhTW' AND `entry` = 18700;
-- OLD name : 噬骨狼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=18706
UPDATE `creature_template_locale` SET `Name` = '噬骨座狼' WHERE `locale` = 'zhTW' AND `entry` = 18706;
-- OLD name : 幽暗的苦力
-- Source : https://www.wowhead.com/wotlk/tw/npc=18717
UPDATE `creature_template_locale` SET `Name` = '幽暗的工人' WHERE `locale` = 'zhTW' AND `entry` = 18717;
-- OLD name : 麻瘋地精苦力
-- Source : https://www.wowhead.com/wotlk/tw/npc=18722
UPDATE `creature_template_locale` SET `Name` = '麻瘋地精工人' WHERE `locale` = 'zhTW' AND `entry` = 18722;
-- OLD name : 煉獄火雨 (地獄火)
-- Source : https://www.wowhead.com/wotlk/tw/npc=18729
UPDATE `creature_template_locale` SET `Name` = '地獄火雨 (地獄火)' WHERE `locale` = 'zhTW' AND `entry` = 18729;
-- OLD name : 宗師瓦皮歐
-- Source : https://www.wowhead.com/wotlk/tw/npc=18732
UPDATE `creature_template_locale` SET `Name` = '領導者瓦皮歐' WHERE `locale` = 'zhTW' AND `entry` = 18732;
-- OLD name : 惡魔劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18733
UPDATE `creature_template_locale` SET `Name` = '惡魔搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 18733;
-- OLD subname : 採礦訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18747
UPDATE `creature_template_locale` SET `Title` = '大師級採礦訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18747;
-- OLD subname : 草藥學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18748
UPDATE `creature_template_locale` SET `Title` = '大師級草藥學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18748;
-- OLD subname : 裁縫訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18749
UPDATE `creature_template_locale` SET `Title` = '大師級裁縫訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18749;
-- OLD subname : 珠寶設計訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18751
UPDATE `creature_template_locale` SET `Title` = '大師級珠寶設計訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18751;
-- OLD subname : 工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18752
UPDATE `creature_template_locale` SET `Title` = '大師級工程學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18752;
-- OLD subname : 附魔訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18753
UPDATE `creature_template_locale` SET `Title` = '大師級附魔訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18753;
-- OLD name : 巴瑞姆·裂蹄, subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18754
UPDATE `creature_template_locale` SET `Name` = '巴爾林·裂蹄',`Title` = '大師級製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18754;
-- OLD subname : 剝皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18755
UPDATE `creature_template_locale` SET `Title` = '大師級剝皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18755;
-- OLD name : 希莉絲·芭爾頓
-- Source : https://www.wowhead.com/wotlk/tw/npc=18756
UPDATE `creature_template_locale` SET `Name` = '哈瑞斯·皮爾頓' WHERE `locale` = 'zhTW' AND `entry` = 18756;
-- OLD name : 拍賣師達瑞司, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/tw/npc=18761
UPDATE `creature_template_locale` SET `Name` = '達瑞司',`Title` = '拍賣師' WHERE `locale` = 'zhTW' AND `entry` = 18761;
-- OLD subname : 哈里斯·皮爾頓的寵物
-- Source : https://www.wowhead.com/wotlk/tw/npc=18762
UPDATE `creature_template_locale` SET `Title` = '哈瑞斯·皮爾頓的寵物' WHERE `locale` = 'zhTW' AND `entry` = 18762;
-- OLD subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18771
UPDATE `creature_template_locale` SET `Title` = '大師級製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18771;
-- OLD subname : 裁縫訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18772
UPDATE `creature_template_locale` SET `Title` = '大師級裁縫訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18772;
-- OLD name : 喬漢·巴奈斯, subname : 附魔訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18773
UPDATE `creature_template_locale` SET `Name` = '裘汗·巴奈斯',`Title` = '大師級附魔訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18773;
-- OLD subname : 珠寶設計訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18774
UPDATE `creature_template_locale` SET `Title` = '大師級珠寶設計訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18774;
-- OLD subname : 工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18775
UPDATE `creature_template_locale` SET `Title` = '大師級工程學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18775;
-- OLD subname : 草藥學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18776
UPDATE `creature_template_locale` SET `Title` = '大師級草藥學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18776;
-- OLD subname : 剝皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18777
UPDATE `creature_template_locale` SET `Title` = '大師級剝皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18777;
-- OLD subname : 採礦訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18779
UPDATE `creature_template_locale` SET `Title` = '大師級採礦訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18779;
-- OLD name : 受折磨的骷髏
-- Source : https://www.wowhead.com/wotlk/tw/npc=18797
UPDATE `creature_template_locale` SET `Name` = '被折磨的骷髏' WHERE `locale` = 'zhTW' AND `entry` = 18797;
-- OLD subname : 鍊金術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18802
UPDATE `creature_template_locale` SET `Title` = '大師級鍊金術訓練師' WHERE `locale` = 'zhTW' AND `entry` = 18802;
-- OLD name : 艾克索達隱形巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18814
UPDATE `creature_template_locale` SET `Name` = '艾克索達隱形行者' WHERE `locale` = 'zhTW' AND `entry` = 18814;
-- OLD name : 隱形部落攻城機具 - 東
-- Source : https://www.wowhead.com/wotlk/tw/npc=18818
UPDATE `creature_template_locale` SET `Name` = '隱形部落攻城坦克 - 東' WHERE `locale` = 'zhTW' AND `entry` = 18818;
-- OLD name : 野生惡魔潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18847
UPDATE `creature_template_locale` SET `Name` = '野生惡魔捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 18847;
-- OLD name : 隱形聯盟攻城機具 - 東
-- Source : https://www.wowhead.com/wotlk/tw/npc=18849
UPDATE `creature_template_locale` SET `Name` = '隱形聯盟攻城坦克 - 東' WHERE `locale` = 'zhTW' AND `entry` = 18849;
-- OLD name : 碎裂的奔行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18881
UPDATE `creature_template_locale` SET `Name` = '破碎的奔行者' WHERE `locale` = 'zhTW' AND `entry` = 18881;
-- OLD name : 碎裂的雷鳴者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18882
UPDATE `creature_template_locale` SET `Name` = '破碎的雷鳴者' WHERE `locale` = 'zhTW' AND `entry` = 18882;
-- OLD name : 間諜吐剛
-- Source : https://www.wowhead.com/wotlk/tw/npc=18891
UPDATE `creature_template_locale` SET `Name` = '間諜·吐剛' WHERE `locale` = 'zhTW' AND `entry` = 18891;
-- OLD subname : 釣魚訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18911
UPDATE `creature_template_locale` SET `Title` = '釣魚供應商' WHERE `locale` = 'zhTW' AND `entry` = 18911;
-- OLD name : 設計者崔尼
-- Source : https://www.wowhead.com/wotlk/tw/npc=18921
UPDATE `creature_template_locale` SET `Name` = '設計者·崔尼' WHERE `locale` = 'zhTW' AND `entry` = 18921;
-- OLD name : 設計者安崔恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=18924
UPDATE `creature_template_locale` SET `Name` = '設計者·安崔恩' WHERE `locale` = 'zhTW' AND `entry` = 18924;
-- OLD name : 司雷因
-- Source : https://www.wowhead.com/wotlk/tw/npc=18926
UPDATE `creature_template_locale` SET `Name` = '史磊英' WHERE `locale` = 'zhTW' AND `entry` = 18926;
-- OLD name : [PH] 八卦 NPC, 人類 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=18935
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 18935;
-- OLD name : [PH] 八卦 NPC, 人類 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=18936
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 18936;
-- OLD name : 布魯貝克·風暴腳
-- Source : https://www.wowhead.com/wotlk/tw/npc=18939
UPDATE `creature_template_locale` SET `Name` = '布魯貝克·暴風腳' WHERE `locale` = 'zhTW' AND `entry` = 18939;
-- OLD name : [PH] 八卦 NPC, 人類, 特定造型 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=18941
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 18941;
-- OLD name : 煉獄火突圍者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18946
UPDATE `creature_template_locale` SET `Name` = '地獄火突圍者' WHERE `locale` = 'zhTW' AND `entry` = 18946;
-- OLD name : 暴風城士兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=18948
UPDATE `creature_template_locale` SET `Name` = '暴風士兵' WHERE `locale` = 'zhTW' AND `entry` = 18948;
-- OLD name : 暴風城法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18949
UPDATE `creature_template_locale` SET `Name` = '暴風法師' WHERE `locale` = 'zhTW' AND `entry` = 18949;
-- OLD name : 奧格瑪蠻兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=18950
UPDATE `creature_template_locale` SET `Name` = '奧格瑪守衛' WHERE `locale` = 'zhTW' AND `entry` = 18950;
-- OLD name : 雌性風翼獵鷹 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18963
UPDATE `creature_template_locale` SET `Name` = '母風翼貓頭獵鷹' WHERE `locale` = 'zhTW' AND `entry` = 18963;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18987
UPDATE `creature_template_locale` SET `Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 18987;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18988
UPDATE `creature_template_locale` SET `Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 18988;
-- OLD subname : 急救訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18990
UPDATE `creature_template_locale` SET `Title` = '醫療者' WHERE `locale` = 'zhTW' AND `entry` = 18990;
-- OLD subname : 急救訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=18991
UPDATE `creature_template_locale` SET `Title` = '醫療者' WHERE `locale` = 'zhTW' AND `entry` = 18991;
-- OLD subname : 烹飪訓練師和供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=18993
UPDATE `creature_template_locale` SET `Title` = '烹飪供應商' WHERE `locale` = 'zhTW' AND `entry` = 18993;
-- OLD name : 恆龍鎮壓者
-- Source : https://www.wowhead.com/wotlk/tw/npc=18995
UPDATE `creature_template_locale` SET `Name` = '恆龍毀滅者' WHERE `locale` = 'zhTW' AND `entry` = 18995;
-- OLD name : 風翼獵鷹 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=18996
UPDATE `creature_template_locale` SET `Name` = '風翼貓頭獵鷹' WHERE `locale` = 'zhTW' AND `entry` = 18996;
-- OLD name : 隱形聯盟攻城機具 - 西
-- Source : https://www.wowhead.com/wotlk/tw/npc=19008
UPDATE `creature_template_locale` SET `Name` = '隱形聯盟攻城坦克 - 西' WHERE `locale` = 'zhTW' AND `entry` = 19008;
-- OLD name : 隱形部落攻城機具 - 西
-- Source : https://www.wowhead.com/wotlk/tw/npc=19009
UPDATE `creature_template_locale` SET `Name` = '隱形部落攻城坦克 - 西' WHERE `locale` = 'zhTW' AND `entry` = 19009;
-- OLD name : 妮可·巴特勒
-- Source : https://www.wowhead.com/wotlk/tw/npc=19033
UPDATE `creature_template_locale` SET `Name` = '妮可·巴勒特' WHERE `locale` = 'zhTW' AND `entry` = 19033;
-- OLD name : 物資官米歐斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=19038
UPDATE `creature_template_locale` SET `Name` = '物資商人米歐斯' WHERE `locale` = 'zhTW' AND `entry` = 19038;
-- OLD subname : 鍊金術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19052
UPDATE `creature_template_locale` SET `Title` = '大師級鍊金術訓練師' WHERE `locale` = 'zhTW' AND `entry` = 19052;
-- OLD name : [PH] 八卦 NPC, 人類 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19057
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19057;
-- OLD name : [PH] 八卦 NPC, 人類 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19058
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19058;
-- OLD name : [PH] 八卦 NPC, 人類 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19059
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19059;
-- OLD name : [PH] 八卦 NPC, 人類 男性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19060
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19060;
-- OLD subname : 珠寶設計訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19063
UPDATE `creature_template_locale` SET `Title` = '大師級珠寶設計訓練師' WHERE `locale` = 'zhTW' AND `entry` = 19063;
-- OLD name : 卡拉達爾狼騎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19069
UPDATE `creature_template_locale` SET `Name` = '卡拉達爾狼坐騎' WHERE `locale` = 'zhTW' AND `entry` = 19069;
-- OLD name : [PH] 八卦 NPC, 矮人 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19078
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19078;
-- OLD name : [PH] 八卦 NPC, 矮人 男性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19079
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19079;
-- OLD name : [PH] 八卦 NPC, 夜精靈 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19080
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19080;
-- OLD name : [PH] 八卦 NPC, 夜精靈 男性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19081
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19081;
-- OLD name : [PH] 八卦 NPC, 德萊尼 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19082
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19082;
-- OLD name : [PH] 八卦 NPC, 德萊尼 男性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19083
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19083;
-- OLD name : [PH] 八卦 NPC, 血精靈 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19084
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19084;
-- OLD name : [PH] 八卦 NPC, 血精靈 男性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19085
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19085;
-- OLD name : [PH] 八卦 NPC, 獸人 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19086
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19086;
-- OLD name : [PH] 八卦 NPC, 獸人 男性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19087
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19087;
-- OLD name : [PH] 八卦 NPC, 牛頭人 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19088
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19088;
-- OLD name : [PH] 八卦 NPC, 牛頭人 男性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19089
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19089;
-- OLD name : [PH] 八卦 NPC, 遺忘者 男性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19090
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19090;
-- OLD name : [PH] 八卦 NPC, 遺忘者 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19091
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19091;
-- OLD name : [PH] 八卦 NPC, 矮人 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19092
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19092;
-- OLD name : [PH] 八卦 NPC, 夜精靈 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19093
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19093;
-- OLD name : [PH] 八卦 NPC, 德萊尼 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19094
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19094;
-- OLD name : [PH] 八卦 NPC, 血精靈 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19095
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19095;
-- OLD name : [PH] 八卦 NPC, 獸人 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19096
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19096;
-- OLD name : [PH] 八卦 NPC, 牛頭人 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19097
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19097;
-- OLD name : [PH] 八卦 NPC, 遺忘者 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19098
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19098;
-- OLD name : [PH] 八卦 NPC, 血精靈 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19099
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19099;
-- OLD name : [PH] 八卦 NPC, 德萊尼 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19100
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19100;
-- OLD name : [PH] 八卦 NPC, 矮人 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19101
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19101;
-- OLD name : [PH] 八卦 NPC, 夜精靈 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19102
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19102;
-- OLD name : [PH] 八卦 NPC, 獸人 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19103
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19103;
-- OLD name : [PH] 八卦 NPC, 牛頭人 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19104
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19104;
-- OLD name : [PH] 八卦 NPC, 遺忘者 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19105
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19105;
-- OLD name : [PH] 八卦 NPC, 血精靈 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19106
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19106;
-- OLD name : [PH] 八卦 NPC, 德萊尼 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19107
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19107;
-- OLD name : [PH] 八卦 NPC, 矮人 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19108
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19108;
-- OLD name : [PH] 八卦 NPC, 獸人 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19109
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19109;
-- OLD name : [PH] 八卦 NPC, 遺忘者 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19110
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19110;
-- OLD name : [PH] 八卦 NPC, 牛頭人 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19111
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19111;
-- OLD name : [PH] 八卦 NPC, 夜精靈 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19112
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19112;
-- OLD name : [PH] 八卦 NPC, 血精靈 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19113
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19113;
-- OLD name : [PH] 八卦 NPC, 德萊尼 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19114
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19114;
-- OLD name : [PH] 八卦 NPC, 矮人 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19115
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19115;
-- OLD name : [PH] 八卦 NPC, 夜精靈 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19116
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19116;
-- OLD name : [PH] 八卦 NPC, 獸人 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19117
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19117;
-- OLD name : [PH] 八卦 NPC, 牛頭人 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19118
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19118;
-- OLD name : [PH] 八卦 NPC, 遺忘者 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19119
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19119;
-- OLD name : [PH] 八卦 NPC, 地精 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19121
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19121;
-- OLD name : [PH] 八卦 NPC, 地精 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19122
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19122;
-- OLD name : [PH] 八卦 NPC, 食人妖 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19123
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19123;
-- OLD name : [PH] 八卦 NPC, 食人妖 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19124
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19124;
-- OLD name : [PH] 八卦 NPC, 地精 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19125
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19125;
-- OLD name : [PH] 八卦 NPC, 地精 男性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19126
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19126;
-- OLD name : [PH] 八卦 NPC, 食人妖 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19127
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19127;
-- OLD name : [PH] 八卦 NPC, 食人妖 男性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19128
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 19128;
-- OLD name : [PH] 八卦 NPC, 地精 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19129
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19129;
-- OLD name : [PH] 八卦 NPC, 食人妖 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19130
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19130;
-- OLD name : [PH] 八卦 NPC, 地精 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19131
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19131;
-- OLD name : [PH] 八卦 NPC, 食人妖 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19132
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19132;
-- OLD subname : 奈辛瓦里狩旅團
-- Source : https://www.wowhead.com/wotlk/tw/npc=19133
UPDATE `creature_template_locale` SET `Title` = '奈辛瓦里狩獵隊' WHERE `locale` = 'zhTW' AND `entry` = 19133;
-- OLD name : 喚焰者小鬼
-- Source : https://www.wowhead.com/wotlk/tw/npc=19136
UPDATE `creature_template_locale` SET `Name` = '烈焰行者小鬼' WHERE `locale` = 'zhTW' AND `entry` = 19136;
-- OLD subname : 奈辛瓦里狩旅團
-- Source : https://www.wowhead.com/wotlk/tw/npc=19137
UPDATE `creature_template_locale` SET `Title` = '奈辛瓦里狩獵隊' WHERE `locale` = 'zhTW' AND `entry` = 19137;
-- OLD name : 艾蘭里農民
-- Source : https://www.wowhead.com/wotlk/tw/npc=19147
UPDATE `creature_template_locale` SET `Name` = '艾蘭里農夫' WHERE `locale` = 'zhTW' AND `entry` = 19147;
-- OLD name : 審問者卡恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=19152
UPDATE `creature_template_locale` SET `Name` = '質問者卡恩' WHERE `locale` = 'zhTW' AND `entry` = 19152;
-- OLD name : 孢子人難民
-- Source : https://www.wowhead.com/wotlk/tw/npc=19155
UPDATE `creature_template_locale` SET `Name` = '孢子難民' WHERE `locale` = 'zhTW' AND `entry` = 19155;
-- OLD name : 艾蘭里農民裝飾
-- Source : https://www.wowhead.com/wotlk/tw/npc=19159
UPDATE `creature_template_locale` SET `Name` = '艾蘭里農夫裝飾' WHERE `locale` = 'zhTW' AND `entry` = 19159;
-- OLD name : 憤怒守衛防衛者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19160
UPDATE `creature_template_locale` SET `Name` = '不懈看守者' WHERE `locale` = 'zhTW' AND `entry` = 19160;
-- OLD subname : 剝皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19180
UPDATE `creature_template_locale` SET `Title` = '大師級剝皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 19180;
-- OLD name : 米歐瑞德·伏萊齊, subname : 急救訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19184
UPDATE `creature_template_locale` SET `Name` = '麥歐瑞德·伏萊齊',`Title` = '醫師' WHERE `locale` = 'zhTW' AND `entry` = 19184;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19185
UPDATE `creature_template_locale` SET `Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 19185;
-- OLD name : 達瑪莉, subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19187
UPDATE `creature_template_locale` SET `Name` = '達瑪力',`Title` = '大師級製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 19187;
-- OLD name : 羽牙誘捕者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19189
UPDATE `creature_template_locale` SET `Name` = '羽牙掠過者' WHERE `locale` = 'zhTW' AND `entry` = 19189;
-- OLD name : 煉獄火接力 (地獄火)
-- Source : https://www.wowhead.com/wotlk/tw/npc=19215
UPDATE `creature_template_locale` SET `Name` = '地獄火接力 (地獄火)' WHERE `locale` = 'zhTW' AND `entry` = 19215;
-- OLD subname : 祈倫托學徒
-- Source : https://www.wowhead.com/wotlk/tw/npc=19217
UPDATE `creature_template_locale` SET `Title` = '肯瑞托學徒' WHERE `locale` = 'zhTW' AND `entry` = 19217;
-- OLD name : 機械領主卡帕希特斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=19219
UPDATE `creature_template_locale` SET `Name` = '機械王卡帕希特斯' WHERE `locale` = 'zhTW' AND `entry` = 19219;
-- OLD name : 岩漿奔流圖騰
-- Source : https://www.wowhead.com/wotlk/tw/npc=19222
UPDATE `creature_template_locale` SET `Name` = '漂浮熔岩圖騰' WHERE `locale` = 'zhTW' AND `entry` = 19222;
-- OLD name : 派瑞·卡特勒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19228
UPDATE `creature_template_locale` SET `Name` = '派瑞‧卡特勒' WHERE `locale` = 'zhTW' AND `entry` = 19228;
-- OLD name : 奴歐拉·喚曦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19247
UPDATE `creature_template_locale` SET `Name` = '奴歐拉‧喚曦' WHERE `locale` = 'zhTW' AND `entry` = 19247;
-- OLD subname : 附魔訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19252
UPDATE `creature_template_locale` SET `Title` = '大師級附魔訓練師' WHERE `locale` = 'zhTW' AND `entry` = 19252;
-- OLD name : 煉獄火入侵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19259
UPDATE `creature_template_locale` SET `Name` = '地獄火入侵者' WHERE `locale` = 'zhTW' AND `entry` = 19259;
-- OLD name : 煉獄火戰爭使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19261
UPDATE `creature_template_locale` SET `Name` = '地獄火戰爭使者' WHERE `locale` = 'zhTW' AND `entry` = 19261;
-- OLD name : 噬骨蠻兵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19269
UPDATE `creature_template_locale` SET `Name` = '快拍蟲' WHERE `locale` = 'zhTW' AND `entry` = 19269;
-- OLD name : 縛地者卡拉崔亞·夜風
-- Source : https://www.wowhead.com/wotlk/tw/npc=19294
UPDATE `creature_template_locale` SET `Name` = '大地束縛者卡拉崔亞·夜風' WHERE `locale` = 'zhTW' AND `entry` = 19294;
-- OLD name : 『煽動者』黑心
-- Source : https://www.wowhead.com/wotlk/tw/npc=19300
UPDATE `creature_template_locale` SET `Name` = '煽動者黑心' WHERE `locale` = 'zhTW' AND `entry` = 19300;
-- OLD name : 『煽動者』黑心
-- Source : https://www.wowhead.com/wotlk/tw/npc=19301
UPDATE `creature_template_locale` SET `Name` = '煽動者黑心' WHERE `locale` = 'zhTW' AND `entry` = 19301;
-- OLD name : 『煽動者』黑心
-- Source : https://www.wowhead.com/wotlk/tw/npc=19302
UPDATE `creature_template_locale` SET `Name` = '煽動者黑心' WHERE `locale` = 'zhTW' AND `entry` = 19302;
-- OLD name : 『煽動者』黑心
-- Source : https://www.wowhead.com/wotlk/tw/npc=19303
UPDATE `creature_template_locale` SET `Name` = '煽動者黑心' WHERE `locale` = 'zhTW' AND `entry` = 19303;
-- OLD name : 『煽動者』黑心
-- Source : https://www.wowhead.com/wotlk/tw/npc=19304
UPDATE `creature_template_locale` SET `Name` = '煽動者黑心' WHERE `locale` = 'zhTW' AND `entry` = 19304;
-- OLD subname : 巨像之王
-- Source : https://www.wowhead.com/wotlk/tw/npc=19305
UPDATE `creature_template_locale` SET `Title` = '戈羅西之王' WHERE `locale` = 'zhTW' AND `entry` = 19305;
-- OLD name : 物資官珊卓雅, subname : 雜貨商和修理工
-- Source : https://www.wowhead.com/wotlk/tw/npc=19314
UPDATE `creature_template_locale` SET `Name` = '物資商人珊卓雅',`Title` = '雜貨和修理' WHERE `locale` = 'zhTW' AND `entry` = 19314;
-- OLD name : 物資官伊莎貝爾, subname : 雜貨商和修理工
-- Source : https://www.wowhead.com/wotlk/tw/npc=19315
UPDATE `creature_template_locale` SET `Name` = '物資商人伊莎貝爾',`Title` = '雜貨和修理' WHERE `locale` = 'zhTW' AND `entry` = 19315;
-- OLD name : Barnu Cragcrush (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19325
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19325;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (19325, 'zhTW','NPC',NULL);
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19333
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 19333;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19341
UPDATE `creature_template_locale` SET `Title` = '大師級鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 19341;
-- OLD name : 棘牙噴毒者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19350
UPDATE `creature_template_locale` SET `Name` = '棘牙吐毒者' WHERE `locale` = 'zhTW' AND `entry` = 19350;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19369
UPDATE `creature_template_locale` SET `Title` = '廚師' WHERE `locale` = 'zhTW' AND `entry` = 19369;
-- OLD subname : 錘類鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19370
UPDATE `creature_template_locale` SET `Title` = '錘匠' WHERE `locale` = 'zhTW' AND `entry` = 19370;
-- OLD name : 戴林·頑錘
-- Source : https://www.wowhead.com/wotlk/tw/npc=19371
UPDATE `creature_template_locale` SET `Name` = '戴林·鋼錘' WHERE `locale` = 'zhTW' AND `entry` = 19371;
-- OLD name : 警備指揮官萊歐納斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=19392
UPDATE `creature_template_locale` SET `Name` = '警備隊長·萊歐納斯' WHERE `locale` = 'zhTW' AND `entry` = 19392;
-- OLD name : 惡魔劫奪者哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=19400
UPDATE `creature_template_locale` SET `Name` = '惡魔搶奪者哨兵' WHERE `locale` = 'zhTW' AND `entry` = 19400;
-- OLD name : 『瘋子』藍姆多
-- Source : https://www.wowhead.com/wotlk/tw/npc=19417
UPDATE `creature_template_locale` SET `Name` = '瘋狂的藍姆多' WHERE `locale` = 'zhTW' AND `entry` = 19417;
-- OLD name : 鈷藍巨蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=19428
UPDATE `creature_template_locale` SET `Name` = '深藍色巨蛇' WHERE `locale` = 'zhTW' AND `entry` = 19428;
-- OLD name : 農民勞工
-- Source : https://www.wowhead.com/wotlk/tw/npc=19444
UPDATE `creature_template_locale` SET `Name` = '農場勞工' WHERE `locale` = 'zhTW' AND `entry` = 19444;
-- OLD subname : 斧類鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19479
UPDATE `creature_template_locale` SET `Title` = '斧匠' WHERE `locale` = 'zhTW' AND `entry` = 19479;
-- OLD name : 晦暗的靈魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=19480
UPDATE `creature_template_locale` SET `Name` = '黯淡的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 19480;
-- OLD subname : 武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19499
UPDATE `creature_template_locale` SET `Title` = '武器鑄造師' WHERE `locale` = 'zhTW' AND `entry` = 19499;
-- OLD subname : 珠寶設計訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19539
UPDATE `creature_template_locale` SET `Title` = '大師級珠寶設計訓練師' WHERE `locale` = 'zhTW' AND `entry` = 19539;
-- OLD subname : 附魔訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19540
UPDATE `creature_template_locale` SET `Title` = '大師級附魔訓練師' WHERE `locale` = 'zhTW' AND `entry` = 19540;
-- OLD name : 戰鬥法師達斯立克, subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=19543
UPDATE `creature_template_locale` SET `Name` = '戰場法師達斯立克',`Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 19543;
-- OLD subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=19544
UPDATE `creature_template_locale` SET `Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 19544;
-- OLD subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=19545
UPDATE `creature_template_locale` SET `Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 19545;
-- OLD name : 棄絕者貝馬拉, subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=19546
UPDATE `creature_template_locale` SET `Name` = '貝馬拉',`Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 19546;
-- OLD name : 隱形置物箱
-- Source : https://www.wowhead.com/wotlk/tw/npc=19550
UPDATE `creature_template_locale` SET `Name` = '隱形手提箱' WHERE `locale` = 'zhTW' AND `entry` = 19550;
-- OLD subname : 大酋長
-- Source : https://www.wowhead.com/wotlk/tw/npc=19556
UPDATE `creature_template_locale` SET `Title` = '酋長' WHERE `locale` = 'zhTW' AND `entry` = 19556;
-- OLD name : 巨型鞭棘者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19557
UPDATE `creature_template_locale` SET `Name` = '巨型爭吵者' WHERE `locale` = 'zhTW' AND `entry` = 19557;
-- OLD name : 阿蜜莉亞·天空之心
-- Source : https://www.wowhead.com/wotlk/tw/npc=19558
UPDATE `creature_template_locale` SET `Name` = '阿蜜利雅·空氣之心' WHERE `locale` = 'zhTW' AND `entry` = 19558;
-- OLD subname : 工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19576
UPDATE `creature_template_locale` SET `Title` = '大師級工程學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 19576;
-- OLD subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=19579
UPDATE `creature_template_locale` SET `Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 19579;
-- OLD subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=19580
UPDATE `creature_template_locale` SET `Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 19580;
-- OLD name : 葛利克的狼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=19607
UPDATE `creature_template_locale` SET `Name` = '葛利克的騎乘座狼' WHERE `locale` = 'zhTW' AND `entry` = 19607;
-- OLD name : 野生鞭棘者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19608
UPDATE `creature_template_locale` SET `Name` = '野生爭吵者' WHERE `locale` = 'zhTW' AND `entry` = 19608;
-- OLD name : 卡勒斯·日刃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19611
UPDATE `creature_template_locale` SET `Name` = '卡勒斯‧日刃' WHERE `locale` = 'zhTW' AND `entry` = 19611;
-- OLD name : 泰洛卡狼魂(人類形態) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19615
UPDATE `creature_template_locale` SET `Name` = '泰洛卡狼魂(人形生物形態)' WHERE `locale` = 'zhTW' AND `entry` = 19615;
-- OLD name : 指揮官曦鑄獎勵
-- Source : https://www.wowhead.com/wotlk/tw/npc=19619
UPDATE `creature_template_locale` SET `Name` = '指揮官黎鑄獎勵' WHERE `locale` = 'zhTW' AND `entry` = 19619;
-- OLD name : 凱爾薩斯·逐日者, subname : 血精靈領主 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19622
UPDATE `creature_template_locale` SET `Name` = '凱爾薩斯‧逐日者',`Title` = '血精靈之王' WHERE `locale` = 'zhTW' AND `entry` = 19622;
-- OLD name : 薩希斯潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19642
UPDATE `creature_template_locale` SET `Name` = '薩希斯捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 19642;
-- OLD name : [PH]日怒施法者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19650
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19650;
-- OLD name : 隱形地點啟動器
-- Source : https://www.wowhead.com/wotlk/tw/npc=19656
UPDATE `creature_template_locale` SET `Name` = 'Netherstorm Trigger' WHERE `locale` = 'zhTW' AND `entry` = 19656;
-- OLD name : 召喚者坎辛
-- Source : https://www.wowhead.com/wotlk/tw/npc=19657
UPDATE `creature_template_locale` SET `Name` = '召喚者卡辛恩' WHERE `locale` = 'zhTW' AND `entry` = 19657;
-- OLD name : 大型精英伊萊克
-- Source : https://www.wowhead.com/wotlk/tw/npc=19659
UPDATE `creature_template_locale` SET `Name` = '大型伊萊克' WHERE `locale` = 'zhTW' AND `entry` = 19659;
-- OLD name : 露比夫人
-- Source : https://www.wowhead.com/wotlk/tw/npc=19663
UPDATE `creature_template_locale` SET `Name` = '魯比夫人' WHERE `locale` = 'zhTW' AND `entry` = 19663;
-- OLD name : 聯合團苦力
-- Source : https://www.wowhead.com/wotlk/tw/npc=19672
UPDATE `creature_template_locale` SET `Name` = '聯合團工人' WHERE `locale` = 'zhTW' AND `entry` = 19672;
-- OLD name : 『瘋子』歐卡司
-- Source : https://www.wowhead.com/wotlk/tw/npc=19683
UPDATE `creature_template_locale` SET `Name` = '瘋狂的歐卡司' WHERE `locale` = 'zhTW' AND `entry` = 19683;
-- OLD name : 強尼·卡索 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19700
UPDATE `creature_template_locale` SET `Name` = '強尼‧卡索' WHERE `locale` = 'zhTW' AND `entry` = 19700;
-- OLD name : 大師戴利斯·曦擊
-- Source : https://www.wowhead.com/wotlk/tw/npc=19705
UPDATE `creature_template_locale` SET `Name` = '大師戴利斯·黎擊' WHERE `locale` = 'zhTW' AND `entry` = 19705;
-- OLD name : Mechanar Ripper (UNUSED) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19711
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19711;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (19711, 'zhTW','NPC',NULL);
-- OLD name : Mechanar Pulverizer (UNUSED) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19714
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19714;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (19714, 'zhTW','NPC',NULL);
-- OLD name : 補給官茲索特
-- Source : https://www.wowhead.com/wotlk/tw/npc=19718
UPDATE `creature_template_locale` SET `Name` = '物資供應者茲索特' WHERE `locale` = 'zhTW' AND `entry` = 19718;
-- OLD name : 哈利斯·納雀希斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19721
UPDATE `creature_template_locale` SET `Name` = '哈利斯‧納雀希斯' WHERE `locale` = 'zhTW' AND `entry` = 19721;
-- OLD name : 隱形BE弩砲
-- Source : https://www.wowhead.com/wotlk/tw/npc=19723
UPDATE `creature_template_locale` SET `Name` = '隱形BE投石器' WHERE `locale` = 'zhTW' AND `entry` = 19723;
-- OLD name : 歷史學家亞登
-- Source : https://www.wowhead.com/wotlk/tw/npc=19736
UPDATE `creature_template_locale` SET `Name` = '歷史家亞登' WHERE `locale` = 'zhTW' AND `entry` = 19736;
-- OLD name : 工程人員
-- Source : https://www.wowhead.com/wotlk/tw/npc=19737
UPDATE `creature_template_locale` SET `Name` = '工程學機員' WHERE `locale` = 'zhTW' AND `entry` = 19737;
-- OLD name : 煉獄火爭吵者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19753
UPDATE `creature_template_locale` SET `Name` = '煉獄火馴獸者' WHERE `locale` = 'zhTW' AND `entry` = 19753;
-- OLD name : 莫阿格武器鍛造師
-- Source : https://www.wowhead.com/wotlk/tw/npc=19755
UPDATE `creature_template_locale` SET `Name` = '莫阿格武器鐵匠' WHERE `locale` = 'zhTW' AND `entry` = 19755;
-- OLD name : 煉獄火靈魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=19757
UPDATE `creature_template_locale` SET `Name` = '地獄火靈魂' WHERE `locale` = 'zhTW' AND `entry` = 19757;
-- OLD name : 全新雕刻的煉獄火
-- Source : https://www.wowhead.com/wotlk/tw/npc=19759
UPDATE `creature_template_locale` SET `Name` = '全新雕刻的地獄火' WHERE `locale` = 'zhTW' AND `entry` = 19759;
-- OLD name : 冷卻的煉獄火
-- Source : https://www.wowhead.com/wotlk/tw/npc=19760
UPDATE `creature_template_locale` SET `Name` = '冷卻的地獄火' WHERE `locale` = 'zhTW' AND `entry` = 19760;
-- OLD name : 考斯卡部屬
-- Source : https://www.wowhead.com/wotlk/tw/npc=19765
UPDATE `creature_template_locale` SET `Name` = '考斯卡侍從' WHERE `locale` = 'zhTW' AND `entry` = 19765;
-- OLD name : 考斯卡尖嘯者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19769
UPDATE `creature_template_locale` SET `Name` = '考斯卡尖哮者' WHERE `locale` = 'zhTW' AND `entry` = 19769;
-- OLD name : 考斯卡眼鏡蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=19784
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 19784;
-- OLD name : 毒冠眼鏡蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=19785
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 19785;
-- OLD name : 伊克利普森百夫長
-- Source : https://www.wowhead.com/wotlk/tw/npc=19792
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 19792;
-- OLD name : 指揮官曦鑄
-- Source : https://www.wowhead.com/wotlk/tw/npc=19831
UPDATE `creature_template_locale` SET `Name` = '指揮官黎鑄' WHERE `locale` = 'zhTW' AND `entry` = 19831;
-- OLD name : 『眼鏡仔』吉哥·齒輪磨碎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19835
UPDATE `creature_template_locale` SET `Name` = '『眼鏡仔』吉哥‧齒輪磨碎' WHERE `locale` = 'zhTW' AND `entry` = 19835;
-- OLD name : 卡利迪斯·明曦
-- Source : https://www.wowhead.com/wotlk/tw/npc=19840
UPDATE `creature_template_locale` SET `Name` = '卡利迪斯·曙光' WHERE `locale` = 'zhTW' AND `entry` = 19840;
-- OLD name : [PH] 尖角鬼魂 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=19846
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 19846;
-- OLD name : 廢料劫奪者X6000
-- Source : https://www.wowhead.com/wotlk/tw/npc=19849
UPDATE `creature_template_locale` SET `Name` = '廢料搶奪者X6000' WHERE `locale` = 'zhTW' AND `entry` = 19849;
-- OLD name : 麥希莫斯·亞當斯爵士
-- Source : https://www.wowhead.com/wotlk/tw/npc=19855
UPDATE `creature_template_locale` SET `Name` = '爵士麥希莫斯·亞當斯' WHERE `locale` = 'zhTW' AND `entry` = 19855;
-- OLD name : 隱形KV護盾產生器
-- Source : https://www.wowhead.com/wotlk/tw/npc=19870
UPDATE `creature_template_locale` SET `Name` = '隱形KV防禦產生器' WHERE `locale` = 'zhTW' AND `entry` = 19870;
-- OLD name : 虛空巡者凱澤
-- Source : https://www.wowhead.com/wotlk/tw/npc=19880
UPDATE `creature_template_locale` SET `Name` = '虛空行者凱澤' WHERE `locale` = 'zhTW' AND `entry` = 19880;
-- OLD subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=19881
UPDATE `creature_template_locale` SET `Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 19881;
-- OLD name : 古魯波·恐怖戰錘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19907
UPDATE `creature_template_locale` SET `Name` = '古魯波‧恐怖戰錘' WHERE `locale` = 'zhTW' AND `entry` = 19907;
-- OLD name : 蘇烏拉·迅箭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19908
UPDATE `creature_template_locale` SET `Name` = '蘇烏拉‧迅箭' WHERE `locale` = 'zhTW' AND `entry` = 19908;
-- OLD subname : 蘇烏拉·迅箭的寵物 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19914
UPDATE `creature_template_locale` SET `Title` = '蘇烏拉‧迅箭的寵物' WHERE `locale` = 'zhTW' AND `entry` = 19914;
-- OLD name : 時光看守者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19918
UPDATE `creature_template_locale` SET `Name` = '時間觀察者' WHERE `locale` = 'zhTW' AND `entry` = 19918;
-- OLD name : 法術劫奪者瑪拉希歐
-- Source : https://www.wowhead.com/wotlk/tw/npc=19926
UPDATE `creature_template_locale` SET `Name` = '法術搶奪者瑪拉希歐' WHERE `locale` = 'zhTW' AND `entry` = 19926;
-- OLD name : 鞭棘者保衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19953
UPDATE `creature_template_locale` SET `Name` = '爭吵者保衛者' WHERE `locale` = 'zhTW' AND `entry` = 19953;
-- OLD name : 恐懼之爐機工 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=19974
UPDATE `creature_template_locale` SET `Name` = '恐懼之爐機械工' WHERE `locale` = 'zhTW' AND `entry` = 19974;
-- OLD name : 維克尼爾·銳眼
-- Source : https://www.wowhead.com/wotlk/tw/npc=19982
UPDATE `creature_template_locale` SET `Name` = '維克尼爾銳眼' WHERE `locale` = 'zhTW' AND `entry` = 19982;
-- OLD name : 魯安歐克凝視者
-- Source : https://www.wowhead.com/wotlk/tw/npc=19985
UPDATE `creature_template_locale` SET `Name` = '魯安歐克·凝視者' WHERE `locale` = 'zhTW' AND `entry` = 19985;
-- OLD name : 魯安歐克天怒
-- Source : https://www.wowhead.com/wotlk/tw/npc=19986
UPDATE `creature_template_locale` SET `Name` = '魯安歐克智者·天怒' WHERE `locale` = 'zhTW' AND `entry` = 19986;
-- OLD name : 暗水鱷魚標本
-- Source : https://www.wowhead.com/wotlk/tw/npc=20026
UPDATE `creature_template_locale` SET `Name` = '黑水鱷魚標本' WHERE `locale` = 'zhTW' AND `entry` = 20026;
-- OLD name : 血守衛侍從
-- Source : https://www.wowhead.com/wotlk/tw/npc=20036
UPDATE `creature_template_locale` SET `Name` = '血守衛扈從' WHERE `locale` = 'zhTW' AND `entry` = 20036;
-- OLD name : 羅德隆哨衛標本
-- Source : https://www.wowhead.com/wotlk/tw/npc=20053
UPDATE `creature_template_locale` SET `Name` = '羅德隆哨兵標本' WHERE `locale` = 'zhTW' AND `entry` = 20053;
-- OLD name : 塔倫米爾農民標本
-- Source : https://www.wowhead.com/wotlk/tw/npc=20055
UPDATE `creature_template_locale` SET `Name` = '塔倫米爾農夫標本' WHERE `locale` = 'zhTW' AND `entry` = 20055;
-- OLD name : 鈷藍塔巴克戰騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=20072
UPDATE `creature_template_locale` SET `Name` = '深藍色塔巴克戰騎' WHERE `locale` = 'zhTW' AND `entry` = 20072;
-- OLD name : 暗羽哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=20079
UPDATE `creature_template_locale` SET `Name` = '暗羽哨兵' WHERE `locale` = 'zhTW' AND `entry` = 20079;
-- OLD subname : 補給官
-- Source : https://www.wowhead.com/wotlk/tw/npc=20080
UPDATE `creature_template_locale` SET `Title` = '物資供應者' WHERE `locale` = 'zhTW' AND `entry` = 20080;
-- OLD name : 血鱗哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=20090
UPDATE `creature_template_locale` SET `Name` = '血鱗哨兵' WHERE `locale` = 'zhTW' AND `entry` = 20090;
-- OLD subname : 一般補給官
-- Source : https://www.wowhead.com/wotlk/tw/npc=20092
UPDATE `creature_template_locale` SET `Title` = '一般物資供應者' WHERE `locale` = 'zhTW' AND `entry` = 20092;
-- OLD name : 虛空巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20101
UPDATE `creature_template_locale` SET `Name` = '虛空行者' WHERE `locale` = 'zhTW' AND `entry` = 20101;
-- OLD name : [PH] 八卦 NPC, 哥布林 女性, 聖誕節 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20103
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 20103;
-- OLD name : [PH] 八卦 NPC, 哥布林 女性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=20104
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 20104;
-- OLD name : [PH] 八卦 NPC, 哥布林 女性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=20105
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 20105;
-- OLD name : [PH] 八卦 NPC, 哥布林 男性, 新年慶典 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=20106
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 20106;
-- OLD name : [PH] 八卦 NPC, 哥布林 男性 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=20107
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 20107;
-- OLD name : 農夫格瑞菲斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=20123
UPDATE `creature_template_locale` SET `Name` = '農夫葛瑞夫斯' WHERE `locale` = 'zhTW' AND `entry` = 20123;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=20124
UPDATE `creature_template_locale` SET `Title` = '武器鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 20124;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=20125
UPDATE `creature_template_locale` SET `Title` = '護甲鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 20125;
-- OLD name : 虛無再生者 - 任務 - 扭曲裂隙
-- Source : https://www.wowhead.com/wotlk/tw/npc=20143
UPDATE `creature_template_locale` SET `Name` = '虛無再生者 - 任務 - 扭曲裂縫' WHERE `locale` = 'zhTW' AND `entry` = 20143;
-- OLD name : 被泥漿覆蓋的屍體
-- Source : https://www.wowhead.com/wotlk/tw/npc=20158
UPDATE `creature_template_locale` SET `Name` = '被軟泥覆蓋的屍體' WHERE `locale` = 'zhTW' AND `entry` = 20158;
-- OLD name : 煉獄火防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20160
UPDATE `creature_template_locale` SET `Name` = '地獄火防衛者' WHERE `locale` = 'zhTW' AND `entry` = 20160;
-- OLD subname : 一般補給官
-- Source : https://www.wowhead.com/wotlk/tw/npc=20194
UPDATE `creature_template_locale` SET `Title` = '一般物資供應者' WHERE `locale` = 'zhTW' AND `entry` = 20194;
-- OLD name : 物資官派斯托, subname : 雜貨商和修理工
-- Source : https://www.wowhead.com/wotlk/tw/npc=20231
UPDATE `creature_template_locale` SET `Name` = '物資商人派斯托',`Title` = '雜貨和修理' WHERE `locale` = 'zhTW' AND `entry` = 20231;
-- OLD name : 補給官奈斯拉
-- Source : https://www.wowhead.com/wotlk/tw/npc=20241
UPDATE `creature_template_locale` SET `Name` = '物資供應者奈斯拉' WHERE `locale` = 'zhTW' AND `entry` = 20241;
-- OLD name : 廢棄的惡魔劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20243
UPDATE `creature_template_locale` SET `Name` = '廢棄的惡魔搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 20243;
-- OLD name : 榮譽堡斥候箭靶
-- Source : https://www.wowhead.com/wotlk/tw/npc=20251
UPDATE `creature_template_locale` SET `Name` = '榮譽堡斥候弓箭目標' WHERE `locale` = 'zhTW' AND `entry` = 20251;
-- OLD subname : 傳承競技場護甲
-- Source : https://www.wowhead.com/wotlk/tw/npc=20278
UPDATE `creature_template_locale` SET `Title` = '競技場商人' WHERE `locale` = 'zhTW' AND `entry` = 20278;
-- OLD name : 諾瓦·泰娜 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20297
UPDATE `creature_template_locale` SET `Name` = '諾瓦‧泰娜' WHERE `locale` = 'zhTW' AND `entry` = 20297;
-- OLD name : 虛空巡者歐祖爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=20341
UPDATE `creature_template_locale` SET `Name` = '虛空行者歐祖爾' WHERE `locale` = 'zhTW' AND `entry` = 20341;
-- OLD name : 提里奧·弗丁
-- Source : https://www.wowhead.com/wotlk/tw/npc=20349
UPDATE `creature_template_locale` SET `Name` = '提里恩·弗丁' WHERE `locale` = 'zhTW' AND `entry` = 20349;
-- OLD subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=20350
UPDATE `creature_template_locale` SET `Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 20350;
-- OLD name : 莎莉·懷特邁恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=20357
UPDATE `creature_template_locale` SET `Name` = '莎麗·懷特邁恩' WHERE `locale` = 'zhTW' AND `entry` = 20357;
-- OLD name : 『流氓』赫洛德
-- Source : https://www.wowhead.com/wotlk/tw/npc=20360
UPDATE `creature_template_locale` SET `Name` = '『流氓』希洛特' WHERE `locale` = 'zhTW' AND `entry` = 20360;
-- OLD name : 泰蘭
-- Source : https://www.wowhead.com/wotlk/tw/npc=20361
UPDATE `creature_template_locale` SET `Name` = '泰伊蘭' WHERE `locale` = 'zhTW' AND `entry` = 20361;
-- OLD name : 達爾拉·哈里斯 OH (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20364
UPDATE `creature_template_locale` SET `Name` = '達爾拉‧哈里斯 OH' WHERE `locale` = 'zhTW' AND `entry` = 20364;
-- OLD name : 達倫·瑪爾維 OH (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20366
UPDATE `creature_template_locale` SET `Name` = '達倫‧瑪爾維 OH' WHERE `locale` = 'zhTW' AND `entry` = 20366;
-- OLD name : 羅比·艾比士雀 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20367
UPDATE `creature_template_locale` SET `Name` = '羅比‧艾比士雀' WHERE `locale` = 'zhTW' AND `entry` = 20367;
-- OLD subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=20370
UPDATE `creature_template_locale` SET `Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 20370;
-- OLD name : 維斯雷·歐 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20371
UPDATE `creature_template_locale` SET `Name` = '維斯雷‧歐' WHERE `locale` = 'zhTW' AND `entry` = 20371;
-- OLD name : 尼瑪·歐 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20375
UPDATE `creature_template_locale` SET `Name` = '妮瑪‧歐' WHERE `locale` = 'zhTW' AND `entry` = 20375;
-- OLD name : 阿薩蘭·亮刃
-- Source : https://www.wowhead.com/wotlk/tw/npc=20388
UPDATE `creature_template_locale` SET `Name` = '阿斯蘭·光刃' WHERE `locale` = 'zhTW' AND `entry` = 20388;
-- OLD name : 捕獲的動物 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20396
UPDATE `creature_template_locale` SET `Name` = '被捕獲的小動物' WHERE `locale` = 'zhTW' AND `entry` = 20396;
-- OLD name : 騎乘用雙足翼龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20413
UPDATE `creature_template_locale` SET `Name` = '騎乘用蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 20413;
-- OLD name : 騎乘用裝甲雙足翼龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20414
UPDATE `creature_template_locale` SET `Name` = '騎乘用裝甲蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 20414;
-- OLD name : 祈倫托法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=20422
UPDATE `creature_template_locale` SET `Name` = '肯瑞托法師' WHERE `locale` = 'zhTW' AND `entry` = 20422;
-- OLD name : 『百觸』威納拉圖斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=20427
UPDATE `creature_template_locale` SET `Name` = '多數的威納拉圖斯' WHERE `locale` = 'zhTW' AND `entry` = 20427;
-- OLD name : 日蝕崗哨 - 原血水晶法術
-- Source : https://www.wowhead.com/wotlk/tw/npc=20431
UPDATE `creature_template_locale` SET `Name` = '日蝕點 - 原血水晶法術' WHERE `locale` = 'zhTW' AND `entry` = 20431;
-- OLD name : 娜塔夏·莫里斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=20441
UPDATE `creature_template_locale` SET `Name` = '娜塔夏·莫利斯' WHERE `locale` = 'zhTW' AND `entry` = 20441;
-- OLD name : 安格拉斯哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=20443
UPDATE `creature_template_locale` SET `Name` = '安格拉斯哨兵' WHERE `locale` = 'zhTW' AND `entry` = 20443;
-- OLD name : 以太皇族刺客
-- Source : https://www.wowhead.com/wotlk/tw/npc=20452
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩刺客' WHERE `locale` = 'zhTW' AND `entry` = 20452;
-- OLD name : 以太皇族突擊兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=20453
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩突擊兵' WHERE `locale` = 'zhTW' AND `entry` = 20453;
-- OLD name : 以太皇族調查者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20456
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩調查者' WHERE `locale` = 'zhTW' AND `entry` = 20456;
-- OLD name : 以太皇族執政官
-- Source : https://www.wowhead.com/wotlk/tw/npc=20458
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩執政官' WHERE `locale` = 'zhTW' AND `entry` = 20458;
-- OLD name : 以太皇族霸主
-- Source : https://www.wowhead.com/wotlk/tw/npc=20459
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩霸主' WHERE `locale` = 'zhTW' AND `entry` = 20459;
-- OLD name : 虛空巡者那魯利斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=20471
UPDATE `creature_template_locale` SET `Name` = '虛空行者那魯利斯' WHERE `locale` = 'zhTW' AND `entry` = 20471;
-- OLD name : 棕毛兔
-- Source : https://www.wowhead.com/wotlk/tw/npc=20472
UPDATE `creature_template_locale` SET `Name` = '咖啡色兔子' WHERE `locale` = 'zhTW' AND `entry` = 20472;
-- OLD name : 以太皇族奈薩斯潛獵者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20474
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩奈薩斯捕獵者' WHERE `locale` = 'zhTW' AND `entry` = 20474;
-- OLD name : 不穩定的蘑菇
-- Source : https://www.wowhead.com/wotlk/tw/npc=20479
UPDATE `creature_template_locale` SET `Name` = '不穩定的斯朗' WHERE `locale` = 'zhTW' AND `entry` = 20479;
-- OLD name : 盛怒的烈焰
-- Source : https://www.wowhead.com/wotlk/tw/npc=20481
UPDATE `creature_template_locale` SET `Name` = '狂怒的烈焰' WHERE `locale` = 'zhTW' AND `entry` = 20481;
-- OLD name : 藍色雙足飛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=20486
UPDATE `creature_template_locale` SET `Name` = '藍色的雙足飛龍' WHERE `locale` = 'zhTW' AND `entry` = 20486;
-- OLD name : 黃褐色雙足飛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=20488
UPDATE `creature_template_locale` SET `Name` = '黃褐色的雙足飛龍' WHERE `locale` = 'zhTW' AND `entry` = 20488;
-- OLD name : 達瑪·蠻鬃
-- Source : https://www.wowhead.com/wotlk/tw/npc=20494
UPDATE `creature_template_locale` SET `Name` = '達瑪·野鬃' WHERE `locale` = 'zhTW' AND `entry` = 20494;
-- OLD name : 碎裂的裂石者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20498
UPDATE `creature_template_locale` SET `Name` = '破碎的裂石者' WHERE `locale` = 'zhTW' AND `entry` = 20498;
-- OLD subname : 飛行訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=20500
UPDATE `creature_template_locale` SET `Title` = '騎術訓練師' WHERE `locale` = 'zhTW' AND `entry` = 20500;
-- OLD name : 爛泥淤泥怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=20501
UPDATE `creature_template_locale` SET `Name` = '爛泥軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 20501;
-- OLD name : 雪白獅鷲獸坐騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=20505
UPDATE `creature_template_locale` SET `Name` = '雪白獅鷲獸' WHERE `locale` = 'zhTW' AND `entry` = 20505;
-- OLD name : 迅捷綠色騎乘用獅鷲獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=20506
UPDATE `creature_template_locale` SET `Name` = '迅捷綠色獅鷲獸' WHERE `locale` = 'zhTW' AND `entry` = 20506;
-- OLD name : 迅捷紫色騎乘用獅鷲獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=20507
UPDATE `creature_template_locale` SET `Name` = '迅捷紫色獅鷲獸' WHERE `locale` = 'zhTW' AND `entry` = 20507;
-- OLD name : 迅捷紅色騎乘用獅鷲獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=20508
UPDATE `creature_template_locale` SET `Name` = '迅捷紅色獅鷲獸' WHERE `locale` = 'zhTW' AND `entry` = 20508;
-- OLD name : 迅捷藍色騎乘用獅鷲獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=20509
UPDATE `creature_template_locale` SET `Name` = '迅捷藍色獅鷲獸' WHERE `locale` = 'zhTW' AND `entry` = 20509;
-- OLD subname : 飛行訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=20511
UPDATE `creature_template_locale` SET `Title` = '騎術訓練師' WHERE `locale` = 'zhTW' AND `entry` = 20511;
-- OLD subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=20512
UPDATE `creature_template_locale` SET `Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 20512;
-- OLD name : 以太皇族囚犯
-- Source : https://www.wowhead.com/wotlk/tw/npc=20520
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩囚犯' WHERE `locale` = 'zhTW' AND `entry` = 20520;
-- OLD name : 暴風海軍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20556
UPDATE `creature_template_locale` SET `Name` = '暴風城海軍' WHERE `locale` = 'zhTW' AND `entry` = 20556;
-- OLD name : 布姆博士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20605
UPDATE `creature_template_locale` SET `Name` = '爆爆博士' WHERE `locale` = 'zhTW' AND `entry` = 20605;
-- OLD name : 以太皇族傳達者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20619
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩傳達者' WHERE `locale` = 'zhTW' AND `entry` = 20619;
-- OLD name : 以太皇族訓練假人
-- Source : https://www.wowhead.com/wotlk/tw/npc=20676
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩訓練假人' WHERE `locale` = 'zhTW' AND `entry` = 20676;
-- OLD name : 山脊巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20714
UPDATE `creature_template_locale` SET `Name` = '山脊行者' WHERE `locale` = 'zhTW' AND `entry` = 20714;
-- OLD subname : 柯林·歐羅克的寵物 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=20716
UPDATE `creature_template_locale` SET `Title` = '柯林‧歐羅克的寵物' WHERE `locale` = 'zhTW' AND `entry` = 20716;
-- OLD name : 以太皇族能量細胞
-- Source : https://www.wowhead.com/wotlk/tw/npc=20755
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩能量細胞' WHERE `locale` = 'zhTW' AND `entry` = 20755;
-- OLD name : 以太皇族目標
-- Source : https://www.wowhead.com/wotlk/tw/npc=20764
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩目標' WHERE `locale` = 'zhTW' AND `entry` = 20764;
-- OLD name : 以太皇族執政官能量細胞
-- Source : https://www.wowhead.com/wotlk/tw/npc=20782
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩執政官能量細胞' WHERE `locale` = 'zhTW' AND `entry` = 20782;
-- OLD name : 『瘋子』瑪拉芙思
-- Source : https://www.wowhead.com/wotlk/tw/npc=20790
UPDATE `creature_template_locale` SET `Name` = '瘋狂的馬拉弗斯' WHERE `locale` = 'zhTW' AND `entry` = 20790;
-- OLD name : 小變異曲蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=20797
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 20797;
-- OLD name : 護國者爆破兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=20802
UPDATE `creature_template_locale` SET `Name` = '護國者破壞者' WHERE `locale` = 'zhTW' AND `entry` = 20802;
-- OLD name : 爛泥淤泥怪球體
-- Source : https://www.wowhead.com/wotlk/tw/npc=20806
UPDATE `creature_template_locale` SET `Name` = '爛泥軟泥怪球體' WHERE `locale` = 'zhTW' AND `entry` = 20806;
-- OLD name : 抄寫員薩歐林
-- Source : https://www.wowhead.com/wotlk/tw/npc=20807
UPDATE `creature_template_locale` SET `Name` = '註冊員薩歐林' WHERE `locale` = 'zhTW' AND `entry` = 20807;
-- OLD name : 薩斯葛爾任務獎勵標誌, 獸欄
-- Source : https://www.wowhead.com/wotlk/tw/npc=20814
UPDATE `creature_template_locale` SET `Name` = '薩斯葛爾任務獎勵標誌, 馬廄' WHERE `locale` = 'zhTW' AND `entry` = 20814;
-- OLD name : 以太皇族囚犯 (泰拉里斯)
-- Source : https://www.wowhead.com/wotlk/tw/npc=20825
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩囚犯 (泰拉里斯)' WHERE `locale` = 'zhTW' AND `entry` = 20825;
-- OLD name : 以太皇族角鬥士
-- Source : https://www.wowhead.com/wotlk/tw/npc=20854
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩角鬥士' WHERE `locale` = 'zhTW' AND `entry` = 20854;
-- OLD name : 競技場事件控制器
-- Source : https://www.wowhead.com/wotlk/tw/npc=20858
UPDATE `creature_template_locale` SET `Name` = '競技場事件控制者' WHERE `locale` = 'zhTW' AND `entry` = 20858;
-- OLD name : 埃雷達爾死亡使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20880
UPDATE `creature_template_locale` SET `Name` = '埃雷達爾死亡召喚者' WHERE `locale` = 'zhTW' AND `entry` = 20880;
-- OLD name : 無縛的毀滅者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20881
UPDATE `creature_template_locale` SET `Name` = '無鏈結的毀滅者' WHERE `locale` = 'zhTW' AND `entry` = 20881;
-- OLD name : 懷恨的妖婦
-- Source : https://www.wowhead.com/wotlk/tw/npc=20883
UPDATE `creature_template_locale` SET `Name` = '惡毒的妖婦' WHERE `locale` = 'zhTW' AND `entry` = 20883;
-- OLD name : 以太皇族囚犯(族群能量球)
-- Source : https://www.wowhead.com/wotlk/tw/npc=20889
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩囚犯(族群能量球)' WHERE `locale` = 'zhTW' AND `entry` = 20889;
-- OLD name : 以太皇族殺戮者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20896
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩殺戮者' WHERE `locale` = 'zhTW' AND `entry` = 20896;
-- OLD name : 以太皇族波動法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=20897
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩波動法師' WHERE `locale` = 'zhTW' AND `entry` = 20897;
-- OLD name : 虛無導管
-- Source : https://www.wowhead.com/wotlk/tw/npc=20899
UPDATE `creature_template_locale` SET `Name` = '虛無導線' WHERE `locale` = 'zhTW' AND `entry` = 20899;
-- OLD name : 無束縛的末日使者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20900
UPDATE `creature_template_locale` SET `Name` = '無束縛的摧毀者' WHERE `locale` = 'zhTW' AND `entry` = 20900;
-- OLD name : 奧基瑞斯喚雷者
-- Source : https://www.wowhead.com/wotlk/tw/npc=20908
UPDATE `creature_template_locale` SET `Name` = '薩弗隆法力塑造者' WHERE `locale` = 'zhTW' AND `entry` = 20908;
-- OLD name : 盤牙門戶控制器
-- Source : https://www.wowhead.com/wotlk/tw/npc=20926
UPDATE `creature_template_locale` SET `Name` = '隱形的潛伏者盤牙通道' WHERE `locale` = 'zhTW' AND `entry` = 20926;
-- OLD subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=20934
UPDATE `creature_template_locale` SET `Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 20934;
-- OLD name : 捕獲的水靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=21029
UPDATE `creature_template_locale` SET `Name` = '捕獲的水之靈' WHERE `locale` = 'zhTW' AND `entry` = 21029;
-- OLD name : 怒鐮者的衝鋒標靶
-- Source : https://www.wowhead.com/wotlk/tw/npc=21030
UPDATE `creature_template_locale` SET `Name` = '怒鐮者的衝鋒目標' WHERE `locale` = 'zhTW' AND `entry` = 21030;
-- OLD name : [PH] 秘法護衛 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=21031
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21031;
-- OLD name : 刃翼放血者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21033
UPDATE `creature_template_locale` SET `Name` = '刃翼血信' WHERE `locale` = 'zhTW' AND `entry` = 21033;
-- OLD name : 藍色蝎子 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=21043
UPDATE `creature_template_locale` SET `Name` = '藍色蠍子' WHERE `locale` = 'zhTW' AND `entry` = 21043;
-- OLD name : 暴怒的水靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=21059
UPDATE `creature_template_locale` SET `Name` = '暴怒的水之靈' WHERE `locale` = 'zhTW' AND `entry` = 21059;
-- OLD name : 暴怒的風靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=21060
UPDATE `creature_template_locale` SET `Name` = '暴怒的風之靈' WHERE `locale` = 'zhTW' AND `entry` = 21060;
-- OLD subname : 祈倫托
-- Source : https://www.wowhead.com/wotlk/tw/npc=21065
UPDATE `creature_template_locale` SET `Title` = '肯瑞托' WHERE `locale` = 'zhTW' AND `entry` = 21065;
-- OLD name : 煉獄火目標(海加爾)
-- Source : https://www.wowhead.com/wotlk/tw/npc=21075
UPDATE `creature_template_locale` SET `Name` = '地獄火目標(海加爾)' WHERE `locale` = 'zhTW' AND `entry` = 21075;
-- OLD name : 煉獄火球體
-- Source : https://www.wowhead.com/wotlk/tw/npc=21080
UPDATE `creature_template_locale` SET `Name` = '地獄火球體' WHERE `locale` = 'zhTW' AND `entry` = 21080;
-- OLD subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=21087
UPDATE `creature_template_locale` SET `Title` = '大師級製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 21087;
-- OLD name : 無縛的虛無區
-- Source : https://www.wowhead.com/wotlk/tw/npc=21101
UPDATE `creature_template_locale` SET `Name` = '無鏈結的虛無區' WHERE `locale` = 'zhTW' AND `entry` = 21101;
-- OLD name : 裂隙看守者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21104
UPDATE `creature_template_locale` SET `Name` = '裂縫看守者' WHERE `locale` = 'zhTW' AND `entry` = 21104;
-- OLD name : 毀滅之鋸
-- Source : https://www.wowhead.com/wotlk/tw/npc=21119
UPDATE `creature_template_locale` SET `Name` = '毀滅之鉅' WHERE `locale` = 'zhTW' AND `entry` = 21119;
-- OLD name : 毀滅之鋸目標
-- Source : https://www.wowhead.com/wotlk/tw/npc=21120
UPDATE `creature_template_locale` SET `Name` = '毀滅之鉅目標' WHERE `locale` = 'zhTW' AND `entry` = 21120;
-- OLD name : 被輕蔑的水靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=21131
UPDATE `creature_template_locale` SET `Name` = '被輕蔑的水之靈' WHERE `locale` = 'zhTW' AND `entry` = 21131;
-- OLD name : 恆龍鎮壓者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21139
UPDATE `creature_template_locale` SET `Name` = '恆龍毀滅者' WHERE `locale` = 'zhTW' AND `entry` = 21139;
-- OLD name : 裂隙領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=21140
UPDATE `creature_template_locale` SET `Name` = '裂縫領主' WHERE `locale` = 'zhTW' AND `entry` = 21140;
-- OLD name : 裂隙看守者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21148
UPDATE `creature_template_locale` SET `Name` = '裂縫看守者' WHERE `locale` = 'zhTW' AND `entry` = 21148;
-- OLD name : 柯爾克隆護甲雙足翼龍坐騎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=21154
UPDATE `creature_template_locale` SET `Name` = '柯爾克隆護甲蠍尾獅坐騎' WHERE `locale` = 'zhTW' AND `entry` = 21154;
-- OLD name : 瑟拉那上士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=21156
UPDATE `creature_template_locale` SET `Name` = '上士瑟拉那' WHERE `locale` = 'zhTW' AND `entry` = 21156;
-- OLD name : 伊利達瑞驚懼領主
-- Source : https://www.wowhead.com/wotlk/tw/npc=21166
UPDATE `creature_template_locale` SET `Name` = '伊利達瑞恐懼領主' WHERE `locale` = 'zhTW' AND `entry` = 21166;
-- OLD name : 榮譽堡獅鷲準將，南方
-- Source : https://www.wowhead.com/wotlk/tw/npc=21170
UPDATE `creature_template_locale` SET `Name` = '榮譽堡獅鷲準將 , 南方' WHERE `locale` = 'zhTW' AND `entry` = 21170;
-- OLD name : 被馴養的惡魔野豬
-- Source : https://www.wowhead.com/wotlk/tw/npc=21195
UPDATE `creature_template_locale` SET `Name` = '被馴養了的惡魔野豬' WHERE `locale` = 'zhTW' AND `entry` = 21195;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=21209
UPDATE `creature_template_locale` SET `Title` = '大師級鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 21209;
-- OLD name : 瓦許伊爾榮譽守衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=21218
UPDATE `creature_template_locale` SET `Name` = '瓦司金榮譽守衛' WHERE `locale` = 'zhTW' AND `entry` = 21218;
-- OLD name : 潮行者魚叉手
-- Source : https://www.wowhead.com/wotlk/tw/npc=21227
UPDATE `creature_template_locale` SET `Name` = '潮行者獵魚者' WHERE `locale` = 'zhTW' AND `entry` = 21227;
-- OLD name : 潮行者水占師
-- Source : https://www.wowhead.com/wotlk/tw/npc=21228
UPDATE `creature_template_locale` SET `Name` = '潮行者海法師' WHERE `locale` = 'zhTW' AND `entry` = 21228;
-- OLD name : 憤怒巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21249
UPDATE `creature_template_locale` SET `Name` = '憤怒行者' WHERE `locale` = 'zhTW' AND `entry` = 21249;
-- OLD subname : 歐朗諾克的夥伴
-- Source : https://www.wowhead.com/wotlk/tw/npc=21255
UPDATE `creature_template_locale` SET `Title` = '歐朗諾克的同伴' WHERE `locale` = 'zhTW' AND `entry` = 21255;
-- OLD name : 以太皇族錘
-- Source : https://www.wowhead.com/wotlk/tw/npc=21286
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩錘' WHERE `locale` = 'zhTW' AND `entry` = 21286;
-- OLD name : 死鑄煉獄火
-- Source : https://www.wowhead.com/wotlk/tw/npc=21316
UPDATE `creature_template_locale` SET `Name` = '死鑄地獄火' WHERE `locale` = 'zhTW' AND `entry` = 21316;
-- OLD name : 葛爾·葛利姆嘎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=21319
UPDATE `creature_template_locale` SET `Name` = '葛爾‧葛利姆嘎' WHERE `locale` = 'zhTW' AND `entry` = 21319;
-- OLD name : 幻象導覽變形 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=21320
UPDATE `creature_template_locale` SET `Name` = '幻象導覽' WHERE `locale` = 'zhTW' AND `entry` = 21320;
-- OLD name : 烏鴉林石木樹人
-- Source : https://www.wowhead.com/wotlk/tw/npc=21325
UPDATE `creature_template_locale` SET `Name` = '烏鴉林石化樹人' WHERE `locale` = 'zhTW' AND `entry` = 21325;
-- OLD name : [PH]Test Skunk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=21333
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21333;
-- OLD name : 威納拉圖斯重生點
-- Source : https://www.wowhead.com/wotlk/tw/npc=21334
UPDATE `creature_template_locale` SET `Name` = '維納迪重生點' WHERE `locale` = 'zhTW' AND `entry` = 21334;
-- OLD name : 維克多
-- Source : https://www.wowhead.com/wotlk/tw/npc=21341
UPDATE `creature_template_locale` SET `Name` = '維克特' WHERE `locale` = 'zhTW' AND `entry` = 21341;
-- OLD name : 以太盜掠者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21368
UPDATE `creature_template_locale` SET `Name` = '伊斯利掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 21368;
-- OLD name : 以太虛空術師
-- Source : https://www.wowhead.com/wotlk/tw/npc=21370
UPDATE `creature_template_locale` SET `Name` = '伊斯利虛空術師' WHERE `locale` = 'zhTW' AND `entry` = 21370;
-- OLD name : [UNUSED]Test Nether Whelp (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=21378
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21378;
-- OLD name : 大衛·亞當斯爵士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=21390
UPDATE `creature_template_locale` SET `Name` = '大衛‧亞當斯爵士' WHERE `locale` = 'zhTW' AND `entry` = 21390;
-- OLD name : 軍團要塞惡魔劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21404
UPDATE `creature_template_locale` SET `Name` = '軍團要塞惡魔搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 21404;
-- OLD name : 以太秘法師
-- Source : https://www.wowhead.com/wotlk/tw/npc=21405
UPDATE `creature_template_locale` SET `Name` = '伊斯利秘法師' WHERE `locale` = 'zhTW' AND `entry` = 21405;
-- OLD name : 『骯髒吞嚥者』托比亞斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=21411
UPDATE `creature_template_locale` SET `Name` = '『骯髒吞嚥者』圖比亞斯' WHERE `locale` = 'zhTW' AND `entry` = 21411;
-- OLD name : 隱藏煉獄火施法者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21417
UPDATE `creature_template_locale` SET `Name` = '隱藏惡魔施法者' WHERE `locale` = 'zhTW' AND `entry` = 21417;
-- OLD name : 煉獄火攻擊者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21419
UPDATE `creature_template_locale` SET `Name` = '地獄火攻擊者' WHERE `locale` = 'zhTW' AND `entry` = 21419;
-- OLD name : Tempixx Finagler (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=21444
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21444;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21444, 'zhTW','NPC',NULL);
-- OLD name : [Unused]大型地殼穿刺者視覺 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=21457
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21457;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/tw/npc=21483
UPDATE `creature_template_locale` SET `Title` = '彈藥商' WHERE `locale` = 'zhTW' AND `entry` = 21483;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/tw/npc=21488
UPDATE `creature_template_locale` SET `Title` = '彈藥商' WHERE `locale` = 'zhTW' AND `entry` = 21488;
-- OLD name : 監督者撕鋸
-- Source : https://www.wowhead.com/wotlk/tw/npc=21499
UPDATE `creature_template_locale` SET `Name` = '監督者撕鉅' WHERE `locale` = 'zhTW' AND `entry` = 21499;
-- OLD name : 戰爭使者瑞術恩的影像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=21502
UPDATE `creature_template_locale` SET `Name` = '戰爭使者拉祖恩的影像' WHERE `locale` = 'zhTW' AND `entry` = 21502;
-- OLD name : [DND]卡瑞里光環驅散 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=21511
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21511;
-- OLD name : 死亡使者裘瓦安
-- Source : https://www.wowhead.com/wotlk/tw/npc=21633
UPDATE `creature_template_locale` SET `Name` = '死亡召喚者裘瓦安' WHERE `locale` = 'zhTW' AND `entry` = 21633;
-- OLD name : 森林行者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21635
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 21635;
-- OLD name : 司凱提斯爪牙 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=21650
UPDATE `creature_template_locale` SET `Name` = '司凱堤斯爪牙' WHERE `locale` = 'zhTW' AND `entry` = 21650;
-- OLD name : [UNUSED]Death's Deliverer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=21658
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21658;
-- OLD name : 漂浮的裝飾眼珠
-- Source : https://www.wowhead.com/wotlk/tw/npc=21659
UPDATE `creature_template_locale` SET `Name` = '漂浮的味眼' WHERE `locale` = 'zhTW' AND `entry` = 21659;
-- OLD subname : 托斯利基地遙控哨衛
-- Source : https://www.wowhead.com/wotlk/tw/npc=21690
UPDATE `creature_template_locale` SET `Title` = '托斯利基地遙控哨兵' WHERE `locale` = 'zhTW' AND `entry` = 21690;
-- OLD name : 以太皇族生命束縛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=21702
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩生命束縛者' WHERE `locale` = 'zhTW' AND `entry` = 21702;
-- OLD name : 墮落的風之圖騰
-- Source : https://www.wowhead.com/wotlk/tw/npc=21705
UPDATE `creature_template_locale` SET `Name` = '墮落的風圖騰' WHERE `locale` = 'zhTW' AND `entry` = 21705;
-- OLD name : 墮落的火元素
-- Source : https://www.wowhead.com/wotlk/tw/npc=21706
UPDATE `creature_template_locale` SET `Name` = '墮落的火焰元素' WHERE `locale` = 'zhTW' AND `entry` = 21706;
-- OLD name : 墮落的風元素
-- Source : https://www.wowhead.com/wotlk/tw/npc=21707
UPDATE `creature_template_locale` SET `Name` = '墮落的空氣元素' WHERE `locale` = 'zhTW' AND `entry` = 21707;
-- OLD name : [DND]Mok'Nathal Wand 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=21713
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21713;
-- OLD name : [DND]Mok'Nathal Wand 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=21714
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21714;
-- OLD name : [DND]Mok'Nathal Wand 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=21715
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21715;
-- OLD name : [DND]Mok'Nathal Wand 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=21716
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 21716;
-- OLD name : 煉獄火邪靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=21735
UPDATE `creature_template_locale` SET `Name` = '地獄火邪靈' WHERE `locale` = 'zhTW' AND `entry` = 21735;
-- OLD name : 贖罪的水靈
-- Source : https://www.wowhead.com/wotlk/tw/npc=21741
UPDATE `creature_template_locale` SET `Name` = '贖罪的水之靈' WHERE `locale` = 'zhTW' AND `entry` = 21741;
-- OLD name : 大酋長黑手
-- Source : https://www.wowhead.com/wotlk/tw/npc=21752
UPDATE `creature_template_locale` SET `Name` = '黑手大酋長' WHERE `locale` = 'zhTW' AND `entry` = 21752;
-- OLD name : 霸主歐巴洛卡赫
-- Source : https://www.wowhead.com/wotlk/tw/npc=21769
UPDATE `creature_template_locale` SET `Name` = '歐巴洛卡赫霸主' WHERE `locale` = 'zhTW' AND `entry` = 21769;
-- OLD name : 喚戰者薩爾登·崔賴斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=21771
UPDATE `creature_template_locale` SET `Name` = '公告員薩爾登·崔賴斯' WHERE `locale` = 'zhTW' AND `entry` = 21771;
-- OLD name : 尤瑞卡爾族長
-- Source : https://www.wowhead.com/wotlk/tw/npc=21773
UPDATE `creature_template_locale` SET `Name` = '賽恩尼·憂瑞卡爾' WHERE `locale` = 'zhTW' AND `entry` = 21773;
-- OLD name : 喚戰者畢爾斯納特
-- Source : https://www.wowhead.com/wotlk/tw/npc=21775
UPDATE `creature_template_locale` SET `Name` = '公告員畢爾斯納特' WHERE `locale` = 'zhTW' AND `entry` = 21775;
-- OLD name : 烏鴉林樹人
-- Source : https://www.wowhead.com/wotlk/tw/npc=21853
UPDATE `creature_template_locale` SET `Name` = '烏鴉林螞蟻' WHERE `locale` = 'zhTW' AND `entry` = 21853;
-- OLD subname : 薩塔家傳物品保管人
-- Source : https://www.wowhead.com/wotlk/tw/npc=21905
UPDATE `creature_template_locale` SET `Title` = '薩塔傳家寶保管人' WHERE `locale` = 'zhTW' AND `entry` = 21905;
-- OLD name : 水珠
-- Source : https://www.wowhead.com/wotlk/tw/npc=21913
UPDATE `creature_template_locale` SET `Name` = '水晶體' WHERE `locale` = 'zhTW' AND `entry` = 21913;
-- OLD name : 惡魔劫奪者哨兵
-- Source : https://www.wowhead.com/wotlk/tw/npc=21949
UPDATE `creature_template_locale` SET `Name` = '惡魔搶奪者哨兵' WHERE `locale` = 'zhTW' AND `entry` = 21949;
-- OLD name : 空軍衛哨 (部落-蝠騎兵)
-- Source : https://www.wowhead.com/wotlk/tw/npc=21993
UPDATE `creature_template_locale` SET `Name` = '空軍哨站 (部落-乘蝠者)' WHERE `locale` = 'zhTW' AND `entry` = 21993;
-- OLD name : 空軍衛哨 (聯盟-獅鷲獸)
-- Source : https://www.wowhead.com/wotlk/tw/npc=21996
UPDATE `creature_template_locale` SET `Name` = '空軍哨站 (聯盟-獅鷲獸)' WHERE `locale` = 'zhTW' AND `entry` = 21996;
-- OLD name : 空軍衛哨 (哥布林-52區- 飛艇)
-- Source : https://www.wowhead.com/wotlk/tw/npc=21997
UPDATE `creature_template_locale` SET `Name` = '空軍哨站 (哥布林-52區- 飛艇)' WHERE `locale` = 'zhTW' AND `entry` = 21997;
-- OLD name : [DND]Spirit 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22023
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22023;
-- OLD name : [PH] bat target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22039
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22039;
-- OLD name : [ph] cave ant [not used] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22048
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22048;
-- OLD name : 『巨像之王』貝希摩森
-- Source : https://www.wowhead.com/wotlk/tw/npc=22054
UPDATE `creature_template_locale` SET `Name` = '『戈羅西之王』貝希摩森' WHERE `locale` = 'zhTW' AND `entry` = 22054;
-- OLD name : 盤牙團隊表情控制跟隨者
-- Source : https://www.wowhead.com/wotlk/tw/npc=22057
UPDATE `creature_template_locale` SET `Name` = '隱形的盤牙團隊表情控制跟隨者' WHERE `locale` = 'zhTW' AND `entry` = 22057;
-- OLD name : 空軍衛哨 (以太族-風暴之尖)
-- Source : https://www.wowhead.com/wotlk/tw/npc=22065
UPDATE `creature_template_locale` SET `Name` = '空軍哨站 (伊斯利-風暴之尖)' WHERE `locale` = 'zhTW' AND `entry` = 22065;
-- OLD name : 空軍衛哨 (占卜者-龍鷹)
-- Source : https://www.wowhead.com/wotlk/tw/npc=22066
UPDATE `creature_template_locale` SET `Name` = '空軍哨站 (占卜者-龍鷹)' WHERE `locale` = 'zhTW' AND `entry` = 22066;
-- OLD name : 空軍飛行警報器-屋頂 (以太族-風暴之尖)
-- Source : https://www.wowhead.com/wotlk/tw/npc=22068
UPDATE `creature_template_locale` SET `Name` = '空軍飛行警報器-屋頂 (伊斯利-風暴之尖)' WHERE `locale` = 'zhTW' AND `entry` = 22068;
-- OLD name : 馬庫斯·阿瑞利恩, subname : 薩塔大將軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=22073
UPDATE `creature_template_locale` SET `Name` = '馬克斯·阿瑞利恩',`Title` = '薩塔的高階將軍' WHERE `locale` = 'zhTW' AND `entry` = 22073;
-- OLD name : 空軍衛哨 (奧多爾-獅鷲獸)
-- Source : https://www.wowhead.com/wotlk/tw/npc=22079
UPDATE `creature_template_locale` SET `Name` = '空軍哨站 (奧多爾-獅鷲獸)' WHERE `locale` = 'zhTW' AND `entry` = 22079;
-- OLD name : 影月暗織者
-- Source : https://www.wowhead.com/wotlk/tw/npc=22081
UPDATE `creature_template_locale` SET `Name` = '影月黑暗編織者' WHERE `locale` = 'zhTW' AND `entry` = 22081;
-- OLD name : 空軍衛哨 (斯博格爾-孢子蝙蝠)
-- Source : https://www.wowhead.com/wotlk/tw/npc=22087
UPDATE `creature_template_locale` SET `Name` = '空軍哨站 (斯博格爾-孢子蝙蝠)' WHERE `locale` = 'zhTW' AND `entry` = 22087;
-- OLD name : 空軍衛哨 (托斯利基地-飛行器)
-- Source : https://www.wowhead.com/wotlk/tw/npc=22090
UPDATE `creature_template_locale` SET `Name` = '空軍哨站 (托斯利基地-飛行器)' WHERE `locale` = 'zhTW' AND `entry` = 22090;
-- OLD name : 巨龍教團補給官
-- Source : https://www.wowhead.com/wotlk/tw/npc=22099
UPDATE `creature_template_locale` SET `Name` = '巨龍教團物資供應者' WHERE `locale` = 'zhTW' AND `entry` = 22099;
-- OLD name : 暗吼上尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=22107
UPDATE `creature_template_locale` SET `Name` = '達克豪中尉' WHERE `locale` = 'zhTW' AND `entry` = 22107;
-- OLD subname : 奈爾斯阿拉古的配偶
-- Source : https://www.wowhead.com/wotlk/tw/npc=22112
UPDATE `creature_template_locale` SET `Title` = '奈爾斯阿拉古的配偶。' WHERE `locale` = 'zhTW' AND `entry` = 22112;
-- OLD name : [DND]Whisper Spying Credit Marker 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22116
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22116;
-- OLD name : [DND]Whisper Spying Credit Marker 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22117
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22117;
-- OLD name : [DND]Whisper Spying Credit Marker 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22118
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22118;
-- OLD name : 深淵潛伏者
-- Source : https://www.wowhead.com/wotlk/tw/npc=22119
UPDATE `creature_template_locale` SET `Name` = '深淵蜘蛛' WHERE `locale` = 'zhTW' AND `entry` = 22119;
-- OLD name : 塞納里奧風暴烏鴉
-- Source : https://www.wowhead.com/wotlk/tw/npc=22122
UPDATE `creature_template_locale` SET `Name` = '塞納里奧暴風烏鴉' WHERE `locale` = 'zhTW' AND `entry` = 22122;
-- OLD name : 空軍衛哨 (塞納里奧-風暴烏鴉)
-- Source : https://www.wowhead.com/wotlk/tw/npc=22125
UPDATE `creature_template_locale` SET `Name` = '空軍哨站 (塞納里奧-暴風烏鴉)' WHERE `locale` = 'zhTW' AND `entry` = 22125;
-- OLD name : 黑暗議會祭儀師
-- Source : https://www.wowhead.com/wotlk/tw/npc=22138
UPDATE `creature_template_locale` SET `Name` = '黑暗議會儀式者' WHERE `locale` = 'zhTW' AND `entry` = 22138;
-- OLD name : 盛怒劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=22196
UPDATE `creature_template_locale` SET `Name` = '盛怒搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 22196;
-- OLD subname : 月布裁縫專家
-- Source : https://www.wowhead.com/wotlk/tw/npc=22208
UPDATE `creature_template_locale` SET `Title` = '月布專家' WHERE `locale` = 'zhTW' AND `entry` = 22208;
-- OLD subname : 影紋裁縫專家
-- Source : https://www.wowhead.com/wotlk/tw/npc=22212
UPDATE `creature_template_locale` SET `Title` = '影紋專家' WHERE `locale` = 'zhTW' AND `entry` = 22212;
-- OLD name : 蓋吉·織法者, subname : 魔焰裁縫專家
-- Source : https://www.wowhead.com/wotlk/tw/npc=22213
UPDATE `creature_template_locale` SET `Name` = '蓋吉·術法編織者',`Title` = '魔焰專家' WHERE `locale` = 'zhTW' AND `entry` = 22213;
-- OLD name : 德魯曼·影林 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22229
UPDATE `creature_template_locale` SET `Name` = '德魯曼‧影林' WHERE `locale` = 'zhTW' AND `entry` = 22229;
-- OLD name : 西尼亞·星歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22234
UPDATE `creature_template_locale` SET `Name` = '西尼亞‧星歌' WHERE `locale` = 'zhTW' AND `entry` = 22234;
-- OLD name : 羅莉亞·風奔者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22237
UPDATE `creature_template_locale` SET `Name` = '羅莉亞‧風奔者' WHERE `locale` = 'zhTW' AND `entry` = 22237;
-- OLD name : 無縛的以太族
-- Source : https://www.wowhead.com/wotlk/tw/npc=22244
UPDATE `creature_template_locale` SET `Name` = '無鏈結的伊斯瑞爾' WHERE `locale` = 'zhTW' AND `entry` = 22244;
-- OLD name : 腐臭蘑菇
-- Source : https://www.wowhead.com/wotlk/tw/npc=22250
UPDATE `creature_template_locale` SET `Name` = '腐臭磨菇' WHERE `locale` = 'zhTW' AND `entry` = 22250;
-- OLD name : 龍喉卓越者
-- Source : https://www.wowhead.com/wotlk/tw/npc=22253
UPDATE `creature_template_locale` SET `Name` = '龍喉監工' WHERE `locale` = 'zhTW' AND `entry` = 22253;
-- OLD name : 地獄火守護小鬼
-- Source : https://www.wowhead.com/wotlk/tw/npc=22259
UPDATE `creature_template_locale` SET `Name` = '地獄火吸法器' WHERE `locale` = 'zhTW' AND `entry` = 22259;
-- OLD name : [PH] Wrath Clefthoof [not used] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22284
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22284;
-- OLD name : 閒置的惡魔劫奪者
-- Source : https://www.wowhead.com/wotlk/tw/npc=22293
UPDATE `creature_template_locale` SET `Name` = '閒置的惡魔搶奪者' WHERE `locale` = 'zhTW' AND `entry` = 22293;
-- OLD name : 洞穴爬行蛛
-- Source : https://www.wowhead.com/wotlk/tw/npc=22306
UPDATE `creature_template_locale` SET `Name` = '洞穴爬行飛掠者' WHERE `locale` = 'zhTW' AND `entry` = 22306;
-- OLD name : [DND]Green Spot Grog Keg Relay (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22349
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22349;
-- OLD name : [DND]Green Spot Grog Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22356
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22356;
-- OLD name : 黑暗領主·哈瑪拉克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22361
UPDATE `creature_template_locale` SET `Name` = '黑暗領主‧哈瑪拉克' WHERE `locale` = 'zhTW' AND `entry` = 22361;
-- OLD name : [DND]Ripe Moonshine Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22367
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22367;
-- OLD name : [DND]Fermented Seed Beer Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22368
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22368;
-- OLD name : [DND]Bloodmaul Chatter Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22383
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22383;
-- OLD name : 血槌預卜者
-- Source : https://www.wowhead.com/wotlk/tw/npc=22384
UPDATE `creature_template_locale` SET `Name` = '血槌預言者' WHERE `locale` = 'zhTW' AND `entry` = 22384;
-- OLD name : 榮譽堡獅鷲準將，北方
-- Source : https://www.wowhead.com/wotlk/tw/npc=22404
UPDATE `creature_template_locale` SET `Name` = '榮譽堡獅鷲準將 , 北方' WHERE `locale` = 'zhTW' AND `entry` = 22404;
-- OLD name : 榮譽堡獅鷲準將，熔爐
-- Source : https://www.wowhead.com/wotlk/tw/npc=22405
UPDATE `creature_template_locale` SET `Name` = '榮譽堡獅鷲準將 , 熔爐' WHERE `locale` = 'zhTW' AND `entry` = 22405;
-- OLD name : 榮譽堡獅鷲準將，山麓小丘
-- Source : https://www.wowhead.com/wotlk/tw/npc=22406
UPDATE `creature_template_locale` SET `Name` = '榮譽堡獅鷲準將 , 山麓小丘' WHERE `locale` = 'zhTW' AND `entry` = 22406;
-- OLD name : 遠征隊先遣騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=22410
UPDATE `creature_template_locale` SET `Name` = '遠征隊騎兵' WHERE `locale` = 'zhTW' AND `entry` = 22410;
-- OLD name : 傑·諾斯利 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22433
UPDATE `creature_template_locale` SET `Name` = '傑‧諾斯利' WHERE `locale` = 'zhTW' AND `entry` = 22433;
-- OLD name : [DND]Ogre Pike Planted Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22434
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22434;
-- OLD name : [DND]Rexxar's Wyvern Freed Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22435
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22435;
-- OLD name : [DND]Sablemane's Trap Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22447
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22447;
-- OLD name : 再活化的主教
-- Source : https://www.wowhead.com/wotlk/tw/npc=22452
UPDATE `creature_template_locale` SET `Name` = '複生的主教' WHERE `locale` = 'zhTW' AND `entry` = 22452;
-- OLD name : 史貝瑞
-- Source : https://www.wowhead.com/wotlk/tw/npc=22460
UPDATE `creature_template_locale` SET `Name` = '鬼魂' WHERE `locale` = 'zhTW' AND `entry` = 22460;
-- OLD name : 第I型惡魔火砲
-- Source : https://www.wowhead.com/wotlk/tw/npc=22461
UPDATE `creature_template_locale` SET `Name` = 'MKI型惡魔火砲' WHERE `locale` = 'zhTW' AND `entry` = 22461;
-- OLD name : 永恆樹林古樹
-- Source : https://www.wowhead.com/wotlk/tw/npc=22478
UPDATE `creature_template_locale` SET `Name` = '永恆樹林先祖' WHERE `locale` = 'zhTW' AND `entry` = 22478;
-- OLD subname : 遠征隊領袖
-- Source : https://www.wowhead.com/wotlk/tw/npc=22481
UPDATE `creature_template_locale` SET `Title` = '遠征隊領導者' WHERE `locale` = 'zhTW' AND `entry` = 22481;
-- OLD name : 卡伯·衝扳
-- Source : https://www.wowhead.com/wotlk/tw/npc=22491
UPDATE `creature_template_locale` SET `Name` = '卡伯·衝板' WHERE `locale` = 'zhTW' AND `entry` = 22491;
-- OLD name : 史貝瑞
-- Source : https://www.wowhead.com/wotlk/tw/npc=22492
UPDATE `creature_template_locale` SET `Name` = '魂' WHERE `locale` = 'zhTW' AND `entry` = 22492;
-- OLD name : [DND]Prophecy 1 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22798
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22798;
-- OLD name : [DND]Prophecy 2 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22799
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22799;
-- OLD name : [DND]Prophecy 3 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22800
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22800;
-- OLD name : [DND]Prophecy 4 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22801
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22801;
-- OLD name : 失落的巨行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=22807
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 22807;
-- OLD name : 以太皇族復仇者
-- Source : https://www.wowhead.com/wotlk/tw/npc=22821
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩復仇者' WHERE `locale` = 'zhTW' AND `entry` = 22821;
-- OLD name : 以太皇族淨化者
-- Source : https://www.wowhead.com/wotlk/tw/npc=22822
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩淨化者' WHERE `locale` = 'zhTW' AND `entry` = 22822;
-- OLD name : 以太皇族巨刃者
-- Source : https://www.wowhead.com/wotlk/tw/npc=22824
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩巨刃者' WHERE `locale` = 'zhTW' AND `entry` = 22824;
-- OLD name : 泰朗·血魔 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22871
UPDATE `creature_template_locale` SET `Name` = '泰朗‧血魔' WHERE `locale` = 'zhTW' AND `entry` = 22871;
-- OLD name : 考斯卡爭吵者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22877
UPDATE `creature_template_locale` SET `Name` = '考斯卡馴獸師' WHERE `locale` = 'zhTW' AND `entry` = 22877;
-- OLD name : 『食人妖僕從』烏丁
-- Source : https://www.wowhead.com/wotlk/tw/npc=22893
UPDATE `creature_template_locale` SET `Name` = '食人妖僕人伍德林' WHERE `locale` = 'zhTW' AND `entry` = 22893;
-- OLD name : 碎裂的靈魂
-- Source : https://www.wowhead.com/wotlk/tw/npc=22912
UPDATE `creature_template_locale` SET `Name` = '分裂靈魂' WHERE `locale` = 'zhTW' AND `entry` = 22912;
-- OLD name : 伊利丹·怒風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22917
UPDATE `creature_template_locale` SET `Name` = '伊利丹‧怒風' WHERE `locale` = 'zhTW' AND `entry` = 22917;
-- OLD name : 以太皇族囚犯(地城能量球)
-- Source : https://www.wowhead.com/wotlk/tw/npc=22927
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩囚犯(地下城能量球)' WHERE `locale` = 'zhTW' AND `entry` = 22927;
-- OLD name : 神廟侍妾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22939
UPDATE `creature_template_locale` SET `Name` = '神廟侍僧' WHERE `locale` = 'zhTW' AND `entry` = 22939;
-- OLD name : [UNUSED] Illidari Hound [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22944
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22944;
-- OLD name : 葛塔格·血沸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22948
UPDATE `creature_template_locale` SET `Name` = '葛塔格‧血沸' WHERE `locale` = 'zhTW' AND `entry` = 22948;
-- OLD name : 維拉斯·深影 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22952
UPDATE `creature_template_locale` SET `Name` = '維拉斯‧深影' WHERE `locale` = 'zhTW' AND `entry` = 22952;
-- OLD name : 迷人的交際花 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22955
UPDATE `creature_template_locale` SET `Name` = '迷人的客人' WHERE `locale` = 'zhTW' AND `entry` = 22955;
-- OLD name : 痛苦之女 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22956
UPDATE `creature_template_locale` SET `Name` = '痛苦祭司' WHERE `locale` = 'zhTW' AND `entry` = 22956;
-- OLD name : 退化女祭司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22957
UPDATE `creature_template_locale` SET `Name` = '癲狂之女' WHERE `locale` = 'zhTW' AND `entry` = 22957;
-- OLD name : 錮法侍者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22959
UPDATE `creature_template_locale` SET `Name` = '熱情招待者' WHERE `locale` = 'zhTW' AND `entry` = 22959;
-- OLD name : [UNUSED] Harem Girl 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=22961
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 22961;
-- OLD name : 喜樂女祭司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22962
UPDATE `creature_template_locale` SET `Name` = '悲痛之女' WHERE `locale` = 'zhTW' AND `entry` = 22962;
-- OLD name : 歡愉之女 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22964
UPDATE `creature_template_locale` SET `Name` = '歡愉祭司' WHERE `locale` = 'zhTW' AND `entry` = 22964;
-- OLD name : 受制的奴僕 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22965
UPDATE `creature_template_locale` SET `Name` = '忠實的管家' WHERE `locale` = 'zhTW' AND `entry` = 22965;
-- OLD name : 聖光之誓伊萊克
-- Source : https://www.wowhead.com/wotlk/tw/npc=22966
UPDATE `creature_template_locale` SET `Name` = '聖光之誓伊萊克騎士' WHERE `locale` = 'zhTW' AND `entry` = 22966;
-- OLD name : 瑪翼夫·影歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=22989
UPDATE `creature_template_locale` SET `Name` = '瑪翼夫‧影歌' WHERE `locale` = 'zhTW' AND `entry` = 22989;
-- OLD name : 瑞茲爾·滑鏈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23002
UPDATE `creature_template_locale` SET `Name` = '瑞茲爾‧滑鏈' WHERE `locale` = 'zhTW' AND `entry` = 23002;
-- OLD name : 喬·蘭姆西 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23003
UPDATE `creature_template_locale` SET `Name` = '喬‧蘭姆西' WHERE `locale` = 'zhTW' AND `entry` = 23003;
-- OLD name : 以太皇族獄卒
-- Source : https://www.wowhead.com/wotlk/tw/npc=23008
UPDATE `creature_template_locale` SET `Name` = '伊斯利恩獄卒' WHERE `locale` = 'zhTW' AND `entry` = 23008;
-- OLD name : 貝司比·響囊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23009
UPDATE `creature_template_locale` SET `Name` = '貝司買‧叮叮袋' WHERE `locale` = 'zhTW' AND `entry` = 23009;
-- OLD name : 沃格蘭·響囊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23010
UPDATE `creature_template_locale` SET `Name` = '沃爾格蘭‧叮叮袋' WHERE `locale` = 'zhTW' AND `entry` = 23010;
-- OLD name : 摩許爾茲·考伯賓奇 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23011
UPDATE `creature_template_locale` SET `Name` = '摩許爾茲‧考伯賓奇' WHERE `locale` = 'zhTW' AND `entry` = 23011;
-- OLD name : 哈托彼克·考伯賓奇 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23012
UPDATE `creature_template_locale` SET `Name` = '哈托彼克‧考伯賓奇' WHERE `locale` = 'zhTW' AND `entry` = 23012;
-- OLD name : 隱形巡者(飄浮)
-- Source : https://www.wowhead.com/wotlk/tw/npc=23033
UPDATE `creature_template_locale` SET `Name` = '隱形行者(飄浮)' WHERE `locale` = 'zhTW' AND `entry` = 23033;
-- OLD name : 凱爾薩斯·逐日者, subname : 血精靈領主 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23054
UPDATE `creature_template_locale` SET `Name` = '凱爾薩斯‧逐日者',`Title` = '血精靈之王' WHERE `locale` = 'zhTW' AND `entry` = 23054;
-- OLD name : 伊比·響囊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23064
UPDATE `creature_template_locale` SET `Name` = '伊比尤西‧叮叮袋' WHERE `locale` = 'zhTW' AND `entry` = 23064;
-- OLD name : 歐納維·考伯賓奇 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23065
UPDATE `creature_template_locale` SET `Name` = '歐納維‧考伯賓奇' WHERE `locale` = 'zhTW' AND `entry` = 23065;
-- OLD name : 魔爪祭司史奇吉克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23067
UPDATE `creature_template_locale` SET `Name` = '魔爪祭司史基茲克' WHERE `locale` = 'zhTW' AND `entry` = 23067;
-- OLD name : [PH]擊倒惡魔火砲假人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23077
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23077;
-- OLD name : 食人妖高頂巡者
-- Source : https://www.wowhead.com/wotlk/tw/npc=23090
UPDATE `creature_template_locale` SET `Name` = '食人妖高頂行者' WHERE `locale` = 'zhTW' AND `entry` = 23090;
-- OLD name : 幽靈形體 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23111
UPDATE `creature_template_locale` SET `Name` = '幽暗靈體' WHERE `locale` = 'zhTW' AND `entry` = 23111;
-- OLD name : [UNUSED] Boss Teron Gorefiend (Mounted) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23126
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23126;
-- OLD name : [PH]惡魔犬 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23138
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23138;
-- OLD name : 監工瓦庫歐·龍息 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23140
UPDATE `creature_template_locale` SET `Name` = '監工瓦庫歐‧龍息' WHERE `locale` = 'zhTW' AND `entry` = 23140;
-- OLD subname : NONE (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23151
UPDATE `creature_template_locale` SET `Title` = 'SPAWNING IS INCOMPLETE HERE, BROTHER!' WHERE `locale` = 'zhTW' AND `entry` = 23151;
-- OLD name : 法債奴隸
-- Source : https://www.wowhead.com/wotlk/tw/npc=23154
UPDATE `creature_template_locale` SET `Name` = '法力之罪奴隸' WHERE `locale` = 'zhTW' AND `entry` = 23154;
-- OLD name : 噬骨者巨獸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23196
UPDATE `creature_template_locale` SET `Name` = '噬骨者魔化兵' WHERE `locale` = 'zhTW' AND `entry` = 23196;
-- OLD name : 瑪翼夫·影歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23197
UPDATE `creature_template_locale` SET `Name` = '瑪翼夫‧影歌' WHERE `locale` = 'zhTW' AND `entry` = 23197;
-- OLD name : 莫阿格施刑者
-- Source : https://www.wowhead.com/wotlk/tw/npc=23212
UPDATE `creature_template_locale` SET `Name` = '莫阿格糾纏者' WHERE `locale` = 'zhTW' AND `entry` = 23212;
-- OLD name : 希瓦拉刺客
-- Source : https://www.wowhead.com/wotlk/tw/npc=23220
UPDATE `creature_template_locale` SET `Name` = '女妖刺客' WHERE `locale` = 'zhTW' AND `entry` = 23220;
-- OLD name : [UNUSED] Mutant Commander [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23238
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23238;
-- OLD name : [PH]憤怒獵犬變形 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23276
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23276;
-- OLD name : [PH] PvP火砲 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23314
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23314;
-- OLD name : [PH] PvP Cannon Shot Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23315
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23315;
-- OLD name : [PH] PvP Cannon Targetting Reticle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23317
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23317;
-- OLD name : 雷·晨星 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23331
UPDATE `creature_template_locale` SET `Name` = '雷‧晨星' WHERE `locale` = 'zhTW' AND `entry` = 23331;
-- OLD name : 莫格·老邁克喬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23340
UPDATE `creature_template_locale` SET `Name` = '莫格‧老邁克喬' WHERE `locale` = 'zhTW' AND `entry` = 23340;
-- OLD name : 甘納格分析者
-- Source : https://www.wowhead.com/wotlk/tw/npc=23386
UPDATE `creature_template_locale` SET `Name` = '甘納格分解者' WHERE `locale` = 'zhTW' AND `entry` = 23386;
-- OLD subname : 聯盟的經典鎖甲與鎧甲
-- Source : https://www.wowhead.com/wotlk/tw/npc=23396
UPDATE `creature_template_locale` SET `Title` = '競技場商人' WHERE `locale` = 'zhTW' AND `entry` = 23396;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/tw/npc=23405
UPDATE `creature_template_locale` SET `Title` = 'PTR消耗品' WHERE `locale` = 'zhTW' AND `entry` = 23405;
-- OLD name : 吉米·麥克威醬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23406
UPDATE `creature_template_locale` SET `Name` = '吉米‧麥克威醬' WHERE `locale` = 'zhTW' AND `entry` = 23406;
-- OLD name : 強尼·麥克威醬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23407
UPDATE `creature_template_locale` SET `Name` = '強尼‧麥克威醬' WHERE `locale` = 'zhTW' AND `entry` = 23407;
-- OLD name : 伊利丹·怒風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23467
UPDATE `creature_template_locale` SET `Name` = '伊利丹‧怒風' WHERE `locale` = 'zhTW' AND `entry` = 23467;
-- OLD name : 女妖刺客 (紅色) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23474
UPDATE `creature_template_locale` SET `Name` = '希娃女妖刺客 (紅色)' WHERE `locale` = 'zhTW' AND `entry` = 23474;
-- OLD name : 女妖刺客 (藍色) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23475
UPDATE `creature_template_locale` SET `Name` = '希娃女妖刺客 (藍色)' WHERE `locale` = 'zhTW' AND `entry` = 23475;
-- OLD name : 女妖刺客 (黑色) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23476
UPDATE `creature_template_locale` SET `Name` = '希娃女妖刺客 (黑色)' WHERE `locale` = 'zhTW' AND `entry` = 23476;
-- OLD name : [PH] Brewfest Dwarf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23479
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23479;
-- OLD name : [PH] Brewfest Human Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23480
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23480;
-- OLD name : 凱蘭·唐納修 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23481
UPDATE `creature_template_locale` SET `Name` = '凱蘭‧唐納修' WHERE `locale` = 'zhTW' AND `entry` = 23481;
-- OLD name : 茍達克·狙獵者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23486
UPDATE `creature_template_locale` SET `Name` = '苟達克‧狙獵者' WHERE `locale` = 'zhTW' AND `entry` = 23486;
-- OLD name : 跩格·麥酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23497
UPDATE `creature_template_locale` SET `Name` = '跩格‧麥酒' WHERE `locale` = 'zhTW' AND `entry` = 23497;
-- OLD name : 吉米·雙舟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23520
UPDATE `creature_template_locale` SET `Name` = '吉米‧雙舟' WHERE `locale` = 'zhTW' AND `entry` = 23520;
-- OLD name : 安·桑默思 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23521
UPDATE `creature_template_locale` SET `Name` = '安‧桑默思' WHERE `locale` = 'zhTW' AND `entry` = 23521;
-- OLD name : 亞連·隆克蘭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23522
UPDATE `creature_template_locale` SET `Name` = '亞連‧隆克蘭' WHERE `locale` = 'zhTW' AND `entry` = 23522;
-- OLD name : [PH] Brewfest Garden D Vendor (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23532
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23532;
-- OLD name : [PH] Brewfest Goblin Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23540
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23540;
-- OLD name : 凱爾·雷度 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23544
UPDATE `creature_template_locale` SET `Name` = '凱爾‧雷度' WHERE `locale` = 'zhTW' AND `entry` = 23544;
-- OLD subname : 暴風城皇家科學協會
-- Source : https://www.wowhead.com/wotlk/tw/npc=23549
UPDATE `creature_template_locale` SET `Title` = '皇家暴風科學協會' WHERE `locale` = 'zhTW' AND `entry` = 23549;
-- OLD name : 奈爾·拉姆斯登 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23558
UPDATE `creature_template_locale` SET `Name` = '奈爾‧拉姆斯登' WHERE `locale` = 'zhTW' AND `entry` = 23558;
-- OLD name : 霸德
-- Source : https://www.wowhead.com/wotlk/tw/npc=23559
UPDATE `creature_template_locale` SET `Name` = '霸德·奈德瑞克' WHERE `locale` = 'zhTW' AND `entry` = 23559;
-- OLD name : 補給官亞米娜
-- Source : https://www.wowhead.com/wotlk/tw/npc=23560
UPDATE `creature_template_locale` SET `Name` = '物資供應者亞米娜' WHERE `locale` = 'zhTW' AND `entry` = 23560;
-- OLD subname : 盜賊訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=23566
UPDATE `creature_template_locale` SET `Title` = '軍情七處' WHERE `locale` = 'zhTW' AND `entry` = 23566;
-- OLD subname : 熊化身
-- Source : https://www.wowhead.com/wotlk/tw/npc=23576
UPDATE `creature_template_locale` SET `Title` = '<熊化身>' WHERE `locale` = 'zhTW' AND `entry` = 23576;
-- OLD subname : 山貓化身
-- Source : https://www.wowhead.com/wotlk/tw/npc=23577
UPDATE `creature_template_locale` SET `Title` = '<山貓化身>' WHERE `locale` = 'zhTW' AND `entry` = 23577;
-- OLD name : 恐怖圖騰縛地者
-- Source : https://www.wowhead.com/wotlk/tw/npc=23595
UPDATE `creature_template_locale` SET `Name` = '恐怖圖騰大地束縳者' WHERE `locale` = 'zhTW' AND `entry` = 23595;
-- OLD name : [PH] New Hinterlands NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23599
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23599;
-- OLD name : 烏塔·粗麵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23603
UPDATE `creature_template_locale` SET `Name` = '烏塔‧粗麵' WHERE `locale` = 'zhTW' AND `entry` = 23603;
-- OLD name : 阿妮絲·遠胛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23604
UPDATE `creature_template_locale` SET `Name` = '阿妮絲‧遠胛' WHERE `locale` = 'zhTW' AND `entry` = 23604;
-- OLD name : [PH] Brewfest Orc Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23607
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23607;
-- OLD name : [PH] Brewfest Tauren Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23608
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23608;
-- OLD name : [PH] Brewfest Troll Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23609
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23609;
-- OLD name : [PH] Brewfest Blood Elf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23610
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23610;
-- OLD name : [PH] Brewfest Undead Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23611
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23611;
-- OLD name : [PH] Brewfest Draenei Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23613
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23613;
-- OLD name : [PH] Brewfest Gnome Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23614
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23614;
-- OLD name : [PH] Brewfest Night Elf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23615
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23615;
-- OLD name : 狂亂的凱爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=23616
UPDATE `creature_template_locale` SET `Name` = '狂怒的凱爾' WHERE `locale` = 'zhTW' AND `entry` = 23616;
-- OLD name : 畢肯·麥酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23627
UPDATE `creature_template_locale` SET `Name` = '畢肯‧麥酒' WHERE `locale` = 'zhTW' AND `entry` = 23627;
-- OLD name : 達然·雷酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23628
UPDATE `creature_template_locale` SET `Name` = '達然‧雷酒' WHERE `locale` = 'zhTW' AND `entry` = 23628;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23629
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23629;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE B (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23630
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23630;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE C (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23631
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23631;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE D (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23632
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23632;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE E (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23633
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23633;
-- OLD name : [PH] Darkmoon Faire Carnie APPEARANCE F (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23634
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23634;
-- OLD name : 瑪伊芙·麥酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23683
UPDATE `creature_template_locale` SET `Name` = '瑪伊芙‧麥酒' WHERE `locale` = 'zhTW' AND `entry` = 23683;
-- OLD name : 意塔·雷酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23684
UPDATE `creature_template_locale` SET `Name` = '意塔‧雷酒' WHERE `locale` = 'zhTW' AND `entry` = 23684;
-- OLD name : 暗翼雄鷹 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23693
UPDATE `creature_template_locale` SET `Name` = '暮翼雄鷹' WHERE `locale` = 'zhTW' AND `entry` = 23693;
-- OLD name : [DND] Brewfest Dark Iron Event Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23703
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23703;
-- OLD name : 貝爾碧·迅移 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23710
UPDATE `creature_template_locale` SET `Name` = '貝爾碧‧迅移' WHERE `locale` = 'zhTW' AND `entry` = 23710;
-- OLD name : 莎夏·歌恩斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23722
UPDATE `creature_template_locale` SET `Name` = '莎夏‧歌恩斯' WHERE `locale` = 'zhTW' AND `entry` = 23722;
-- OLD name : 哈洛德·拉格銳思 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23730
UPDATE `creature_template_locale` SET `Name` = '哈洛德‧拉格銳思' WHERE `locale` = 'zhTW' AND `entry` = 23730;
-- OLD name : 旅店老闆哈索爾·拉格銳思, subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=23731
UPDATE `creature_template_locale` SET `Name` = '旅館老闆哈索爾·拉格銳思',`Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 23731;
-- OLD subname : 急救訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=23734
UPDATE `creature_template_locale` SET `Title` = '宗師級急救訓練師' WHERE `locale` = 'zhTW' AND `entry` = 23734;
-- OLD name : 北方帳篷
-- Source : https://www.wowhead.com/wotlk/tw/npc=23751
UPDATE `creature_template_locale` SET `Name` = '北方帳棚' WHERE `locale` = 'zhTW' AND `entry` = 23751;
-- OLD name : 東北方帳篷
-- Source : https://www.wowhead.com/wotlk/tw/npc=23752
UPDATE `creature_template_locale` SET `Name` = '東北方帳棚' WHERE `locale` = 'zhTW' AND `entry` = 23752;
-- OLD name : 東方帳篷
-- Source : https://www.wowhead.com/wotlk/tw/npc=23753
UPDATE `creature_template_locale` SET `Name` = '東方帳棚' WHERE `locale` = 'zhTW' AND `entry` = 23753;
-- OLD name : 希瓦娜斯·風行者(高等精靈) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23765
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者(高等精靈)' WHERE `locale` = 'zhTW' AND `entry` = 23765;
-- OLD name : 衛克沙·幼龍看守者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23788
UPDATE `creature_template_locale` SET `Name` = '衛克沙‧幼龍看守者' WHERE `locale` = 'zhTW' AND `entry` = 23788;
-- OLD name : [DND] Brewfest Keg Move to Target (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23808
UPDATE `creature_template_locale` SET `Name` = 'Brewfest Keg Move to Target' WHERE `locale` = 'zhTW' AND `entry` = 23808;
-- OLD name : [PH] Brewfest Dwarf Male Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23819
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23819;
-- OLD name : [PH] Brewfest Dwarf Female Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23820
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23820;
-- OLD name : [PH] Brewfest Goblin Female Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23824
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23824;
-- OLD name : [PH] Brewfest Goblin Male Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23825
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23825;
-- OLD name : [DND] L70ETC FX Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23830
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23830;
-- OLD name : [DND] L70ETC Bergrisst Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23845
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23845;
-- OLD name : [DND] L70ETC Concert Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23850
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23850;
-- OLD name : [DND] L70ETC Mai'Kyl Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23852
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23852;
-- OLD name : [DND] L70ETC Samuro Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23853
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23853;
-- OLD name : [DND] L70ETC Sig Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23854
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23854;
-- OLD name : [DND] L70ETC Chief Thunder-Skins Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23855
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23855;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/tw/npc=23862
UPDATE `creature_template_locale` SET `Title` = '彈藥商' WHERE `locale` = 'zhTW' AND `entry` = 23862;
-- OLD name : 祖爾金, subname : NONE (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23863
UPDATE `creature_template_locale` SET `Name` = '達卡拉',`Title` = '無敵' WHERE `locale` = 'zhTW' AND `entry` = 23863;
-- OLD name : 寇仁·恐酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23872
UPDATE `creature_template_locale` SET `Name` = '寇仁‧恐酒' WHERE `locale` = 'zhTW' AND `entry` = 23872;
-- OLD name : 監督者艾琳娜·石衣 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23891
UPDATE `creature_template_locale` SET `Name` = '監督者艾琳娜‧石衣' WHERE `locale` = 'zhTW' AND `entry` = 23891;
-- OLD name : [DND] Brewfest Dark Iron Spawn Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23894
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23894;
-- OLD name : 『骯髒』麥可·克羅威, subname : 釣魚訓練師和供應商
-- Source : https://www.wowhead.com/wotlk/tw/npc=23896
UPDATE `creature_template_locale` SET `Name` = '『骯髒』米凱爾·克羅威',`Title` = '魚商' WHERE `locale` = 'zhTW' AND `entry` = 23896;
-- OLD name : [DNT]TEST Pet Moth (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=23936
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 23936;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=23937
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 23937;
-- OLD name : 火鬃飛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=23969
UPDATE `creature_template_locale` SET `Name` = '火鬃龍' WHERE `locale` = 'zhTW' AND `entry` = 23969;
-- OLD name : 賽波·鋼環 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=23976
UPDATE `creature_template_locale` SET `Name` = '賽波‧鋼環' WHERE `locale` = 'zhTW' AND `entry` = 23976;
-- OLD name : 攻城工人
-- Source : https://www.wowhead.com/wotlk/tw/npc=24005
UPDATE `creature_template_locale` SET `Name` = '磨坊工人' WHERE `locale` = 'zhTW' AND `entry` = 24005;
-- OLD name : 塔魯·霜蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24028
UPDATE `creature_template_locale` SET `Name` = '塔魯‧霜蹄' WHERE `locale` = 'zhTW' AND `entry` = 24028;
-- OLD name : 賽利亞·冰鬃, subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24032
UPDATE `creature_template_locale` SET `Name` = '賽利亞‧冰鬃',`Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 24032;
-- OLD name : 寶利·冬季圖騰 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24033
UPDATE `creature_template_locale` SET `Name` = '寶利‧冬季圖騰' WHERE `locale` = 'zhTW' AND `entry` = 24033;
-- OLD name : 史盔吉·獵像者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24048
UPDATE `creature_template_locale` SET `Name` = '史盔吉‧獵像者' WHERE `locale` = 'zhTW' AND `entry` = 24048;
-- OLD name : 海爾嘉·蘭姆剋星 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24053
UPDATE `creature_template_locale` SET `Name` = '海爾嘉‧蘭姆剋星' WHERE `locale` = 'zhTW' AND `entry` = 24053;
-- OLD name : 巴拉爾·蘭姆剋星 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24054
UPDATE `creature_template_locale` SET `Name` = '巴拉爾‧蘭姆剋星' WHERE `locale` = 'zhTW' AND `entry` = 24054;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=24057
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 24057;
-- OLD name : 瑪哈那·霜蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24067
UPDATE `creature_template_locale` SET `Name` = '瑪哈那‧霜蹄' WHERE `locale` = 'zhTW' AND `entry` = 24067;
-- OLD name : [DND] Brewfest Target Dummy Move To Target (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24109
UPDATE `creature_template_locale` SET `Name` = 'Brewfest Target Dummy Move To Target' WHERE `locale` = 'zhTW' AND `entry` = 24109;
-- OLD name : 諾可瑪·雪先知 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24123
UPDATE `creature_template_locale` SET `Name` = '諾可瑪‧雪先知' WHERE `locale` = 'zhTW' AND `entry` = 24123;
-- OLD name : 阿喉塔·白霜 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24127
UPDATE `creature_template_locale` SET `Name` = '阿喉塔‧白霜' WHERE `locale` = 'zhTW' AND `entry` = 24127;
-- OLD name : 冬蹄飛龍騎士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24132
UPDATE `creature_template_locale` SET `Name` = '冬蹄蠍尾獅騎士' WHERE `locale` = 'zhTW' AND `entry` = 24132;
-- OLD name : 吉爾·葛瑞斯特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24139
UPDATE `creature_template_locale` SET `Name` = '吉爾‧葛瑞斯特' WHERE `locale` = 'zhTW' AND `entry` = 24139;
-- OLD name : 史帝芬·巴羅內 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24141
UPDATE `creature_template_locale` SET `Name` = '史帝芬‧巴羅內' WHERE `locale` = 'zhTW' AND `entry` = 24141;
-- OLD name : 冬蹄營地飛龍騎士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24142
UPDATE `creature_template_locale` SET `Name` = '冬蹄營地蠍尾獅騎士' WHERE `locale` = 'zhTW' AND `entry` = 24142;
-- OLD name : 塔拉·庫珀 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24147
UPDATE `creature_template_locale` SET `Name` = '塔拉‧庫珀' WHERE `locale` = 'zhTW' AND `entry` = 24147;
-- OLD name : 大衛·馬克思 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24148
UPDATE `creature_template_locale` SET `Name` = '大衛‧馬克思' WHERE `locale` = 'zhTW' AND `entry` = 24148;
-- OLD name : 巴希爾·奧斯古 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24149
UPDATE `creature_template_locale` SET `Name` = '巴希爾‧奧斯古' WHERE `locale` = 'zhTW' AND `entry` = 24149;
-- OLD name : 瑪麗·達隆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24154
UPDATE `creature_template_locale` SET `Name` = '瑪麗‧達隆' WHERE `locale` = 'zhTW' AND `entry` = 24154;
-- OLD name : 托比亞斯·薩克霍夫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24155
UPDATE `creature_template_locale` SET `Name` = '托比亞斯‧薩克霍夫' WHERE `locale` = 'zhTW' AND `entry` = 24155;
-- OLD name : 古拿·索瓦德森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24162
UPDATE `creature_template_locale` SET `Name` = '古拿‧索瓦德森' WHERE `locale` = 'zhTW' AND `entry` = 24162;
-- OLD name : 米迦·碎石 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24168
UPDATE `creature_template_locale` SET `Name` = '米迦‧碎石' WHERE `locale` = 'zhTW' AND `entry` = 24168;
-- OLD name : [DND] Darkmoon Faire Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24171
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24171;
-- OLD name : [UNUSED]Ghost of Explorer Jaren (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24181
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge B' WHERE `locale` = 'zhTW' AND `entry` = 24181;
-- OLD subname : 補給官
-- Source : https://www.wowhead.com/wotlk/tw/npc=24188
UPDATE `creature_template_locale` SET `Title` = '物資供應者' WHERE `locale` = 'zhTW' AND `entry` = 24188;
-- OLD name : [DND] Brewfest Barker Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24202
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24202;
-- OLD name : [DND] Brewfest Barker Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24203
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24203;
-- OLD name : [DND] Brewfest Barker Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24204
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24204;
-- OLD name : [DND] Brewfest Barker Bunny 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24205
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24205;
-- OLD name : 亡靈大軍
-- Source : https://www.wowhead.com/wotlk/tw/npc=24207
UPDATE `creature_template_locale` SET `Name` = '食屍鬼大軍' WHERE `locale` = 'zhTW' AND `entry` = 24207;
-- OLD name : [DND] Darkmoon Faire Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24220
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24220;
-- OLD name : 大領主提里奧·弗丁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24232
UPDATE `creature_template_locale` SET `Name` = '大領主提里奧‧弗丁' WHERE `locale` = 'zhTW' AND `entry` = 24232;
-- OLD name : 畢雍·海格德森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24238
UPDATE `creature_template_locale` SET `Name` = '畢雍‧海格德森' WHERE `locale` = 'zhTW' AND `entry` = 24238;
-- OLD name : 艾利森·安第列 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24240
UPDATE `creature_template_locale` SET `Name` = '艾利森‧安第列' WHERE `locale` = 'zhTW' AND `entry` = 24240;
-- OLD name : 維酷的靈魂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24262
UPDATE `creature_template_locale` SET `Name` = '維酷人的靈魂' WHERE `locale` = 'zhTW' AND `entry` = 24262;
-- OLD name : [DND] Brewfest Speed Bunny Green (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24263
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24263;
-- OLD name : [DND] Brewfest Speed Bunny Yellow (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24264
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24264;
-- OLD name : [DND] Brewfest Speed Bunny Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24265
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24265;
-- OLD name : [PH] Gossip NPC Human Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24292
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24292;
-- OLD name : [PH] Gossip NPC Human Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24293
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24293;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24294
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24294;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24295
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24295;
-- OLD name : [PH] Gossip NPC Draenei Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24296
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24296;
-- OLD name : [PH] Gossip NPC Draenei Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24297
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24297;
-- OLD name : [PH] Gossip NPC Dwarf Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24298
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24298;
-- OLD name : [PH] Gossip NPC Dwarf Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24299
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24299;
-- OLD name : [PH] Gossip NPC Undead Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24300
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24300;
-- OLD name : [PH] Gossip NPC Undead Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24301
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24301;
-- OLD name : [PH] Gossip NPC Gnome Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24302
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24302;
-- OLD name : [PH] Gossip NPC Gnome Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24303
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24303;
-- OLD name : [PH] Gossip NPC Goblin Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24304
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24304;
-- OLD name : [PH] Gossip NPC Goblin Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24305
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24305;
-- OLD name : [PH] Gossip NPC Night Elf Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24306
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24306;
-- OLD name : [PH] Gossip NPC Night Elf Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24307
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24307;
-- OLD name : [PH] Gossip NPC Orc Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24308
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24308;
-- OLD name : [PH] Gossip NPC Orc Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24309
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24309;
-- OLD name : [PH] Gossip NPC Tauren Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24310
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24310;
-- OLD name : [PH] Gossip NPC Tauren Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24311
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24311;
-- OLD name : [PH]恐怖布娃娃 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24319
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24319;
-- OLD name : 歐森·洛奇 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24330
UPDATE `creature_template_locale` SET `Name` = '歐森‧洛奇' WHERE `locale` = 'zhTW' AND `entry` = 24330;
-- OLD name : 傑森·古韓奇, subname : 酒保
-- Source : https://www.wowhead.com/wotlk/tw/npc=24333
UPDATE `creature_template_locale` SET `Name` = '酒保傑森·古韓奇',`Title` = '飲料' WHERE `locale` = 'zhTW' AND `entry` = 24333;
-- OLD name : [DND] Brewfest Delivery Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24337
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24337;
-- OLD name : 巴納巴斯·富萊伊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24341
UPDATE `creature_template_locale` SET `Name` = '巴納巴斯‧富萊伊' WHERE `locale` = 'zhTW' AND `entry` = 24341;
-- OLD name : 提摩西·霍蘭德 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24342
UPDATE `creature_template_locale` SET `Name` = '提摩西‧霍蘭德' WHERE `locale` = 'zhTW' AND `entry` = 24342;
-- OLD name : 布洛克·歐爾森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24343
UPDATE `creature_template_locale` SET `Name` = '布洛克‧歐爾森' WHERE `locale` = 'zhTW' AND `entry` = 24343;
-- OLD name : 阿萊希斯·行者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24347
UPDATE `creature_template_locale` SET `Name` = '阿萊希斯‧行者' WHERE `locale` = 'zhTW' AND `entry` = 24347;
-- OLD name : 派崔克·豪爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24348
UPDATE `creature_template_locale` SET `Name` = '派崔克‧豪爾' WHERE `locale` = 'zhTW' AND `entry` = 24348;
-- OLD name : 潔西卡·伊凡斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24349
UPDATE `creature_template_locale` SET `Name` = '潔西卡‧伊凡斯' WHERE `locale` = 'zhTW' AND `entry` = 24349;
-- OLD name : 羅博特·克拉克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24350
UPDATE `creature_template_locale` SET `Name` = '羅博特‧克拉克' WHERE `locale` = 'zhTW' AND `entry` = 24350;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24351
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24351;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24352
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24352;
-- OLD name : 梅瑟·天影 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24357
UPDATE `creature_template_locale` SET `Name` = '梅瑟‧天影' WHERE `locale` = 'zhTW' AND `entry` = 24357;
-- OLD name : 哈里遜·瓊斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24358
UPDATE `creature_template_locale` SET `Name` = '哈里遜‧瓊斯' WHERE `locale` = 'zhTW' AND `entry` = 24358;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24360
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24360;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24361
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 24361;
-- OLD name : 弗萊恩·火酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24364
UPDATE `creature_template_locale` SET `Name` = '弗萊恩‧火酒' WHERE `locale` = 'zhTW' AND `entry` = 24364;
-- OLD name : 虛空巡者瑪頓恩
-- Source : https://www.wowhead.com/wotlk/tw/npc=24370
UPDATE `creature_template_locale` SET `Name` = '虛空行者瑪頓恩' WHERE `locale` = 'zhTW' AND `entry` = 24370;
-- OLD name : 哈里遜·瓊斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24375
UPDATE `creature_template_locale` SET `Name` = '哈里遜‧瓊斯' WHERE `locale` = 'zhTW' AND `entry` = 24375;
-- OLD name : [UNUSED]Vazruden Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24377
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge C' WHERE `locale` = 'zhTW' AND `entry` = 24377;
-- OLD name : [UNUSED]Nazan Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24378
UPDATE `creature_template_locale` SET `Name` = '"Back To Bladespire Fortress" Flight Kill Credit' WHERE `locale` = 'zhTW' AND `entry` = 24378;
-- OLD name : [VO]納羅拉克 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24382
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24382;
-- OLD name : [VO]阿奇爾森 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24383
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24383;
-- OLD name : [VO]哈拉齊 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24384
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24384;
-- OLD name : [VO]賈納雷 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24386
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24386;
-- OLD name : 利尼『微笑』斯莫斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=24392
UPDATE `creature_template_locale` SET `Name` = '「利尼『微笑』斯莫斯」' WHERE `locale` = 'zhTW' AND `entry` = 24392;
-- OLD name : 德利克斯·急嘯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24394
UPDATE `creature_template_locale` SET `Name` = '德利克斯‧急嘯' WHERE `locale` = 'zhTW' AND `entry` = 24394;
-- OLD subname : 競技場商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=24395
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 24395;
-- OLD name : 阿達拉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24405
UPDATE `creature_template_locale` SET `Name` = '艾達拉' WHERE `locale` = 'zhTW' AND `entry` = 24405;
-- OLD name : 盤牙部屬影像
-- Source : https://www.wowhead.com/wotlk/tw/npc=24415
UPDATE `creature_template_locale` SET `Name` = '盤牙侍從影像' WHERE `locale` = 'zhTW' AND `entry` = 24415;
-- OLD name : Invisible Man - No Weapons (Server Only/Hide Body)
-- Source : https://www.wowhead.com/wotlk/tw/npc=24417
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 24417;
-- OLD name : 黑色潛獵者影像
-- Source : https://www.wowhead.com/wotlk/tw/npc=24420
UPDATE `creature_template_locale` SET `Name` = '黑色捕獵者影像' WHERE `locale` = 'zhTW' AND `entry` = 24420;
-- OLD name : 裂隙領主影像
-- Source : https://www.wowhead.com/wotlk/tw/npc=24429
UPDATE `creature_template_locale` SET `Name` = '裂縫領主影像' WHERE `locale` = 'zhTW' AND `entry` = 24429;
-- OLD name : 艾里·爆鼻 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24451
UPDATE `creature_template_locale` SET `Name` = '艾里‧爆鼻' WHERE `locale` = 'zhTW' AND `entry` = 24451;
-- OLD name : 帕利·爆鼻 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24452
UPDATE `creature_template_locale` SET `Name` = '帕利‧爆鼻' WHERE `locale` = 'zhTW' AND `entry` = 24452;
-- OLD name : 泰爾達·風詠上尉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24456
UPDATE `creature_template_locale` SET `Name` = '泰爾達‧風詠上尉' WHERE `locale` = 'zhTW' AND `entry` = 24456;
-- OLD name : 藍色飄浮符文頻道兔子 01 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24465
UPDATE `creature_template_locale` SET `Name` = '藍色飄浮符文引導兔子 01' WHERE `locale` = 'zhTW' AND `entry` = 24465;
-- OLD name : 藍色飄浮符文頻道兔子 02 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24466
UPDATE `creature_template_locale` SET `Name` = '藍色飄浮符文引導兔子 02' WHERE `locale` = 'zhTW' AND `entry` = 24466;
-- OLD name : 保爾·安伯斯堤爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24468
UPDATE `creature_template_locale` SET `Name` = '保爾‧凍石' WHERE `locale` = 'zhTW' AND `entry` = 24468;
-- OLD name : [PH] Maldonado's Test Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24470
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24470;
-- OLD name : 熔爐火焰
-- Source : https://www.wowhead.com/wotlk/tw/npc=24471
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 24471;
-- OLD name : 布力克斯·修械 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24495
UPDATE `creature_template_locale` SET `Name` = '布力克斯‧修械' WHERE `locale` = 'zhTW' AND `entry` = 24495;
-- OLD name : 寇特·高斯坦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24498
UPDATE `creature_template_locale` SET `Name` = '寇特‧高斯坦' WHERE `locale` = 'zhTW' AND `entry` = 24498;
-- OLD name : 德瑞茲·迅跌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24510
UPDATE `creature_template_locale` SET `Name` = '德瑞茲‧迅跌' WHERE `locale` = 'zhTW' AND `entry` = 24510;
-- OLD name : 朵莉絲· 維蘭提斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24520
UPDATE `creature_template_locale` SET `Name` = '朵莉絲‧ 維蘭提斯' WHERE `locale` = 'zhTW' AND `entry` = 24520;
-- OLD name : 包克·滴確 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24527
UPDATE `creature_template_locale` SET `Name` = '包克‧滴確' WHERE `locale` = 'zhTW' AND `entry` = 24527;
-- OLD name : 紅眼的班 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24542
UPDATE `creature_template_locale` SET `Name` = '紅眼阿班' WHERE `locale` = 'zhTW' AND `entry` = 24542;
-- OLD name : 依拉瑪·火光 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24554
UPDATE `creature_template_locale` SET `Name` = '依拉瑪‧火光' WHERE `locale` = 'zhTW' AND `entry` = 24554;
-- OLD name : 卡嘉尼·夜擊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24557
UPDATE `creature_template_locale` SET `Name` = '卡嘉尼‧夜擊' WHERE `locale` = 'zhTW' AND `entry` = 24557;
-- OLD name : 艾爾里斯·聖暮 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24558
UPDATE `creature_template_locale` SET `Name` = '艾爾里斯‧聖暮' WHERE `locale` = 'zhTW' AND `entry` = 24558;
-- OLD name : [UNUSED]裂鞭撕掠者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24575
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24575;
-- OLD name : [UNUSED]裂鞭獵潮者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24577
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24577;
-- OLD name : [UNUSED] 裂鞭毒蛇守衛 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24578
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24578;
-- OLD name : [UNUSED] 裂鞭潮汐領主 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24579
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24579;
-- OLD name : [UNUSED] 凍原狼 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24617
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24617;
-- OLD name : [UNUSED] 原生凍原狼 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24620
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24620;
-- OLD name : 格瑞希克斯·斷紡 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24643
UPDATE `creature_template_locale` SET `Name` = '格瑞希克斯‧斷紡' WHERE `locale` = 'zhTW' AND `entry` = 24643;
-- OLD name : 葛羅卓克·獵狙者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24657
UPDATE `creature_template_locale` SET `Name` = '葛羅卓克‧獵狙者' WHERE `locale` = 'zhTW' AND `entry` = 24657;
-- OLD name : [PH] BLB Blue Blood Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24658
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24658;
-- OLD name : [UNUSED]裂鞭多頭蛇 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24661
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24661;
-- OLD name : 凱爾薩斯·逐日者, subname : 血精靈領主 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24664
UPDATE `creature_template_locale` SET `Name` = '凱爾薩斯‧逐日者',`Title` = '血精靈之王' WHERE `locale` = 'zhTW' AND `entry` = 24664;
-- OLD name : 冰錘中尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=24665
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 24665;
-- OLD name : 鄙惡者潛藏者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24688
UPDATE `creature_template_locale` SET `Name` = '惡癮者潛藏者' WHERE `locale` = 'zhTW' AND `entry` = 24688;
-- OLD name : 鄙惡者衛兵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24689
UPDATE `creature_template_locale` SET `Name` = '惡癮者衛兵' WHERE `locale` = 'zhTW' AND `entry` = 24689;
-- OLD name : 鄙惡者之軀 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24690
UPDATE `creature_template_locale` SET `Name` = '惡癮者之軀' WHERE `locale` = 'zhTW' AND `entry` = 24690;
-- OLD name : 德姆·冰隱 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24706
UPDATE `creature_template_locale` SET `Name` = '德姆‧冰隱' WHERE `locale` = 'zhTW' AND `entry` = 24706;
-- OLD name : 易菲克佛·鐵桶 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24710
UPDATE `creature_template_locale` SET `Name` = '易菲克佛‧鐵桶' WHERE `locale` = 'zhTW' AND `entry` = 24710;
-- OLD name : 泰伯·詐桶 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24711
UPDATE `creature_template_locale` SET `Name` = '泰伯‧詐桶' WHERE `locale` = 'zhTW' AND `entry` = 24711;
-- OLD name : 賽林·炎心 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24723
UPDATE `creature_template_locale` SET `Name` = '賽林‧炎心' WHERE `locale` = 'zhTW' AND `entry` = 24723;
-- OLD name : 泥濘黃蜂
-- Source : https://www.wowhead.com/wotlk/tw/npc=24731
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 24731;
-- OLD name : 愛蓮娜·伊度 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24734
UPDATE `creature_template_locale` SET `Name` = '愛蓮娜‧伊度' WHERE `locale` = 'zhTW' AND `entry` = 24734;
-- OLD name : 貝肯娜·伊度 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24735
UPDATE `creature_template_locale` SET `Name` = '貝肯娜‧伊度' WHERE `locale` = 'zhTW' AND `entry` = 24735;
-- OLD name : 蘇蘭·杜納黛爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24736
UPDATE `creature_template_locale` SET `Name` = '蘇蘭‧杜納黛爾' WHERE `locale` = 'zhTW' AND `entry` = 24736;
-- OLD name : 威廉·杜納黛爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24737
UPDATE `creature_template_locale` SET `Name` = '威廉‧杜納黛爾' WHERE `locale` = 'zhTW' AND `entry` = 24737;
-- OLD name : 伊蘭娜·伊度 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24738
UPDATE `creature_template_locale` SET `Name` = '伊蘭娜‧伊度' WHERE `locale` = 'zhTW' AND `entry` = 24738;
-- OLD name : 班傑利·伊度 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24739
UPDATE `creature_template_locale` SET `Name` = '班傑利‧伊度' WHERE `locale` = 'zhTW' AND `entry` = 24739;
-- OLD name : 古迪, subname : 伊蘭娜·伊度的寵物
-- Source : https://www.wowhead.com/wotlk/tw/npc=24740
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 24740;
-- OLD name : 安妮·波恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24741
UPDATE `creature_template_locale` SET `Name` = '安妮‧波恩' WHERE `locale` = 'zhTW' AND `entry` = 24741;
-- OLD name : 『瘋子』喬納·斯德林 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24742
UPDATE `creature_template_locale` SET `Name` = '『瘋子』喬納‧斯德林' WHERE `locale` = 'zhTW' AND `entry` = 24742;
-- OLD name : [DND] Brewfest Face Me Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24766
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24766;
-- OLD name : 虛弱的摩本特·費爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24782
UPDATE `creature_template_locale` SET `Name` = '虛弱的摩本特‧費爾' WHERE `locale` = 'zhTW' AND `entry` = 24782;
-- OLD name : 史加斗·霜首 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24784
UPDATE `creature_template_locale` SET `Name` = '史加斗‧霜首' WHERE `locale` = 'zhTW' AND `entry` = 24784;
-- OLD name : 傑克·亞當斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24788
UPDATE `creature_template_locale` SET `Name` = '傑克‧亞當斯' WHERE `locale` = 'zhTW' AND `entry` = 24788;
-- OLD name : 多茍利『小鬍子』船長 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24833
UPDATE `creature_template_locale` SET `Name` = '多苟利『小鬍子』船長' WHERE `locale` = 'zhTW' AND `entry` = 24833;
-- OLD name : 凱爾薩斯·逐日者影像, subname : 血精靈領主 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24855
UPDATE `creature_template_locale` SET `Name` = '凱爾薩斯‧逐日者影像',`Title` = '血精靈之王' WHERE `locale` = 'zhTW' AND `entry` = 24855;
-- OLD name : 迪菲亞海賊，女性
-- Source : https://www.wowhead.com/wotlk/tw/npc=24860
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 24860;
-- OLD name : 尼歐畢·嘯炫, subname : 工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=24868
UPDATE `creature_template_locale` SET `Name` = '尼歐畢·威索火花',`Title` = '大師級工程學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 24868;
-- OLD name : 伊蘇鐸夫·冰心 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24877
UPDATE `creature_template_locale` SET `Name` = '伊蘇鐸夫‧冰心' WHERE `locale` = 'zhTW' AND `entry` = 24877;
-- OLD name : 『墮落者』塞斯諾瓦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24892
UPDATE `creature_template_locale` SET `Name` = '『墮落者』薩索瓦爾' WHERE `locale` = 'zhTW' AND `entry` = 24892;
-- OLD name : [PH]雪崩 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=24912
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 24912;
-- OLD name : 造型觸發器 - LAB
-- Source : https://www.wowhead.com/wotlk/tw/npc=24921
UPDATE `creature_template_locale` SET `Name` = 'Generic Cosmetic Trigger - LAB' WHERE `locale` = 'zhTW' AND `entry` = 24921;
-- OLD name : 鄙惡者吞噬者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24960
UPDATE `creature_template_locale` SET `Name` = '惡癮者吞噬者' WHERE `locale` = 'zhTW' AND `entry` = 24960;
-- OLD name : 陣亡的守衛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24962
UPDATE `creature_template_locale` SET `Name` = '被殺的守衛' WHERE `locale` = 'zhTW' AND `entry` = 24962;
-- OLD name : 鄙惡者惡魔 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24966
UPDATE `creature_template_locale` SET `Name` = '惡癮者惡魔' WHERE `locale` = 'zhTW' AND `entry` = 24966;
-- OLD name : 塞里斯·曦爐上尉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24967
UPDATE `creature_template_locale` SET `Name` = '塞里斯‧曦爐上尉' WHERE `locale` = 'zhTW' AND `entry` = 24967;
-- OLD name : 法拉斯卡托夫人, subname : 法拉斯卡托的配偶
-- Source : https://www.wowhead.com/wotlk/tw/npc=24982
UPDATE `creature_template_locale` SET `Name` = '弗拉斯卡索夫人',`Title` = 'PTR附魔' WHERE `locale` = 'zhTW' AND `entry` = 24982;
-- OLD name : 聖誕版大術士奈德克斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24984
UPDATE `creature_template_locale` SET `Name` = '冬幕版大術士奈德克斯' WHERE `locale` = 'zhTW' AND `entry` = 24984;
-- OLD name : 聖誕版宗師瓦皮歐 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24985
UPDATE `creature_template_locale` SET `Name` = '冬幕版宗師瓦皮歐' WHERE `locale` = 'zhTW' AND `entry` = 24985;
-- OLD name : 聖誕版主教瑪拉達爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24986
UPDATE `creature_template_locale` SET `Name` = '冬幕版瑪拉達爾主教' WHERE `locale` = 'zhTW' AND `entry` = 24986;
-- OLD name : 聖誕版史卡拉克上尉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24987
UPDATE `creature_template_locale` SET `Name` = '冬幕版史卡拉克上尉' WHERE `locale` = 'zhTW' AND `entry` = 24987;
-- OLD name : 聖誕版虛空術師賽菲瑞雅 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24988
UPDATE `creature_template_locale` SET `Name` = '冬幕版虛空術師賽菲瑞雅' WHERE `locale` = 'zhTW' AND `entry` = 24988;
-- OLD name : 捷蒂雅·麥克威醬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24989
UPDATE `creature_template_locale` SET `Name` = '捷蒂雅‧麥克威醬' WHERE `locale` = 'zhTW' AND `entry` = 24989;
-- OLD name : 聖誕版大植物學家費瑞衛恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=24990
UPDATE `creature_template_locale` SET `Name` = '冬幕版大植物學家費瑞衛恩' WHERE `locale` = 'zhTW' AND `entry` = 24990;
-- OLD subname : 羽月渡口 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25025
UPDATE `creature_template_locale` SET `Title` = '退休的船長' WHERE `locale` = 'zhTW' AND `entry` = 25025;
-- OLD name : 艾達拉·曦奔
-- Source : https://www.wowhead.com/wotlk/tw/npc=25032
UPDATE `creature_template_locale` SET `Name` = '艾達拉·晨路' WHERE `locale` = 'zhTW' AND `entry` = 25032;
-- OLD name : 泰瑞爾·焰吻 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25035
UPDATE `creature_template_locale` SET `Name` = '泰瑞爾‧焰吻' WHERE `locale` = 'zhTW' AND `entry` = 25035;
-- OLD name : 瑟拉芬娜·血心 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25037
UPDATE `creature_template_locale` SET `Name` = '瑟拉芬娜‧血心' WHERE `locale` = 'zhTW' AND `entry` = 25037;
-- OLD name : 瑟拉斯·幽暮使者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25043
UPDATE `creature_template_locale` SET `Name` = '瑟拉斯‧幽暮使者' WHERE `locale` = 'zhTW' AND `entry` = 25043;
-- OLD name : 鄙惡者飢餓者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25047
UPDATE `creature_template_locale` SET `Name` = '惡癮者飢餓者' WHERE `locale` = 'zhTW' AND `entry` = 25047;
-- OLD name : 加林德·風刀船長 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25050
UPDATE `creature_template_locale` SET `Name` = '加林德‧風刀船長' WHERE `locale` = 'zhTW' AND `entry` = 25050;
-- OLD name : 埃倫·破雲者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25059
UPDATE `creature_template_locale` SET `Name` = '埃倫‧破雲者' WHERE `locale` = 'zhTW' AND `entry` = 25059;
-- OLD name : 克瑞克·擰鼻船長 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25078
UPDATE `creature_template_locale` SET `Name` = '克瑞克‧擰鼻船長' WHERE `locale` = 'zhTW' AND `entry` = 25078;
-- OLD subname : 工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=25099
UPDATE `creature_template_locale` SET `Title` = '大師級工程學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 25099;
-- OLD name : [PH] Bri's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=25139
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25139;
-- OLD name : 老邁克喬的雙足翼龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25185
UPDATE `creature_template_locale` SET `Name` = '老邁克喬的蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 25185;
-- OLD name : 柯爾克隆狼騎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25194
UPDATE `creature_template_locale` SET `Name` = '柯爾克隆狼坐騎' WHERE `locale` = 'zhTW' AND `entry` = 25194;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/tw/npc=25195
UPDATE `creature_template_locale` SET `Title` = '特殊彈藥商人' WHERE `locale` = 'zhTW' AND `entry` = 25195;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/tw/npc=25196
UPDATE `creature_template_locale` SET `Title` = '特殊彈藥商人' WHERE `locale` = 'zhTW' AND `entry` = 25196;
-- OLD name : 史蒂芬·湯瑪斯
-- Source : https://www.wowhead.com/wotlk/tw/npc=25200
UPDATE `creature_template_locale` SET `Name` = '史蒂芬·湯瑪士' WHERE `locale` = 'zhTW' AND `entry` = 25200;
-- OLD name : 冬鰭濱擊者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25215
UPDATE `creature_template_locale` SET `Name` = '冬鰭巡岸者' WHERE `locale` = 'zhTW' AND `entry` = 25215;
-- OLD name : [PH]火炬目標 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=25218
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25218;
-- OLD name : 索拉納爾·血怒領主 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25223
UPDATE `creature_template_locale` SET `Name` = '索拉納爾‧血怒領主' WHERE `locale` = 'zhTW' AND `entry` = 25223;
-- OLD name : 浪克·長牙 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25233
UPDATE `creature_template_locale` SET `Name` = '浪克‧長牙' WHERE `locale` = 'zhTW' AND `entry` = 25233;
-- OLD name : 希爾妲·石鑄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25235
UPDATE `creature_template_locale` SET `Name` = '希爾妲‧石鑄' WHERE `locale` = 'zhTW' AND `entry` = 25235;
-- OLD name : 卡爾洛斯·地獄吼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25237
UPDATE `creature_template_locale` SET `Name` = '卡爾洛斯‧地獄吼' WHERE `locale` = 'zhTW' AND `entry` = 25237;
-- OLD name : 詹姆士·戴肯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25245
UPDATE `creature_template_locale` SET `Name` = '詹姆士‧戴肯' WHERE `locale` = 'zhTW' AND `entry` = 25245;
-- OLD subname : 血騎士女王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25246
UPDATE `creature_template_locale` SET `Title` = '血騎士團長' WHERE `locale` = 'zhTW' AND `entry` = 25246;
-- OLD name : 『鹽漬』約翰·索普 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25248
UPDATE `creature_template_locale` SET `Name` = '『鹽漬』約翰‧索普' WHERE `locale` = 'zhTW' AND `entry` = 25248;
-- OLD name : 審判者茱利亞·莎莉絲蒂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25264
UPDATE `creature_template_locale` SET `Name` = '審判者茱利亞‧莎莉絲蒂' WHERE `locale` = 'zhTW' AND `entry` = 25264;
-- OLD name : 海德加爾·鋼鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25281
UPDATE `creature_template_locale` SET `Name` = '海德加爾‧鋼鬚' WHERE `locale` = 'zhTW' AND `entry` = 25281;
-- OLD name : 斐林恩·風歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25282
UPDATE `creature_template_locale` SET `Name` = '斐林恩‧風歌' WHERE `locale` = 'zhTW' AND `entry` = 25282;
-- OLD name : 戰歌飛龍騎士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25286
UPDATE `creature_template_locale` SET `Name` = '戰歌蠍尾獅騎士' WHERE `locale` = 'zhTW' AND `entry` = 25286;
-- OLD name : 戰歌雙足翼龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25287
UPDATE `creature_template_locale` SET `Name` = '戰歌蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 25287;
-- OLD name : 吐瑞達·冷風, subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25288
UPDATE `creature_template_locale` SET `Name` = '吐瑞達‧冷風',`Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 25288;
-- OLD subname : 錘和法杖 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25314
UPDATE `creature_template_locale` SET `Title` = '錘和法杖商人' WHERE `locale` = 'zhTW' AND `entry` = 25314;
-- OLD name : Craig Steele, subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/tw/npc=25323
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25323;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25323, 'zhTW','克瑞格·斯蒂利','軟體工程師');
-- OLD name : 『屍體研磨者』寇治 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25329
UPDATE `creature_template_locale` SET `Name` = '殲滅者葛雷克洛' WHERE `locale` = 'zhTW' AND `entry` = 25329;
-- OLD name : 先知克雷格·厲牙 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25344
UPDATE `creature_template_locale` SET `Name` = '先知克雷格‧厲牙' WHERE `locale` = 'zhTW' AND `entry` = 25344;
-- OLD name : 看守者諾克·血狂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25379
UPDATE `creature_template_locale` SET `Name` = '看守者諾克‧血狂' WHERE `locale` = 'zhTW' AND `entry` = 25379;
-- OLD name : 威廉·愛勒頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25385
UPDATE `creature_template_locale` SET `Name` = '威廉‧愛勒頓' WHERE `locale` = 'zhTW' AND `entry` = 25385;
-- OLD name : Craig Steele2, subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/tw/npc=25406
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25406;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25406, 'zhTW','克瑞格·斯蒂利2','軟體工程師');
-- OLD name : Craig Steele3, subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/tw/npc=25411
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25411;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25411, 'zhTW','克瑞格·斯蒂利3','軟體工程師');
-- OLD name : 烏格索·血狂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25426
UPDATE `creature_template_locale` SET `Name` = '烏格索‧血狂' WHERE `locale` = 'zhTW' AND `entry` = 25426;
-- OLD name : 瑪格默斯強奪者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25429
UPDATE `creature_template_locale` SET `Name` = '瑪格默斯採獵者' WHERE `locale` = 'zhTW' AND `entry` = 25429;
-- OLD name : 卡芙緹·顛鏈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25477
UPDATE `creature_template_locale` SET `Name` = '卡芙緹‧顛鏈' WHERE `locale` = 'zhTW' AND `entry` = 25477;
-- OLD name : 派迪麥克斯 - 假人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25499
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - The Dummy' WHERE `locale` = 'zhTW' AND `entry` = 25499;
-- OLD name : 派迪麥克斯 - 飛行假人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25500
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - Flying Dummy' WHERE `locale` = 'zhTW' AND `entry` = 25500;
-- OLD name : 第2艘科瓦迪爾飛船(科·德拉卡) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25511
UPDATE `creature_template_locale` SET `Name` = '第2艘科瓦迪爾飛船(科‧德拉卡)' WHERE `locale` = 'zhTW' AND `entry` = 25511;
-- OLD name : [PH]節慶火焰雜耍師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=25515
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25515;
-- OLD name : [DNT] Torch Tossing Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=25535
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25535;
-- OLD name : [DNT] Torch Tossing Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=25536
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25536;
-- OLD name : Craig's Test Human A (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25537
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25537;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25537, 'zhTW','Craig''s Test Human',NULL);
-- OLD name : 邦克·電環 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25589
UPDATE `creature_template_locale` SET `Name` = '邦克‧電環' WHERE `locale` = 'zhTW' AND `entry` = 25589;
-- OLD name : 嘶軸·滿閥 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25590
UPDATE `creature_template_locale` SET `Name` = '嘶軸‧滿閥' WHERE `locale` = 'zhTW' AND `entry` = 25590;
-- OLD subname : 陶土議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=25697
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 25697;
-- OLD name : 莫爾斗·榫紡 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25702
UPDATE `creature_template_locale` SET `Name` = '莫爾斗‧旋輪' WHERE `locale` = 'zhTW' AND `entry` = 25702;
-- OLD name : 碧西·扭柄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25705
UPDATE `creature_template_locale` SET `Name` = '碧西‧扭柄' WHERE `locale` = 'zhTW' AND `entry` = 25705;
-- OLD name : 灼熱的小焦焰
-- Source : https://www.wowhead.com/wotlk/tw/npc=25706
UPDATE `creature_template_locale` SET `Name` = '小焦焰' WHERE `locale` = 'zhTW' AND `entry` = 25706;
-- OLD name : 汀基·芯哨 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25714
UPDATE `creature_template_locale` SET `Name` = '汀基‧芯哨' WHERE `locale` = 'zhTW' AND `entry` = 25714;
-- OLD name : [ph]凜懼島藍龍巡邏者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=25723
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25723;
-- OLD name : [PH] Ahune Summon Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=25745
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25745;
-- OLD name : [PH] Ahune Loot Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=25746
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 25746;
-- OLD name : 金基·翼果 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25747
UPDATE `creature_template_locale` SET `Name` = '金基‧翼果' WHERE `locale` = 'zhTW' AND `entry` = 25747;
-- OLD subname : 陶土議會
-- Source : https://www.wowhead.com/wotlk/tw/npc=25754
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 25754;
-- OLD name : 艾伯奈·嘶鍊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25780
UPDATE `creature_template_locale` SET `Name` = '艾伯奈‧嘶鍊' WHERE `locale` = 'zhTW' AND `entry` = 25780;
-- OLD name : 哈洛德·蘭恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25804
UPDATE `creature_template_locale` SET `Name` = '哈洛德‧蘭恩' WHERE `locale` = 'zhTW' AND `entry` = 25804;
-- OLD name : 『尾旋』艾基·榫栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25807
UPDATE `creature_template_locale` SET `Name` = '『尾旋』艾基‧榫栓' WHERE `locale` = 'zhTW' AND `entry` = 25807;
-- OLD name : 湯姆·海格 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25827
UPDATE `creature_template_locale` SET `Name` = '湯姆‧海格' WHERE `locale` = 'zhTW' AND `entry` = 25827;
-- OLD name : 菲奇司·絞輪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25849
UPDATE `creature_template_locale` SET `Name` = '菲奇司‧絞輪' WHERE `locale` = 'zhTW' AND `entry` = 25849;
-- OLD name : 異點 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25855
UPDATE `creature_template_locale` SET `Name` = '奇異點' WHERE `locale` = 'zhTW' AND `entry` = 25855;
-- OLD name : 仲夏節慶祝者裝扮:血精靈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25868
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：血精靈' WHERE `locale` = 'zhTW' AND `entry` = 25868;
-- OLD name : 仲夏節慶祝者裝扮:德萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25869
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：德萊尼' WHERE `locale` = 'zhTW' AND `entry` = 25869;
-- OLD name : 仲夏節慶祝者裝扮:矮人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25870
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：矮人' WHERE `locale` = 'zhTW' AND `entry` = 25870;
-- OLD name : 仲夏節慶祝者裝扮:地精 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25871
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：地精' WHERE `locale` = 'zhTW' AND `entry` = 25871;
-- OLD name : 仲夏節慶祝者裝扮:哥布林 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25872
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：哥布林' WHERE `locale` = 'zhTW' AND `entry` = 25872;
-- OLD name : 仲夏節慶祝者裝扮:人類 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25873
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：人類' WHERE `locale` = 'zhTW' AND `entry` = 25873;
-- OLD name : 仲夏節慶祝者裝扮:夜精靈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25874
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：夜精靈' WHERE `locale` = 'zhTW' AND `entry` = 25874;
-- OLD name : 仲夏節慶祝者裝扮:獸人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25875
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：獸人' WHERE `locale` = 'zhTW' AND `entry` = 25875;
-- OLD name : 仲夏節慶祝者裝扮:牛頭人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25876
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：牛頭人' WHERE `locale` = 'zhTW' AND `entry` = 25876;
-- OLD name : 仲夏節慶祝者裝扮:食人妖 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25877
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：食人妖' WHERE `locale` = 'zhTW' AND `entry` = 25877;
-- OLD name : 仲夏節慶祝者裝扮:不死族 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25878
UPDATE `creature_template_locale` SET `Name` = '仲夏節慶祝者裝扮：不死族' WHERE `locale` = 'zhTW' AND `entry` = 25878;
-- OLD name : 北貧瘠之地火焰守護者
-- Source : https://www.wowhead.com/wotlk/tw/npc=25943
UPDATE `creature_template_locale` SET `Name` = '貧瘠之地火焰守護者' WHERE `locale` = 'zhTW' AND `entry` = 25943;
-- OLD name : 杜然·霜蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25983
UPDATE `creature_template_locale` SET `Name` = '杜然‧霜蹄' WHERE `locale` = 'zhTW' AND `entry` = 25983;
-- OLD name : 迫降的偵查駕駛員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=25984
UPDATE `creature_template_locale` SET `Name` = '迫降的偵察駕駛員' WHERE `locale` = 'zhTW' AND `entry` = 25984;
-- OLD name : 馴服的毒蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=26032
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 26032;
-- OLD name : 馴服的風蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=26038
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 26038;
-- OLD name : 德寇特·狼伴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26044
UPDATE `creature_template_locale` SET `Name` = '德寇特‧狼伴' WHERE `locale` = 'zhTW' AND `entry` = 26044;
-- OLD name : Craig's Test Human B (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26080
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26080;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26080, 'zhTW','NPC',NULL);
-- OLD name : 吉羅德·葛林 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26083
UPDATE `creature_template_locale` SET `Name` = '吉羅德‧葛林' WHERE `locale` = 'zhTW' AND `entry` = 26083;
-- OLD name : 杰瑞米亞·豪寧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26084
UPDATE `creature_template_locale` SET `Name` = '杰瑞米亞‧豪寧' WHERE `locale` = 'zhTW' AND `entry` = 26084;
-- OLD name : 溫蒂·達倫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26085
UPDATE `creature_template_locale` SET `Name` = '溫蒂‧達倫' WHERE `locale` = 'zhTW' AND `entry` = 26085;
-- OLD name : 吞焰者大師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26113
UPDATE `creature_template_locale` SET `Name` = '吞火者大師' WHERE `locale` = 'zhTW' AND `entry` = 26113;
-- OLD name : 馬克·漢尼斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26155
UPDATE `creature_template_locale` SET `Name` = '馬克‧漢尼斯' WHERE `locale` = 'zhTW' AND `entry` = 26155;
-- OLD name : 瓦圖克·冰誕 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26156
UPDATE `creature_template_locale` SET `Name` = '瓦圖克‧冰誕' WHERE `locale` = 'zhTW' AND `entry` = 26156;
-- OLD name : [PH] Tom Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26176
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26176;
-- OLD name : [PH] 接火炬目標兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26188
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26188;
-- OLD name : [PH] 拍擊目標兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26190
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26190;
-- OLD name : 淹死的守護者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26224
UPDATE `creature_template_locale` SET `Name` = '溺斃的守護者' WHERE `locale` = 'zhTW' AND `entry` = 26224;
-- OLD name : [PH] 艾胡恩的鬼魂(偽裝) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26241
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26241;
-- OLD subname : 血騎士女王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26247
UPDATE `creature_template_locale` SET `Title` = '血騎士團長' WHERE `locale` = 'zhTW' AND `entry` = 26247;
-- OLD name : [DND] 仲夏營火陣營兔子 - 聯盟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26258
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 26258;
-- OLD name : [PH] 龍骨荒野大型黑龍 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26275
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26275;
-- OLD name : [PH] 龍骨荒野大型綠龍 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26278
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26278;
-- OLD name : [PH] 龍骨荒野元素黑曜龍殿 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26285
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26285;
-- OLD name : 遺民之濱事件觸發器
-- Source : https://www.wowhead.com/wotlk/tw/npc=26288
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 26288;
-- OLD name : [PH] 龍骨荒野天譴腐屍農地 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26292
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26292;
-- OLD name : [PH] 龍骨荒野岩龍 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26294
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26294;
-- OLD name : [PH] 龍骨荒野血色突襲軍 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26296
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26296;
-- OLD name : [PH]龍骨荒野坦卡 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26311
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26311;
-- OLD name : [PH]龍骨荒野坦卡靈魂 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26312
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26312;
-- OLD name : [PH]龍骨荒野樹人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26313
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26313;
-- OLD name : [PH]龍骨荒野天譴葛拉克朗安息地 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26317
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26317;
-- OLD name : [PH] 龍骨荒野天譴黑曜龍殿 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26318
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26318;
-- OLD name : [PH]龍骨荒野天譴晶紅龍殿 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26320
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26320;
-- OLD name : [DND] 仲夏節慶營火陣營兔子 - 部落 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26355
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 26355;
-- OLD name : 熱能軟泥怪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26366
UPDATE `creature_template_locale` SET `Name` = '混亂軟泥怪' WHERE `locale` = 'zhTW' AND `entry` = 26366;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=26375
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 26375;
-- OLD name : Test - Brutallus Craig (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26376
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26376;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26376, 'zhTW','NPC',NULL);
-- OLD name : 伊薇·銅簧, subname : 競技場商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=26378
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 26378;
-- OLD name : 格利金·銅簧, subname : 競技場商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=26383
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 26383;
-- OLD name : 佛利基·銅杯, subname : 競技場商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=26384
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 26384;
-- OLD name : [PH]冰封之箱兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26391
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26391;
-- OLD name : 朵莉絲· 維蘭提斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26398
UPDATE `creature_template_locale` SET `Name` = '朵莉絲‧ 維蘭提斯' WHERE `locale` = 'zhTW' AND `entry` = 26398;
-- OLD name : 外域兒童週銀月城L70ETC 01觸發器
-- Source : https://www.wowhead.com/wotlk/tw/npc=26400
UPDATE `creature_template_locale` SET `Name` = '外域兒童週銀月L70ETC 01觸發器' WHERE `locale` = 'zhTW' AND `entry` = 26400;
-- OLD name : 拉格納·德拉卡路德 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26451
UPDATE `creature_template_locale` SET `Name` = '拉格納‧德拉卡路德' WHERE `locale` = 'zhTW' AND `entry` = 26451;
-- OLD name : 指揮官賽雅·蒼鋼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26459
UPDATE `creature_template_locale` SET `Name` = '指揮官賽雅‧蒼鋼' WHERE `locale` = 'zhTW' AND `entry` = 26459;
-- OLD name : 大法師埃薩·奪日者的影像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26471
UPDATE `creature_template_locale` SET `Name` = '大法師埃薩‧奪日者的影像' WHERE `locale` = 'zhTW' AND `entry` = 26471;
-- OLD name : 休·格雷斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26484
UPDATE `creature_template_locale` SET `Name` = '休‧格雷斯' WHERE `locale` = 'zhTW' AND `entry` = 26484;
-- OLD name : [PH] 龍骨荒野腐屍農地死靈法師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26489
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26489;
-- OLD name : [PH] 龍骨荒野腐屍農地殭屍 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26490
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26490;
-- OLD name : [PH] 龍骨荒野腐屍農地石像鬼 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26491
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26491;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26497
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 26497;
-- OLD name : 伊希尼歐·月影 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26501
UPDATE `creature_template_locale` SET `Name` = '伊希尼歐‧月影' WHERE `locale` = 'zhTW' AND `entry` = 26501;
-- OLD name : 梭爾·鷹怒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26504
UPDATE `creature_template_locale` SET `Name` = '梭爾‧鷹怒' WHERE `locale` = 'zhTW' AND `entry` = 26504;
-- OLD name : [Demo]克雷格·亞邁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26535
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'zhTW' AND `entry` = 26535;
-- OLD name : 格利伯·瑞姆洛基 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26537
UPDATE `creature_template_locale` SET `Name` = '格利伯‧瑞姆洛基' WHERE `locale` = 'zhTW' AND `entry` = 26537;
-- OLD name : 納爾高·螺孔 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26538
UPDATE `creature_template_locale` SET `Name` = '納爾高‧螺孔' WHERE `locale` = 'zhTW' AND `entry` = 26538;
-- OLD name : 米菲·遙流 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26539
UPDATE `creature_template_locale` SET `Name` = '米菲‧遙流' WHERE `locale` = 'zhTW' AND `entry` = 26539;
-- OLD name : 德然克·扳爍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26540
UPDATE `creature_template_locale` SET `Name` = '德然克‧扳爍' WHERE `locale` = 'zhTW' AND `entry` = 26540;
-- OLD name : 扎伯·氣栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26541
UPDATE `creature_template_locale` SET `Name` = '扎伯‧氣栓' WHERE `locale` = 'zhTW' AND `entry` = 26541;
-- OLD name : 里尼·柄栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26542
UPDATE `creature_template_locale` SET `Name` = '里尼‧柄栓' WHERE `locale` = 'zhTW' AND `entry` = 26542;
-- OLD name : 魯汀·法洛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26546
UPDATE `creature_template_locale` SET `Name` = '魯汀‧法洛' WHERE `locale` = 'zhTW' AND `entry` = 26546;
-- OLD name : 莉夏·坦稜拜 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26548
UPDATE `creature_template_locale` SET `Name` = '莉夏‧坦稜拜' WHERE `locale` = 'zhTW' AND `entry` = 26548;
-- OLD name : 奈爾諾·銅樑 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26549
UPDATE `creature_template_locale` SET `Name` = '奈爾諾‧銅樑' WHERE `locale` = 'zhTW' AND `entry` = 26549;
-- OLD name : 漢斯瑞克·史脫特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26551
UPDATE `creature_template_locale` SET `Name` = '漢斯瑞克‧史脫特' WHERE `locale` = 'zhTW' AND `entry` = 26551;
-- OLD name : 瑪耶·派波 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26552
UPDATE `creature_template_locale` SET `Name` = '瑪耶‧派波' WHERE `locale` = 'zhTW' AND `entry` = 26552;
-- OLD name : 伯魯斯·折鐵者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26564
UPDATE `creature_template_locale` SET `Name` = '伯魯斯‧折鐵者' WHERE `locale` = 'zhTW' AND `entry` = 26564;
-- OLD subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26566
UPDATE `creature_template_locale` SET `Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 26566;
-- OLD name : 艾利斯·沃泰爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26569
UPDATE `creature_template_locale` SET `Name` = '艾利斯‧沃泰爾' WHERE `locale` = 'zhTW' AND `entry` = 26569;
-- OLD name : 沃爾諾克·風怒者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26574
UPDATE `creature_template_locale` SET `Name` = '沃爾諾克‧風怒者' WHERE `locale` = 'zhTW' AND `entry` = 26574;
-- OLD name : [PH] Justin's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26576
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26576;
-- OLD name : 寇爾提拉·亡織者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26581
UPDATE `creature_template_locale` SET `Name` = '寇爾提拉‧亡織者' WHERE `locale` = 'zhTW' AND `entry` = 26581;
-- OLD name : 靈魂洞察變形 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26594
UPDATE `creature_template_locale` SET `Name` = '靈魂洞察' WHERE `locale` = 'zhTW' AND `entry` = 26594;
-- OLD name : 『鵝媽媽』托比·鐵栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26597
UPDATE `creature_template_locale` SET `Name` = '『鵝媽媽』托比‧鐵栓' WHERE `locale` = 'zhTW' AND `entry` = 26597;
-- OLD name : 蜜斯提·曦顫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26598
UPDATE `creature_template_locale` SET `Name` = '蜜斯提‧曦顫' WHERE `locale` = 'zhTW' AND `entry` = 26598;
-- OLD name : 威利斯·搖輪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26599
UPDATE `creature_template_locale` SET `Name` = '威利斯‧搖輪' WHERE `locale` = 'zhTW' AND `entry` = 26599;
-- OLD name : 首席工程師高朋·滾索 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26600
UPDATE `creature_template_locale` SET `Name` = '首席工程師高朋‧滾索' WHERE `locale` = 'zhTW' AND `entry` = 26600;
-- OLD name : 卡拉·參星 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26602
UPDATE `creature_template_locale` SET `Name` = '卡拉‧參星' WHERE `locale` = 'zhTW' AND `entry` = 26602;
-- OLD name : 麥客·菲爾森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26604
UPDATE `creature_template_locale` SET `Name` = '麥客‧菲爾森' WHERE `locale` = 'zhTW' AND `entry` = 26604;
-- OLD name : 嘶軸看守者魯伯特·銳眼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26634
UPDATE `creature_template_locale` SET `Name` = '嘶軸看守者魯伯特‧銳眼' WHERE `locale` = 'zhTW' AND `entry` = 26634;
-- OLD name : 隆諾克·冰霧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26654
UPDATE `creature_template_locale` SET `Name` = '隆諾克‧冰霧' WHERE `locale` = 'zhTW' AND `entry` = 26654;
-- OLD name : [PH]命名兀鷹辛瑞克 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26665
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26665;
-- OLD name : Rabid Dire Bear *Unused* (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26671
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26671;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26671, 'zhTW','NPC',NULL);
-- OLD name : 艾揚·冷風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26680
UPDATE `creature_template_locale` SET `Name` = '艾揚‧冷風' WHERE `locale` = 'zhTW' AND `entry` = 26680;
-- OLD name : 特萬·寒鬃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26697
UPDATE `creature_template_locale` SET `Name` = '特萬‧寒鬃' WHERE `locale` = 'zhTW' AND `entry` = 26697;
-- OLD name : 立多寇·冰圖騰 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26707
UPDATE `creature_template_locale` SET `Name` = '立多寇‧冰圖騰' WHERE `locale` = 'zhTW' AND `entry` = 26707;
-- OLD name : 銀溪村民 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26708
UPDATE `creature_template_locale` SET `Name` = '回想起的銀溪村民' WHERE `locale` = 'zhTW' AND `entry` = 26708;
-- OLD name : 帕胡·霜蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26709
UPDATE `creature_template_locale` SET `Name` = '帕胡‧霜蹄' WHERE `locale` = 'zhTW' AND `entry` = 26709;
-- OLD name : 達努克·風暴低語者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26720
UPDATE `creature_template_locale` SET `Name` = '達努克‧風暴低語者' WHERE `locale` = 'zhTW' AND `entry` = 26720;
-- OLD name : 哈隆那·風暴低語者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26721
UPDATE `creature_template_locale` SET `Name` = '哈隆那‧風暴低語者' WHERE `locale` = 'zhTW' AND `entry` = 26721;
-- OLD name : [DND] TAR Pedestal - Armor, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26724
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26724;
-- OLD name : [dnd]嘶軸傘兵兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26732
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26732;
-- OLD name : 班索克·冰霧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26733
UPDATE `creature_template_locale` SET `Name` = '班索克‧冰霧' WHERE `locale` = 'zhTW' AND `entry` = 26733;
-- OLD name : [DND] TAR Pedestal - Accessories (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26738
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26738;
-- OLD name : [DND] TAR Pedestal - Enchantments (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26739
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26739;
-- OLD name : [DND] TAR Pedestal - Gems (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26740
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26740;
-- OLD name : [DND] TAR Pedestal - General Goods (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26741
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26741;
-- OLD name : [DND] TAR Pedestal - Armor, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26742
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26742;
-- OLD name : [DND] TAR Pedestal - Glyph, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26743
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26743;
-- OLD name : [DND] TAR Pedestal - Glyph, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26744
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26744;
-- OLD name : [DND] TAR Pedestal - Weapons (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26745
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26745;
-- OLD name : [DND] TAR Pedestal - Arena Organizer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26747
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26747;
-- OLD name : [DND] TAR Pedestal - Beastmaster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26748
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26748;
-- OLD name : [DND] TAR Pedestal - Paymaster (-> Monk) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26749
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26749;
-- OLD name : [DND] TAR Pedestal - Teleporter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26750
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26750;
-- OLD name : [DND] TAR Pedestal - Trainer, Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26751
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26751;
-- OLD name : [DND] TAR Pedestal - Trainer, Hunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26752
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26752;
-- OLD name : [DND] TAR Pedestal - Trainer, Mage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26753
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26753;
-- OLD name : [DND] TAR Pedestal - Trainer, Paladin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26754
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26754;
-- OLD name : [DND] TAR Pedestal - Trainer, Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26755
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26755;
-- OLD name : [DND] TAR Pedestal - Trainer, Rogue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26756
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26756;
-- OLD name : [DND] TAR Pedestal - Trainer, Shaman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26757
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26757;
-- OLD name : [DND] TAR Pedestal - Trainer, Warlock (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26758
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26758;
-- OLD name : [DND] TAR Pedestal - Trainer, Warrior (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26759
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26759;
-- OLD name : 艾米·馬林隊長 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26762
UPDATE `creature_template_locale` SET `Name` = '艾米‧馬林隊長' WHERE `locale` = 'zhTW' AND `entry` = 26762;
-- OLD name : 伊爾莎·恐酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26764
UPDATE `creature_template_locale` SET `Name` = '伊爾莎‧恐酒' WHERE `locale` = 'zhTW' AND `entry` = 26764;
-- OLD name : [DND] TAR Pedestal - Fight Promoter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26765
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26765;
-- OLD name : Scott Keenan, subname : Thug Life
-- Source : https://www.wowhead.com/wotlk/tw/npc=26791
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26791;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26791, 'zhTW','史考特·基南','暴徒生活');
-- OLD name : 守護者之蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=26806
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 26806;
-- OLD name : 隆諾克·冰霧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26810
UPDATE `creature_template_locale` SET `Name` = '隆諾克‧冰霧' WHERE `locale` = 'zhTW' AND `entry` = 26810;
-- OLD name : 哈里遜·瓊斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26814
UPDATE `creature_template_locale` SET `Name` = '哈里遜‧瓊斯' WHERE `locale` = 'zhTW' AND `entry` = 26814;
-- OLD name : 厄蘇拉·恐酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26822
UPDATE `creature_template_locale` SET `Name` = '厄蘇拉‧恐酒' WHERE `locale` = 'zhTW' AND `entry` = 26822;
-- OLD name : [PH]龍骨荒野鍬牙拾荒者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26835
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26835;
-- OLD name : [PH] 龍骨荒野命名冰霜巨龍部落 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=26840
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 26840;
-- OLD subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26842
UPDATE `creature_template_locale` SET `Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 26842;
-- OLD name : 朱特·威斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26845
UPDATE `creature_template_locale` SET `Name` = '朱特‧威斯' WHERE `locale` = 'zhTW' AND `entry` = 26845;
-- OLD subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26846
UPDATE `creature_template_locale` SET `Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 26846;
-- OLD name : 歐穆·精風, subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26847
UPDATE `creature_template_locale` SET `Name` = '歐穆‧精風',`Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 26847;
-- OLD subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26848
UPDATE `creature_template_locale` SET `Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 26848;
-- OLD name : 努莫·精風, subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26850
UPDATE `creature_template_locale` SET `Name` = '努莫‧精風',`Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 26850;
-- OLD subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26852
UPDATE `creature_template_locale` SET `Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 26852;
-- OLD name : 邁基·冬風, subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26853
UPDATE `creature_template_locale` SET `Name` = '邁基‧冬風',`Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 26853;
-- OLD name : 深淵戰鬥觀察者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26869
UPDATE `creature_template_locale` SET `Name` = '鬥技場觀察者' WHERE `locale` = 'zhTW' AND `entry` = 26869;
-- OLD name : 德瑞克·拉梅爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26877
UPDATE `creature_template_locale` SET `Name` = '德瑞克‧拉梅爾' WHERE `locale` = 'zhTW' AND `entry` = 26877;
-- OLD name : 羅德尼·威爾斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26878
UPDATE `creature_template_locale` SET `Name` = '羅德尼‧威爾斯' WHERE `locale` = 'zhTW' AND `entry` = 26878;
-- OLD name : 托瑪斯·利夫威爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26879
UPDATE `creature_template_locale` SET `Name` = '托瑪斯‧利夫威爾' WHERE `locale` = 'zhTW' AND `entry` = 26879;
-- OLD name : 瓦那·格雷 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26880
UPDATE `creature_template_locale` SET `Name` = '瓦那‧格雷' WHERE `locale` = 'zhTW' AND `entry` = 26880;
-- OLD name : 帕雷那·銀雲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26881
UPDATE `creature_template_locale` SET `Name` = '帕雷那‧銀雲' WHERE `locale` = 'zhTW' AND `entry` = 26881;
-- OLD name : 瑞加爾·斷眉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26883
UPDATE `creature_template_locale` SET `Name` = '瑞加爾‧斷眉' WHERE `locale` = 'zhTW' AND `entry` = 26883;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/tw/npc=26901
UPDATE `creature_template_locale` SET `Title` = '彈藥商' WHERE `locale` = 'zhTW' AND `entry` = 26901;
-- OLD subname : 鍊金術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26903
UPDATE `creature_template_locale` SET `Title` = '宗師級鍊金術訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26903;
-- OLD subname : 鍛造訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26904
UPDATE `creature_template_locale` SET `Title` = '宗師級鍛造訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26904;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26905
UPDATE `creature_template_locale` SET `Title` = '宗師級烹飪訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26905;
-- OLD subname : 附魔訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26906
UPDATE `creature_template_locale` SET `Title` = '宗師級附魔訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26906;
-- OLD subname : 工程學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26907
UPDATE `creature_template_locale` SET `Title` = '宗師級工程學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26907;
-- OLD subname : 釣魚訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26909
UPDATE `creature_template_locale` SET `Title` = '宗師級釣魚訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26909;
-- OLD subname : 草藥學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26910
UPDATE `creature_template_locale` SET `Title` = '宗師級草藥學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26910;
-- OLD subname : 製皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26911
UPDATE `creature_template_locale` SET `Title` = '宗師級製皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26911;
-- OLD subname : 採礦訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26912
UPDATE `creature_template_locale` SET `Title` = '宗師級採礦訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26912;
-- OLD subname : 剝皮訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26913
UPDATE `creature_template_locale` SET `Title` = '宗師級剝皮訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26913;
-- OLD subname : 裁縫訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26914
UPDATE `creature_template_locale` SET `Title` = '宗師級裁縫訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26914;
-- OLD subname : 珠寶設計訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26915
UPDATE `creature_template_locale` SET `Title` = '宗師級珠寶設計訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26915;
-- OLD subname : 銘文學訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=26916
UPDATE `creature_template_locale` SET `Title` = '宗師級銘文學訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26916;
-- OLD name : 埃佛列特·麥基爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26934
UPDATE `creature_template_locale` SET `Name` = '埃佛列特‧麥基爾' WHERE `locale` = 'zhTW' AND `entry` = 26934;
-- OLD name : 恰斯卡·霜蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26936
UPDATE `creature_template_locale` SET `Name` = '恰斯卡‧霜蹄' WHERE `locale` = 'zhTW' AND `entry` = 26936;
-- OLD name : 布羅坎·熊臂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26941
UPDATE `creature_template_locale` SET `Name` = '布羅坎‧熊臂' WHERE `locale` = 'zhTW' AND `entry` = 26941;
-- OLD name : 索羅克·風暴之怒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26944
UPDATE `creature_template_locale` SET `Name` = '索羅克‧風暴之怒' WHERE `locale` = 'zhTW' AND `entry` = 26944;
-- OLD name : 參德利·毒牙 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26945
UPDATE `creature_template_locale` SET `Name` = '參德利‧毒牙' WHERE `locale` = 'zhTW' AND `entry` = 26945;
-- OLD name : 維克斯·銘爆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26947
UPDATE `creature_template_locale` SET `Name` = '維克斯‧銘爆' WHERE `locale` = 'zhTW' AND `entry` = 26947;
-- OLD name : 沙努特·迅矛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26950
UPDATE `creature_template_locale` SET `Name` = '沙努特‧迅矛' WHERE `locale` = 'zhTW' AND `entry` = 26950;
-- OLD name : 維爾海米那·芮奈爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26951
UPDATE `creature_template_locale` SET `Name` = '維爾海米那‧芮奈爾' WHERE `locale` = 'zhTW' AND `entry` = 26951;
-- OLD name : 克里斯坦·斯麥瑟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26952
UPDATE `creature_template_locale` SET `Name` = '克莉斯坦‧斯麥瑟' WHERE `locale` = 'zhTW' AND `entry` = 26952;
-- OLD name : 湯瑪士·寇里奇歐 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26953
UPDATE `creature_template_locale` SET `Name` = '湯瑪士‧寇里奇歐' WHERE `locale` = 'zhTW' AND `entry` = 26953;
-- OLD name : 埃米爾·奧頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26954
UPDATE `creature_template_locale` SET `Name` = '埃米爾‧奧頓' WHERE `locale` = 'zhTW' AND `entry` = 26954;
-- OLD name : 詹姆席納·華特利 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26955
UPDATE `creature_template_locale` SET `Name` = '詹姆席納‧華特利' WHERE `locale` = 'zhTW' AND `entry` = 26955;
-- OLD name : 莎莉·湯普金斯, subname : 急救訓練師 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26956
UPDATE `creature_template_locale` SET `Name` = '莎莉‧湯普金斯',`Title` = '繃帶訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26956;
-- OLD name : 安裘琳娜·索林 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26957
UPDATE `creature_template_locale` SET `Name` = '安裘琳娜‧索林' WHERE `locale` = 'zhTW' AND `entry` = 26957;
-- OLD name : 瑪裘利·肯恩斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26958
UPDATE `creature_template_locale` SET `Name` = '瑪裘利‧肯恩斯' WHERE `locale` = 'zhTW' AND `entry` = 26958;
-- OLD name : 布克·凱爾斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26959
UPDATE `creature_template_locale` SET `Name` = '布克‧凱爾斯' WHERE `locale` = 'zhTW' AND `entry` = 26959;
-- OLD name : 卡特·提芬斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26960
UPDATE `creature_template_locale` SET `Name` = '卡特‧提芬斯' WHERE `locale` = 'zhTW' AND `entry` = 26960;
-- OLD name : 剛特·漢森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26961
UPDATE `creature_template_locale` SET `Name` = '剛特‧漢森' WHERE `locale` = 'zhTW' AND `entry` = 26961;
-- OLD name : 喬納森·路易斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26962
UPDATE `creature_template_locale` SET `Name` = '喬納森‧路易斯' WHERE `locale` = 'zhTW' AND `entry` = 26962;
-- OLD name : 蘿貝塔·傑克斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26963
UPDATE `creature_template_locale` SET `Name` = '蘿貝塔‧傑克斯' WHERE `locale` = 'zhTW' AND `entry` = 26963;
-- OLD name : 亞歷珊卓·麥昆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26964
UPDATE `creature_template_locale` SET `Name` = '亞歷珊卓‧麥昆' WHERE `locale` = 'zhTW' AND `entry` = 26964;
-- OLD name : 翁恩·柔蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26972
UPDATE `creature_template_locale` SET `Name` = '翁恩‧柔蹄' WHERE `locale` = 'zhTW' AND `entry` = 26972;
-- OLD name : 守望者裘迪·月歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26973
UPDATE `creature_template_locale` SET `Name` = '看守者裘迪‧月歌' WHERE `locale` = 'zhTW' AND `entry` = 26973;
-- OLD name : 艾菊·蠻鬃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26974
UPDATE `creature_template_locale` SET `Name` = '艾菊‧蠻鬃' WHERE `locale` = 'zhTW' AND `entry` = 26974;
-- OLD name : 亞瑟·汗斯洛威 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26975
UPDATE `creature_template_locale` SET `Name` = '亞瑟‧汗斯洛威' WHERE `locale` = 'zhTW' AND `entry` = 26975;
-- OLD name : 布魯娜·鐵斧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26976
UPDATE `creature_template_locale` SET `Name` = '布魯娜‧鐵斧' WHERE `locale` = 'zhTW' AND `entry` = 26976;
-- OLD name : 艾德連·日槍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26977
UPDATE `creature_template_locale` SET `Name` = '艾德連‧日槍' WHERE `locale` = 'zhTW' AND `entry` = 26977;
-- OLD name : 伊歐然·曦擊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26980
UPDATE `creature_template_locale` SET `Name` = '伊歐然‧曦擊' WHERE `locale` = 'zhTW' AND `entry` = 26980;
-- OLD name : 克羅格·鋼脊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26981
UPDATE `creature_template_locale` SET `Name` = '克羅格‧鋼脊' WHERE `locale` = 'zhTW' AND `entry` = 26981;
-- OLD name : 史帝芬·法蘭克斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26984
UPDATE `creature_template_locale` SET `Name` = '史帝芬‧法蘭克斯' WHERE `locale` = 'zhTW' AND `entry` = 26984;
-- OLD name : 提波尼·風暴低語者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26986
UPDATE `creature_template_locale` SET `Name` = '提波尼‧風暴低語者' WHERE `locale` = 'zhTW' AND `entry` = 26986;
-- OLD name : 法隆·夜語 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26987
UPDATE `creature_template_locale` SET `Name` = '法隆‧夜語' WHERE `locale` = 'zhTW' AND `entry` = 26987;
-- OLD name : 亞高·勁壯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26988
UPDATE `creature_template_locale` SET `Name` = '亞高‧勁壯' WHERE `locale` = 'zhTW' AND `entry` = 26988;
-- OLD name : 羅利克·麥克里爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26989
UPDATE `creature_template_locale` SET `Name` = '羅利克‧麥克里爾' WHERE `locale` = 'zhTW' AND `entry` = 26989;
-- OLD name : 阿萊希斯·瑪洛威 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26990
UPDATE `creature_template_locale` SET `Name` = '阿萊希斯‧瑪洛威' WHERE `locale` = 'zhTW' AND `entry` = 26990;
-- OLD name : 薩克·亮栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26991
UPDATE `creature_template_locale` SET `Name` = '薩克‧亮栓' WHERE `locale` = 'zhTW' AND `entry` = 26991;
-- OLD name : 布萊娜·威爾森, subname : 急救訓練師 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26992
UPDATE `creature_template_locale` SET `Name` = '布萊娜‧威爾森',`Title` = '繃帶訓練師' WHERE `locale` = 'zhTW' AND `entry` = 26992;
-- OLD name : 基瑞亞·月舞 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26994
UPDATE `creature_template_locale` SET `Name` = '基瑞亞‧月舞' WHERE `locale` = 'zhTW' AND `entry` = 26994;
-- OLD name : 汀克·亮栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26995
UPDATE `creature_template_locale` SET `Name` = '汀克‧亮栓' WHERE `locale` = 'zhTW' AND `entry` = 26995;
-- OLD name : 艾汪·冰誕 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26996
UPDATE `creature_template_locale` SET `Name` = '艾汪‧冰誕' WHERE `locale` = 'zhTW' AND `entry` = 26996;
-- OLD name : 蘿斯瑪莉·鮑瓦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26998
UPDATE `creature_template_locale` SET `Name` = '蘿斯瑪莉‧鮑瓦' WHERE `locale` = 'zhTW' AND `entry` = 26998;
-- OLD name : 芬德利格·紅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=26999
UPDATE `creature_template_locale` SET `Name` = '芬德利格‧紅鬚' WHERE `locale` = 'zhTW' AND `entry` = 26999;
-- OLD name : 達寧·古斯提 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27001
UPDATE `creature_template_locale` SET `Name` = '達寧‧古斯提' WHERE `locale` = 'zhTW' AND `entry` = 27001;
-- OLD name : 德瑞格瑪·符標 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27003
UPDATE `creature_template_locale` SET `Name` = '德瑞格瑪‧符標' WHERE `locale` = 'zhTW' AND `entry` = 27003;
-- OLD name : 席林德·尋酒者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27010
UPDATE `creature_template_locale` SET `Name` = '席林德‧尋酒者' WHERE `locale` = 'zhTW' AND `entry` = 27010;
-- OLD name : 布羅弗·彭貝斯特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27011
UPDATE `creature_template_locale` SET `Name` = '布羅弗‧彭貝斯特' WHERE `locale` = 'zhTW' AND `entry` = 27011;
-- OLD name : 畢姆·金鏈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27012
UPDATE `creature_template_locale` SET `Name` = '畢姆‧金鏈' WHERE `locale` = 'zhTW' AND `entry` = 27012;
-- OLD subname : 鍊金術訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=27023
UPDATE `creature_template_locale` SET `Title` = '大師級鍊金術訓練師' WHERE `locale` = 'zhTW' AND `entry` = 27023;
-- OLD name : 哈洛德·哈吉勒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27025
UPDATE `creature_template_locale` SET `Name` = '哈洛德‧哈吉勒' WHERE `locale` = 'zhTW' AND `entry` = 27025;
-- OLD name : 洛禾西亞·威納 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27026
UPDATE `creature_template_locale` SET `Name` = '洛禾西亞‧威納' WHERE `locale` = 'zhTW' AND `entry` = 27026;
-- OLD name : 漢瑟爾·包爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27028
UPDATE `creature_template_locale` SET `Name` = '漢瑟爾‧包爾' WHERE `locale` = 'zhTW' AND `entry` = 27028;
-- OLD name : 布瑞德利·湯恩斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27030
UPDATE `creature_template_locale` SET `Name` = '布瑞德利‧湯恩斯' WHERE `locale` = 'zhTW' AND `entry` = 27030;
-- OLD subname : 蘑菇商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27032
UPDATE `creature_template_locale` SET `Title` = '蘑菇商人' WHERE `locale` = 'zhTW' AND `entry` = 27032;
-- OLD name : 鄧肯·法勒斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27033
UPDATE `creature_template_locale` SET `Name` = '鄧肯‧法勒斯' WHERE `locale` = 'zhTW' AND `entry` = 27033;
-- OLD name : 喬司利克·芬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27034
UPDATE `creature_template_locale` SET `Name` = '喬司利克‧芬' WHERE `locale` = 'zhTW' AND `entry` = 27034;
-- OLD name : 雷克希·布里維格 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27039
UPDATE `creature_template_locale` SET `Name` = '雷克希‧布里維格' WHERE `locale` = 'zhTW' AND `entry` = 27039;
-- OLD name : 芬尼·麥克朗普金斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27041
UPDATE `creature_template_locale` SET `Name` = '芬尼‧麥克朗普金斯' WHERE `locale` = 'zhTW' AND `entry` = 27041;
-- OLD name : 伊魯希雅·盧恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27042
UPDATE `creature_template_locale` SET `Name` = '伊魯希雅‧盧恩' WHERE `locale` = 'zhTW' AND `entry` = 27042;
-- OLD name : 崔克西·崔瑟頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27043
UPDATE `creature_template_locale` SET `Name` = '崔克西‧崔瑟頓' WHERE `locale` = 'zhTW' AND `entry` = 27043;
-- OLD name : 歐爾多·麥克朗普金斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27044
UPDATE `creature_template_locale` SET `Name` = '歐爾多‧麥克朗普金斯' WHERE `locale` = 'zhTW' AND `entry` = 27044;
-- OLD name : 拉努斯·長葉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27053
UPDATE `creature_template_locale` SET `Name` = '拉努斯‧長葉' WHERE `locale` = 'zhTW' AND `entry` = 27053;
-- OLD name : 莎拉默·白柳 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27057
UPDATE `creature_template_locale` SET `Name` = '莎拉默‧白柳' WHERE `locale` = 'zhTW' AND `entry` = 27057;
-- OLD name : 科洛特·銳眼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27058
UPDATE `creature_template_locale` SET `Name` = '科洛特‧銳眼' WHERE `locale` = 'zhTW' AND `entry` = 27058;
-- OLD name : 布羅姆·阿姆斯壯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27062
UPDATE `creature_template_locale` SET `Name` = '布羅姆‧阿姆斯壯' WHERE `locale` = 'zhTW' AND `entry` = 27062;
-- OLD name : 布瑞卡·狼女 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27065
UPDATE `creature_template_locale` SET `Name` = '布瑞卡‧狼女' WHERE `locale` = 'zhTW' AND `entry` = 27065;
-- OLD name : 珍妮佛·貝爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27066
UPDATE `creature_template_locale` SET `Name` = '珍妮佛‧貝爾' WHERE `locale` = 'zhTW' AND `entry` = 27066;
-- OLD name : 德利茍斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27067
UPDATE `creature_template_locale` SET `Name` = '德利苟斯' WHERE `locale` = 'zhTW' AND `entry` = 27067;
-- OLD name : 馬修·艾克曼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27068
UPDATE `creature_template_locale` SET `Name` = '馬修‧艾克曼' WHERE `locale` = 'zhTW' AND `entry` = 27068;
-- OLD name : 莉莎·菲爾布魯克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27070
UPDATE `creature_template_locale` SET `Name` = '莉莎‧菲爾布魯克' WHERE `locale` = 'zhTW' AND `entry` = 27070;
-- OLD name : 班傑明·傑考伯司 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27071
UPDATE `creature_template_locale` SET `Name` = '班傑明‧傑考伯司' WHERE `locale` = 'zhTW' AND `entry` = 27071;
-- OLD name : 尤蘭達·海默 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27088
UPDATE `creature_template_locale` SET `Name` = '尤蘭達‧海默' WHERE `locale` = 'zhTW' AND `entry` = 27088;
-- OLD name : 賽弗隆·列諾斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27089
UPDATE `creature_template_locale` SET `Name` = '賽弗隆‧列諾斯' WHERE `locale` = 'zhTW' AND `entry` = 27089;
-- OLD name : 克羅格·毀誓者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27105
UPDATE `creature_template_locale` SET `Name` = '克羅格‧毀誓者' WHERE `locale` = 'zhTW' AND `entry` = 27105;
-- OLD name : 冰拳強奪者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27123
UPDATE `creature_template_locale` SET `Name` = '冰拳採獵者' WHERE `locale` = 'zhTW' AND `entry` = 27123;
-- OLD name : 奧古斯特·敵錘公爵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27157
UPDATE `creature_template_locale` SET `Name` = '奧古斯特‧敵錘公爵' WHERE `locale` = 'zhTW' AND `entry` = 27157;
-- OLD name : 冽牙強奪者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27171
UPDATE `creature_template_locale` SET `Name` = '冽牙採獵者' WHERE `locale` = 'zhTW' AND `entry` = 27171;
-- OLD name : 多瑞克, subname : 製矛者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27188
UPDATE `creature_template_locale` SET `Name` = '卡邱',`Title` = '修理工' WHERE `locale` = 'zhTW' AND `entry` = 27188;
-- OLD name : [PH]新壁爐谷血色步卒 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=27205
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 27205;
-- OLD name : [PH]新壁爐谷血色指揮官 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=27208
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 27208;
-- OLD name : 拷問者樂卡夫特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27209
UPDATE `creature_template_locale` SET `Name` = '拷問者阿爾馮斯' WHERE `locale` = 'zhTW' AND `entry` = 27209;
-- OLD name : 博克西·栓旋者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27215
UPDATE `creature_template_locale` SET `Name` = '博克西‧栓旋者' WHERE `locale` = 'zhTW' AND `entry` = 27215;
-- OLD name : 比索·迅提 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27216
UPDATE `creature_template_locale` SET `Name` = '比索‧迅提' WHERE `locale` = 'zhTW' AND `entry` = 27216;
-- OLD name : [PH]新壁爐谷血色斥候 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=27218
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 27218;
-- OLD name : 克雷頓·杜賓·杰, subname : 品質保證 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27231
UPDATE `creature_template_locale` SET `Name` = 'Clayton Dubin Test J',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 27231;
-- OLD name : 藥劑師維琪·萊文 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27248
UPDATE `creature_template_locale` SET `Name` = '藥劑師維琪‧萊文' WHERE `locale` = 'zhTW' AND `entry` = 27248;
-- OLD name : 凍原食腐狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=27294
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 27294;
-- OLD name : 海多爾王幻像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27310
UPDATE `creature_template_locale` SET `Name` = '海多爾王幻象' WHERE `locale` = 'zhTW' AND `entry` = 27310;
-- OLD name : 拉努夫王幻像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27311
UPDATE `creature_template_locale` SET `Name` = '拉努夫王幻象' WHERE `locale` = 'zhTW' AND `entry` = 27311;
-- OLD name : 托爾王幻像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27312
UPDATE `creature_template_locale` SET `Name` = '托爾王幻象' WHERE `locale` = 'zhTW' AND `entry` = 27312;
-- OLD name : 『災禍』約德·冰鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27319
UPDATE `creature_template_locale` SET `Name` = '『災禍』約德‧冰鬚' WHERE `locale` = 'zhTW' AND `entry` = 27319;
-- OLD name : 突襲軍血犬
-- Source : https://www.wowhead.com/wotlk/tw/npc=27329
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 27329;
-- OLD name : 艾德琳·錢柏 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27344
UPDATE `creature_template_locale` SET `Name` = '艾德琳‧錢柏' WHERE `locale` = 'zhTW' AND `entry` = 27344;
-- OLD name : [DND]已存放的寵物外觀 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=27368
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 27368;
-- OLD name : 特沃德·艾利克森族長 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27377
UPDATE `creature_template_locale` SET `Name` = '特沃德‧艾利克森族長' WHERE `locale` = 'zhTW' AND `entry` = 27377;
-- OLD name : 資深書記貝瑞加 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27378
UPDATE `creature_template_locale` SET `Name` = '資深書記金尼迪斯' WHERE `locale` = 'zhTW' AND `entry` = 27378;
-- OLD name : 溫特加德內門攻擊觸發器
-- Source : https://www.wowhead.com/wotlk/tw/npc=27380
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 27380;
-- OLD name : 『幽暮使者』賽爾贊
-- Source : https://www.wowhead.com/wotlk/tw/npc=27384
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 27384;
-- OLD name : 羅奈德·安德森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27385
UPDATE `creature_template_locale` SET `Name` = '羅奈德‧安德森' WHERE `locale` = 'zhTW' AND `entry` = 27385;
-- OLD name : [DND] 驍勇要塞步卒觀眾 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=27387
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 27387;
-- OLD name : 吉爾巴特·巨錘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27398
UPDATE `creature_template_locale` SET `Name` = '吉爾巴特‧巨錘' WHERE `locale` = 'zhTW' AND `entry` = 27398;
-- OLD name : 俄特加德雙人組觸發器
-- Source : https://www.wowhead.com/wotlk/tw/npc=27404
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 27404;
-- OLD name : 瓦羅斯·雲行者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27447
UPDATE `creature_template_locale` SET `Name` = '瓦羅斯‧雲行者' WHERE `locale` = 'zhTW' AND `entry` = 27447;
-- OLD name : 指揮官巴茍克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27451
UPDATE `creature_template_locale` SET `Name` = '指揮官巴苟克' WHERE `locale` = 'zhTW' AND `entry` = 27451;
-- OLD name : 征服堡斥候 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27470
UPDATE `creature_template_locale` SET `Name` = '征服堡蠻兵' WHERE `locale` = 'zhTW' AND `entry` = 27470;
-- OLD name : 盧克·迪梅魯德隊長任務獎勵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27474
UPDATE `creature_template_locale` SET `Name` = '盧克‧迪梅魯德隊長任務獎勵' WHERE `locale` = 'zhTW' AND `entry` = 27474;
-- OLD name : 盧克·瓦隆佛斯上尉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27476
UPDATE `creature_template_locale` SET `Name` = '盧克‧瓦隆佛斯上尉' WHERE `locale` = 'zhTW' AND `entry` = 27476;
-- OLD name : 卡登·麥酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27477
UPDATE `creature_template_locale` SET `Name` = '卡登‧麥酒' WHERE `locale` = 'zhTW' AND `entry` = 27477;
-- OLD name : 拉金·雷酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27478
UPDATE `creature_template_locale` SET `Name` = '拉金‧雷酒' WHERE `locale` = 'zhTW' AND `entry` = 27478;
-- OLD name : Clayton Dubin - TEST COPY DATA (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27527
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 27527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (27527, 'zhTW','NPC',NULL);
-- OLD name : 艾弗薩斯塔茲領主 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27575
UPDATE `creature_template_locale` SET `Name` = '戴伏斯塔茲領主' WHERE `locale` = 'zhTW' AND `entry` = 27575;
-- OLD name : 高佛雷鎮長
-- Source : https://www.wowhead.com/wotlk/tw/npc=27577
UPDATE `creature_template_locale` SET `Name` = '賈弗雷鎮長' WHERE `locale` = 'zhTW' AND `entry` = 27577;
-- OLD name : 達爾娜·蜜啤 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27584
UPDATE `creature_template_locale` SET `Name` = '達爾娜‧蜜啤' WHERE `locale` = 'zhTW' AND `entry` = 27584;
-- OLD name : 瑞茲·嘶啤 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27585
UPDATE `creature_template_locale` SET `Name` = '瑞茲‧嘶啤' WHERE `locale` = 'zhTW' AND `entry` = 27585;
-- OLD name : 霸波·雷札爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27628
UPDATE `creature_template_locale` SET `Name` = '霸波‧雷札爾' WHERE `locale` = 'zhTW' AND `entry` = 27628;
-- OLD name : [UNUSED] 憤怒之門地穴惡魔 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=27630
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 27630;
-- OLD name : 地脈守護者伊瑞茍斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27656
UPDATE `creature_template_locale` SET `Name` = '地脈守護者伊瑞苟斯' WHERE `locale` = 'zhTW' AND `entry` = 27656;
-- OLD name : 妲莉雅·日觸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27680
UPDATE `creature_template_locale` SET `Name` = '妲莉雅‧日觸' WHERE `locale` = 'zhTW' AND `entry` = 27680;
-- OLD name : 妲莉雅·日觸的殘骸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27683
UPDATE `creature_template_locale` SET `Name` = '妲莉雅‧日觸的殘骸' WHERE `locale` = 'zhTW' AND `entry` = 27683;
-- OLD name : 托格·雷電圖騰 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27716
UPDATE `creature_template_locale` SET `Name` = '托格‧雷電圖騰' WHERE `locale` = 'zhTW' AND `entry` = 27716;
-- OLD name : 霍葛倫·地獄斬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27718
UPDATE `creature_template_locale` SET `Name` = '霍葛倫‧地獄斬' WHERE `locale` = 'zhTW' AND `entry` = 27718;
-- OLD name : 葛林尼克斯·剃扭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27719
UPDATE `creature_template_locale` SET `Name` = '葛林尼克斯‧剃扭' WHERE `locale` = 'zhTW' AND `entry` = 27719;
-- OLD name : 布齊·維爾占 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27720
UPDATE `creature_template_locale` SET `Name` = '布齊‧維爾占' WHERE `locale` = 'zhTW' AND `entry` = 27720;
-- OLD name : [DND] 奧多爾郵箱故障兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=27723
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 27723;
-- OLD name : 拉斯特勒·燃蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27750
UPDATE `creature_template_locale` SET `Name` = '拉斯特勒‧燃蹄' WHERE `locale` = 'zhTW' AND `entry` = 27750;
-- OLD name : 『灰熊』D·亞當斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27760
UPDATE `creature_template_locale` SET `Name` = '『灰熊』D‧亞當斯' WHERE `locale` = 'zhTW' AND `entry` = 27760;
-- OLD name : 洛瑞爾·真刃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27803
UPDATE `creature_template_locale` SET `Name` = '洛瑞爾‧真刃' WHERE `locale` = 'zhTW' AND `entry` = 27803;
-- OLD name : 葛拉克·岩拳 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27804
UPDATE `creature_template_locale` SET `Name` = '葛拉克‧岩拳' WHERE `locale` = 'zhTW' AND `entry` = 27804;
-- OLD name : 芬里克·巴羅威 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27842
UPDATE `creature_template_locale` SET `Name` = '芬里克‧巴羅威' WHERE `locale` = 'zhTW' AND `entry` = 27842;
-- OLD name : 大領主伯瓦爾·弗塔根 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27858
UPDATE `creature_template_locale` SET `Name` = '大領主伯瓦爾‧弗塔根' WHERE `locale` = 'zhTW' AND `entry` = 27858;
-- OLD name : TEST派迪的測試載具 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27862
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - vehicle' WHERE `locale` = 'zhTW' AND `entry` = 27862;
-- OLD name : 大領主伯瓦爾·弗塔根 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27872
UPDATE `creature_template_locale` SET `Name` = '大領主伯瓦爾‧弗塔根' WHERE `locale` = 'zhTW' AND `entry` = 27872;
-- OLD name : 柯爾克隆雙足翼龍坐騎(憤怒之門) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27873
UPDATE `creature_template_locale` SET `Name` = '柯爾克隆蠍尾獅坐騎(憤怒之門)' WHERE `locale` = 'zhTW' AND `entry` = 27873;
-- OLD name : 希爾維歐·皮雷利 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27876
UPDATE `creature_template_locale` SET `Name` = '希爾維歐‧皮雷利' WHERE `locale` = 'zhTW' AND `entry` = 27876;
-- OLD name : 瑪莎·高斯林 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27884
UPDATE `creature_template_locale` SET `Name` = '瑪莎‧高斯林' WHERE `locale` = 'zhTW' AND `entry` = 27884;
-- OLD name : 潔娜·安德森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27885
UPDATE `creature_template_locale` SET `Name` = '潔娜‧安德森' WHERE `locale` = 'zhTW' AND `entry` = 27885;
-- OLD name : 邁爾康·摩爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27891
UPDATE `creature_template_locale` SET `Name` = '邁爾康‧摩爾' WHERE `locale` = 'zhTW' AND `entry` = 27891;
-- OLD name : 羅傑·歐文斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27903
UPDATE `creature_template_locale` SET `Name` = '羅傑‧歐文斯' WHERE `locale` = 'zhTW' AND `entry` = 27903;
-- OLD name : 巴托比·拜特森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27907
UPDATE `creature_template_locale` SET `Name` = '巴托比‧拜特森' WHERE `locale` = 'zhTW' AND `entry` = 27907;
-- OLD name : 海軍上將巴瑞恩·韋斯溫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27951
UPDATE `creature_template_locale` SET `Name` = '海軍上將巴瑞恩‧韋斯溫' WHERE `locale` = 'zhTW' AND `entry` = 27951;
-- OLD name : [PH]扭曲巡者坐騎 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=27976
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 27976;
-- OLD name : 新鑄的鐵穴居怪
-- Source : https://www.wowhead.com/wotlk/tw/npc=27979
UPDATE `creature_template_locale` SET `Name` = '鑄鐵穴居怪' WHERE `locale` = 'zhTW' AND `entry` = 27979;
-- OLD name : 新鑄的鐵矮人
-- Source : https://www.wowhead.com/wotlk/tw/npc=27982
UPDATE `creature_template_locale` SET `Name` = '鍛造鐵矮人' WHERE `locale` = 'zhTW' AND `entry` = 27982;
-- OLD name : 赫米特·奈辛瓦里 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27986
UPDATE `creature_template_locale` SET `Name` = '赫米特‧奈辛瓦里' WHERE `locale` = 'zhTW' AND `entry` = 27986;
-- OLD name : 蒙特·膛擊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=27987
UPDATE `creature_template_locale` SET `Name` = '蒙特‧膛擊' WHERE `locale` = 'zhTW' AND `entry` = 27987;
-- OLD name : 冰錘中尉
-- Source : https://www.wowhead.com/wotlk/tw/npc=27994
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 27994;
-- OLD name : 荒原拾荒者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28005
UPDATE `creature_template_locale` SET `Name` = '荒原食腐者' WHERE `locale` = 'zhTW' AND `entry` = 28005;
-- OLD name : 大王眼鏡蛇
-- Source : https://www.wowhead.com/wotlk/tw/npc=28011
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 28011;
-- OLD name : 巴克·坎特威爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28031
UPDATE `creature_template_locale` SET `Name` = '巴克‧坎特威爾' WHERE `locale` = 'zhTW' AND `entry` = 28031;
-- OLD name : 威斯雷克斯·迅鉗 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28033
UPDATE `creature_template_locale` SET `Name` = '威斯雷克斯‧迅鉗' WHERE `locale` = 'zhTW' AND `entry` = 28033;
-- OLD name : 海德里厄斯·哈羅威 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28047
UPDATE `creature_template_locale` SET `Name` = '海德里厄斯‧哈羅威' WHERE `locale` = 'zhTW' AND `entry` = 28047;
-- OLD name : 加敏·賀索格 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28057
UPDATE `creature_template_locale` SET `Name` = '加敏‧賀索格' WHERE `locale` = 'zhTW' AND `entry` = 28057;
-- OLD name : 天藍蜂巢雄蜂
-- Source : https://www.wowhead.com/wotlk/tw/npc=28085
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 28085;
-- OLD name : 蘇·侯魯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28115
UPDATE `creature_template_locale` SET `Name` = '蘇‧侯魯' WHERE `locale` = 'zhTW' AND `entry` = 28115;
-- OLD name : 卡洛斯大爺
-- Source : https://www.wowhead.com/wotlk/tw/npc=28126
UPDATE `creature_template_locale` SET `Name` = '唐卡洛斯' WHERE `locale` = 'zhTW' AND `entry` = 28126;
-- OLD name : 卡洛斯大爺
-- Source : https://www.wowhead.com/wotlk/tw/npc=28132
UPDATE `creature_template_locale` SET `Name` = '唐卡洛斯' WHERE `locale` = 'zhTW' AND `entry` = 28132;
-- OLD name : [ph]爆炸的桶子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28173
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28173;
-- OLD name : [ph]哥布林建築工作人員 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28180
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28180;
-- OLD name : [DND] 水下建築工作人員 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28184
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28184;
-- OLD name : 坦瑞斯·暗血王子 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28194
UPDATE `creature_template_locale` SET `Name` = '坦瑞斯‧暗血王子' WHERE `locale` = 'zhTW' AND `entry` = 28194;
-- OLD name : 畢爾可·浮爍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28195
UPDATE `creature_template_locale` SET `Name` = '畢爾可‧浮爍' WHERE `locale` = 'zhTW' AND `entry` = 28195;
-- OLD name : 席德·惶修 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28196
UPDATE `creature_template_locale` SET `Name` = '席德‧惶修' WHERE `locale` = 'zhTW' AND `entry` = 28196;
-- OLD name : 基普·鉤掠 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28197
UPDATE `creature_template_locale` SET `Name` = '基普‧鉤掠' WHERE `locale` = 'zhTW' AND `entry` = 28197;
-- OLD name : [DND]L70ETC鼓 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28206
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28206;
-- OLD name : 『猩猩獵人』茍瑞格克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28214
UPDATE `creature_template_locale` SET `Name` = '『猩猩獵人』苟瑞格克' WHERE `locale` = 'zhTW' AND `entry` = 28214;
-- OLD name : 克雷格·鋼鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28261
UPDATE `creature_template_locale` SET `Name` = '克雷格‧鋼鬚' WHERE `locale` = 'zhTW' AND `entry` = 28261;
-- OLD name : 蒙特圭·克羅爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28262
UPDATE `creature_template_locale` SET `Name` = '蒙特圭‧克羅爾' WHERE `locale` = 'zhTW' AND `entry` = 28262;
-- OLD name : [DND]飛行點雄鷹 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28292
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28292;
-- OLD name : 史勒波·嘶桶 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28329
UPDATE `creature_template_locale` SET `Name` = '史勒波‧嘶桶' WHERE `locale` = 'zhTW' AND `entry` = 28329;
-- OLD name : 邁爾斯·西德尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28347
UPDATE `creature_template_locale` SET `Name` = '邁爾斯‧西德尼' WHERE `locale` = 'zhTW' AND `entry` = 28347;
-- OLD name : 火息術觸發器(斯卡迪)
-- Source : https://www.wowhead.com/wotlk/tw/npc=28351
UPDATE `creature_template_locale` SET `Name` = '火息觸發器(斯卡迪)' WHERE `locale` = 'zhTW' AND `entry` = 28351;
-- OLD name : 萊特·威廉斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28355
UPDATE `creature_template_locale` SET `Name` = '萊特‧威廉斯' WHERE `locale` = 'zhTW' AND `entry` = 28355;
-- OLD name : 毒尖
-- Source : https://www.wowhead.com/wotlk/tw/npc=28358
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 28358;
-- OLD name : 多里安·龍巡者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28376
UPDATE `creature_template_locale` SET `Name` = '多里安‧龍巡者' WHERE `locale` = 'zhTW' AND `entry` = 28376;
-- OLD name : 薩爾葛倫·荒疫使者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28443
UPDATE `creature_template_locale` SET `Name` = '薩爾葛倫‧荒疫使者' WHERE `locale` = 'zhTW' AND `entry` = 28443;
-- OLD name : 大領主達瑞安·莫格萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28444
UPDATE `creature_template_locale` SET `Name` = '大領主達瑞安‧莫格萊尼' WHERE `locale` = 'zhTW' AND `entry` = 28444;
-- OLD name : 寇爾提拉·亡織者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28447
UPDATE `creature_template_locale` SET `Name` = '寇爾提拉‧亡織者' WHERE `locale` = 'zhTW' AND `entry` = 28447;
-- OLD name : 歐貝茲·血禍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28448
UPDATE `creature_template_locale` SET `Name` = '歐貝茲‧血禍' WHERE `locale` = 'zhTW' AND `entry` = 28448;
-- OLD name : 赫米特·奈辛瓦里 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28451
UPDATE `creature_template_locale` SET `Name` = '赫米特‧奈辛瓦里' WHERE `locale` = 'zhTW' AND `entry` = 28451;
-- OLD name : [UNUSED]奎茲倫祭壇閘道 - 現實世界 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28469
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28469;
-- OLD name : 元素馴伏者達茍答 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28480
UPDATE `creature_template_locale` SET `Name` = '元素馴伏者達苟答' WHERE `locale` = 'zhTW' AND `entry` = 28480;
-- OLD name : Ronakada (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28501
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28501;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (28501, 'zhTW','NPC',NULL);
-- OLD name : 拷問者樂卡夫特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28554
UPDATE `creature_template_locale` SET `Name` = '拷問者阿爾馮斯' WHERE `locale` = 'zhTW' AND `entry` = 28554;
-- OLD name : 丹尼卡·森特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28618
UPDATE `creature_template_locale` SET `Name` = '丹尼卡‧森特' WHERE `locale` = 'zhTW' AND `entry` = 28618;
-- OLD name : 葛瑞森·鐵翼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28621
UPDATE `creature_template_locale` SET `Name` = '葛瑞森‧鐵翼' WHERE `locale` = 'zhTW' AND `entry` = 28621;
-- OLD name : 神秘的吉普賽人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28652
UPDATE `creature_template_locale` SET `Name` = '神秘的商人' WHERE `locale` = 'zhTW' AND `entry` = 28652;
-- OLD name : 奎茲倫預言者
-- Source : https://www.wowhead.com/wotlk/tw/npc=28671
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 28671;
-- OLD name : 艾魯丹·白雲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28674
UPDATE `creature_template_locale` SET `Name` = '艾魯丹‧白雲' WHERE `locale` = 'zhTW' AND `entry` = 28674;
-- OLD name : 英姬·魅光 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28682
UPDATE `creature_template_locale` SET `Name` = '英姬‧魅光' WHERE `locale` = 'zhTW' AND `entry` = 28682;
-- OLD name : 娜莉莎·紅金 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28685
UPDATE `creature_template_locale` SET `Name` = '娜莉莎‧紅金' WHERE `locale` = 'zhTW' AND `entry` = 28685;
-- OLD subname : 旅店老闆助理
-- Source : https://www.wowhead.com/wotlk/tw/npc=28686
UPDATE `creature_template_locale` SET `Title` = '旅館老闆助理' WHERE `locale` = 'zhTW' AND `entry` = 28686;
-- OLD name : 阿咪希·蒼凝 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28687
UPDATE `creature_template_locale` SET `Name` = '阿咪希‧蒼凝' WHERE `locale` = 'zhTW' AND `entry` = 28687;
-- OLD name : 血色馬伕 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28689
UPDATE `creature_template_locale` SET `Name` = '血色馬夫' WHERE `locale` = 'zhTW' AND `entry` = 28689;
-- OLD name : 塔西亞·喃谷 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28690
UPDATE `creature_template_locale` SET `Name` = '塔西亞‧喃谷' WHERE `locale` = 'zhTW' AND `entry` = 28690;
-- OLD name : 蘇珊娜·艾維羅 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28691
UPDATE `creature_template_locale` SET `Name` = '蘇珊娜‧艾維羅' WHERE `locale` = 'zhTW' AND `entry` = 28691;
-- OLD name : 『赤紅』傑克·芬朵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28692
UPDATE `creature_template_locale` SET `Name` = '『赤紅』傑克‧芬朵' WHERE `locale` = 'zhTW' AND `entry` = 28692;
-- OLD name : 艾拉得·席彌德 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28694
UPDATE `creature_template_locale` SET `Name` = '艾拉得‧席彌德' WHERE `locale` = 'zhTW' AND `entry` = 28694;
-- OLD name : 戴里克·馬克思 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28696
UPDATE `creature_template_locale` SET `Name` = '戴里克‧馬克思' WHERE `locale` = 'zhTW' AND `entry` = 28696;
-- OLD name : 提摩菲·歐杉科 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28697
UPDATE `creature_template_locale` SET `Name` = '提摩菲‧歐杉科' WHERE `locale` = 'zhTW' AND `entry` = 28697;
-- OLD name : 捷帝迪亞·漢德斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28698
UPDATE `creature_template_locale` SET `Name` = '捷帝迪亞‧漢德斯' WHERE `locale` = 'zhTW' AND `entry` = 28698;
-- OLD name : 查理斯·沃斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28699
UPDATE `creature_template_locale` SET `Name` = '查理斯‧沃斯' WHERE `locale` = 'zhTW' AND `entry` = 28699;
-- OLD name : 黛安·坎寧斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28700
UPDATE `creature_template_locale` SET `Name` = '黛安‧坎寧斯' WHERE `locale` = 'zhTW' AND `entry` = 28700;
-- OLD name : 提摩西·瓊斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28701
UPDATE `creature_template_locale` SET `Name` = '提摩西‧瓊斯' WHERE `locale` = 'zhTW' AND `entry` = 28701;
-- OLD name : 琳西·黑栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28703
UPDATE `creature_template_locale` SET `Name` = '琳西‧黑栓' WHERE `locale` = 'zhTW' AND `entry` = 28703;
-- OLD name : 桃樂西·伊根 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28704
UPDATE `creature_template_locale` SET `Name` = '桃樂西‧伊根' WHERE `locale` = 'zhTW' AND `entry` = 28704;
-- OLD subname : 烹飪訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=28705
UPDATE `creature_template_locale` SET `Title` = '宗師級烹飪訓練師' WHERE `locale` = 'zhTW' AND `entry` = 28705;
-- OLD subname : 急救訓練師 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28706
UPDATE `creature_template_locale` SET `Title` = '繃帶訓練師' WHERE `locale` = 'zhTW' AND `entry` = 28706;
-- OLD name : 安傑羅·佩斯卡多 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28707
UPDATE `creature_template_locale` SET `Name` = '安傑羅‧佩斯卡多' WHERE `locale` = 'zhTW' AND `entry` = 28707;
-- OLD name : 奇集·銅鉗 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28708
UPDATE `creature_template_locale` SET `Name` = '琪茲‧銅剪' WHERE `locale` = 'zhTW' AND `entry` = 28708;
-- OLD name : 伊爾汀·悲矛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28714
UPDATE `creature_template_locale` SET `Name` = '伊爾汀‧悲矛' WHERE `locale` = 'zhTW' AND `entry` = 28714;
-- OLD name : 沛爾嘉·安伯斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28716
UPDATE `creature_template_locale` SET `Name` = '沛爾嘉‧安伯斯' WHERE `locale` = 'zhTW' AND `entry` = 28716;
-- OLD name : 拉尼德·怒金, subname : 製皮和剝皮供應商 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28718
UPDATE `creature_template_locale` SET `Name` = '拉尼德‧怒金',`Title` = '製皮與剝皮材料' WHERE `locale` = 'zhTW' AND `entry` = 28718;
-- OLD name : 靈魂聖水器空間區 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28719
UPDATE `creature_template_locale` SET `Name` = '靈魂之泉空間區' WHERE `locale` = 'zhTW' AND `entry` = 28719;
-- OLD name : 蒂芬妮·卡地亞 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28721
UPDATE `creature_template_locale` SET `Name` = '蒂芬妮‧卡地亞' WHERE `locale` = 'zhTW' AND `entry` = 28721;
-- OLD name : 布萊恩·蘭德森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28722
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧蘭德森' WHERE `locale` = 'zhTW' AND `entry` = 28722;
-- OLD name : 拉蕾娜·德羅姆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28723
UPDATE `creature_template_locale` SET `Name` = '拉蕾娜‧德羅姆' WHERE `locale` = 'zhTW' AND `entry` = 28723;
-- OLD name : 靈魂聖水器兔子 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28724
UPDATE `creature_template_locale` SET `Name` = '靈魂之泉兔子' WHERE `locale` = 'zhTW' AND `entry` = 28724;
-- OLD name : 派翠西亞·伊根 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28725
UPDATE `creature_template_locale` SET `Name` = '派翠西亞‧伊根' WHERE `locale` = 'zhTW' AND `entry` = 28725;
-- OLD name : 多明尼克·史特凡諾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28726
UPDATE `creature_template_locale` SET `Name` = '多明尼克‧史特凡諾' WHERE `locale` = 'zhTW' AND `entry` = 28726;
-- OLD name : 愛德華·伊根 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28727
UPDATE `creature_template_locale` SET `Name` = '愛德華‧伊根' WHERE `locale` = 'zhTW' AND `entry` = 28727;
-- OLD name : 多里安·范恩斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28728
UPDATE `creature_template_locale` SET `Name` = '多里安‧范恩斯' WHERE `locale` = 'zhTW' AND `entry` = 28728;
-- OLD name : 瑪西亞·切斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28742
UPDATE `creature_template_locale` SET `Name` = '瑪西亞‧切斯' WHERE `locale` = 'zhTW' AND `entry` = 28742;
-- OLD subname : 飛行訓練師
-- Source : https://www.wowhead.com/wotlk/tw/npc=28746
UPDATE `creature_template_locale` SET `Title` = '寒冷氣候飛行訓練師' WHERE `locale` = 'zhTW' AND `entry` = 28746;
-- OLD name : 『瘸腳』哈古斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28760
UPDATE `creature_template_locale` SET `Name` = '『汙穢者』哈古斯' WHERE `locale` = 'zhTW' AND `entry` = 28760;
-- OLD name : [階段1]血色十字軍代理生物 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28763
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28763;
-- OLD name : [階段1]避風郡市民代理生物 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28764
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28764;
-- OLD name : [階段1]避風郡馬匹獎勵，步驟01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28767
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28767;
-- OLD name : 寇爾文·諾靈頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28771
UPDATE `creature_template_locale` SET `Name` = '寇爾文‧諾靈頓' WHERE `locale` = 'zhTW' AND `entry` = 28771;
-- OLD name : 安德魯·馬修斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28774
UPDATE `creature_template_locale` SET `Name` = '安德魯‧馬修斯' WHERE `locale` = 'zhTW' AND `entry` = 28774;
-- OLD name : 伊莉莎白·羅斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28776
UPDATE `creature_template_locale` SET `Name` = '伊莉莎白‧羅斯' WHERE `locale` = 'zhTW' AND `entry` = 28776;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=28791
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 28791;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/tw/npc=28800
UPDATE `creature_template_locale` SET `Title` = '彈藥商' WHERE `locale` = 'zhTW' AND `entry` = 28800;
-- OLD name : 查德·卡特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28806
UPDATE `creature_template_locale` SET `Name` = '查德‧卡特' WHERE `locale` = 'zhTW' AND `entry` = 28806;
-- OLD name : 文森·修伯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28809
UPDATE `creature_template_locale` SET `Name` = '文森‧修伯' WHERE `locale` = 'zhTW' AND `entry` = 28809;
-- OLD name : 布萊迪·鐵瓦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28811
UPDATE `creature_template_locale` SET `Name` = '布萊迪‧鐵瓦' WHERE `locale` = 'zhTW' AND `entry` = 28811;
-- OLD name : 拉普·風暴角 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28812
UPDATE `creature_template_locale` SET `Name` = '拉普‧風暴角' WHERE `locale` = 'zhTW' AND `entry` = 28812;
-- OLD name : 伊莉莎白·賀林思沃斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28813
UPDATE `creature_template_locale` SET `Name` = '伊莉莎白‧賀林思沃斯' WHERE `locale` = 'zhTW' AND `entry` = 28813;
-- OLD name : 渥克瀚的鐵砧
-- Source : https://www.wowhead.com/wotlk/tw/npc=28823
UPDATE `creature_template_locale` SET `Name` = '渥克瀚的鐵鉆' WHERE `locale` = 'zhTW' AND `entry` = 28823;
-- OLD name : 古神之血
-- Source : https://www.wowhead.com/wotlk/tw/npc=28854
UPDATE `creature_template_locale` SET `Name` = '上古之神鮮血' WHERE `locale` = 'zhTW' AND `entry` = 28854;
-- OLD subname : 錘和法杖 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28855
UPDATE `creature_template_locale` SET `Title` = '錘和法杖商人' WHERE `locale` = 'zhTW' AND `entry` = 28855;
-- OLD name : 寇爾提拉·亡織者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28912
UPDATE `creature_template_locale` SET `Name` = '寇爾提拉‧亡織者' WHERE `locale` = 'zhTW' AND `entry` = 28912;
-- OLD name : 歐貝茲·血禍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28914
UPDATE `creature_template_locale` SET `Name` = '歐貝茲‧血禍' WHERE `locale` = 'zhTW' AND `entry` = 28914;
-- OLD name : 丹賽爾·亞當斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28930
UPDATE `creature_template_locale` SET `Name` = '丹賽爾‧亞當斯' WHERE `locale` = 'zhTW' AND `entry` = 28930;
-- OLD name : [章節II]血色十字軍測試假人傢伙 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28957
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28957;
-- OLD name : 潔沙·編織者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28958
UPDATE `creature_template_locale` SET `Name` = '潔沙‧編織者' WHERE `locale` = 'zhTW' AND `entry` = 28958;
-- OLD name : 血色領主傑瑟利亞·麥克利 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28964
UPDATE `creature_template_locale` SET `Name` = '血色領主波魯亞' WHERE `locale` = 'zhTW' AND `entry` = 28964;
-- OLD name : [章節II]血色十字軍代理人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=28984
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 28984;
-- OLD name : 安東尼·都睿 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28990
UPDATE `creature_template_locale` SET `Name` = '安東尼‧都睿' WHERE `locale` = 'zhTW' AND `entry` = 28990;
-- OLD name : 汎拉登·銀刃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28991
UPDATE `creature_template_locale` SET `Name` = '汎拉登‧銀刃' WHERE `locale` = 'zhTW' AND `entry` = 28991;
-- OLD name : 維勒莉·朗格姆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28992
UPDATE `creature_template_locale` SET `Name` = '維勒莉‧朗格姆' WHERE `locale` = 'zhTW' AND `entry` = 28992;
-- OLD name : 依利絲·櫻草 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28993
UPDATE `creature_template_locale` SET `Name` = '依利絲‧櫻草' WHERE `locale` = 'zhTW' AND `entry` = 28993;
-- OLD name : 格力瑟達·杭德蘭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=28997
UPDATE `creature_template_locale` SET `Name` = '格力瑟達‧杭德蘭' WHERE `locale` = 'zhTW' AND `entry` = 28997;
-- OLD subname : 弓箭商
-- Source : https://www.wowhead.com/wotlk/tw/npc=29014
UPDATE `creature_template_locale` SET `Title` = '造箭者' WHERE `locale` = 'zhTW' AND `entry` = 29014;
-- OLD name : [DND]碼頭工人w/Bag (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=29020
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 29020;
-- OLD name : [609]黯黑堡決鬥獎勵 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=29025
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 29025;
-- OLD name : 瑪拉·勇角 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29032
UPDATE `creature_template_locale` SET `Name` = '瑪拉‧勇角' WHERE `locale` = 'zhTW' AND `entry` = 29032;
-- OLD name : 蘇·醬
-- Source : https://www.wowhead.com/wotlk/tw/npc=29037
UPDATE `creature_template_locale` SET `Name` = '蘇-醬' WHERE `locale` = 'zhTW' AND `entry` = 29037;
-- OLD name : [章節II]火炬投擲假人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=29038
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 29038;
-- OLD name : [UNUSED][ph]暴風獅鷲獸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29039
UPDATE `creature_template_locale` SET `Name` = 'REUSE' WHERE `locale` = 'zhTW' AND `entry` = 29039;
-- OLD name : 艾立爾·蒼凝 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29049
UPDATE `creature_template_locale` SET `Name` = '艾立爾‧蒼凝' WHERE `locale` = 'zhTW' AND `entry` = 29049;
-- OLD name : 艾倫·史坦布利吉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29061
UPDATE `creature_template_locale` SET `Name` = '艾倫‧史坦布利吉' WHERE `locale` = 'zhTW' AND `entry` = 29061;
-- OLD name : 雅茲米娜·橡棘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29065
UPDATE `creature_template_locale` SET `Name` = '雅茲米娜‧橡棘' WHERE `locale` = 'zhTW' AND `entry` = 29065;
-- OLD name : 多諾汎·普佛羅斯特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29067
UPDATE `creature_template_locale` SET `Name` = '多諾汎‧普佛羅斯特' WHERE `locale` = 'zhTW' AND `entry` = 29067;
-- OLD name : 高比·布萊頓海默 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29068
UPDATE `creature_template_locale` SET `Name` = '高比‧布萊頓海默' WHERE `locale` = 'zhTW' AND `entry` = 29068;
-- OLD name : 安東尼·布瑞克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29071
UPDATE `creature_template_locale` SET `Name` = '安東尼‧布瑞克' WHERE `locale` = 'zhTW' AND `entry` = 29071;
-- OLD name : 庫格·鐵顎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29072
UPDATE `creature_template_locale` SET `Name` = '庫格‧鐵顎' WHERE `locale` = 'zhTW' AND `entry` = 29072;
-- OLD name : 伊吉·暗牙 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29073
UPDATE `creature_template_locale` SET `Name` = '伊吉‧暗牙' WHERE `locale` = 'zhTW' AND `entry` = 29073;
-- OLD name : 『惡運』派迪麥克斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29083
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - The Duece' WHERE `locale` = 'zhTW' AND `entry` = 29083;
-- OLD name : 伊安·崔克
-- Source : https://www.wowhead.com/wotlk/tw/npc=29093
UPDATE `creature_template_locale` SET `Name` = '伊恩·崔克' WHERE `locale` = 'zhTW' AND `entry` = 29093;
-- OLD name : 愛德華·坎爾
-- Source : https://www.wowhead.com/wotlk/tw/npc=29095
UPDATE `creature_template_locale` SET `Name` = '艾德華·坎爾' WHERE `locale` = 'zhTW' AND `entry` = 29095;
-- OLD name : 完全一般兔子 x8.0 (JSB) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29100
UPDATE `creature_template_locale` SET `Name` = 'Universal Bunny - DNT' WHERE `locale` = 'zhTW' AND `entry` = 29100;
-- OLD name : 高階指揮官嘉爾瓦·波爾伯勒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29114
UPDATE `creature_template_locale` SET `Name` = '高階指揮官嘉爾瓦‧波爾伯勒' WHERE `locale` = 'zhTW' AND `entry` = 29114;
-- OLD name : 佩拉·銅刷 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29141
UPDATE `creature_template_locale` SET `Name` = '佩拉‧銅刷' WHERE `locale` = 'zhTW' AND `entry` = 29141;
-- OLD name : 捷林奈克·利剪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29142
UPDATE `creature_template_locale` SET `Name` = '捷林奈克‧利剪' WHERE `locale` = 'zhTW' AND `entry` = 29142;
-- OLD name : 普立克·迅斷 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29145
UPDATE `creature_template_locale` SET `Name` = '普立克‧迅斷' WHERE `locale` = 'zhTW' AND `entry` = 29145;
-- OLD name : 薩茍德·鐵翼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29154
UPDATE `creature_template_locale` SET `Name` = '薩苟德‧鐵翼' WHERE `locale` = 'zhTW' AND `entry` = 29154;
-- OLD name : 葛林布茲·雷酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29157
UPDATE `creature_template_locale` SET `Name` = '葛林布茲‧雷酒' WHERE `locale` = 'zhTW' AND `entry` = 29157;
-- OLD name : 大領主達瑞安·莫格萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29173
UPDATE `creature_template_locale` SET `Name` = '大領主達瑞安‧莫格萊尼' WHERE `locale` = 'zhTW' AND `entry` = 29173;
-- OLD name : 大領主提里奧·弗丁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29175
UPDATE `creature_template_locale` SET `Name` = '大領主提里奧‧弗丁' WHERE `locale` = 'zhTW' AND `entry` = 29175;
-- OLD name : 指揮官艾利格·黎明使者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29177
UPDATE `creature_template_locale` SET `Name` = '指揮官艾利格‧黎明使者' WHERE `locale` = 'zhTW' AND `entry` = 29177;
-- OLD name : 麥斯威爾·泰羅索斯領主 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29178
UPDATE `creature_template_locale` SET `Name` = '麥斯威爾‧泰羅索斯領主' WHERE `locale` = 'zhTW' AND `entry` = 29178;
-- OLD name : 可敬的萊尼德·巴薩羅梅 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29179
UPDATE `creature_template_locale` SET `Name` = '可敬的萊尼德‧巴薩羅梅' WHERE `locale` = 'zhTW' AND `entry` = 29179;
-- OLD name : 尼古拉斯·瑟倫霍夫公爵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29180
UPDATE `creature_template_locale` SET `Name` = '尼古拉斯‧瑟倫霍夫公爵' WHERE `locale` = 'zhTW' AND `entry` = 29180;
-- OLD name : 林布拉特·碎地者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29182
UPDATE `creature_template_locale` SET `Name` = '林布拉特‧碎地者' WHERE `locale` = 'zhTW' AND `entry` = 29182;
-- OLD name : [章節IV]章節IV假人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=29192
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 29192;
-- OLD name : 寇爾提拉·亡織者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29199
UPDATE `creature_template_locale` SET `Name` = '寇爾提拉‧亡織者' WHERE `locale` = 'zhTW' AND `entry` = 29199;
-- OLD name : 歐貝茲·血禍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29204
UPDATE `creature_template_locale` SET `Name` = '歐貝茲‧血禍' WHERE `locale` = 'zhTW' AND `entry` = 29204;
-- OLD name : 大領主亞歷山卓斯·莫格萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29227
UPDATE `creature_template_locale` SET `Name` = '大領主亞歷山卓斯‧莫格萊尼' WHERE `locale` = 'zhTW' AND `entry` = 29227;
-- OLD name : 達瑞安·莫格萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29228
UPDATE `creature_template_locale` SET `Name` = '達瑞安‧莫格萊尼' WHERE `locale` = 'zhTW' AND `entry` = 29228;
-- OLD subname : 急救訓練師 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29233
UPDATE `creature_template_locale` SET `Title` = '繃帶訓練師' WHERE `locale` = 'zhTW' AND `entry` = 29233;
-- OLD name : 傑希·瑪斯特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29244
UPDATE `creature_template_locale` SET `Name` = '傑希‧瑪斯特' WHERE `locale` = 'zhTW' AND `entry` = 29244;
-- OLD name : [章節IV]黎明曙光獎勵 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=29245
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 29245;
-- OLD name : 大領主達瑞安·莫格萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29246
UPDATE `creature_template_locale` SET `Name` = '大領主達瑞安‧莫格萊尼' WHERE `locale` = 'zhTW' AND `entry` = 29246;
-- OLD name : 提姆·史曲特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29250
UPDATE `creature_template_locale` SET `Name` = '提姆‧史曲特' WHERE `locale` = 'zhTW' AND `entry` = 29250;
-- OLD name : 傑森·瑞金斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29252
UPDATE `creature_template_locale` SET `Name` = '傑森‧瑞金斯' WHERE `locale` = 'zhTW' AND `entry` = 29252;
-- OLD name : 溫都·炫亮 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29261
UPDATE `creature_template_locale` SET `Name` = '溫都‧炫亮' WHERE `locale` = 'zhTW' AND `entry` = 29261;
-- OLD name : 喬格利爾·鑽炫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29262
UPDATE `creature_template_locale` SET `Name` = '喬格利爾‧鑽炫' WHERE `locale` = 'zhTW' AND `entry` = 29262;
-- OLD name : 派迪麥克斯盤旋假人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29263
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - Hovering Dummy' WHERE `locale` = 'zhTW' AND `entry` = 29263;
-- OLD name : 戴塔羅·小球 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29277
UPDATE `creature_template_locale` SET `Name` = '戴塔羅‧小球' WHERE `locale` = 'zhTW' AND `entry` = 29277;
-- OLD name : 保羅·卡佛上尉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29287
UPDATE `creature_template_locale` SET `Name` = '保羅‧卡佛上尉' WHERE `locale` = 'zhTW' AND `entry` = 29287;
-- OLD name : 工程師克帝斯·沛達克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29288
UPDATE `creature_template_locale` SET `Name` = '工程師克帝斯‧沛達克' WHERE `locale` = 'zhTW' AND `entry` = 29288;
-- OLD name : 大副伊嘉·弗羅利斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29289
UPDATE `creature_template_locale` SET `Name` = '大副伊嘉‧弗羅利斯' WHERE `locale` = 'zhTW' AND `entry` = 29289;
-- OLD name : 領航員里安·托斯特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29290
UPDATE `creature_template_locale` SET `Name` = '領航員里安‧托斯特' WHERE `locale` = 'zhTW' AND `entry` = 29290;
-- OLD name : 船艙長保羅·庫比特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29291
UPDATE `creature_template_locale` SET `Name` = '船艙長保羅‧庫比特' WHERE `locale` = 'zhTW' AND `entry` = 29291;
-- OLD name : 亞特·佩許寇夫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29292
UPDATE `creature_template_locale` SET `Name` = '亞特‧佩許寇夫' WHERE `locale` = 'zhTW' AND `entry` = 29292;
-- OLD name : 丹尼爾·克拉默 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29293
UPDATE `creature_template_locale` SET `Name` = '丹尼爾‧克拉默' WHERE `locale` = 'zhTW' AND `entry` = 29293;
-- OLD name : 坎蒂絲·湯瑪斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29294
UPDATE `creature_template_locale` SET `Name` = '坎蒂絲‧湯瑪斯' WHERE `locale` = 'zhTW' AND `entry` = 29294;
-- OLD name : 梅根·多森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29295
UPDATE `creature_template_locale` SET `Name` = '梅根‧多森' WHERE `locale` = 'zhTW' AND `entry` = 29295;
-- OLD name : 賈斯汀·貝姆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29296
UPDATE `creature_template_locale` SET `Name` = '賈斯汀‧貝姆' WHERE `locale` = 'zhTW' AND `entry` = 29296;
-- OLD name : 麥可·科波拉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29297
UPDATE `creature_template_locale` SET `Name` = '麥可‧科波拉' WHERE `locale` = 'zhTW' AND `entry` = 29297;
-- OLD name : 班傑明·厄沃塔 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29298
UPDATE `creature_template_locale` SET `Name` = '班傑明‧厄沃塔' WHERE `locale` = 'zhTW' AND `entry` = 29298;
-- OLD name : 瑟班·歐普瑞斯庫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29299
UPDATE `creature_template_locale` SET `Name` = '瑟班‧歐普瑞斯庫' WHERE `locale` = 'zhTW' AND `entry` = 29299;
-- OLD name : 羅伯特·理查森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29300
UPDATE `creature_template_locale` SET `Name` = '羅伯特‧理查森' WHERE `locale` = 'zhTW' AND `entry` = 29300;
-- OLD name : [PH]測試滑冰者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=29361
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 29361;
-- OLD name : 風暴冶煉監工 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29369
UPDATE `creature_template_locale` SET `Name` = '風鑄監工' WHERE `locale` = 'zhTW' AND `entry` = 29369;
-- OLD name : 風暴冶煉勇士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29370
UPDATE `creature_template_locale` SET `Name` = '風鑄勇士' WHERE `locale` = 'zhTW' AND `entry` = 29370;
-- OLD name : 風暴冶煉魔導師 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29374
UPDATE `creature_template_locale` SET `Name` = '風鑄魔導師' WHERE `locale` = 'zhTW' AND `entry` = 29374;
-- OLD name : 風暴冶煉鐵巨人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29375
UPDATE `creature_template_locale` SET `Name` = '風鑄鐵巨人' WHERE `locale` = 'zhTW' AND `entry` = 29375;
-- OLD name : 風暴冶煉設計者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29376
UPDATE `creature_template_locale` SET `Name` = '風鑄工藝師' WHERE `locale` = 'zhTW' AND `entry` = 29376;
-- OLD name : 風暴冶煉劫掠者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29377
UPDATE `creature_template_locale` SET `Name` = '風鑄劫掠者' WHERE `locale` = 'zhTW' AND `entry` = 29377;
-- OLD name : 風暴冶煉戰爭魔像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29380
UPDATE `creature_template_locale` SET `Name` = '風鑄戰爭魔像' WHERE `locale` = 'zhTW' AND `entry` = 29380;
-- OLD name : 風暴冶煉劫奪者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29382
UPDATE `creature_template_locale` SET `Name` = '風鑄劫奪者' WHERE `locale` = 'zhTW' AND `entry` = 29382;
-- OLD name : 瑟塔爾·暗癒者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29396
UPDATE `creature_template_locale` SET `Name` = '瑟塔爾‧暗癒者' WHERE `locale` = 'zhTW' AND `entry` = 29396;
-- OLD name : 烏佐·喚死者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29405
UPDATE `creature_template_locale` SET `Name` = '烏佐‧喚死者' WHERE `locale` = 'zhTW' AND `entry` = 29405;
-- OLD name : 傑森·莫里斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29418
UPDATE `creature_template_locale` SET `Name` = '傑森‧莫里斯' WHERE `locale` = 'zhTW' AND `entry` = 29418;
-- OLD name : 朱利安·莫里斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29419
UPDATE `creature_template_locale` SET `Name` = '朱利安‧莫里斯' WHERE `locale` = 'zhTW' AND `entry` = 29419;
-- OLD name : 潔西卡·莫里斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29420
UPDATE `creature_template_locale` SET `Name` = '潔西卡‧莫里斯' WHERE `locale` = 'zhTW' AND `entry` = 29420;
-- OLD name : 妮可·莫里斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29421
UPDATE `creature_template_locale` SET `Name` = '妮可‧莫里斯' WHERE `locale` = 'zhTW' AND `entry` = 29421;
-- OLD name : 風暴冶煉閃電目標 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29424
UPDATE `creature_template_locale` SET `Name` = '風鑄閃電目標' WHERE `locale` = 'zhTW' AND `entry` = 29424;
-- OLD name : 托爾·滾鉗 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29430
UPDATE `creature_template_locale` SET `Name` = '托爾‧滾鉗' WHERE `locale` = 'zhTW' AND `entry` = 29430;
-- OLD name : 吉爾·炫臼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29431
UPDATE `creature_template_locale` SET `Name` = '吉爾‧炫臼' WHERE `locale` = 'zhTW' AND `entry` = 29431;
-- OLD name : 野牛·厲禍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29456
UPDATE `creature_template_locale` SET `Name` = '野牛‧厲禍' WHERE `locale` = 'zhTW' AND `entry` = 29456;
-- OLD name : 格雷森·嘶炫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29473
UPDATE `creature_template_locale` SET `Name` = '格雷森‧嘶炫' WHERE `locale` = 'zhTW' AND `entry` = 29473;
-- OLD name : 妲戈娜·燧鎖 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29476
UPDATE `creature_template_locale` SET `Name` = '妲戈娜‧燧鎖' WHERE `locale` = 'zhTW' AND `entry` = 29476;
-- OLD name : 杰佩托·樂吱 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29478
UPDATE `creature_template_locale` SET `Name` = '杰佩托‧樂吱' WHERE `locale` = 'zhTW' AND `entry` = 29478;
-- OLD name : 傑洛德·普勒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29493
UPDATE `creature_template_locale` SET `Name` = '傑洛德‧普勒' WHERE `locale` = 'zhTW' AND `entry` = 29493;
-- OLD name : 諾文·埃德曼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29495
UPDATE `creature_template_locale` SET `Name` = '諾文‧埃德曼' WHERE `locale` = 'zhTW' AND `entry` = 29495;
-- OLD name : 華瑟·懷特弗德 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29497
UPDATE `creature_template_locale` SET `Name` = '華瑟‧懷特弗德' WHERE `locale` = 'zhTW' AND `entry` = 29497;
-- OLD name : 巴特瑞·赫勒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29499
UPDATE `creature_template_locale` SET `Name` = '巴特瑞‧赫勒' WHERE `locale` = 'zhTW' AND `entry` = 29499;
-- OLD name : 伊敏萃兒·矛歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29505
UPDATE `creature_template_locale` SET `Name` = '伊敏萃兒‧矛歌' WHERE `locale` = 'zhTW' AND `entry` = 29505;
-- OLD name : 奧蘭德·席佛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29506
UPDATE `creature_template_locale` SET `Name` = '奧蘭德‧席佛' WHERE `locale` = 'zhTW' AND `entry` = 29506;
-- OLD name : 邁弗瑞德·斯托勒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29507
UPDATE `creature_template_locale` SET `Name` = '邁弗瑞德‧斯托勒' WHERE `locale` = 'zhTW' AND `entry` = 29507;
-- OLD name : 納姆哈·月水 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29509
UPDATE `creature_template_locale` SET `Name` = '納姆哈‧月水' WHERE `locale` = 'zhTW' AND `entry` = 29509;
-- OLD name : 莉娜·布魯德 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29510
UPDATE `creature_template_locale` SET `Name` = '莉娜‧布魯德' WHERE `locale` = 'zhTW' AND `entry` = 29510;
-- OLD name : 拉菈·亮織 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29511
UPDATE `creature_template_locale` SET `Name` = '拉菈‧亮織' WHERE `locale` = 'zhTW' AND `entry` = 29511;
-- OLD name : 安戴魯·夏葉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29512
UPDATE `creature_template_locale` SET `Name` = '安戴魯‧夏葉' WHERE `locale` = 'zhTW' AND `entry` = 29512;
-- OLD name : 『板手』狄迪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29513
UPDATE `creature_template_locale` SET `Name` = '『扳手』狄迪' WHERE `locale` = 'zhTW' AND `entry` = 29513;
-- OLD name : 芬朵·嘯汽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29514
UPDATE `creature_template_locale` SET `Name` = '芬朵‧嘯汽' WHERE `locale` = 'zhTW' AND `entry` = 29514;
-- OLD name : 奇夫·嘶炫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29525
UPDATE `creature_template_locale` SET `Name` = '奇夫‧嘶炫' WHERE `locale` = 'zhTW' AND `entry` = 29525;
-- OLD name : 歐爾頓·班尼特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29527
UPDATE `creature_template_locale` SET `Name` = '歐爾頓‧班尼特' WHERE `locale` = 'zhTW' AND `entry` = 29527;
-- OLD name : 黛比·摩爾, subname : 飾品和符咒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29528
UPDATE `creature_template_locale` SET `Name` = '黛比‧摩爾',`Title` = '飾品和符咒商人' WHERE `locale` = 'zhTW' AND `entry` = 29528;
-- OLD subname : 旅店老闆
-- Source : https://www.wowhead.com/wotlk/tw/npc=29532
UPDATE `creature_template_locale` SET `Title` = '旅館老闆' WHERE `locale` = 'zhTW' AND `entry` = 29532;
-- OLD name : 『塞爾大叔』史金巴利·斷栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29533
UPDATE `creature_template_locale` SET `Name` = '『塞爾大叔』史金巴利‧斷栓' WHERE `locale` = 'zhTW' AND `entry` = 29533;
-- OLD subname : 競技場編制者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29534
UPDATE `creature_template_locale` SET `Title` = '競技場登記員' WHERE `locale` = 'zhTW' AND `entry` = 29534;
-- OLD subname : 施法材料和魔法物品 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29537
UPDATE `creature_template_locale` SET `Title` = '施法材料和魔法物品供應商' WHERE `locale` = 'zhTW' AND `entry` = 29537;
-- OLD name : 海希爾·加洛特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29538
UPDATE `creature_template_locale` SET `Name` = '海希爾‧加洛特' WHERE `locale` = 'zhTW' AND `entry` = 29538;
-- OLD name : 納高·鞭索 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29539
UPDATE `creature_template_locale` SET `Name` = '納高‧鞭索' WHERE `locale` = 'zhTW' AND `entry` = 29539;
-- OLD name : 札奇·燻管 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29540
UPDATE `creature_template_locale` SET `Name` = '札奇‧燻管' WHERE `locale` = 'zhTW' AND `entry` = 29540;
-- OLD name : 扎姆·巴康 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29541
UPDATE `creature_template_locale` SET `Name` = '扎姆‧巴康' WHERE `locale` = 'zhTW' AND `entry` = 29541;
-- OLD name : 蘋果樹枝 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29547
UPDATE `creature_template_locale` SET `Name` = '蘋枝' WHERE `locale` = 'zhTW' AND `entry` = 29547;
-- OLD name : 『技巧』理查·鏽栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29568
UPDATE `creature_template_locale` SET `Name` = '『技巧』理查‧鏽栓' WHERE `locale` = 'zhTW' AND `entry` = 29568;
-- OLD name : 布萊恩·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29579
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 29579;
-- OLD name : 黯刃翼騎
-- Source : https://www.wowhead.com/wotlk/tw/npc=29582
UPDATE `creature_template_locale` SET `Name` = '黯刃飛行戰駒' WHERE `locale` = 'zhTW' AND `entry` = 29582;
-- OLD name : 風暴冶煉掠取者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29586
UPDATE `creature_template_locale` SET `Name` = '風鑄掠取者' WHERE `locale` = 'zhTW' AND `entry` = 29586;
-- OLD name : 約格·風暴之心 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29593
UPDATE `creature_template_locale` SET `Name` = '約格‧風暴之心' WHERE `locale` = 'zhTW' AND `entry` = 29593;
-- OLD name : 布洛·熊皮 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29604
UPDATE `creature_template_locale` SET `Name` = '布洛‧熊皮' WHERE `locale` = 'zhTW' AND `entry` = 29604;
-- OLD name : 瓦麗拉·桑古納爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29607
UPDATE `creature_template_locale` SET `Name` = '瓦麗拉‧桑古納爾' WHERE `locale` = 'zhTW' AND `entry` = 29607;
-- OLD name : 瓦里安·烏瑞恩國王, subname : 暴風之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29611
UPDATE `creature_template_locale` SET `Name` = '瓦里安‧烏瑞恩國王',`Title` = '暴風城之王' WHERE `locale` = 'zhTW' AND `entry` = 29611;
-- OLD name : 托爾瑪·霜膽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29626
UPDATE `creature_template_locale` SET `Name` = '托爾瑪‧霜膽' WHERE `locale` = 'zhTW' AND `entry` = 29626;
-- OLD name : 安潔利奎·巴特勒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29628
UPDATE `creature_template_locale` SET `Name` = '安潔利奎‧巴特勒' WHERE `locale` = 'zhTW' AND `entry` = 29628;
-- OLD name : 阿維羅·隆貢巴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29631
UPDATE `creature_template_locale` SET `Name` = '阿維羅‧隆貢巴' WHERE `locale` = 'zhTW' AND `entry` = 29631;
-- OLD name : 喬絲·伯奇 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29640
UPDATE `creature_template_locale` SET `Name` = '喬絲‧伯奇' WHERE `locale` = 'zhTW' AND `entry` = 29640;
-- OLD name : 瑟利莎·沃夫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29641
UPDATE `creature_template_locale` SET `Name` = '瑟利莎‧沃夫' WHERE `locale` = 'zhTW' AND `entry` = 29641;
-- OLD name : 博克塔·血怒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29651
UPDATE `creature_template_locale` SET `Name` = '博克塔‧血怒' WHERE `locale` = 'zhTW' AND `entry` = 29651;
-- OLD name : 風暴冶煉追蹤者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29652
UPDATE `creature_template_locale` SET `Name` = '風鑄追蹤者' WHERE `locale` = 'zhTW' AND `entry` = 29652;
-- OLD name : 『鎖撬』帕茲克·撬鎖 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29665
UPDATE `creature_template_locale` SET `Name` = '『鎖撬』帕茲克‧撬鎖' WHERE `locale` = 'zhTW' AND `entry` = 29665;
-- OLD name : 毒蛇防衛者
-- Source : https://www.wowhead.com/wotlk/tw/npc=29693
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 29693;
-- OLD name : 風暴冶煉追捕者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29696
UPDATE `creature_template_locale` SET `Name` = '風鑄追捕者' WHERE `locale` = 'zhTW' AND `entry` = 29696;
-- OLD name : 恰梅里·巴拿費許 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29702
UPDATE `creature_template_locale` SET `Name` = '恰梅里‧巴拿費許' WHERE `locale` = 'zhTW' AND `entry` = 29702;
-- OLD name : 薛斗·光爍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29703
UPDATE `creature_template_locale` SET `Name` = '薛斗‧光爍' WHERE `locale` = 'zhTW' AND `entry` = 29703;
-- OLD name : 魯西安·提亞斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29714
UPDATE `creature_template_locale` SET `Name` = '魯西安‧提亞斯' WHERE `locale` = 'zhTW' AND `entry` = 29714;
-- OLD name : 菲亞拉·甜莓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29715
UPDATE `creature_template_locale` SET `Name` = '菲亞拉‧甜莓' WHERE `locale` = 'zhTW' AND `entry` = 29715;
-- OLD name : 史基索·巧滑 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29721
UPDATE `creature_template_locale` SET `Name` = '史基索‧巧滑' WHERE `locale` = 'zhTW' AND `entry` = 29721;
-- OLD name : 班尼克·栓剪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29725
UPDATE `creature_template_locale` SET `Name` = '班尼克‧栓剪' WHERE `locale` = 'zhTW' AND `entry` = 29725;
-- OLD name : 格洛梭·硬鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29727
UPDATE `creature_template_locale` SET `Name` = '格洛梭‧硬鬚' WHERE `locale` = 'zhTW' AND `entry` = 29727;
-- OLD name : 華特·索瑞夫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29728
UPDATE `creature_template_locale` SET `Name` = '華特‧索瑞夫' WHERE `locale` = 'zhTW' AND `entry` = 29728;
-- OLD name : 弗尤林·霜眉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29732
UPDATE `creature_template_locale` SET `Name` = '弗尤林‧霜眉' WHERE `locale` = 'zhTW' AND `entry` = 29732;
-- OLD name : 克拉加·鐵刺 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29740
UPDATE `creature_template_locale` SET `Name` = '克拉加‧鐵刺' WHERE `locale` = 'zhTW' AND `entry` = 29740;
-- OLD name : 洛克·銳頦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29744
UPDATE `creature_template_locale` SET `Name` = '洛克‧銳頦' WHERE `locale` = 'zhTW' AND `entry` = 29744;
-- OLD name : 摩嘉娜·日炎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29749
UPDATE `creature_template_locale` SET `Name` = '摩嘉娜‧日炎' WHERE `locale` = 'zhTW' AND `entry` = 29749;
-- OLD name : 德洛·霜握 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29751
UPDATE `creature_template_locale` SET `Name` = '德洛‧霜握' WHERE `locale` = 'zhTW' AND `entry` = 29751;
-- OLD name : 卡巴格·馴風者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29757
UPDATE `creature_template_locale` SET `Name` = '卡巴格‧馴風者' WHERE `locale` = 'zhTW' AND `entry` = 29757;
-- OLD name : 海揚·派克, subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29762
UPDATE `creature_template_locale` SET `Name` = '海揚‧派克',`Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 29762;
-- OLD name : 西拉納·冰嘯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29794
UPDATE `creature_template_locale` SET `Name` = '西拉納‧冰嘯' WHERE `locale` = 'zhTW' AND `entry` = 29794;
-- OLD name : 寇爾提拉·亡織者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29795
UPDATE `creature_template_locale` SET `Name` = '寇爾提拉‧亡織者' WHERE `locale` = 'zhTW' AND `entry` = 29795;
-- OLD name : [DND]達拉然玩具石飛機掛勾 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=29807
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 29807;
-- OLD name : [DND]達拉然玩具店飛機掛繩兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=29812
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 29812;
-- OLD name : 艾絲翠德·畢優利塔 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29839
UPDATE `creature_template_locale` SET `Name` = '艾絲翠德‧畢優利塔' WHERE `locale` = 'zhTW' AND `entry` = 29839;
-- OLD name : 風暴冶煉尋知者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29843
UPDATE `creature_template_locale` SET `Name` = '風鑄尋知者' WHERE `locale` = 'zhTW' AND `entry` = 29843;
-- OLD name : 風暴冶煉根除者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29861
UPDATE `creature_template_locale` SET `Name` = '風鑄根除者' WHERE `locale` = 'zhTW' AND `entry` = 29861;
-- OLD name : 風暴冶煉監控者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29862
UPDATE `creature_template_locale` SET `Name` = '風鑄監控者' WHERE `locale` = 'zhTW' AND `entry` = 29862;
-- OLD name : 微笑的斯勒克·銅扳 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29904
UPDATE `creature_template_locale` SET `Name` = '微笑的斯勒克‧銅扳' WHERE `locale` = 'zhTW' AND `entry` = 29904;
-- OLD name : 葛里利克斯·骨鋸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29905
UPDATE `creature_template_locale` SET `Name` = '葛里利克斯‧骨鋸' WHERE `locale` = 'zhTW' AND `entry` = 29905;
-- OLD name : 薩爾克·栓錘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29907
UPDATE `creature_template_locale` SET `Name` = '薩爾克‧栓錘' WHERE `locale` = 'zhTW' AND `entry` = 29907;
-- OLD name : 波立普·肥囊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29908
UPDATE `creature_template_locale` SET `Name` = '波立普‧肥囊' WHERE `locale` = 'zhTW' AND `entry` = 29908;
-- OLD name : 妮麗卡·疾杯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29909
UPDATE `creature_template_locale` SET `Name` = '妮麗卡‧疾杯' WHERE `locale` = 'zhTW' AND `entry` = 29909;
-- OLD name : 達格尼·歐瑞格林 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29923
UPDATE `creature_template_locale` SET `Name` = '達格尼‧歐瑞格林' WHERE `locale` = 'zhTW' AND `entry` = 29923;
-- OLD name : 路特納·鋼剔 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29925
UPDATE `creature_template_locale` SET `Name` = '路特納‧鋼剔' WHERE `locale` = 'zhTW' AND `entry` = 29925;
-- OLD name : 剛達·粗錘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29926
UPDATE `creature_template_locale` SET `Name` = '剛達‧粗錘' WHERE `locale` = 'zhTW' AND `entry` = 29926;
-- OLD name : 摩特哈·風誕 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29937
UPDATE `creature_template_locale` SET `Name` = '摩特哈‧風誕' WHERE `locale` = 'zhTW' AND `entry` = 29937;
-- OLD name : 布瑞克·岩眉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29950
UPDATE `creature_template_locale` SET `Name` = '布瑞克‧岩眉' WHERE `locale` = 'zhTW' AND `entry` = 29950;
-- OLD name : 安杜格·瓦膛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29959
UPDATE `creature_template_locale` SET `Name` = '安杜格‧瓦膛' WHERE `locale` = 'zhTW' AND `entry` = 29959;
-- OLD name : 梅茍恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29963
UPDATE `creature_template_locale` SET `Name` = '梅苟恩' WHERE `locale` = 'zhTW' AND `entry` = 29963;
-- OLD name : 達古·錘深 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29964
UPDATE `creature_template_locale` SET `Name` = '達古‧錘深' WHERE `locale` = 'zhTW' AND `entry` = 29964;
-- OLD name : 烏多侯·冰奔者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29967
UPDATE `creature_template_locale` SET `Name` = '烏多侯‧冰奔者' WHERE `locale` = 'zhTW' AND `entry` = 29967;
-- OLD name : 哈帕努·冷風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29968
UPDATE `creature_template_locale` SET `Name` = '哈帕努‧冷風' WHERE `locale` = 'zhTW' AND `entry` = 29968;
-- OLD name : 丹侯·遙雲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29970
UPDATE `creature_template_locale` SET `Name` = '丹侯‧遙雲' WHERE `locale` = 'zhTW' AND `entry` = 29970;
-- OLD name : 瓦巴達·白花 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=29971
UPDATE `creature_template_locale` SET `Name` = '瓦巴達‧白花' WHERE `locale` = 'zhTW' AND `entry` = 29971;
-- OLD name : 『野獸大師』卡里 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30008
UPDATE `creature_template_locale` SET `Name` = '『馴獸者』卡里' WHERE `locale` = 'zhTW' AND `entry` = 30008;
-- OLD name : 裴拉·因加多提爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30010
UPDATE `creature_template_locale` SET `Name` = '裴拉‧因加多提爾' WHERE `locale` = 'zhTW' AND `entry` = 30010;
-- OLD name : 賽拉·克微蕭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30041
UPDATE `creature_template_locale` SET `Name` = '賽拉‧克微蕭' WHERE `locale` = 'zhTW' AND `entry` = 30041;
-- OLD name : 風暴冶煉好戰者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30060
UPDATE `creature_template_locale` SET `Name` = '風鑄好戰者' WHERE `locale` = 'zhTW' AND `entry` = 30060;
-- OLD name : 風暴冶煉講述者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30062
UPDATE `creature_template_locale` SET `Name` = '風鑄講述者' WHERE `locale` = 'zhTW' AND `entry` = 30062;
-- OLD name : 風暴冶煉屠殺者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30063
UPDATE `creature_template_locale` SET `Name` = '風鑄屠殺者' WHERE `locale` = 'zhTW' AND `entry` = 30063;
-- OLD name : [DND]龍眠神殿光束目標 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30078
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30078;
-- OLD name : 席格芮·冰誕 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30086
UPDATE `creature_template_locale` SET `Name` = '席格芮‧冰誕' WHERE `locale` = 'zhTW' AND `entry` = 30086;
-- OLD name : 布萊恩·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30107
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 30107;
-- OLD name : 風暴冶煉士兵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30136
UPDATE `creature_template_locale` SET `Name` = '風鑄士兵' WHERE `locale` = 'zhTW' AND `entry` = 30136;
-- OLD name : 布魯爾·鐵禍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30152
UPDATE `creature_template_locale` SET `Name` = '布魯爾‧鐵禍' WHERE `locale` = 'zhTW' AND `entry` = 30152;
-- OLD name : 艾格奈塔·泰斯多達 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30154
UPDATE `creature_template_locale` SET `Name` = '艾格奈塔‧泰斯多達' WHERE `locale` = 'zhTW' AND `entry` = 30154;
-- OLD name : UNUSED妮可·莫里斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30155
UPDATE `creature_template_locale` SET `Name` = 'UNUSED妮可‧莫里斯' WHERE `locale` = 'zhTW' AND `entry` = 30155;
-- OLD name : [DND]苦痛觀眾兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30156
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30156;
-- OLD subname : 潔西卡·莫里斯的夥伴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30157
UPDATE `creature_template_locale` SET `Title` = '潔西卡‧莫里斯的夥伴' WHERE `locale` = 'zhTW' AND `entry` = 30157;
-- OLD subname : 妮可·莫里斯的夥伴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30158
UPDATE `creature_template_locale` SET `Title` = '妮可‧莫里斯的夥伴' WHERE `locale` = 'zhTW' AND `entry` = 30158;
-- OLD name : 席格芮·冰誕的元龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30159
UPDATE `creature_template_locale` SET `Name` = '席格芮‧冰誕的元龍' WHERE `locale` = 'zhTW' AND `entry` = 30159;
-- OLD name : 汀基·芯哨 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30162
UPDATE `creature_template_locale` SET `Name` = '汀基‧芯哨' WHERE `locale` = 'zhTW' AND `entry` = 30162;
-- OLD name : 約格·風暴之心 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30182
UPDATE `creature_template_locale` SET `Name` = '約格‧風暴之心' WHERE `locale` = 'zhTW' AND `entry` = 30182;
-- OLD name : 風暴冶煉伏擊者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30208
UPDATE `creature_template_locale` SET `Name` = '風鑄伏擊者' WHERE `locale` = 'zhTW' AND `entry` = 30208;
-- OLD name : 史蒂芬·艾倫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30217
UPDATE `creature_template_locale` SET `Name` = '史蒂芬‧艾倫' WHERE `locale` = 'zhTW' AND `entry` = 30217;
-- OLD name : 風暴冶煉滲透者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30222
UPDATE `creature_template_locale` SET `Name` = '風鑄滲透者' WHERE `locale` = 'zhTW' AND `entry` = 30222;
-- OLD name : 銳道夫·雷得 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30231
UPDATE `creature_template_locale` SET `Name` = '銳道夫‧雷得' WHERE `locale` = 'zhTW' AND `entry` = 30231;
-- OLD name : 艾拉努拉·焰雲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30239
UPDATE `creature_template_locale` SET `Name` = '艾拉努拉‧焰雲' WHERE `locale` = 'zhTW' AND `entry` = 30239;
-- OLD name : 摩莉亞·末日之翼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30314
UPDATE `creature_template_locale` SET `Name` = '摩莉亞‧末日之翼' WHERE `locale` = 'zhTW' AND `entry` = 30314;
-- OLD name : 喬穆塔 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30340
UPDATE `creature_template_locale` SET `Name` = '喬克塔' WHERE `locale` = 'zhTW' AND `entry` = 30340;
-- OLD name : 提督賈斯汀·巴特勒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30344
UPDATE `creature_template_locale` SET `Name` = '提督賈斯汀‧巴特勒' WHERE `locale` = 'zhTW' AND `entry` = 30344;
-- OLD name : 破天者號海員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30352
UPDATE `creature_template_locale` SET `Name` = '破天者號船員' WHERE `locale` = 'zhTW' AND `entry` = 30352;
-- OLD name : 布萊恩·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30382
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 30382;
-- OLD name : 維洛格·冰吼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30401
UPDATE `creature_template_locale` SET `Name` = '維洛格‧冰吼' WHERE `locale` = 'zhTW' AND `entry` = 30401;
-- OLD name : 布萊恩·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30405
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 30405;
-- OLD name : 貝索德·費格 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30406
UPDATE `creature_template_locale` SET `Name` = '貝索德‧費格' WHERE `locale` = 'zhTW' AND `entry` = 30406;
-- OLD name : 約格·風暴之心 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30408
UPDATE `creature_template_locale` SET `Name` = '約格‧風暴之心' WHERE `locale` = 'zhTW' AND `entry` = 30408;
-- OLD name : 麥格尼·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30411
UPDATE `creature_template_locale` SET `Name` = '麥格尼‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 30411;
-- OLD subname : 女妖之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30426
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 30426;
-- OLD subname : 女妖之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30427
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 30427;
-- OLD subname : 女妖之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30428
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 30428;
-- OLD name : 老練的十字軍艾里歐恰·賽加德 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30431
UPDATE `creature_template_locale` SET `Name` = '老練的十字軍艾里歐恰‧賽加德' WHERE `locale` = 'zhTW' AND `entry` = 30431;
-- OLD name : 伊登·莫朗 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30433
UPDATE `creature_template_locale` SET `Name` = '伊登‧莫朗' WHERE `locale` = 'zhTW' AND `entry` = 30433;
-- OLD name : 督里克·銅爆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30434
UPDATE `creature_template_locale` SET `Name` = '督里克‧銅爆' WHERE `locale` = 'zhTW' AND `entry` = 30434;
-- OLD name : 哈力格·火熔 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30436
UPDATE `creature_template_locale` SET `Name` = '哈力格‧火熔' WHERE `locale` = 'zhTW' AND `entry` = 30436;
-- OLD name : 寇琳·圖莉修女 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30439
UPDATE `creature_template_locale` SET `Name` = '寇琳‧圖莉修女' WHERE `locale` = 'zhTW' AND `entry` = 30439;
-- OLD name : 歐拉特·酒膽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30472
UPDATE `creature_template_locale` SET `Name` = '歐拉特‧酒膽' WHERE `locale` = 'zhTW' AND `entry` = 30472;
-- OLD name : [DND]寒冰皇冠飛行至飛船兔子(A) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30476
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30476;
-- OLD name : 暗月占卜師
-- Source : https://www.wowhead.com/wotlk/tw/npc=30481
UPDATE `creature_template_locale` SET `Name` = '暗月算命師' WHERE `locale` = 'zhTW' AND `entry` = 30481;
-- OLD name : 崔維斯·戴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30488
UPDATE `creature_template_locale` SET `Name` = '崔維斯‧戴' WHERE `locale` = 'zhTW' AND `entry` = 30488;
-- OLD name : 摩根·戴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30489
UPDATE `creature_template_locale` SET `Name` = '摩根‧戴' WHERE `locale` = 'zhTW' AND `entry` = 30489;
-- OLD name : 風暴冶煉屠殺者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30503
UPDATE `creature_template_locale` SET `Name` = '風鑄屠殺者' WHERE `locale` = 'zhTW' AND `entry` = 30503;
-- OLD name : 風暴冶煉好戰者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30504
UPDATE `creature_template_locale` SET `Name` = '風鑄好戰者' WHERE `locale` = 'zhTW' AND `entry` = 30504;
-- OLD name : [UNUSED] 憤怒之擊石像鬼 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30545
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30545;
-- OLD name : 弗拉斯·希亞比 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30552
UPDATE `creature_template_locale` SET `Name` = '艾茲拉‧格里姆' WHERE `locale` = 'zhTW' AND `entry` = 30552;
-- OLD name : 卡林·雷德帕斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30555
UPDATE `creature_template_locale` SET `Name` = '卡林‧雷德帕斯' WHERE `locale` = 'zhTW' AND `entry` = 30555;
-- OLD name : 瑪萊恩·雷德帕斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30556
UPDATE `creature_template_locale` SET `Name` = '瑪萊恩‧雷德帕斯' WHERE `locale` = 'zhTW' AND `entry` = 30556;
-- OLD name : 帕米拉·雷德帕斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30557
UPDATE `creature_template_locale` SET `Name` = '帕米拉‧雷德帕斯' WHERE `locale` = 'zhTW' AND `entry` = 30557;
-- OLD name : 潔西卡·雷德帕斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30558
UPDATE `creature_template_locale` SET `Name` = '潔西卡‧雷德帕斯' WHERE `locale` = 'zhTW' AND `entry` = 30558;
-- OLD name : [DND]寒冰皇冠飛行至飛船兔子(A)傳送目標 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30559
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30559;
-- OLD name : 格里安·斯托曼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30561
UPDATE `creature_template_locale` SET `Name` = '格里安‧斯托曼' WHERE `locale` = 'zhTW' AND `entry` = 30561;
-- OLD name : 約瑟夫·雷德帕斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30565
UPDATE `creature_template_locale` SET `Name` = '約瑟夫‧雷德帕斯' WHERE `locale` = 'zhTW' AND `entry` = 30565;
-- OLD name : 艾默利·奈爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30570
UPDATE `creature_template_locale` SET `Name` = '艾默利‧奈爾' WHERE `locale` = 'zhTW' AND `entry` = 30570;
-- OLD name : 麥可·貝爾法斯特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30571
UPDATE `creature_template_locale` SET `Name` = '麥可‧貝爾法斯特' WHERE `locale` = 'zhTW' AND `entry` = 30571;
-- OLD name : 貝薩尼·艾迪爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30578
UPDATE `creature_template_locale` SET `Name` = '貝薩尼‧艾迪爾' WHERE `locale` = 'zhTW' AND `entry` = 30578;
-- OLD name : 瑪加·熊肌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30579
UPDATE `creature_template_locale` SET `Name` = '瑪加‧熊肌' WHERE `locale` = 'zhTW' AND `entry` = 30579;
-- OLD name : 尼瓦拉·刃舞 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30580
UPDATE `creature_template_locale` SET `Name` = '尼瓦拉‧刃舞' WHERE `locale` = 'zhTW' AND `entry` = 30580;
-- OLD name : 烏弗達·巨人殺戮者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30582
UPDATE `creature_template_locale` SET `Name` = '烏弗達‧巨人殺戮者' WHERE `locale` = 'zhTW' AND `entry` = 30582;
-- OLD name : 薩拉·直截 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30583
UPDATE `creature_template_locale` SET `Name` = '薩拉‧直截' WHERE `locale` = 'zhTW' AND `entry` = 30583;
-- OLD name : 瑪布里安·遠曦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30584
UPDATE `creature_template_locale` SET `Name` = '瑪布里安‧遠曦' WHERE `locale` = 'zhTW' AND `entry` = 30584;
-- OLD name : 維沃·金備 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30587
UPDATE `creature_template_locale` SET `Name` = '維沃‧金備' WHERE `locale` = 'zhTW' AND `entry` = 30587;
-- OLD name : [DND]寒冰皇冠飛行至飛船兔子(H) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30588
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30588;
-- OLD name : [DND]寒冰皇冠飛行至飛船兔子(H)傳送目標 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30589
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30589;
-- OLD name : 科多·雲劈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30590
UPDATE `creature_template_locale` SET `Name` = '科多‧雲劈' WHERE `locale` = 'zhTW' AND `entry` = 30590;
-- OLD name : 風暴冶煉講述者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30591
UPDATE `creature_template_locale` SET `Name` = '風鑄講述者' WHERE `locale` = 'zhTW' AND `entry` = 30591;
-- OLD name : [UNUSED]遺忘深淵高階祭師 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30594
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30594;
-- OLD name : 大領主提里奧·弗丁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30595
UPDATE `creature_template_locale` SET `Name` = '大領主提里奧‧弗丁' WHERE `locale` = 'zhTW' AND `entry` = 30595;
-- OLD name : 發款員張 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30606
UPDATE `creature_template_locale` SET `Name` = '發款員小張' WHERE `locale` = 'zhTW' AND `entry` = 30606;
-- OLD name : 『蠻兵』格力拉·柄鏈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30611
UPDATE `creature_template_locale` SET `Name` = '『蠻兵』格力拉‧柄鏈' WHERE `locale` = 'zhTW' AND `entry` = 30611;
-- OLD name : [DND]寒冰皇冠飛船(A) - 火砲目標 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30640
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30640;
-- OLD name : [DND]寒冰皇冠飛船(A) - 火砲，對等 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30646
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30646;
-- OLD name : 大地之力圖騰 VII (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30647
UPDATE `creature_template_locale` SET `Name` = 'zzOLD大地之力圖騰 VII' WHERE `locale` = 'zhTW' AND `entry` = 30647;
-- OLD name : [DND]寒冰皇冠飛船(H) - 火砲目標 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30649
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30649;
-- OLD name : [DND]寒冰皇冠飛船(A) - 火砲，零散 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30651
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30651;
-- OLD name : 憤怒圖騰 IV (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30654
UPDATE `creature_template_locale` SET `Name` = 'zzOLD憤怒圖騰 IV' WHERE `locale` = 'zhTW' AND `entry` = 30654;
-- OLD name : [DND]寒冰皇冠飛船(A) - 火砲控制器01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30655
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30655;
-- OLD name : 大領主提里奧·弗丁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30677
UPDATE `creature_template_locale` SET `Name` = '大領主提里奧‧弗丁' WHERE `locale` = 'zhTW' AND `entry` = 30677;
-- OLD name : 喬娜·羅伯森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30678
UPDATE `creature_template_locale` SET `Name` = '喬娜‧羅伯森' WHERE `locale` = 'zhTW' AND `entry` = 30678;
-- OLD name : [DND]寒冰皇冠飛船(H) - 火砲，零散 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30690
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30690;
-- OLD name : [DND]寒冰皇冠飛船(H) - 火砲，對等 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30699
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30699;
-- OLD name : [DND]寒冰皇冠飛船(H) - 火砲，中立 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30700
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30700;
-- OLD name : [DND]寒冰皇冠飛船(H) - 火砲控制器01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30707
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30707;
-- OLD name : 十字軍歐拉金·山瑞斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30708
UPDATE `creature_template_locale` SET `Name` = '十字軍歐拉金‧山瑞斯' WHERE `locale` = 'zhTW' AND `entry` = 30708;
-- OLD name : 波西坎·堅縛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30709
UPDATE `creature_template_locale` SET `Name` = '波西坎‧堅縛' WHERE `locale` = 'zhTW' AND `entry` = 30709;
-- OLD name : 卡特麗娜·史丹佛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30713
UPDATE `creature_template_locale` SET `Name` = '卡特麗娜‧史丹佛' WHERE `locale` = 'zhTW' AND `entry` = 30713;
-- OLD name : 菲丹·達金 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30715
UPDATE `creature_template_locale` SET `Name` = '菲丹‧達金' WHERE `locale` = 'zhTW' AND `entry` = 30715;
-- OLD name : 艾莉絲·光函 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30717
UPDATE `creature_template_locale` SET `Name` = '艾莉絲‧光函' WHERE `locale` = 'zhTW' AND `entry` = 30717;
-- OLD name : 麥可·史汪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30721
UPDATE `creature_template_locale` SET `Name` = '麥可‧史汪' WHERE `locale` = 'zhTW' AND `entry` = 30721;
-- OLD name : 莫斗·鬱筆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30724
UPDATE `creature_template_locale` SET `Name` = '莫斗‧鬱筆' WHERE `locale` = 'zhTW' AND `entry` = 30724;
-- OLD name : 史丹力·麥寇米克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30730
UPDATE `creature_template_locale` SET `Name` = '史丹力‧麥寇米克' WHERE `locale` = 'zhTW' AND `entry` = 30730;
-- OLD name : 伊利安娜·月繕 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30731
UPDATE `creature_template_locale` SET `Name` = '伊利安娜‧月繕' WHERE `locale` = 'zhTW' AND `entry` = 30731;
-- OLD name : 薩根·重羽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30733
UPDATE `creature_template_locale` SET `Name` = '薩根‧重羽' WHERE `locale` = 'zhTW' AND `entry` = 30733;
-- OLD name : 潔賽貝兒·比坎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30734
UPDATE `creature_template_locale` SET `Name` = '潔賽貝兒‧比坎' WHERE `locale` = 'zhTW' AND `entry` = 30734;
-- OLD name : 庫爾·墨濺 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30735
UPDATE `creature_template_locale` SET `Name` = '庫爾‧墨濺' WHERE `locale` = 'zhTW' AND `entry` = 30735;
-- OLD name : [DND]寒冰皇冠飛船(H) - 火砲目標，保護盾 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30749
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30749;
-- OLD name : 空奪者寇姆·黑疤 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30824
UPDATE `creature_template_locale` SET `Name` = '空奪者寇姆‧黑疤' WHERE `locale` = 'zhTW' AND `entry` = 30824;
-- OLD name : [DND]寒冰皇冠飛船(A) - 火砲目標，保護盾 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=30832
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 30832;
-- OLD name : 大領主達瑞安·莫格萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30838
UPDATE `creature_template_locale` SET `Name` = '大領主達瑞安‧莫格萊尼' WHERE `locale` = 'zhTW' AND `entry` = 30838;
-- OLD name : 阿索·穩航 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30869
UPDATE `creature_template_locale` SET `Name` = '阿索‧穩航' WHERE `locale` = 'zhTW' AND `entry` = 30869;
-- OLD name : 赫索·穩航 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30870
UPDATE `creature_template_locale` SET `Name` = '赫索‧穩航' WHERE `locale` = 'zhTW' AND `entry` = 30870;
-- OLD name : 布雷齊克·火爪, subname : 傳承競技場護甲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30885
UPDATE `creature_template_locale` SET `Name` = '布雷齊克‧火爪',`Title` = '憎恨鬥士' WHERE `locale` = 'zhTW' AND `entry` = 30885;
-- OLD name : QA Test Dummy 80 Hostile Low Damage (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30888
UPDATE `creature_template_locale` SET `Name` = 'Andrew Test Dummy 80 Hostile Low Damage' WHERE `locale` = 'zhTW' AND `entry` = 30888;
-- OLD name : 凱力多斯·血刃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=30946
UPDATE `creature_template_locale` SET `Name` = '凱力多斯‧血刃' WHERE `locale` = 'zhTW' AND `entry` = 30946;
-- OLD name : [UNUSED]巫妖王 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=31014
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 31014;
-- OLD name : 梅爾·寇里克斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31017
UPDATE `creature_template_locale` SET `Name` = '梅爾‧寇里克斯' WHERE `locale` = 'zhTW' AND `entry` = 31017;
-- OLD name : 愛德華·歐里克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31018
UPDATE `creature_template_locale` SET `Name` = '愛德華‧歐里克' WHERE `locale` = 'zhTW' AND `entry` = 31018;
-- OLD name : 史蒂芬妮·辛德利 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31019
UPDATE `creature_template_locale` SET `Name` = '史蒂芬妮‧辛德利' WHERE `locale` = 'zhTW' AND `entry` = 31019;
-- OLD name : 奧利維亞·森尼希 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31020
UPDATE `creature_template_locale` SET `Name` = '奧利維亞‧森尼希' WHERE `locale` = 'zhTW' AND `entry` = 31020;
-- OLD name : 蘇菲·伊然 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31021
UPDATE `creature_template_locale` SET `Name` = '蘇菲‧伊然' WHERE `locale` = 'zhTW' AND `entry` = 31021;
-- OLD name : 喬治·古德曼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31022
UPDATE `creature_template_locale` SET `Name` = '喬治‧古德曼' WHERE `locale` = 'zhTW' AND `entry` = 31022;
-- OLD name : 布蘭登·艾瑞戴克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31023
UPDATE `creature_template_locale` SET `Name` = '布蘭登‧艾瑞戴克' WHERE `locale` = 'zhTW' AND `entry` = 31023;
-- OLD name : 布洛克·席里斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31024
UPDATE `creature_template_locale` SET `Name` = '布洛克‧席里斯' WHERE `locale` = 'zhTW' AND `entry` = 31024;
-- OLD name : 羅伯特·皮爾斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31025
UPDATE `creature_template_locale` SET `Name` = '羅伯特‧皮爾斯' WHERE `locale` = 'zhTW' AND `entry` = 31025;
-- OLD name : 安娜·慕尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31026
UPDATE `creature_template_locale` SET `Name` = '安娜‧慕尼' WHERE `locale` = 'zhTW' AND `entry` = 31026;
-- OLD name : 里卡·特納 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31027
UPDATE `creature_template_locale` SET `Name` = '里卡‧特納' WHERE `locale` = 'zhTW' AND `entry` = 31027;
-- OLD name : 派翠西亞·歐瑞利 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31028
UPDATE `creature_template_locale` SET `Name` = '派翠西亞‧歐瑞利' WHERE `locale` = 'zhTW' AND `entry` = 31028;
-- OLD name : Russell Bernau Test NPC (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31060
UPDATE `creature_template_locale` SET `Name` = 'Ali Garchanter [TEST]' WHERE `locale` = 'zhTW' AND `entry` = 31060;
-- OLD name : 守望者艾圖拉斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31080
UPDATE `creature_template_locale` SET `Name` = '看守者艾圖拉斯' WHERE `locale` = 'zhTW' AND `entry` = 31080;
-- OLD name : 軍官凡·羅森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31081
UPDATE `creature_template_locale` SET `Name` = '軍官凡‧羅森' WHERE `locale` = 'zhTW' AND `entry` = 31081;
-- OLD name : 大領主達瑞安·莫格萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31084
UPDATE `creature_template_locale` SET `Name` = '大領主達瑞安‧莫格萊尼' WHERE `locale` = 'zhTW' AND `entry` = 31084;
-- OLD name : 寇爾提拉·亡織者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31088
UPDATE `creature_template_locale` SET `Name` = '寇爾提拉‧亡織者' WHERE `locale` = 'zhTW' AND `entry` = 31088;
-- OLD name : 維耶隆·炎羽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31102
UPDATE `creature_template_locale` SET `Name` = '維耶隆‧炎羽' WHERE `locale` = 'zhTW' AND `entry` = 31102;
-- OLD name : 石爪圖騰 IX (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31121
UPDATE `creature_template_locale` SET `Name` = 'zzOLD石爪圖騰 IX' WHERE `locale` = 'zhTW' AND `entry` = 31121;
-- OLD name : 石爪圖騰 X (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31122
UPDATE `creature_template_locale` SET `Name` = 'zzOLD石爪圖騰 X' WHERE `locale` = 'zhTW' AND `entry` = 31122;
-- OLD name : 大地之力圖騰 VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31129
UPDATE `creature_template_locale` SET `Name` = 'zzOLD大地之力圖騰 VIII' WHERE `locale` = 'zhTW' AND `entry` = 31129;
-- OLD name : 火舌圖騰 VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31133
UPDATE `creature_template_locale` SET `Name` = 'zzOLD火舌圖騰 VIII' WHERE `locale` = 'zhTW' AND `entry` = 31133;
-- OLD name : Reinforced Training Dummy (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31143
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 31143;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31143, 'zhTW','NPC',NULL);
-- OLD name : 訓練假人
-- Source : https://www.wowhead.com/wotlk/tw/npc=31144
UPDATE `creature_template_locale` SET `Name` = '宗師的訓練假人' WHERE `locale` = 'zhTW' AND `entry` = 31144;
-- OLD name : 團隊副本的訓練假人
-- Source : https://www.wowhead.com/wotlk/tw/npc=31146
UPDATE `creature_template_locale` SET `Name` = '英雄訓練假人' WHERE `locale` = 'zhTW' AND `entry` = 31146;
-- OLD name : 火舌圖騰 VII (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31158
UPDATE `creature_template_locale` SET `Name` = 'zzOLD火舌圖騰 VII' WHERE `locale` = 'zhTW' AND `entry` = 31158;
-- OLD name : 灼熱圖騰 VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31162
UPDATE `creature_template_locale` SET `Name` = 'zzOLD灼熱圖騰 VIII' WHERE `locale` = 'zhTW' AND `entry` = 31162;
-- OLD name : 灼熱圖騰 X (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31165
UPDATE `creature_template_locale` SET `Name` = 'zzOLD灼熱圖騰 X' WHERE `locale` = 'zhTW' AND `entry` = 31165;
-- OLD name : 熔岩圖騰 VII (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31167
UPDATE `creature_template_locale` SET `Name` = 'zzOLD熔岩圖騰 VII' WHERE `locale` = 'zhTW' AND `entry` = 31167;
-- OLD name : V (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31168
UPDATE `creature_template_locale` SET `Name` = 'zzOLDV' WHERE `locale` = 'zhTW' AND `entry` = 31168;
-- OLD name : 抗火圖騰 V (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31169
UPDATE `creature_template_locale` SET `Name` = 'zzOLD抗火圖騰 V' WHERE `locale` = 'zhTW' AND `entry` = 31169;
-- OLD name : 抗火圖騰 VI (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31170
UPDATE `creature_template_locale` SET `Name` = 'zzOLD抗火圖騰 VI' WHERE `locale` = 'zhTW' AND `entry` = 31170;
-- OLD name : 抗寒圖騰 V (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31171
UPDATE `creature_template_locale` SET `Name` = 'zzOLD抗寒圖騰 V' WHERE `locale` = 'zhTW' AND `entry` = 31171;
-- OLD name : 自然抗性圖騰 V (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31173
UPDATE `creature_template_locale` SET `Name` = 'zzOLD自然抗性圖騰 V' WHERE `locale` = 'zhTW' AND `entry` = 31173;
-- OLD name : 石甲圖騰 X (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31176
UPDATE `creature_template_locale` SET `Name` = 'zzOLD石甲圖騰 X' WHERE `locale` = 'zhTW' AND `entry` = 31176;
-- OLD name : 治療之泉圖騰 VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31182
UPDATE `creature_template_locale` SET `Name` = 'zzOLD治療之泉圖騰 VIII' WHERE `locale` = 'zhTW' AND `entry` = 31182;
-- OLD name : 治療之泉圖騰 IX (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31185
UPDATE `creature_template_locale` SET `Name` = 'zzOLD治療之泉圖騰 IX' WHERE `locale` = 'zhTW' AND `entry` = 31185;
-- OLD name : 法力之泉圖騰 VII (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31189
UPDATE `creature_template_locale` SET `Name` = 'zzOLD法力之泉圖騰 VII' WHERE `locale` = 'zhTW' AND `entry` = 31189;
-- OLD name : 法力之泉圖騰 VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31190
UPDATE `creature_template_locale` SET `Name` = 'zzOLD法力之泉圖騰 VIII' WHERE `locale` = 'zhTW' AND `entry` = 31190;
-- OLD name : 十字軍歐拉金·山瑞斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31235
UPDATE `creature_template_locale` SET `Name` = '十字軍歐拉金‧山瑞斯' WHERE `locale` = 'zhTW' AND `entry` = 31235;
-- OLD name : 席拉·雪曦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31238
UPDATE `creature_template_locale` SET `Name` = '席拉‧雪曦' WHERE `locale` = 'zhTW' AND `entry` = 31238;
-- OLD name : 督軍賀克·濃眉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31240
UPDATE `creature_template_locale` SET `Name` = '督軍賀克‧濃眉' WHERE `locale` = 'zhTW' AND `entry` = 31240;
-- OLD name : 席格芮·冰誕 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31242
UPDATE `creature_template_locale` SET `Name` = '席格芮‧冰誕' WHERE `locale` = 'zhTW' AND `entry` = 31242;
-- OLD name : [DND]寒冰皇冠飛船火砲爆炸兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=31246
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 31246;
-- OLD name : 羅西·羊馳 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31247
UPDATE `creature_template_locale` SET `Name` = '羅西‧羊馳' WHERE `locale` = 'zhTW' AND `entry` = 31247;
-- OLD name : 里米·冷軸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31248
UPDATE `creature_template_locale` SET `Name` = '里米‧冷軸' WHERE `locale` = 'zhTW' AND `entry` = 31248;
-- OLD name : 席格芮·冰誕的元龍(可騎乘) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31249
UPDATE `creature_template_locale` SET `Name` = '席格芮‧冰誕的元龍(可騎乘)' WHERE `locale` = 'zhTW' AND `entry` = 31249;
-- OLD name : 柯爾克隆戰鬥雙足翼龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31269
UPDATE `creature_template_locale` SET `Name` = '柯爾克隆戰鬥蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 31269;
-- OLD name : 歐貝茲·血禍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31283
UPDATE `creature_template_locale` SET `Name` = '歐貝茲‧血禍' WHERE `locale` = 'zhTW' AND `entry` = 31283;
-- OLD name : 大領主達瑞安·莫格萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31290
UPDATE `creature_template_locale` SET `Name` = '大領主達瑞安‧莫格萊尼' WHERE `locale` = 'zhTW' AND `entry` = 31290;
-- OLD subname : 傳承正義點數軍需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31300
UPDATE `creature_template_locale` SET `Title` = '懷舊正義點數軍需官' WHERE `locale` = 'zhTW' AND `entry` = 31300;
-- OLD subname : 傳承正義點數軍需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31302
UPDATE `creature_template_locale` SET `Title` = '懷舊正義點數軍需官' WHERE `locale` = 'zhTW' AND `entry` = 31302;
-- OLD subname : 傳承正義點數軍需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31305
UPDATE `creature_template_locale` SET `Title` = '懷舊正義點數軍需官' WHERE `locale` = 'zhTW' AND `entry` = 31305;
-- OLD name : 瑪葛瑞弗·達卡 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31306
UPDATE `creature_template_locale` SET `Name` = '瑪葛瑞弗‧達卡' WHERE `locale` = 'zhTW' AND `entry` = 31306;
-- OLD subname : 傳承正義點數軍需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31307
UPDATE `creature_template_locale` SET `Title` = '懷舊正義點數軍需官' WHERE `locale` = 'zhTW' AND `entry` = 31307;
-- OLD name : 死亡騎士菁英 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31318
UPDATE `creature_template_locale` SET `Name` = '死亡騎士精英' WHERE `locale` = 'zhTW' AND `entry` = 31318;
-- OLD name : 死亡騎士菁英 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31325
UPDATE `creature_template_locale` SET `Name` = '死亡騎士精英' WHERE `locale` = 'zhTW' AND `entry` = 31325;
-- OLD name : 逃亡中的部落士兵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31328
UPDATE `creature_template_locale` SET `Name` = '逃亡的部落士兵' WHERE `locale` = 'zhTW' AND `entry` = 31328;
-- OLD name : 逃亡中的部落士兵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31330
UPDATE `creature_template_locale` SET `Name` = '逃亡的部落士兵' WHERE `locale` = 'zhTW' AND `entry` = 31330;
-- OLD name : [DND] Icecrown Airship (N) - Attack Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=31353
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 31353;
-- OLD name : 伊利丹·怒風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31395
UPDATE `creature_template_locale` SET `Name` = '伊利丹‧怒風' WHERE `locale` = 'zhTW' AND `entry` = 31395;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31418
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 31418;
-- OLD name : 希瓦娜斯·風行者女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31419
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者女士' WHERE `locale` = 'zhTW' AND `entry` = 31419;
-- OLD subname : 雙足飛龍管理員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31426
UPDATE `creature_template_locale` SET `Title` = '蠍尾獅管理員' WHERE `locale` = 'zhTW' AND `entry` = 31426;
-- OLD name : 十字軍歐拉金·山瑞斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31428
UPDATE `creature_template_locale` SET `Name` = '十字軍歐拉金‧山瑞斯' WHERE `locale` = 'zhTW' AND `entry` = 31428;
-- OLD name : 旅店老闆格雷什卡 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31433
UPDATE `creature_template_locale` SET `Name` = '旅店老闆葛蕾思卡' WHERE `locale` = 'zhTW' AND `entry` = 31433;
-- OLD name : 戰歌騎兵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31435
UPDATE `creature_template_locale` SET `Name` = '戰歌劫掠者' WHERE `locale` = 'zhTW' AND `entry` = 31435;
-- OLD subname : 榮譽軍需官徽章
-- Source : https://www.wowhead.com/wotlk/tw/npc=31579
UPDATE `creature_template_locale` SET `Title` = '勇氣紋章軍需官' WHERE `locale` = 'zhTW' AND `entry` = 31579;
-- OLD subname : 英雄主義軍需官的象徵
-- Source : https://www.wowhead.com/wotlk/tw/npc=31580
UPDATE `creature_template_locale` SET `Title` = '英雄紋章軍需官' WHERE `locale` = 'zhTW' AND `entry` = 31580;
-- OLD subname : 英雄主義軍需官的象徵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31581
UPDATE `creature_template_locale` SET `Title` = '懷舊正義點數軍需官' WHERE `locale` = 'zhTW' AND `entry` = 31581;
-- OLD subname : 傳承正義點數軍需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31582
UPDATE `creature_template_locale` SET `Title` = '懷舊正義點數軍需官' WHERE `locale` = 'zhTW' AND `entry` = 31582;
-- OLD name : 地脈守護者伊瑞茍斯影像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31619
UPDATE `creature_template_locale` SET `Name` = '地脈守護者伊瑞苟斯影像' WHERE `locale` = 'zhTW' AND `entry` = 31619;
-- OLD name : 凱倫·諾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31648
UPDATE `creature_template_locale` SET `Name` = '凱倫‧諾' WHERE `locale` = 'zhTW' AND `entry` = 31648;
-- OLD name : 希瓦娜斯·風行者女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31651
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者女士' WHERE `locale` = 'zhTW' AND `entry` = 31651;
-- OLD name : 風暴冶煉破壞者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31693
UPDATE `creature_template_locale` SET `Name` = '風鑄破壞者' WHERE `locale` = 'zhTW' AND `entry` = 31693;
-- OLD name : Bronze Drake (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31696
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 31696;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31696, 'zhTW','NPC',NULL);
-- OLD name : 暮光飛龍
-- Source : https://www.wowhead.com/wotlk/tw/npc=31698
UPDATE `creature_template_locale` SET `Name` = '暮光龍坐騎' WHERE `locale` = 'zhTW' AND `entry` = 31698;
-- OLD name : 約翰·布魯克曼船長 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31763
UPDATE `creature_template_locale` SET `Name` = '約翰‧布魯克曼船長' WHERE `locale` = 'zhTW' AND `entry` = 31763;
-- OLD name : 大副卡西·迪松 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31764
UPDATE `creature_template_locale` SET `Name` = '大副卡西‧迪松' WHERE `locale` = 'zhTW' AND `entry` = 31764;
-- OLD name : 瑟索爾·死亡之寒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31775
UPDATE `creature_template_locale` SET `Name` = '瑟索爾‧死亡之寒' WHERE `locale` = 'zhTW' AND `entry` = 31775;
-- OLD name : 芙芮索·齒磨 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31776
UPDATE `creature_template_locale` SET `Name` = '芙芮索‧齒磨' WHERE `locale` = 'zhTW' AND `entry` = 31776;
-- OLD name : 轟擊·雷彈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31781
UPDATE `creature_template_locale` SET `Name` = '轟擊‧雷彈' WHERE `locale` = 'zhTW' AND `entry` = 31781;
-- OLD name : 布萊恩·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31810
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 31810;
-- OLD name : 利基·棘扭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31839
UPDATE `creature_template_locale` SET `Name` = '利基‧棘扭' WHERE `locale` = 'zhTW' AND `entry` = 31839;
-- OLD name : 納高·鞭索, subname : 老練競技場商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=31863
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 31863;
-- OLD name : 札奇·燻管 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31864
UPDATE `creature_template_locale` SET `Name` = '札奇‧燻管' WHERE `locale` = 'zhTW' AND `entry` = 31864;
-- OLD name : 扎姆·巴康 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=31865
UPDATE `creature_template_locale` SET `Name` = '扎姆‧巴康' WHERE `locale` = 'zhTW' AND `entry` = 31865;
-- OLD name : 哈洛德·溫斯頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32172
UPDATE `creature_template_locale` SET `Name` = '哈洛德‧溫斯頓' WHERE `locale` = 'zhTW' AND `entry` = 32172;
-- OLD name : 破天者號偵查戰鬥機 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32189
UPDATE `creature_template_locale` SET `Name` = '破天者號偵察戰鬥機' WHERE `locale` = 'zhTW' AND `entry` = 32189;
-- OLD name : [DND] Icecrown Airship Bomb (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=32193
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 32193;
-- OLD name : 租借的雙足飛龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32208
UPDATE `creature_template_locale` SET `Name` = '租借的蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 32208;
-- OLD name : 梅·法蘭西斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32216
UPDATE `creature_template_locale` SET `Name` = '梅‧法蘭西斯' WHERE `locale` = 'zhTW' AND `entry` = 32216;
-- OLD name : 大領主提里奧·弗丁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32239
UPDATE `creature_template_locale` SET `Name` = '大領主提里奧‧弗丁' WHERE `locale` = 'zhTW' AND `entry` = 32239;
-- OLD name : 滴答作響的定時炸彈
-- Source : https://www.wowhead.com/wotlk/tw/npc=32246
UPDATE `creature_template_locale` SET `Name` = '計時炸彈' WHERE `locale` = 'zhTW' AND `entry` = 32246;
-- OLD name : 戰爭使者戴沃斯·里歐特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32301
UPDATE `creature_template_locale` SET `Name` = '戰爭使者戴沃斯‧里歐特' WHERE `locale` = 'zhTW' AND `entry` = 32301;
-- OLD name : 騎士長德羅許 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32302
UPDATE `creature_template_locale` SET `Name` = '騎士隊長德羅許' WHERE `locale` = 'zhTW' AND `entry` = 32302;
-- OLD name : 瓦里安·烏瑞恩國王, subname : 暴風之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32303
UPDATE `creature_template_locale` SET `Name` = '瓦里安‧烏瑞恩國王',`Title` = '暴風城之王' WHERE `locale` = 'zhTW' AND `entry` = 32303;
-- OLD name : 黯黑騎士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32309
UPDATE `creature_template_locale` SET `Name` = '黯刃騎士' WHERE `locale` = 'zhTW' AND `entry` = 32309;
-- OLD name : 寇爾提拉·亡織者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32311
UPDATE `creature_template_locale` SET `Name` = '寇爾提拉‧亡織者' WHERE `locale` = 'zhTW' AND `entry` = 32311;
-- OLD name : 大領主達瑞安·莫格萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32312
UPDATE `creature_template_locale` SET `Name` = '大領主達瑞安‧莫格萊尼' WHERE `locale` = 'zhTW' AND `entry` = 32312;
-- OLD name : 阿薩斯·米奈希爾王子 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32326
UPDATE `creature_template_locale` SET `Name` = '阿薩斯‧米奈希爾王子' WHERE `locale` = 'zhTW' AND `entry` = 32326;
-- OLD name : [DND] Dalaran Sewer Arena - Controller - Death (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=32328
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 32328;
-- OLD name : 卡尼塔·金井, subname : 競技場編制者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32329
UPDATE `creature_template_locale` SET `Name` = '卡尼塔‧金井',`Title` = '競技場登記員' WHERE `locale` = 'zhTW' AND `entry` = 32329;
-- OLD name : 拉米克·猛擰 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32332
UPDATE `creature_template_locale` SET `Name` = '拉米克‧猛擰' WHERE `locale` = 'zhTW' AND `entry` = 32332;
-- OLD name : 精悍的達尼克·黑柄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32333
UPDATE `creature_template_locale` SET `Name` = '精悍的達尼克‧黑柄' WHERE `locale` = 'zhTW' AND `entry` = 32333;
-- OLD name : 尼基·火爪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32334
UPDATE `creature_template_locale` SET `Name` = '尼基‧火爪' WHERE `locale` = 'zhTW' AND `entry` = 32334;
-- OLD name : 藍色裝甲雙足飛龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32336
UPDATE `creature_template_locale` SET `Name` = '藍色裝甲蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 32336;
-- OLD name : 克利斯蒂·斯托克頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32337
UPDATE `creature_template_locale` SET `Name` = '克利斯蒂‧斯托克頓' WHERE `locale` = 'zhTW' AND `entry` = 32337;
-- OLD name : [DND] Dalaran Sewer Arena - Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=32339
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 32339;
-- OLD name : 發條玩具大猩猩
-- Source : https://www.wowhead.com/wotlk/tw/npc=32345
UPDATE `creature_template_locale` SET `Name` = '研磨齒輪玩具大猩猩' WHERE `locale` = 'zhTW' AND `entry` = 32345;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32346
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 32346;
-- OLD name : 大索克·曲矩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32355
UPDATE `creature_template_locale` SET `Name` = '大索克‧曲矩' WHERE `locale` = 'zhTW' AND `entry` = 32355;
-- OLD name : 方寶·機風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32358
UPDATE `creature_template_locale` SET `Name` = '方寶‧機風' WHERE `locale` = 'zhTW' AND `entry` = 32358;
-- OLD name : 亞傑斯·鐵膽, subname : 老練競技場商人
-- Source : https://www.wowhead.com/wotlk/tw/npc=32359
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 32359;
-- OLD name : 艾克頓·銅杯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32360
UPDATE `creature_template_locale` SET `Name` = '艾克頓‧銅杯' WHERE `locale` = 'zhTW' AND `entry` = 32360;
-- OLD name : 伊薇·銅簧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32362
UPDATE `creature_template_locale` SET `Name` = '伊薇‧銅簧' WHERE `locale` = 'zhTW' AND `entry` = 32362;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32364
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 32364;
-- OLD name : 希瓦娜斯·風行者女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32365
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者女士' WHERE `locale` = 'zhTW' AND `entry` = 32365;
-- OLD name : 布洛·熊皮 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32376
UPDATE `creature_template_locale` SET `Name` = '布洛‧熊皮' WHERE `locale` = 'zhTW' AND `entry` = 32376;
-- OLD name : 瓦麗拉·桑古納爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32378
UPDATE `creature_template_locale` SET `Name` = '瓦麗拉‧桑古納爾' WHERE `locale` = 'zhTW' AND `entry` = 32378;
-- OLD name : 朵莉絲· 維蘭提斯, subname : 老練護甲軍需官
-- Source : https://www.wowhead.com/wotlk/tw/npc=32385
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 32385;
-- OLD name : 瓦里安·烏瑞恩國王, subname : 暴風之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32401
UPDATE `creature_template_locale` SET `Name` = '瓦里安‧烏瑞恩國王',`Title` = '暴風城之王' WHERE `locale` = 'zhTW' AND `entry` = 32401;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32402
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 32402;
-- OLD name : 珊卓拉·巴爾坦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32403
UPDATE `creature_template_locale` SET `Name` = '珊卓拉‧巴爾坦' WHERE `locale` = 'zhTW' AND `entry` = 32403;
-- OLD name : 米希阿斯·薩爾奈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32404
UPDATE `creature_template_locale` SET `Name` = '米希阿斯‧薩爾奈' WHERE `locale` = 'zhTW' AND `entry` = 32404;
-- OLD name : 亞傑斯·鐵膽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32407
UPDATE `creature_template_locale` SET `Name` = '亞傑斯‧鐵膽' WHERE `locale` = 'zhTW' AND `entry` = 32407;
-- OLD name : 米希阿斯·薩爾奈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32408
UPDATE `creature_template_locale` SET `Name` = '米希阿斯‧薩爾奈' WHERE `locale` = 'zhTW' AND `entry` = 32408;
-- OLD name : 艾芙桑奈·亞斯拉, subname : 旅店老闆助理 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32411
UPDATE `creature_template_locale` SET `Name` = '艾芙桑奈‧亞斯拉',`Title` = '旅店助理' WHERE `locale` = 'zhTW' AND `entry` = 32411;
-- OLD name : 伊斯拉米·順風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32413
UPDATE `creature_template_locale` SET `Name` = '伊斯拉米‧順風' WHERE `locale` = 'zhTW' AND `entry` = 32413;
-- OLD subname : 旅店老闆助理 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32418
UPDATE `creature_template_locale` SET `Title` = '旅店助理' WHERE `locale` = 'zhTW' AND `entry` = 32418;
-- OLD name : 米希阿斯·薩爾奈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32423
UPDATE `creature_template_locale` SET `Name` = '米希阿斯‧薩爾奈' WHERE `locale` = 'zhTW' AND `entry` = 32423;
-- OLD name : 碁伯里·基羅赫茲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32444
UPDATE `creature_template_locale` SET `Name` = '碁伯里‧基羅赫茲' WHERE `locale` = 'zhTW' AND `entry` = 32444;
-- OLD name : 查斯特·銅壺 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32477
UPDATE `creature_template_locale` SET `Name` = '查斯特‧銅壺' WHERE `locale` = 'zhTW' AND `entry` = 32477;
-- OLD name : 希爾達娜·亡據者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32495
UPDATE `creature_template_locale` SET `Name` = '希爾達娜‧亡據者' WHERE `locale` = 'zhTW' AND `entry` = 32495;
-- OLD name : 舞動的符文刃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32496
UPDATE `creature_template_locale` SET `Name` = '幻舞符文刃' WHERE `locale` = 'zhTW' AND `entry` = 32496;
-- OLD name : 米希阿斯·薩爾奈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32497
UPDATE `creature_template_locale` SET `Name` = '米希阿斯‧薩爾奈' WHERE `locale` = 'zhTW' AND `entry` = 32497;
-- OLD name : 布朗摩·深礦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32509
UPDATE `creature_template_locale` SET `Name` = '布朗摩‧深礦' WHERE `locale` = 'zhTW' AND `entry` = 32509;
-- OLD name : 凡妮莎·塞勒斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32514
UPDATE `creature_template_locale` SET `Name` = '凡妮莎‧塞勒斯' WHERE `locale` = 'zhTW' AND `entry` = 32514;
-- OLD name : 布瑞格·厚鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32515
UPDATE `creature_template_locale` SET `Name` = '布瑞格‧厚鬚' WHERE `locale` = 'zhTW' AND `entry` = 32515;
-- OLD name : 強尼·耶斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32523
UPDATE `creature_template_locale` SET `Name` = '強尼‧耶斯' WHERE `locale` = 'zhTW' AND `entry` = 32523;
-- OLD name : 威利·梅彼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32524
UPDATE `creature_template_locale` SET `Name` = '威利‧梅彼' WHERE `locale` = 'zhTW' AND `entry` = 32524;
-- OLD name : [UNUSED]靈魂醫者(WGA) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=32536
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 32536;
-- OLD name : 黯黑騎士訓練假人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32546
UPDATE `creature_template_locale` SET `Name` = '黯刃騎士訓練假人' WHERE `locale` = 'zhTW' AND `entry` = 32546;
-- OLD name : 嘉拉·碎顱者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32565
UPDATE `creature_template_locale` SET `Name` = '嘉拉‧碎顱者' WHERE `locale` = 'zhTW' AND `entry` = 32565;
-- OLD name : 伊利丹·怒風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32587
UPDATE `creature_template_locale` SET `Name` = '伊利丹‧怒風' WHERE `locale` = 'zhTW' AND `entry` = 32587;
-- OLD name : 伊利丹·怒風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32588
UPDATE `creature_template_locale` SET `Name` = '伊利丹‧怒風' WHERE `locale` = 'zhTW' AND `entry` = 32588;
-- OLD name : [DND]造形書 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=32606
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 32606;
-- OLD name : 訓練假人
-- Source : https://www.wowhead.com/wotlk/tw/npc=32666
UPDATE `creature_template_locale` SET `Name` = '專家的訓練假人' WHERE `locale` = 'zhTW' AND `entry` = 32666;
-- OLD name : 訓練假人
-- Source : https://www.wowhead.com/wotlk/tw/npc=32667
UPDATE `creature_template_locale` SET `Name` = '大師的訓練假人' WHERE `locale` = 'zhTW' AND `entry` = 32667;
-- OLD name : 格林斗·火炫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32676
UPDATE `creature_template_locale` SET `Name` = '葛林多‧火炫' WHERE `locale` = 'zhTW' AND `entry` = 32676;
-- OLD name : 艾默琳·嘶炸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32678
UPDATE `creature_template_locale` SET `Name` = '艾默琳‧嘶炸' WHERE `locale` = 'zhTW' AND `entry` = 32678;
-- OLD name : 達薩莉亞·黯炬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32679
UPDATE `creature_template_locale` SET `Name` = '達薩莉亞‧黯炬' WHERE `locale` = 'zhTW' AND `entry` = 32679;
-- OLD name : 夢娜·長春 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32684
UPDATE `creature_template_locale` SET `Name` = '夢娜‧長春' WHERE `locale` = 'zhTW' AND `entry` = 32684;
-- OLD name : 綺茲·傲息 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32685
UPDATE `creature_template_locale` SET `Name` = '綺茲‧傲息' WHERE `locale` = 'zhTW' AND `entry` = 32685;
-- OLD name : 克夫提庫斯·屈心者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32686
UPDATE `creature_template_locale` SET `Name` = '湯姆士‧里歐庚' WHERE `locale` = 'zhTW' AND `entry` = 32686;
-- OLD name : 琳達·安·凱斯汀洛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32687
UPDATE `creature_template_locale` SET `Name` = '琳達‧安‧凱斯汀洛' WHERE `locale` = 'zhTW' AND `entry` = 32687;
-- OLD name : 艾多里安·陸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32689
UPDATE `creature_template_locale` SET `Name` = '艾多里安‧陸' WHERE `locale` = 'zhTW' AND `entry` = 32689;
-- OLD name : 比提·霜擲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32690
UPDATE `creature_template_locale` SET `Name` = '比提‧霜擲' WHERE `locale` = 'zhTW' AND `entry` = 32690;
-- OLD name : 魔導師范西·善使 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32691
UPDATE `creature_template_locale` SET `Name` = '魔導師范西‧善使' WHERE `locale` = 'zhTW' AND `entry` = 32691;
-- OLD name : 莎布里安娜·哀凝 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32693
UPDATE `creature_template_locale` SET `Name` = '莎布里安娜‧哀凝' WHERE `locale` = 'zhTW' AND `entry` = 32693;
-- OLD name : 卓格·破顱者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32702
UPDATE `creature_template_locale` SET `Name` = '卓格‧破顱者' WHERE `locale` = 'zhTW' AND `entry` = 32702;
-- OLD name : 納瑞斯特·淡星 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32708
UPDATE `creature_template_locale` SET `Name` = '納瑞斯特‧淡星' WHERE `locale` = 'zhTW' AND `entry` = 32708;
-- OLD name : 林姬·紅齒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32716
UPDATE `creature_template_locale` SET `Name` = '林姬‧紅齒' WHERE `locale` = 'zhTW' AND `entry` = 32716;
-- OLD name : 迪西卓拉·颶耀 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32718
UPDATE `creature_template_locale` SET `Name` = '迪西卓拉‧颶耀' WHERE `locale` = 'zhTW' AND `entry` = 32718;
-- OLD name : 娜塔莉·圖堤布雷爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32727
UPDATE `creature_template_locale` SET `Name` = '娜塔莉‧圖堤布雷爾' WHERE `locale` = 'zhTW' AND `entry` = 32727;
-- OLD name : 幻術師卡利娜
-- Source : https://www.wowhead.com/wotlk/tw/npc=32728
UPDATE `creature_template_locale` SET `Name` = '幻術家卡利娜' WHERE `locale` = 'zhTW' AND `entry` = 32728;
-- OLD name : 羅夫威爾·立孚樂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32729
UPDATE `creature_template_locale` SET `Name` = '羅夫威爾‧立孚樂' WHERE `locale` = 'zhTW' AND `entry` = 32729;
-- OLD name : 高迪立·爍墜 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32730
UPDATE `creature_template_locale` SET `Name` = '高迪立‧爍墜' WHERE `locale` = 'zhTW' AND `entry` = 32730;
-- OLD name : 梅塔皮亞斯·尋知者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32731
UPDATE `creature_template_locale` SET `Name` = '梅塔皮亞斯‧尋知者' WHERE `locale` = 'zhTW' AND `entry` = 32731;
-- OLD name : 鐸夫斯·法首 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32732
UPDATE `creature_template_locale` SET `Name` = '鐸夫斯‧法首' WHERE `locale` = 'zhTW' AND `entry` = 32732;
-- OLD name : 韋拉德·布勞維特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32743
UPDATE `creature_template_locale` SET `Name` = '韋拉德‧布勞維特' WHERE `locale` = 'zhTW' AND `entry` = 32743;
-- OLD name : 阿邁拉·天空 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32745
UPDATE `creature_template_locale` SET `Name` = '阿邁拉‧天空' WHERE `locale` = 'zhTW' AND `entry` = 32745;
-- OLD name : 曼德茲·夜影 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32747
UPDATE `creature_template_locale` SET `Name` = '曼德茲‧夜影' WHERE `locale` = 'zhTW' AND `entry` = 32747;
-- OLD name : 賓保·炫指 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32748
UPDATE `creature_template_locale` SET `Name` = '賓保‧炫指' WHERE `locale` = 'zhTW' AND `entry` = 32748;
-- OLD name : 塔孚·戈霍夫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32749
UPDATE `creature_template_locale` SET `Name` = '塔孚‧戈霍夫' WHERE `locale` = 'zhTW' AND `entry` = 32749;
-- OLD name : 豪洛崴·峽灣之錘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32755
UPDATE `creature_template_locale` SET `Name` = '豪洛崴‧峽灣之錘' WHERE `locale` = 'zhTW' AND `entry` = 32755;
-- OLD name : 里納斯·勁紡 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32756
UPDATE `creature_template_locale` SET `Name` = '里納斯‧勁紡' WHERE `locale` = 'zhTW' AND `entry` = 32756;
-- OLD name : 哈洛德·多森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32757
UPDATE `creature_template_locale` SET `Name` = '哈洛德‧多森' WHERE `locale` = 'zhTW' AND `entry` = 32757;
-- OLD name : 夏洛蒂·瑪德 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32758
UPDATE `creature_template_locale` SET `Name` = '夏洛蒂‧瑪德' WHERE `locale` = 'zhTW' AND `entry` = 32758;
-- OLD name : 莉碧·水輪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32759
UPDATE `creature_template_locale` SET `Name` = '莉碧‧水輪' WHERE `locale` = 'zhTW' AND `entry` = 32759;
-- OLD name : 茱麗葉·石盔 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32760
UPDATE `creature_template_locale` SET `Name` = '茱麗葉‧石盔' WHERE `locale` = 'zhTW' AND `entry` = 32760;
-- OLD name : 克蕾兒·微陽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32761
UPDATE `creature_template_locale` SET `Name` = '克蕾兒‧微陽' WHERE `locale` = 'zhTW' AND `entry` = 32761;
-- OLD name : 大衛·胡沬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32762
UPDATE `creature_template_locale` SET `Name` = '大衛‧胡沬' WHERE `locale` = 'zhTW' AND `entry` = 32762;
-- OLD name : 塞巴斯汀·克瑞恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32774
UPDATE `creature_template_locale` SET `Name` = '塞巴斯汀‧克瑞恩' WHERE `locale` = 'zhTW' AND `entry` = 32774;
-- OLD name : 火焰新星圖騰 IX (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32775
UPDATE `creature_template_locale` SET `Name` = 'zzOLD火焰新星圖騰 IX' WHERE `locale` = 'zhTW' AND `entry` = 32775;
-- OLD name : 火焰新星圖騰 VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32776
UPDATE `creature_template_locale` SET `Name` = 'zzOLD火焰新星圖騰 VIII' WHERE `locale` = 'zhTW' AND `entry` = 32776;
-- OLD name : 領空隊長馬克·傑克森 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32777
UPDATE `creature_template_locale` SET `Name` = '領空隊長馬克‧傑克森' WHERE `locale` = 'zhTW' AND `entry` = 32777;
-- OLD name : 纏繞之網幻像
-- Source : https://www.wowhead.com/wotlk/tw/npc=32785
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 32785;
-- OLD name : 伊利丹·怒風擊殺獎勵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32797
UPDATE `creature_template_locale` SET `Name` = '伊利丹‧怒風擊殺獎勵' WHERE `locale` = 'zhTW' AND `entry` = 32797;
-- OLD name : [PH]旅人豐年祭餐桌 - 火雞 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=32824
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 32824;
-- OLD name : [PH]旅人豐年祭餐桌 - 甜薯 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=32825
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 32825;
-- OLD name : [PH]旅人豐年祭餐桌 - 蔓越莓醬 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=32827
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 32827;
-- OLD name : [PH]旅人豐年祭餐桌 - 派 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=32829
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 32829;
-- OLD name : [PH]旅人豐年祭餐桌 - 餡料 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=32831
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 32831;
-- OLD name : 蜜西·焰袖 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32893
UPDATE `creature_template_locale` SET `Name` = '蜜西‧焰袖' WHERE `locale` = 'zhTW' AND `entry` = 32893;
-- OLD name : 艾里·夜羽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32901
UPDATE `creature_template_locale` SET `Name` = '艾里‧夜羽' WHERE `locale` = 'zhTW' AND `entry` = 32901;
-- OLD name : 鐵枝長者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32913
UPDATE `creature_template_locale` SET `Name` = '鐵枒長者' WHERE `locale` = 'zhTW' AND `entry` = 32913;
-- OLD name : 拓爾·灰雲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32941
UPDATE `creature_template_locale` SET `Name` = '拓爾‧灰雲' WHERE `locale` = 'zhTW' AND `entry` = 32941;
-- OLD name : 薇莎·炎織者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=32946
UPDATE `creature_template_locale` SET `Name` = '薇莎‧炎織者' WHERE `locale` = 'zhTW' AND `entry` = 32946;
-- OLD name : 珍妮佛·歐文斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33018
UPDATE `creature_template_locale` SET `Name` = '珍妮佛‧歐文斯' WHERE `locale` = 'zhTW' AND `entry` = 33018;
-- OLD name : 梅根·歐文斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33019
UPDATE `creature_template_locale` SET `Name` = '梅根‧歐文斯' WHERE `locale` = 'zhTW' AND `entry` = 33019;
-- OLD name : 薩拉·布萊迪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33026
UPDATE `creature_template_locale` SET `Name` = '薩拉‧布萊迪' WHERE `locale` = 'zhTW' AND `entry` = 33026;
-- OLD name : 潔西卡·塞勒斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33027
UPDATE `creature_template_locale` SET `Name` = '潔西卡‧塞勒斯' WHERE `locale` = 'zhTW' AND `entry` = 33027;
-- OLD name : 塞巴斯汀·鮑爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33031
UPDATE `creature_template_locale` SET `Name` = '塞巴斯汀‧鮑爾' WHERE `locale` = 'zhTW' AND `entry` = 33031;
-- OLD name : [ph] justin test backstab target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33049
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33049;
-- OLD name : [PH]競技戰馬 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33130
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33130;
-- OLD name : [PH]競技騎士 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33135
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33135;
-- OLD name : 馬庫斯·巴羅威爵士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33222
UPDATE `creature_template_locale` SET `Name` = '馬庫斯‧巴羅威爵士' WHERE `locale` = 'zhTW' AND `entry` = 33222;
-- OLD name : 約瑟夫·霍雷上尉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33223
UPDATE `creature_template_locale` SET `Name` = '約瑟夫‧霍雷上尉' WHERE `locale` = 'zhTW' AND `entry` = 33223;
-- OLD name : 傑科布·亞雷瑞斯元帥 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33225
UPDATE `creature_template_locale` SET `Name` = '傑科布‧亞雷瑞斯元帥' WHERE `locale` = 'zhTW' AND `entry` = 33225;
-- OLD name : 布萊恩·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33235
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 33235;
-- OLD name : 真言術:壁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33248
UPDATE `creature_template_locale` SET `Name` = '真言術：壁' WHERE `locale` = 'zhTW' AND `entry` = 33248;
-- OLD name : [DND] TAR Pedestal - Trainer, Death Knight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33252
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33252;
-- OLD name : 吉莉安·麥克威醬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33290
UPDATE `creature_template_locale` SET `Name` = '吉莉安‧麥克威醬' WHERE `locale` = 'zhTW' AND `entry` = 33290;
-- OLD name : [DND] Tournament - TEST NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33305
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33305;
-- OLD name : 亞瑟·弗路下士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33307
UPDATE `creature_template_locale` SET `Name` = '亞瑟‧弗路下士' WHERE `locale` = 'zhTW' AND `entry` = 33307;
-- OLD name : 卡拉菈·跌酒, subname : 山羊大師 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33309
UPDATE `creature_template_locale` SET `Name` = '卡拉菈‧跌酒',`Title` = '山羊管理者' WHERE `locale` = 'zhTW' AND `entry` = 33309;
-- OLD name : 德瑞克·斑鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33310
UPDATE `creature_template_locale` SET `Name` = '德瑞克‧斑鬚' WHERE `locale` = 'zhTW' AND `entry` = 33310;
-- OLD name : 菈娜·頑錘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33312
UPDATE `creature_template_locale` SET `Name` = '菈娜‧頑錘' WHERE `locale` = 'zhTW' AND `entry` = 33312;
-- OLD name : 羅洛·穩擊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33315
UPDATE `creature_template_locale` SET `Name` = '羅洛‧穩擊' WHERE `locale` = 'zhTW' AND `entry` = 33315;
-- OLD name : 艾薇·夜羽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33325
UPDATE `creature_template_locale` SET `Name` = '艾薇‧夜羽' WHERE `locale` = 'zhTW' AND `entry` = 33325;
-- OLD name : 西希·焰袖 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33327
UPDATE `creature_template_locale` SET `Name` = '西希‧焰袖' WHERE `locale` = 'zhTW' AND `entry` = 33327;
-- OLD name : 阿米菈·炎織者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33331
UPDATE `creature_template_locale` SET `Name` = '阿米菈‧炎織者' WHERE `locale` = 'zhTW' AND `entry` = 33331;
-- OLD name : 卡爾·灰雲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33333
UPDATE `creature_template_locale` SET `Name` = '卡爾‧灰雲' WHERE `locale` = 'zhTW' AND `entry` = 33333;
-- OLD name : 安布羅斯·拴炫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33335
UPDATE `creature_template_locale` SET `Name` = '安布羅斯‧拴炫' WHERE `locale` = 'zhTW' AND `entry` = 33335;
-- OLD name : [DND] Tournament - Ranged Target Dummy - Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33339
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33339;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Charge Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33340
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33340;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Block Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33341
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33341;
-- OLD name : Morgan Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33351
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33351;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (33351, 'zhTW','NPC',NULL);
-- OLD name : 艾瑞西雅·曦詠 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33379
UPDATE `creature_template_locale` SET `Name` = '艾瑞西雅‧曦詠' WHERE `locale` = 'zhTW' AND `entry` = 33379;
-- OLD name : 魯諾克·蠻鬃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33403
UPDATE `creature_template_locale` SET `Name` = '魯諾克‧蠻鬃' WHERE `locale` = 'zhTW' AND `entry` = 33403;
-- OLD name : [ph]聯賽伊萊克戰騎 - NPC only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33415
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33415;
-- OLD name : 森林蟲群 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33431
UPDATE `creature_template_locale` SET `Name` = '森林花群' WHERE `locale` = 'zhTW' AND `entry` = 33431;
-- OLD name : 戰輪第II代 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33432
UPDATE `creature_template_locale` SET `Name` = '戰輪二號' WHERE `locale` = 'zhTW' AND `entry` = 33432;
-- OLD name : 貝索·爆栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33434
UPDATE `creature_template_locale` SET `Name` = '貝索‧爆栓' WHERE `locale` = 'zhTW' AND `entry` = 33434;
-- OLD name : 波索·爆栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33435
UPDATE `creature_template_locale` SET `Name` = '波索‧爆栓' WHERE `locale` = 'zhTW' AND `entry` = 33435;
-- OLD name : 溫德爾·貝爾弗爵士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33439
UPDATE `creature_template_locale` SET `Name` = '溫德爾‧貝爾弗爵士' WHERE `locale` = 'zhTW' AND `entry` = 33439;
-- OLD name : [ph]聯賽科多獸戰騎 - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33450
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33450;
-- OLD name : 洛瑞安·日炎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33455
UPDATE `creature_template_locale` SET `Name` = '洛瑞安‧日炎' WHERE `locale` = 'zhTW' AND `entry` = 33455;
-- OLD name : 康歐·鐵握 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33457
UPDATE `creature_template_locale` SET `Name` = '康歐‧鐵握' WHERE `locale` = 'zhTW' AND `entry` = 33457;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 01 - Weak Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33489
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33489;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 02 -Speedy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33490
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33490;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 03 - Block Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33491
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33491;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 04 - Strong Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33492
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33492;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 05 - Ultimate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33493
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33493;
-- OLD name : 骷髏樵夫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33499
UPDATE `creature_template_locale` SET `Name` = '骷髏伐木者' WHERE `locale` = 'zhTW' AND `entry` = 33499;
-- OLD name : [ph] Tournament - Daily Combatant Summoner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33501
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33501;
-- OLD name : 馴服的異種蠍
-- Source : https://www.wowhead.com/wotlk/tw/npc=33508
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 33508;
-- OLD name : [ph] Tournament - Mounted Combatant - Valiant Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33520
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33520;
-- OLD name : [ph] Tournament - Mounted Combatant - Champion Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33521
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33521;
-- OLD name : 凱希爾·日槍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33538
UPDATE `creature_template_locale` SET `Name` = '凱希爾‧日槍' WHERE `locale` = 'zhTW' AND `entry` = 33538;
-- OLD name : 德恩·狂暴圖騰 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33539
UPDATE `creature_template_locale` SET `Name` = '德恩‧狂暴圖騰' WHERE `locale` = 'zhTW' AND `entry` = 33539;
-- OLD name : 薩拉·喬克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33541
UPDATE `creature_template_locale` SET `Name` = '薩拉‧喬克' WHERE `locale` = 'zhTW' AND `entry` = 33541;
-- OLD name : 博學者艾狄恩·日谷 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33542
UPDATE `creature_template_locale` SET `Name` = '博學者艾狄恩‧日谷' WHERE `locale` = 'zhTW' AND `entry` = 33542;
-- OLD name : 莫菈·座狼姊妹 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33544
UPDATE `creature_template_locale` SET `Name` = '莫菈‧座狼姊妹' WHERE `locale` = 'zhTW' AND `entry` = 33544;
-- OLD name : 安妮拉·修倫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33548
UPDATE `creature_template_locale` SET `Name` = '安妮拉‧修倫' WHERE `locale` = 'zhTW' AND `entry` = 33548;
-- OLD name : 安卡·爪蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33549
UPDATE `creature_template_locale` SET `Name` = '安卡‧爪蹄' WHERE `locale` = 'zhTW' AND `entry` = 33549;
-- OLD name : 弗雷卡·血斧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33553
UPDATE `creature_template_locale` SET `Name` = '弗雷卡‧血斧' WHERE `locale` = 'zhTW' AND `entry` = 33553;
-- OLD name : 伊莉莎·基里安 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33555
UPDATE `creature_template_locale` SET `Name` = '伊莉莎‧基里安' WHERE `locale` = 'zhTW' AND `entry` = 33555;
-- OLD name : 杜魯·雷角 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33556
UPDATE `creature_template_locale` SET `Name` = '杜魯‧雷角' WHERE `locale` = 'zhTW' AND `entry` = 33556;
-- OLD name : 崔利斯·晨日 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33557
UPDATE `creature_template_locale` SET `Name` = '崔利斯‧晨日' WHERE `locale` = 'zhTW' AND `entry` = 33557;
-- OLD name : 布萊恩·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33579
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 33579;
-- OLD name : 達斯汀·范爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33580
UPDATE `creature_template_locale` SET `Name` = '達斯汀‧范爾' WHERE `locale` = 'zhTW' AND `entry` = 33580;
-- OLD name : 菲爾·晨歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33583
UPDATE `creature_template_locale` SET `Name` = '菲爾‧晨歌' WHERE `locale` = 'zhTW' AND `entry` = 33583;
-- OLD name : 賓奇·亮輪 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33586
UPDATE `creature_template_locale` SET `Name` = '賓奇‧亮輪' WHERE `locale` = 'zhTW' AND `entry` = 33586;
-- OLD name : 貝薩尼·克倫威爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33587
UPDATE `creature_template_locale` SET `Name` = '貝薩尼‧克倫威爾' WHERE `locale` = 'zhTW' AND `entry` = 33587;
-- OLD name : 克里斯托·亮炫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33588
UPDATE `creature_template_locale` SET `Name` = '克里斯托‧亮炫' WHERE `locale` = 'zhTW' AND `entry` = 33588;
-- OLD name : 約瑟夫·威爾森, subname : 急救訓練師 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33589
UPDATE `creature_template_locale` SET `Name` = '約瑟夫‧威爾森',`Title` = '繃帶訓練師' WHERE `locale` = 'zhTW' AND `entry` = 33589;
-- OLD name : 潔琳·晚歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33592
UPDATE `creature_template_locale` SET `Name` = '潔琳‧晚歌' WHERE `locale` = 'zhTW' AND `entry` = 33592;
-- OLD name : 費奇司·爆栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33594
UPDATE `creature_template_locale` SET `Name` = '費奇司‧爆栓' WHERE `locale` = 'zhTW' AND `entry` = 33594;
-- OLD name : 莫菈·迷霧行者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33595
UPDATE `creature_template_locale` SET `Name` = '莫菈‧迷霧行者' WHERE `locale` = 'zhTW' AND `entry` = 33595;
-- OLD name : 默琳·幽徑 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33596
UPDATE `creature_template_locale` SET `Name` = '默琳‧幽徑' WHERE `locale` = 'zhTW' AND `entry` = 33596;
-- OLD name : 黎艾拉·晨歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33597
UPDATE `creature_template_locale` SET `Name` = '黎艾拉‧晨歌' WHERE `locale` = 'zhTW' AND `entry` = 33597;
-- OLD name : 布洛連·麥鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33599
UPDATE `creature_template_locale` SET `Name` = '布洛連‧麥鬚' WHERE `locale` = 'zhTW' AND `entry` = 33599;
-- OLD name : 瑟芮·雀歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33600
UPDATE `creature_template_locale` SET `Name` = '瑟芮‧雀歌' WHERE `locale` = 'zhTW' AND `entry` = 33600;
-- OLD name : 艾爾卡·風暴啤酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33601
UPDATE `creature_template_locale` SET `Name` = '艾爾卡‧烈酒' WHERE `locale` = 'zhTW' AND `entry` = 33601;
-- OLD name : 亞瑟·丹尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33603
UPDATE `creature_template_locale` SET `Name` = '亞瑟‧丹尼' WHERE `locale` = 'zhTW' AND `entry` = 33603;
-- OLD name : 急救 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33621
UPDATE `creature_template_locale` SET `Name` = '急救配方' WHERE `locale` = 'zhTW' AND `entry` = 33621;
-- OLD name : 戈蘭·破鋼者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33622
UPDATE `creature_template_locale` SET `Name` = '戈蘭‧破鋼者' WHERE `locale` = 'zhTW' AND `entry` = 33622;
-- OLD name : 大領主提里奧·弗丁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33628
UPDATE `creature_template_locale` SET `Name` = '大領主提里奧‧弗丁' WHERE `locale` = 'zhTW' AND `entry` = 33628;
-- OLD name : 威斯雷克斯·迅鉗 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33629
UPDATE `creature_template_locale` SET `Name` = '威斯雷克斯‧迅鉗' WHERE `locale` = 'zhTW' AND `entry` = 33629;
-- OLD name : 奇倫伯里·銀鬃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33637
UPDATE `creature_template_locale` SET `Name` = '奇倫伯里‧銀鬃' WHERE `locale` = 'zhTW' AND `entry` = 33637;
-- OLD name : 艾莉雅·月舞者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33644
UPDATE `creature_template_locale` SET `Name` = '艾莉雅‧月舞者' WHERE `locale` = 'zhTW' AND `entry` = 33644;
-- OLD name : 潔娜·雷酒, subname : 提神飲料 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33645
UPDATE `creature_template_locale` SET `Name` = '潔娜‧雷酒',`Title` = '休閒餐點' WHERE `locale` = 'zhTW' AND `entry` = 33645;
-- OLD name : 阿凡瑞斯·迅擊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33646
UPDATE `creature_template_locale` SET `Name` = '阿凡瑞斯‧迅擊' WHERE `locale` = 'zhTW' AND `entry` = 33646;
-- OLD name : 提金·輪扳 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33648
UPDATE `creature_template_locale` SET `Name` = '提金‧輪扳' WHERE `locale` = 'zhTW' AND `entry` = 33648;
-- OLD name : 佛立金·輪扳 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33649
UPDATE `creature_template_locale` SET `Name` = '佛立金‧輪扳' WHERE `locale` = 'zhTW' AND `entry` = 33649;
-- OLD name : 瑞里·軸螺 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33650
UPDATE `creature_template_locale` SET `Name` = '瑞里‧軸螺' WHERE `locale` = 'zhTW' AND `entry` = 33650;
-- OLD name : 依蕾絲崔亞·刃詠 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33652
UPDATE `creature_template_locale` SET `Name` = '依蕾絲崔亞‧刃詠' WHERE `locale` = 'zhTW' AND `entry` = 33652;
-- OLD name : 魯克·鷹拳 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33653
UPDATE `creature_template_locale` SET `Name` = '魯克‧鷹拳' WHERE `locale` = 'zhTW' AND `entry` = 33653;
-- OLD name : 愛芮·星尋者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33654
UPDATE `creature_template_locale` SET `Name` = '愛芮‧尋星者' WHERE `locale` = 'zhTW' AND `entry` = 33654;
-- OLD name : 艾瑪瑞爾·日誓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33658
UPDATE `creature_template_locale` SET `Name` = '艾瑪瑞爾‧日誓' WHERE `locale` = 'zhTW' AND `entry` = 33658;
-- OLD name : 加拉西雅·明曦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33659
UPDATE `creature_template_locale` SET `Name` = '加拉西雅‧明曦' WHERE `locale` = 'zhTW' AND `entry` = 33659;
-- OLD name : 娥蘇拉·麥克威醬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33665
UPDATE `creature_template_locale` SET `Name` = '娥蘇拉‧麥克威醬' WHERE `locale` = 'zhTW' AND `entry` = 33665;
-- OLD name : 詹姆士·巴洛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33685
UPDATE `creature_template_locale` SET `Name` = '詹姆士‧巴洛' WHERE `locale` = 'zhTW' AND `entry` = 33685;
-- OLD name : 風暴淬鍛守衛者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33699
UPDATE `creature_template_locale` SET `Name` = '風鍛守護者' WHERE `locale` = 'zhTW' AND `entry` = 33699;
-- OLD name : 風暴淬鍛守衛者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33722
UPDATE `creature_template_locale` SET `Name` = '風鍛守護者' WHERE `locale` = 'zhTW' AND `entry` = 33722;
-- OLD name : 克羅科·天譴剋星 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33762
UPDATE `creature_template_locale` SET `Name` = '克羅科‧天譴剋星' WHERE `locale` = 'zhTW' AND `entry` = 33762;
-- OLD name : 瑟利安·破曉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33763
UPDATE `creature_template_locale` SET `Name` = '瑟利安‧破曉' WHERE `locale` = 'zhTW' AND `entry` = 33763;
-- OLD name : 伊黎芮·夜暮 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33770
UPDATE `creature_template_locale` SET `Name` = '伊黎芮‧夜暮' WHERE `locale` = 'zhTW' AND `entry` = 33770;
-- OLD name : [ph] test tournament charger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=33784
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 33784;
-- OLD name : 斐倫·影歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33788
UPDATE `creature_template_locale` SET `Name` = '斐倫‧闇曲' WHERE `locale` = 'zhTW' AND `entry` = 33788;
-- OLD name : 審判者瑪瑞爾·真心 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33817
UPDATE `creature_template_locale` SET `Name` = '審判者瑪瑞爾‧真心' WHERE `locale` = 'zhTW' AND `entry` = 33817;
-- OLD name : 彌米倫集中點
-- Source : https://www.wowhead.com/wotlk/tw/npc=33835
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 33835;
-- OLD name : 海力丹·光翼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33849
UPDATE `creature_template_locale` SET `Name` = '海力丹‧光翼' WHERE `locale` = 'zhTW' AND `entry` = 33849;
-- OLD name : 布羅賽·金握 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33853
UPDATE `creature_template_locale` SET `Name` = '布羅賽‧金握' WHERE `locale` = 'zhTW' AND `entry` = 33853;
-- OLD name : 湯瑪斯·分脊 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33854
UPDATE `creature_template_locale` SET `Name` = '湯瑪斯‧分脊' WHERE `locale` = 'zhTW' AND `entry` = 33854;
-- OLD name : 鐵枝長者影像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33861
UPDATE `creature_template_locale` SET `Name` = '鐵枒長者影像' WHERE `locale` = 'zhTW' AND `entry` = 33861;
-- OLD subname : 提神飲料 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33867
UPDATE `creature_template_locale` SET `Title` = '休閒餐點' WHERE `locale` = 'zhTW' AND `entry` = 33867;
-- OLD subname : 提神飲料 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33868
UPDATE `creature_template_locale` SET `Title` = '休閒餐點' WHERE `locale` = 'zhTW' AND `entry` = 33868;
-- OLD subname : 提神飲料 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33869
UPDATE `creature_template_locale` SET `Title` = '休閒餐點' WHERE `locale` = 'zhTW' AND `entry` = 33869;
-- OLD name : 茱莉·奧斯沃斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33871
UPDATE `creature_template_locale` SET `Name` = '茱莉‧奧斯沃斯' WHERE `locale` = 'zhTW' AND `entry` = 33871;
-- OLD name : 亞傑斯·鐵膽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33915
UPDATE `creature_template_locale` SET `Name` = '亞傑斯‧鐵膽' WHERE `locale` = 'zhTW' AND `entry` = 33915;
-- OLD name : 大索克·曲矩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33916
UPDATE `creature_template_locale` SET `Name` = '大索克‧曲矩' WHERE `locale` = 'zhTW' AND `entry` = 33916;
-- OLD name : 艾克頓·銅杯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33917
UPDATE `creature_template_locale` SET `Name` = '艾克頓‧銅杯' WHERE `locale` = 'zhTW' AND `entry` = 33917;
-- OLD name : 伊薇·銅簧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33920
UPDATE `creature_template_locale` SET `Name` = '伊薇‧銅簧' WHERE `locale` = 'zhTW' AND `entry` = 33920;
-- OLD name : 納高·鞭索 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33921
UPDATE `creature_template_locale` SET `Name` = '納高‧鞭索' WHERE `locale` = 'zhTW' AND `entry` = 33921;
-- OLD name : 札奇·燻管 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33922
UPDATE `creature_template_locale` SET `Name` = '札奇‧燻管' WHERE `locale` = 'zhTW' AND `entry` = 33922;
-- OLD name : 扎姆·巴康 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33923
UPDATE `creature_template_locale` SET `Name` = '扎姆‧巴康' WHERE `locale` = 'zhTW' AND `entry` = 33923;
-- OLD name : 亞傑斯·鐵膽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33924
UPDATE `creature_template_locale` SET `Name` = '亞傑斯‧鐵膽' WHERE `locale` = 'zhTW' AND `entry` = 33924;
-- OLD name : 扎姆·巴康 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33925
UPDATE `creature_template_locale` SET `Name` = '扎姆‧巴康' WHERE `locale` = 'zhTW' AND `entry` = 33925;
-- OLD name : 札奇·燻管 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33926
UPDATE `creature_template_locale` SET `Name` = '札奇‧燻管' WHERE `locale` = 'zhTW' AND `entry` = 33926;
-- OLD name : 納高·鞭索 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33927
UPDATE `creature_template_locale` SET `Name` = '納高‧鞭索' WHERE `locale` = 'zhTW' AND `entry` = 33927;
-- OLD name : 伊薇·銅簧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33928
UPDATE `creature_template_locale` SET `Name` = '伊薇‧銅簧' WHERE `locale` = 'zhTW' AND `entry` = 33928;
-- OLD name : 艾克頓·銅杯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33929
UPDATE `creature_template_locale` SET `Name` = '艾克頓‧銅杯' WHERE `locale` = 'zhTW' AND `entry` = 33929;
-- OLD name : 大索克·曲矩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33932
UPDATE `creature_template_locale` SET `Name` = '大索克‧曲矩' WHERE `locale` = 'zhTW' AND `entry` = 33932;
-- OLD name : 大索克·曲矩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33933
UPDATE `creature_template_locale` SET `Name` = '大索克‧曲矩' WHERE `locale` = 'zhTW' AND `entry` = 33933;
-- OLD name : 艾克頓·銅杯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33934
UPDATE `creature_template_locale` SET `Name` = '艾克頓‧銅杯' WHERE `locale` = 'zhTW' AND `entry` = 33934;
-- OLD name : 伊薇·銅簧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33935
UPDATE `creature_template_locale` SET `Name` = '伊薇‧銅簧' WHERE `locale` = 'zhTW' AND `entry` = 33935;
-- OLD name : 納高·鞭索 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33936
UPDATE `creature_template_locale` SET `Name` = '納高‧鞭索' WHERE `locale` = 'zhTW' AND `entry` = 33936;
-- OLD name : 札奇·燻管 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33937
UPDATE `creature_template_locale` SET `Name` = '札奇‧燻管' WHERE `locale` = 'zhTW' AND `entry` = 33937;
-- OLD name : 扎姆·巴康 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33938
UPDATE `creature_template_locale` SET `Name` = '扎姆‧巴康' WHERE `locale` = 'zhTW' AND `entry` = 33938;
-- OLD name : 亞傑斯·鐵膽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33939
UPDATE `creature_template_locale` SET `Name` = '亞傑斯‧鐵膽' WHERE `locale` = 'zhTW' AND `entry` = 33939;
-- OLD name : 哥布林穿鑿爆彈
-- Source : https://www.wowhead.com/wotlk/tw/npc=33958
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 33958;
-- OLD subname : 征服徽章軍需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33963
UPDATE `creature_template_locale` SET `Title` = '懷舊正義點數軍需官' WHERE `locale` = 'zhTW' AND `entry` = 33963;
-- OLD subname : 征服徽章軍需官
-- Source : https://www.wowhead.com/wotlk/tw/npc=33964
UPDATE `creature_template_locale` SET `Title` = '征服紋章軍需官' WHERE `locale` = 'zhTW' AND `entry` = 33964;
-- OLD name : 卡瑞斯·日槍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33970
UPDATE `creature_template_locale` SET `Name` = '卡瑞斯‧日槍' WHERE `locale` = 'zhTW' AND `entry` = 33970;
-- OLD name : 賈倫·曦光 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33971
UPDATE `creature_template_locale` SET `Name` = '賈倫‧曦光' WHERE `locale` = 'zhTW' AND `entry` = 33971;
-- OLD name : 魯根·鋼腹 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33972
UPDATE `creature_template_locale` SET `Name` = '魯根‧鋼腹' WHERE `locale` = 'zhTW' AND `entry` = 33972;
-- OLD name : 傑倫·鎖木 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33973
UPDATE `creature_template_locale` SET `Name` = '傑倫‧鎖木' WHERE `locale` = 'zhTW' AND `entry` = 33973;
-- OLD name : 瓦利斯·逐風者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33974
UPDATE `creature_template_locale` SET `Name` = '瓦利斯‧逐風者' WHERE `locale` = 'zhTW' AND `entry` = 33974;
-- OLD name : 哈利·清水 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=33992
UPDATE `creature_template_locale` SET `Name` = '哈利‧清水' WHERE `locale` = 'zhTW' AND `entry` = 33992;
-- OLD name : 馴服的土狼
-- Source : https://www.wowhead.com/wotlk/tw/npc=34019
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 34019;
-- OLD name : 馴服的陸行鳥
-- Source : https://www.wowhead.com/wotlk/tw/npc=34022
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 34022;
-- OLD name : 貯藏箱影像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34032
UPDATE `creature_template_locale` SET `Name` = '寶箱影像' WHERE `locale` = 'zhTW' AND `entry` = 34032;
-- OLD name : 布萊恩·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34044
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 34044;
-- OLD name : 銅鬚無線電
-- Source : https://www.wowhead.com/wotlk/tw/npc=34054
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'zhTW' AND `entry` = 34054;
-- OLD name : 朵莉絲· 維蘭提斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34058
UPDATE `creature_template_locale` SET `Name` = '朵莉絲‧ 維蘭提斯' WHERE `locale` = 'zhTW' AND `entry` = 34058;
-- OLD name : 朵莉絲· 維蘭提斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34059
UPDATE `creature_template_locale` SET `Name` = '朵莉絲‧ 維蘭提斯' WHERE `locale` = 'zhTW' AND `entry` = 34059;
-- OLD name : 朵莉絲· 維蘭提斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34060
UPDATE `creature_template_locale` SET `Name` = '朵莉絲‧ 維蘭提斯' WHERE `locale` = 'zhTW' AND `entry` = 34060;
-- OLD name : 布萊恩·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34064
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 34064;
-- OLD name : 厄瑞·石心 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34070
UPDATE `creature_template_locale` SET `Name` = '厄瑞‧石心' WHERE `locale` = 'zhTW' AND `entry` = 34070;
-- OLD name : 戰輪第II代 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34071
UPDATE `creature_template_locale` SET `Name` = '戰輪二號' WHERE `locale` = 'zhTW' AND `entry` = 34071;
-- OLD name : 葛瑞克斯·腦鍋 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34089
UPDATE `creature_template_locale` SET `Name` = '葛瑞克斯‧腦鍋' WHERE `locale` = 'zhTW' AND `entry` = 34089;
-- OLD name : 葛瑞克斯·腦鍋 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34091
UPDATE `creature_template_locale` SET `Name` = '葛瑞克斯‧腦鍋' WHERE `locale` = 'zhTW' AND `entry` = 34091;
-- OLD name : 葛瑞克斯·腦鍋 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34094
UPDATE `creature_template_locale` SET `Name` = '葛瑞克斯‧腦鍋' WHERE `locale` = 'zhTW' AND `entry` = 34094;
-- OLD name : 傑克·麥克威醬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34168
UPDATE `creature_template_locale` SET `Name` = '傑克‧麥克威醬' WHERE `locale` = 'zhTW' AND `entry` = 34168;
-- OLD name : 朱利安·麥克威醬隊長 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34172
UPDATE `creature_template_locale` SET `Name` = '朱利安‧麥克威醬隊長' WHERE `locale` = 'zhTW' AND `entry` = 34172;
-- OLD name : 葛蘭尼·麥克威醬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34173
UPDATE `creature_template_locale` SET `Name` = '葛蘭尼‧麥克威醬' WHERE `locale` = 'zhTW' AND `entry` = 34173;
-- OLD name : 尚·皮耶·普隆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34244
UPDATE `creature_template_locale` SET `Name` = '尚‧皮耶‧普隆' WHERE `locale` = 'zhTW' AND `entry` = 34244;
-- OLD name : 杜賓·克雷 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34252
UPDATE `creature_template_locale` SET `Name` = '杜賓‧克雷' WHERE `locale` = 'zhTW' AND `entry` = 34252;
-- OLD name : [DND]艾澤拉斯兒童週觸發器 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34281
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34281;
-- OLD name : [DND]勇士Go-To兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34319
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34319;
-- OLD name : [DND]北裂境兒童週觸發器 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34381
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34381;
-- OLD name : 薇薇安·黑語 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34441
UPDATE `creature_template_locale` SET `Name` = '薇薇安‧黑語' WHERE `locale` = 'zhTW' AND `entry` = 34441;
-- OLD name : 黎安卓·喚日 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34445
UPDATE `creature_template_locale` SET `Name` = '黎安卓‧喚日' WHERE `locale` = 'zhTW' AND `entry` = 34445;
-- OLD name : 金賽兒·凋擲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34449
UPDATE `creature_template_locale` SET `Name` = '金賽兒‧凋擲' WHERE `locale` = 'zhTW' AND `entry` = 34449;
-- OLD name : 碧菈娜·風暴之蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34451
UPDATE `creature_template_locale` SET `Name` = '碧菈娜‧風暴之蹄' WHERE `locale` = 'zhTW' AND `entry` = 34451;
-- OLD name : 納霍克·破鋼者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34453
UPDATE `creature_template_locale` SET `Name` = '納霍克‧破鋼者' WHERE `locale` = 'zhTW' AND `entry` = 34453;
-- OLD name : 伯洛連·頑角 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34455
UPDATE `creature_template_locale` SET `Name` = '伯洛連‧頑角' WHERE `locale` = 'zhTW' AND `entry` = 34455;
-- OLD name : 瑪力薩·亮刃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34456
UPDATE `creature_template_locale` SET `Name` = '瑪力薩‧亮刃' WHERE `locale` = 'zhTW' AND `entry` = 34456;
-- OLD name : 高葛林·影斬 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34458
UPDATE `creature_template_locale` SET `Name` = '高葛林‧影斬' WHERE `locale` = 'zhTW' AND `entry` = 34458;
-- OLD name : 艾琳·霧蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34459
UPDATE `creature_template_locale` SET `Name` = '艾琳‧霧蹄' WHERE `locale` = 'zhTW' AND `entry` = 34459;
-- OLD name : 卡薇娜·林地之歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34460
UPDATE `creature_template_locale` SET `Name` = '卡薇娜‧林地之歌' WHERE `locale` = 'zhTW' AND `entry` = 34460;
-- OLD name : 提瑞斯·暮刃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34461
UPDATE `creature_template_locale` SET `Name` = '提瑞斯‧暮刃' WHERE `locale` = 'zhTW' AND `entry` = 34461;
-- OLD name : 安薩·修爐匠 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34466
UPDATE `creature_template_locale` SET `Name` = '安薩‧修爐匠' WHERE `locale` = 'zhTW' AND `entry` = 34466;
-- OLD name : 愛莉希雅·月巡者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34467
UPDATE `creature_template_locale` SET `Name` = '愛莉希雅‧月巡者' WHERE `locale` = 'zhTW' AND `entry` = 34467;
-- OLD name : 諾佐·嘯棍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34468
UPDATE `creature_template_locale` SET `Name` = '諾佐‧嘯棍' WHERE `locale` = 'zhTW' AND `entry` = 34468;
-- OLD name : 梅拉朵·谷行者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34469
UPDATE `creature_template_locale` SET `Name` = '梅拉朵‧谷行者' WHERE `locale` = 'zhTW' AND `entry` = 34469;
-- OLD name : 貝爾諾·攜光者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34471
UPDATE `creature_template_locale` SET `Name` = '貝爾諾‧攜光者' WHERE `locale` = 'zhTW' AND `entry` = 34471;
-- OLD name : 艾芮絲·影步 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34472
UPDATE `creature_template_locale` SET `Name` = '艾芮絲‧影步' WHERE `locale` = 'zhTW' AND `entry` = 34472;
-- OLD name : 布芮娜·夜墜 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34473
UPDATE `creature_template_locale` SET `Name` = '布芮娜‧夜墜' WHERE `locale` = 'zhTW' AND `entry` = 34473;
-- OLD name : 瑟芮莎·厲濺 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34474
UPDATE `creature_template_locale` SET `Name` = '瑟芮莎‧厲濺' WHERE `locale` = 'zhTW' AND `entry` = 34474;
-- OLD name : 艾狄絲·暗寂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34496
UPDATE `creature_template_locale` SET `Name` = '艾狄絲‧暗寂' WHERE `locale` = 'zhTW' AND `entry` = 34496;
-- OLD name : 菲歐拉·光寂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34497
UPDATE `creature_template_locale` SET `Name` = '菲歐拉‧光寂' WHERE `locale` = 'zhTW' AND `entry` = 34497;
-- OLD name : ScottM Test Creature (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34533
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34533;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (34533, 'zhTW','NPC',NULL);
-- OLD name : [DND]臭彈目標 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34562
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34562;
-- OLD name : [DND]戰爭機器人-藍色 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34588
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34588;
-- OLD name : [DND]戰爭機器人-紅色 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34589
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34589;
-- OLD name : 達諾威·雷角 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34612
UPDATE `creature_template_locale` SET `Name` = '達諾威‧雷角' WHERE `locale` = 'zhTW' AND `entry` = 34612;
-- OLD name : 愛德華·溫斯洛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34644
UPDATE `creature_template_locale` SET `Name` = '愛德華‧溫斯洛' WHERE `locale` = 'zhTW' AND `entry` = 34644;
-- OLD name : 伊莉莎白·貝克·溫斯洛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34645
UPDATE `creature_template_locale` SET `Name` = '伊莉莎白‧貝克‧溫斯洛' WHERE `locale` = 'zhTW' AND `entry` = 34645;
-- OLD name : 潔琳·晚歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34657
UPDATE `creature_template_locale` SET `Name` = '潔琳‧晚歌' WHERE `locale` = 'zhTW' AND `entry` = 34657;
-- OLD name : 潔琳·晚歌的坐騎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34658
UPDATE `creature_template_locale` SET `Name` = '潔琳‧晚歌的坐騎' WHERE `locale` = 'zhTW' AND `entry` = 34658;
-- OLD name : 葛列格里·塔波 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34675
UPDATE `creature_template_locale` SET `Name` = '葛列格里‧塔波' WHERE `locale` = 'zhTW' AND `entry` = 34675;
-- OLD name : 艾薩克·愛勒頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34676
UPDATE `creature_template_locale` SET `Name` = '艾薩克‧愛勒頓' WHERE `locale` = 'zhTW' AND `entry` = 34676;
-- OLD name : 邁爾斯·墨壺 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34677
UPDATE `creature_template_locale` SET `Name` = '邁爾斯‧墨壺' WHERE `locale` = 'zhTW' AND `entry` = 34677;
-- OLD name : 杜金·遠野 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34678
UPDATE `creature_template_locale` SET `Name` = '杜金‧遠野' WHERE `locale` = 'zhTW' AND `entry` = 34678;
-- OLD name : 法蘭西斯·埃頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34679
UPDATE `creature_template_locale` SET `Name` = '法蘭西斯‧埃頓' WHERE `locale` = 'zhTW' AND `entry` = 34679;
-- OLD name : 艾坎巴·夏眠 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34681
UPDATE `creature_template_locale` SET `Name` = '艾坎巴‧夏眠' WHERE `locale` = 'zhTW' AND `entry` = 34681;
-- OLD name : 薇敏娜·霍貝克 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34682
UPDATE `creature_template_locale` SET `Name` = '薇敏娜‧霍貝克' WHERE `locale` = 'zhTW' AND `entry` = 34682;
-- OLD name : 蘿絲·墨壺 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34683
UPDATE `creature_template_locale` SET `Name` = '蘿絲‧墨壺' WHERE `locale` = 'zhTW' AND `entry` = 34683;
-- OLD name : 拉荷·遠野 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34684
UPDATE `creature_template_locale` SET `Name` = '拉荷‧遠野' WHERE `locale` = 'zhTW' AND `entry` = 34684;
-- OLD name : 達妮·勁草 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34685
UPDATE `creature_template_locale` SET `Name` = '達妮‧勁草' WHERE `locale` = 'zhTW' AND `entry` = 34685;
-- OLD name : 安布羅斯·拴炫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34702
UPDATE `creature_template_locale` SET `Name` = '安布羅斯‧拴炫' WHERE `locale` = 'zhTW' AND `entry` = 34702;
-- OLD name : 菈娜·頑錘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34703
UPDATE `creature_template_locale` SET `Name` = '菈娜‧頑錘' WHERE `locale` = 'zhTW' AND `entry` = 34703;
-- OLD name : 傑科布·亞雷瑞斯元帥 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34705
UPDATE `creature_template_locale` SET `Name` = '傑科布‧亞雷瑞斯元帥' WHERE `locale` = 'zhTW' AND `entry` = 34705;
-- OLD name : 凱特倫·鐵壺 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34708
UPDATE `creature_template_locale` SET `Name` = '凱特倫‧鐵壺' WHERE `locale` = 'zhTW' AND `entry` = 34708;
-- OLD name : 愛蓮·摩爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34710
UPDATE `creature_template_locale` SET `Name` = '愛蓮‧摩爾' WHERE `locale` = 'zhTW' AND `entry` = 34710;
-- OLD name : 瑪麗·愛勒頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34711
UPDATE `creature_template_locale` SET `Name` = '瑪麗‧愛勒頓' WHERE `locale` = 'zhTW' AND `entry` = 34711;
-- OLD name : 蘿貝塔·卡特 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34712
UPDATE `creature_template_locale` SET `Name` = '蘿貝塔‧卡特' WHERE `locale` = 'zhTW' AND `entry` = 34712;
-- OLD name : 昂達尼·巨磨 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34713
UPDATE `creature_template_locale` SET `Name` = '昂達尼‧巨磨' WHERE `locale` = 'zhTW' AND `entry` = 34713;
-- OLD name : 瑪哈拉·金麥 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34714
UPDATE `creature_template_locale` SET `Name` = '瑪哈拉‧金麥' WHERE `locale` = 'zhTW' AND `entry` = 34714;
-- OLD name : 船員葛利特
-- Source : https://www.wowhead.com/wotlk/tw/npc=34719
UPDATE `creature_template_locale` SET `Name` = '船員砂礫' WHERE `locale` = 'zhTW' AND `entry` = 34719;
-- OLD name : [DND]魔法猛雞(男性德萊尼) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34731
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34731;
-- OLD name : [DND]魔法猛雞(男性牛頭人) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34732
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34732;
-- OLD name : 炆烤火雞代理人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34738
UPDATE `creature_template_locale` SET `Name` = '慢烤火雞代理人' WHERE `locale` = 'zhTW' AND `entry` = 34738;
-- OLD name : 糖煮甜薯代理人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34739
UPDATE `creature_template_locale` SET `Name` = '蜜煮甘薯代理人' WHERE `locale` = 'zhTW' AND `entry` = 34739;
-- OLD name : 蔓越莓酸甜醬代理人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34741
UPDATE `creature_template_locale` SET `Name` = '蔓越莓甜酸醬代理人' WHERE `locale` = 'zhTW' AND `entry` = 34741;
-- OLD name : 賈斯伯·摩爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34744
UPDATE `creature_template_locale` SET `Name` = '賈斯伯‧摩爾' WHERE `locale` = 'zhTW' AND `entry` = 34744;
-- OLD name : 齊里·熱噴嘴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34765
UPDATE `creature_template_locale` SET `Name` = '齊里‧熱噴嘴' WHERE `locale` = 'zhTW' AND `entry` = 34765;
-- OLD name : 克倫德·大袋 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34766
UPDATE `creature_template_locale` SET `Name` = '克倫德‧大袋' WHERE `locale` = 'zhTW' AND `entry` = 34766;
-- OLD name : 威廉·慕林 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34768
UPDATE `creature_template_locale` SET `Name` = '威廉‧慕林' WHERE `locale` = 'zhTW' AND `entry` = 34768;
-- OLD name : 凡薩霖·紅晨 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34772
UPDATE `creature_template_locale` SET `Name` = '凡薩霖‧紅晨' WHERE `locale` = 'zhTW' AND `entry` = 34772;
-- OLD name : 倫妮莎·白枝 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34783
UPDATE `creature_template_locale` SET `Name` = '倫妮莎‧白枝' WHERE `locale` = 'zhTW' AND `entry` = 34783;
-- OLD name : 艾爾納·白枝 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34785
UPDATE `creature_template_locale` SET `Name` = '艾爾納‧白枝' WHERE `locale` = 'zhTW' AND `entry` = 34785;
-- OLD name : 愛麗絲·帆谷 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34786
UPDATE `creature_template_locale` SET `Name` = '愛麗絲‧帆谷' WHERE `locale` = 'zhTW' AND `entry` = 34786;
-- OLD name : 約翰·帆谷 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34787
UPDATE `creature_template_locale` SET `Name` = '約翰‧帆谷' WHERE `locale` = 'zhTW' AND `entry` = 34787;
-- OLD name : 酸喉(可動式) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34798
UPDATE `creature_template_locale` SET `Name` = '酸喉(機動型態)' WHERE `locale` = 'zhTW' AND `entry` = 34798;
-- OLD name : 巴瑞特·萊姆瑟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34816
UPDATE `creature_template_locale` SET `Name` = '巴瑞特‧萊姆瑟' WHERE `locale` = 'zhTW' AND `entry` = 34816;
-- OLD name : 甜薯位 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34824
UPDATE `creature_template_locale` SET `Name` = '甘薯椅' WHERE `locale` = 'zhTW' AND `entry` = 34824;
-- OLD name : 娜拉希·雪曦 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34880
UPDATE `creature_template_locale` SET `Name` = '娜拉希‧雪曦' WHERE `locale` = 'zhTW' AND `entry` = 34880;
-- OLD name : 希倫·識歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34881
UPDATE `creature_template_locale` SET `Name` = '希倫‧識歌' WHERE `locale` = 'zhTW' AND `entry` = 34881;
-- OLD name : [ph]銀白團隊觀眾 - FX - 部落 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34883
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34883;
-- OLD name : 伊芙尼奇·卡莎莉絲夫人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34885
UPDATE `creature_template_locale` SET `Name` = '伊芙尼奇‧卡莎莉絲夫人' WHERE `locale` = 'zhTW' AND `entry` = 34885;
-- OLD name : [ph]銀白團隊觀眾 - FX - 聯盟 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34887
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34887;
-- OLD name : [PH] Goss Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34889
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34889;
-- OLD name : [PH]聯賽角鷹獸任務坐騎 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34891
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34891;
-- OLD name : [PH]圈養的銀白角鷹獸 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34893
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34893;
-- OLD name : [ph]銀白團隊觀眾 - FX - 人類 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34900
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34900;
-- OLD name : [ph]銀白團隊觀眾 - FX - 獸人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34901
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34901;
-- OLD name : [ph]銀白團隊觀眾 - FX - 食人妖 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34902
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34902;
-- OLD name : [ph]銀白團隊觀眾 - FX - 牛頭人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34903
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34903;
-- OLD name : [ph]銀白團隊觀眾 - FX - 血精靈 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34904
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34904;
-- OLD name : [ph]銀白團隊觀眾 - FX - 不死族 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34905
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34905;
-- OLD name : [ph]銀白團隊觀眾 - FX - 矮人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34906
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34906;
-- OLD name : [ph]銀白團隊觀眾 - FX - 德萊尼 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34908
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34908;
-- OLD name : [ph]銀白團隊觀眾 - FX - 夜精靈 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34909
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34909;
-- OLD name : [ph]銀白團隊觀眾 - FX - 地精 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=34910
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 34910;
-- OLD name : 莎薇娜·識歌 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34912
UPDATE `creature_template_locale` SET `Name` = '莎薇娜‧識歌' WHERE `locale` = 'zhTW' AND `entry` = 34912;
-- OLD name : 提洛斯·曦奔 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34914
UPDATE `creature_template_locale` SET `Name` = '提洛斯‧曦奔' WHERE `locale` = 'zhTW' AND `entry` = 34914;
-- OLD name : 風暴冶煉掠奪者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34915
UPDATE `creature_template_locale` SET `Name` = '風鑄掠奪者' WHERE `locale` = 'zhTW' AND `entry` = 34915;
-- OLD name : 高階指揮官海弗德·龍禍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34924
UPDATE `creature_template_locale` SET `Name` = '高階指揮官海弗德‧龍禍' WHERE `locale` = 'zhTW' AND `entry` = 34924;
-- OLD name : 翠玉虎
-- Source : https://www.wowhead.com/wotlk/tw/npc=34930
UPDATE `creature_template_locale` SET `Name` = '碧玉虎' WHERE `locale` = 'zhTW' AND `entry` = 34930;
-- OLD name : 卡格·穿顱 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34955
UPDATE `creature_template_locale` SET `Name` = '卡格‧穿顱' WHERE `locale` = 'zhTW' AND `entry` = 34955;
-- OLD name : 埃路斯·金晨 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34972
UPDATE `creature_template_locale` SET `Name` = '埃路斯‧金晨' WHERE `locale` = 'zhTW' AND `entry` = 34972;
-- OLD name : 伊芮莎·血星 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34973
UPDATE `creature_template_locale` SET `Name` = '伊芮莎‧血星' WHERE `locale` = 'zhTW' AND `entry` = 34973;
-- OLD name : 多廷·赫魯斯加 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34980
UPDATE `creature_template_locale` SET `Name` = '多廷‧赫魯斯加' WHERE `locale` = 'zhTW' AND `entry` = 34980;
-- OLD name : 瓦里安·烏瑞恩國王, subname : 暴風之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34990
UPDATE `creature_template_locale` SET `Name` = '瓦里安‧烏瑞恩國王',`Title` = '暴風城之王' WHERE `locale` = 'zhTW' AND `entry` = 34990;
-- OLD name : 柏瑞姆·金錘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34991
UPDATE `creature_template_locale` SET `Name` = '柏瑞姆‧金錘' WHERE `locale` = 'zhTW' AND `entry` = 34991;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34992
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 34992;
-- OLD name : 菈芮娜·心鑄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34993
UPDATE `creature_template_locale` SET `Name` = '菈芮娜‧心鑄' WHERE `locale` = 'zhTW' AND `entry` = 34993;
-- OLD name : 卡爾洛斯·地獄吼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34995
UPDATE `creature_template_locale` SET `Name` = '卡爾洛斯‧地獄吼' WHERE `locale` = 'zhTW' AND `entry` = 34995;
-- OLD name : 大領主提里奧·弗丁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34996
UPDATE `creature_template_locale` SET `Name` = '大領主提里奧‧弗丁' WHERE `locale` = 'zhTW' AND `entry` = 34996;
-- OLD name : 戴文·遠谷 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34997
UPDATE `creature_template_locale` SET `Name` = '戴文‧遠谷' WHERE `locale` = 'zhTW' AND `entry` = 34997;
-- OLD name : 愛莉森·戴維 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=34998
UPDATE `creature_template_locale` SET `Name` = '愛莉森‧戴維' WHERE `locale` = 'zhTW' AND `entry` = 34998;
-- OLD name : 賽爾德·亮焰
-- Source : https://www.wowhead.com/wotlk/tw/npc=35001
UPDATE `creature_template_locale` SET `Name` = '賽爾德·亮燄' WHERE `locale` = 'zhTW' AND `entry` = 35001;
-- OLD name : 傑倫·日誓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35004
UPDATE `creature_template_locale` SET `Name` = '傑倫‧日誓' WHERE `locale` = 'zhTW' AND `entry` = 35004;
-- OLD name : 亞芮拉斯·亮星 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35005
UPDATE `creature_template_locale` SET `Name` = '亞芮拉斯‧亮星' WHERE `locale` = 'zhTW' AND `entry` = 35005;
-- OLD name : 莉薩·魔擲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35007
UPDATE `creature_template_locale` SET `Name` = '莉薩‧魔擲' WHERE `locale` = 'zhTW' AND `entry` = 35007;
-- OLD name : [ph]銀白團隊觀眾 - 一般假人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=35016
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 35016;
-- OLD name : 戈洛姆·戰牙 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35017
UPDATE `creature_template_locale` SET `Name` = '戈洛姆‧戰牙' WHERE `locale` = 'zhTW' AND `entry` = 35017;
-- OLD name : 布茹卡·悲哀使者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35019
UPDATE `creature_template_locale` SET `Name` = '布茹卡‧悲哀使者' WHERE `locale` = 'zhTW' AND `entry` = 35019;
-- OLD name : 歐苟·碎肋者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35022
UPDATE `creature_template_locale` SET `Name` = '歐苟‧碎肋者' WHERE `locale` = 'zhTW' AND `entry` = 35022;
-- OLD name : 特倫斯·梅特里 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35023
UPDATE `creature_template_locale` SET `Name` = '特倫斯‧梅特里' WHERE `locale` = 'zhTW' AND `entry` = 35023;
-- OLD name : 卓希安·弗連寧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35024
UPDATE `creature_template_locale` SET `Name` = '卓希安‧弗連寧' WHERE `locale` = 'zhTW' AND `entry` = 35024;
-- OLD name : 黎奈特·布瑞瑟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35025
UPDATE `creature_template_locale` SET `Name` = '黎奈特‧布瑞瑟' WHERE `locale` = 'zhTW' AND `entry` = 35025;
-- OLD name : 瑪莎·鑰印 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35026
UPDATE `creature_template_locale` SET `Name` = '瑪莎‧鑰印' WHERE `locale` = 'zhTW' AND `entry` = 35026;
-- OLD name : 巴瑞特·萊姆瑟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35035
UPDATE `creature_template_locale` SET `Name` = '巴瑞特‧萊姆瑟' WHERE `locale` = 'zhTW' AND `entry` = 35035;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance Fireworks NOT USED (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=35066
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 35066;
-- OLD name : 古圖拉·四風 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35068
UPDATE `creature_template_locale` SET `Name` = '古圖拉‧四風' WHERE `locale` = 'zhTW' AND `entry` = 35068;
-- OLD name : 瑪萊妮雅·奪天者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35087
UPDATE `creature_template_locale` SET `Name` = '瑪萊妮雅‧奪天者' WHERE `locale` = 'zhTW' AND `entry` = 35087;
-- OLD name : 庫斯特·棒柄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35088
UPDATE `creature_template_locale` SET `Name` = '庫斯特‧棒柄' WHERE `locale` = 'zhTW' AND `entry` = 35088;
-- OLD name : 埃薩斯·火鷹船長 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35090
UPDATE `creature_template_locale` SET `Name` = '埃薩斯‧火鷹船長' WHERE `locale` = 'zhTW' AND `entry` = 35090;
-- OLD name : 荷札克·轉啃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35091
UPDATE `creature_template_locale` SET `Name` = '荷札克‧轉啃' WHERE `locale` = 'zhTW' AND `entry` = 35091;
-- OLD name : 風騎兵賈修巴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35093
UPDATE `creature_template_locale` SET `Name` = '蠍尾獅騎士賈修巴' WHERE `locale` = 'zhTW' AND `entry` = 35093;
-- OLD name : 巴那·蠻鬃, subname : 雙足飛龍看管者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35099
UPDATE `creature_template_locale` SET `Name` = '巴那‧蠻鬃',`Title` = '蠍尾獅看管者' WHERE `locale` = 'zhTW' AND `entry` = 35099;
-- OLD name : 哈根·青銅之翼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35100
UPDATE `creature_template_locale` SET `Name` = '哈根‧青銅之翼' WHERE `locale` = 'zhTW' AND `entry` = 35100;
-- OLD name : 關妲·青銅之翼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35101
UPDATE `creature_template_locale` SET `Name` = '關妲‧青銅之翼' WHERE `locale` = 'zhTW' AND `entry` = 35101;
-- OLD name : 伊蕾安·浪峰船長 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35102
UPDATE `creature_template_locale` SET `Name` = '伊蕾安‧浪峰船長' WHERE `locale` = 'zhTW' AND `entry` = 35102;
-- OLD name : 杜根·雷喙 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35131
UPDATE `creature_template_locale` SET `Name` = '杜根‧雷喙' WHERE `locale` = 'zhTW' AND `entry` = 35131;
-- OLD name : 托弗·天蹄, subname : 雙足飛龍看管者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35132
UPDATE `creature_template_locale` SET `Name` = '托弗‧天蹄',`Title` = '蠍尾獅看管者' WHERE `locale` = 'zhTW' AND `entry` = 35132;
-- OLD name : 梅格菈·利羽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35133
UPDATE `creature_template_locale` SET `Name` = '梅格菈‧利羽' WHERE `locale` = 'zhTW' AND `entry` = 35133;
-- OLD name : 風騎兵莎班芭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35135
UPDATE `creature_template_locale` SET `Name` = '蠍尾獅騎士莎班芭' WHERE `locale` = 'zhTW' AND `entry` = 35135;
-- OLD name : 史廷·角草 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35290
UPDATE `creature_template_locale` SET `Name` = '史廷‧角草' WHERE `locale` = 'zhTW' AND `entry` = 35290;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35320
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 35320;
-- OLD name : 瓦里安·烏瑞恩國王, subname : 暴風之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35321
UPDATE `creature_template_locale` SET `Name` = '瓦里安‧烏瑞恩國王',`Title` = '暴風城之王' WHERE `locale` = 'zhTW' AND `entry` = 35321;
-- OLD name : 伯格納·鐵足 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35344
UPDATE `creature_template_locale` SET `Name` = '伯格納‧鐵足' WHERE `locale` = 'zhTW' AND `entry` = 35344;
-- OLD name : 大領主提里奧·弗丁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35361
UPDATE `creature_template_locale` SET `Name` = '大領主提里奧‧弗丁' WHERE `locale` = 'zhTW' AND `entry` = 35361;
-- OLD name : 卡爾洛斯·地獄吼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35372
UPDATE `creature_template_locale` SET `Name` = '卡爾洛斯‧地獄吼' WHERE `locale` = 'zhTW' AND `entry` = 35372;
-- OLD name : 聯賽雙足飛龍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35373
UPDATE `creature_template_locale` SET `Name` = '聯賽蠍尾獅' WHERE `locale` = 'zhTW' AND `entry` = 35373;
-- OLD name : 威爾弗雷德·菲斯巴恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35458
UPDATE `creature_template_locale` SET `Name` = '威爾弗雷德‧菲斯巴恩' WHERE `locale` = 'zhTW' AND `entry` = 35458;
-- OLD name : 塔拉格·高山 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35462
UPDATE `creature_template_locale` SET `Name` = '塔拉格‧高山' WHERE `locale` = 'zhTW' AND `entry` = 35462;
-- OLD name : 索恩·傲鬃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35471
UPDATE `creature_template_locale` SET `Name` = '索恩‧傲鬃' WHERE `locale` = 'zhTW' AND `entry` = 35471;
-- OLD name : 威爾弗雷德·菲斯巴恩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35476
UPDATE `creature_template_locale` SET `Name` = '威爾弗雷德‧菲斯巴恩' WHERE `locale` = 'zhTW' AND `entry` = 35476;
-- OLD subname : 凱旋軍需官的徽記
-- Source : https://www.wowhead.com/wotlk/tw/npc=35494
UPDATE `creature_template_locale` SET `Title` = '凱旋紋章軍需官' WHERE `locale` = 'zhTW' AND `entry` = 35494;
-- OLD name : 博學者凡薩菈, subname : 凱旋軍需官的徽記 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35495
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'zhTW' AND `entry` = 35495;
-- OLD name : 魯本·勞倫 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35496
UPDATE `creature_template_locale` SET `Name` = '魯本‧勞倫' WHERE `locale` = 'zhTW' AND `entry` = 35496;
-- OLD name : 勞佛·朗格姆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35497
UPDATE `creature_template_locale` SET `Name` = '勞佛‧朗格姆' WHERE `locale` = 'zhTW' AND `entry` = 35497;
-- OLD name : 何瑞斯·杭德蘭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35498
UPDATE `creature_template_locale` SET `Name` = '何瑞斯‧杭德蘭' WHERE `locale` = 'zhTW' AND `entry` = 35498;
-- OLD subname : 家傳物品商人 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35508
UPDATE `creature_template_locale` SET `Title` = '傳家寶商人' WHERE `locale` = 'zhTW' AND `entry` = 35508;
-- OLD name : 復活的傑倫·日誓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35545
UPDATE `creature_template_locale` SET `Name` = '復活的傑倫‧日誓' WHERE `locale` = 'zhTW' AND `entry` = 35545;
-- OLD name : 復活的亞芮拉斯·亮星 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35564
UPDATE `creature_template_locale` SET `Name` = '復活的亞芮拉斯‧亮星' WHERE `locale` = 'zhTW' AND `entry` = 35564;
-- OLD name : 艾瑞西雅·曦詠 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35569
UPDATE `creature_template_locale` SET `Name` = '艾瑞西雅‧曦詠' WHERE `locale` = 'zhTW' AND `entry` = 35569;
-- OLD name : 魯諾克·蠻鬃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35571
UPDATE `creature_template_locale` SET `Name` = '魯諾克‧蠻鬃' WHERE `locale` = 'zhTW' AND `entry` = 35571;
-- OLD subname : 傳承正義點數軍需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35573
UPDATE `creature_template_locale` SET `Title` = '懷舊正義點數軍需官' WHERE `locale` = 'zhTW' AND `entry` = 35573;
-- OLD subname : 傳承正義點數軍需官 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35574
UPDATE `creature_template_locale` SET `Title` = '懷舊正義點數軍需官' WHERE `locale` = 'zhTW' AND `entry` = 35574;
-- OLD name : 傑倫·日誓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35589
UPDATE `creature_template_locale` SET `Name` = '傑倫‧日誓' WHERE `locale` = 'zhTW' AND `entry` = 35589;
-- OLD name : 銅拴·械扳 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35594
UPDATE `creature_template_locale` SET `Name` = '銅拴‧械扳' WHERE `locale` = 'zhTW' AND `entry` = 35594;
-- OLD name : 亞芮拉斯·亮星 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35604
UPDATE `creature_template_locale` SET `Name` = '亞芮拉斯‧亮星' WHERE `locale` = 'zhTW' AND `entry` = 35604;
-- OLD name : 瑞吉納德·弧火 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35607
UPDATE `creature_template_locale` SET `Name` = '瑞吉納德‧弧火' WHERE `locale` = 'zhTW' AND `entry` = 35607;
-- OLD name : [DND] Dalaran Argent Tournament Herald Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=35608
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 35608;
-- OLD name : 安布羅斯·拴炫的坐騎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35633
UPDATE `creature_template_locale` SET `Name` = '安布羅斯‧拴炫的坐騎' WHERE `locale` = 'zhTW' AND `entry` = 35633;
-- OLD name : 艾瑞西雅·曦詠的坐騎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35635
UPDATE `creature_template_locale` SET `Name` = '艾瑞西雅‧曦詠的坐騎' WHERE `locale` = 'zhTW' AND `entry` = 35635;
-- OLD name : 菈娜·頑錘的坐騎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35636
UPDATE `creature_template_locale` SET `Name` = '菈娜‧頑錘的坐騎' WHERE `locale` = 'zhTW' AND `entry` = 35636;
-- OLD name : 傑科布·亞雷瑞斯元帥的坐騎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35637
UPDATE `creature_template_locale` SET `Name` = '傑科布‧亞雷瑞斯元帥的坐騎' WHERE `locale` = 'zhTW' AND `entry` = 35637;
-- OLD name : 魯諾克·蠻鬃的坐騎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35640
UPDATE `creature_template_locale` SET `Name` = '魯諾克‧蠻鬃的坐騎' WHERE `locale` = 'zhTW' AND `entry` = 35640;
-- OLD name : 巴瑞特·萊姆瑟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35766
UPDATE `creature_template_locale` SET `Name` = '巴瑞特‧萊姆瑟' WHERE `locale` = 'zhTW' AND `entry` = 35766;
-- OLD name : 巴瑞特·萊姆瑟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35770
UPDATE `creature_template_locale` SET `Name` = '巴瑞特‧萊姆瑟' WHERE `locale` = 'zhTW' AND `entry` = 35770;
-- OLD name : 巴瑞特·萊姆瑟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35771
UPDATE `creature_template_locale` SET `Name` = '巴瑞特‧萊姆瑟' WHERE `locale` = 'zhTW' AND `entry` = 35771;
-- OLD name : 凱伊·吐吉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35826
UPDATE `creature_template_locale` SET `Name` = '凱伊‧吐吉' WHERE `locale` = 'zhTW' AND `entry` = 35826;
-- OLD name : 巴瑞特·萊姆瑟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35895
UPDATE `creature_template_locale` SET `Name` = '巴瑞特‧萊姆瑟' WHERE `locale` = 'zhTW' AND `entry` = 35895;
-- OLD name : 巴瑞特·萊姆瑟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35909
UPDATE `creature_template_locale` SET `Name` = '巴瑞特‧萊姆瑟' WHERE `locale` = 'zhTW' AND `entry` = 35909;
-- OLD name : 巴瑞特·萊姆瑟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=35910
UPDATE `creature_template_locale` SET `Name` = '巴瑞特‧萊姆瑟' WHERE `locale` = 'zhTW' AND `entry` = 35910;
-- OLD name : [DNT]測試龍鷹 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=35983
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 35983;
-- OLD name : 菲歐拉·光寂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36065
UPDATE `creature_template_locale` SET `Name` = '菲歐拉‧光寂' WHERE `locale` = 'zhTW' AND `entry` = 36065;
-- OLD name : 艾狄絲·暗寂 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36066
UPDATE `creature_template_locale` SET `Name` = '艾狄絲‧暗寂' WHERE `locale` = 'zhTW' AND `entry` = 36066;
-- OLD name : [DND]銀白戰騎 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36071
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36071;
-- OLD name : [DND]迅捷酒紅色狼騎 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36072
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36072;
-- OLD name : [DND]迅捷部落狼騎 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36074
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36074;
-- OLD name : [DND]白馬 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36075
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36075;
-- OLD name : [DND]迅捷聯盟戰駒 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36076
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36076;
-- OLD name : 大領主提里奧·弗丁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36095
UPDATE `creature_template_locale` SET `Name` = '大領主提里奧‧弗丁' WHERE `locale` = 'zhTW' AND `entry` = 36095;
-- OLD name : 安薩·修爐匠 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36108
UPDATE `creature_template_locale` SET `Name` = '安薩‧修爐匠' WHERE `locale` = 'zhTW' AND `entry` = 36108;
-- OLD name : 貝爾諾·攜光者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36109
UPDATE `creature_template_locale` SET `Name` = '貝爾諾‧攜光者' WHERE `locale` = 'zhTW' AND `entry` = 36109;
-- OLD name : 諾佐·嘯棍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36114
UPDATE `creature_template_locale` SET `Name` = '諾佐‧嘯棍' WHERE `locale` = 'zhTW' AND `entry` = 36114;
-- OLD name : 梅拉朵·谷行者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36116
UPDATE `creature_template_locale` SET `Name` = '梅拉朵‧谷行者' WHERE `locale` = 'zhTW' AND `entry` = 36116;
-- OLD name : 瑪力薩·亮刃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36120
UPDATE `creature_template_locale` SET `Name` = '瑪力薩‧亮刃' WHERE `locale` = 'zhTW' AND `entry` = 36120;
-- OLD name : 納霍克·破鋼者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36122
UPDATE `creature_template_locale` SET `Name` = '納霍克‧破鋼者' WHERE `locale` = 'zhTW' AND `entry` = 36122;
-- OLD name : [DND]被遺忘者海員 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36148
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36148;
-- OLD name : [DND]瓦爾加德苦工 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36154
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36154;
-- OLD name : [DND]博格洛克狼 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36167
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36167;
-- OLD name : [DND]博格洛克苦工 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36169
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36169;
-- OLD name : 瑟拉希·火刃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36208
UPDATE `creature_template_locale` SET `Name` = '瑟拉希‧火刃' WHERE `locale` = 'zhTW' AND `entry` = 36208;
-- OLD name : [DND]北裂境兒童週觸發器2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36209
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36209;
-- OLD name : [DND]瘋狂的藥劑師產生器 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36212
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36212;
-- OLD name : 柯爾克隆監督者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36213
UPDATE `creature_template_locale` SET `Name` = '幽暗城守護者' WHERE `locale` = 'zhTW' AND `entry` = 36213;
-- OLD name : 監督者克拉戈許 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36217
UPDATE `creature_template_locale` SET `Name` = '殘缺的屍體' WHERE `locale` = 'zhTW' AND `entry` = 36217;
-- OLD name : 弗林特·鐵鹿 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36284
UPDATE `creature_template_locale` SET `Name` = '弗林特‧鐵鹿' WHERE `locale` = 'zhTW' AND `entry` = 36284;
-- OLD name : 史拉巴·護堤 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36351
UPDATE `creature_template_locale` SET `Name` = '史拉巴‧護堤' WHERE `locale` = 'zhTW' AND `entry` = 36351;
-- OLD name : 特朗克·砰箱 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36352
UPDATE `creature_template_locale` SET `Name` = '特朗克‧砰箱' WHERE `locale` = 'zhTW' AND `entry` = 36352;
-- OLD name : 巴芙·硬皮 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36380
UPDATE `creature_template_locale` SET `Name` = '巴芙‧硬皮' WHERE `locale` = 'zhTW' AND `entry` = 36380;
-- OLD name : 布拉斯特·粗頸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36390
UPDATE `creature_template_locale` SET `Name` = '布拉斯特‧粗頸' WHERE `locale` = 'zhTW' AND `entry` = 36390;
-- OLD name : [DND] Valentine Boss - Vial Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36530
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36530;
-- OLD name : 眾魂之井 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36536
UPDATE `creature_template_locale` SET `Name` = '靈魂之井' WHERE `locale` = 'zhTW' AND `entry` = 36536;
-- OLD name : 卡拉迪斯·亮矛 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36624
UPDATE `creature_template_locale` SET `Name` = '卡拉迪斯‧亮矛' WHERE `locale` = 'zhTW' AND `entry` = 36624;
-- OLD name : 米拉連恩·日炎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36642
UPDATE `creature_template_locale` SET `Name` = '米拉連恩‧日炎' WHERE `locale` = 'zhTW' AND `entry` = 36642;
-- OLD name : [DND] Valentine Boss Manager (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36643
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36643;
-- OLD name : 奧莫·雷角 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36644
UPDATE `creature_template_locale` SET `Name` = '奧莫‧雷角' WHERE `locale` = 'zhTW' AND `entry` = 36644;
-- OLD name : 貝恩·血蹄 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36648
UPDATE `creature_template_locale` SET `Name` = '貝恩‧血蹄' WHERE `locale` = 'zhTW' AND `entry` = 36648;
-- OLD name : [DND]藥劑師之桌(法術效果) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36710
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36710;
-- OLD name : [PH]寒冰皇冠再活化的十字軍 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36726
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36726;
-- OLD name : 瓦莉絲瑞雅·夢行者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36789
UPDATE `creature_template_locale` SET `Name` = '瓦莉絲瑞雅‧夢行者' WHERE `locale` = 'zhTW' AND `entry` = 36789;
-- OLD name : [PH] Unused Quarry Overseer (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36792
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36792;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36792, 'zhTW','NPC',NULL);
-- OLD name : [DND]愛之船召喚者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36817
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36817;
-- OLD name : 泰瑞納斯·米奈希爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36823
UPDATE `creature_template_locale` SET `Name` = '泰瑞納斯‧米奈希爾' WHERE `locale` = 'zhTW' AND `entry` = 36823;
-- OLD name : 桑迪·光爍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36856
UPDATE `creature_template_locale` SET `Name` = '桑迪‧光爍' WHERE `locale` = 'zhTW' AND `entry` = 36856;
-- OLD name : [PH]冰冠笞刑食屍鬼 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36875
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36875;
-- OLD name : Gryphon Hatchling 3.3.0 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36904
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36904;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36904, 'zhTW','NPC',NULL);
-- OLD name : 小獅鷲獸
-- Source : https://www.wowhead.com/wotlk/tw/npc=36908
UPDATE `creature_template_locale` SET `Name` = '獅鷲雛獸' WHERE `locale` = 'zhTW' AND `entry` = 36908;
-- OLD name : 老陳·風暴烈酒 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36912
UPDATE `creature_template_locale` SET `Name` = '老陳‧風暴烈酒' WHERE `locale` = 'zhTW' AND `entry` = 36912;
-- OLD name : 穆拉丁·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36948
UPDATE `creature_template_locale` SET `Name` = '穆拉丁‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 36948;
-- OLD name : 破天者號海員 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36950
UPDATE `creature_template_locale` SET `Name` = '破天者號船員' WHERE `locale` = 'zhTW' AND `entry` = 36950;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36955
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 36955;
-- OLD name : [DND] World Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=36966
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 36966;
-- OLD name : 靈魂綁定火元素 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36977
UPDATE `creature_template_locale` SET `Name` = '縛魂火元素' WHERE `locale` = 'zhTW' AND `entry` = 36977;
-- OLD name : 希瓦娜斯·風行者女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36990
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者女士' WHERE `locale` = 'zhTW' AND `entry` = 36990;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=36993
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 36993;
-- OLD name : 黏稠軟泥
-- Source : https://www.wowhead.com/wotlk/tw/npc=37006
UPDATE `creature_template_locale` SET `Name` = '粘稠軟泥' WHERE `locale` = 'zhTW' AND `entry` = 37006;
-- OLD name : [DND]Ground Cover Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37039
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37039;
-- OLD name : [PH]冰冠暗影 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37128
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37128;
-- OLD name : [DND] Summon Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37168
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37168;
-- OLD name : 警探史內卜·凸栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37172
UPDATE `creature_template_locale` SET `Name` = '警探史內卜‧凸栓' WHERE `locale` = 'zhTW' AND `entry` = 37172;
-- OLD name : 提督賈斯汀·巴特勒(IAB) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37182
UPDATE `creature_template_locale` SET `Name` = '提督賈斯汀‧巴特勒(IAB)' WHERE `locale` = 'zhTW' AND `entry` = 37182;
-- OLD name : 札弗德·轟箱 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37184
UPDATE `creature_template_locale` SET `Name` = '札弗德‧轟箱' WHERE `locale` = 'zhTW' AND `entry` = 37184;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37188
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 37188;
-- OLD name : [PH] 冰石2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37191
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37191;
-- OLD name : [PH] 冰石3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37192
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37192;
-- OLD name : [DND] Summon Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37201
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37201;
-- OLD name : [DND] Summon Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37202
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37202;
-- OLD name : 薩洛瑞安·曦尋者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37205
UPDATE `creature_template_locale` SET `Name` = '薩洛瑞安‧曦尋者' WHERE `locale` = 'zhTW' AND `entry` = 37205;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37221
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 37221;
-- OLD name : 希瓦娜斯·風行者女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37223
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者女士' WHERE `locale` = 'zhTW' AND `entry` = 37223;
-- OLD name : 赫杜倫·亮翼, subname : 遊俠將軍 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37527
UPDATE `creature_template_locale` SET `Name` = '赫杜倫‧亮翼',`Title` = '銀月城遊俠將軍' WHERE `locale` = 'zhTW' AND `entry` = 37527;
-- OLD name : 莫蘭·冷握 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37542
UPDATE `creature_template_locale` SET `Name` = '莫蘭‧冷握' WHERE `locale` = 'zhTW' AND `entry` = 37542;
-- OLD name : [DND] 震動者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37543
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37543;
-- OLD name : 薩洛瑞安·曦尋者的遺骸 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37552
UPDATE `creature_template_locale` SET `Name` = '薩洛瑞安‧曦尋者的遺骸' WHERE `locale` = 'zhTW' AND `entry` = 37552;
-- OLD name : 希瓦娜斯·風行者女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37554
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者女士' WHERE `locale` = 'zhTW' AND `entry` = 37554;
-- OLD name : [DND]Something Stinks Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37558
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37558;
-- OLD name : [DND] Shaker - Small (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37574
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37574;
-- OLD name : 馬汀·維特斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37580
UPDATE `creature_template_locale` SET `Name` = '馬汀‧維特斯' WHERE `locale` = 'zhTW' AND `entry` = 37580;
-- OLD name : 葛剛·鐵顱 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37581
UPDATE `creature_template_locale` SET `Name` = '葛剛‧鐵顱' WHERE `locale` = 'zhTW' AND `entry` = 37581;
-- OLD name : 馬汀·維特斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37591
UPDATE `creature_template_locale` SET `Name` = '馬汀‧維特斯' WHERE `locale` = 'zhTW' AND `entry` = 37591;
-- OLD name : 葛剛·鐵顱 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37592
UPDATE `creature_template_locale` SET `Name` = '葛剛‧鐵顱' WHERE `locale` = 'zhTW' AND `entry` = 37592;
-- OLD name : 希瓦娜斯·風行者女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37596
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者女士' WHERE `locale` = 'zhTW' AND `entry` = 37596;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37597
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 37597;
-- OLD name : 薩洛瑞安·曦尋者獎勵 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37601
UPDATE `creature_template_locale` SET `Name` = '薩洛瑞安‧曦尋者獎勵' WHERE `locale` = 'zhTW' AND `entry` = 37601;
-- OLD name : 指揮官艾里歐恰·賽加德 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37693
UPDATE `creature_template_locale` SET `Name` = '指揮官艾里歐恰‧賽加德' WHERE `locale` = 'zhTW' AND `entry` = 37693;
-- OLD name : 史尼佛·鏽彈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37715
UPDATE `creature_template_locale` SET `Name` = '史尼佛‧鏽彈' WHERE `locale` = 'zhTW' AND `entry` = 37715;
-- OLD name : 卓耿·深集 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37742
UPDATE `creature_template_locale` SET `Name` = '卓耿‧深集' WHERE `locale` = 'zhTW' AND `entry` = 37742;
-- OLD name : 洛索瑪·塞隆 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37764
UPDATE `creature_template_locale` SET `Name` = '洛索瑪‧塞隆' WHERE `locale` = 'zhTW' AND `entry` = 37764;
-- OLD name : 阿瑞克·追日者上尉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37765
UPDATE `creature_template_locale` SET `Name` = '阿瑞克‧追日者上尉' WHERE `locale` = 'zhTW' AND `entry` = 37765;
-- OLD name : [TEST]霸王歐瑪 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37820
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37820;
-- OLD name : 薩洛瑞安·曦尋者的影像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37828
UPDATE `creature_template_locale` SET `Name` = '薩洛瑞安‧曦尋者的影像' WHERE `locale` = 'zhTW' AND `entry` = 37828;
-- OLD name : [PH]上尉 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37831
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37831;
-- OLD name : 空奪者寇姆·黑疤 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37833
UPDATE `creature_template_locale` SET `Name` = '空奪者寇姆‧黑疤' WHERE `locale` = 'zhTW' AND `entry` = 37833;
-- OLD name : 莫蘭·冷握的影像 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37845
UPDATE `creature_template_locale` SET `Name` = '莫蘭‧冷握的影像' WHERE `locale` = 'zhTW' AND `entry` = 37845;
-- OLD name : 瓦里安·烏瑞恩國王, subname : 暴風之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37879
UPDATE `creature_template_locale` SET `Name` = '瓦里安‧烏瑞恩國王',`Title` = '暴風城之王' WHERE `locale` = 'zhTW' AND `entry` = 37879;
-- OLD name : 丘比特·傳播者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37887
UPDATE `creature_template_locale` SET `Name` = '丘比特‧傳播者' WHERE `locale` = 'zhTW' AND `entry` = 37887;
-- OLD name : 弗雷克斯·桶滴 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37888
UPDATE `creature_template_locale` SET `Name` = '弗雷克斯‧桶滴' WHERE `locale` = 'zhTW' AND `entry` = 37888;
-- OLD name : 雪利·鋼臟 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37903
UPDATE `creature_template_locale` SET `Name` = '雪利‧鋼臟' WHERE `locale` = 'zhTW' AND `entry` = 37903;
-- OLD name : 布瑞奇·蓋茲 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37904
UPDATE `creature_template_locale` SET `Name` = '布瑞奇‧蓋茲' WHERE `locale` = 'zhTW' AND `entry` = 37904;
-- OLD name : 提摩西·卡汀漢 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37915
UPDATE `creature_template_locale` SET `Name` = '提摩西‧卡汀漢' WHERE `locale` = 'zhTW' AND `entry` = 37915;
-- OLD name : 藥劑師坎蒂斯·湯瑪斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37935
UPDATE `creature_template_locale` SET `Name` = '藥劑師坎蒂斯‧湯瑪斯' WHERE `locale` = 'zhTW' AND `entry` = 37935;
-- OLD name : 摩根·日炎 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37936
UPDATE `creature_template_locale` SET `Name` = '摩根‧日炎' WHERE `locale` = 'zhTW' AND `entry` = 37936;
-- OLD subname : 冰霜軍需官徽記
-- Source : https://www.wowhead.com/wotlk/tw/npc=37941
UPDATE `creature_template_locale` SET `Title` = '冰霜紋章軍需官' WHERE `locale` = 'zhTW' AND `entry` = 37941;
-- OLD subname : 冰霜軍需官徽記
-- Source : https://www.wowhead.com/wotlk/tw/npc=37942
UPDATE `creature_template_locale` SET `Title` = '冰霜紋章軍需官' WHERE `locale` = 'zhTW' AND `entry` = 37942;
-- OLD name : 瓦莉絲瑞雅·夢行者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=37950
UPDATE `creature_template_locale` SET `Name` = '瓦莉絲瑞雅‧夢行者' WHERE `locale` = 'zhTW' AND `entry` = 37950;
-- OLD name : [DND]愛之船召喚者 02 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37964
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37964;
-- OLD name : [DND]愛之船召喚者 03 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37981
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37981;
-- OLD name : [DND] Sample Quest Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=37990
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 37990;
-- OLD name : 丘比特·傳播者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38039
UPDATE `creature_template_locale` SET `Name` = '丘比特‧傳播者' WHERE `locale` = 'zhTW' AND `entry` = 38039;
-- OLD name : 丘比特·傳播者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38040
UPDATE `creature_template_locale` SET `Name` = '丘比特‧傳播者' WHERE `locale` = 'zhTW' AND `entry` = 38040;
-- OLD name : 丘比特·傳播者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38041
UPDATE `creature_template_locale` SET `Name` = '丘比特‧傳播者' WHERE `locale` = 'zhTW' AND `entry` = 38041;
-- OLD name : 丘比特·傳播者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38042
UPDATE `creature_template_locale` SET `Name` = '丘比特‧傳播者' WHERE `locale` = 'zhTW' AND `entry` = 38042;
-- OLD name : 丘比特·傳播者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38043
UPDATE `creature_template_locale` SET `Name` = '丘比特‧傳播者' WHERE `locale` = 'zhTW' AND `entry` = 38043;
-- OLD name : 丘比特·傳播者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38044
UPDATE `creature_template_locale` SET `Name` = '丘比特‧傳播者' WHERE `locale` = 'zhTW' AND `entry` = 38044;
-- OLD name : 丘比特·傳播者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38045
UPDATE `creature_template_locale` SET `Name` = '丘比特‧傳播者' WHERE `locale` = 'zhTW' AND `entry` = 38045;
-- OLD subname : 血騎士女王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38052
UPDATE `creature_template_locale` SET `Title` = '血騎士團長' WHERE `locale` = 'zhTW' AND `entry` = 38052;
-- OLD name : [DND] Fire Strat Small (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38053
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38053;
-- OLD name : 巡官史尼卜·凸栓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38066
UPDATE `creature_template_locale` SET `Name` = '巡官史尼卜‧凸栓' WHERE `locale` = 'zhTW' AND `entry` = 38066;
-- OLD name : 染疫殭屍
-- Source : https://www.wowhead.com/wotlk/tw/npc=38104
UPDATE `creature_template_locale` SET `Name` = '染疫僵屍' WHERE `locale` = 'zhTW' AND `entry` = 38104;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38160
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 38160;
-- OLD name : 希瓦娜斯·風行者女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38161
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者女士' WHERE `locale` = 'zhTW' AND `entry` = 38161;
-- OLD name : [PH]上尉(奧格瑪) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38164
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38164;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38188
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 38188;
-- OLD name : 希瓦娜斯·風行者女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38189
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者女士' WHERE `locale` = 'zhTW' AND `entry` = 38189;
-- OLD name : 大型愛心火箭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38204
UPDATE `creature_template_locale` SET `Name` = 'X-45萬人迷' WHERE `locale` = 'zhTW' AND `entry` = 38204;
-- OLD name : 大型愛心火箭 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38207
UPDATE `creature_template_locale` SET `Name` = 'X-45萬人迷' WHERE `locale` = 'zhTW' AND `entry` = 38207;
-- OLD name : 調查員菲贊·銅釘 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38208
UPDATE `creature_template_locale` SET `Name` = '調查員菲贊‧銅釘' WHERE `locale` = 'zhTW' AND `entry` = 38208;
-- OLD name : [DND] Sandbag Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38226
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38226;
-- OLD name : [DND] Sandbag Stack Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38230
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38230;
-- OLD name : [DND] Leader Gathered Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38236
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38236;
-- OLD name : 烏弗路斯·厄火 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38284
UPDATE `creature_template_locale` SET `Name` = '烏弗路斯‧厄火' WHERE `locale` = 'zhTW' AND `entry` = 38284;
-- OLD name : 瑪莉恩·蘇頓 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38325
UPDATE `creature_template_locale` SET `Name` = '瑪莉恩‧蘇頓' WHERE `locale` = 'zhTW' AND `entry` = 38325;
-- OLD name : 史尼佛·鏽彈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38334
UPDATE `creature_template_locale` SET `Name` = '史尼佛‧鏽彈' WHERE `locale` = 'zhTW' AND `entry` = 38334;
-- OLD name : 史尼佛·鏽彈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38335
UPDATE `creature_template_locale` SET `Name` = '史尼佛‧鏽彈' WHERE `locale` = 'zhTW' AND `entry` = 38335;
-- OLD name : 史尼佛·鏽彈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38336
UPDATE `creature_template_locale` SET `Name` = '史尼佛‧鏽彈' WHERE `locale` = 'zhTW' AND `entry` = 38336;
-- OLD name : 史尼佛·鏽彈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38337
UPDATE `creature_template_locale` SET `Name` = '史尼佛‧鏽彈' WHERE `locale` = 'zhTW' AND `entry` = 38337;
-- OLD name : 史尼佛·鏽彈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38338
UPDATE `creature_template_locale` SET `Name` = '史尼佛‧鏽彈' WHERE `locale` = 'zhTW' AND `entry` = 38338;
-- OLD name : 史尼佛·鏽彈 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38339
UPDATE `creature_template_locale` SET `Name` = '史尼佛‧鏽彈' WHERE `locale` = 'zhTW' AND `entry` = 38339;
-- OLD name : [DND] Holiday - Love - Bank Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38340
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38340;
-- OLD name : [DND] Holiday - Love - AH Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38341
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38341;
-- OLD name : [DND] Holiday - Love - Barber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38342
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38342;
-- OLD name : 殉節潛獵者(IGB)
-- Source : https://www.wowhead.com/wotlk/tw/npc=38569
UPDATE `creature_template_locale` SET `Name` = '殉難者潛獵者(IGB/Saurfang)' WHERE `locale` = 'zhTW' AND `entry` = 38569;
-- OLD name : 泰瑞納斯·米奈希爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38579
UPDATE `creature_template_locale` SET `Name` = '泰瑞納斯‧米奈希爾' WHERE `locale` = 'zhTW' AND `entry` = 38579;
-- OLD name : [PH] Matt Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38580
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38580;
-- OLD name : [PH] Matt Test NPC 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38581
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38581;
-- OLD name : 瓦莉絲瑞雅·夢行者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38589
UPDATE `creature_template_locale` SET `Name` = '瓦莉絲瑞雅‧夢行者' WHERE `locale` = 'zhTW' AND `entry` = 38589;
-- OLD name : 珍娜·普勞德摩爾女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38606
UPDATE `creature_template_locale` SET `Name` = '珍娜‧普勞德摩爾女士' WHERE `locale` = 'zhTW' AND `entry` = 38606;
-- OLD name : 穆拉丁·銅鬚 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38607
UPDATE `creature_template_locale` SET `Name` = '穆拉丁‧銅鬚' WHERE `locale` = 'zhTW' AND `entry` = 38607;
-- OLD name : 希瓦娜斯·風行者女士 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38609
UPDATE `creature_template_locale` SET `Name` = '希瓦娜斯‧風行者女士' WHERE `locale` = 'zhTW' AND `entry` = 38609;
-- OLD name : 大領主亞歷山卓斯·莫格萊尼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38610
UPDATE `creature_template_locale` SET `Name` = '大領主亞歷山卓斯‧莫格萊尼' WHERE `locale` = 'zhTW' AND `entry` = 38610;
-- OLD name : 艾伊林 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38825
UPDATE `creature_template_locale` SET `Name` = '艾琳' WHERE `locale` = 'zhTW' AND `entry` = 38825;
-- OLD name : [PH]恐怖圖騰保衛者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38830
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38830;
-- OLD name : [PH]恐怖圖騰收集者 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38843
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38843;
-- OLD name : [PH]被殺的德魯伊 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38846
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38846;
-- OLD name : 派迪麥克斯LK (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38857
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - LK' WHERE `locale` = 'zhTW' AND `entry` = 38857;
-- OLD subname : 傳承正義點數軍需官
-- Source : https://www.wowhead.com/wotlk/tw/npc=38858
UPDATE `creature_template_locale` SET `Title` = '冰霜紋章軍需官' WHERE `locale` = 'zhTW' AND `entry` = 38858;
-- OLD name : [DND]黑鐵衛兵移至兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38870
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38870;
-- OLD name : [DND]鑽地機生成器 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38882
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38882;
-- OLD name : ScottG Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38883
UPDATE `creature_template_locale` SET `Name` = 'Idle Before Scaling' WHERE `locale` = 'zhTW' AND `entry` = 38883;
-- OLD name : [PH]恐怖圖騰商人 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=38905
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 38905;
-- OLD name : 大領主提里奧·弗丁 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=38995
UPDATE `creature_template_locale` SET `Name` = '大領主提里奧‧弗丁' WHERE `locale` = 'zhTW' AND `entry` = 38995;
-- OLD name : Martyr Stalker (Reputation)
-- Source : https://www.wowhead.com/wotlk/tw/npc=39010
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39010;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (39010, 'zhTW','殉難者潛獵者(Reputation)',NULL);
-- OLD name : [DND] TB事件兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39023
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39023;
-- OLD name : [DND] Fire Strat Auto (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39057
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39057;
-- OLD name : [PH]獸人救火員 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39058
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39058;
-- OLD name : 布萊恩·銅鬚(序章) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=39060
UPDATE `creature_template_locale` SET `Name` = '布萊恩‧銅鬚 (序章)' WHERE `locale` = 'zhTW' AND `entry` = 39060;
-- OLD name : 杜雷克‧火語者 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=39090
UPDATE `creature_template_locale` SET `Name` = '杜洛卡‧火語者' WHERE `locale` = 'zhTW' AND `entry` = 39090;
-- OLD name : 泰瑞納斯·米奈希爾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=39217
UPDATE `creature_template_locale` SET `Name` = '泰瑞納斯‧米奈希爾' WHERE `locale` = 'zhTW' AND `entry` = 39217;
-- OLD name : [DND]飛行器 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39229
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39229;
-- OLD name : 癒地者諾爾莎拉 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=39283
UPDATE `creature_template_locale` SET `Name` = '大地治癒者諾爾莎拉' WHERE `locale` = 'zhTW' AND `entry` = 39283;
-- OLD name : [DND]敬禮任務獎勵兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39355
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39355;
-- OLD name : [DND]吼叫任務獎勵兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39356
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39356;
-- OLD name : [DND]跳舞任務獎勵兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39361
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39361;
-- OLD name : [DND]振奮任務獎勵兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39362
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39362;
-- OLD name : 瓦里安·烏瑞恩國王, subname : 暴風之王 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=39371
UPDATE `creature_template_locale` SET `Name` = '瓦里安‧烏瑞恩國王',`Title` = '暴風城之王' WHERE `locale` = 'zhTW' AND `entry` = 39371;
-- OLD name : 卡爾洛斯·地獄吼 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=39372
UPDATE `creature_template_locale` SET `Name` = '卡爾洛斯‧地獄吼' WHERE `locale` = 'zhTW' AND `entry` = 39372;
-- OLD name : [DND]探測目標兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39420
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39420;
-- OLD name : [DND]任務獎勵兔子 - 彈出 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39683
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39683;
-- OLD name : [DND]任務獎勵兔子 - 移動1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39691
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39691;
-- OLD name : [DND]任務獎勵兔子 - 移動2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39692
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39692;
-- OLD name : [DND]任務獎勵兔子 - 移動3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39695
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39695;
-- OLD name : [DND]任務獎勵兔子 - 攻擊 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39703
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39703;
-- OLD name : [DND]攻擊兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39707
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39707;
-- OLD name : [DND] GT轟炸機兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39743
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39743;
-- OLD name : [DND] GT轟炸機兔子2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39744
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39744;
-- OLD name : [PH]穴居怪母親 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39798
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39798;
-- OLD name : [DND] 召喚平台 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39817
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39817;
-- OLD name : [DND]爆炸兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=39841
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 39841;
-- OLD name : 杜雷克之盾 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40006
UPDATE `creature_template_locale` SET `Name` = '杜洛卡之盾' WHERE `locale` = 'zhTW' AND `entry` = 40006;
-- OLD name : 杜雷克之盾 (第二階段) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40037
UPDATE `creature_template_locale` SET `Name` = '杜洛卡之盾 (第二階段)' WHERE `locale` = 'zhTW' AND `entry` = 40037;
-- OLD name : 杜雷克之盾 (第三階段) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40038
UPDATE `creature_template_locale` SET `Name` = '杜洛卡之盾 (第三階段)' WHERE `locale` = 'zhTW' AND `entry` = 40038;
-- OLD name : 杜雷克之盾 (第四階段) (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40039
UPDATE `creature_template_locale` SET `Name` = '杜洛卡之盾 (第四階段)' WHERE `locale` = 'zhTW' AND `entry` = 40039;
-- OLD name : 偵查蝙蝠 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40203
UPDATE `creature_template_locale` SET `Name` = '偵察蝙蝠' WHERE `locale` = 'zhTW' AND `entry` = 40203;
-- OLD name : 扎姆·巴康 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40205
UPDATE `creature_template_locale` SET `Name` = '扎姆‧巴康' WHERE `locale` = 'zhTW' AND `entry` = 40205;
-- OLD name : 大索克·曲矩 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40206
UPDATE `creature_template_locale` SET `Name` = '大索克‧曲矩' WHERE `locale` = 'zhTW' AND `entry` = 40206;
-- OLD name : 葛瑞克斯·腦鍋 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40209
UPDATE `creature_template_locale` SET `Name` = '葛瑞克斯‧腦鍋' WHERE `locale` = 'zhTW' AND `entry` = 40209;
-- OLD name : 札奇·燻管 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40210
UPDATE `creature_template_locale` SET `Name` = '札奇‧燻管' WHERE `locale` = 'zhTW' AND `entry` = 40210;
-- OLD name : 納高·鞭索 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40211
UPDATE `creature_template_locale` SET `Name` = '納高‧鞭索' WHERE `locale` = 'zhTW' AND `entry` = 40211;
-- OLD subname : 傳承競技場武器 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40212
UPDATE `creature_template_locale` SET `Title` = '蠻荒鬥士' WHERE `locale` = 'zhTW' AND `entry` = 40212;
-- OLD name : 艾克頓·銅杯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40213
UPDATE `creature_template_locale` SET `Name` = '艾克頓‧銅杯' WHERE `locale` = 'zhTW' AND `entry` = 40213;
-- OLD name : 伊薇·銅簧 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40214
UPDATE `creature_template_locale` SET `Name` = '伊薇‧銅簧' WHERE `locale` = 'zhTW' AND `entry` = 40214;
-- OLD name : 亞傑斯·鐵膽 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40215
UPDATE `creature_template_locale` SET `Name` = '亞傑斯‧鐵膽' WHERE `locale` = 'zhTW' AND `entry` = 40215;
-- OLD subname : 傳承競技場武器 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40216
UPDATE `creature_template_locale` SET `Title` = '兇惡鬥士' WHERE `locale` = 'zhTW' AND `entry` = 40216;
-- OLD name : 被施妖術的兇暴食人妖 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40225
UPDATE `creature_template_locale` SET `Name` = '被施妖術的凶暴食人妖' WHERE `locale` = 'zhTW' AND `entry` = 40225;
-- OLD name : [DND]贊塔布拉獵豹形態 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=40265
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 40265;
-- OLD name : 藍色發條火箭機器人
-- Source : https://www.wowhead.com/wotlk/tw/npc=40295
UPDATE `creature_template_locale` SET `Name` = '發條火箭機器人' WHERE `locale` = 'zhTW' AND `entry` = 40295;
-- OLD name : [DND] Zen'tabra Travel Form (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=40354
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 40354;
-- OLD name : 亞倫強·日刃 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40413
UPDATE `creature_template_locale` SET `Name` = '亞倫強‧日刃' WHERE `locale` = 'zhTW' AND `entry` = 40413;
-- OLD name : [DND] 任務獎勵兔子 - ET 戰鬥 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=40428
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 40428;
-- OLD name : 艾爾金·科里克斯普林 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40478
UPDATE `creature_template_locale` SET `Name` = '艾爾金‧科里克斯普林' WHERE `locale` = 'zhTW' AND `entry` = 40478;
-- OLD name : 中尉騎士提邁爾·賽迪斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40606
UPDATE `creature_template_locale` SET `Name` = '中尉騎士提邁爾‧賽迪斯' WHERE `locale` = 'zhTW' AND `entry` = 40606;
-- OLD name : 中尉騎士提邁爾·賽迪斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40607
UPDATE `creature_template_locale` SET `Name` = '中尉騎士提邁爾‧賽迪斯' WHERE `locale` = 'zhTW' AND `entry` = 40607;
-- OLD name : [DND] 兔子 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=40617
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 40617;
-- OLD name : 克夫提庫斯·瓊斯 (RETAIL DATAS)
-- Source : https://www.wowhead.com/tw/npc=40724
UPDATE `creature_template_locale` SET `Name` = '克夫提庫斯‧瓊斯' WHERE `locale` = 'zhTW' AND `entry` = 40724;
-- OLD name : [DND]控制器 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/tw/npc=41839
DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW' AND `entry` = 41839;

-- List of entries using retail datas :
-- 81,444,904,1230,1233,1235,1293,1455,1546,1859,2295,2296,2301,2870,2872,2940,4315,4318,4579,5098,5131,5192,5549,5588,5590,5671,5672,5904,6046,6067,6783,9617,10448,14201,14242,15166,15982,15983,16312,16711,16754,16759,16853,16872,16874,16875,16882,16883,16908,16909,16926,16930,16941,17010,17012,17026,17027,17028,17061,17065,17162,17188,17214,17222,17224,17228,17240,17241,17242,17285,17295,17333,17387,17421,17445,17446,17487,17489,17506,17515,17575,17665,17679,17718,17733,17767,17772,17822,17914,17948,17949,17982,17997,18076,18149,18287,18345,18363,18364,18365,18366,18377,18378,18379,18380,18552,18643,18674,18963,18996,19059,19060,19069,19078,19079,19080,19081,19082,19083,19084,19085,19086,19087,19088,19089,19090,19091,19125,19126,19127,19128,19160,19228,19247,19269,19325,19611,19615,19622,19700,19711,19714,19721,19753,19835,19907,19908,19914,19974,20103,20297,20364,20366,20367,20371,20375,20396,20413,20414,20556,20605,20716,21043,21154,21156,21319,21320,21390,21444,21502,21650,22229,22234,22237,22361,22433,22871,22877,22917,22939,22948,22952,22955,22956,22957,22959,22962,22964,22965,22989,23002,23003,23009,23010,23011,23012,23054,23064,23065,23067,23111,23140,23151,23196,23197,23331,23340,23406,23407,23467,23474,23475,23476,23481,23486,23497,23520,23521,23522,23544,23558,23603,23604,23627,23628,23683,23684,23693,23710,23722,23730,23765,23788,23808,23863,23872,23891,23976,24028,24032,24033,24048,24053,24054,24067,24109,24123,24127,24132,24139,24141,24142,24147,24148,24149,24154,24155,24162,24168,24181,24232,24238,24240,24262,24292,24293,24294,24295,24296,24297,24298,24299,24300,24301,24302,24303,24304,24305,24306,24307,24308,24309,24310,24311,24330,24341,24342,24343,24347,24348,24349,24350,24351,24352,24357,24358,24360,24361,24364,24375,24377,24378,24394,24405,24451,24452,24456,24465,24466,24468,24495,24498,24510,24520,24527,24542,24554,24557,24558,24643,24657,24664,24688,24689,24690,24706,24710,24711,24723,24734,24735,24736,24737,24738,24739,24741,24742,24782,24784,24788,24833,24855,24877,24892,24960,24962,24966,24967,24984,24985,24986,24987,24988,24989,24990,25025,25035,25037,25043,25047,25050,25059,25078,25185,25194,25215,25223,25233,25235,25237,25245,25246,25248,25264,25281,25282,25286,25287,25288,25314,25329,25344,25379,25385,25426,25429,25477,25499,25500,25511,25537,25589,25590,25702,25705,25714,25747,25780,25804,25807,25827,25849,25855,25868,25869,25870,25871,25872,25873,25874,25875,25876,25877,25878,25983,25984,26044,26080,26083,26084,26085,26155,26156,26224,26247,26258,26355,26366,26376,26398,26451,26459,26471,26484,26497,26501,26504,26535,26537,26538,26539,26540,26541,26542,26546,26548,26549,26551,26552,26564,26566,26569,26574,26581,26594,26597,26598,26599,26600,26602,26604,26634,26654,26671,26680,26697,26707,26708,26709,26720,26721,26733,26762,26764,26810,26814,26822,26842,26845,26846,26847,26848,26850,26852,26853,26869,26877,26878,26879,26880,26881,26883,26934,26936,26941,26944,26945,26947,26950,26951,26952,26953,26954,26955,26956,26957,26958,26959,26960,26961,26962,26963,26964,26972,26973,26974,26975,26976,26977,26980,26981,26984,26986,26987,26988,26989,26990,26991,26992,26994,26995,26996,26998,26999,27001,27003,27010,27011,27012,27025,27026,27028,27030,27032,27033,27034,27039,27041,27042,27043,27044,27053,27057,27058,27062,27065,27066,27067,27068,27070,27071,27088,27089,27105,27123,27157,27171,27188,27209,27215,27216,27231,27248,27310,27311,27312,27319,27344,27377,27378,27385,27398,27447,27451,27470,27474,27476,27477,27478,27527,27575,27584,27585,27628,27656,27680,27683,27716,27718,27719,27720,27750,27760,27803,27804,27842,27858,27862,27872,27873,27876,27884,27885,27891,27903,27907,27951,27986,27987,28005,28031,28033,28047,28057,28115,28194,28195,28196,28197,28214,28261,28262,28329,28347,28355,28376,28443,28444,28447,28448,28451,28480,28501,28554,28618,28621,28652,28674,28682,28685,28687,28689,28690,28691,28692,28694,28696,28697,28698,28699,28700,28701,28703,28704,28706,28707,28708,28714,28716,28718,28719,28721,28722,28723,28724,28725,28726,28727,28728,28742,28760,28771,28774,28776,28806,28809,28811,28812,28813,28855,28912,28914,28930,28958,28964,28990,28991,28992,28993,28997,29032,29039,29049,29061,29065,29067,29068,29071,29072,29073,29083,29100,29114,29141,29142,29145,29154,29157,29173,29175,29177,29178,29179,29180,29182,29199,29204,29227,29228,29233,29244,29246,29250,29252,29261,29262,29263,29277,29287,29288,29289,29290,29291,29292,29293,29294,29295,29296,29297,29298,29299,29300,29369,29370,29374,29375,29376,29377,29380,29382,29396,29405,29418,29419,29420,29421,29424,29430,29431,29456,29473,29476,29478,29493,29495,29497,29499,29505,29506,29507,29509,29510,29511,29512,29513,29514,29525,29527,29528,29533,29534,29537,29538,29539,29540,29541,29547,29568,29579,29586,29593,29604,29607,29611,29626,29628,29631,29640,29641,29651,29652,29665,29696,29702,29703,29714,29715,29721,29725,29727,29728,29732,29740,29744,29749,29751,29757,29762,29794,29795,29839,29843,29861,29862,29904,29905,29907,29908,29909,29923,29925,29926,29937,29950,29959,29963,29964,29967,29968,29970,29971,30008,30010,30041,30060,30062,30063,30086,30107,30136,30152,30154,30155,30157,30158,30159,30162,30182,30208,30217,30222,30231,30239,30314,30340,30344,30352,30382,30401,30405,30406,30408,30411,30426,30427,30428,30431,30433,30434,30436,30439,30472,30488,30489,30503,30504,30552,30555,30556,30557,30558,30561,30565,30570,30571,30578,30579,30580,30582,30583,30584,30587,30590,30591,30595,30606,30611,30647,30654,30677,30678,30708,30709,30713,30715,30717,30721,30724,30730,30731,30733,30734,30735,30824,30838,30869,30870,30885,30888,30946,31017,31018,31019,31020,31021,31022,31023,31024,31025,31026,31027,31028,31060,31080,31081,31084,31088,31102,31121,31122,31129,31133,31143,31158,31162,31165,31167,31168,31169,31170,31171,31173,31176,31182,31185,31189,31190,31235,31238,31240,31242,31247,31248,31249,31269,31283,31290,31300,31302,31305,31306,31307,31318,31325,31328,31330,31395,31418,31419,31426,31428,31433,31435,31581,31582,31619,31648,31651,31693,31696,31763,31764,31775,31776,31781,31810,31839,31864,31865,32172,32189,32208,32216,32239,32301,32302,32303,32309,32311,32312,32326,32329,32332,32333,32334,32336,32337,32346,32355,32358,32360,32362,32364,32365,32376,32378,32401,32402,32403,32404,32407,32408,32411,32413,32418,32423,32444,32477,32495,32496,32497,32509,32514,32515,32523,32524,32546,32565,32587,32588,32676,32678,32679,32684,32685,32686,32687,32689,32690,32691,32693,32702,32708,32716,32718,32727,32729,32730,32731,32732,32743,32745,32747,32748,32749,32755,32756,32757,32758,32759,32760,32761,32762,32774,32775,32776,32777,32797,32893,32901,32913,32941,32946,33018,33019,33026,33027,33031,33222,33223,33225,33235,33248,33290,33307,33309,33310,33312,33315,33325,33327,33331,33333,33335,33351,33379,33403,33431,33432,33434,33435,33439,33455,33457,33499,33538,33539,33541,33542,33544,33548,33549,33553,33555,33556,33557,33579,33580,33583,33586,33587,33588,33589,33592,33594,33595,33596,33597,33599,33600,33601,33603,33621,33622,33628,33629,33637,33644,33645,33646,33648,33649,33650,33652,33653,33654,33658,33659,33665,33685,33699,33722,33762,33763,33770,33788,33817,33849,33853,33854,33861,33867,33868,33869,33871,33915,33916,33917,33920,33921,33922,33923,33924,33925,33926,33927,33928,33929,33932,33933,33934,33935,33936,33937,33938,33939,33963,33970,33971,33972,33973,33974,33992,34032,34044,34058,34059,34060,34064,34070,34071,34089,34091,34094,34168,34172,34173,34244,34252,34441,34445,34449,34451,34453,34455,34456,34458,34459,34460,34461,34466,34467,34468,34469,34471,34472,34473,34474,34496,34497,34533,34612,34644,34645,34657,34658,34675,34676,34677,34678,34679,34681,34682,34683,34684,34685,34702,34703,34705,34708,34710,34711,34712,34713,34714,34738,34739,34741,34744,34765,34766,34768,34772,34783,34785,34786,34787,34798,34816,34824,34880,34881,34885,34912,34914,34915,34924,34955,34972,34973,34980,34990,34991,34992,34993,34995,34996,34997,34998,35004,35005,35007,35017,35019,35022,35023,35024,35025,35026,35035,35068,35087,35088,35090,35091,35093,35099,35100,35101,35102,35131,35132,35133,35135,35290,35320,35321,35344,35361,35372,35373,35458,35462,35471,35476,35495,35496,35497,35498,35508,35545,35564,35569,35571,35573,35574,35589,35594,35604,35607,35633,35635,35636,35637,35640,35766,35770,35771,35826,35895,35909,35910,36065,36066,36095,36108,36109,36114,36116,36120,36122,36208,36213,36217,36284,36351,36352,36380,36390,36536,36624,36642,36644,36648,36789,36792,36823,36856,36904,36912,36948,36950,36955,36977,36990,36993,37172,37182,37184,37188,37205,37221,37223,37527,37542,37552,37554,37580,37581,37591,37592,37596,37597,37601,37693,37715,37742,37764,37765,37828,37833,37845,37879,37887,37888,37903,37904,37915,37935,37936,37950,38039,38040,38041,38042,38043,38044,38045,38052,38066,38160,38161,38188,38189,38204,38207,38208,38284,38325,38334,38335,38336,38337,38338,38339,38579,38589,38606,38607,38609,38610,38825,38857,38883,38995,39060,39090,39217,39283,39371,39372,40006,40037,40038,40039,40203,40205,40206,40209,40210,40211,40212,40213,40214,40215,40216,40225,40413,40478,40606,40607,40724
-- END
