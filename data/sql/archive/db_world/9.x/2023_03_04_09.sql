-- DB update 2023_03_04_08 -> 2023_03_04_09
-- Halls of Reflection - remove the used duplicates (no broadcastid) and add missing texts.
-- Marwyn
DELETE FROM `creature_text` WHERE `CreatureID`=38113;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(38113, 0, 0, 'Death is all that you will find here!', 14, 0, 100, 0, 0, 16734, 37948, 0, 'marwyn SAY_AGGRO'),
(38113, 1, 0, 'I saw the same look in his eyes when he died. Terenas could hardly believe it.', 14, 0, 100, 0, 0, 16735, 37949, 0, 'marwyn SAY_SLAY_1'),
(38113, 1, 1, 'Choke on your suffering!', 14, 0, 100, 0, 0, 16736, 37950, 0, 'marwyn SAY_SLAY_2'),
(38113, 2, 0, 'Yes... Run... Run to meet your destiny... Its bitter, cold embrace, awaits you.', 14, 0, 100, 0, 0, 16737, 37951, 0, 'marwyn SAY_DEATH'),
(38113, 3, 0, 'Your flesh shall decay before your very eyes!', 14, 0, 100, 0, 0, 16739, 37954, 0, 'marwyn SAY_CORRUPTED_FLESH'),
(38113, 4, 0, 'Waste away into nothingness!', 14, 0, 100, 0, 0, 16740, 37955, 0, 'marwyn SAY_CORRUPTED_WELL'),
(38113, 5, 0, 'As you wish, my lord.', 14, 0, 100, 0, 0, 16741, 37953, 0, 'marwyn SAY_MARWYN_INTRO_1'),
(38113, 6, 0, 'Spirits appear and surround the altar!', 41, 0, 100, 0, 0, 0, 38623, 0, 'marwyn EMOTE_MARWYN_INTRO_SPIRITS'),
(38113, 7, 0, 'The master surveyed his kingdom and found it... Lacking. His judgement was swift and without mercy: DEATH TO ALL!', 14, 0, 100, 0, 0, 16738, 37952, 0, 'marwyn SAY_MARWYN_WIPE_AFTER_FALRIC');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=38113 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(38113, 0, 0, 'zhCN', '你们只会寻得死亡！'),
(38113, 1, 0, 'zhCN', '我看到的是同样的眼神。泰瑞纳斯怎么也想不到。'),
(38113, 1, 1, 'zhCN', '痛苦的窒息吧！'),
(38113, 2, 0, 'zhCN', '对，去吧……迎接你的命运吧……痛苦、冰冷的拥抱正等着你。'),
(38113, 3, 0, 'zhCN', '你的躯壳将在你的眼前朽化！'),
(38113, 4, 0, 'zhCN', '灰飞烟灭吧！'),
(38113, 5, 0, 'zhCN', '如您所愿，我的主人。'),
(38113, 6, 0, 'zhCN', '灵魂们出现并围在祭坛四周！'),
(38113, 7, 0, 'zhCN', '主人审视他的王国，找到了它的……不足。他的决断迅速而无情：生灵俱灭！');

-- Falric
DELETE FROM `creature_text` WHERE `CreatureID`=38112;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(38112, 0, 0, 'Men, women, and children... None were spared the master\'s wrath. Your death will be no different.', 14, 0, 100, 0, 0, 16710, 37931, 0, 'falric SAY_AGGRO'),
(38112, 1, 0, 'Sniveling maggot!', 14, 0, 100, 0, 0, 16711, 37941, 0, 'falric SAY_SLAY_1'),
(38112, 1, 1, 'The children of Stratholme fought with more ferocity!', 14, 0, 100, 0, 0, 16712, 37942, 0, 'falric SAY_SLAY_2'),
(38112, 2, 0, 'Marwyn, finish them...', 14, 0, 100, 0, 0, 16713, 37943, 0, 'falric SAY_DEATH'),
(38112, 3, 0, 'Despair... so delicious...', 14, 0, 100, 0, 0, 16715, 37945, 0, 'falric SAY_IMPENDING_DESPAIR'),
(38112, 4, 0, 'Fear... so exhilarating...', 14, 0, 100, 0, 0, 16716, 37946, 0, 'falric SAY_DEFILING_HORROR'),
(38112, 5, 0, 'As you wish, my lord.', 14, 0, 100, 0, 0, 16717, 37953, 0, 'Falric SAY_FALRIC_INTRO_1'),
(38112, 6, 0, 'Soldiers of Lordaeron, rise to meet your master\'s call!', 14, 0, 100, 0, 0, 16714, 37944, 0, 'Falric SAY_FALRIC_INTRO_2');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=38112 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(38112, 0, 0, 'zhCN', '男人，女人，还有孩子……没人能逃过主人的怒火。你的死早已注定。'),
(38112, 1, 0, 'zhCN', '无能的家伙！'),
(38112, 1, 1, 'zhCN', '斯坦索姆的小孩子都要比你们勇猛！'),
(38112, 2, 0, 'zhCN', '玛维恩，干掉他们……'),
(38112, 3, 0, 'zhCN', '绝望……如此甘甜……'),
(38112, 4, 0, 'zhCN', '恐惧……如此美好……'),
(38112, 5, 0, 'zhCN', '遵命，我的主人。'),
(38112, 6, 0, 'zhCN', '洛丹伦的战士们，服从主人的召唤！');

