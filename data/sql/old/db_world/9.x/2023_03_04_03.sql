-- DB update 2023_03_04_02 -> 2023_03_04_03
-- Pit of Saron - Fix order, add missing creature_text and remove duplicates from original sniffs.
-- Forgemaster Garfrost 
DELETE FROM `creature_text` WHERE `CreatureID`=36494;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(36494, 0, 0, 'Tiny creatures under feet, you bring Garfrost something good to eat!', 14, 0, 100, 0, 0, 16912, 37218, 0, 'Forgemaster Garfrost SAY_AGGRO'),
(36494, 1, 0, 'Axe too weak. Garfrost make better and CRUSH YOU.', 14, 0, 100, 0, 0, 16916, 36445, 0, 'Forgemaster Garfrost SAY_HP_66'),
(36494, 2, 0, 'Garfrost tired of puny mortals. Now your bones will freeze!', 14, 0, 100, 0, 0, 16917, 36444, 0, 'Forgemaster Garfrost SAY_HP_33'),
(36494, 3, 0, 'Garfrost hope giant underpants clean. Save boss great shame. For later.', 14, 0, 100, 0, 0, 16915, 37221, 0, 'Forgemaster Garfrost SAY_DEATH'),
(36494, 4, 0, 'Will save for snack. For later.', 14, 0, 100, 0, 0, 16913, 37219, 0, 'Forgemaster Garfrost SAY_SLAY'),
(36494, 5, 0, 'That one maybe not so good to eat now. Stupid Garfrost! BAD! BAD!', 14, 0, 100, 0, 0, 16914, 37220, 0, 'Forgemaster Garfrost SAY_BOULDER_HIT'),
(36494, 6, 0, '%s hurls a massive saronite boulder at you!', 42, 0, 100, 0, 0, 0, 37438, 0, 'Forgemaster Garfrost WHISPER_BOULDER'),
(36494, 7, 0, '%s casts |cFF00AACCDeep Freeze|r at $n.', 41, 0, 100, 0, 0, 0, 37260, 0, 'Forgemaster Garfrost EMOTE_DEEP_FREEZE');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=36494 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(36494, 0, 0, 'zhCN', '看这些小东西，你给加弗斯特带来了好吃的！'),
(36494, 1, 0, 'zhCN', '斧子太弱了。看我弄好他，然后……然后砸扁你。'),
(36494, 2, 0, 'zhCN', '加弗斯特厌倦了这些凡人。刺骨的寒风刮起来！'),
(36494, 3, 0, 'zhCN', '加弗斯特不想弄的太狼狈。不想给头领丢脸。晚了。'),
(36494, 4, 0, 'zhCN', '可以留下来当个小点心。'),
(36494, 5, 0, 'zhCN', '这个好像不……不太好吃。加弗斯特真笨！真笨！'),
(36494, 6, 0, 'zhCN', '%s向你用力投出一大块萨隆邪铁巨石！'),
(36494, 7, 0, 'zhCN', '%s向$n施放|cFF00AACC深度冻结|r。');

-- Ick
DELETE FROM `creature_text` WHERE `CreatureID`=36476;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(36476, 0, 0, '%s begins to unleash a toxic poison cloud!', 41, 0, 100, 0, 0, 0, 36531, 0, 'Ick EMOTE_ICK_POISON_NOVA'),
(36476, 1, 0, '%s is chasing you. Run!', 41, 0, 100, 0, 0, 0, 36529, 0, 'Ick EMOTE_ICK_CHASE');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=36476 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(36476, 0, 0, 'zhCN', '%s开始释放一块毒云！'),
(36476, 1, 0, 'zhCN', '%s正在追赶你。快跑！');

