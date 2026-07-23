-- DB update 2026_06_26_00 -> 2026_06_28_00
-- Issue #14141: add missing ruRU offer reward / request items text for quest 10324 (The Great Moongraze Hunt)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 10324 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(10324, 'ruRU', 'Чудесно! Ты становишься настоящим охотником, $N.$B$BХочешь выглядеть, как я? Почему бы и нет! Пока ты охотился, я сделал несколько предметов из оленьих шкур. Выбирай любой!', 0);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 10324 AND `locale` = 'ruRU';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(10324, 'ruRU', 'У маралов чрезвычайно прочные шкуры, хотя мясо очень жесткое – практически несъедобное. Но мы их применим для других целей.', 0);

-- Issue #14147: add missing ruRU offer reward / request items text for quest 1034 (The Ruins of Stardust). Hand-translated (wowhead has English fallback only).
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1034 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1034, 'ruRU', 'Ты добыл пыль! Я приготовлю из нее припарку – она должна сбить жар у Релары.$B$BЕще раз спасибо тебе, $N. Без твоей помощи моя дочь обязательно бы погибла.', 0);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 1034 AND `locale` = 'ruRU';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(1034, 'ruRU', 'Удалось ли тебе раздобыть морозную пыль, $N?', 0);

-- Issue #14148: add missing ruRU offer reward text for quest 1025 (An Aggressive Defense)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1025 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1025, 'ruRU', 'Славная работа, $N. Спасибо тебе.', 0);

-- Issue #14151: add missing ruRU offer reward text for quest 1070 (On Guard in Stonetalon)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1070 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1070, 'ruRU', 'А, так ты здесь по просьбе Тары из Ясеневого леса... я так скучаю по ней, по моей родине, по друзьям. Должно быть, ей хорошо среди часовых, раз прочие дела передает путникам. Я горжусь за нее.$B$BРада познакомиться с тобой, $N.', 0);

-- Issues #14153 / #14208: add missing ruRU offer reward text for quest 1071 (A Gnome\'s Respite)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1071 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1071, 'ruRU', 'Спасибо тебе за помощь, $N. Да и вернуться тебе удалось как раз вовремя.$B$BКажется, я выработал идеальный план... взрывчатка. Нет, это не сам план, это его часть.$B$BПонимаешь ли, я использую сильные взрывчатые вещества – не волнуйся, они далеко не так опасны, как считается – для того, чтобы припугнуть гоблинов. Я смогу как следует нагнать на них страху, разместив в ключевых местах на границах горной местности заряды, однако в ближайшие несколько дней мне может не хватить материалов...', 0);

-- Issue #14154: add missing ruRU offer reward text for quest 1056 (Journey to Stonetalon Peak)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1056 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1056, 'ruRU', 'Наконец-то! Вижу, Фальдреас прислушался к духам лесов...', 0);

-- Issue #14157: add missing ruRU offer reward / request items text for quest 377 (Crime and Punishment)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 377 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(377, 'ruRU', 'Так значит, Декстрен Вард наконец-то расплатился за свои преступления против человечества? Чем меньше швали, тем лучше, я так считаю. Хвала тебе, друг мой! Ты не только утешил семьи покойных, ты преподал наглядный урок продажным бюрократам из Благородных домов. Штормград должен прислушиваться к нашему голосу, или мы восстанем против его тирании.', 0);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 377 AND `locale` = 'ruRU';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(377, 'ruRU', 'Пока выродки вроде Декстрена Варда живут на этом свете, в мире нет места справедливости. Возвращайся, когда исполнишь приговор лорда Чернодрева. Тем самым мы утешим семьи покойных и – более того – преподадим урок Благородным домам.', 0);

-- Issue #14169: add missing ruRU offer reward text for quest 10428 (The Missing Fisherman)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 10428 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(10428, 'ruRU', 'Моя семья... Что я наделал... Но что я мог изменить?$B$BЗа что мне такие мучения?', 0);

-- Issue #14171: add missing ruRU offer reward text for quest 10366 (Jol)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 10366 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(10366, 'ruRU', 'Я давно тебя поджидаю, $N.$B$BТуллас превозносит тебя до небес, и я с радостью продолжу учить тебя пути Света. Я помогу тебе лучше разобраться в своих способностях и скрытом могуществе, когда ты будешь готов.', 0);