-- Frostsworn General (Big add after the wave encounter)
DELETE FROM `creature_text` WHERE `CreatureID`=36723;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(36723, 0, 0, 'You are not worthy to face the Lich King!', 14, 0, 100, 0, 0, 16921, 38664, 0, 'SAY_FROSTSWORN_GENERAL_AGGRO'),
(36723, 1, 0, 'Master, I have failed...', 14, 0, 100, 0, 0, 16922, 36921, 0, 'SAY_FROSTSWORN_GENERAL_DEATH');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=36723 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(36723, 0, 0, 'zhCN', '你根本没有资格晋见巫妖王。'),
(36723, 1, 0, 'zhCN', '主人，我失败了……');

-- The Lich King (Event)
DELETE FROM `creature_text` WHERE `CreatureID`=37226;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(37226, 0, 0, 'SILENCE, PALADIN!', 14, 0, 100, 0, 0, 17225, 37613, 0, 'Lich King SAY_LK_INTRO_1'),
(37226, 1, 0, 'So you wish to commune with the dead? You shall have your wish.', 14, 0, 100, 0, 0, 17226, 37614, 0, 'Lich King SAY_LK_INTRO_2'),
(37226, 2, 0, 'Falric. Marwyn. Bring their corpses to my chamber when you are through.', 14, 0, 100, 0, 0, 17227, 37615, 0, 'Lich King SAY_LK_INTRO_3');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=37226 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(37226, 0, 0, 'zhCN', '闭嘴，圣骑士！'),
(37226, 1, 0, 'zhCN', '你真的想和死人交谈？我会满足你。'),
(37226, 2, 0, 'zhCN', '法瑞克，玛维恩，杀掉他们，送到我的大殿来。');

-- Quel'Delar
DELETE FROM `creature_text` WHERE `CreatureID`=37158;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(37158, 0, 0, 'Quel\'Delar leaps to life in the presence of Frostmourne!', 41, 0, 100, 0, 0, 0, 37645, 0, 'Quel\'Delar EMOTE_QUEL_SPAWN'),
(37158, 1, 0, '%s prepares to attack!', 41, 0, 100, 0, 0, 0, 37211, 0, 'Quel\'Delar EMOTE_QUEL_PREPARE');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=37158 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(37158, 0, 0, 'zhCN', '面对霜之哀伤，奎尔德拉很快复苏了！'),
(37158, 1, 0, 'zhCN', '%s准备攻击！');