-- Krick
DELETE FROM `creature_text` WHERE `CreatureID`=36477;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(36477, 0, 0, 'Our work must not be interrupted! Ick, take care of them!', 14, 0, 100, 0, 0, 16926, 37222, 0, 'Krick SAY_AGGRO'),
(36477, 1, 0, 'We could probably use these parts.', 14, 0, 100, 0, 0, 16927, 37223, 0, 'Krick SAY_SLAY_1'),
(36477, 1, 1, 'Arms and legs are in short supply! Thanks for your contribution!', 14, 0, 100, 0, 0, 16928, 37224, 0, 'Krick SAY_SLAY_2'),
(36477, 2, 0, 'Enough moving around! Hold still while I blow them all up!', 14, 0, 100, 0, 0, 16929, 36538, 0, 'Krick SAY_BARRAGE_1'),
(36477, 3, 0, '%s begins rapidly conjuring explosive mines!', 41, 0, 100, 0, 0, 0, 36550, 0, 'Krick SAY_BARRAGE_2'),
(36477, 4, 0, 'Quickly! Poison them all while they\'re still close!', 14, 0, 100, 0, 0, 16930, 36537, 0, 'Krick SAY_POISON_NOVA'),
(36477, 5, 0, 'No, that one! That one! Get that one!', 14, 0, 100, 0, 0, 16931, 36536, 0, 'Krick SAY_CHASE_1'),
(36477, 5, 1, 'I\'ve changed my mind, go get that one instead!', 14, 0, 100, 0, 0, 16932, 37225, 0, 'Krick SAY_CHASE_2'),
(36477, 5, 2, 'What are you attacking him for? The dangerous one is over there!', 14, 0, 100, 0, 0, 16933, 37226, 0, 'Krick SAY_CHASE_3'),
(36477, 6, 0, 'Wait! Stop! Don\'t kill me, please! I\'ll tell you everything!', 14, 0, 100, 0, 0, 16934, 36841, 0, 'Krick SAY_KRICK_OUTRO_1'),
(36477, 7, 0, 'What you seek is in the master\'s lair, but you must destroy Tyrannus to gain entry. Now, within the Halls of Reflection you will find Frostmourne. It... It holds the truth.', 14, 0, 100, 0, 0, 16935, 36842, 0, 'Krick SAY_KRICK_OUTRO_3'),
(36477, 8, 0, 'I swear it is true! Please, don\'t kill me!!', 14, 0, 100, 0, 0, 16936, 36843, 0, 'Krick SAY_KRICK_OUTRO_5'),
(36477, 9, 0, 'Urg... no!!', 14, 0, 100, 0, 0, 16937, 36844, 0, 'Krick SAY_KRICK_OUTRO_8');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=36477 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(36477, 0, 0, 'zhCN', '我们的工作绝不能被干扰！伊克，招呼他们！'),
(36477, 1, 0, 'zhCN', '这些部件也许对我们有用。'),
(36477, 1, 1, 'zhCN', '我们正缺胳膊和腿呢！感谢你们的大力援助！'),
(36477, 2, 0, 'zhCN', '不要乱动！站稳了，等我把他们都炸飞！'),
(36477, 3, 0, 'zhCN', '%s开始不断召唤出炸雷！'),
(36477, 4, 0, 'zhCN', '快点，趁他们在一起的时候上毒！'),
(36477, 5, 0, 'zhCN', '不，是那个！那个！就是他！'),
(36477, 5, 1, 'zhCN', '我改主意了，现在我要的是这个！'),
(36477, 5, 2, 'zhCN', '你打这个家伙干什么？真正危险的人在那儿，傻子！'),
(36477, 6, 0, 'zhCN', '等等！停！别杀我！我把一切都告诉你！'),
(36477, 7, 0, 'zhCN', '你要找的就在主人的巢穴里，但要先干掉泰兰努斯才能进去。霜之哀伤就在映像大厅里……你们……你们能在它那里找到真相。'),
(36477, 8, 0, 'zhCN', '我发誓我没说谎！求你了！别杀我！'),
(36477, 9, 0, 'zhCN', '啊…不！！');