-- Issue #14173: add missing ruRU offer reward / request items text for quest 1026 (Search the Bole)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1026 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1026, 'ruRU', 'Я рада твоему возвращению, $N.', 0);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 1026 AND `locale` = 'ruRU';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(1026, 'ruRU', 'Меня беспокоит то, что древни подверглись порче. Хотелось бы мне побольше сделать для них.', 0);

-- Issue #14174: add missing ruRU offer reward / request items text for quest 1035 (Fallen Sky Lake)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1035 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1035, 'ruRU', 'О, $N, ты спас мою дочь! Я знаю, что сила лунного камня вернет моей дочери силы!$B$BМне никогда не отблагодарить тебя за все, что ты для меня сделал, но... пожалуйста, возьми вот это. После Релары это самое дорогое, что есть у меня.', 0);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 1035 AND `locale` = 'ruRU';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(1035, 'ruRU', 'Ты сразился с Чащобным Оракулом, $N? Если так, то дай мне, пожалуйста, лунный камень. Релара при последнем издыхании!', 0);

-- Issue #14179: add missing ruRU offer reward text for quest 1021 (Vile Satyr! Dryads in Danger!)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1021 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1021, 'ruRU', 'Судя по зияющей в боку ране, Анилия на грани смерти.', 0);

-- Issue #14184: add missing ruRU offer reward / request items text for quest 1011 (Forsaken Diseases)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1011 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1011, 'ruRU', 'Очень хорошо, $N. Теперь, когда я проанализирую содержимое бутыли, станут понятны цели Отрекшихся!', 0);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 1011 AND `locale` = 'ruRU';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(1011, 'ruRU', 'Ты нашел лагерь, $N? Добыл бутыль заразы?', 0);

-- Issue #14185: add missing ruRU offer reward text for quest 1022 (The Howling Vale)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1022 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1022, 'ruRU', 'Фолиант Мел\'Тандрис действует странным образом. События, которые он записывает, события, которые он показывает... Никто толком не понимает, почему он делает то, что делает.$B$BТем не менее, понятно, что предмет, который получила жрица Звездная Песня – эта коса Элуны – требует дальнейшего исследования.', 0);

-- Issue #14186: add missing ruRU offer reward / request items text for quest 1031 (The Branch of Cenarius)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1031 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1031, 'ruRU', 'Анилия умерла? Нет, этого не может быть! Кажется, только вчера мы вместе бегали и играли в лесах!$B$BСчастливые дни теперь миновали...', 0);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 1031 AND `locale` = 'ruRU';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(1031, 'ruRU', 'Ты нашел их? Что сказала Анилия? Где она?', 0);

-- Issue #14194: add missing ruRU offer reward text for quest 373 (The Unsent Letter)
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 373 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(373, 'ruRU', 'Эдвин ван Клиф, говорите? Я бы скорее ждал письма от своей покойной бабушки... Так это вы его убили? Извините, конечно, но я сильно удивлен. В молодые годы он был просто непревзойденным бойцом. Ну, дайте-ка взглянуть, что он мне там написал после стольких лет...$B$B*Барос рассматривает письмо.*$B$BЭх, Эдвин… годы не изменили тебя ни на каплю. Все такой же идеалист и романтик. Представляете, $N, ему было все равно, кому мстить. Месть попросту поглотила его. Но, кажется, я его понимаю…', 0);

-- Issue #14231: fix incorrect ruRU title (plural -> singular) and add missing offer reward / request items text for quest 1007 (The Ancient Statuette)
UPDATE `quest_template_locale` SET `Title` = 'Древняя статуэтка' WHERE `ID` = 1007 AND `locale` = 'ruRU';

DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 1007 AND `locale` = 'ruRU';
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1007, 'ruRU', 'Ты ее нашел! Спасибо тебе, $N!$B$BДревний город Зорам хранит неисчислимые тайны, и эта статуэтка может послужить ключом ко многим из них.', 0);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 1007 AND `locale` = 'ruRU';
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(1007, 'ruRU', 'Ты нашел статуэтку, $N?', 0);