-- Uther the Lightbringer
DELETE FROM `creature_text` WHERE `CreatureID`=37225;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(37225, 0, 0, 'Jaina! Could it truly be you?', 12, 0, 100, 0, 0, 16666, 37603, 0, 'Uther SAY_UTHER_INTRO_A2_1'),
(37225, 1, 0, 'Jaina, you haven\'t much time. The Lich King sees what the sword sees. He will be here shortly. ', 12, 0, 100, 0, 0, 16667, 37604, 0, 'Uther SAY_UTHER_INTRO_A2_2'),
(37225, 2, 0, 'No, girl. Arthas is not here. Arthas is merely a presence within the Lich King\'s mind. A dwindling presence...', 12, 0, 100, 0, 0, 16668, 37605, 0, 'Uther SAY_UTHER_INTRO_A2_3'),
(37225, 3, 0, 'Jaina, listen to me. You must destroy the Lich King. You cannot reason with him. He will kill you and your allies and raise you all as powerful soldiers of the Scourge.', 12, 0, 100, 0, 0, 16669, 37606, 0, 'Uther SAY_UTHER_INTRO_A2_4'),
(37225, 4, 0, 'Snap out of it, girl. You must destroy the Lich King at the place where he merged with Ner\'zhul - atop the spire, at the Frozen Throne. It is the only way.', 12, 0, 100, 0, 0, 16670, 37607, 0, 'Uther SAY_UTHER_INTRO_A2_5'),
(37225, 5, 0, 'There is... something else that you should know about the Lich King. Control over the Scourge must never be lost. Even if you were to strike down the Lich King, another would have to take his place. For without the control of its master, the Scourge would run rampant across the world - destroying all living things.', 12, 0, 100, 0, 0, 16671, 37608, 0, 'Uther SAY_UTHER_INTRO_A2_6'),
(37225, 6, 0, 'A grand sacrifice by a noble soul...', 12, 0, 100, 0, 0, 16672, 37609, 0, 'Uther SAY_UTHER_INTRO_A2_7'),
(37225, 7, 0, 'I do not know, Jaina. I suspect that the piece of Arthas that might be left inside the Lich King is all that holds the Scourge from annihilating Azeroth.', 12, 0, 100, 0, 0, 16673, 37610, 0, 'Uther SAY_UTHER_INTRO_A2_8'),
(37225, 8, 0, 'No, Jaina! ARRRRRRGHHHH... He... He is coming. You... You must...', 12, 0, 100, 0, 0, 16674, 37611, 0, 'Uther SAY_UTHER_INTRO_A2_9'),
(37225, 9, 0, 'Careful, girl. I\'ve heard talk of that cursed blade saving us before. Look around you and see what has been born of Frostmourne.', 12, 0, 100, 0, 0, 16659, 37583, 0, 'Uther SAY_UTHER_INTRO_H2_1'),
(37225, 10, 0, 'You haven\'t much time. The Lich King sees what the sword sees. He will be here shortly. ', 12, 0, 100, 0, 0, 16660, 37584, 0, 'Uther SAY_UTHER_INTRO_H2_2'),
(37225, 11, 0, 'You cannot defeat the Lich King. Not here. You would be a fool to try. He will kill those that follow you and raise them as powerful soldiers of the Scourge. But for you, Sylvanas, his reward for you would be worse than the last.', 12, 0, 100, 0, 0, 16661, 37585, 0, 'Uther SAY_UTHER_INTRO_H2_3'),
(37225, 12, 0, 'Perhaps, but know this: there must always be a Lich King. Even if you were to strike down Arthas, another would have to take his place, for without the control of the Lich King, the Scourge would wash over this world like locusts, destroying all that they touched.', 12, 0, 100, 0, 0, 16662, 37586, 0, 'Uther SAY_UTHER_INTRO_H2_4'),
(37225, 13, 0, 'I do not know, Banshee Queen. I suspect that the piece of Arthas that might be left inside the Lich King is all that holds the Scourge from annihilating Azeroth.', 12, 0, 100, 0, 0, 16663, 37587, 0, 'Uther SAY_UTHER_INTRO_H2_5'),
(37225, 14, 0, 'Alas, the only way to defeat the Lich King is to destroy him at the place where he was created.', 12, 0, 100, 0, 0, 16664, 37588, 0, 'Uther SAY_UTHER_INTRO_H2_6'),
(37225, 15, 0, 'Aye. ARRRRRRGHHHH... He... He is coming. You... You must...', 12, 0, 100, 0, 0, 16665, 37589, 0, 'Uther SAY_UTHER_INTRO_H2_7'),
(37225, 16, 0, 'Halt! Do not carry that blade any further!', 14, 0, 100, 25, 0, 16675, 37201, 0, 'Uther SAY_BATTERED_HILT_HALT'),
(37225, 17, 0, 'Do you realize what you\'ve done?', 14, 0, 100, 5, 0, 16676, 37202, 0, 'Uther SAY_BATTERED_HILT_REALIZE'),
(37225, 18, 0, 'You have forged this blade from saronite, the very blood of an old god. The power of the Lich King calls to this weapon.', 12, 0, 100, 1, 0, 16677, 37204, 0, 'Uther SAY_BATTERED_HILT_OUTRO1'),
(37225, 19, 0, 'Each moment you tarry here, Quel\'Delar drinks in the evil of this place.', 12, 0, 100, 1, 0, 16678, 38442, 0, 'Uther SAY_BATTERED_HILT_OUTRO2'),
(37225, 20, 0, 'There is only one way to cleanse this sword. Make haste for the Sunwell and immerse the blade in its waters.', 12, 0, 100, 25, 0, 16679, 37205, 0, 'Uther SAY_BATTERED_HILT_OUTRO3'),
(37225, 21, 0, 'I can resist Frostmourne\'s call no more...', 12, 0, 100, 1, 0, 16680, 37206, 0, 'Uther SAY_BATTERED_HILT_OUTRO4');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=37225 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(37225, 0, 0, 'zhCN', '吉安娜！真的是你吗？'),
(37225, 1, 0, 'zhCN', '吉安娜，你没有时间了。巫妖王能看到剑旁的一切。他就要来了。'),
(37225, 2, 0, 'zhCN', '不，孩子。阿尔萨斯不在这里。阿尔萨斯只是巫妖王意识中的一个存在。一个即将泯灭的存在……'),
(37225, 3, 0, 'zhCN', '吉安娜，听我说。你必须终结巫妖王。不要试图说服他。他会把你们全杀掉，变成天灾军团的战士。'),
(37225, 4, 0, 'zhCN', '振作起来，女孩。你必须在巫妖王和耐奥祖融合的地方－－冰封王座，将他终结。这是唯一的办法。'),
(37225, 5, 0, 'zhCN', '还有…还有一些事情你需要知道。天灾军团绝不能失去控制。即使你战胜了这个巫妖王，也要有别人来取代他。没有巫妖王的控制，天灾军团就会横扫整个世界，摧毁一切生灵。'),
(37225, 6, 0, 'zhCN', '要有个崇高的灵魂作出牺牲……'),
(37225, 7, 0, 'zhCN', '我不知道，吉安娜。我怀疑正是阿尔萨斯残留在巫妖王体内的一缕灵魂阻止了天灾军团彻底毁灭艾泽拉斯。'),
(37225, 8, 0, 'zhCN', '不，吉安娜！啊……他……他来了。你……你必须……'),
(37225, 9, 0, 'zhCN', '小心，女孩。我听说这把被诅咒的剑救过我们。注意周围，看看霜之哀伤都创造了些什么。'),
(37225, 10, 0, 'zhCN', '你没有时间了。巫妖王能看到剑旁的一切。他就要来了。'),
(37225, 11, 0, 'zhCN', '在这里，你无法击败巫妖王。这种企图是愚蠢的。他会打倒那些跟随你的人，把他们变成强大的天灾战士。只有你除外，希尔瓦娜斯……他对你的“馈赠”要比上次更恐怖。'),
(37225, 12, 0, 'zhCN', '也许吧，但要记住：一定要有一位巫妖王。即使你终结了阿尔萨斯，也要有另一个人来取代他。没有了巫妖王的控制，天灾军团就会像蝗灾一样横扫世界，所到之处，寸草不生。'),
(37225, 13, 0, 'zhCN', '我不知道，女妖之王。我怀疑正是阿尔萨斯残留在巫妖王体内的一缕灵魂阻止了天灾军团彻底毁灭艾泽拉斯。'),
(37225, 14, 0, 'zhCN', '唉，击败巫妖王的唯一方法就是在他的诞生地摧毁他。'),
(37225, 15, 0, 'zhCN', '啊……他……他来了。你……你必须……'),
(37225, 16, 0, 'zhCN', '住手！你快把那剑放下！'),
(37225, 17, 0, 'zhCN', '你知道你在干什么吗？'),
(37225, 18, 0, 'zhCN', '你用上古之神的血，萨隆邪铁重铸了这把剑。巫妖王的力量会召唤它。'),
(37225, 19, 0, 'zhCN', '只要你留在这里，奎尔德拉就会汲取这里的邪能。'),
(37225, 20, 0, 'zhCN', '只有一个办法能净化它。赶快到太阳之井去，将剑沉入井水之中。'),
(37225, 21, 0, 'zhCN', '我抵抗不了霜之哀伤的召唤……巫妖王来了……');