-- Scourgelord Tyrannus
DELETE FROM `creature_text` WHERE `CreatureID`=36658;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(36658, 0, 0, 'Alas, brave, brave adventurers, your meddling has reached its end. Do you hear the clatter of bone and steel coming up the tunnel behind you? That is the sound of your impending demise.', 14, 0, 100, 0, 0, 16758, 37233, 0, 'Tyrannus SAY_BOSS_TYRANNUS_INTRO_1'),
(36658, 1, 0, 'Ha, such an amusing gesture from the rabble. When I have finished with you, my master\'s blade will feast upon your souls. Die.', 14, 0, 100, 0, 0, 16759, 37234, 0, 'Tyrannus SAY_BOSS_TYRANNUS_INTRO_2'),
(36658, 2, 0, 'I shall not fail the Lich King. Come and meet your end!', 14, 0, 100, 0, 0, 16760, 38718, 0, 'Tyrannus SAY_AGGRO'),
(36658, 3, 0, 'Such a shameful display. You are better off dead.', 14, 0, 100, 0, 0, 16761, 38715, 0, 'Tyrannus SAY_SLAY_1'),
(36658, 3, 1, 'Perhaps you should have stayed... in the mountains!', 14, 0, 100, 0, 0, 16762, 38716, 0, 'Tyrannus SAY_SLAY_2'),
(36658, 4, 0, 'Impossible.... Rimefang.... warn....', 14, 0, 100, 0, 0, 16763, 38714, 0, 'Tyrannus SAY_DEATH'),
(36658, 5, 0, 'Rimefang, destroy this fool!', 14, 0, 100, 0, 0, 16764, 36648, 0, 'Tyrannus SAY_MARK_RIMEFANG'),
(36658, 6, 0, 'The frostwyrm Rimefang gazes at $n and readies an icy attack!', 41, 0, 100, 0, 0, 0, 36649, 0, 'Tyrannus EMOTE_MARK_RIMEFANG'),
(36658, 7, 0, 'Power... overwhelming!', 14, 0, 100, 0, 0, 16765, 38717, 0, 'Tyrannus SAY_DARK_MIGHT'),
(36658, 8, 0, '%s roars and swells with dark might!', 41, 0, 100, 0, 0, 0, 36628, 0, 'Tyrannus EMOTE_DARK_MIGHT');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=36658 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(36658, 0, 0, 'zhCN', '唉，勇敢的冒险者，你们的路已经到头了。难道你们没有听到身后隧道里钢铁撞击的声音吗？那就是末日降临的乐章。'),
(36658, 1, 0, 'zhCN', '哈，一群不自量力的乌合之众。等我杀了你们之后，主人的剑就能尽情享用你们的灵魂了。去死吧。'),
(36658, 2, 0, 'zhCN', '我不会让巫妖王失望的。准备受死吧！'),
(36658, 3, 0, 'zhCN', '低劣的顽抗，死亡是对你的优待。'),
(36658, 3, 1, 'zhCN', '也许你早应该留在……群山里！'),
(36658, 4, 0, 'zhCN', '不可能……霜牙……警报……'),
(36658, 5, 0, 'zhCN', '霜牙，干掉那个蠢货！'),
(36658, 6, 0, 'zhCN', '冰霜巨龙霜牙凝视着$n，准备发动一次冰霜袭击！'),
(36658, 7, 0, 'zhCN', '力量……无上的力量！'),
(36658, 8, 0, 'zhCN', '%s发出怒吼，在黑暗力量的作用下开始膨胀！');

-- Rimefang - Delete "The frostwyrm Rimefang gazes at $n and readies an icy attack!", already being used by Scourgelord Tyrannus (6)
DELETE FROM `creature_text` WHERE `CreatureID`=36661;
DELETE FROM `creature_text_locale` WHERE `CreatureID`=36661 AND `Locale`='zhCN';