-- Sylvanas (Part 1)
DELETE FROM `creature_text` WHERE `CreatureID`=37223;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(37223, 0, 0, 'I... I don\'t believe it! Frostmourne stands before us - unguarded - just as the gnome claimed. Come, heroes!', 14, 0, 100, 0, 0, 17049, 37568, 0, 'Sylvanas SAY_SYLVANAS_INTRO_1'),
(37223, 1, 0, 'Standing this close to the blade that ended my life... The pain... It is renewed.', 14, 0, 100, 0, 0, 17050, 37569, 0, 'Sylvanas SAY_SYLVANAS_INTRO_2'),
(37223, 2, 0, 'I dare not touch it. Stand back! Stand back as I attempt to commune with the blade! Perhaps our salvation lies within...', 14, 0, 100, 0, 0, 17051, 37570, 0, 'Sylvanas SAY_SYLVANAS_INTRO_3'),
(37223, 3, 0, 'Uther... Uther the Lightbringer. How...', 12, 0, 100, 0, 0, 17052, 37571, 0, 'Sylvanas SAY_SYLVANAS_INTRO_4'),
(37223, 4, 0, 'The Lich King is here? Then my destiny shall be fulfilled on this day! ', 12, 0, 100, 0, 0, 17053, 37572, 0, 'Sylvanas SAY_SYLVANAS_INTRO_5'),
(37223, 5, 0, 'There must be a way...', 12, 0, 100, 0, 0, 17054, 37573, 0, 'Sylvanas SAY_SYLVANAS_INTRO_6'),
(37223, 6, 0, 'Who could bear such a burden?', 12, 0, 100, 0, 0, 17055, 37600, 0, 'Sylvanas SAY_SYLVANAS_INTRO_7'),
(37223, 7, 0, 'The Frozen Throne...', 12, 0, 100, 0, 0, 17056, 37575, 0, 'Sylvanas SAY_SYLVANAS_INTRO_8'),
(37223, 8, 0, 'You will not escape me that easily, Arthas! I will have my vengeance! ', 14, 0, 100, 0, 0, 17057, 37576, 0, 'Sylvanas SAY_SYLVANAS_INTRO_END');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=37223 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(37223, 0, 0, 'zhCN', '真是……不敢相信！霜之哀伤居然……无人看管，那个侏儒说的没错。来吧，英雄们！'),
(37223, 1, 0, 'zhCN', '就是这把剑终结了我的生命……那种痛苦……挥之不去。'),
(37223, 2, 0, 'zhCN', '我不敢碰它。后退！后退，我要试着和这把剑交谈！也许我们的救赎就在其中……'),
(37223, 3, 0, 'zhCN', '乌瑟尔……乌瑟尔·光明使者。怎么……'),
(37223, 4, 0, 'zhCN', '巫妖王就在这里？那今天就是我完成使命的日子！'),
(37223, 5, 0, 'zhCN', '一定有办法……'),
(37223, 6, 0, 'zhCN', '谁能扛起这样的重担？'),
(37223, 7, 0, 'zhCN', '冰封王座……'),
(37223, 8, 0, 'zhCN', '你别想轻易逃走，阿尔萨斯！我的仇一定要报！');

-- Jaina (Part 1)
DELETE FROM `creature_text` WHERE `CreatureID`=37221;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(37221, 0, 0, 'The chill of this place... I can feel my blood freezing.', 14, 0, 100, 0, 0, 16631, 37591, 0, 'Jaina SAY_JAINA_INTRO_1'),
(37221, 1, 0, 'What is that! Up ahead! Could it be? Heroes, at my side!', 14, 0, 100, 0, 0, 16632, 37592, 0, 'Jaina SAY_JAINA_INTRO_2'),
(37221, 2, 0, 'Frostmourne: the blade that destroyed our kingdom...', 14, 0, 100, 0, 0, 16633, 37593, 0, 'Jaina SAY_JAINA_INTRO_3'),
(37221, 3, 0, 'Stand back! Touch that blade and your soul will be scarred for all eternity! I must attempt to commune with the spirits locked away within Frostmourne. Give me space. Back up, please. ', 14, 0, 100, 0, 0, 16634, 37594, 0, 'Jaina SAY_JAINA_INTRO_4'),
(37221, 4, 0, 'Uther! Dear Uther! I... I\'m so sorry.', 12, 0, 100, 0, 0, 16635, 37595, 0, 'Jaina SAY_JAINA_INTRO_5'),
(37221, 5, 0, 'Arthas is here? Maybe I...', 12, 0, 100, 0, 0, 16636, 37596, 0, 'Jaina SAY_JAINA_INTRO_6'),
(37221, 6, 0, 'But Uther, if there\'s any hope of reaching Arthas. I... I must try.', 12, 0, 100, 0, 0, 16637, 37597, 0, 'Jaina SAY_JAINA_INTRO_7'),
(37221, 7, 0, 'Tell me how, Uther? How do I destroy my prince? My...', 12, 0, 100, 0, 0, 16638, 37598, 0, 'Jaina SAY_JAINA_INTRO_8'),
(37221, 8, 0, 'You\'re right, Uther. Forgive me. I... I don\'t know what got a hold of me. We will deliver this information to the King and the knights that battle the Scourge within Icecrown Citadel.', 12, 0, 100, 0, 0, 16639, 37599, 0, 'Jaina SAY_JAINA_INTRO_9'),
(37221, 9, 0, 'Who could bear such a burden?', 12, 0, 100, 0, 0, 16640, 37600, 0, 'Jaina SAY_JAINA_INTRO_10'),
(37221, 10, 0, 'Then maybe there is still hope...', 12, 0, 100, 0, 0, 16641, 37601, 0, 'Jaina SAY_JAINA_INTRO_11'),
(37221, 11, 0, 'You won\'t deny me this, Arthas! I must know... I must find out... ', 14, 0, 100, 0, 0, 16642, 37602, 0, 'Jaina SAY_JAINA_INTRO_END');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=37221 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(37221, 0, 0, 'zhCN', '这种刺骨的寒冷……血液好像都要凝结了。'),
(37221, 1, 0, 'zhCN', '看前面！那是什么！难道是？英雄们，到我身边来！'),
(37221, 2, 0, 'zhCN', '霜之哀伤：正是它摧毁了我们的王国。'),
(37221, 3, 0, 'zhCN', '后退！如果碰到这把剑，你的灵魂就会受到永恒的创伤！我必须试着与封印在霜之哀伤中的灵魂交谈。远离我，请再后退一点。'),
(37221, 4, 0, 'zhCN', '乌瑟尔！亲爱的乌瑟尔！我……很难过。'),
(37221, 5, 0, 'zhCN', '阿尔萨斯在这里？也许我……'),
(37221, 6, 0, 'zhCN', '但是，乌瑟尔，哪怕有一丝见到他的可能，我……我也要去。'),
(37221, 7, 0, 'zhCN', '告诉我，乌瑟尔，我该怎样终结我的王子？我的……'),
(37221, 8, 0, 'zhCN', '你是对的，乌瑟尔。原谅我。我……我不知道自己是怎么了。正在冰冠堡垒与天灾军团作战的国王和骑士们很快就会得到我们的报告。'),
(37221, 9, 0, 'zhCN', '谁能扛起这样的重担？'),
(37221, 10, 0, 'zhCN', '也许还有希望……'),
(37221, 11, 0, 'zhCN', '你不能拒绝我，阿尔萨斯！我必须知道……必须明白……');

-- The Lich King Boss (Part 2)
DELETE FROM `creature_text` WHERE `CreatureID`=36954;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(36954, 0, 0, 'Your allies have arrived Jaina, just as you promised. You will all become powerful agents of the Scourge.', 14, 0, 100, 0, 0, 17212, 37172, 0, 'Lich King SAY_LK_AGGRO_ALLY'),
(36954, 1, 0, 'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!', 14, 0, 100, 0, 0, 17213, 37173, 0, 'Lich King SAY_LK_AGGRO_HORDE'),
(36954, 2, 0, 'There is no escape!', 14, 0, 100, 0, 0, 17217, 37177, 0, 'Lich King SAY_LK_WALL_01'),
(36954, 3, 0, 'Succumb to the chill of the grave.', 14, 0, 100, 0, 0, 17218, 37175, 0, 'Lich King SAY_LK_WALL_02'),
(36954, 4, 0, 'Another dead end.', 14, 0, 100, 0, 0, 17219, 37176, 0, 'Lich King SAY_LK_WALL_03'),
(36954, 5, 0, 'How long can you fight it?', 14, 0, 100, 0, 0, 17220, 38668, 0, 'Lich King SAY_LK_WALL_04'),
(36954, 6, 0, 'Arise minions.  Do not let them pass.', 14, 0, 100, 0, 0, 17216, 38669, 0, 'Lich King SAY_LK_GHOUL'),
(36954, 7, 0, 'Minions, sieze them.  Bring their corpses back to me.', 14, 0, 100, 0, 0, 17222, 38670, 0, 'Lich King SAY_LK_ABON'),
(36954, 8, 0, 'Death\'s cold embrace awaits.', 14, 0, 100, 0, 0, 17221, 37174, 0, 'Lich King SAY_LK_KING_WINTER'),
(36954, 9, 0, 'Nowhere to run! You\'re mine now...', 14, 0, 100, 0, 0, 17223, 36994, 0, 'Lich King SAY_LK_NOWHERE_TO_RUN');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=36954 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(36954, 0, 0, 'zhCN', '你的盟友到了，吉安娜，你说的没错。全都变成效忠我的天灾战士吧。'),
(36954, 1, 0, 'zhCN', '我不会再犯同样的错误，希尔瓦娜斯。这次你走不了了，你们死后都会成为我的奴仆！'),
(36954, 2, 0, 'zhCN', '你们无路可逃！'),
(36954, 3, 0, 'zhCN', '屈服于死亡的严寒吧！'),
(36954, 4, 0, 'zhCN', '死路一条！'),
(36954, 5, 0, 'zhCN', '你们能抵挡多久？'),
(36954, 6, 0, 'zhCN', '苏醒吧，奴仆们。拦住他们。'),
(36954, 7, 0, 'zhCN', '奴仆们，抓住他们！带他们的尸体来见我！'),
(36954, 8, 0, 'zhCN', '阴冷的死亡等待着你。'),
(36954, 9, 0, 'zhCN', '穷途末路……变成我的奴仆吧！');