-- Scourgelord Tyrannus Voice
DELETE FROM `creature_text` WHERE `CreatureID`=36795;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(36795, 0, 0, 'Another shall take his place. You waste your time.', 14, 0, 100, 0, 0, 16752, 36765, 0, 'tyrannus SAY_TYRANNUS_GARFROST'),
(36795, 1, 0, 'Rimefang! Trap them within the tunnel! Bury them alive!', 14, 0, 100, 0, 0, 16757, 36714, 0, 'tyrannus SAY_TYRANNUS_TRAP_TUNNEL');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=36795 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(36795, 0, 0, 'zhCN', '别人会取代他。你是在浪费时间。'),
(36795, 1, 0, 'zhCN', '霜牙，把他们困在隧道里！统统给我埋了！');

-- Scourgelord Tyrannus Event
DELETE FROM `creature_text` WHERE `CreatureID`=36794;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(36794, 0, 0, 'Worthless gnat! Death is all that awaits you!', 14, 0, 100, 0, 0, 16753, 36852, 0, 'tyrannus SAY_TYRANNUS_KRICK_1'),
(36794, 1, 0, 'Do not think that I shall permit you entry into my master\'s sanctum so easily. Pursue me if you dare.', 14, 0, 100, 0, 0, 16754, 36853, 0, 'tyrannus SAY_TYRANNUS_KRICK_2'),
(36794, 2, 0, 'Your pursuit shall be in vain, intruders, for the Lich King has placed an army of undead at my command! Behold!', 14, 0, 100, 0, 0, 16755, 36708, 0, 'tyrannus SAY_TYRANNUS_AMBUSH_1'),
(36794, 3, 0, 'Persistent whelps! You will not reach the entrance of my lord\'s lair! Soldiers, destroy them!', 14, 0, 100, 0, 0, 16756, 36709, 0, 'tyrannus SAY_TYRANNUS_AMBUSH_2'),
(36794, 4, 0, 'Intruders have entered the master\'s domain. Signal the alarms!', 14, 0, 100, 0, 0, 16747, 37093, 0, 'tyrannus SAY_TYRANNUS_INTRO_1'),
(36794, 5, 0, 'Hrmph, fodder. Not even fit to labor in the quarry. Relish these final moments for soon you will be nothing more than mindless undead.', 14, 0, 100, 0, 0, 16748, 37094, 0, 'tyrannus SAY_TYRANNUS_INTRO_2'),
(36794, 6, 0, 'Your last waking memory will be of agonizing pain.', 14, 0, 100, 0, 0, 16749, 37095, 0, 'tyrannus SAY_TYRANNUS_INTRO_3'),
(36794, 7, 0, 'Minions, destroy these interlopers!', 14, 0, 100, 0, 0, 16751, 37096, 0, 'tyrannus SAY_TYRANNUS_INTRO_4');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=36794 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(36794, 0, 0, 'zhCN', '没用的虫子！死亡正等待着你！'),
(36794, 1, 0, 'zhCN', '不要以为我会那么容易让你进入主人的密室。有本事放马过来吧。'),
(36794, 2, 0, 'zhCN', '你们的努力是徒劳的，入侵者。巫妖王让我统率的可是一支亡灵大军！小心了！'),
(36794, 3, 0, 'zhCN', '固执的家伙！你们根本到不了主人的密室！士兵们，消灭他们！'),
(36794, 4, 0, 'zhCN', '入侵者进入了主人的领地。拉响警报！'),
(36794, 5, 0, 'zhCN', '哼，废物，就连在矿坑里作苦力都不配。享受最后的时刻吧。很快你们就会变成行尸走肉了。'),
(36794, 6, 0, 'zhCN', '你们最后的记忆将填满痛苦。'),
(36794, 7, 0, 'zhCN', '奴仆们，消灭那些闯入者！');

-- Sindragosa (NullCreature) - fix air walking
UPDATE `creature_template_movement` SET `Flight` = 2 WHERE `CreatureId` = 37755;