-- (Horde) Sky-Reaver Korm Blackscar 
DELETE FROM `creature_text` WHERE `CreatureID`=30824;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30824, 0, 0, 'FIRE! FIRE!', 14, 0, 100, 0, 0, 16732, 38681, 0, 'Sky-Reaver Korm Blackscar SAY_FIRE_HORDE'),
(30824, 1, 0, 'Get on board, now! This whole mountainside could collapse at any moment.', 14, 0, 100, 0, 0, 16733, 37212, 0, 'Sky-Reaver Korm Blackscar SAY_ONBOARD_HORDE');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=30824 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(30824, 0, 0, 'zhCN', '开火！开火！'),
(30824, 1, 0, 'zhCN', '立刻上船！快！这面山壁随时都可能塌陷。');

-- (Alliance) High Captain Justin Bartlett
DELETE FROM `creature_text` WHERE `CreatureID`=30344;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30344, 0, 0, 'FIRE! FIRE!', 14, 0, 100, 0, 0, 16721, 36993, 0, 'High Captain Justin Bartlett SAY_FIRE_ALLY'),
(30344, 1, 0, 'Quickly, climb aboard! We mustn\'t tarry here! There\'s no telling when this whole mountainside will collapse.', 14, 0, 100, 0, 0, 16722, 37213, 0, 'High Captain Justin Bartlett SAY_ONBOARD_ALLY');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=30344 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(30344, 0, 0, 'zhCN', '开火！开火！'),
(30344, 1, 0, 'zhCN', '快！立刻上船！此地不可久留，整面山壁随时都可能塌陷。');

-- Sylvanas (Part 2)
DELETE FROM `creature_text` WHERE `CreatureID`=37554;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `comment`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`) VALUES
(37554, 0, 0, 'He\'s... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do what I can do hold him in place while we flee.', 14, 'Sylvanas SAY_SYLVANA_AGGRO', 0, 100, 0, 0, 17058, 37168, 0),
(37554, 1, 0, 'No wall can hold the Banshee Queen. Keep the undead at bay, heroes. I will tear this barrier down!', 14, 'Sylvanas SAY_SYLVANA_WALL_01', 0, 100, 0, 0, 17029, 38540, 0),
(37554, 2, 0, 'Another barrier? Stand strong, champions. I will bring the wall down.', 14, 'Sylvanas SAY_SYLVANA_WALL_02', 0, 100, 0, 0, 17030, 38541, 0),
(37554, 3, 0, 'I grow tired of these games, Arthas! Your walls can\'t stop me!', 14, 'Sylvanas SAY_SYLVANA_WALL_03', 0, 100, 0, 0, 17031, 38542, 0),
(37554, 4, 0, 'You won\'t impede our escape, fiend! Keep the undead off me while I bring this barrier down.', 14, 'Sylvanas SAY_SYLVANA_WALL_04', 0, 100, 0, 0, 17032, 38543, 0),
(37554, 5, 0, 'There\'s an opening up ahead. GO NOW!', 14, 'Sylvanas SAY_SYLVANA_ESCAPE_01', 0, 100, 1, 0, 17059, 38551, 0),
(37554, 6, 0, 'We\'re almost there... Don\'t give up!', 14, 'Sylvanas SAY_SYLVANA_ESCAPE_02', 0, 100, 0, 0, 17060, 38538, 0),
(37554, 7, 0, 'BLASTED DEAD END! So this is how it ends. Prepare yourselves, heroes, for today we make our final stand!', 14, 'Sylvanas SAY_SYLVANA_TRAP', 0, 100, 5, 0, 17061, 37170, 0),
(37554, 8, 0, 'We are safe... for now. His strength has increased tenfold since our last battle. It will take a mighty army to destroy the Lich King. An army greater than even the Horde can rouse.', 14, 'Sylvanas SAY_SYLVANA_FINAL', 0, 100, 1, 0, 17062, 37171, 0);

DELETE FROM `creature_text_locale` WHERE `CreatureID`=37554 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(37554, 0, 0, 'zhCN', '他……太强大了。英雄们，快，快过来！我们必须马上离开！你们先走。我会尽全力挡住他。'),
(37554, 1, 0, 'zhCN', '没有墙壁能阻挡女妖之王。挡住那些亡灵，英雄们。我会粉碎这道屏障！'),
(37554, 2, 0, 'zhCN', '又是一道！坚持住，勇士们。我会粉碎这面冰墙。'),
(37554, 3, 0, 'zhCN', '我厌倦了你的把戏，阿尔萨斯！你的冰墙阻挡不了我！'),
(37554, 4, 0, 'zhCN', '你们这些恶魔拦不住我们！挡住那些亡灵，我在努力摧毁冰墙！'),
(37554, 5, 0, 'zhCN', '前面有个出口，赶快！'),
(37554, 6, 0, 'zhCN', '我们就要到了……不要放弃！'),
(37554, 7, 0, 'zhCN', '天杀的死路！看来真的无路可走了。准备战斗，英雄们，让我们放手一搏！'),
(37554, 8, 0, 'zhCN', '我们暂时……安全了。他的力量已经十倍于往昔。只有一支大军才能战胜巫妖王。单凭部落的力量毫无胜算。');

-- Jaina (Part 2)
DELETE FROM `creature_text` WHERE `CreatureID`=36955;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(36955, 0, 0, 'He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!', 14, 0, 100, 1, 0, 16644, 36821, 0, 'Jaina SAY_JAINA_AGGRO'),
(36955, 1, 0, 'I will destroy this barrier. You must hold the undead back!', 14, 0, 100, 0, 0, 16607, 38536, 0, 'Jaina SAY_JAINA_WALL_01'),
(36955, 2, 0, 'Another ice wall! Keep the undead from interrupting my incantations so that I may bring this wall down.', 14, 0, 100, 0, 0, 16608, 38537, 0, 'Jaina SAY_JAINA_WALL_02'),
(36955, 3, 0, 'We\'re almost there... Don\'t give up', 14, 0, 100, 0, 0, 16646, 38538, 0, 'Jaina SAY_JAINA_WALL_03'),
(36955, 4, 0, 'Your barriers can\'t hold us back much longer, monster! I will shatter them all!', 14, 0, 100, 0, 0, 16610, 38539, 0, 'Jaina SAY_JAINA_WALL_04'),
(36955, 5, 0, 'There\'s an opening up ahead. GO NOW!', 14, 0, 100, 1, 0, 16645, 38551, 0, 'Jaina SAY_JAINA_ESCAPE_01'),
(36955, 6, 0, 'It... It\'s a dead end. We have no choice but to fight. Steel yourselves, heroes, for this is our last stand!', 14, 0, 100, 1, 0, 16647, 36992, 0, 'Jaina SAY_JAINA_TRAP'),
(36955, 7, 0, 'Forgive me, heroes. I should have listened to Uther. I... I just had to see for myself. To look into his eyes one last time. I am sorry.', 14, 0, 100, 1, 0, 16648, 36990, 0, 'Jaina SAY_JAINA_FINAL_1'),
(36955, 8, 0, 'We now know what must be done. I will deliver this news to King Varian and Highlord Fordring.', 14, 0, 100, 1, 0, 16649, 36991, 0, 'Jaina SAY_JAINA_FINAL_2');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=36955 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(36955, 0, 0, 'zhCN', '太强大了。我们必须马上离开！我的魔法只能暂时拖住他。快来，英雄们！'),
(36955, 1, 0, 'zhCN', '我会摧毁这道屏障，但你必须挡住那些亡灵！'),
(36955, 2, 0, 'zhCN', '又是一道冰墙！不要让那些亡灵打断我的法术，这样我才能摧毁冰墙。'),
(36955, 3, 0, 'zhCN', '我们就要到了……不要放弃！'),
(36955, 4, 0, 'zhCN', '你的屏障挡不住我们，怪物！我会将它们全部粉碎！'),
(36955, 5, 0, 'zhCN', '前面有个出口，赶快！'),
(36955, 6, 0, 'zhCN', '这……这是死路！我们别无选择，只能战斗。准备迎战，英雄们，这是我们最后的阵地。'),
(36955, 7, 0, 'zhCN', '原谅我，英雄们。我应该听乌瑟尔的。我……我只是希望能够，能够看他最后一眼。对不起。'),
(36955, 8, 0, 'zhCN', '我们知道该怎么做了。我会把这个消息带给瓦里安国王和弗丁大人。');

-- Wave mobs - Ghostly Priest, Phantom Mage, Shadowy Mercenary, Spectral Footman, Tortured Rifleman
SET @PRIEST := 38175;
SET @MAGE := 38172;
SET @MERC := 38177;
SET @FOOTMAN := 38173;
SET @RIFLEMAN := 38176;

DELETE FROM `creature_text` WHERE `CreatureID` IN (@PRIEST, @MAGE, @MERC, @FOOTMAN, @RIFLEMAN);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@PRIEST, 0, 0, 'All serve the master in death.', 12, 0, 100, 0, 0, 0, 38527, 0, 'Priest SAY_WAVE_DEATH_1'),
(@PRIEST, 0, 1, 'Our souls will never be freed.', 12, 0, 100, 0, 0, 0, 38529, 0, 'Priest SAY_WAVE_DEATH_2'),
(@PRIEST, 0, 2, 'Our torment is eternal.', 12, 0, 100, 0, 0, 0, 38525, 0, 'Priest SAY_WAVE_DEATH_3'),
(@PRIEST, 0, 3, 'This is but a brief repose...', 12, 0, 100, 0, 0, 0, 38528, 0, 'Priest SAY_WAVE_DEATH_4'),
(@PRIEST, 0, 4, 'This is not our final rest.', 12, 0, 100, 0, 0, 0, 38526, 0, 'Priest SAY_WAVE_DEATH_5'),
(@MAGE, 0, 0, 'All serve the master in death.', 12, 0, 100, 0, 0, 0, 38527, 0, 'Mage SAY_WAVE_DEATH_1'),
(@MAGE, 0, 1, 'Our souls will never be freed.', 12, 0, 100, 0, 0, 0, 38529, 0, 'Mage SAY_WAVE_DEATH_2'),
(@MAGE, 0, 2, 'Our torment is eternal.', 12, 0, 100, 0, 0, 0, 38525, 0, 'Mage SAY_WAVE_DEATH_3'),
(@MAGE, 0, 3, 'This is but a brief repose...', 12, 0, 100, 0, 0, 0, 38528, 0, 'Mage SAY_WAVE_DEATH_4'),
(@MAGE, 0, 4, 'This is not our final rest.', 12, 0, 100, 0, 0, 0, 38526, 0, 'Mage SAY_WAVE_DEATH_5'),
(@MERC, 0, 0, 'All serve the master in death.', 12, 0, 100, 0, 0, 0, 38527, 0, 'Mercenary SAY_WAVE_DEATH_1'),
(@MERC, 0, 1, 'Our souls will never be freed.', 12, 0, 100, 0, 0, 0, 38529, 0, 'Mercenary SAY_WAVE_DEATH_2'),
(@MERC, 0, 2, 'Our torment is eternal.', 12, 0, 100, 0, 0, 0, 38525, 0, 'Mercenary SAY_WAVE_DEATH_3'),
(@MERC, 0, 3, 'This is but a brief repose...', 12, 0, 100, 0, 0, 0, 38528, 0, 'Mercenary SAY_WAVE_DEATH_4'),
(@MERC, 0, 4, 'This is not our final rest.', 12, 0, 100, 0, 0, 0, 38526, 0, 'Mercenary SAY_WAVE_DEATH_5'),
(@FOOTMAN, 0, 0, 'All serve the master in death.', 12, 0, 100, 0, 0, 0, 38527, 0, 'Footman SAY_WAVE_DEATH_1'),
(@FOOTMAN, 0, 1, 'Our souls will never be freed.', 12, 0, 100, 0, 0, 0, 38529, 0, 'Footman SAY_WAVE_DEATH_2'),
(@FOOTMAN, 0, 2, 'Our torment is eternal.', 12, 0, 100, 0, 0, 0, 38525, 0, 'Footman SAY_WAVE_DEATH_3'),
(@FOOTMAN, 0, 3, 'This is but a brief repose...', 12, 0, 100, 0, 0, 0, 38528, 0, 'Footman SAY_WAVE_DEATH_4'),
(@FOOTMAN, 0, 4, 'This is not our final rest.', 12, 0, 100, 0, 0, 0, 38526, 0, 'Footman SAY_WAVE_DEATH_5'),
(@RIFLEMAN, 0, 0, 'All serve the master in death.', 12, 0, 100, 0, 0, 0, 38527, 0, 'Rifleman SAY_WAVE_DEATH_1'),
(@RIFLEMAN, 0, 1, 'Our souls will never be freed.', 12, 0, 100, 0, 0, 0, 38529, 0, 'Rifleman SAY_WAVE_DEATH_2'),
(@RIFLEMAN, 0, 2, 'Our torment is eternal.', 12, 0, 100, 0, 0, 0, 38525, 0, 'Rifleman SAY_WAVE_DEATH_3'),
(@RIFLEMAN, 0, 3, 'This is but a brief repose...', 12, 0, 100, 0, 0, 0, 38528, 0, 'Rifleman SAY_WAVE_DEATH_4'),
(@RIFLEMAN, 0, 4, 'This is not our final rest.', 12, 0, 100, 0, 0, 0, 38526, 0, 'Rifleman SAY_WAVE_DEATH_5');

DELETE FROM `creature_text_locale` WHERE `CreatureID` IN (@PRIEST, @MAGE, @MERC, @FOOTMAN, @RIFLEMAN) AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(@PRIEST, 0, 0, 'zhCN', '死后仍为主人效命。'),
(@PRIEST, 0, 1, 'zhCN', '我们的灵魂将永无宁日。'),
(@PRIEST, 0, 2, 'zhCN', '我们永远无法摆脱折磨。'),
(@PRIEST, 0, 3, 'zhCN', '这只不过是暂时的休息…。'),
(@PRIEST, 0, 4, 'zhCN', '最终的胜利还没有到来。'),
(@MAGE, 0, 0, 'zhCN', '死后仍为主人效命。'),
(@MAGE, 0, 1, 'zhCN', '我们的灵魂将永无宁日。'),
(@MAGE, 0, 2, 'zhCN', '我们永远无法摆脱折磨。'),
(@MAGE, 0, 3, 'zhCN', '这只不过是暂时的休息…。'),
(@MAGE, 0, 4, 'zhCN', '最终的胜利还没有到来。'),
(@MERC, 0, 0, 'zhCN', '死后仍为主人效命。'),
(@MERC, 0, 1, 'zhCN', '我们的灵魂将永无宁日。'),
(@MERC, 0, 2, 'zhCN', '我们永远无法摆脱折磨。'),
(@MERC, 0, 3, 'zhCN', '这只不过是暂时的休息…。'),
(@MERC, 0, 4, 'zhCN', '最终的胜利还没有到来。'),
(@FOOTMAN, 0, 0, 'zhCN', '死后仍为主人效命。'),
(@FOOTMAN, 0, 1, 'zhCN', '我们的灵魂将永无宁日。'),
(@FOOTMAN, 0, 2, 'zhCN', '我们永远无法摆脱折磨。'),
(@FOOTMAN, 0, 3, 'zhCN', '这只不过是暂时的休息…。'),
(@FOOTMAN, 0, 4, 'zhCN', '最终的胜利还没有到来。'),
(@RIFLEMAN, 0, 0, 'zhCN', '死后仍为主人效命。'),
(@RIFLEMAN, 0, 1, 'zhCN', '我们的灵魂将永无宁日。'),
(@RIFLEMAN, 0, 2, 'zhCN', '我们永远无法摆脱折磨。'),
(@RIFLEMAN, 0, 3, 'zhCN', '这只不过是暂时的休息…。'),
(@RIFLEMAN, 0, 4, 'zhCN', '最终的胜利还没有到来。');
