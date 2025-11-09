-- Update ruRU ; from WowHead WOTLK
-- OLD name : Никудышный шаромыжник
-- Source : https://www.wowhead.com/wotlk/ru/npc=38
UPDATE `creature_template_locale` SET `Name` = 'Лиходей из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 38;
-- OLD name : Младший суккуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=49
UPDATE `creature_template_locale` SET `Name` = 'Малый суккуб' WHERE `locale` = 'ruRU' AND `entry` = 49;
-- OLD subname : Оружейник
-- Source : https://www.wowhead.com/wotlk/ru/npc=54
UPDATE `creature_template_locale` SET `Title` = 'Оружейница' WHERE `locale` = 'ruRU' AND `entry` = 54;
-- OLD name : Карманник
-- Source : https://www.wowhead.com/wotlk/ru/npc=94
UPDATE `creature_template_locale` SET `Name` = 'Карманник из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 94;
-- OLD name : Бандит
-- Source : https://www.wowhead.com/wotlk/ru/npc=116
UPDATE `creature_template_locale` SET `Name` = 'Бандит из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 116;
-- OLD name : Брог Мясорук
-- Source : https://www.wowhead.com/wotlk/ru/npc=151
UPDATE `creature_template_locale` SET `Name` = 'Брог Хэмфист' WHERE `locale` = 'ruRU' AND `entry` = 151;
-- OLD name : Хрупкокостный скелет
-- Source : https://www.wowhead.com/wotlk/ru/npc=201
UPDATE `creature_template_locale` SET `Name` = 'Хрупкий скелет' WHERE `locale` = 'ruRU' AND `entry` = 201;
-- OLD name : Гниющий ужас
-- Source : https://www.wowhead.com/wotlk/ru/npc=202
UPDATE `creature_template_locale` SET `Name` = 'Ужасный скелет' WHERE `locale` = 'ruRU' AND `entry` = 202;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=228
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 228;
-- OLD name : Unknown Evil Transform (do not translate)
-- Source : https://www.wowhead.com/wotlk/ru/npc=229
UPDATE `creature_template_locale` SET `Name` = 'Вайю' WHERE `locale` = 'ruRU' AND `entry` = 229;
-- OLD name : Thornton Fellwood, subname : Woodcrafter
-- Source : https://www.wowhead.com/wotlk/ru/npc=230
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 230;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (230, 'ruRU','Торнтон Хвористинка','Плотник');
-- OLD name : Маршал Гриан Камнегрив, subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=234
UPDATE `creature_template_locale` SET `Name` = 'Гриан Камнегрив',`Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 234;
-- OLD name : [DND] Wounded Lion's Footman
-- Source : https://www.wowhead.com/wotlk/ru/npc=262
UPDATE `creature_template_locale` SET `Name` = 'Обглоданный труп' WHERE `locale` = 'ruRU' AND `entry` = 262;
-- OLD name : Роул Дрегер
-- Source : https://www.wowhead.com/wotlk/ru/npc=269
UPDATE `creature_template_locale` SET `Name` = 'Роул Дрейгер' WHERE `locale` = 'ruRU' AND `entry` = 269;
-- OLD name : Виктор Призм’Антрас
-- Source : https://www.wowhead.com/wotlk/ru/npc=276
UPDATE `creature_template_locale` SET `Name` = 'Виктор Призм''Антрас' WHERE `locale` = 'ruRU' AND `entry` = 276;
-- OLD name : Трактирщик Фарли
-- Source : https://www.wowhead.com/wotlk/ru/npc=295
UPDATE `creature_template_locale` SET `Name` = 'Фарли' WHERE `locale` = 'ruRU' AND `entry` = 295;
-- OLD name : Молодой волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=299
UPDATE `creature_template_locale` SET `Name` = 'Больной молодой волк' WHERE `locale` = 'ruRU' AND `entry` = 299;
-- OLD name : Конь Скверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=304
UPDATE `creature_template_locale` SET `Name` = 'Скакун Скверны' WHERE `locale` = 'ruRU' AND `entry` = 304;
-- OLD name : Белый жеребец
-- Source : https://www.wowhead.com/wotlk/ru/npc=305
UPDATE `creature_template_locale` SET `Name` = 'Белый ездовой конь' WHERE `locale` = 'ruRU' AND `entry` = 305;
-- OLD name : "Buried Upside-Down" Vehicle
-- Source : https://www.wowhead.com/wotlk/ru/npc=309
UPDATE `creature_template_locale` SET `Name` = 'Труп Рольфа' WHERE `locale` = 'ruRU' AND `entry` = 309;
-- OLD name : Мазен МакНадир
-- Source : https://www.wowhead.com/wotlk/ru/npc=338
UPDATE `creature_template_locale` SET `Name` = 'Мазен Макнадир' WHERE `locale` = 'ruRU' AND `entry` = 338;
-- OLD name : Дарси Паркер, subname : Waitress
-- Source : https://www.wowhead.com/wotlk/ru/npc=379
UPDATE `creature_template_locale` SET `Name` = 'Дарси',`Title` = 'Официантка' WHERE `locale` = 'ruRU' AND `entry` = 379;
-- OLD name : Портовый начальник Барен
-- Source : https://www.wowhead.com/wotlk/ru/npc=381
UPDATE `creature_template_locale` SET `Name` = 'Начальник дока Барен' WHERE `locale` = 'ruRU' AND `entry` = 381;
-- OLD subname : Продавец рыбы и снастей
-- Source : https://www.wowhead.com/wotlk/ru/npc=383
UPDATE `creature_template_locale` SET `Title` = 'Торговец рыбой и снастями' WHERE `locale` = 'ruRU' AND `entry` = 383;
-- OLD subname : Коневод
-- Source : https://www.wowhead.com/wotlk/ru/npc=384
UPDATE `creature_template_locale` SET `Title` = 'Конезаводчица' WHERE `locale` = 'ruRU' AND `entry` = 384;
-- OLD name : Великий волхв Доан
-- Source : https://www.wowhead.com/wotlk/ru/npc=397
UPDATE `creature_template_locale` SET `Name` = 'Моргант' WHERE `locale` = 'ruRU' AND `entry` = 397;
-- OLD name : Младший демон Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=418
UPDATE `creature_template_locale` SET `Name` = 'Малый демон Бездны' WHERE `locale` = 'ruRU' AND `entry` = 418;
-- OLD name : Капитан стражи Паркер
-- Source : https://www.wowhead.com/wotlk/ru/npc=464
UPDATE `creature_template_locale` SET `Name` = 'Стражник Паркер' WHERE `locale` = 'ruRU' AND `entry` = 464;
-- OLD name : Плутоватый маг
-- Source : https://www.wowhead.com/wotlk/ru/npc=474
UPDATE `creature_template_locale` SET `Name` = 'Волшебник-плут из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 474;
-- OLD subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=487
UPDATE `creature_template_locale` SET `Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 487;
-- OLD name : Ткач-заступник, subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=488
UPDATE `creature_template_locale` SET `Name` = 'Заступник Вивер',`Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 488;
-- OLD subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=489
UPDATE `creature_template_locale` SET `Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 489;
-- OLD subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=490
UPDATE `creature_template_locale` SET `Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 490;
-- OLD name : Дозорный Кифэр
-- Source : https://www.wowhead.com/wotlk/ru/npc=495
UPDATE `creature_template_locale` SET `Name` = 'Дозорная Кифер' WHERE `locale` = 'ruRU' AND `entry` = 495;
-- OLD name : Тенеткач Ночной Погибели
-- Source : https://www.wowhead.com/wotlk/ru/npc=533
UPDATE `creature_template_locale` SET `Name` = 'Маг теней из стаи Ночной Погибели' WHERE `locale` = 'ruRU' AND `entry` = 533;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=543
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица' WHERE `locale` = 'ruRU' AND `entry` = 543;
-- OLD name : Душитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=583
UPDATE `creature_template_locale` SET `Name` = 'Душитель из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 583;
-- OLD name : Знахарь племени Кровавого Скальпа
-- Source : https://www.wowhead.com/wotlk/ru/npc=660
UPDATE `creature_template_locale` SET `Name` = 'Знахарь из племени Кровавого Скальпа' WHERE `locale` = 'ruRU' AND `entry` = 660;
-- OLD name : Тропический ловец
-- Source : https://www.wowhead.com/wotlk/ru/npc=687
UPDATE `creature_template_locale` SET `Name` = 'Хищник джунглей' WHERE `locale` = 'ruRU' AND `entry` = 687;
-- OLD name : Младший элементаль воды
-- Source : https://www.wowhead.com/wotlk/ru/npc=691
UPDATE `creature_template_locale` SET `Name` = 'Малый элементаль воды' WHERE `locale` = 'ruRU' AND `entry` = 691;
-- OLD name : Письмена, subname : Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=693
UPDATE `creature_template_locale` SET `Name` = 'Учитель вторичных умений',`Title` = 'Учитель' WHERE `locale` = 'ruRU' AND `entry` = 693;
-- OLD name : Генерал Фангор
-- Source : https://www.wowhead.com/wotlk/ru/npc=703
UPDATE `creature_template_locale` SET `Name` = 'Лейтенант Фангор' WHERE `locale` = 'ruRU' AND `entry` = 703;
-- OLD name : Тролль-подросток из племени Мерзлогривов
-- Source : https://www.wowhead.com/wotlk/ru/npc=706
UPDATE `creature_template_locale` SET `Name` = 'Молодой тролль из племени Мерзлогривов' WHERE `locale` = 'ruRU' AND `entry` = 706;
-- OLD name : Горный пехотинец Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=727
UPDATE `creature_template_locale` SET `Name` = 'Стальгорнский горный пехотинец' WHERE `locale` = 'ruRU' AND `entry` = 727;
-- OLD name : Ами Девенпорт
-- Source : https://www.wowhead.com/wotlk/ru/npc=777
UPDATE `creature_template_locale` SET `Name` = 'Эми Дэвенпорт' WHERE `locale` = 'ruRU' AND `entry` = 777;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=789
UPDATE `creature_template_locale` SET `Title` = 'Торговец стрелами' WHERE `locale` = 'ruRU' AND `entry` = 789;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=812
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 812;
-- OLD subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=820
UPDATE `creature_template_locale` SET `Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 820;
-- OLD subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=821
UPDATE `creature_template_locale` SET `Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 821;
-- OLD name : Сержант Виллем
-- Source : https://www.wowhead.com/wotlk/ru/npc=823
UPDATE `creature_template_locale` SET `Name` = 'Заместитель судьи Виллем' WHERE `locale` = 'ruRU' AND `entry` = 823;
-- OLD name : Освобожденный циклон
-- Source : https://www.wowhead.com/wotlk/ru/npc=832
UPDATE `creature_template_locale` SET `Name` = 'Пыледемон' WHERE `locale` = 'ruRU' AND `entry` = 832;
-- OLD name : Harl Cutter, subname : Woodcrafting Supplies
-- Source : https://www.wowhead.com/wotlk/ru/npc=841
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 841;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (841, 'ruRU','Лыко Вязз','Стройматериалы');
-- OLD name : Дух дикого волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=852
UPDATE `creature_template_locale` SET `Name` = 'Дух дикого зверя' WHERE `locale` = 'ruRU' AND `entry` = 852;
-- OLD name : Молодой тропический ловец
-- Source : https://www.wowhead.com/wotlk/ru/npc=854
UPDATE `creature_template_locale` SET `Name` = 'Молодой хищник джунглей' WHERE `locale` = 'ruRU' AND `entry` = 854;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=857
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 857;
-- OLD subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=869
UPDATE `creature_template_locale` SET `Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 869;
-- OLD subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=870
UPDATE `creature_template_locale` SET `Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 870;
-- OLD name : Воин племени Соленой Чешуи
-- Source : https://www.wowhead.com/wotlk/ru/npc=871
UPDATE `creature_template_locale` SET `Name` = 'Воин из племени Соленой Чешуи' WHERE `locale` = 'ruRU' AND `entry` = 871;
-- OLD name : Оракул племени Соленой Чешуи
-- Source : https://www.wowhead.com/wotlk/ru/npc=873
UPDATE `creature_template_locale` SET `Name` = 'Оракул из племени Соленой Чешуи' WHERE `locale` = 'ruRU' AND `entry` = 873;
-- OLD subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=874
UPDATE `creature_template_locale` SET `Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 874;
-- OLD subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=876
UPDATE `creature_template_locale` SET `Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 876;
-- OLD subname : Дружина Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=878
UPDATE `creature_template_locale` SET `Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 878;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=896
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 896;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=907
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 907;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=908
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 908;
-- OLD name : Андер Гермайн
-- Source : https://www.wowhead.com/wotlk/ru/npc=914
UPDATE `creature_template_locale` SET `Name` = 'Андер Жермен' WHERE `locale` = 'ruRU' AND `entry` = 914;
-- OLD name : Новобранец племени Мерзлогривов
-- Source : https://www.wowhead.com/wotlk/ru/npc=946
UPDATE `creature_template_locale` SET `Name` = 'Рекрут из племени Мерзлогривов' WHERE `locale` = 'ruRU' AND `entry` = 946;
-- OLD subname : Librarian
-- Source : https://www.wowhead.com/wotlk/ru/npc=951
UPDATE `creature_template_locale` SET `Title` = 'Библиотекарь' WHERE `locale` = 'ruRU' AND `entry` = 951;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=954
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 954;
-- OLD name : Эрик Додз Третий
-- Source : https://www.wowhead.com/wotlk/ru/npc=996
UPDATE `creature_template_locale` SET `Name` = 'Мастер-портной' WHERE `locale` = 'ruRU' AND `entry` = 996;
-- OLD name : Неубиваемый тестовый манекен, subname : NONE
-- Source : https://www.wowhead.com/wotlk/ru/npc=1000
UPDATE `creature_template_locale` SET `Name` = 'Дозорный Бломберг',`Title` = 'Ночной дозор' WHERE `locale` = 'ruRU' AND `entry` = 1000;
-- OLD name : Оракул из племени Синежабров
-- Source : https://www.wowhead.com/wotlk/ru/npc=1029
UPDATE `creature_template_locale` SET `Name` = 'Оракул из племени Синежабрых' WHERE `locale` = 'ruRU' AND `entry` = 1029;
-- OLD name : Военачальник клана Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=1037
UPDATE `creature_template_locale` SET `Name` = 'Военачальница клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 1037;
-- OLD name : Хранитель теней из клана Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=1038
UPDATE `creature_template_locale` SET `Name` = 'Хранительница теней из клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 1038;
-- OLD name : Саботажник из клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=1052
UPDATE `creature_template_locale` SET `Name` = 'Диверсант из клана Черного Железа' WHERE `locale` = 'ruRU' AND `entry` = 1052;
-- OLD name : Рубака Гром'гола
-- Source : https://www.wowhead.com/wotlk/ru/npc=1064
UPDATE `creature_template_locale` SET `Name` = 'Рубака из лагеря Гром''гол' WHERE `locale` = 'ruRU' AND `entry` = 1064;
-- OLD name : Горилла Мглистой долины
-- Source : https://www.wowhead.com/wotlk/ru/npc=1108
UPDATE `creature_template_locale` SET `Name` = 'Горилла из Мглистой долины' WHERE `locale` = 'ruRU' AND `entry` = 1108;
-- OLD name : Темный чародей племени Мерзлогривов
-- Source : https://www.wowhead.com/wotlk/ru/npc=1124
UPDATE `creature_template_locale` SET `Name` = 'Темный чародей из племени Мерзлогривов' WHERE `locale` = 'ruRU' AND `entry` = 1124;
-- OLD name : Черный медведь
-- Source : https://www.wowhead.com/wotlk/ru/npc=1186
UPDATE `creature_template_locale` SET `Name` = 'Старый черный медведь' WHERE `locale` = 'ruRU' AND `entry` = 1186;
-- OLD name : Дерил Юный
-- Source : https://www.wowhead.com/wotlk/ru/npc=1187
UPDATE `creature_template_locale` SET `Name` = 'Дэрил Юный' WHERE `locale` = 'ruRU' AND `entry` = 1187;
-- OLD name : Скрежетун
-- Source : https://www.wowhead.com/wotlk/ru/npc=1206
UPDATE `creature_template_locale` SET `Name` = 'Костеглод' WHERE `locale` = 'ruRU' AND `entry` = 1206;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=1213
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 1213;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=1218
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 1218;
-- OLD name : Трактирщик Белм
-- Source : https://www.wowhead.com/wotlk/ru/npc=1247
UPDATE `creature_template_locale` SET `Name` = 'Белм' WHERE `locale` = 'ruRU' AND `entry` = 1247;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=1249
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 1249;
-- OLD name : Белый баран Х
-- Source : https://www.wowhead.com/wotlk/ru/npc=1262
UPDATE `creature_template_locale` SET `Name` = 'Белый баран' WHERE `locale` = 'ruRU' AND `entry` = 1262;
-- OLD subname : Торговец оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=1287
UPDATE `creature_template_locale` SET `Title` = 'Торговка оружием' WHERE `locale` = 'ruRU' AND `entry` = 1287;
-- OLD name : Карла Гренжер, subname : Торговец тканевыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=1291
UPDATE `creature_template_locale` SET `Name` = 'Карла Грейнджер',`Title` = 'Торговка тканевыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 1291;
-- OLD name : Мариса Гренжер, subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=1292
UPDATE `creature_template_locale` SET `Name` = 'Мариса Грейнджер',`Title` = 'Учительница снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 1292;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=1295
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 1295;
-- OLD subname : Торговец луками и ружьями
-- Source : https://www.wowhead.com/wotlk/ru/npc=1297
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками и ружьями' WHERE `locale` = 'ruRU' AND `entry` = 1297;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=1298
UPDATE `creature_template_locale` SET `Title` = 'Торговец луками и стрелами' WHERE `locale` = 'ruRU' AND `entry` = 1298;
-- OLD subname : Торговец одеждой
-- Source : https://www.wowhead.com/wotlk/ru/npc=1299
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеждой' WHERE `locale` = 'ruRU' AND `entry` = 1299;
-- OLD subname : Продавец алкогольных напитков
-- Source : https://www.wowhead.com/wotlk/ru/npc=1301
UPDATE `creature_template_locale` SET `Title` = 'Торговка алкогольными напитками' WHERE `locale` = 'ruRU' AND `entry` = 1301;
-- OLD subname : Торговец одеяниями
-- Source : https://www.wowhead.com/wotlk/ru/npc=1309
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеяниями' WHERE `locale` = 'ruRU' AND `entry` = 1309;
-- OLD subname : Продавец сумок
-- Source : https://www.wowhead.com/wotlk/ru/npc=1321
UPDATE `creature_template_locale` SET `Title` = 'Торговка сумками' WHERE `locale` = 'ruRU' AND `entry` = 1321;
-- OLD subname : Торговец ядами
-- Source : https://www.wowhead.com/wotlk/ru/npc=1326
UPDATE `creature_template_locale` SET `Title` = 'Торговка ядами' WHERE `locale` = 'ruRU' AND `entry` = 1326;
-- OLD name : Август Мюлейн
-- Source : https://www.wowhead.com/wotlk/ru/npc=1349
UPDATE `creature_template_locale` SET `Name` = 'Огюст Мулен' WHERE `locale` = 'ruRU' AND `entry` = 1349;
-- OLD name : Тереза Мюлейн, subname : Торговец одеяниями
-- Source : https://www.wowhead.com/wotlk/ru/npc=1350
UPDATE `creature_template_locale` SET `Name` = 'Тереза Мулен',`Title` = 'Торговка одеяниями' WHERE `locale` = 'ruRU' AND `entry` = 1350;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=1382
UPDATE `creature_template_locale` SET `Title` = 'Опытный повар' WHERE `locale` = 'ruRU' AND `entry` = 1382;
-- OLD name : Ясновидец племени Мерзлогривов
-- Source : https://www.wowhead.com/wotlk/ru/npc=1397
UPDATE `creature_template_locale` SET `Name` = 'Провидец из племени Мерзлогривов' WHERE `locale` = 'ruRU' AND `entry` = 1397;
-- OLD subname : Торговец легкими доспехами и оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=1407
UPDATE `creature_template_locale` SET `Title` = 'Торговка легкими доспехами и оружием' WHERE `locale` = 'ruRU' AND `entry` = 1407;
-- OLD name : Кровостраж из клана Огнекрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=1410
UPDATE `creature_template_locale` SET `Name` = 'Кровавый страж из армии Огнекрылых' WHERE `locale` = 'ruRU' AND `entry` = 1410;
-- OLD name : Кубб
-- Source : https://www.wowhead.com/wotlk/ru/npc=1425
UPDATE `creature_template_locale` SET `Name` = 'Гризлак' WHERE `locale` = 'ruRU' AND `entry` = 1425;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=1430
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 1430;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=1459
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 1459;
-- OLD subname : Коневод
-- Source : https://www.wowhead.com/wotlk/ru/npc=1460
UPDATE `creature_template_locale` SET `Title` = 'Конезаводчик' WHERE `locale` = 'ruRU' AND `entry` = 1460;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=1462
UPDATE `creature_template_locale` SET `Title` = 'Торговец стрелами' WHERE `locale` = 'ruRU' AND `entry` = 1462;
-- OLD name : Трактирщик Хелбрек
-- Source : https://www.wowhead.com/wotlk/ru/npc=1464
UPDATE `creature_template_locale` SET `Name` = 'Хелбрек' WHERE `locale` = 'ruRU' AND `entry` = 1464;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=1473
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 1473;
-- OLD subname : Капитан "Девичьей Чести"
-- Source : https://www.wowhead.com/wotlk/ru/npc=1481
UPDATE `creature_template_locale` SET `Title` = 'Капитан "Девичьей Добродетели"' WHERE `locale` = 'ruRU' AND `entry` = 1481;
-- OLD name : Мок'раш Колун
-- Source : https://www.wowhead.com/wotlk/ru/npc=1493
UPDATE `creature_template_locale` SET `Name` = 'Мок''раш' WHERE `locale` = 'ruRU' AND `entry` = 1493;
-- OLD name : Страж смерти Линнея
-- Source : https://www.wowhead.com/wotlk/ru/npc=1495
UPDATE `creature_template_locale` SET `Name` = 'Стражница смерти Линнея' WHERE `locale` = 'ruRU' AND `entry` = 1495;
-- OLD name : Новообращенный Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=1506
UPDATE `creature_template_locale` SET `Name` = 'Новообращенный из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 1506;
-- OLD name : Мрачноокий скелет-заклинатель
-- Source : https://www.wowhead.com/wotlk/ru/npc=1522
UPDATE `creature_template_locale` SET `Name` = 'Мрачноокий заклинатель костей' WHERE `locale` = 'ruRU' AND `entry` = 1522;
-- OLD name : Ревнитель Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=1537
UPDATE `creature_template_locale` SET `Name` = 'Ревнитель из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 1537;
-- OLD name : Старая горилла Мглистой долины
-- Source : https://www.wowhead.com/wotlk/ru/npc=1557
UPDATE `creature_template_locale` SET `Name` = 'Старая горилла из Мглистой долины' WHERE `locale` = 'ruRU' AND `entry` = 1557;
-- OLD name : Жрец Тени Сарвис
-- Source : https://www.wowhead.com/wotlk/ru/npc=1569
UPDATE `creature_template_locale` SET `Name` = 'Жрец Тьмы Сарвис' WHERE `locale` = 'ruRU' AND `entry` = 1569;
-- OLD name : Тест разбойник
-- Source : https://www.wowhead.com/wotlk/ru/npc=1601
UPDATE `creature_template_locale` SET `Name` = 'Rogue 40' WHERE `locale` = 'ruRU' AND `entry` = 1601;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=1632
UPDATE `creature_template_locale` SET `Title` = 'Учительница кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 1632;
-- OLD name : Тармен Агамонд
-- Source : https://www.wowhead.com/wotlk/ru/npc=1656
UPDATE `creature_template_locale` SET `Name` = 'Турман Агамонд' WHERE `locale` = 'ruRU' AND `entry` = 1656;
-- OLD subname : Ружейник
-- Source : https://www.wowhead.com/wotlk/ru/npc=1686
UPDATE `creature_template_locale` SET `Title` = 'Ружейница' WHERE `locale` = 'ruRU' AND `entry` = 1686;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=1695
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 1695;
-- OLD name : Узник
-- Source : https://www.wowhead.com/wotlk/ru/npc=1706
UPDATE `creature_template_locale` SET `Name` = 'Узник из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 1706;
-- OLD name : Каторжник
-- Source : https://www.wowhead.com/wotlk/ru/npc=1711
UPDATE `creature_template_locale` SET `Name` = 'Каторжник из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 1711;
-- OLD name : Мятежник
-- Source : https://www.wowhead.com/wotlk/ru/npc=1715
UPDATE `creature_template_locale` SET `Name` = 'Мятежник из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 1715;
-- OLD name : Житель Штормграда
-- Source : https://www.wowhead.com/wotlk/ru/npc=1723
UPDATE `creature_template_locale` SET `Name` = 'Жительница Штормграда' WHERE `locale` = 'ruRU' AND `entry` = 1723;
-- OLD name : Ветроплет из Братства Справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=1732
UPDATE `creature_template_locale` SET `Name` = 'Заклинатель штормов из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 1732;
-- OLD name : Великий дух дикого волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=1764
UPDATE `creature_template_locale` SET `Name` = 'Великий дух дикого зверя' WHERE `locale` = 'ruRU' AND `entry` = 1764;
-- OLD name : Бешеный ворг
-- Source : https://www.wowhead.com/wotlk/ru/npc=1766
UPDATE `creature_template_locale` SET `Name` = 'Крапчатый ворг' WHERE `locale` = 'ruRU' AND `entry` = 1766;
-- OLD name : Мшистый ползун
-- Source : https://www.wowhead.com/wotlk/ru/npc=1781
UPDATE `creature_template_locale` SET `Name` = 'Мглистый ползун' WHERE `locale` = 'ruRU' AND `entry` = 1781;
-- OLD name : Гигантский бешеный медведь
-- Source : https://www.wowhead.com/wotlk/ru/npc=1797
UPDATE `creature_template_locale` SET `Name` = 'Гигантский седой медведь' WHERE `locale` = 'ruRU' AND `entry` = 1797;
-- OLD name : Призыватель духов из Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=1835
UPDATE `creature_template_locale` SET `Name` = 'Призыватель из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 1835;
-- OLD name : Рабочий Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=1883
UPDATE `creature_template_locale` SET `Name` = 'Рабочий из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 1883;
-- OLD name : Дозорный Янтарной мельницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=1888
UPDATE `creature_template_locale` SET `Name` = 'Даларанский дозорный' WHERE `locale` = 'ruRU' AND `entry` = 1888;
-- OLD name : Волшебник Янтарной мельницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=1889
UPDATE `creature_template_locale` SET `Name` = 'Даларанский волшебник' WHERE `locale` = 'ruRU' AND `entry` = 1889;
-- OLD name : Заступник Янтарной мельницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=1912
UPDATE `creature_template_locale` SET `Name` = 'Даларанский заступник' WHERE `locale` = 'ruRU' AND `entry` = 1912;
-- OLD name : Тюремщик Янтарной мельницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=1913
UPDATE `creature_template_locale` SET `Name` = 'Даларанский тюремщик' WHERE `locale` = 'ruRU' AND `entry` = 1913;
-- OLD name : Магистр Янтарной мельницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=1914
UPDATE `creature_template_locale` SET `Name` = 'Даларанский маг' WHERE `locale` = 'ruRU' AND `entry` = 1914;
-- OLD name : Колдун Янтарной мельницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=1915
UPDATE `creature_template_locale` SET `Name` = 'Даларанский окудник' WHERE `locale` = 'ruRU' AND `entry` = 1915;
-- OLD name : Чарокнижник Янтарной мельницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=1920
UPDATE `creature_template_locale` SET `Name` = 'Даларанский чарокнижник' WHERE `locale` = 'ruRU' AND `entry` = 1920;
-- OLD name : Чащобный ядозуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=1999
UPDATE `creature_template_locale` SET `Name` = 'Чащобный ядовитый паук' WHERE `locale` = 'ruRU' AND `entry` = 1999;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=2046
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 2046;
-- OLD name : Опытный аптекарь Фаранелл
-- Source : https://www.wowhead.com/wotlk/ru/npc=2055
UPDATE `creature_template_locale` SET `Name` = 'Мастер-аптекарь Фаранелл' WHERE `locale` = 'ruRU' AND `entry` = 2055;
-- OLD name : Малорослый лунопард
-- Source : https://www.wowhead.com/wotlk/ru/npc=2070
UPDATE `creature_template_locale` SET `Name` = 'Малый лунопард' WHERE `locale` = 'ruRU' AND `entry` = 2070;
-- OLD name : Илталайн
-- Source : https://www.wowhead.com/wotlk/ru/npc=2079
UPDATE `creature_template_locale` SET `Name` = 'Опекун Илталайн' WHERE `locale` = 'ruRU' AND `entry` = 2079;
-- OLD name : Член команды "Девичьей Чести"
-- Source : https://www.wowhead.com/wotlk/ru/npc=2099
UPDATE `creature_template_locale` SET `Name` = 'Член команды "Девичьей Добродетели"' WHERE `locale` = 'ruRU' AND `entry` = 2099;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=2114
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 2114;
-- OLD name : Темный жрец Алистер
-- Source : https://www.wowhead.com/wotlk/ru/npc=2121
UPDATE `creature_template_locale` SET `Name` = 'Жрец Тьмы Алистер' WHERE `locale` = 'ruRU' AND `entry` = 2121;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=2132
UPDATE `creature_template_locale` SET `Title` = 'Учительница алхимии' WHERE `locale` = 'ruRU' AND `entry` = 2132;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=2137
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 2137;
-- OLD name : Проклятый высокорожденный
-- Source : https://www.wowhead.com/wotlk/ru/npc=2176
UPDATE `creature_template_locale` SET `Name` = 'Проклятая высокорожденная' WHERE `locale` = 'ruRU' AND `entry` = 2176;
-- OLD name : Крепкозуб Темных берегов
-- Source : https://www.wowhead.com/wotlk/ru/npc=2185
UPDATE `creature_template_locale` SET `Name` = 'Крепкозуб c Темных берегов' WHERE `locale` = 'ruRU' AND `entry` = 2185;
-- OLD name : Старый крепкозуб Темных берегов
-- Source : https://www.wowhead.com/wotlk/ru/npc=2187
UPDATE `creature_template_locale` SET `Name` = 'Старый крепкозуб c Темных берегов' WHERE `locale` = 'ruRU' AND `entry` = 2187;
-- OLD name : Страж смерти Ройанна
-- Source : https://www.wowhead.com/wotlk/ru/npc=2210
UPDATE `creature_template_locale` SET `Name` = 'Стражница смерти Ройанна' WHERE `locale` = 'ruRU' AND `entry` = 2210;
-- OLD name : Преступник Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2240
UPDATE `creature_template_locale` SET `Name` = 'Преступник из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2240;
-- OLD name : Вор Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2241
UPDATE `creature_template_locale` SET `Name` = 'Вор из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2241;
-- OLD name : Шпион Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2242
UPDATE `creature_template_locale` SET `Name` = 'Шпион из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2242;
-- OLD name : Караульный Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2243
UPDATE `creature_template_locale` SET `Name` = 'Караульный из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2243;
-- OLD name : Темный маг Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2244
UPDATE `creature_template_locale` SET `Name` = 'Темный маг из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2244;
-- OLD name : Саботажник Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2245
UPDATE `creature_template_locale` SET `Name` = 'Саботажник из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2245;
-- OLD name : Головорез Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2247
UPDATE `creature_template_locale` SET `Name` = 'Головорез из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2247;
-- OLD name : Маггаррак
-- Source : https://www.wowhead.com/wotlk/ru/npc=2258
UPDATE `creature_template_locale` SET `Name` = 'Каменная Ярость' WHERE `locale` = 'ruRU' AND `entry` = 2258;
-- OLD name : Разбойник Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2260
UPDATE `creature_template_locale` SET `Name` = 'Разбойник из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2260;
-- OLD name : Сторож Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2261
UPDATE `creature_template_locale` SET `Name` = 'Сторож из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2261;
-- OLD name : Bow Guy
-- Source : https://www.wowhead.com/wotlk/ru/npc=2286
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 2286;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2286, 'ruRU','Лучник',NULL);
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=2302
UPDATE `creature_template_locale` SET `Title` = 'Военачальница ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 2302;
-- OLD name : Волшебник Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2319
UPDATE `creature_template_locale` SET `Name` = 'Волшебник из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2319;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=2326
UPDATE `creature_template_locale` SET `Title` = 'Врач' WHERE `locale` = 'ruRU' AND `entry` = 2326;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=2327
UPDATE `creature_template_locale` SET `Title` = 'Учительница первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 2327;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=2329
UPDATE `creature_template_locale` SET `Title` = 'Врач' WHERE `locale` = 'ruRU' AND `entry` = 2329;
-- OLD name : Ружейник Дун Гарока
-- Source : https://www.wowhead.com/wotlk/ru/npc=2345
UPDATE `creature_template_locale` SET `Name` = 'Ружейник из Дун Гарока' WHERE `locale` = 'ruRU' AND `entry` = 2345;
-- OLD name : Одомашненный ползун
-- Source : https://www.wowhead.com/wotlk/ru/npc=2349
UPDATE `creature_template_locale` SET `Name` = 'Гигантский моховой ползун' WHERE `locale` = 'ruRU' AND `entry` = 2349;
-- OLD name : Лесной ползун
-- Source : https://www.wowhead.com/wotlk/ru/npc=2350
UPDATE `creature_template_locale` SET `Name` = 'Лесной моховой ползун' WHERE `locale` = 'ruRU' AND `entry` = 2350;
-- OLD name : Гнилостный медведь
-- Source : https://www.wowhead.com/wotlk/ru/npc=2351
UPDATE `creature_template_locale` SET `Name` = 'Серый медведь' WHERE `locale` = 'ruRU' AND `entry` = 2351;
-- OLD name : Трактирщик Андерсон
-- Source : https://www.wowhead.com/wotlk/ru/npc=2352
UPDATE `creature_template_locale` SET `Name` = 'Андерсон' WHERE `locale` = 'ruRU' AND `entry` = 2352;
-- OLD subname : Коневод
-- Source : https://www.wowhead.com/wotlk/ru/npc=2357
UPDATE `creature_template_locale` SET `Title` = 'Конезаводчица' WHERE `locale` = 'ruRU' AND `entry` = 2357;
-- OLD name : Волнолов из племени Порванного Плавника
-- Source : https://www.wowhead.com/wotlk/ru/npc=2377
UPDATE `creature_template_locale` SET `Name` = 'Волнолов из племени Рваного Плавника' WHERE `locale` = 'ruRU' AND `entry` = 2377;
-- OLD name : Охотник предгорий
-- Source : https://www.wowhead.com/wotlk/ru/npc=2385
UPDATE `creature_template_locale` SET `Name` = 'Яростный горный лев' WHERE `locale` = 'ruRU' AND `entry` = 2385;
-- OLD name : Стражник Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=2386
UPDATE `creature_template_locale` SET `Name` = 'Стражник Южнобережья' WHERE `locale` = 'ruRU' AND `entry` = 2386;
-- OLD name : Трактирщик Шай
-- Source : https://www.wowhead.com/wotlk/ru/npc=2388
UPDATE `creature_template_locale` SET `Name` = 'Шай' WHERE `locale` = 'ruRU' AND `entry` = 2388;
-- OLD subname : Дрессировщик нетопырей
-- Source : https://www.wowhead.com/wotlk/ru/npc=2389
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица нетопырей' WHERE `locale` = 'ruRU' AND `entry` = 2389;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=2390
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 2390;
-- OLD name : Дерил Стак
-- Source : https://www.wowhead.com/wotlk/ru/npc=2399
UPDATE `creature_template_locale` SET `Name` = 'Дэрил Стак' WHERE `locale` = 'ruRU' AND `entry` = 2399;
-- OLD name : Страж смерти Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=2405
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 2405;
-- OLD name : Страж смерти Самс
-- Source : https://www.wowhead.com/wotlk/ru/npc=2418
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти Замза' WHERE `locale` = 'ruRU' AND `entry` = 2418;
-- OLD name : Банкир гильдии, subname : Банкир гильдии
-- Source : https://www.wowhead.com/wotlk/ru/npc=2424
UPDATE `creature_template_locale` SET `Name` = 'Гильдейский банкир',`Title` = 'Гильдейский банкир' WHERE `locale` = 'ruRU' AND `entry` = 2424;
-- OLD name : Вариматас
-- Source : https://www.wowhead.com/wotlk/ru/npc=2425
UPDATE `creature_template_locale` SET `Name` = 'Вариматрас' WHERE `locale` = 'ruRU' AND `entry` = 2425;
-- OLD name : Гош-Халдир
-- Source : https://www.wowhead.com/wotlk/ru/npc=2476
UPDATE `creature_template_locale` SET `Name` = 'Большой озерный кроколиск' WHERE `locale` = 'ruRU' AND `entry` = 2476;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=2489
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 2489;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=2492
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 2492;
-- OLD subname : Посланник Занзила
-- Source : https://www.wowhead.com/wotlk/ru/npc=2530
UPDATE `creature_template_locale` SET `Title` = 'Заложник из племени Черного Копья' WHERE `locale` = 'ruRU' AND `entry` = 2530;
-- OLD name : Прислужник Доана
-- Source : https://www.wowhead.com/wotlk/ru/npc=2531
UPDATE `creature_template_locale` SET `Name` = 'Прислужник Морганта' WHERE `locale` = 'ruRU' AND `entry` = 2531;
-- OLD name : Змей Янтарной мельницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=2540
UPDATE `creature_template_locale` SET `Name` = 'Даларанский змей' WHERE `locale` = 'ruRU' AND `entry` = 2540;
-- OLD name : Верховный маг Ансарем Руноплет
-- Source : https://www.wowhead.com/wotlk/ru/npc=2543
UPDATE `creature_template_locale` SET `Name` = 'Верховный маг Ансарем Руномант' WHERE `locale` = 'ruRU' AND `entry` = 2543;
-- OLD name : Долгоног нагорья
-- Source : https://www.wowhead.com/wotlk/ru/npc=2559
UPDATE `creature_template_locale` SET `Name` = 'Ящер с нагорья Арати' WHERE `locale` = 'ruRU' AND `entry` = 2559;
-- OLD name : Волхв клана Тяжелого Кулака
-- Source : https://www.wowhead.com/wotlk/ru/npc=2567
UPDATE `creature_template_locale` SET `Name` = 'Волхв из клана Тяжелого Кулака' WHERE `locale` = 'ruRU' AND `entry` = 2567;
-- OLD name : Шаман клана Тяжелого Кулака
-- Source : https://www.wowhead.com/wotlk/ru/npc=2570
UPDATE `creature_template_locale` SET `Name` = 'Шаман из клана Тяжелого Кулака' WHERE `locale` = 'ruRU' AND `entry` = 2570;
-- OLD name : Ополченец усадьбы Дабири
-- Source : https://www.wowhead.com/wotlk/ru/npc=2581
UPDATE `creature_template_locale` SET `Name` = 'Ополченец из усадьбы Дабири' WHERE `locale` = 'ruRU' AND `entry` = 2581;
-- OLD name : Стромгардский солдат
-- Source : https://www.wowhead.com/wotlk/ru/npc=2585
UPDATE `creature_template_locale` SET `Name` = 'Стромгардский воздаятель' WHERE `locale` = 'ruRU' AND `entry` = 2585;
-- OLD name : Проходимец Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2586
UPDATE `creature_template_locale` SET `Name` = 'Проходимец из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2586;
-- OLD name : Налетчик Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2587
UPDATE `creature_template_locale` SET `Name` = 'Налетчик из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2587;
-- OLD name : Тать Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2588
UPDATE `creature_template_locale` SET `Name` = 'Тать из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2588;
-- OLD name : Наемник Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2589
UPDATE `creature_template_locale` SET `Name` = 'Наемник из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2589;
-- OLD name : Окудник Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2590
UPDATE `creature_template_locale` SET `Name` = 'Окудник из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2590;
-- OLD name : Волхв Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=2591
UPDATE `creature_template_locale` SET `Name` = 'Волхв из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 2591;
-- OLD name : Шумный изгнанник
-- Source : https://www.wowhead.com/wotlk/ru/npc=2592
UPDATE `creature_template_locale` SET `Name` = 'Каменный изгнанник' WHERE `locale` = 'ruRU' AND `entry` = 2592;
-- OLD subname : Shadow Council Warlock
-- Source : https://www.wowhead.com/wotlk/ru/npc=2598
UPDATE `creature_template_locale` SET `Title` = 'Чернокнижник Совета Теней' WHERE `locale` = 'ruRU' AND `entry` = 2598;
-- OLD name : Старый кроколиск-хрустогрыз
-- Source : https://www.wowhead.com/wotlk/ru/npc=2635
UPDATE `creature_template_locale` SET `Name` = 'Старый солоноводный кроколиск' WHERE `locale` = 'ruRU' AND `entry` = 2635;
-- OLD name : Взыватель из племени Сухокожих
-- Source : https://www.wowhead.com/wotlk/ru/npc=2654
UPDATE `creature_template_locale` SET `Name` = 'Призыватель из племени Сухокожих' WHERE `locale` = 'ruRU' AND `entry` = 2654;
-- OLD name : Port Master Szik, subname : Boat Vendor
-- Source : https://www.wowhead.com/wotlk/ru/npc=2662
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 2662;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2662, 'ruRU','Портовый начальник Вжик','Торговец кораблями');
-- OLD name : Волчонок Порочной Ветви
-- Source : https://www.wowhead.com/wotlk/ru/npc=2680
UPDATE `creature_template_locale` SET `Name` = 'Волчонок племени Порочной Ветви' WHERE `locale` = 'ruRU' AND `entry` = 2680;
-- OLD name : Верховой волк Порочной Ветви
-- Source : https://www.wowhead.com/wotlk/ru/npc=2681
UPDATE `creature_template_locale` SET `Name` = 'Верховой волк племени Порочной Ветви' WHERE `locale` = 'ruRU' AND `entry` = 2681;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=2704
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 2704;
-- OLD name : Отрекшийся-курьер
-- Source : https://www.wowhead.com/wotlk/ru/npc=2714
UPDATE `creature_template_locale` SET `Name` = 'Отрекшаяся-курьер' WHERE `locale` = 'ruRU' AND `entry` = 2714;
-- OLD name : Баррикада
-- Source : https://www.wowhead.com/wotlk/ru/npc=2749
UPDATE `creature_template_locale` SET `Name` = 'Осадный голем' WHERE `locale` = 'ruRU' AND `entry` = 2749;
-- OLD name : Пылающий изгой
-- Source : https://www.wowhead.com/wotlk/ru/npc=2760
UPDATE `creature_template_locale` SET `Name` = 'Пылающий изгнанник' WHERE `locale` = 'ruRU' AND `entry` = 2760;
-- OLD name : Морской изгой
-- Source : https://www.wowhead.com/wotlk/ru/npc=2761
UPDATE `creature_template_locale` SET `Name` = 'Морской изгнанник' WHERE `locale` = 'ruRU' AND `entry` = 2761;
-- OLD name : Грохочущий изгнанник
-- Source : https://www.wowhead.com/wotlk/ru/npc=2762
UPDATE `creature_template_locale` SET `Name` = 'Громовой изгнанник' WHERE `locale` = 'ruRU' AND `entry` = 2762;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=2804
UPDATE `creature_template_locale` SET `Title` = 'Военачальник ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 2804;
-- OLD subname : Сто мелочей
-- Source : https://www.wowhead.com/wotlk/ru/npc=2808
UPDATE `creature_template_locale` SET `Title` = 'Потребительские товары' WHERE `locale` = 'ruRU' AND `entry` = 2808;
-- OLD name : Опалившийся канюк
-- Source : https://www.wowhead.com/wotlk/ru/npc=2830
UPDATE `creature_template_locale` SET `Name` = 'Канюк' WHERE `locale` = 'ruRU' AND `entry` = 2830;
-- OLD name : Джаксин Чонг
-- Source : https://www.wowhead.com/wotlk/ru/npc=2837
UPDATE `creature_template_locale` SET `Name` = 'Джаксин Чун' WHERE `locale` = 'ruRU' AND `entry` = 2837;
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=2851
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 2851;
-- OLD subname : Crocilisk Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=2876
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщик кроколисков' WHERE `locale` = 'ruRU' AND `entry` = 2876;
-- OLD subname : Ranged Skills Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=2886
UPDATE `creature_template_locale` SET `Title` = 'Учитель дальнего боя' WHERE `locale` = 'ruRU' AND `entry` = 2886;
-- OLD subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=2938
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщик медведей' WHERE `locale` = 'ruRU' AND `entry` = 2938;
-- OLD name : Jackson Bayne, subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=2939
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 2939;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2939, 'ruRU','Джексон Бейн','Дрессировщик кабанов');
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=2942
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщик волков' WHERE `locale` = 'ruRU' AND `entry` = 2942;
-- OLD name : Налетчик из племени Дыбогривов
-- Source : https://www.wowhead.com/wotlk/ru/npc=2952
UPDATE `creature_template_locale` SET `Name` = 'Свинобраз из племени Дыбогривов' WHERE `locale` = 'ruRU' AND `entry` = 2952;
-- OLD name : Волк прерий
-- Source : https://www.wowhead.com/wotlk/ru/npc=2958
UPDATE `creature_template_locale` SET `Name` = 'Луговой волк' WHERE `locale` = 'ruRU' AND `entry` = 2958;
-- OLD name : Могучий волк прерий
-- Source : https://www.wowhead.com/wotlk/ru/npc=2960
UPDATE `creature_template_locale` SET `Name` = 'Вожак луговых волков' WHERE `locale` = 'ruRU' AND `entry` = 2960;
-- OLD name : Молодой боевой вепрь
-- Source : https://www.wowhead.com/wotlk/ru/npc=2966
UPDATE `creature_template_locale` SET `Name` = 'Боевой вепрь' WHERE `locale` = 'ruRU' AND `entry` = 2966;
-- OLD name : Дух предков
-- Source : https://www.wowhead.com/wotlk/ru/npc=2994
UPDATE `creature_template_locale` SET `Name` = 'Дух предка' WHERE `locale` = 'ruRU' AND `entry` = 2994;
-- OLD subname : Торговец оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=2997
UPDATE `creature_template_locale` SET `Title` = 'Торговка оружием' WHERE `locale` = 'ruRU' AND `entry` = 2997;
-- OLD subname : Торговец хлебом
-- Source : https://www.wowhead.com/wotlk/ru/npc=3003
UPDATE `creature_template_locale` SET `Title` = 'Торговка хлебом' WHERE `locale` = 'ruRU' AND `entry` = 3003;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=3004
UPDATE `creature_template_locale` SET `Title` = 'Учительница портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 3004;
-- OLD subname : Товары для портных
-- Source : https://www.wowhead.com/wotlk/ru/npc=3005
UPDATE `creature_template_locale` SET `Title` = 'Товары для кожевников и портных' WHERE `locale` = 'ruRU' AND `entry` = 3005;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=3007
UPDATE `creature_template_locale` SET `Title` = 'Учительница кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 3007;
-- OLD subname : Товары для кожевников
-- Source : https://www.wowhead.com/wotlk/ru/npc=3008
UPDATE `creature_template_locale` SET `Title` = 'Ученик кожевника' WHERE `locale` = 'ruRU' AND `entry` = 3008;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=3009
UPDATE `creature_template_locale` SET `Title` = 'Учительница алхимии' WHERE `locale` = 'ruRU' AND `entry` = 3009;
-- OLD subname : Торговец луками и стрелами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3015
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками и стрелами' WHERE `locale` = 'ruRU' AND `entry` = 3015;
-- OLD subname : Продавец фруктов
-- Source : https://www.wowhead.com/wotlk/ru/npc=3017
UPDATE `creature_template_locale` SET `Title` = 'Торговка фруктами' WHERE `locale` = 'ruRU' AND `entry` = 3017;
-- OLD subname : Торговец посохами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3022
UPDATE `creature_template_locale` SET `Title` = 'Торговка посохами' WHERE `locale` = 'ruRU' AND `entry` = 3022;
-- OLD name : Сура Буйногривая
-- Source : https://www.wowhead.com/wotlk/ru/npc=3023
UPDATE `creature_template_locale` SET `Name` = 'Сура Буйная Грива' WHERE `locale` = 'ruRU' AND `entry` = 3023;
-- OLD subname : Продавец мяса
-- Source : https://www.wowhead.com/wotlk/ru/npc=3025
UPDATE `creature_template_locale` SET `Title` = 'Торговка мясом' WHERE `locale` = 'ruRU' AND `entry` = 3025;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=3026
UPDATE `creature_template_locale` SET `Title` = 'Учительница кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 3026;
-- OLD name : Ким Буйногривая
-- Source : https://www.wowhead.com/wotlk/ru/npc=3036
UPDATE `creature_template_locale` SET `Name` = 'Ким Буйная Грива' WHERE `locale` = 'ruRU' AND `entry` = 3036;
-- OLD name : Шеза Буйногривая
-- Source : https://www.wowhead.com/wotlk/ru/npc=3037
UPDATE `creature_template_locale` SET `Name` = 'Шеза Буйная Грива' WHERE `locale` = 'ruRU' AND `entry` = 3037;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=3067
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 3067;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3074
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 3074;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=3075
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 3075;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=3080
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 3080;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=3087
UPDATE `creature_template_locale` SET `Title` = 'Учительница кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 3087;
-- OLD subname : Торговец тканевыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3092
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканевыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 3092;
-- OLD subname : Торговец тяжелыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3095
UPDATE `creature_template_locale` SET `Title` = 'Торговка тяжелыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 3095;
-- OLD name : Приливный краб
-- Source : https://www.wowhead.com/wotlk/ru/npc=3106
UPDATE `creature_template_locale` SET `Name` = 'Карликовый приливный краб' WHERE `locale` = 'ruRU' AND `entry` = 3106;
-- OLD name : Взрослый приливный краб
-- Source : https://www.wowhead.com/wotlk/ru/npc=3107
UPDATE `creature_template_locale` SET `Name` = 'Приливный краб' WHERE `locale` = 'ruRU' AND `entry` = 3107;
-- OLD name : Рокочущая ящерица
-- Source : https://www.wowhead.com/wotlk/ru/npc=3130
UPDATE `creature_template_locale` SET `Name` = 'Рокочущий ящер' WHERE `locale` = 'ruRU' AND `entry` = 3130;
-- OLD subname : Торговец ядами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3135
UPDATE `creature_template_locale` SET `Title` = 'Торговка ядами' WHERE `locale` = 'ruRU' AND `entry` = 3135;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=3136
UPDATE `creature_template_locale` SET `Title` = 'Учительница кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 3136;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=3161
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 3161;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=3167
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 3167;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=3185
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 3185;
-- OLD name : Неофит клана Пылающего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=3196
UPDATE `creature_template_locale` SET `Name` = 'Неофит из клана Пылающего Клинка' WHERE `locale` = 'ruRU' AND `entry` = 3196;
-- OLD name : Ученик клана Пылающего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=3198
UPDATE `creature_template_locale` SET `Name` = 'Ученик из клана Пылающего Клинка' WHERE `locale` = 'ruRU' AND `entry` = 3198;
-- OLD name : Eric's AAA Special Vendor
-- Source : https://www.wowhead.com/wotlk/ru/npc=3200
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 3200;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (3200, 'ruRU','ИСПЫТАНИЕ-ТОРГОВЕЦ',NULL);
-- OLD name : Скотт Мерсер
-- Source : https://www.wowhead.com/wotlk/ru/npc=3201
UPDATE `creature_template_locale` SET `Name` = 'SM Test Mob' WHERE `locale` = 'ruRU' AND `entry` = 3201;
-- OLD name : Пшикс Чернолап
-- Source : https://www.wowhead.com/wotlk/ru/npc=3203
UPDATE `creature_template_locale` SET `Name` = 'Пшикс Черношквал' WHERE `locale` = 'ruRU' AND `entry` = 3203;
-- OLD name : Храбрец Серогривый
-- Source : https://www.wowhead.com/wotlk/ru/npc=3224
UPDATE `creature_template_locale` SET `Name` = 'Храбрец Облачная Грива' WHERE `locale` = 'ruRU' AND `entry` = 3224;
-- OLD name : Членистоног Силитида
-- Source : https://www.wowhead.com/wotlk/ru/npc=3252
UPDATE `creature_template_locale` SET `Name` = 'Силитид-роевик' WHERE `locale` = 'ruRU' AND `entry` = 3252;
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=3305
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 3305;
-- OLD subname : Продавец мяса
-- Source : https://www.wowhead.com/wotlk/ru/npc=3312
UPDATE `creature_template_locale` SET `Title` = 'Торговка мясом' WHERE `locale` = 'ruRU' AND `entry` = 3312;
-- OLD subname : Торговец тканевыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3317
UPDATE `creature_template_locale` SET `Title` = 'Торговец легкими доспехами' WHERE `locale` = 'ruRU' AND `entry` = 3317;
-- OLD subname : Торговец кольчужными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3319
UPDATE `creature_template_locale` SET `Title` = 'Торговка кольчужными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 3319;
-- OLD subname : Луки и ружья
-- Source : https://www.wowhead.com/wotlk/ru/npc=3322
UPDATE `creature_template_locale` SET `Title` = 'Ружья и боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 3322;
-- OLD name : Гроль'дар
-- Source : https://www.wowhead.com/wotlk/ru/npc=3324
UPDATE `creature_template_locale` SET `Name` = 'Грол''дар' WHERE `locale` = 'ruRU' AND `entry` = 3324;
-- OLD subname : Продавец фруктов
-- Source : https://www.wowhead.com/wotlk/ru/npc=3342
UPDATE `creature_template_locale` SET `Title` = 'Торговка фруктами' WHERE `locale` = 'ruRU' AND `entry` = 3342;
-- OLD subname : Наставница шаманов
-- Source : https://www.wowhead.com/wotlk/ru/npc=3344
UPDATE `creature_template_locale` SET `Title` = 'Наставник шаманов' WHERE `locale` = 'ruRU' AND `entry` = 3344;
-- OLD subname : Продавец мяса
-- Source : https://www.wowhead.com/wotlk/ru/npc=3368
UPDATE `creature_template_locale` SET `Title` = 'Торговец мясом' WHERE `locale` = 'ruRU' AND `entry` = 3368;
-- OLD subname : Продавец сумок
-- Source : https://www.wowhead.com/wotlk/ru/npc=3369
UPDATE `creature_template_locale` SET `Title` = 'Торговец сумками' WHERE `locale` = 'ruRU' AND `entry` = 3369;
-- OLD name : Послушник клана Пылающего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=3380
UPDATE `creature_template_locale` SET `Name` = 'Послушник из клана Пылающего Клинка' WHERE `locale` = 'ruRU' AND `entry` = 3380;
-- OLD name : Грабитель Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=3381
UPDATE `creature_template_locale` SET `Name` = 'Грабитель из братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 3381;
-- OLD name : Канонир Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=3382
UPDATE `creature_template_locale` SET `Name` = 'Канонир из братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 3382;
-- OLD name : Головорез Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=3383
UPDATE `creature_template_locale` SET `Name` = 'Головорез из братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 3383;
-- OLD name : Капер Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=3384
UPDATE `creature_template_locale` SET `Name` = 'Капер из братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 3384;
-- OLD name : Тераморский страж бухты
-- Source : https://www.wowhead.com/wotlk/ru/npc=3385
UPDATE `creature_template_locale` SET `Name` = 'Страж бухты Терамора' WHERE `locale` = 'ruRU' AND `entry` = 3385;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=3399
UPDATE `creature_template_locale` SET `Title` = 'Учительница кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 3399;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=3404
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 3404;
-- OLD subname : Реагенты и яды
-- Source : https://www.wowhead.com/wotlk/ru/npc=3405
UPDATE `creature_template_locale` SET `Title` = 'Товары для травников' WHERE `locale` = 'ruRU' AND `entry` = 3405;
-- OLD name : Фиглай Изгнанник (Old)
-- Source : https://www.wowhead.com/wotlk/ru/npc=3421
UPDATE `creature_template_locale` SET `Name` = 'Фиглай Изгнанник' WHERE `locale` = 'ruRU' AND `entry` = 3421;
-- OLD subname : Независимый поставщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=3442
UPDATE `creature_template_locale` SET `Title` = 'Союз ремонтников' WHERE `locale` = 'ruRU' AND `entry` = 3442;
-- OLD name : Спутник Братства Справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=3450
UPDATE `creature_template_locale` SET `Name` = 'Спутник из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 3450;
-- OLD subname : Флибустьеры Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=3467
UPDATE `creature_template_locale` SET `Title` = 'Флибустьеры Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 3467;
-- OLD subname : Торговец одеждой
-- Source : https://www.wowhead.com/wotlk/ru/npc=3486
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеждой' WHERE `locale` = 'ruRU' AND `entry` = 3486;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=3493
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 3493;
-- OLD name : Заступник-силитид
-- Source : https://www.wowhead.com/wotlk/ru/npc=3503
UPDATE `creature_template_locale` SET `Name` = 'Силитид-заступник' WHERE `locale` = 'ruRU' AND `entry` = 3503;
-- OLD subname : Все для алхимиков и травников
-- Source : https://www.wowhead.com/wotlk/ru/npc=3548
UPDATE `creature_template_locale` SET `Title` = 'Товары для алхимиков и травников' WHERE `locale` = 'ruRU' AND `entry` = 3548;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=3549
UPDATE `creature_template_locale` SET `Title` = 'Учительница кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 3549;
-- OLD subname : Торговец ядами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3551
UPDATE `creature_template_locale` SET `Title` = 'Торговка ядами' WHERE `locale` = 'ruRU' AND `entry` = 3551;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3552
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 3552;
-- OLD subname : Торговец одеждой
-- Source : https://www.wowhead.com/wotlk/ru/npc=3554
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеждой' WHERE `locale` = 'ruRU' AND `entry` = 3554;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=3557
UPDATE `creature_template_locale` SET `Title` = 'Учительница кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 3557;
-- OLD subname : Торговец ядами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3561
UPDATE `creature_template_locale` SET `Title` = 'Торговка ядами' WHERE `locale` = 'ruRU' AND `entry` = 3561;
-- OLD name : Часовой Тельдрассила
-- Source : https://www.wowhead.com/wotlk/ru/npc=3571
UPDATE `creature_template_locale` SET `Name` = 'Часовой из Тельдрассила' WHERE `locale` = 'ruRU' AND `entry` = 3571;
-- OLD name : Пивовар Янтарной мельницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=3577
UPDATE `creature_template_locale` SET `Name` = 'Даларанский пивовар' WHERE `locale` = 'ruRU' AND `entry` = 3577;
-- OLD name : Шахтер Янтарной мельницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=3578
UPDATE `creature_template_locale` SET `Name` = 'Даларанский шахтер' WHERE `locale` = 'ruRU' AND `entry` = 3578;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=3589
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 3589;
-- OLD subname : Торговец одеждой
-- Source : https://www.wowhead.com/wotlk/ru/npc=3590
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеждой' WHERE `locale` = 'ruRU' AND `entry` = 3590;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3591
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 3591;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=3592
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 3592;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=3603
UPDATE `creature_template_locale` SET `Title` = 'Учительница алхимии' WHERE `locale` = 'ruRU' AND `entry` = 3603;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=3605
UPDATE `creature_template_locale` SET `Title` = 'Учительница кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 3605;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=3606
UPDATE `creature_template_locale` SET `Title` = 'Учительница наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 3606;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=3610
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 3610;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=3612
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 3612;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=3613
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 3613;
-- OLD name : Муйон
-- Source : https://www.wowhead.com/wotlk/ru/npc=3678
UPDATE `creature_template_locale` SET `Name` = 'Послушник Наралекса' WHERE `locale` = 'ruRU' AND `entry` = 3678;
-- OLD name : Часовой Селарина
-- Source : https://www.wowhead.com/wotlk/ru/npc=3694
UPDATE `creature_template_locale` SET `Name` = 'Часовая Селарина' WHERE `locale` = 'ruRU' AND `entry` = 3694;
-- OLD name : Kyln Longclaw, subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=3697
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 3697;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (3697, 'ruRU','Килн Длинный Коготь','Дрессировщик кабанов');
-- OLD subname : Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=3698
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщик' WHERE `locale` = 'ruRU' AND `entry` = 3698;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=3699
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица кошек' WHERE `locale` = 'ruRU' AND `entry` = 3699;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=3704
UPDATE `creature_template_locale` SET `Title` = 'Учительница портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 3704;
-- OLD name : Разящий из клана Зловещего Хвоста
-- Source : https://www.wowhead.com/wotlk/ru/npc=3712
UPDATE `creature_template_locale` SET `Name` = 'Острохвост из клана Зловещего Хвоста' WHERE `locale` = 'ruRU' AND `entry` = 3712;
-- OLD name : Forsaken Seeker[UNUSED]
-- Source : https://www.wowhead.com/wotlk/ru/npc=3732
UPDATE `creature_template_locale` SET `Name` = 'Отрекшийся-искатель' WHERE `locale` = 'ruRU' AND `entry` = 3732;
-- OLD name : Орк-надзиратель
-- Source : https://www.wowhead.com/wotlk/ru/npc=3734
UPDATE `creature_template_locale` SET `Name` = 'Отрекшийся-лиходей' WHERE `locale` = 'ruRU' AND `entry` = 3734;
-- OLD subname : Целитель душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=3777
UPDATE `creature_template_locale` SET `Title` = 'Целительница душ' WHERE `locale` = 'ruRU' AND `entry` = 3777;
-- OLD subname : Целитель душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=3778
UPDATE `creature_template_locale` SET `Title` = 'Целительница душ' WHERE `locale` = 'ruRU' AND `entry` = 3778;
-- OLD name : Обгоревший шаркун
-- Source : https://www.wowhead.com/wotlk/ru/npc=3780
UPDATE `creature_template_locale` SET `Name` = 'Чащобный поедатель мха' WHERE `locale` = 'ruRU' AND `entry` = 3780;
-- OLD name : Вторгшийся Отрекшийся
-- Source : https://www.wowhead.com/wotlk/ru/npc=3804
UPDATE `creature_template_locale` SET `Name` = 'Отрекшийся-захватчик' WHERE `locale` = 'ruRU' AND `entry` = 3804;
-- OLD name : Секретный агент Отрекшихся
-- Source : https://www.wowhead.com/wotlk/ru/npc=3806
UPDATE `creature_template_locale` SET `Name` = 'Отрекшийся-лазутчик' WHERE `locale` = 'ruRU' AND `entry` = 3806;
-- OLD name : Паук-скакун дикого терна
-- Source : https://www.wowhead.com/wotlk/ru/npc=3819
UPDATE `creature_template_locale` SET `Name` = 'Терновый паук-охотник' WHERE `locale` = 'ruRU' AND `entry` = 3819;
-- OLD name : Ядоплюй дикого терна
-- Source : https://www.wowhead.com/wotlk/ru/npc=3820
UPDATE `creature_template_locale` SET `Name` = 'Терновый паук-ядоплюй' WHERE `locale` = 'ruRU' AND `entry` = 3820;
-- OLD name : Воронковый паук дикого терна
-- Source : https://www.wowhead.com/wotlk/ru/npc=3821
UPDATE `creature_template_locale` SET `Name` = 'Терновый паук' WHERE `locale` = 'ruRU' AND `entry` = 3821;
-- OLD name : Телдира Лунное Перо
-- Source : https://www.wowhead.com/wotlk/ru/npc=3841
UPDATE `creature_template_locale` SET `Name` = 'Кайлаис Лунное Перо' WHERE `locale` = 'ruRU' AND `entry` = 3841;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=3890
UPDATE `creature_template_locale` SET `Title` = 'Военачальник ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 3890;
-- OLD name : Трактирщик Буранд Ветродуй
-- Source : https://www.wowhead.com/wotlk/ru/npc=3934
UPDATE `creature_template_locale` SET `Name` = 'Буранд Ветродуй' WHERE `locale` = 'ruRU' AND `entry` = 3934;
-- OLD subname : Генерал Армии Часовых
-- Source : https://www.wowhead.com/wotlk/ru/npc=3936
UPDATE `creature_template_locale` SET `Title` = 'Генерал армии Часовых' WHERE `locale` = 'ruRU' AND `entry` = 3936;
-- OLD subname : Торговец одеждой
-- Source : https://www.wowhead.com/wotlk/ru/npc=3952
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеждой' WHERE `locale` = 'ruRU' AND `entry` = 3952;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=3964
UPDATE `creature_template_locale` SET `Title` = 'Учительница алхимии' WHERE `locale` = 'ruRU' AND `entry` = 3964;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=3965
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 3965;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=3966
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 3966;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=3967
UPDATE `creature_template_locale` SET `Title` = 'Учительница кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 3967;
-- OLD subname : Яды
-- Source : https://www.wowhead.com/wotlk/ru/npc=3969
UPDATE `creature_template_locale` SET `Title` = 'Инструменты и припасы' WHERE `locale` = 'ruRU' AND `entry` = 3969;
-- OLD name : Командир Алого ордена Могрейн
-- Source : https://www.wowhead.com/wotlk/ru/npc=3976
UPDATE `creature_template_locale` SET `Name` = 'Командор Алого ордена Могрейн' WHERE `locale` = 'ruRU' AND `entry` = 3976;
-- OLD name : Дроворуб Торговой Компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=3990
UPDATE `creature_template_locale` SET `Name` = 'Дроворуб Торговой компании' WHERE `locale` = 'ruRU' AND `entry` = 3990;
-- OLD name : Начальник-надсмотрщик Торговой Компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=3997
UPDATE `creature_template_locale` SET `Name` = 'Начальник-надсмотрщик Торговой компании' WHERE `locale` = 'ruRU' AND `entry` = 3997;
-- OLD name : Едкий сгустень
-- Source : https://www.wowhead.com/wotlk/ru/npc=4021
UPDATE `creature_template_locale` SET `Name` = 'Едкая сокотварь' WHERE `locale` = 'ruRU' AND `entry` = 4021;
-- OLD name : JEFF CHOW TEST
-- Source : https://www.wowhead.com/wotlk/ru/npc=4045
UPDATE `creature_template_locale` SET `Name` = '[UNUSED] JEFF CHOW TEST' WHERE `locale` = 'ruRU' AND `entry` = 4045;
-- OLD subname : Старый провозвестник
-- Source : https://www.wowhead.com/wotlk/ru/npc=4047
UPDATE `creature_template_locale` SET `Title` = 'Старший провидец' WHERE `locale` = 'ruRU' AND `entry` = 4047;
-- OLD name : Планировщик Торговой Компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=4069
UPDATE `creature_template_locale` SET `Name` = 'Планировщик Торговой компании' WHERE `locale` = 'ruRU' AND `entry` = 4069;
-- OLD name : Шлифовальщик Торговой Компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=4071
UPDATE `creature_template_locale` SET `Name` = 'Шлифовальщик Торговой компании' WHERE `locale` = 'ruRU' AND `entry` = 4071;
-- OLD name : Часовой Тенисил
-- Source : https://www.wowhead.com/wotlk/ru/npc=4079
UPDATE `creature_template_locale` SET `Name` = 'Часовая Тенисил' WHERE `locale` = 'ruRU' AND `entry` = 4079;
-- OLD name : Астария Устремленная к Звездам
-- Source : https://www.wowhead.com/wotlk/ru/npc=4090
UPDATE `creature_template_locale` SET `Name` = 'Астария Звездочет' WHERE `locale` = 'ruRU' AND `entry` = 4090;
-- OLD name : Кркк'кс
-- Source : https://www.wowhead.com/wotlk/ru/npc=4132
UPDATE `creature_template_locale` SET `Name` = 'Опустошитель-силитид' WHERE `locale` = 'ruRU' AND `entry` = 4132;
-- OLD subname : Foraging Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=4149
UPDATE `creature_template_locale` SET `Title` = 'Опытная добытчица' WHERE `locale` = 'ruRU' AND `entry` = 4149;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=4153
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица кошек' WHERE `locale` = 'ruRU' AND `entry` = 4153;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=4156
UPDATE `creature_template_locale` SET `Title` = 'Учительница рыбной ловли' WHERE `locale` = 'ruRU' AND `entry` = 4156;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=4157
UPDATE `creature_template_locale` SET `Title` = 'Учитель картографии' WHERE `locale` = 'ruRU' AND `entry` = 4157;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=4159
UPDATE `creature_template_locale` SET `Title` = 'Учительница портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 4159;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=4160
UPDATE `creature_template_locale` SET `Title` = 'Учительница алхимии' WHERE `locale` = 'ruRU' AND `entry` = 4160;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=4165
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 4165;
-- OLD subname : Продавец мяса
-- Source : https://www.wowhead.com/wotlk/ru/npc=4169
UPDATE `creature_template_locale` SET `Title` = 'Торговка мясом' WHERE `locale` = 'ruRU' AND `entry` = 4169;
-- OLD subname : Торговец клинками
-- Source : https://www.wowhead.com/wotlk/ru/npc=4171
UPDATE `creature_template_locale` SET `Title` = 'Торговка клинками' WHERE `locale` = 'ruRU' AND `entry` = 4171;
-- OLD subname : Торговец одеяниями
-- Source : https://www.wowhead.com/wotlk/ru/npc=4172
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеяниями' WHERE `locale` = 'ruRU' AND `entry` = 4172;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=4173
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 4173;
-- OLD name : Siannai, subname : Arrow Merchant
-- Source : https://www.wowhead.com/wotlk/ru/npc=4174
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 4174;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4174, 'ruRU','Шианнай','Торговец стрелами');
-- OLD subname : Торговец тканевыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=4175
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканевыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 4175;
-- OLD subname : Торговец тканевыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=4176
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканевыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 4176;
-- OLD subname : Торговец кольчужными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=4177
UPDATE `creature_template_locale` SET `Title` = 'Торговка кольчужными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 4177;
-- OLD subname : Торговец кольчужными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=4178
UPDATE `creature_template_locale` SET `Title` = 'Торговка кольчужными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 4178;
-- OLD subname : Торговец щитами
-- Source : https://www.wowhead.com/wotlk/ru/npc=4179
UPDATE `creature_template_locale` SET `Title` = 'Торговка щитами' WHERE `locale` = 'ruRU' AND `entry` = 4179;
-- OLD subname : Торговец двуручным оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=4180
UPDATE `creature_template_locale` SET `Title` = 'Торговка двуручным оружием' WHERE `locale` = 'ruRU' AND `entry` = 4180;
-- OLD subname : Торговец одеждой
-- Source : https://www.wowhead.com/wotlk/ru/npc=4185
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеждой' WHERE `locale` = 'ruRU' AND `entry` = 4185;
-- OLD subname : Броня и щиты
-- Source : https://www.wowhead.com/wotlk/ru/npc=4187
UPDATE `creature_template_locale` SET `Title` = 'Доспехи и щиты' WHERE `locale` = 'ruRU' AND `entry` = 4187;
-- OLD subname : Торговец тканевыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=4188
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканевыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 4188;
-- OLD subname : Продавец рыбы
-- Source : https://www.wowhead.com/wotlk/ru/npc=4200
UPDATE `creature_template_locale` SET `Title` = 'Торговец рыбой' WHERE `locale` = 'ruRU' AND `entry` = 4200;
-- OLD subname : Торговец оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=4203
UPDATE `creature_template_locale` SET `Title` = 'Торговка оружием' WHERE `locale` = 'ruRU' AND `entry` = 4203;
-- OLD subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=4206
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщик медведей' WHERE `locale` = 'ruRU' AND `entry` = 4206;
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=4207
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщик волков' WHERE `locale` = 'ruRU' AND `entry` = 4207;
-- OLD subname : Продавец рыбы
-- Source : https://www.wowhead.com/wotlk/ru/npc=4221
UPDATE `creature_template_locale` SET `Title` = 'Торговец рыбой' WHERE `locale` = 'ruRU' AND `entry` = 4221;
-- OLD name : Talegon, subname : Cartography Supplies
-- Source : https://www.wowhead.com/wotlk/ru/npc=4224
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 4224;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4224, 'ruRU','Талегон','Товары для картографов');
-- OLD name : Паршивый рыкун
-- Source : https://www.wowhead.com/wotlk/ru/npc=4249
UPDATE `creature_template_locale` SET `Name` = 'Паршивый рычун' WHERE `locale` = 'ruRU' AND `entry` = 4249;
-- OLD name : Дарнасский часовой
-- Source : https://www.wowhead.com/wotlk/ru/npc=4262
UPDATE `creature_template_locale` SET `Name` = 'Дарнасская часовая' WHERE `locale` = 'ruRU' AND `entry` = 4262;
-- OLD name : Чародей Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=4282
UPDATE `creature_template_locale` SET `Name` = 'Чародей из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 4282;
-- OLD name : Вызыватель из Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=4289
UPDATE `creature_template_locale` SET `Name` = 'Пробудитель из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 4289;
-- OLD name : Предсказатель Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=4291
UPDATE `creature_template_locale` SET `Name` = 'Предсказатель из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 4291;
-- OLD name : Заступник Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=4292
UPDATE `creature_template_locale` SET `Name` = 'Заступник из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 4292;
-- OLD name : Ищейка из Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=4304
UPDATE `creature_template_locale` SET `Name` = 'Ищейка Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 4304;
-- OLD name : Ниса, subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=4317
UPDATE `creature_template_locale` SET `Name` = 'Нице',`Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 4317;
-- OLD subname : Целитель душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=4340
UPDATE `creature_template_locale` SET `Title` = 'Целительница душ' WHERE `locale` = 'ruRU' AND `entry` = 4340;
-- OLD name : Темноклыкий скрытень
-- Source : https://www.wowhead.com/wotlk/ru/npc=4411
UPDATE `creature_template_locale` SET `Name` = 'Скрытень-темножвал' WHERE `locale` = 'ruRU' AND `entry` = 4411;
-- OLD name : Темноклыкий ползун
-- Source : https://www.wowhead.com/wotlk/ru/npc=4412
UPDATE `creature_template_locale` SET `Name` = 'Ползун-темножвал' WHERE `locale` = 'ruRU' AND `entry` = 4412;
-- OLD name : Паук-черноклык
-- Source : https://www.wowhead.com/wotlk/ru/npc=4413
UPDATE `creature_template_locale` SET `Name` = 'Паук-темножвал' WHERE `locale` = 'ruRU' AND `entry` = 4413;
-- OLD name : Ядоплюй-черноклык
-- Source : https://www.wowhead.com/wotlk/ru/npc=4414
UPDATE `creature_template_locale` SET `Name` = 'Ядоплюй-темножвал' WHERE `locale` = 'ruRU' AND `entry` = 4414;
-- OLD name : Гигантский темноклыкий паук
-- Source : https://www.wowhead.com/wotlk/ru/npc=4415
UPDATE `creature_template_locale` SET `Name` = 'Гигантский паук-темножвал' WHERE `locale` = 'ruRU' AND `entry` = 4415;
-- OLD name : Властитель Таранный Клык
-- Source : https://www.wowhead.com/wotlk/ru/npc=4420
UPDATE `creature_template_locale` SET `Name` = 'Властитель Злоклык' WHERE `locale` = 'ruRU' AND `entry` = 4420;
-- OLD subname : Пророк племени Мертовой Головы
-- Source : https://www.wowhead.com/wotlk/ru/npc=4424
UPDATE `creature_template_locale` SET `Title` = 'Пророк племени Мертвой Головы' WHERE `locale` = 'ruRU' AND `entry` = 4424;
-- OLD name : Wazza, subname : Totem Merchent
-- Source : https://www.wowhead.com/wotlk/ru/npc=4443
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 4443;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4443, 'ruRU','Какдл','Торговец тотемами');
-- OLD name : Воин из племени Порочной Ветви
-- Source : https://www.wowhead.com/wotlk/ru/npc=4465
UPDATE `creature_template_locale` SET `Name` = 'Воительница из племени Порочной Ветви' WHERE `locale` = 'ruRU' AND `entry` = 4465;
-- OLD name : Волк Порочной Ветви
-- Source : https://www.wowhead.com/wotlk/ru/npc=4482
UPDATE `creature_template_locale` SET `Name` = 'Волк племени Порочной Ветви' WHERE `locale` = 'ruRU' AND `entry` = 4482;
-- OLD name : Чароплет Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=4494
UPDATE `creature_template_locale` SET `Name` = 'Чародей из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 4494;
-- OLD name : Маурин Костолом
-- Source : https://www.wowhead.com/wotlk/ru/npc=4498
UPDATE `creature_template_locale` SET `Name` = 'Морин Костолом' WHERE `locale` = 'ruRU' AND `entry` = 4498;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=4552
UPDATE `creature_template_locale` SET `Title` = 'Учительница кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 4552;
-- OLD subname : Торговец легкими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=4558
UPDATE `creature_template_locale` SET `Title` = 'Торговка легкими доспехами' WHERE `locale` = 'ruRU' AND `entry` = 4558;
-- OLD name : Тимоти Уэлдон
-- Source : https://www.wowhead.com/wotlk/ru/npc=4559
UPDATE `creature_template_locale` SET `Name` = 'Тимоти Велдон' WHERE `locale` = 'ruRU' AND `entry` = 4559;
-- OLD subname : Торговец посохами
-- Source : https://www.wowhead.com/wotlk/ru/npc=4570
UPDATE `creature_template_locale` SET `Title` = 'Торговка посохами' WHERE `locale` = 'ruRU' AND `entry` = 4570;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=4578
UPDATE `creature_template_locale` SET `Title` = 'Учительница шитья из тенеткани' WHERE `locale` = 'ruRU' AND `entry` = 4578;
-- OLD subname : Торговец одеяниями
-- Source : https://www.wowhead.com/wotlk/ru/npc=4580
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеяниями' WHERE `locale` = 'ruRU' AND `entry` = 4580;
-- OLD subname : Продавец сумок
-- Source : https://www.wowhead.com/wotlk/ru/npc=4590
UPDATE `creature_template_locale` SET `Title` = 'Торговец сумками' WHERE `locale` = 'ruRU' AND `entry` = 4590;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=4604
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 4604;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=4614
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 4614;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=4616
UPDATE `creature_template_locale` SET `Title` = 'Учительница наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 4616;
-- OLD subname : Raptor Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=4621
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщик ящеров' WHERE `locale` = 'ruRU' AND `entry` = 4621;
-- OLD name : Костолом Пиратской Бухты
-- Source : https://www.wowhead.com/wotlk/ru/npc=4624
UPDATE `creature_template_locale` SET `Name` = 'Костолом из Пиратской Бухты' WHERE `locale` = 'ruRU' AND `entry` = 4624;
-- OLD name : Авгур клана Пылающего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=4663
UPDATE `creature_template_locale` SET `Name` = 'Авгур из клана Пылающего Клинка' WHERE `locale` = 'ruRU' AND `entry` = 4663;
-- OLD name : Адепт клана Пылающего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=4665
UPDATE `creature_template_locale` SET `Name` = 'Адепт из клана Пылающего Клинка' WHERE `locale` = 'ruRU' AND `entry` = 4665;
-- OLD name : Темный маг клана Пылающего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=4667
UPDATE `creature_template_locale` SET `Name` = 'Темный маг из клана Пылающего Клинка' WHERE `locale` = 'ruRU' AND `entry` = 4667;
-- OLD name : Окудник клана Пылающего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=4669
UPDATE `creature_template_locale` SET `Name` = 'Окудник из клана Пылающего Клинка' WHERE `locale` = 'ruRU' AND `entry` = 4669;
-- OLD name : Разъяренная рокочущая ящерица
-- Source : https://www.wowhead.com/wotlk/ru/npc=4726
UPDATE `creature_template_locale` SET `Name` = 'Разъяренный рокочущий ящер' WHERE `locale` = 'ruRU' AND `entry` = 4726;
-- OLD name : Старая рокочущая ящерица
-- Source : https://www.wowhead.com/wotlk/ru/npc=4727
UPDATE `creature_template_locale` SET `Name` = 'Старый рокочущий ящер' WHERE `locale` = 'ruRU' AND `entry` = 4727;
-- OLD name : Снежный баран
-- Source : https://www.wowhead.com/wotlk/ru/npc=4778
UPDATE `creature_template_locale` SET `Name` = 'Синий баран' WHERE `locale` = 'ruRU' AND `entry` = 4778;
-- OLD name : Разведчик Талрид, subname : The Argent Dawn
-- Source : https://www.wowhead.com/wotlk/ru/npc=4787
UPDATE `creature_template_locale` SET `Name` = 'Страж Талрид из ордена Серебряного Рассвета',`Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 4787;
-- OLD name : Рыбоед Аку'май
-- Source : https://www.wowhead.com/wotlk/ru/npc=4824
UPDATE `creature_template_locale` SET `Name` = 'Рыбоед Аку''мая' WHERE `locale` = 'ruRU' AND `entry` = 4824;
-- OLD name : Хрустогрыз Аку'май
-- Source : https://www.wowhead.com/wotlk/ru/npc=4825
UPDATE `creature_template_locale` SET `Name` = 'Хрустогрыз Аку''мая' WHERE `locale` = 'ruRU' AND `entry` = 4825;
-- OLD subname : Turtle Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=4881
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщик черепах' WHERE `locale` = 'ruRU' AND `entry` = 4881;
-- OLD subname : Коневод
-- Source : https://www.wowhead.com/wotlk/ru/npc=4885
UPDATE `creature_template_locale` SET `Title` = 'Конезаводчик' WHERE `locale` = 'ruRU' AND `entry` = 4885;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=4888
UPDATE `creature_template_locale` SET `Title` = 'Оружейник' WHERE `locale` = 'ruRU' AND `entry` = 4888;
-- OLD subname : Наставник охотников и продавец луков
-- Source : https://www.wowhead.com/wotlk/ru/npc=4892
UPDATE `creature_template_locale` SET `Title` = 'Торговец луками' WHERE `locale` = 'ruRU' AND `entry` = 4892;
-- OLD name : Барменша Лилиан, subname : Барменша
-- Source : https://www.wowhead.com/wotlk/ru/npc=4893
UPDATE `creature_template_locale` SET `Name` = 'Бармен Лилиан',`Title` = 'Бармен' WHERE `locale` = 'ruRU' AND `entry` = 4893;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=4894
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 4894;
-- OLD subname : Потребительские товары и реагенты
-- Source : https://www.wowhead.com/wotlk/ru/npc=4896
UPDATE `creature_template_locale` SET `Title` = 'Потребительские товары' WHERE `locale` = 'ruRU' AND `entry` = 4896;
-- OLD name : Брент Яшмоцвет
-- Source : https://www.wowhead.com/wotlk/ru/npc=4898
UPDATE `creature_template_locale` SET `Name` = 'Брент Джасперблум' WHERE `locale` = 'ruRU' AND `entry` = 4898;
-- OLD name : Водяная змея
-- Source : https://www.wowhead.com/wotlk/ru/npc=4953
UPDATE `creature_template_locale` SET `Name` = 'Болотная гадюка' WHERE `locale` = 'ruRU' AND `entry` = 4953;
-- OLD name : Посланник из Братства Справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=4970
UPDATE `creature_template_locale` SET `Name` = 'Агент Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 4970;
-- OLD name : Альдвин Лолкинс
-- Source : https://www.wowhead.com/wotlk/ru/npc=4974
UPDATE `creature_template_locale` SET `Name` = 'Альдвин Лафлин' WHERE `locale` = 'ruRU' AND `entry` = 4974;
-- OLD name : Элис Логлин
-- Source : https://www.wowhead.com/wotlk/ru/npc=4976
UPDATE `creature_template_locale` SET `Name` = 'Элис Лафлин' WHERE `locale` = 'ruRU' AND `entry` = 4976;
-- OLD name : Слуга Аку'май
-- Source : https://www.wowhead.com/wotlk/ru/npc=4978
UPDATE `creature_template_locale` SET `Name` = 'Слуга Аку''мая' WHERE `locale` = 'ruRU' AND `entry` = 4978;
-- OLD subname : Wolf Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=4994
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица волков' WHERE `locale` = 'ruRU' AND `entry` = 4994;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=4997
UPDATE `creature_template_locale` SET `Title` = 'Учительница рыбной ловли' WHERE `locale` = 'ruRU' AND `entry` = 4997;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=4998
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 4998;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=4999
UPDATE `creature_template_locale` SET `Title` = 'Учительница горного дела' WHERE `locale` = 'ruRU' AND `entry` = 4999;
-- OLD subname : Учитель дрессировки
-- Source : https://www.wowhead.com/wotlk/ru/npc=5000
UPDATE `creature_template_locale` SET `Title` = 'Учительница дрессировки' WHERE `locale` = 'ruRU' AND `entry` = 5000;
-- OLD subname : Bird Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5001
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица птиц' WHERE `locale` = 'ruRU' AND `entry` = 5001;
-- OLD name : World Boar Trainer, subname : Boar Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5002
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 5002;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (5002, 'ruRU','Дрессировщица вепрей','Дрессировщица кабанов');
-- OLD subname : Cat Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5003
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица кошек' WHERE `locale` = 'ruRU' AND `entry` = 5003;
-- OLD subname : Crawler Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5004
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица крабов' WHERE `locale` = 'ruRU' AND `entry` = 5004;
-- OLD subname : Crocodile Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5005
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица крокодилов' WHERE `locale` = 'ruRU' AND `entry` = 5005;
-- OLD name : World Demon Trainer - old, subname : NONE
-- Source : https://www.wowhead.com/wotlk/ru/npc=5006
UPDATE `creature_template_locale` SET `Name` = 'Наставник демонов',`Title` = 'Наставник демонов' WHERE `locale` = 'ruRU' AND `entry` = 5006;
-- OLD subname : Gorilla Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5008
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица горилл' WHERE `locale` = 'ruRU' AND `entry` = 5008;
-- OLD name : Учитель верховой езды, subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5009
UPDATE `creature_template_locale` SET `Name` = 'Учительница верховой езды',`Title` = 'Дрессировщица лошадей' WHERE `locale` = 'ruRU' AND `entry` = 5009;
-- OLD subname : Raptor Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5011
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица ящеров' WHERE `locale` = 'ruRU' AND `entry` = 5011;
-- OLD subname : Scorpid Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5012
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица скорпионов' WHERE `locale` = 'ruRU' AND `entry` = 5012;
-- OLD subname : Spider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5013
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица пауков' WHERE `locale` = 'ruRU' AND `entry` = 5013;
-- OLD name : Дрессировщица суккубов
-- Source : https://www.wowhead.com/wotlk/ru/npc=5014
UPDATE `creature_template_locale` SET `Name` = 'Наставница суккубов' WHERE `locale` = 'ruRU' AND `entry` = 5014;
-- OLD subname : Tallstrider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5015
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица долгоногов' WHERE `locale` = 'ruRU' AND `entry` = 5015;
-- OLD name : Дрессировщица демонов Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=5016
UPDATE `creature_template_locale` SET `Name` = 'Наставница демонов Бездны' WHERE `locale` = 'ruRU' AND `entry` = 5016;
-- OLD subname : Turtle Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5017
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица черепах' WHERE `locale` = 'ruRU' AND `entry` = 5017;
-- OLD name : Мировой портал: дарнасский учитель, subname : Портал: дарнасский учитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=5018
UPDATE `creature_template_locale` SET `Name` = 'Мировой портал: дарнасская учительница',`Title` = 'Портал: дарнасская учительница' WHERE `locale` = 'ruRU' AND `entry` = 5018;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=5024
UPDATE `creature_template_locale` SET `Title` = 'Учительница первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 5024;
-- OLD subname : Horse Riding Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5026
UPDATE `creature_template_locale` SET `Title` = 'Учительница верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 5026;
-- OLD name : [PH] Mogu Pain Barrier, subname : Lockpicking Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5027
UPDATE `creature_template_locale` SET `Name` = 'Мир - учитель - вскрытие замков',`Title` = 'Учитель вскрытия замков' WHERE `locale` = 'ruRU' AND `entry` = 5027;
-- OLD name : Мир - учитель - езда на баранах, subname : Учитель езды на баранах
-- Source : https://www.wowhead.com/wotlk/ru/npc=5028
UPDATE `creature_template_locale` SET `Name` = 'Мир - учительница верховой езды на баранах',`Title` = 'Учительница верховой езды на баранах' WHERE `locale` = 'ruRU' AND `entry` = 5028;
-- OLD name : Цзимин, subname : Survival Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5029
UPDATE `creature_template_locale` SET `Name` = 'Мир - учитель - выживание',`Title` = 'Учитель выживания' WHERE `locale` = 'ruRU' AND `entry` = 5029;
-- OLD name : Мир - учитель - езда на тиграх, subname : Tiger Riding Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5030
UPDATE `creature_template_locale` SET `Name` = 'Мир - учительница верховой езды на тиграх',`Title` = 'Учительница верховой езды на тиграх' WHERE `locale` = 'ruRU' AND `entry` = 5030;
-- OLD name : Мир - учитель - езда на волках, subname : Учитель езды на волках
-- Source : https://www.wowhead.com/wotlk/ru/npc=5031
UPDATE `creature_template_locale` SET `Name` = 'Мир - учительница верховой езды на волках',`Title` = 'Учительница верховой езды на волках' WHERE `locale` = 'ruRU' AND `entry` = 5031;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=5032
UPDATE `creature_template_locale` SET `Title` = 'Учительница алхимии' WHERE `locale` = 'ruRU' AND `entry` = 5032;
-- OLD name : Винва, subname : Brewing Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5034
UPDATE `creature_template_locale` SET `Name` = 'Мир - учитель - пивовар',`Title` = 'Учитель пивоварения' WHERE `locale` = 'ruRU' AND `entry` = 5034;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5035
UPDATE `creature_template_locale` SET `Title` = 'Учитель картографии' WHERE `locale` = 'ruRU' AND `entry` = 5035;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=5036
UPDATE `creature_template_locale` SET `Title` = 'Учительница кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 5036;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=5037
UPDATE `creature_template_locale` SET `Title` = 'Учительница инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 5037;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=5038
UPDATE `creature_template_locale` SET `Title` = 'Учительница наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 5038;
-- OLD name : Мир - учитель - чернокнижник, subname : Наставница чернокнижников
-- Source : https://www.wowhead.com/wotlk/ru/npc=5039
UPDATE `creature_template_locale` SET `Name` = 'Мир - учитель - следопыт',`Title` = 'Учитель следопытов' WHERE `locale` = 'ruRU' AND `entry` = 5039;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=5040
UPDATE `creature_template_locale` SET `Title` = 'Учительница кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 5040;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=5041
UPDATE `creature_template_locale` SET `Title` = 'Учительница портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 5041;
-- OLD name : Бунтовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=5043
UPDATE `creature_template_locale` SET `Name` = 'Бунтовщик из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 5043;
-- OLD name : Банкирша
-- Source : https://www.wowhead.com/wotlk/ru/npc=5060
UPDATE `creature_template_locale` SET `Name` = 'Банкир' WHERE `locale` = 'ruRU' AND `entry` = 5060;
-- OLD name : Продавец гербовых накидок гильдий
-- Source : https://www.wowhead.com/wotlk/ru/npc=5061
UPDATE `creature_template_locale` SET `Name` = 'Продавец гильдейских гербовых накидок' WHERE `locale` = 'ruRU' AND `entry` = 5061;
-- OLD name : Казначей Лендри
-- Source : https://www.wowhead.com/wotlk/ru/npc=5083
UPDATE `creature_template_locale` SET `Name` = 'Клерк Лендри' WHERE `locale` = 'ruRU' AND `entry` = 5083;
-- OLD subname : Капитан команды красных
-- Source : https://www.wowhead.com/wotlk/ru/npc=5095
UPDATE `creature_template_locale` SET `Title` = 'Капитан красной команды' WHERE `locale` = 'ruRU' AND `entry` = 5095;
-- OLD subname : Капитан команды синих
-- Source : https://www.wowhead.com/wotlk/ru/npc=5096
UPDATE `creature_template_locale` SET `Title` = 'Капитан синей команды' WHERE `locale` = 'ruRU' AND `entry` = 5096;
-- OLD subname : Gun Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5104
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по огнестрельному оружию' WHERE `locale` = 'ruRU' AND `entry` = 5104;
-- OLD subname : Торговец легкими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=5108
UPDATE `creature_template_locale` SET `Title` = 'Торговка легкими доспехами' WHERE `locale` = 'ruRU' AND `entry` = 5108;
-- OLD subname : Торговец хлебом
-- Source : https://www.wowhead.com/wotlk/ru/npc=5109
UPDATE `creature_template_locale` SET `Title` = 'Торговка хлебом' WHERE `locale` = 'ruRU' AND `entry` = 5109;
-- OLD name : Трактирщик Огневар
-- Source : https://www.wowhead.com/wotlk/ru/npc=5111
UPDATE `creature_template_locale` SET `Name` = 'Огневар' WHERE `locale` = 'ruRU' AND `entry` = 5111;
-- OLD subname : Торговец клинками
-- Source : https://www.wowhead.com/wotlk/ru/npc=5120
UPDATE `creature_template_locale` SET `Title` = 'Торговка клинками' WHERE `locale` = 'ruRU' AND `entry` = 5120;
-- OLD subname : Торговец огнестрельным оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=5123
UPDATE `creature_template_locale` SET `Title` = 'Торговка огнестрельным оружием' WHERE `locale` = 'ruRU' AND `entry` = 5123;
-- OLD subname : Продавец мяса
-- Source : https://www.wowhead.com/wotlk/ru/npc=5124
UPDATE `creature_template_locale` SET `Title` = 'Торговец мясом' WHERE `locale` = 'ruRU' AND `entry` = 5124;
-- OLD subname : Торговец легкими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=5129
UPDATE `creature_template_locale` SET `Title` = 'Торговка легкими доспехами' WHERE `locale` = 'ruRU' AND `entry` = 5129;
-- OLD subname : Продавец сумок
-- Source : https://www.wowhead.com/wotlk/ru/npc=5132
UPDATE `creature_template_locale` SET `Title` = 'Торговец сумками' WHERE `locale` = 'ruRU' AND `entry` = 5132;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=5137
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 5137;
-- OLD name : Браэнна Кремнескал
-- Source : https://www.wowhead.com/wotlk/ru/npc=5142
UPDATE `creature_template_locale` SET `Name` = 'Бренна Кремнескал' WHERE `locale` = 'ruRU' AND `entry` = 5142;
-- OLD subname : Торговец тканевыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=5155
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканевыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 5155;
-- OLD subname : Торговец одеяниями
-- Source : https://www.wowhead.com/wotlk/ru/npc=5156
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеяниями' WHERE `locale` = 'ruRU' AND `entry` = 5156;
-- OLD name : Дерил Рикнуссун
-- Source : https://www.wowhead.com/wotlk/ru/npc=5159
UPDATE `creature_template_locale` SET `Name` = 'Дэрил Рикнуссун' WHERE `locale` = 'ruRU' AND `entry` = 5159;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=5164
UPDATE `creature_template_locale` SET `Title` = 'Учитель бронников' WHERE `locale` = 'ruRU' AND `entry` = 5164;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=5177
UPDATE `creature_template_locale` SET `Title` = 'Учительница алхимии' WHERE `locale` = 'ruRU' AND `entry` = 5177;
-- OLD name : Пушка Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=5187
UPDATE `creature_template_locale` SET `Name` = 'Пушка братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 5187;
-- OLD subname : Продавец гербовых накидок
-- Source : https://www.wowhead.com/wotlk/ru/npc=5188
UPDATE `creature_template_locale` SET `Title` = 'Торговка гербовыми накидками' WHERE `locale` = 'ruRU' AND `entry` = 5188;
-- OLD subname : Продавец гербовых накидок
-- Source : https://www.wowhead.com/wotlk/ru/npc=5189
UPDATE `creature_template_locale` SET `Title` = 'Торговец гербовыми накидками' WHERE `locale` = 'ruRU' AND `entry` = 5189;
-- OLD subname : Продавец гербовых накидок
-- Source : https://www.wowhead.com/wotlk/ru/npc=5190
UPDATE `creature_template_locale` SET `Title` = 'Торговка гербовыми накидками' WHERE `locale` = 'ruRU' AND `entry` = 5190;
-- OLD subname : Продавец гербовых накидок
-- Source : https://www.wowhead.com/wotlk/ru/npc=5191
UPDATE `creature_template_locale` SET `Title` = 'Торговец гербовыми накидками' WHERE `locale` = 'ruRU' AND `entry` = 5191;
-- OLD name : Жрец племени Атал'ай
-- Source : https://www.wowhead.com/wotlk/ru/npc=5269
UPDATE `creature_template_locale` SET `Name` = 'Жрец из племени Атал''ай' WHERE `locale` = 'ruRU' AND `entry` = 5269;
-- OLD name : Мертвоброд из племени Атал'ай
-- Source : https://www.wowhead.com/wotlk/ru/npc=5271
UPDATE `creature_template_locale` SET `Name` = 'Вестник смерти из племени Атал''ай' WHERE `locale` = 'ruRU' AND `entry` = 5271;
-- OLD name : Верховный жрец племени Атал'ай
-- Source : https://www.wowhead.com/wotlk/ru/npc=5273
UPDATE `creature_template_locale` SET `Name` = 'Старший жрец из племени Атал''ай' WHERE `locale` = 'ruRU' AND `entry` = 5273;
-- OLD name : Защитник клана Огнекрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=5355
UPDATE `creature_template_locale` SET `Name` = 'Защитник из армии Огнекрылых' WHERE `locale` = 'ruRU' AND `entry` = 5355;
-- OLD name : Рыкун
-- Source : https://www.wowhead.com/wotlk/ru/npc=5356
UPDATE `creature_template_locale` SET `Name` = 'Рычун' WHERE `locale` = 'ruRU' AND `entry` = 5356;
-- OLD name : Старший исследователь Магеллас
-- Source : https://www.wowhead.com/wotlk/ru/npc=5387
UPDATE `creature_template_locale` SET `Name` = 'Верховный исследователь Магеллас' WHERE `locale` = 'ruRU' AND `entry` = 5387;
-- OLD subname : Ювелирное дело: обучение и товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=5388
UPDATE `creature_template_locale` SET `Title` = 'Лига исследователей' WHERE `locale` = 'ruRU' AND `entry` = 5388;
-- OLD name : Порабощенный пожинатель
-- Source : https://www.wowhead.com/wotlk/ru/npc=5409
UPDATE `creature_template_locale` SET `Name` = 'Пожинающий рой' WHERE `locale` = 'ruRU' AND `entry` = 5409;
-- OLD name : Гурда Буйногривая
-- Source : https://www.wowhead.com/wotlk/ru/npc=5412
UPDATE `creature_template_locale` SET `Name` = 'Гурда Буйная Грива' WHERE `locale` = 'ruRU' AND `entry` = 5412;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=5499
UPDATE `creature_template_locale` SET `Title` = 'Учительница алхимии' WHERE `locale` = 'ruRU' AND `entry` = 5499;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=5502
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 5502;
-- OLD subname : Tallstrider Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=5507
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщик долгоногов' WHERE `locale` = 'ruRU' AND `entry` = 5507;
-- OLD name : Тулман Кремневый Утес, subname : Огнестрельное оружие
-- Source : https://www.wowhead.com/wotlk/ru/npc=5510
UPDATE `creature_template_locale` SET `Name` = 'Тулман Кремнескал',`Title` = 'Продавец огнестрельного оружия' WHERE `locale` = 'ruRU' AND `entry` = 5510;
-- OLD name : Гельман Крепкорук
-- Source : https://www.wowhead.com/wotlk/ru/npc=5513
UPDATE `creature_template_locale` SET `Name` = 'Гельман Камнерук' WHERE `locale` = 'ruRU' AND `entry` = 5513;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=5566
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 5566;
-- OLD name : Изгнанник племени Атал'ай
-- Source : https://www.wowhead.com/wotlk/ru/npc=5598
UPDATE `creature_template_locale` SET `Name` = 'Изгнанник из племени Атал''ай' WHERE `locale` = 'ruRU' AND `entry` = 5598;
-- OLD name : Призыватель Огня из племени Песчаной Бури
-- Source : https://www.wowhead.com/wotlk/ru/npc=5647
UPDATE `creature_template_locale` SET `Name` = 'Призыватель огня из племени Песчаной Бури' WHERE `locale` = 'ruRU' AND `entry` = 5647;
-- OLD name : Знахарь из клана Песчаной Бури
-- Source : https://www.wowhead.com/wotlk/ru/npc=5650
UPDATE `creature_template_locale` SET `Name` = 'Знахарь из племени Песчаной Бури' WHERE `locale` = 'ruRU' AND `entry` = 5650;
-- OLD name : Тренировочная цель
-- Source : https://www.wowhead.com/wotlk/ru/npc=5674
UPDATE `creature_template_locale` SET `Name` = 'Тренировочная мишень' WHERE `locale` = 'ruRU' AND `entry` = 5674;
-- OLD name : Вызванный суккуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=5677
UPDATE `creature_template_locale` SET `Name` = 'Призванный суккуб' WHERE `locale` = 'ruRU' AND `entry` = 5677;
-- OLD name : Комер Виллард
-- Source : https://www.wowhead.com/wotlk/ru/npc=5683
UPDATE `creature_template_locale` SET `Name` = 'Корма Виллард' WHERE `locale` = 'ruRU' AND `entry` = 5683;
-- OLD name : Трактирщица Ренни
-- Source : https://www.wowhead.com/wotlk/ru/npc=5688
UPDATE `creature_template_locale` SET `Name` = 'Ренни' WHERE `locale` = 'ruRU' AND `entry` = 5688;
-- OLD subname : Марионетка Джерарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=5697
UPDATE `creature_template_locale` SET `Title` = 'Эксперимент Джерарда' WHERE `locale` = 'ruRU' AND `entry` = 5697;
-- OLD name : Жезель Пруитт
-- Source : https://www.wowhead.com/wotlk/ru/npc=5702
UPDATE `creature_template_locale` SET `Name` = 'Жезель Прюитт' WHERE `locale` = 'ruRU' AND `entry` = 5702;
-- OLD name : Охотник Скверны Жезели
-- Source : https://www.wowhead.com/wotlk/ru/npc=5726
UPDATE `creature_template_locale` SET `Name` = 'Охотник Скверны Жезель' WHERE `locale` = 'ruRU' AND `entry` = 5726;
-- OLD name : Конь Скверны Жезели
-- Source : https://www.wowhead.com/wotlk/ru/npc=5727
UPDATE `creature_template_locale` SET `Name` = 'Конь Скверны Жезель' WHERE `locale` = 'ruRU' AND `entry` = 5727;
-- OLD name : Суккуб Жезели
-- Source : https://www.wowhead.com/wotlk/ru/npc=5728
UPDATE `creature_template_locale` SET `Name` = 'Суккуб Жезель' WHERE `locale` = 'ruRU' AND `entry` = 5728;
-- OLD name : Демон Бездны Жезели
-- Source : https://www.wowhead.com/wotlk/ru/npc=5729
UPDATE `creature_template_locale` SET `Name` = 'Демон Бездны Жезель' WHERE `locale` = 'ruRU' AND `entry` = 5729;
-- OLD name : Бес Жезели
-- Source : https://www.wowhead.com/wotlk/ru/npc=5730
UPDATE `creature_template_locale` SET `Name` = 'Бес Жезель' WHERE `locale` = 'ruRU' AND `entry` = 5730;
-- OLD name : Аптекарь Ликанус
-- Source : https://www.wowhead.com/wotlk/ru/npc=5733
UPDATE `creature_template_locale` SET `Name` = 'Аптекарь Ликан' WHERE `locale` = 'ruRU' AND `entry` = 5733;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=5759
UPDATE `creature_template_locale` SET `Title` = 'Учительница первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 5759;
-- OLD name : Нара Буйногривая
-- Source : https://www.wowhead.com/wotlk/ru/npc=5770
UPDATE `creature_template_locale` SET `Name` = 'Нара Буйная Грива' WHERE `locale` = 'ruRU' AND `entry` = 5770;
-- OLD subname : Миротворец Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=5793
UPDATE `creature_template_locale` SET `Title` = 'Миротворица Альянса' WHERE `locale` = 'ruRU' AND `entry` = 5793;
-- OLD name : Сержант Кертис
-- Source : https://www.wowhead.com/wotlk/ru/npc=5809
UPDATE `creature_template_locale` SET `Name` = 'Командир стражи Залафил' WHERE `locale` = 'ruRU' AND `entry` = 5809;
-- OLD subname : Торговец тяжелыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=5812
UPDATE `creature_template_locale` SET `Title` = 'Торговка тяжелыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 5812;
-- OLD name : Трактирщик Тулбек
-- Source : https://www.wowhead.com/wotlk/ru/npc=5814
UPDATE `creature_template_locale` SET `Name` = 'Тулбек' WHERE `locale` = 'ruRU' AND `entry` = 5814;
-- OLD subname : Торговец тяжелыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=5819
UPDATE `creature_template_locale` SET `Title` = 'Торговка тяжелыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 5819;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=5820
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 5820;
-- OLD name : Канага заклинатель земли
-- Source : https://www.wowhead.com/wotlk/ru/npc=5887
UPDATE `creature_template_locale` SET `Name` = 'Канага Заклинатель Земли' WHERE `locale` = 'ruRU' AND `entry` = 5887;
-- OLD name : Рубака Колючего Холма
-- Source : https://www.wowhead.com/wotlk/ru/npc=5953
UPDATE `creature_template_locale` SET `Name` = 'Рубака из Колючего Холма' WHERE `locale` = 'ruRU' AND `entry` = 5953;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=5957
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 5957;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=5958
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 5958;
-- OLD name :  Мир - орк - мужчина - учитель - чернокнижник
-- Source : https://www.wowhead.com/wotlk/ru/npc=5962
UPDATE `creature_template_locale` SET `Name` = 'Мир - орк - мужчина - учитель - чернокнижник' WHERE `locale` = 'ruRU' AND `entry` = 5962;
-- OLD name :  Мир - дворф - женщина - учитель - воин
-- Source : https://www.wowhead.com/wotlk/ru/npc=5967
UPDATE `creature_template_locale` SET `Name` = 'Мир - дворф - женщина - наставница воинов' WHERE `locale` = 'ruRU' AND `entry` = 5967;
-- OLD name : Костегрыз - поедатель Скверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=5983
UPDATE `creature_template_locale` SET `Name` = 'Костегрыз' WHERE `locale` = 'ruRU' AND `entry` = 5983;
-- OLD name : Крепкохват скорпок
-- Source : https://www.wowhead.com/wotlk/ru/npc=5987
UPDATE `creature_template_locale` SET `Name` = 'Скорпок-крепкохват' WHERE `locale` = 'ruRU' AND `entry` = 5987;
-- OLD name : Плеточник скорпок
-- Source : https://www.wowhead.com/wotlk/ru/npc=5989
UPDATE `creature_template_locale` SET `Name` = 'Скорпок-хвостожал' WHERE `locale` = 'ruRU' AND `entry` = 5989;
-- OLD name : Сектант культа Приверженцев Тени
-- Source : https://www.wowhead.com/wotlk/ru/npc=6004
UPDATE `creature_template_locale` SET `Name` = 'Сектант Культа Приверженцев Тени' WHERE `locale` = 'ruRU' AND `entry` = 6004;
-- OLD name : Караульный-страж Скверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=6011
UPDATE `creature_template_locale` SET `Name` = 'Страж Скверны - дозорный' WHERE `locale` = 'ruRU' AND `entry` = 6011;
-- OLD name : Тотем защиты от сил стихий
-- Source : https://www.wowhead.com/wotlk/ru/npc=6016
UPDATE `creature_template_locale` SET `Name` = 'Тотем защиты от стихий' WHERE `locale` = 'ruRU' AND `entry` = 6016;
-- OLD name : Часовой Аубердина
-- Source : https://www.wowhead.com/wotlk/ru/npc=6086
UPDATE `creature_template_locale` SET `Name` = 'Аубердинская часовая' WHERE `locale` = 'ruRU' AND `entry` = 6086;
-- OLD name : Часовой Астранаара
-- Source : https://www.wowhead.com/wotlk/ru/npc=6087
UPDATE `creature_template_locale` SET `Name` = 'Астранаарская часовая' WHERE `locale` = 'ruRU' AND `entry` = 6087;
-- OLD name : Младший фантазм
-- Source : https://www.wowhead.com/wotlk/ru/npc=6106
UPDATE `creature_template_locale` SET `Name` = 'Слабый фантазм' WHERE `locale` = 'ruRU' AND `entry` = 6106;
-- OLD name : Старший фантазм
-- Source : https://www.wowhead.com/wotlk/ru/npc=6108
UPDATE `creature_template_locale` SET `Name` = 'Сильный фантазм' WHERE `locale` = 'ruRU' AND `entry` = 6108;
-- OLD name : Драконья чаровязка
-- Source : https://www.wowhead.com/wotlk/ru/npc=6131
UPDATE `creature_template_locale` SET `Name` = 'Драконья чаротворица' WHERE `locale` = 'ruRU' AND `entry` = 6131;
-- OLD name : Посланник из клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=6212
UPDATE `creature_template_locale` SET `Name` = 'Посланник клана Черного Железа' WHERE `locale` = 'ruRU' AND `entry` = 6212;
-- OLD name : Посол из клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=6228
UPDATE `creature_template_locale` SET `Name` = 'Посол клана Черного Железа' WHERE `locale` = 'ruRU' AND `entry` = 6228;
-- OLD name : Толпогон 9-60
-- Source : https://www.wowhead.com/wotlk/ru/npc=6229
UPDATE `creature_template_locale` SET `Name` = '"Толпогон 9-60"' WHERE `locale` = 'ruRU' AND `entry` = 6229;
-- OLD name : Электрошокер 6000
-- Source : https://www.wowhead.com/wotlk/ru/npc=6235
UPDATE `creature_template_locale` SET `Name` = '"Электрошокер-6000"' WHERE `locale` = 'ruRU' AND `entry` = 6235;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=6242
UPDATE `creature_template_locale` SET `Title` = 'Учительница снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 6242;
-- OLD name : Трактирщица Джанин
-- Source : https://www.wowhead.com/wotlk/ru/npc=6272
UPDATE `creature_template_locale` SET `Name` = 'Джанин' WHERE `locale` = 'ruRU' AND `entry` = 6272;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=6286
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 6286;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=6288
UPDATE `creature_template_locale` SET `Title` = 'Учительница снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 6288;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=6292
UPDATE `creature_template_locale` SET `Title` = 'Учительница снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 6292;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=6295
UPDATE `creature_template_locale` SET `Title` = 'Учительница снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 6295;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=6306
UPDATE `creature_template_locale` SET `Title` = 'Учительница снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 6306;
-- OLD name : Целитель душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=6491
UPDATE `creature_template_locale` SET `Name` = 'Целительница душ' WHERE `locale` = 'ruRU' AND `entry` = 6491;
-- OLD name : Смоляной господин
-- Source : https://www.wowhead.com/wotlk/ru/npc=6519
UPDATE `creature_template_locale` SET `Name` = 'Смоляной дух' WHERE `locale` = 'ruRU' AND `entry` = 6519;
-- OLD name : Ружейник из клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=6523
UPDATE `creature_template_locale` SET `Name` = 'Стрелок из клана Черного Железа' WHERE `locale` = 'ruRU' AND `entry` = 6523;
-- OLD name : Эстелла Джендри
-- Source : https://www.wowhead.com/wotlk/ru/npc=6566
UPDATE `creature_template_locale` SET `Name` = 'Эстель Джендри' WHERE `locale` = 'ruRU' AND `entry` = 6566;
-- OLD name : Облик кошки (ночной эльф-друид)
-- Source : https://www.wowhead.com/wotlk/ru/npc=6571
UPDATE `creature_template_locale` SET `Name` = 'Облик кошки  (ночной эльф-друид)' WHERE `locale` = 'ruRU' AND `entry` = 6571;
-- OLD name : Земледелец (Лес)
-- Source : https://www.wowhead.com/wotlk/ru/npc=6578
UPDATE `creature_template_locale` SET `Name` = 'Лесоруб' WHERE `locale` = 'ruRU' AND `entry` = 6578;
-- OLD name : Матка Завас
-- Source : https://www.wowhead.com/wotlk/ru/npc=6582
UPDATE `creature_template_locale` SET `Name` = 'Королева Завас' WHERE `locale` = 'ruRU' AND `entry` = 6582;
-- OLD name : Плотник из Западного Края
-- Source : https://www.wowhead.com/wotlk/ru/npc=6670
UPDATE `creature_template_locale` SET `Name` = 'Плотник из Западного края' WHERE `locale` = 'ruRU' AND `entry` = 6670;
-- OLD name : Трактирщица Брианна
-- Source : https://www.wowhead.com/wotlk/ru/npc=6727
UPDATE `creature_template_locale` SET `Name` = 'Брианна' WHERE `locale` = 'ruRU' AND `entry` = 6727;
-- OLD name : Трактирщик Жаркий Очаг
-- Source : https://www.wowhead.com/wotlk/ru/npc=6734
UPDATE `creature_template_locale` SET `Name` = 'Жаркий Очаг' WHERE `locale` = 'ruRU' AND `entry` = 6734;
-- OLD name : Трактирщица Салиенна
-- Source : https://www.wowhead.com/wotlk/ru/npc=6735
UPDATE `creature_template_locale` SET `Name` = 'Салиенна' WHERE `locale` = 'ruRU' AND `entry` = 6735;
-- OLD name : Трактирщик Кельдамир
-- Source : https://www.wowhead.com/wotlk/ru/npc=6736
UPDATE `creature_template_locale` SET `Name` = 'Кельдамир' WHERE `locale` = 'ruRU' AND `entry` = 6736;
-- OLD name : Трактирщица Шосси
-- Source : https://www.wowhead.com/wotlk/ru/npc=6737
UPDATE `creature_template_locale` SET `Name` = 'Шосси' WHERE `locale` = 'ruRU' AND `entry` = 6737;
-- OLD name : Трактирщица Кимлия
-- Source : https://www.wowhead.com/wotlk/ru/npc=6738
UPDATE `creature_template_locale` SET `Name` = 'Кимлия' WHERE `locale` = 'ruRU' AND `entry` = 6738;
-- OLD name : Трактирщик Бейтс
-- Source : https://www.wowhead.com/wotlk/ru/npc=6739
UPDATE `creature_template_locale` SET `Name` = 'Бейтс' WHERE `locale` = 'ruRU' AND `entry` = 6739;
-- OLD name : Трактирщица Аллисон
-- Source : https://www.wowhead.com/wotlk/ru/npc=6740
UPDATE `creature_template_locale` SET `Name` = 'Аллисон' WHERE `locale` = 'ruRU' AND `entry` = 6740;
-- OLD name : Трактирщик Норман
-- Source : https://www.wowhead.com/wotlk/ru/npc=6741
UPDATE `creature_template_locale` SET `Name` = 'Норман' WHERE `locale` = 'ruRU' AND `entry` = 6741;
-- OLD name : Трактирщица Пала
-- Source : https://www.wowhead.com/wotlk/ru/npc=6746
UPDATE `creature_template_locale` SET `Name` = 'Пала' WHERE `locale` = 'ruRU' AND `entry` = 6746;
-- OLD name : Трактирщик Каут
-- Source : https://www.wowhead.com/wotlk/ru/npc=6747
UPDATE `creature_template_locale` SET `Name` = 'Каут' WHERE `locale` = 'ruRU' AND `entry` = 6747;
-- OLD name : Трактирщица Трилана
-- Source : https://www.wowhead.com/wotlk/ru/npc=6790
UPDATE `creature_template_locale` SET `Name` = 'Трилана' WHERE `locale` = 'ruRU' AND `entry` = 6790;
-- OLD name : Трактирщик Вихлюн
-- Source : https://www.wowhead.com/wotlk/ru/npc=6791
UPDATE `creature_template_locale` SET `Name` = 'Вихлюн' WHERE `locale` = 'ruRU' AND `entry` = 6791;
-- OLD name : Трактирщик Втридорог
-- Source : https://www.wowhead.com/wotlk/ru/npc=6807
UPDATE `creature_template_locale` SET `Name` = 'Втридорог' WHERE `locale` = 'ruRU' AND `entry` = 6807;
-- OLD name : Прибрежный краб
-- Source : https://www.wowhead.com/wotlk/ru/npc=6827
UPDATE `creature_template_locale` SET `Name` = 'Краб' WHERE `locale` = 'ruRU' AND `entry` = 6827;
-- OLD name : Начальник порта
-- Source : https://www.wowhead.com/wotlk/ru/npc=6846
UPDATE `creature_template_locale` SET `Name` = 'Портовый начальник из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 6846;
-- OLD name : Телохранитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=6866
UPDATE `creature_template_locale` SET `Name` = 'Телохранитель из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 6866;
-- OLD name : Онин МакМолот
-- Source : https://www.wowhead.com/wotlk/ru/npc=6886
UPDATE `creature_template_locale` SET `Name` = 'Онин Макмолот' WHERE `locale` = 'ruRU' AND `entry` = 6886;
-- OLD name : Портовый рабочий
-- Source : https://www.wowhead.com/wotlk/ru/npc=6927
UPDATE `creature_template_locale` SET `Name` = 'Докер из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 6927;
-- OLD name : Трактирщик Гроск
-- Source : https://www.wowhead.com/wotlk/ru/npc=6928
UPDATE `creature_template_locale` SET `Name` = 'Гроск' WHERE `locale` = 'ruRU' AND `entry` = 6928;
-- OLD name : Трактирщица Гришка
-- Source : https://www.wowhead.com/wotlk/ru/npc=6929
UPDATE `creature_template_locale` SET `Name` = 'Гришка' WHERE `locale` = 'ruRU' AND `entry` = 6929;
-- OLD name : Трактирщик Каракуль
-- Source : https://www.wowhead.com/wotlk/ru/npc=6930
UPDATE `creature_template_locale` SET `Name` = 'Каракуль' WHERE `locale` = 'ruRU' AND `entry` = 6930;
-- OLD subname : Сотрудник ШРУ
-- Source : https://www.wowhead.com/wotlk/ru/npc=6946
UPDATE `creature_template_locale` SET `Title` = 'Агент ШРУ' WHERE `locale` = 'ruRU' AND `entry` = 6946;
-- OLD subname : Скупщики Дрофферс и сын
-- Source : https://www.wowhead.com/wotlk/ru/npc=6986
UPDATE `creature_template_locale` SET `Title` = '"Скупщики Дрофферс и сын"' WHERE `locale` = 'ruRU' AND `entry` = 6986;
-- OLD subname : Скупщики Дрофферс и сын
-- Source : https://www.wowhead.com/wotlk/ru/npc=6987
UPDATE `creature_template_locale` SET `Title` = '"Скупщики Дрофферс и сын"' WHERE `locale` = 'ruRU' AND `entry` = 6987;
-- OLD name : Стражник из клана Черной горы
-- Source : https://www.wowhead.com/wotlk/ru/npc=7013
UPDATE `creature_template_locale` SET `Name` = 'Буян из клана Черной Горы' WHERE `locale` = 'ruRU' AND `entry` = 7013;
-- OLD name : Агент Кеарнен
-- Source : https://www.wowhead.com/wotlk/ru/npc=7024
UPDATE `creature_template_locale` SET `Name` = 'Агент Кирнен' WHERE `locale` = 'ruRU' AND `entry` = 7024;
-- OLD name : Чернокнижник клана Черной горы
-- Source : https://www.wowhead.com/wotlk/ru/npc=7028
UPDATE `creature_template_locale` SET `Name` = 'Чернокнижник из клана Черной горы' WHERE `locale` = 'ruRU' AND `entry` = 7028;
-- OLD name : Ворг из клана Черной горы
-- Source : https://www.wowhead.com/wotlk/ru/npc=7055
UPDATE `creature_template_locale` SET `Name` = 'Ворг клана Черной горы' WHERE `locale` = 'ruRU' AND `entry` = 7055;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=7089
UPDATE `creature_template_locale` SET `Title` = 'Учительница снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 7089;
-- OLD name : Слуга-демон Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=7130
UPDATE `creature_template_locale` SET `Name` = 'Демон Бездны - слуга' WHERE `locale` = 'ruRU' AND `entry` = 7130;
-- OLD name : Страж-демон Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=7131
UPDATE `creature_template_locale` SET `Name` = 'Демон Бездны - страж' WHERE `locale` = 'ruRU' AND `entry` = 7131;
-- OLD subname : Учитель оружейного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=7173
UPDATE `creature_template_locale` SET `Title` = 'Учительница оружейного дела' WHERE `locale` = 'ruRU' AND `entry` = 7173;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=7174
UPDATE `creature_template_locale` SET `Title` = 'Учитель отковки брони' WHERE `locale` = 'ruRU' AND `entry` = 7174;
-- OLD name : Обсидиановый осколок
-- Source : https://www.wowhead.com/wotlk/ru/npc=7209
UPDATE `creature_template_locale` SET `Name` = 'Осколок обсидиана' WHERE `locale` = 'ruRU' AND `entry` = 7209;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=7230
UPDATE `creature_template_locale` SET `Title` = 'Учитель бронников' WHERE `locale` = 'ruRU' AND `entry` = 7230;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=7231
UPDATE `creature_template_locale` SET `Title` = 'Учитель оружейного дела' WHERE `locale` = 'ruRU' AND `entry` = 7231;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=7232
UPDATE `creature_template_locale` SET `Title` = 'Учитель оружейного дела' WHERE `locale` = 'ruRU' AND `entry` = 7232;
-- OLD name : Темный охотник из клана Песчаной Бури
-- Source : https://www.wowhead.com/wotlk/ru/npc=7246
UPDATE `creature_template_locale` SET `Name` = 'Темный охотник из племени Песчаной Бури' WHERE `locale` = 'ruRU' AND `entry` = 7246;
-- OLD name : Знахарь Зум'рах
-- Source : https://www.wowhead.com/wotlk/ru/npc=7271
UPDATE `creature_template_locale` SET `Name` = 'Знахарь Зум''ра' WHERE `locale` = 'ruRU' AND `entry` = 7271;
-- OLD name : Палач из клана Песчаной Бури
-- Source : https://www.wowhead.com/wotlk/ru/npc=7274
UPDATE `creature_template_locale` SET `Name` = 'Палач из племени Песчаной Бури' WHERE `locale` = 'ruRU' AND `entry` = 7274;
-- OLD name : Темный жрец Шезз'зиз
-- Source : https://www.wowhead.com/wotlk/ru/npc=7275
UPDATE `creature_template_locale` SET `Name` = 'Жрец Тьмы Шезз''зиз' WHERE `locale` = 'ruRU' AND `entry` = 7275;
-- OLD name : Мутировавший мертвяк Торговой Компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=7310
UPDATE `creature_template_locale` SET `Name` = 'Мутировавший мертвяк из Торговой компании' WHERE `locale` = 'ruRU' AND `entry` = 7310;
-- OLD name : Черный ночной саблезуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=7322
UPDATE `creature_template_locale` SET `Name` = 'Ночной саблезуб' WHERE `locale` = 'ruRU' AND `entry` = 7322;
-- OLD subname : Волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=7323
UPDATE `creature_template_locale` SET `Title` = '"Волк"' WHERE `locale` = 'ruRU' AND `entry` = 7323;
-- OLD name : Скелет-ледоплет
-- Source : https://www.wowhead.com/wotlk/ru/npc=7341
UPDATE `creature_template_locale` SET `Name` = 'Скелет - повелитель льда' WHERE `locale` = 'ruRU' AND `entry` = 7341;
-- OLD name : Подгородский таракан
-- Source : https://www.wowhead.com/wotlk/ru/npc=7395
UPDATE `creature_template_locale` SET `Name` = 'Тараканище' WHERE `locale` = 'ruRU' AND `entry` = 7395;
-- OLD name : Ловчий ледопард
-- Source : https://www.wowhead.com/wotlk/ru/npc=7432
UPDATE `creature_template_locale` SET `Name` = 'Ледопард-ловец' WHERE `locale` = 'ruRU' AND `entry` = 7432;
-- OLD name : Кобальтовая чаровязка
-- Source : https://www.wowhead.com/wotlk/ru/npc=7437
UPDATE `creature_template_locale` SET `Name` = 'Кобальтовая чаротворица' WHERE `locale` = 'ruRU' AND `entry` = 7437;
-- OLD name : Волшебник крови Дразиал
-- Source : https://www.wowhead.com/wotlk/ru/npc=7505
UPDATE `creature_template_locale` SET `Name` = 'Маг крови Дразиал' WHERE `locale` = 'ruRU' AND `entry` = 7505;
-- OLD name : World Leatherworking Dragonscale Trainer (NO LONGER IMPLEMENTED), subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=7525
UPDATE `creature_template_locale` SET `Name` = 'Мир - учитель - кожевничество - драконья чешуя',`Title` = 'Учитель кожевничества: драконьи шкуры' WHERE `locale` = 'ruRU' AND `entry` = 7525;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=7526
UPDATE `creature_template_locale` SET `Title` = 'Учитель кожевничества: сила стихий' WHERE `locale` = 'ruRU' AND `entry` = 7526;
-- OLD name : World Leatherworking Tribal Trainer (NO LONGER WORKING), subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=7528
UPDATE `creature_template_locale` SET `Name` = 'Мир - учитель - кожевничество - дикаря',`Title` = 'Учитель кожевничества: традиции предков' WHERE `locale` = 'ruRU' AND `entry` = 7528;
-- OLD name : Большая рогатая сова
-- Source : https://www.wowhead.com/wotlk/ru/npc=7553
UPDATE `creature_template_locale` SET `Name` = 'Большой рогатый филин' WHERE `locale` = 'ruRU' AND `entry` = 7553;
-- OLD name : Cottontail Rabbit
-- Source : https://www.wowhead.com/wotlk/ru/npc=7558
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 7558;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7558, 'ruRU','Зайчик-побегайчик',NULL);
-- OLD name : Spotted Rabbit
-- Source : https://www.wowhead.com/wotlk/ru/npc=7559
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 7559;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7559, 'ruRU','Пятнистый кролик',NULL);
-- OLD name : Ворона
-- Source : https://www.wowhead.com/wotlk/ru/npc=7605
UPDATE `creature_template_locale` SET `Name` = 'Ворон' WHERE `locale` = 'ruRU' AND `entry` = 7605;
-- OLD name : Тестовый рыцарь Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=7624
UPDATE `creature_template_locale` SET `Name` = 'Test Death Knight' WHERE `locale` = 'ruRU' AND `entry` = 7624;
-- OLD name : Леопард
-- Source : https://www.wowhead.com/wotlk/ru/npc=7684
UPDATE `creature_template_locale` SET `Name` = 'Желтый тигр' WHERE `locale` = 'ruRU' AND `entry` = 7684;
-- OLD name : Бенгальский тигр
-- Source : https://www.wowhead.com/wotlk/ru/npc=7686
UPDATE `creature_template_locale` SET `Name` = 'Красный тигр' WHERE `locale` = 'ruRU' AND `entry` = 7686;
-- OLD name : Пятнистый ночной саблезуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=7689
UPDATE `creature_template_locale` SET `Name` = 'Пятнистый черный тигр' WHERE `locale` = 'ruRU' AND `entry` = 7689;
-- OLD name : Крапчатый красный ящер
-- Source : https://www.wowhead.com/wotlk/ru/npc=7704
UPDATE `creature_template_locale` SET `Name` = 'Малиновый ящер' WHERE `locale` = 'ruRU' AND `entry` = 7704;
-- OLD name : Палевый ящер
-- Source : https://www.wowhead.com/wotlk/ru/npc=7706
UPDATE `creature_template_locale` SET `Name` = 'Кремовый ящер' WHERE `locale` = 'ruRU' AND `entry` = 7706;
-- OLD name : Бьюла, subname : Бывший хозяин таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=7714
UPDATE `creature_template_locale` SET `Name` = 'Хозяин таверны Быкко',`Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 7714;
-- OLD name : Натуралист племени Зловещего Тотема
-- Source : https://www.wowhead.com/wotlk/ru/npc=7726
UPDATE `creature_template_locale` SET `Name` = 'Натуралист из племени Зловещего Тотема' WHERE `locale` = 'ruRU' AND `entry` = 7726;
-- OLD name : Шаман племени Зловещего Тотема
-- Source : https://www.wowhead.com/wotlk/ru/npc=7727
UPDATE `creature_template_locale` SET `Name` = 'Шаман из племени Зловещего Тотема' WHERE `locale` = 'ruRU' AND `entry` = 7727;
-- OLD name : Рубака Когтистых гор
-- Source : https://www.wowhead.com/wotlk/ru/npc=7730
UPDATE `creature_template_locale` SET `Name` = 'Рубака с Когтистых гор' WHERE `locale` = 'ruRU' AND `entry` = 7730;
-- OLD name : Трактирщица Джайка
-- Source : https://www.wowhead.com/wotlk/ru/npc=7731
UPDATE `creature_template_locale` SET `Name` = 'Джайка' WHERE `locale` = 'ruRU' AND `entry` = 7731;
-- OLD name : Трактирщик Ворчунелло
-- Source : https://www.wowhead.com/wotlk/ru/npc=7733
UPDATE `creature_template_locale` SET `Name` = 'Ворчунелло' WHERE `locale` = 'ruRU' AND `entry` = 7733;
-- OLD name : Трактирщица Шария
-- Source : https://www.wowhead.com/wotlk/ru/npc=7736
UPDATE `creature_template_locale` SET `Name` = 'Шария' WHERE `locale` = 'ruRU' AND `entry` = 7736;
-- OLD name : Трактирщица Греула
-- Source : https://www.wowhead.com/wotlk/ru/npc=7737
UPDATE `creature_template_locale` SET `Name` = 'Греула' WHERE `locale` = 'ruRU' AND `entry` = 7737;
-- OLD subname : Учитель верховой езды нежити
-- Source : https://www.wowhead.com/wotlk/ru/npc=7743
UPDATE `creature_template_locale` SET `Title` = 'Учительница верховой езды нежити' WHERE `locale` = 'ruRU' AND `entry` = 7743;
-- OLD name : Трактирщик Тулфрам
-- Source : https://www.wowhead.com/wotlk/ru/npc=7744
UPDATE `creature_template_locale` SET `Name` = 'Тулфрам' WHERE `locale` = 'ruRU' AND `entry` = 7744;
-- OLD subname : Учитель верховой езды на ящерах
-- Source : https://www.wowhead.com/wotlk/ru/npc=7745
UPDATE `creature_template_locale` SET `Title` = 'Учительница верховой езды на ящерах' WHERE `locale` = 'ruRU' AND `entry` = 7745;
-- OLD name : Мир - учитель - езда на механоходунах, subname : Учитель вождения механодолгоногов
-- Source : https://www.wowhead.com/wotlk/ru/npc=7746
UPDATE `creature_template_locale` SET `Name` = 'Мир - учительница верховой езды на механодолгоногах',`Title` = 'Учительница верховой езды на механодолгоногах' WHERE `locale` = 'ruRU' AND `entry` = 7746;
-- OLD subname : Продавец верховых животных
-- Source : https://www.wowhead.com/wotlk/ru/npc=7747
UPDATE `creature_template_locale` SET `Title` = 'Торговка транспортом' WHERE `locale` = 'ruRU' AND `entry` = 7747;
-- OLD name : Жрица Тирония
-- Source : https://www.wowhead.com/wotlk/ru/npc=7779
UPDATE `creature_template_locale` SET `Name` = 'Жрица Тириона' WHERE `locale` = 'ruRU' AND `entry` = 7779;
-- OLD name : Самонаводящийся робот КПХ-17/TN
-- Source : https://www.wowhead.com/wotlk/ru/npc=7784
UPDATE `creature_template_locale` SET `Name` = 'Самонаводящийся робот КПХ-17/ТН' WHERE `locale` = 'ruRU' AND `entry` = 7784;
-- OLD name : Оберег Зум'раха
-- Source : https://www.wowhead.com/wotlk/ru/npc=7785
UPDATE `creature_template_locale` SET `Name` = 'Оберег Зум''ра' WHERE `locale` = 'ruRU' AND `entry` = 7785;
-- OLD name : Скелет Зум'раха
-- Source : https://www.wowhead.com/wotlk/ru/npc=7786
UPDATE `creature_template_locale` SET `Name` = 'Скелет Зум''ра' WHERE `locale` = 'ruRU' AND `entry` = 7786;
-- OLD name : Гидромант Велрата
-- Source : https://www.wowhead.com/wotlk/ru/npc=7795
UPDATE `creature_template_locale` SET `Name` = 'Гидромантка Велрата' WHERE `locale` = 'ruRU' AND `entry` = 7795;
-- OLD name : Ханк Молот
-- Source : https://www.wowhead.com/wotlk/ru/npc=7798
UPDATE `creature_template_locale` SET `Name` = 'Хэнк Молот' WHERE `locale` = 'ruRU' AND `entry` = 7798;
-- OLD name : Самонаводящийся робот КПХ-9/HL
-- Source : https://www.wowhead.com/wotlk/ru/npc=7806
UPDATE `creature_template_locale` SET `Name` = 'Самонаводящийся робот КПХ-9/ВЗ' WHERE `locale` = 'ruRU' AND `entry` = 7806;
-- OLD name : Самонаводящийся робот КПX-22/FE
-- Source : https://www.wowhead.com/wotlk/ru/npc=7807
UPDATE `creature_template_locale` SET `Name` = 'Самонаводящийся робот КПX-22/ФЕ' WHERE `locale` = 'ruRU' AND `entry` = 7807;
-- OLD name : Пират Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=7855
UPDATE `creature_template_locale` SET `Name` = 'Пират из братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 7855;
-- OLD name : Флибустьер Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=7856
UPDATE `creature_template_locale` SET `Name` = 'Флибустьер из братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 7856;
-- OLD name : Рабочий из порта Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=7857
UPDATE `creature_template_locale` SET `Name` = 'Портовый рабочий из братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 7857;
-- OLD name : Сорвиголова Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=7858
UPDATE `creature_template_locale` SET `Name` = 'Сорвиголова из братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 7858;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=7866
UPDATE `creature_template_locale` SET `Title` = 'Учитель кожевничества: чешуя дракона' WHERE `locale` = 'ruRU' AND `entry` = 7866;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=7867
UPDATE `creature_template_locale` SET `Title` = 'Учитель кожевничества: чешуя дракона' WHERE `locale` = 'ruRU' AND `entry` = 7867;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=7868
UPDATE `creature_template_locale` SET `Title` = 'Учитель кожевничества: сила стихий' WHERE `locale` = 'ruRU' AND `entry` = 7868;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=7869
UPDATE `creature_template_locale` SET `Title` = 'Учитель кожевничества: сила стихий' WHERE `locale` = 'ruRU' AND `entry` = 7869;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=7870
UPDATE `creature_template_locale` SET `Title` = 'Учитель кожевничества: традиции предков' WHERE `locale` = 'ruRU' AND `entry` = 7870;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=7871
UPDATE `creature_template_locale` SET `Title` = 'Учитель кожевничества: традиции предков' WHERE `locale` = 'ruRU' AND `entry` = 7871;
-- OLD name : Буканьер Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=7896
UPDATE `creature_template_locale` SET `Name` = 'Буканьер из братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 7896;
-- OLD name : Пират-охотник за сокровищами
-- Source : https://www.wowhead.com/wotlk/ru/npc=7899
UPDATE `creature_template_locale` SET `Name` = 'Пират - охотник за сокровищами' WHERE `locale` = 'ruRU' AND `entry` = 7899;
-- OLD subname : Продавец рыбы
-- Source : https://www.wowhead.com/wotlk/ru/npc=7943
UPDATE `creature_template_locale` SET `Title` = 'Торговец рыбой' WHERE `locale` = 'ruRU' AND `entry` = 7943;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=7948
UPDATE `creature_template_locale` SET `Title` = 'Учительница алхимии' WHERE `locale` = 'ruRU' AND `entry` = 7948;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=7949
UPDATE `creature_template_locale` SET `Title` = 'Учительница наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 7949;
-- OLD subname : Учитель верховой езды
-- Source : https://www.wowhead.com/wotlk/ru/npc=7954
UPDATE `creature_template_locale` SET `Title` = 'Водитель механодолгоногов' WHERE `locale` = 'ruRU' AND `entry` = 7954;
-- OLD subname : Торговец механодолгоногами
-- Source : https://www.wowhead.com/wotlk/ru/npc=7955
UPDATE `creature_template_locale` SET `Title` = 'Торговка механодолгоногами' WHERE `locale` = 'ruRU' AND `entry` = 7955;
-- OLD name : Кинда Лунная Пряжа
-- Source : https://www.wowhead.com/wotlk/ru/npc=7956
UPDATE `creature_template_locale` SET `Name` = 'Киндел Лунная Пряжа' WHERE `locale` = 'ruRU' AND `entry` = 7956;
-- OLD name : Джер'ка Лунная Пряжа
-- Source : https://www.wowhead.com/wotlk/ru/npc=7957
UPDATE `creature_template_locale` SET `Name` = 'Джер''кай Лунная Пряжа' WHERE `locale` = 'ruRU' AND `entry` = 7957;
-- OLD name : Храбрец лагеря Нараче
-- Source : https://www.wowhead.com/wotlk/ru/npc=7975
UPDATE `creature_template_locale` SET `Name` = 'Мулгорский заступник' WHERE `locale` = 'ruRU' AND `entry` = 7975;
-- OLD name : Талгус Брат Грома
-- Source : https://www.wowhead.com/wotlk/ru/npc=7976
UPDATE `creature_template_locale` SET `Name` = 'Талгус Громовой Кулак' WHERE `locale` = 'ruRU' AND `entry` = 7976;
-- OLD subname : Продавец фруктов
-- Source : https://www.wowhead.com/wotlk/ru/npc=7978
UPDATE `creature_template_locale` SET `Title` = 'Торговка фруктами' WHERE `locale` = 'ruRU' AND `entry` = 7978;
-- OLD name : Гутрум Брат Грома
-- Source : https://www.wowhead.com/wotlk/ru/npc=8018
UPDATE `creature_template_locale` SET `Name` = 'Гутрум Громовой Кулак' WHERE `locale` = 'ruRU' AND `entry` = 8018;
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=8020
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 8020;
-- OLD name : Дружинник Западного Края, subname : The People's Militia
-- Source : https://www.wowhead.com/wotlk/ru/npc=8096
UPDATE `creature_template_locale` SET `Name` = 'Народный заступник',`Title` = 'Народное ополчение' WHERE `locale` = 'ruRU' AND `entry` = 8096;
-- OLD name : Углекрыл
-- Source : https://www.wowhead.com/wotlk/ru/npc=8207
UPDATE `creature_template_locale` SET `Name` = 'Большой огнекрыл' WHERE `locale` = 'ruRU' AND `entry` = 8207;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=8306
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 8306;
-- OLD name : Дух мертвоброда из племени Атал'ай
-- Source : https://www.wowhead.com/wotlk/ru/npc=8317
UPDATE `creature_template_locale` SET `Name` = 'Дух вестника смерти из племени Атал''ай' WHERE `locale` = 'ruRU' AND `entry` = 8317;
-- OLD name : Раб племени Атал'ай
-- Source : https://www.wowhead.com/wotlk/ru/npc=8318
UPDATE `creature_template_locale` SET `Name` = 'Раб из племени Атал''ай' WHERE `locale` = 'ruRU' AND `entry` = 8318;
-- OLD name : Скелет из племени Атал'ай
-- Source : https://www.wowhead.com/wotlk/ru/npc=8324
UPDATE `creature_template_locale` SET `Name` = 'Скелет племени Атал''ай' WHERE `locale` = 'ruRU' AND `entry` = 8324;
-- OLD name : Чугунорез клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=8337
UPDATE `creature_template_locale` SET `Name` = 'Чугунорез из клана Черного Железа' WHERE `locale` = 'ruRU' AND `entry` = 8337;
-- OLD subname : Продавец сумок
-- Source : https://www.wowhead.com/wotlk/ru/npc=8364
UPDATE `creature_template_locale` SET `Title` = 'Торговка сумками' WHERE `locale` = 'ruRU' AND `entry` = 8364;
-- OLD name : Мастер Дуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=8383
UPDATE `creature_template_locale` SET `Name` = 'Мастер Вуд' WHERE `locale` = 'ruRU' AND `entry` = 8383;
-- OLD name : Ксан'Тиш
-- Source : https://www.wowhead.com/wotlk/ru/npc=8404
UPDATE `creature_template_locale` SET `Name` = 'Зан''Тиш' WHERE `locale` = 'ruRU' AND `entry` = 8404;
-- OLD name : Прислужник племени Хаккари
-- Source : https://www.wowhead.com/wotlk/ru/npc=8437
UPDATE `creature_template_locale` SET `Name` = 'Прислужник из племени Хаккари' WHERE `locale` = 'ruRU' AND `entry` = 8437;
-- OLD name : Каларан Ветрорез
-- Source : https://www.wowhead.com/wotlk/ru/npc=8479
UPDATE `creature_template_locale` SET `Name` = 'Веларок Ветрорез' WHERE `locale` = 'ruRU' AND `entry` = 8479;
-- OLD name : Каларан Обманщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=8480
UPDATE `creature_template_locale` SET `Name` = 'Веларок Обманщик' WHERE `locale` = 'ruRU' AND `entry` = 8480;
-- OLD name : Тотем Атал'ай
-- Source : https://www.wowhead.com/wotlk/ru/npc=8510
UPDATE `creature_template_locale` SET `Name` = 'Тотем племени Атал''ай' WHERE `locale` = 'ruRU' AND `entry` = 8510;
-- OLD name : Зачумленный ужас
-- Source : https://www.wowhead.com/wotlk/ru/npc=8521
UPDATE `creature_template_locale` SET `Name` = 'Чумной ужас' WHERE `locale` = 'ruRU' AND `entry` = 8521;
-- OLD name : Ужасный некрорахнид
-- Source : https://www.wowhead.com/wotlk/ru/npc=8557
UPDATE `creature_template_locale` SET `Name` = 'Ужасный некроарахнид' WHERE `locale` = 'ruRU' AND `entry` = 8557;
-- OLD name : Разведчик дорог
-- Source : https://www.wowhead.com/wotlk/ru/npc=8565
UPDATE `creature_template_locale` SET `Name` = 'Разведчица дорог' WHERE `locale` = 'ruRU' AND `entry` = 8565;
-- OLD name : Большой чумной пес
-- Source : https://www.wowhead.com/wotlk/ru/npc=8599
UPDATE `creature_template_locale` SET `Name` = 'Чумной мастиф' WHERE `locale` = 'ruRU' AND `entry` = 8599;
-- OLD name : Служительница солнца Саерн
-- Source : https://www.wowhead.com/wotlk/ru/npc=8664
UPDATE `creature_template_locale` SET `Name` = 'Саерн Гордая Поступь' WHERE `locale` = 'ruRU' AND `entry` = 8664;
-- OLD subname : Учитель гномского инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=8676
UPDATE `creature_template_locale` SET `Title` = 'Учительница гномского инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 8676;
-- OLD name : Послушник из клана Песчаной Бури
-- Source : https://www.wowhead.com/wotlk/ru/npc=8876
UPDATE `creature_template_locale` SET `Name` = 'Послушник из племени Песчаной Бури' WHERE `locale` = 'ruRU' AND `entry` = 8876;
-- OLD name : Ездовой баран
-- Source : https://www.wowhead.com/wotlk/ru/npc=8881
UPDATE `creature_template_locale` SET `Name` = 'Скаковой баран' WHERE `locale` = 'ruRU' AND `entry` = 8881;
-- OLD name : Ездовой тигр
-- Source : https://www.wowhead.com/wotlk/ru/npc=8882
UPDATE `creature_template_locale` SET `Name` = 'Верховой тигр' WHERE `locale` = 'ruRU' AND `entry` = 8882;
-- OLD name : Наблюдающий за поединком
-- Source : https://www.wowhead.com/wotlk/ru/npc=8916
UPDATE `creature_template_locale` SET `Name` = 'Зритель арены' WHERE `locale` = 'ruRU' AND `entry` = 8916;
-- OLD name : Раб с каменоломни
-- Source : https://www.wowhead.com/wotlk/ru/npc=8917
UPDATE `creature_template_locale` SET `Name` = 'Раб из каменоломни' WHERE `locale` = 'ruRU' AND `entry` = 8917;
-- OLD name : Трактирщица Хизер
-- Source : https://www.wowhead.com/wotlk/ru/npc=8931
UPDATE `creature_template_locale` SET `Name` = 'Хизер' WHERE `locale` = 'ruRU' AND `entry` = 8931;
-- OLD name : Нида
-- Source : https://www.wowhead.com/wotlk/ru/npc=8962
UPDATE `creature_template_locale` SET `Name` = 'Хилари' WHERE `locale` = 'ruRU' AND `entry` = 8962;
-- OLD name : Прислужник-демон Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=8996
UPDATE `creature_template_locale` SET `Name` = 'Демон Бездны - прислужник' WHERE `locale` = 'ruRU' AND `entry` = 8996;
-- OLD name : Бейл'Гор
-- Source : https://www.wowhead.com/wotlk/ru/npc=9016
UPDATE `creature_template_locale` SET `Name` = 'Бейл''Гар' WHERE `locale` = 'ruRU' AND `entry` = 9016;
-- OLD name : Интендант из легиона Изрубленного Щита
-- Source : https://www.wowhead.com/wotlk/ru/npc=9046
UPDATE `creature_template_locale` SET `Name` = 'Интендант легиона Изрубленного Щита' WHERE `locale` = 'ruRU' AND `entry` = 9046;
-- OLD name : Горлоп
-- Source : https://www.wowhead.com/wotlk/ru/npc=9176
UPDATE `creature_template_locale` SET `Name` = 'Гор''теш' WHERE `locale` = 'ruRU' AND `entry` = 9176;
-- OLD name : Жрец Тени из племени Тлеющего Терновника
-- Source : https://www.wowhead.com/wotlk/ru/npc=9240
UPDATE `creature_template_locale` SET `Name` = 'Жрец Тьмы из племени Тлеющего Терновника' WHERE `locale` = 'ruRU' AND `entry` = 9240;
-- OLD name : Трактирщик Шул'кар
-- Source : https://www.wowhead.com/wotlk/ru/npc=9356
UPDATE `creature_template_locale` SET `Name` = 'Шул''кар' WHERE `locale` = 'ruRU' AND `entry` = 9356;
-- OLD name : Ожившая окаменелость
-- Source : https://www.wowhead.com/wotlk/ru/npc=9397
UPDATE `creature_template_locale` SET `Name` = 'Живая буря' WHERE `locale` = 'ruRU' AND `entry` = 9397;
-- OLD name : Порождение Бейл'Гора
-- Source : https://www.wowhead.com/wotlk/ru/npc=9436
UPDATE `creature_template_locale` SET `Name` = 'Порождение Бейл''Гара' WHERE `locale` = 'ruRU' AND `entry` = 9436;
-- OLD name : Чаротворец Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=9452
UPDATE `creature_template_locale` SET `Name` = 'Чаротворец из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 9452;
-- OLD name : Трактирщик Адегва
-- Source : https://www.wowhead.com/wotlk/ru/npc=9501
UPDATE `creature_template_locale` SET `Name` = 'Адегва' WHERE `locale` = 'ruRU' AND `entry` = 9501;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=9552
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 9552;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=9553
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 9553;
-- OLD name : Отшвартуй
-- Source : https://www.wowhead.com/wotlk/ru/npc=9558
UPDATE `creature_template_locale` SET `Name` = 'Гримбл' WHERE `locale` = 'ruRU' AND `entry` = 9558;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=9584
UPDATE `creature_template_locale` SET `Title` = 'Учительница шитья из тенеткани' WHERE `locale` = 'ruRU' AND `entry` = 9584;
-- OLD name : Мир, смотритель стойл, subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=9896
UPDATE `creature_template_locale` SET `Name` = 'Мир, смотрительница стойл',`Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 9896;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=9977
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 9977;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=9979
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 9979;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=9980
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 9980;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=9981
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 9981;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=9982
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 9982;
-- OLD subname : Бывший смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=9983
UPDATE `creature_template_locale` SET `Title` = 'Смотритель стойл' WHERE `locale` = 'ruRU' AND `entry` = 9983;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=9986
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 9986;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=9989
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 9989;
-- OLD name : Головорез Гиблотопи
-- Source : https://www.wowhead.com/wotlk/ru/npc=10036
UPDATE `creature_template_locale` SET `Name` = 'Головорез из Гиблотопи' WHERE `locale` = 'ruRU' AND `entry` = 10036;
-- OLD name : Стражник Приозерья
-- Source : https://www.wowhead.com/wotlk/ru/npc=10037
UPDATE `creature_template_locale` SET `Name` = 'Стражник из Приозерья' WHERE `locale` = 'ruRU' AND `entry` = 10037;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=10046
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 10046;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=10050
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 10050;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=10051
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 10051;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=10053
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 10053;
-- OLD name : Антарий, subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=10059
UPDATE `creature_template_locale` SET `Name` = 'Антария',`Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 10059;
-- OLD name : Джеласия, subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=10085
UPDATE `creature_template_locale` SET `Name` = 'Джелисия',`Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 10085;
-- OLD name : Обреченный раб
-- Source : https://www.wowhead.com/wotlk/ru/npc=10116
UPDATE `creature_template_locale` SET `Name` = 'Раб' WHERE `locale` = 'ruRU' AND `entry` = 10116;
-- OLD name : Несса Песня Теней
-- Source : https://www.wowhead.com/wotlk/ru/npc=10118
UPDATE `creature_template_locale` SET `Name` = 'Несса Песнь Теней' WHERE `locale` = 'ruRU' AND `entry` = 10118;
-- OLD name : Тюремщик подземелья
-- Source : https://www.wowhead.com/wotlk/ru/npc=10120
UPDATE `creature_template_locale` SET `Name` = 'Страж подземелья' WHERE `locale` = 'ruRU' AND `entry` = 10120;
-- OLD name : Флюоресцирующий зеленый механодолгоног
-- Source : https://www.wowhead.com/wotlk/ru/npc=10178
UPDATE `creature_template_locale` SET `Name` = 'Зеленый флюоресцентный механодолгоног' WHERE `locale` = 'ruRU' AND `entry` = 10178;
-- OLD name : Белый механодолгоног модель Б
-- Source : https://www.wowhead.com/wotlk/ru/npc=10179
UPDATE `creature_template_locale` SET `Name` = 'Черный механодолгоног' WHERE `locale` = 'ruRU' AND `entry` = 10179;
-- OLD name : Тотем удара пламени
-- Source : https://www.wowhead.com/wotlk/ru/npc=10217
UPDATE `creature_template_locale` SET `Name` = 'Тотем огненного удара' WHERE `locale` = 'ruRU' AND `entry` = 10217;
-- OLD subname : Dagger Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=10292
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по кинжалам' WHERE `locale` = 'ruRU' AND `entry` = 10292;
-- OLD subname : Торговец тканевыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=10293
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканевыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 10293;
-- OLD subname : Fist Weapons Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=10294
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по кистевому оружию' WHERE `locale` = 'ruRU' AND `entry` = 10294;
-- OLD name : Акрайд
-- Source : https://www.wowhead.com/wotlk/ru/npc=10296
UPDATE `creature_template_locale` SET `Name` = 'Ваэлан' WHERE `locale` = 'ruRU' AND `entry` = 10296;
-- OLD name : Герратис Ночной Гонец, subname : Bow Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=10297
UPDATE `creature_template_locale` SET `Name` = 'Герратис Ночной Вестник',`Title` = 'Экперт по лукам' WHERE `locale` = 'ruRU' AND `entry` = 10297;
-- OLD name : Траелион Тенешепот
-- Source : https://www.wowhead.com/wotlk/ru/npc=10298
UPDATE `creature_template_locale` SET `Name` = 'Траелион Шепот Тени' WHERE `locale` = 'ruRU' AND `entry` = 10298;
-- OLD name : Акрайд
-- Source : https://www.wowhead.com/wotlk/ru/npc=10299
UPDATE `creature_template_locale` SET `Name` = 'Секретный агент из легиона Изрубленного Щита' WHERE `locale` = 'ruRU' AND `entry` = 10299;
-- OLD subname : Explorers' League
-- Source : https://www.wowhead.com/wotlk/ru/npc=10301
UPDATE `creature_template_locale` SET `Title` = 'Лига исследователей' WHERE `locale` = 'ruRU' AND `entry` = 10301;
-- OLD name : Уми Румпельшникер
-- Source : https://www.wowhead.com/wotlk/ru/npc=10305
UPDATE `creature_template_locale` SET `Name` = 'Уми Смехотреп' WHERE `locale` = 'ruRU' AND `entry` = 10305;
-- OLD name : Знахарь Мау'ари
-- Source : https://www.wowhead.com/wotlk/ru/npc=10307
UPDATE `creature_template_locale` SET `Name` = 'Знахарка Мау''ари' WHERE `locale` = 'ruRU' AND `entry` = 10307;
-- OLD name : Тюремщик легиона Чернорука
-- Source : https://www.wowhead.com/wotlk/ru/npc=10316
UPDATE `creature_template_locale` SET `Name` = 'Тюремщик из легиона Чернорука' WHERE `locale` = 'ruRU' AND `entry` = 10316;
-- OLD name : Элитный боец легиона Чернорука
-- Source : https://www.wowhead.com/wotlk/ru/npc=10317
UPDATE `creature_template_locale` SET `Name` = 'Элитный боец из легиона Чернорука' WHERE `locale` = 'ruRU' AND `entry` = 10317;
-- OLD name : Железный страж легиона Чернорука
-- Source : https://www.wowhead.com/wotlk/ru/npc=10319
UPDATE `creature_template_locale` SET `Name` = 'Железный страж из легиона Чернорука' WHERE `locale` = 'ruRU' AND `entry` = 10319;
-- OLD name : Древний ледопард
-- Source : https://www.wowhead.com/wotlk/ru/npc=10322
UPDATE `creature_template_locale` SET `Name` = 'Белый тигр' WHERE `locale` = 'ruRU' AND `entry` = 10322;
-- OLD name : Первобытный ледопард
-- Source : https://www.wowhead.com/wotlk/ru/npc=10336
UPDATE `creature_template_locale` SET `Name` = 'Пятнистый тигр' WHERE `locale` = 'ruRU' AND `entry` = 10336;
-- OLD name : Рыжий саблезуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=10337
UPDATE `creature_template_locale` SET `Name` = 'Рыжий тигр' WHERE `locale` = 'ruRU' AND `entry` = 10337;
-- OLD name : Золотой саблезуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=10338
UPDATE `creature_template_locale` SET `Name` = 'Золотой тигр' WHERE `locale` = 'ruRU' AND `entry` = 10338;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=10360
UPDATE `creature_template_locale` SET `Title` = 'Военачальник ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 10360;
-- OLD name : Яэлика Длинный Коготь
-- Source : https://www.wowhead.com/wotlk/ru/npc=10364
UPDATE `creature_template_locale` SET `Name` = 'Яэлика Длиннокогт' WHERE `locale` = 'ruRU' AND `entry` = 10364;
-- OLD name : Тузадинский послушник
-- Source : https://www.wowhead.com/wotlk/ru/npc=10399
UPDATE `creature_template_locale` SET `Name` = 'Послушник из секты Тузадин' WHERE `locale` = 'ruRU' AND `entry` = 10399;
-- OLD name : Тузадинский некромант
-- Source : https://www.wowhead.com/wotlk/ru/npc=10400
UPDATE `creature_template_locale` SET `Name` = 'Некромант из секты Тузадин' WHERE `locale` = 'ruRU' AND `entry` = 10400;
-- OLD name : Скалокрылая гаргулья
-- Source : https://www.wowhead.com/wotlk/ru/npc=10408
UPDATE `creature_template_locale` SET `Name` = 'Скалокрылая горгулья' WHERE `locale` = 'ruRU' AND `entry` = 10408;
-- OLD name : Охранник из Багрового Легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=10418
UPDATE `creature_template_locale` SET `Name` = 'Охранник из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 10418;
-- OLD name : Восставший окудник
-- Source : https://www.wowhead.com/wotlk/ru/npc=10419
UPDATE `creature_template_locale` SET `Name` = 'Окудник из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 10419;
-- OLD name : Восставший посвященный
-- Source : https://www.wowhead.com/wotlk/ru/npc=10420
UPDATE `creature_template_locale` SET `Name` = 'Посвященный из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 10420;
-- OLD name : Восставший защитник
-- Source : https://www.wowhead.com/wotlk/ru/npc=10421
UPDATE `creature_template_locale` SET `Name` = 'Защитник из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 10421;
-- OLD name : Восставший колдун
-- Source : https://www.wowhead.com/wotlk/ru/npc=10422
UPDATE `creature_template_locale` SET `Name` = 'Колдун из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 10422;
-- OLD name : Восставший жрец
-- Source : https://www.wowhead.com/wotlk/ru/npc=10423
UPDATE `creature_template_locale` SET `Name` = 'Жрец из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 10423;
-- OLD name : Восставший кавалер
-- Source : https://www.wowhead.com/wotlk/ru/npc=10424
UPDATE `creature_template_locale` SET `Name` = 'Кавалер из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 10424;
-- OLD name : Восставший боевой маг
-- Source : https://www.wowhead.com/wotlk/ru/npc=10425
UPDATE `creature_template_locale` SET `Name` = 'Боевой маг из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 10425;
-- OLD name : Восставший инквизитор
-- Source : https://www.wowhead.com/wotlk/ru/npc=10426
UPDATE `creature_template_locale` SET `Name` = 'Инквизитор из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 10426;
-- OLD name : Motega Firemane
-- Source : https://www.wowhead.com/wotlk/ru/npc=10428
UPDATE `creature_template_locale` SET `Name` = 'Мотега Огненная Грива' WHERE `locale` = 'ruRU' AND `entry` = 10428;
-- OLD name : Зверь
-- Source : https://www.wowhead.com/wotlk/ru/npc=10430
UPDATE `creature_template_locale` SET `Name` = 'Чудовище' WHERE `locale` = 'ruRU' AND `entry` = 10430;
-- OLD subname : Mace Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=10452
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по булавам' WHERE `locale` = 'ruRU' AND `entry` = 10452;
-- OLD name : Мрачбур Кремневый Топор, subname : Axe Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=10453
UPDATE `creature_template_locale` SET `Name` = 'Мрачбур Кремнетопор',`Title` = 'Эксперт по топорам' WHERE `locale` = 'ruRU' AND `entry` = 10453;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=10454
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по арбалетам' WHERE `locale` = 'ruRU' AND `entry` = 10454;
-- OLD name : Адепт Некроситета
-- Source : https://www.wowhead.com/wotlk/ru/npc=10469
UPDATE `creature_template_locale` SET `Name` = 'Адепт из Некроситета' WHERE `locale` = 'ruRU' AND `entry` = 10469;
-- OLD name : Неофит Некроситета
-- Source : https://www.wowhead.com/wotlk/ru/npc=10470
UPDATE `creature_template_locale` SET `Name` = 'Неофит из Некроситета' WHERE `locale` = 'ruRU' AND `entry` = 10470;
-- OLD name : Оккультист Некроситета
-- Source : https://www.wowhead.com/wotlk/ru/npc=10472
UPDATE `creature_template_locale` SET `Name` = 'Оккультист из Некроситета' WHERE `locale` = 'ruRU' AND `entry` = 10472;
-- OLD name : Темный чародей Некроситета
-- Source : https://www.wowhead.com/wotlk/ru/npc=10473
UPDATE `creature_template_locale` SET `Name` = 'Темный чародей из Некроситета' WHERE `locale` = 'ruRU' AND `entry` = 10473;
-- OLD name : Ученик Некроситета
-- Source : https://www.wowhead.com/wotlk/ru/npc=10475
UPDATE `creature_template_locale` SET `Name` = 'Ученик из Некроситета' WHERE `locale` = 'ruRU' AND `entry` = 10475;
-- OLD name : Некролит Некроситета
-- Source : https://www.wowhead.com/wotlk/ru/npc=10476
UPDATE `creature_template_locale` SET `Name` = 'Некролит из Некроситета' WHERE `locale` = 'ruRU' AND `entry` = 10476;
-- OLD name : Некромант Некроситета
-- Source : https://www.wowhead.com/wotlk/ru/npc=10477
UPDATE `creature_template_locale` SET `Name` = 'Некромант из Некроситета' WHERE `locale` = 'ruRU' AND `entry` = 10477;
-- OLD name : Восставшее создание
-- Source : https://www.wowhead.com/wotlk/ru/npc=10488
UPDATE `creature_template_locale` SET `Name` = 'Оживленный голем' WHERE `locale` = 'ruRU' AND `entry` = 10488;
-- OLD name : Тонтек Грохочущее копыто
-- Source : https://www.wowhead.com/wotlk/ru/npc=10600
UPDATE `creature_template_locale` SET `Name` = 'Тонтек Грохочущее Копыто' WHERE `locale` = 'ruRU' AND `entry` = 10600;
-- OLD subname : Охранник Риверна
-- Source : https://www.wowhead.com/wotlk/ru/npc=10619
UPDATE `creature_template_locale` SET `Title` = 'Охранница Риверна' WHERE `locale` = 'ruRU' AND `entry` = 10619;
-- OLD name : Вестница Печали
-- Source : https://www.wowhead.com/wotlk/ru/npc=10684
UPDATE `creature_template_locale` SET `Name` = 'Раскаявшаяся высокорожденная' WHERE `locale` = 'ruRU' AND `entry` = 10684;
-- OLD name : Укротитель драконов легиона Чернорука
-- Source : https://www.wowhead.com/wotlk/ru/npc=10742
UPDATE `creature_template_locale` SET `Name` = 'Укротитель драконов из легиона Чернорука' WHERE `locale` = 'ruRU' AND `entry` = 10742;
-- OLD name : Геомант племени Зловещего Тотема
-- Source : https://www.wowhead.com/wotlk/ru/npc=10760
UPDATE `creature_template_locale` SET `Name` = 'Геомант из племени Зловещего Тотема' WHERE `locale` = 'ruRU' AND `entry` = 10760;
-- OLD name : Айс Вентурон
-- Source : https://www.wowhead.com/wotlk/ru/npc=10776
UPDATE `creature_template_locale` SET `Name` = 'Пип Шустрикс' WHERE `locale` = 'ruRU' AND `entry` = 10776;
-- OLD name : Шар Обмана (человек, мужчина)
-- Source : https://www.wowhead.com/wotlk/ru/npc=10795
UPDATE `creature_template_locale` SET `Name` = 'Сфера Обмана (человек, мужчина)' WHERE `locale` = 'ruRU' AND `entry` = 10795;
-- OLD name : Шар Обмана (человек, женщина)
-- Source : https://www.wowhead.com/wotlk/ru/npc=10796
UPDATE `creature_template_locale` SET `Name` = 'Сфера Обмана (человек, женщина)' WHERE `locale` = 'ruRU' AND `entry` = 10796;
-- OLD name : Инструктор Галфорд
-- Source : https://www.wowhead.com/wotlk/ru/npc=10811
UPDATE `creature_template_locale` SET `Name` = 'Архивариус Галфорд' WHERE `locale` = 'ruRU' AND `entry` = 10811;
-- OLD name : Бальназар
-- Source : https://www.wowhead.com/wotlk/ru/npc=10813
UPDATE `creature_template_locale` SET `Name` = 'Балназзар' WHERE `locale` = 'ruRU' AND `entry` = 10813;
-- OLD name : Смертолов Ястребиное Копье
-- Source : https://www.wowhead.com/wotlk/ru/npc=10824
UPDATE `creature_template_locale` SET `Name` = 'Предводитель следопытов Ястребиное Копье' WHERE `locale` = 'ruRU' AND `entry` = 10824;
-- OLD name : Линния Аббендис
-- Source : https://www.wowhead.com/wotlk/ru/npc=10828
UPDATE `creature_template_locale` SET `Name` = 'Верховный генерал Аббендис' WHERE `locale` = 'ruRU' AND `entry` = 10828;
-- OLD name : Командир Ашлам Неутомимый
-- Source : https://www.wowhead.com/wotlk/ru/npc=10838
UPDATE `creature_template_locale` SET `Name` = 'Командир Ашлам Отважный Кулак' WHERE `locale` = 'ruRU' AND `entry` = 10838;
-- OLD subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=10839
UPDATE `creature_template_locale` SET `Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 10839;
-- OLD subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=10840
UPDATE `creature_template_locale` SET `Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 10840;
-- OLD name : Интендант Хасна из ордена Серебряного Рассвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=10856
UPDATE `creature_template_locale` SET `Name` = 'Интендант ордена Серебряного Рассвета Хасана' WHERE `locale` = 'ruRU' AND `entry` = 10856;
-- OLD subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=10857
UPDATE `creature_template_locale` SET `Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 10857;
-- OLD name : Нежить-скарабей
-- Source : https://www.wowhead.com/wotlk/ru/npc=10876
UPDATE `creature_template_locale` SET `Name` = 'Скарабей-нежить' WHERE `locale` = 'ruRU' AND `entry` = 10876;
-- OLD name : Глашатай Лунопарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=10878
UPDATE `creature_template_locale` SET `Name` = 'Глашатай Лунная Охотница' WHERE `locale` = 'ruRU' AND `entry` = 10878;
-- OLD name : Оружейник легиона Чернорука
-- Source : https://www.wowhead.com/wotlk/ru/npc=10898
UPDATE `creature_template_locale` SET `Name` = 'Оружейник из легиона Чернорука' WHERE `locale` = 'ruRU' AND `entry` = 10898;
-- OLD name : Горалук Треснувшая Наковальня
-- Source : https://www.wowhead.com/wotlk/ru/npc=10899
UPDATE `creature_template_locale` SET `Name` = 'Горалук Разбитая Наковальня' WHERE `locale` = 'ruRU' AND `entry` = 10899;
-- OLD name : Редпат Оскверненный
-- Source : https://www.wowhead.com/wotlk/ru/npc=10938
UPDATE `creature_template_locale` SET `Name` = 'Редпат Падший' WHERE `locale` = 'ruRU' AND `entry` = 10938;
-- OLD name : Дейвил Яркосвет
-- Source : https://www.wowhead.com/wotlk/ru/npc=10944
UPDATE `creature_template_locale` SET `Name` = 'Дейвил Лайтфайр' WHERE `locale` = 'ruRU' AND `entry` = 10944;
-- OLD name : Послушник из клана Серебряной Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=10949
UPDATE `creature_template_locale` SET `Name` = 'Послушник ордена Серебряной Длани' WHERE `locale` = 'ruRU' AND `entry` = 10949;
-- OLD name : Ополчение Редпата
-- Source : https://www.wowhead.com/wotlk/ru/npc=10950
UPDATE `creature_template_locale` SET `Name` = 'Ополченец Редпата' WHERE `locale` = 'ruRU' AND `entry` = 10950;
-- OLD name : Трогг Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=10987
UPDATE `creature_template_locale` SET `Name` = 'Трогг с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 10987;
-- OLD name : Вилли Разбивающий Надежды
-- Source : https://www.wowhead.com/wotlk/ru/npc=10997
UPDATE `creature_template_locale` SET `Name` = 'Мастер-канонир Вилли' WHERE `locale` = 'ruRU' AND `entry` = 10997;
-- OLD name : Вэлдон Баров
-- Source : https://www.wowhead.com/wotlk/ru/npc=11023
UPDATE `creature_template_locale` SET `Name` = 'Велдон Баров' WHERE `locale` = 'ruRU' AND `entry` = 11023;
-- OLD name : Командир Малор
-- Source : https://www.wowhead.com/wotlk/ru/npc=11032
UPDATE `creature_template_locale` SET `Name` = 'Малор Ревностный' WHERE `locale` = 'ruRU' AND `entry` = 11032;
-- OLD name : Дымок ЛаРу
-- Source : https://www.wowhead.com/wotlk/ru/npc=11033
UPDATE `creature_template_locale` SET `Name` = 'Смоки Ля Рю' WHERE `locale` = 'ruRU' AND `entry` = 11033;
-- OLD subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=11034
UPDATE `creature_template_locale` SET `Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 11034;
-- OLD subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=11036
UPDATE `creature_template_locale` SET `Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 11036;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=11037
UPDATE `creature_template_locale` SET `Title` = 'Учительница инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 11037;
-- OLD subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=11039
UPDATE `creature_template_locale` SET `Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 11039;
-- OLD name : Восставший монах
-- Source : https://www.wowhead.com/wotlk/ru/npc=11043
UPDATE `creature_template_locale` SET `Name` = 'Монах из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 11043;
-- OLD name : Восставший ружейник
-- Source : https://www.wowhead.com/wotlk/ru/npc=11054
UPDATE `creature_template_locale` SET `Name` = 'Ружейник из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 11054;
-- OLD name : Жрица Тени Вандис
-- Source : https://www.wowhead.com/wotlk/ru/npc=11055
UPDATE `creature_template_locale` SET `Name` = 'Жрица Тьмы Вандис' WHERE `locale` = 'ruRU' AND `entry` = 11055;
-- OLD name : Фрас Сиаби
-- Source : https://www.wowhead.com/wotlk/ru/npc=11058
UPDATE `creature_template_locale` SET `Name` = 'Эзра Гримм' WHERE `locale` = 'ruRU' AND `entry` = 11058;
-- OLD subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=11063
UPDATE `creature_template_locale` SET `Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 11063;
-- OLD name : Дух Дарроушира
-- Source : https://www.wowhead.com/wotlk/ru/npc=11064
UPDATE `creature_template_locale` SET `Name` = 'Дарроуширский дух' WHERE `locale` = 'ruRU' AND `entry` = 11064;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=11069
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 11069;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=11072
UPDATE `creature_template_locale` SET `Title` = 'Учительница наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 11072;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=11073
UPDATE `creature_template_locale` SET `Title` = 'Учительница наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 11073;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=11098
UPDATE `creature_template_locale` SET `Title` = 'Учительница кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 11098;
-- OLD name : Всадник Серебряного Авангарда, subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=11102
UPDATE `creature_template_locale` SET `Name` = 'Всадник из Серебряного Авангарда',`Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 11102;
-- OLD name : Трактирщица Лиссерея
-- Source : https://www.wowhead.com/wotlk/ru/npc=11103
UPDATE `creature_template_locale` SET `Name` = 'Лиссерея' WHERE `locale` = 'ruRU' AND `entry` = 11103;
-- OLD name : Трактирщица Сикоя
-- Source : https://www.wowhead.com/wotlk/ru/npc=11106
UPDATE `creature_template_locale` SET `Name` = 'Сикоя' WHERE `locale` = 'ruRU' AND `entry` = 11106;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=11117
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 11117;
-- OLD name : Трактирщица Виззи
-- Source : https://www.wowhead.com/wotlk/ru/npc=11118
UPDATE `creature_template_locale` SET `Name` = 'Виззи' WHERE `locale` = 'ruRU' AND `entry` = 11118;
-- OLD name : Восставший молотобоец
-- Source : https://www.wowhead.com/wotlk/ru/npc=11120
UPDATE `creature_template_locale` SET `Name` = 'Молотобоец из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 11120;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=11146
UPDATE `creature_template_locale` SET `Title` = 'Учитель оружейного дела' WHERE `locale` = 'ruRU' AND `entry` = 11146;
-- OLD name : Лиловый механодолгоног
-- Source : https://www.wowhead.com/wotlk/ru/npc=11148
UPDATE `creature_template_locale` SET `Name` = 'Пурпурный механодолгоног' WHERE `locale` = 'ruRU' AND `entry` = 11148;
-- OLD name : Льдисто-синий механодолгоног модель А
-- Source : https://www.wowhead.com/wotlk/ru/npc=11150
UPDATE `creature_template_locale` SET `Name` = 'Льдисто-синий механодолгоног модель' WHERE `locale` = 'ruRU' AND `entry` = 11150;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=11177
UPDATE `creature_template_locale` SET `Title` = 'Бронник' WHERE `locale` = 'ruRU' AND `entry` = 11177;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=11178
UPDATE `creature_template_locale` SET `Title` = 'Оружейник' WHERE `locale` = 'ruRU' AND `entry` = 11178;
-- OLD name : Храбрец заставы Отравленной Крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=11180
UPDATE `creature_template_locale` SET `Name` = 'Воитель с заставы Отравленной Крови' WHERE `locale` = 'ruRU' AND `entry` = 11180;
-- OLD name : Защитник Серебряного Авангарда, subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=11194
UPDATE `creature_template_locale` SET `Name` = 'Защитник из Серебряного Авангарда',`Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 11194;
-- OLD name : Конь смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=11195
UPDATE `creature_template_locale` SET `Name` = 'Черный боевой конь-скелет' WHERE `locale` = 'ruRU' AND `entry` = 11195;
-- OLD name : Пушка Багрового Легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=11199
UPDATE `creature_template_locale` SET `Name` = 'Пушка Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 11199;
-- OLD name : Укротитель Некроситета
-- Source : https://www.wowhead.com/wotlk/ru/npc=11257
UPDATE `creature_template_locale` SET `Name` = 'Укротитель из Некроситета' WHERE `locale` = 'ruRU' AND `entry` = 11257;
-- OLD name : Горожанин Каэр Дарроу
-- Source : https://www.wowhead.com/wotlk/ru/npc=11277
UPDATE `creature_template_locale` SET `Name` = 'Житель Каэр Дарроу' WHERE `locale` = 'ruRU' AND `entry` = 11277;
-- OLD name : Охранник Каэр Дарроу
-- Source : https://www.wowhead.com/wotlk/ru/npc=11279
UPDATE `creature_template_locale` SET `Name` = 'Охранник из Каэр Дарроу' WHERE `locale` = 'ruRU' AND `entry` = 11279;
-- OLD name : Канонир Каэр Дарроу
-- Source : https://www.wowhead.com/wotlk/ru/npc=11280
UPDATE `creature_template_locale` SET `Name` = 'Канонир из Каэр Дарроу' WHERE `locale` = 'ruRU' AND `entry` = 11280;
-- OLD name : Верховой Каэр Дарроу
-- Source : https://www.wowhead.com/wotlk/ru/npc=11281
UPDATE `creature_template_locale` SET `Name` = 'Кавалерист из Каэр Дарроу' WHERE `locale` = 'ruRU' AND `entry` = 11281;
-- OLD name : Полтергейст из Дарроушира
-- Source : https://www.wowhead.com/wotlk/ru/npc=11296
UPDATE `creature_template_locale` SET `Name` = 'Дарроуширский полтергейст' WHERE `locale` = 'ruRU' AND `entry` = 11296;
-- OLD name : Сектант из клана Пламенеющего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=11322
UPDATE `creature_template_locale` SET `Name` = 'Сектант из клана Огненного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 11322;
-- OLD name : Головорез из клана Пламенеющего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=11323
UPDATE `creature_template_locale` SET `Name` = 'Головорез из клана Огненного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 11323;
-- OLD name : Чернокнижник из клана Пламенеющего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=11324
UPDATE `creature_template_locale` SET `Name` = 'Чернокнижник из клана Огненного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 11324;
-- OLD name : Воитель из племени Гурубаши
-- Source : https://www.wowhead.com/wotlk/ru/npc=11356
UPDATE `creature_template_locale` SET `Name` = 'Защитник из племени Гурубаши' WHERE `locale` = 'ruRU' AND `entry` = 11356;
-- OLD name : Призыватель-высокорожденный, subname : Дом Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=11466
UPDATE `creature_template_locale` SET `Name` = 'Высокорожденный-призыватель',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 11466;
-- OLD name : Огнечар Элдрета
-- Source : https://www.wowhead.com/wotlk/ru/npc=11469
UPDATE `creature_template_locale` SET `Name` = 'Элдретский огнечар' WHERE `locale` = 'ruRU' AND `entry` = 11469;
-- OLD name : Элдретарский колдун
-- Source : https://www.wowhead.com/wotlk/ru/npc=11470
UPDATE `creature_template_locale` SET `Name` = 'Элдретский колдун' WHERE `locale` = 'ruRU' AND `entry` = 11470;
-- OLD name : Элдретарская тень
-- Source : https://www.wowhead.com/wotlk/ru/npc=11471
UPDATE `creature_template_locale` SET `Name` = 'Элдретская тень' WHERE `locale` = 'ruRU' AND `entry` = 11471;
-- OLD name : Элдретарский дух
-- Source : https://www.wowhead.com/wotlk/ru/npc=11472
UPDATE `creature_template_locale` SET `Name` = 'Элдретский дух' WHERE `locale` = 'ruRU' AND `entry` = 11472;
-- OLD name : Элдретарский призрак
-- Source : https://www.wowhead.com/wotlk/ru/npc=11473
UPDATE `creature_template_locale` SET `Name` = 'Элдретский призрак' WHERE `locale` = 'ruRU' AND `entry` = 11473;
-- OLD name : Элдретарское привидение
-- Source : https://www.wowhead.com/wotlk/ru/npc=11474
UPDATE `creature_template_locale` SET `Name` = 'Элдретское привидение' WHERE `locale` = 'ruRU' AND `entry` = 11474;
-- OLD name : Элдретарский фантазм
-- Source : https://www.wowhead.com/wotlk/ru/npc=11475
UPDATE `creature_template_locale` SET `Name` = 'Элдретский фантазм' WHERE `locale` = 'ruRU' AND `entry` = 11475;
-- OLD name : [UNUSED] Волшебный ужас
-- Source : https://www.wowhead.com/wotlk/ru/npc=11479
UPDATE `creature_template_locale` SET `Name` = 'Волшебный ужас' WHERE `locale` = 'ruRU' AND `entry` = 11479;
-- OLD subname : Правитель Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=11486
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 11486;
-- OLD name : Бессмер'тер
-- Source : https://www.wowhead.com/wotlk/ru/npc=11496
UPDATE `creature_template_locale` SET `Name` = 'Пламе''тар' WHERE `locale` = 'ruRU' AND `entry` = 11496;
-- OLD name : Скарр Сломленный
-- Source : https://www.wowhead.com/wotlk/ru/npc=11498
UPDATE `creature_template_locale` SET `Name` = 'Скарр Непреклонный' WHERE `locale` = 'ruRU' AND `entry` = 11498;
-- OLD subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=11536
UPDATE `creature_template_locale` SET `Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 11536;
-- OLD name : Скелет-ученик Некроситета
-- Source : https://www.wowhead.com/wotlk/ru/npc=11547
UPDATE `creature_template_locale` SET `Name` = 'Скелет-ученик из Некроситета' WHERE `locale` = 'ruRU' AND `entry` = 11547;
-- OLD name : Злобный некрорахнид
-- Source : https://www.wowhead.com/wotlk/ru/npc=11551
UPDATE `creature_template_locale` SET `Name` = 'Злобный некроарахнид' WHERE `locale` = 'ruRU' AND `entry` = 11551;
-- OLD name : Призыватель Тьмы Некроситета
-- Source : https://www.wowhead.com/wotlk/ru/npc=11582
UPDATE `creature_template_locale` SET `Name` = 'Призыватель тьмы из Некроситета' WHERE `locale` = 'ruRU' AND `entry` = 11582;
-- OLD name : Шаман Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=11600
UPDATE `creature_template_locale` SET `Name` = 'Шаман с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 11600;
-- OLD name : Головолом Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=11602
UPDATE `creature_template_locale` SET `Name` = 'Головолом с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 11602;
-- OLD name : Гончая Недр
-- Source : https://www.wowhead.com/wotlk/ru/npc=11671
UPDATE `creature_template_locale` SET `Name` = 'Гончая недр' WHERE `locale` = 'ruRU' AND `entry` = 11671;
-- OLD name : Гончая Недр
-- Source : https://www.wowhead.com/wotlk/ru/npc=11673
UPDATE `creature_template_locale` SET `Name` = 'Древняя гончая недр' WHERE `locale` = 'ruRU' AND `entry` = 11673;
-- OLD name : Ордынский разведчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=11680
UPDATE `creature_template_locale` SET `Name` = 'Разведчик Орды' WHERE `locale` = 'ruRU' AND `entry` = 11680;
-- OLD name : Лесоруб Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=11681
UPDATE `creature_template_locale` SET `Name` = 'Ордынский лесозаготовитель' WHERE `locale` = 'ruRU' AND `entry` = 11681;
-- OLD name : Гоблинский лесозаготовитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=11684
UPDATE `creature_template_locale` SET `Name` = 'Крошшер клана Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 11684;
-- OLD subname : Укротители ледопардов
-- Source : https://www.wowhead.com/wotlk/ru/npc=11696
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщики ледопардов' WHERE `locale` = 'ruRU' AND `entry` = 11696;
-- OLD name : Пескоброд из улья Аши
-- Source : https://www.wowhead.com/wotlk/ru/npc=11723
UPDATE `creature_template_locale` SET `Name` = 'Песчаный ловец из улья Аши' WHERE `locale` = 'ruRU' AND `entry` = 11723;
-- OLD subname : Дарнасский распорядитель полетов
-- Source : https://www.wowhead.com/wotlk/ru/npc=11800
UPDATE `creature_template_locale` SET `Title` = 'Дарнасская распорядительница полетов' WHERE `locale` = 'ruRU' AND `entry` = 11800;
-- OLD name : Страж-смотритель Лунной поляны
-- Source : https://www.wowhead.com/wotlk/ru/npc=11822
UPDATE `creature_template_locale` SET `Name` = 'Смотритель Лунной поляны' WHERE `locale` = 'ruRU' AND `entry` = 11822;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=11865
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 11865;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=11866
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 11866;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=11867
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 11867;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=11868
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 11868;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=11869
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 11869;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=11870
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 11870;
-- OLD name : Рун Буйногривый
-- Source : https://www.wowhead.com/wotlk/ru/npc=11877
UPDATE `creature_template_locale` SET `Name` = 'Рун Буйная Грива' WHERE `locale` = 'ruRU' AND `entry` = 11877;
-- OLD name : Зачумленная гончая
-- Source : https://www.wowhead.com/wotlk/ru/npc=11885
UPDATE `creature_template_locale` SET `Name` = 'Чумная гончая' WHERE `locale` = 'ruRU' AND `entry` = 11885;
-- OLD name : Лорд-рыцарь Валделмар
-- Source : https://www.wowhead.com/wotlk/ru/npc=11898
UPDATE `creature_template_locale` SET `Name` = 'Командир рыцарей Валделмар' WHERE `locale` = 'ruRU' AND `entry` = 11898;
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=11899
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 11899;
-- OLD name : Наемник племени Зловещего Тотема
-- Source : https://www.wowhead.com/wotlk/ru/npc=11911
UPDATE `creature_template_locale` SET `Name` = 'Наемник из племени Зловещего Тотема' WHERE `locale` = 'ruRU' AND `entry` = 11911;
-- OLD name : Колдун племени Зловещего Тотема
-- Source : https://www.wowhead.com/wotlk/ru/npc=11913
UPDATE `creature_template_locale` SET `Name` = 'Колдун из племени Зловещего Тотема' WHERE `locale` = 'ruRU' AND `entry` = 11913;
-- OLD name : Хранитель скал из племени Камнепадов
-- Source : https://www.wowhead.com/wotlk/ru/npc=11915
UPDATE `creature_template_locale` SET `Name` = 'Хранитель скал из племени Гоггер' WHERE `locale` = 'ruRU' AND `entry` = 11915;
-- OLD name : Геомант из племени Камнепадов
-- Source : https://www.wowhead.com/wotlk/ru/npc=11917
UPDATE `creature_template_locale` SET `Name` = 'Геомант из стаи Гоггер' WHERE `locale` = 'ruRU' AND `entry` = 11917;
-- OLD name : Камнелом из племени Камнепадов
-- Source : https://www.wowhead.com/wotlk/ru/npc=11918
UPDATE `creature_template_locale` SET `Name` = 'Камнелом из племени Гоггер' WHERE `locale` = 'ruRU' AND `entry` = 11918;
-- OLD name : Вандар Грозовая Вершина
-- Source : https://www.wowhead.com/wotlk/ru/npc=11948
UPDATE `creature_template_locale` SET `Name` = 'Ванндар Грозовая Вершина' WHERE `locale` = 'ruRU' AND `entry` = 11948;
-- OLD name : Глашатай Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=11997
UPDATE `creature_template_locale` SET `Name` = 'Глашатай из клана Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 11997;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=12020
UPDATE `creature_template_locale` SET `Title` = 'Алхимик-искусник' WHERE `locale` = 'ruRU' AND `entry` = 12020;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=12029
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 12029;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=12032
UPDATE `creature_template_locale` SET `Title` = 'Учительница рыбной ловли' WHERE `locale` = 'ruRU' AND `entry` = 12032;
-- OLD name : Мастер горного дела с Заоблачного пика
-- Source : https://www.wowhead.com/wotlk/ru/npc=12035
UPDATE `creature_template_locale` SET `Name` = 'Учитель горного дела с Заоблачного пика' WHERE `locale` = 'ruRU' AND `entry` = 12035;
-- OLD name : Грелла Каменный Кулак
-- Source : https://www.wowhead.com/wotlk/ru/npc=12036
UPDATE `creature_template_locale` SET `Name` = 'Торговка с Заоблачного пика' WHERE `locale` = 'ruRU' AND `entry` = 12036;
-- OLD name : Браник Железное Брюхо
-- Source : https://www.wowhead.com/wotlk/ru/npc=12040
UPDATE `creature_template_locale` SET `Name` = 'Торговец кольчугами с Заоблачного пика' WHERE `locale` = 'ruRU' AND `entry` = 12040;
-- OLD name : Легионер Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=12051
UPDATE `creature_template_locale` SET `Name` = 'Легионер из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 12051;
-- OLD name : Воин клана Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=12052
UPDATE `creature_template_locale` SET `Name` = 'Воин из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 12052;
-- OLD name : Страж Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=12053
UPDATE `creature_template_locale` SET `Name` = 'Страж из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 12053;
-- OLD name : Лавовый волноплеск
-- Source : https://www.wowhead.com/wotlk/ru/npc=12101
UPDATE `creature_template_locale` SET `Name` = 'Лавоменталь' WHERE `locale` = 'ruRU' AND `entry` = 12101;
-- OLD name : Гвардеец из Багрового Легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=12128
UPDATE `creature_template_locale` SET `Name` = 'Гвардеец из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 12128;
-- OLD name : Верховой кодо (черный)
-- Source : https://www.wowhead.com/wotlk/ru/npc=12145
UPDATE `creature_template_locale` SET `Name` = 'Черный верховой кодо' WHERE `locale` = 'ruRU' AND `entry` = 12145;
-- OLD name : Верховой кодо (оливковый)
-- Source : https://www.wowhead.com/wotlk/ru/npc=12146
UPDATE `creature_template_locale` SET `Name` = 'Оливковый верховой кодо' WHERE `locale` = 'ruRU' AND `entry` = 12146;
-- OLD name : Верховой кодо (белый)
-- Source : https://www.wowhead.com/wotlk/ru/npc=12147
UPDATE `creature_template_locale` SET `Name` = 'Белый верховой кодо' WHERE `locale` = 'ruRU' AND `entry` = 12147;
-- OLD name : Бирюзовый кодо
-- Source : https://www.wowhead.com/wotlk/ru/npc=12148
UPDATE `creature_template_locale` SET `Name` = 'Бирюзовый кодo' WHERE `locale` = 'ruRU' AND `entry` = 12148;
-- OLD name : Верховой кодо (лиловый)
-- Source : https://www.wowhead.com/wotlk/ru/npc=12150
UPDATE `creature_template_locale` SET `Name` = 'Лиловый верховой кодо' WHERE `locale` = 'ruRU' AND `entry` = 12150;
-- OLD name : Трактирщица Кайлиска
-- Source : https://www.wowhead.com/wotlk/ru/npc=12196
UPDATE `creature_template_locale` SET `Name` = 'Кайлиска' WHERE `locale` = 'ruRU' AND `entry` = 12196;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=12198
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 12198;
-- OLD name : Торготрон 1000
-- Source : https://www.wowhead.com/wotlk/ru/npc=12245
UPDATE `creature_template_locale` SET `Name` = '"Торготрон 1000"' WHERE `locale` = 'ruRU' AND `entry` = 12245;
-- OLD name : Робо-торговец 680
-- Source : https://www.wowhead.com/wotlk/ru/npc=12246
UPDATE `creature_template_locale` SET `Name` = '"Робо-торговец 680"' WHERE `locale` = 'ruRU' AND `entry` = 12246;
-- OLD name : Токсиколог клана Пылающего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=12319
UPDATE `creature_template_locale` SET `Name` = 'Токсиколог из клана Пылающего Клинка' WHERE `locale` = 'ruRU' AND `entry` = 12319;
-- OLD name : Курьер из Багрового Легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=12337
UPDATE `creature_template_locale` SET `Name` = 'Курьер из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 12337;
-- OLD name : Белый ездовой баран
-- Source : https://www.wowhead.com/wotlk/ru/npc=12374
UPDATE `creature_template_locale` SET `Name` = 'Белый скаковой баран' WHERE `locale` = 'ruRU' AND `entry` = 12374;
-- OLD name : Легионер Крыла Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=12416
UPDATE `creature_template_locale` SET `Name` = 'Легионер из логова Крыла Тьмы' WHERE `locale` = 'ruRU' AND `entry` = 12416;
-- OLD name : Маг Крыла Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=12420
UPDATE `creature_template_locale` SET `Name` = 'Маг из логова Крыла Тьмы' WHERE `locale` = 'ruRU' AND `entry` = 12420;
-- OLD name : Чароплет Крыла Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=12457
UPDATE `creature_template_locale` SET `Name` = 'Чародей из логова Крыла Тьмы' WHERE `locale` = 'ruRU' AND `entry` = 12457;
-- OLD name : Чернокнижник Крыла Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=12459
UPDATE `creature_template_locale` SET `Name` = 'Чернокнижник из логова Крыла Тьмы' WHERE `locale` = 'ruRU' AND `entry` = 12459;
-- OLD name : Гнездовая Когтя Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=12468
UPDATE `creature_template_locale` SET `Name` = 'Стражница гнезда Когтя Смерти' WHERE `locale` = 'ruRU' AND `entry` = 12468;
-- OLD subname : Вербовщик Штормграда
-- Source : https://www.wowhead.com/wotlk/ru/npc=12481
UPDATE `creature_template_locale` SET `Title` = 'Вербовщица Штормграда' WHERE `locale` = 'ruRU' AND `entry` = 12481;
-- OLD name : Иллюзия: черный драконор
-- Source : https://www.wowhead.com/wotlk/ru/npc=12536
UPDATE `creature_template_locale` SET `Name` = 'Иллюзия "Черный драконор"' WHERE `locale` = 'ruRU' AND `entry` = 12536;
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=12616
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 12616;
-- OLD subname : Дрессировщик нетопырей
-- Source : https://www.wowhead.com/wotlk/ru/npc=12636
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица нетопырей' WHERE `locale` = 'ruRU' AND `entry` = 12636;
-- OLD name : Налетчик с Заставы Расщепленного Дерева
-- Source : https://www.wowhead.com/wotlk/ru/npc=12859
UPDATE `creature_template_locale` SET `Name` = 'Налетчик с заставы Расщепленного Дерева' WHERE `locale` = 'ruRU' AND `entry` = 12859;
-- OLD name : Разведчик клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=12862
UPDATE `creature_template_locale` SET `Name` = 'Разведчик из клана Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 12862;
-- OLD name : Гонец клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=12863
UPDATE `creature_template_locale` SET `Name` = 'Гонец из клана Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 12863;
-- OLD name : Стражник Заставы Расщепленного Дерева
-- Source : https://www.wowhead.com/wotlk/ru/npc=12903
UPDATE `creature_template_locale` SET `Name` = 'Стражник с заставы Расщепленного Дерева' WHERE `locale` = 'ruRU' AND `entry` = 12903;
-- OLD name : Смертельно раненый солдат
-- Source : https://www.wowhead.com/wotlk/ru/npc=12925
UPDATE `creature_template_locale` SET `Name` = 'Смертельно раненный солдат' WHERE `locale` = 'ruRU' AND `entry` = 12925;
-- OLD name : Смертельно раненый солдат Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=12937
UPDATE `creature_template_locale` SET `Name` = 'Смертельно раненный солдат Альянса' WHERE `locale` = 'ruRU' AND `entry` = 12937;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=12939
UPDATE `creature_template_locale` SET `Title` = 'Травматолог' WHERE `locale` = 'ruRU' AND `entry` = 12939;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=12961
UPDATE `creature_template_locale` SET `Title` = 'Учительница рыбной ловли' WHERE `locale` = 'ruRU' AND `entry` = 12961;
-- OLD name : Верховой горный пехотинец Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=12996
UPDATE `creature_template_locale` SET `Name` = 'Стальгорнский верховой горный пехотинец' WHERE `locale` = 'ruRU' AND `entry` = 12996;
-- OLD name : Ясновидец клана Пылающего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13019
UPDATE `creature_template_locale` SET `Name` = 'Ясновидец из клана Пылающего Клинка' WHERE `locale` = 'ruRU' AND `entry` = 13019;
-- OLD name : Гончая клана Гордок
-- Source : https://www.wowhead.com/wotlk/ru/npc=13036
UPDATE `creature_template_locale` SET `Name` = 'Мастифф клана Гордок' WHERE `locale` = 'ruRU' AND `entry` = 13036;
-- OLD name : Горный пехотинец Дун Морога
-- Source : https://www.wowhead.com/wotlk/ru/npc=13076
UPDATE `creature_template_locale` SET `Name` = 'Горный пехотинец из Дун Морога' WHERE `locale` = 'ruRU' AND `entry` = 13076;
-- OLD name : Стражник Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13080
UPDATE `creature_template_locale` SET `Name` = 'Стражник с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13080;
-- OLD name : Налетчик Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13081
UPDATE `creature_template_locale` SET `Name` = 'Налетчик с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13081;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=13084
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 13084;
-- OLD name : Захватчик Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13087
UPDATE `creature_template_locale` SET `Name` = 'Захватчик с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13087;
-- OLD name : Стражник Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13089
UPDATE `creature_template_locale` SET `Name` = 'Стражник с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13089;
-- OLD name : Исследователь Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13096
UPDATE `creature_template_locale` SET `Name` = 'Исследователь с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13096;
-- OLD name : Геодезист Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13097
UPDATE `creature_template_locale` SET `Name` = 'Геодезист с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13097;
-- OLD name : Геодезист Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13098
UPDATE `creature_template_locale` SET `Name` = 'Геодезист с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13098;
-- OLD name : Исследователь Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13099
UPDATE `creature_template_locale` SET `Name` = 'Исследователь с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13099;
-- OLD name : Телохранитель из Багрового Легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=13118
UPDATE `creature_template_locale` SET `Name` = 'Телохранитель из Багрового легиона' WHERE `locale` = 'ruRU' AND `entry` = 13118;
-- OLD name : Грабитель Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=13149
UPDATE `creature_template_locale` SET `Name` = 'Грабитель из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 13149;
-- OLD name : Посланник Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=13150
UPDATE `creature_template_locale` SET `Name` = 'Агент Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 13150;
-- OLD subname : Снабженец клана Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=13216
UPDATE `creature_template_locale` SET `Title` = 'Интендант клана Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 13216;
-- OLD subname : Снабженец клана Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=13217
UPDATE `creature_template_locale` SET `Title` = 'Интендант клана Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 13217;
-- OLD subname : Снабженец клана Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13218
UPDATE `creature_template_locale` SET `Title` = 'Интендант клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 13218;
-- OLD name : Джорек Железнобок, subname : Снабженец клана Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13219
UPDATE `creature_template_locale` SET `Name` = 'Джекилл Флендринг',`Title` = 'Интендант клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 13219;
-- OLD name : Шаман из клана Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13284
UPDATE `creature_template_locale` SET `Name` = 'Шаманка из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 13284;
-- OLD name : Батрак Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13316
UPDATE `creature_template_locale` SET `Name` = 'Батрак с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13316;
-- OLD name : Шахтер Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13317
UPDATE `creature_template_locale` SET `Name` = 'Шахтер с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13317;
-- OLD name : Малая лягушка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13321
UPDATE `creature_template_locale` SET `Name` = 'Лягушка' WHERE `locale` = 'ruRU' AND `entry` = 13321;
-- OLD name : Бывалый часовой
-- Source : https://www.wowhead.com/wotlk/ru/npc=13336
UPDATE `creature_template_locale` SET `Name` = 'Часовая-ветеран' WHERE `locale` = 'ruRU' AND `entry` = 13336;
-- OLD name : Минер Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13357
UPDATE `creature_template_locale` SET `Name` = 'Минер из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 13357;
-- OLD name : Снайпер из клана Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=13358
UPDATE `creature_template_locale` SET `Name` = 'Лучник из клана Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 13358;
-- OLD name : Снайпер из клана Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13359
UPDATE `creature_template_locale` SET `Name` = 'Лучник из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 13359;
-- OLD name : Шахтер Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13396
UPDATE `creature_template_locale` SET `Name` = 'Шахтер с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13396;
-- OLD name : Батрак Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13397
UPDATE `creature_template_locale` SET `Name` = 'Батрак с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13397;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=13418
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 13418;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=13420
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 13420;
-- OLD name : Горный пехотинец-ветеран
-- Source : https://www.wowhead.com/wotlk/ru/npc=13426
UPDATE `creature_template_locale` SET `Name` = 'Горный пехотинец - ветеран' WHERE `locale` = 'ruRU' AND `entry` = 13426;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=13429
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 13429;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=13430
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 13430;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=13431
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 13431;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=13432
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 13432;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=13433
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 13433;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=13434
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 13434;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=13435
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 13435;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=13436
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 13436;
-- OLD name : Всадник на волке из клана Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13440
UPDATE `creature_template_locale` SET `Name` = 'Наездник на волке из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 13440;
-- OLD name : Командир всадников на волках клана Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13441
UPDATE `creature_template_locale` SET `Name` = 'Командир наездников на волках из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 13441;
-- OLD name : Капрал Норг Грозовая Вершина
-- Source : https://www.wowhead.com/wotlk/ru/npc=13447
UPDATE `creature_template_locale` SET `Name` = 'Капрал Норег Грозовая Вершина' WHERE `locale` = 'ruRU' AND `entry` = 13447;
-- OLD name : Зен'Балай, subname : Наставница друидов
-- Source : https://www.wowhead.com/wotlk/ru/npc=13476
UPDATE `creature_template_locale` SET `Name` = 'Бала Лок''Вен',`Title` = 'Зелья, свитки и реагенты' WHERE `locale` = 'ruRU' AND `entry` = 13476;
-- OLD name : Гонец Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13516
UPDATE `creature_template_locale` SET `Name` = 'Гонец из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 13516;
-- OLD name : Следопыт клана Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=13520
UPDATE `creature_template_locale` SET `Name` = 'Следопыт из клана Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 13520;
-- OLD name : Боец клана Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=13524
UPDATE `creature_template_locale` SET `Name` = 'Боец из клана Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 13524;
-- OLD name : Элитный боец-ветеран
-- Source : https://www.wowhead.com/wotlk/ru/npc=13527
UPDATE `creature_template_locale` SET `Name` = 'Элитный боец - ветеран' WHERE `locale` = 'ruRU' AND `entry` = 13527;
-- OLD name : Опытный стражник Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13534
UPDATE `creature_template_locale` SET `Name` = 'Опытный стражник с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13534;
-- OLD name : Бывалый стражник Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13535
UPDATE `creature_template_locale` SET `Name` = 'Бывалый стражник с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13535;
-- OLD name : Стражник-ветеран Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13536
UPDATE `creature_template_locale` SET `Name` = 'Стражник-ветеран с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13536;
-- OLD name : Опытный геодезист Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13537
UPDATE `creature_template_locale` SET `Name` = 'Опытный геодезист с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13537;
-- OLD name : Бывалый геодезист Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13538
UPDATE `creature_template_locale` SET `Name` = 'Бывалый геодезист с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13538;
-- OLD name : Геодезист-ветеран Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13539
UPDATE `creature_template_locale` SET `Name` = 'Геодезист-ветеран с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13539;
-- OLD name : Опытный исследователь Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13540
UPDATE `creature_template_locale` SET `Name` = 'Опытный исследователь с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13540;
-- OLD name : Бывалый исследователь Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13541
UPDATE `creature_template_locale` SET `Name` = 'Бывалый исследователь с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13541;
-- OLD name : Ислледователь-ветеран Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13542
UPDATE `creature_template_locale` SET `Name` = 'Ислледователь-ветеран с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13542;
-- OLD name : Опытный налетчик Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13543
UPDATE `creature_template_locale` SET `Name` = 'Опытный налетчик с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13543;
-- OLD name : Бывалый налетчик Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13544
UPDATE `creature_template_locale` SET `Name` = 'Бывалый налетчик с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13544;
-- OLD name : Налетчик-ветеран Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13545
UPDATE `creature_template_locale` SET `Name` = 'Налетчик-ветеран с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13545;
-- OLD name : Опытный исследователь Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13546
UPDATE `creature_template_locale` SET `Name` = 'Опытный исследователь с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13546;
-- OLD name : Бывалый исследователь Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13547
UPDATE `creature_template_locale` SET `Name` = 'Бывалый исследователь с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13547;
-- OLD name : Исследователь-ветеран Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13548
UPDATE `creature_template_locale` SET `Name` = 'Исследователь-ветеран с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13548;
-- OLD name : Опытный захватчик Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13549
UPDATE `creature_template_locale` SET `Name` = 'Опытный захватчик с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13549;
-- OLD name : Бывалый захватчик Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13550
UPDATE `creature_template_locale` SET `Name` = 'Бывалый захватчик с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13550;
-- OLD name : Захватчик-ветеран Ледяного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13551
UPDATE `creature_template_locale` SET `Name` = 'Захватчик-ветеран с Ледяного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13551;
-- OLD name : Опытный стражник Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13552
UPDATE `creature_template_locale` SET `Name` = 'Опытный стражник с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13552;
-- OLD name : Бывалый стражник Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13553
UPDATE `creature_template_locale` SET `Name` = 'Бывалый стражник с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13553;
-- OLD name : Стражник-ветеран Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13554
UPDATE `creature_template_locale` SET `Name` = 'Стражник-ветеран с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13554;
-- OLD name : Опытный геодезист Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13555
UPDATE `creature_template_locale` SET `Name` = 'Опытный геодезист с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13555;
-- OLD name : Бывалый геодезист Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13556
UPDATE `creature_template_locale` SET `Name` = 'Бывалый геодезист с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13556;
-- OLD name : Геодезист-ветеран Железного рудника
-- Source : https://www.wowhead.com/wotlk/ru/npc=13557
UPDATE `creature_template_locale` SET `Name` = 'Геодезист-ветеран с Железного рудника' WHERE `locale` = 'ruRU' AND `entry` = 13557;
-- OLD name : Наездник на баране клана Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=13576
UPDATE `creature_template_locale` SET `Name` = 'Наездник на баране из клана Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 13576;
-- OLD name : Эксперт по взрывчатым веществам из клана Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13597
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по взрывчатке из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 13597;
-- OLD name : Эксперт по взрывчатым веществам клана Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=13598
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по взрывчатке из клана Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 13598;
-- OLD name : Смотритель стойл из клана Северного Волка, subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=13616
UPDATE `creature_template_locale` SET `Name` = 'Смотрительница стойл из клана Северного Волка',`Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 13616;
-- OLD name : Смотритель стойл из клана Грозовой Вершины, subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=13617
UPDATE `creature_template_locale` SET `Name` = 'Смотрительница стойл из клана Грозовой Вершины',`Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 13617;
-- OLD name : Конь кошмаров клана Пылающего Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=13836
UPDATE `creature_template_locale` SET `Name` = 'Кошмарный конь клана Пылающего Клинка' WHERE `locale` = 'ruRU' AND `entry` = 13836;
-- OLD subname : Вербовщик стражей для клана Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=13843
UPDATE `creature_template_locale` SET `Title` = 'Вербовщик стражи Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 13843;
-- OLD name : Хрустальный тотем Забытого Города
-- Source : https://www.wowhead.com/wotlk/ru/npc=13916
UPDATE `creature_template_locale` SET `Name` = 'Хрустальный тотем Забытого города' WHERE `locale` = 'ruRU' AND `entry` = 13916;
-- OLD name : Техник Крыла Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=13996
UPDATE `creature_template_locale` SET `Name` = 'Техник из логова Крыла Тьмы' WHERE `locale` = 'ruRU' AND `entry` = 13996;
-- OLD name : Землемер клана Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=14141
UPDATE `creature_template_locale` SET `Name` = 'Завоеватель из клана Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 14141;
-- OLD name : Землемер из клана Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=14142
UPDATE `creature_template_locale` SET `Name` = 'Завоеватель из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 14142;
-- OLD name : Волк-ищейка племени Ледяной Секиры
-- Source : https://www.wowhead.com/wotlk/ru/npc=14274
UPDATE `creature_template_locale` SET `Name` = 'Ищейка племени Ледяной Секиры' WHERE `locale` = 'ruRU' AND `entry` = 14274;
-- OLD name : Гончий волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=14282
UPDATE `creature_template_locale` SET `Name` = 'Гончий северный волк' WHERE `locale` = 'ruRU' AND `entry` = 14282;
-- OLD name : Боевой страж Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=14285
UPDATE `creature_template_locale` SET `Name` = 'Боевой страж из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 14285;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=14301
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 14301;
-- OLD name : Прародительница Шен'дралар, subname : Дом Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=14358
UPDATE `creature_template_locale` SET `Name` = 'Древняя Шен''дралар',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 14358;
-- OLD subname : Дом Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=14364
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 14364;
-- OLD subname : Дом Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=14368
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 14368;
-- OLD name : Шен'драларский ревнитель, subname : Дом Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=14369
UPDATE `creature_template_locale` SET `Name` = 'Шен''дралар-ревнитель',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 14369;
-- OLD name : Шен'драларский поставщик, subname : Дом Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=14371
UPDATE `creature_template_locale` SET `Name` = 'Шен''дралар-поставщик',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 14371;
-- OLD name : Книжница Рунический Шип
-- Source : https://www.wowhead.com/wotlk/ru/npc=14374
UPDATE `creature_template_locale` SET `Name` = 'Исследовательница Рунический Шип' WHERE `locale` = 'ruRU' AND `entry` = 14374;
-- OLD subname : Дом Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=14381
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 14381;
-- OLD subname : Дом Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=14382
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 14382;
-- OLD subname : Дом Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=14383
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 14383;
-- OLD name : Горный пехотинец-экспедитор
-- Source : https://www.wowhead.com/wotlk/ru/npc=14390
UPDATE `creature_template_locale` SET `Name` = 'Горный пехотинец экспедиции' WHERE `locale` = 'ruRU' AND `entry` = 14390;
-- OLD name : Инициатор разрушителя Забытого Города
-- Source : https://www.wowhead.com/wotlk/ru/npc=14391
UPDATE `creature_template_locale` SET `Name` = 'Инициатор разрушителя Забытого города' WHERE `locale` = 'ruRU' AND `entry` = 14391;
-- OLD name : Око Бессмер'тера
-- Source : https://www.wowhead.com/wotlk/ru/npc=14396
UPDATE `creature_template_locale` SET `Name` = 'Око Пламе''тара' WHERE `locale` = 'ruRU' AND `entry` = 14396;
-- OLD name : Элдретарский хамелеон
-- Source : https://www.wowhead.com/wotlk/ru/npc=14398
UPDATE `creature_template_locale` SET `Name` = 'Элдретский хамелеон' WHERE `locale` = 'ruRU' AND `entry` = 14398;
-- OLD name : Бурая луговая собачка
-- Source : https://www.wowhead.com/wotlk/ru/npc=14421
UPDATE `creature_template_locale` SET `Name` = 'Луговая собачка' WHERE `locale` = 'ruRU' AND `entry` = 14421;
-- OLD name : Тревого-бот
-- Source : https://www.wowhead.com/wotlk/ru/npc=14434
UPDATE `creature_template_locale` SET `Name` = 'Тревогобот' WHERE `locale` = 'ruRU' AND `entry` = 14434;
-- OLD name : Капитан Змеюк
-- Source : https://www.wowhead.com/wotlk/ru/npc=14445
UPDATE `creature_template_locale` SET `Name` = 'Лорд-капитан Змеюк' WHERE `locale` = 'ruRU' AND `entry` = 14445;
-- OLD name : Порабощенный страж ужаса: Командир
-- Source : https://www.wowhead.com/wotlk/ru/npc=14452
UPDATE `creature_template_locale` SET `Name` = 'Порабощенный страж ужаса - командир' WHERE `locale` = 'ruRU' AND `entry` = 14452;
-- OLD name : Стражник Крыла Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=14456
UPDATE `creature_template_locale` SET `Name` = 'Стражник из логова Крыла Тьмы' WHERE `locale` = 'ruRU' AND `entry` = 14456;
-- OLD name : Сирота Штормграда
-- Source : https://www.wowhead.com/wotlk/ru/npc=14496
UPDATE `creature_template_locale` SET `Name` = 'Штормградский сирота' WHERE `locale` = 'ruRU' AND `entry` = 14496;
-- OLD name : Д'жииви
-- Source : https://www.wowhead.com/wotlk/ru/npc=14500
UPDATE `creature_template_locale` SET `Name` = 'Д''живи' WHERE `locale` = 'ruRU' AND `entry` = 14500;
-- OLD name : Зоротианский конь погибели
-- Source : https://www.wowhead.com/wotlk/ru/npc=14502
UPDATE `creature_template_locale` SET `Name` = 'Зоротианский скакун погибели' WHERE `locale` = 'ruRU' AND `entry` = 14502;
-- OLD name : Дух коня погибели
-- Source : https://www.wowhead.com/wotlk/ru/npc=14504
UPDATE `creature_template_locale` SET `Name` = 'Дух скакуна погибели' WHERE `locale` = 'ruRU' AND `entry` = 14504;
-- OLD name : Конь погибели
-- Source : https://www.wowhead.com/wotlk/ru/npc=14505
UPDATE `creature_template_locale` SET `Name` = 'Конь Ужаса' WHERE `locale` = 'ruRU' AND `entry` = 14505;
-- OLD name : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=14623
UPDATE `creature_template_locale` SET `Name` = 'Военачальник ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 14623;
-- OLD name : Хансел Большерук
-- Source : https://www.wowhead.com/wotlk/ru/npc=14627
UPDATE `creature_template_locale` SET `Name` = 'Гензель Большерук' WHERE `locale` = 'ruRU' AND `entry` = 14627;
-- OLD name : Глашатай из клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=14645
UPDATE `creature_template_locale` SET `Name` = 'Глашатай ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 14645;
-- OLD name : Верховный правитель Саурфанг
-- Source : https://www.wowhead.com/wotlk/ru/npc=14720
UPDATE `creature_template_locale` SET `Name` = 'Верховный воевода Саурфанг' WHERE `locale` = 'ruRU' AND `entry` = 14720;
-- OLD name : Фельдмаршал Афрасиаби
-- Source : https://www.wowhead.com/wotlk/ru/npc=14721
UPDATE `creature_template_locale` SET `Name` = 'Фельдмаршал Стоунбридж' WHERE `locale` = 'ruRU' AND `entry` = 14721;
-- OLD name : Часовой Дальняя Песня
-- Source : https://www.wowhead.com/wotlk/ru/npc=14733
UPDATE `creature_template_locale` SET `Name` = 'Часовая Дальняя Песня' WHERE `locale` = 'ruRU' AND `entry` = 14733;
-- OLD name : Старейшина племени Сломанного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=14736
UPDATE `creature_template_locale` SET `Name` = 'Старейшина Зазубренный Клык' WHERE `locale` = 'ruRU' AND `entry` = 14736;
-- OLD name : Летучий всадник Гурубаши
-- Source : https://www.wowhead.com/wotlk/ru/npc=14750
UPDATE `creature_template_locale` SET `Name` = 'Наездник на нетопыре из племени Гурубаши' WHERE `locale` = 'ruRU' AND `entry` = 14750;
-- OLD name : Боевой штандарт Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=14751
UPDATE `creature_template_locale` SET `Name` = 'Боевой штандарт клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 14751;
-- OLD subname : Снабженец Среброкрылых
-- Source : https://www.wowhead.com/wotlk/ru/npc=14753
UPDATE `creature_template_locale` SET `Title` = 'Интендант Среброкрылых' WHERE `locale` = 'ruRU' AND `entry` = 14753;
-- OLD subname : Снабженец Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=14754
UPDATE `creature_template_locale` SET `Title` = 'Интендант клана Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 14754;
-- OLD name : Старейшина Сломанный Клык
-- Source : https://www.wowhead.com/wotlk/ru/npc=14757
UPDATE `creature_template_locale` SET `Name` = 'Старейшина Зазубренный Клык' WHERE `locale` = 'ruRU' AND `entry` = 14757;
-- OLD name : Маршал северного Оплота Дун Болдара
-- Source : https://www.wowhead.com/wotlk/ru/npc=14762
UPDATE `creature_template_locale` SET `Name` = 'Маршал северного бункера Дун Болдара' WHERE `locale` = 'ruRU' AND `entry` = 14762;
-- OLD name : Маршал южного Оплота Дун Болдара
-- Source : https://www.wowhead.com/wotlk/ru/npc=14763
UPDATE `creature_template_locale` SET `Name` = 'Маршал южного бункера Дун Болдара' WHERE `locale` = 'ruRU' AND `entry` = 14763;
-- OLD name : Маршал Ледяного Крыла
-- Source : https://www.wowhead.com/wotlk/ru/npc=14764
UPDATE `creature_template_locale` SET `Name` = 'Маршал бункера Ледяного Крыла' WHERE `locale` = 'ruRU' AND `entry` = 14764;
-- OLD name : Маршал Каменного Очага
-- Source : https://www.wowhead.com/wotlk/ru/npc=14765
UPDATE `creature_template_locale` SET `Name` = 'Маршал бункера Каменного Очага' WHERE `locale` = 'ruRU' AND `entry` = 14765;
-- OLD name : Маршал Стылой Крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=14766
UPDATE `creature_template_locale` SET `Name` = 'Маршал башни Стылой Крови' WHERE `locale` = 'ruRU' AND `entry` = 14766;
-- OLD name : Воевода северного оплота Дун Балдара
-- Source : https://www.wowhead.com/wotlk/ru/npc=14770
UPDATE `creature_template_locale` SET `Name` = 'Воевода северного оплота Дун Болдара' WHERE `locale` = 'ruRU' AND `entry` = 14770;
-- OLD name : Воевода южного оплота Дун Балдара
-- Source : https://www.wowhead.com/wotlk/ru/npc=14771
UPDATE `creature_template_locale` SET `Name` = 'Воевода южного оплота Дун Болдара' WHERE `locale` = 'ruRU' AND `entry` = 14771;
-- OLD name : Воевода Стылой Крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=14773
UPDATE `creature_template_locale` SET `Name` = 'Воевода башни Стылой Крови' WHERE `locale` = 'ruRU' AND `entry` = 14773;
-- OLD name : Воевода Ледяного Крыла
-- Source : https://www.wowhead.com/wotlk/ru/npc=14774
UPDATE `creature_template_locale` SET `Name` = 'Воевода бункера Ледяного Крыла' WHERE `locale` = 'ruRU' AND `entry` = 14774;
-- OLD name : Воевода Каменного Очага
-- Source : https://www.wowhead.com/wotlk/ru/npc=14775
UPDATE `creature_template_locale` SET `Name` = 'Воевода бункера Каменного Очага' WHERE `locale` = 'ruRU' AND `entry` = 14775;
-- OLD name : Воевода Смотровой башни
-- Source : https://www.wowhead.com/wotlk/ru/npc=14776
UPDATE `creature_template_locale` SET `Name` = 'Воевода смотровой башни' WHERE `locale` = 'ruRU' AND `entry` = 14776;
-- OLD subname : Призы и сувениры
-- Source : https://www.wowhead.com/wotlk/ru/npc=14828
UPDATE `creature_template_locale` SET `Title` = 'Ярмарка Новолуния: выдача призов' WHERE `locale` = 'ruRU' AND `entry` = 14828;
-- OLD subname : Продавец напитков
-- Source : https://www.wowhead.com/wotlk/ru/npc=14844
UPDATE `creature_template_locale` SET `Title` = 'Продавец напитков ярмарки Новолуния' WHERE `locale` = 'ruRU' AND `entry` = 14844;
-- OLD subname : Продавец еды
-- Source : https://www.wowhead.com/wotlk/ru/npc=14845
UPDATE `creature_template_locale` SET `Title` = 'Продавец еды ярмарки Новолуния' WHERE `locale` = 'ruRU' AND `entry` = 14845;
-- OLD subname : Карты Новолуния
-- Source : https://www.wowhead.com/wotlk/ru/npc=14847
UPDATE `creature_template_locale` SET `Title` = 'Карты и редкие товары ярмарки Новолуния' WHERE `locale` = 'ruRU' AND `entry` = 14847;
-- OLD name : Работник ярмарки Новолуния
-- Source : https://www.wowhead.com/wotlk/ru/npc=14849
UPDATE `creature_template_locale` SET `Name` = 'Зазывала ярмарки Новолуния' WHERE `locale` = 'ruRU' AND `entry` = 14849;
-- OLD name : Каз-моданский баран
-- Source : https://www.wowhead.com/wotlk/ru/npc=14864
UPDATE `creature_template_locale` SET `Name` = 'Казмоданский баран' WHERE `locale` = 'ruRU' AND `entry` = 14864;
-- OLD name : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=14879
UPDATE `creature_template_locale` SET `Name` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 14879;
-- OLD name : Ал'табим Всевидящий
-- Source : https://www.wowhead.com/wotlk/ru/npc=14903
UPDATE `creature_template_locale` SET `Name` = 'Аль''табим Всевидящий' WHERE `locale` = 'ruRU' AND `entry` = 14903;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=14961
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 14961;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=14962
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 14962;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=14963
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 14963;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=14964
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 14964;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=14981
UPDATE `creature_template_locale` SET `Title` = 'Военачальница ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 14981;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=14982
UPDATE `creature_template_locale` SET `Title` = 'Военачальница ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 14982;
-- OLD name : Сержант Макчист
-- Source : https://www.wowhead.com/wotlk/ru/npc=14984
UPDATE `creature_template_locale` SET `Name` = 'Сержант Маклир' WHERE `locale` = 'ruRU' AND `entry` = 14984;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=15006
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 15006;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=15007
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 15007;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=15008
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 15008;
-- OLD subname : Ученик опытного рыбака
-- Source : https://www.wowhead.com/wotlk/ru/npc=15078
UPDATE `creature_template_locale` SET `Title` = 'Ученица опытного рыбака' WHERE `locale` = 'ruRU' AND `entry` = 15078;
-- OLD name : Эмиссар из клана Грозовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=15103
UPDATE `creature_template_locale` SET `Name` = 'Эмиссар клана Грозовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 15103;
-- OLD name : Военный атташе клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=15105
UPDATE `creature_template_locale` SET `Name` = 'Эмиссар клана Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 15105;
-- OLD name : Военный атташе Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=15106
UPDATE `creature_template_locale` SET `Name` = 'Эмиссар клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 15106;
-- OLD name : Пленник Гурубаши
-- Source : https://www.wowhead.com/wotlk/ru/npc=15110
UPDATE `creature_template_locale` SET `Name` = 'Пленник из племени Гурубаши' WHERE `locale` = 'ruRU' AND `entry` = 15110;
-- OLD name : Облик лучшего рыболова
-- Source : https://www.wowhead.com/wotlk/ru/npc=15118
UPDATE `creature_template_locale` SET `Name` = 'Облик мастера-рыболова' WHERE `locale` = 'ruRU' AND `entry` = 15118;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=15124
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 15124;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=15125
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 15125;
-- OLD name : Резерфорд Оттяжка, subname : Снабженец Осквернителей
-- Source : https://www.wowhead.com/wotlk/ru/npc=15126
UPDATE `creature_template_locale` SET `Name` = 'Резерфорд Твинг',`Title` = 'Интендант Осквернителей' WHERE `locale` = 'ruRU' AND `entry` = 15126;
-- OLD subname : Снабженец Лиги Аратора
-- Source : https://www.wowhead.com/wotlk/ru/npc=15127
UPDATE `creature_template_locale` SET `Title` = 'Интендант Лиги Аратора' WHERE `locale` = 'ruRU' AND `entry` = 15127;
-- OLD name : Портал Безумия
-- Source : https://www.wowhead.com/wotlk/ru/npc=15141
UPDATE `creature_template_locale` SET `Name` = 'Портал безумия' WHERE `locale` = 'ruRU' AND `entry` = 15141;
-- OLD name : Инквизитор из Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=15162
UPDATE `creature_template_locale` SET `Name` = 'Инквизитор Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 15162;
-- OLD name : Командир Мар'алит
-- Source : https://www.wowhead.com/wotlk/ru/npc=15181
UPDATE `creature_template_locale` SET `Name` = 'Командор Мар''алит' WHERE `locale` = 'ruRU' AND `entry` = 15181;
-- OLD name : Пехотинец крепости Кенария
-- Source : https://www.wowhead.com/wotlk/ru/npc=15184
UPDATE `creature_template_locale` SET `Name` = 'Пехотинец из крепости Кенария' WHERE `locale` = 'ruRU' AND `entry` = 15184;
-- OLD name : Леди Сильвана Ветрокрылая
-- Source : https://www.wowhead.com/wotlk/ru/npc=15193
UPDATE `creature_template_locale` SET `Name` = 'Королева банши' WHERE `locale` = 'ruRU' AND `entry` = 15193;
-- OLD name : Седой храмовник
-- Source : https://www.wowhead.com/wotlk/ru/npc=15212
UPDATE `creature_template_locale` SET `Name` = 'Серый храмовник' WHERE `locale` = 'ruRU' AND `entry` = 15212;
-- OLD name : Страж-всадник на грифоне
-- Source : https://www.wowhead.com/wotlk/ru/npc=15241
UPDATE `creature_template_locale` SET `Name` = 'Наездник на грифоне' WHERE `locale` = 'ruRU' AND `entry` = 15241;
-- OLD name : Хуум Буйногривый
-- Source : https://www.wowhead.com/wotlk/ru/npc=15270
UPDATE `creature_template_locale` SET `Name` = 'Хуум Буйная Грива' WHERE `locale` = 'ruRU' AND `entry` = 15270;
-- OLD name : Волшебный призрак
-- Source : https://www.wowhead.com/wotlk/ru/npc=15273
UPDATE `creature_template_locale` SET `Name` = 'Чародейский призрак' WHERE `locale` = 'ruRU' AND `entry` = 15273;
-- OLD name : Призыватель Тель’Лариен
-- Source : https://www.wowhead.com/wotlk/ru/npc=15283
UPDATE `creature_template_locale` SET `Name` = 'Призыватель Тели''Лариен' WHERE `locale` = 'ruRU' AND `entry` = 15283;
-- OLD name : Налетчик Кариель
-- Source : https://www.wowhead.com/wotlk/ru/npc=15285
UPDATE `creature_template_locale` SET `Name` = 'Налетчик Авокор' WHERE `locale` = 'ruRU' AND `entry` = 15285;
-- OLD subname : Оружейник
-- Source : https://www.wowhead.com/wotlk/ru/npc=15289
UPDATE `creature_template_locale` SET `Title` = 'Оружейница' WHERE `locale` = 'ruRU' AND `entry` = 15289;
-- OLD subname : Торговец тканями и кожей
-- Source : https://www.wowhead.com/wotlk/ru/npc=15291
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканями и кожей' WHERE `locale` = 'ruRU' AND `entry` = 15291;
-- OLD subname : Бронник
-- Source : https://www.wowhead.com/wotlk/ru/npc=15292
UPDATE `creature_template_locale` SET `Title` = 'Бронница' WHERE `locale` = 'ruRU' AND `entry` = 15292;
-- OLD name : Нечистый волшебный призрак
-- Source : https://www.wowhead.com/wotlk/ru/npc=15298
UPDATE `creature_template_locale` SET `Name` = 'Нечистый чародейский призрак' WHERE `locale` = 'ruRU' AND `entry` = 15298;
-- OLD name : Гонец Аларион
-- Source : https://www.wowhead.com/wotlk/ru/npc=15301
UPDATE `creature_template_locale` SET `Name` = 'Курьер Аларион' WHERE `locale` = 'ruRU' AND `entry` = 15301;
-- OLD name : Бор Буйногривый
-- Source : https://www.wowhead.com/wotlk/ru/npc=15306
UPDATE `creature_template_locale` SET `Name` = 'Бор Буйная Грива' WHERE `locale` = 'ruRU' AND `entry` = 15306;
-- OLD name : Земельник-храмовник
-- Source : https://www.wowhead.com/wotlk/ru/npc=15307
UPDATE `creature_template_locale` SET `Name` = 'Земляной храмовник' WHERE `locale` = 'ruRU' AND `entry` = 15307;
-- OLD subname : Торговец оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=15315
UPDATE `creature_template_locale` SET `Title` = 'Торговка оружием' WHERE `locale` = 'ruRU' AND `entry` = 15315;
-- OLD name : Пескоброд из улья Зара
-- Source : https://www.wowhead.com/wotlk/ru/npc=15323
UPDATE `creature_template_locale` SET `Name` = 'Песчаный ловец из улья Зара' WHERE `locale` = 'ruRU' AND `entry` = 15323;
-- OLD name : Радиоуправляемый дирижабль <PH>, subname : NONE
-- Source : https://www.wowhead.com/wotlk/ru/npc=15349
UPDATE `creature_template_locale` SET `Name` = 'RC Blimp',`Title` = 'PH' WHERE `locale` = 'ruRU' AND `entry` = 15349;
-- OLD name : RC Танк-миномет <PH>, subname : NONE
-- Source : https://www.wowhead.com/wotlk/ru/npc=15364
UPDATE `creature_template_locale` SET `Name` = 'RC Mortar Tank',`Title` = 'PH' WHERE `locale` = 'ruRU' AND `entry` = 15364;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=15400
UPDATE `creature_template_locale` SET `Title` = 'Учительница кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 15400;
-- OLD name : Отембе Создатель Копий
-- Source : https://www.wowhead.com/wotlk/ru/npc=15408
UPDATE `creature_template_locale` SET `Name` = 'Копьедел Отембе' WHERE `locale` = 'ruRU' AND `entry` = 15408;
-- OLD name : Следопыт Джаела
-- Source : https://www.wowhead.com/wotlk/ru/npc=15416
UPDATE `creature_template_locale` SET `Name` = 'Следопыт Джела' WHERE `locale` = 'ruRU' AND `entry` = 15416;
-- OLD name : Калдорайский пехотинец
-- Source : https://www.wowhead.com/wotlk/ru/npc=15423
UPDATE `creature_template_locale` SET `Name` = 'Калдорай-пехотинец' WHERE `locale` = 'ruRU' AND `entry` = 15423;
-- OLD name : Трактирщица Деланиель
-- Source : https://www.wowhead.com/wotlk/ru/npc=15433
UPDATE `creature_template_locale` SET `Name` = 'Деланиель' WHERE `locale` = 'ruRU' AND `entry` = 15433;
-- OLD name : Ружейник дружины Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=15441
UPDATE `creature_template_locale` SET `Name` = 'Ружейник из дружины Стальгорна' WHERE `locale` = 'ruRU' AND `entry` = 15441;
-- OLD name : Старший сержант Гермайн
-- Source : https://www.wowhead.com/wotlk/ru/npc=15445
UPDATE `creature_template_locale` SET `Name` = 'Старший сержант Жермен' WHERE `locale` = 'ruRU' AND `entry` = 15445;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=15465
UPDATE `creature_template_locale` SET `Title` = 'Учительница ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 15465;
-- OLD name : Главный сержант Т'келах
-- Source : https://www.wowhead.com/wotlk/ru/npc=15469
UPDATE `creature_template_locale` SET `Name` = 'Старший сержант Т''келах' WHERE `locale` = 'ruRU' AND `entry` = 15469;
-- OLD name : Калдорайский гвардеец
-- Source : https://www.wowhead.com/wotlk/ru/npc=15473
UPDATE `creature_template_locale` SET `Name` = 'Калдорай-гвардеец' WHERE `locale` = 'ruRU' AND `entry` = 15473;
-- OLD name : Скорпид
-- Source : https://www.wowhead.com/wotlk/ru/npc=15476
UPDATE `creature_template_locale` SET `Name` = 'Скорпион' WHERE `locale` = 'ruRU' AND `entry` = 15476;
-- OLD name : Тотем кольца огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=15483
UPDATE `creature_template_locale` SET `Name` = 'Тотем кольца огня VII' WHERE `locale` = 'ruRU' AND `entry` = 15483;
-- OLD name : Ясмин Тель’Лариен
-- Source : https://www.wowhead.com/wotlk/ru/npc=15494
UPDATE `creature_template_locale` SET `Name` = 'Ясмин Тели''Лариен' WHERE `locale` = 'ruRU' AND `entry` = 15494;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=15501
UPDATE `creature_template_locale` SET `Title` = 'Учительница ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 15501;
-- OLD name : Каменный страж Илистое Копыто, subname : Приемщик бинтов из рунической ткани
-- Source : https://www.wowhead.com/wotlk/ru/npc=15532
UPDATE `creature_template_locale` SET `Name` = 'Камнестраж Илистое Копыто',`Title` = 'Приемщица бинтов из рунической ткани' WHERE `locale` = 'ruRU' AND `entry` = 15532;
-- OLD subname : Собиратель постного стейка из волчатины
-- Source : https://www.wowhead.com/wotlk/ru/npc=15533
UPDATE `creature_template_locale` SET `Title` = 'Собиратель постных стейков из волчатины' WHERE `locale` = 'ruRU' AND `entry` = 15533;
-- OLD subname : Приемщик запеченого лосося
-- Source : https://www.wowhead.com/wotlk/ru/npc=15535
UPDATE `creature_template_locale` SET `Title` = 'Приемщик печеного лосося' WHERE `locale` = 'ruRU' AND `entry` = 15535;
-- OLD name : Предок Буйногривая
-- Source : https://www.wowhead.com/wotlk/ru/npc=15578
UPDATE `creature_template_locale` SET `Name` = 'Предок Буйная Грива' WHERE `locale` = 'ruRU' AND `entry` = 15578;
-- OLD name : Дж. Д. Тенепев
-- Source : https://www.wowhead.com/wotlk/ru/npc=15614
UPDATE `creature_template_locale` SET `Name` = 'Дж. Д. Шейдсонг' WHERE `locale` = 'ruRU' AND `entry` = 15614;
-- OLD name : Жрица Тени Шаи
-- Source : https://www.wowhead.com/wotlk/ru/npc=15615
UPDATE `creature_template_locale` SET `Name` = 'Жрица Тьмы Шаи' WHERE `locale` = 'ruRU' AND `entry` = 15615;
-- OLD name : Мастер проклятий из оргриммарского легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=15618
UPDATE `creature_template_locale` SET `Name` = 'Проклинатель из оргриммарского легиона' WHERE `locale` = 'ruRU' AND `entry` = 15618;
-- OLD name : Древун Лесов Вечной Песни
-- Source : https://www.wowhead.com/wotlk/ru/npc=15635
UPDATE `creature_template_locale` SET `Name` = 'Древун из лесов Вечной Песни' WHERE `locale` = 'ruRU' AND `entry` = 15635;
-- OLD name : Хранитель Лесов Вечной Песни
-- Source : https://www.wowhead.com/wotlk/ru/npc=15636
UPDATE `creature_template_locale` SET `Name` = 'Хранитель лесов Вечной Песни' WHERE `locale` = 'ruRU' AND `entry` = 15636;
-- OLD name : Темный жрец из племени Амани
-- Source : https://www.wowhead.com/wotlk/ru/npc=15642
UPDATE `creature_template_locale` SET `Name` = 'Жрец Тьмы из племени Амани' WHERE `locale` = 'ruRU' AND `entry` = 15642;
-- OLD name : Ловчий маны
-- Source : https://www.wowhead.com/wotlk/ru/npc=15647
UPDATE `creature_template_locale` SET `Name` = 'Волшебный охотник' WHERE `locale` = 'ruRU' AND `entry` = 15647;
-- OLD name : Чумнокостный погромщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=15654
UPDATE `creature_template_locale` SET `Name` = 'Чумной мародер' WHERE `locale` = 'ruRU' AND `entry` = 15654;
-- OLD name : Гнилорукий каннибал
-- Source : https://www.wowhead.com/wotlk/ru/npc=15655
UPDATE `creature_template_locale` SET `Name` = 'Гниющий каннибал' WHERE `locale` = 'ruRU' AND `entry` = 15655;
-- OLD name : Гневотень
-- Source : https://www.wowhead.com/wotlk/ru/npc=15656
UPDATE `creature_template_locale` SET `Name` = 'Гневная тень' WHERE `locale` = 'ruRU' AND `entry` = 15656;
-- OLD name : Гнилопалый мародер
-- Source : https://www.wowhead.com/wotlk/ru/npc=15658
UPDATE `creature_template_locale` SET `Name` = 'Гниющий мародер' WHERE `locale` = 'ruRU' AND `entry` = 15658;
-- OLD name : Метцен – северный олень
-- Source : https://www.wowhead.com/wotlk/ru/npc=15664
UPDATE `creature_template_locale` SET `Name` = 'Метцен - северный олень' WHERE `locale` = 'ruRU' AND `entry` = 15664;
-- OLD name : Похититель Южных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=15685
UPDATE `creature_template_locale` SET `Name` = 'Похититель из братства Южных Морей' WHERE `locale` = 'ruRU' AND `entry` = 15685;
-- OLD name : Главный сержант Тайга, subname : Ан'киражский вербовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=15702
UPDATE `creature_template_locale` SET `Name` = 'Старший сержант Тайга',`Title` = 'Ан''киражская вербовщица' WHERE `locale` = 'ruRU' AND `entry` = 15702;
-- OLD name : Главный сержант Гримсфорд
-- Source : https://www.wowhead.com/wotlk/ru/npc=15703
UPDATE `creature_template_locale` SET `Name` = 'Старший сержант Гримсфорд' WHERE `locale` = 'ruRU' AND `entry` = 15703;
-- OLD name : Главный сержант Кай'джин, subname : Ан'киражский вербовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=15704
UPDATE `creature_template_locale` SET `Name` = 'Старший сержант Кай''джин',`Title` = 'Ан''киражская вербовщица' WHERE `locale` = 'ruRU' AND `entry` = 15704;
-- OLD subname : Ан'киражский вербовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=15708
UPDATE `creature_template_locale` SET `Title` = 'Ан''киражская вербовщица' WHERE `locale` = 'ruRU' AND `entry` = 15708;
-- OLD subname : Ан'киражский вербовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=15709
UPDATE `creature_template_locale` SET `Title` = 'Ан''киражская вербовщица' WHERE `locale` = 'ruRU' AND `entry` = 15709;
-- OLD name : Blue Qiraji Battle Tank
-- Source : https://www.wowhead.com/wotlk/ru/npc=15713
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 15713;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15713, 'ruRU','[Blue Qiraji Battle Tank]',NULL);
-- OLD name : Сборщик похвальных значков из Дарнаса
-- Source : https://www.wowhead.com/wotlk/ru/npc=15731
UPDATE `creature_template_locale` SET `Name` = 'Сборщик похвальных значков из Дарнасса' WHERE `locale` = 'ruRU' AND `entry` = 15731;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=15732
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 15732;
-- OLD subname : Наградной отдел племени Черного Копья
-- Source : https://www.wowhead.com/wotlk/ru/npc=15761
UPDATE `creature_template_locale` SET `Title` = 'Награды племени Черного Копья' WHERE `locale` = 'ruRU' AND `entry` = 15761;
-- OLD subname : Наградной отдел Дарнаса
-- Source : https://www.wowhead.com/wotlk/ru/npc=15762
UPDATE `creature_template_locale` SET `Title` = 'Наградной отдел Дарнасса' WHERE `locale` = 'ruRU' AND `entry` = 15762;
-- OLD name : Ружейник-таурен
-- Source : https://www.wowhead.com/wotlk/ru/npc=15855
UPDATE `creature_template_locale` SET `Name` = 'Таурен-ружейник' WHERE `locale` = 'ruRU' AND `entry` = 15855;
-- OLD name : Калдорайский стрелок
-- Source : https://www.wowhead.com/wotlk/ru/npc=15860
UPDATE `creature_template_locale` SET `Name` = 'Калдорай-стрелок' WHERE `locale` = 'ruRU' AND `entry` = 15860;
-- OLD name : Следопыт Лесов Вечной Песни
-- Source : https://www.wowhead.com/wotlk/ru/npc=15938
UPDATE `creature_template_locale` SET `Name` = 'Следопыт из лесов Вечной Песни' WHERE `locale` = 'ruRU' AND `entry` = 15938;
-- OLD name : Следопыт Деголайн
-- Source : https://www.wowhead.com/wotlk/ru/npc=15939
UPDATE `creature_template_locale` SET `Name` = 'Следопыт Деголиен' WHERE `locale` = 'ruRU' AND `entry` = 15939;
-- OLD name : Следопыт Сарийна
-- Source : https://www.wowhead.com/wotlk/ru/npc=15942
UPDATE `creature_template_locale` SET `Name` = 'Следопыт Сарейн' WHERE `locale` = 'ruRU' AND `entry` = 15942;
-- OLD name : Магистр Блеклых Сумерек
-- Source : https://www.wowhead.com/wotlk/ru/npc=15951
UPDATE `creature_template_locale` SET `Name` = 'Магистр Блеклые Сумерки' WHERE `locale` = 'ruRU' AND `entry` = 15951;
-- OLD name : Ученик Блеклых Сумерек
-- Source : https://www.wowhead.com/wotlk/ru/npc=15965
UPDATE `creature_template_locale` SET `Name` = 'Ученик магистра Блеклые Сумерки' WHERE `locale` = 'ruRU' AND `entry` = 15965;
-- OLD name : Исчадие эфира
-- Source : https://www.wowhead.com/wotlk/ru/npc=15967
UPDATE `creature_template_locale` SET `Name` = 'Эфирный призрак' WHERE `locale` = 'ruRU' AND `entry` = 15967;
-- OLD name : Виллитен Хранитель Земель
-- Source : https://www.wowhead.com/wotlk/ru/npc=15969
UPDATE `creature_template_locale` SET `Name` = 'Смотритель Виллитен' WHERE `locale` = 'ruRU' AND `entry` = 15969;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=16000
UPDATE `creature_template_locale` SET `Title` = 'Учительница портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 16000;
-- OLD subname : Дом Шен'дралар
-- Source : https://www.wowhead.com/wotlk/ru/npc=16032
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 16032;
-- OLD name : Тан Кортазз
-- Source : https://www.wowhead.com/wotlk/ru/npc=16064
UPDATE `creature_template_locale` SET `Name` = 'Тан Корт''азз' WHERE `locale` = 'ruRU' AND `entry` = 16064;
-- OLD name : Жеребец смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=16067
UPDATE `creature_template_locale` SET `Name` = 'Конь смерти-жеребец' WHERE `locale` = 'ruRU' AND `entry` = 16067;
-- OLD name : Командир рыцарей Корфакс
-- Source : https://www.wowhead.com/wotlk/ru/npc=16112
UPDATE `creature_template_locale` SET `Name` = 'Корфакс, Воитель Света' WHERE `locale` = 'ruRU' AND `entry` = 16112;
-- OLD name : Командир Алого ордена Маржан
-- Source : https://www.wowhead.com/wotlk/ru/npc=16114
UPDATE `creature_template_locale` SET `Name` = 'Командор Алого ордена Маржан' WHERE `locale` = 'ruRU' AND `entry` = 16114;
-- OLD name : Командир Элигор Вестник Рассвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=16115
UPDATE `creature_template_locale` SET `Name` = 'Командор Элигор Вестник Рассвета' WHERE `locale` = 'ruRU' AND `entry` = 16115;
-- OLD name : Резервист крепости Кенария
-- Source : https://www.wowhead.com/wotlk/ru/npc=16139
UPDATE `creature_template_locale` SET `Name` = 'Резервист из крепости Кенария' WHERE `locale` = 'ruRU' AND `entry` = 16139;
-- OLD name : Капитан рыцарей Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=16145
UPDATE `creature_template_locale` SET `Name` = 'Капитан рыцарей смерти' WHERE `locale` = 'ruRU' AND `entry` = 16145;
-- OLD subname : Ночной страж
-- Source : https://www.wowhead.com/wotlk/ru/npc=16159
UPDATE `creature_template_locale` SET `Title` = 'Ночной сторож' WHERE `locale` = 'ruRU' AND `entry` = 16159;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=16160
UPDATE `creature_template_locale` SET `Title` = 'Учительница наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 16160;
-- OLD subname : Управляющий
-- Source : https://www.wowhead.com/wotlk/ru/npc=16169
UPDATE `creature_template_locale` SET `Title` = 'Уборщик' WHERE `locale` = 'ruRU' AND `entry` = 16169;
-- OLD name : Паук-ловец Холодного Тумана
-- Source : https://www.wowhead.com/wotlk/ru/npc=16170
UPDATE `creature_template_locale` SET `Name` = 'Паук-ловец холодного тумана' WHERE `locale` = 'ruRU' AND `entry` = 16170;
-- OLD name : Черная вдова Холодного Тумана
-- Source : https://www.wowhead.com/wotlk/ru/npc=16171
UPDATE `creature_template_locale` SET `Name` = 'Черная вдова холодного тумана' WHERE `locale` = 'ruRU' AND `entry` = 16171;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=16185
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 16185;
-- OLD subname : Торговец тканями и кожей
-- Source : https://www.wowhead.com/wotlk/ru/npc=16186
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканями и кожей' WHERE `locale` = 'ruRU' AND `entry` = 16186;
-- OLD name : Учитель наложения чар из дополнения, subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=16190
UPDATE `creature_template_locale` SET `Name` = 'Учительница наложения чар из дополнения',`Title` = 'Учительница наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 16190;
-- OLD subname : Укротитель дракондоров
-- Source : https://www.wowhead.com/wotlk/ru/npc=16192
UPDATE `creature_template_locale` SET `Title` = 'Укротительница дракондоров' WHERE `locale` = 'ruRU' AND `entry` = 16192;
-- OLD name : Нечестивые Мечи
-- Source : https://www.wowhead.com/wotlk/ru/npc=16216
UPDATE `creature_template_locale` SET `Name` = 'Нечестивые мечи' WHERE `locale` = 'ruRU' AND `entry` = 16216;
-- OLD name : Магистр Каендрис
-- Source : https://www.wowhead.com/wotlk/ru/npc=16239
UPDATE `creature_template_locale` SET `Name` = 'Магистр Кендрис' WHERE `locale` = 'ruRU' AND `entry` = 16239;
-- OLD name : Разведчик Транквиллиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=16242
UPDATE `creature_template_locale` SET `Name` = 'Разведчик из Транквиллиона' WHERE `locale` = 'ruRU' AND `entry` = 16242;
-- OLD name : Верховный палач Маврен
-- Source : https://www.wowhead.com/wotlk/ru/npc=16252
UPDATE `creature_template_locale` SET `Name` = 'Верховный вершитель Маврен' WHERE `locale` = 'ruRU' AND `entry` = 16252;
-- OLD name : Главный шеф-повар Плеснер, subname : Кулинария: обучение и товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=16253
UPDATE `creature_template_locale` SET `Name` = 'Шеф-повар Плеснер',`Title` = 'Учитель кулинарии и торговец' WHERE `locale` = 'ruRU' AND `entry` = 16253;
-- OLD name : Разведчик из ордена Серебряного Рассвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=16255
UPDATE `creature_template_locale` SET `Name` = 'Разведчик из Серебряного Авангарда' WHERE `locale` = 'ruRU' AND `entry` = 16255;
-- OLD subname : Разводчик крылобегов
-- Source : https://www.wowhead.com/wotlk/ru/npc=16264
UPDATE `creature_template_locale` SET `Title` = 'Заводчица крылобегов' WHERE `locale` = 'ruRU' AND `entry` = 16264;
-- OLD subname : Торговец ядами
-- Source : https://www.wowhead.com/wotlk/ru/npc=16268
UPDATE `creature_template_locale` SET `Title` = 'Торговка ядами' WHERE `locale` = 'ruRU' AND `entry` = 16268;
-- OLD name : Теленус
-- Source : https://www.wowhead.com/wotlk/ru/npc=16271
UPDATE `creature_template_locale` SET `Name` = 'Телен' WHERE `locale` = 'ruRU' AND `entry` = 16271;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=16274
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 16274;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=16277
UPDATE `creature_template_locale` SET `Title` = 'Учительница кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 16277;
-- OLD subname : Rogue Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=16279
UPDATE `creature_template_locale` SET `Title` = 'Наставник разбойников' WHERE `locale` = 'ruRU' AND `entry` = 16279;
-- OLD name : Жутекостный скелет
-- Source : https://www.wowhead.com/wotlk/ru/npc=16303
UPDATE `creature_template_locale` SET `Name` = 'Жуткий скелет' WHERE `locale` = 'ruRU' AND `entry` = 16303;
-- OLD name : Жутекостный скелет-часовой
-- Source : https://www.wowhead.com/wotlk/ru/npc=16305
UPDATE `creature_template_locale` SET `Name` = 'Жуткий скелет-часовой' WHERE `locale` = 'ruRU' AND `entry` = 16305;
-- OLD name : Некромант Смертхольма
-- Source : https://www.wowhead.com/wotlk/ru/npc=16317
UPDATE `creature_template_locale` SET `Name` = 'Некромант из Смертхольма' WHERE `locale` = 'ruRU' AND `entry` = 16317;
-- OLD name : Черный маг Смертхольма
-- Source : https://www.wowhead.com/wotlk/ru/npc=16318
UPDATE `creature_template_locale` SET `Name` = 'Темный маг из Смертхольма' WHERE `locale` = 'ruRU' AND `entry` = 16318;
-- OLD name : Око Дар'Кхана
-- Source : https://www.wowhead.com/wotlk/ru/npc=16320
UPDATE `creature_template_locale` SET `Name` = 'Око Дар''Хана' WHERE `locale` = 'ruRU' AND `entry` = 16320;
-- OLD name : Дар'Кхан Дратир
-- Source : https://www.wowhead.com/wotlk/ru/npc=16329
UPDATE `creature_template_locale` SET `Name` = 'Дар''Хан Дратир' WHERE `locale` = 'ruRU' AND `entry` = 16329;
-- OLD name : Секретный агент-часовой
-- Source : https://www.wowhead.com/wotlk/ru/npc=16333
UPDATE `creature_template_locale` SET `Name` = 'Часовая-шпионка' WHERE `locale` = 'ruRU' AND `entry` = 16333;
-- OLD name : Ведьмак племени Призрачной Сосны
-- Source : https://www.wowhead.com/wotlk/ru/npc=16341
UPDATE `creature_template_locale` SET `Name` = 'Ведьмак из племени Призрачной Сосны' WHERE `locale` = 'ruRU' AND `entry` = 16341;
-- OLD name : Оракул племени Призрачной Сосны
-- Source : https://www.wowhead.com/wotlk/ru/npc=16343
UPDATE `creature_template_locale` SET `Name` = 'Оракул из племени Призрачной Сосны' WHERE `locale` = 'ruRU' AND `entry` = 16343;
-- OLD name : Пылающий кристалл
-- Source : https://www.wowhead.com/wotlk/ru/npc=16364
UPDATE `creature_template_locale` SET `Name` = 'Заряженный кристалл' WHERE `locale` = 'ruRU' AND `entry` = 16364;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=16366
UPDATE `creature_template_locale` SET `Title` = 'Учительница портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 16366;
-- OLD subname : Травничество: обучение и товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=16367
UPDATE `creature_template_locale` SET `Title` = 'Торговец и учитель травничества' WHERE `locale` = 'ruRU' AND `entry` = 16367;
-- OLD name : Превращенный в курицу
-- Source : https://www.wowhead.com/wotlk/ru/npc=16369
UPDATE `creature_template_locale` SET `Name` = 'Жертва превращения в курицу' WHERE `locale` = 'ruRU' AND `entry` = 16369;
-- OLD name : Превращенный в свинью
-- Source : https://www.wowhead.com/wotlk/ru/npc=16371
UPDATE `creature_template_locale` SET `Name` = 'Жертва превращения в свинью' WHERE `locale` = 'ruRU' AND `entry` = 16371;
-- OLD name : Превращенный в овцу
-- Source : https://www.wowhead.com/wotlk/ru/npc=16372
UPDATE `creature_template_locale` SET `Name` = 'Жертва превращения в овцу' WHERE `locale` = 'ruRU' AND `entry` = 16372;
-- OLD name : Превращенный в крысу
-- Source : https://www.wowhead.com/wotlk/ru/npc=16373
UPDATE `creature_template_locale` SET `Name` = 'Жертва превращения в крысу' WHERE `locale` = 'ruRU' AND `entry` = 16373;
-- OLD name : Превращенный в таракана
-- Source : https://www.wowhead.com/wotlk/ru/npc=16374
UPDATE `creature_template_locale` SET `Name` = 'Жертва превращения в таракана' WHERE `locale` = 'ruRU' AND `entry` = 16374;
-- OLD name : Превращенный в черепаху
-- Source : https://www.wowhead.com/wotlk/ru/npc=16377
UPDATE `creature_template_locale` SET `Name` = 'Жертва превращения в черепаху' WHERE `locale` = 'ruRU' AND `entry` = 16377;
-- OLD name : Караульный Серебряного Авангарда, subname : Серебряный Авангард
-- Source : https://www.wowhead.com/wotlk/ru/npc=16378
UPDATE `creature_template_locale` SET `Name` = 'Караульный из Серебряного Авангарда',`Title` = 'Серебряный Рассвет' WHERE `locale` = 'ruRU' AND `entry` = 16378;
-- OLD name : Призрачный студент
-- Source : https://www.wowhead.com/wotlk/ru/npc=16389
UPDATE `creature_template_locale` SET `Name` = 'Призрачный ученик' WHERE `locale` = 'ruRU' AND `entry` = 16389;
-- OLD name : Предатель шайки Кровавого Паруса
-- Source : https://www.wowhead.com/wotlk/ru/npc=16399
UPDATE `creature_template_locale` SET `Name` = 'Предатель из шайки Кровавого Паруса' WHERE `locale` = 'ruRU' AND `entry` = 16399;
-- OLD name : Иссохший мурлок из племени Зловещей Чешуи
-- Source : https://www.wowhead.com/wotlk/ru/npc=16403
UPDATE `creature_template_locale` SET `Name` = 'Иссохший мурлок из племени Темной Чешуи' WHERE `locale` = 'ruRU' AND `entry` = 16403;
-- OLD name : Фантомный лакей
-- Source : https://www.wowhead.com/wotlk/ru/npc=16408
UPDATE `creature_template_locale` SET `Name` = 'Фантомный служитель' WHERE `locale` = 'ruRU' AND `entry` = 16408;
-- OLD name : Призрачный охранитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=16410
UPDATE `creature_template_locale` SET `Name` = 'Призрачный эконом' WHERE `locale` = 'ruRU' AND `entry` = 16410;
-- OLD name : Фантомный пекарь
-- Source : https://www.wowhead.com/wotlk/ru/npc=16412
UPDATE `creature_template_locale` SET `Name` = 'Бестелесный пекарь' WHERE `locale` = 'ruRU' AND `entry` = 16412;
-- OLD name : Фантомный распорядитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=16414
UPDATE `creature_template_locale` SET `Name` = 'Бестелесный распорядитель' WHERE `locale` = 'ruRU' AND `entry` = 16414;
-- OLD name : Призрачный караульный
-- Source : https://www.wowhead.com/wotlk/ru/npc=16424
UPDATE `creature_template_locale` SET `Name` = 'Призрачный стражник' WHERE `locale` = 'ruRU' AND `entry` = 16424;
-- OLD name : Фантомный охранник
-- Source : https://www.wowhead.com/wotlk/ru/npc=16425
UPDATE `creature_template_locale` SET `Name` = 'Фантомный стражник' WHERE `locale` = 'ruRU' AND `entry` = 16425;
-- OLD name : Солдат Ледяных Пустошей
-- Source : https://www.wowhead.com/wotlk/ru/npc=16427
UPDATE `creature_template_locale` SET `Name` = 'Солдат ледяных пустошей' WHERE `locale` = 'ruRU' AND `entry` = 16427;
-- OLD name : Трактирщица Фаралия
-- Source : https://www.wowhead.com/wotlk/ru/npc=16458
UPDATE `creature_template_locale` SET `Name` = 'Фаралия' WHERE `locale` = 'ruRU' AND `entry` = 16458;
-- OLD name : Конкубина
-- Source : https://www.wowhead.com/wotlk/ru/npc=16461
UPDATE `creature_template_locale` SET `Name` = 'Рьяная пассия' WHERE `locale` = 'ruRU' AND `entry` = 16461;
-- OLD name : Призрачный завсегдатай
-- Source : https://www.wowhead.com/wotlk/ru/npc=16468
UPDATE `creature_template_locale` SET `Name` = 'Призрачный зритель' WHERE `locale` = 'ruRU' AND `entry` = 16468;
-- OLD name : Темный чародей племени Призрачной Сосны
-- Source : https://www.wowhead.com/wotlk/ru/npc=16469
UPDATE `creature_template_locale` SET `Name` = 'Темный чародей из племени Призрачной Сосны' WHERE `locale` = 'ruRU' AND `entry` = 16469;
-- OLD name : Фантомный филантроп
-- Source : https://www.wowhead.com/wotlk/ru/npc=16470
UPDATE `creature_template_locale` SET `Name` = 'Бестелесный филантроп' WHERE `locale` = 'ruRU' AND `entry` = 16470;
-- OLD name : Скелет-привратник
-- Source : https://www.wowhead.com/wotlk/ru/npc=16471
UPDATE `creature_template_locale` SET `Name` = 'Скелет-билетер' WHERE `locale` = 'ruRU' AND `entry` = 16471;
-- OLD name : Проэнтиус
-- Source : https://www.wowhead.com/wotlk/ru/npc=16477
UPDATE `creature_template_locale` SET `Name` = 'Проэнитус' WHERE `locale` = 'ruRU' AND `entry` = 16477;
-- OLD name : Совун Совиных холмов
-- Source : https://www.wowhead.com/wotlk/ru/npc=16518
UPDATE `creature_template_locale` SET `Name` = 'Совун с Совиных холмов' WHERE `locale` = 'ruRU' AND `entry` = 16518;
-- OLD name : Учитель травничества из Запределья, subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=16527
UPDATE `creature_template_locale` SET `Name` = 'Учительница травничества из Запределья',`Title` = 'Мастер травничества' WHERE `locale` = 'ruRU' AND `entry` = 16527;
-- OLD name : Привитый совун Совиных холмов
-- Source : https://www.wowhead.com/wotlk/ru/npc=16534
UPDATE `creature_template_locale` SET `Name` = 'Привитый совун с Совиных холмов' WHERE `locale` = 'ruRU' AND `entry` = 16534;
-- OLD name : Трактирщик Каларин
-- Source : https://www.wowhead.com/wotlk/ru/npc=16542
UPDATE `creature_template_locale` SET `Name` = 'Каларин' WHERE `locale` = 'ruRU' AND `entry` = 16542;
-- OLD name : Грибная тварь
-- Source : https://www.wowhead.com/wotlk/ru/npc=16565
UPDATE `creature_template_locale` SET `Name` = 'Myconite Warrior (PH)' WHERE `locale` = 'ruRU' AND `entry` = 16565;
-- OLD name : Темный охотник Туджин
-- Source : https://www.wowhead.com/wotlk/ru/npc=16575
UPDATE `creature_template_locale` SET `Name` = 'Темный охотник Ту''джин' WHERE `locale` = 'ruRU' AND `entry` = 16575;
-- OLD subname : Рука Вождя
-- Source : https://www.wowhead.com/wotlk/ru/npc=16576
UPDATE `creature_template_locale` SET `Title` = 'Десница Вождя' WHERE `locale` = 'ruRU' AND `entry` = 16576;
-- OLD name : Часовой Соколиного Дозора
-- Source : https://www.wowhead.com/wotlk/ru/npc=16579
UPDATE `creature_template_locale` SET `Name` = 'Часовой из Соколиного дозора' WHERE `locale` = 'ruRU' AND `entry` = 16579;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=16583
UPDATE `creature_template_locale` SET `Title` = 'Мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 16583;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=16588
UPDATE `creature_template_locale` SET `Title` = 'Мастер алхимии' WHERE `locale` = 'ruRU' AND `entry` = 16588;
-- OLD name : Послушник клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=16594
UPDATE `creature_template_locale` SET `Name` = 'Послушник из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 16594;
-- OLD name : Bri's Test Character
-- Source : https://www.wowhead.com/wotlk/ru/npc=16605
UPDATE `creature_template_locale` SET `Name` = 'Брианна Шнайдер' WHERE `locale` = 'ruRU' AND `entry` = 16605;
-- OLD subname : Продавец гербовых накидок
-- Source : https://www.wowhead.com/wotlk/ru/npc=16610
UPDATE `creature_template_locale` SET `Title` = 'Торговец гербовыми накидками' WHERE `locale` = 'ruRU' AND `entry` = 16610;
-- OLD name : Трактирщица Веландра
-- Source : https://www.wowhead.com/wotlk/ru/npc=16618
UPDATE `creature_template_locale` SET `Name` = 'Веландра' WHERE `locale` = 'ruRU' AND `entry` = 16618;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=16619
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 16619;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=16621
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 16621;
-- OLD subname : Торговец тканевыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=16623
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканевыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 16623;
-- OLD name : Кеели, subname : Торговец кольчужными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=16625
UPDATE `creature_template_locale` SET `Name` = 'Кили',`Title` = 'Торговка кольчужными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 16625;
-- OLD subname : Торговец латными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=16626
UPDATE `creature_template_locale` SET `Title` = 'Торговка латными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 16626;
-- OLD name : Аукционист Итиллан, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/ru/npc=16627
UPDATE `creature_template_locale` SET `Name` = 'Итиллан',`Title` = 'Аукционер' WHERE `locale` = 'ruRU' AND `entry` = 16627;
-- OLD name : Аукционистка Кайдори, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/ru/npc=16628
UPDATE `creature_template_locale` SET `Name` = 'Кайдори',`Title` = 'Аукционер' WHERE `locale` = 'ruRU' AND `entry` = 16628;
-- OLD name : Аукционист Тандрон, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/ru/npc=16629
UPDATE `creature_template_locale` SET `Name` = 'Тандрон',`Title` = 'Аукционер' WHERE `locale` = 'ruRU' AND `entry` = 16629;
-- OLD subname : Торговец одеждой
-- Source : https://www.wowhead.com/wotlk/ru/npc=16631
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеждой' WHERE `locale` = 'ruRU' AND `entry` = 16631;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=16633
UPDATE `creature_template_locale` SET `Title` = 'Учительница наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 16633;
-- OLD subname : Торговец жезлами
-- Source : https://www.wowhead.com/wotlk/ru/npc=16636
UPDATE `creature_template_locale` SET `Title` = 'Торговка жезлами' WHERE `locale` = 'ruRU' AND `entry` = 16636;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=16644
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 16644;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=16654
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 16654;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=16656
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 16656;
-- OLD name : Алестус
-- Source : https://www.wowhead.com/wotlk/ru/npc=16662
UPDATE `creature_template_locale` SET `Name` = 'Алест' WHERE `locale` = 'ruRU' AND `entry` = 16662;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=16667
UPDATE `creature_template_locale` SET `Title` = 'Учительница инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 16667;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=16676
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 16676;
-- OLD subname : Торговец ядами
-- Source : https://www.wowhead.com/wotlk/ru/npc=16683
UPDATE `creature_template_locale` SET `Title` = 'Торговка ядами' WHERE `locale` = 'ruRU' AND `entry` = 16683;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=16688
UPDATE `creature_template_locale` SET `Title` = 'Учительница кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 16688;
-- OLD subname : Продавец сумок
-- Source : https://www.wowhead.com/wotlk/ru/npc=16690
UPDATE `creature_template_locale` SET `Title` = 'Торговец сумками' WHERE `locale` = 'ruRU' AND `entry` = 16690;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=16694
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 16694;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=16696
UPDATE `creature_template_locale` SET `Title` = 'Военачальник ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 16696;
-- OLD name : Аукционист Эох, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/ru/npc=16707
UPDATE `creature_template_locale` SET `Name` = 'Эох',`Title` = 'Аукционер' WHERE `locale` = 'ruRU' AND `entry` = 16707;
-- OLD subname : Продавец сумок
-- Source : https://www.wowhead.com/wotlk/ru/npc=16709
UPDATE `creature_template_locale` SET `Title` = 'Торговка сумками' WHERE `locale` = 'ruRU' AND `entry` = 16709;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=16711
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 16711;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=16715
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 16715;
-- OLD subname : Торговец тканевыми доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=16716
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканевыми доспехами' WHERE `locale` = 'ruRU' AND `entry` = 16716;
-- OLD subname : Торговец одеждой
-- Source : https://www.wowhead.com/wotlk/ru/npc=16717
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеждой' WHERE `locale` = 'ruRU' AND `entry` = 16717;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=16719
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 16719;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/ru/npc=16720
UPDATE `creature_template_locale` SET `Title` = 'Наставник демонов' WHERE `locale` = 'ruRU' AND `entry` = 16720;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=16724
UPDATE `creature_template_locale` SET `Title` = 'Учительница кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 16724;
-- OLD subname : Торговец фейерверками
-- Source : https://www.wowhead.com/wotlk/ru/npc=16730
UPDATE `creature_template_locale` SET `Title` = 'Торговка фейерверками' WHERE `locale` = 'ruRU' AND `entry` = 16730;
-- OLD subname : Ружейник
-- Source : https://www.wowhead.com/wotlk/ru/npc=16735
UPDATE `creature_template_locale` SET `Title` = 'Ружейница' WHERE `locale` = 'ruRU' AND `entry` = 16735;
-- OLD subname : Ученица чаротворца
-- Source : https://www.wowhead.com/wotlk/ru/npc=16742
UPDATE `creature_template_locale` SET `Title` = 'Ученица зачаровывателя' WHERE `locale` = 'ruRU' AND `entry` = 16742;
-- OLD subname : Торговец кожаными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=16747
UPDATE `creature_template_locale` SET `Title` = 'Торговка кожаными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 16747;
-- OLD subname : Торговец латными доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=16753
UPDATE `creature_template_locale` SET `Title` = 'Торговка латными доспехами' WHERE `locale` = 'ruRU' AND `entry` = 16753;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=16755
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 16755;
-- OLD name : Кадмос
-- Source : https://www.wowhead.com/wotlk/ru/npc=16756
UPDATE `creature_template_locale` SET `Name` = 'Кедмос' WHERE `locale` = 'ruRU' AND `entry` = 16756;
-- OLD subname : Торговец одеяниями
-- Source : https://www.wowhead.com/wotlk/ru/npc=16758
UPDATE `creature_template_locale` SET `Title` = 'Торговка одеяниями' WHERE `locale` = 'ruRU' AND `entry` = 16758;
-- OLD subname : Торговец щитами
-- Source : https://www.wowhead.com/wotlk/ru/npc=16762
UPDATE `creature_template_locale` SET `Title` = 'Торговка щитами' WHERE `locale` = 'ruRU' AND `entry` = 16762;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=16763
UPDATE `creature_template_locale` SET `Title` = 'Учительница снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 16763;
-- OLD subname : Торговец ударным оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=16765
UPDATE `creature_template_locale` SET `Title` = 'Торговка ударным оружием' WHERE `locale` = 'ruRU' AND `entry` = 16765;
-- OLD subname : Продавец гербовых накидок
-- Source : https://www.wowhead.com/wotlk/ru/npc=16766
UPDATE `creature_template_locale` SET `Title` = 'Торговка гербовыми накидками' WHERE `locale` = 'ruRU' AND `entry` = 16766;
-- OLD subname : Торговец
-- Source : https://www.wowhead.com/wotlk/ru/npc=16768
UPDATE `creature_template_locale` SET `Title` = 'Торговка' WHERE `locale` = 'ruRU' AND `entry` = 16768;
-- OLD name : Чернокнижник из клана Огнекрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=16769
UPDATE `creature_template_locale` SET `Name` = 'Чернокнижник из армии Огнекрылых' WHERE `locale` = 'ruRU' AND `entry` = 16769;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=16773
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 16773;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=16774
UPDATE `creature_template_locale` SET `Title` = 'Учительница рыбной ловли' WHERE `locale` = 'ruRU' AND `entry` = 16774;
-- OLD name : Превращенная корова
-- Source : https://www.wowhead.com/wotlk/ru/npc=16779
UPDATE `creature_template_locale` SET `Name` = 'Жертва превращения в корову' WHERE `locale` = 'ruRU' AND `entry` = 16779;
-- OLD name : Дреней-узник
-- Source : https://www.wowhead.com/wotlk/ru/npc=16795
UPDATE `creature_template_locale` SET `Name` = 'Пленный дреней' WHERE `locale` = 'ruRU' AND `entry` = 16795;
-- OLD subname : Правящий лорд Кель'Таласа
-- Source : https://www.wowhead.com/wotlk/ru/npc=16802
UPDATE `creature_template_locale` SET `Title` = 'Лорд-регент Кель''Таласа' WHERE `locale` = 'ruRU' AND `entry` = 16802;
-- OLD name : Распорядитель полетов Крилла Грузнер
-- Source : https://www.wowhead.com/wotlk/ru/npc=16822
UPDATE `creature_template_locale` SET `Name` = 'Распорядительница полетов Крилла Грузнер' WHERE `locale` = 'ruRU' AND `entry` = 16822;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=16823
UPDATE `creature_template_locale` SET `Title` = 'Мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 16823;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=16824
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 16824;
-- OLD name : Археолог из Лиги исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=16835
UPDATE `creature_template_locale` SET `Name` = 'Археолог Лиги исследователей' WHERE `locale` = 'ruRU' AND `entry` = 16835;
-- OLD name : Шахтер Оплота Чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=16838
UPDATE `creature_template_locale` SET `Name` = 'Шахтер из Оплота Чести' WHERE `locale` = 'ruRU' AND `entry` = 16838;
-- OLD name : Кавалерист Оплота Чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=16843
UPDATE `creature_template_locale` SET `Name` = 'Кавалерист из Оплота Чести' WHERE `locale` = 'ruRU' AND `entry` = 16843;
-- OLD name : Винсум
-- Source : https://www.wowhead.com/wotlk/ru/npc=16868
UPDATE `creature_template_locale` SET `Name` = 'Душегуб из клана Веселого Черепа' WHERE `locale` = 'ruRU' AND `entry` = 16868;
-- OLD name : Цзисин
-- Source : https://www.wowhead.com/wotlk/ru/npc=16869
UPDATE `creature_template_locale` SET `Name` = 'Неофит из клана Веселого Черепа' WHERE `locale` = 'ruRU' AND `entry` = 16869;
-- OLD name : Сквернокровый ужас
-- Source : https://www.wowhead.com/wotlk/ru/npc=16881
UPDATE `creature_template_locale` SET `Name` = 'Сквернокровный ужас' WHERE `locale` = 'ruRU' AND `entry` = 16881;
-- OLD name : Участник праздника в Дарнасе
-- Source : https://www.wowhead.com/wotlk/ru/npc=16892
UPDATE `creature_template_locale` SET `Name` = 'Участник праздника в Дарнассе' WHERE `locale` = 'ruRU' AND `entry` = 16892;
-- OLD name : Лучник Оплота Чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=16896
UPDATE `creature_template_locale` SET `Name` = 'Лучник из Оплота Чести' WHERE `locale` = 'ruRU' AND `entry` = 16896;
-- OLD subname : Торговец тканями и кожей
-- Source : https://www.wowhead.com/wotlk/ru/npc=16918
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканями и кожей' WHERE `locale` = 'ruRU' AND `entry` = 16918;
-- OLD subname : Оружейник
-- Source : https://www.wowhead.com/wotlk/ru/npc=16919
UPDATE `creature_template_locale` SET `Title` = 'Оружейница' WHERE `locale` = 'ruRU' AND `entry` = 16919;
-- OLD name : Страж долины Аммен
-- Source : https://www.wowhead.com/wotlk/ru/npc=16921
UPDATE `creature_template_locale` SET `Name` = 'Страж из долины Аммен' WHERE `locale` = 'ruRU' AND `entry` = 16921;
-- OLD name : Боевой волк Костеглодов
-- Source : https://www.wowhead.com/wotlk/ru/npc=16926
UPDATE `creature_template_locale` SET `Name` = 'Боевой волк клана Костеглодов' WHERE `locale` = 'ruRU' AND `entry` = 16926;
-- OLD name : Патрульный лагеря Легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=16953
UPDATE `creature_template_locale` SET `Name` = 'Патрульный из лагеря Легиона' WHERE `locale` = 'ruRU' AND `entry` = 16953;
-- OLD name : Легионер лагеря Легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=16954
UPDATE `creature_template_locale` SET `Name` = 'Легионер из лагеря Легиона' WHERE `locale` = 'ruRU' AND `entry` = 16954;
-- OLD name : Полководец Морк
-- Source : https://www.wowhead.com/wotlk/ru/npc=16964
UPDATE `creature_template_locale` SET `Name` = 'Воевода Морх' WHERE `locale` = 'ruRU' AND `entry` = 16964;
-- OLD name : Остроглаз Хаал'еши
-- Source : https://www.wowhead.com/wotlk/ru/npc=16965
UPDATE `creature_template_locale` SET `Name` = 'Остроглаз из племени Хаал''эш' WHERE `locale` = 'ruRU' AND `entry` = 16965;
-- OLD name : Ветроступ Хаал'еши
-- Source : https://www.wowhead.com/wotlk/ru/npc=16966
UPDATE `creature_template_locale` SET `Name` = 'Ветроступ из племени Хаал''эш' WHERE `locale` = 'ruRU' AND `entry` = 16966;
-- OLD name : Коготарь Хаал'еши
-- Source : https://www.wowhead.com/wotlk/ru/npc=16967
UPDATE `creature_template_locale` SET `Name` = 'Коготарь из племени Хаал''эш' WHERE `locale` = 'ruRU' AND `entry` = 16967;
-- OLD name : Канюк-костеклювач
-- Source : https://www.wowhead.com/wotlk/ru/npc=16972
UPDATE `creature_template_locale` SET `Name` = 'Канюк-костеклюй' WHERE `locale` = 'ruRU' AND `entry` = 16972;
-- OLD name : Стервятник-костеклювач
-- Source : https://www.wowhead.com/wotlk/ru/npc=16973
UPDATE `creature_template_locale` SET `Name` = 'Стервятник-костеклюй' WHERE `locale` = 'ruRU' AND `entry` = 16973;
-- OLD name : Хранитель праздничного пламени (таурен)
-- Source : https://www.wowhead.com/wotlk/ru/npc=16987
UPDATE `creature_template_locale` SET `Name` = 'Хранительница праздничного пламени (таурен)' WHERE `locale` = 'ruRU' AND `entry` = 16987;
-- OLD name : Хранитель праздничного пламени (человек)
-- Source : https://www.wowhead.com/wotlk/ru/npc=16988
UPDATE `creature_template_locale` SET `Name` = 'Хранительница праздничного пламени (человек)' WHERE `locale` = 'ruRU' AND `entry` = 16988;
-- OLD subname : Weapon Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=17005
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по оружию' WHERE `locale` = 'ruRU' AND `entry` = 17005;
-- OLD name : Солдат клана Черной горы
-- Source : https://www.wowhead.com/wotlk/ru/npc=17017
UPDATE `creature_template_locale` SET `Name` = 'Солдат из клана Черной горы' WHERE `locale` = 'ruRU' AND `entry` = 17017;
-- OLD name : Солдат Северного Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=17019
UPDATE `creature_template_locale` SET `Name` = 'Солдат из клана Северного Волка' WHERE `locale` = 'ruRU' AND `entry` = 17019;
-- OLD name : Огнеглотатель Штормграда
-- Source : https://www.wowhead.com/wotlk/ru/npc=17038
UPDATE `creature_template_locale` SET `Name` = 'Огнеглотатель из Штормграда' WHERE `locale` = 'ruRU' AND `entry` = 17038;
-- OLD name : Огнеглотатель Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=17048
UPDATE `creature_template_locale` SET `Name` = 'Огнеглотатель из Стальгорна' WHERE `locale` = 'ruRU' AND `entry` = 17048;
-- OLD name : Огнеглотатель Дарнаса
-- Source : https://www.wowhead.com/wotlk/ru/npc=17049
UPDATE `creature_template_locale` SET `Name` = 'Огнеглотатель из Дарнасса' WHERE `locale` = 'ruRU' AND `entry` = 17049;
-- OLD name : Огнеглотатель Громового Утеса
-- Source : https://www.wowhead.com/wotlk/ru/npc=17050
UPDATE `creature_template_locale` SET `Name` = 'Огнеглотатель из Громового Утеса' WHERE `locale` = 'ruRU' AND `entry` = 17050;
-- OLD name : Огнеглотатель Подгорода
-- Source : https://www.wowhead.com/wotlk/ru/npc=17051
UPDATE `creature_template_locale` SET `Name` = 'Огнеглотатель из Подгорода' WHERE `locale` = 'ruRU' AND `entry` = 17051;
-- OLD name : Любитель вечеринок Лесов Вечной Песни
-- Source : https://www.wowhead.com/wotlk/ru/npc=17056
UPDATE `creature_template_locale` SET `Name` = 'Тусовщик из лесов Вечной Песни' WHERE `locale` = 'ruRU' AND `entry` = 17056;
-- OLD subname : Повелительница рыцарей крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=17076
UPDATE `creature_template_locale` SET `Title` = 'Матриарх рыцарей крови' WHERE `locale` = 'ruRU' AND `entry` = 17076;
-- OLD subname : Рыбная ловля: обучение и снасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=17101
UPDATE `creature_template_locale` SET `Title` = 'Учительница рыбной ловли' WHERE `locale` = 'ruRU' AND `entry` = 17101;
-- OLD subname : Mage Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=17105
UPDATE `creature_template_locale` SET `Title` = 'Наставница магов' WHERE `locale` = 'ruRU' AND `entry` = 17105;
-- OLD name : Воин клана Тяжелого Кулака
-- Source : https://www.wowhead.com/wotlk/ru/npc=17136
UPDATE `creature_template_locale` SET `Name` = 'Воин из клана Тяжелого Кулака' WHERE `locale` = 'ruRU' AND `entry` = 17136;
-- OLD name : Маг клана Тяжелого Кулака
-- Source : https://www.wowhead.com/wotlk/ru/npc=17137
UPDATE `creature_template_locale` SET `Name` = 'Маг из клана Тяжелого Кулака' WHERE `locale` = 'ruRU' AND `entry` = 17137;
-- OLD name : Легионер стражи Скверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=17152
UPDATE `creature_template_locale` SET `Name` = 'Страж Скверны - легионер' WHERE `locale` = 'ruRU' AND `entry` = 17152;
-- OLD name : Water Elemental [UNUSED]
-- Source : https://www.wowhead.com/wotlk/ru/npc=17165
UPDATE `creature_template_locale` SET `Name` = '(NPC #17165)' WHERE `locale` = 'ruRU' AND `entry` = 17165;
-- OLD name : Мирмидон клана Зловещей Чешуи
-- Source : https://www.wowhead.com/wotlk/ru/npc=17194
UPDATE `creature_template_locale` SET `Name` = 'Мирмидон из клана Зловещей Чешуи' WHERE `locale` = 'ruRU' AND `entry` = 17194;
-- OLD name : Анахорет Фатима
-- Source : https://www.wowhead.com/wotlk/ru/npc=17214
UPDATE `creature_template_locale` SET `Name` = 'Анахоретка Фатима' WHERE `locale` = 'ruRU' AND `entry` = 17214;
-- OLD name : Работник Даэло
-- Source : https://www.wowhead.com/wotlk/ru/npc=17222
UPDATE `creature_template_locale` SET `Name` = 'Механолог Даэло' WHERE `locale` = 'ruRU' AND `entry` = 17222;
-- OLD subname : Рыцари Серебряной Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=17233
UPDATE `creature_template_locale` SET `Title` = 'Рыцари ордена Серебряной Длани' WHERE `locale` = 'ruRU' AND `entry` = 17233;
-- OLD name : Алчущий из клана Костеглодов
-- Source : https://www.wowhead.com/wotlk/ru/npc=17259
UPDATE `creature_template_locale` SET `Name` = 'Пожиратель из клана Костеглодов' WHERE `locale` = 'ruRU' AND `entry` = 17259;
-- OLD name : Следопыт Соколиного Дозора
-- Source : https://www.wowhead.com/wotlk/ru/npc=17282
UPDATE `creature_template_locale` SET `Name` = 'Следопыт из Соколиного дозора' WHERE `locale` = 'ruRU' AND `entry` = 17282;
-- OLD name : Неубиваемый тестовый манекен Спаммер
-- Source : https://www.wowhead.com/wotlk/ru/npc=17313
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy Spammer' WHERE `locale` = 'ruRU' AND `entry` = 17313;
-- OLD name : Чернокнижник клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=17371
UPDATE `creature_template_locale` SET `Name` = 'Чернокнижник из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 17371;
-- OLD name : Родоначальник племени Тихвой
-- Source : https://www.wowhead.com/wotlk/ru/npc=17379
UPDATE `creature_template_locale` SET `Name` = 'Родоначальник племени Тихвой Акида' WHERE `locale` = 'ruRU' AND `entry` = 17379;
-- OLD name : Пехотинец Оплота Чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=17382
UPDATE `creature_template_locale` SET `Name` = 'Пехотинец из Оплота Чести' WHERE `locale` = 'ruRU' AND `entry` = 17382;
-- OLD name : Стрелок Оплота Чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=17383
UPDATE `creature_template_locale` SET `Name` = 'Стрелок из Оплота Чести' WHERE `locale` = 'ruRU' AND `entry` = 17383;
-- OLD name : Колдун клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=17396
UPDATE `creature_template_locale` SET `Name` = 'Колдун из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 17396;
-- OLD name : Адепт клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=17397
UPDATE `creature_template_locale` SET `Name` = 'Адепт из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 17397;
-- OLD name : Страж Скверны-уничтожитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=17400
UPDATE `creature_template_locale` SET `Name` = 'Страж Скверны - уничтожитель' WHERE `locale` = 'ruRU' AND `entry` = 17400;
-- OLD name : Работник
-- Source : https://www.wowhead.com/wotlk/ru/npc=17406
UPDATE `creature_template_locale` SET `Name` = 'Механолог' WHERE `locale` = 'ruRU' AND `entry` = 17406;
-- OLD subname : Торговец оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=17412
UPDATE `creature_template_locale` SET `Title` = 'Торговка оружием' WHERE `locale` = 'ruRU' AND `entry` = 17412;
-- OLD name : Техник клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=17414
UPDATE `creature_template_locale` SET `Name` = 'Техник из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 17414;
-- OLD name : Защитник племени Тихвой
-- Source : https://www.wowhead.com/wotlk/ru/npc=17432
UPDATE `creature_template_locale` SET `Name` = 'Защитник из племени Тихвой' WHERE `locale` = 'ruRU' AND `entry` = 17432;
-- OLD name : Воздаятельница Алезия
-- Source : https://www.wowhead.com/wotlk/ru/npc=17433
UPDATE `creature_template_locale` SET `Name` = 'Воздаятельница Аалезия' WHERE `locale` = 'ruRU' AND `entry` = 17433;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=17434
UPDATE `creature_template_locale` SET `Title` = 'Учительница травничества' WHERE `locale` = 'ruRU' AND `entry` = 17434;
-- OLD name : Труп защитника племени Тихвой
-- Source : https://www.wowhead.com/wotlk/ru/npc=17437
UPDATE `creature_template_locale` SET `Name` = 'Труп защитника из племени Тихвой' WHERE `locale` = 'ruRU' AND `entry` = 17437;
-- OLD name : Огненная турель гномов
-- Source : https://www.wowhead.com/wotlk/ru/npc=17458
UPDATE `creature_template_locale` SET `Name` = 'Гномская огненная турель' WHERE `locale` = 'ruRU' AND `entry` = 17458;
-- OLD name : Рубака
-- Source : https://www.wowhead.com/wotlk/ru/npc=17469
UPDATE `creature_template_locale` SET `Name` = 'Орк-рубака' WHERE `locale` = 'ruRU' AND `entry` = 17469;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=17485
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 17485;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=17487
UPDATE `creature_template_locale` SET `Title` = 'Учительница портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 17487;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=17488
UPDATE `creature_template_locale` SET `Title` = 'Учительница горного дела' WHERE `locale` = 'ruRU' AND `entry` = 17488;
-- OLD name : Удрученная целительница
-- Source : https://www.wowhead.com/wotlk/ru/npc=17503
UPDATE `creature_template_locale` SET `Name` = 'Печальная целительница' WHERE `locale` = 'ruRU' AND `entry` = 17503;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=17507
UPDATE `creature_template_locale` SET `Title` = 'Военачальница ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 17507;
-- OLD name : Samantha LeCraft, subname : Mistress of Breadcrumbs
-- Source : https://www.wowhead.com/wotlk/ru/npc=17515
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 17515;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (17515, 'ruRU','Саманта Лекрафт','Повелительница хлебных крошек');
-- OLD name : Детеныш опустошителя Кровавой Дымки
-- Source : https://www.wowhead.com/wotlk/ru/npc=17525
UPDATE `creature_template_locale` SET `Name` = 'Детеныш опустошителя с острова Кровавой Дымки' WHERE `locale` = 'ruRU' AND `entry` = 17525;
-- OLD name : Опустошитель острова Кровавой Дымки
-- Source : https://www.wowhead.com/wotlk/ru/npc=17526
UPDATE `creature_template_locale` SET `Name` = 'Опустошитель с острова Кровавой Дымки' WHERE `locale` = 'ruRU' AND `entry` = 17526;
-- OLD name : Миротворец Кровавой заставы
-- Source : https://www.wowhead.com/wotlk/ru/npc=17549
UPDATE `creature_template_locale` SET `Name` = 'Миротворец с Кровавой заставы' WHERE `locale` = 'ruRU' AND `entry` = 17549;
-- OLD name : Тренировочный манекен полуострова
-- Source : https://www.wowhead.com/wotlk/ru/npc=17578
UPDATE `creature_template_locale` SET `Name` = 'Тренировочный манекен' WHERE `locale` = 'ruRU' AND `entry` = 17578;
-- OLD name : Test Monster
-- Source : https://www.wowhead.com/wotlk/ru/npc=17582
UPDATE `creature_template_locale` SET `Name` = '(NPC #17582)' WHERE `locale` = 'ruRU' AND `entry` = 17582;
-- OLD name : Эльф крови-бандит
-- Source : https://www.wowhead.com/wotlk/ru/npc=17591
UPDATE `creature_template_locale` SET `Name` = 'Эльф крови - бандит' WHERE `locale` = 'ruRU' AND `entry` = 17591;
-- OLD subname : Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/ru/npc=17598
UPDATE `creature_template_locale` SET `Title` = 'Продавец боеприпасов' WHERE `locale` = 'ruRU' AND `entry` = 17598;
-- OLD name : Рубака-орк Скверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=17625
UPDATE `creature_template_locale` SET `Name` = 'Орк Скверны - рубака' WHERE `locale` = 'ruRU' AND `entry` = 17625;
-- OLD name : Аукционист Дженат, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/ru/npc=17627
UPDATE `creature_template_locale` SET `Name` = 'Дженат',`Title` = 'Аукционер' WHERE `locale` = 'ruRU' AND `entry` = 17627;
-- OLD name : Аукционист Винна, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/ru/npc=17628
UPDATE `creature_template_locale` SET `Name` = 'Винна',`Title` = 'Аукционер' WHERE `locale` = 'ruRU' AND `entry` = 17628;
-- OLD name : Аукционистка Фейнна, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/ru/npc=17629
UPDATE `creature_template_locale` SET `Name` = 'Фейнна',`Title` = 'Аукционер' WHERE `locale` = 'ruRU' AND `entry` = 17629;
-- OLD name : Трактирщица Йова
-- Source : https://www.wowhead.com/wotlk/ru/npc=17630
UPDATE `creature_template_locale` SET `Name` = 'Йова' WHERE `locale` = 'ruRU' AND `entry` = 17630;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=17634
UPDATE `creature_template_locale` SET `Title` = 'Учитель мастеров инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 17634;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=17637
UPDATE `creature_template_locale` SET `Title` = 'Учитель мастеров инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 17637;
-- OLD name : Чаротворец клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=17653
UPDATE `creature_template_locale` SET `Name` = 'Чаротворец из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 17653;
-- OLD subname : Начальник снабжения Оплота Чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=17657
UPDATE `creature_template_locale` SET `Title` = 'Интендант Оплота Чести' WHERE `locale` = 'ruRU' AND `entry` = 17657;
-- OLD name : Джессера из Мак'Ари
-- Source : https://www.wowhead.com/wotlk/ru/npc=17663
UPDATE `creature_template_locale` SET `Name` = 'Матпарм' WHERE `locale` = 'ruRU' AND `entry` = 17663;
-- OLD subname : Глашатай Сиронаса
-- Source : https://www.wowhead.com/wotlk/ru/npc=17664
UPDATE `creature_template_locale` SET `Title` = 'Глашатай Сиронас' WHERE `locale` = 'ruRU' AND `entry` = 17664;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=17667
UPDATE `creature_template_locale` SET `Title` = 'Торговка луками' WHERE `locale` = 'ruRU' AND `entry` = 17667;
-- OLD name : Поганище Ман'ари
-- Source : https://www.wowhead.com/wotlk/ru/npc=17679
UPDATE `creature_template_locale` SET `Name` = 'Поганище ман''ари' WHERE `locale` = 'ruRU' AND `entry` = 17679;
-- OLD name : Принцесса Тихвоя
-- Source : https://www.wowhead.com/wotlk/ru/npc=17682
UPDATE `creature_template_locale` SET `Name` = 'Принцесса Тихвой' WHERE `locale` = 'ruRU' AND `entry` = 17682;
-- OLD name : Черный маг клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=17694
UPDATE `creature_template_locale` SET `Name` = 'Темный маг из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 17694;
-- OLD name : Вестник Гермесиус
-- Source : https://www.wowhead.com/wotlk/ru/npc=17703
UPDATE `creature_template_locale` SET `Name` = 'Вестник Гермесий' WHERE `locale` = 'ruRU' AND `entry` = 17703;
-- OLD name : Проклятая нага
-- Source : https://www.wowhead.com/wotlk/ru/npc=17713
UPDATE `creature_template_locale` SET `Name` = 'Нага с острова Проклятой Крови' WHERE `locale` = 'ruRU' AND `entry` = 17713;
-- OLD name : Проклятый путешественник
-- Source : https://www.wowhead.com/wotlk/ru/npc=17714
UPDATE `creature_template_locale` SET `Name` = 'Путешественник с острова Проклятой Крови' WHERE `locale` = 'ruRU' AND `entry` = 17714;
-- OLD name : Атоф Проклятый
-- Source : https://www.wowhead.com/wotlk/ru/npc=17715
UPDATE `creature_template_locale` SET `Name` = 'Атоф Проклятая Кровь' WHERE `locale` = 'ruRU' AND `entry` = 17715;
-- OLD name : Страж Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=17719
UPDATE `creature_template_locale` SET `Name` = 'Стальгорнский наездник на грифоне' WHERE `locale` = 'ruRU' AND `entry` = 17719;
-- OLD name : Гидромант Теспия
-- Source : https://www.wowhead.com/wotlk/ru/npc=17797
UPDATE `creature_template_locale` SET `Name` = 'Гидромантка Теспия' WHERE `locale` = 'ruRU' AND `entry` = 17797;
-- OLD name : Надсмотрщик резервуара Кривого Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=17805
UPDATE `creature_template_locale` SET `Name` = 'Надсмотрщик из резервуара Кривого Клыка' WHERE `locale` = 'ruRU' AND `entry` = 17805;
-- OLD name : Дознаватель Элизия
-- Source : https://www.wowhead.com/wotlk/ru/npc=17825
UPDATE `creature_template_locale` SET `Name` = 'Дознавательница Элизия' WHERE `locale` = 'ruRU' AND `entry` = 17825;
-- OLD name : Владыка болота Мусел'ек
-- Source : https://www.wowhead.com/wotlk/ru/npc=17826
UPDATE `creature_template_locale` SET `Name` = 'Владыка болот Мусел''ек' WHERE `locale` = 'ruRU' AND `entry` = 17826;
-- OLD subname : Питомец Владыки болот Мусел'ека
-- Source : https://www.wowhead.com/wotlk/ru/npc=17827
UPDATE `creature_template_locale` SET `Title` = 'Питомец владыки болот Мусел''ека' WHERE `locale` = 'ruRU' AND `entry` = 17827;
-- OLD name : Портал Времени
-- Source : https://www.wowhead.com/wotlk/ru/npc=17838
UPDATE `creature_template_locale` SET `Name` = 'Портал времени' WHERE `locale` = 'ruRU' AND `entry` = 17838;
-- OLD name : Тшу
-- Source : https://www.wowhead.com/wotlk/ru/npc=17857
UPDATE `creature_template_locale` SET `Name` = 'Т''шу' WHERE `locale` = 'ruRU' AND `entry` = 17857;
-- OLD name : Страж-смотритель Хамуут
-- Source : https://www.wowhead.com/wotlk/ru/npc=17858
UPDATE `creature_template_locale` SET `Name` = 'Страж Хамут' WHERE `locale` = 'ruRU' AND `entry` = 17858;
-- OLD subname : Глашатай Сиронаса
-- Source : https://www.wowhead.com/wotlk/ru/npc=17865
UPDATE `creature_template_locale` SET `Title` = 'Глашатай Сиронас' WHERE `locale` = 'ruRU' AND `entry` = 17865;
-- OLD name : Кнн'икс
-- Source : https://www.wowhead.com/wotlk/ru/npc=17866
UPDATE `creature_template_locale` SET `Name` = 'Кхн''икс' WHERE `locale` = 'ruRU' AND `entry` = 17866;
-- OLD name : Некрорахнид
-- Source : https://www.wowhead.com/wotlk/ru/npc=17897
UPDATE `creature_template_locale` SET `Name` = 'Некроарахнид' WHERE `locale` = 'ruRU' AND `entry` = 17897;
-- OLD name : Лауранна Тар'вел
-- Source : https://www.wowhead.com/wotlk/ru/npc=17909
UPDATE `creature_template_locale` SET `Name` = 'Лоранна Тар''велл' WHERE `locale` = 'ruRU' AND `entry` = 17909;
-- OLD name : Элементаль воды резервуара Кривого Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=17917
UPDATE `creature_template_locale` SET `Name` = 'Элементаль воды из резервуара Кривого Клыка' WHERE `locale` = 'ruRU' AND `entry` = 17917;
-- OLD subname : Торговец тканями и кожей
-- Source : https://www.wowhead.com/wotlk/ru/npc=17929
UPDATE `creature_template_locale` SET `Title` = 'Торговка тканями и кожей' WHERE `locale` = 'ruRU' AND `entry` = 17929;
-- OLD name : Ордынский рубака
-- Source : https://www.wowhead.com/wotlk/ru/npc=17932
UPDATE `creature_template_locale` SET `Name` = 'Рубака Орды' WHERE `locale` = 'ruRU' AND `entry` = 17932;
-- OLD name : Ордынский знахарь
-- Source : https://www.wowhead.com/wotlk/ru/npc=17935
UPDATE `creature_template_locale` SET `Name` = 'Знахарь Орды' WHERE `locale` = 'ruRU' AND `entry` = 17935;
-- OLD name : Ордынский шаман
-- Source : https://www.wowhead.com/wotlk/ru/npc=17936
UPDATE `creature_template_locale` SET `Name` = 'Шаман Орды' WHERE `locale` = 'ruRU' AND `entry` = 17936;
-- OLD name : Ордынский батрак
-- Source : https://www.wowhead.com/wotlk/ru/npc=17937
UPDATE `creature_template_locale` SET `Name` = 'Батрак Орды' WHERE `locale` = 'ruRU' AND `entry` = 17937;
-- OLD name : Укротитель резервуара Кривого Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=17959
UPDATE `creature_template_locale` SET `Name` = 'Рабовладелец из резервуара Кривого Клыка' WHERE `locale` = 'ruRU' AND `entry` = 17959;
-- OLD name : Катушка Теслы с Кровавой Дымки
-- Source : https://www.wowhead.com/wotlk/ru/npc=17979
UPDATE `creature_template_locale` SET `Name` = 'Катушка Теслы с острова Кровавой Дымки' WHERE `locale` = 'ruRU' AND `entry` = 17979;
-- OLD name : Страж-элементаль воды
-- Source : https://www.wowhead.com/wotlk/ru/npc=18001
UPDATE `creature_template_locale` SET `Name` = 'Элементаль воды - страж' WHERE `locale` = 'ruRU' AND `entry` = 18001;
-- OLD subname : Торговец реагентами
-- Source : https://www.wowhead.com/wotlk/ru/npc=18006
UPDATE `creature_template_locale` SET `Title` = 'Торговка реагентами' WHERE `locale` = 'ruRU' AND `entry` = 18006;
-- OLD name : Темный охотник Дэнжай
-- Source : https://www.wowhead.com/wotlk/ru/npc=18013
UPDATE `creature_template_locale` SET `Name` = 'Темный охотник Денжай' WHERE `locale` = 'ruRU' AND `entry` = 18013;
-- OLD name : Гамбаринко
-- Source : https://www.wowhead.com/wotlk/ru/npc=18015
UPDATE `creature_template_locale` SET `Name` = 'Гамбаринка' WHERE `locale` = 'ruRU' AND `entry` = 18015;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=18018
UPDATE `creature_template_locale` SET `Title` = 'Учительница рыбной ловли' WHERE `locale` = 'ruRU' AND `entry` = 18018;
-- OLD name : Миротворец острова Лазурной Дымки
-- Source : https://www.wowhead.com/wotlk/ru/npc=18038
UPDATE `creature_template_locale` SET `Name` = 'Миротворец с острова Лазурной Дымки' WHERE `locale` = 'ruRU' AND `entry` = 18038;
-- OLD name : Поработитель Тенетопи
-- Source : https://www.wowhead.com/wotlk/ru/npc=18042
UPDATE `creature_template_locale` SET `Name` = 'Поработитель из племени Тенетопи' WHERE `locale` = 'ruRU' AND `entry` = 18042;
-- OLD name : Оракул Тенетопи
-- Source : https://www.wowhead.com/wotlk/ru/npc=18077
UPDATE `creature_template_locale` SET `Name` = 'Оракул из племени Тенетопи' WHERE `locale` = 'ruRU' AND `entry` = 18077;
-- OLD name : Провидец Тенетопи
-- Source : https://www.wowhead.com/wotlk/ru/npc=18079
UPDATE `creature_template_locale` SET `Name` = 'Провидец из племени Тенетопи' WHERE `locale` = 'ruRU' AND `entry` = 18079;
-- OLD name : Стражник Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=18092
UPDATE `creature_template_locale` SET `Name` = 'Стражник из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 18092;
-- OLD name : Заступник Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=18093
UPDATE `creature_template_locale` SET `Name` = 'Защитник Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 18093;
-- OLD name : Смотритель Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=18094
UPDATE `creature_template_locale` SET `Name` = 'Дозорный из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 18094;
-- OLD subname : Ярость Земли
-- Source : https://www.wowhead.com/wotlk/ru/npc=18099
UPDATE `creature_template_locale` SET `Title` = 'Гнев Земли' WHERE `locale` = 'ruRU' AND `entry` = 18099;
-- OLD subname : Ярость Огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=18100
UPDATE `creature_template_locale` SET `Title` = 'Гнев Огня' WHERE `locale` = 'ruRU' AND `entry` = 18100;
-- OLD subname : Ярость Воды
-- Source : https://www.wowhead.com/wotlk/ru/npc=18101
UPDATE `creature_template_locale` SET `Title` = 'Гнев Воды' WHERE `locale` = 'ruRU' AND `entry` = 18101;
-- OLD subname : Ярость Воздуха
-- Source : https://www.wowhead.com/wotlk/ru/npc=18102
UPDATE `creature_template_locale` SET `Title` = 'Гнев Воздуха' WHERE `locale` = 'ruRU' AND `entry` = 18102;
-- OLD name : Экспедиционный разведчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=18126
UPDATE `creature_template_locale` SET `Name` = 'Разведчик экспедиции' WHERE `locale` = 'ruRU' AND `entry` = 18126;
-- OLD name : Угорь Тенетопи
-- Source : https://www.wowhead.com/wotlk/ru/npc=18138
UPDATE `creature_template_locale` SET `Name` = 'Угорь из озера Тенетопь' WHERE `locale` = 'ruRU' AND `entry` = 18138;
-- OLD name : Жнец из Спореггара
-- Source : https://www.wowhead.com/wotlk/ru/npc=18140
UPDATE `creature_template_locale` SET `Name` = 'Спореггарский жнец' WHERE `locale` = 'ruRU' AND `entry` = 18140;
-- OLD name : Следопыт Луносвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=18147
UPDATE `creature_template_locale` SET `Name` = 'Следопыт из Луносвета' WHERE `locale` = 'ruRU' AND `entry` = 18147;
-- OLD name : Расседлыватель элекков Кровавой Дымки
-- Source : https://www.wowhead.com/wotlk/ru/npc=18173
UPDATE `creature_template_locale` SET `Name` = 'Расседлыватель элекков с острова Кровавой Дымки' WHERE `locale` = 'ruRU' AND `entry` = 18173;
-- OLD name : Стражник Халаани (Орда)
-- Source : https://www.wowhead.com/wotlk/ru/npc=18192
UPDATE `creature_template_locale` SET `Name` = 'Стражник из Халаа (Орда)' WHERE `locale` = 'ruRU' AND `entry` = 18192;
-- OLD name : Селянин Солнечного Источника
-- Source : https://www.wowhead.com/wotlk/ru/npc=18240
UPDATE `creature_template_locale` SET `Name` = 'Житель заставы Солнечного Источника' WHERE `locale` = 'ruRU' AND `entry` = 18240;
-- OLD name : Стражник Халаани (Альянс)
-- Source : https://www.wowhead.com/wotlk/ru/npc=18256
UPDATE `creature_template_locale` SET `Name` = 'Стражник из Халаа (Альянс)' WHERE `locale` = 'ruRU' AND `entry` = 18256;
-- OLD name : Беженец заставы Солнечного Источника
-- Source : https://www.wowhead.com/wotlk/ru/npc=18293
UPDATE `creature_template_locale` SET `Name` = 'Беженец с заставы Солнечного Источника' WHERE `locale` = 'ruRU' AND `entry` = 18293;
-- OLD name : Магистр Луносвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=18336
UPDATE `creature_template_locale` SET `Name` = 'Магистр из Луносвета' WHERE `locale` = 'ruRU' AND `entry` = 18336;
-- OLD name : Аукционист Фанин, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/ru/npc=18348
UPDATE `creature_template_locale` SET `Name` = 'Фанин',`Title` = 'Аукционер' WHERE `locale` = 'ruRU' AND `entry` = 18348;
-- OLD name : Аукционистка Иресса, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/ru/npc=18349
UPDATE `creature_template_locale` SET `Name` = 'Иресса',`Title` = 'Аукционер' WHERE `locale` = 'ruRU' AND `entry` = 18349;
-- OLD name : Джаэла
-- Source : https://www.wowhead.com/wotlk/ru/npc=18350
UPDATE `creature_template_locale` SET `Name` = 'Джела' WHERE `locale` = 'ruRU' AND `entry` = 18350;
-- OLD name : Охотник клана Тяжелого Кулака
-- Source : https://www.wowhead.com/wotlk/ru/npc=18352
UPDATE `creature_template_locale` SET `Name` = 'Охотник из клана Тяжелого Кулака' WHERE `locale` = 'ruRU' AND `entry` = 18352;
-- OLD name : Маленький спорлинг
-- Source : https://www.wowhead.com/wotlk/ru/npc=18358
UPDATE `creature_template_locale` SET `Name` = 'Спореггарский спорлинг' WHERE `locale` = 'ruRU' AND `entry` = 18358;
-- OLD subname : Начальник снабжения Спореггара
-- Source : https://www.wowhead.com/wotlk/ru/npc=18382
UPDATE `creature_template_locale` SET `Title` = 'Интендант Спореггара' WHERE `locale` = 'ruRU' AND `entry` = 18382;
-- OLD name : Миротворец Кузни Бурь
-- Source : https://www.wowhead.com/wotlk/ru/npc=18405
UPDATE `creature_template_locale` SET `Name` = 'Миротворец из кузни бурь' WHERE `locale` = 'ruRU' AND `entry` = 18405;
-- OLD name : Влажночешуйчатый пожиратель
-- Source : https://www.wowhead.com/wotlk/ru/npc=18463
UPDATE `creature_template_locale` SET `Name` = 'Гладкоспинный пожиратель' WHERE `locale` = 'ruRU' AND `entry` = 18463;
-- OLD name : Странник Луносвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=18507
UPDATE `creature_template_locale` SET `Name` = 'Странник из Луносвета' WHERE `locale` = 'ruRU' AND `entry` = 18507;
-- OLD name : Ксири
-- Source : https://www.wowhead.com/wotlk/ru/npc=18528
UPDATE `creature_template_locale` SET `Name` = 'Зи''ри' WHERE `locale` = 'ruRU' AND `entry` = 18528;
-- OLD name : Ворен'таль Провидец
-- Source : https://www.wowhead.com/wotlk/ru/npc=18530
UPDATE `creature_template_locale` SET `Name` = 'Ворен''таль Предсказатель' WHERE `locale` = 'ruRU' AND `entry` = 18530;
-- OLD name : Курьер из клана Огнекрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=18548
UPDATE `creature_template_locale` SET `Name` = 'Курьер из армии Огнекрылых' WHERE `locale` = 'ruRU' AND `entry` = 18548;
-- OLD name : Тууремский душитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=18550
UPDATE `creature_template_locale` SET `Name` = 'Тууремский налетчик' WHERE `locale` = 'ruRU' AND `entry` = 18550;
-- OLD name : Сальсалабим
-- Source : https://www.wowhead.com/wotlk/ru/npc=18584
UPDATE `creature_template_locale` SET `Name` = 'Саль''салабим' WHERE `locale` = 'ruRU' AND `entry` = 18584;
-- OLD name : Кабалист-жрец Тени
-- Source : https://www.wowhead.com/wotlk/ru/npc=18637
UPDATE `creature_template_locale` SET `Name` = 'Кабалист-жрец Тьмы' WHERE `locale` = 'ruRU' AND `entry` = 18637;
-- OLD name : Крестьянин Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=18644
UPDATE `creature_template_locale` SET `Name` = 'Крестьянин из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 18644;
-- OLD name : Коневод Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=18646
UPDATE `creature_template_locale` SET `Name` = 'Коневод из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 18646;
-- OLD name : Трактирщица Моника
-- Source : https://www.wowhead.com/wotlk/ru/npc=18649
UPDATE `creature_template_locale` SET `Name` = 'Моника' WHERE `locale` = 'ruRU' AND `entry` = 18649;
-- OLD name : Конь Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=18650
UPDATE `creature_template_locale` SET `Name` = 'Конь из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 18650;
-- OLD name : Рыбак Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=18657
UPDATE `creature_template_locale` SET `Name` = 'Рыбак из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 18657;
-- OLD name : Черносерд Проповедник
-- Source : https://www.wowhead.com/wotlk/ru/npc=18667
UPDATE `creature_template_locale` SET `Name` = 'Черносерд Подстрекатель' WHERE `locale` = 'ruRU' AND `entry` = 18667;
-- OLD name : Соолавин
-- Source : https://www.wowhead.com/wotlk/ru/npc=18675
UPDATE `creature_template_locale` SET `Name` = 'Сулавин' WHERE `locale` = 'ruRU' AND `entry` = 18675;
-- OLD name : Таэла Вечная Странница
-- Source : https://www.wowhead.com/wotlk/ru/npc=18704
UPDATE `creature_template_locale` SET `Name` = 'Тэла Вечная Странница' WHERE `locale` = 'ruRU' AND `entry` = 18704;
-- OLD name : Мавг Лютострел
-- Source : https://www.wowhead.com/wotlk/ru/npc=18705
UPDATE `creature_template_locale` SET `Name` = 'Мауг Лютострел' WHERE `locale` = 'ruRU' AND `entry` = 18705;
-- OLD name : Верховой волк Костеглодов
-- Source : https://www.wowhead.com/wotlk/ru/npc=18706
UPDATE `creature_template_locale` SET `Name` = 'Верховой волк клана Костеглодов' WHERE `locale` = 'ruRU' AND `entry` = 18706;
-- OLD name : Владыка Судеб Каззак
-- Source : https://www.wowhead.com/wotlk/ru/npc=18728
UPDATE `creature_template_locale` SET `Name` = 'Владыка судеб Каззак' WHERE `locale` = 'ruRU' AND `entry` = 18728;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=18747
UPDATE `creature_template_locale` SET `Title` = 'Мастер горного дела' WHERE `locale` = 'ruRU' AND `entry` = 18747;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=18748
UPDATE `creature_template_locale` SET `Title` = 'Мастер травничества' WHERE `locale` = 'ruRU' AND `entry` = 18748;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=18749
UPDATE `creature_template_locale` SET `Title` = 'Мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 18749;
-- OLD name : Келаен, subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=18751
UPDATE `creature_template_locale` SET `Name` = 'Кален',`Title` = 'Мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 18751;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=18752
UPDATE `creature_template_locale` SET `Title` = 'Учитель мастеров инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 18752;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=18753
UPDATE `creature_template_locale` SET `Title` = 'Мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 18753;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=18754
UPDATE `creature_template_locale` SET `Title` = 'Мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 18754;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=18755
UPDATE `creature_template_locale` SET `Title` = 'Мастер снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 18755;
-- OLD name : Заступник Телхамата
-- Source : https://www.wowhead.com/wotlk/ru/npc=18758
UPDATE `creature_template_locale` SET `Name` = 'Защитник храма Телхамат' WHERE `locale` = 'ruRU' AND `entry` = 18758;
-- OLD name : Аукционистка Дариса, subname : Auctioneer
-- Source : https://www.wowhead.com/wotlk/ru/npc=18761
UPDATE `creature_template_locale` SET `Name` = 'Дариса',`Title` = 'Аукционер' WHERE `locale` = 'ruRU' AND `entry` = 18761;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=18771
UPDATE `creature_template_locale` SET `Title` = 'Мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 18771;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=18772
UPDATE `creature_template_locale` SET `Title` = 'Мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 18772;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=18773
UPDATE `creature_template_locale` SET `Title` = 'Мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 18773;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=18774
UPDATE `creature_template_locale` SET `Title` = 'Мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 18774;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=18775
UPDATE `creature_template_locale` SET `Title` = 'Учитель мастеров инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 18775;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=18776
UPDATE `creature_template_locale` SET `Title` = 'Мастер травничества' WHERE `locale` = 'ruRU' AND `entry` = 18776;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=18777
UPDATE `creature_template_locale` SET `Title` = 'Мастер снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 18777;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=18779
UPDATE `creature_template_locale` SET `Title` = 'Мастер горного дела' WHERE `locale` = 'ruRU' AND `entry` = 18779;
-- OLD name : Горожанин Луносвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=18799
UPDATE `creature_template_locale` SET `Name` = 'Житель Луносвета' WHERE `locale` = 'ruRU' AND `entry` = 18799;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=18802
UPDATE `creature_template_locale` SET `Title` = 'Мастер алхимии' WHERE `locale` = 'ruRU' AND `entry` = 18802;
-- OLD name : Посол клана Тихвой Фрасабу, subname : Военный атташе племени Тихвой
-- Source : https://www.wowhead.com/wotlk/ru/npc=18803
UPDATE `creature_template_locale` SET `Name` = 'Посол клана Тихвой Олорг',`Title` = 'Посланник племени Тихвой' WHERE `locale` = 'ruRU' AND `entry` = 18803;
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=18807
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 18807;
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=18808
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 18808;
-- OLD name : Тюремщик цитадели Адского Пламени
-- Source : https://www.wowhead.com/wotlk/ru/npc=18829
UPDATE `creature_template_locale` SET `Name` = 'Тюремщик из цитадели Адского Пламени' WHERE `locale` = 'ruRU' AND `entry` = 18829;
-- OLD name : Громила стражи Скверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=18894
UPDATE `creature_template_locale` SET `Name` = 'Страж Скверны - громила' WHERE `locale` = 'ruRU' AND `entry` = 18894;
-- OLD name : Трактирщик Базиль Олоф'тазун
-- Source : https://www.wowhead.com/wotlk/ru/npc=18905
UPDATE `creature_template_locale` SET `Name` = 'Базиль Олоф''тазун' WHERE `locale` = 'ruRU' AND `entry` = 18905;
-- OLD name : Трактирщик Корит Стоктрон
-- Source : https://www.wowhead.com/wotlk/ru/npc=18907
UPDATE `creature_template_locale` SET `Name` = 'Корит Стоктрон' WHERE `locale` = 'ruRU' AND `entry` = 18907;
-- OLD name : Трактирщик Керп
-- Source : https://www.wowhead.com/wotlk/ru/npc=18908
UPDATE `creature_template_locale` SET `Name` = 'Керп' WHERE `locale` = 'ruRU' AND `entry` = 18908;
-- OLD name : Стражник Забра'джина
-- Source : https://www.wowhead.com/wotlk/ru/npc=18909
UPDATE `creature_template_locale` SET `Name` = 'Стражник из Забра''джина' WHERE `locale` = 'ruRU' AND `entry` = 18909;
-- OLD name : Стражник заставы Болотной Крысы
-- Source : https://www.wowhead.com/wotlk/ru/npc=18910
UPDATE `creature_template_locale` SET `Name` = 'Стражник с заставы Болотной Крысы' WHERE `locale` = 'ruRU' AND `entry` = 18910;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=18911
UPDATE `creature_template_locale` SET `Title` = 'Мастер рыбной ловли' WHERE `locale` = 'ruRU' AND `entry` = 18911;
-- OLD name : Сиделка Изель
-- Source : https://www.wowhead.com/wotlk/ru/npc=18914
UPDATE `creature_template_locale` SET `Name` = 'Корчмарь Изель' WHERE `locale` = 'ruRU' AND `entry` = 18914;
-- OLD name : Работник Дренин
-- Source : https://www.wowhead.com/wotlk/ru/npc=18921
UPDATE `creature_template_locale` SET `Name` = 'Механолог Дренин' WHERE `locale` = 'ruRU' AND `entry` = 18921;
-- OLD name : Стражник Телредора
-- Source : https://www.wowhead.com/wotlk/ru/npc=18922
UPDATE `creature_template_locale` SET `Name` = 'Стражник из Телредора' WHERE `locale` = 'ruRU' AND `entry` = 18922;
-- OLD name : Работник Андрен
-- Source : https://www.wowhead.com/wotlk/ru/npc=18924
UPDATE `creature_template_locale` SET `Name` = 'Механолог Андрен' WHERE `locale` = 'ruRU' AND `entry` = 18924;
-- OLD subname : Продавец сыра
-- Source : https://www.wowhead.com/wotlk/ru/npc=18929
UPDATE `creature_template_locale` SET `Title` = 'Торговка сыром' WHERE `locale` = 'ruRU' AND `entry` = 18929;
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=18930
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 18930;
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=18942
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 18942;
-- OLD subname : Продавец сумок
-- Source : https://www.wowhead.com/wotlk/ru/npc=18947
UPDATE `creature_template_locale` SET `Title` = 'Торговец сумками' WHERE `locale` = 'ruRU' AND `entry` = 18947;
-- OLD subname : Припасы для наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=18951
UPDATE `creature_template_locale` SET `Title` = 'Товары для наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 18951;
-- OLD name : Моряк Мелинан
-- Source : https://www.wowhead.com/wotlk/ru/npc=18954
UPDATE `creature_template_locale` SET `Name` = 'Матрос Мелинан' WHERE `locale` = 'ruRU' AND `entry` = 18954;
-- OLD name : Трактирщица Грилка
-- Source : https://www.wowhead.com/wotlk/ru/npc=18957
UPDATE `creature_template_locale` SET `Name` = 'Грилка' WHERE `locale` = 'ruRU' AND `entry` = 18957;
-- OLD name : Мельгромм Высокогорец
-- Source : https://www.wowhead.com/wotlk/ru/npc=18969
UPDATE `creature_template_locale` SET `Name` = 'Мельгромм Крутогор' WHERE `locale` = 'ruRU' AND `entry` = 18969;
-- OLD name : Рубака форта Камнеломов
-- Source : https://www.wowhead.com/wotlk/ru/npc=18973
UPDATE `creature_template_locale` SET `Name` = 'Рубака из форта Камнеломов' WHERE `locale` = 'ruRU' AND `entry` = 18973;
-- OLD name : Разрущающий страж Скверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=18977
UPDATE `creature_template_locale` SET `Name` = 'Страж Скверны - разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 18977;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=18987
UPDATE `creature_template_locale` SET `Title` = 'Шеф-повар' WHERE `locale` = 'ruRU' AND `entry` = 18987;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=18988
UPDATE `creature_template_locale` SET `Title` = 'Шеф-повар' WHERE `locale` = 'ruRU' AND `entry` = 18988;
-- OLD name : Стражник форта Камнеломов
-- Source : https://www.wowhead.com/wotlk/ru/npc=18989
UPDATE `creature_template_locale` SET `Name` = 'Стражник из форта Камнеломов' WHERE `locale` = 'ruRU' AND `entry` = 18989;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=18990
UPDATE `creature_template_locale` SET `Title` = 'Медик' WHERE `locale` = 'ruRU' AND `entry` = 18990;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=18991
UPDATE `creature_template_locale` SET `Title` = 'Медик' WHERE `locale` = 'ruRU' AND `entry` = 18991;
-- OLD subname : Кулинария: обучение и товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=18993
UPDATE `creature_template_locale` SET `Title` = 'Товары для кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 18993;
-- OLD subname : Торговец оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=19001
UPDATE `creature_template_locale` SET `Title` = 'Торговка оружием' WHERE `locale` = 'ruRU' AND `entry` = 19001;
-- OLD name : Магистр Луносвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=19006
UPDATE `creature_template_locale` SET `Name` = 'Магистр из Луносвета' WHERE `locale` = 'ruRU' AND `entry` = 19006;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=19018
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 19018;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=19019
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 19019;
-- OLD name : Снабженец Миллс
-- Source : https://www.wowhead.com/wotlk/ru/npc=19038
UPDATE `creature_template_locale` SET `Name` = 'Интендант Миллс' WHERE `locale` = 'ruRU' AND `entry` = 19038;
-- OLD name : Прыготрон-4000
-- Source : https://www.wowhead.com/wotlk/ru/npc=19041
UPDATE `creature_template_locale` SET `Name` = 'Прыг-о-трон 4000' WHERE `locale` = 'ruRU' AND `entry` = 19041;
-- OLD name : Батрак форта Камнеломов
-- Source : https://www.wowhead.com/wotlk/ru/npc=19048
UPDATE `creature_template_locale` SET `Name` = 'Батрак из форта Камнеломов' WHERE `locale` = 'ruRU' AND `entry` = 19048;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=19052
UPDATE `creature_template_locale` SET `Title` = 'Мастер алхимии' WHERE `locale` = 'ruRU' AND `entry` = 19052;
-- OLD name : Новый учитель езды на лошадях
-- Source : https://www.wowhead.com/wotlk/ru/npc=19054
UPDATE `creature_template_locale` SET `Name` = 'Новый учитель верховой езды на лошадях' WHERE `locale` = 'ruRU' AND `entry` = 19054;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=19063
UPDATE `creature_template_locale` SET `Title` = 'Мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 19063;
-- OLD name : Изгой Скеттиса
-- Source : https://www.wowhead.com/wotlk/ru/npc=19075
UPDATE `creature_template_locale` SET `Name` = 'Изгой из Скеттиса' WHERE `locale` = 'ruRU' AND `entry` = 19075;
-- OLD subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=19145
UPDATE `creature_template_locale` SET `Title` = 'Дрессировщица лошадей' WHERE `locale` = 'ruRU' AND `entry` = 19145;
-- OLD name : Старый укротитель ящеров
-- Source : https://www.wowhead.com/wotlk/ru/npc=19146
UPDATE `creature_template_locale` SET `Name` = 'Старая укротительница ящеров' WHERE `locale` = 'ruRU' AND `entry` = 19146;
-- OLD name : Плененный воздаятель Халаани
-- Source : https://www.wowhead.com/wotlk/ru/npc=19157
UPDATE `creature_template_locale` SET `Name` = 'Плененный воздаятель из Халаа' WHERE `locale` = 'ruRU' AND `entry` = 19157;
-- OLD name : Страж гнева-защитник
-- Source : https://www.wowhead.com/wotlk/ru/npc=19160
UPDATE `creature_template_locale` SET `Name` = 'Гневостраж-защитник' WHERE `locale` = 'ruRU' AND `entry` = 19160;
-- OLD name : Патрульный Бурекузницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=19166
UPDATE `creature_template_locale` SET `Name` = 'Патрульный из кузни бурь' WHERE `locale` = 'ruRU' AND `entry` = 19166;
-- OLD name : Эльф крови-обыватель
-- Source : https://www.wowhead.com/wotlk/ru/npc=19169
UPDATE `creature_template_locale` SET `Name` = 'Эльф крови - обыватель' WHERE `locale` = 'ruRU' AND `entry` = 19169;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=19180
UPDATE `creature_template_locale` SET `Title` = 'Мастер снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 19180;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=19184
UPDATE `creature_template_locale` SET `Title` = 'Врач' WHERE `locale` = 'ruRU' AND `entry` = 19184;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=19185
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 19185;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=19187
UPDATE `creature_template_locale` SET `Title` = 'Мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 19187;
-- OLD subname : Торговец фруктами
-- Source : https://www.wowhead.com/wotlk/ru/npc=19223
UPDATE `creature_template_locale` SET `Title` = 'Торговка фруктами' WHERE `locale` = 'ruRU' AND `entry` = 19223;
-- OLD name : Трактирщик Хелтоль
-- Source : https://www.wowhead.com/wotlk/ru/npc=19232
UPDATE `creature_template_locale` SET `Name` = 'Хелтоль' WHERE `locale` = 'ruRU' AND `entry` = 19232;
-- OLD subname : Торговец жезлами
-- Source : https://www.wowhead.com/wotlk/ru/npc=19236
UPDATE `creature_template_locale` SET `Title` = 'Торговка жезлами' WHERE `locale` = 'ruRU' AND `entry` = 19236;
-- OLD subname : Продавец алкогольных напитков
-- Source : https://www.wowhead.com/wotlk/ru/npc=19245
UPDATE `creature_template_locale` SET `Title` = 'Торговец алкогольными напитками' WHERE `locale` = 'ruRU' AND `entry` = 19245;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=19251
UPDATE `creature_template_locale` SET `Title` = 'Учительница наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 19251;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=19252
UPDATE `creature_template_locale` SET `Title` = 'Мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 19252;
-- OLD name : Везир из клана Кровавой Глазницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=19268
UPDATE `creature_template_locale` SET `Name` = 'Советник из клана Кровавой Глазницы' WHERE `locale` = 'ruRU' AND `entry` = 19268;
-- OLD name : Захватчик-демон Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=19287
UPDATE `creature_template_locale` SET `Name` = 'Захватчик - демон Бездны' WHERE `locale` = 'ruRU' AND `entry` = 19287;
-- OLD name : Трактирщица Бириби
-- Source : https://www.wowhead.com/wotlk/ru/npc=19296
UPDATE `creature_template_locale` SET `Name` = 'Бириби' WHERE `locale` = 'ruRU' AND `entry` = 19296;
-- OLD name : Черносерд Проповедник
-- Source : https://www.wowhead.com/wotlk/ru/npc=19300
UPDATE `creature_template_locale` SET `Name` = 'Черносерд Подстрекатель' WHERE `locale` = 'ruRU' AND `entry` = 19300;
-- OLD name : Черносерд Проповедник
-- Source : https://www.wowhead.com/wotlk/ru/npc=19301
UPDATE `creature_template_locale` SET `Name` = 'Черносерд Подстрекатель' WHERE `locale` = 'ruRU' AND `entry` = 19301;
-- OLD name : Черносерд Проповедник
-- Source : https://www.wowhead.com/wotlk/ru/npc=19302
UPDATE `creature_template_locale` SET `Name` = 'Черносерд Подстрекатель' WHERE `locale` = 'ruRU' AND `entry` = 19302;
-- OLD name : Черносерд Проповедник
-- Source : https://www.wowhead.com/wotlk/ru/npc=19303
UPDATE `creature_template_locale` SET `Name` = 'Черносерд Подстрекатель' WHERE `locale` = 'ruRU' AND `entry` = 19303;
-- OLD name : Черносерд Проповедник
-- Source : https://www.wowhead.com/wotlk/ru/npc=19304
UPDATE `creature_template_locale` SET `Name` = 'Черносерд Подстрекатель' WHERE `locale` = 'ruRU' AND `entry` = 19304;
-- OLD name : Снабженец Шандрия
-- Source : https://www.wowhead.com/wotlk/ru/npc=19314
UPDATE `creature_template_locale` SET `Name` = 'Интендант Шандрия' WHERE `locale` = 'ruRU' AND `entry` = 19314;
-- OLD name : Снабженец Изабель
-- Source : https://www.wowhead.com/wotlk/ru/npc=19315
UPDATE `creature_template_locale` SET `Name` = 'Интендант Изабель' WHERE `locale` = 'ruRU' AND `entry` = 19315;
-- OLD name : Трактирщик Дарг Жилотяг
-- Source : https://www.wowhead.com/wotlk/ru/npc=19319
UPDATE `creature_template_locale` SET `Name` = 'Дарг Жилотяг' WHERE `locale` = 'ruRU' AND `entry` = 19319;
-- OLD name : Barnu Cragcrush, subname : Stable Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=19325
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 19325;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (19325, 'ruRU','Барну Скалобой','Смотрительница стойл');
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=19340
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 19340;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=19341
UPDATE `creature_template_locale` SET `Title` = 'Мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 19341;
-- OLD subname : Ружья
-- Source : https://www.wowhead.com/wotlk/ru/npc=19351
UPDATE `creature_template_locale` SET `Title` = 'Ружья и боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 19351;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=19368
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 19368;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=19369
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 19369;
-- OLD name : Ординн Брат Грома
-- Source : https://www.wowhead.com/wotlk/ru/npc=19370
UPDATE `creature_template_locale` SET `Name` = 'Ординн Громовой Кулак' WHERE `locale` = 'ruRU' AND `entry` = 19370;
-- OLD subname : Бронник
-- Source : https://www.wowhead.com/wotlk/ru/npc=19373
UPDATE `creature_template_locale` SET `Title` = 'Бронница' WHERE `locale` = 'ruRU' AND `entry` = 19373;
-- OLD name : Лейтенант стражи Скверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=19391
UPDATE `creature_template_locale` SET `Name` = 'Страж Скверны - лейтенант' WHERE `locale` = 'ruRU' AND `entry` = 19391;
-- OLD name : Воздаятель острова Лазурной Дымки
-- Source : https://www.wowhead.com/wotlk/ru/npc=19407
UPDATE `creature_template_locale` SET `Name` = 'Воздаятель с острова Лазурной Дымки' WHERE `locale` = 'ruRU' AND `entry` = 19407;
-- OLD name : Ворг из клана Кровавой Глазницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=19423
UPDATE `creature_template_locale` SET `Name` = 'Ворг клана Кровавой Глазницы' WHERE `locale` = 'ruRU' AND `entry` = 19423;
-- OLD name : Анахорет Каржа
-- Source : https://www.wowhead.com/wotlk/ru/npc=19467
UPDATE `creature_template_locale` SET `Name` = 'Анахоретка Каржа' WHERE `locale` = 'ruRU' AND `entry` = 19467;
-- OLD subname : Продавец рыбы и снастей
-- Source : https://www.wowhead.com/wotlk/ru/npc=19472
UPDATE `creature_template_locale` SET `Title` = 'Торговец рыбой и снастями' WHERE `locale` = 'ruRU' AND `entry` = 19472;
-- OLD subname : Метательное оружие
-- Source : https://www.wowhead.com/wotlk/ru/npc=19473
UPDATE `creature_template_locale` SET `Title` = 'Метательное оружие и боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 19473;
-- OLD name : Комендант Смертехрон
-- Source : https://www.wowhead.com/wotlk/ru/npc=19488
UPDATE `creature_template_locale` SET `Name` = 'Смотритель Дайворт' WHERE `locale` = 'ruRU' AND `entry` = 19488;
-- OLD subname : Учитель верховой езды
-- Source : https://www.wowhead.com/wotlk/ru/npc=19490
UPDATE `creature_template_locale` SET `Title` = 'Учительница верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 19490;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=19491
UPDATE `creature_template_locale` SET `Title` = 'Учительница верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 19491;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=19492
UPDATE `creature_template_locale` SET `Title` = 'Учительница верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 19492;
-- OLD name : Трактирщица Шонесси
-- Source : https://www.wowhead.com/wotlk/ru/npc=19495
UPDATE `creature_template_locale` SET `Name` = 'Шонесси' WHERE `locale` = 'ruRU' AND `entry` = 19495;
-- OLD name : Часовой Сильванаара
-- Source : https://www.wowhead.com/wotlk/ru/npc=19500
UPDATE `creature_template_locale` SET `Name` = 'Часовая из Сильванаара' WHERE `locale` = 'ruRU' AND `entry` = 19500;
-- OLD name : Защитник Нижнего Города, subname : Нижний Город
-- Source : https://www.wowhead.com/wotlk/ru/npc=19501
UPDATE `creature_template_locale` SET `Name` = 'Защитник Нижнего города',`Title` = 'Нижний город' WHERE `locale` = 'ruRU' AND `entry` = 19501;
-- OLD name : Целитель из Нижнего Города
-- Source : https://www.wowhead.com/wotlk/ru/npc=19502
UPDATE `creature_template_locale` SET `Name` = 'Целитель из Нижнего города' WHERE `locale` = 'ruRU' AND `entry` = 19502;
-- OLD name : Нексус-стражник Штормовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=19529
UPDATE `creature_template_locale` SET `Name` = 'Стражник нексуса из Штормовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 19529;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=19539
UPDATE `creature_template_locale` SET `Title` = 'Мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 19539;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=19540
UPDATE `creature_template_locale` SET `Title` = 'Мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 19540;
-- OLD name : Кольен Ледоплет
-- Source : https://www.wowhead.com/wotlk/ru/npc=19545
UPDATE `creature_template_locale` SET `Name` = 'Кольен Повелитель Льда' WHERE `locale` = 'ruRU' AND `entry` = 19545;
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=19558
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 19558;
-- OLD name : Командующий ракетами Фьюзеляж
-- Source : https://www.wowhead.com/wotlk/ru/npc=19570
UPDATE `creature_template_locale` SET `Name` = 'Ведущий ракетостроитель Фьюзеляж' WHERE `locale` = 'ruRU' AND `entry` = 19570;
-- OLD name : Трактирщица Реми Делайтак
-- Source : https://www.wowhead.com/wotlk/ru/npc=19571
UPDATE `creature_template_locale` SET `Name` = 'Реми Делайтак' WHERE `locale` = 'ruRU' AND `entry` = 19571;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=19576
UPDATE `creature_template_locale` SET `Title` = 'Учитель мастеров инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 19576;
-- OLD name : Роботех Элли
-- Source : https://www.wowhead.com/wotlk/ru/npc=19578
UPDATE `creature_template_locale` SET `Name` = 'Роботехник Элли' WHERE `locale` = 'ruRU' AND `entry` = 19578;
-- OLD name : Кольен Ледоплет в шляпе
-- Source : https://www.wowhead.com/wotlk/ru/npc=19579
UPDATE `creature_template_locale` SET `Name` = 'Кольен Повелитель Льда в шляпе' WHERE `locale` = 'ruRU' AND `entry` = 19579;
-- OLD name : Маккс А. Миллион, модель I
-- Source : https://www.wowhead.com/wotlk/ru/npc=19582
UPDATE `creature_template_locale` SET `Name` = '"Маккс А. Миллион I"' WHERE `locale` = 'ruRU' AND `entry` = 19582;
-- OLD name : Маккс А. Миллион, модель II
-- Source : https://www.wowhead.com/wotlk/ru/npc=19588
UPDATE `creature_template_locale` SET `Name` = '"Маккс А. Миллион II"' WHERE `locale` = 'ruRU' AND `entry` = 19588;
-- OLD name : Маккс А. Миллион, модель V
-- Source : https://www.wowhead.com/wotlk/ru/npc=19589
UPDATE `creature_template_locale` SET `Name` = '"Маккс А. Миллион V"' WHERE `locale` = 'ruRU' AND `entry` = 19589;
-- OLD name : Верховой ворг из клана Кровавой Глазницы
-- Source : https://www.wowhead.com/wotlk/ru/npc=19640
UPDATE `creature_template_locale` SET `Name` = 'Верховой ворг клана Кровавой Глазницы' WHERE `locale` = 'ruRU' AND `entry` = 19640;
-- OLD name : Работник Морфалиус
-- Source : https://www.wowhead.com/wotlk/ru/npc=19670
UPDATE `creature_template_locale` SET `Name` = 'Механолог Морфалиус' WHERE `locale` = 'ruRU' AND `entry` = 19670;
-- OLD name : Принц Харамад
-- Source : https://www.wowhead.com/wotlk/ru/npc=19674
UPDATE `creature_template_locale` SET `Name` = 'Принц нексуса Харамад' WHERE `locale` = 'ruRU' AND `entry` = 19674;
-- OLD name : Принц Харамад
-- Source : https://www.wowhead.com/wotlk/ru/npc=19675
UPDATE `creature_template_locale` SET `Name` = 'Принц нексуса Харамад' WHERE `locale` = 'ruRU' AND `entry` = 19675;
-- OLD name : Хаггард Ветеран
-- Source : https://www.wowhead.com/wotlk/ru/npc=19684
UPDATE `creature_template_locale` SET `Name` = 'Изможденный ветеран' WHERE `locale` = 'ruRU' AND `entry` = 19684;
-- OLD name : Миротворец Шаттрата
-- Source : https://www.wowhead.com/wotlk/ru/npc=19687
UPDATE `creature_template_locale` SET `Name` = 'Миротворец из Шаттрата' WHERE `locale` = 'ruRU' AND `entry` = 19687;
-- OLD name : Джонни Замок
-- Source : https://www.wowhead.com/wotlk/ru/npc=19700
UPDATE `creature_template_locale` SET `Name` = 'Джонни Касл' WHERE `locale` = 'ruRU' AND `entry` = 19700;
-- OLD name : Вызыватель из клана Костеглодов
-- Source : https://www.wowhead.com/wotlk/ru/npc=19701
UPDATE `creature_template_locale` SET `Name` = 'Взыватель из клана Костеглодов' WHERE `locale` = 'ruRU' AND `entry` = 19701;
-- OLD name : Разрушитель Бурегорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=19735
UPDATE `creature_template_locale` SET `Name` = 'Разрушитель из кузни бурь' WHERE `locale` = 'ruRU' AND `entry` = 19735;
-- OLD name : Балмон Псарь
-- Source : https://www.wowhead.com/wotlk/ru/npc=19747
UPDATE `creature_template_locale` SET `Name` = 'Бэлмон Псарь' WHERE `locale` = 'ruRU' AND `entry` = 19747;
-- OLD name : Ремонтник Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=19754
UPDATE `creature_template_locale` SET `Name` = 'Ремонтник из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 19754;
-- OLD name : Кузнец Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=19756
UPDATE `creature_template_locale` SET `Name` = 'Кузнец из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 19756;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=19775
UPDATE `creature_template_locale` SET `Title` = 'Учительница ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 19775;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=19778
UPDATE `creature_template_locale` SET `Title` = 'Учительница ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 19778;
-- OLD subname : Торговец огнестрельным оружием
-- Source : https://www.wowhead.com/wotlk/ru/npc=19836
UPDATE `creature_template_locale` SET `Title` = 'Торговка огнестрельным оружием' WHERE `locale` = 'ruRU' AND `entry` = 19836;
-- OLD name : Утилизатор Х6000
-- Source : https://www.wowhead.com/wotlk/ru/npc=19849
UPDATE `creature_template_locale` SET `Name` = '"Утилизатор Х6000"' WHERE `locale` = 'ruRU' AND `entry` = 19849;
-- OLD name : Страж ужаса Скверномеч
-- Source : https://www.wowhead.com/wotlk/ru/npc=19853
UPDATE `creature_template_locale` SET `Name` = 'Страж ужаса - клинок Скверны' WHERE `locale` = 'ruRU' AND `entry` = 19853;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=19855
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 19855;
-- OLD name : Барон Раф Дреугер
-- Source : https://www.wowhead.com/wotlk/ru/npc=19874
UPDATE `creature_template_locale` SET `Name` = 'Барон Раф Дрейгер' WHERE `locale` = 'ruRU' AND `entry` = 19874;
-- OLD name : Баронесса Дороти Милстип
-- Source : https://www.wowhead.com/wotlk/ru/npc=19875
UPDATE `creature_template_locale` SET `Name` = 'Баронесса Доротея Милстип' WHERE `locale` = 'ruRU' AND `entry` = 19875;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=19905
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 19905;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=19908
UPDATE `creature_template_locale` SET `Title` = 'Военачальница ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 19908;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=19910
UPDATE `creature_template_locale` SET `Title` = 'Военачальник ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 19910;
-- OLD name : Техник Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=19979
UPDATE `creature_template_locale` SET `Name` = 'Техник из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 19979;
-- OLD name : Небосмотр Рууан'ока
-- Source : https://www.wowhead.com/wotlk/ru/npc=19985
UPDATE `creature_template_locale` SET `Name` = 'Небесный дозорный из гнездовья Рууан' WHERE `locale` = 'ruRU' AND `entry` = 19985;
-- OLD name : Небесный воин Рууан'ока
-- Source : https://www.wowhead.com/wotlk/ru/npc=19986
UPDATE `creature_template_locale` SET `Name` = 'Небесный воин из гнездовья Рууан' WHERE `locale` = 'ruRU' AND `entry` = 19986;
-- OLD name : Враностраж Рууан'ока
-- Source : https://www.wowhead.com/wotlk/ru/npc=19987
UPDATE `creature_template_locale` SET `Name` = 'Вороний страж из гнездовья Рууан' WHERE `locale` = 'ruRU' AND `entry` = 19987;
-- OLD name : Талассийский боевой конь
-- Source : https://www.wowhead.com/wotlk/ru/npc=20029
UPDATE `creature_template_locale` SET `Name` = 'Кель''таласский боевой конь' WHERE `locale` = 'ruRU' AND `entry` = 20029;
-- OLD name : Талассийский скакун
-- Source : https://www.wowhead.com/wotlk/ru/npc=20030
UPDATE `creature_template_locale` SET `Name` = 'Кель''таласский скакун' WHERE `locale` = 'ruRU' AND `entry` = 20030;
-- OLD name : Боевой маг из клана Багровой Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=20047
UPDATE `creature_template_locale` SET `Name` = 'Боевой маг из армии Багровой Длани' WHERE `locale` = 'ruRU' AND `entry` = 20047;
-- OLD name : Центурион из клана Багровой Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=20048
UPDATE `creature_template_locale` SET `Name` = 'Центурион из армии Багровой Длани' WHERE `locale` = 'ruRU' AND `entry` = 20048;
-- OLD name : Рыцарь крови из клана Багровой Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=20049
UPDATE `creature_template_locale` SET `Name` = 'Рыцарь крови из армии Багровой Длани' WHERE `locale` = 'ruRU' AND `entry` = 20049;
-- OLD name : Инквизитор из клана Багровой Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=20050
UPDATE `creature_template_locale` SET `Name` = 'Инквизитор из армии Багровой Длани' WHERE `locale` = 'ruRU' AND `entry` = 20050;
-- OLD name : Крестьянин Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=20055
UPDATE `creature_template_locale` SET `Name` = 'Крестьянин из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 20055;
-- OLD name : Старший инженер Телоникус
-- Source : https://www.wowhead.com/wotlk/ru/npc=20063
UPDATE `creature_template_locale` SET `Name` = 'Главный инженер Телоникус' WHERE `locale` = 'ruRU' AND `entry` = 20063;
-- OLD name : Проекция нексус-принца Харамада
-- Source : https://www.wowhead.com/wotlk/ru/npc=20084
UPDATE `creature_template_locale` SET `Name` = 'Проекция принца нексуса Харамада' WHERE `locale` = 'ruRU' AND `entry` = 20084;
-- OLD name : Знахарь Тенетопи
-- Source : https://www.wowhead.com/wotlk/ru/npc=20115
UPDATE `creature_template_locale` SET `Name` = 'Знахарь из племени Тенетопи' WHERE `locale` = 'ruRU' AND `entry` = 20115;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=20118
UPDATE `creature_template_locale` SET `Title` = 'Военачальница ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 20118;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=20120
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 20120;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=20124
UPDATE `creature_template_locale` SET `Title` = 'Учитель оружейного дела' WHERE `locale` = 'ruRU' AND `entry` = 20124;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=20125
UPDATE `creature_template_locale` SET `Title` = 'Учитель бронников' WHERE `locale` = 'ruRU' AND `entry` = 20125;
-- OLD name : Сторожевое древо Сильванаара
-- Source : https://www.wowhead.com/wotlk/ru/npc=20126
UPDATE `creature_template_locale` SET `Name` = 'Сторожевое древо из Сильванаара' WHERE `locale` = 'ruRU' AND `entry` = 20126;
-- OLD name : Снайпер из клана Ярости Солнца
-- Source : https://www.wowhead.com/wotlk/ru/npc=20207
UPDATE `creature_template_locale` SET `Name` = 'Лучник из клана Ярости Солнца' WHERE `locale` = 'ruRU' AND `entry` = 20207;
-- OLD name : Матриарх Рууан'ока
-- Source : https://www.wowhead.com/wotlk/ru/npc=20211
UPDATE `creature_template_locale` SET `Name` = 'Матриарх гнездовья Рууан' WHERE `locale` = 'ruRU' AND `entry` = 20211;
-- OLD name : Снабженец Пест
-- Source : https://www.wowhead.com/wotlk/ru/npc=20231
UPDATE `creature_template_locale` SET `Name` = 'Интендант Пест' WHERE `locale` = 'ruRU' AND `entry` = 20231;
-- OLD name : Всадник на грифоне Оплота Чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=20237
UPDATE `creature_template_locale` SET `Name` = 'Наездник на грифоне из Оплота Чести' WHERE `locale` = 'ruRU' AND `entry` = 20237;
-- OLD name : Разведчик Оплота Чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=20238
UPDATE `creature_template_locale` SET `Name` = 'Разведчик из Оплота Чести' WHERE `locale` = 'ruRU' AND `entry` = 20238;
-- OLD name : Поставщик Несела
-- Source : https://www.wowhead.com/wotlk/ru/npc=20241
UPDATE `creature_template_locale` SET `Name` = 'Поставщица Несела' WHERE `locale` = 'ruRU' AND `entry` = 20241;
-- OLD name : Мистер Мур’рзик
-- Source : https://www.wowhead.com/wotlk/ru/npc=20245
UPDATE `creature_template_locale` SET `Name` = 'Мистер Мур''рзик' WHERE `locale` = 'ruRU' AND `entry` = 20245;
-- OLD name : Мур’рка
-- Source : https://www.wowhead.com/wotlk/ru/npc=20246
UPDATE `creature_template_locale` SET `Name` = 'Мур''рка' WHERE `locale` = 'ruRU' AND `entry` = 20246;
-- OLD name : Мур’рзик
-- Source : https://www.wowhead.com/wotlk/ru/npc=20247
UPDATE `creature_template_locale` SET `Name` = 'Мур''рзик' WHERE `locale` = 'ruRU' AND `entry` = 20247;
-- OLD name : Мишень для лучников Оплота Чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=20251
UPDATE `creature_template_locale` SET `Name` = 'Мишень для лучников из Оплота Чести' WHERE `locale` = 'ruRU' AND `entry` = 20251;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=20269
UPDATE `creature_template_locale` SET `Title` = 'Военачальник ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 20269;
-- OLD subname : Военачальник Ущелья Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=20272
UPDATE `creature_template_locale` SET `Title` = 'Военачальник ущелья Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 20272;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=20273
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 20273;
-- OLD subname : Военачальник Низины Арати
-- Source : https://www.wowhead.com/wotlk/ru/npc=20274
UPDATE `creature_template_locale` SET `Title` = 'Военачальник низины Арати' WHERE `locale` = 'ruRU' AND `entry` = 20274;
-- OLD subname : Старинная экипировка арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=20278
UPDATE `creature_template_locale` SET `Title` = 'Жестокий продавец экипировки арены' WHERE `locale` = 'ruRU' AND `entry` = 20278;
-- OLD name : Озерный бродяга
-- Source : https://www.wowhead.com/wotlk/ru/npc=20291
UPDATE `creature_template_locale` SET `Name` = 'Лагунный бродяга' WHERE `locale` = 'ruRU' AND `entry` = 20291;
-- OLD name : Пойманная зверушка
-- Source : https://www.wowhead.com/wotlk/ru/npc=20396
UPDATE `creature_template_locale` SET `Name` = 'Пойманный зверек' WHERE `locale` = 'ruRU' AND `entry` = 20396;
-- OLD subname : Наставница шаманов
-- Source : https://www.wowhead.com/wotlk/ru/npc=20407
UPDATE `creature_template_locale` SET `Title` = 'Наставник шаманов' WHERE `locale` = 'ruRU' AND `entry` = 20407;
-- OLD name : Кирин'Варский ученик
-- Source : https://www.wowhead.com/wotlk/ru/npc=20409
UPDATE `creature_template_locale` SET `Name` = 'Кирин''варский ученик' WHERE `locale` = 'ruRU' AND `entry` = 20409;
-- OLD name : Волшебный слуга
-- Source : https://www.wowhead.com/wotlk/ru/npc=20478
UPDATE `creature_template_locale` SET `Name` = 'Чародейский слуга' WHERE `locale` = 'ruRU' AND `entry` = 20478;
-- OLD name : Кирин'Варское привидение
-- Source : https://www.wowhead.com/wotlk/ru/npc=20480
UPDATE `creature_template_locale` SET `Name` = 'Кирин''варское привидение' WHERE `locale` = 'ruRU' AND `entry` = 20480;
-- OLD name : Дама Буйногривая
-- Source : https://www.wowhead.com/wotlk/ru/npc=20494
UPDATE `creature_template_locale` SET `Name` = 'Дама Буйная Грива' WHERE `locale` = 'ruRU' AND `entry` = 20494;
-- OLD name : Кирин'Варский фантомник
-- Source : https://www.wowhead.com/wotlk/ru/npc=20496
UPDATE `creature_template_locale` SET `Name` = 'Кирин''варский фантом' WHERE `locale` = 'ruRU' AND `entry` = 20496;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=20500
UPDATE `creature_template_locale` SET `Title` = 'Учитель верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 20500;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=20511
UPDATE `creature_template_locale` SET `Title` = 'Учитель верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 20511;
-- OLD name : Штормградский страж бухты
-- Source : https://www.wowhead.com/wotlk/ru/npc=20556
UPDATE `creature_template_locale` SET `Name` = 'Штормградский морской пехотинец' WHERE `locale` = 'ruRU' AND `entry` = 20556;
-- OLD name : Верховный командир Рууск
-- Source : https://www.wowhead.com/wotlk/ru/npc=20563
UPDATE `creature_template_locale` SET `Name` = 'Главнокомандующий Рууск' WHERE `locale` = 'ruRU' AND `entry` = 20563;
-- OLD name : Мерцальница ночная
-- Source : https://www.wowhead.com/wotlk/ru/npc=20611
UPDATE `creature_template_locale` SET `Name` = 'Ночная мерцальница' WHERE `locale` = 'ruRU' AND `entry` = 20611;
-- OLD name : Котенок Араги
-- Source : https://www.wowhead.com/wotlk/ru/npc=20615
UPDATE `creature_template_locale` SET `Name` = 'Котенок Гиблопасти' WHERE `locale` = 'ruRU' AND `entry` = 20615;
-- OLD name : Рек'тор
-- Source : https://www.wowhead.com/wotlk/ru/npc=20716
UPDATE `creature_template_locale` SET `Name` = 'Черный ящер Запределья' WHERE `locale` = 'ruRU' AND `entry` = 20716;
-- OLD name : Камнерогий ящер
-- Source : https://www.wowhead.com/wotlk/ru/npc=20728
UPDATE `creature_template_locale` SET `Name` = 'Ящер клана Камнерогов' WHERE `locale` = 'ruRU' AND `entry` = 20728;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=20791
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 20791;
-- OLD name : Призыватель Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=20872
UPDATE `creature_template_locale` SET `Name` = 'Призыватель из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 20872;
-- OLD name : Скеттис-беженец
-- Source : https://www.wowhead.com/wotlk/ru/npc=20874
UPDATE `creature_template_locale` SET `Name` = 'Беженец из Скеттиса' WHERE `locale` = 'ruRU' AND `entry` = 20874;
-- OLD name : Беженец Шаттрата
-- Source : https://www.wowhead.com/wotlk/ru/npc=20877
UPDATE `creature_template_locale` SET `Name` = 'Беженец из Шаттрата' WHERE `locale` = 'ruRU' AND `entry` = 20877;
-- OLD name : Страж Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=20878
UPDATE `creature_template_locale` SET `Name` = 'Стражник из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 20878;
-- OLD name : Эредераский пожиратель душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=20879
UPDATE `creature_template_locale` SET `Name` = 'Эредарский пожиратель душ' WHERE `locale` = 'ruRU' AND `entry` = 20879;
-- OLD name : Сектант Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=20884
UPDATE `creature_template_locale` SET `Name` = 'Сектант из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 20884;
-- OLD name : Бес Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=20887
UPDATE `creature_template_locale` SET `Name` = 'Бес из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 20887;
-- OLD name : Фазовая прыгуана
-- Source : https://www.wowhead.com/wotlk/ru/npc=20906
UPDATE `creature_template_locale` SET `Name` = 'Внепространственный охотник' WHERE `locale` = 'ruRU' AND `entry` = 20906;
-- OLD name : Драконид Крыла Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=20911
UPDATE `creature_template_locale` SET `Name` = 'Драконид из пещеры Крыла Тьмы' WHERE `locale` = 'ruRU' AND `entry` = 20911;
-- OLD name : Ноко Шептунья Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=20915
UPDATE `creature_template_locale` SET `Name` = 'Ноко Шепот Луны' WHERE `locale` = 'ruRU' AND `entry` = 20915;
-- OLD name : Ловец Скверны Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=20918
UPDATE `creature_template_locale` SET `Name` = 'Ловец Скверны из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 20918;
-- OLD name : Страж Ужаса Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=20919
UPDATE `creature_template_locale` SET `Name` = 'Страж ужаса из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 20919;
-- OLD name : Василиск из Чащобы Рууан
-- Source : https://www.wowhead.com/wotlk/ru/npc=20987
UPDATE `creature_template_locale` SET `Name` = 'Василиск из чащобы Рууан' WHERE `locale` = 'ruRU' AND `entry` = 20987;
-- OLD name : Селянин клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=20995
UPDATE `creature_template_locale` SET `Name` = 'Житель деревни Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 20995;
-- OLD name : QA Test Dummy 73 Raid Debuff (High Armor)
-- Source : https://www.wowhead.com/wotlk/ru/npc=21003
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy 73 Raid Debuffed Warrior' WHERE `locale` = 'ruRU' AND `entry` = 21003;
-- OLD name : Сержант Чани
-- Source : https://www.wowhead.com/wotlk/ru/npc=21007
UPDATE `creature_template_locale` SET `Name` = 'Сержант Чауни' WHERE `locale` = 'ruRU' AND `entry` = 21007;
-- OLD name : Разъяренный саженец Леса Ворона
-- Source : https://www.wowhead.com/wotlk/ru/npc=21040
UPDATE `creature_template_locale` SET `Name` = 'Разъяренный саженец из леса Ворона' WHERE `locale` = 'ruRU' AND `entry` = 21040;
-- OLD name : Ужасающий ворон
-- Source : https://www.wowhead.com/wotlk/ru/npc=21042
UPDATE `creature_template_locale` SET `Name` = 'Лютый ворон' WHERE `locale` = 'ruRU' AND `entry` = 21042;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=21087
UPDATE `creature_template_locale` SET `Title` = 'Мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 21087;
-- OLD name : Уварос
-- Source : https://www.wowhead.com/wotlk/ru/npc=21102
UPDATE `creature_template_locale` SET `Name` = 'Увурос' WHERE `locale` = 'ruRU' AND `entry` = 21102;
-- OLD name : Вызыватель духов Гракош
-- Source : https://www.wowhead.com/wotlk/ru/npc=21103
UPDATE `creature_template_locale` SET `Name` = 'Призыватель духов Гракош' WHERE `locale` = 'ruRU' AND `entry` = 21103;
-- OLD name : Вызыватель духов Рокнак
-- Source : https://www.wowhead.com/wotlk/ru/npc=21105
UPDATE `creature_template_locale` SET `Name` = 'Призыватель духов Рокнак' WHERE `locale` = 'ruRU' AND `entry` = 21105;
-- OLD name : Вызыватель духов Скраш
-- Source : https://www.wowhead.com/wotlk/ru/npc=21106
UPDATE `creature_template_locale` SET `Name` = 'Призыватель духов Скраш' WHERE `locale` = 'ruRU' AND `entry` = 21106;
-- OLD subname : Продавец еды
-- Source : https://www.wowhead.com/wotlk/ru/npc=21145
UPDATE `creature_template_locale` SET `Title` = 'Торговка едой' WHERE `locale` = 'ruRU' AND `entry` = 21145;
-- OLD name : Главный сержант Вечерняя Тень, subname : Ан'киражский вербовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=21155
UPDATE `creature_template_locale` SET `Name` = 'Старший сержант Вечерняя Тень',`Title` = 'Ан''киражская вербовщица' WHERE `locale` = 'ruRU' AND `entry` = 21155;
-- OLD subname : Ан'киражский вербовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=21156
UPDATE `creature_template_locale` SET `Title` = 'Ан''киражская вербовщица' WHERE `locale` = 'ruRU' AND `entry` = 21156;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=21209
UPDATE `creature_template_locale` SET `Title` = 'Мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 21209;
-- OLD name : Вестник Костеглодов
-- Source : https://www.wowhead.com/wotlk/ru/npc=21244
UPDATE `creature_template_locale` SET `Name` = 'Вестник из клана Костеглодов' WHERE `locale` = 'ruRU' AND `entry` = 21244;
-- OLD name : Спороскат Змеиного храма
-- Source : https://www.wowhead.com/wotlk/ru/npc=21246
UPDATE `creature_template_locale` SET `Name` = 'Спороскат из Змеиного святилища' WHERE `locale` = 'ruRU' AND `entry` = 21246;
-- OLD name : Чернокнижник Совета Теней
-- Source : https://www.wowhead.com/wotlk/ru/npc=21302
UPDATE `creature_template_locale` SET `Name` = 'Чернокнижник из Совета Теней' WHERE `locale` = 'ruRU' AND `entry` = 21302;
-- OLD name : Инфернал Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=21316
UPDATE `creature_template_locale` SET `Name` = 'Инфернал из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 21316;
-- OLD name : Превращение в путеводный огонек
-- Source : https://www.wowhead.com/wotlk/ru/npc=21320
UPDATE `creature_template_locale` SET `Name` = 'Превращение путеводного видения' WHERE `locale` = 'ruRU' AND `entry` = 21320;
-- OLD name : Каменный ствол Леса Ворона
-- Source : https://www.wowhead.com/wotlk/ru/npc=21325
UPDATE `creature_template_locale` SET `Name` = 'Каменный ствол из леса Ворона' WHERE `locale` = 'ruRU' AND `entry` = 21325;
-- OLD name : Листобород Леса Ворона
-- Source : https://www.wowhead.com/wotlk/ru/npc=21326
UPDATE `creature_template_locale` SET `Name` = 'Листобород из леса Ворона' WHERE `locale` = 'ruRU' AND `entry` = 21326;
-- OLD name : Анахорет Сейла
-- Source : https://www.wowhead.com/wotlk/ru/npc=21402
UPDATE `creature_template_locale` SET `Name` = 'Анахоретка Сейла' WHERE `locale` = 'ruRU' AND `entry` = 21402;
-- OLD name : Сквернобот форта Легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=21404
UPDATE `creature_template_locale` SET `Name` = 'Сквернобот из форта Легиона' WHERE `locale` = 'ruRU' AND `entry` = 21404;
-- OLD subname : Берейторы Разака
-- Source : https://www.wowhead.com/wotlk/ru/npc=21426
UPDATE `creature_template_locale` SET `Title` = 'Коленорезы Разака' WHERE `locale` = 'ruRU' AND `entry` = 21426;
-- OLD subname : Берейторы Разака
-- Source : https://www.wowhead.com/wotlk/ru/npc=21427
UPDATE `creature_template_locale` SET `Title` = 'Коленорезы Разака' WHERE `locale` = 'ruRU' AND `entry` = 21427;
-- OLD name : Tempixx Finagler
-- Source : https://www.wowhead.com/wotlk/ru/npc=21444
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 21444;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21444, 'ruRU','Темпикс Фингалер',NULL);
-- OLD subname : Торговец клинками
-- Source : https://www.wowhead.com/wotlk/ru/npc=21474
UPDATE `creature_template_locale` SET `Title` = 'Торговка клинками' WHERE `locale` = 'ruRU' AND `entry` = 21474;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=21483
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 21483;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=21488
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 21488;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=21518
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 21518;
-- OLD name : Forest Strider
-- Source : https://www.wowhead.com/wotlk/ru/npc=21634
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 21634;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21634, 'ruRU','Лесной долгоног ярмарки Новолуния',NULL);
-- OLD name : Лесной долгоног ярмарки Новолуния
-- Source : https://www.wowhead.com/wotlk/ru/npc=21635
UPDATE `creature_template_locale` SET `Name` = 'Лесной долгоног' WHERE `locale` = 'ruRU' AND `entry` = 21635;
-- OLD subname : Начальник снабжения Нижнего Города
-- Source : https://www.wowhead.com/wotlk/ru/npc=21655
UPDATE `creature_template_locale` SET `Title` = 'Интендант Нижнего города' WHERE `locale` = 'ruRU' AND `entry` = 21655;
-- OLD name : Жизневяз из Эфириума
-- Source : https://www.wowhead.com/wotlk/ru/npc=21702
UPDATE `creature_template_locale` SET `Name` = 'Заклинатель жизни из Эфириума' WHERE `locale` = 'ruRU' AND `entry` = 21702;
-- OLD name : Разведчик клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=21749
UPDATE `creature_template_locale` SET `Name` = 'Разведчик из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 21749;
-- OLD name : Боевой вождь Чернорук
-- Source : https://www.wowhead.com/wotlk/ru/npc=21752
UPDATE `creature_template_locale` SET `Name` = 'Вождь Чернорук' WHERE `locale` = 'ruRU' AND `entry` = 21752;
-- OLD name : Властитель Ор'барокх
-- Source : https://www.wowhead.com/wotlk/ru/npc=21769
UPDATE `creature_template_locale` SET `Name` = 'Воевода Ор''барох' WHERE `locale` = 'ruRU' AND `entry` = 21769;
-- OLD name : Ревнитель клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=21788
UPDATE `creature_template_locale` SET `Name` = 'Ревнитель из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 21788;
-- OLD name : Сверхмощный сефориевый заряд
-- Source : https://www.wowhead.com/wotlk/ru/npc=21848
UPDATE `creature_template_locale` SET `Name` = 'ZZOLD - Bone Burster Visual[PH]' WHERE `locale` = 'ruRU' AND `entry` = 21848;
-- OLD name : Энт Леса Ворона
-- Source : https://www.wowhead.com/wotlk/ru/npc=21853
UPDATE `creature_template_locale` SET `Name` = 'Энт из леса Ворона' WHERE `locale` = 'ruRU' AND `entry` = 21853;
-- OLD name : Брандашмыг из Змеиного Святилища
-- Source : https://www.wowhead.com/wotlk/ru/npc=21863
UPDATE `creature_template_locale` SET `Name` = 'Брандашмыг из Змеиного святилища' WHERE `locale` = 'ruRU' AND `entry` = 21863;
-- OLD name : Младший командир из клана Громоборцев
-- Source : https://www.wowhead.com/wotlk/ru/npc=21951
UPDATE `creature_template_locale` SET `Name` = 'Младший вождь клана Громоборцев' WHERE `locale` = 'ruRU' AND `entry` = 21951;
-- OLD name : Кор'кронский наездник на ветрокрыле
-- Source : https://www.wowhead.com/wotlk/ru/npc=21998
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский всадник на ветрокрыле' WHERE `locale` = 'ruRU' AND `entry` = 21998;
-- OLD name : Дракон Пустоты из клана Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=22000
UPDATE `creature_template_locale` SET `Name` = 'Дракон Пустоты клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 22000;
-- OLD name : Всадник на грифоне Громового Молота
-- Source : https://www.wowhead.com/wotlk/ru/npc=22059
UPDATE `creature_template_locale` SET `Name` = 'Наездник на грифоне из клана Громового Молота' WHERE `locale` = 'ruRU' AND `entry` = 22059;
-- OLD name : Дракон Штормовой Вершины
-- Source : https://www.wowhead.com/wotlk/ru/npc=22064
UPDATE `creature_template_locale` SET `Name` = 'Дракон из Штормовой Вершины' WHERE `locale` = 'ruRU' AND `entry` = 22064;
-- OLD name : Темнопряд клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=22081
UPDATE `creature_template_locale` SET `Name` = 'Темнопряд из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 22081;
-- OLD name : Избранный клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=22084
UPDATE `creature_template_locale` SET `Name` = 'Избранный из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 22084;
-- OLD name : Спороскат Спореггара
-- Source : https://www.wowhead.com/wotlk/ru/npc=22085
UPDATE `creature_template_locale` SET `Name` = 'Спореггарский спороскат' WHERE `locale` = 'ruRU' AND `entry` = 22085;
-- OLD name : Интендант Культа Змея
-- Source : https://www.wowhead.com/wotlk/ru/npc=22099
UPDATE `creature_template_locale` SET `Name` = 'Интендант культа Змея' WHERE `locale` = 'ruRU' AND `entry` = 22099;
-- OLD name : Око Килрогга из клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=22134
UPDATE `creature_template_locale` SET `Name` = 'Око Килрогга клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 22134;
-- OLD name : Сестра Чащобы Рууан
-- Source : https://www.wowhead.com/wotlk/ru/npc=22151
UPDATE `creature_template_locale` SET `Name` = 'Сестра из чащобы Рууан' WHERE `locale` = 'ruRU' AND `entry` = 22151;
-- OLD name : Огонек Чащобы Рууан
-- Source : https://www.wowhead.com/wotlk/ru/npc=22152
UPDATE `creature_template_locale` SET `Name` = 'Огонек из чащобы Рууан' WHERE `locale` = 'ruRU' AND `entry` = 22152;
-- OLD subname : Специалист по шитью из луноткани
-- Source : https://www.wowhead.com/wotlk/ru/npc=22208
UPDATE `creature_template_locale` SET `Title` = 'Специалистка по луноткани' WHERE `locale` = 'ruRU' AND `entry` = 22208;
-- OLD subname : Специалист по шитью из тенеткани
-- Source : https://www.wowhead.com/wotlk/ru/npc=22212
UPDATE `creature_template_locale` SET `Title` = 'Специалист по тенеткани' WHERE `locale` = 'ruRU' AND `entry` = 22212;
-- OLD subname : Специалист по шитью из огненной чароткани
-- Source : https://www.wowhead.com/wotlk/ru/npc=22213
UPDATE `creature_template_locale` SET `Title` = 'Специалист по огненной чароткани' WHERE `locale` = 'ruRU' AND `entry` = 22213;
-- OLD name : Волномут Змеиного Святилища
-- Source : https://www.wowhead.com/wotlk/ru/npc=22238
UPDATE `creature_template_locale` SET `Name` = 'Волномут из Змеиного святилища' WHERE `locale` = 'ruRU' AND `entry` = 22238;
-- OLD name : Батрак клана Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=22252
UPDATE `creature_template_locale` SET `Name` = 'Батрак из клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 22252;
-- OLD name : Стражник цитадели Адского Пламени
-- Source : https://www.wowhead.com/wotlk/ru/npc=22259
UPDATE `creature_template_locale` SET `Name` = 'Стражник из цитадели Адского Пламени' WHERE `locale` = 'ruRU' AND `entry` = 22259;
-- OLD name : Сталевар Огри'лы
-- Source : https://www.wowhead.com/wotlk/ru/npc=22264
UPDATE `creature_template_locale` SET `Name` = 'Сталемант из Огри''ла' WHERE `locale` = 'ruRU' AND `entry` = 22264;
-- OLD name : Поставщик провизии Огри'лы, subname : Продавец еды
-- Source : https://www.wowhead.com/wotlk/ru/npc=22266
UPDATE `creature_template_locale` SET `Name` = 'Поставщик провизии из Огри''ла',`Title` = 'Торговец едой' WHERE `locale` = 'ruRU' AND `entry` = 22266;
-- OLD name : Торговец из Огри'лы
-- Source : https://www.wowhead.com/wotlk/ru/npc=22270
UPDATE `creature_template_locale` SET `Name` = 'Торговец из Огри''ла' WHERE `locale` = 'ruRU' AND `entry` = 22270;
-- OLD name : Продавец из Огри'лы
-- Source : https://www.wowhead.com/wotlk/ru/npc=22271
UPDATE `creature_template_locale` SET `Name` = 'Продавец из Огри''ла' WHERE `locale` = 'ruRU' AND `entry` = 22271;
-- OLD name : Страж-смотритель Скверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=22273
UPDATE `creature_template_locale` SET `Name` = 'Главный тюремщик Скверны' WHERE `locale` = 'ruRU' AND `entry` = 22273;
-- OLD name : Усмиритель небес Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=22274
UPDATE `creature_template_locale` SET `Name` = 'Усмиритель небес из клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 22274;
-- OLD name : Самоходная машина Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=22295
UPDATE `creature_template_locale` SET `Name` = 'Автоматон из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 22295;
-- OLD name : Вызыватель духов Догар
-- Source : https://www.wowhead.com/wotlk/ru/npc=22312
UPDATE `creature_template_locale` SET `Name` = 'Призыватель духов Догар' WHERE `locale` = 'ruRU' AND `entry` = 22312;
-- OLD name : Мина Кузницы Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=22315
UPDATE `creature_template_locale` SET `Name` = 'Мина из Кузницы Смерти' WHERE `locale` = 'ruRU' AND `entry` = 22315;
-- OLD name : Прислужник Террока
-- Source : https://www.wowhead.com/wotlk/ru/npc=22376
UPDATE `creature_template_locale` SET `Name` = 'Прислужник Терокка' WHERE `locale` = 'ruRU' AND `entry` = 22376;
-- OLD name : Паразит Змеиного Святилища
-- Source : https://www.wowhead.com/wotlk/ru/npc=22379
UPDATE `creature_template_locale` SET `Name` = 'Паразит из Змеиного святилища' WHERE `locale` = 'ruRU' AND `entry` = 22379;
-- OLD name : Коготарь Литика
-- Source : https://www.wowhead.com/wotlk/ru/npc=22388
UPDATE `creature_template_locale` SET `Name` = 'Коготарь Литик' WHERE `locale` = 'ruRU' AND `entry` = 22388;
-- OLD subname : Владелец академии разбойников
-- Source : https://www.wowhead.com/wotlk/ru/npc=22442
UPDATE `creature_template_locale` SET `Title` = 'Владелица академии разбойников' WHERE `locale` = 'ruRU' AND `entry` = 22442;
-- OLD name : Пушка Скверны Дверей Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=22443
UPDATE `creature_template_locale` SET `Name` = 'Пушка Скверны Врат Смерти' WHERE `locale` = 'ruRU' AND `entry` = 22443;
-- OLD name : Ученый из Лиги исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=22464
UPDATE `creature_template_locale` SET `Name` = 'Ученый Лиги исследователей' WHERE `locale` = 'ruRU' AND `entry` = 22464;
-- OLD name : Часовой Шептунья Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=22488
UPDATE `creature_template_locale` SET `Name` = 'Часовая Шепот Луны' WHERE `locale` = 'ruRU' AND `entry` = 22488;
-- OLD name : Огнеглотатель Экзодара
-- Source : https://www.wowhead.com/wotlk/ru/npc=22802
UPDATE `creature_template_locale` SET `Name` = 'Огнеглотатель из Экзодара' WHERE `locale` = 'ruRU' AND `entry` = 22802;
-- OLD name : Огнеглотатель Луносвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=22804
UPDATE `creature_template_locale` SET `Name` = 'Огнеглотатель из Луносвета' WHERE `locale` = 'ruRU' AND `entry` = 22804;
-- OLD name : Огнеглотатель Шаттрата
-- Source : https://www.wowhead.com/wotlk/ru/npc=22806
UPDATE `creature_template_locale` SET `Name` = 'Огнеглотатель из Шаттрата' WHERE `locale` = 'ruRU' AND `entry` = 22806;
-- OLD name : Спасенный громила из Нижнего Города
-- Source : https://www.wowhead.com/wotlk/ru/npc=22811
UPDATE `creature_template_locale` SET `Name` = 'Спасенный громила из Нижнего города' WHERE `locale` = 'ruRU' AND `entry` = 22811;
-- OLD name : Спасенный разведчик Спореггара
-- Source : https://www.wowhead.com/wotlk/ru/npc=22814
UPDATE `creature_template_locale` SET `Name` = 'Спасенный спореггарский разведчик' WHERE `locale` = 'ruRU' AND `entry` = 22814;
-- OLD name : Иллюзорный пеплоуст
-- Source : https://www.wowhead.com/wotlk/ru/npc=22840
UPDATE `creature_template_locale` SET `Name` = 'Иллюзорный Пеплоуст' WHERE `locale` = 'ruRU' AND `entry` = 22840;
-- OLD name : Дух волка пеплоустов
-- Source : https://www.wowhead.com/wotlk/ru/npc=22849
UPDATE `creature_template_locale` SET `Name` = 'Дух волка Пеплоустов' WHERE `locale` = 'ruRU' AND `entry` = 22849;
-- OLD name : Иллидарский Повелитель ночи
-- Source : https://www.wowhead.com/wotlk/ru/npc=22855
UPDATE `creature_template_locale` SET `Name` = 'Иллидарский владыка ночи' WHERE `locale` = 'ruRU' AND `entry` = 22855;
-- OLD name : Иллидарский суккуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=22860
UPDATE `creature_template_locale` SET `Name` = 'Суккуб иллидари' WHERE `locale` = 'ruRU' AND `entry` = 22860;
-- OLD name : Морская взывательница из клана Змеиных Колец
-- Source : https://www.wowhead.com/wotlk/ru/npc=22875
UPDATE `creature_template_locale` SET `Name` = 'Заклинательница моря из клана Змеиных Колец' WHERE `locale` = 'ruRU' AND `entry` = 22875;
-- OLD name : Пастух из клана Змеиных Колец
-- Source : https://www.wowhead.com/wotlk/ru/npc=22877
UPDATE `creature_template_locale` SET `Name` = 'Укротитель из клана Змеиных Колец' WHERE `locale` = 'ruRU' AND `entry` = 22877;
-- OLD name : Разоритель клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=22879
UPDATE `creature_template_locale` SET `Name` = 'Разоритель из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 22879;
-- OLD name : Воитель клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=22880
UPDATE `creature_template_locale` SET `Name` = 'Воитель из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 22880;
-- OLD name : Смертоплет клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=22882
UPDATE `creature_template_locale` SET `Name` = 'Смертоплет из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 22882;
-- OLD name : Пленник Черного храма
-- Source : https://www.wowhead.com/wotlk/ru/npc=22886
UPDATE `creature_template_locale` SET `Name` = 'Пленник из Черного храма' WHERE `locale` = 'ruRU' AND `entry` = 22886;
-- OLD name : Опаляющий тотем пеплоуста
-- Source : https://www.wowhead.com/wotlk/ru/npc=22896
UPDATE `creature_template_locale` SET `Name` = 'Опаляющий тотем Пеплоуста' WHERE `locale` = 'ruRU' AND `entry` = 22896;
-- OLD name : Призванный Тотем неистовства ветра
-- Source : https://www.wowhead.com/wotlk/ru/npc=22897
UPDATE `creature_template_locale` SET `Name` = 'Призванный тотем неистовства ветра' WHERE `locale` = 'ruRU' AND `entry` = 22897;
-- OLD name : Пленник Эфириума (палата стазиса Альфа)
-- Source : https://www.wowhead.com/wotlk/ru/npc=22921
UPDATE `creature_template_locale` SET `Name` = 'Пленник Эфириума (стазисная камера "Альфа")' WHERE `locale` = 'ruRU' AND `entry` = 22921;
-- OLD name : Трактирщица Алерия
-- Source : https://www.wowhead.com/wotlk/ru/npc=22922
UPDATE `creature_template_locale` SET `Name` = 'Алерия' WHERE `locale` = 'ruRU' AND `entry` = 22922;
-- OLD name : Храмовая конкубина
-- Source : https://www.wowhead.com/wotlk/ru/npc=22939
UPDATE `creature_template_locale` SET `Name` = 'Храмовый послушник' WHERE `locale` = 'ruRU' AND `entry` = 22939;
-- OLD name : Кровавый маг клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=22945
UPDATE `creature_template_locale` SET `Name` = 'Кровавый маг из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 22945;
-- OLD name : Очаровательная куртизанка
-- Source : https://www.wowhead.com/wotlk/ru/npc=22955
UPDATE `creature_template_locale` SET `Name` = 'Очаровательный посетитель' WHERE `locale` = 'ruRU' AND `entry` = 22955;
-- OLD name : Сестра Боли
-- Source : https://www.wowhead.com/wotlk/ru/npc=22956
UPDATE `creature_template_locale` SET `Name` = 'Жрица мучений' WHERE `locale` = 'ruRU' AND `entry` = 22956;
-- OLD name : Жрица безумия
-- Source : https://www.wowhead.com/wotlk/ru/npc=22957
UPDATE `creature_template_locale` SET `Name` = 'Госпожа безумия' WHERE `locale` = 'ruRU' AND `entry` = 22957;
-- OLD name : Зачарованный служка
-- Source : https://www.wowhead.com/wotlk/ru/npc=22959
UPDATE `creature_template_locale` SET `Name` = 'Сердитый хозяин' WHERE `locale` = 'ruRU' AND `entry` = 22959;
-- OLD name : Жрица наслаждения
-- Source : https://www.wowhead.com/wotlk/ru/npc=22962
UPDATE `creature_template_locale` SET `Name` = 'Госпожа горести' WHERE `locale` = 'ruRU' AND `entry` = 22962;
-- OLD name : Сестра Удовольствий
-- Source : https://www.wowhead.com/wotlk/ru/npc=22964
UPDATE `creature_template_locale` SET `Name` = 'Жрица наслаждения' WHERE `locale` = 'ruRU' AND `entry` = 22964;
-- OLD name : Порабощенный слуга
-- Source : https://www.wowhead.com/wotlk/ru/npc=22965
UPDATE `creature_template_locale` SET `Name` = 'Усердный распорядитель' WHERE `locale` = 'ruRU' AND `entry` = 22965;
-- OLD name : Орк Скверны клана Изувеченной Длани из Черного храма
-- Source : https://www.wowhead.com/wotlk/ru/npc=22973
UPDATE `creature_template_locale` SET `Name` = 'Орк Скверны из клана Изувеченной Длани из Черного храма' WHERE `locale` = 'ruRU' AND `entry` = 22973;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=23009
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 23009;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=23010
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 23010;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=23011
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 23011;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=23012
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 23012;
-- OLD name : Элекк с острова дизайнеров
-- Source : https://www.wowhead.com/wotlk/ru/npc=23013
UPDATE `creature_template_locale` SET `Name` = '[Designer Island Elekk]' WHERE `locale` = 'ruRU' AND `entry` = 23013;
-- OLD name : Саблезуб с острова дизайнеров
-- Source : https://www.wowhead.com/wotlk/ru/npc=23014
UPDATE `creature_template_locale` SET `Name` = '[Designer Island Sabercat]' WHERE `locale` = 'ruRU' AND `entry` = 23014;
-- OLD name : Укротитель из Стражи Небес
-- Source : https://www.wowhead.com/wotlk/ru/npc=23016
UPDATE `creature_template_locale` SET `Name` = 'Укротительница из Стражи Небес' WHERE `locale` = 'ruRU' AND `entry` = 23016;
-- OLD name : Псарь клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=23018
UPDATE `creature_template_locale` SET `Name` = 'Псарь из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 23018;
-- OLD name : TEST Iceberg
-- Source : https://www.wowhead.com/wotlk/ru/npc=23041
UPDATE `creature_template_locale` SET `Name` = '[TEST Iceberg]' WHERE `locale` = 'ruRU' AND `entry` = 23041;
-- OLD name : Солдат клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=23047
UPDATE `creature_template_locale` SET `Name` = 'Солдат из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 23047;
-- OLD name : Эксперт по оружию клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=23049
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по оружию из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 23049;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=23064
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 23064;
-- OLD subname : Пастбища Дымного Леса
-- Source : https://www.wowhead.com/wotlk/ru/npc=23065
UPDATE `creature_template_locale` SET `Title` = '"Пастбища Дымного Леса"' WHERE `locale` = 'ruRU' AND `entry` = 23065;
-- OLD name : Король бочонков Огри'лы
-- Source : https://www.wowhead.com/wotlk/ru/npc=23110
UPDATE `creature_template_locale` SET `Name` = 'Король бочонков из Огри''ла' WHERE `locale` = 'ruRU' AND `entry` = 23110;
-- OLD name : Миротворец Огри'лы
-- Source : https://www.wowhead.com/wotlk/ru/npc=23115
UPDATE `creature_template_locale` SET `Name` = 'Миротворец из Огри''ла' WHERE `locale` = 'ruRU' AND `entry` = 23115;
-- OLD name : Путешественник Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=23133
UPDATE `creature_template_locale` SET `Name` = 'Путешественник из Альянса' WHERE `locale` = 'ruRU' AND `entry` = 23133;
-- OLD name : Рубака клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=23147
UPDATE `creature_template_locale` SET `Name` = 'Рубака из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 23147;
-- OLD name : Мана-раб
-- Source : https://www.wowhead.com/wotlk/ru/npc=23154
UPDATE `creature_template_locale` SET `Name` = 'Долговой раб' WHERE `locale` = 'ruRU' AND `entry` = 23154;
-- OLD name : Провидец Канеи
-- Source : https://www.wowhead.com/wotlk/ru/npc=23158
UPDATE `creature_template_locale` SET `Name` = 'Провидец Канаи' WHERE `locale` = 'ruRU' AND `entry` = 23158;
-- OLD name : Ордынский солдат
-- Source : https://www.wowhead.com/wotlk/ru/npc=23171
UPDATE `creature_template_locale` SET `Name` = 'Солдат Орды' WHERE `locale` = 'ruRU' AND `entry` = 23171;
-- OLD name : Стражник Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=23175
UPDATE `creature_template_locale` SET `Name` = 'Стражник из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 23175;
-- OLD name : Стражник Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=23176
UPDATE `creature_template_locale` SET `Name` = 'Стражник из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 23176;
-- OLD name : Смотритель Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=23177
UPDATE `creature_template_locale` SET `Name` = 'Дозорный из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 23177;
-- OLD name : Смотритель Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=23178
UPDATE `creature_template_locale` SET `Name` = 'Дозорный из Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 23178;
-- OLD name : Заступник Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=23179
UPDATE `creature_template_locale` SET `Name` = 'Защитник Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 23179;
-- OLD name : Заступник Мельницы Таррен
-- Source : https://www.wowhead.com/wotlk/ru/npc=23180
UPDATE `creature_template_locale` SET `Name` = 'Защитник Мельницы Таррен' WHERE `locale` = 'ruRU' AND `entry` = 23180;
-- OLD name : Пепел Аззинота
-- Source : https://www.wowhead.com/wotlk/ru/npc=23192
UPDATE `creature_template_locale` SET `Name` = 'Жар Аззинота' WHERE `locale` = 'ruRU' AND `entry` = 23192;
-- OLD name : Чудовищный костеглод
-- Source : https://www.wowhead.com/wotlk/ru/npc=23196
UPDATE `creature_template_locale` SET `Name` = 'Великан из клана Костеглодов' WHERE `locale` = 'ruRU' AND `entry` = 23196;
-- OLD name : Баранина для батрака клана Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=23213
UPDATE `creature_template_locale` SET `Name` = 'Баранина для батрака из клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 23213;
-- OLD name : Шиваррская убийца
-- Source : https://www.wowhead.com/wotlk/ru/npc=23220
UPDATE `creature_template_locale` SET `Name` = 'Шиванская убийца' WHERE `locale` = 'ruRU' AND `entry` = 23220;
-- OLD name : Боевая гончая-мутант
-- Source : https://www.wowhead.com/wotlk/ru/npc=23232
UPDATE `creature_template_locale` SET `Name` = 'Боевой волк-мутант' WHERE `locale` = 'ruRU' AND `entry` = 23232;
-- OLD name : Послушник-щитоносец из клана Костеглодов
-- Source : https://www.wowhead.com/wotlk/ru/npc=23236
UPDATE `creature_template_locale` SET `Name` = 'Щитоносец-ученик из клана Костеглодов' WHERE `locale` = 'ruRU' AND `entry` = 23236;
-- OLD name : Отчаянный боец из клана Костеглодов
-- Source : https://www.wowhead.com/wotlk/ru/npc=23239
UPDATE `creature_template_locale` SET `Name` = 'Боец из клана Костеглодов' WHERE `locale` = 'ruRU' AND `entry` = 23239;
-- OLD name : Осклизлый раб
-- Source : https://www.wowhead.com/wotlk/ru/npc=23246
UPDATE `creature_template_locale` SET `Name` = 'Слюнявый раб' WHERE `locale` = 'ruRU' AND `entry` = 23246;
-- OLD name : Рассказчик Огри'лы
-- Source : https://www.wowhead.com/wotlk/ru/npc=23256
UPDATE `creature_template_locale` SET `Name` = 'Рассказчик из Огри''ла' WHERE `locale` = 'ruRU' AND `entry` = 23256;
-- OLD subname : Продавец мяса
-- Source : https://www.wowhead.com/wotlk/ru/npc=23263
UPDATE `creature_template_locale` SET `Title` = 'Торговец мясом' WHERE `locale` = 'ruRU' AND `entry` = 23263;
-- OLD name : Драенорский кровавый ужасень
-- Source : https://www.wowhead.com/wotlk/ru/npc=23290
UPDATE `creature_template_locale` SET `Name` = 'Дренорский кровавый ужасень' WHERE `locale` = 'ruRU' AND `entry` = 23290;
-- OLD name : Рабочий участок батрака клана Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=23308
UPDATE `creature_template_locale` SET `Name` = 'Рабочий участок батрака из клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 23308;
-- OLD name : Непокорный батрак клана Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=23311
UPDATE `creature_template_locale` SET `Name` = 'Непокорный батрак из клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 23311;
-- OLD name : Инструктор полетов из клана Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=23321
UPDATE `creature_template_locale` SET `Name` = 'Летный инструктор из клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 23321;
-- OLD name : Цель инструктора полетов Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=23325
UPDATE `creature_template_locale` SET `Name` = 'Цель летного инструктора из клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 23325;
-- OLD name : Иллидарский сердцелов
-- Source : https://www.wowhead.com/wotlk/ru/npc=23339
UPDATE `creature_template_locale` SET `Name` = 'Иллидари - пронзатель сердец' WHERE `locale` = 'ruRU' AND `entry` = 23339;
-- OLD name : Верховой мотылек из клана Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=23341
UPDATE `creature_template_locale` SET `Name` = 'Верховой мотылек клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 23341;
-- OLD name : Гонка Драконьей Пасти: цель Малверика
-- Source : https://www.wowhead.com/wotlk/ru/npc=23360
UPDATE `creature_template_locale` SET `Name` = 'Гонка Драконьей Пасти: цель Маэстра' WHERE `locale` = 'ruRU' AND `entry` = 23360;
-- OLD name : Павший воин клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=23371
UPDATE `creature_template_locale` SET `Name` = 'Павший воин из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 23371;
-- OLD name : Часовой-патрульный
-- Source : https://www.wowhead.com/wotlk/ru/npc=23394
UPDATE `creature_template_locale` SET `Name` = 'Страж аллеи' WHERE `locale` = 'ruRU' AND `entry` = 23394;
-- OLD subname : Классические кольчужные и латные доспехи Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=23396
UPDATE `creature_template_locale` SET `Title` = 'Продавец экипировки арены' WHERE `locale` = 'ruRU' AND `entry` = 23396;
-- OLD name : Разгневанный осколок души
-- Source : https://www.wowhead.com/wotlk/ru/npc=23398
UPDATE `creature_template_locale` SET `Name` = 'Осколок разгневанной души' WHERE `locale` = 'ruRU' AND `entry` = 23398;
-- OLD name : Иллидарский архон
-- Source : https://www.wowhead.com/wotlk/ru/npc=23400
UPDATE `creature_template_locale` SET `Name` = 'Иллидарский архонт' WHERE `locale` = 'ruRU' AND `entry` = 23400;
-- OLD name : Склянкотар, subname : NONE
-- Source : https://www.wowhead.com/wotlk/ru/npc=23405
UPDATE `creature_template_locale` SET `Name` = 'Склянкотавр',`Title` = 'Тестовые расходуемые предметы' WHERE `locale` = 'ruRU' AND `entry` = 23405;
-- OLD name : Укротитель Ирена из Стражи Небес
-- Source : https://www.wowhead.com/wotlk/ru/npc=23413
UPDATE `creature_template_locale` SET `Name` = 'Укротительница Ирена из Стражи Небес' WHERE `locale` = 'ruRU' AND `entry` = 23413;
-- OLD name : Совет Иллидари
-- Source : https://www.wowhead.com/wotlk/ru/npc=23426
UPDATE `creature_template_locale` SET `Name` = 'Совет иллидари' WHERE `locale` = 'ruRU' AND `entry` = 23426;
-- OLD name : Повелитель Иллидари Балтаз
-- Source : https://www.wowhead.com/wotlk/ru/npc=23427
UPDATE `creature_template_locale` SET `Name` = 'Повелитель иллидари Балтас' WHERE `locale` = 'ruRU' AND `entry` = 23427;
-- OLD subname : Начальник снабжения Огри'лы
-- Source : https://www.wowhead.com/wotlk/ru/npc=23428
UPDATE `creature_template_locale` SET `Title` = 'Интендант Огри''ла' WHERE `locale` = 'ruRU' AND `entry` = 23428;
-- OLD name : Командир Хобб
-- Source : https://www.wowhead.com/wotlk/ru/npc=23434
UPDATE `creature_template_locale` SET `Name` = 'Командор Хобб' WHERE `locale` = 'ruRU' AND `entry` = 23434;
-- OLD name : Усмиритель небес Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=23440
UPDATE `creature_template_locale` SET `Name` = 'Усмиритель небес из клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 23440;
-- OLD name : Усмиритель небес Драконьей Пасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=23441
UPDATE `creature_template_locale` SET `Name` = 'Усмиритель небес из клана Драконьей Пасти' WHERE `locale` = 'ruRU' AND `entry` = 23441;
-- OLD subname : Вербовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=23449
UPDATE `creature_template_locale` SET `Title` = 'Вербовщица' WHERE `locale` = 'ruRU' AND `entry` = 23449;
-- OLD name : Командир Аркус
-- Source : https://www.wowhead.com/wotlk/ru/npc=23452
UPDATE `creature_template_locale` SET `Name` = 'Командор Аркус' WHERE `locale` = 'ruRU' AND `entry` = 23452;
-- OLD subname : Продавец напитков Ячменоваров
-- Source : https://www.wowhead.com/wotlk/ru/npc=23482
UPDATE `creature_template_locale` SET `Title` = 'Торговец напитками Ячменоваров' WHERE `locale` = 'ruRU' AND `entry` = 23482;
-- OLD subname : Продавец напитков Громоваров
-- Source : https://www.wowhead.com/wotlk/ru/npc=23510
UPDATE `creature_template_locale` SET `Title` = 'Торговец напитками Громоваров' WHERE `locale` = 'ruRU' AND `entry` = 23510;
-- OLD name : Northrend Yeti (Blue)
-- Source : https://www.wowhead.com/wotlk/ru/npc=23513
UPDATE `creature_template_locale` SET `Name` = '[Northrend Yeti (Blue)]' WHERE `locale` = 'ruRU' AND `entry` = 23513;
-- OLD name : Northrend Yeti (Brown)
-- Source : https://www.wowhead.com/wotlk/ru/npc=23514
UPDATE `creature_template_locale` SET `Name` = '[Northrend Yeti (Brown)]' WHERE `locale` = 'ruRU' AND `entry` = 23514;
-- OLD name : Northrend Yeti (Yellow)
-- Source : https://www.wowhead.com/wotlk/ru/npc=23516
UPDATE `creature_template_locale` SET `Name` = '[Northrend Yeti (Yellow)]' WHERE `locale` = 'ruRU' AND `entry` = 23516;
-- OLD name : Northrend Yeti (White)
-- Source : https://www.wowhead.com/wotlk/ru/npc=23517
UPDATE `creature_template_locale` SET `Name` = '[Northrend Yeti (White)]' WHERE `locale` = 'ruRU' AND `entry` = 23517;
-- OLD name : Tauren Canoe (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=23518
UPDATE `creature_template_locale` SET `Name` = '[Tauren Canoe (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 23518;
-- OLD name : Большой Ширрл
-- Source : https://www.wowhead.com/wotlk/ru/npc=23519
UPDATE `creature_template_locale` SET `Name` = '[Big Shirl]' WHERE `locale` = 'ruRU' AND `entry` = 23519;
-- OLD name : Джимми "Два Каноэ"
-- Source : https://www.wowhead.com/wotlk/ru/npc=23520
UPDATE `creature_template_locale` SET `Name` = '[Jimmy Two-Canoes]' WHERE `locale` = 'ruRU' AND `entry` = 23520;
-- OLD subname : Продавец сыра
-- Source : https://www.wowhead.com/wotlk/ru/npc=23521
UPDATE `creature_template_locale` SET `Title` = 'Торговка сыром' WHERE `locale` = 'ruRU' AND `entry` = 23521;
-- OLD subname : Продавец алкогольных напитков
-- Source : https://www.wowhead.com/wotlk/ru/npc=23525
UPDATE `creature_template_locale` SET `Title` = 'Торговец алкогольными напитками' WHERE `locale` = 'ruRU' AND `entry` = 23525;
-- OLD name : Тельдрассильский розовый элекк
-- Source : https://www.wowhead.com/wotlk/ru/npc=23527
UPDATE `creature_template_locale` SET `Name` = 'Тельдрассилский розовый элекк' WHERE `locale` = 'ruRU' AND `entry` = 23527;
-- OLD name : Розовый элекк острова Лазурной Дымки
-- Source : https://www.wowhead.com/wotlk/ru/npc=23528
UPDATE `creature_template_locale` SET `Name` = 'Розовый элекк с острова Лазурной Дымки' WHERE `locale` = 'ruRU' AND `entry` = 23528;
-- OLD name : Розовый элекк Лесов Вечной Песни
-- Source : https://www.wowhead.com/wotlk/ru/npc=23531
UPDATE `creature_template_locale` SET `Name` = 'Розовый элекк из лесов Вечной Песни' WHERE `locale` = 'ruRU' AND `entry` = 23531;
-- OLD subname : Продавец вудуистского пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=23533
UPDATE `creature_template_locale` SET `Title` = 'Торговец вудуистскими напитками' WHERE `locale` = 'ruRU' AND `entry` = 23533;
-- OLD name : Норт
-- Source : https://www.wowhead.com/wotlk/ru/npc=23538
UPDATE `creature_template_locale` SET `Name` = '[Northrend Red Dragon]' WHERE `locale` = 'ruRU' AND `entry` = 23538;
-- OLD name : Нордскольский красный дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=23539
UPDATE `creature_template_locale` SET `Name` = '[Northrend Red Drake]' WHERE `locale` = 'ruRU' AND `entry` = 23539;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23548
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 23548;
-- OLD name : Vrykul (Northrend Size Model)
-- Source : https://www.wowhead.com/wotlk/ru/npc=23553
UPDATE `creature_template_locale` SET `Name` = '[Vrykul (Northrend Size Model)]' WHERE `locale` = 'ruRU' AND `entry` = 23553;
-- OLD name : Врайкульский верховой протодракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=23556
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Proto-dragon Mount]' WHERE `locale` = 'ruRU' AND `entry` = 23556;
-- OLD name : Бадд
-- Source : https://www.wowhead.com/wotlk/ru/npc=23559
UPDATE `creature_template_locale` SET `Name` = 'Бадд Недрек' WHERE `locale` = 'ruRU' AND `entry` = 23559;
-- OLD name : Солдат Ледяных Пустошей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23561
UPDATE `creature_template_locale` SET `Name` = 'Солдат ледяных пустошей' WHERE `locale` = 'ruRU' AND `entry` = 23561;
-- OLD subname : Наставник разбойников
-- Source : https://www.wowhead.com/wotlk/ru/npc=23566
UPDATE `creature_template_locale` SET `Title` = 'ШРУ' WHERE `locale` = 'ruRU' AND `entry` = 23566;
-- OLD name : Ренн Макжабр
-- Source : https://www.wowhead.com/wotlk/ru/npc=23569
UPDATE `creature_template_locale` SET `Name` = 'Ренн Макгилл' WHERE `locale` = 'ruRU' AND `entry` = 23569;
-- OLD name : Завоеватель племени Амани
-- Source : https://www.wowhead.com/wotlk/ru/npc=23580
UPDATE `creature_template_locale` SET `Name` = 'Аманийский завоеватель' WHERE `locale` = 'ruRU' AND `entry` = 23580;
-- OLD name : Заклинатель духа волка племени Зловещего Тотема
-- Source : https://www.wowhead.com/wotlk/ru/npc=23593
UPDATE `creature_template_locale` SET `Name` = 'Заклинатель духа волка из племени Зловещего Тотема' WHERE `locale` = 'ruRU' AND `entry` = 23593;
-- OLD name : Землепряд племени Зловещего Тотема
-- Source : https://www.wowhead.com/wotlk/ru/npc=23595
UPDATE `creature_template_locale` SET `Name` = 'Геомант из племени Зловещего Тотема' WHERE `locale` = 'ruRU' AND `entry` = 23595;
-- OLD subname : Торговец хлебом
-- Source : https://www.wowhead.com/wotlk/ru/npc=23603
UPDATE `creature_template_locale` SET `Title` = 'Торговка хлебом' WHERE `locale` = 'ruRU' AND `entry` = 23603;
-- OLD subname : Продавец сыра
-- Source : https://www.wowhead.com/wotlk/ru/npc=23604
UPDATE `creature_template_locale` SET `Title` = 'Торговка сыром' WHERE `locale` = 'ruRU' AND `entry` = 23604;
-- OLD subname : Продавец алкогольных напитков
-- Source : https://www.wowhead.com/wotlk/ru/npc=23606
UPDATE `creature_template_locale` SET `Title` = 'Торговец алкогольными напитками' WHERE `locale` = 'ruRU' AND `entry` = 23606;
-- OLD name : Член клана Большого Бивня
-- Source : https://www.wowhead.com/wotlk/ru/npc=23639
UPDATE `creature_template_locale` SET `Name` = '[Longtusk Tribesman]' WHERE `locale` = 'ruRU' AND `entry` = 23639;
-- OLD name : Гарпунщик из клана Большого Бивня
-- Source : https://www.wowhead.com/wotlk/ru/npc=23640
UPDATE `creature_template_locale` SET `Name` = '[Longtusk Harpooner]' WHERE `locale` = 'ruRU' AND `entry` = 23640;
-- OLD name : Взывающий из клана Большого Бивня
-- Source : https://www.wowhead.com/wotlk/ru/npc=23641
UPDATE `creature_template_locale` SET `Name` = '[Longtusk Sea-caller]' WHERE `locale` = 'ruRU' AND `entry` = 23641;
-- OLD name : Проводник из клана Большого Бивня
-- Source : https://www.wowhead.com/wotlk/ru/npc=23642
UPDATE `creature_template_locale` SET `Name` = '[Longtusk Wayfinder]' WHERE `locale` = 'ruRU' AND `entry` = 23642;
-- OLD name : Контрабандист Северных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23646
UPDATE `creature_template_locale` SET `Name` = '[Northsea Smuggler]' WHERE `locale` = 'ruRU' AND `entry` = 23646;
-- OLD name : Грабитель Северных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23647
UPDATE `creature_template_locale` SET `Name` = '[Northsea Brigand]' WHERE `locale` = 'ruRU' AND `entry` = 23647;
-- OLD name : Мародер Северных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23648
UPDATE `creature_template_locale` SET `Name` = '[Northsea Raider]' WHERE `locale` = 'ruRU' AND `entry` = 23648;
-- OLD name : Сорвиголова Северных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23649
UPDATE `creature_template_locale` SET `Name` = '[Northsea Swashbuckler]' WHERE `locale` = 'ruRU' AND `entry` = 23649;
-- OLD name : Пират Северных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23650
UPDATE `creature_template_locale` SET `Name` = '[Northsea Pirate]' WHERE `locale` = 'ruRU' AND `entry` = 23650;
-- OLD name : Старейшина из клана Укротителей драконов
-- Source : https://www.wowhead.com/wotlk/ru/npc=23659
UPDATE `creature_template_locale` SET `Name` = '[Dragonflayer Elder]' WHERE `locale` = 'ruRU' AND `entry` = 23659;
-- OLD name : Косматый вепрь
-- Source : https://www.wowhead.com/wotlk/ru/npc=23692
UPDATE `creature_template_locale` SET `Name` = '[Shaghide Boar]' WHERE `locale` = 'ruRU' AND `entry` = 23692;
-- OLD name : Tuskarr (Northrend Size Model)
-- Source : https://www.wowhead.com/wotlk/ru/npc=23695
UPDATE `creature_template_locale` SET `Name` = '[Tuskarr (Northrend Size Model)]' WHERE `locale` = 'ruRU' AND `entry` = 23695;
-- OLD name : Clayton's Test Creature, subname : Качество гарантировано
-- Source : https://www.wowhead.com/wotlk/ru/npc=23715
UPDATE `creature_template_locale` SET `Name` = '[Clayton''s Test Creature]',`Title` = '[Quality Assured]' WHERE `locale` = 'ruRU' AND `entry` = 23715;
-- OLD name : Каменный лорд
-- Source : https://www.wowhead.com/wotlk/ru/npc=23726
UPDATE `creature_template_locale` SET `Name` = '[Stone Lord]' WHERE `locale` = 'ruRU' AND `entry` = 23726;
-- OLD name : Трактирщица Хейзел Лаграс
-- Source : https://www.wowhead.com/wotlk/ru/npc=23731
UPDATE `creature_template_locale` SET `Name` = 'Хозяйка таверны Хейзел Лаграс' WHERE `locale` = 'ruRU' AND `entry` = 23731;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=23734
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 23734;
-- OLD name : Штейгер Майлз Макмади
-- Source : https://www.wowhead.com/wotlk/ru/npc=23738
UPDATE `creature_template_locale` SET `Name` = 'Старшина Майлз МакМуди' WHERE `locale` = 'ruRU' AND `entry` = 23738;
-- OLD name : Йети Ледяной пещеры
-- Source : https://www.wowhead.com/wotlk/ru/npc=23743
UPDATE `creature_template_locale` SET `Name` = '[Icehollow Yeti]' WHERE `locale` = 'ruRU' AND `entry` = 23743;
-- OLD name : Молодой протодракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=23750
UPDATE `creature_template_locale` SET `Name` = 'Детеныш протодракона' WHERE `locale` = 'ruRU' AND `entry` = 23750;
-- OLD name : Паровой танк Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=23756
UPDATE `creature_template_locale` SET `Name` = '[Ironforge Steam Tank]' WHERE `locale` = 'ruRU' AND `entry` = 23756;
-- OLD name : Капитан абордажной команды
-- Source : https://www.wowhead.com/wotlk/ru/npc=23767
UPDATE `creature_template_locale` SET `Name` = '[Blockade Captain]' WHERE `locale` = 'ruRU' AND `entry` = 23767;
-- OLD name : Акула-молот бухты Кинжалов
-- Source : https://www.wowhead.com/wotlk/ru/npc=23785
UPDATE `creature_template_locale` SET `Name` = 'Рыба-молот бухты Кинжалов' WHERE `locale` = 'ruRU' AND `entry` = 23785;
-- OLD name : Валгардский ружейник
-- Source : https://www.wowhead.com/wotlk/ru/npc=23792
UPDATE `creature_template_locale` SET `Name` = '[Valgarde Rifleman]' WHERE `locale` = 'ruRU' AND `entry` = 23792;
-- OLD name : Пламя клана Укротителей драконов
-- Source : https://www.wowhead.com/wotlk/ru/npc=23806
UPDATE `creature_template_locale` SET `Name` = '[Dragonflayer Blaze]' WHERE `locale` = 'ruRU' AND `entry` = 23806;
-- OLD name : Дровосек из крепости Западной Стражи (с дровами)
-- Source : https://www.wowhead.com/wotlk/ru/npc=23838
UPDATE `creature_template_locale` SET `Name` = '[Westguard Lumberjack (Wood)]' WHERE `locale` = 'ruRU' AND `entry` = 23838;
-- OLD name : Дворф-кавалерист из крепости Западной Стражи
-- Source : https://www.wowhead.com/wotlk/ru/npc=23856
UPDATE `creature_template_locale` SET `Name` = '[Westguard Cavalryman Dwarf]' WHERE `locale` = 'ruRU' AND `entry` = 23856;
-- OLD name : Кавалерист из Крепости Западной Стражи
-- Source : https://www.wowhead.com/wotlk/ru/npc=23857
UPDATE `creature_template_locale` SET `Name` = '[Westguard Cavalryman Human]' WHERE `locale` = 'ruRU' AND `entry` = 23857;
-- OLD name : Прирученный протодракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=23882
UPDATE `creature_template_locale` SET `Name` = '[Tamed Proto-Whelp]' WHERE `locale` = 'ruRU' AND `entry` = 23882;
-- OLD name : Отрекшийся-арбалетчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=23883
UPDATE `creature_template_locale` SET `Name` = 'Лучник-Отрекшийся' WHERE `locale` = 'ruRU' AND `entry` = 23883;
-- OLD subname : Рыбная ловля: обучение и снасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=23896
UPDATE `creature_template_locale` SET `Title` = 'Торговец рыбой' WHERE `locale` = 'ruRU' AND `entry` = 23896;
-- OLD name : Invisible Giant Trigger
-- Source : https://www.wowhead.com/wotlk/ru/npc=23901
UPDATE `creature_template_locale` SET `Name` = '[Invisible Giant Trigger]' WHERE `locale` = 'ruRU' AND `entry` = 23901;
-- OLD name : Test Guy Brian
-- Source : https://www.wowhead.com/wotlk/ru/npc=23925
UPDATE `creature_template_locale` SET `Name` = '[Test Guy Brian]' WHERE `locale` = 'ruRU' AND `entry` = 23925;
-- OLD name : Спящий защитник из крепости Западной Стражи
-- Source : https://www.wowhead.com/wotlk/ru/npc=23933
UPDATE `creature_template_locale` SET `Name` = '[Westguard Defender - Sleeping]' WHERE `locale` = 'ruRU' AND `entry` = 23933;
-- OLD name : Трактирщица Селеста Доброклад
-- Source : https://www.wowhead.com/wotlk/ru/npc=23937
UPDATE `creature_template_locale` SET `Name` = 'Хозяйка таверны Селеста Доброклад' WHERE `locale` = 'ruRU' AND `entry` = 23937;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23967
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 23967;
-- OLD name : Торелий Мудрый
-- Source : https://www.wowhead.com/wotlk/ru/npc=23975
UPDATE `creature_template_locale` SET `Name` = 'Торалиус Мудрый' WHERE `locale` = 'ruRU' AND `entry` = 23975;
-- OLD name : Путник Могизу
-- Source : https://www.wowhead.com/wotlk/ru/npc=23981
UPDATE `creature_template_locale` SET `Name` = '[Mogisu the Wayfarer]' WHERE `locale` = 'ruRU' AND `entry` = 23981;
-- OLD name : Груженый мул Лиги исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23984
UPDATE `creature_template_locale` SET `Name` = 'Груженый мул Лиги Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 23984;
-- OLD name : Ловчий смерти Разаэль
-- Source : https://www.wowhead.com/wotlk/ru/npc=23998
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти Разаэль' WHERE `locale` = 'ruRU' AND `entry` = 23998;
-- OLD name : Строитель баррикад
-- Source : https://www.wowhead.com/wotlk/ru/npc=24005
UPDATE `creature_template_locale` SET `Name` = 'Мельничный работник' WHERE `locale` = 'ruRU' AND `entry` = 24005;
-- OLD name : Мусорный червь
-- Source : https://www.wowhead.com/wotlk/ru/npc=24017
UPDATE `creature_template_locale` SET `Name` = '[Scavenging Maggot]' WHERE `locale` = 'ruRU' AND `entry` = 24017;
-- OLD name : Некровладыка Мезхен
-- Source : https://www.wowhead.com/wotlk/ru/npc=24018
UPDATE `creature_template_locale` SET `Name` = 'Некро-владыка Мезхен' WHERE `locale` = 'ruRU' AND `entry` = 24018;
-- OLD name : Конь (Гьялербронский конь Скверны) (размер x2)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24020
UPDATE `creature_template_locale` SET `Name` = '[Riding Horse (Gjalerbron Felsteed) (scale x2)]' WHERE `locale` = 'ruRU' AND `entry` = 24020;
-- OLD name : Test Faction Monster
-- Source : https://www.wowhead.com/wotlk/ru/npc=24022
UPDATE `creature_template_locale` SET `Name` = '[Test Faction Monster]' WHERE `locale` = 'ruRU' AND `entry` = 24022;
-- OLD name : Зловещий призыватель драконов
-- Source : https://www.wowhead.com/wotlk/ru/npc=24029
UPDATE `creature_template_locale` SET `Name` = 'Зловещий призыватель змей' WHERE `locale` = 'ruRU' AND `entry` = 24029;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24048
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24048;
-- OLD name : Камнерогий баран
-- Source : https://www.wowhead.com/wotlk/ru/npc=24049
UPDATE `creature_template_locale` SET `Name` = '[Rockhorn Ram]' WHERE `locale` = 'ruRU' AND `entry` = 24049;
-- OLD name : Праматерь протодраконов
-- Source : https://www.wowhead.com/wotlk/ru/npc=24072
UPDATE `creature_template_locale` SET `Name` = '[Proto-Drake Broodmother]' WHERE `locale` = 'ruRU' AND `entry` = 24072;
-- OLD name : Чудовищный ужас
-- Source : https://www.wowhead.com/wotlk/ru/npc=24073
UPDATE `creature_template_locale` SET `Name` = 'Кошмарный ужас' WHERE `locale` = 'ruRU' AND `entry` = 24073;
-- OLD name : Геодезист
-- Source : https://www.wowhead.com/wotlk/ru/npc=24074
UPDATE `creature_template_locale` SET `Name` = '[Surveyor]' WHERE `locale` = 'ruRU' AND `entry` = 24074;
-- OLD name : Валгардский разведчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=24075
UPDATE `creature_template_locale` SET `Name` = '[Valgarde Scout]' WHERE `locale` = 'ruRU' AND `entry` = 24075;
-- OLD name : Пленный валгардский ребенок
-- Source : https://www.wowhead.com/wotlk/ru/npc=24091
UPDATE `creature_template_locale` SET `Name` = '[Captured Valgarde Child]' WHERE `locale` = 'ruRU' AND `entry` = 24091;
-- OLD name : Winterskorn Vrykul Dismembering Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=24095
UPDATE `creature_template_locale` SET `Name` = '[Winterskorn Vrykul Dismembering Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 24095;
-- OLD name : Skorn Longhouse SW Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=24101
UPDATE `creature_template_locale` SET `Name` = '[Skorn Longhouse SW Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 24101;
-- OLD name : Протодракон-страж небес
-- Source : https://www.wowhead.com/wotlk/ru/npc=24105
UPDATE `creature_template_locale` SET `Name` = '[Proto-Drake Skyguard]' WHERE `locale` = 'ruRU' AND `entry` = 24105;
-- OLD name : Часовой из клана Укротителей драконов
-- Source : https://www.wowhead.com/wotlk/ru/npc=24107
UPDATE `creature_template_locale` SET `Name` = '[Dragonflayer Sentinel]' WHERE `locale` = 'ruRU' AND `entry` = 24107;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24122
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24122;
-- OLD name : Пленный валгардский узник (прокси)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24124
UPDATE `creature_template_locale` SET `Name` = '[Captured Valgarde Prisoner (PROXY)]' WHERE `locale` = 'ruRU' AND `entry` = 24124;
-- OLD name : Хранитель душ Зловещего Тотема
-- Source : https://www.wowhead.com/wotlk/ru/npc=24133
UPDATE `creature_template_locale` SET `Name` = 'Хранитель душ из племени Зловещего Тотема' WHERE `locale` = 'ruRU' AND `entry` = 24133;
-- OLD name : Туманный саблезуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=24134
UPDATE `creature_template_locale` SET `Name` = '[Mistsaber]' WHERE `locale` = 'ruRU' AND `entry` = 24134;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24145
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24145;
-- OLD name : Труп моряка Северного флота
-- Source : https://www.wowhead.com/wotlk/ru/npc=24146
UPDATE `creature_template_locale` SET `Name` = '[North Fleet Corpse]' WHERE `locale` = 'ruRU' AND `entry` = 24146;
-- OLD subname : Яды
-- Source : https://www.wowhead.com/wotlk/ru/npc=24148
UPDATE `creature_template_locale` SET `Title` = 'Торговец ядами' WHERE `locale` = 'ruRU' AND `entry` = 24148;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24150
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24150;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24151
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24151;
-- OLD name : Служитель Света
-- Source : https://www.wowhead.com/wotlk/ru/npc=24190
UPDATE `creature_template_locale` SET `Name` = '[Servitor of the Light]' WHERE `locale` = 'ruRU' AND `entry` = 24190;
-- OLD name : Служитель Света (сопровождение)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24192
UPDATE `creature_template_locale` SET `Name` = '[Servitor of the Light (Escort)]' WHERE `locale` = 'ruRU' AND `entry` = 24192;
-- OLD name : Войско мертвых
-- Source : https://www.wowhead.com/wotlk/ru/npc=24207
UPDATE `creature_template_locale` SET `Name` = 'Вурдалак из войска мертвых' WHERE `locale` = 'ruRU' AND `entry` = 24207;
-- OLD name : Врайкульский верховой протодракон (белый)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24237
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Proto-dragon Mount (White)]' WHERE `locale` = 'ruRU' AND `entry` = 24237;
-- OLD name : Артас, Король-лич
-- Source : https://www.wowhead.com/wotlk/ru/npc=24266
UPDATE `creature_template_locale` SET `Name` = '[Arthas, Lich King]' WHERE `locale` = 'ruRU' AND `entry` = 24266;
-- OLD name : Артас, Падший
-- Source : https://www.wowhead.com/wotlk/ru/npc=24267
UPDATE `creature_template_locale` SET `Name` = '[Arthas, Dark]' WHERE `locale` = 'ruRU' AND `entry` = 24267;
-- OLD name : Артас, человек
-- Source : https://www.wowhead.com/wotlk/ru/npc=24268
UPDATE `creature_template_locale` SET `Name` = '[Arthas, Human]' WHERE `locale` = 'ruRU' AND `entry` = 24268;
-- OLD name : Очищающая модель [использовать снова]
-- Source : https://www.wowhead.com/wotlk/ru/npc=24269
UPDATE `creature_template_locale` SET `Name` = '[The Cleansing Bunny [reuse me]]' WHERE `locale` = 'ruRU' AND `entry` = 24269;
-- OLD name : Метка взрыва зачумленного из клана Укротителей драконов
-- Source : https://www.wowhead.com/wotlk/ru/npc=24274
UPDATE `creature_template_locale` SET `Name` = '[Plagued Dragonflayer Explode Credit]' WHERE `locale` = 'ruRU' AND `entry` = 24274;
-- OLD name : Гарвал - превращение в воргена
-- Source : https://www.wowhead.com/wotlk/ru/npc=24278
UPDATE `creature_template_locale` SET `Name` = '[Garwal - Worgen Transform]' WHERE `locale` = 'ruRU' AND `entry` = 24278;
-- OLD name : Метка вала зачумленного из клана Укротителей драконов
-- Source : https://www.wowhead.com/wotlk/ru/npc=24281
UPDATE `creature_template_locale` SET `Name` = '[Plagued Dragonflayer Spray Credit]' WHERE `locale` = 'ruRU' AND `entry` = 24281;
-- OLD name : Древний врайкул
-- Source : https://www.wowhead.com/wotlk/ru/npc=24314
UPDATE `creature_template_locale` SET `Name` = 'Древний мужчина-врайкул' WHERE `locale` = 'ruRU' AND `entry` = 24314;
-- OLD name : Страж смерти Аптекарского поселка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24317
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти-экспедитор' WHERE `locale` = 'ruRU' AND `entry` = 24317;
-- OLD name : Управление событием Ниффлвара
-- Source : https://www.wowhead.com/wotlk/ru/npc=24326
UPDATE `creature_template_locale` SET `Name` = '[Nifflevar Event Controller]' WHERE `locale` = 'ruRU' AND `entry` = 24326;
-- OLD name : Валь'кира-похитительница душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=24327
UPDATE `creature_template_locale` SET `Name` = 'Валь''кира-душекрад' WHERE `locale` = 'ruRU' AND `entry` = 24327;
-- OLD name : Транспорт Нордскола для Blizzcon
-- Source : https://www.wowhead.com/wotlk/ru/npc=24331
UPDATE `creature_template_locale` SET `Name` = '[Blizzcon Northrend Transport]' WHERE `locale` = 'ruRU' AND `entry` = 24331;
-- OLD name : Транспорт Зул'Амана для Blizzcon
-- Source : https://www.wowhead.com/wotlk/ru/npc=24332
UPDATE `creature_template_locale` SET `Name` = '[Blizzcon Zul''Aman Transport]' WHERE `locale` = 'ruRU' AND `entry` = 24332;
-- OLD name : Джейсон Доброклад, subname : Бармен
-- Source : https://www.wowhead.com/wotlk/ru/npc=24333
UPDATE `creature_template_locale` SET `Name` = 'Бармен Джейсон Доброклад',`Title` = 'Напитки' WHERE `locale` = 'ruRU' AND `entry` = 24333;
-- OLD name : Алоцвет
-- Source : https://www.wowhead.com/wotlk/ru/npc=24339
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Growth]' WHERE `locale` = 'ruRU' AND `entry` = 24339;
-- OLD name : Барнабас Фрай
-- Source : https://www.wowhead.com/wotlk/ru/npc=24341
UPDATE `creature_template_locale` SET `Name` = 'Барбанас Фрай' WHERE `locale` = 'ruRU' AND `entry` = 24341;
-- OLD name : Eric Maloof Test Forsaken Male
-- Source : https://www.wowhead.com/wotlk/ru/npc=24353
UPDATE `creature_template_locale` SET `Name` = '[Eric Maloof Test Forsaken Male]' WHERE `locale` = 'ruRU' AND `entry` = 24353;
-- OLD name : Eric Maloof Test Forsaken Female
-- Source : https://www.wowhead.com/wotlk/ru/npc=24354
UPDATE `creature_template_locale` SET `Name` = '[Eric Maloof Test Forsaken Female]' WHERE `locale` = 'ruRU' AND `entry` = 24354;
-- OLD name : Eric Maloof Test Human Male
-- Source : https://www.wowhead.com/wotlk/ru/npc=24355
UPDATE `creature_template_locale` SET `Name` = '[Eric Maloof Test Human Male]' WHERE `locale` = 'ruRU' AND `entry` = 24355;
-- OLD name : Труп Харрисона
-- Source : https://www.wowhead.com/wotlk/ru/npc=24365
UPDATE `creature_template_locale` SET `Name` = 'Труп Вилли' WHERE `locale` = 'ruRU' AND `entry` = 24365;
-- OLD name : Глашатай конференции Blizzcon
-- Source : https://www.wowhead.com/wotlk/ru/npc=24380
UPDATE `creature_template_locale` SET `Name` = '[Blizzcon Greeter]' WHERE `locale` = 'ruRU' AND `entry` = 24380;
-- OLD name : Слуга из клана Железной Руны
-- Source : https://www.wowhead.com/wotlk/ru/npc=24387
UPDATE `creature_template_locale` SET `Name` = '[Iron Rune Servant]' WHERE `locale` = 'ruRU' AND `entry` = 24387;
-- OLD name : Старое корыто
-- Source : https://www.wowhead.com/wotlk/ru/npc=24391
UPDATE `creature_template_locale` SET `Name` = '[Speedboat]' WHERE `locale` = 'ruRU' AND `entry` = 24391;
-- OLD subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=24395
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 24395;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24398
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24398;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24399
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24399;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24400
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24400;
-- OLD subname : Продавец еды
-- Source : https://www.wowhead.com/wotlk/ru/npc=24408
UPDATE `creature_template_locale` SET `Title` = 'Торговец едой' WHERE `locale` = 'ruRU' AND `entry` = 24408;
-- OLD name : Невидимый человек - без оружия (только сервер/скрыть тело) (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24417;
-- OLD name : Проекция разрушителя Бурегорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=24432
UPDATE `creature_template_locale` SET `Name` = 'Проекция разрушителя из кузни бурь' WHERE `locale` = 'ruRU' AND `entry` = 24432;
-- OLD name : Steel Gate - Grapple Target
-- Source : https://www.wowhead.com/wotlk/ru/npc=24438
UPDATE `creature_template_locale` SET `Name` = '[Steel Gate - Grapple Target]' WHERE `locale` = 'ruRU' AND `entry` = 24438;
-- OLD name : Король-лич
-- Source : https://www.wowhead.com/wotlk/ru/npc=24446
UPDATE `creature_template_locale` SET `Name` = '[The Lich King]' WHERE `locale` = 'ruRU' AND `entry` = 24446;
-- OLD name : Frostwyrm (Dragonblight)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24447
UPDATE `creature_template_locale` SET `Name` = '[Frostwyrm (Dragonblight)]' WHERE `locale` = 'ruRU' AND `entry` = 24447;
-- OLD name : Invisible Charge Target 1
-- Source : https://www.wowhead.com/wotlk/ru/npc=24449
UPDATE `creature_template_locale` SET `Name` = '[Invisible Charge Target 1]' WHERE `locale` = 'ruRU' AND `entry` = 24449;
-- OLD name : Invisible Charge Target 2
-- Source : https://www.wowhead.com/wotlk/ru/npc=24450
UPDATE `creature_template_locale` SET `Name` = '[Invisible Charge Target 2]' WHERE `locale` = 'ruRU' AND `entry` = 24450;
-- OLD subname : Лунная пыль
-- Source : https://www.wowhead.com/wotlk/ru/npc=24456
UPDATE `creature_template_locale` SET `Title` = '"Лунная пыль"' WHERE `locale` = 'ruRU' AND `entry` = 24456;
-- OLD name : Модель синей плавающей руны 01
-- Source : https://www.wowhead.com/wotlk/ru/npc=24465
UPDATE `creature_template_locale` SET `Name` = '[Blue Floating Rune Channel Bunny 01]' WHERE `locale` = 'ruRU' AND `entry` = 24465;
-- OLD name : Модель синей плавающей руны 02
-- Source : https://www.wowhead.com/wotlk/ru/npc=24466
UPDATE `creature_template_locale` SET `Name` = '[Blue Floating Rune Channel Bunny 02]' WHERE `locale` = 'ruRU' AND `entry` = 24466;
-- OLD name : Пламя горна (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24471;
-- OLD name : SP Test
-- Source : https://www.wowhead.com/wotlk/ru/npc=24472
UPDATE `creature_template_locale` SET `Name` = '[SP Test]' WHERE `locale` = 'ruRU' AND `entry` = 24472;
-- OLD subname : Главный археолог экспедиции
-- Source : https://www.wowhead.com/wotlk/ru/npc=24473
UPDATE `creature_template_locale` SET `Title` = 'Главный архелог экспедиции' WHERE `locale` = 'ruRU' AND `entry` = 24473;
-- OLD name : Ассасин из Лагеря Возмездия
-- Source : https://www.wowhead.com/wotlk/ru/npc=24474
UPDATE `creature_template_locale` SET `Name` = 'Асассин из Лагеря Возмездия' WHERE `locale` = 'ruRU' AND `entry` = 24474;
-- OLD name : Вор Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=24477
UPDATE `creature_template_locale` SET `Name` = 'Вор из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 24477;
-- OLD name : Ледокраб
-- Source : https://www.wowhead.com/wotlk/ru/npc=24479
UPDATE `creature_template_locale` SET `Name` = '[Ice Crawler]' WHERE `locale` = 'ruRU' AND `entry` = 24479;
-- OLD name : Моджо
-- Source : https://www.wowhead.com/wotlk/ru/npc=24480
UPDATE `creature_template_locale` SET `Name` = 'Вудуистский амулет' WHERE `locale` = 'ruRU' AND `entry` = 24480;
-- OLD name : Страж смерти Флоренс
-- Source : https://www.wowhead.com/wotlk/ru/npc=24491
UPDATE `creature_template_locale` SET `Name` = 'Стражница смерти Флоренс' WHERE `locale` = 'ruRU' AND `entry` = 24491;
-- OLD subname : Продавец алкогольных напитков винокурни Дрона
-- Source : https://www.wowhead.com/wotlk/ru/npc=24501
UPDATE `creature_template_locale` SET `Title` = 'Торговец напитками винокурни Дрона' WHERE `locale` = 'ruRU' AND `entry` = 24501;
-- OLD name : Врайкульская гарпунная пушка (СТАРЫЙ)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24512
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Harpoon Gun (OLD)]' WHERE `locale` = 'ruRU' AND `entry` = 24512;
-- OLD name : Контроллер врайкульского гарпуна вид 001
-- Source : https://www.wowhead.com/wotlk/ru/npc=24513
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Harpoon Controller 001 View]' WHERE `locale` = 'ruRU' AND `entry` = 24513;
-- OLD name : Тест1 Северных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24521
UPDATE `creature_template_locale` SET `Name` = '[Northsea Test1]' WHERE `locale` = 'ruRU' AND `entry` = 24521;
-- OLD subname : Продавец напитков Громоваров
-- Source : https://www.wowhead.com/wotlk/ru/npc=24545
UPDATE `creature_template_locale` SET `Title` = 'Торговец напитками Громоваров' WHERE `locale` = 'ruRU' AND `entry` = 24545;
-- OLD name : Неруб'арский паутинный демон
-- Source : https://www.wowhead.com/wotlk/ru/npc=24564
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Webfiend]' WHERE `locale` = 'ruRU' AND `entry` = 24564;
-- OLD name : Неруб'арский паук
-- Source : https://www.wowhead.com/wotlk/ru/npc=24565
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Spider]' WHERE `locale` = 'ruRU' AND `entry` = 24565;
-- OLD name : Крыса из логова
-- Source : https://www.wowhead.com/wotlk/ru/npc=24568
UPDATE `creature_template_locale` SET `Name` = '[Den Rat]' WHERE `locale` = 'ruRU' AND `entry` = 24568;
-- OLD name : Ползун из логова
-- Source : https://www.wowhead.com/wotlk/ru/npc=24569
UPDATE `creature_template_locale` SET `Name` = '[Den Creeper]' WHERE `locale` = 'ruRU' AND `entry` = 24569;
-- OLD name : Тундровый кобольд-вредитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=24570
UPDATE `creature_template_locale` SET `Name` = '[Tundra Vermin]' WHERE `locale` = 'ruRU' AND `entry` = 24570;
-- OLD name : Задиристый кобольд-вредитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=24571
UPDATE `creature_template_locale` SET `Name` = '[Vermin Bully]' WHERE `locale` = 'ruRU' AND `entry` = 24571;
-- OLD name : Колдующий кобольд-вредитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=24572
UPDATE `creature_template_locale` SET `Name` = '[Vermin Witchling]' WHERE `locale` = 'ruRU' AND `entry` = 24572;
-- OLD name : Тундровый рух
-- Source : https://www.wowhead.com/wotlk/ru/npc=24573
UPDATE `creature_template_locale` SET `Name` = '[Tundra Roc]' WHERE `locale` = 'ruRU' AND `entry` = 24573;
-- OLD name : Старший тундровый рух
-- Source : https://www.wowhead.com/wotlk/ru/npc=24574
UPDATE `creature_template_locale` SET `Name` = '[Greater Tundra Roc]' WHERE `locale` = 'ruRU' AND `entry` = 24574;
-- OLD name : Геодезист клана Свинцовых Приливов
-- Source : https://www.wowhead.com/wotlk/ru/npc=24581
UPDATE `creature_template_locale` SET `Name` = '[Irontide Surveyor]' WHERE `locale` = 'ruRU' AND `entry` = 24581;
-- OLD name : Кузнец-механик клана Свинцовых Приливов
-- Source : https://www.wowhead.com/wotlk/ru/npc=24582
UPDATE `creature_template_locale` SET `Name` = '[Irontide Machinesmith]' WHERE `locale` = 'ruRU' AND `entry` = 24582;
-- OLD name : Инженер из клана Свинцовых Приливов
-- Source : https://www.wowhead.com/wotlk/ru/npc=24583
UPDATE `creature_template_locale` SET `Name` = '[Irontide Engineer]' WHERE `locale` = 'ruRU' AND `entry` = 24583;
-- OLD name : Рыболов из клана Истинного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24584
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Fisherman]' WHERE `locale` = 'ruRU' AND `entry` = 24584;
-- OLD name : Член клана Истинного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24585
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Clansman]' WHERE `locale` = 'ruRU' AND `entry` = 24585;
-- OLD name : Гарпунщик из клана Истинного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24586
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Harpooner]' WHERE `locale` = 'ruRU' AND `entry` = 24586;
-- OLD name : Китобой из клана Истинного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24587
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Whaler]' WHERE `locale` = 'ruRU' AND `entry` = 24587;
-- OLD name : Заклинатель моря из клана Истинного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24588
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Sea-caller]' WHERE `locale` = 'ruRU' AND `entry` = 24588;
-- OLD name : Охотник на косаток из клана Истинного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24589
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Orca Hunter]' WHERE `locale` = 'ruRU' AND `entry` = 24589;
-- OLD name : Проводник из клана Истинного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24590
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Wayfinder]' WHERE `locale` = 'ruRU' AND `entry` = 24590;
-- OLD name : Резчик идолов из клана Истинного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24591
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Idol-Carver]' WHERE `locale` = 'ruRU' AND `entry` = 24591;
-- OLD name : Старейшина клана Истинного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24592
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Elder]' WHERE `locale` = 'ruRU' AND `entry` = 24592;
-- OLD name : Ведун-жрец из клана Истинного Клыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24593
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Sage-Priest]' WHERE `locale` = 'ruRU' AND `entry` = 24593;
-- OLD name : Коралловопанцирная черепаха
-- Source : https://www.wowhead.com/wotlk/ru/npc=24594
UPDATE `creature_template_locale` SET `Name` = '[Coral Shell Turtle]' WHERE `locale` = 'ruRU' AND `entry` = 24594;
-- OLD name : Корраловопанцирный крепкохват
-- Source : https://www.wowhead.com/wotlk/ru/npc=24595
UPDATE `creature_template_locale` SET `Name` = '[Coral Shell Snapper]' WHERE `locale` = 'ruRU' AND `entry` = 24595;
-- OLD name : Древняя коралловая черепаха
-- Source : https://www.wowhead.com/wotlk/ru/npc=24596
UPDATE `creature_template_locale` SET `Name` = '[Ancient Coral Shell]' WHERE `locale` = 'ruRU' AND `entry` = 24596;
-- OLD name : Береговой волноход
-- Source : https://www.wowhead.com/wotlk/ru/npc=24597
UPDATE `creature_template_locale` SET `Name` = '[Coast Surger]' WHERE `locale` = 'ruRU' AND `entry` = 24597;
-- OLD name : Волноход
-- Source : https://www.wowhead.com/wotlk/ru/npc=24598
UPDATE `creature_template_locale` SET `Name` = '[Tide Surger]' WHERE `locale` = 'ruRU' AND `entry` = 24598;
-- OLD name : Старший волноход
-- Source : https://www.wowhead.com/wotlk/ru/npc=24599
UPDATE `creature_template_locale` SET `Name` = '[Greater Tide Surger]' WHERE `locale` = 'ruRU' AND `entry` = 24599;
-- OLD name : Паровой потрошитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=24600
UPDATE `creature_template_locale` SET `Name` = '[Steam Ripper]' WHERE `locale` = 'ruRU' AND `entry` = 24600;
-- OLD name : Живой гейзер
-- Source : https://www.wowhead.com/wotlk/ru/npc=24602
UPDATE `creature_template_locale` SET `Name` = '[Living Geyser]' WHERE `locale` = 'ruRU' AND `entry` = 24602;
-- OLD name : Живая вьюга
-- Source : https://www.wowhead.com/wotlk/ru/npc=24603
UPDATE `creature_template_locale` SET `Name` = '[Living Blizzard]' WHERE `locale` = 'ruRU' AND `entry` = 24603;
-- OLD name : Ледяная ярость
-- Source : https://www.wowhead.com/wotlk/ru/npc=24604
UPDATE `creature_template_locale` SET `Name` = '[Ice Fury]' WHERE `locale` = 'ruRU' AND `entry` = 24604;
-- OLD name : Налетчик из клана Волдскар
-- Source : https://www.wowhead.com/wotlk/ru/npc=24605
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Raider]' WHERE `locale` = 'ruRU' AND `entry` = 24605;
-- OLD name : Расхититель из клана Волдскар
-- Source : https://www.wowhead.com/wotlk/ru/npc=24606
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Plunderer]' WHERE `locale` = 'ruRU' AND `entry` = 24606;
-- OLD name : Щитоносец клана Волдскар
-- Source : https://www.wowhead.com/wotlk/ru/npc=24607
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Shield-Maiden]' WHERE `locale` = 'ruRU' AND `entry` = 24607;
-- OLD name : Гребец из клана Волдскар
-- Source : https://www.wowhead.com/wotlk/ru/npc=24608
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Oar-man]' WHERE `locale` = 'ruRU' AND `entry` = 24608;
-- OLD name : Погромщик из клана Волдскар
-- Source : https://www.wowhead.com/wotlk/ru/npc=24609
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Pillager]' WHERE `locale` = 'ruRU' AND `entry` = 24609;
-- OLD name : Руночар из клана Волдскар
-- Source : https://www.wowhead.com/wotlk/ru/npc=24610
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Rune-caster]' WHERE `locale` = 'ruRU' AND `entry` = 24610;
-- OLD name : Мореход из клана Волдскар
-- Source : https://www.wowhead.com/wotlk/ru/npc=24611
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Sea-Waker]' WHERE `locale` = 'ruRU' AND `entry` = 24611;
-- OLD name : Тан Волдскара
-- Source : https://www.wowhead.com/wotlk/ru/npc=24612
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Thane]' WHERE `locale` = 'ruRU' AND `entry` = 24612;
-- OLD name : Одинокий мамонт
-- Source : https://www.wowhead.com/wotlk/ru/npc=24615
UPDATE `creature_template_locale` SET `Name` = '[Solitary Mammoth]' WHERE `locale` = 'ruRU' AND `entry` = 24615;
-- OLD name : Мамонт-патриарх
-- Source : https://www.wowhead.com/wotlk/ru/npc=24616
UPDATE `creature_template_locale` SET `Name` = '[Mammoth Patriarch]' WHERE `locale` = 'ruRU' AND `entry` = 24616;
-- OLD name : Голодный тундровый волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=24618
UPDATE `creature_template_locale` SET `Name` = '[Starving Tundra Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 24618;
-- OLD name : Старший тундровый волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=24619
UPDATE `creature_template_locale` SET `Name` = '[Greater Tundra Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 24619;
-- OLD name : Скелет из ледяной клети
-- Source : https://www.wowhead.com/wotlk/ru/npc=24621
UPDATE `creature_template_locale` SET `Name` = '[Frost Cage Skeleton]' WHERE `locale` = 'ruRU' AND `entry` = 24621;
-- OLD name : Разоритель из ледяной клети
-- Source : https://www.wowhead.com/wotlk/ru/npc=24622
UPDATE `creature_template_locale` SET `Name` = '[Frost Cage Reaver]' WHERE `locale` = 'ruRU' AND `entry` = 24622;
-- OLD name : Промерзшие кости
-- Source : https://www.wowhead.com/wotlk/ru/npc=24623
UPDATE `creature_template_locale` SET `Name` = '[Frosty Bones]' WHERE `locale` = 'ruRU' AND `entry` = 24623;
-- OLD name : Боральская горгулья
-- Source : https://www.wowhead.com/wotlk/ru/npc=24624
UPDATE `creature_template_locale` SET `Name` = '[Boralstone Gargoyle]' WHERE `locale` = 'ruRU' AND `entry` = 24624;
-- OLD name : Боральский небесный охотник
-- Source : https://www.wowhead.com/wotlk/ru/npc=24625
UPDATE `creature_template_locale` SET `Name` = '[Boralstone Skyhunter]' WHERE `locale` = 'ruRU' AND `entry` = 24625;
-- OLD name : Визгунья-певчая Плети
-- Source : https://www.wowhead.com/wotlk/ru/npc=24626
UPDATE `creature_template_locale` SET `Name` = '[Scourgesong Shrieker]' WHERE `locale` = 'ruRU' AND `entry` = 24626;
-- OLD name : Плакальщица Плети
-- Source : https://www.wowhead.com/wotlk/ru/npc=24627
UPDATE `creature_template_locale` SET `Name` = '[Scourgesong Wailer]' WHERE `locale` = 'ruRU' AND `entry` = 24627;
-- OLD name : Флибустьер Северных морей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24636
UPDATE `creature_template_locale` SET `Name` = '[Northsea Freebooter]' WHERE `locale` = 'ruRU' AND `entry` = 24636;
-- OLD name : Alliance Standard Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=24641
UPDATE `creature_template_locale` SET `Name` = '[Alliance Standard Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 24641;
-- OLD name : Рама зеркала
-- Source : https://www.wowhead.com/wotlk/ru/npc=24645
UPDATE `creature_template_locale` SET `Name` = '[Mirror Frame]' WHERE `locale` = 'ruRU' AND `entry` = 24645;
-- OLD name : Invisible Stalker (Scale x2)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24648
UPDATE `creature_template_locale` SET `Name` = '[Invisible Stalker (Scale x2)]' WHERE `locale` = 'ruRU' AND `entry` = 24648;
-- OLD name : Отражение пламени
-- Source : https://www.wowhead.com/wotlk/ru/npc=24651
UPDATE `creature_template_locale` SET `Name` = '[Reflection of Flame]' WHERE `locale` = 'ruRU' AND `entry` = 24651;
-- OLD name : Серф-гарпун
-- Source : https://www.wowhead.com/wotlk/ru/npc=24652
UPDATE `creature_template_locale` SET `Name` = '[Harpoon Surfboard]' WHERE `locale` = 'ruRU' AND `entry` = 24652;
-- OLD name : Reflection Bounce Target
-- Source : https://www.wowhead.com/wotlk/ru/npc=24655
UPDATE `creature_template_locale` SET `Name` = '[Reflection Bounce Target]' WHERE `locale` = 'ruRU' AND `entry` = 24655;
-- OLD name : Повелитель приливов
-- Source : https://www.wowhead.com/wotlk/ru/npc=24663
UPDATE `creature_template_locale` SET `Name` = '[Tidelord]' WHERE `locale` = 'ruRU' AND `entry` = 24663;
-- OLD name : Лейтенант Ледяной Молот (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24665;
-- OLD name : Врайкульская гарпунная пушка (СТАРЫЙ)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24682
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Harpoon Gun (OLD)]' WHERE `locale` = 'ruRU' AND `entry` = 24682;
-- OLD name : Маг-стражник из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24683
UPDATE `creature_template_locale` SET `Name` = 'Маг-стражник Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 24683;
-- OLD name : Рыцарь крови из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24684
UPDATE `creature_template_locale` SET `Name` = 'Рыцарь крови Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 24684;
-- OLD name : Магистр из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24685
UPDATE `creature_template_locale` SET `Name` = 'Магистр Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 24685;
-- OLD name : Чернокнижник из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24686
UPDATE `creature_template_locale` SET `Name` = 'Чернокнижник Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 24686;
-- OLD name : Врач из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24687
UPDATE `creature_template_locale` SET `Name` = 'Врач Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 24687;
-- OLD name : Invisible Vehicle (Floating)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24704
UPDATE `creature_template_locale` SET `Name` = '[Invisible Vehicle (Floating)]' WHERE `locale` = 'ruRU' AND `entry` = 24704;
-- OLD name : Test Scaling Bony Construct
-- Source : https://www.wowhead.com/wotlk/ru/npc=24712
UPDATE `creature_template_locale` SET `Name` = '[Test Scaling Bony Construct]' WHERE `locale` = 'ruRU' AND `entry` = 24712;
-- OLD name : Такси-ветролет
-- Source : https://www.wowhead.com/wotlk/ru/npc=24716
UPDATE `creature_template_locale` SET `Name` = '[Flying Machine Taxi]' WHERE `locale` = 'ruRU' AND `entry` = 24716;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24717
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24717;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24718
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24718;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24719
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24719;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24720
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24720;
-- OLD name : Летающий синий дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=24721
UPDATE `creature_template_locale` SET `Name` = '[Flying Blue Drake]' WHERE `locale` = 'ruRU' AND `entry` = 24721;
-- OLD name : Gorloc Oracle Black (Northrend Model)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24724
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Black (Northrend Model)]' WHERE `locale` = 'ruRU' AND `entry` = 24724;
-- OLD name : Собачья нарта
-- Source : https://www.wowhead.com/wotlk/ru/npc=24725
UPDATE `creature_template_locale` SET `Name` = '[Dog Sled]' WHERE `locale` = 'ruRU' AND `entry` = 24725;
-- OLD name : Санный пес
-- Source : https://www.wowhead.com/wotlk/ru/npc=24726
UPDATE `creature_template_locale` SET `Name` = '[Sled Dog]' WHERE `locale` = 'ruRU' AND `entry` = 24726;
-- OLD name : Грязевая оса
-- Source : https://www.wowhead.com/wotlk/ru/npc=24731
UPDATE `creature_template_locale` SET `Name` = '[Mud Wasp]' WHERE `locale` = 'ruRU' AND `entry` = 24731;
-- OLD name : Грязевой шкипер
-- Source : https://www.wowhead.com/wotlk/ru/npc=24732
UPDATE `creature_template_locale` SET `Name` = '[Mud Skipper]' WHERE `locale` = 'ruRU' AND `entry` = 24732;
-- OLD name : Угодья фьорда 03
-- Source : https://www.wowhead.com/wotlk/ru/npc=24748
UPDATE `creature_template_locale` SET `Name` = '[Fjord Prey 03]' WHERE `locale` = 'ruRU' AND `entry` = 24748;
-- OLD name : Угодья фьорда 04
-- Source : https://www.wowhead.com/wotlk/ru/npc=24749
UPDATE `creature_template_locale` SET `Name` = '[Fjord Prey 04]' WHERE `locale` = 'ruRU' AND `entry` = 24749;
-- OLD name : Отражение магии
-- Source : https://www.wowhead.com/wotlk/ru/npc=24756
UPDATE `creature_template_locale` SET `Name` = '[Reflection of Magic]' WHERE `locale` = 'ruRU' AND `entry` = 24756;
-- OLD name : Фьордовая скальная змея
-- Source : https://www.wowhead.com/wotlk/ru/npc=24757
UPDATE `creature_template_locale` SET `Name` = '[Fjord Rock Snake]' WHERE `locale` = 'ruRU' AND `entry` = 24757;
-- OLD name : Метка тотема копьеклыкого ворга
-- Source : https://www.wowhead.com/wotlk/ru/npc=24758
UPDATE `creature_template_locale` SET `Name` = '[Spearfang Worg Totem Credit]' WHERE `locale` = 'ruRU' AND `entry` = 24758;
-- OLD name : Пленный клыкарр
-- Source : https://www.wowhead.com/wotlk/ru/npc=24759
UPDATE `creature_template_locale` SET `Name` = '[Captive Tuskarr]' WHERE `locale` = 'ruRU' AND `entry` = 24759;
-- OLD name : Фьордовый монарх
-- Source : https://www.wowhead.com/wotlk/ru/npc=24760
UPDATE `creature_template_locale` SET `Name` = '[Fjord Monarch]' WHERE `locale` = 'ruRU' AND `entry` = 24760;
-- OLD name : Хранитель из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24762
UPDATE `creature_template_locale` SET `Name` = 'Хранитель Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 24762;
-- OLD name : Суриут
-- Source : https://www.wowhead.com/wotlk/ru/npc=24764
UPDATE `creature_template_locale` SET `Name` = '[Suirut]' WHERE `locale` = 'ruRU' AND `entry` = 24764;
-- OLD name : Ловчий смерти Хейвард
-- Source : https://www.wowhead.com/wotlk/ru/npc=24768
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти Хейвард' WHERE `locale` = 'ruRU' AND `entry` = 24768;
-- OLD name : Красный дракончик Хладарры
-- Source : https://www.wowhead.com/wotlk/ru/npc=24775
UPDATE `creature_template_locale` SET `Name` = '[Coldarra Red Whelp]' WHERE `locale` = 'ruRU' AND `entry` = 24775;
-- OLD name : Часовой из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24777
UPDATE `creature_template_locale` SET `Name` = 'Часовой Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 24777;
-- OLD name : Missile Target Flare
-- Source : https://www.wowhead.com/wotlk/ru/npc=24778
UPDATE `creature_template_locale` SET `Name` = '[Missile Target Flare]' WHERE `locale` = 'ruRU' AND `entry` = 24778;
-- OLD name : Фьордовая оса
-- Source : https://www.wowhead.com/wotlk/ru/npc=24793
UPDATE `creature_template_locale` SET `Name` = '[Fjord Wasp]' WHERE `locale` = 'ruRU' AND `entry` = 24793;
-- OLD name : Жук фьорда
-- Source : https://www.wowhead.com/wotlk/ru/npc=24794
UPDATE `creature_template_locale` SET `Name` = '[Fjord Beetle]' WHERE `locale` = 'ruRU' AND `entry` = 24794;
-- OLD name : Grell (Pink)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24798
UPDATE `creature_template_locale` SET `Name` = '[Grell (Pink)]' WHERE `locale` = 'ruRU' AND `entry` = 24798;
-- OLD name : Grell (Blue)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24799
UPDATE `creature_template_locale` SET `Name` = '[Grell (Blue)]' WHERE `locale` = 'ruRU' AND `entry` = 24799;
-- OLD name : Grell (Blanca)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24800
UPDATE `creature_template_locale` SET `Name` = '[Grell (Blanca)]' WHERE `locale` = 'ruRU' AND `entry` = 24800;
-- OLD name : Grell (Red)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24801
UPDATE `creature_template_locale` SET `Name` = '[Grell (Red)]' WHERE `locale` = 'ruRU' AND `entry` = 24801;
-- OLD name : Grell (Orange)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24802
UPDATE `creature_template_locale` SET `Name` = '[Grell (Orange)]' WHERE `locale` = 'ruRU' AND `entry` = 24802;
-- OLD name : Grell (White)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24803
UPDATE `creature_template_locale` SET `Name` = '[Grell (White)]' WHERE `locale` = 'ruRU' AND `entry` = 24803;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24807
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24807;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24811
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24811;
-- OLD name : Скакун Всадника без головы
-- Source : https://www.wowhead.com/wotlk/ru/npc=24814
UPDATE `creature_template_locale` SET `Name` = 'Верховое животное Всадника без головы' WHERE `locale` = 'ruRU' AND `entry` = 24814;
-- OLD name : Фьордовый дикобраз
-- Source : https://www.wowhead.com/wotlk/ru/npc=24816
UPDATE `creature_template_locale` SET `Name` = '[Fjord Porcupine]' WHERE `locale` = 'ruRU' AND `entry` = 24816;
-- OLD name : Управление событием Лиги исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24817
UPDATE `creature_template_locale` SET `Name` = 'Управление событием Лиги Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24817;
-- OLD subname : Леди Мели
-- Source : https://www.wowhead.com/wotlk/ru/npc=24833
UPDATE `creature_template_locale` SET `Title` = '"Леди Мели"' WHERE `locale` = 'ruRU' AND `entry` = 24833;
-- OLD name : Галерный повар Грейс, subname : Леди Мели
-- Source : https://www.wowhead.com/wotlk/ru/npc=24834
UPDATE `creature_template_locale` SET `Name` = 'Кок Грейс',`Title` = '"Леди Мели"' WHERE `locale` = 'ruRU' AND `entry` = 24834;
-- OLD subname : Леди Мели
-- Source : https://www.wowhead.com/wotlk/ru/npc=24835
UPDATE `creature_template_locale` SET `Title` = '"Леди Мели"' WHERE `locale` = 'ruRU' AND `entry` = 24835;
-- OLD name : Эйб Юнга, subname : Леди Мели
-- Source : https://www.wowhead.com/wotlk/ru/npc=24836
UPDATE `creature_template_locale` SET `Name` = 'Юнга Эйб',`Title` = '"Леди Мели"' WHERE `locale` = 'ruRU' AND `entry` = 24836;
-- OLD subname : Леди Мели
-- Source : https://www.wowhead.com/wotlk/ru/npc=24837
UPDATE `creature_template_locale` SET `Title` = '"Леди Мели"' WHERE `locale` = 'ruRU' AND `entry` = 24837;
-- OLD subname : Леди Мели
-- Source : https://www.wowhead.com/wotlk/ru/npc=24838
UPDATE `creature_template_locale` SET `Title` = '"Леди Мели"' WHERE `locale` = 'ruRU' AND `entry` = 24838;
-- OLD subname : Леди Мели
-- Source : https://www.wowhead.com/wotlk/ru/npc=24839
UPDATE `creature_template_locale` SET `Title` = '"Леди Мели"' WHERE `locale` = 'ruRU' AND `entry` = 24839;
-- OLD subname : Леди Мели
-- Source : https://www.wowhead.com/wotlk/ru/npc=24840
UPDATE `creature_template_locale` SET `Title` = '"Леди Мели"' WHERE `locale` = 'ruRU' AND `entry` = 24840;
-- OLD name : Страж бухты Андерсон
-- Source : https://www.wowhead.com/wotlk/ru/npc=24842
UPDATE `creature_template_locale` SET `Name` = 'Стражница бухты Андерсон' WHERE `locale` = 'ruRU' AND `entry` = 24842;
-- OLD subname : Леди Мели
-- Source : https://www.wowhead.com/wotlk/ru/npc=24843
UPDATE `creature_template_locale` SET `Title` = '"Леди Мели"' WHERE `locale` = 'ruRU' AND `entry` = 24843;
-- OLD name : Тачка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24853
UPDATE `creature_template_locale` SET `Name` = '[Wheelbarrow]' WHERE `locale` = 'ruRU' AND `entry` = 24853;
-- OLD name : Перегревшийся элементаль
-- Source : https://www.wowhead.com/wotlk/ru/npc=24859
UPDATE `creature_template_locale` SET `Name` = '[Superheated Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 24859;
-- OLD name : Пиратка из Братства Справедливости (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24860;
-- OLD name : Хрустальный проблеск
-- Source : https://www.wowhead.com/wotlk/ru/npc=24861
UPDATE `creature_template_locale` SET `Name` = '[Crystal Beam]' WHERE `locale` = 'ruRU' AND `entry` = 24861;
-- OLD name : Переключатель хрустального проблеска
-- Source : https://www.wowhead.com/wotlk/ru/npc=24865
UPDATE `creature_template_locale` SET `Name` = '[Crystal Beam Relay]' WHERE `locale` = 'ruRU' AND `entry` = 24865;
-- OLD name : Вражеский отчаянный противник из Халаа
-- Source : https://www.wowhead.com/wotlk/ru/npc=24867
UPDATE `creature_template_locale` SET `Name` = 'Противник из Халаа' WHERE `locale` = 'ruRU' AND `entry` = 24867;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=24868
UPDATE `creature_template_locale` SET `Title` = 'Учитель мастеров инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 24868;
-- OLD name : Страж грузовой машины
-- Source : https://www.wowhead.com/wotlk/ru/npc=24869
UPDATE `creature_template_locale` SET `Name` = '[Rig Guardian]' WHERE `locale` = 'ruRU' AND `entry` = 24869;
-- OLD name : Техник грузовой машины
-- Source : https://www.wowhead.com/wotlk/ru/npc=24870
UPDATE `creature_template_locale` SET `Name` = '[Rig Technician]' WHERE `locale` = 'ruRU' AND `entry` = 24870;
-- OLD name : Часовой грузовой машины
-- Source : https://www.wowhead.com/wotlk/ru/npc=24878
UPDATE `creature_template_locale` SET `Name` = '[Rig Sentry]' WHERE `locale` = 'ruRU' AND `entry` = 24878;
-- OLD name : Метка задания Ветрана
-- Source : https://www.wowhead.com/wotlk/ru/npc=24890
UPDATE `creature_template_locale` SET `Name` = '[Windan Quest Credit]' WHERE `locale` = 'ruRU' AND `entry` = 24890;
-- OLD name : Утесное чудище
-- Source : https://www.wowhead.com/wotlk/ru/npc=24894
UPDATE `creature_template_locale` SET `Name` = '[Bluff Behemoth]' WHERE `locale` = 'ruRU' AND `entry` = 24894;
-- OLD name : Юнга Луи (каноэ)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24898
UPDATE `creature_template_locale` SET `Name` = '[Lou the Cabin Boy (Canoe)]' WHERE `locale` = 'ruRU' AND `entry` = 24898;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=24905
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 24905;
-- OLD name : Снегобоязнь
-- Source : https://www.wowhead.com/wotlk/ru/npc=24915
UPDATE `creature_template_locale` SET `Name` = '[Snowball Stampede]' WHERE `locale` = 'ruRU' AND `entry` = 24915;
-- OLD subname : Железный Орел
-- Source : https://www.wowhead.com/wotlk/ru/npc=24924
UPDATE `creature_template_locale` SET `Title` = '"Железный орел"' WHERE `locale` = 'ruRU' AND `entry` = 24924;
-- OLD subname : Железный Орел
-- Source : https://www.wowhead.com/wotlk/ru/npc=24926
UPDATE `creature_template_locale` SET `Title` = '"Железный орел"' WHERE `locale` = 'ruRU' AND `entry` = 24926;
-- OLD subname : Железный Орел
-- Source : https://www.wowhead.com/wotlk/ru/npc=24927
UPDATE `creature_template_locale` SET `Title` = '"Железный орел"' WHERE `locale` = 'ruRU' AND `entry` = 24927;
-- OLD subname : Железный Орел
-- Source : https://www.wowhead.com/wotlk/ru/npc=24929
UPDATE `creature_template_locale` SET `Title` = '"Железный орел"' WHERE `locale` = 'ruRU' AND `entry` = 24929;
-- OLD subname : Железный Орел
-- Source : https://www.wowhead.com/wotlk/ru/npc=24930
UPDATE `creature_template_locale` SET `Title` = '"Железный орел"' WHERE `locale` = 'ruRU' AND `entry` = 24930;
-- OLD subname : Железный Орел
-- Source : https://www.wowhead.com/wotlk/ru/npc=24931
UPDATE `creature_template_locale` SET `Title` = '"Железный орел"' WHERE `locale` = 'ruRU' AND `entry` = 24931;
-- OLD name : Вкусоматик IV
-- Source : https://www.wowhead.com/wotlk/ru/npc=24934
UPDATE `creature_template_locale` SET `Name` = '"Вкусоматик IV"' WHERE `locale` = 'ruRU' AND `entry` = 24934;
-- OLD name : Торг-о-трон делюкс
-- Source : https://www.wowhead.com/wotlk/ru/npc=24935
UPDATE `creature_template_locale` SET `Name` = '"Торг-о-трон делюкс"' WHERE `locale` = 'ruRU' AND `entry` = 24935;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=24974
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 24974;
-- OLD name : Мадам Склянкотар, subname : Супруга Склянкотара
-- Source : https://www.wowhead.com/wotlk/ru/npc=24982
UPDATE `creature_template_locale` SET `Name` = 'Мадам Склянкотавр',`Title` = 'Чары для PTR' WHERE `locale` = 'ruRU' AND `entry` = 24982;
-- OLD name : Нечистый дух магнатавра
-- Source : https://www.wowhead.com/wotlk/ru/npc=24983
UPDATE `creature_template_locale` SET `Name` = '[Tainted Magnataur Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 24983;
-- OLD name : Рождественский великий чернокнижник Проклятие Пустоты
-- Source : https://www.wowhead.com/wotlk/ru/npc=24984
UPDATE `creature_template_locale` SET `Name` = 'Рождественский главный чернокнижник Пустоклят' WHERE `locale` = 'ruRU' AND `entry` = 24984;
-- OLD name : Галерный кок Марисс, subname : Лунная пыль
-- Source : https://www.wowhead.com/wotlk/ru/npc=24993
UPDATE `creature_template_locale` SET `Name` = 'Кок Марисс',`Title` = '"Лунная пыль"' WHERE `locale` = 'ruRU' AND `entry` = 24993;
-- OLD subname : Лунная пыль
-- Source : https://www.wowhead.com/wotlk/ru/npc=24995
UPDATE `creature_template_locale` SET `Title` = '"Лунная пыль"' WHERE `locale` = 'ruRU' AND `entry` = 24995;
-- OLD name : Морячка Шепот Клинка, subname : Лунная пыль
-- Source : https://www.wowhead.com/wotlk/ru/npc=24996
UPDATE `creature_template_locale` SET `Name` = 'Матрос Шепот Клинка',`Title` = '"Лунная пыль"' WHERE `locale` = 'ruRU' AND `entry` = 24996;
-- OLD name : Морячка Стремительная Звезда, subname : Лунная пыль
-- Source : https://www.wowhead.com/wotlk/ru/npc=24997
UPDATE `creature_template_locale` SET `Name` = 'Матрос Стремительная Звезда',`Title` = '"Лунная пыль"' WHERE `locale` = 'ruRU' AND `entry` = 24997;
-- OLD name : Морячка Дальневзор, subname : Лунная пыль
-- Source : https://www.wowhead.com/wotlk/ru/npc=24998
UPDATE `creature_template_locale` SET `Name` = 'Матрос Дальний Взор',`Title` = '"Лунная пыль"' WHERE `locale` = 'ruRU' AND `entry` = 24998;
-- OLD name : Dan's Test Vehicle
-- Source : https://www.wowhead.com/wotlk/ru/npc=25006
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Vehicle]' WHERE `locale` = 'ruRU' AND `entry` = 25006;
-- OLD name : Морячка Вечный Туман, subname : Лунная пыль
-- Source : https://www.wowhead.com/wotlk/ru/npc=25007
UPDATE `creature_template_locale` SET `Name` = 'Матрос Вечерний Туман',`Title` = '"Лунная пыль"' WHERE `locale` = 'ruRU' AND `entry` = 25007;
-- OLD name : Галерный кок Сборень
-- Source : https://www.wowhead.com/wotlk/ru/npc=25012
UPDATE `creature_template_locale` SET `Name` = 'Кок Сборень' WHERE `locale` = 'ruRU' AND `entry` = 25012;
-- OLD name : Галерный кок Алунвея
-- Source : https://www.wowhead.com/wotlk/ru/npc=25020
UPDATE `creature_template_locale` SET `Name` = 'Кок Алунвея' WHERE `locale` = 'ruRU' AND `entry` = 25020;
-- OLD name : Морячка Лунный Клинок
-- Source : https://www.wowhead.com/wotlk/ru/npc=25021
UPDATE `creature_template_locale` SET `Name` = 'Матрос Лунный Клинок' WHERE `locale` = 'ruRU' AND `entry` = 25021;
-- OLD name : Морячка Безмолвное Бдение
-- Source : https://www.wowhead.com/wotlk/ru/npc=25022
UPDATE `creature_template_locale` SET `Name` = 'Матрос Безмолвное Бдение' WHERE `locale` = 'ruRU' AND `entry` = 25022;
-- OLD name : Морячка Вечнобдительная
-- Source : https://www.wowhead.com/wotlk/ru/npc=25023
UPDATE `creature_template_locale` SET `Name` = 'Матрос Вечный Дозор' WHERE `locale` = 'ruRU' AND `entry` = 25023;
-- OLD name : Морячка Нежная Песнь
-- Source : https://www.wowhead.com/wotlk/ru/npc=25024
UPDATE `creature_template_locale` SET `Name` = 'Матрос Нежная Песнь' WHERE `locale` = 'ruRU' AND `entry` = 25024;
-- OLD name : Бесноватый вурдалак
-- Source : https://www.wowhead.com/wotlk/ru/npc=25027
UPDATE `creature_template_locale` SET `Name` = 'Взбесившийся вурдалак' WHERE `locale` = 'ruRU' AND `entry` = 25027;
-- OLD name : Скелетон-опустошитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=25028
UPDATE `creature_template_locale` SET `Name` = 'Скелет-опустошитель' WHERE `locale` = 'ruRU' AND `entry` = 25028;
-- OLD name : Эредарский колдун
-- Source : https://www.wowhead.com/wotlk/ru/npc=25033
UPDATE `creature_template_locale` SET `Name` = 'Эредар-колдун' WHERE `locale` = 'ruRU' AND `entry` = 25033;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=25037
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 25037;
-- OLD name : Скакун утренней звезды
-- Source : https://www.wowhead.com/wotlk/ru/npc=25049
UPDATE `creature_template_locale` SET `Name` = 'Скакун Утренней Звезды' WHERE `locale` = 'ruRU' AND `entry` = 25049;
-- OLD name : Галерный кок Галумвория
-- Source : https://www.wowhead.com/wotlk/ru/npc=25052
UPDATE `creature_template_locale` SET `Name` = 'Кок Галумвория' WHERE `locale` = 'ruRU' AND `entry` = 25052;
-- OLD name : Морячка Дальнебродка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25053
UPDATE `creature_template_locale` SET `Name` = 'Матрос Дальний Поход' WHERE `locale` = 'ruRU' AND `entry` = 25053;
-- OLD name : Морячка Яркая Звезда
-- Source : https://www.wowhead.com/wotlk/ru/npc=25054
UPDATE `creature_template_locale` SET `Name` = 'Матрос Яркая Звезда' WHERE `locale` = 'ruRU' AND `entry` = 25054;
-- OLD name : Морячка Холодная Ночь
-- Source : https://www.wowhead.com/wotlk/ru/npc=25055
UPDATE `creature_template_locale` SET `Name` = 'Матрос Холодная Ночь' WHERE `locale` = 'ruRU' AND `entry` = 25055;
-- OLD name : Морячка Бесшумный Ход
-- Source : https://www.wowhead.com/wotlk/ru/npc=25056
UPDATE `creature_template_locale` SET `Name` = 'Матрос Бесшумный Ход' WHERE `locale` = 'ruRU' AND `entry` = 25056;
-- OLD name : Предвестник Иннуро
-- Source : https://www.wowhead.com/wotlk/ru/npc=25061
UPDATE `creature_template_locale` SET `Name` = 'Предвестник Инууро' WHERE `locale` = 'ruRU' AND `entry` = 25061;
-- OLD subname : Девичий каприз
-- Source : https://www.wowhead.com/wotlk/ru/npc=25078
UPDATE `creature_template_locale` SET `Title` = '"Девичий каприз"' WHERE `locale` = 'ruRU' AND `entry` = 25078;
-- OLD subname : Девичий каприз
-- Source : https://www.wowhead.com/wotlk/ru/npc=25082
UPDATE `creature_template_locale` SET `Title` = '"Девичий каприз"' WHERE `locale` = 'ruRU' AND `entry` = 25082;
-- OLD name : Зеленожабрый-раб
-- Source : https://www.wowhead.com/wotlk/ru/npc=25084
UPDATE `creature_template_locale` SET `Name` = 'Раб из племени Зеленожабрых' WHERE `locale` = 'ruRU' AND `entry` = 25084;
-- OLD name : Освобожденный зеленожабрый-раб
-- Source : https://www.wowhead.com/wotlk/ru/npc=25085
UPDATE `creature_template_locale` SET `Name` = 'Освобожденный раб из племени Зеленожабрых' WHERE `locale` = 'ruRU' AND `entry` = 25085;
-- OLD name : Галерный кок Сталебрюх, subname : Девичий каприз
-- Source : https://www.wowhead.com/wotlk/ru/npc=25089
UPDATE `creature_template_locale` SET `Name` = 'Кок Сталебрюх',`Title` = '"Девичий каприз"' WHERE `locale` = 'ruRU' AND `entry` = 25089;
-- OLD subname : Девичий каприз
-- Source : https://www.wowhead.com/wotlk/ru/npc=25093
UPDATE `creature_template_locale` SET `Title` = '"Девичий каприз"' WHERE `locale` = 'ruRU' AND `entry` = 25093;
-- OLD subname : Девичий каприз
-- Source : https://www.wowhead.com/wotlk/ru/npc=25094
UPDATE `creature_template_locale` SET `Title` = '"Девичий каприз"' WHERE `locale` = 'ruRU' AND `entry` = 25094;
-- OLD subname : Девичий каприз
-- Source : https://www.wowhead.com/wotlk/ru/npc=25095
UPDATE `creature_template_locale` SET `Title` = '"Девичий каприз"' WHERE `locale` = 'ruRU' AND `entry` = 25095;
-- OLD subname : Девичий каприз
-- Source : https://www.wowhead.com/wotlk/ru/npc=25096
UPDATE `creature_template_locale` SET `Title` = '"Девичий каприз"' WHERE `locale` = 'ruRU' AND `entry` = 25096;
-- OLD subname : Девичий каприз
-- Source : https://www.wowhead.com/wotlk/ru/npc=25097
UPDATE `creature_template_locale` SET `Title` = '"Девичий каприз"' WHERE `locale` = 'ruRU' AND `entry` = 25097;
-- OLD subname : Девичий каприз
-- Source : https://www.wowhead.com/wotlk/ru/npc=25098
UPDATE `creature_template_locale` SET `Title` = '"Девичий каприз"' WHERE `locale` = 'ruRU' AND `entry` = 25098;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=25099
UPDATE `creature_template_locale` SET `Title` = 'Учитель мастеров инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 25099;
-- OLD subname : Девичий каприз
-- Source : https://www.wowhead.com/wotlk/ru/npc=25111
UPDATE `creature_template_locale` SET `Title` = '"Девичий каприз"' WHERE `locale` = 'ruRU' AND `entry` = 25111;
-- OLD name : Анахорет Оури
-- Source : https://www.wowhead.com/wotlk/ru/npc=25112
UPDATE `creature_template_locale` SET `Name` = 'Анахоретка Аюри' WHERE `locale` = 'ruRU' AND `entry` = 25112;
-- OLD name : Наблюдатель из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25132
UPDATE `creature_template_locale` SET `Name` = 'Наблюдатель Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25132;
-- OLD name : Капитан Дранарус
-- Source : https://www.wowhead.com/wotlk/ru/npc=25138
UPDATE `creature_template_locale` SET `Name` = 'Капитан Дранар' WHERE `locale` = 'ruRU' AND `entry` = 25138;
-- OLD name : Сержант-инструктор Бадум
-- Source : https://www.wowhead.com/wotlk/ru/npc=25162
UPDATE `creature_template_locale` SET `Name` = 'Сержант-инструктор Бадуум' WHERE `locale` = 'ruRU' AND `entry` = 25162;
-- OLD name : Главная чернокнижница Алитесса
-- Source : https://www.wowhead.com/wotlk/ru/npc=25166
UPDATE `creature_template_locale` SET `Name` = 'Верховная чернокнижница Алитесса' WHERE `locale` = 'ruRU' AND `entry` = 25166;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/ru/npc=25195
UPDATE `creature_template_locale` SET `Title` = 'Продавец особых боеприпасов' WHERE `locale` = 'ruRU' AND `entry` = 25195;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/ru/npc=25196
UPDATE `creature_template_locale` SET `Title` = 'Продавец особых боеприпасов' WHERE `locale` = 'ruRU' AND `entry` = 25196;
-- OLD name : Образ Тени
-- Source : https://www.wowhead.com/wotlk/ru/npc=25214
UPDATE `creature_template_locale` SET `Name` = 'Темная проекция' WHERE `locale` = 'ruRU' AND `entry` = 25214;
-- OLD name : TEST - Clayton Dubin - TEST
-- Source : https://www.wowhead.com/wotlk/ru/npc=25221
UPDATE `creature_template_locale` SET `Name` = '[TEST - Clayton Dubin - TEST]' WHERE `locale` = 'ruRU' AND `entry` = 25221;
-- OLD subname : Повелительница рыцарей крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=25246
UPDATE `creature_template_locale` SET `Title` = 'Матриарх рыцарей крови' WHERE `locale` = 'ruRU' AND `entry` = 25246;
-- OLD name : Horde Grunt (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25252
UPDATE `creature_template_locale` SET `Name` = '[Horde Grunt (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25252;
-- OLD name : Alliance Soldier (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25254
UPDATE `creature_template_locale` SET `Name` = '[Alliance Soldier (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25254;
-- OLD name : Scourge Soldier (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25255
UPDATE `creature_template_locale` SET `Name` = '[Scourge Soldier (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25255;
-- OLD name : World Inscription Trainer, subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=25263
UPDATE `creature_template_locale` SET `Name` = '[World Inscription Trainer]',`Title` = '[Inscription Trainer]' WHERE `locale` = 'ruRU' AND `entry` = 25263;
-- OLD name : Призывник
-- Source : https://www.wowhead.com/wotlk/ru/npc=25266
UPDATE `creature_template_locale` SET `Name` = '[Civilian Recruit]' WHERE `locale` = 'ruRU' AND `entry` = 25266;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=25277
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 25277;
-- OLD name : Штейгер Мортий
-- Source : https://www.wowhead.com/wotlk/ru/npc=25280
UPDATE `creature_template_locale` SET `Name` = 'Штейгер Мортуус' WHERE `locale` = 'ruRU' AND `entry` = 25280;
-- OLD name : Запасной костюм короля Мргла-Мргла
-- Source : https://www.wowhead.com/wotlk/ru/npc=25283
UPDATE `creature_template_locale` SET `Name` = '[King Mrgl-Mrgl''s Spare Suit]' WHERE `locale` = 'ruRU' AND `entry` = 25283;
-- OLD name : Виверна клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=25287
UPDATE `creature_template_locale` SET `Name` = '[Warsong Wyvern]' WHERE `locale` = 'ruRU' AND `entry` = 25287;
-- OLD name : Ай'мон, subname : Спутник То'бора
-- Source : https://www.wowhead.com/wotlk/ru/npc=25290
UPDATE `creature_template_locale` SET `Name` = '[Ay''mon]',`Title` = '[To''bor''s Companion]' WHERE `locale` = 'ruRU' AND `entry` = 25290;
-- OLD name : Неруб'арские яйца
-- Source : https://www.wowhead.com/wotlk/ru/npc=25293
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Egg Sac]' WHERE `locale` = 'ruRU' AND `entry` = 25293;
-- OLD name : Неруб'арская личинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25296
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Larva]' WHERE `locale` = 'ruRU' AND `entry` = 25296;
-- OLD name : Деревянный манекен
-- Source : https://www.wowhead.com/wotlk/ru/npc=25297
UPDATE `creature_template_locale` SET `Name` = 'Тренировочный манекен' WHERE `locale` = 'ruRU' AND `entry` = 25297;
-- OLD name : Ружейник Крепости Отваги
-- Source : https://www.wowhead.com/wotlk/ru/npc=25311
UPDATE `creature_template_locale` SET `Name` = 'Ружейник из крепости Отваги' WHERE `locale` = 'ruRU' AND `entry` = 25311;
-- OLD name : Сел, subname : Реагенты и яды
-- Source : https://www.wowhead.com/wotlk/ru/npc=25312
UPDATE `creature_template_locale` SET `Name` = '[Cel]',`Title` = '[Reagent and Poison Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 25312;
-- OLD name : Craig Steele, subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/ru/npc=25323
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25323;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25323, 'ruRU','Крейг Стииле','Программер');
-- OLD name : Обжора Трупомол
-- Source : https://www.wowhead.com/wotlk/ru/npc=25329
UPDATE `creature_template_locale` SET `Name` = 'Крушитель Грек''лор' WHERE `locale` = 'ruRU' AND `entry` = 25329;
-- OLD name : Неруб'арское чудище
-- Source : https://www.wowhead.com/wotlk/ru/npc=25330
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Behemoth]' WHERE `locale` = 'ruRU' AND `entry` = 25330;
-- OLD name : Неруб'арский разрушитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=25331
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Destroyer]' WHERE `locale` = 'ruRU' AND `entry` = 25331;
-- OLD name : Шитый ужас клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=25332
UPDATE `creature_template_locale` SET `Name` = 'Лоскутный ужас клана Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 25332;
-- OLD name : Рубака Десница Гнева
-- Source : https://www.wowhead.com/wotlk/ru/npc=25336
UPDATE `creature_template_locale` SET `Name` = 'Рубака Гневная Длань' WHERE `locale` = 'ruRU' AND `entry` = 25336;
-- OLD name : Знаменосец клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=25337
UPDATE `creature_template_locale` SET `Name` = '[Warsong Standard Bearer]' WHERE `locale` = 'ruRU' AND `entry` = 25337;
-- OLD name : Dead Caravan Guard Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25340
UPDATE `creature_template_locale` SET `Name` = '[Dead Caravan Guard Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25340;
-- OLD name : Dead Caravan Worker Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25341
UPDATE `creature_template_locale` SET `Name` = '[Dead Caravan Worker Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25341;
-- OLD name : Властитель Плети
-- Source : https://www.wowhead.com/wotlk/ru/npc=25352
UPDATE `creature_template_locale` SET `Name` = '[Scourge Overlord]' WHERE `locale` = 'ruRU' AND `entry` = 25352;
-- OLD name : Боевой маг Анзим
-- Source : https://www.wowhead.com/wotlk/ru/npc=25356
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Анзим' WHERE `locale` = 'ruRU' AND `entry` = 25356;
-- OLD name : Кабалист из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25363
UPDATE `creature_template_locale` SET `Name` = 'Кабалист Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25363;
-- OLD name : (PH) Dreadweave Spinner
-- Source : https://www.wowhead.com/wotlk/ru/npc=25365
UPDATE `creature_template_locale` SET `Name` = '[(PH) Dreadweave Spinner]' WHERE `locale` = 'ruRU' AND `entry` = 25365;
-- OLD name : (PH) DEPRECATED
-- Source : https://www.wowhead.com/wotlk/ru/npc=25366
UPDATE `creature_template_locale` SET `Name` = '[(PH) DEPRECATED]' WHERE `locale` = 'ruRU' AND `entry` = 25366;
-- OLD name : Верховный маг из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25367
UPDATE `creature_template_locale` SET `Name` = 'Верховный маг Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25367;
-- OLD name : Душегуб из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25368
UPDATE `creature_template_locale` SET `Name` = 'Душегуб Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25368;
-- OLD name : Воздаятель из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25369
UPDATE `creature_template_locale` SET `Name` = 'Воздаятель Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25369;
-- OLD name : Жрец заката из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25370
UPDATE `creature_template_locale` SET `Name` = 'Жрец заката Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25370;
-- OLD name : Жрец восхода из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25371
UPDATE `creature_template_locale` SET `Name` = 'Жрец восхода Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25371;
-- OLD name : Разведчик из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25372
UPDATE `creature_template_locale` SET `Name` = 'Разведчик Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25372;
-- OLD name : Душеплет из клана Темного Меча
-- Source : https://www.wowhead.com/wotlk/ru/npc=25373
UPDATE `creature_template_locale` SET `Name` = 'Стражница душ из клана Темного Меча' WHERE `locale` = 'ruRU' AND `entry` = 25373;
-- OLD name : Гигантский скарабей
-- Source : https://www.wowhead.com/wotlk/ru/npc=25375
UPDATE `creature_template_locale` SET `Name` = '[Giant Scarab]' WHERE `locale` = 'ruRU' AND `entry` = 25375;
-- OLD name : En'kilah Hatchling (1)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25388
UPDATE `creature_template_locale` SET `Name` = '[En''kilah Hatchling (1)]' WHERE `locale` = 'ruRU' AND `entry` = 25388;
-- OLD name : En'kilah Hatchling (2)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25389
UPDATE `creature_template_locale` SET `Name` = '[En''kilah Hatchling (2)]' WHERE `locale` = 'ruRU' AND `entry` = 25389;
-- OLD name : Старейшина Яконе
-- Source : https://www.wowhead.com/wotlk/ru/npc=25400
UPDATE `creature_template_locale` SET `Name` = '[Elder Yakone]' WHERE `locale` = 'ruRU' AND `entry` = 25400;
-- OLD name : Craig Steele2, subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/ru/npc=25406
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25406;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25406, 'ruRU','Крейг Стииле2','Программер');
-- OLD name : Craig Steele3, subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/ru/npc=25411
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25411;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25411, 'ruRU','Крейг Стииле3','Программер');
-- OLD subname : Сын Нока
-- Source : https://www.wowhead.com/wotlk/ru/npc=25426
UPDATE `creature_template_locale` SET `Title` = 'Сын Норка' WHERE `locale` = 'ruRU' AND `entry` = 25426;
-- OLD name : Старый дух клыкарра
-- Source : https://www.wowhead.com/wotlk/ru/npc=25436
UPDATE `creature_template_locale` SET `Name` = '[Elder Tuskarr Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 25436;
-- OLD name : Магмотский тотем огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=25444
UPDATE `creature_template_locale` SET `Name` = 'Тотем огня магмота' WHERE `locale` = 'ruRU' AND `entry` = 25444;
-- OLD name : Волк клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=25447
UPDATE `creature_template_locale` SET `Name` = '[Warsong Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 25447;
-- OLD name : Чудесный ковер-самолет
-- Source : https://www.wowhead.com/wotlk/ru/npc=25460
UPDATE `creature_template_locale` SET `Name` = 'Великолепный ковер-самолет' WHERE `locale` = 'ruRU' AND `entry` = 25460;
-- OLD name : Солдат Ледяных Пустошей
-- Source : https://www.wowhead.com/wotlk/ru/npc=25463
UPDATE `creature_template_locale` SET `Name` = '[Soldier of the Frozen Wastes]' WHERE `locale` = 'ruRU' AND `entry` = 25463;
-- OLD name : Отряд Плети Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=25495
UPDATE `creature_template_locale` SET `Name` = '[Scourge Proxy Unit]' WHERE `locale` = 'ruRU' AND `entry` = 25495;
-- OLD name : Орабус Кормчий
-- Source : https://www.wowhead.com/wotlk/ru/npc=25497
UPDATE `creature_template_locale` SET `Name` = '[Orabus the Helmsman]' WHERE `locale` = 'ruRU' AND `entry` = 25497;
-- OLD name : Hah... You're Not So Big Now! Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=25505
UPDATE `creature_template_locale` SET `Name` = '[Hah... You''re Not So Big Now! Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 25505;
-- OLD name : Заступник клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25507
UPDATE `creature_template_locale` SET `Name` = 'Заступник Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25507;
-- OLD name : Калеб, subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=25519
UPDATE `creature_template_locale` SET `Name` = '[Caleb]',`Title` = '[Stable Master]' WHERE `locale` = 'ruRU' AND `entry` = 25519;
-- OLD name : Порабощенная жрица из клана Терзающего Бича
-- Source : https://www.wowhead.com/wotlk/ru/npc=25524
UPDATE `creature_template_locale` SET `Name` = '[Enslaved Riplash Priestess]' WHERE `locale` = 'ruRU' AND `entry` = 25524;
-- OLD name : Orabus Spell Trigger
-- Source : https://www.wowhead.com/wotlk/ru/npc=25525
UPDATE `creature_template_locale` SET `Name` = '[Orabus Spell Trigger]' WHERE `locale` = 'ruRU' AND `entry` = 25525;
-- OLD name : Naked Caravan Guard - Orc Male Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25526
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Guard - Orc Male Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25526;
-- OLD name : Naked Caravan Guard - Forsaken Male Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25527
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Guard - Forsaken Male Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25527;
-- OLD name : Naked Caravan Guard - Orc Female Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25528
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Guard - Orc Female Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25528;
-- OLD name : Naked Caravan Guard - Tauren Male Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25529
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Guard - Tauren Male Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25529;
-- OLD name : Naked Caravan Worker - Orc Male Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25530
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Worker - Orc Male Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25530;
-- OLD name : Naked Caravan Worker - Forsaken Male Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25531
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Worker - Forsaken Male Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25531;
-- OLD name : Naked Caravan Worker - Orc Female Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25532
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Worker - Orc Female Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25532;
-- OLD name : Naked Caravan Worker - Troll Male Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25533
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Worker - Troll Male Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25533;
-- OLD name : Craig's Test Human A
-- Source : https://www.wowhead.com/wotlk/ru/npc=25537
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25537;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25537, 'ruRU','Craig''s Test Human',NULL);
-- OLD name : It Was The Orcs, Honest! Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=25581
UPDATE `creature_template_locale` SET `Name` = '[It Was The Orcs, Honest! Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 25581;
-- OLD name : Мина клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=25583
UPDATE `creature_template_locale` SET `Name` = '[Warsong Land Mine]' WHERE `locale` = 'ruRU' AND `entry` = 25583;
-- OLD name : Warsong Orc Disguise Male Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25586
UPDATE `creature_template_locale` SET `Name` = '[Warsong Orc Disguise Male Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25586;
-- OLD name : Warsong Orc Disguise Female Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=25587
UPDATE `creature_template_locale` SET `Name` = '[Warsong Orc Disguise Female Transform]' WHERE `locale` = 'ruRU' AND `entry` = 25587;
-- OLD name : Бонкер Тумблервольт
-- Source : https://www.wowhead.com/wotlk/ru/npc=25589
UPDATE `creature_template_locale` SET `Name` = 'Бонкер Тумблевольт' WHERE `locale` = 'ruRU' AND `entry` = 25589;
-- OLD name : Скадирский гребец
-- Source : https://www.wowhead.com/wotlk/ru/npc=25612
UPDATE `creature_template_locale` SET `Name` = '[Skadir Oarsman]' WHERE `locale` = 'ruRU' AND `entry` = 25612;
-- OLD name : Скадирская лодка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25614
UPDATE `creature_template_locale` SET `Name` = '[Skadir Boat]' WHERE `locale` = 'ruRU' AND `entry` = 25614;
-- OLD name : Чумной снобольд
-- Source : https://www.wowhead.com/wotlk/ru/npc=25616
UPDATE `creature_template_locale` SET `Name` = '[Plagued Snobold]' WHERE `locale` = 'ruRU' AND `entry` = 25616;
-- OLD name : Stop the Plague Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=25654
UPDATE `creature_template_locale` SET `Name` = '[Stop the Plague Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 25654;
-- OLD name : Корабль Кормчего
-- Source : https://www.wowhead.com/wotlk/ru/npc=25656
UPDATE `creature_template_locale` SET `Name` = '[The Helmsman''s Ship]' WHERE `locale` = 'ruRU' AND `entry` = 25656;
-- OLD name : Квалдир-матрос
-- Source : https://www.wowhead.com/wotlk/ru/npc=25659
UPDATE `creature_template_locale` SET `Name` = '[Kvaldir Crewman]' WHERE `locale` = 'ruRU' AND `entry` = 25659;
-- OLD name : Чумной карибу
-- Source : https://www.wowhead.com/wotlk/ru/npc=25667
UPDATE `creature_template_locale` SET `Name` = '[Plagued Caribou]' WHERE `locale` = 'ruRU' AND `entry` = 25667;
-- OLD name : Верховой мамонт
-- Source : https://www.wowhead.com/wotlk/ru/npc=25673
UPDATE `creature_template_locale` SET `Name` = '[Mammoth Mount]' WHERE `locale` = 'ruRU' AND `entry` = 25673;
-- OLD name : Таунка-объездчик мамонтов
-- Source : https://www.wowhead.com/wotlk/ru/npc=25674
UPDATE `creature_template_locale` SET `Name` = '[Taunka Mammoth-rider]' WHERE `locale` = 'ruRU' AND `entry` = 25674;
-- OLD name : Грозовая туча
-- Source : https://www.wowhead.com/wotlk/ru/npc=25676
UPDATE `creature_template_locale` SET `Name` = '[Storm Cloud]' WHERE `locale` = 'ruRU' AND `entry` = 25676;
-- OLD name : Уцелевший безумный клыкарр
-- Source : https://www.wowhead.com/wotlk/ru/npc=25681
UPDATE `creature_template_locale` SET `Name` = '[Maddened Tuskarr Survivor]' WHERE `locale` = 'ruRU' AND `entry` = 25681;
-- OLD name : Gorloc Oracle Yellow (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25688
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Yellow (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25688;
-- OLD name : Gorloc Oracle Pink (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25689
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Pink (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25689;
-- OLD name : Gorloc Oracle Red (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25690
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Red (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25690;
-- OLD name : Gorloc Oracle Green (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25691
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Green (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25691;
-- OLD name : Gorloc Oracle Charcoal (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25692
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Charcoal (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25692;
-- OLD name : Gorloc Oracle Light Blue (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25693
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Light Blue (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25693;
-- OLD name : Gorloc Oracle Blue (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25694
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Blue (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25694;
-- OLD name : Red Drake (Speed Mount)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25695
UPDATE `creature_template_locale` SET `Name` = 'Красный дракон' WHERE `locale` = 'ruRU' AND `entry` = 25695;
-- OLD name : Kodo Saved Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=25698
UPDATE `creature_template_locale` SET `Name` = '[Kodo Saved Credit]' WHERE `locale` = 'ruRU' AND `entry` = 25698;
-- OLD name : Жаркий сполох
-- Source : https://www.wowhead.com/wotlk/ru/npc=25706
UPDATE `creature_template_locale` SET `Name` = 'Сполох' WHERE `locale` = 'ruRU' AND `entry` = 25706;
-- OLD name : Чароплет Хладарры
-- Source : https://www.wowhead.com/wotlk/ru/npc=25719
UPDATE `creature_template_locale` SET `Name` = 'Чародей Хладарры' WHERE `locale` = 'ruRU' AND `entry` = 25719;
-- OLD name : Чаровяз Хладарры
-- Source : https://www.wowhead.com/wotlk/ru/npc=25722
UPDATE `creature_template_locale` SET `Name` = 'Чароплет Хладарры' WHERE `locale` = 'ruRU' AND `entry` = 25722;
-- OLD name : Боевой маг Моран
-- Source : https://www.wowhead.com/wotlk/ru/npc=25727
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Моран' WHERE `locale` = 'ruRU' AND `entry` = 25727;
-- OLD name : Боевой маг Престон
-- Source : https://www.wowhead.com/wotlk/ru/npc=25732
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Престон' WHERE `locale` = 'ruRU' AND `entry` = 25732;
-- OLD name : Боевой маг Остин
-- Source : https://www.wowhead.com/wotlk/ru/npc=25733
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Остин' WHERE `locale` = 'ruRU' AND `entry` = 25733;
-- OLD name : Паровая скважина
-- Source : https://www.wowhead.com/wotlk/ru/npc=25739
UPDATE `creature_template_locale` SET `Name` = 'Паровая вентиляция' WHERE `locale` = 'ruRU' AND `entry` = 25739;
-- OLD name : Сбежавший вьючный кодо
-- Source : https://www.wowhead.com/wotlk/ru/npc=25775
UPDATE `creature_template_locale` SET `Name` = '[Refugee Pack Kodo]' WHERE `locale` = 'ruRU' AND `entry` = 25775;
-- OLD name : Жена беженца
-- Source : https://www.wowhead.com/wotlk/ru/npc=25776
UPDATE `creature_template_locale` SET `Name` = '[Refugee Wife]' WHERE `locale` = 'ruRU' AND `entry` = 25776;
-- OLD name : Отец-беженец
-- Source : https://www.wowhead.com/wotlk/ru/npc=25777
UPDATE `creature_template_locale` SET `Name` = '[Refugee Father]' WHERE `locale` = 'ruRU' AND `entry` = 25777;
-- OLD name : Беженец-одиночка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25778
UPDATE `creature_template_locale` SET `Name` = '[Refugee Loner]' WHERE `locale` = 'ruRU' AND `entry` = 25778;
-- OLD name : X-42B
-- Source : https://www.wowhead.com/wotlk/ru/npc=25787
UPDATE `creature_template_locale` SET `Name` = '[X-42B]' WHERE `locale` = 'ruRU' AND `entry` = 25787;
-- OLD name : Прихвостень Эрнестуэя
-- Source : https://www.wowhead.com/wotlk/ru/npc=25805
UPDATE `creature_template_locale` SET `Name` = '[Nesingwary Lackey]' WHERE `locale` = 'ruRU' AND `entry` = 25805;
-- OLD name : (Deprecated) Sunwell FX
-- Source : https://www.wowhead.com/wotlk/ru/npc=25813
UPDATE `creature_template_locale` SET `Name` = '[(Deprecated) Sunwell FX]' WHERE `locale` = 'ruRU' AND `entry` = 25813;
-- OLD name : Механогном со станции Выкрутеня
-- Source : https://www.wowhead.com/wotlk/ru/npc=25814
UPDATE `creature_template_locale` SET `Name` = 'Мехагном со станции Выкрутеня' WHERE `locale` = 'ruRU' AND `entry` = 25814;
-- OLD name : Master and Servant Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=25815
UPDATE `creature_template_locale` SET `Name` = '[Master and Servant Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 25815;
-- OLD name : Перепрограммированный караульный робот 57-K
-- Source : https://www.wowhead.com/wotlk/ru/npc=25823
UPDATE `creature_template_locale` SET `Name` = 'Перепрограммированный часовобот 57-K' WHERE `locale` = 'ruRU' AND `entry` = 25823;
-- OLD name : Дите Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=25824
UPDATE `creature_template_locale` SET `Name` = 'Дитя Бездны' WHERE `locale` = 'ruRU' AND `entry` = 25824;
-- OLD name : Dire Furbolg (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25842
UPDATE `creature_template_locale` SET `Name` = '[Dire Furbolg (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25842;
-- OLD name : Мамонтенок-сирота
-- Source : https://www.wowhead.com/wotlk/ru/npc=25861
UPDATE `creature_template_locale` SET `Name` = 'Мамонтенок-сиротка' WHERE `locale` = 'ruRU' AND `entry` = 25861;
-- OLD name : Многофазовое возмущение
-- Source : https://www.wowhead.com/wotlk/ru/npc=25882
UPDATE `creature_template_locale` SET `Name` = 'Мультифазовое возмущение' WHERE `locale` = 'ruRU' AND `entry` = 25882;
-- OLD name : Страж огня Выжженных земель
-- Source : https://www.wowhead.com/wotlk/ru/npc=25890
UPDATE `creature_template_locale` SET `Name` = 'Стражница огня Выжженных земель' WHERE `locale` = 'ruRU' AND `entry` = 25890;
-- OLD name : Страж огня с Темных берегов
-- Source : https://www.wowhead.com/wotlk/ru/npc=25893
UPDATE `creature_template_locale` SET `Name` = 'Страж огня Темных берегов' WHERE `locale` = 'ruRU' AND `entry` = 25893;
-- OLD name : Страж огня цитадели Адского Пламени
-- Source : https://www.wowhead.com/wotlk/ru/npc=25900
UPDATE `creature_template_locale` SET `Name` = 'Страж огня полуострова Адского Пламени' WHERE `locale` = 'ruRU' AND `entry` = 25900;
-- OLD name : Хилсбрадский страж огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=25901
UPDATE `creature_template_locale` SET `Name` = 'Стражница огня Хилсбрада' WHERE `locale` = 'ruRU' AND `entry` = 25901;
-- OLD name : Страж огня Долины Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=25905
UPDATE `creature_template_locale` SET `Name` = 'Страж огня долины Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 25905;
-- OLD name : Страж огня леса Тероккар
-- Source : https://www.wowhead.com/wotlk/ru/npc=25907
UPDATE `creature_template_locale` SET `Name` = 'Стражница огня леса Тероккар' WHERE `locale` = 'ruRU' AND `entry` = 25907;
-- OLD name : Страж огня Западных Чумных земель
-- Source : https://www.wowhead.com/wotlk/ru/npc=25909
UPDATE `creature_template_locale` SET `Name` = 'Стражница огня Западных Чумных земель' WHERE `locale` = 'ruRU' AND `entry` = 25909;
-- OLD name : Страж огня Западного Края
-- Source : https://www.wowhead.com/wotlk/ru/npc=25910
UPDATE `creature_template_locale` SET `Name` = 'Страж огня Западного края' WHERE `locale` = 'ruRU' AND `entry` = 25910;
-- OLD name : Страж огня Болотины
-- Source : https://www.wowhead.com/wotlk/ru/npc=25911
UPDATE `creature_template_locale` SET `Name` = 'Стражница огня Болотины' WHERE `locale` = 'ruRU' AND `entry` = 25911;
-- OLD name : Хранитель огня Силитус
-- Source : https://www.wowhead.com/wotlk/ru/npc=25919
UPDATE `creature_template_locale` SET `Name` = 'Хранитель огня Силитуса' WHERE `locale` = 'ruRU' AND `entry` = 25919;
-- OLD name : Хранитель огня Лесов Вечной Песни
-- Source : https://www.wowhead.com/wotlk/ru/npc=25931
UPDATE `creature_template_locale` SET `Name` = 'Хранитель огня лесов Вечной Песни' WHERE `locale` = 'ruRU' AND `entry` = 25931;
-- OLD name : Хранитель огня цитадели Адского Пламени
-- Source : https://www.wowhead.com/wotlk/ru/npc=25934
UPDATE `creature_template_locale` SET `Name` = 'Хранитель огня полуострова Адского Пламени' WHERE `locale` = 'ruRU' AND `entry` = 25934;
-- OLD name : Хранитель огня Долины Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=25938
UPDATE `creature_template_locale` SET `Name` = 'Хранитель огня долины Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 25938;
-- OLD name : Хранитель огня Серебряный бор
-- Source : https://www.wowhead.com/wotlk/ru/npc=25939
UPDATE `creature_template_locale` SET `Name` = 'Хранитель огня Серебряного бора' WHERE `locale` = 'ruRU' AND `entry` = 25939;
-- OLD name : Хранитель огня Леса Тероккар
-- Source : https://www.wowhead.com/wotlk/ru/npc=25942
UPDATE `creature_template_locale` SET `Name` = 'Хранитель огня леса Тероккар' WHERE `locale` = 'ruRU' AND `entry` = 25942;
-- OLD name : Хранитель огня Северных Степей
-- Source : https://www.wowhead.com/wotlk/ru/npc=25943
UPDATE `creature_template_locale` SET `Name` = 'Хранитель огня Степей' WHERE `locale` = 'ruRU' AND `entry` = 25943;
-- OLD name : Хранитель огня Тирисфаля
-- Source : https://www.wowhead.com/wotlk/ru/npc=25946
UPDATE `creature_template_locale` SET `Name` = 'Хранитель огня Тирисфальских лесов' WHERE `locale` = 'ruRU' AND `entry` = 25946;
-- OLD name : Arctic Condor (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25963
UPDATE `creature_template_locale` SET `Name` = '[Arctic Condor (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 25963;
-- OLD name : Обращенный сборщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=25993
UPDATE `creature_template_locale` SET `Name` = '[Converted Collector]' WHERE `locale` = 'ruRU' AND `entry` = 25993;
-- OLD name : Craig's Test Human B
-- Source : https://www.wowhead.com/wotlk/ru/npc=26080
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26080;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26080, 'ruRU','[Craig''s Test Human B]',NULL);
-- OLD name : Weakness to Lightning Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=26082
UPDATE `creature_template_locale` SET `Name` = '[Weakness to Lightning Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 26082;
-- OLD name : Сфера телепортации
-- Source : https://www.wowhead.com/wotlk/ru/npc=26086
UPDATE `creature_template_locale` SET `Name` = '[Transport Orb]' WHERE `locale` = 'ruRU' AND `entry` = 26086;
-- OLD name : Красный дракон-курьер
-- Source : https://www.wowhead.com/wotlk/ru/npc=26088
UPDATE `creature_template_locale` SET `Name` = '[Red Drake Courier]' WHERE `locale` = 'ruRU' AND `entry` = 26088;
-- OLD name : Ore Cart (1)
-- Source : https://www.wowhead.com/wotlk/ru/npc=26099
UPDATE `creature_template_locale` SET `Name` = '[Ore Cart (1)]' WHERE `locale` = 'ruRU' AND `entry` = 26099;
-- OLD name : Отдыхающий боевой страж
-- Source : https://www.wowhead.com/wotlk/ru/npc=26109
UPDATE `creature_template_locale` SET `Name` = 'Свободный боевой страж' WHERE `locale` = 'ruRU' AND `entry` = 26109;
-- OLD name : Plagued Grain Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=26114
UPDATE `creature_template_locale` SET `Name` = '[Plagued Grain Credit]' WHERE `locale` = 'ruRU' AND `entry` = 26114;
-- OLD name : Warsong Worg (Taxi)
-- Source : https://www.wowhead.com/wotlk/ru/npc=26128
UPDATE `creature_template_locale` SET `Name` = '[Warsong Worg (Taxi)]' WHERE `locale` = 'ruRU' AND `entry` = 26128;
-- OLD name : Quest InvisMan - Buying Time - Effect Caster
-- Source : https://www.wowhead.com/wotlk/ru/npc=26129
UPDATE `creature_template_locale` SET `Name` = '[Quest InvisMan - Buying Time - Effect Caster]' WHERE `locale` = 'ruRU' AND `entry` = 26129;
-- OLD name : Quest InvisMan - Buying Time - Effect Target
-- Source : https://www.wowhead.com/wotlk/ru/npc=26130
UPDATE `creature_template_locale` SET `Name` = '[Quest InvisMan - Buying Time - Effect Target]' WHERE `locale` = 'ruRU' AND `entry` = 26130;
-- OLD name : Храбрец Таунка'ле
-- Source : https://www.wowhead.com/wotlk/ru/npc=26157
UPDATE `creature_template_locale` SET `Name` = 'Храбрец таунка''ле' WHERE `locale` = 'ruRU' AND `entry` = 26157;
-- OLD name : Кодо из каравана Таунка'ле
-- Source : https://www.wowhead.com/wotlk/ru/npc=26160
UPDATE `creature_template_locale` SET `Name` = 'Кодо из каравана таунка''ле' WHERE `locale` = 'ruRU' AND `entry` = 26160;
-- OLD name : Ракета Пустоты X-51
-- Source : https://www.wowhead.com/wotlk/ru/npc=26192
UPDATE `creature_template_locale` SET `Name` = 'Ракета Пустоты Х-51' WHERE `locale` = 'ruRU' AND `entry` = 26192;
-- OLD name : Nexus 70 - Buying Time - Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=26193
UPDATE `creature_template_locale` SET `Name` = '[Nexus 70 - Buying Time - Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 26193;
-- OLD subname : Вождь Калу'ак с Драконьего Погоста
-- Source : https://www.wowhead.com/wotlk/ru/npc=26194
UPDATE `creature_template_locale` SET `Title` = 'Вождь Калу''ак c Драконьего Погоста' WHERE `locale` = 'ruRU' AND `entry` = 26194;
-- OLD name : Боевая единица из Эн'кила
-- Source : https://www.wowhead.com/wotlk/ru/npc=26195
UPDATE `creature_template_locale` SET `Name` = '[En''kilah Unit]' WHERE `locale` = 'ruRU' AND `entry` = 26195;
-- OLD name : Воин Моа'ки
-- Source : https://www.wowhead.com/wotlk/ru/npc=26220
UPDATE `creature_template_locale` SET `Name` = '[Moa''ki Warrior]' WHERE `locale` = 'ruRU' AND `entry` = 26220;
-- OLD name : Утонувший страж
-- Source : https://www.wowhead.com/wotlk/ru/npc=26224
UPDATE `creature_template_locale` SET `Name` = 'Страж-утопленник' WHERE `locale` = 'ruRU' AND `entry` = 26224;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26226
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 26226;
-- OLD name : Slay Loguhn Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=26227
UPDATE `creature_template_locale` SET `Name` = '[Slay Loguhn Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 26227;
-- OLD subname : Повелительница рыцарей крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=26247
UPDATE `creature_template_locale` SET `Title` = 'Матриарх рыцарей крови' WHERE `locale` = 'ruRU' AND `entry` = 26247;
-- OLD name : Farshire Bell Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=26256
UPDATE `creature_template_locale` SET `Name` = '[Farshire Bell Credit]' WHERE `locale` = 'ruRU' AND `entry` = 26256;
-- OLD name : Верховой красный дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=26263
UPDATE `creature_template_locale` SET `Name` = '[Red Dragon Mount]' WHERE `locale` = 'ruRU' AND `entry` = 26263;
-- OLD name : Пико, subname : Торговец кожами
-- Source : https://www.wowhead.com/wotlk/ru/npc=26269
UPDATE `creature_template_locale` SET `Name` = '[Pico]',`Title` = '[Leather Trader]' WHERE `locale` = 'ruRU' AND `entry` = 26269;
-- OLD name : Красный дракон Драконьего Погоста
-- Source : https://www.wowhead.com/wotlk/ru/npc=26279
UPDATE `creature_template_locale` SET `Name` = '[Dragonblight Red Dragon]' WHERE `locale` = 'ruRU' AND `entry` = 26279;
-- OLD name : Змей затаившегося пламени
-- Source : https://www.wowhead.com/wotlk/ru/npc=26286
UPDATE `creature_template_locale` SET `Name` = 'Тлеющий змей' WHERE `locale` = 'ruRU' AND `entry` = 26286;
-- OLD name : Forgotten Shore Event Trigger (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26288;
-- OLD name : Тканевые доспехи
-- Source : https://www.wowhead.com/wotlk/ru/npc=26301
UPDATE `creature_template_locale` SET `Name` = 'Продавец тканевых и кожаных доспехов' WHERE `locale` = 'ruRU' AND `entry` = 26301;
-- OLD name : Латные доспехи
-- Source : https://www.wowhead.com/wotlk/ru/npc=26305
UPDATE `creature_template_locale` SET `Name` = 'Продавец кольчужных доспехов и лат' WHERE `locale` = 'ruRU' AND `entry` = 26305;
-- OLD name : Кожаные доспехи
-- Source : https://www.wowhead.com/wotlk/ru/npc=26306
UPDATE `creature_template_locale` SET `Name` = 'Продавец кольчужных доспехов' WHERE `locale` = 'ruRU' AND `entry` = 26306;
-- OLD name : Кольчужные доспехи
-- Source : https://www.wowhead.com/wotlk/ru/npc=26308
UPDATE `creature_template_locale` SET `Name` = 'Продавец лат' WHERE `locale` = 'ruRU' AND `entry` = 26308;
-- OLD name : Волшебный змейчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=26322
UPDATE `creature_template_locale` SET `Name` = 'Волшебный змей' WHERE `locale` = 'ruRU' AND `entry` = 26322;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26361
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 26361;
-- OLD name : Геодезист из Лиги исследователей, subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26362
UPDATE `creature_template_locale` SET `Name` = 'Геодезист из Лиги Исследователей',`Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 26362;
-- OLD name : (PH) Wildlife Test Doe
-- Source : https://www.wowhead.com/wotlk/ru/npc=26364
UPDATE `creature_template_locale` SET `Name` = '[(PH) Wildlife Test Doe]' WHERE `locale` = 'ruRU' AND `entry` = 26364;
-- OLD name : (PH) Wildlife Test Bear
-- Source : https://www.wowhead.com/wotlk/ru/npc=26368
UPDATE `creature_template_locale` SET `Name` = '[(PH) Wildlife Test Bear]' WHERE `locale` = 'ruRU' AND `entry` = 26368;
-- OLD name : (PH) Grizzly Test Low Aggro Worg
-- Source : https://www.wowhead.com/wotlk/ru/npc=26372
UPDATE `creature_template_locale` SET `Name` = '[(PH) Grizzly Test Low Aggro Worg]' WHERE `locale` = 'ruRU' AND `entry` = 26372;
-- OLD name : Test - Brutallus Craig
-- Source : https://www.wowhead.com/wotlk/ru/npc=26376
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26376;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26376, 'ruRU','[Test - Brutallus Craig]',NULL);
-- OLD name : Иви Медипрыг, subname : Продавец экипировки арены (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26378;
-- OLD name : Гриккин Медипрыг, subname : Продавец экипировки арены (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26383;
-- OLD name : Фрикси Меднотумблер, subname : Продавец экипировки арены (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26384;
-- OLD name : Преображенный зверолов-самец
-- Source : https://www.wowhead.com/wotlk/ru/npc=26390
UPDATE `creature_template_locale` SET `Name` = '[Transformed Trapper Male]' WHERE `locale` = 'ruRU' AND `entry` = 26390;
-- OLD name : Черный тяжеловоз-скелет
-- Source : https://www.wowhead.com/wotlk/ru/npc=26404
UPDATE `creature_template_locale` SET `Name` = '[Black Skeletal Warhorse]' WHERE `locale` = 'ruRU' AND `entry` = 26404;
-- OLD name : (PH) Wildlife Test Worg
-- Source : https://www.wowhead.com/wotlk/ru/npc=26412
UPDATE `creature_template_locale` SET `Name` = '[(PH) Wildlife Test Worg]' WHERE `locale` = 'ruRU' AND `entry` = 26412;
-- OLD name : Transformed Trapper Visual
-- Source : https://www.wowhead.com/wotlk/ru/npc=26427
UPDATE `creature_template_locale` SET `Name` = '[Transformed Trapper Visual]' WHERE `locale` = 'ruRU' AND `entry` = 26427;
-- OLD name : Бадд
-- Source : https://www.wowhead.com/wotlk/ru/npc=26429
UPDATE `creature_template_locale` SET `Name` = '[Budd]' WHERE `locale` = 'ruRU' AND `entry` = 26429;
-- OLD name : Пассажирское сиденье Дукала
-- Source : https://www.wowhead.com/wotlk/ru/npc=26430
UPDATE `creature_template_locale` SET `Name` = '[Ducal''s Passenger Seat]' WHERE `locale` = 'ruRU' AND `entry` = 26430;
-- OLD name : Беженец из Таунка'ле
-- Source : https://www.wowhead.com/wotlk/ru/npc=26432
UPDATE `creature_template_locale` SET `Name` = '[Taunka''le Refugee]' WHERE `locale` = 'ruRU' AND `entry` = 26432;
-- OLD name : Беженец из Таунка'ле
-- Source : https://www.wowhead.com/wotlk/ru/npc=26433
UPDATE `creature_template_locale` SET `Name` = '[Taunka''le Refugee]' WHERE `locale` = 'ruRU' AND `entry` = 26433;
-- OLD name : Рак'ла Путешественник, subname : Игрок
-- Source : https://www.wowhead.com/wotlk/ru/npc=26442
UPDATE `creature_template_locale` SET `Name` = '[Rak''la the Traveler]',`Title` = '[Gambler]' WHERE `locale` = 'ruRU' AND `entry` = 26442;
-- OLD name : Quest Invisman - Filling the Cages
-- Source : https://www.wowhead.com/wotlk/ru/npc=26444
UPDATE `creature_template_locale` SET `Name` = '[Quest Invisman - Filling the Cages]' WHERE `locale` = 'ruRU' AND `entry` = 26444;
-- OLD name : Рунический диск
-- Source : https://www.wowhead.com/wotlk/ru/npc=26445
UPDATE `creature_template_locale` SET `Name` = '[Rune Plate]' WHERE `locale` = 'ruRU' AND `entry` = 26445;
-- OLD name : Льдистый змей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26446
UPDATE `creature_template_locale` SET `Name` = 'Ледяной змей' WHERE `locale` = 'ruRU' AND `entry` = 26446;
-- OLD name : (PH) Duskhowl Stalker
-- Source : https://www.wowhead.com/wotlk/ru/npc=26454
UPDATE `creature_template_locale` SET `Name` = '[(PH) Duskhowl Stalker]' WHERE `locale` = 'ruRU' AND `entry` = 26454;
-- OLD name : Вестник смерти Лорн
-- Source : https://www.wowhead.com/wotlk/ru/npc=26460
UPDATE `creature_template_locale` SET `Name` = '[Lorn Deathspeaker]' WHERE `locale` = 'ruRU' AND `entry` = 26460;
-- OLD name : Test Gryphon
-- Source : https://www.wowhead.com/wotlk/ru/npc=26462
UPDATE `creature_template_locale` SET `Name` = '[Test Gryphon]' WHERE `locale` = 'ruRU' AND `entry` = 26462;
-- OLD name : Проекция верховного мага Этаса Похитителя Солнца
-- Source : https://www.wowhead.com/wotlk/ru/npc=26471
UPDATE `creature_template_locale` SET `Name` = 'Проекция Этаса Похитителя Солнца' WHERE `locale` = 'ruRU' AND `entry` = 26471;
-- OLD name : Dead Mage Hunter Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=26476
UPDATE `creature_template_locale` SET `Name` = '[Dead Mage Hunter Transform]' WHERE `locale` = 'ruRU' AND `entry` = 26476;
-- OLD name : Ордынский воин, subname : Дети Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=26486
UPDATE `creature_template_locale` SET `Name` = '[Horde Warrior]',`Title` = '[Sons of Warsong]' WHERE `locale` = 'ruRU' AND `entry` = 26486;
-- OLD name : Солдат Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=26487
UPDATE `creature_template_locale` SET `Name` = '[Alliance Soldier]' WHERE `locale` = 'ruRU' AND `entry` = 26487;
-- OLD name : Test Catapult
-- Source : https://www.wowhead.com/wotlk/ru/npc=26495
UPDATE `creature_template_locale` SET `Name` = '[Test Catapult]' WHERE `locale` = 'ruRU' AND `entry` = 26495;
-- OLD name : Отрекшийся-призыватель гнили
-- Source : https://www.wowhead.com/wotlk/ru/npc=26508
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Blightcaller]' WHERE `locale` = 'ruRU' AND `entry` = 26508;
-- OLD subname : "Тот, что играет с едой"
-- Source : https://www.wowhead.com/wotlk/ru/npc=26510
UPDATE `creature_template_locale` SET `Title` = '"Тот, кто играет с едой"' WHERE `locale` = 'ruRU' AND `entry` = 26510;
-- OLD name : Некромант-падальщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=26512
UPDATE `creature_template_locale` SET `Name` = '[Carrion Necromancer]' WHERE `locale` = 'ruRU' AND `entry` = 26512;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26514
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 26514;
-- OLD name : Вурдалак-падальщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=26515
UPDATE `creature_template_locale` SET `Name` = '[Carrion Ghoul]' WHERE `locale` = 'ruRU' AND `entry` = 26515;
-- OLD name : Горгулья-падальщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=26517
UPDATE `creature_template_locale` SET `Name` = '[Carrion Gargoyle]' WHERE `locale` = 'ruRU' AND `entry` = 26517;
-- OLD name : Мерзостное поганище
-- Source : https://www.wowhead.com/wotlk/ru/npc=26518
UPDATE `creature_template_locale` SET `Name` = '[Carrion Abomination]' WHERE `locale` = 'ruRU' AND `entry` = 26518;
-- OLD name : Пехотник Алого Натиска
-- Source : https://www.wowhead.com/wotlk/ru/npc=26524
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Footman]' WHERE `locale` = 'ruRU' AND `entry` = 26524;
-- OLD name : Порабощенный Плетью пехотинец Алого Натиска
-- Source : https://www.wowhead.com/wotlk/ru/npc=26526
UPDATE `creature_template_locale` SET `Name` = '[Scourged Scarlet Footman]' WHERE `locale` = 'ruRU' AND `entry` = 26526;
-- OLD subname : Рыцарь ордена Серебряной Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=26528
UPDATE `creature_template_locale` SET `Title` = 'Рыцарь Серебряной Длани' WHERE `locale` = 'ruRU' AND `entry` = 26528;
-- OLD name : Заб Парострел, subname : Хозяин дирижабля Ревущего фьорда
-- Source : https://www.wowhead.com/wotlk/ru/npc=26541
UPDATE `creature_template_locale` SET `Name` = '[Zab Steambolt]',`Title` = '[Howling Fjord Zeppelin Master]' WHERE `locale` = 'ruRU' AND `entry` = 26541;
-- OLD name : Лини Тягболт, subname : Хозяин дирижабля Борейской тундры
-- Source : https://www.wowhead.com/wotlk/ru/npc=26542
UPDATE `creature_template_locale` SET `Name` = '[Lini Lugbolt]',`Title` = '[Borean Tundra Zeppelin Master]' WHERE `locale` = 'ruRU' AND `entry` = 26542;
-- OLD name : Хансрик Стаут, subname : Начальник порта
-- Source : https://www.wowhead.com/wotlk/ru/npc=26551
UPDATE `creature_template_locale` SET `Name` = '[Hansric Stout]',`Title` = '[Dockmaster]' WHERE `locale` = 'ruRU' AND `entry` = 26551;
-- OLD name : Майя Пайпер, subname : Начальник порта
-- Source : https://www.wowhead.com/wotlk/ru/npc=26552
UPDATE `creature_template_locale` SET `Name` = '[Maye Piper]',`Title` = '[Dockmaster]' WHERE `locale` = 'ruRU' AND `entry` = 26552;
-- OLD subname : Укротитель дракондоров
-- Source : https://www.wowhead.com/wotlk/ru/npc=26560
UPDATE `creature_template_locale` SET `Title` = 'Укротительница дракондоров' WHERE `locale` = 'ruRU' AND `entry` = 26560;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26564
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 26564;
-- OLD name : Запертая обезьянка
-- Source : https://www.wowhead.com/wotlk/ru/npc=26571
UPDATE `creature_template_locale` SET `Name` = '[Imprisoned Monkey]' WHERE `locale` = 'ruRU' AND `entry` = 26571;
-- OLD name : Неупокоенная селянка
-- Source : https://www.wowhead.com/wotlk/ru/npc=26573
UPDATE `creature_template_locale` SET `Name` = '[Lingering Villager]' WHERE `locale` = 'ruRU' AND `entry` = 26573;
-- OLD name : Кролик с Седых холмов
-- Source : https://www.wowhead.com/wotlk/ru/npc=26587
UPDATE `creature_template_locale` SET `Name` = '[Grizzly Hills Rabbit]' WHERE `locale` = 'ruRU' AND `entry` = 26587;
-- OLD name : Spiritual Insight Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=26594
UPDATE `creature_template_locale` SET `Name` = '[Spiritual Insight Transform]' WHERE `locale` = 'ruRU' AND `entry` = 26594;
-- OLD name : Шарлиз Сугроба Из, subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=26596
UPDATE `creature_template_locale` SET `Name` = 'Чарли "Полярыч"',`Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 26596;
-- OLD name : Burninate Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=26612
UPDATE `creature_template_locale` SET `Name` = '[Burninate Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 26612;
-- OLD name : Снегопадный олень
-- Source : https://www.wowhead.com/wotlk/ru/npc=26615
UPDATE `creature_template_locale` SET `Name` = 'Снегопадный лось' WHERE `locale` = 'ruRU' AND `entry` = 26615;
-- OLD name : Рубака Тар'йуг
-- Source : https://www.wowhead.com/wotlk/ru/npc=26617
UPDATE `creature_template_locale` SET `Name` = '[Grunt Tar''yug]' WHERE `locale` = 'ruRU' AND `entry` = 26617;
-- OLD name : Ануб'арская тюрьма
-- Source : https://www.wowhead.com/wotlk/ru/npc=26656
UPDATE `creature_template_locale` SET `Name` = 'Ануб''арский тюремщик' WHERE `locale` = 'ruRU' AND `entry` = 26656;
-- OLD name : Йормунгарское мясо
-- Source : https://www.wowhead.com/wotlk/ru/npc=26699
UPDATE `creature_template_locale` SET `Name` = '[Jormungar Meat]' WHERE `locale` = 'ruRU' AND `entry` = 26699;
-- OLD name : Порабощенный Плетью оракул Драккари
-- Source : https://www.wowhead.com/wotlk/ru/npc=26702
UPDATE `creature_template_locale` SET `Name` = '[Scourged Drakkari Oracle]' WHERE `locale` = 'ruRU' AND `entry` = 26702;
-- OLD name : Порабощенный Плетью наемник Драккари
-- Source : https://www.wowhead.com/wotlk/ru/npc=26703
UPDATE `creature_template_locale` SET `Name` = '[Scourged Drakkari Warmonger]' WHERE `locale` = 'ruRU' AND `entry` = 26703;
-- OLD subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=26709
UPDATE `creature_template_locale` SET `Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 26709;
-- OLD name : Подопытный Драконьего Погоста
-- Source : https://www.wowhead.com/wotlk/ru/npc=26713
UPDATE `creature_template_locale` SET `Name` = '[Dragonblight Test Subject]' WHERE `locale` = 'ruRU' AND `entry` = 26713;
-- OLD name : Капитан Эмми Малин
-- Source : https://www.wowhead.com/wotlk/ru/npc=26762
UPDATE `creature_template_locale` SET `Name` = 'Капитан Эмми Мэлин' WHERE `locale` = 'ruRU' AND `entry` = 26762;
-- OLD subname : Официантка клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=26764
UPDATE `creature_template_locale` SET `Title` = 'Официантка из клана Черного Железа' WHERE `locale` = 'ruRU' AND `entry` = 26764;
-- OLD name : The Focus on the Beach Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=26773
UPDATE `creature_template_locale` SET `Name` = '[The Focus on the Beach Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 26773;
-- OLD name : Dan's Test Dummy
-- Source : https://www.wowhead.com/wotlk/ru/npc=26784
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Dummy]' WHERE `locale` = 'ruRU' AND `entry` = 26784;
-- OLD name : Выносливый гонец Таунка'ле
-- Source : https://www.wowhead.com/wotlk/ru/npc=26790
UPDATE `creature_template_locale` SET `Name` = 'Выносливый гонец таунка''ле' WHERE `locale` = 'ruRU' AND `entry` = 26790;
-- OLD name : Scott Keenan, subname : Thug Life
-- Source : https://www.wowhead.com/wotlk/ru/npc=26791
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26791;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26791, 'ruRU','Скотт Кинан','Вор');
-- OLD name : Преображенный зверолов
-- Source : https://www.wowhead.com/wotlk/ru/npc=26819
UPDATE `creature_template_locale` SET `Name` = '[Tranformed Trapper Female]' WHERE `locale` = 'ruRU' AND `entry` = 26819;
-- OLD subname : Официантка клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=26822
UPDATE `creature_template_locale` SET `Title` = 'Официантка из клана Черного Железа' WHERE `locale` = 'ruRU' AND `entry` = 26822;
-- OLD name : Бесноватый ворген
-- Source : https://www.wowhead.com/wotlk/ru/npc=26829
UPDATE `creature_template_locale` SET `Name` = '[Frenzied Worgen]' WHERE `locale` = 'ruRU' AND `entry` = 26829;
-- OLD name : Atop the Woodlands Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=26831
UPDATE `creature_template_locale` SET `Name` = '[Atop the Woodlands Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 26831;
-- OLD name : Испуганный тяжеловоз
-- Source : https://www.wowhead.com/wotlk/ru/npc=26833
UPDATE `creature_template_locale` SET `Name` = '[Startled Warhorse]' WHERE `locale` = 'ruRU' AND `entry` = 26833;
-- OLD name : Карег, subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=26846
UPDATE `creature_template_locale` SET `Name` = '[Kareg]',`Title` = '[Wind Rider Master]' WHERE `locale` = 'ruRU' AND `entry` = 26846;
-- OLD name : Arctic Grizzly Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=26882
UPDATE `creature_template_locale` SET `Name` = '[Arctic Grizzly Credit]' WHERE `locale` = 'ruRU' AND `entry` = 26882;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26883
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 26883;
-- OLD name : The End of the Line Ley Line Focus Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=26887
UPDATE `creature_template_locale` SET `Name` = '[The End of the Line Ley Line Focus Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 26887;
-- OLD name : Картографер Тобиас
-- Source : https://www.wowhead.com/wotlk/ru/npc=26888
UPDATE `creature_template_locale` SET `Name` = '[Cartographer Tobias]' WHERE `locale` = 'ruRU' AND `entry` = 26888;
-- OLD name : TEST ESCORTEE - LAB
-- Source : https://www.wowhead.com/wotlk/ru/npc=26894
UPDATE `creature_template_locale` SET `Name` = '[TEST ESCORTEE - LAB]' WHERE `locale` = 'ruRU' AND `entry` = 26894;
-- OLD name : Snowfall Elk Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=26895
UPDATE `creature_template_locale` SET `Name` = '[Snowfall Elk Credit]' WHERE `locale` = 'ruRU' AND `entry` = 26895;
-- OLD name : Gnome, Clockwork (Northrend)
-- Source : https://www.wowhead.com/wotlk/ru/npc=26897
UPDATE `creature_template_locale` SET `Name` = '[Gnome, Clockwork (Northrend)]' WHERE `locale` = 'ruRU' AND `entry` = 26897;
-- OLD name : Верховой дракон, красный
-- Source : https://www.wowhead.com/wotlk/ru/npc=26899
UPDATE `creature_template_locale` SET `Name` = '[Riding Drake, Red]' WHERE `locale` = 'ruRU' AND `entry` = 26899;
-- OLD name : Ланолис Капля Росы, subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=26903
UPDATE `creature_template_locale` SET `Name` = 'Ланолис Росинка',`Title` = 'Великий алхимик' WHERE `locale` = 'ruRU' AND `entry` = 26903;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26904
UPDATE `creature_template_locale` SET `Title` = 'Мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 26904;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=26905
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 26905;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=26906
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 26906;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26907
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 26907;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=26909
UPDATE `creature_template_locale` SET `Title` = 'Великий рыбак' WHERE `locale` = 'ruRU' AND `entry` = 26909;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=26910
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер травничества' WHERE `locale` = 'ruRU' AND `entry` = 26910;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=26911
UPDATE `creature_template_locale` SET `Title` = 'Мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 26911;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26912
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер горного дела' WHERE `locale` = 'ruRU' AND `entry` = 26912;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=26913
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 26913;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26914
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 26914;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26915
UPDATE `creature_template_locale` SET `Title` = 'Мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 26915;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=26916
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 26916;
-- OLD name : Warlord Jin'gom Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=26927
UPDATE `creature_template_locale` SET `Name` = '[Warlord Jin''gom Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 26927;
-- OLD name : Скакун Кровопорча
-- Source : https://www.wowhead.com/wotlk/ru/npc=26931
UPDATE `creature_template_locale` SET `Name` = '[Bloodbane''s Mount]' WHERE `locale` = 'ruRU' AND `entry` = 26931;
-- OLD name : Викс Хромовый Запал, subname : Книжный магазин самообслуживания
-- Source : https://www.wowhead.com/wotlk/ru/npc=26947
UPDATE `creature_template_locale` SET `Name` = '[Vix Chromeblaster]',`Title` = '[Self-Help Bookseller]' WHERE `locale` = 'ruRU' AND `entry` = 26947;
-- OLD name : Гадкое страшилище
-- Source : https://www.wowhead.com/wotlk/ru/npc=26948
UPDATE `creature_template_locale` SET `Name` = 'Неповоротливое страшилище' WHERE `locale` = 'ruRU' AND `entry` = 26948;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=26951
UPDATE `creature_template_locale` SET `Title` = 'Великий алхимик' WHERE `locale` = 'ruRU' AND `entry` = 26951;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26952
UPDATE `creature_template_locale` SET `Title` = 'Мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 26952;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=26953
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 26953;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=26954
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 26954;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26955
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 26955;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=26956
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер оказания первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 26956;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=26957
UPDATE `creature_template_locale` SET `Title` = 'Великий рыбак' WHERE `locale` = 'ruRU' AND `entry` = 26957;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=26958
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер травничества' WHERE `locale` = 'ruRU' AND `entry` = 26958;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=26959
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 26959;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26960
UPDATE `creature_template_locale` SET `Title` = 'Мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 26960;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=26961
UPDATE `creature_template_locale` SET `Title` = 'Мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 26961;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26962
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер горного дела' WHERE `locale` = 'ruRU' AND `entry` = 26962;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=26963
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 26963;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26964
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 26964;
-- OLD name : Ледяной дракон-душегуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=26967
UPDATE `creature_template_locale` SET `Name` = '[Frostbrood Slayer]' WHERE `locale` = 'ruRU' AND `entry` = 26967;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26969
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 26969;
-- OLD name : Grand Magus Telestra Critter Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=26970
UPDATE `creature_template_locale` SET `Name` = '[Grand Magus Telestra Critter Transform]' WHERE `locale` = 'ruRU' AND `entry` = 26970;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=26972
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 26972;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=26974
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер травничества' WHERE `locale` = 'ruRU' AND `entry` = 26974;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=26975
UPDATE `creature_template_locale` SET `Title` = 'Великий алхимик' WHERE `locale` = 'ruRU' AND `entry` = 26975;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26976
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер горного дела' WHERE `locale` = 'ruRU' AND `entry` = 26976;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=26977
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 26977;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=26980
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 26980;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26981
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 26981;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26982
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 26982;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=26986
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 26986;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=26987
UPDATE `creature_template_locale` SET `Title` = 'Великий алхимик' WHERE `locale` = 'ruRU' AND `entry` = 26987;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26988
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 26988;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=26989
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 26989;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=26990
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 26990;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26991
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 26991;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=26992
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 26992;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=26993
UPDATE `creature_template_locale` SET `Title` = 'Великий рыбак' WHERE `locale` = 'ruRU' AND `entry` = 26993;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=26994
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер травничества' WHERE `locale` = 'ruRU' AND `entry` = 26994;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=26995
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 26995;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=26996
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 26996;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26997
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 26997;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=26998
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 26998;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26999
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер горного дела' WHERE `locale` = 'ruRU' AND `entry` = 26999;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=27000
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 27000;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=27001
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 27001;
-- OLD name : Ледохват
-- Source : https://www.wowhead.com/wotlk/ru/npc=27004
UPDATE `creature_template_locale` SET `Name` = 'Ледолап' WHERE `locale` = 'ruRU' AND `entry` = 27004;
-- OLD name : Строитель Беззл
-- Source : https://www.wowhead.com/wotlk/ru/npc=27014
UPDATE `creature_template_locale` SET `Name` = '[Builder Bezzle]' WHERE `locale` = 'ruRU' AND `entry` = 27014;
-- OLD name : Строитель Боззл
-- Source : https://www.wowhead.com/wotlk/ru/npc=27015
UPDATE `creature_template_locale` SET `Name` = '[Builder Bozzle]' WHERE `locale` = 'ruRU' AND `entry` = 27015;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=27021
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 27021;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=27023
UPDATE `creature_template_locale` SET `Title` = 'Мастер алхимии' WHERE `locale` = 'ruRU' AND `entry` = 27023;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=27026
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 27026;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=27029
UPDATE `creature_template_locale` SET `Title` = 'Мастер алхимии' WHERE `locale` = 'ruRU' AND `entry` = 27029;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=27034
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 27034;
-- OLD name : Dreadlord - Metamorphosis (Warlock)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27036
UPDATE `creature_template_locale` SET `Name` = '[Dreadlord - Metamorphosis (Warlock)]' WHERE `locale` = 'ruRU' AND `entry` = 27036;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=27043
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 27043;
-- OLD name : Боевой маг Адами
-- Source : https://www.wowhead.com/wotlk/ru/npc=27046
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Адами' WHERE `locale` = 'ruRU' AND `entry` = 27046;
-- OLD name : Заряженный боевой голем
-- Source : https://www.wowhead.com/wotlk/ru/npc=27049
UPDATE `creature_template_locale` SET `Name` = '[Charged War Golem]' WHERE `locale` = 'ruRU' AND `entry` = 27049;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=27057
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 27057;
-- OLD name : Чумной зомби
-- Source : https://www.wowhead.com/wotlk/ru/npc=27059
UPDATE `creature_template_locale` SET `Name` = '[Plague Zombie]' WHERE `locale` = 'ruRU' AND `entry` = 27059;
-- OLD name : Ордынский осадный танк-2
-- Source : https://www.wowhead.com/wotlk/ru/npc=27103
UPDATE `creature_template_locale` SET `Name` = '[Horde Siege Tank 2]' WHERE `locale` = 'ruRU' AND `entry` = 27103;
-- OLD name : Ордынский осадный танк-3
-- Source : https://www.wowhead.com/wotlk/ru/npc=27104
UPDATE `creature_template_locale` SET `Name` = '[Horde Siege Tank 3]' WHERE `locale` = 'ruRU' AND `entry` = 27104;
-- OLD name : Раненый доверенный из клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=27109
UPDATE `creature_template_locale` SET `Name` = '[Injured Warsong Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 27109;
-- OLD name : Blighted Elk Liquid Fire of Elune Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27111
UPDATE `creature_template_locale` SET `Name` = '[Blighted Elk Liquid Fire of Elune Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27111;
-- OLD name : Rabid Grizzly Liquid Fire of Elune Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27112
UPDATE `creature_template_locale` SET `Name` = '[Rabid Grizzly Liquid Fire of Elune Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27112;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=27113
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 27113;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=27114
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 27114;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=27115
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 27115;
-- OLD name : Blackriver Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27121
UPDATE `creature_template_locale` SET `Name` = '[Blackriver Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27121;
-- OLD name : Добытчик-ледохват
-- Source : https://www.wowhead.com/wotlk/ru/npc=27123
UPDATE `creature_template_locale` SET `Name` = 'Добытчик-ледолап' WHERE `locale` = 'ruRU' AND `entry` = 27123;
-- OLD name : Hippogryph Taxi (Dragonblight)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27127
UPDATE `creature_template_locale` SET `Name` = '[Hippogryph Taxi (Dragonblight)]' WHERE `locale` = 'ruRU' AND `entry` = 27127;
-- OLD subname : Товары для алхимиков
-- Source : https://www.wowhead.com/wotlk/ru/npc=27140
UPDATE `creature_template_locale` SET `Title` = 'Товары для алхимика' WHERE `locale` = 'ruRU' AND `entry` = 27140;
-- OLD name : Скакун Всадника без головы
-- Source : https://www.wowhead.com/wotlk/ru/npc=27152
UPDATE `creature_template_locale` SET `Name` = 'Конь Всадника без головы, игрок, в полете' WHERE `locale` = 'ruRU' AND `entry` = 27152;
-- OLD name : Test Faction NPC
-- Source : https://www.wowhead.com/wotlk/ru/npc=27154
UPDATE `creature_template_locale` SET `Name` = '[Test Faction NPC]' WHERE `locale` = 'ruRU' AND `entry` = 27154;
-- OLD name : Копейщик Камагуа
-- Source : https://www.wowhead.com/wotlk/ru/npc=27167
UPDATE `creature_template_locale` SET `Name` = 'Копейшик Камагуа' WHERE `locale` = 'ruRU' AND `entry` = 27167;
-- OLD name : 7th Legion Test Unit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27168
UPDATE `creature_template_locale` SET `Name` = '[7th Legion Test Unit]' WHERE `locale` = 'ruRU' AND `entry` = 27168;
-- OLD name : Боевой маг Янтарной гряды
-- Source : https://www.wowhead.com/wotlk/ru/npc=27170
UPDATE `creature_template_locale` SET `Name` = '[Amber Ledge Warmage]' WHERE `locale` = 'ruRU' AND `entry` = 27170;
-- OLD name : Боевой маг Каландра
-- Source : https://www.wowhead.com/wotlk/ru/npc=27173
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Каландра' WHERE `locale` = 'ruRU' AND `entry` = 27173;
-- OLD name : Дежурная летучая мышь (ревущий фьорд)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27179
UPDATE `creature_template_locale` SET `Name` = '[Bat Taxi (Howling Fjord)]' WHERE `locale` = 'ruRU' AND `entry` = 27179;
-- OLD subname : Раб
-- Source : https://www.wowhead.com/wotlk/ru/npc=27191
UPDATE `creature_template_locale` SET `Title` = 'Гном-раб' WHERE `locale` = 'ruRU' AND `entry` = 27191;
-- OLD name : Броут, subname : Раб
-- Source : https://www.wowhead.com/wotlk/ru/npc=27198
UPDATE `creature_template_locale` SET `Name` = 'Брот',`Title` = 'Гном-раб' WHERE `locale` = 'ruRU' AND `entry` = 27198;
-- OLD name : Истязатель Лекрафт
-- Source : https://www.wowhead.com/wotlk/ru/npc=27209
UPDATE `creature_template_locale` SET `Name` = 'Истязатель Альфонс' WHERE `locale` = 'ruRU' AND `entry` = 27209;
-- OLD name : Лошадь Алого Натиска
-- Source : https://www.wowhead.com/wotlk/ru/npc=27214
UPDATE `creature_template_locale` SET `Name` = '[Onslaught Horse]' WHERE `locale` = 'ruRU' AND `entry` = 27214;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=27227
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 27227;
-- OLD name : Йормунгарский червь
-- Source : https://www.wowhead.com/wotlk/ru/npc=27228
UPDATE `creature_template_locale` SET `Name` = 'Йормунгарские черви' WHERE `locale` = 'ruRU' AND `entry` = 27228;
-- OLD name : Клейтон Дабин Младший, subname : Гарантированное качество
-- Source : https://www.wowhead.com/wotlk/ru/npc=27231
UPDATE `creature_template_locale` SET `Name` = '[Clayton Dubin J]',`Title` = '[Assured Quality ]' WHERE `locale` = 'ruRU' AND `entry` = 27231;
-- OLD name : Rogue Test Dummy
-- Source : https://www.wowhead.com/wotlk/ru/npc=27239
UPDATE `creature_template_locale` SET `Name` = '[Rogue Test Dummy]' WHERE `locale` = 'ruRU' AND `entry` = 27239;
-- OLD name : Забытый грифон
-- Source : https://www.wowhead.com/wotlk/ru/npc=27240
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Gryphon]' WHERE `locale` = 'ruRU' AND `entry` = 27240;
-- OLD name : Оберегающий дух
-- Source : https://www.wowhead.com/wotlk/ru/npc=27242
UPDATE `creature_template_locale` SET `Name` = '[Guardian Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 27242;
-- OLD name : Изумрудный огонек
-- Source : https://www.wowhead.com/wotlk/ru/npc=27252
UPDATE `creature_template_locale` SET `Name` = '[Emerald Wisp]' WHERE `locale` = 'ruRU' AND `entry` = 27252;
-- OLD name : Blighted Last Rites Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27253
UPDATE `creature_template_locale` SET `Name` = '[Blighted Last Rites Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27253;
-- OLD name : Scourge Plague Spreader (SMALL)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27257
UPDATE `creature_template_locale` SET `Name` = '[Scourge Plague Spreader (SMALL)]' WHERE `locale` = 'ruRU' AND `entry` = 27257;
-- OLD name : Изумрудный дичок
-- Source : https://www.wowhead.com/wotlk/ru/npc=27261
UPDATE `creature_template_locale` SET `Name` = '[Emerald Seedling]' WHERE `locale` = 'ruRU' AND `entry` = 27261;
-- OLD name : Let Them Not Rise! Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27280
UPDATE `creature_template_locale` SET `Name` = '[Let Them Not Rise! Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27280;
-- OLD name : Захороненный узник
-- Source : https://www.wowhead.com/wotlk/ru/npc=27282
UPDATE `creature_template_locale` SET `Name` = '[Buried Prisoner]' WHERE `locale` = 'ruRU' AND `entry` = 27282;
-- OLD name : Fresh Remounts Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27296
UPDATE `creature_template_locale` SET `Name` = '[Fresh Remounts Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27296;
-- OLD name : Король Бьорн визуальное
-- Source : https://www.wowhead.com/wotlk/ru/npc=27304
UPDATE `creature_template_locale` SET `Name` = '[King Bjorn Visual]' WHERE `locale` = 'ruRU' AND `entry` = 27304;
-- OLD name : Король Халдор визуальное
-- Source : https://www.wowhead.com/wotlk/ru/npc=27310
UPDATE `creature_template_locale` SET `Name` = '[King Haldor Visual]' WHERE `locale` = 'ruRU' AND `entry` = 27310;
-- OLD name : Король Ранульф визуальное
-- Source : https://www.wowhead.com/wotlk/ru/npc=27311
UPDATE `creature_template_locale` SET `Name` = '[King Ranulf Visual]' WHERE `locale` = 'ruRU' AND `entry` = 27311;
-- OLD name : Король Тор визуальное
-- Source : https://www.wowhead.com/wotlk/ru/npc=27312
UPDATE `creature_template_locale` SET `Name` = '[King Tor Visual]' WHERE `locale` = 'ruRU' AND `entry` = 27312;
-- OLD name : Ice Giant, Northrend
-- Source : https://www.wowhead.com/wotlk/ru/npc=27313
UPDATE `creature_template_locale` SET `Name` = '[Ice Giant, Northrend]' WHERE `locale` = 'ruRU' AND `entry` = 27313;
-- OLD name : Дворовый ловчий
-- Source : https://www.wowhead.com/wotlk/ru/npc=27323
UPDATE `creature_template_locale` SET `Name` = '[Outhouse Stalker]' WHERE `locale` = 'ruRU' AND `entry` = 27323;
-- OLD name : Outhouse Invisible Man
-- Source : https://www.wowhead.com/wotlk/ru/npc=27324
UPDATE `creature_template_locale` SET `Name` = '[Outhouse Invisible Man]' WHERE `locale` = 'ruRU' AND `entry` = 27324;
-- OLD name : Глава шпионов Репайн
-- Source : https://www.wowhead.com/wotlk/ru/npc=27337
UPDATE `creature_template_locale` SET `Name` = 'Госпожа шпионов Репина' WHERE `locale` = 'ruRU' AND `entry` = 27337;
-- OLD name : Dan's Test Vehicle 2
-- Source : https://www.wowhead.com/wotlk/ru/npc=27338
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Vehicle 2]' WHERE `locale` = 'ruRU' AND `entry` = 27338;
-- OLD name : Беспомощный селянин Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=27341
UPDATE `creature_template_locale` SET `Name` = '[Helpless Villager Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 27341;
-- OLD name : Аделина Чемберс
-- Source : https://www.wowhead.com/wotlk/ru/npc=27344
UPDATE `creature_template_locale` SET `Name` = 'Дрессировщица нетопырей Аделина' WHERE `locale` = 'ruRU' AND `entry` = 27344;
-- OLD name : Helpless Wintergarde Villager (Peasants)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27345
UPDATE `creature_template_locale` SET `Name` = '[Helpless Wintergarde Villager (Peasants)]' WHERE `locale` = 'ruRU' AND `entry` = 27345;
-- OLD name : Архонт-ворон Алого Натиска
-- Source : https://www.wowhead.com/wotlk/ru/npc=27357
UPDATE `creature_template_locale` SET `Name` = 'Вороний архонт Алого Натиска' WHERE `locale` = 'ruRU' AND `entry` = 27357;
-- OLD name : Vordrassil Sapling Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27366
UPDATE `creature_template_locale` SET `Name` = '[Vordrassil Sapling Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27366;
-- OLD name : Ursoc Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27372
UPDATE `creature_template_locale` SET `Name` = '[Ursoc Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27372;
-- OLD name : Главный писарь Баррига
-- Source : https://www.wowhead.com/wotlk/ru/npc=27378
UPDATE `creature_template_locale` SET `Name` = 'Главный писарь Киннедий' WHERE `locale` = 'ruRU' AND `entry` = 27378;
-- OLD name : Wintergarde Inner Gate Attack Trigger (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27380;
-- OLD name : Тель'зан Мраконосец (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27384;
-- OLD name : Torture the Torturer Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27394
UPDATE `creature_template_locale` SET `Name` = '[Torture the Torturer Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27394;
-- OLD name : Тайфун
-- Source : https://www.wowhead.com/wotlk/ru/npc=27395
UPDATE `creature_template_locale` SET `Name` = '[Typhoon]' WHERE `locale` = 'ruRU' AND `entry` = 27395;
-- OLD name : Kill Credit Bunny - Shredder Delivery
-- Source : https://www.wowhead.com/wotlk/ru/npc=27396
UPDATE `creature_template_locale` SET `Name` = '[Kill Credit Bunny - Shredder Delivery]' WHERE `locale` = 'ruRU' AND `entry` = 27396;
-- OLD name : Rocket Mount (Log Ride Test)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27397
UPDATE `creature_template_locale` SET `Name` = '[Rocket Mount (Log Ride Test)]' WHERE `locale` = 'ruRU' AND `entry` = 27397;
-- OLD name : Utgarde Duo Trigger (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27404;
-- OLD name : The Perfect Dissemblance Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27419
UPDATE `creature_template_locale` SET `Name` = '[The Perfect Dissemblance Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27419;
-- OLD name : Rothin's Necromantic Rune Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27420
UPDATE `creature_template_locale` SET `Name` = '[Rothin''s Necromantic Rune Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27420;
-- OLD name : Commander Jordan Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27426
UPDATE `creature_template_locale` SET `Name` = '[Commander Jordan Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27426;
-- OLD name : Lead Cannoneer Zierhut Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27427
UPDATE `creature_template_locale` SET `Name` = '[Lead Cannoneer Zierhut Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27427;
-- OLD name : Blacksmith Goodman Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27428
UPDATE `creature_template_locale` SET `Name` = '[Blacksmith Goodman Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27428;
-- OLD name : Stable Master Mercer Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27429
UPDATE `creature_template_locale` SET `Name` = '[Stable Master Mercer Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27429;
-- OLD name : Scarlet Raven Priest Image - Female Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=27442
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Raven Priest Image - Female Transform]' WHERE `locale` = 'ruRU' AND `entry` = 27442;
-- OLD name : Scarlet Raven Priest Image - Male Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=27443
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Raven Priest Image - Male Transform]' WHERE `locale` = 'ruRU' AND `entry` = 27443;
-- OLD name : A Fall from Grace High Abbot Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27444
UPDATE `creature_template_locale` SET `Name` = '[A Fall from Grace High Abbot Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27444;
-- OLD name : A Fall from Grace Bell Rung Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27445
UPDATE `creature_template_locale` SET `Name` = '[A Fall from Grace Bell Rung Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27445;
-- OLD name : Прыгучка верховного настоятеля Ландгрена
-- Source : https://www.wowhead.com/wotlk/ru/npc=27446
UPDATE `creature_template_locale` SET `Name` = '[High Abbot Landgren''s Jump Vehicle]' WHERE `locale` = 'ruRU' AND `entry` = 27446;
-- OLD name : Blue Sky Kill Credit Bunny - Grizzly Hills
-- Source : https://www.wowhead.com/wotlk/ru/npc=27453
UPDATE `creature_template_locale` SET `Name` = '[Blue Sky Kill Credit Bunny - Grizzly Hills]' WHERE `locale` = 'ruRU' AND `entry` = 27453;
-- OLD name : Труп застрельщика
-- Source : https://www.wowhead.com/wotlk/ru/npc=27457
UPDATE `creature_template_locale` SET `Name` = 'Труп рыскателя' WHERE `locale` = 'ruRU' AND `entry` = 27457;
-- OLD name : Израненный застрельщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=27463
UPDATE `creature_template_locale` SET `Name` = 'Израненный рыскатель' WHERE `locale` = 'ruRU' AND `entry` = 27463;
-- OLD name : Kill Credit Bunny - Wounded Skirmishers
-- Source : https://www.wowhead.com/wotlk/ru/npc=27466
UPDATE `creature_template_locale` SET `Name` = '[Kill Credit Bunny - Wounded Skirmishers]' WHERE `locale` = 'ruRU' AND `entry` = 27466;
-- OLD name : Forgotten Rifleman Quest Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27471
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Rifleman Quest Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27471;
-- OLD name : Forgotten Peasant Quest Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27472
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Peasant Quest Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27472;
-- OLD name : Forgotten Knight Quest Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27473
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Knight Quest Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27473;
-- OLD name : Captain Luc D'Merud Quest Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27474
UPDATE `creature_template_locale` SET `Name` = '[Captain Luc D''Merud Quest Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27474;
-- OLD name : Пехотник Дружины Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=27475
UPDATE `creature_template_locale` SET `Name` = 'Пехотинец Дружины Западного края' WHERE `locale` = 'ruRU' AND `entry` = 27475;
-- OLD subname : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27487
UPDATE `creature_template_locale` SET `Title` = 'Торговец напитками' WHERE `locale` = 'ruRU' AND `entry` = 27487;
-- OLD name : Gryphon Taxi (Howling Fjord -> Dragonblight - DND)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27491
UPDATE `creature_template_locale` SET `Name` = '[Gryphon Taxi (Howling Fjord -> Dragonblight - DND)]' WHERE `locale` = 'ruRU' AND `entry` = 27491;
-- OLD name : Нордскольский всадник на грифоне
-- Source : https://www.wowhead.com/wotlk/ru/npc=27504
UPDATE `creature_template_locale` SET `Name` = '[Northrend Gryphon Rider]' WHERE `locale` = 'ruRU' AND `entry` = 27504;
-- OLD name : Воскрешенный грифон
-- Source : https://www.wowhead.com/wotlk/ru/npc=27505
UPDATE `creature_template_locale` SET `Name` = '[Raised Gryphon]' WHERE `locale` = 'ruRU' AND `entry` = 27505;
-- OLD name : Unu'pe Vision - Blue Dragon (DND)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27507
UPDATE `creature_template_locale` SET `Name` = '[Unu''pe Vision - Blue Dragon (DND)]' WHERE `locale` = 'ruRU' AND `entry` = 27507;
-- OLD name : Unu'pe Vision - Vrykul (DND)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27514
UPDATE `creature_template_locale` SET `Name` = '[Unu''pe Vision - Vrykul (DND)]' WHERE `locale` = 'ruRU' AND `entry` = 27514;
-- OLD name : Unu'pe Vision - Gorloc (DND)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27515
UPDATE `creature_template_locale` SET `Name` = '[Unu''pe Vision - Gorloc (DND)]' WHERE `locale` = 'ruRU' AND `entry` = 27515;
-- OLD name : Трактирная крыса
-- Source : https://www.wowhead.com/wotlk/ru/npc=27522
UPDATE `creature_template_locale` SET `Name` = '[Inn Rat]' WHERE `locale` = 'ruRU' AND `entry` = 27522;
-- OLD name : Белый бронированный грифон
-- Source : https://www.wowhead.com/wotlk/ru/npc=27526
UPDATE `creature_template_locale` SET `Name` = '[White Armored Gryphon]' WHERE `locale` = 'ruRU' AND `entry` = 27526;
-- OLD name : Clayton Dubin - TEST COPY DATA, subname : Quality Assured
-- Source : https://www.wowhead.com/wotlk/ru/npc=27527
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (27527, 'ruRU','[Clayton Dubin - TEST COPY DATA]','[Quality Assured]');
-- OLD name : Penguin, Northrend
-- Source : https://www.wowhead.com/wotlk/ru/npc=27548
UPDATE `creature_template_locale` SET `Name` = '[Penguin, Northrend]' WHERE `locale` = 'ruRU' AND `entry` = 27548;
-- OLD name : Undead Miner Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27561
UPDATE `creature_template_locale` SET `Name` = '[Undead Miner Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27561;
-- OLD name : Стойла Торговой Компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=27568
UPDATE `creature_template_locale` SET `Name` = '[Venture Co. Stables]' WHERE `locale` = 'ruRU' AND `entry` = 27568;
-- OLD name : Лорд Афрасастраз, subname : Начальник стражи Храма Драконьего Покоя
-- Source : https://www.wowhead.com/wotlk/ru/npc=27575
UPDATE `creature_template_locale` SET `Name` = 'Лорд Деврестраз',`Title` = 'Командир стражи Храма Драконьего Покоя' WHERE `locale` = 'ruRU' AND `entry` = 27575;
-- OLD name : Novos Summon Target
-- Source : https://www.wowhead.com/wotlk/ru/npc=27583
UPDATE `creature_template_locale` SET `Name` = '[Novos Summon Target]' WHERE `locale` = 'ruRU' AND `entry` = 27583;
-- OLD name : QA Test Dummy 80 Normal, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=27586
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Normal]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 27586;
-- OLD name : QA Test Dummy 80 No Armor, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=27590
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 No Armor]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 27590;
-- OLD name : QA Test Dummy 83 No Armor, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=27591
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 83 No Armor]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 27591;
-- OLD name : QA Test Dummy 83 Normal, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=27592
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 83 Normal]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 27592;
-- OLD name : QA Test Dummy 80 High Magic Resist, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=27595
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 High Magic Resist]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 27595;
-- OLD name : QA Test Dummy 83 High Magic Resist, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=27596
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 83 High Magic Resist]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 27596;
-- OLD name : QA Test Dummy 80 Fixed Damage, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=27599
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Fixed Damage]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 27599;
-- OLD name : QA Test Dummy 83 Fixed Damage, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=27601
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 83 Fixed Damage]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 27601;
-- OLD name : Лазурный драконоид
-- Source : https://www.wowhead.com/wotlk/ru/npc=27608
UPDATE `creature_template_locale` SET `Name` = 'Лазурный дракон' WHERE `locale` = 'ruRU' AND `entry` = 27608;
-- OLD name : QA Test Dummy 80 Spell Spammer, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=27609
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Spell Spammer]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 27609;
-- OLD name : Некромант Джинта'калар
-- Source : https://www.wowhead.com/wotlk/ru/npc=27614
UPDATE `creature_template_locale` SET `Name` = '[Jintha''kalar Necromancer]' WHERE `locale` = 'ruRU' AND `entry` = 27614;
-- OLD name : Проекция Короля-лича
-- Source : https://www.wowhead.com/wotlk/ru/npc=27623
UPDATE `creature_template_locale` SET `Name` = '[Image of the Lich King]' WHERE `locale` = 'ruRU' AND `entry` = 27623;
-- OLD name : Plague Wagon Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27625
UPDATE `creature_template_locale` SET `Name` = '[Plague Wagon Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27625;
-- OLD name : Tatjana (Unconscious), subname : Посвященный культа Волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=27632
UPDATE `creature_template_locale` SET `Name` = '[Tatjana (Unconscious)]',`Title` = '[Wolfcult Initiate]' WHERE `locale` = 'ruRU' AND `entry` = 27632;
-- OLD name : Wolf Spirit Visual (Ymirjar Dusk Shaman)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27634
UPDATE `creature_template_locale` SET `Name` = '[Wolf Spirit Visual (Ymirjar Dusk Shaman)]' WHERE `locale` = 'ruRU' AND `entry` = 27634;
-- OLD name : Глашатай Храма
-- Source : https://www.wowhead.com/wotlk/ru/npc=27643
UPDATE `creature_template_locale` SET `Name` = '[Temple Caller]' WHERE `locale` = 'ruRU' AND `entry` = 27643;
-- OLD name : Kill Credit Bunny - Venture Bay 01
-- Source : https://www.wowhead.com/wotlk/ru/npc=27660
UPDATE `creature_template_locale` SET `Name` = '[Kill Credit Bunny - Venture Bay 01]' WHERE `locale` = 'ruRU' AND `entry` = 27660;
-- OLD name : Novos Spell Dummy
-- Source : https://www.wowhead.com/wotlk/ru/npc=27669
UPDATE `creature_template_locale` SET `Name` = '[Novos Spell Dummy]' WHERE `locale` = 'ruRU' AND `entry` = 27669;
-- OLD name : Мина ближнего действия
-- Source : https://www.wowhead.com/wotlk/ru/npc=27679
UPDATE `creature_template_locale` SET `Name` = '[Proximity Mine]' WHERE `locale` = 'ruRU' AND `entry` = 27679;
-- OLD name : Лазурный дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=27682
UPDATE `creature_template_locale` SET `Name` = 'Лазурный дракончик' WHERE `locale` = 'ruRU' AND `entry` = 27682;
-- OLD name : Защитник Драконьего Покоя
-- Source : https://www.wowhead.com/wotlk/ru/npc=27690
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Defender]' WHERE `locale` = 'ruRU' AND `entry` = 27690;
-- OLD name : Player Skeleton [PH]
-- Source : https://www.wowhead.com/wotlk/ru/npc=27694
UPDATE `creature_template_locale` SET `Name` = '[Player Skeleton [PH]]' WHERE `locale` = 'ruRU' AND `entry` = 27694;
-- OLD name : Пророк Тарон'джа
-- Source : https://www.wowhead.com/wotlk/ru/npc=27696
UPDATE `creature_template_locale` SET `Name` = '[The Prophet Tharon''ja ]' WHERE `locale` = 'ruRU' AND `entry` = 27696;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=27703
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 27703;
-- OLD name : Горейс Олдер
-- Source : https://www.wowhead.com/wotlk/ru/npc=27704
UPDATE `creature_template_locale` SET `Name` = 'Гораций Олдер' WHERE `locale` = 'ruRU' AND `entry` = 27704;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=27705
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 27705;
-- OLD name : Goblin Rocket Mount Test
-- Source : https://www.wowhead.com/wotlk/ru/npc=27710
UPDATE `creature_template_locale` SET `Name` = '[Goblin Rocket Mount Test]' WHERE `locale` = 'ruRU' AND `entry` = 27710;
-- OLD name : Drakkari Bat Mount (For Drakkari Invaders)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27724
UPDATE `creature_template_locale` SET `Name` = '[Drakkari Bat Mount (For Drakkari Invaders)]' WHERE `locale` = 'ruRU' AND `entry` = 27724;
-- OLD name : Горгонна
-- Source : https://www.wowhead.com/wotlk/ru/npc=27726
UPDATE `creature_template_locale` SET `Name` = '[Gorgonna]' WHERE `locale` = 'ruRU' AND `entry` = 27726;
-- OLD name : Ледопард-транспорт
-- Source : https://www.wowhead.com/wotlk/ru/npc=27738
UPDATE `creature_template_locale` SET `Name` = '[Frostsabre Vehicle]' WHERE `locale` = 'ruRU' AND `entry` = 27738;
-- OLD name : Механическая модель дикого элекка
-- Source : https://www.wowhead.com/wotlk/ru/npc=27740
UPDATE `creature_template_locale` SET `Name` = '[Wild Elekk Vehicle Version]' WHERE `locale` = 'ruRU' AND `entry` = 27740;
-- OLD name : Currency Token Test Wizard
-- Source : https://www.wowhead.com/wotlk/ru/npc=27741
UPDATE `creature_template_locale` SET `Name` = '[Currency Token Test Wizard]' WHERE `locale` = 'ruRU' AND `entry` = 27741;
-- OLD name : Захватчик Драккари
-- Source : https://www.wowhead.com/wotlk/ru/npc=27754
UPDATE `creature_template_locale` SET `Name` = '[Drakkari Invader]' WHERE `locale` = 'ruRU' AND `entry` = 27754;
-- OLD name : Wintergarde Gryphon (Taxi)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27764
UPDATE `creature_template_locale` SET `Name` = '[Wintergarde Gryphon (Taxi)]' WHERE `locale` = 'ruRU' AND `entry` = 27764;
-- OLD name : Imperial Eagle Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27786
UPDATE `creature_template_locale` SET `Name` = '[Imperial Eagle Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27786;
-- OLD name : Worg's Blood Elixir Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27796
UPDATE `creature_template_locale` SET `Name` = '[Worg''s Blood Elixir Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27796;
-- OLD name : Переродившийся небесный коготь
-- Source : https://www.wowhead.com/wotlk/ru/npc=27798
UPDATE `creature_template_locale` SET `Name` = 'Оживший небесный коготь' WHERE `locale` = 'ruRU' AND `entry` = 27798;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27806
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27806;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27810
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27810;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27811
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27811;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27812
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27812;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27813
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27813;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27814
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27814;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27815
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27815;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27816
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27816;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27817
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27817;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27818
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27818;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27819
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27819;
-- OLD name : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27820
UPDATE `creature_template_locale` SET `Name` = 'Торговка напитками' WHERE `locale` = 'ruRU' AND `entry` = 27820;
-- OLD name : Доверенный Плети в Мавзолее Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=27825
UPDATE `creature_template_locale` SET `Name` = '[Mausoleum Scourge Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 27825;
-- OLD name : Гленгарри Адамс, subname : 7-й легион
-- Source : https://www.wowhead.com/wotlk/ru/npc=27833
UPDATE `creature_template_locale` SET `Name` = '[Glengarry Adams]',`Title` = '[7th Legion]' WHERE `locale` = 'ruRU' AND `entry` = 27833;
-- OLD name : Страж-тенедемон
-- Source : https://www.wowhead.com/wotlk/ru/npc=27834
UPDATE `creature_template_locale` SET `Name` = '[Shadowfiend Guardian]' WHERE `locale` = 'ruRU' AND `entry` = 27834;
-- OLD name : Летающий аппарат Озера Ледяных Оков
-- Source : https://www.wowhead.com/wotlk/ru/npc=27838
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Fighter Plane]' WHERE `locale` = 'ruRU' AND `entry` = 27838;
-- OLD name : Wintergarde Gryphon (NPC Mount)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27841
UPDATE `creature_template_locale` SET `Name` = '[Wintergarde Gryphon (NPC Mount)]' WHERE `locale` = 'ruRU' AND `entry` = 27841;
-- OLD name : Тень Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=27847
UPDATE `creature_template_locale` SET `Name` = '[Shadow Void]' WHERE `locale` = 'ruRU' AND `entry` = 27847;
-- OLD name : Тигрюша
-- Source : https://www.wowhead.com/wotlk/ru/npc=27849
UPDATE `creature_template_locale` SET `Name` = 'Пятнюга' WHERE `locale` = 'ruRU' AND `entry` = 27849;
-- OLD name : Wintergrasp Flying Machine 2 (Bomber)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27850
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Bomber]' WHERE `locale` = 'ruRU' AND `entry` = 27850;
-- OLD name : Plague Zombie Vehicle - TEST
-- Source : https://www.wowhead.com/wotlk/ru/npc=27854
UPDATE `creature_template_locale` SET `Name` = '[Plague Zombie Vehicle - TEST]' WHERE `locale` = 'ruRU' AND `entry` = 27854;
-- OLD name : Patty's test vehicle TEST
-- Source : https://www.wowhead.com/wotlk/ru/npc=27862
UPDATE `creature_template_locale` SET `Name` = '[Patty''s test vehicle]' WHERE `locale` = 'ruRU' AND `entry` = 27862;
-- OLD name : Рубиновые цветы
-- Source : https://www.wowhead.com/wotlk/ru/npc=27863
UPDATE `creature_template_locale` SET `Name` = '[Ruby Flowers]' WHERE `locale` = 'ruRU' AND `entry` = 27863;
-- OLD name : Личина ворга-кровоклыка
-- Source : https://www.wowhead.com/wotlk/ru/npc=27864
UPDATE `creature_template_locale` SET `Name` = '[Fanggore Worg Disguise]' WHERE `locale` = 'ruRU' AND `entry` = 27864;
-- OLD name : Чумной питомец
-- Source : https://www.wowhead.com/wotlk/ru/npc=27865
UPDATE `creature_template_locale` SET `Name` = '[Plagued Pet]' WHERE `locale` = 'ruRU' AND `entry` = 27865;
-- OLD name : Kor'kron Wyvern Mount (Wrathgate)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27873
UPDATE `creature_template_locale` SET `Name` = '[Kor''kron Wyvern Mount (Wrathgate)]' WHERE `locale` = 'ruRU' AND `entry` = 27873;
-- OLD name : Лагерь Алого Натиска Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=27875
UPDATE `creature_template_locale` SET `Name` = '[Onslaught Base Camp Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 27875;
-- OLD name : Wintergrasp Land Mine
-- Source : https://www.wowhead.com/wotlk/ru/npc=27878
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Land Mine]' WHERE `locale` = 'ruRU' AND `entry` = 27878;
-- OLD name : Frostmourne Cavern Quest Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=27879
UPDATE `creature_template_locale` SET `Name` = '[Frostmourne Cavern Quest Credit]' WHERE `locale` = 'ruRU' AND `entry` = 27879;
-- OLD name : Оруженосец Ледяной Скорби
-- Source : https://www.wowhead.com/wotlk/ru/npc=27880
UPDATE `creature_template_locale` SET `Name` = '[Frostmourne Weapon Holder]' WHERE `locale` = 'ruRU' AND `entry` = 27880;
-- OLD name : Крошшер Озера Ледяных Оков
-- Source : https://www.wowhead.com/wotlk/ru/npc=27883
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Shredder]' WHERE `locale` = 'ruRU' AND `entry` = 27883;
-- OLD name : Боевой маг Аркус
-- Source : https://www.wowhead.com/wotlk/ru/npc=27888
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Аркус' WHERE `locale` = 'ruRU' AND `entry` = 27888;
-- OLD name : Taking Wing Timer Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27889
UPDATE `creature_template_locale` SET `Name` = '[Taking Wing Timer Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27889;
-- OLD name : Fire Revenant, Northrend
-- Source : https://www.wowhead.com/wotlk/ru/npc=27895
UPDATE `creature_template_locale` SET `Name` = '[Fire Revenant, Northrend]' WHERE `locale` = 'ruRU' AND `entry` = 27895;
-- OLD name : Боевой маг Ваткинс
-- Source : https://www.wowhead.com/wotlk/ru/npc=27904
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Ваткинс' WHERE `locale` = 'ruRU' AND `entry` = 27904;
-- OLD name : Сиденье бомбометательного отсека Озера Ледяных Оков
-- Source : https://www.wowhead.com/wotlk/ru/npc=27905
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Bomber Cockpit]' WHERE `locale` = 'ruRU' AND `entry` = 27905;
-- OLD name : Боевой маг Холлистер
-- Source : https://www.wowhead.com/wotlk/ru/npc=27906
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Холлистер' WHERE `locale` = 'ruRU' AND `entry` = 27906;
-- OLD name : World Death Knight Trainer, subname : Наставница рыцарей смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=27916
UPDATE `creature_template_locale` SET `Name` = '[World Deathknight Trainer]',`Title` = '[Deathknight Trainer]' WHERE `locale` = 'ruRU' AND `entry` = 27916;
-- OLD name : Вербовщик Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=27917
UPDATE `creature_template_locale` SET `Name` = '[Alliance Recruiter]' WHERE `locale` = 'ruRU' AND `entry` = 27917;
-- OLD name : Ордынский вербовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=27918
UPDATE `creature_template_locale` SET `Name` = '[Horde Recruiter]' WHERE `locale` = 'ruRU' AND `entry` = 27918;
-- OLD name : Герольд Орды
-- Source : https://www.wowhead.com/wotlk/ru/npc=27919
UPDATE `creature_template_locale` SET `Name` = '[Herald of the Horde]' WHERE `locale` = 'ruRU' AND `entry` = 27919;
-- OLD name : Герольд Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=27920
UPDATE `creature_template_locale` SET `Name` = '[Herald of the Alliance]' WHERE `locale` = 'ruRU' AND `entry` = 27920;
-- OLD name : Drakuru Handshake KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27921
UPDATE `creature_template_locale` SET `Name` = '[Drakuru Handshake KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27921;
-- OLD name : Mummified Carcass KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27929
UPDATE `creature_template_locale` SET `Name` = '[Mummified Carcass KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27929;
-- OLD name : Кормчий Орф
-- Source : https://www.wowhead.com/wotlk/ru/npc=27937
UPDATE `creature_template_locale` SET `Name` = '[Orf the Helmsman]' WHERE `locale` = 'ruRU' AND `entry` = 27937;
-- OLD name : Корабль Кормчего
-- Source : https://www.wowhead.com/wotlk/ru/npc=27939
UPDATE `creature_template_locale` SET `Name` = 'Корабль кормчего' WHERE `locale` = 'ruRU' AND `entry` = 27939;
-- OLD name : Ice Spike Trigger
-- Source : https://www.wowhead.com/wotlk/ru/npc=27942
UPDATE `creature_template_locale` SET `Name` = '[Ice Spike Trigger]' WHERE `locale` = 'ruRU' AND `entry` = 27942;
-- OLD name : Командир Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=27949
UPDATE `creature_template_locale` SET `Name` = 'Командор Альянса' WHERE `locale` = 'ruRU' AND `entry` = 27949;
-- OLD name : Wyrmrest Protector Visual (Red)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27952
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Red)]' WHERE `locale` = 'ruRU' AND `entry` = 27952;
-- OLD name : Wyrmrest Protector Visual (Green)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27954
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Green)]' WHERE `locale` = 'ruRU' AND `entry` = 27954;
-- OLD name : Wyrmrest Protector Visual (Bronze)
-- Source : https://www.wowhead.com/wotlk/ru/npc=27955
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Bronze)]' WHERE `locale` = 'ruRU' AND `entry` = 27955;
-- OLD name : Dan's Test Turret
-- Source : https://www.wowhead.com/wotlk/ru/npc=27956
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Turret]' WHERE `locale` = 'ruRU' AND `entry` = 27956;
-- OLD name : Dark Rune Keeper [PH], subname : PH MODEL: TASK 17271
-- Source : https://www.wowhead.com/wotlk/ru/npc=27968
UPDATE `creature_template_locale` SET `Name` = '[Dark Rune Keeper [PH]]',`Title` = '[PH MODEL: TASK 17271]' WHERE `locale` = 'ruRU' AND `entry` = 27968;
-- OLD name : Обветренный осколыш
-- Source : https://www.wowhead.com/wotlk/ru/npc=27974
UPDATE `creature_template_locale` SET `Name` = 'Выветренный осколыш' WHERE `locale` = 'ruRU' AND `entry` = 27974;
-- OLD name : Искаженная слизь
-- Source : https://www.wowhead.com/wotlk/ru/npc=27981
UPDATE `creature_template_locale` SET `Name` = 'Бесформенная слизь' WHERE `locale` = 'ruRU' AND `entry` = 27981;
-- OLD name : Летающий прототип диска
-- Source : https://www.wowhead.com/wotlk/ru/npc=27991
UPDATE `creature_template_locale` SET `Name` = '[Flying Disc Prototype]' WHERE `locale` = 'ruRU' AND `entry` = 27991;
-- OLD name : Лейтенант Ледяной Молот (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27994;
-- OLD name : The Gearmaster's Manual Researched Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=27995
UPDATE `creature_template_locale` SET `Name` = '[The Gearmaster''s Manual Researched Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 27995;
-- OLD name : Test PvP Questgiver
-- Source : https://www.wowhead.com/wotlk/ru/npc=27997
UPDATE `creature_template_locale` SET `Name` = '[Test PvP Questgiver]' WHERE `locale` = 'ruRU' AND `entry` = 27997;
-- OLD name : Верховой дракон Антиока
-- Source : https://www.wowhead.com/wotlk/ru/npc=28007
UPDATE `creature_template_locale` SET `Name` = '[Antiok''s Mount]' WHERE `locale` = 'ruRU' AND `entry` = 28007;
-- OLD name : Fire Upon the Waters Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28013
UPDATE `creature_template_locale` SET `Name` = '[Fire Upon the Waters Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28013;
-- OLD name : Кровавый червь
-- Source : https://www.wowhead.com/wotlk/ru/npc=28017
UPDATE `creature_template_locale` SET `Name` = 'Кровочервь' WHERE `locale` = 'ruRU' AND `entry` = 28017;
-- OLD name : Escape from Silverbrook Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=28019
UPDATE `creature_template_locale` SET `Name` = '[Escape from Silverbrook Credit]' WHERE `locale` = 'ruRU' AND `entry` = 28019;
-- OLD name : Wyrmrest Vanquisher (Bones)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28021
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Vanquisher (Bones)]' WHERE `locale` = 'ruRU' AND `entry` = 28021;
-- OLD name : Жуткий Капитан де Меза
-- Source : https://www.wowhead.com/wotlk/ru/npc=28048
UPDATE `creature_template_locale` SET `Name` = 'Жуткий капитан де Меза' WHERE `locale` = 'ruRU' AND `entry` = 28048;
-- OLD name : Королева Сапфирного улья
-- Source : https://www.wowhead.com/wotlk/ru/npc=28087
UPDATE `creature_template_locale` SET `Name` = 'Матка Сапфирного улья' WHERE `locale` = 'ruRU' AND `entry` = 28087;
-- OLD name : Moveto Test - Moves, subname : Начальник экспедиции
-- Source : https://www.wowhead.com/wotlk/ru/npc=28088
UPDATE `creature_template_locale` SET `Name` = '[Moveto Test - Moves]',`Title` = '[Expedition Leader]' WHERE `locale` = 'ruRU' AND `entry` = 28088;
-- OLD name : TEST- Theresa's frostsaber vehicle
-- Source : https://www.wowhead.com/wotlk/ru/npc=28119
UPDATE `creature_template_locale` SET `Name` = '[TEST- Theresa''s frostsaber vehicle]' WHERE `locale` = 'ruRU' AND `entry` = 28119;
-- OLD name : Bristlepine Food Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28128
UPDATE `creature_template_locale` SET `Name` = '[Bristlepine Food Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28128;
-- OLD name : Mindless Aberration (Unkillable)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28144
UPDATE `creature_template_locale` SET `Name` = '[Mindless Aberration (Unkillable)]' WHERE `locale` = 'ruRU' AND `entry` = 28144;
-- OLD name : Гнилосерд Драккари
-- Source : https://www.wowhead.com/wotlk/ru/npc=28159
UPDATE `creature_template_locale` SET `Name` = '[Scourgeheart Drakkari]' WHERE `locale` = 'ruRU' AND `entry` = 28159;
-- OLD name : Боевой конь Кунца
-- Source : https://www.wowhead.com/wotlk/ru/npc=28172
UPDATE `creature_template_locale` SET `Name` = '[Kunz''s Warhorse]' WHERE `locale` = 'ruRU' AND `entry` = 28172;
-- OLD name : Скорбная бездна
-- Source : https://www.wowhead.com/wotlk/ru/npc=28174
UPDATE `creature_template_locale` SET `Name` = '[Grief Void]' WHERE `locale` = 'ruRU' AND `entry` = 28174;
-- OLD name : Venture Bay Kill Credit Bunny - Grizzly Hills
-- Source : https://www.wowhead.com/wotlk/ru/npc=28190
UPDATE `creature_template_locale` SET `Name` = '[Venture Bay Kill Credit Bunny - Grizzly Hills]' WHERE `locale` = 'ruRU' AND `entry` = 28190;
-- OLD name : Ракетомет
-- Source : https://www.wowhead.com/wotlk/ru/npc=28198
UPDATE `creature_template_locale` SET `Name` = '[Rocket Launcher]' WHERE `locale` = 'ruRU' AND `entry` = 28198;
-- OLD name : Trapdoor Crawler Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28224
UPDATE `creature_template_locale` SET `Name` = '[Trapdoor Crawler Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28224;
-- OLD name : Воздушный патруль Торговой Компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=28241
UPDATE `creature_template_locale` SET `Name` = '[Venture Co. Air Patrol]' WHERE `locale` = 'ruRU' AND `entry` = 28241;
-- OLD name : QA Test First Aid Trainer, subname : Медик
-- Source : https://www.wowhead.com/wotlk/ru/npc=28245
UPDATE `creature_template_locale` SET `Name` = '[QA Test First Aid Trainer]',`Title` = '[Medic]' WHERE `locale` = 'ruRU' AND `entry` = 28245;
-- OLD name : Alchemist KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28248
UPDATE `creature_template_locale` SET `Name` = '[Alchemist KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28248;
-- OLD name : Wyrmrest Protector Visual (Black)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28250
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Black)]' WHERE `locale` = 'ruRU' AND `entry` = 28250;
-- OLD name : Wyrmrest Protector Visual (Blue)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28251
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Blue)]' WHERE `locale` = 'ruRU' AND `entry` = 28251;
-- OLD name : Wyrmrest Protector Visual (Nether)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28252
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Nether)]' WHERE `locale` = 'ruRU' AND `entry` = 28252;
-- OLD name : Defeated Argent Footman (Transform)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28259
UPDATE `creature_template_locale` SET `Name` = '[Defeated Argent Footman (Transform)]' WHERE `locale` = 'ruRU' AND `entry` = 28259;
-- OLD name : Ветролет
-- Source : https://www.wowhead.com/wotlk/ru/npc=28269
UPDATE `creature_template_locale` SET `Name` = '[Flying Machine Vehicle]' WHERE `locale` = 'ruRU' AND `entry` = 28269;
-- OLD name : Jintha'kalar Scourge (PROXY DO NOT SPAWN)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28270
UPDATE `creature_template_locale` SET `Name` = '[Jintha''kalar Scourge (PROXY DO NOT SPAWN)]' WHERE `locale` = 'ruRU' AND `entry` = 28270;
-- OLD name : Glacial Breach Scourge Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=28271
UPDATE `creature_template_locale` SET `Name` = '[Glacial Breach Scourge Credit]' WHERE `locale` = 'ruRU' AND `entry` = 28271;
-- OLD name : Прожорливый чумной пес
-- Source : https://www.wowhead.com/wotlk/ru/npc=28278
UPDATE `creature_template_locale` SET `Name` = '[Ravenous Plaguehound]' WHERE `locale` = 'ruRU' AND `entry` = 28278;
-- OLD name : Plague Sprayer Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28289
UPDATE `creature_template_locale` SET `Name` = '[Plague Sprayer Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28289;
-- OLD name : Muddy Mire Maggot KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28293
UPDATE `creature_template_locale` SET `Name` = '[Muddy Mire Maggot KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28293;
-- OLD name : Withered Batwing KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28294
UPDATE `creature_template_locale` SET `Name` = '[Withered Batwing KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28294;
-- OLD name : Amberseed KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28295
UPDATE `creature_template_locale` SET `Name` = '[Amberseed KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28295;
-- OLD name : Chilled Serpent Mucus KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28296
UPDATE `creature_template_locale` SET `Name` = '[Chilled Serpent Mucus KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28296;
-- OLD name : QA Test Dummy 80 Buff Spammer, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=28310
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Buff Spammer]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 28310;
-- OLD name : QA Test Dummy 80 Spell Reflector, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=28311
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Spell Reflector]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 28311;
-- OLD name : Defeated Argent Footman KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28316
UPDATE `creature_template_locale` SET `Name` = '[Defeated Argent Footman KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28316;
-- OLD name : Сбежавший гладиатор
-- Source : https://www.wowhead.com/wotlk/ru/npc=28322
UPDATE `creature_template_locale` SET `Name` = '[Escaped Gladiator]' WHERE `locale` = 'ruRU' AND `entry` = 28322;
-- OLD subname : Питомец Дебаар
-- Source : https://www.wowhead.com/wotlk/ru/npc=28346
UPDATE `creature_template_locale` SET `Title` = 'Питомец Дебаара' WHERE `locale` = 'ruRU' AND `entry` = 28346;
-- OLD name : Восставший врайкул-берсерк
-- Source : https://www.wowhead.com/wotlk/ru/npc=28349
UPDATE `creature_template_locale` SET `Name` = '[Risen Vrykul Berserker]' WHERE `locale` = 'ruRU' AND `entry` = 28349;
-- OLD name : Восставший врайкул-волхв
-- Source : https://www.wowhead.com/wotlk/ru/npc=28350
UPDATE `creature_template_locale` SET `Name` = '[Risen Vrykul Magus]' WHERE `locale` = 'ruRU' AND `entry` = 28350;
-- OLD name : Forsaken Blightspreader (Red)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28353
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Blightspreader (Red)]' WHERE `locale` = 'ruRU' AND `entry` = 28353;
-- OLD name : Forsaken Scientist (Blight Backpack)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28354
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Scientist (Blight Backpack)]' WHERE `locale` = 'ruRU' AND `entry` = 28354;
-- OLD name : Воздушное такси Выкрутеня
-- Source : https://www.wowhead.com/wotlk/ru/npc=28360
UPDATE `creature_template_locale` SET `Name` = '[Riding Fizzcrank Flyer Taxi]' WHERE `locale` = 'ruRU' AND `entry` = 28360;
-- OLD name : Riding Dragonhawk (A)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28361
UPDATE `creature_template_locale` SET `Name` = '[Riding Dragonhawk (A)]' WHERE `locale` = 'ruRU' AND `entry` = 28361;
-- OLD name : Slim's Test Mage
-- Source : https://www.wowhead.com/wotlk/ru/npc=28364
UPDATE `creature_template_locale` SET `Name` = '[Slim''s Test Mage]' WHERE `locale` = 'ruRU' AND `entry` = 28364;
-- OLD name : Slim's Test Warlock
-- Source : https://www.wowhead.com/wotlk/ru/npc=28365
UPDATE `creature_template_locale` SET `Name` = '[Slim''s Test Warlock]' WHERE `locale` = 'ruRU' AND `entry` = 28365;
-- OLD name : 7th Legion Siege Engineer (DVD)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28370
UPDATE `creature_template_locale` SET `Name` = '[7th Legion Siege Engineer (DVD)]' WHERE `locale` = 'ruRU' AND `entry` = 28370;
-- OLD name : DK (Human Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28395
UPDATE `creature_template_locale` SET `Name` = '[DK (Human Male)]' WHERE `locale` = 'ruRU' AND `entry` = 28395;
-- OLD name : Нордскольский учитель кожевничества, subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=28400
UPDATE `creature_template_locale` SET `Name` = '[Northrend Leatherworking Trainer]',`Title` = '[Leatherworking Trainer]' WHERE `locale` = 'ruRU' AND `entry` = 28400;
-- OLD name : DK (Human Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28420
UPDATE `creature_template_locale` SET `Name` = '[DK (Human Female)]' WHERE `locale` = 'ruRU' AND `entry` = 28420;
-- OLD name : DK (Dwarf Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28421
UPDATE `creature_template_locale` SET `Name` = '[DK (Dwarf Female)]' WHERE `locale` = 'ruRU' AND `entry` = 28421;
-- OLD name : DK (Gnome Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28422
UPDATE `creature_template_locale` SET `Name` = '[DK (Gnome Female)]' WHERE `locale` = 'ruRU' AND `entry` = 28422;
-- OLD name : DK (Night Elf Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28423
UPDATE `creature_template_locale` SET `Name` = '[DK (Night Elf Female)]' WHERE `locale` = 'ruRU' AND `entry` = 28423;
-- OLD name : DK (Draenei Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28424
UPDATE `creature_template_locale` SET `Name` = '[DK (Draenei Female)]' WHERE `locale` = 'ruRU' AND `entry` = 28424;
-- OLD name : DK (Dwarf Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28425
UPDATE `creature_template_locale` SET `Name` = '[DK (Dwarf Male)]' WHERE `locale` = 'ruRU' AND `entry` = 28425;
-- OLD name : DK (Gnome Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28426
UPDATE `creature_template_locale` SET `Name` = '[DK (Gnome Male)]' WHERE `locale` = 'ruRU' AND `entry` = 28426;
-- OLD name : DK (Night Elf Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28427
UPDATE `creature_template_locale` SET `Name` = '[DK (Night Elf Male)]' WHERE `locale` = 'ruRU' AND `entry` = 28427;
-- OLD name : DK (Draenei Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28428
UPDATE `creature_template_locale` SET `Name` = '[DK (Draenei Male)]' WHERE `locale` = 'ruRU' AND `entry` = 28428;
-- OLD name : DK (Blood Elf Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28429
UPDATE `creature_template_locale` SET `Name` = '[DK (Blood Elf Male)]' WHERE `locale` = 'ruRU' AND `entry` = 28429;
-- OLD name : DK (Orc Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28430
UPDATE `creature_template_locale` SET `Name` = '[DK (Orc Male)]' WHERE `locale` = 'ruRU' AND `entry` = 28430;
-- OLD name : DK (Forsaken Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28431
UPDATE `creature_template_locale` SET `Name` = '[DK (Forsaken Male)]' WHERE `locale` = 'ruRU' AND `entry` = 28431;
-- OLD name : DK (Troll Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28432
UPDATE `creature_template_locale` SET `Name` = '[DK (Troll Male)]' WHERE `locale` = 'ruRU' AND `entry` = 28432;
-- OLD name : DK (Tauren Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28433
UPDATE `creature_template_locale` SET `Name` = '[DK (Tauren Male)]' WHERE `locale` = 'ruRU' AND `entry` = 28433;
-- OLD name : DK (Blood Elf Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28434
UPDATE `creature_template_locale` SET `Name` = '[DK (Blood Elf Female)]' WHERE `locale` = 'ruRU' AND `entry` = 28434;
-- OLD name : DK (Troll Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28435
UPDATE `creature_template_locale` SET `Name` = '[DK (Troll Female)]' WHERE `locale` = 'ruRU' AND `entry` = 28435;
-- OLD name : DK (Orc Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28436
UPDATE `creature_template_locale` SET `Name` = '[DK (Orc Female)]' WHERE `locale` = 'ruRU' AND `entry` = 28436;
-- OLD name : DK (Forsaken Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28437
UPDATE `creature_template_locale` SET `Name` = '[DK (Forsaken Female)]' WHERE `locale` = 'ruRU' AND `entry` = 28437;
-- OLD name : DK (Tauren Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28438
UPDATE `creature_template_locale` SET `Name` = '[DK (Tauren Female)]' WHERE `locale` = 'ruRU' AND `entry` = 28438;
-- OLD name : Great Horned Owl Hover Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28441
UPDATE `creature_template_locale` SET `Name` = '[Great Horned Owl Hover Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28441;
-- OLD name : Ярость
-- Source : https://www.wowhead.com/wotlk/ru/npc=28446
UPDATE `creature_template_locale` SET `Name` = 'Неистовый' WHERE `locale` = 'ruRU' AND `entry` = 28446;
-- OLD name : Непривязанный скакун
-- Source : https://www.wowhead.com/wotlk/ru/npc=28450
UPDATE `creature_template_locale` SET `Name` = '[Unbound Charger]' WHERE `locale` = 'ruRU' AND `entry` = 28450;
-- OLD name : Riding Horse (Vehicle Demo)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28453
UPDATE `creature_template_locale` SET `Name` = '[Riding Horse (Vehicle Demo)]' WHERE `locale` = 'ruRU' AND `entry` = 28453;
-- OLD name : Рунический топор
-- Source : https://www.wowhead.com/wotlk/ru/npc=28475
UPDATE `creature_template_locale` SET `Name` = '[Runebladed Axe]' WHERE `locale` = 'ruRU' AND `entry` = 28475;
-- OLD name : Avatar of Freya Conversation Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=28482
UPDATE `creature_template_locale` SET `Name` = '[Avatar of Freya Conversation Credit]' WHERE `locale` = 'ruRU' AND `entry` = 28482;
-- OLD name : Runeforge (SW)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28483
UPDATE `creature_template_locale` SET `Name` = '[Runeforge (SW)]' WHERE `locale` = 'ruRU' AND `entry` = 28483;
-- OLD name : Синдрагоса, subname : Королева ледяных драконов
-- Source : https://www.wowhead.com/wotlk/ru/npc=28499
UPDATE `creature_template_locale` SET `Name` = '[Sindragosa]',`Title` = '[Queen of the Frostbrood]' WHERE `locale` = 'ruRU' AND `entry` = 28499;
-- OLD name : Ronakada, subname : Blademaster
-- Source : https://www.wowhead.com/wotlk/ru/npc=28501
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28501;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (28501, 'ruRU','[Ronakada]','[Blademaster]');
-- OLD name : Summon Vision Test - LAB
-- Source : https://www.wowhead.com/wotlk/ru/npc=28507
UPDATE `creature_template_locale` SET `Name` = '[Summon Vision Test - LAB]' WHERE `locale` = 'ruRU' AND `entry` = 28507;
-- OLD name : Building (CoT Stratholme)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28509
UPDATE `creature_template_locale` SET `Name` = '[Building (CoT Stratholme)]' WHERE `locale` = 'ruRU' AND `entry` = 28509;
-- OLD name : Hair Sample KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28520
UPDATE `creature_template_locale` SET `Name` = '[Hair Sample KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28520;
-- OLD name : Крестоносец Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28529
UPDATE `creature_template_locale` SET `Name` = 'Рыцарь Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28529;
-- OLD name : Верховой ледяной змей
-- Source : https://www.wowhead.com/wotlk/ru/npc=28531
UPDATE `creature_template_locale` SET `Name` = '[Frost Wyrm Mount]' WHERE `locale` = 'ruRU' AND `entry` = 28531;
-- OLD name : Riding Horse (Scarlet Commander)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28533
UPDATE `creature_template_locale` SET `Name` = '[Riding Horse (Scarlet Commander)]' WHERE `locale` = 'ruRU' AND `entry` = 28533;
-- OLD name : Свистящий клапан
-- Source : https://www.wowhead.com/wotlk/ru/npc=28539
UPDATE `creature_template_locale` SET `Name` = 'Паровой клапан' WHERE `locale` = 'ruRU' AND `entry` = 28539;
-- OLD name : Дистилло-матик 5000
-- Source : https://www.wowhead.com/wotlk/ru/npc=28545
UPDATE `creature_template_locale` SET `Name` = '[Distillo-matic 5000]' WHERE `locale` = 'ruRU' AND `entry` = 28545;
-- OLD name : Истязатель Лекрафт
-- Source : https://www.wowhead.com/wotlk/ru/npc=28554
UPDATE `creature_template_locale` SET `Name` = 'Истязатель Альфонс' WHERE `locale` = 'ruRU' AND `entry` = 28554;
-- OLD name : Маскировка Плети
-- Source : https://www.wowhead.com/wotlk/ru/npc=28570
UPDATE `creature_template_locale` SET `Name` = '[Scourge Disguise]' WHERE `locale` = 'ruRU' AND `entry` = 28570;
-- OLD name : Генерал Бьярнгрим
-- Source : https://www.wowhead.com/wotlk/ru/npc=28586
UPDATE `creature_template_locale` SET `Name` = 'Генерал Бьярнгрин' WHERE `locale` = 'ruRU' AND `entry` = 28586;
-- OLD name : Ошметки после взрыва трупа
-- Source : https://www.wowhead.com/wotlk/ru/npc=28590
UPDATE `creature_template_locale` SET `Name` = '[Corpse Explosion Rubble]' WHERE `locale` = 'ruRU' AND `entry` = 28590;
-- OLD name : Freya's Horn Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=28595
UPDATE `creature_template_locale` SET `Name` = '[Freya''s Horn Credit]' WHERE `locale` = 'ruRU' AND `entry` = 28595;
-- OLD name : Пехотинец из Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28609
UPDATE `creature_template_locale` SET `Name` = 'Пехотинец Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28609;
-- OLD name : Рыцарь Серебряной Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=28612
UPDATE `creature_template_locale` SET `Name` = 'Рыцарь ордена Серебряной Длани' WHERE `locale` = 'ruRU' AND `entry` = 28612;
-- OLD name : Оргриммарский всадник на волке
-- Source : https://www.wowhead.com/wotlk/ru/npc=28613
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Wolf Rider]' WHERE `locale` = 'ruRU' AND `entry` = 28613;
-- OLD name : Всадник на грифоне из Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28616
UPDATE `creature_template_locale` SET `Name` = 'Всадник на грифоне Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28616;
-- OLD name : Riding Horse (Charger, Default Run Speed)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28620
UPDATE `creature_template_locale` SET `Name` = '[Riding Horse (Charger, Default Run Speed)]' WHERE `locale` = 'ruRU' AND `entry` = 28620;
-- OLD name : Грейсон Стальное Крыло, subname : Распорядитель полетов
-- Source : https://www.wowhead.com/wotlk/ru/npc=28621
UPDATE `creature_template_locale` SET `Name` = '[Grayson Ironwing]',`Title` = '[Flight Master]' WHERE `locale` = 'ruRU' AND `entry` = 28621;
-- OLD name : Scalps! Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28622
UPDATE `creature_template_locale` SET `Name` = '[Scalps! Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28622;
-- OLD name : Riding Gyrocopter (Taxi)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28625
UPDATE `creature_template_locale` SET `Name` = '[Riding Gyrocopter (Taxi)]' WHERE `locale` = 'ruRU' AND `entry` = 28625;
-- OLD name : Scarlet Peasant (Logs Transform Visual)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28626
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Peasant (Logs Transform Visual)]' WHERE `locale` = 'ruRU' AND `entry` = 28626;
-- OLD name : Slim's Test Priest
-- Source : https://www.wowhead.com/wotlk/ru/npc=28628
UPDATE `creature_template_locale` SET `Name` = '[Slim''s Test Priest]' WHERE `locale` = 'ruRU' AND `entry` = 28628;
-- OLD name : Slim's Test Warrior
-- Source : https://www.wowhead.com/wotlk/ru/npc=28629
UPDATE `creature_template_locale` SET `Name` = '[Slim''s Test Warrior]' WHERE `locale` = 'ruRU' AND `entry` = 28629;
-- OLD name : Drakuru KC Bunny 01
-- Source : https://www.wowhead.com/wotlk/ru/npc=28631
UPDATE `creature_template_locale` SET `Name` = '[Drakuru KC Bunny 01]' WHERE `locale` = 'ruRU' AND `entry` = 28631;
-- OLD name : Дух волка
-- Source : https://www.wowhead.com/wotlk/ru/npc=28635
UPDATE `creature_template_locale` SET `Name` = '[Spirit Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 28635;
-- OLD name : Mosswalker Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=28644
UPDATE `creature_template_locale` SET `Name` = '[Mosswalker Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 28644;
-- OLD name : Vic's Self Replicating Abomination (DND)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28645
UPDATE `creature_template_locale` SET `Name` = '[Vic''s Self Replicating Abomination (DND)]' WHERE `locale` = 'ruRU' AND `entry` = 28645;
-- OLD name : Таинственный цыган
-- Source : https://www.wowhead.com/wotlk/ru/npc=28652
UPDATE `creature_template_locale` SET `Name` = '[Mysterious Gypsy]' WHERE `locale` = 'ruRU' AND `entry` = 28652;
-- OLD name : Gorebag KC Bunny 01
-- Source : https://www.wowhead.com/wotlk/ru/npc=28663
UPDATE `creature_template_locale` SET `Name` = '[Gorebag KC Bunny 01]' WHERE `locale` = 'ruRU' AND `entry` = 28663;
-- OLD name : Оккупант - LAB
-- Source : https://www.wowhead.com/wotlk/ru/npc=28664
UPDATE `creature_template_locale` SET `Name` = '[Seat Squatter - LAB]' WHERE `locale` = 'ruRU' AND `entry` = 28664;
-- OLD name : Служащая банка Халдер, subname : Банкир
-- Source : https://www.wowhead.com/wotlk/ru/npc=28678
UPDATE `creature_template_locale` SET `Name` = '[Teller Halder]',`Title` = '[Banker]' WHERE `locale` = 'ruRU' AND `entry` = 28678;
-- OLD name : Служащая банка Дюта, subname : Банкир
-- Source : https://www.wowhead.com/wotlk/ru/npc=28679
UPDATE `creature_template_locale` SET `Name` = '[Teller Duta]',`Title` = '[Banker]' WHERE `locale` = 'ruRU' AND `entry` = 28679;
-- OLD name : Служащий банка Баннинг, subname : Банкир
-- Source : https://www.wowhead.com/wotlk/ru/npc=28680
UPDATE `creature_template_locale` SET `Name` = '[Teller Banning]',`Title` = '[Banker]' WHERE `locale` = 'ruRU' AND `entry` = 28680;
-- OLD name : Грум из Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28689
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Stablehand]' WHERE `locale` = 'ruRU' AND `entry` = 28689;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=28692
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 28692;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=28693
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 28693;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=28694
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 28694;
-- OLD name : Дерик Маркс, subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=28696
UPDATE `creature_template_locale` SET `Name` = 'Дерик Шкуродер',`Title` = 'Великий мастер снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 28696;
-- OLD name : Тимофей Ошенко, subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=28697
UPDATE `creature_template_locale` SET `Name` = 'Тимоти Ошенко',`Title` = 'Великий мастер инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 28697;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=28698
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер горного дела' WHERE `locale` = 'ruRU' AND `entry` = 28698;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=28699
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 28699;
-- OLD name : Диана Кеннингс, subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=28700
UPDATE `creature_template_locale` SET `Name` = 'Диана Таннер',`Title` = 'Великий мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 28700;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=28701
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 28701;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=28702
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 28702;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=28703
UPDATE `creature_template_locale` SET `Title` = 'Великий алхимик' WHERE `locale` = 'ruRU' AND `entry` = 28703;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=28704
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер травничества' WHERE `locale` = 'ruRU' AND `entry` = 28704;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=28705
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 28705;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=28706
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 28706;
-- OLD name : Неживой орел
-- Source : https://www.wowhead.com/wotlk/ru/npc=28711
UPDATE `creature_template_locale` SET `Name` = '[Undead Eagle]' WHERE `locale` = 'ruRU' AND `entry` = 28711;
-- OLD name : Основная добыча пиньята, subname : Ударь меня!
-- Source : https://www.wowhead.com/wotlk/ru/npc=28712
UPDATE `creature_template_locale` SET `Name` = '[Basic Loot Pinata]',`Title` = '[Hit Me!]' WHERE `locale` = 'ruRU' AND `entry` = 28712;
-- OLD name : Quetz'lun Troll Worshipper Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28713
UPDATE `creature_template_locale` SET `Name` = '[Quetz''lun Troll Worshipper Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28713;
-- OLD name : Эндора Мурхед
-- Source : https://www.wowhead.com/wotlk/ru/npc=28715
UPDATE `creature_template_locale` SET `Name` = 'Ендора Мурхед' WHERE `locale` = 'ruRU' AND `entry` = 28715;
-- OLD name : Первая помощь добыча пиньята, subname : Ударь меня!
-- Source : https://www.wowhead.com/wotlk/ru/npc=28720
UPDATE `creature_template_locale` SET `Name` = '[First Aid Loot Pinata]',`Title` = '[Hit Me!]' WHERE `locale` = 'ruRU' AND `entry` = 28720;
-- OLD subname : Товары для алхимиков
-- Source : https://www.wowhead.com/wotlk/ru/npc=28725
UPDATE `creature_template_locale` SET `Title` = 'Товары для алхимика' WHERE `locale` = 'ruRU' AND `entry` = 28725;
-- OLD name : Старина Нелли
-- Source : https://www.wowhead.com/wotlk/ru/npc=28737
UPDATE `creature_template_locale` SET `Name` = '[Ol'' Nelly]' WHERE `locale` = 'ruRU' AND `entry` = 28737;
-- OLD name : Drakuru KC Bunny 00
-- Source : https://www.wowhead.com/wotlk/ru/npc=28738
UPDATE `creature_template_locale` SET `Name` = '[Drakuru KC Bunny 00]' WHERE `locale` = 'ruRU' AND `entry` = 28738;
-- OLD name : Blight Crystal KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28740
UPDATE `creature_template_locale` SET `Name` = '[Blight Crystal KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28740;
-- OLD name : Blight Cauldron KC Bunny 02
-- Source : https://www.wowhead.com/wotlk/ru/npc=28741
UPDATE `creature_template_locale` SET `Name` = '[Blight Cauldron KC Bunny 02]' WHERE `locale` = 'ruRU' AND `entry` = 28741;
-- OLD subname : Рыбная ловля: обучение и снасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=28742
UPDATE `creature_template_locale` SET `Title` = 'Великий рыбак и торговец снастями' WHERE `locale` = 'ruRU' AND `entry` = 28742;
-- OLD name : Неубиваемый босс Слима
-- Source : https://www.wowhead.com/wotlk/ru/npc=28744
UPDATE `creature_template_locale` SET `Name` = '[Slim''s Unkillable Boss]' WHERE `locale` = 'ruRU' AND `entry` = 28744;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=28746
UPDATE `creature_template_locale` SET `Title` = 'Инструктор полетов в непогоду' WHERE `locale` = 'ruRU' AND `entry` = 28746;
-- OLD name : High Priest Mu'funu Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28753
UPDATE `creature_template_locale` SET `Name` = '[High Priest Mu''funu Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28753;
-- OLD name : High Priestess Tua-Tua Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28755
UPDATE `creature_template_locale` SET `Name` = '[High Priestess Tua-Tua Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28755;
-- OLD name : High Priest Hawinni Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28757
UPDATE `creature_template_locale` SET `Name` = '[High Priest Hawinni Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28757;
-- OLD name : Reconnaisaince Flight Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=28758
UPDATE `creature_template_locale` SET `Name` = '[Reconnaisaince Flight Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 28758;
-- OLD name : Харгус Калека
-- Source : https://www.wowhead.com/wotlk/ru/npc=28760
UPDATE `creature_template_locale` SET `Name` = 'Харгус Дух' WHERE `locale` = 'ruRU' AND `entry` = 28760;
-- OLD name : Drakuru KC Bunny 02
-- Source : https://www.wowhead.com/wotlk/ru/npc=28762
UPDATE `creature_template_locale` SET `Name` = '[Drakuru KC Bunny 02]' WHERE `locale` = 'ruRU' AND `entry` = 28762;
-- OLD name : High Priestess Tua-Tua Hex of Fire Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28770
UPDATE `creature_template_locale` SET `Name` = '[High Priestess Tua-Tua Hex of Fire Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28770;
-- OLD name : High Priest Hawinni Hex of Frost Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28773
UPDATE `creature_template_locale` SET `Name` = '[High Priest Hawinni Hex of Frost Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28773;
-- OLD name : Dark Rider Target
-- Source : https://www.wowhead.com/wotlk/ru/npc=28775
UPDATE `creature_template_locale` SET `Name` = '[Dark Rider Target]' WHERE `locale` = 'ruRU' AND `entry` = 28775;
-- OLD name : Catapult KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28777
UPDATE `creature_template_locale` SET `Name` = '[Catapult KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28777;
-- OLD name : Боевой разрушитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=28781
UPDATE `creature_template_locale` SET `Name` = 'Разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 28781;
-- OLD name : Riding Gryphon, Amored, Neutral (Taxi)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28783
UPDATE `creature_template_locale` SET `Name` = '[Riding Gryphon, Amored, Neutral (Taxi)]' WHERE `locale` = 'ruRU' AND `entry` = 28783;
-- OLD name : Drakuru KC Bunny 03
-- Source : https://www.wowhead.com/wotlk/ru/npc=28786
UPDATE `creature_template_locale` SET `Name` = '[Drakuru KC Bunny 03]' WHERE `locale` = 'ruRU' AND `entry` = 28786;
-- OLD subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=28791
UPDATE `creature_template_locale` SET `Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 28791;
-- OLD subname : Кузнец
-- Source : https://www.wowhead.com/wotlk/ru/npc=28796
UPDATE `creature_template_locale` SET `Title` = 'Кузница' WHERE `locale` = 'ruRU' AND `entry` = 28796;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=28800
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 28800;
-- OLD name : Распространитель чумы
-- Source : https://www.wowhead.com/wotlk/ru/npc=28804
UPDATE `creature_template_locale` SET `Name` = '[Plague Spreader]' WHERE `locale` = 'ruRU' AND `entry` = 28804;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=28813
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 28813;
-- OLD name : Destructive Ward Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=28820
UPDATE `creature_template_locale` SET `Name` = '[Destructive Ward Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 28820;
-- OLD subname : Товары для алхимиков
-- Source : https://www.wowhead.com/wotlk/ru/npc=28829
UPDATE `creature_template_locale` SET `Title` = 'Товары для алхимика' WHERE `locale` = 'ruRU' AND `entry` = 28829;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=28831
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 28831;
-- OLD name : Mine Cart Test
-- Source : https://www.wowhead.com/wotlk/ru/npc=28842
UPDATE `creature_template_locale` SET `Name` = '[Mine Cart Test]' WHERE `locale` = 'ruRU' AND `entry` = 28842;
-- OLD name : Scarlet Fleet (PROXY)
-- Source : https://www.wowhead.com/wotlk/ru/npc=28849
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Fleet (PROXY)]' WHERE `locale` = 'ruRU' AND `entry` = 28849;
-- OLD name : Наземная пушка Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28850
UPDATE `creature_template_locale` SET `Name` = 'Пушка Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28850;
-- OLD name : Dead Mam'toth Disciple Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=28853
UPDATE `creature_template_locale` SET `Name` = '[Dead Mam''toth Disciple Transform]' WHERE `locale` = 'ruRU' AND `entry` = 28853;
-- OLD name : Кровь древнего бога
-- Source : https://www.wowhead.com/wotlk/ru/npc=28854
UPDATE `creature_template_locale` SET `Name` = 'Кровь Древнего Бога' WHERE `locale` = 'ruRU' AND `entry` = 28854;
-- OLD subname : Товары для алхимиков
-- Source : https://www.wowhead.com/wotlk/ru/npc=28866
UPDATE `creature_template_locale` SET `Title` = 'Товары для алхимика' WHERE `locale` = 'ruRU' AND `entry` = 28866;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=28872
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 28872;
-- OLD name : Mam'toth Disciple Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28876
UPDATE `creature_template_locale` SET `Name` = '[Mam''toth Disciple Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28876;
-- OLD name : Test Iron Dwarf
-- Source : https://www.wowhead.com/wotlk/ru/npc=28880
UPDATE `creature_template_locale` SET `Name` = '[Test Iron Dwarf]' WHERE `locale` = 'ruRU' AND `entry` = 28880;
-- OLD name : Наземная пушка Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28885
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Land Cannon]' WHERE `locale` = 'ruRU' AND `entry` = 28885;
-- OLD name : Защитник флота Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28886
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Fleet Defender]' WHERE `locale` = 'ruRU' AND `entry` = 28886;
-- OLD name : Пушка Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28887
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Cannon]' WHERE `locale` = 'ruRU' AND `entry` = 28887;
-- OLD name : Всадник на грифоне из Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28894
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Gryphon Rider]' WHERE `locale` = 'ruRU' AND `entry` = 28894;
-- OLD name : Медик Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28895
UPDATE `creature_template_locale` SET `Name` = 'Медик из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28895;
-- OLD name : Капитан Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28898
UPDATE `creature_template_locale` SET `Name` = 'Капитан из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28898;
-- OLD name : Тихоземская кобыла
-- Source : https://www.wowhead.com/wotlk/ru/npc=28899
UPDATE `creature_template_locale` SET `Name` = '[Havenshire Mare]' WHERE `locale` = 'ruRU' AND `entry` = 28899;
-- OLD name : Тихоземский жеребец
-- Source : https://www.wowhead.com/wotlk/ru/npc=28900
UPDATE `creature_template_locale` SET `Name` = '[Havenshire Stallion]' WHERE `locale` = 'ruRU' AND `entry` = 28900;
-- OLD name : Скакун темного всадника закреплен
-- Source : https://www.wowhead.com/wotlk/ru/npc=28915
UPDATE `creature_template_locale` SET `Name` = '[Dark Rider Mount Fixed]' WHERE `locale` = 'ruRU' AND `entry` = 28915;
-- OLD name : Искра Ионара
-- Source : https://www.wowhead.com/wotlk/ru/npc=28926
UPDATE `creature_template_locale` SET `Name` = 'Искра Ионар' WHERE `locale` = 'ruRU' AND `entry` = 28926;
-- OLD name : Drakuru KC Bunny 04
-- Source : https://www.wowhead.com/wotlk/ru/npc=28928
UPDATE `creature_template_locale` SET `Name` = '[Drakuru KC Bunny 04]' WHERE `locale` = 'ruRU' AND `entry` = 28928;
-- OLD name : Drakuru's Upper Chamber Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=28929
UPDATE `creature_template_locale` SET `Name` = '[Drakuru''s Upper Chamber Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 28929;
-- OLD name : Командир Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28936
UPDATE `creature_template_locale` SET `Name` = 'Командир из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28936;
-- OLD name : Крестоносец Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28940
UPDATE `creature_template_locale` SET `Name` = 'Рыцарь Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28940;
-- OLD name : Начертатель, subname : Выдающийся дизайнер
-- Source : https://www.wowhead.com/wotlk/ru/npc=28944
UPDATE `creature_template_locale` SET `Name` = '[The Inscriber]',`Title` = '[Designer Extraordinaire]' WHERE `locale` = 'ruRU' AND `entry` = 28944;
-- OLD name : Spell Performance Test Caster, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=28949
UPDATE `creature_template_locale` SET `Name` = '[Spell Performance Test Caster]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 28949;
-- OLD name : Spell Performance Test Target, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=28950
UPDATE `creature_template_locale` SET `Name` = '[Spell Performance Test Target]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 28950;
-- OLD name : Unkillable Test Dummy 70 Gnome
-- Source : https://www.wowhead.com/wotlk/ru/npc=28953
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 70 Gnome]' WHERE `locale` = 'ruRU' AND `entry` = 28953;
-- OLD name : Unkillable Test Dummy 70 Tauren
-- Source : https://www.wowhead.com/wotlk/ru/npc=28954
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 70 Tauren]' WHERE `locale` = 'ruRU' AND `entry` = 28954;
-- OLD name : Unkillable Test Dummy 70 Dwarf
-- Source : https://www.wowhead.com/wotlk/ru/npc=28955
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 70 Dwarf]' WHERE `locale` = 'ruRU' AND `entry` = 28955;
-- OLD subname : Наставница магов
-- Source : https://www.wowhead.com/wotlk/ru/npc=28958
UPDATE `creature_template_locale` SET `Title` = 'Наставник магов' WHERE `locale` = 'ruRU' AND `entry` = 28958;
-- OLD name : Титановый осадник
-- Source : https://www.wowhead.com/wotlk/ru/npc=28961
UPDATE `creature_template_locale` SET `Name` = 'Титановый воин' WHERE `locale` = 'ruRU' AND `entry` = 28961;
-- OLD name : Лорд Алого ордена Джессерия Маккри
-- Source : https://www.wowhead.com/wotlk/ru/npc=28964
UPDATE `creature_template_locale` SET `Name` = 'Лорд Алого ордена Бораг' WHERE `locale` = 'ruRU' AND `entry` = 28964;
-- OLD name : Горожанин Нового Авалона Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=28986
UPDATE `creature_template_locale` SET `Name` = '[Citizen of New Avalon Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 28986;
-- OLD name : Командир Алого ордена Родрик
-- Source : https://www.wowhead.com/wotlk/ru/npc=29000
UPDATE `creature_template_locale` SET `Name` = 'Командир Родрик из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 29000;
-- OLD name : Frost Vrykul (Type A)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29002
UPDATE `creature_template_locale` SET `Name` = '[Frost Vrykul (Type A)]' WHERE `locale` = 'ruRU' AND `entry` = 29002;
-- OLD name : Frost Vrykul (Type B)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29003
UPDATE `creature_template_locale` SET `Name` = '[Frost Vrykul (Type B)]' WHERE `locale` = 'ruRU' AND `entry` = 29003;
-- OLD name : Frost Vrykul (Type C)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29004
UPDATE `creature_template_locale` SET `Name` = '[Frost Vrykul (Type C)]' WHERE `locale` = 'ruRU' AND `entry` = 29004;
-- OLD name : Monsoon Revenant Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=29008
UPDATE `creature_template_locale` SET `Name` = '[Monsoon Revenant Credit]' WHERE `locale` = 'ruRU' AND `entry` = 29008;
-- OLD name : Storm Revenant Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=29009
UPDATE `creature_template_locale` SET `Name` = '[Storm Revenant Credit]' WHERE `locale` = 'ruRU' AND `entry` = 29009;
-- OLD name : Anti-Magic Barrier (Quest)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29010
UPDATE `creature_template_locale` SET `Name` = '[Anti-Magic Barrier (Quest)]' WHERE `locale` = 'ruRU' AND `entry` = 29010;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=29014
UPDATE `creature_template_locale` SET `Title` = 'Торговец стрелами' WHERE `locale` = 'ruRU' AND `entry` = 29014;
-- OLD name : Портовый грузчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=29019
UPDATE `creature_template_locale` SET `Name` = 'Портовый рабочий' WHERE `locale` = 'ruRU' AND `entry` = 29019;
-- OLD name : It's A Chopper, Baby (Horde), subname : Орда
-- Source : https://www.wowhead.com/wotlk/ru/npc=29045
UPDATE `creature_template_locale` SET `Name` = '[It''s A Chopper, Baby (Horde)]',`Title` = '[Horde]' WHERE `locale` = 'ruRU' AND `entry` = 29045;
-- OLD name : It's A Chopper, Baby (Alliance), subname : Орда
-- Source : https://www.wowhead.com/wotlk/ru/npc=29046
UPDATE `creature_template_locale` SET `Name` = '[It''s A Chopper, Baby (Alliance)]',`Title` = '[Horde]' WHERE `locale` = 'ruRU' AND `entry` = 29046;
-- OLD name : Outhouse Invisible Woman
-- Source : https://www.wowhead.com/wotlk/ru/npc=29052
UPDATE `creature_template_locale` SET `Name` = '[Outhouse Invisible Woman]' WHERE `locale` = 'ruRU' AND `entry` = 29052;
-- OLD name : Missile Test Mob
-- Source : https://www.wowhead.com/wotlk/ru/npc=29054
UPDATE `creature_template_locale` SET `Name` = '[Missile Test Mob]' WHERE `locale` = 'ruRU' AND `entry` = 29054;
-- OLD name : Horn of Fecundity Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=29055
UPDATE `creature_template_locale` SET `Name` = '[Horn of Fecundity Credit]' WHERE `locale` = 'ruRU' AND `entry` = 29055;
-- OLD name : Craig - TEST - Iron Dwarf
-- Source : https://www.wowhead.com/wotlk/ru/npc=29059
UPDATE `creature_template_locale` SET `Name` = '[Craig - TEST - Iron Dwarf]' WHERE `locale` = 'ruRU' AND `entry` = 29059;
-- OLD name : Crusader Parachute Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29060
UPDATE `creature_template_locale` SET `Name` = '[Crusader Parachute Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29060;
-- OLD name : Гоби Подрывайстер
-- Source : https://www.wowhead.com/wotlk/ru/npc=29068
UPDATE `creature_template_locale` SET `Name` = 'Гоби Покрышкинс' WHERE `locale` = 'ruRU' AND `entry` = 29068;
-- OLD name : QA Test Dummy 73 Raid Debuff (Low Armor)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29075
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 73 Raid Debuff (Low Armor)]' WHERE `locale` = 'ruRU' AND `entry` = 29075;
-- OLD name : ПэттиМакс "Двойка"
-- Source : https://www.wowhead.com/wotlk/ru/npc=29083
UPDATE `creature_template_locale` SET `Name` = '[PattyMacks The Duece]' WHERE `locale` = 'ruRU' AND `entry` = 29083;
-- OLD name : Drakkari Skullcrusher KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29099
UPDATE `creature_template_locale` SET `Name` = '[Drakkari Skullcrusher KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29099;
-- OLD name : Валь'кира-воительница
-- Source : https://www.wowhead.com/wotlk/ru/npc=29111
UPDATE `creature_template_locale` SET `Name` = '[Val''kyr Battle-maiden]' WHERE `locale` = 'ruRU' AND `entry` = 29111;
-- OLD name : Главнокомандующий Галвар Чистокров
-- Source : https://www.wowhead.com/wotlk/ru/npc=29114
UPDATE `creature_template_locale` SET `Name` = '[High Commander Galvar Pureblood]' WHERE `locale` = 'ruRU' AND `entry` = 29114;
-- OLD name : Стенающая душа Драккари
-- Source : https://www.wowhead.com/wotlk/ru/npc=29135
UPDATE `creature_template_locale` SET `Name` = '[Wailing Drakkari Soul]' WHERE `locale` = 'ruRU' AND `entry` = 29135;
-- OLD name : Трясение камеры - 20-40 секунд
-- Source : https://www.wowhead.com/wotlk/ru/npc=29140
UPDATE `creature_template_locale` SET `Name` = '[Camera Shaker - 20-40 seconds]' WHERE `locale` = 'ruRU' AND `entry` = 29140;
-- OLD name : Солдат из Алого ордена Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=29150
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Soldier Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 29150;
-- OLD name : Test Scaling Vendor
-- Source : https://www.wowhead.com/wotlk/ru/npc=29163
UPDATE `creature_template_locale` SET `Name` = '[Test Scaling Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 29163;
-- OLD name : Телепорт в Чертоги Камня
-- Source : https://www.wowhead.com/wotlk/ru/npc=29165
UPDATE `creature_template_locale` SET `Name` = '[Halls of Stone Teleporter]' WHERE `locale` = 'ruRU' AND `entry` = 29165;
-- OLD name : Кунц-младший
-- Source : https://www.wowhead.com/wotlk/ru/npc=29171
UPDATE `creature_template_locale` SET `Name` = '[Kunz Jr.]' WHERE `locale` = 'ruRU' AND `entry` = 29171;
-- OLD name : Извергатель чумы
-- Source : https://www.wowhead.com/wotlk/ru/npc=29187
UPDATE `creature_template_locale` SET `Name` = '[Plague Eruptor]' WHERE `locale` = 'ruRU' AND `entry` = 29187;
-- OLD name : Хладный дух
-- Source : https://www.wowhead.com/wotlk/ru/npc=29188
UPDATE `creature_template_locale` SET `Name` = '[Coldwraith]' WHERE `locale` = 'ruRU' AND `entry` = 29188;
-- OLD name : Frozen Shade, Climax
-- Source : https://www.wowhead.com/wotlk/ru/npc=29197
UPDATE `creature_template_locale` SET `Name` = '[Frozen Shade, Climax]' WHERE `locale` = 'ruRU' AND `entry` = 29197;
-- OLD name : Скакун Могрейна
-- Source : https://www.wowhead.com/wotlk/ru/npc=29198
UPDATE `creature_template_locale` SET `Name` = '[Mograine''s Mount]' WHERE `locale` = 'ruRU' AND `entry` = 29198;
-- OLD name : Скакун рыцаря смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=29201
UPDATE `creature_template_locale` SET `Name` = '[Death Knight Mount]' WHERE `locale` = 'ruRU' AND `entry` = 29201;
-- OLD subname : Реагенты
-- Source : https://www.wowhead.com/wotlk/ru/npc=29203
UPDATE `creature_template_locale` SET `Title` = 'Продавец трупного праха' WHERE `locale` = 'ruRU' AND `entry` = 29203;
-- OLD name : Disciples of the Unholy Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29215
UPDATE `creature_template_locale` SET `Name` = '[Disciples of the Unholy Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29215;
-- OLD name : Death Knight Mount, Ebon Hold
-- Source : https://www.wowhead.com/wotlk/ru/npc=29221
UPDATE `creature_template_locale` SET `Name` = '[Death Knight Mount, Ebon Hold]' WHERE `locale` = 'ruRU' AND `entry` = 29221;
-- OLD name : Тень Йогг-Сарона
-- Source : https://www.wowhead.com/wotlk/ru/npc=29224
UPDATE `creature_template_locale` SET `Name` = '[Presence of Yogg-Saron]' WHERE `locale` = 'ruRU' AND `entry` = 29224;
-- OLD name : Младшее создание Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=29230
UPDATE `creature_template_locale` SET `Name` = '[Lesser Shadow Construct]' WHERE `locale` = 'ruRU' AND `entry` = 29230;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=29233
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 29233;
-- OLD name : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=29234
UPDATE `creature_template_locale` SET `Name` = '[Strand of the Ancients Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 29234;
-- OLD name : Omar the Test Dragon Gen2
-- Source : https://www.wowhead.com/wotlk/ru/npc=29257
UPDATE `creature_template_locale` SET `Name` = '[Omar the Test Dragon Gen2]' WHERE `locale` = 'ruRU' AND `entry` = 29257;
-- OLD name : Omar's accumulator bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29258
UPDATE `creature_template_locale` SET `Name` = '[Omar''s accumulator bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29258;
-- OLD name : PattyMacks Hovering Dummy
-- Source : https://www.wowhead.com/wotlk/ru/npc=29263
UPDATE `creature_template_locale` SET `Name` = '[PattyMacks Hovering Dummy]' WHERE `locale` = 'ruRU' AND `entry` = 29263;
-- OLD name : Откидывающий шар, subname : Ударь меня!
-- Source : https://www.wowhead.com/wotlk/ru/npc=29265
UPDATE `creature_template_locale` SET `Name` = '[Knockback Ball]',`Title` = '[<Hit Me!>]' WHERE `locale` = 'ruRU' AND `entry` = 29265;
-- OLD name : Эфирная сфера
-- Source : https://www.wowhead.com/wotlk/ru/npc=29271
UPDATE `creature_template_locale` SET `Name` = 'Бесплотная сфера' WHERE `locale` = 'ruRU' AND `entry` = 29271;
-- OLD name : Дворфийский голем
-- Source : https://www.wowhead.com/wotlk/ru/npc=29272
UPDATE `creature_template_locale` SET `Name` = '[Dwarven Golem]' WHERE `locale` = 'ruRU' AND `entry` = 29272;
-- OLD name : Казначей Хаберт, subname : Банкир
-- Source : https://www.wowhead.com/wotlk/ru/npc=29283
UPDATE `creature_template_locale` SET `Name` = '[Paymaster Habert]',`Title` = '[Banker]' WHERE `locale` = 'ruRU' AND `entry` = 29283;
-- OLD name : Бенджамин Эльгуэта
-- Source : https://www.wowhead.com/wotlk/ru/npc=29298
UPDATE `creature_template_locale` SET `Name` = 'Веджамин Эльгуэта' WHERE `locale` = 'ruRU' AND `entry` = 29298;
-- OLD name : Lifeblood Elemental Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=29303
UPDATE `creature_template_locale` SET `Name` = '[Lifeblood Elemental Credit]' WHERE `locale` = 'ruRU' AND `entry` = 29303;
-- OLD name : Синигоса
-- Source : https://www.wowhead.com/wotlk/ru/npc=29317
UPDATE `creature_template_locale` SET `Name` = '[Cyanigosa (Dragon)]' WHERE `locale` = 'ruRU' AND `entry` = 29317;
-- OLD name : Военачальник арены Даларана, subname : Полководец
-- Source : https://www.wowhead.com/wotlk/ru/npc=29318
UPDATE `creature_template_locale` SET `Name` = '[Dalaran Arena Battlemaster]',`Title` = '[Battle Master]' WHERE `locale` = 'ruRU' AND `entry` = 29318;
-- OLD name : (PH) Storm Maiden
-- Source : https://www.wowhead.com/wotlk/ru/npc=29320
UPDATE `creature_template_locale` SET `Name` = '[(PH) Storm Maiden]' WHERE `locale` = 'ruRU' AND `entry` = 29320;
-- OLD name : (PH) Storm Maiden - Caster
-- Source : https://www.wowhead.com/wotlk/ru/npc=29322
UPDATE `creature_template_locale` SET `Name` = '[(PH) Storm Maiden - Caster]' WHERE `locale` = 'ruRU' AND `entry` = 29322;
-- OLD name : Рыцарь Серебряного Рассвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=29336
UPDATE `creature_template_locale` SET `Name` = '[Argent Knight]' WHERE `locale` = 'ruRU' AND `entry` = 29336;
-- OLD name : Епископ-ворон Алого Натиска
-- Source : https://www.wowhead.com/wotlk/ru/npc=29338
UPDATE `creature_template_locale` SET `Name` = 'Вороний епископ Алого Натиска' WHERE `locale` = 'ruRU' AND `entry` = 29338;
-- OLD name : Sybil (Archer) - Deprecated
-- Source : https://www.wowhead.com/wotlk/ru/npc=29342
UPDATE `creature_template_locale` SET `Name` = '[Sybil (Archer) - Deprecated]' WHERE `locale` = 'ruRU' AND `entry` = 29342;
-- OLD name : Знамя Серебряного Рассвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=29345
UPDATE `creature_template_locale` SET `Name` = '[Argent Dawn Banner]' WHERE `locale` = 'ruRU' AND `entry` = 29345;
-- OLD name : Ichor Globule (Transform)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29367
UPDATE `creature_template_locale` SET `Name` = '[Ichor Globule (Transform)]' WHERE `locale` = 'ruRU' AND `entry` = 29367;
-- OLD name : Сумеречный дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=29372
UPDATE `creature_template_locale` SET `Name` = '[Twilight Drake]' WHERE `locale` = 'ruRU' AND `entry` = 29372;
-- OLD name : Налетчик из клана Закаленных Бурей
-- Source : https://www.wowhead.com/wotlk/ru/npc=29377
UPDATE `creature_template_locale` SET `Name` = 'Мародер из клана Закаленных Бурей' WHERE `locale` = 'ruRU' AND `entry` = 29377;
-- OLD name : Бруннхильдарская наблюдательница
-- Source : https://www.wowhead.com/wotlk/ru/npc=29378
UPDATE `creature_template_locale` SET `Name` = '[Brunnhildar Observer]' WHERE `locale` = 'ruRU' AND `entry` = 29378;
-- OLD name : QA Arena Master: Blade's Edge, subname : Полководец
-- Source : https://www.wowhead.com/wotlk/ru/npc=29381
UPDATE `creature_template_locale` SET `Name` = '[QA Arena Master: Blade''s Edge]',`Title` = '[Battle Master]' WHERE `locale` = 'ruRU' AND `entry` = 29381;
-- OLD name : QA Arena Master: Nagrand Arena, subname : Полководец
-- Source : https://www.wowhead.com/wotlk/ru/npc=29383
UPDATE `creature_template_locale` SET `Name` = '[QA Arena Master: Nagrand Arena]',`Title` = '[Battle Master]' WHERE `locale` = 'ruRU' AND `entry` = 29383;
-- OLD name : QA Arena Master: Ruins of Lordaeron, subname : Полководец
-- Source : https://www.wowhead.com/wotlk/ru/npc=29385
UPDATE `creature_template_locale` SET `Name` = '[QA Arena Master: Ruins of Lordaeron]',`Title` = '[Battle Master]' WHERE `locale` = 'ruRU' AND `entry` = 29385;
-- OLD name : QA Arena Master: Orgrimmar Arena, subname : Полководец
-- Source : https://www.wowhead.com/wotlk/ru/npc=29386
UPDATE `creature_template_locale` SET `Name` = '[QA Arena Master: Orgrimmar Arena]',`Title` = '[Battle Master]' WHERE `locale` = 'ruRU' AND `entry` = 29386;
-- OLD name : QA Arena Master: Dalaran Arena, subname : Полководец
-- Source : https://www.wowhead.com/wotlk/ru/npc=29387
UPDATE `creature_template_locale` SET `Name` = '[QA Arena Master: Dalaran Arena]',`Title` = '[Battle Master]' WHERE `locale` = 'ruRU' AND `entry` = 29387;
-- OLD name : Ravenous Jaws Blood Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29391
UPDATE `creature_template_locale` SET `Name` = '[Ravenous Jaws Blood Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29391;
-- OLD name : From Their Corpses, Rise! Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29398
UPDATE `creature_template_locale` SET `Name` = '[From Their Corpses, Rise! Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29398;
-- OLD name : You'll Need a Gryphon Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29406
UPDATE `creature_template_locale` SET `Name` = '[You''ll Need a Gryphon Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29406;
-- OLD name : Фанатик с Холмов Снежной Слепоты
-- Source : https://www.wowhead.com/wotlk/ru/npc=29407
UPDATE `creature_template_locale` SET `Name` = 'Приверженец с Холмов Снежной Слепоты' WHERE `locale` = 'ruRU' AND `entry` = 29407;
-- OLD name : Налетчик из Гарма
-- Source : https://www.wowhead.com/wotlk/ru/npc=29408
UPDATE `creature_template_locale` SET `Name` = '[Garm Raider]' WHERE `locale` = 'ruRU' AND `entry` = 29408;
-- OLD name : Summon Tester
-- Source : https://www.wowhead.com/wotlk/ru/npc=29423
UPDATE `creature_template_locale` SET `Name` = '[Summon Tester]' WHERE `locale` = 'ruRU' AND `entry` = 29423;
-- OLD name : Sybil (Unarmed) - Deprecated
-- Source : https://www.wowhead.com/wotlk/ru/npc=29435
UPDATE `creature_template_locale` SET `Name` = '[Sybil (Unarmed) - Deprecated]' WHERE `locale` = 'ruRU' AND `entry` = 29435;
-- OLD name : Лейтенант Крегор, subname : Серебряный Рассвет
-- Source : https://www.wowhead.com/wotlk/ru/npc=29442
UPDATE `creature_template_locale` SET `Name` = '[Lieutenant Kregor]',`Title` = '[The Argent Dawn]' WHERE `locale` = 'ruRU' AND `entry` = 29442;
-- OLD name : Тролль Драккари
-- Source : https://www.wowhead.com/wotlk/ru/npc=29471
UPDATE `creature_template_locale` SET `Name` = '[Drakkari Troll]' WHERE `locale` = 'ruRU' AND `entry` = 29471;
-- OLD name : Рыцарь Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=29472
UPDATE `creature_template_locale` SET `Name` = '[Argent Crusader]' WHERE `locale` = 'ruRU' AND `entry` = 29472;
-- OLD name : Верховой грифон-скелет
-- Source : https://www.wowhead.com/wotlk/ru/npc=29474
UPDATE `creature_template_locale` SET `Name` = '[Riding Skeletal Gryphon]' WHERE `locale` = 'ruRU' AND `entry` = 29474;
-- OLD name : Ручной скунс
-- Source : https://www.wowhead.com/wotlk/ru/npc=29482
UPDATE `creature_template_locale` SET `Name` = '[Pet Skunk]' WHERE `locale` = 'ruRU' AND `entry` = 29482;
-- OLD subname : Specialty Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=29493
UPDATE `creature_template_locale` SET `Title` = 'Продавец особых боеприпасов' WHERE `locale` = 'ruRU' AND `entry` = 29493;
-- OLD name : Шен Кан Чэн
-- Source : https://www.wowhead.com/wotlk/ru/npc=29494
UPDATE `creature_template_locale` SET `Name` = 'Шен Кан Чен' WHERE `locale` = 'ruRU' AND `entry` = 29494;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=29505
UPDATE `creature_template_locale` SET `Title` = 'Учитель оружейников' WHERE `locale` = 'ruRU' AND `entry` = 29505;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=29506
UPDATE `creature_template_locale` SET `Title` = 'Учитель отковки брони' WHERE `locale` = 'ruRU' AND `entry` = 29506;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=29507
UPDATE `creature_template_locale` SET `Title` = 'Учитель кожевничества: сила стихий' WHERE `locale` = 'ruRU' AND `entry` = 29507;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=29508
UPDATE `creature_template_locale` SET `Title` = 'Учитель кожевничества: чешуя дракона' WHERE `locale` = 'ruRU' AND `entry` = 29508;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=29509
UPDATE `creature_template_locale` SET `Title` = 'Учитель кожевничества: традиции предков' WHERE `locale` = 'ruRU' AND `entry` = 29509;
-- OLD subname : Учитель гоблинского инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=29513
UPDATE `creature_template_locale` SET `Title` = 'Наставница в гоблинской инженерии' WHERE `locale` = 'ruRU' AND `entry` = 29513;
-- OLD subname : Учитель гномского инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=29514
UPDATE `creature_template_locale` SET `Title` = 'Наставник в гномской инженерии' WHERE `locale` = 'ruRU' AND `entry` = 29514;
-- OLD name : Ледяной змеедракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=29522
UPDATE `creature_template_locale` SET `Name` = '[Frost Wyrm Raptor]' WHERE `locale` = 'ruRU' AND `entry` = 29522;
-- OLD name : Mammoth Meat Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29524
UPDATE `creature_template_locale` SET `Name` = '[Mammoth Meat Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29524;
-- OLD name : Sholazar Daily Test NPC
-- Source : https://www.wowhead.com/wotlk/ru/npc=29526
UPDATE `creature_template_locale` SET `Name` = '[Sholazar Daily Test NPC]' WHERE `locale` = 'ruRU' AND `entry` = 29526;
-- OLD name : Наргл Гибкошнур, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=29539
UPDATE `creature_template_locale` SET `Name` = '[Nargle Lashcord]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 29539;
-- OLD name : Ксази Смолюга, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=29540
UPDATE `creature_template_locale` SET `Name` = '[Xazi Smolderpipe]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 29540;
-- OLD name : Зом Боком, subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=29541
UPDATE `creature_template_locale` SET `Name` = '[Zom Bocom]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 29541;
-- OLD subname : Продавец фруктов
-- Source : https://www.wowhead.com/wotlk/ru/npc=29547
UPDATE `creature_template_locale` SET `Title` = 'Торговец фруктами' WHERE `locale` = 'ruRU' AND `entry` = 29547;
-- OLD name : Arete's Gate Summoned Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29550
UPDATE `creature_template_locale` SET `Name` = '[Arete''s Gate Summoned Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29550;
-- OLD name : Налетчик из Гарма
-- Source : https://www.wowhead.com/wotlk/ru/npc=29552
UPDATE `creature_template_locale` SET `Name` = '[Garm Raider]' WHERE `locale` = 'ruRU' AND `entry` = 29552;
-- OLD name : Лучник штормградского порта
-- Source : https://www.wowhead.com/wotlk/ru/npc=29578
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Harbor Archer]' WHERE `locale` = 'ruRU' AND `entry` = 29578;
-- OLD name : Гнилостный протодракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=29590
UPDATE `creature_template_locale` SET `Name` = 'Чумной протодракон' WHERE `locale` = 'ruRU' AND `entry` = 29590;
-- OLD name : Валькирионский наездник на драконе
-- Source : https://www.wowhead.com/wotlk/ru/npc=29591
UPDATE `creature_template_locale` SET `Name` = '[Valkyrion Drake-Rider]' WHERE `locale` = 'ruRU' AND `entry` = 29591;
-- OLD name : Frostworg KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29595
UPDATE `creature_template_locale` SET `Name` = '[Frostworg KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29595;
-- OLD name : Frost Giant KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29597
UPDATE `creature_template_locale` SET `Name` = '[Frost Giant KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29597;
-- OLD name : Бролл Медвежья Шкура
-- Source : https://www.wowhead.com/wotlk/ru/npc=29604
UPDATE `creature_template_locale` SET `Name` = '[Broll Bearmantle]' WHERE `locale` = 'ruRU' AND `entry` = 29604;
-- OLD name : Валира Сангвинар
-- Source : https://www.wowhead.com/wotlk/ru/npc=29607
UPDATE `creature_template_locale` SET `Name` = '[Valeera Sanguinar]' WHERE `locale` = 'ruRU' AND `entry` = 29607;
-- OLD name : Джорвирган
-- Source : https://www.wowhead.com/wotlk/ru/npc=29610
UPDATE `creature_template_locale` SET `Name` = '[Jorwyrgan]' WHERE `locale` = 'ruRU' AND `entry` = 29610;
-- OLD name : Icefang TEST
-- Source : https://www.wowhead.com/wotlk/ru/npc=29616
UPDATE `creature_template_locale` SET `Name` = '[Icefang TEST]' WHERE `locale` = 'ruRU' AND `entry` = 29616;
-- OLD name : Grand Admiral Westwind Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29627
UPDATE `creature_template_locale` SET `Name` = '[Grand Admiral Westwind Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29627;
-- OLD name : Owen Test Creature
-- Source : https://www.wowhead.com/wotlk/ru/npc=29629
UPDATE `creature_template_locale` SET `Name` = '[Owen Test Creature]' WHERE `locale` = 'ruRU' AND `entry` = 29629;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=29631
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 29631;
-- OLD name : Механический костюм ZX-5103
-- Source : https://www.wowhead.com/wotlk/ru/npc=29645
UPDATE `creature_template_locale` SET `Name` = '[Mechanical Suit ZX-5103]' WHERE `locale` = 'ruRU' AND `entry` = 29645;
-- OLD name : Гал'дарайский люторог, subname : Верховный пророк Акали
-- Source : https://www.wowhead.com/wotlk/ru/npc=29681
UPDATE `creature_template_locale` SET `Name` = '[Gal''darah Rhino]',`Title` = '[High Prophet of Akali]' WHERE `locale` = 'ruRU' AND `entry` = 29681;
-- OLD name : WotLK City Attacks Ice Block Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29685
UPDATE `creature_template_locale` SET `Name` = '[WotLK City Attacks Ice Block Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29685;
-- OLD name : Скакун Алого Натиска
-- Source : https://www.wowhead.com/wotlk/ru/npc=29710
UPDATE `creature_template_locale` SET `Name` = 'Боевой конь Алого Натиска' WHERE `locale` = 'ruRU' AND `entry` = 29710;
-- OLD name : Мей
-- Source : https://www.wowhead.com/wotlk/ru/npc=29711
UPDATE `creature_template_locale` SET `Name` = '[Mei]' WHERE `locale` = 'ruRU' AND `entry` = 29711;
-- OLD name : Скиззл Ухомах
-- Source : https://www.wowhead.com/wotlk/ru/npc=29721
UPDATE `creature_template_locale` SET `Name` = 'Скиззл Гладкоезд' WHERE `locale` = 'ruRU' AND `entry` = 29721;
-- OLD name : Мастер топора из клана Зиморожденных
-- Source : https://www.wowhead.com/wotlk/ru/npc=29729
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по топорам из клана Зиморожденных' WHERE `locale` = 'ruRU' AND `entry` = 29729;
-- OLD name : Освобожденная бруннхильдарка, subname : PH Texture
-- Source : https://www.wowhead.com/wotlk/ru/npc=29734
UPDATE `creature_template_locale` SET `Name` = '[Liberated Brunnhildar]',`Title` = '[PH Texture]' WHERE `locale` = 'ruRU' AND `entry` = 29734;
-- OLD name : Взбешенный ворг
-- Source : https://www.wowhead.com/wotlk/ru/npc=29735
UPDATE `creature_template_locale` SET `Name` = 'Дикий ворг' WHERE `locale` = 'ruRU' AND `entry` = 29735;
-- OLD name : Бочка веселухи
-- Source : https://www.wowhead.com/wotlk/ru/npc=29737
UPDATE `creature_template_locale` SET `Name` = '[Barrel o'' Fun]' WHERE `locale` = 'ruRU' AND `entry` = 29737;
-- OLD name : Moorabi Mammoth Visual, subname : Верховный пророк Ман'тота
-- Source : https://www.wowhead.com/wotlk/ru/npc=29741
UPDATE `creature_template_locale` SET `Name` = '[Moorabi Mammoth Visual]',`Title` = '[High Prophet of Man''toth]' WHERE `locale` = 'ruRU' AND `entry` = 29741;
-- OLD name : Моргана Дневной Свет, subname : Распорядитель полетов
-- Source : https://www.wowhead.com/wotlk/ru/npc=29749
UPDATE `creature_template_locale` SET `Name` = '[Morgana Dayblaze]',`Title` = '[Flight Master]' WHERE `locale` = 'ruRU' AND `entry` = 29749;
-- OLD name : Веранус
-- Source : https://www.wowhead.com/wotlk/ru/npc=29756
UPDATE `creature_template_locale` SET `Name` = '[Veranus]' WHERE `locale` = 'ruRU' AND `entry` = 29756;
-- OLD name : Cosmetic Totem Horde Air
-- Source : https://www.wowhead.com/wotlk/ru/npc=29758
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Totem Horde Air]' WHERE `locale` = 'ruRU' AND `entry` = 29758;
-- OLD name : Cosmetic Totem Horde Earth
-- Source : https://www.wowhead.com/wotlk/ru/npc=29759
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Totem Horde Earth]' WHERE `locale` = 'ruRU' AND `entry` = 29759;
-- OLD name : Cosmetic Totem Horde Fire
-- Source : https://www.wowhead.com/wotlk/ru/npc=29760
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Totem Horde Fire]' WHERE `locale` = 'ruRU' AND `entry` = 29760;
-- OLD name : Cosmetic Totem Horde Water
-- Source : https://www.wowhead.com/wotlk/ru/npc=29761
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Totem Horde Water]' WHERE `locale` = 'ruRU' AND `entry` = 29761;
-- OLD name : Spectral Gryphon, Mount
-- Source : https://www.wowhead.com/wotlk/ru/npc=29767
UPDATE `creature_template_locale` SET `Name` = '[Spectral Gryphon, Mount]' WHERE `locale` = 'ruRU' AND `entry` = 29767;
-- OLD name : ELM General Purpose Bunny Large (Phase I)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29773
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny Large (Phase I)]' WHERE `locale` = 'ruRU' AND `entry` = 29773;
-- OLD name : Wisp, Ghost Mount
-- Source : https://www.wowhead.com/wotlk/ru/npc=29776
UPDATE `creature_template_locale` SET `Name` = '[Wisp, Ghost Mount]' WHERE `locale` = 'ruRU' AND `entry` = 29776;
-- OLD name : The Ocular - Eye of C'Thun Transform
-- Source : https://www.wowhead.com/wotlk/ru/npc=29789
UPDATE `creature_template_locale` SET `Name` = '[The Ocular - Eye of C''Thun Transform]' WHERE `locale` = 'ruRU' AND `entry` = 29789;
-- OLD name : Наездница на драконе Круга хильд
-- Source : https://www.wowhead.com/wotlk/ru/npc=29800
UPDATE `creature_template_locale` SET `Name` = '[Hyldsmeet Drake-Rider Credit]' WHERE `locale` = 'ruRU' AND `entry` = 29800;
-- OLD name : The Ocular Destroyed Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29803
UPDATE `creature_template_locale` SET `Name` = '[The Ocular Destroyed Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29803;
-- OLD name : Усовершенствованный экзоскелет Рида
-- Source : https://www.wowhead.com/wotlk/ru/npc=29810
UPDATE `creature_template_locale` SET `Name` = '[Reed''s Enhanced Exoskeleton]' WHERE `locale` = 'ruRU' AND `entry` = 29810;
-- OLD name : Наксрамасский конь смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=29814
UPDATE `creature_template_locale` SET `Name` = '[Naxxramas Deathcharger]' WHERE `locale` = 'ruRU' AND `entry` = 29814;
-- OLD name : Chain Swing Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29815
UPDATE `creature_template_locale` SET `Name` = '[Chain Swing Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29815;
-- OLD name : Eagle Feeding Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=29816
UPDATE `creature_template_locale` SET `Name` = '[Eagle Feeding Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 29816;
-- OLD name : Жеребец смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=29818
UPDATE `creature_template_locale` SET `Name` = 'Конь смерти-жеребец' WHERE `locale` = 'ruRU' AND `entry` = 29818;
-- OLD name : Мердл, subname : Гордость и радость Свечекрута
-- Source : https://www.wowhead.com/wotlk/ru/npc=29841
UPDATE `creature_template_locale` SET `Name` = '[Merdle]',`Title` = '[Sparksocket''s Pride and Joy]' WHERE `locale` = 'ruRU' AND `entry` = 29841;
-- OLD name : Vile Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29845
UPDATE `creature_template_locale` SET `Name` = '[Vile Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29845;
-- OLD name : Lady Nightswood Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29846
UPDATE `creature_template_locale` SET `Name` = '[Lady Nightswood Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29846;
-- OLD name : The Leaper Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=29847
UPDATE `creature_template_locale` SET `Name` = '[The Leaper Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 29847;
-- OLD name : Ло'гош, subname : Призрачный волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=29850
UPDATE `creature_template_locale` SET `Name` = '[Lo''Gosh]',`Title` = '[The Ghost Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 29850;
-- OLD name : Непоколебимость
-- Source : https://www.wowhead.com/wotlk/ru/npc=29863
UPDATE `creature_template_locale` SET `Name` = 'Упорство' WHERE `locale` = 'ruRU' AND `entry` = 29863;
-- OLD name : Lordaeron Knight Specimen
-- Source : https://www.wowhead.com/wotlk/ru/npc=29864
UPDATE `creature_template_locale` SET `Name` = '[Lordaeron Knight Specimen]' WHERE `locale` = 'ruRU' AND `entry` = 29864;
-- OLD name : Persistence Waypoint 00
-- Source : https://www.wowhead.com/wotlk/ru/npc=29870
UPDATE `creature_template_locale` SET `Name` = '[Persistence Waypoint 00]' WHERE `locale` = 'ruRU' AND `entry` = 29870;
-- OLD name : Persistence Waypoint 01
-- Source : https://www.wowhead.com/wotlk/ru/npc=29871
UPDATE `creature_template_locale` SET `Name` = '[Persistence Waypoint 01]' WHERE `locale` = 'ruRU' AND `entry` = 29871;
-- OLD name : ELM General Purpose Bunny (Phase I)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29876
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny (Phase I)]' WHERE `locale` = 'ruRU' AND `entry` = 29876;
-- OLD name : ELM General Purpose Bunny (scale x0.01 - Phase I) Large
-- Source : https://www.wowhead.com/wotlk/ru/npc=29877
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny (scale x0.01 - Phase I) Large]' WHERE `locale` = 'ruRU' AND `entry` = 29877;
-- OLD name : Log Ride (Log A)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29878
UPDATE `creature_template_locale` SET `Name` = '[Log Ride (Log A)]' WHERE `locale` = 'ruRU' AND `entry` = 29878;
-- OLD name : Log Ride (Log B)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29879
UPDATE `creature_template_locale` SET `Name` = '[Log Ride (Log B)]' WHERE `locale` = 'ruRU' AND `entry` = 29879;
-- OLD name : Спутник Варгула
-- Source : https://www.wowhead.com/wotlk/ru/npc=29882
UPDATE `creature_template_locale` SET `Name` = '[Vargul Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 29882;
-- OLD name : Kyle's Test Vehicle
-- Source : https://www.wowhead.com/wotlk/ru/npc=29883
UPDATE `creature_template_locale` SET `Name` = '[Kyle''s Test Vehicle]' WHERE `locale` = 'ruRU' AND `entry` = 29883;
-- OLD name : Captive Vrykul Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=29886
UPDATE `creature_template_locale` SET `Name` = '[Exhausted Vrykul Credit]' WHERE `locale` = 'ruRU' AND `entry` = 29886;
-- OLD name : Братья бури
-- Source : https://www.wowhead.com/wotlk/ru/npc=29896
UPDATE `creature_template_locale` SET `Name` = '[Brothers of the Storm]' WHERE `locale` = 'ruRU' AND `entry` = 29896;
-- OLD name : Kill Credit Test
-- Source : https://www.wowhead.com/wotlk/ru/npc=29902
UPDATE `creature_template_locale` SET `Name` = '[Kill Credit Test]' WHERE `locale` = 'ruRU' AND `entry` = 29902;
-- OLD name : Dan's Test Dummy (Large AOI)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29913
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Dummy (Large AOI)]' WHERE `locale` = 'ruRU' AND `entry` = 29913;
-- OLD name : GGOODMAN 2
-- Source : https://www.wowhead.com/wotlk/ru/npc=29921
UPDATE `creature_template_locale` SET `Name` = '[GGOODMAN 2]' WHERE `locale` = 'ruRU' AND `entry` = 29921;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=29924
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 29924;
-- OLD subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=29926
UPDATE `creature_template_locale` SET `Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 29926;
-- OLD name : Мотоцикл Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=29930
UPDATE `creature_template_locale` SET `Name` = '[Alliance Motorcycle]' WHERE `locale` = 'ruRU' AND `entry` = 29930;
-- OLD name : Боров, subname : PH: Name, Model
-- Source : https://www.wowhead.com/wotlk/ru/npc=29933
UPDATE `creature_template_locale` SET `Name` = '[The Hog]',`Title` = '[PH: Name, Model]' WHERE `locale` = 'ruRU' AND `entry` = 29933;
-- OLD name : Верховой ледяной змей Алгара
-- Source : https://www.wowhead.com/wotlk/ru/npc=29936
UPDATE `creature_template_locale` SET `Name` = '[Algar''s Frost Wyrm Mount]' WHERE `locale` = 'ruRU' AND `entry` = 29936;
-- OLD name : Верховая черепаха клыкарров
-- Source : https://www.wowhead.com/wotlk/ru/npc=29938
UPDATE `creature_template_locale` SET `Name` = '[Tuskarr Land Mount]' WHERE `locale` = 'ruRU' AND `entry` = 29938;
-- OLD name : SCOURGE PROXY (PHASED)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29943
UPDATE `creature_template_locale` SET `Name` = '[SCOURGE PROXY (PHASED)]' WHERE `locale` = 'ruRU' AND `entry` = 29943;
-- OLD name : Защитник Оргриммара
-- Source : https://www.wowhead.com/wotlk/ru/npc=29949
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Defender]' WHERE `locale` = 'ruRU' AND `entry` = 29949;
-- OLD name : Хоргору Сборщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=29962
UPDATE `creature_template_locale` SET `Name` = 'Норгору Сборщик' WHERE `locale` = 'ruRU' AND `entry` = 29962;
-- OLD subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=29971
UPDATE `creature_template_locale` SET `Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 29971;
-- OLD name : Хейлин
-- Source : https://www.wowhead.com/wotlk/ru/npc=29977
UPDATE `creature_template_locale` SET `Name` = '[Haylin]' WHERE `locale` = 'ruRU' AND `entry` = 29977;
-- OLD name : Земельник-дозорный
-- Source : https://www.wowhead.com/wotlk/ru/npc=29981
UPDATE `creature_template_locale` SET `Name` = 'Земельник-страж-смотритель' WHERE `locale` = 'ruRU' AND `entry` = 29981;
-- OLD name : The Lich King (Icecrown)
-- Source : https://www.wowhead.com/wotlk/ru/npc=29983
UPDATE `creature_template_locale` SET `Name` = '[The Lich King (Icecrown)]' WHERE `locale` = 'ruRU' AND `entry` = 29983;
-- OLD name : Void Zone X
-- Source : https://www.wowhead.com/wotlk/ru/npc=29992
UPDATE `creature_template_locale` SET `Name` = '[Void Zone X]' WHERE `locale` = 'ruRU' AND `entry` = 29992;
-- OLD name : Железный дворф-призыватель
-- Source : https://www.wowhead.com/wotlk/ru/npc=29995
UPDATE `creature_template_locale` SET `Name` = '[Iron Dwarf Summoner]' WHERE `locale` = 'ruRU' AND `entry` = 29995;
-- OLD name : Оскверненная земля V
-- Source : https://www.wowhead.com/wotlk/ru/npc=29998
UPDATE `creature_template_locale` SET `Name` = '[Desecrated Ground V]' WHERE `locale` = 'ruRU' AND `entry` = 29998;
-- OLD name : Турбореактивный дистанционно-управляемый гиро-бомбометатель смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=30004
UPDATE `creature_template_locale` SET `Name` = '[Turbo-propelled Remote-controlled Gyro Bomber of Death]' WHERE `locale` = 'ruRU' AND `entry` = 30004;
-- OLD subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=30005
UPDATE `creature_template_locale` SET `Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 30005;
-- OLD name : Грозовестник
-- Source : https://www.wowhead.com/wotlk/ru/npc=30013
UPDATE `creature_template_locale` SET `Name` = 'Орел-грозовестник' WHERE `locale` = 'ruRU' AND `entry` = 30013;
-- OLD subname : Чемпион племени Ледяной Секиры
-- Source : https://www.wowhead.com/wotlk/ru/npc=30023
UPDATE `creature_template_locale` SET `Title` = 'Герой Секиры Зимы' WHERE `locale` = 'ruRU' AND `entry` = 30023;
-- OLD name : Чумной зомби
-- Source : https://www.wowhead.com/wotlk/ru/npc=30032
UPDATE `creature_template_locale` SET `Name` = '[Plague Zombie]' WHERE `locale` = 'ruRU' AND `entry` = 30032;
-- OLD name : Чумной зомби
-- Source : https://www.wowhead.com/wotlk/ru/npc=30033
UPDATE `creature_template_locale` SET `Name` = '[Plague Zombie]' WHERE `locale` = 'ruRU' AND `entry` = 30033;
-- OLD name : Чумной зомби
-- Source : https://www.wowhead.com/wotlk/ru/npc=30034
UPDATE `creature_template_locale` SET `Name` = '[Plague Zombie]' WHERE `locale` = 'ruRU' AND `entry` = 30034;
-- OLD name : Mjordin Combatant Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30038
UPDATE `creature_template_locale` SET `Name` = '[Mjordin Combatant Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30038;
-- OLD name : Earthen Stone State
-- Source : https://www.wowhead.com/wotlk/ru/npc=30050
UPDATE `creature_template_locale` SET `Name` = '[Earthen Stone State]' WHERE `locale` = 'ruRU' AND `entry` = 30050;
-- OLD name : Ледяной шар
-- Source : https://www.wowhead.com/wotlk/ru/npc=30054
UPDATE `creature_template_locale` SET `Name` = '[Frozen Orb]' WHERE `locale` = 'ruRU' AND `entry` = 30054;
-- OLD name : Змей Грозовой Гряды
-- Source : https://www.wowhead.com/wotlk/ru/npc=30055
UPDATE `creature_template_locale` SET `Name` = '[Stormpeak Wyrm]' WHERE `locale` = 'ruRU' AND `entry` = 30055;
-- OLD name : Wyrmrest Warden Visual (Bronze)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30059
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Warden Visual (Bronze)]' WHERE `locale` = 'ruRU' AND `entry` = 30059;
-- OLD name : Усилитель магии из клана Закаленных Бурей
-- Source : https://www.wowhead.com/wotlk/ru/npc=30062
UPDATE `creature_template_locale` SET `Name` = '[Stormforged Amplifier]' WHERE `locale` = 'ruRU' AND `entry` = 30062;
-- OLD name : Мастер топора из клана Зиморожденных
-- Source : https://www.wowhead.com/wotlk/ru/npc=30065
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по топорам из клана Зиморожденных' WHERE `locale` = 'ruRU' AND `entry` = 30065;
-- OLD name : Wyrmrest Warden Visual (Red)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30072
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Warden Visual (Red)]' WHERE `locale` = 'ruRU' AND `entry` = 30072;
-- OLD name : Wyrmrest Warden Visual (Green)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30073
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Warden Visual (Green)]' WHERE `locale` = 'ruRU' AND `entry` = 30073;
-- OLD name : Wyrmrest Warden Visual (Blue)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30076
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Warden Visual (Blue)]' WHERE `locale` = 'ruRU' AND `entry` = 30076;
-- OLD name : Wyrmrest Warden Visual (Black)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30077
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Warden Visual (Black)]' WHERE `locale` = 'ruRU' AND `entry` = 30077;
-- OLD name : ELM General Purpose Bunny (Phase II)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30079
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny (Phase II)]' WHERE `locale` = 'ruRU' AND `entry` = 30079;
-- OLD name : Виллзикс
-- Source : https://www.wowhead.com/wotlk/ru/npc=30080
UPDATE `creature_template_locale` SET `Name` = '[Willzyx]' WHERE `locale` = 'ruRU' AND `entry` = 30080;
-- OLD name : Brokentoe (Mount)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30088
UPDATE `creature_template_locale` SET `Name` = '[Brokentoe (Mount)]' WHERE `locale` = 'ruRU' AND `entry` = 30088;
-- OLD name : Mammoth Mount (Small)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30089
UPDATE `creature_template_locale` SET `Name` = '[Mammoth Mount (Small)]' WHERE `locale` = 'ruRU' AND `entry` = 30089;
-- OLD name : WotLK City Attacks Ice Block Bunny, Small
-- Source : https://www.wowhead.com/wotlk/ru/npc=30101
UPDATE `creature_template_locale` SET `Name` = '[WotLK City Attacks Ice Block Bunny, Small]' WHERE `locale` = 'ruRU' AND `entry` = 30101;
-- OLD name : Сумеречный верующий
-- Source : https://www.wowhead.com/wotlk/ru/npc=30111
UPDATE `creature_template_locale` SET `Name` = 'Верующий из культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 30111;
-- OLD name : Сумеречный посвященный
-- Source : https://www.wowhead.com/wotlk/ru/npc=30114
UPDATE `creature_template_locale` SET `Name` = 'Посвященный культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 30114;
-- OLD name : Vengeful Revenant KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30125
UPDATE `creature_template_locale` SET `Name` = '[Vengeful Revenant KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30125;
-- OLD name : Njormeld KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30126
UPDATE `creature_template_locale` SET `Name` = '[Njormeld KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30126;
-- OLD name : Veranus Right Foot Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30130
UPDATE `creature_template_locale` SET `Name` = '[Veranus Right Foot Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30130;
-- OLD name : Veranus Left Foot Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30131
UPDATE `creature_template_locale` SET `Name` = '[Veranus Left Foot Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30131;
-- OLD name : Veranus Right Wing Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30132
UPDATE `creature_template_locale` SET `Name` = '[Veranus Right Wing Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30132;
-- OLD name : Veranus Left Wing Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30133
UPDATE `creature_template_locale` SET `Name` = '[Veranus Left Wing Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30133;
-- OLD name : Frost Giant Ghost KC
-- Source : https://www.wowhead.com/wotlk/ru/npc=30138
UPDATE `creature_template_locale` SET `Name` = '[Frost Giant Ghost KC]' WHERE `locale` = 'ruRU' AND `entry` = 30138;
-- OLD name : Frost Dwarf Ghost KC
-- Source : https://www.wowhead.com/wotlk/ru/npc=30139
UPDATE `creature_template_locale` SET `Name` = '[Frost Dwarf Ghost KC]' WHERE `locale` = 'ruRU' AND `entry` = 30139;
-- OLD name : Frostborn Floating Spirit
-- Source : https://www.wowhead.com/wotlk/ru/npc=30145
UPDATE `creature_template_locale` SET `Name` = 'Frostborn Floating Spirit 01' WHERE `locale` = 'ruRU' AND `entry` = 30145;
-- OLD name : Демо, сектант Ледяной Короны, subname : Культ Проклятых
-- Source : https://www.wowhead.com/wotlk/ru/npc=30149
UPDATE `creature_template_locale` SET `Name` = '[Demo, Icecrown Cultist]',`Title` = '[Cult of the Damned]' WHERE `locale` = 'ruRU' AND `entry` = 30149;
-- OLD name : Ледяной дракон-разрушитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=30150
UPDATE `creature_template_locale` SET `Name` = '[Frostbrood Destroyer]' WHERE `locale` = 'ruRU' AND `entry` = 30150;
-- OLD name : Last Chapter Dialogue Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30153
UPDATE `creature_template_locale` SET `Name` = '[Last Chapter Dialogue Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30153;
-- OLD name : Механогном-труженик
-- Source : https://www.wowhead.com/wotlk/ru/npc=30170
UPDATE `creature_template_locale` SET `Name` = 'Мехагном-работник' WHERE `locale` = 'ruRU' AND `entry` = 30170;
-- OLD name : Военачальник Арены Доблести, subname : Полководец
-- Source : https://www.wowhead.com/wotlk/ru/npc=30171
UPDATE `creature_template_locale` SET `Name` = '[The Ring of Valor Battlemaster]',`Title` = '[Battle Master]' WHERE `locale` = 'ruRU' AND `entry` = 30171;
-- OLD name : Сумеречный апостол
-- Source : https://www.wowhead.com/wotlk/ru/npc=30179
UPDATE `creature_template_locale` SET `Name` = 'Апостол культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 30179;
-- OLD name : G'eras Test Vendor List
-- Source : https://www.wowhead.com/wotlk/ru/npc=30201
UPDATE `creature_template_locale` SET `Name` = '[G''eras Test Vendor List]' WHERE `locale` = 'ruRU' AND `entry` = 30201;
-- OLD name : Hodir's Helm KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30210
UPDATE `creature_template_locale` SET `Name` = '[Hodir''s Helm KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30210;
-- OLD name : Южная штормовая кузня
-- Source : https://www.wowhead.com/wotlk/ru/npc=30212
UPDATE `creature_template_locale` SET `Name` = 'Южная штормовая кузница' WHERE `locale` = 'ruRU' AND `entry` = 30212;
-- OLD name : Thrall's Big Hit, Lightning Bolt Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30214
UPDATE `creature_template_locale` SET `Name` = '[Thrall''s Big Hit, Lightning Bolt Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30214;
-- OLD name : Leave Our Mark Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30220
UPDATE `creature_template_locale` SET `Name` = '[Leave Our Mark Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30220;
-- OLD name : Kirgaraak Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=30221
UPDATE `creature_template_locale` SET `Name` = '[Kirgaraak Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 30221;
-- OLD name : Верховой ледочрев
-- Source : https://www.wowhead.com/wotlk/ru/npc=30229
UPDATE `creature_template_locale` SET `Name` = '[Icemaw Bear Mount]' WHERE `locale` = 'ruRU' AND `entry` = 30229;
-- OLD name : Раненая разведчица Похитителей Солнца
-- Source : https://www.wowhead.com/wotlk/ru/npc=30240
UPDATE `creature_template_locale` SET `Name` = '[Injured Sunreaver Scout]' WHERE `locale` = 'ruRU' AND `entry` = 30240;
-- OLD name : Раненый разведчик Серебряного союза
-- Source : https://www.wowhead.com/wotlk/ru/npc=30266
UPDATE `creature_template_locale` SET `Name` = '[Injured Silver Covenant Scout]' WHERE `locale` = 'ruRU' AND `entry` = 30266;
-- OLD name : Глубинный ползун
-- Source : https://www.wowhead.com/wotlk/ru/npc=30279
UPDATE `creature_template_locale` SET `Name` = 'Глубинный паук' WHERE `locale` = 'ruRU' AND `entry` = 30279;
-- OLD name : Разъяренный бронированный гиппогриф
-- Source : https://www.wowhead.com/wotlk/ru/npc=30280
UPDATE `creature_template_locale` SET `Name` = '[Enraged Armored Hippogryph]' WHERE `locale` = 'ruRU' AND `entry` = 30280;
-- OLD name : Защитник штормградского порта
-- Source : https://www.wowhead.com/wotlk/ru/npc=30289
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Harbor Defender]' WHERE `locale` = 'ruRU' AND `entry` = 30289;
-- OLD name : Дракондор Похитителей Солнца
-- Source : https://www.wowhead.com/wotlk/ru/npc=30290
UPDATE `creature_template_locale` SET `Name` = '[Sunreaver Dragonhawk]' WHERE `locale` = 'ruRU' AND `entry` = 30290;
-- OLD name : Капитан штормградского порта
-- Source : https://www.wowhead.com/wotlk/ru/npc=30293
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Harbor Captain]' WHERE `locale` = 'ruRU' AND `entry` = 30293;
-- OLD name : Iron Sentinel Credit, subname : Слуга Локена
-- Source : https://www.wowhead.com/wotlk/ru/npc=30296
UPDATE `creature_template_locale` SET `Name` = '[Iron Sentinel Credit]',`Title` = '[Servant of Loken]' WHERE `locale` = 'ruRU' AND `entry` = 30296;
-- OLD name : Iron Dwarf Assailant Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=30297
UPDATE `creature_template_locale` SET `Name` = '[Iron Dwarf Assailant Credit]' WHERE `locale` = 'ruRU' AND `entry` = 30297;
-- OLD name : Стремительная летающая метла
-- Source : https://www.wowhead.com/wotlk/ru/npc=30305
UPDATE `creature_template_locale` SET `Name` = '[Swift Flying Broom]' WHERE `locale` = 'ruRU' AND `entry` = 30305;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=30311
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 30311;
-- OLD name : Сумеречный черный маг
-- Source : https://www.wowhead.com/wotlk/ru/npc=30319
UPDATE `creature_template_locale` SET `Name` = 'Черный маг культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 30319;
-- OLD name : Гнилап
-- Source : https://www.wowhead.com/wotlk/ru/npc=30326
UPDATE `creature_template_locale` SET `Name` = 'Гнилоклык' WHERE `locale` = 'ruRU' AND `entry` = 30326;
-- OLD name : Jokkum KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30327
UPDATE `creature_template_locale` SET `Name` = '[Jokkum KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30327;
-- OLD name : Торим
-- Source : https://www.wowhead.com/wotlk/ru/npc=30328
UPDATE `creature_template_locale` SET `Name` = '[Thorim]' WHERE `locale` = 'ruRU' AND `entry` = 30328;
-- OLD name : Frigid Tomb Controller Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30339
UPDATE `creature_template_locale` SET `Name` = '[Frigid Tomb Controller Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30339;
-- OLD name : Йормуттар
-- Source : https://www.wowhead.com/wotlk/ru/npc=30340
UPDATE `creature_template_locale` SET `Name` = 'Йоркуттар' WHERE `locale` = 'ruRU' AND `entry` = 30340;
-- OLD name : Командир Джастин Бартлетт
-- Source : https://www.wowhead.com/wotlk/ru/npc=30344
UPDATE `creature_template_locale` SET `Name` = 'Старший капитан Джастин Бартлетт' WHERE `locale` = 'ruRU' AND `entry` = 30344;
-- OLD name : Пехотинец с "Усмирителя небес"
-- Source : https://www.wowhead.com/wotlk/ru/npc=30352
UPDATE `creature_template_locale` SET `Name` = 'Пехотинец "Усмирителя небес"' WHERE `locale` = 'ruRU' AND `entry` = 30352;
-- OLD name : Wintergrasp Alliance Melee Guard
-- Source : https://www.wowhead.com/wotlk/ru/npc=30354
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Alliance Melee Guard]' WHERE `locale` = 'ruRU' AND `entry` = 30354;
-- OLD name : Wintergrasp Alliance Ranged Guard
-- Source : https://www.wowhead.com/wotlk/ru/npc=30355
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Alliance Ranged Guard]' WHERE `locale` = 'ruRU' AND `entry` = 30355;
-- OLD name : Мастер топора из клана Зиморожденных
-- Source : https://www.wowhead.com/wotlk/ru/npc=30356
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по топорам из клана Зиморожденных' WHERE `locale` = 'ruRU' AND `entry` = 30356;
-- OLD name : Сумеречный доброволец
-- Source : https://www.wowhead.com/wotlk/ru/npc=30385
UPDATE `creature_template_locale` SET `Name` = 'Доброволец культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 30385;
-- OLD name : Предок таунка
-- Source : https://www.wowhead.com/wotlk/ru/npc=30386
UPDATE `creature_template_locale` SET `Name` = '[Taunka Ancestor]' WHERE `locale` = 'ruRU' AND `entry` = 30386;
-- OLD name : Forgotten Depths Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=30402
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Depths Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 30402;
-- OLD subname : Правитель Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=30411
UPDATE `creature_template_locale` SET `Title` = 'Повелитель Стальгорна' WHERE `locale` = 'ruRU' AND `entry` = 30411;
-- OLD name : Deep in the Bowels of The Underhalls Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30412
UPDATE `creature_template_locale` SET `Name` = '[Deep in the Bowels of The Underhalls Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30412;
-- OLD name : Wild Wyrm KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30415
UPDATE `creature_template_locale` SET `Name` = '[Wild Wyrm KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30415;
-- OLD name : Лок'лира Карга
-- Source : https://www.wowhead.com/wotlk/ru/npc=30417
UPDATE `creature_template_locale` SET `Name` = '[Lok''lira the Crone]' WHERE `locale` = 'ruRU' AND `entry` = 30417;
-- OLD name : Roaming Jormungar KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30421
UPDATE `creature_template_locale` SET `Name` = '[Roaming Jormungar KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30421;
-- OLD name : Lady Sylvanas Windrunner (Test 01), subname : Королева банши
-- Source : https://www.wowhead.com/wotlk/ru/npc=30426
UPDATE `creature_template_locale` SET `Name` = '[Lady Sylvanas Windrunner (Test 01)]',`Title` = '[Banshee Queen]' WHERE `locale` = 'ruRU' AND `entry` = 30426;
-- OLD name : Lady Sylvanas Windrunner (Test 02), subname : Королева банши
-- Source : https://www.wowhead.com/wotlk/ru/npc=30427
UPDATE `creature_template_locale` SET `Name` = '[Lady Sylvanas Windrunner (Test 02)]',`Title` = '[Banshee Queen]' WHERE `locale` = 'ruRU' AND `entry` = 30427;
-- OLD name : Lady Sylvanas Windrunner (Test 03), subname : Королева банши
-- Source : https://www.wowhead.com/wotlk/ru/npc=30428
UPDATE `creature_template_locale` SET `Name` = '[Lady Sylvanas Windrunner (Test 03)]',`Title` = '[Banshee Queen]' WHERE `locale` = 'ruRU' AND `entry` = 30428;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=30437
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 30437;
-- OLD name : Работник Оплота
-- Source : https://www.wowhead.com/wotlk/ru/npc=30440
UPDATE `creature_template_locale` SET `Name` = '[Vanguard Laborer]' WHERE `locale` = 'ruRU' AND `entry` = 30440;
-- OLD name : Загруженный работник Оплота
-- Source : https://www.wowhead.com/wotlk/ru/npc=30441
UPDATE `creature_template_locale` SET `Name` = '[Burdened Vanguard Laborer]' WHERE `locale` = 'ruRU' AND `entry` = 30441;
-- OLD name : Ветролет Зака
-- Source : https://www.wowhead.com/wotlk/ru/npc=30463
UPDATE `creature_template_locale` SET `Name` = '[Zak''s Flying Machine]' WHERE `locale` = 'ruRU' AND `entry` = 30463;
-- OLD name : Макс "Честный"
-- Source : https://www.wowhead.com/wotlk/ru/npc=30464
UPDATE `creature_template_locale` SET `Name` = '"Честный" Макс' WHERE `locale` = 'ruRU' AND `entry` = 30464;
-- OLD name : Dan's Test Void Sentry
-- Source : https://www.wowhead.com/wotlk/ru/npc=30465
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Void Sentry]' WHERE `locale` = 'ruRU' AND `entry` = 30465;
-- OLD name : Lok'lira the Crone's Conversation Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=30467
UPDATE `creature_template_locale` SET `Name` = '[Lok''lira the Crone''s Conversation Credit]' WHERE `locale` = 'ruRU' AND `entry` = 30467;
-- OLD name : Ритцун
-- Source : https://www.wowhead.com/wotlk/ru/npc=30491
UPDATE `creature_template_locale` SET `Name` = '[Ritssyn]' WHERE `locale` = 'ruRU' AND `entry` = 30491;
-- OLD name : Крушитель из клана Закаленных Бурей
-- Source : https://www.wowhead.com/wotlk/ru/npc=30503
UPDATE `creature_template_locale` SET `Name` = '[Stormforged Decimator]' WHERE `locale` = 'ruRU' AND `entry` = 30503;
-- OLD name : Мастер топора из клана Зиморожденных
-- Source : https://www.wowhead.com/wotlk/ru/npc=30505
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по топорам из клана Зиморожденных' WHERE `locale` = 'ruRU' AND `entry` = 30505;
-- OLD name : Грозовестник
-- Source : https://www.wowhead.com/wotlk/ru/npc=30506
UPDATE `creature_template_locale` SET `Name` = 'Орел-грозовестник' WHERE `locale` = 'ruRU' AND `entry` = 30506;
-- OLD name : Кодо Хмельного фестиваля
-- Source : https://www.wowhead.com/wotlk/ru/npc=30507
UPDATE `creature_template_locale` SET `Name` = '[Brewfest Kodo]' WHERE `locale` = 'ruRU' AND `entry` = 30507;
-- OLD name : Thorim Talk KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30514
UPDATE `creature_template_locale` SET `Name` = '[Thorim Talk KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30514;
-- OLD name : Witness the Reckoning Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=30515
UPDATE `creature_template_locale` SET `Name` = '[Witness the Reckoning Credit]' WHERE `locale` = 'ruRU' AND `entry` = 30515;
-- OLD name : Training Dummy
-- Source : https://www.wowhead.com/wotlk/ru/npc=30527
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (30527, 'ruRU','[Training Dummy]',NULL);
-- OLD name : Фрас Сиаби
-- Source : https://www.wowhead.com/wotlk/ru/npc=30552
UPDATE `creature_template_locale` SET `Name` = 'Эзра Гримм' WHERE `locale` = 'ruRU' AND `entry` = 30552;
-- OLD name : Джессика Редпат
-- Source : https://www.wowhead.com/wotlk/ru/npc=30558
UPDATE `creature_template_locale` SET `Name` = '[Jessica Redpath]' WHERE `locale` = 'ruRU' AND `entry` = 30558;
-- OLD name : Ящик противопехотных мин
-- Source : https://www.wowhead.com/wotlk/ru/npc=30563
UPDATE `creature_template_locale` SET `Name` = '[Crate of Land Mines]' WHERE `locale` = 'ruRU' AND `entry` = 30563;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=30572
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 30572;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30578
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30578;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30580
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30580;
-- OLD name : Бугурда, subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30581
UPDATE `creature_template_locale` SET `Name` = '[Buhurda]',`Title` = '[Strand of the Ancients Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 30581;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30582
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30582;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30583
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30583;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30584
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30584;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30586
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30586;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30587
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30587;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30590
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30590;
-- OLD name : Spike Target
-- Source : https://www.wowhead.com/wotlk/ru/npc=30598
UPDATE `creature_template_locale` SET `Name` = '[Spike Target]' WHERE `locale` = 'ruRU' AND `entry` = 30598;
-- OLD subname : Arena Organizer
-- Source : https://www.wowhead.com/wotlk/ru/npc=30611
UPDATE `creature_template_locale` SET `Title` = 'Организатор боев на арене' WHERE `locale` = 'ruRU' AND `entry` = 30611;
-- OLD name : Кровавое жало, subname : Питомец Молога
-- Source : https://www.wowhead.com/wotlk/ru/npc=30613
UPDATE `creature_template_locale` SET `Name` = '[Bloodsting]',`Title` = '[Molog''s Pet]' WHERE `locale` = 'ruRU' AND `entry` = 30613;
-- OLD name : Spike Target 2
-- Source : https://www.wowhead.com/wotlk/ru/npc=30614
UPDATE `creature_template_locale` SET `Name` = '[Spike Target 2]' WHERE `locale` = 'ruRU' AND `entry` = 30614;
-- OLD name : Dan's Test Dummy (Non Vehicle)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30615
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Dummy (Non Vehicle)]' WHERE `locale` = 'ruRU' AND `entry` = 30615;
-- OLD name : NONE
-- Source : https://www.wowhead.com/wotlk/ru/npc=30618
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30618;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (30618, 'ruRU','[]',NULL);
-- OLD name : Батрак Озера Ледяных Оков
-- Source : https://www.wowhead.com/wotlk/ru/npc=30619
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Peon]' WHERE `locale` = 'ruRU' AND `entry` = 30619;
-- OLD name : Крестьянин Озера Ледяных Оков
-- Source : https://www.wowhead.com/wotlk/ru/npc=30626
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Peasant]' WHERE `locale` = 'ruRU' AND `entry` = 30626;
-- OLD name : Eye of Acherus (DK)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30628
UPDATE `creature_template_locale` SET `Name` = '[Eye of Acherus (DK)]' WHERE `locale` = 'ruRU' AND `entry` = 30628;
-- OLD name : Смертельная сущность
-- Source : https://www.wowhead.com/wotlk/ru/npc=30629
UPDATE `creature_template_locale` SET `Name` = '[Mortal Essence]' WHERE `locale` = 'ruRU' AND `entry` = 30629;
-- OLD name : The Art of Being a Water Terror Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30644
UPDATE `creature_template_locale` SET `Name` = '[The Art of Being a Water Terror Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30644;
-- OLD name : Shadron Portal Visual
-- Source : https://www.wowhead.com/wotlk/ru/npc=30650
UPDATE `creature_template_locale` SET `Name` = '[Shadron Portal Visual]' WHERE `locale` = 'ruRU' AND `entry` = 30650;
-- OLD name : Лазурный разрушитель заклятий
-- Source : https://www.wowhead.com/wotlk/ru/npc=30662
UPDATE `creature_template_locale` SET `Name` = 'Лазурный рушитель чар' WHERE `locale` = 'ruRU' AND `entry` = 30662;
-- OLD name : Лазурная чародейка
-- Source : https://www.wowhead.com/wotlk/ru/npc=30663
UPDATE `creature_template_locale` SET `Name` = 'Лазурный чароплет' WHERE `locale` = 'ruRU' AND `entry` = 30663;
-- OLD name : Scourge Proxy Chapter II
-- Source : https://www.wowhead.com/wotlk/ru/npc=30670
UPDATE `creature_template_locale` SET `Name` = '[Scourge Proxy Chapter II]' WHERE `locale` = 'ruRU' AND `entry` = 30670;
-- OLD name : Ионна Робертсон, subname : Информация
-- Source : https://www.wowhead.com/wotlk/ru/npc=30678
UPDATE `creature_template_locale` SET `Name` = '[Jonna Robertson]',`Title` = '[Directions]' WHERE `locale` = 'ruRU' AND `entry` = 30678;
-- OLD name : Огненная сфера
-- Source : https://www.wowhead.com/wotlk/ru/npc=30702
UPDATE `creature_template_locale` SET `Name` = 'Огненный шар' WHERE `locale` = 'ruRU' AND `entry` = 30702;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=30721
UPDATE `creature_template_locale` SET `Title` = 'Мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 30721;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=30722
UPDATE `creature_template_locale` SET `Title` = 'Мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 30722;
-- OLD name : Незашитый вурдалак
-- Source : https://www.wowhead.com/wotlk/ru/npc=30728
UPDATE `creature_template_locale` SET `Name` = '[Unspiked Ghoul]' WHERE `locale` = 'ruRU' AND `entry` = 30728;
-- OLD name : Tabard Faction Tester
-- Source : https://www.wowhead.com/wotlk/ru/npc=30738
UPDATE `creature_template_locale` SET `Name` = '[Tabard Faction Tester]' WHERE `locale` = 'ruRU' AND `entry` = 30738;
-- OLD name : Портал Шадрона
-- Source : https://www.wowhead.com/wotlk/ru/npc=30741
UPDATE `creature_template_locale` SET `Name` = '[Shadron Portal]' WHERE `locale` = 'ruRU' AND `entry` = 30741;
-- OLD name : Succubus Transform 01
-- Source : https://www.wowhead.com/wotlk/ru/npc=30743
UPDATE `creature_template_locale` SET `Name` = '[Succubus Transform 01]' WHERE `locale` = 'ruRU' AND `entry` = 30743;
-- OLD name : Through the Eye Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30750
UPDATE `creature_template_locale` SET `Name` = '[Through the Eye Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30750;
-- OLD name : Кор'кронский разоритель
-- Source : https://www.wowhead.com/wotlk/ru/npc=30755
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 30755;
-- OLD name : Телепорт в Чертоги Молний
-- Source : https://www.wowhead.com/wotlk/ru/npc=30828
UPDATE `creature_template_locale` SET `Name` = '[Halls of Lightning Teleporter]' WHERE `locale` = 'ruRU' AND `entry` = 30828;
-- OLD name : Покалеченная душа
-- Source : https://www.wowhead.com/wotlk/ru/npc=30843
UPDATE `creature_template_locale` SET `Name` = '[Severed Soul]' WHERE `locale` = 'ruRU' AND `entry` = 30843;
-- OLD name : Death Gate (Dummy)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30844
UPDATE `creature_template_locale` SET `Name` = '[Death Gate (Dummy)]' WHERE `locale` = 'ruRU' AND `entry` = 30844;
-- OLD name : Яростное пламя
-- Source : https://www.wowhead.com/wotlk/ru/npc=30847
UPDATE `creature_template_locale` SET `Name` = 'Бушующее пламя' WHERE `locale` = 'ruRU' AND `entry` = 30847;
-- OLD name : Гномолет
-- Source : https://www.wowhead.com/wotlk/ru/npc=30853
UPDATE `creature_template_locale` SET `Name` = '[Gnomish ''Chopper]' WHERE `locale` = 'ruRU' AND `entry` = 30853;
-- OLD name : Инженер Озера Ледяных Оков
-- Source : https://www.wowhead.com/wotlk/ru/npc=30855
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Engineer]' WHERE `locale` = 'ruRU' AND `entry` = 30855;
-- OLD name : Аура неуязвимости
-- Source : https://www.wowhead.com/wotlk/ru/npc=30874
UPDATE `creature_template_locale` SET `Name` = '[Invulnerability Aura]' WHERE `locale` = 'ruRU' AND `entry` = 30874;
-- OLD name : Find the Ancient Hero Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30880
UPDATE `creature_template_locale` SET `Name` = '[Find the Ancient Hero Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30880;
-- OLD subname : Старинная экипировка арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=30885
UPDATE `creature_template_locale` SET `Title` = 'Продавец воды' WHERE `locale` = 'ruRU' AND `entry` = 30885;
-- OLD name : QA Test Dummy 80 Hostile Low Damage, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=30888
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Hostile Low Damage]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 30888;
-- OLD name : Лазурная чародейка
-- Source : https://www.wowhead.com/wotlk/ru/npc=30918
UPDATE `creature_template_locale` SET `Name` = 'Лазурный чароплет' WHERE `locale` = 'ruRU' AND `entry` = 30918;
-- OLD name : Tenebron Egg (Twilight)
-- Source : https://www.wowhead.com/wotlk/ru/npc=30948
UPDATE `creature_template_locale` SET `Name` = '[Tenebron Egg (Twilight)]' WHERE `locale` = 'ruRU' AND `entry` = 30948;
-- OLD subname : Всадник крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=30953
UPDATE `creature_template_locale` SET `Title` = 'Наездник крови' WHERE `locale` = 'ruRU' AND `entry` = 30953;
-- OLD name : Лазурный разрушитель заклятий
-- Source : https://www.wowhead.com/wotlk/ru/npc=30962
UPDATE `creature_template_locale` SET `Name` = 'Лазурный рушитель чар' WHERE `locale` = 'ruRU' AND `entry` = 30962;
-- OLD name : CoT Stratholme - Crates KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=30996
UPDATE `creature_template_locale` SET `Name` = '[CoT Stratholme - Crates KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 30996;
-- OLD name : CoT Stratholme - Mal'Ganis KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=31006
UPDATE `creature_template_locale` SET `Name` = '[CoT Stratholme - Mal''Ganis KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 31006;
-- OLD name : Лазурная чародейка
-- Source : https://www.wowhead.com/wotlk/ru/npc=31007
UPDATE `creature_template_locale` SET `Name` = 'Лазурный чароплет' WHERE `locale` = 'ruRU' AND `entry` = 31007;
-- OLD name : Лазурный разрушитель заклятий
-- Source : https://www.wowhead.com/wotlk/ru/npc=31009
UPDATE `creature_template_locale` SET `Name` = 'Лазурный рушитель чар' WHERE `locale` = 'ruRU' AND `entry` = 31009;
-- OLD subname : Флорист
-- Source : https://www.wowhead.com/wotlk/ru/npc=31021
UPDATE `creature_template_locale` SET `Title` = 'Цветочник' WHERE `locale` = 'ruRU' AND `entry` = 31021;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=31025
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 31025;
-- OLD name : Анна Муни, subname : Официантка
-- Source : https://www.wowhead.com/wotlk/ru/npc=31026
UPDATE `creature_template_locale` SET `Name` = '[Anna Moony]',`Title` = '[Waitress]' WHERE `locale` = 'ruRU' AND `entry` = 31026;
-- OLD name : Душегуб Забытых Глубин
-- Source : https://www.wowhead.com/wotlk/ru/npc=31038
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Depths Slayer]' WHERE `locale` = 'ruRU' AND `entry` = 31038;
-- OLD name : Pack Mule (Chapter IV)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31046
UPDATE `creature_template_locale` SET `Name` = '[Pack Mule (Chapter IV)]' WHERE `locale` = 'ruRU' AND `entry` = 31046;
-- OLD name : ELM General Purpose Bunny Gigantic
-- Source : https://www.wowhead.com/wotlk/ru/npc=31047
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny Gigantic]' WHERE `locale` = 'ruRU' AND `entry` = 31047;
-- OLD name : Горящий скелет
-- Source : https://www.wowhead.com/wotlk/ru/npc=31048
UPDATE `creature_template_locale` SET `Name` = 'Пылающий скелет' WHERE `locale` = 'ruRU' AND `entry` = 31048;
-- OLD name : Лучник Рендольф
-- Source : https://www.wowhead.com/wotlk/ru/npc=31052
UPDATE `creature_template_locale` SET `Name` = 'Лучник Рандольф' WHERE `locale` = 'ruRU' AND `entry` = 31052;
-- OLD name : Гвардейский протодракон Балагарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=31056
UPDATE `creature_template_locale` SET `Name` = '[Balargarde Elite Proto-Drake]' WHERE `locale` = 'ruRU' AND `entry` = 31056;
-- OLD name : Crusade Architect Silas (Chapter IV)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31058
UPDATE `creature_template_locale` SET `Name` = '[Crusade Architect Silas (Chapter IV)]' WHERE `locale` = 'ruRU' AND `entry` = 31058;
-- OLD name : Russell Bernau Test NPC
-- Source : https://www.wowhead.com/wotlk/ru/npc=31060
UPDATE `creature_template_locale` SET `Name` = '[Russell Bernau Test NPC]' WHERE `locale` = 'ruRU' AND `entry` = 31060;
-- OLD name : Crusade Engineer Spitzpatrick (Chapter IV)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31061
UPDATE `creature_template_locale` SET `Name` = '[Crusade Engineer Spitzpatrick (Chapter IV)]' WHERE `locale` = 'ruRU' AND `entry` = 31061;
-- OLD name : Siegemaster Fezzik (Chapter IV)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31062
UPDATE `creature_template_locale` SET `Name` = '[Siegemaster Fezzik (Chapter IV)]' WHERE `locale` = 'ruRU' AND `entry` = 31062;
-- OLD name : Indalamar's Nax 10 Vendor, subname : Невероятные награды
-- Source : https://www.wowhead.com/wotlk/ru/npc=31076
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Nax 10 Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'ruRU' AND `entry` = 31076;
-- OLD name : Верховный лорд Дарион Могрейн (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 31084;
-- OLD name : Трусливый упырь Акеруса
-- Source : https://www.wowhead.com/wotlk/ru/npc=31090
UPDATE `creature_template_locale` SET `Name` = '[Cowardly Acherus Geist]' WHERE `locale` = 'ruRU' AND `entry` = 31090;
-- OLD name : Scourge Egg KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=31092
UPDATE `creature_template_locale` SET `Name` = '[Scourge Egg KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 31092;
-- OLD name : Испуганный вурдалак
-- Source : https://www.wowhead.com/wotlk/ru/npc=31097
UPDATE `creature_template_locale` SET `Name` = '[Frightened Ghoul]' WHERE `locale` = 'ruRU' AND `entry` = 31097;
-- OLD name : Acherus Scourge Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=31100
UPDATE `creature_template_locale` SET `Name` = '[Acherus Scourge Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 31100;
-- OLD name : Ночной эльф - ирокез
-- Source : https://www.wowhead.com/wotlk/ru/npc=31111
UPDATE `creature_template_locale` SET `Name` = '[Night Elf Mohawk]' WHERE `locale` = 'ruRU' AND `entry` = 31111;
-- OLD name : Indalamar's Nax 25 Vendor, subname : Невероятные награды
-- Source : https://www.wowhead.com/wotlk/ru/npc=31116
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Nax 25 Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'ruRU' AND `entry` = 31116;
-- OLD name : Гниющая тварь
-- Source : https://www.wowhead.com/wotlk/ru/npc=31141
UPDATE `creature_template_locale` SET `Name` = '[Decaying Wight]' WHERE `locale` = 'ruRU' AND `entry` = 31141;
-- OLD name : Reinforced Training Dummy
-- Source : https://www.wowhead.com/wotlk/ru/npc=31143
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 31143;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31143, 'ruRU','[Reinforced Training Dummy]',NULL);
-- OLD name : Тренировочный манекен
-- Source : https://www.wowhead.com/wotlk/ru/npc=31144
UPDATE `creature_template_locale` SET `Name` = 'Тренировочный манекен великого мастера' WHERE `locale` = 'ruRU' AND `entry` = 31144;
-- OLD name : Тренировочный манекен рейдера
-- Source : https://www.wowhead.com/wotlk/ru/npc=31146
UPDATE `creature_template_locale` SET `Name` = 'Героический тренировочный манекен' WHERE `locale` = 'ruRU' AND `entry` = 31146;
-- OLD name : Портал к Озеру Ледяных Оков
-- Source : https://www.wowhead.com/wotlk/ru/npc=31149
UPDATE `creature_template_locale` SET `Name` = '[Lake Wintergrasp Portal]' WHERE `locale` = 'ruRU' AND `entry` = 31149;
-- OLD subname : Всадник крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=31159
UPDATE `creature_template_locale` SET `Title` = 'Наездник крови' WHERE `locale` = 'ruRU' AND `entry` = 31159;
-- OLD name : V
-- Source : https://www.wowhead.com/wotlk/ru/npc=31168
UPDATE `creature_template_locale` SET `Name` = '[V]' WHERE `locale` = 'ruRU' AND `entry` = 31168;
-- OLD name : Riding Argent Skytalon, Neutral (Taxi)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31209
UPDATE `creature_template_locale` SET `Name` = '[Riding Argent Skytalon, Neutral (Taxi)]' WHERE `locale` = 'ruRU' AND `entry` = 31209;
-- OLD name : Неприкаянная дриада
-- Source : https://www.wowhead.com/wotlk/ru/npc=31230
UPDATE `creature_template_locale` SET `Name` = '[Forlorn Dryad]' WHERE `locale` = 'ruRU' AND `entry` = 31230;
-- OLD name : Индаламарские награды за эмблемы доблести, subname : Невероятные награды
-- Source : https://www.wowhead.com/wotlk/ru/npc=31234
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Emblem of Valor Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'ruRU' AND `entry` = 31234;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=31247
UPDATE `creature_template_locale` SET `Title` = 'Инструктор полетов в непогоду' WHERE `locale` = 'ruRU' AND `entry` = 31247;
-- OLD name : Рими Хладочудо, subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=31248
UPDATE `creature_template_locale` SET `Name` = '[Rimi Coldcrank]',`Title` = '[Cold Weather Flying Trainer]' WHERE `locale` = 'ruRU' AND `entry` = 31248;
-- OLD name : Sigrid Iceborn's Proto-Drake (mountable)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31249
UPDATE `creature_template_locale` SET `Name` = '[Sigrid Iceborn''s Proto-Drake (mountable)]' WHERE `locale` = 'ruRU' AND `entry` = 31249;
-- OLD name : Заступник Черного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=31250
UPDATE `creature_template_locale` SET `Name` = 'Защитник Черного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 31250;
-- OLD name : Застрельщик Мрачного Свода
-- Source : https://www.wowhead.com/wotlk/ru/npc=31251
UPDATE `creature_template_locale` SET `Name` = 'Рыскатель Мрачного Свода' WHERE `locale` = 'ruRU' AND `entry` = 31251;
-- OLD name : Bad Fish - Critter
-- Source : https://www.wowhead.com/wotlk/ru/npc=31252
UPDATE `creature_template_locale` SET `Name` = '[Bad Fish - Critter]' WHERE `locale` = 'ruRU' AND `entry` = 31252;
-- OLD name : Bad Fish - Rabbits
-- Source : https://www.wowhead.com/wotlk/ru/npc=31256
UPDATE `creature_template_locale` SET `Name` = '[Bad Fish - Rabbits]' WHERE `locale` = 'ruRU' AND `entry` = 31256;
-- OLD name : Dying Berserker KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=31272
UPDATE `creature_template_locale` SET `Name` = '[Dying Berserker KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 31272;
-- OLD name : Надзиратель-рыцарь смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=31274
UPDATE `creature_template_locale` SET `Name` = '[Death Knight Overseer]' WHERE `locale` = 'ruRU' AND `entry` = 31274;
-- OLD name : Прожорливый вурдалак
-- Source : https://www.wowhead.com/wotlk/ru/npc=31278
UPDATE `creature_template_locale` SET `Name` = '[Ravenous Ghoul]' WHERE `locale` = 'ruRU' AND `entry` = 31278;
-- OLD name : Чародейка Ивренна, subname : Старинные награды за очки справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=31300
UPDATE `creature_template_locale` SET `Name` = '[Arcanist Ivrenne]',`Title` = '[Emblem of Heroism Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 31300;
-- OLD name : Магистр Ламбрисса, subname : Старинные награды за очки справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=31302
UPDATE `creature_template_locale` SET `Name` = '[Magistrix Lambriesse]',`Title` = '[Emblem of Heroism Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 31302;
-- OLD name : Чародей Адурин, subname : Старинные награды за очки справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=31305
UPDATE `creature_template_locale` SET `Name` = '[Arcanist Adurin]',`Title` = '[Emblem of Valor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 31305;
-- OLD name : Магистр Бразайл, subname : Старинные награды за очки справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=31307
UPDATE `creature_template_locale` SET `Name` = '[Magister Brasael]',`Title` = '[Emblem of Valor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 31307;
-- OLD name : Dying Soldier KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=31312
UPDATE `creature_template_locale` SET `Name` = '[Dying Soldier KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 31312;
-- OLD name : Riding Hippogryph (Armored)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31315
UPDATE `creature_template_locale` SET `Name` = '[Riding Hippogryph (Armored)]' WHERE `locale` = 'ruRU' AND `entry` = 31315;
-- OLD name : Большой медведь Blizzard
-- Source : https://www.wowhead.com/wotlk/ru/npc=31319
UPDATE `creature_template_locale` SET `Name` = '[Big Blizzard Bear]' WHERE `locale` = 'ruRU' AND `entry` = 31319;
-- OLD name : Skeletal Footsoldier Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=31329
UPDATE `creature_template_locale` SET `Name` = '[Skeletal Footsoldier Credit]' WHERE `locale` = 'ruRU' AND `entry` = 31329;
-- OLD name : Индаламарские награды за эмблемы героизма, subname : Невероятные награды
-- Source : https://www.wowhead.com/wotlk/ru/npc=31331
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Emblem of Heroism Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'ruRU' AND `entry` = 31331;
-- OLD name : Frostbrood Skytalon KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=31364
UPDATE `creature_template_locale` SET `Name` = '[Frostbrood Skytalon KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 31364;
-- OLD name : Хрустальный змей
-- Source : https://www.wowhead.com/wotlk/ru/npc=31393
UPDATE `creature_template_locale` SET `Name` = 'Хрустальный дракон' WHERE `locale` = 'ruRU' AND `entry` = 31393;
-- OLD name : Валь'кира-надсмотрщица
-- Source : https://www.wowhead.com/wotlk/ru/npc=31396
UPDATE `creature_template_locale` SET `Name` = 'Валь''кира-надзиратель' WHERE `locale` = 'ruRU' AND `entry` = 31396;
-- OLD name : Избранный воитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=31398
UPDATE `creature_template_locale` SET `Name` = '[The Chosen Champion]' WHERE `locale` = 'ruRU' AND `entry` = 31398;
-- OLD name : Лазурный чаровяз
-- Source : https://www.wowhead.com/wotlk/ru/npc=31403
UPDATE `creature_template_locale` SET `Name` = 'Лазурный чароплет' WHERE `locale` = 'ruRU' AND `entry` = 31403;
-- OLD name : Icecrown Bomber Beacon, Horde
-- Source : https://www.wowhead.com/wotlk/ru/npc=31405
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Bomber Beacon, Horde]' WHERE `locale` = 'ruRU' AND `entry` = 31405;
-- OLD name : WotLK City Attacks Ice Block Bunny, BUG TEST
-- Source : https://www.wowhead.com/wotlk/ru/npc=31415
UPDATE `creature_template_locale` SET `Name` = '[WotLK City Attacks Ice Block Bunny, BUG TEST]' WHERE `locale` = 'ruRU' AND `entry` = 31415;
-- OLD subname : Огнестрельное оружие
-- Source : https://www.wowhead.com/wotlk/ru/npc=31423
UPDATE `creature_template_locale` SET `Title` = 'Ружья и боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 31423;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=31427
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 31427;
-- OLD name : Аукционист Вешак
-- Source : https://www.wowhead.com/wotlk/ru/npc=31430
UPDATE `creature_template_locale` SET `Name` = 'Аукционер Скаботун' WHERE `locale` = 'ruRU' AND `entry` = 31430;
-- OLD name : Трактирщица Гришка
-- Source : https://www.wowhead.com/wotlk/ru/npc=31433
UPDATE `creature_template_locale` SET `Name` = 'Хозяйка таверны Гришка' WHERE `locale` = 'ruRU' AND `entry` = 31433;
-- OLD name : Scourge Fight Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=31481
UPDATE `creature_template_locale` SET `Name` = '[Scourge Fight Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 31481;
-- OLD name : Дружественный даларанский волшебник
-- Source : https://www.wowhead.com/wotlk/ru/npc=31522
UPDATE `creature_template_locale` SET `Name` = '[Friendly Dalaran Wizard]' WHERE `locale` = 'ruRU' AND `entry` = 31522;
-- OLD name : Дружественный даларанский гладиатор
-- Source : https://www.wowhead.com/wotlk/ru/npc=31523
UPDATE `creature_template_locale` SET `Name` = '[Friendly Dalaran Gladiator]' WHERE `locale` = 'ruRU' AND `entry` = 31523;
-- OLD name : Чародей Передрис, subname : Награды за очки чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=31545
UPDATE `creature_template_locale` SET `Name` = '[Arcanist Peridris]',`Title` = '[Honor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 31545;
-- OLD name : Чародей Баладриэль, subname : Специалист по наградам за очки чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=31549
UPDATE `creature_template_locale` SET `Name` = '[Arcanist Baladrialle]',`Title` = '[Veteran Honor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 31549;
-- OLD name : Магистр Фейрина, subname : Специалист по наградам за очки чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=31551
UPDATE `creature_template_locale` SET `Name` = '[Magistrix Feyrina]',`Title` = '[Veteran Honor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 31551;
-- OLD name : Магистр Саремвир, subname : Награды за очки чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=31552
UPDATE `creature_template_locale` SET `Name` = '[Magister Saremvir]',`Title` = '[Honor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 31552;
-- OLD name : Присутствие древнего бога
-- Source : https://www.wowhead.com/wotlk/ru/npc=31562
UPDATE `creature_template_locale` SET `Name` = 'Присутствие Древнего Бога' WHERE `locale` = 'ruRU' AND `entry` = 31562;
-- OLD name : Blight Wagon [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31566
UPDATE `creature_template_locale` SET `Name` = '[Blight Wagon [Wrath Gate Both] (UC)]' WHERE `locale` = 'ruRU' AND `entry` = 31566;
-- OLD name : Forsaken Chemistry Set [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31567
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Chemistry Set [Wrath Gate Both] (UC)]' WHERE `locale` = 'ruRU' AND `entry` = 31567;
-- OLD name : Forsaken Chemistry Set 02 [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31568
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Chemistry Set 02 [Wrath Gate Both] (UC)]' WHERE `locale` = 'ruRU' AND `entry` = 31568;
-- OLD name : Plague Barrel [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31569
UPDATE `creature_template_locale` SET `Name` = '[Plague Barrel [Wrath Gate Both] (UC)]' WHERE `locale` = 'ruRU' AND `entry` = 31569;
-- OLD name : Broken Plague Barrel [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31570
UPDATE `creature_template_locale` SET `Name` = '[Broken Plague Barrel  [Wrath Gate Both] (UC)]' WHERE `locale` = 'ruRU' AND `entry` = 31570;
-- OLD name : Broken Plague Barrel 2 [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31571
UPDATE `creature_template_locale` SET `Name` = '[Broken Plague Barrel 2 [Wrath Gate Both] (UC)]' WHERE `locale` = 'ruRU' AND `entry` = 31571;
-- OLD name : Чумной таракан
-- Source : https://www.wowhead.com/wotlk/ru/npc=31572
UPDATE `creature_template_locale` SET `Name` = '[Blighted Cockroach]' WHERE `locale` = 'ruRU' AND `entry` = 31572;
-- OLD name : Forsaken Fire [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31573
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Fire [Wrath Gate Both] (UC)]' WHERE `locale` = 'ruRU' AND `entry` = 31573;
-- OLD name : Forsaken Fire Small [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31574
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Fire Small [Wrath Gate Both] (UC)]' WHERE `locale` = 'ruRU' AND `entry` = 31574;
-- OLD subname : Эмблема почетного квартирмейстера
-- Source : https://www.wowhead.com/wotlk/ru/npc=31579
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы доблести' WHERE `locale` = 'ruRU' AND `entry` = 31579;
-- OLD subname : Эмблема героизма квартирмейстера
-- Source : https://www.wowhead.com/wotlk/ru/npc=31580
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы героизма' WHERE `locale` = 'ruRU' AND `entry` = 31580;
-- OLD subname : Эмблема почетного квартирмейстера
-- Source : https://www.wowhead.com/wotlk/ru/npc=31581
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы доблести' WHERE `locale` = 'ruRU' AND `entry` = 31581;
-- OLD subname : Эмблема героизма квартирмейстера
-- Source : https://www.wowhead.com/wotlk/ru/npc=31582
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы героизма' WHERE `locale` = 'ruRU' AND `entry` = 31582;
-- OLD name : Ветролет Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=31637
UPDATE `creature_template_locale` SET `Name` = '[Alliance Flying Machine]' WHERE `locale` = 'ruRU' AND `entry` = 31637;
-- OLD name : Осадная машина Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=31638
UPDATE `creature_template_locale` SET `Name` = '[Alliance Siege Vehicle]' WHERE `locale` = 'ruRU' AND `entry` = 31638;
-- OLD name : Cosmetic Trigger - Phase 2 - LAB
-- Source : https://www.wowhead.com/wotlk/ru/npc=31645
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Trigger - Phase 2 - LAB]' WHERE `locale` = 'ruRU' AND `entry` = 31645;
-- OLD name : Ордынский подрывник
-- Source : https://www.wowhead.com/wotlk/ru/npc=31654
UPDATE `creature_template_locale` SET `Name` = 'Ордынский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 31654;
-- OLD name : Wrath Gate Dummy
-- Source : https://www.wowhead.com/wotlk/ru/npc=31683
UPDATE `creature_template_locale` SET `Name` = '[Wrath Gate Dummy]' WHERE `locale` = 'ruRU' AND `entry` = 31683;
-- OLD name : Завихрение
-- Source : https://www.wowhead.com/wotlk/ru/npc=31688
UPDATE `creature_template_locale` SET `Name` = 'Вихрь' WHERE `locale` = 'ruRU' AND `entry` = 31688;
-- OLD name : Bronze Drake
-- Source : https://www.wowhead.com/wotlk/ru/npc=31696
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 31696;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31696, 'ruRU','[Bronze Drake]',NULL);
-- OLD name : Сумеречный дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=31698
UPDATE `creature_template_locale` SET `Name` = 'Сумеречный верховой дракон' WHERE `locale` = 'ruRU' AND `entry` = 31698;
-- OLD name : Черный верховой северный медведь
-- Source : https://www.wowhead.com/wotlk/ru/npc=31699
UPDATE `creature_template_locale` SET `Name` = '[Black Polar Bear Mount]' WHERE `locale` = 'ruRU' AND `entry` = 31699;
-- OLD name : Бурый верховой северный медведь
-- Source : https://www.wowhead.com/wotlk/ru/npc=31700
UPDATE `creature_template_locale` SET `Name` = '[Brown Polar Bear Mount]' WHERE `locale` = 'ruRU' AND `entry` = 31700;
-- OLD name : Верховой черный мамонт
-- Source : https://www.wowhead.com/wotlk/ru/npc=31703
UPDATE `creature_template_locale` SET `Name` = '[Black Mammoth Mount]' WHERE `locale` = 'ruRU' AND `entry` = 31703;
-- OLD name : Cosmetic Crimson Snake
-- Source : https://www.wowhead.com/wotlk/ru/npc=31712
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Crimson Snake]' WHERE `locale` = 'ruRU' AND `entry` = 31712;
-- OLD name : Cosmetic Green Water Snake
-- Source : https://www.wowhead.com/wotlk/ru/npc=31713
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Green Water Snake]' WHERE `locale` = 'ruRU' AND `entry` = 31713;
-- OLD name : Небесный капитан Криолет
-- Source : https://www.wowhead.com/wotlk/ru/npc=31716
UPDATE `creature_template_locale` SET `Name` = 'Небесный капитан Криолёт' WHERE `locale` = 'ruRU' AND `entry` = 31716;
-- OLD name : Icy Ghoul KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=31743
UPDATE `creature_template_locale` SET `Name` = '[Icy Ghoul KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 31743;
-- OLD name : Cooking Loot Pinata, subname : Ударь меня!
-- Source : https://www.wowhead.com/wotlk/ru/npc=31744
UPDATE `creature_template_locale` SET `Name` = '[Cooking Loot Pinata]',`Title` = '[Hit Me!]' WHERE `locale` = 'ruRU' AND `entry` = 31744;
-- OLD name : Icecrown Bomber - Bindsight Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=31745
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Bomber - Bindsight Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 31745;
-- OLD name : King of the Mountain Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=31766
UPDATE `creature_template_locale` SET `Name` = '[King of the Mountain Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 31766;
-- OLD name : Plague Cauldron KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=31767
UPDATE `creature_template_locale` SET `Name` = '[Plague Cauldron KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 31767;
-- OLD name : Cloak Dome Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=31777
UPDATE `creature_template_locale` SET `Name` = '[Cloak Dome Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 31777;
-- OLD name : Верховое животное в стойлах
-- Source : https://www.wowhead.com/wotlk/ru/npc=31799
UPDATE `creature_template_locale` SET `Name` = '[Stabled Mount]' WHERE `locale` = 'ruRU' AND `entry` = 31799;
-- OLD name : Верховое животное в стойлах
-- Source : https://www.wowhead.com/wotlk/ru/npc=31800
UPDATE `creature_template_locale` SET `Name` = '[Stabled Mount]' WHERE `locale` = 'ruRU' AND `entry` = 31800;
-- OLD name : Древень-союзник
-- Source : https://www.wowhead.com/wotlk/ru/npc=31802
UPDATE `creature_template_locale` SET `Name` = '[Treant Ally]' WHERE `locale` = 'ruRU' AND `entry` = 31802;
-- OLD name : Верховое животное в стойлах
-- Source : https://www.wowhead.com/wotlk/ru/npc=31803
UPDATE `creature_template_locale` SET `Name` = '[Stabled Mount]' WHERE `locale` = 'ruRU' AND `entry` = 31803;
-- OLD name : Стремительный даларанский скакун
-- Source : https://www.wowhead.com/wotlk/ru/npc=31809
UPDATE `creature_template_locale` SET `Name` = '[Swift Dalaran Steed]' WHERE `locale` = 'ruRU' AND `entry` = 31809;
-- OLD name : Ветролет Бранна
-- Source : https://www.wowhead.com/wotlk/ru/npc=31827
UPDATE `creature_template_locale` SET `Name` = '[Brann''s Flying Machine]' WHERE `locale` = 'ruRU' AND `entry` = 31827;
-- OLD name : Дворфийский хранитель душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=31842
UPDATE `creature_template_locale` SET `Name` = 'Дворфский хранитель душ' WHERE `locale` = 'ruRU' AND `entry` = 31842;
-- OLD name : Ксази Смолюга
-- Source : https://www.wowhead.com/wotlk/ru/npc=31864
UPDATE `creature_template_locale` SET `Name` = 'Ксази Смолилка' WHERE `locale` = 'ruRU' AND `entry` = 31864;
-- OLD name : Slaves to Saronite Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=31866
UPDATE `creature_template_locale` SET `Name` = '[Slaves to Saronite Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 31866;
-- OLD name : Lighting Wasp (Underbelly Elixer Shapeshift)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31871
UPDATE `creature_template_locale` SET `Name` = '[Lighting Wasp (Underbelly Elixer Shapeshift)]' WHERE `locale` = 'ruRU' AND `entry` = 31871;
-- OLD name : Продавец осколков хранителя камней Индаламара, subname : Невероятные награды
-- Source : https://www.wowhead.com/wotlk/ru/npc=31872
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Stone Keeper''s Shard Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'ruRU' AND `entry` = 31872;
-- OLD name : Human Mage (Underbelly Elixir Mirror Effect)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31879
UPDATE `creature_template_locale` SET `Name` = '[Human Mage (Underbelly Elixir Mirror Effect)]' WHERE `locale` = 'ruRU' AND `entry` = 31879;
-- OLD name : Колодец Света
-- Source : https://www.wowhead.com/wotlk/ru/npc=31893
UPDATE `creature_template_locale` SET `Name` = '[Lightwell]' WHERE `locale` = 'ruRU' AND `entry` = 31893;
-- OLD name : Джиун
-- Source : https://www.wowhead.com/wotlk/ru/npc=31910
UPDATE `creature_template_locale` SET `Name` = 'Джин' WHERE `locale` = 'ruRU' AND `entry` = 31910;
-- OLD name : Invisible Stalker (no weapons)
-- Source : https://www.wowhead.com/wotlk/ru/npc=31913
UPDATE `creature_template_locale` SET `Name` = '[Invisible Stalker (Dispersion)]' WHERE `locale` = 'ruRU' AND `entry` = 31913;
-- OLD name : Хранитель мудрости Золлингер
-- Source : https://www.wowhead.com/wotlk/ru/npc=32150
UPDATE `creature_template_locale` SET `Name` = '[Loremaster Zollinger]' WHERE `locale` = 'ruRU' AND `entry` = 32150;
-- OLD name : Страж ужаса-погромщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=32159
UPDATE `creature_template_locale` SET `Name` = 'Стражник ужаса-погромщик' WHERE `locale` = 'ruRU' AND `entry` = 32159;
-- OLD name : Twilight Drake Mount (Red)
-- Source : https://www.wowhead.com/wotlk/ru/npc=32165
UPDATE `creature_template_locale` SET `Name` = '[Twilight Drake Mount (Red)]' WHERE `locale` = 'ruRU' AND `entry` = 32165;
-- OLD name : Twilight Drake Mount (Purple)
-- Source : https://www.wowhead.com/wotlk/ru/npc=32166
UPDATE `creature_template_locale` SET `Name` = '[Twilight Drake Mount (Purple)]' WHERE `locale` = 'ruRU' AND `entry` = 32166;
-- OLD name : Risen Skeleton KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32167
UPDATE `creature_template_locale` SET `Name` = '[Risen Skeleton KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32167;
-- OLD name : Vicious Geist KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32168
UPDATE `creature_template_locale` SET `Name` = '[Vicious Geist KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32168;
-- OLD name : Unkillable Test Dummy 80 Warrior
-- Source : https://www.wowhead.com/wotlk/ru/npc=32171
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 80 Warrior]' WHERE `locale` = 'ruRU' AND `entry` = 32171;
-- OLD name : Гарольд Уинстон
-- Source : https://www.wowhead.com/wotlk/ru/npc=32172
UPDATE `creature_template_locale` SET `Name` = 'Гарольд Винстон' WHERE `locale` = 'ruRU' AND `entry` = 32172;
-- OLD name : Некрополь Ледяной Короны
-- Source : https://www.wowhead.com/wotlk/ru/npc=32173
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Necropolis]' WHERE `locale` = 'ruRU' AND `entry` = 32173;
-- OLD name : Нетопырь Скверны Хеб'Драккара
-- Source : https://www.wowhead.com/wotlk/ru/npc=32194
UPDATE `creature_template_locale` SET `Name` = '[Heb''Drakkar Felbat]' WHERE `locale` = 'ruRU' AND `entry` = 32194;
-- OLD name : South Gate KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32195
UPDATE `creature_template_locale` SET `Name` = '[South Gate KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32195;
-- OLD name : Central Gate KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32196
UPDATE `creature_template_locale` SET `Name` = '[Central Gate KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32196;
-- OLD name : North Gate KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32197
UPDATE `creature_template_locale` SET `Name` = '[North Gate KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32197;
-- OLD name : Наемный грифон
-- Source : https://www.wowhead.com/wotlk/ru/npc=32198
UPDATE `creature_template_locale` SET `Name` = '[Loaned Gryphon]' WHERE `locale` = 'ruRU' AND `entry` = 32198;
-- OLD name : Northwest Gate KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32199
UPDATE `creature_template_locale` SET `Name` = '[Northwest Gate KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32199;
-- OLD name : Наемный ветрокрыл
-- Source : https://www.wowhead.com/wotlk/ru/npc=32208
UPDATE `creature_template_locale` SET `Name` = '[Loaned Wind Rider]' WHERE `locale` = 'ruRU' AND `entry` = 32208;
-- OLD name : Большой караванный мамонт
-- Source : https://www.wowhead.com/wotlk/ru/npc=32212
UPDATE `creature_template_locale` SET `Name` = '[Grand Caravan Mammoth]' WHERE `locale` = 'ruRU' AND `entry` = 32212;
-- OLD name : Большой караванный мамонт
-- Source : https://www.wowhead.com/wotlk/ru/npc=32213
UPDATE `creature_template_locale` SET `Name` = '[Grand Caravan Mammoth]' WHERE `locale` = 'ruRU' AND `entry` = 32213;
-- OLD name : Drag Drop KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32229
UPDATE `creature_template_locale` SET `Name` = '[Drag Drop KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32229;
-- OLD name : Наблюдатель Хаоса
-- Source : https://www.wowhead.com/wotlk/ru/npc=32235
UPDATE `creature_template_locale` SET `Name` = '[Chaos Watcher]' WHERE `locale` = 'ruRU' AND `entry` = 32235;
-- OLD name : Снайперская пушка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32254
UPDATE `creature_template_locale` SET `Name` = '[Sniper Rifle]' WHERE `locale` = 'ruRU' AND `entry` = 32254;
-- OLD name : Порабощенный прислужник
-- Source : https://www.wowhead.com/wotlk/ru/npc=32260
UPDATE `creature_template_locale` SET `Name` = 'Порабощенный слуга' WHERE `locale` = 'ruRU' AND `entry` = 32260;
-- OLD name : Writhing Mass KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32266
UPDATE `creature_template_locale` SET `Name` = '[Writhing Mass KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32266;
-- OLD name : Хранитель времени
-- Source : https://www.wowhead.com/wotlk/ru/npc=32281
UPDATE `creature_template_locale` SET `Name` = 'Хранитель Времени' WHERE `locale` = 'ruRU' AND `entry` = 32281;
-- OLD name : Беспокойный прах
-- Source : https://www.wowhead.com/wotlk/ru/npc=32283
UPDATE `creature_template_locale` SET `Name` = '[Unquiet Remnant]' WHERE `locale` = 'ruRU' AND `entry` = 32283;
-- OLD name : Освобожденный прах
-- Source : https://www.wowhead.com/wotlk/ru/npc=32288
UPDATE `creature_template_locale` SET `Name` = '[Freed Remnant]' WHERE `locale` = 'ruRU' AND `entry` = 32288;
-- OLD name : Dark Subjugator Transform, subname : Культ Проклятых
-- Source : https://www.wowhead.com/wotlk/ru/npc=32293
UPDATE `creature_template_locale` SET `Name` = '[Dark Subjugator Transform]',`Title` = '[Cult of the Damned]' WHERE `locale` = 'ruRU' AND `entry` = 32293;
-- OLD name : Алумет Перерожденный
-- Source : https://www.wowhead.com/wotlk/ru/npc=32300
UPDATE `creature_template_locale` SET `Name` = 'Алумет Восходящий' WHERE `locale` = 'ruRU' AND `entry` = 32300;
-- OLD name : Test Totem
-- Source : https://www.wowhead.com/wotlk/ru/npc=32304
UPDATE `creature_template_locale` SET `Name` = '[Test Totem]' WHERE `locale` = 'ruRU' AND `entry` = 32304;
-- OLD name : Драконоид из рода Бесконечности
-- Source : https://www.wowhead.com/wotlk/ru/npc=32306
UPDATE `creature_template_locale` SET `Name` = 'Дракон из рода Бесконечности' WHERE `locale` = 'ruRU' AND `entry` = 32306;
-- OLD name : Рыцарь черного клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32309
UPDATE `creature_template_locale` SET `Name` = 'Черный рыцарь' WHERE `locale` = 'ruRU' AND `entry` = 32309;
-- OLD name : Dark Messenger KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32314
UPDATE `creature_template_locale` SET `Name` = '[Dark Messenger KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32314;
-- OLD name : Взрывная ракетная турель
-- Source : https://www.wowhead.com/wotlk/ru/npc=32350
UPDATE `creature_template_locale` SET `Name` = '[TF-Xplosive Rocket Turret]' WHERE `locale` = 'ruRU' AND `entry` = 32350;
-- OLD name : Арджекс Сталежорц
-- Source : https://www.wowhead.com/wotlk/ru/npc=32359
UPDATE `creature_template_locale` SET `Name` = 'Арджекс Сталечрев' WHERE `locale` = 'ruRU' AND `entry` = 32359;
-- OLD subname : Начальник снабжения ветеранскими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=32380
UPDATE `creature_template_locale` SET `Title` = 'Опытный начальник снабжения доспехами' WHERE `locale` = 'ruRU' AND `entry` = 32380;
-- OLD subname : Начальник снабжения доспехами для новичков
-- Source : https://www.wowhead.com/wotlk/ru/npc=32381
UPDATE `creature_template_locale` SET `Title` = 'Ученик начальника снабжения доспехами' WHERE `locale` = 'ruRU' AND `entry` = 32381;
-- OLD name : Сержант Кин, subname : Интендант ювелиров
-- Source : https://www.wowhead.com/wotlk/ru/npc=32384
UPDATE `creature_template_locale` SET `Name` = '[Sergeant Kien]',`Title` = '[Jewelcrafting Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 32384;
-- OLD name : Дорисса Летуни, subname : Начальник снабжения ветеранскими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=32385
UPDATE `creature_template_locale` SET `Name` = 'Дорисса Волантий',`Title` = 'Опытный начальник снабжения доспехами' WHERE `locale` = 'ruRU' AND `entry` = 32385;
-- OLD name : Кеззик Гарпунер
-- Source : https://www.wowhead.com/wotlk/ru/npc=32405
UPDATE `creature_template_locale` SET `Name` = '[Kezzik the Striker]' WHERE `locale` = 'ruRU' AND `entry` = 32405;
-- OLD name : Арджекс Сталежорц
-- Source : https://www.wowhead.com/wotlk/ru/npc=32407
UPDATE `creature_template_locale` SET `Name` = '[Argex Irongut]' WHERE `locale` = 'ruRU' AND `entry` = 32407;
-- OLD name : Обезумевший беглец из деревни Инду'ле
-- Source : https://www.wowhead.com/wotlk/ru/npc=32409
UPDATE `creature_template_locale` SET `Name` = 'Выживший сумасшедший из деревни Инду''ле' WHERE `locale` = 'ruRU' AND `entry` = 32409;
-- OLD name : Ирагос
-- Source : https://www.wowhead.com/wotlk/ru/npc=32432
UPDATE `creature_template_locale` SET `Name` = '[Iragos]' WHERE `locale` = 'ruRU' AND `entry` = 32432;
-- OLD name : Селагоса
-- Source : https://www.wowhead.com/wotlk/ru/npc=32433
UPDATE `creature_template_locale` SET `Name` = '[Selagosa]' WHERE `locale` = 'ruRU' AND `entry` = 32433;
-- OLD name : Анигос
-- Source : https://www.wowhead.com/wotlk/ru/npc=32434
UPDATE `creature_template_locale` SET `Name` = '[Anygos]' WHERE `locale` = 'ruRU' AND `entry` = 32434;
-- OLD name : Терагос
-- Source : https://www.wowhead.com/wotlk/ru/npc=32436
UPDATE `creature_template_locale` SET `Name` = '[Theragos]' WHERE `locale` = 'ruRU' AND `entry` = 32436;
-- OLD name : Мирагоса
-- Source : https://www.wowhead.com/wotlk/ru/npc=32437
UPDATE `creature_template_locale` SET `Name` = '[Myragosa]' WHERE `locale` = 'ruRU' AND `entry` = 32437;
-- OLD name : Зиндрагоса
-- Source : https://www.wowhead.com/wotlk/ru/npc=32439
UPDATE `creature_template_locale` SET `Name` = '[Zyndragosa]' WHERE `locale` = 'ruRU' AND `entry` = 32439;
-- OLD name : Кортегос
-- Source : https://www.wowhead.com/wotlk/ru/npc=32440
UPDATE `creature_template_locale` SET `Name` = '[Corthegos]' WHERE `locale` = 'ruRU' AND `entry` = 32440;
-- OLD name : Позаимствованная метла
-- Source : https://www.wowhead.com/wotlk/ru/npc=32449
UPDATE `creature_template_locale` SET `Name` = '[Borrowed Broom]' WHERE `locale` = 'ruRU' AND `entry` = 32449;
-- OLD name : Машина Долины Потерянной Надежды
-- Source : https://www.wowhead.com/wotlk/ru/npc=32452
UPDATE `creature_template_locale` SET `Name` = '[Valley of Lost Hope Vehicle]' WHERE `locale` = 'ruRU' AND `entry` = 32452;
-- OLD name : Житель Даларана
-- Source : https://www.wowhead.com/wotlk/ru/npc=32453
UPDATE `creature_template_locale` SET `Name` = '[Dalaran Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 32453;
-- OLD name : Житель Даларана
-- Source : https://www.wowhead.com/wotlk/ru/npc=32454
UPDATE `creature_template_locale` SET `Name` = '[Dalaran Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 32454;
-- OLD name : Сеятель Гнили Плети
-- Source : https://www.wowhead.com/wotlk/ru/npc=32473
UPDATE `creature_template_locale` SET `Name` = '[Scourge Blightbringer]' WHERE `locale` = 'ruRU' AND `entry` = 32473;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=32474
UPDATE `creature_template_locale` SET `Title` = 'Великий рыбак' WHERE `locale` = 'ruRU' AND `entry` = 32474;
-- OLD name : Нерубский король подземелий
-- Source : https://www.wowhead.com/wotlk/ru/npc=32480
UPDATE `creature_template_locale` SET `Name` = '[Nerubian Underking]' WHERE `locale` = 'ruRU' AND `entry` = 32480;
-- OLD name : Израненный житель Даларана
-- Source : https://www.wowhead.com/wotlk/ru/npc=32493
UPDATE `creature_template_locale` SET `Name` = '[Wounded Dalaran]' WHERE `locale` = 'ruRU' AND `entry` = 32493;
-- OLD name : Даларанский ребенок
-- Source : https://www.wowhead.com/wotlk/ru/npc=32494
UPDATE `creature_template_locale` SET `Name` = '[Dalaran Child]' WHERE `locale` = 'ruRU' AND `entry` = 32494;
-- OLD name : David Test Creature 1235
-- Source : https://www.wowhead.com/wotlk/ru/npc=32508
UPDATE `creature_template_locale` SET `Name` = '[David Test Creature 1235]' WHERE `locale` = 'ruRU' AND `entry` = 32508;
-- OLD name : Тренировочный манекен верховного лорда
-- Source : https://www.wowhead.com/wotlk/ru/npc=32547
UPDATE `creature_template_locale` SET `Name` = 'Наставник Немезиды верховного лорда' WHERE `locale` = 'ruRU' AND `entry` = 32547;
-- OLD name : QA Test Dummy 80 Undead, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=32556
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Undead]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 32556;
-- OLD name : QA Test Dummy 80 Beast, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=32557
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Beast]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 32557;
-- OLD name : QA Test Dummy 80 Dragonkin, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=32558
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Dragonkin]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 32558;
-- OLD name : QA Test Dummy 80 Demon, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=32559
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Demon]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 32559;
-- OLD name : QA Test Dummy 80 Giant, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=32560
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Giant]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 32560;
-- OLD name : QA Test Dummy 80 Elemental, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=32561
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Elemental]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 32561;
-- OLD name : Красный верховой дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=32563
UPDATE `creature_template_locale` SET `Name` = '[Red Drake Mount]' WHERE `locale` = 'ruRU' AND `entry` = 32563;
-- OLD name : Великолепный ковер-самолет
-- Source : https://www.wowhead.com/wotlk/ru/npc=32567
UPDATE `creature_template_locale` SET `Name` = '[Magnificent Flying Carpet]' WHERE `locale` = 'ruRU' AND `entry` = 32567;
-- OLD name : Черный летающий киражский боевой танк
-- Source : https://www.wowhead.com/wotlk/ru/npc=32568
UPDATE `creature_template_locale` SET `Name` = '[Flying Black Qiraji Battle Tank]' WHERE `locale` = 'ruRU' AND `entry` = 32568;
-- OLD name : Превращенная черная кошка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32570
UPDATE `creature_template_locale` SET `Name` = '[Polymorphed Black Cat]' WHERE `locale` = 'ruRU' AND `entry` = 32570;
-- OLD name : Испытательный ветролет
-- Source : https://www.wowhead.com/wotlk/ru/npc=32574
UPDATE `creature_template_locale` SET `Name` = '[Test Flying Machine]' WHERE `locale` = 'ruRU' AND `entry` = 32574;
-- OLD name : Облик волчера
-- Source : https://www.wowhead.com/wotlk/ru/npc=32584
UPDATE `creature_template_locale` SET `Name` = '[Wolvar Illusion]' WHERE `locale` = 'ruRU' AND `entry` = 32584;
-- OLD name : Riding Protodrake, Blue
-- Source : https://www.wowhead.com/wotlk/ru/npc=32585
UPDATE `creature_template_locale` SET `Name` = '[Riding Protodrake, Blue]' WHERE `locale` = 'ruRU' AND `entry` = 32585;
-- OLD name : Riding Protodrake, Bronze
-- Source : https://www.wowhead.com/wotlk/ru/npc=32586
UPDATE `creature_template_locale` SET `Name` = '[Riding Protodrake, Bronze]' WHERE `locale` = 'ruRU' AND `entry` = 32586;
-- OLD name : Протодракончик
-- Source : https://www.wowhead.com/wotlk/ru/npc=32592
UPDATE `creature_template_locale` SET `Name` = 'Детеныш протодракона' WHERE `locale` = 'ruRU' AND `entry` = 32592;
-- OLD name : Icecrown Bomber Horde Test Pilot (DND)
-- Source : https://www.wowhead.com/wotlk/ru/npc=32607
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Bomber Horde Test Pilot (DND)]' WHERE `locale` = 'ruRU' AND `entry` = 32607;
-- OLD name : Ордынский вестник войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=32615
UPDATE `creature_template_locale` SET `Name` = '[Horde Warbringer]' WHERE `locale` = 'ruRU' AND `entry` = 32615;
-- OLD name : Бригадный генерал Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=32626
UPDATE `creature_template_locale` SET `Name` = '[Alliance Brigadier General]' WHERE `locale` = 'ruRU' AND `entry` = 32626;
-- OLD name : Посетитель приемной
-- Source : https://www.wowhead.com/wotlk/ru/npc=32632
UPDATE `creature_template_locale` SET `Name` = '[Parlor Patron]' WHERE `locale` = 'ruRU' AND `entry` = 32632;
-- OLD name : Стремительный ковер-самолет из луноткани
-- Source : https://www.wowhead.com/wotlk/ru/npc=32634
UPDATE `creature_template_locale` SET `Name` = '[Swift Mooncloth Carpet]' WHERE `locale` = 'ruRU' AND `entry` = 32634;
-- OLD name : Стремительный ковер-самолет из тенеткани
-- Source : https://www.wowhead.com/wotlk/ru/npc=32635
UPDATE `creature_template_locale` SET `Name` = '[Swift Shadoweave Carpet]' WHERE `locale` = 'ruRU' AND `entry` = 32635;
-- OLD name : Стремительный ковер-самолет из огненной чароткани
-- Source : https://www.wowhead.com/wotlk/ru/npc=32636
UPDATE `creature_template_locale` SET `Name` = '[Swift Spellfire Carpet]' WHERE `locale` = 'ruRU' AND `entry` = 32636;
-- OLD name : Ковер-самолет
-- Source : https://www.wowhead.com/wotlk/ru/npc=32637
UPDATE `creature_template_locale` SET `Name` = '[Flying Carpet]' WHERE `locale` = 'ruRU' AND `entry` = 32637;
-- OLD subname : Странствующий торговец
-- Source : https://www.wowhead.com/wotlk/ru/npc=32638
UPDATE `creature_template_locale` SET `Title` = 'Товары для путешественников' WHERE `locale` = 'ruRU' AND `entry` = 32638;
-- OLD name : Tirion's Gambit Event Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=32648
UPDATE `creature_template_locale` SET `Name` = '[Tirion''s Gambit Event Credit]' WHERE `locale` = 'ruRU' AND `entry` = 32648;
-- OLD name : Горький, subname : Странствующий торговец
-- Source : https://www.wowhead.com/wotlk/ru/npc=32649
UPDATE `creature_template_locale` SET `Name` = '[Gorky]',`Title` = '[Traveling Salesman]' WHERE `locale` = 'ruRU' AND `entry` = 32649;
-- OLD subname : Капитан "Нежной Девы"
-- Source : https://www.wowhead.com/wotlk/ru/npc=32658
UPDATE `creature_template_locale` SET `Title` = 'Капитан "Благодарной Девы"' WHERE `locale` = 'ruRU' AND `entry` = 32658;
-- OLD name : Тренировочный манекен
-- Source : https://www.wowhead.com/wotlk/ru/npc=32666
UPDATE `creature_template_locale` SET `Name` = 'Тренировочный манекен для опытных бойцов' WHERE `locale` = 'ruRU' AND `entry` = 32666;
-- OLD name : Тренировочный манекен
-- Source : https://www.wowhead.com/wotlk/ru/npc=32667
UPDATE `creature_template_locale` SET `Name` = 'Тренировочный манекен для мастеров' WHERE `locale` = 'ruRU' AND `entry` = 32667;
-- OLD name : Ремеслий Головолом
-- Source : https://www.wowhead.com/wotlk/ru/npc=32686
UPDATE `creature_template_locale` SET `Name` = 'Томас Риогейн' WHERE `locale` = 'ruRU' AND `entry` = 32686;
-- OLD name : Боевой маг Лукемс
-- Source : https://www.wowhead.com/wotlk/ru/npc=32722
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Лукемс' WHERE `locale` = 'ruRU' AND `entry` = 32722;
-- OLD name : Боевой маг Кат'лин
-- Source : https://www.wowhead.com/wotlk/ru/npc=32723
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Кат''лин' WHERE `locale` = 'ruRU' AND `entry` = 32723;
-- OLD name : Боевой маг Мумплина
-- Source : https://www.wowhead.com/wotlk/ru/npc=32724
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Мумплина' WHERE `locale` = 'ruRU' AND `entry` = 32724;
-- OLD name : Боевой маг Сильва
-- Source : https://www.wowhead.com/wotlk/ru/npc=32725
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Сильва' WHERE `locale` = 'ruRU' AND `entry` = 32725;
-- OLD name : Дурандас
-- Source : https://www.wowhead.com/wotlk/ru/npc=32726
UPDATE `creature_template_locale` SET `Name` = 'Балбес' WHERE `locale` = 'ruRU' AND `entry` = 32726;
-- OLD subname : Символы для рыцарей смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=32753
UPDATE `creature_template_locale` SET `Title` = 'Припасы для рыцарей смерти' WHERE `locale` = 'ruRU' AND `entry` = 32753;
-- OLD subname : Символы для друидов
-- Source : https://www.wowhead.com/wotlk/ru/npc=32754
UPDATE `creature_template_locale` SET `Title` = 'Припасы для друидов' WHERE `locale` = 'ruRU' AND `entry` = 32754;
-- OLD subname : Символы для охотников
-- Source : https://www.wowhead.com/wotlk/ru/npc=32755
UPDATE `creature_template_locale` SET `Title` = 'Припасы для охотников' WHERE `locale` = 'ruRU' AND `entry` = 32755;
-- OLD subname : Символы для магов
-- Source : https://www.wowhead.com/wotlk/ru/npc=32756
UPDATE `creature_template_locale` SET `Title` = 'Припасы для магов' WHERE `locale` = 'ruRU' AND `entry` = 32756;
-- OLD subname : Символы для паладинов
-- Source : https://www.wowhead.com/wotlk/ru/npc=32757
UPDATE `creature_template_locale` SET `Title` = 'Припасы для паладинов' WHERE `locale` = 'ruRU' AND `entry` = 32757;
-- OLD subname : Символы для жрецов
-- Source : https://www.wowhead.com/wotlk/ru/npc=32758
UPDATE `creature_template_locale` SET `Title` = 'Припасы для жрецов' WHERE `locale` = 'ruRU' AND `entry` = 32758;
-- OLD subname : Символы для разбойников
-- Source : https://www.wowhead.com/wotlk/ru/npc=32759
UPDATE `creature_template_locale` SET `Title` = 'Припасы для разбойников' WHERE `locale` = 'ruRU' AND `entry` = 32759;
-- OLD subname : Символы для шаманов
-- Source : https://www.wowhead.com/wotlk/ru/npc=32760
UPDATE `creature_template_locale` SET `Title` = 'Припасы для шаманов' WHERE `locale` = 'ruRU' AND `entry` = 32760;
-- OLD subname : Символы для чернокнижников
-- Source : https://www.wowhead.com/wotlk/ru/npc=32761
UPDATE `creature_template_locale` SET `Title` = 'Припасы для чернокнижников' WHERE `locale` = 'ruRU' AND `entry` = 32761;
-- OLD subname : Символы для воинов
-- Source : https://www.wowhead.com/wotlk/ru/npc=32762
UPDATE `creature_template_locale` SET `Title` = 'Припасы для воинов' WHERE `locale` = 'ruRU' AND `entry` = 32762;
-- OLD name : Тотем кольца огня IX
-- Source : https://www.wowhead.com/wotlk/ru/npc=32775
UPDATE `creature_template_locale` SET `Name` = '[Fire Nova Totem IX]' WHERE `locale` = 'ruRU' AND `entry` = 32775;
-- OLD name : Тотем кольца огня VIII
-- Source : https://www.wowhead.com/wotlk/ru/npc=32776
UPDATE `creature_template_locale` SET `Name` = '[Fire Nova Totem VIII]' WHERE `locale` = 'ruRU' AND `entry` = 32776;
-- OLD name : Подлый вор
-- Source : https://www.wowhead.com/wotlk/ru/npc=32779
UPDATE `creature_template_locale` SET `Name` = '[Ignoble Thief]' WHERE `locale` = 'ruRU' AND `entry` = 32779;
-- OLD name : Кролик Сада чудес
-- Source : https://www.wowhead.com/wotlk/ru/npc=32781
UPDATE `creature_template_locale` SET `Name` = '[Noblegarden Rabbit]' WHERE `locale` = 'ruRU' AND `entry` = 32781;
-- OLD name : Noblegarden Bunny Waypoint
-- Source : https://www.wowhead.com/wotlk/ru/npc=32782
UPDATE `creature_template_locale` SET `Name` = '[Noblegarden Bunny Waypoint]' WHERE `locale` = 'ruRU' AND `entry` = 32782;
-- OLD name : Noblegarden Bunny Controller
-- Source : https://www.wowhead.com/wotlk/ru/npc=32784
UPDATE `creature_template_locale` SET `Name` = '[Noblegarden Bunny Controller]' WHERE `locale` = 'ruRU' AND `entry` = 32784;
-- OLD name : Web Wrap Visual (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32785;
-- OLD name : Портал для возвращения с Лунной поляны
-- Source : https://www.wowhead.com/wotlk/ru/npc=32788
UPDATE `creature_template_locale` SET `Name` = 'Портал для возвращения из Лунной поляны' WHERE `locale` = 'ruRU' AND `entry` = 32788;
-- OLD name : Превращенный кролик
-- Source : https://www.wowhead.com/wotlk/ru/npc=32789
UPDATE `creature_template_locale` SET `Name` = '[Polymorphed Rabbit]' WHERE `locale` = 'ruRU' AND `entry` = 32789;
-- OLD name : Кролик-малютка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32793
UPDATE `creature_template_locale` SET `Name` = '[Baby Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32793;
-- OLD name : Indalamar's 83 Test Dummy, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/ru/npc=32794
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s 83 Test Dummy]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'ruRU' AND `entry` = 32794;
-- OLD name : Illidan Stormrage Kill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=32797
UPDATE `creature_template_locale` SET `Name` = '[Illidan Stormrage Kill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 32797;
-- OLD name : Весенний собиратель
-- Source : https://www.wowhead.com/wotlk/ru/npc=32799
UPDATE `creature_template_locale` SET `Name` = '[Spring Collector]' WHERE `locale` = 'ruRU' AND `entry` = 32799;
-- OLD name : Страж огня Ревущего фьорда
-- Source : https://www.wowhead.com/wotlk/ru/npc=32804
UPDATE `creature_template_locale` SET `Name` = 'Страж огня Ревущего Фьорда' WHERE `locale` = 'ruRU' AND `entry` = 32804;
-- OLD name : Хранитель огня Ревущего фьорда
-- Source : https://www.wowhead.com/wotlk/ru/npc=32812
UPDATE `creature_template_locale` SET `Name` = 'Хранитель огня Ревущего Фьорда' WHERE `locale` = 'ruRU' AND `entry` = 32812;
-- OLD name : Revenge for the Vargul Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32821
UPDATE `creature_template_locale` SET `Name` = '[Revenge for the Vargul Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32821;
-- OLD name : Крупная индейка (превращение)
-- Source : https://www.wowhead.com/wotlk/ru/npc=32822
UPDATE `creature_template_locale` SET `Name` = '[Large Turkey (Polymorph)]' WHERE `locale` = 'ruRU' AND `entry` = 32822;
-- OLD name : Крепкий стул
-- Source : https://www.wowhead.com/wotlk/ru/npc=32826
UPDATE `creature_template_locale` SET `Name` = '[Sturdy Seat]' WHERE `locale` = 'ruRU' AND `entry` = 32826;
-- OLD name : Chair Holder
-- Source : https://www.wowhead.com/wotlk/ru/npc=32828
UPDATE `creature_template_locale` SET `Name` = '[Chair Holder]' WHERE `locale` = 'ruRU' AND `entry` = 32828;
-- OLD name : Кровавый страж Зар'ши
-- Source : https://www.wowhead.com/wotlk/ru/npc=32832
UPDATE `creature_template_locale` SET `Name` = 'Кровь стража Зар''ши' WHERE `locale` = 'ruRU' AND `entry` = 32832;
-- OLD name : Разведчик Зар'ши
-- Source : https://www.wowhead.com/wotlk/ru/npc=32833
UPDATE `creature_template_locale` SET `Name` = '[Scout Zar''shi]' WHERE `locale` = 'ruRU' AND `entry` = 32833;
-- OLD name : Капрал Лунная Заря
-- Source : https://www.wowhead.com/wotlk/ru/npc=32835
UPDATE `creature_template_locale` SET `Name` = '[Corporal Moonstrike]' WHERE `locale` = 'ruRU' AND `entry` = 32835;
-- OLD name : Разработчики WoW
-- Source : https://www.wowhead.com/wotlk/ru/npc=32842
UPDATE `creature_template_locale` SET `Name` = 'Команда разработчиков WoW' WHERE `locale` = 'ruRU' AND `entry` = 32842;
-- OLD name : Unkillable Test Dummy 80 Warrior (Bonus Armor)
-- Source : https://www.wowhead.com/wotlk/ru/npc=32847
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 80 Warrior (Bonus Armor)]' WHERE `locale` = 'ruRU' AND `entry` = 32847;
-- OLD name : Unkillable Test Dummy 80 S1 Resil Priest, subname : Жрец
-- Source : https://www.wowhead.com/wotlk/ru/npc=32848
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 80 S1 Resil Priest]',`Title` = '[Priest]' WHERE `locale` = 'ruRU' AND `entry` = 32848;
-- OLD name : Unkillable Test Dummy 80 S1 Resil Warrior, subname : Воин
-- Source : https://www.wowhead.com/wotlk/ru/npc=32849
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 80 S1 Resil Warrior]',`Title` = '[Warrior]' WHERE `locale` = 'ruRU' AND `entry` = 32849;
-- OLD name : QA Test Dummy 83 Raid Debuff (High Armor)
-- Source : https://www.wowhead.com/wotlk/ru/npc=32853
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 83 Raid Debuff (High Armor)]' WHERE `locale` = 'ruRU' AND `entry` = 32853;
-- OLD name : Unkillable Test Dummy 83 Warrior (Bonus Armor)
-- Source : https://www.wowhead.com/wotlk/ru/npc=32854
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 83 Warrior (Bonus Armor)]' WHERE `locale` = 'ruRU' AND `entry` = 32854;
-- OLD name : Ронакада, subname : Мастер клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32870
UPDATE `creature_template_locale` SET `Name` = '[The Real Ronakada]',`Title` = '[Blademaster]' WHERE `locale` = 'ruRU' AND `entry` = 32870;
-- OLD name : Пленный наемник
-- Source : https://www.wowhead.com/wotlk/ru/npc=32883
UPDATE `creature_template_locale` SET `Name` = 'Пленный солдат' WHERE `locale` = 'ruRU' AND `entry` = 32883;
-- OLD name : Пленный наемник
-- Source : https://www.wowhead.com/wotlk/ru/npc=32885
UPDATE `creature_template_locale` SET `Name` = 'Пленный солдат' WHERE `locale` = 'ruRU' AND `entry` = 32885;
-- OLD name : Magma Totem TEST
-- Source : https://www.wowhead.com/wotlk/ru/npc=32887
UPDATE `creature_template_locale` SET `Name` = '[Magma Totem TEST]' WHERE `locale` = 'ruRU' AND `entry` = 32887;
-- OLD name : Костолом поля боя Сары
-- Source : https://www.wowhead.com/wotlk/ru/npc=32898
UPDATE `creature_template_locale` SET `Name` = '[Sarah''s Battleground Bruiser]' WHERE `locale` = 'ruRU' AND `entry` = 32898;
-- OLD name : Бешеная индейка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32905
UPDATE `creature_template_locale` SET `Name` = '[Rabid Turkey]' WHERE `locale` = 'ruRU' AND `entry` = 32905;
-- OLD name : Ледяная вспышка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32926
UPDATE `creature_template_locale` SET `Name` = 'Ледяная ловушка' WHERE `locale` = 'ruRU' AND `entry` = 32926;
-- OLD name : Dan's Test Mount
-- Source : https://www.wowhead.com/wotlk/ru/npc=32931
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Mount]' WHERE `locale` = 'ruRU' AND `entry` = 32931;
-- OLD name : Ледяная вспышка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32938
UPDATE `creature_template_locale` SET `Name` = 'Ледяная ловушка' WHERE `locale` = 'ruRU' AND `entry` = 32938;
-- OLD name : Олешек
-- Source : https://www.wowhead.com/wotlk/ru/npc=32939
UPDATE `creature_template_locale` SET `Name` = 'Олененок' WHERE `locale` = 'ruRU' AND `entry` = 32939;
-- OLD name : Riding Spectral Gryphon (Taxi)
-- Source : https://www.wowhead.com/wotlk/ru/npc=32942
UPDATE `creature_template_locale` SET `Name` = '[Riding Spectral Gryphon (Taxi)]' WHERE `locale` = 'ruRU' AND `entry` = 32942;
-- OLD name : Голодный клыкарр
-- Source : https://www.wowhead.com/wotlk/ru/npc=32954
UPDATE `creature_template_locale` SET `Name` = '[Hungry Tuskarr]' WHERE `locale` = 'ruRU' AND `entry` = 32954;
-- OLD name : Взрывающаяся звезда
-- Source : https://www.wowhead.com/wotlk/ru/npc=32955
UPDATE `creature_template_locale` SET `Name` = 'Вспыхивающая звезда' WHERE `locale` = 'ruRU' AND `entry` = 32955;
-- OLD name : Прислужник клана Темных Рун
-- Source : https://www.wowhead.com/wotlk/ru/npc=32957
UPDATE `creature_template_locale` SET `Name` = '[Dark Rune Acolyte]' WHERE `locale` = 'ruRU' AND `entry` = 32957;
-- OLD name : Элементаль молний
-- Source : https://www.wowhead.com/wotlk/ru/npc=32958
UPDATE `creature_template_locale` SET `Name` = 'Наэлектризованный элементаль' WHERE `locale` = 'ruRU' AND `entry` = 32958;
-- OLD name : Верный мул
-- Source : https://www.wowhead.com/wotlk/ru/npc=32980
UPDATE `creature_template_locale` SET `Name` = '[Faithful Mule]' WHERE `locale` = 'ruRU' AND `entry` = 32980;
-- OLD name : Riding Scourge Gryphon (Taxi)
-- Source : https://www.wowhead.com/wotlk/ru/npc=32981
UPDATE `creature_template_locale` SET `Name` = '[Riding Scourge Gryphon (Taxi)]' WHERE `locale` = 'ruRU' AND `entry` = 32981;
-- OLD name : Взятый в найм вьючный мул
-- Source : https://www.wowhead.com/wotlk/ru/npc=32983
UPDATE `creature_template_locale` SET `Name` = '[Rented Pack Mule]' WHERE `locale` = 'ruRU' AND `entry` = 32983;
-- OLD name : Test of Strength Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=32984
UPDATE `creature_template_locale` SET `Name` = '[Test of Strength Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 32984;
-- OLD name : Tails Up Frost Leopard Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=33005
UPDATE `creature_template_locale` SET `Name` = '[Tails Up Frost Leopard Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 33005;
-- OLD name : Tails Up Icepaw Bear Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=33006
UPDATE `creature_template_locale` SET `Name` = '[Tails Up Icepaw Bear Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 33006;
-- OLD name : Самец ледолапого медведя
-- Source : https://www.wowhead.com/wotlk/ru/npc=33008
UPDATE `creature_template_locale` SET `Name` = 'Самец ледопалого медведя' WHERE `locale` = 'ruRU' AND `entry` = 33008;
-- OLD name : Самка ледолапого медведя
-- Source : https://www.wowhead.com/wotlk/ru/npc=33011
UPDATE `creature_template_locale` SET `Name` = 'Самка ледопалого медведя' WHERE `locale` = 'ruRU' AND `entry` = 33011;
-- OLD name : Justin Test Vehicle A
-- Source : https://www.wowhead.com/wotlk/ru/npc=33014
UPDATE `creature_template_locale` SET `Name` = '[Justin Test Vehicle A]' WHERE `locale` = 'ruRU' AND `entry` = 33014;
-- OLD subname : Продавец алкогольных напитков
-- Source : https://www.wowhead.com/wotlk/ru/npc=33026
UPDATE `creature_template_locale` SET `Title` = 'Алкоголь' WHERE `locale` = 'ruRU' AND `entry` = 33026;
-- OLD name : Лиловый светляк
-- Source : https://www.wowhead.com/wotlk/ru/npc=33032
UPDATE `creature_template_locale` SET `Name` = '[Firefly (Purple)]' WHERE `locale` = 'ruRU' AND `entry` = 33032;
-- OLD name : ELM General Purpose Bunny Large (scale x5)
-- Source : https://www.wowhead.com/wotlk/ru/npc=33045
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny Large (scale x5)]' WHERE `locale` = 'ruRU' AND `entry` = 33045;
-- OLD name : Разбитый механоцикл
-- Source : https://www.wowhead.com/wotlk/ru/npc=33061
UPDATE `creature_template_locale` SET `Name` = '[Wrecked Mechano-hog]' WHERE `locale` = 'ruRU' AND `entry` = 33061;
-- OLD name : Мороззер
-- Source : https://www.wowhead.com/wotlk/ru/npc=33064
UPDATE `creature_template_locale` SET `Name` = '[Frizzer]' WHERE `locale` = 'ruRU' AND `entry` = 33064;
-- OLD name : Костолом ярмарки Новолуния
-- Source : https://www.wowhead.com/wotlk/ru/npc=33069
UPDATE `creature_template_locale` SET `Name` = '[Darkmoon Bruiser]' WHERE `locale` = 'ruRU' AND `entry` = 33069;
-- OLD name : Unkillable Test Dummy 87 Warrior Sessile
-- Source : https://www.wowhead.com/wotlk/ru/npc=33073
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 83 Warrior Sessile]' WHERE `locale` = 'ruRU' AND `entry` = 33073;
-- OLD name : Осадная пушка Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=33080
UPDATE `creature_template_locale` SET `Name` = '[Warsong Siege Turret]' WHERE `locale` = 'ruRU' AND `entry` = 33080;
-- OLD name : Цель танковой пушки
-- Source : https://www.wowhead.com/wotlk/ru/npc=33081
UPDATE `creature_template_locale` SET `Name` = '[Tonk Cannon Target]' WHERE `locale` = 'ruRU' AND `entry` = 33081;
-- OLD name : Железное создание (Magma Visual)
-- Source : https://www.wowhead.com/wotlk/ru/npc=33122
UPDATE `creature_template_locale` SET `Name` = '[Iron Construct (Magma Visual)]' WHERE `locale` = 'ruRU' AND `entry` = 33122;
-- OLD name : Кукловод
-- Source : https://www.wowhead.com/wotlk/ru/npc=33128
UPDATE `creature_template_locale` SET `Name` = '[Puppeteer]' WHERE `locale` = 'ruRU' AND `entry` = 33128;
-- OLD name : Гном-марионетка
-- Source : https://www.wowhead.com/wotlk/ru/npc=33129
UPDATE `creature_template_locale` SET `Name` = '[Gnome Puppet]' WHERE `locale` = 'ruRU' AND `entry` = 33129;
-- OLD name : Марионетка
-- Source : https://www.wowhead.com/wotlk/ru/npc=33137
UPDATE `creature_template_locale` SET `Name` = '[Puppet Hand]' WHERE `locale` = 'ruRU' AND `entry` = 33137;
-- OLD name : Demolisher Engineering Console (Old)
-- Source : https://www.wowhead.com/wotlk/ru/npc=33146
UPDATE `creature_template_locale` SET `Name` = '[Demolisher Engineering Console (Old)]' WHERE `locale` = 'ruRU' AND `entry` = 33146;
-- OLD name : Ящик гранат
-- Source : https://www.wowhead.com/wotlk/ru/npc=33185
UPDATE `creature_template_locale` SET `Name` = '[Grenade Crate]' WHERE `locale` = 'ruRU' AND `entry` = 33185;
-- OLD name : Icecrown Scourge Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=33192
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Scourge Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 33192;
-- OLD name : Дунморогский медвежонок
-- Source : https://www.wowhead.com/wotlk/ru/npc=33194
UPDATE `creature_template_locale` SET `Name` = 'Дун-морогский медвежонок' WHERE `locale` = 'ruRU' AND `entry` = 33194;
-- OLD name : Ожог
-- Source : https://www.wowhead.com/wotlk/ru/npc=33221
UPDATE `creature_template_locale` SET `Name` = 'Сполох' WHERE `locale` = 'ruRU' AND `entry` = 33221;
-- OLD subname : Знаток лошадей
-- Source : https://www.wowhead.com/wotlk/ru/npc=33223
UPDATE `creature_template_locale` SET `Title` = 'Специалист по лошадям' WHERE `locale` = 'ruRU' AND `entry` = 33223;
-- OLD name : Прибрежный ползун
-- Source : https://www.wowhead.com/wotlk/ru/npc=33226
UPDATE `creature_template_locale` SET `Name` = 'Береговой краб' WHERE `locale` = 'ruRU' AND `entry` = 33226;
-- OLD name : Дар Эонара
-- Source : https://www.wowhead.com/wotlk/ru/npc=33228
UPDATE `creature_template_locale` SET `Name` = 'Дар Эонар' WHERE `locale` = 'ruRU' AND `entry` = 33228;
-- OLD name : Оруженосец Черного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=33240
UPDATE `creature_template_locale` SET `Name` = '[Ebon Squire [PH]]' WHERE `locale` = 'ruRU' AND `entry` = 33240;
-- OLD name : Iron Dwarf Warrior [PH]
-- Source : https://www.wowhead.com/wotlk/ru/npc=33246
UPDATE `creature_template_locale` SET `Name` = '[Iron Dwarf Warrior [PH]]' WHERE `locale` = 'ruRU' AND `entry` = 33246;
-- OLD name : Слово силы: Барьер
-- Source : https://www.wowhead.com/wotlk/ru/npc=33248
UPDATE `creature_template_locale` SET `Name` = '[Power Word: Barrier]' WHERE `locale` = 'ruRU' AND `entry` = 33248;
-- OLD name : Наставник рыцарей смерти и кузня рун
-- Source : https://www.wowhead.com/wotlk/ru/npc=33251
UPDATE `creature_template_locale` SET `Name` = '[Death Knight Trainer and Runeforge]' WHERE `locale` = 'ruRU' AND `entry` = 33251;
-- OLD name : Элвиннский лесной волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=33286
UPDATE `creature_template_locale` SET `Name` = '[Elwynn Forest Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 33286;
-- OLD name : Джиллиан Максоус, subname : Прелестнейшая из Максоусов
-- Source : https://www.wowhead.com/wotlk/ru/npc=33290
UPDATE `creature_template_locale` SET `Name` = '[Jillian McWeaksauce]',`Title` = '[The Cutest McWeaksauce]' WHERE `locale` = 'ruRU' AND `entry` = 33290;
-- OLD name : Гном Джером
-- Source : https://www.wowhead.com/wotlk/ru/npc=33314
UPDATE `creature_template_locale` SET `Name` = '[Gerome the Gnome]' WHERE `locale` = 'ruRU' AND `entry` = 33314;
-- OLD name : Morgan Test
-- Source : https://www.wowhead.com/wotlk/ru/npc=33351
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33351;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (33351, 'ruRU','[Morgan Test]',NULL);
-- OLD name : "Призрачный тигр"
-- Source : https://www.wowhead.com/wotlk/ru/npc=33357
UPDATE `creature_template_locale` SET `Name` = '["Spectral Tiger"]' WHERE `locale` = 'ruRU' AND `entry` = 33357;
-- OLD name : Сетка наведения адского огня Мимирона
-- Source : https://www.wowhead.com/wotlk/ru/npc=33369
UPDATE `creature_template_locale` SET `Name` = 'Сетка наведения инферналя Мимирона' WHERE `locale` = 'ruRU' AND `entry` = 33369;
-- OLD name : Ловчий смерти Визери
-- Source : https://www.wowhead.com/wotlk/ru/npc=33373
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти Визери' WHERE `locale` = 'ruRU' AND `entry` = 33373;
-- OLD name : Hammer Vehicle [PH]
-- Source : https://www.wowhead.com/wotlk/ru/npc=33380
UPDATE `creature_template_locale` SET `Name` = '[Hammer Vehicle [PH]]' WHERE `locale` = 'ruRU' AND `entry` = 33380;
-- OLD name : Оргриммарский волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=33409
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 33409;
-- OLD name : Боевой конь Отрекшихся
-- Source : https://www.wowhead.com/wotlk/ru/npc=33414
UPDATE `creature_template_locale` SET `Name` = 'Стремительный боевой конь Отрекшихся' WHERE `locale` = 'ruRU' AND `entry` = 33414;
-- OLD name : Horde Engineer [PH]
-- Source : https://www.wowhead.com/wotlk/ru/npc=33425
UPDATE `creature_template_locale` SET `Name` = '[Horde Engineer [PH]]' WHERE `locale` = 'ruRU' AND `entry` = 33425;
-- OLD name : Horde Dragon Handler [PH]
-- Source : https://www.wowhead.com/wotlk/ru/npc=33426
UPDATE `creature_template_locale` SET `Name` = '[Horde Dragon Handler [PH]]' WHERE `locale` = 'ruRU' AND `entry` = 33426;
-- OLD name : Лесной плеточник
-- Source : https://www.wowhead.com/wotlk/ru/npc=33431
UPDATE `creature_template_locale` SET `Name` = 'Лесной ползун' WHERE `locale` = 'ruRU' AND `entry` = 33431;
-- OLD name : Претендент из Оргриммара
-- Source : https://www.wowhead.com/wotlk/ru/npc=33461
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Aspirant]' WHERE `locale` = 'ruRU' AND `entry` = 33461;
-- OLD name : Претендент из Гномрегана
-- Source : https://www.wowhead.com/wotlk/ru/npc=33464
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Aspirant]' WHERE `locale` = 'ruRU' AND `entry` = 33464;
-- OLD name : Претендент из Луносвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=33466
UPDATE `creature_template_locale` SET `Name` = '[Silvermoon Aspirant]' WHERE `locale` = 'ruRU' AND `entry` = 33466;
-- OLD name : Претендент из Подгорода
-- Source : https://www.wowhead.com/wotlk/ru/npc=33470
UPDATE `creature_template_locale` SET `Name` = '[Undercity Aspirant]' WHERE `locale` = 'ruRU' AND `entry` = 33470;
-- OLD name : Чемпион Громового Утеса
-- Source : https://www.wowhead.com/wotlk/ru/npc=33471
UPDATE `creature_template_locale` SET `Name` = '[Thunder Bluff Champion]' WHERE `locale` = 'ruRU' AND `entry` = 33471;
-- OLD name : Претендент из Громового Утеса
-- Source : https://www.wowhead.com/wotlk/ru/npc=33472
UPDATE `creature_template_locale` SET `Name` = '[Thunder Bluff Aspirant]' WHERE `locale` = 'ruRU' AND `entry` = 33472;
-- OLD name : Чемпион Сен'джина
-- Source : https://www.wowhead.com/wotlk/ru/npc=33474
UPDATE `creature_template_locale` SET `Name` = 'Чемпион Сен''джин' WHERE `locale` = 'ruRU' AND `entry` = 33474;
-- OLD name : Претендент из деревни Сен'джин
-- Source : https://www.wowhead.com/wotlk/ru/npc=33475
UPDATE `creature_template_locale` SET `Name` = '[Sen''jin Aspirant]' WHERE `locale` = 'ruRU' AND `entry` = 33475;
-- OLD name : Претендент из Штормграда
-- Source : https://www.wowhead.com/wotlk/ru/npc=33478
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Aspirant]' WHERE `locale` = 'ruRU' AND `entry` = 33478;
-- OLD name : Претендент из Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=33482
UPDATE `creature_template_locale` SET `Name` = '[Ironforge Aspirant]' WHERE `locale` = 'ruRU' AND `entry` = 33482;
-- OLD name : Приручаемая гончая Недр
-- Source : https://www.wowhead.com/wotlk/ru/npc=33502
UPDATE `creature_template_locale` SET `Name` = '[Tamable Core Hound]' WHERE `locale` = 'ruRU' AND `entry` = 33502;
-- OLD name : Horde Commander [PH]
-- Source : https://www.wowhead.com/wotlk/ru/npc=33503
UPDATE `creature_template_locale` SET `Name` = '[Horde Commander [PH]]' WHERE `locale` = 'ruRU' AND `entry` = 33503;
-- OLD name : Приручаемая химера
-- Source : https://www.wowhead.com/wotlk/ru/npc=33504
UPDATE `creature_template_locale` SET `Name` = '[Tamable Chimaera]' WHERE `locale` = 'ruRU' AND `entry` = 33504;
-- OLD name : Приручаемый дьявозавр
-- Source : https://www.wowhead.com/wotlk/ru/npc=33505
UPDATE `creature_template_locale` SET `Name` = '[Tamable Devilsaur]' WHERE `locale` = 'ruRU' AND `entry` = 33505;
-- OLD name : Приручаемый люторог
-- Source : https://www.wowhead.com/wotlk/ru/npc=33506
UPDATE `creature_template_locale` SET `Name` = '[Tamable Rhino]' WHERE `locale` = 'ruRU' AND `entry` = 33506;
-- OLD name : Приручаемый силитид
-- Source : https://www.wowhead.com/wotlk/ru/npc=33508
UPDATE `creature_template_locale` SET `Name` = '[Tamable Silithid]' WHERE `locale` = 'ruRU' AND `entry` = 33508;
-- OLD name : Приручаемый дух зверя
-- Source : https://www.wowhead.com/wotlk/ru/npc=33510
UPDATE `creature_template_locale` SET `Name` = '[Tamable Spirit Beast]' WHERE `locale` = 'ruRU' AND `entry` = 33510;
-- OLD name : Приручаемый червяк
-- Source : https://www.wowhead.com/wotlk/ru/npc=33511
UPDATE `creature_template_locale` SET `Name` = '[Tamable Worm]' WHERE `locale` = 'ruRU' AND `entry` = 33511;
-- OLD name : Трещина в земле
-- Source : https://www.wowhead.com/wotlk/ru/npc=33516
UPDATE `creature_template_locale` SET `Name` = 'Трещина в почве' WHERE `locale` = 'ruRU' AND `entry` = 33516;
-- OLD name : Бронированный вороной грифон
-- Source : https://www.wowhead.com/wotlk/ru/npc=33517
UPDATE `creature_template_locale` SET `Name` = '[Armored Ebon Gryphon]' WHERE `locale` = 'ruRU' AND `entry` = 33517;
-- OLD name : Грифон Черного рыцаря
-- Source : https://www.wowhead.com/wotlk/ru/npc=33519
UPDATE `creature_template_locale` SET `Name` = 'Черный боевой грифон' WHERE `locale` = 'ruRU' AND `entry` = 33519;
-- OLD name : Волчер-сирота
-- Source : https://www.wowhead.com/wotlk/ru/npc=33532
UPDATE `creature_template_locale` SET `Name` = 'Сиротка-волчер' WHERE `locale` = 'ruRU' AND `entry` = 33532;
-- OLD name : Оракул-сирота
-- Source : https://www.wowhead.com/wotlk/ru/npc=33533
UPDATE `creature_template_locale` SET `Name` = 'Сиротка-оракул' WHERE `locale` = 'ruRU' AND `entry` = 33533;
-- OLD subname : Знаток лошадей
-- Source : https://www.wowhead.com/wotlk/ru/npc=33547
UPDATE `creature_template_locale` SET `Title` = 'Специалист по лошадям' WHERE `locale` = 'ruRU' AND `entry` = 33547;
-- OLD name : Верный штормградский скакун
-- Source : https://www.wowhead.com/wotlk/ru/npc=33551
UPDATE `creature_template_locale` SET `Name` = '[Trusty Stormwind Charger [PH]]' WHERE `locale` = 'ruRU' AND `entry` = 33551;
-- OLD name : Чемпион Дарнаса
-- Source : https://www.wowhead.com/wotlk/ru/npc=33563
UPDATE `creature_template_locale` SET `Name` = '[Darnassus Champion]' WHERE `locale` = 'ruRU' AND `entry` = 33563;
-- OLD name : Рыба
-- Source : https://www.wowhead.com/wotlk/ru/npc=33568
UPDATE `creature_template_locale` SET `Name` = '[Fish]' WHERE `locale` = 'ruRU' AND `entry` = 33568;
-- OLD name : Тестовый манекен Берно
-- Source : https://www.wowhead.com/wotlk/ru/npc=33570
UPDATE `creature_template_locale` SET `Name` = '[Bernau Test Dummy]' WHERE `locale` = 'ruRU' AND `entry` = 33570;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33580
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 33580;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=33581
UPDATE `creature_template_locale` SET `Title` = 'Мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 33581;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=33583
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 33583;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33586
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 33586;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=33587
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 33587;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=33588
UPDATE `creature_template_locale` SET `Title` = 'Великий алхимик' WHERE `locale` = 'ruRU' AND `entry` = 33588;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=33589
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер оказания первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 33589;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33590
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 33590;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33591
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 33591;
-- OLD subname : Товары для алхимиков
-- Source : https://www.wowhead.com/wotlk/ru/npc=33600
UPDATE `creature_template_locale` SET `Title` = 'Товары для алхимика' WHERE `locale` = 'ruRU' AND `entry` = 33600;
-- OLD subname : Товары для кожевников
-- Source : https://www.wowhead.com/wotlk/ru/npc=33601
UPDATE `creature_template_locale` SET `Title` = 'Товары для кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 33601;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=33603
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 33603;
-- OLD name : Кожевничество
-- Source : https://www.wowhead.com/wotlk/ru/npc=33612
UPDATE `creature_template_locale` SET `Name` = 'Кожевенное дело' WHERE `locale` = 'ruRU' AND `entry` = 33612;
-- OLD name : Кулинария
-- Source : https://www.wowhead.com/wotlk/ru/npc=33619
UPDATE `creature_template_locale` SET `Name` = 'Кулинарное дело' WHERE `locale` = 'ruRU' AND `entry` = 33619;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=33626
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 33626;
-- OLD name : Верховный лорд Тирион Фордринг
-- Source : https://www.wowhead.com/wotlk/ru/npc=33628
UPDATE `creature_template_locale` SET `Name` = '[Highlord Tirion Fordring]' WHERE `locale` = 'ruRU' AND `entry` = 33628;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=33630
UPDATE `creature_template_locale` SET `Title` = 'Мастер алхимии' WHERE `locale` = 'ruRU' AND `entry` = 33630;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33631
UPDATE `creature_template_locale` SET `Title` = 'Мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 33631;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=33633
UPDATE `creature_template_locale` SET `Title` = 'Мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 33633;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33634
UPDATE `creature_template_locale` SET `Title` = 'Учитель мастеров инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 33634;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=33635
UPDATE `creature_template_locale` SET `Title` = 'Мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 33635;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33636
UPDATE `creature_template_locale` SET `Title` = 'Мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 33636;
-- OLD name : Кирембри Серебряная Грива, subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33637
UPDATE `creature_template_locale` SET `Name` = 'Киремби Серебряная Грива',`Title` = 'Мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 33637;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=33638
UPDATE `creature_template_locale` SET `Title` = 'Мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 33638;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=33639
UPDATE `creature_template_locale` SET `Title` = 'Мастер травничества' WHERE `locale` = 'ruRU' AND `entry` = 33639;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33640
UPDATE `creature_template_locale` SET `Title` = 'Мастер горного дела' WHERE `locale` = 'ruRU' AND `entry` = 33640;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=33641
UPDATE `creature_template_locale` SET `Title` = 'Мастер снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 33641;
-- OLD name : "Гоблинское долото"
-- Source : https://www.wowhead.com/wotlk/ru/npc=33660
UPDATE `creature_template_locale` SET `Name` = '[Goblin Chisel]' WHERE `locale` = 'ruRU' AND `entry` = 33660;
-- OLD name : Patchwerk (PTR DPS Test)
-- Source : https://www.wowhead.com/wotlk/ru/npc=33663
UPDATE `creature_template_locale` SET `Name` = '[Patchwerk (PTR DPS Test)]' WHERE `locale` = 'ruRU' AND `entry` = 33663;
-- OLD name : Урсула Максоус, subname : Продавщица убер-рубашки
-- Source : https://www.wowhead.com/wotlk/ru/npc=33665
UPDATE `creature_template_locale` SET `Name` = '[Ursula McWeaksauce]',`Title` = '[Shirt of Uber Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33665;
-- OLD name : Patchwerk (PTR Tank Test)
-- Source : https://www.wowhead.com/wotlk/ru/npc=33667
UPDATE `creature_template_locale` SET `Name` = '[Patchwerk (PTR Tank Test)]' WHERE `locale` = 'ruRU' AND `entry` = 33667;
-- OLD name : Верховой краб
-- Source : https://www.wowhead.com/wotlk/ru/npc=33671
UPDATE `creature_template_locale` SET `Name` = '[Crawler Mount]' WHERE `locale` = 'ruRU' AND `entry` = 33671;
-- OLD name : Пингоро, subname : Князь пингвинов
-- Source : https://www.wowhead.com/wotlk/ru/npc=33673
UPDATE `creature_template_locale` SET `Name` = '[Pengoro]',`Title` = '[Prince of Penguins]' WHERE `locale` = 'ruRU' AND `entry` = 33673;
-- OLD subname : Учитель алхимии
-- Source : https://www.wowhead.com/wotlk/ru/npc=33674
UPDATE `creature_template_locale` SET `Title` = 'Мастер алхимии' WHERE `locale` = 'ruRU' AND `entry` = 33674;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33675
UPDATE `creature_template_locale` SET `Title` = 'Мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 33675;
-- OLD subname : Учитель наложения чар
-- Source : https://www.wowhead.com/wotlk/ru/npc=33676
UPDATE `creature_template_locale` SET `Title` = 'Мастер наложения чар' WHERE `locale` = 'ruRU' AND `entry` = 33676;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33677
UPDATE `creature_template_locale` SET `Title` = 'Учитель мастеров инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 33677;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=33678
UPDATE `creature_template_locale` SET `Title` = 'Мастер травничества' WHERE `locale` = 'ruRU' AND `entry` = 33678;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=33679
UPDATE `creature_template_locale` SET `Title` = 'Мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 33679;
-- OLD subname : Учитель ювелирного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33680
UPDATE `creature_template_locale` SET `Title` = 'Мастер ювелирного дела' WHERE `locale` = 'ruRU' AND `entry` = 33680;
-- OLD subname : Учитель кожевничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=33681
UPDATE `creature_template_locale` SET `Title` = 'Мастер кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 33681;
-- OLD subname : Учитель горного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33682
UPDATE `creature_template_locale` SET `Title` = 'Мастер горного дела' WHERE `locale` = 'ruRU' AND `entry` = 33682;
-- OLD subname : Учитель снятия шкур
-- Source : https://www.wowhead.com/wotlk/ru/npc=33683
UPDATE `creature_template_locale` SET `Title` = 'Мастер снятия шкур' WHERE `locale` = 'ruRU' AND `entry` = 33683;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=33684
UPDATE `creature_template_locale` SET `Title` = 'Мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 33684;
-- OLD name : Джеймс Барло, subname : Мастер рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=33685
UPDATE `creature_template_locale` SET `Name` = '[James Barlo]',`Title` = '[Master of Fishing]' WHERE `locale` = 'ruRU' AND `entry` = 33685;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=33701
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 33701;
-- OLD name : Argent Champion Credit (Valiant Test), subname : С.С.М.
-- Source : https://www.wowhead.com/wotlk/ru/npc=33708
UPDATE `creature_template_locale` SET `Name` = '[Argent Champion Credit (Valiant Test)]',`Title` = '[S.T.O.U.T.]' WHERE `locale` = 'ruRU' AND `entry` = 33708;
-- OLD name : Бронзовая супруга
-- Source : https://www.wowhead.com/wotlk/ru/npc=33718
UPDATE `creature_template_locale` SET `Name` = '[Bronze Consort]' WHERE `locale` = 'ruRU' AND `entry` = 33718;
-- OLD name : Чемпион Сен'джина
-- Source : https://www.wowhead.com/wotlk/ru/npc=33745
UPDATE `creature_template_locale` SET `Name` = 'Чемпион Сен''джин' WHERE `locale` = 'ruRU' AND `entry` = 33745;
-- OLD name : Оскверненная земля II
-- Source : https://www.wowhead.com/wotlk/ru/npc=33751
UPDATE `creature_template_locale` SET `Name` = '[Desecrated Ground II]' WHERE `locale` = 'ruRU' AND `entry` = 33751;
-- OLD name : Оскверненная земля III
-- Source : https://www.wowhead.com/wotlk/ru/npc=33752
UPDATE `creature_template_locale` SET `Name` = '[Desecrated Ground III]' WHERE `locale` = 'ruRU' AND `entry` = 33752;
-- OLD name : Оскверненная земля IV
-- Source : https://www.wowhead.com/wotlk/ru/npc=33753
UPDATE `creature_template_locale` SET `Name` = '[Desecrated Ground IV]' WHERE `locale` = 'ruRU' AND `entry` = 33753;
-- OLD name : Рокотан клана Темных Рун
-- Source : https://www.wowhead.com/wotlk/ru/npc=33754
UPDATE `creature_template_locale` SET `Name` = 'Рокотун из клана Темных Рун' WHERE `locale` = 'ruRU' AND `entry` = 33754;
-- OLD name : Опустошитель из клана Темных Рун
-- Source : https://www.wowhead.com/wotlk/ru/npc=33755
UPDATE `creature_template_locale` SET `Name` = 'Разрушитель из клана Темных Рун' WHERE `locale` = 'ruRU' AND `entry` = 33755;
-- OLD name : Голограмма древня Светлого Листа
-- Source : https://www.wowhead.com/wotlk/ru/npc=33761
UPDATE `creature_template_locale` SET `Name` = '[Elder Brightleaf Image]' WHERE `locale` = 'ruRU' AND `entry` = 33761;
-- OLD name : OCL Test Creature
-- Source : https://www.wowhead.com/wotlk/ru/npc=33764
UPDATE `creature_template_locale` SET `Name` = '[OCL Test Creature]' WHERE `locale` = 'ruRU' AND `entry` = 33764;
-- OLD name : Конь смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=33783
UPDATE `creature_template_locale` SET `Name` = '[Deathcharger]' WHERE `locale` = 'ruRU' AND `entry` = 33783;
-- OLD name : Horde Defender [PH]
-- Source : https://www.wowhead.com/wotlk/ru/npc=33805
UPDATE `creature_template_locale` SET `Name` = '[Horde Defender [PH]]' WHERE `locale` = 'ruRU' AND `entry` = 33805;
-- OLD name : Rubble Stalker Kologarn
-- Source : https://www.wowhead.com/wotlk/ru/npc=33809
UPDATE `creature_template_locale` SET `Name` = 'Каменный Ловчий Кологарн' WHERE `locale` = 'ruRU' AND `entry` = 33809;
-- OLD name : Сумеречный приверженец
-- Source : https://www.wowhead.com/wotlk/ru/npc=33818
UPDATE `creature_template_locale` SET `Name` = 'Приверженец культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 33818;
-- OLD name : Сумеречный ледяной маг
-- Source : https://www.wowhead.com/wotlk/ru/npc=33819
UPDATE `creature_template_locale` SET `Name` = 'Ледяной маг культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 33819;
-- OLD name : Сумеречный пиромант
-- Source : https://www.wowhead.com/wotlk/ru/npc=33820
UPDATE `creature_template_locale` SET `Name` = 'Пиромант культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 33820;
-- OLD name : Сумеречный страж
-- Source : https://www.wowhead.com/wotlk/ru/npc=33822
UPDATE `creature_template_locale` SET `Name` = 'Страж культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 33822;
-- OLD name : Сумеречный убийца
-- Source : https://www.wowhead.com/wotlk/ru/npc=33823
UPDATE `creature_template_locale` SET `Name` = 'Убийца из культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 33823;
-- OLD name : Сумеречный душегуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=33824
UPDATE `creature_template_locale` SET `Name` = 'Душегуб культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 33824;
-- OLD name : Точки фокусировки Мимирона (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33835;
-- OLD name : Голограмма древня Железной Ветви
-- Source : https://www.wowhead.com/wotlk/ru/npc=33861
UPDATE `creature_template_locale` SET `Name` = '[Elder Ironbranch Image]' WHERE `locale` = 'ruRU' AND `entry` = 33861;
-- OLD name : Голограмма древня Каменной Коры
-- Source : https://www.wowhead.com/wotlk/ru/npc=33862
UPDATE `creature_template_locale` SET `Name` = '[Elder Stonebark Image]' WHERE `locale` = 'ruRU' AND `entry` = 33862;
-- OLD name : Боевой конь Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=33863
UPDATE `creature_template_locale` SET `Name` = '[Argent Warhorse]' WHERE `locale` = 'ruRU' AND `entry` = 33863;
-- OLD name : Релга, subname : Прохладительные напитки
-- Source : https://www.wowhead.com/wotlk/ru/npc=33867
UPDATE `creature_template_locale` SET `Name` = '[Relga]',`Title` = '[Refreshments]' WHERE `locale` = 'ruRU' AND `entry` = 33867;
-- OLD name : Голограмма Фрейи
-- Source : https://www.wowhead.com/wotlk/ru/npc=33876
UPDATE `creature_template_locale` SET `Name` = '[Freya Image]' WHERE `locale` = 'ruRU' AND `entry` = 33876;
-- OLD name : Голограмма Сиф
-- Source : https://www.wowhead.com/wotlk/ru/npc=33877
UPDATE `creature_template_locale` SET `Name` = '[Sif Image]' WHERE `locale` = 'ruRU' AND `entry` = 33877;
-- OLD name : Голограмма Торима
-- Source : https://www.wowhead.com/wotlk/ru/npc=33878
UPDATE `creature_template_locale` SET `Name` = '[Thorim Image]' WHERE `locale` = 'ruRU' AND `entry` = 33878;
-- OLD name : Голограмма Ходира
-- Source : https://www.wowhead.com/wotlk/ru/npc=33879
UPDATE `creature_template_locale` SET `Name` = '[Hodir Image]' WHERE `locale` = 'ruRU' AND `entry` = 33879;
-- OLD name : Голограмма Мимирона
-- Source : https://www.wowhead.com/wotlk/ru/npc=33880
UPDATE `creature_template_locale` SET `Name` = '[Mimiron Image]' WHERE `locale` = 'ruRU' AND `entry` = 33880;
-- OLD name : Йогг-Сарон
-- Source : https://www.wowhead.com/wotlk/ru/npc=33883
UPDATE `creature_template_locale` SET `Name` = '[Yogg-Saron (Transform Only)]' WHERE `locale` = 'ruRU' AND `entry` = 33883;
-- OLD name : Арджекс Сталежорц, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33915
UPDATE `creature_template_locale` SET `Name` = '[Argex Irongut]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33915;
-- OLD name : Большой Зокк Крутируль, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33916
UPDATE `creature_template_locale` SET `Name` = '[Big Zokk Torquewrench]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33916;
-- OLD name : Эктон Меднотумблер, subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33917
UPDATE `creature_template_locale` SET `Name` = '[Ecton Brasstumbler]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33917;
-- OLD name : Кеззик Гарпунер, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33918
UPDATE `creature_template_locale` SET `Name` = '[Kezzik the Striker]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33918;
-- OLD name : Крошка Линни "Улыбайка", subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33919
UPDATE `creature_template_locale` SET `Name` = '[Leeni "Smiley" Smalls]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33919;
-- OLD name : Иви Медипрыг, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33920
UPDATE `creature_template_locale` SET `Name` = '[Evee Copperspring]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33920;
-- OLD name : Наргл Гибкошнур, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33921
UPDATE `creature_template_locale` SET `Name` = '[Nargle Lashcord]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33921;
-- OLD name : Ксази Смолюга, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33922
UPDATE `creature_template_locale` SET `Name` = '[Xazi Smolderpipe]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33922;
-- OLD name : Зом Боком, subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33923
UPDATE `creature_template_locale` SET `Name` = '[Zom Bocom]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33923;
-- OLD name : Арджекс Сталежорц, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33924
UPDATE `creature_template_locale` SET `Name` = '[Argex Irongut]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33924;
-- OLD name : Зом Боком, subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33925
UPDATE `creature_template_locale` SET `Name` = '[Zom Bocom]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33925;
-- OLD name : Ксази Смолюга, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33926
UPDATE `creature_template_locale` SET `Name` = '[Xazi Smolderpipe]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33926;
-- OLD name : Наргл Гибкошнур, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33927
UPDATE `creature_template_locale` SET `Name` = '[Nargle Lashcord]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33927;
-- OLD name : Иви Медипрыг, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33928
UPDATE `creature_template_locale` SET `Name` = '[Evee Copperspring]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33928;
-- OLD name : Эктон Меднотумблер, subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33929
UPDATE `creature_template_locale` SET `Name` = '[Ecton Brasstumbler]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33929;
-- OLD name : Крошка Линни "Улыбайка", subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33930
UPDATE `creature_template_locale` SET `Name` = '[Leeni "Smiley" Smalls]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33930;
-- OLD name : Кеззик Гарпунер, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33931
UPDATE `creature_template_locale` SET `Name` = '[Kezzik the Striker]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33931;
-- OLD name : Большой Зокк Крутируль, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33932
UPDATE `creature_template_locale` SET `Name` = '[Big Zokk Torquewrench]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33932;
-- OLD name : Большой Зокк Крутируль, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33933
UPDATE `creature_template_locale` SET `Name` = '[Big Zokk Torquewrench]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33933;
-- OLD name : Эктон Меднотумблер, subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33934
UPDATE `creature_template_locale` SET `Name` = '[Ecton Brasstumbler]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33934;
-- OLD name : Иви Медипрыг, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33935
UPDATE `creature_template_locale` SET `Name` = '[Evee Copperspring]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33935;
-- OLD name : Наргл Гибкошнур, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33936
UPDATE `creature_template_locale` SET `Name` = '[Nargle Lashcord]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33936;
-- OLD name : Ксази Смолюга, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33937
UPDATE `creature_template_locale` SET `Name` = '[Xazi Smolderpipe]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33937;
-- OLD name : Зом Боком, subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33938
UPDATE `creature_template_locale` SET `Name` = '[Zom Bocom]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33938;
-- OLD name : Арджекс Сталежорц, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33939
UPDATE `creature_template_locale` SET `Name` = '[Argex Irongut]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33939;
-- OLD name : Кеззик Гарпунер, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33940
UPDATE `creature_template_locale` SET `Name` = '[Kezzik the Striker]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33940;
-- OLD name : Крошка Линни "Улыбайка", subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=33941
UPDATE `creature_template_locale` SET `Name` = '[Leeni "Smiley" Smalls]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 33941;
-- OLD name : Торговец эмблемами завоевателя Индаламара, subname : Невероятные награды
-- Source : https://www.wowhead.com/wotlk/ru/npc=33946
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Emblem of Conquest Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'ruRU' AND `entry` = 33946;
-- OLD name : Огромный черный волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=33949
UPDATE `creature_template_locale` SET `Name` = '[Giant Black Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 33949;
-- OLD name : Огромный белый волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=33950
UPDATE `creature_template_locale` SET `Name` = '[Giant White Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 33950;
-- OLD name : Огромный серый волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=33951
UPDATE `creature_template_locale` SET `Name` = '[Giant Grey Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 33951;
-- OLD name : Огромный рыжий волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=33952
UPDATE `creature_template_locale` SET `Name` = '[Giant Red Wolf]' WHERE `locale` = 'ruRU' AND `entry` = 33952;
-- OLD subname : Эмблема завоевания Интендант
-- Source : https://www.wowhead.com/wotlk/ru/npc=33963
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы завоевания' WHERE `locale` = 'ruRU' AND `entry` = 33963;
-- OLD subname : Эмблема завоевания Интендант
-- Source : https://www.wowhead.com/wotlk/ru/npc=33964
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы завоевания' WHERE `locale` = 'ruRU' AND `entry` = 33964;
-- OLD name : Зайчик Сада чудес
-- Source : https://www.wowhead.com/wotlk/ru/npc=33975
UPDATE `creature_template_locale` SET `Name` = '[Noblegarden Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 33975;
-- OLD name : Гарри Ясновод, subname : Опытный рыбак
-- Source : https://www.wowhead.com/wotlk/ru/npc=33992
UPDATE `creature_template_locale` SET `Name` = '[Harry Clearwater]',`Title` = '[Fishmaster]' WHERE `locale` = 'ruRU' AND `entry` = 33992;
-- OLD name : Портал Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=34000
UPDATE `creature_template_locale` SET `Name` = '[Void Zone]' WHERE `locale` = 'ruRU' AND `entry` = 34000;
-- OLD name : Портал Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=34001
UPDATE `creature_template_locale` SET `Name` = 'Зона вакуума' WHERE `locale` = 'ruRU' AND `entry` = 34001;
-- OLD name : Algalon Test Creature
-- Source : https://www.wowhead.com/wotlk/ru/npc=34002
UPDATE `creature_template_locale` SET `Name` = '[Algalon Test Creature]' WHERE `locale` = 'ruRU' AND `entry` = 34002;
-- OLD name : Голограмма кнопки
-- Source : https://www.wowhead.com/wotlk/ru/npc=34011
UPDATE `creature_template_locale` SET `Name` = '[Button Image]' WHERE `locale` = 'ruRU' AND `entry` = 34011;
-- OLD name : Стремительный мышастый конь
-- Source : https://www.wowhead.com/wotlk/ru/npc=34017
UPDATE `creature_template_locale` SET `Name` = '[Swift Gray Steed]' WHERE `locale` = 'ruRU' AND `entry` = 34017;
-- OLD name : Приручаемый спороскат
-- Source : https://www.wowhead.com/wotlk/ru/npc=34018
UPDATE `creature_template_locale` SET `Name` = '[Tamable Sporebat]' WHERE `locale` = 'ruRU' AND `entry` = 34018;
-- OLD name : Приручаемая гиена
-- Source : https://www.wowhead.com/wotlk/ru/npc=34019
UPDATE `creature_template_locale` SET `Name` = '[Tamable Hyena]' WHERE `locale` = 'ruRU' AND `entry` = 34019;
-- OLD name : Приручаемый мотылек
-- Source : https://www.wowhead.com/wotlk/ru/npc=34021
UPDATE `creature_template_locale` SET `Name` = '[Tamable Moth]' WHERE `locale` = 'ruRU' AND `entry` = 34021;
-- OLD name : Приручаемый долгоног
-- Source : https://www.wowhead.com/wotlk/ru/npc=34022
UPDATE `creature_template_locale` SET `Name` = '[Tamable Tallstrider]' WHERE `locale` = 'ruRU' AND `entry` = 34022;
-- OLD name : Приручаемая оса
-- Source : https://www.wowhead.com/wotlk/ru/npc=34024
UPDATE `creature_template_locale` SET `Name` = '[Tamable Wasp]' WHERE `locale` = 'ruRU' AND `entry` = 34024;
-- OLD name : Приручаемый медведь
-- Source : https://www.wowhead.com/wotlk/ru/npc=34025
UPDATE `creature_template_locale` SET `Name` = '[Tamable Bear]' WHERE `locale` = 'ruRU' AND `entry` = 34025;
-- OLD name : Приручаемый краб
-- Source : https://www.wowhead.com/wotlk/ru/npc=34026
UPDATE `creature_template_locale` SET `Name` = '[Tamable Crab]' WHERE `locale` = 'ruRU' AND `entry` = 34026;
-- OLD name : Приручаемый кроколиск
-- Source : https://www.wowhead.com/wotlk/ru/npc=34027
UPDATE `creature_template_locale` SET `Name` = '[Tamable Crocolisk]' WHERE `locale` = 'ruRU' AND `entry` = 34027;
-- OLD name : Приручаемая горилла
-- Source : https://www.wowhead.com/wotlk/ru/npc=34028
UPDATE `creature_template_locale` SET `Name` = '[Tamable Gorilla]' WHERE `locale` = 'ruRU' AND `entry` = 34028;
-- OLD name : Приручаемая черепаха
-- Source : https://www.wowhead.com/wotlk/ru/npc=34029
UPDATE `creature_template_locale` SET `Name` = '[Tamable Turtle]' WHERE `locale` = 'ruRU' AND `entry` = 34029;
-- OLD name : Голограмма склада
-- Source : https://www.wowhead.com/wotlk/ru/npc=34032
UPDATE `creature_template_locale` SET `Name` = '[Cache Image]' WHERE `locale` = 'ruRU' AND `entry` = 34032;
-- OLD name : Сержант Громовой Рог, subname : Ученик начальника снабжения доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=34036
UPDATE `creature_template_locale` SET `Name` = '[Sergeant Thunderhorn]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34036;
-- OLD name : Сержант Громовой Рог, subname : Ученик начальника снабжения доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=34037
UPDATE `creature_template_locale` SET `Name` = '[Sergeant Thunderhorn]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34037;
-- OLD name : Сержант Громовой Рог, subname : Ученик начальника снабжения доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=34038
UPDATE `creature_template_locale` SET `Name` = '[Sergeant Thunderhorn]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34038;
-- OLD name : Леди Палансир, subname : Интендант ювелиров
-- Source : https://www.wowhead.com/wotlk/ru/npc=34039
UPDATE `creature_template_locale` SET `Name` = '[Lady Palanseer]',`Title` = '[Jewelcrafting Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34039;
-- OLD name : Леди Палансир, subname : Интендант ювелиров
-- Source : https://www.wowhead.com/wotlk/ru/npc=34040
UPDATE `creature_template_locale` SET `Name` = '[Lady Palanseer]',`Title` = '[Jewelcrafting Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34040;
-- OLD name : Рыба-призрак, subname : Выдающийся дизайнер
-- Source : https://www.wowhead.com/wotlk/ru/npc=34042
UPDATE `creature_template_locale` SET `Name` = '[Phantom Ghostfish]',`Title` = '[Designer Extraordinaire]' WHERE `locale` = 'ruRU' AND `entry` = 34042;
-- OLD name : Рация Бронзоборода (NO TRANSLATION EXIST)
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34054;
-- OLD name : Дорисса Летуни, subname : Начальник снабжения ветеранскими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=34058
UPDATE `creature_template_locale` SET `Name` = '[Doris Volanthius]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34058;
-- OLD name : Дорисса Летуни, subname : Начальник снабжения ветеранскими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=34059
UPDATE `creature_template_locale` SET `Name` = '[Doris Volanthius]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34059;
-- OLD name : Дорисса Летуни, subname : Начальник снабжения ветеранскими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=34060
UPDATE `creature_template_locale` SET `Name` = '[Doris Volanthius]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34060;
-- OLD name : Кровавый страж Зар'ши, subname : Начальник снабжения доспехами Нордскола
-- Source : https://www.wowhead.com/wotlk/ru/npc=34061
UPDATE `creature_template_locale` SET `Name` = '[Blood Guard Zar''shi]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34061;
-- OLD name : Кровавый страж Зар'ши, subname : Начальник снабжения доспехами Нордскола
-- Source : https://www.wowhead.com/wotlk/ru/npc=34062
UPDATE `creature_template_locale` SET `Name` = '[Blood Guard Zar''shi]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34062;
-- OLD name : Кровавый страж Зар'ши, subname : Начальник снабжения доспехами Нордскола
-- Source : https://www.wowhead.com/wotlk/ru/npc=34063
UPDATE `creature_template_locale` SET `Name` = '[Blood Guard Zar''shi]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34063;
-- OLD name : Урел Каменное Сердце
-- Source : https://www.wowhead.com/wotlk/ru/npc=34070
UPDATE `creature_template_locale` SET `Name` = '[Urel Stoneheart]' WHERE `locale` = 'ruRU' AND `entry` = 34070;
-- OLD name : Капитан Сокрушающий Молот, subname : Начальник снабжения доспехами для новичков
-- Source : https://www.wowhead.com/wotlk/ru/npc=34073
UPDATE `creature_template_locale` SET `Name` = '[Captain Dirgehammer]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34073;
-- OLD name : Капитан Сокрушающий Молот, subname : Начальник снабжения доспехами для новичков
-- Source : https://www.wowhead.com/wotlk/ru/npc=34074
UPDATE `creature_template_locale` SET `Name` = '[Captain Dirgehammer]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34074;
-- OLD name : Капитан Сокрушающий Молот, subname : Начальник снабжения доспехами для новичков
-- Source : https://www.wowhead.com/wotlk/ru/npc=34075
UPDATE `creature_template_locale` SET `Name` = '[Captain Dirgehammer]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34075;
-- OLD name : Лейтенант Тристия, subname : Начальник снабжения ветеранскими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=34076
UPDATE `creature_template_locale` SET `Name` = '[Lieutenant Tristia]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34076;
-- OLD name : Лейтенант Тристия, subname : Начальник снабжения ветеранскими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=34077
UPDATE `creature_template_locale` SET `Name` = '[Lieutenant Tristia]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34077;
-- OLD name : Лейтенант Тристия, subname : Начальник снабжения ветеранскими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=34078
UPDATE `creature_template_locale` SET `Name` = '[Lieutenant Tristia]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34078;
-- OLD name : Капитан О'Нил, subname : Интендант ювелиров
-- Source : https://www.wowhead.com/wotlk/ru/npc=34080
UPDATE `creature_template_locale` SET `Name` = '[Captain O''Neal]',`Title` = '[Jewelcrafting Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34080;
-- OLD name : Капитан О'Нил, subname : Интендант ювелиров
-- Source : https://www.wowhead.com/wotlk/ru/npc=34081
UPDATE `creature_template_locale` SET `Name` = '[Captain O''Neal]',`Title` = '[Jewelcrafting Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34081;
-- OLD name : Рыцарь-лейтенант Лунная Заря, subname : Начальник снабжения доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=34082
UPDATE `creature_template_locale` SET `Name` = '[Knight-Lieutenant Moonstrike]',`Title` = '[Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34082;
-- OLD name : Рыцарь-лейтенант Лунная Заря, subname : Начальник снабжения доспехами Нордскола
-- Source : https://www.wowhead.com/wotlk/ru/npc=34083
UPDATE `creature_template_locale` SET `Name` = '[Knight-Lieutenant Moonstrike]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34083;
-- OLD name : Рыцарь-лейтенант Лунная Заря, subname : Начальник снабжения доспехами Нордскола
-- Source : https://www.wowhead.com/wotlk/ru/npc=34084
UPDATE `creature_template_locale` SET `Name` = '[Knight-Lieutenant Moonstrike]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 34084;
-- OLD name : Блаззек Кусака, subname : Исключительное оружие для арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=34088
UPDATE `creature_template_locale` SET `Name` = '[Blazzek the Biter]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'ruRU' AND `entry` = 34088;
-- OLD name : Грекс Мозговар, subname : Исключительное оружие для арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=34089
UPDATE `creature_template_locale` SET `Name` = '[Grex Brainboiler]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'ruRU' AND `entry` = 34089;
-- OLD name : Блаззек Кусака, subname : Исключительное оружие для арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=34090
UPDATE `creature_template_locale` SET `Name` = '[Blazzek the Biter]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'ruRU' AND `entry` = 34090;
-- OLD name : Грекс Мозговар, subname : Исключительное оружие для арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=34091
UPDATE `creature_template_locale` SET `Name` = '[Grex Brainboiler]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'ruRU' AND `entry` = 34091;
-- OLD name : Чуднокусь Рикс, subname : Исключительное оружие для арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=34092
UPDATE `creature_template_locale` SET `Name` = '[Trapjaw Rix]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'ruRU' AND `entry` = 34092;
-- OLD name : Блаззек Кусака, subname : Исключительное оружие для арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=34093
UPDATE `creature_template_locale` SET `Name` = '[Blazzek the Biter]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'ruRU' AND `entry` = 34093;
-- OLD name : Грекс Мозговар, subname : Исключительное оружие для арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=34094
UPDATE `creature_template_locale` SET `Name` = '[Grex Brainboiler]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'ruRU' AND `entry` = 34094;
-- OLD name : Чуднокусь Рикс, subname : Исключительное оружие для арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=34095
UPDATE `creature_template_locale` SET `Name` = '[Trapjaw Rix]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'ruRU' AND `entry` = 34095;
-- OLD name : Черный рыцарь
-- Source : https://www.wowhead.com/wotlk/ru/npc=34104
UPDATE `creature_template_locale` SET `Name` = '[The Black Knight (No helmet)]' WHERE `locale` = 'ruRU' AND `entry` = 34104;
-- OLD name : Скакун Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=34107
UPDATE `creature_template_locale` SET `Name` = '[Argent Charger (No abilities)]' WHERE `locale` = 'ruRU' AND `entry` = 34107;
-- OLD name : Воображаемая рыба
-- Source : https://www.wowhead.com/wotlk/ru/npc=34116
UPDATE `creature_template_locale` SET `Name` = '[Shadowy Fish]' WHERE `locale` = 'ruRU' AND `entry` = 34116;
-- OLD name : Чумная костяная телега
-- Source : https://www.wowhead.com/wotlk/ru/npc=34128
UPDATE `creature_template_locale` SET `Name` = '[Boneguard Plague Wagon]' WHERE `locale` = 'ruRU' AND `entry` = 34128;
-- OLD name : Синий боевой конь-скелет
-- Source : https://www.wowhead.com/wotlk/ru/npc=34154
UPDATE `creature_template_locale` SET `Name` = '[Blue Skeletal Warhorse]' WHERE `locale` = 'ruRU' AND `entry` = 34154;
-- OLD name : Ядошкурый равазавр
-- Source : https://www.wowhead.com/wotlk/ru/npc=34156
UPDATE `creature_template_locale` SET `Name` = 'Верховой ядошкурый равазавр' WHERE `locale` = 'ruRU' AND `entry` = 34156;
-- OLD name : Toxic Tolerance Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=34157
UPDATE `creature_template_locale` SET `Name` = '[Toxic Tolerance Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 34157;
-- OLD name : Механогномский танк
-- Source : https://www.wowhead.com/wotlk/ru/npc=34164
UPDATE `creature_template_locale` SET `Name` = 'Мехагномский танк' WHERE `locale` = 'ruRU' AND `entry` = 34164;
-- OLD name : Джек Максоус, subname : Ulduar 10 Vehicle Test Gear
-- Source : https://www.wowhead.com/wotlk/ru/npc=34168
UPDATE `creature_template_locale` SET `Name` = '[Jack McWeaksauce]',`Title` = '[Ulduar 10 Vehicle Test Gear]' WHERE `locale` = 'ruRU' AND `entry` = 34168;
-- OLD name : Капитан Джулиан Максоус, subname : Сияющий сокол
-- Source : https://www.wowhead.com/wotlk/ru/npc=34172
UPDATE `creature_template_locale` SET `Name` = '[Captain Julian McWeaksauce]',`Title` = '[The Flaming Falcon]' WHERE `locale` = 'ruRU' AND `entry` = 34172;
-- OLD name : Бабушка Максоус, subname : Будущее снаряжение
-- Source : https://www.wowhead.com/wotlk/ru/npc=34173
UPDATE `creature_template_locale` SET `Name` = '[Granny McWeaksauce]',`Title` = '[Future Loot Tier Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 34173;
-- OLD name : Гриллз
-- Source : https://www.wowhead.com/wotlk/ru/npc=34178
UPDATE `creature_template_locale` SET `Name` = '[Grylls]' WHERE `locale` = 'ruRU' AND `entry` = 34178;
-- OLD name : Страж передней
-- Source : https://www.wowhead.com/wotlk/ru/npc=34197
UPDATE `creature_template_locale` SET `Name` = 'Страж Вестибюля' WHERE `locale` = 'ruRU' AND `entry` = 34197;
-- OLD name : Influence Tentacle Visual
-- Source : https://www.wowhead.com/wotlk/ru/npc=34202
UPDATE `creature_template_locale` SET `Name` = '[Influence Tentacle Visual]' WHERE `locale` = 'ruRU' AND `entry` = 34202;
-- OLD name : Воспламеняющая руна
-- Source : https://www.wowhead.com/wotlk/ru/npc=34213
UPDATE `creature_template_locale` SET `Name` = '[Flaming Rune]' WHERE `locale` = 'ruRU' AND `entry` = 34213;
-- OLD name : Взрыв мины
-- Source : https://www.wowhead.com/wotlk/ru/npc=34223
UPDATE `creature_template_locale` SET `Name` = 'Взрыв сапера' WHERE `locale` = 'ruRU' AND `entry` = 34223;
-- OLD name : Azeroth Planet Stalker
-- Source : https://www.wowhead.com/wotlk/ru/npc=34250
UPDATE `creature_template_locale` SET `Name` = '[Azeroth Planet Stalker]' WHERE `locale` = 'ruRU' AND `entry` = 34250;
-- OLD name : Сара
-- Source : https://www.wowhead.com/wotlk/ru/npc=34313
UPDATE `creature_template_locale` SET `Name` = '[Sara (Transform Only)]' WHERE `locale` = 'ruRU' AND `entry` = 34313;
-- OLD name : Dino Meat Feeding Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=34327
UPDATE `creature_template_locale` SET `Name` = '[Dino Meat Feeding Credit]' WHERE `locale` = 'ruRU' AND `entry` = 34327;
-- OLD name : Silithid Meat Feeding Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=34336
UPDATE `creature_template_locale` SET `Name` = '[Silithid Meat Feeding Credit]' WHERE `locale` = 'ruRU' AND `entry` = 34336;
-- OLD name : Silithid Egg Feeding Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=34338
UPDATE `creature_template_locale` SET `Name` = '[Silithid Egg Feeding Credit]' WHERE `locale` = 'ruRU' AND `entry` = 34338;
-- OLD name : Кьоик
-- Source : https://www.wowhead.com/wotlk/ru/npc=34360
UPDATE `creature_template_locale` SET `Name` = '[Wabbit]' WHERE `locale` = 'ruRU' AND `entry` = 34360;
-- OLD name : Верховный оракул Су-ру
-- Source : https://www.wowhead.com/wotlk/ru/npc=34386
UPDATE `creature_template_locale` SET `Name` = '[High-Oracle Soo-roo]' WHERE `locale` = 'ruRU' AND `entry` = 34386;
-- OLD name : Старейшина Кекек
-- Source : https://www.wowhead.com/wotlk/ru/npc=34387
UPDATE `creature_template_locale` SET `Name` = '[Elder Kekek]' WHERE `locale` = 'ruRU' AND `entry` = 34387;
-- OLD name : Тестовый торговец
-- Source : https://www.wowhead.com/wotlk/ru/npc=34393
UPDATE `creature_template_locale` SET `Name` = '[Test Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 34393;
-- OLD name : Мини-дирижабль
-- Source : https://www.wowhead.com/wotlk/ru/npc=34428
UPDATE `creature_template_locale` SET `Name` = '[MiniZep]' WHERE `locale` = 'ruRU' AND `entry` = 34428;
-- OLD name : ELM Daze Target
-- Source : https://www.wowhead.com/wotlk/ru/npc=34434
UPDATE `creature_template_locale` SET `Name` = '[ELM Daze Target]' WHERE `locale` = 'ruRU' AND `entry` = 34434;
-- OLD name : ELM Attacker
-- Source : https://www.wowhead.com/wotlk/ru/npc=34436
UPDATE `creature_template_locale` SET `Name` = '[ELM Attacker]' WHERE `locale` = 'ruRU' AND `entry` = 34436;
-- OLD name : Военачальник Острова Завоеваний
-- Source : https://www.wowhead.com/wotlk/ru/npc=34437
UPDATE `creature_template_locale` SET `Name` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 34437;
-- OLD name : Веселый дух Отрекшегося
-- Source : https://www.wowhead.com/wotlk/ru/npc=34476
UPDATE `creature_template_locale` SET `Name` = '[Cheerful Forsaken Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 34476;
-- OLD name : Веселый дух таурена
-- Source : https://www.wowhead.com/wotlk/ru/npc=34480
UPDATE `creature_template_locale` SET `Name` = '[Cheerful Tauren Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 34480;
-- OLD name : Веселый дух эльфийки крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=34483
UPDATE `creature_template_locale` SET `Name` = '[Cheerful Blood Elf Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 34483;
-- OLD name : Веселый дух дренея
-- Source : https://www.wowhead.com/wotlk/ru/npc=34484
UPDATE `creature_template_locale` SET `Name` = '[Cheerful Draenei Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 34484;
-- OLD name : Новый друг из Зимних Плавников
-- Source : https://www.wowhead.com/wotlk/ru/npc=34489
UPDATE `creature_template_locale` SET `Name` = '[Winterfin Playmate]' WHERE `locale` = 'ruRU' AND `entry` = 34489;
-- OLD name : Новый друг с Поляны Снегопада
-- Source : https://www.wowhead.com/wotlk/ru/npc=34490
UPDATE `creature_template_locale` SET `Name` = '[Snowfall Glade Playmate]' WHERE `locale` = 'ruRU' AND `entry` = 34490;
-- OLD name : XT-005 Debugger
-- Source : https://www.wowhead.com/wotlk/ru/npc=34515
UPDATE `creature_template_locale` SET `Name` = '[XT-005 Debugger]' WHERE `locale` = 'ruRU' AND `entry` = 34515;
-- OLD name : Оракул-сирота
-- Source : https://www.wowhead.com/wotlk/ru/npc=34519
UPDATE `creature_template_locale` SET `Name` = 'Сиротка-оракул' WHERE `locale` = 'ruRU' AND `entry` = 34519;
-- OLD name : Волчер-сирота
-- Source : https://www.wowhead.com/wotlk/ru/npc=34520
UPDATE `creature_template_locale` SET `Name` = 'Сиротка-волчер' WHERE `locale` = 'ruRU' AND `entry` = 34520;
-- OLD name : Ру
-- Source : https://www.wowhead.com/wotlk/ru/npc=34531
UPDATE `creature_template_locale` SET `Name` = '[Roo]' WHERE `locale` = 'ruRU' AND `entry` = 34531;
-- OLD name : Кекек
-- Source : https://www.wowhead.com/wotlk/ru/npc=34532
UPDATE `creature_template_locale` SET `Name` = '[Kekek]' WHERE `locale` = 'ruRU' AND `entry` = 34532;
-- OLD name : ScottM Test Creature
-- Source : https://www.wowhead.com/wotlk/ru/npc=34533
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34533;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (34533, 'ruRU','[ScottM Test Creature]',NULL);
-- OLD name : Отрекшийся-хулиган
-- Source : https://www.wowhead.com/wotlk/ru/npc=34561
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Prankster]' WHERE `locale` = 'ruRU' AND `entry` = 34561;
-- OLD name : Безобидный селянин
-- Source : https://www.wowhead.com/wotlk/ru/npc=34565
UPDATE `creature_template_locale` SET `Name` = '[Innocuous Townsman]' WHERE `locale` = 'ruRU' AND `entry` = 34565;
-- OLD name : Равазаврик (1.25)
-- Source : https://www.wowhead.com/wotlk/ru/npc=34579
UPDATE `creature_template_locale` SET `Name` = '[Venomhide Hatchling (1.25)]' WHERE `locale` = 'ruRU' AND `entry` = 34579;
-- OLD name : Равазаврик (1.50)
-- Source : https://www.wowhead.com/wotlk/ru/npc=34580
UPDATE `creature_template_locale` SET `Name` = '[Venomhide Hatchling (1.50)]' WHERE `locale` = 'ruRU' AND `entry` = 34580;
-- OLD name : Равазаврик (1.75)
-- Source : https://www.wowhead.com/wotlk/ru/npc=34581
UPDATE `creature_template_locale` SET `Name` = '[Venomhide Hatchling (1.75)]' WHERE `locale` = 'ruRU' AND `entry` = 34581;
-- OLD name : Нерубский копатель
-- Source : https://www.wowhead.com/wotlk/ru/npc=34607
UPDATE `creature_template_locale` SET `Name` = 'Нерубский землеглот' WHERE `locale` = 'ruRU' AND `entry` = 34607;
-- OLD name : Данова Громовой Рог
-- Source : https://www.wowhead.com/wotlk/ru/npc=34612
UPDATE `creature_template_locale` SET `Name` = '[Danowe Thunderhorn]' WHERE `locale` = 'ruRU' AND `entry` = 34612;
-- OLD name : Огрская пиньята
-- Source : https://www.wowhead.com/wotlk/ru/npc=34632
UPDATE `creature_template_locale` SET `Name` = '[Ogre Pinata]' WHERE `locale` = 'ruRU' AND `entry` = 34632;
-- OLD name : Волшебный петух
-- Source : https://www.wowhead.com/wotlk/ru/npc=34655
UPDATE `creature_template_locale` SET `Name` = '[Magic Rooster]' WHERE `locale` = 'ruRU' AND `entry` = 34655;
-- OLD name : Серебряный верховой дракондор
-- Source : https://www.wowhead.com/wotlk/ru/npc=34709
UPDATE `creature_template_locale` SET `Name` = '[Silver Riding Dragonhawk]' WHERE `locale` = 'ruRU' AND `entry` = 34709;
-- OLD name : Техник Дробз
-- Source : https://www.wowhead.com/wotlk/ru/npc=34719
UPDATE `creature_template_locale` SET `Name` = 'Техник Щебняк' WHERE `locale` = 'ruRU' AND `entry` = 34719;
-- OLD name : Spice Bread Stuffing Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=34737
UPDATE `creature_template_locale` SET `Name` = '[Spice Bread Stuffing Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 34737;
-- OLD name : Slow-roasted Turkey Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=34738
UPDATE `creature_template_locale` SET `Name` = '[Slow-roasted Turkey Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 34738;
-- OLD name : Засахаренный батат
-- Source : https://www.wowhead.com/wotlk/ru/npc=34739
UPDATE `creature_template_locale` SET `Name` = '[Candied Sweet Potato Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 34739;
-- OLD name : Pumpkin Pie Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=34740
UPDATE `creature_template_locale` SET `Name` = '[Pumpkin Pie Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 34740;
-- OLD name : Cranberry Chutney Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=34741
UPDATE `creature_template_locale` SET `Name` = '[Cranberry Chutney Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 34741;
-- OLD name : Вильям Маллинс
-- Source : https://www.wowhead.com/wotlk/ru/npc=34768
UPDATE `creature_template_locale` SET `Name` = 'Вилльям Маллинс' WHERE `locale` = 'ruRU' AND `entry` = 34768;
-- OLD name : Кислотная Утроба
-- Source : https://www.wowhead.com/wotlk/ru/npc=34798
UPDATE `creature_template_locale` SET `Name` = '[Acidmaw (Mobile)]' WHERE `locale` = 'ruRU' AND `entry` = 34798;
-- OLD name : Пылающий скелет
-- Source : https://www.wowhead.com/wotlk/ru/npc=34801
UPDATE `creature_template_locale` SET `Name` = '[Incinerated Skeleton]' WHERE `locale` = 'ruRU' AND `entry` = 34801;
-- OLD name : Пиршественный стол Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=34806
UPDATE `creature_template_locale` SET `Name` = '[Bountiful Table Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 34806;
-- OLD name : Argent Coliseum PTR Beast Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=34827
UPDATE `creature_template_locale` SET `Name` = '[Argent Coliseum PTR Beast Master]' WHERE `locale` = 'ruRU' AND `entry` = 34827;
-- OLD name : Jend Jow (Test), subname : Военачальник
-- Source : https://www.wowhead.com/wotlk/ru/npc=34895
UPDATE `creature_template_locale` SET `Name` = '[Jend Jow (Test)]',`Title` = '[Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 34895;
-- OLD name : Snowblind Follower Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=34899
UPDATE `creature_template_locale` SET `Name` = '[Snowblind Follower Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 34899;
-- OLD name : Глубинный йормунгар
-- Source : https://www.wowhead.com/wotlk/ru/npc=34920
UPDATE `creature_template_locale` SET `Name` = 'Глубинный йогмунгар' WHERE `locale` = 'ruRU' AND `entry` = 34920;
-- OLD name : Шар инфернала пламени Скверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=34921
UPDATE `creature_template_locale` SET `Name` = '[Felflame Infernal Ball]' WHERE `locale` = 'ruRU' AND `entry` = 34921;
-- OLD name : Хоторо, subname : Военачальник
-- Source : https://www.wowhead.com/wotlk/ru/npc=34971
UPDATE `creature_template_locale` SET `Name` = '[Hotoro]',`Title` = '[Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 34971;
-- OLD name : Аэлус Золотистый Рассвет, subname : Военачальник
-- Source : https://www.wowhead.com/wotlk/ru/npc=34972
UPDATE `creature_template_locale` SET `Name` = '[Aelus Goldmorn]',`Title` = '[Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 34972;
-- OLD name : Плакия
-- Source : https://www.wowhead.com/wotlk/ru/npc=34985
UPDATE `creature_template_locale` SET `Name` = 'Мизери' WHERE `locale` = 'ruRU' AND `entry` = 34985;
-- OLD name : Ларина Сердце Горна, subname : Военачальник
-- Source : https://www.wowhead.com/wotlk/ru/npc=34993
UPDATE `creature_template_locale` SET `Name` = '[Larina Heartforge]',`Title` = '[Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 34993;
-- OLD name : Stalker Koralon
-- Source : https://www.wowhead.com/wotlk/ru/npc=35018
UPDATE `creature_template_locale` SET `Name` = '[Stalker Koralon]' WHERE `locale` = 'ruRU' AND `entry` = 35018;
-- OLD name : Брука Несущая Горе, subname : Военачальник Острова Завоеваний
-- Source : https://www.wowhead.com/wotlk/ru/npc=35019
UPDATE `creature_template_locale` SET `Name` = '[Bruka Woebringer]',`Title` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 35019;
-- OLD name : Терранс Маттерли, subname : Военачальник Острова Завоеваний
-- Source : https://www.wowhead.com/wotlk/ru/npc=35023
UPDATE `creature_template_locale` SET `Name` = '[Terrance Matterly]',`Title` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 35023;
-- OLD name : Драциен Фленнинг, subname : Военачальник Острова Завоеваний
-- Source : https://www.wowhead.com/wotlk/ru/npc=35024
UPDATE `creature_template_locale` SET `Name` = '[Dracien Flanning]',`Title` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 35024;
-- OLD name : Линетт Брейсер, subname : Военачальник Острова Завоеваний
-- Source : https://www.wowhead.com/wotlk/ru/npc=35025
UPDATE `creature_template_locale` SET `Name` = '[Lynette Bracer]',`Title` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 35025;
-- OLD name : Эрутор, subname : Военачальник Острова Завоеваний
-- Source : https://www.wowhead.com/wotlk/ru/npc=35027
UPDATE `creature_template_locale` SET `Name` = '[Erutor]',`Title` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'ruRU' AND `entry` = 35027;
-- OLD name : Видение Люцифрона
-- Source : https://www.wowhead.com/wotlk/ru/npc=35031
UPDATE `creature_template_locale` SET `Name` = '[Memory of Lucifron]' WHERE `locale` = 'ruRU' AND `entry` = 35031;
-- OLD name : Видение Громораана
-- Source : https://www.wowhead.com/wotlk/ru/npc=35032
UPDATE `creature_template_locale` SET `Name` = '[Memory of Thunderaan]' WHERE `locale` = 'ruRU' AND `entry` = 35032;
-- OLD name : Видение Груула
-- Source : https://www.wowhead.com/wotlk/ru/npc=35039
UPDATE `creature_template_locale` SET `Name` = '[Memory of Gruul]' WHERE `locale` = 'ruRU' AND `entry` = 35039;
-- OLD name : Видение Иллидана
-- Source : https://www.wowhead.com/wotlk/ru/npc=35042
UPDATE `creature_template_locale` SET `Name` = '[Memory of Illidan]' WHERE `locale` = 'ruRU' AND `entry` = 35042;
-- OLD name : Видение Ониксии
-- Source : https://www.wowhead.com/wotlk/ru/npc=35048
UPDATE `creature_template_locale` SET `Name` = '[Memory of Onyxia]' WHERE `locale` = 'ruRU' AND `entry` = 35048;
-- OLD name : Fallen Hero's Spirit Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=35055
UPDATE `creature_template_locale` SET `Name` = '[Fallen Hero''s Spirit Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 35055;
-- OLD name : Бес в бутылке
-- Source : https://www.wowhead.com/wotlk/ru/npc=35067
UPDATE `creature_template_locale` SET `Name` = '[Imp in a Bottle]' WHERE `locale` = 'ruRU' AND `entry` = 35067;
-- OLD name : Штейгер Фиск
-- Source : https://www.wowhead.com/wotlk/ru/npc=35085
UPDATE `creature_template_locale` SET `Name` = '[Foreman Fisk]' WHERE `locale` = 'ruRU' AND `entry` = 35085;
-- OLD name : Подрядчик Жаднюк
-- Source : https://www.wowhead.com/wotlk/ru/npc=35086
UPDATE `creature_template_locale` SET `Name` = '[Labor Captain Grabbit]' WHERE `locale` = 'ruRU' AND `entry` = 35086;
-- OLD name : Малинея Опустошительница Небес
-- Source : https://www.wowhead.com/wotlk/ru/npc=35087
UPDATE `creature_template_locale` SET `Name` = '[Malynea Skyreaver]' WHERE `locale` = 'ruRU' AND `entry` = 35087;
-- OLD name : Кустер Дубник
-- Source : https://www.wowhead.com/wotlk/ru/npc=35088
UPDATE `creature_template_locale` SET `Name` = '[Custer Clubnik]' WHERE `locale` = 'ruRU' AND `entry` = 35088;
-- OLD name : Хорзак Кругоглод
-- Source : https://www.wowhead.com/wotlk/ru/npc=35091
UPDATE `creature_template_locale` SET `Name` = '[Horzak Zignibble]' WHERE `locale` = 'ruRU' AND `entry` = 35091;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=35093
UPDATE `creature_template_locale` SET `Title` = 'Учитель верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 35093;
-- OLD name : Бана Буйногривая
-- Source : https://www.wowhead.com/wotlk/ru/npc=35099
UPDATE `creature_template_locale` SET `Name` = 'Бана Дикая Грива' WHERE `locale` = 'ruRU' AND `entry` = 35099;
-- OLD name : Харген Бронзовое Крыло, subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=35100
UPDATE `creature_template_locale` SET `Name` = 'Харген Бронзокрыл',`Title` = 'Учитель верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 35100;
-- OLD subname : Укротительница грифонов
-- Source : https://www.wowhead.com/wotlk/ru/npc=35101
UPDATE `creature_template_locale` SET `Title` = 'Хозяйка грифонов' WHERE `locale` = 'ruRU' AND `entry` = 35101;
-- OLD name : Argent Coliseum PTR Eredar Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=35107
UPDATE `creature_template_locale` SET `Name` = '[Argent Coliseum PTR Eredar Master]' WHERE `locale` = 'ruRU' AND `entry` = 35107;
-- OLD name : Argent Coliseum PTR Faction Champion Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=35108
UPDATE `creature_template_locale` SET `Name` = '[Argent Coliseum PTR Faction Champion Master]' WHERE `locale` = 'ruRU' AND `entry` = 35108;
-- OLD name : Argent Colosseum PTR Valkyr Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=35109
UPDATE `creature_template_locale` SET `Name` = '[Argent Coliseum PTR Val''kyr Master]' WHERE `locale` = 'ruRU' AND `entry` = 35109;
-- OLD name : Argent Colosseum PTR Anubarak Master
-- Source : https://www.wowhead.com/wotlk/ru/npc=35110
UPDATE `creature_template_locale` SET `Name` = '[Argent Coliseum PTR Anub''arak Master]' WHERE `locale` = 'ruRU' AND `entry` = 35110;
-- OLD subname : Укротитель грифонов
-- Source : https://www.wowhead.com/wotlk/ru/npc=35131
UPDATE `creature_template_locale` SET `Title` = 'Хозяин грифонов' WHERE `locale` = 'ruRU' AND `entry` = 35131;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=35133
UPDATE `creature_template_locale` SET `Title` = 'Учитель верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 35133;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=35135
UPDATE `creature_template_locale` SET `Title` = 'Учитель верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 35135;
-- OLD name : Жуткая Чешуя (Сессил)
-- Source : https://www.wowhead.com/wotlk/ru/npc=35145
UPDATE `creature_template_locale` SET `Name` = '[Dreadscale (Sessile)]' WHERE `locale` = 'ruRU' AND `entry` = 35145;
-- OLD name : Серебряный гиппогриф
-- Source : https://www.wowhead.com/wotlk/ru/npc=35146
UPDATE `creature_template_locale` SET `Name` = '[Argent Hippogryph (Bombing Run)]' WHERE `locale` = 'ruRU' AND `entry` = 35146;
-- OLD name : Дух маны
-- Source : https://www.wowhead.com/wotlk/ru/npc=35155
UPDATE `creature_template_locale` SET `Name` = '[Mana Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 35155;
-- OLD name : Нефритовая панда
-- Source : https://www.wowhead.com/wotlk/ru/npc=35156
UPDATE `creature_template_locale` SET `Name` = '[Jade Panda]' WHERE `locale` = 'ruRU' AND `entry` = 35156;
-- OLD name : Нефритовый дракончик
-- Source : https://www.wowhead.com/wotlk/ru/npc=35157
UPDATE `creature_template_locale` SET `Name` = '[Tiny Jade Dragon]' WHERE `locale` = 'ruRU' AND `entry` = 35157;
-- OLD name : Скакун Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=35179
UPDATE `creature_template_locale` SET `Name` = '[Argent Charger]' WHERE `locale` = 'ruRU' AND `entry` = 35179;
-- OLD name : Боевой конь Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=35180
UPDATE `creature_template_locale` SET `Name` = '[Argent Warhorse]' WHERE `locale` = 'ruRU' AND `entry` = 35180;
-- OLD name : Invisible Burrowed Jormungar
-- Source : https://www.wowhead.com/wotlk/ru/npc=35228
UPDATE `creature_template_locale` SET `Name` = '[Invisible Burrowed Jormungar]' WHERE `locale` = 'ruRU' AND `entry` = 35228;
-- OLD name : Квалдир-лазутчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=35242
UPDATE `creature_template_locale` SET `Name` = '[Kvaldir Invader]' WHERE `locale` = 'ruRU' AND `entry` = 35242;
-- OLD name : Радующийся дух эльфа крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=35243
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Blood Elf Celebrant]' WHERE `locale` = 'ruRU' AND `entry` = 35243;
-- OLD name : Радующийся дух Отрекшегося
-- Source : https://www.wowhead.com/wotlk/ru/npc=35244
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Forsaken Celebrant]' WHERE `locale` = 'ruRU' AND `entry` = 35244;
-- OLD name : Радующийся дух дренея
-- Source : https://www.wowhead.com/wotlk/ru/npc=35246
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Draenei Celebrant]' WHERE `locale` = 'ruRU' AND `entry` = 35246;
-- OLD name : Радующийся дух таурена
-- Source : https://www.wowhead.com/wotlk/ru/npc=35252
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Tauren Celebrant]' WHERE `locale` = 'ruRU' AND `entry` = 35252;
-- OLD name : Радующийся дух Алдора
-- Source : https://www.wowhead.com/wotlk/ru/npc=35258
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Aldor Celebrant]' WHERE `locale` = 'ruRU' AND `entry` = 35258;
-- OLD name : Радующийся дух Провидца
-- Source : https://www.wowhead.com/wotlk/ru/npc=35259
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Scryer Celebrant]' WHERE `locale` = 'ruRU' AND `entry` = 35259;
-- OLD name : Веселый дух Провидца
-- Source : https://www.wowhead.com/wotlk/ru/npc=35261
UPDATE `creature_template_locale` SET `Name` = '[Cheerful Scryer Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 35261;
-- OLD subname : Наставница паладинов
-- Source : https://www.wowhead.com/wotlk/ru/npc=35281
UPDATE `creature_template_locale` SET `Title` = 'Наставник паладинов' WHERE `locale` = 'ruRU' AND `entry` = 35281;
-- OLD name : Серебряный жеребец
-- Source : https://www.wowhead.com/wotlk/ru/npc=35285
UPDATE `creature_template_locale` SET `Name` = '[Argent Colt]' WHERE `locale` = 'ruRU' AND `entry` = 35285;
-- OLD name : Icecrown Cultist Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=35297
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Cultist Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 35297;
-- OLD name : Королевский стражник Штормграда
-- Source : https://www.wowhead.com/wotlk/ru/npc=35322
UPDATE `creature_template_locale` SET `Name` = 'Королевский страж Штормграда' WHERE `locale` = 'ruRU' AND `entry` = 35322;
-- OLD name : Чемпион Сен'джина
-- Source : https://www.wowhead.com/wotlk/ru/npc=35323
UPDATE `creature_template_locale` SET `Name` = 'Чемпион Сен''джин' WHERE `locale` = 'ruRU' AND `entry` = 35323;
-- OLD name : Детеныш из Гундрака
-- Source : https://www.wowhead.com/wotlk/ru/npc=35400
UPDATE `creature_template_locale` SET `Name` = 'Детеныш Гундрака' WHERE `locale` = 'ruRU' AND `entry` = 35400;
-- OLD name : Король-лич
-- Source : https://www.wowhead.com/wotlk/ru/npc=35459
UPDATE `creature_template_locale` SET `Name` = '[The Lich King]' WHERE `locale` = 'ruRU' AND `entry` = 35459;
-- OLD name : Мстительная валь'кира
-- Source : https://www.wowhead.com/wotlk/ru/npc=35474
UPDATE `creature_template_locale` SET `Name` = '[Vengeful Val''kyr]' WHERE `locale` = 'ruRU' AND `entry` = 35474;
-- OLD name : Чернокнижник-гость
-- Source : https://www.wowhead.com/wotlk/ru/npc=35475
UPDATE `creature_template_locale` SET `Name` = '[Visiting Warlock]' WHERE `locale` = 'ruRU' AND `entry` = 35475;
-- OLD name : Вилфред Непопамс
-- Source : https://www.wowhead.com/wotlk/ru/npc=35476
UPDATE `creature_template_locale` SET `Name` = '[Wilfred Fizzlebang]' WHERE `locale` = 'ruRU' AND `entry` = 35476;
-- OLD name : Стражник с "Зефира", subname : Зефир
-- Source : https://www.wowhead.com/wotlk/ru/npc=35492
UPDATE `creature_template_locale` SET `Name` = '[Zephyr Guard]',`Title` = '[The Zephyr]' WHERE `locale` = 'ruRU' AND `entry` = 35492;
-- OLD name : Мстительный ледяной змей
-- Source : https://www.wowhead.com/wotlk/ru/npc=35493
UPDATE `creature_template_locale` SET `Name` = '[Vengeful Frostwyrm]' WHERE `locale` = 'ruRU' AND `entry` = 35493;
-- OLD subname : Эмблема триумфального интенданта
-- Source : https://www.wowhead.com/wotlk/ru/npc=35494
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы триумфа' WHERE `locale` = 'ruRU' AND `entry` = 35494;
-- OLD subname : Эмблема триумфального интенданта
-- Source : https://www.wowhead.com/wotlk/ru/npc=35495
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы триумфа' WHERE `locale` = 'ruRU' AND `entry` = 35495;
-- OLD subname : Старинные награды за очки справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=35573
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы триумфа' WHERE `locale` = 'ruRU' AND `entry` = 35573;
-- OLD subname : Старинные награды за очки справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=35574
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы триумфа' WHERE `locale` = 'ruRU' AND `entry` = 35574;
-- OLD name : Гиппогриф Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=35586
UPDATE `creature_template_locale` SET `Name` = '[Argent Hippogryph (Herald Mount)]' WHERE `locale` = 'ruRU' AND `entry` = 35586;
-- OLD name : Миротворец Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=35587
UPDATE `creature_template_locale` SET `Name` = '[Argent Peacekeeper]' WHERE `locale` = 'ruRU' AND `entry` = 35587;
-- OLD name : Лоскутных дел мастер
-- Source : https://www.wowhead.com/wotlk/ru/npc=35588
UPDATE `creature_template_locale` SET `Name` = '[Coliseum Master of Patchwerks]' WHERE `locale` = 'ruRU' AND `entry` = 35588;
-- OLD name : Джерен Верный Солнцу
-- Source : https://www.wowhead.com/wotlk/ru/npc=35589
UPDATE `creature_template_locale` SET `Name` = '[Jaeren Sunsworn]' WHERE `locale` = 'ruRU' AND `entry` = 35589;
-- OLD subname : Механический аукционист
-- Source : https://www.wowhead.com/wotlk/ru/npc=35594
UPDATE `creature_template_locale` SET `Title` = 'Механический аукционер' WHERE `locale` = 'ruRU' AND `entry` = 35594;
-- OLD name : Арелас Ясная Звезда
-- Source : https://www.wowhead.com/wotlk/ru/npc=35604
UPDATE `creature_template_locale` SET `Name` = '[Arelas Brightstar]' WHERE `locale` = 'ruRU' AND `entry` = 35604;
-- OLD subname : Механический аукционист
-- Source : https://www.wowhead.com/wotlk/ru/npc=35607
UPDATE `creature_template_locale` SET `Title` = 'Механический аукционер' WHERE `locale` = 'ruRU' AND `entry` = 35607;
-- OLD name : Кошка
-- Source : https://www.wowhead.com/wotlk/ru/npc=35610
UPDATE `creature_template_locale` SET `Name` = 'Кот' WHERE `locale` = 'ruRU' AND `entry` = 35610;
-- OLD name : Ловчий смерти Визери
-- Source : https://www.wowhead.com/wotlk/ru/npc=35617
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти Визери' WHERE `locale` = 'ruRU' AND `entry` = 35617;
-- OLD name : Скакун ловчего смерти Визери
-- Source : https://www.wowhead.com/wotlk/ru/npc=35634
UPDATE `creature_template_locale` SET `Name` = 'Скакун стража смерти Визери' WHERE `locale` = 'ruRU' AND `entry` = 35634;
-- OLD name : Сломанная крепостная пушка
-- Source : https://www.wowhead.com/wotlk/ru/npc=35819
UPDATE `creature_template_locale` SET `Name` = '[Broken Keep Cannon]' WHERE `locale` = 'ruRU' AND `entry` = 35819;
-- OLD name : Барретт Ремси, subname : Распорядитель Колизея Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=35895
UPDATE `creature_template_locale` SET `Name` = '[Barrett Ramsey]',`Title` = '[Argent Coliseum Master]' WHERE `locale` = 'ruRU' AND `entry` = 35895;
-- OLD name : Барретт Ремси, subname : Распорядитель Колизея Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=35910
UPDATE `creature_template_locale` SET `Name` = '[Barrett Ramsey]',`Title` = '[Argent Coliseum Master]' WHERE `locale` = 'ruRU' AND `entry` = 35910;
-- OLD name : Фьола Погибель Света
-- Source : https://www.wowhead.com/wotlk/ru/npc=36065
UPDATE `creature_template_locale` SET `Name` = '[Fjola Lightbane]' WHERE `locale` = 'ruRU' AND `entry` = 36065;
-- OLD name : Эйдис Погибель Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=36066
UPDATE `creature_template_locale` SET `Name` = '[Eydis Darkbane]' WHERE `locale` = 'ruRU' AND `entry` = 36066;
-- OLD name : Жрица Алора
-- Source : https://www.wowhead.com/wotlk/ru/npc=36101
UPDATE `creature_template_locale` SET `Name` = '[Priestess Alorah]' WHERE `locale` = 'ruRU' AND `entry` = 36101;
-- OLD name : Жрец Гриммин
-- Source : https://www.wowhead.com/wotlk/ru/npc=36102
UPDATE `creature_template_locale` SET `Name` = '[Priest Grimmin]' WHERE `locale` = 'ruRU' AND `entry` = 36102;
-- OLD name : Антар Очистительный Горн
-- Source : https://www.wowhead.com/wotlk/ru/npc=36108
UPDATE `creature_template_locale` SET `Name` = '[Anthar Forgemender]' WHERE `locale` = 'ruRU' AND `entry` = 36108;
-- OLD name : Бельнор Светоносный
-- Source : https://www.wowhead.com/wotlk/ru/npc=36109
UPDATE `creature_template_locale` SET `Name` = '[Baelnor Lightbearer]' WHERE `locale` = 'ruRU' AND `entry` = 36109;
-- OLD name : Нуззл Чудодей
-- Source : https://www.wowhead.com/wotlk/ru/npc=36114
UPDATE `creature_template_locale` SET `Name` = '[Noozle Whizzlestick]' WHERE `locale` = 'ruRU' AND `entry` = 36114;
-- OLD name : Меладор Дальний Гонец
-- Source : https://www.wowhead.com/wotlk/ru/npc=36116
UPDATE `creature_template_locale` SET `Name` = '[Melador Valestrider]' WHERE `locale` = 'ruRU' AND `entry` = 36116;
-- OLD name : Шокул
-- Source : https://www.wowhead.com/wotlk/ru/npc=36118
UPDATE `creature_template_locale` SET `Name` = '[Shocuul]' WHERE `locale` = 'ruRU' AND `entry` = 36118;
-- OLD name : Каифа Неумолимый
-- Source : https://www.wowhead.com/wotlk/ru/npc=36119
UPDATE `creature_template_locale` SET `Name` = '[Caiphus the Stern]' WHERE `locale` = 'ruRU' AND `entry` = 36119;
-- OLD name : Малитас Сияющий Клинок
-- Source : https://www.wowhead.com/wotlk/ru/npc=36120
UPDATE `creature_template_locale` SET `Name` = '[Malithus Brightblade]' WHERE `locale` = 'ruRU' AND `entry` = 36120;
-- OLD name : Маз'дина
-- Source : https://www.wowhead.com/wotlk/ru/npc=36121
UPDATE `creature_template_locale` SET `Name` = '[Maz''dinah]' WHERE `locale` = 'ruRU' AND `entry` = 36121;
-- OLD name : Наррок Крушитель Стали
-- Source : https://www.wowhead.com/wotlk/ru/npc=36122
UPDATE `creature_template_locale` SET `Name` = '[Narrhok Steelbreaker]' WHERE `locale` = 'ruRU' AND `entry` = 36122;
-- OLD name : Харкзог
-- Source : https://www.wowhead.com/wotlk/ru/npc=36124
UPDATE `creature_template_locale` SET `Name` = '[Harkzog]' WHERE `locale` = 'ruRU' AND `entry` = 36124;
-- OLD name : Наездник на ледяном змее
-- Source : https://www.wowhead.com/wotlk/ru/npc=36128
UPDATE `creature_template_locale` SET `Name` = '[Frostwyrm Rider]' WHERE `locale` = 'ruRU' AND `entry` = 36128;
-- OLD name : Кор'кронский разоритель
-- Source : https://www.wowhead.com/wotlk/ru/npc=36164
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 36164;
-- OLD name : Морской пехотинец 7-го легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=36166
UPDATE `creature_template_locale` SET `Name` = 'Моряк 7-го легиона' WHERE `locale` = 'ruRU' AND `entry` = 36166;
-- OLD name : Dan's Test Colossus
-- Source : https://www.wowhead.com/wotlk/ru/npc=36168
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Colossus]' WHERE `locale` = 'ruRU' AND `entry` = 36168;
-- OLD name : Hardknuckle Charger Proxy
-- Source : https://www.wowhead.com/wotlk/ru/npc=36189
UPDATE `creature_template_locale` SET `Name` = '[Hardknuckle Charger Proxy]' WHERE `locale` = 'ruRU' AND `entry` = 36189;
-- OLD name : Schweitzermobile
-- Source : https://www.wowhead.com/wotlk/ru/npc=36215
UPDATE `creature_template_locale` SET `Name` = '[Schweitzermobile]' WHERE `locale` = 'ruRU' AND `entry` = 36215;
-- OLD name : Надзиратель Краггош
-- Source : https://www.wowhead.com/wotlk/ru/npc=36217
UPDATE `creature_template_locale` SET `Name` = '[Overseer Kraggosh]' WHERE `locale` = 'ruRU' AND `entry` = 36217;
-- OLD name : Стремительный ордынский волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=36223
UPDATE `creature_template_locale` SET `Name` = 'Стремительный волк Орды' WHERE `locale` = 'ruRU' AND `entry` = 36223;
-- OLD name : Аукционист Камнекост
-- Source : https://www.wowhead.com/wotlk/ru/npc=36235
UPDATE `creature_template_locale` SET `Name` = '[Auctioneer Rockbone]' WHERE `locale` = 'ruRU' AND `entry` = 36235;
-- OLD name : Флинт Стальной Олень, subname : Банкир
-- Source : https://www.wowhead.com/wotlk/ru/npc=36284
UPDATE `creature_template_locale` SET `Name` = '[Flint Ironstag]',`Title` = '[Banker]' WHERE `locale` = 'ruRU' AND `entry` = 36284;
-- OLD name : Honorable Defender Trigger, 25 yd (Horde)
-- Source : https://www.wowhead.com/wotlk/ru/npc=36350
UPDATE `creature_template_locale` SET `Name` = '[Honorable Defender Trigger, 25 yd (Horde)]' WHERE `locale` = 'ruRU' AND `entry` = 36350;
-- OLD name : Слаб Грузнолоб, subname : Банкир
-- Source : https://www.wowhead.com/wotlk/ru/npc=36351
UPDATE `creature_template_locale` SET `Name` = '[Slab Bulkhead]',`Title` = '[Banker]' WHERE `locale` = 'ruRU' AND `entry` = 36351;
-- OLD name : Транк Бейподдых, subname : Банкир
-- Source : https://www.wowhead.com/wotlk/ru/npc=36352
UPDATE `creature_template_locale` SET `Name` = '[Trunk Slamchest]',`Title` = '[Banker]' WHERE `locale` = 'ruRU' AND `entry` = 36352;
-- OLD name : Аукционист Бочкогруд
-- Source : https://www.wowhead.com/wotlk/ru/npc=36359
UPDATE `creature_template_locale` SET `Name` = '[Auctioneer Plankchest]' WHERE `locale` = 'ruRU' AND `entry` = 36359;
-- OLD name : Аукционистка Каменная Плита
-- Source : https://www.wowhead.com/wotlk/ru/npc=36360
UPDATE `creature_template_locale` SET `Name` = '[Auctioneer Slabrock]' WHERE `locale` = 'ruRU' AND `entry` = 36360;
-- OLD name : Бафф Крутоспин
-- Source : https://www.wowhead.com/wotlk/ru/npc=36380
UPDATE `creature_template_locale` SET `Name` = '[Buff Hardback]' WHERE `locale` = 'ruRU' AND `entry` = 36380;
-- OLD name : Бласт Толстошей
-- Source : https://www.wowhead.com/wotlk/ru/npc=36390
UPDATE `creature_template_locale` SET `Name` = '[Blast Thickneck]' WHERE `locale` = 'ruRU' AND `entry` = 36390;
-- OLD name : Стражник из клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=36431
UPDATE `creature_template_locale` SET `Name` = '[Dark Iron Guard]' WHERE `locale` = 'ruRU' AND `entry` = 36431;
-- OLD name : Белый жеребенок
-- Source : https://www.wowhead.com/wotlk/ru/npc=36483
UPDATE `creature_template_locale` SET `Name` = '[Little White Stallion]' WHERE `locale` = 'ruRU' AND `entry` = 36483;
-- OLD name : Маленький палевый ящер
-- Source : https://www.wowhead.com/wotlk/ru/npc=36484
UPDATE `creature_template_locale` SET `Name` = '[Little Ivory Raptor]' WHERE `locale` = 'ruRU' AND `entry` = 36484;
-- OLD name : Пожиратель Душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=36503
UPDATE `creature_template_locale` SET `Name` = '[Devourer of Souls]' WHERE `locale` = 'ruRU' AND `entry` = 36503;
-- OLD name : Пожиратель Душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=36504
UPDATE `creature_template_locale` SET `Name` = '[Devourer of Souls]' WHERE `locale` = 'ruRU' AND `entry` = 36504;
-- OLD name : Дуротарский песчаный вихрь
-- Source : https://www.wowhead.com/wotlk/ru/npc=36510
UPDATE `creature_template_locale` SET `Name` = '[Durotar Sand Vortex]' WHERE `locale` = 'ruRU' AND `entry` = 36510;
-- OLD subname : Ловчие смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=36517
UPDATE `creature_template_locale` SET `Title` = 'Стражи смерти' WHERE `locale` = 'ruRU' AND `entry` = 36517;
-- OLD name : Нестабильный опаляющий тотем
-- Source : https://www.wowhead.com/wotlk/ru/npc=36532
UPDATE `creature_template_locale` SET `Name` = '[Unstable Searing Totem]' WHERE `locale` = 'ruRU' AND `entry` = 36532;
-- OLD name : Нестабильный элементаль огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=36533
UPDATE `creature_template_locale` SET `Name` = '[Unstable Fire Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 36533;
-- OLD name : Unstable Earth Elemental [mini]
-- Source : https://www.wowhead.com/wotlk/ru/npc=36537
UPDATE `creature_template_locale` SET `Name` = '[Unstable Earth Elemental [mini]]' WHERE `locale` = 'ruRU' AND `entry` = 36537;
-- OLD name : Нестабильный тотем исцеляющего потока
-- Source : https://www.wowhead.com/wotlk/ru/npc=36542
UPDATE `creature_template_locale` SET `Name` = '[Unstable Healing Stream Totem]' WHERE `locale` = 'ruRU' AND `entry` = 36542;
-- OLD name : Unstable Water Elemental [mini]
-- Source : https://www.wowhead.com/wotlk/ru/npc=36543
UPDATE `creature_template_locale` SET `Name` = '[Unstable Water Elemental [mini]]' WHERE `locale` = 'ruRU' AND `entry` = 36543;
-- OLD name : Ночной эльф - ирокез
-- Source : https://www.wowhead.com/wotlk/ru/npc=36544
UPDATE `creature_template_locale` SET `Name` = '[Night Elf Mohawk]' WHERE `locale` = 'ruRU' AND `entry` = 36544;
-- OLD name : Нестабильный элементаль воды
-- Source : https://www.wowhead.com/wotlk/ru/npc=36545
UPDATE `creature_template_locale` SET `Name` = '[Unstable Water Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 36545;
-- OLD name : Нестабильный элементаль воздуха
-- Source : https://www.wowhead.com/wotlk/ru/npc=36546
UPDATE `creature_template_locale` SET `Name` = '[Unstable Air Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 36546;
-- OLD name : Unstable Air Elemental [mini]
-- Source : https://www.wowhead.com/wotlk/ru/npc=36547
UPDATE `creature_template_locale` SET `Name` = '[Unstable Air Elemental [mini]]' WHERE `locale` = 'ruRU' AND `entry` = 36547;
-- OLD name : Нестабильный тотем каменной кожи
-- Source : https://www.wowhead.com/wotlk/ru/npc=36550
UPDATE `creature_template_locale` SET `Name` = '[Unstable Stoneskin Totem]' WHERE `locale` = 'ruRU' AND `entry` = 36550;
-- OLD name : Unstable Fire Elemental [mini]
-- Source : https://www.wowhead.com/wotlk/ru/npc=36553
UPDATE `creature_template_locale` SET `Name` = '[Unstable Fire Elemental [mini] ]' WHERE `locale` = 'ruRU' AND `entry` = 36553;
-- OLD name : Нестабильный элементаль земли
-- Source : https://www.wowhead.com/wotlk/ru/npc=36554
UPDATE `creature_template_locale` SET `Name` = '[Unstable Earth Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 36554;
-- OLD name : Нестабильный тотем гнева воздуха
-- Source : https://www.wowhead.com/wotlk/ru/npc=36556
UPDATE `creature_template_locale` SET `Name` = '[Unstable Wrath of Air Totem]' WHERE `locale` = 'ruRU' AND `entry` = 36556;
-- OLD name : Justin's test Boss A
-- Source : https://www.wowhead.com/wotlk/ru/npc=36573
UPDATE `creature_template_locale` SET `Name` = '[Justin''s test Boss A]' WHERE `locale` = 'ruRU' AND `entry` = 36573;
-- OLD name : Justin's Test Boss B
-- Source : https://www.wowhead.com/wotlk/ru/npc=36574
UPDATE `creature_template_locale` SET `Name` = '[Justin''s Test Boss B]' WHERE `locale` = 'ruRU' AND `entry` = 36574;
-- OLD name : Нестабильный колодец Света
-- Source : https://www.wowhead.com/wotlk/ru/npc=36605
UPDATE `creature_template_locale` SET `Name` = '[Unstable Lightwell]' WHERE `locale` = 'ruRU' AND `entry` = 36605;
-- OLD name : Ахмо Громовой Рог
-- Source : https://www.wowhead.com/wotlk/ru/npc=36644
UPDATE `creature_template_locale` SET `Name` = '[Ahmo Thunderhorn]' WHERE `locale` = 'ruRU' AND `entry` = 36644;
-- OLD name : Бейн Кровавое Копыто, subname : Верховный вождь
-- Source : https://www.wowhead.com/wotlk/ru/npc=36648
UPDATE `creature_template_locale` SET `Name` = '[Baine Bloodhoof (Leader)]',`Title` = '[High Chieftain]' WHERE `locale` = 'ruRU' AND `entry` = 36648;
-- OLD name : Skeletal Miner (Cosmetic)
-- Source : https://www.wowhead.com/wotlk/ru/npc=36677
UPDATE `creature_template_locale` SET `Name` = '[Skeletal Miner (Cosmetic)]' WHERE `locale` = 'ruRU' AND `entry` = 36677;
-- OLD name : Верный льдам лейтенант
-- Source : https://www.wowhead.com/wotlk/ru/npc=36679
UPDATE `creature_template_locale` SET `Name` = '[Frostsworn Lieutenant]' WHERE `locale` = 'ruRU' AND `entry` = 36679;
-- OLD name : Quel'Delar Krasus Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=36715
UPDATE `creature_template_locale` SET `Name` = '[Quel''Delar Krasus Credit]' WHERE `locale` = 'ruRU' AND `entry` = 36715;
-- OLD name : Invisible Stalker
-- Source : https://www.wowhead.com/wotlk/ru/npc=36737
UPDATE `creature_template_locale` SET `Name` = '[Invisible Stalker]' WHERE `locale` = 'ruRU' AND `entry` = 36737;
-- OLD name : Верный льдам берсерк
-- Source : https://www.wowhead.com/wotlk/ru/npc=36757
UPDATE `creature_template_locale` SET `Name` = '[Frostsworn Berserker]' WHERE `locale` = 'ruRU' AND `entry` = 36757;
-- OLD name : Верный льдам боевой маг
-- Source : https://www.wowhead.com/wotlk/ru/npc=36763
UPDATE `creature_template_locale` SET `Name` = '[Frostsworn Battle-Mage]' WHERE `locale` = 'ruRU' AND `entry` = 36763;
-- OLD name : Верный льдам стрелок
-- Source : https://www.wowhead.com/wotlk/ru/npc=36769
UPDATE `creature_template_locale` SET `Name` = '[Frostsworn Marksman]' WHERE `locale` = 'ruRU' AND `entry` = 36769;
-- OLD name : Представитель Серебряного союза
-- Source : https://www.wowhead.com/wotlk/ru/npc=36774
UPDATE `creature_template_locale` SET `Name` = 'Посланник Серебряного союза' WHERE `locale` = 'ruRU' AND `entry` = 36774;
-- OLD name : Могучий ледопард, subname : Спутник ночного эльфа – ирокеза
-- Source : https://www.wowhead.com/wotlk/ru/npc=36778
UPDATE `creature_template_locale` SET `Name` = '[Mighty Frostsaber]',`Title` = '[Night Elf Mohawk''s Companion]' WHERE `locale` = 'ruRU' AND `entry` = 36778;
-- OLD name : Падший чемпион
-- Source : https://www.wowhead.com/wotlk/ru/npc=36796
UPDATE `creature_template_locale` SET `Name` = '[Corrupted Champion]' WHERE `locale` = 'ruRU' AND `entry` = 36796;
-- OLD name : Matt's Test Priest
-- Source : https://www.wowhead.com/wotlk/ru/npc=36804
UPDATE `creature_template_locale` SET `Name` = '[Matt''s Test Priest]' WHERE `locale` = 'ruRU' AND `entry` = 36804;
-- OLD name : Эльф крови - воин
-- Source : https://www.wowhead.com/wotlk/ru/npc=36857
UPDATE `creature_template_locale` SET `Name` = '[Blood Elf Warrior]' WHERE `locale` = 'ruRU' AND `entry` = 36857;
-- OLD name : Дворф-маг
-- Source : https://www.wowhead.com/wotlk/ru/npc=36858
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Mage]' WHERE `locale` = 'ruRU' AND `entry` = 36858;
-- OLD name : Дворф-шаман
-- Source : https://www.wowhead.com/wotlk/ru/npc=36859
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Shaman]' WHERE `locale` = 'ruRU' AND `entry` = 36859;
-- OLD name : Гном-жрец
-- Source : https://www.wowhead.com/wotlk/ru/npc=36860
UPDATE `creature_template_locale` SET `Name` = '[Gnome Priest]' WHERE `locale` = 'ruRU' AND `entry` = 36860;
-- OLD name : Человек-охотник
-- Source : https://www.wowhead.com/wotlk/ru/npc=36861
UPDATE `creature_template_locale` SET `Name` = '[Human Hunter]' WHERE `locale` = 'ruRU' AND `entry` = 36861;
-- OLD name : Ночной эльф - маг
-- Source : https://www.wowhead.com/wotlk/ru/npc=36862
UPDATE `creature_template_locale` SET `Name` = '[Night Elf Mage]' WHERE `locale` = 'ruRU' AND `entry` = 36862;
-- OLD name : Орк-маг
-- Source : https://www.wowhead.com/wotlk/ru/npc=36863
UPDATE `creature_template_locale` SET `Name` = '[Orc Mage]' WHERE `locale` = 'ruRU' AND `entry` = 36863;
-- OLD name : Таурен-паладин
-- Source : https://www.wowhead.com/wotlk/ru/npc=36864
UPDATE `creature_template_locale` SET `Name` = '[Tauren Paladin]' WHERE `locale` = 'ruRU' AND `entry` = 36864;
-- OLD name : Таурен-жрец
-- Source : https://www.wowhead.com/wotlk/ru/npc=36865
UPDATE `creature_template_locale` SET `Name` = '[Tauren Priest]' WHERE `locale` = 'ruRU' AND `entry` = 36865;
-- OLD name : Тролль-друид
-- Source : https://www.wowhead.com/wotlk/ru/npc=36866
UPDATE `creature_template_locale` SET `Name` = '[Troll Druid]' WHERE `locale` = 'ruRU' AND `entry` = 36866;
-- OLD name : Нежить-охотник
-- Source : https://www.wowhead.com/wotlk/ru/npc=36867
UPDATE `creature_template_locale` SET `Name` = '[Undead Hunter]' WHERE `locale` = 'ruRU' AND `entry` = 36867;
-- OLD name : Gryphon Hatchling 3.3.0
-- Source : https://www.wowhead.com/wotlk/ru/npc=36904
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36904;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36904, 'ruRU','[Gryphon Hatchling 3.3.0]',NULL);
-- OLD name : Чэнь Буйный Портер
-- Source : https://www.wowhead.com/wotlk/ru/npc=36912
UPDATE `creature_template_locale` SET `Name` = '[Chen Stormstout]' WHERE `locale` = 'ruRU' AND `entry` = 36912;
-- OLD name : Кор'кронский разоритель
-- Source : https://www.wowhead.com/wotlk/ru/npc=36957
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 36957;
-- OLD name : Гневный элементаль воды
-- Source : https://www.wowhead.com/wotlk/ru/npc=36965
UPDATE `creature_template_locale` SET `Name` = '[Furious Water Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 36965;
-- OLD name : Личный элементаль огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=36977
UPDATE `creature_template_locale` SET `Name` = '[Soulbound Fire Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 36977;
-- OLD name : Ледяная гробница
-- Source : https://www.wowhead.com/wotlk/ru/npc=36980
UPDATE `creature_template_locale` SET `Name` = 'Ледяной склеп' WHERE `locale` = 'ruRU' AND `entry` = 36980;
-- OLD name : Страж Солнечного Колодца
-- Source : https://www.wowhead.com/wotlk/ru/npc=36991
UPDATE `creature_template_locale` SET `Name` = '[Sunwell Guardian]' WHERE `locale` = 'ruRU' AND `entry` = 36991;
-- OLD name : Sunwell Visual Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=37000
UPDATE `creature_template_locale` SET `Name` = '[Sunwell Visual Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 37000;
-- OLD name : Липкая жижа
-- Source : https://www.wowhead.com/wotlk/ru/npc=37006
UPDATE `creature_template_locale` SET `Name` = 'Липучий слизнюк' WHERE `locale` = 'ruRU' AND `entry` = 37006;
-- OLD name : Кор'кронский разоритель
-- Source : https://www.wowhead.com/wotlk/ru/npc=37029
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 37029;
-- OLD name : Струящийся элементаль воды
-- Source : https://www.wowhead.com/wotlk/ru/npc=37036
UPDATE `creature_template_locale` SET `Name` = '[Rippling Water Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 37036;
-- OLD name : Акантур
-- Source : https://www.wowhead.com/wotlk/ru/npc=37037
UPDATE `creature_template_locale` SET `Name` = '[Acanthurus]' WHERE `locale` = 'ruRU' AND `entry` = 37037;
-- OLD name : Штормградский стражник
-- Source : https://www.wowhead.com/wotlk/ru/npc=37063
UPDATE `creature_template_locale` SET `Name` = '[Stormwind City Guard]' WHERE `locale` = 'ruRU' AND `entry` = 37063;
-- OLD name : Argent Warhose TEST
-- Source : https://www.wowhead.com/wotlk/ru/npc=37074
UPDATE `creature_template_locale` SET `Name` = '[Argent Warhose TEST]' WHERE `locale` = 'ruRU' AND `entry` = 37074;
-- OLD name : Горнило душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=37094
UPDATE `creature_template_locale` SET `Name` = '[Crucible of Souls]' WHERE `locale` = 'ruRU' AND `entry` = 37094;
-- OLD name : Alliance Brigadier General (Stormwind Visual)
-- Source : https://www.wowhead.com/wotlk/ru/npc=37100
UPDATE `creature_template_locale` SET `Name` = '[Alliance Brigadier General (Stormwind Visual)]' WHERE `locale` = 'ruRU' AND `entry` = 37100;
-- OLD name : Horde Warbringer - Orgrimmar Appearance (DND)
-- Source : https://www.wowhead.com/wotlk/ru/npc=37101
UPDATE `creature_template_locale` SET `Name` = '[Horde Warbringer - Orgrimmar Appearance (DND)]' WHERE `locale` = 'ruRU' AND `entry` = 37101;
-- OLD name : Колдун с "Усмирителя небес"
-- Source : https://www.wowhead.com/wotlk/ru/npc=37116
UPDATE `creature_template_locale` SET `Name` = 'Колдун "Усмирителя небес"' WHERE `locale` = 'ruRU' AND `entry` = 37116;
-- OLD name : Стена стихий
-- Source : https://www.wowhead.com/wotlk/ru/npc=37118
UPDATE `creature_template_locale` SET `Name` = '[Elemental Stone]' WHERE `locale` = 'ruRU' AND `entry` = 37118;
-- OLD name : Зеркальное изображение
-- Source : https://www.wowhead.com/wotlk/ru/npc=37130
UPDATE `creature_template_locale` SET `Name` = '[Mirror Image]' WHERE `locale` = 'ruRU' AND `entry` = 37130;
-- OLD name : Mirror Image Bug Test
-- Source : https://www.wowhead.com/wotlk/ru/npc=37131
UPDATE `creature_template_locale` SET `Name` = '[Mirror Image Bug Test]' WHERE `locale` = 'ruRU' AND `entry` = 37131;
-- OLD name : Кель'Делар
-- Source : https://www.wowhead.com/wotlk/ru/npc=37158
UPDATE `creature_template_locale` SET `Name` = '[Quel''Delar]' WHERE `locale` = 'ruRU' AND `entry` = 37158;
-- OLD name : Командир Джастин Бартлетт
-- Source : https://www.wowhead.com/wotlk/ru/npc=37182
UPDATE `creature_template_locale` SET `Name` = 'Старший капитан Джастин Бартлетт' WHERE `locale` = 'ruRU' AND `entry` = 37182;
-- OLD name : Леди Джайна Праудмур
-- Source : https://www.wowhead.com/wotlk/ru/npc=37188
UPDATE `creature_template_locale` SET `Name` = '[Lady Jaina Proudmoore]' WHERE `locale` = 'ruRU' AND `entry` = 37188;
-- OLD name : Балистоид
-- Source : https://www.wowhead.com/wotlk/ru/npc=37193
UPDATE `creature_template_locale` SET `Name` = '[Balistoides]' WHERE `locale` = 'ruRU' AND `entry` = 37193;
-- OLD name : Четодон
-- Source : https://www.wowhead.com/wotlk/ru/npc=37194
UPDATE `creature_template_locale` SET `Name` = '[Chaetodon]' WHERE `locale` = 'ruRU' AND `entry` = 37194;
-- OLD name : Талориен Искатель Рассвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=37205
UPDATE `creature_template_locale` SET `Name` = '[Thalorien Dawnseeker]' WHERE `locale` = 'ruRU' AND `entry` = 37205;
-- OLD name : Защитник Солнечного Колодца
-- Source : https://www.wowhead.com/wotlk/ru/npc=37211
UPDATE `creature_template_locale` SET `Name` = '[Sunwell Defender]' WHERE `locale` = 'ruRU' AND `entry` = 37211;
-- OLD name : Служащий химической компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=37214
UPDATE `creature_template_locale` SET `Name` = '[Crown Lackey]' WHERE `locale` = 'ruRU' AND `entry` = 37214;
-- OLD subname : Рыцарь ордена Серебряной Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=37225
UPDATE `creature_template_locale` SET `Title` = 'Рыцарь Серебряной Длани' WHERE `locale` = 'ruRU' AND `entry` = 37225;
-- OLD name : Караульный из армии Расколотого Солнца
-- Source : https://www.wowhead.com/wotlk/ru/npc=37509
UPDATE `creature_template_locale` SET `Name` = '[Shattered Sun Sentry]' WHERE `locale` = 'ruRU' AND `entry` = 37509;
-- OLD name : Верховный маг из армии Расколотого Солнца
-- Source : https://www.wowhead.com/wotlk/ru/npc=37510
UPDATE `creature_template_locale` SET `Name` = '[Shattered Sun Archmage]' WHERE `locale` = 'ruRU' AND `entry` = 37510;
-- OLD name : Воин из армии Расколотого Солнца
-- Source : https://www.wowhead.com/wotlk/ru/npc=37512
UPDATE `creature_template_locale` SET `Name` = '[Shattered Sun Warrior]' WHERE `locale` = 'ruRU' AND `entry` = 37512;
-- OLD name : Хранитель Солнечного Колодца
-- Source : https://www.wowhead.com/wotlk/ru/npc=37523
UPDATE `creature_template_locale` SET `Name` = '[Warden of the Sunwell]' WHERE `locale` = 'ruRU' AND `entry` = 37523;
-- OLD name : Щупальце в слизи
-- Source : https://www.wowhead.com/wotlk/ru/npc=37530
UPDATE `creature_template_locale` SET `Name` = '[Slimy Tentacle]' WHERE `locale` = 'ruRU' AND `entry` = 37530;
-- OLD name : Боец Служителей Льда
-- Source : https://www.wowhead.com/wotlk/ru/npc=37531
UPDATE `creature_template_locale` SET `Name` = 'Рабочий Служителей Льда' WHERE `locale` = 'ruRU' AND `entry` = 37531;
-- OLD name : Осклизлое щупальце
-- Source : https://www.wowhead.com/wotlk/ru/npc=37535
UPDATE `creature_template_locale` SET `Name` = '[Ooze Covered Tentacle]' WHERE `locale` = 'ruRU' AND `entry` = 37535;
-- OLD name : Зомби из Плети
-- Source : https://www.wowhead.com/wotlk/ru/npc=37538
UPDATE `creature_template_locale` SET `Name` = '[Scourge Zombie]' WHERE `locale` = 'ruRU' AND `entry` = 37538;
-- OLD name : Вурдалак-захватчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=37539
UPDATE `creature_template_locale` SET `Name` = '[Ghoul Invader]' WHERE `locale` = 'ruRU' AND `entry` = 37539;
-- OLD name : Осквернитель гробниц
-- Source : https://www.wowhead.com/wotlk/ru/npc=37541
UPDATE `creature_template_locale` SET `Name` = '[Crypt Raider]' WHERE `locale` = 'ruRU' AND `entry` = 37541;
-- OLD name : Морлен Ледяной Захват
-- Source : https://www.wowhead.com/wotlk/ru/npc=37542
UPDATE `creature_template_locale` SET `Name` = '[Morlen Coldgrip]' WHERE `locale` = 'ruRU' AND `entry` = 37542;
-- OLD name : Останки Талориена Искателя Рассвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=37552
UPDATE `creature_template_locale` SET `Name` = '[Thalorien Dawnseeker''s Remains]' WHERE `locale` = 'ruRU' AND `entry` = 37552;
-- OLD name : Thalorien Dawnseeker Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=37601
UPDATE `creature_template_locale` SET `Name` = '[Thalorien Dawnseeker Credit]' WHERE `locale` = 'ruRU' AND `entry` = 37601;
-- OLD name : Стражник-тень
-- Source : https://www.wowhead.com/wotlk/ru/npc=37691
UPDATE `creature_template_locale` SET `Name` = '[Guardian Shade]' WHERE `locale` = 'ruRU' AND `entry` = 37691;
-- OLD name : Командир Алеча Сегард, subname : Интендант Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=37693
UPDATE `creature_template_locale` SET `Name` = '[Commander Aliocha Segard [Icecrown Raid]]',`Title` = '[Argent Crusade Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 37693;
-- OLD name : RN Test Honor Guard
-- Source : https://www.wowhead.com/wotlk/ru/npc=37699
UPDATE `creature_template_locale` SET `Name` = '[RN Test Honor Guard]' WHERE `locale` = 'ruRU' AND `entry` = 37699;
-- OLD name : RN Test Royal Guard
-- Source : https://www.wowhead.com/wotlk/ru/npc=37700
UPDATE `creature_template_locale` SET `Name` = '[RN Test Royal Guard]' WHERE `locale` = 'ruRU' AND `entry` = 37700;
-- OLD name : Бушующий элементаль
-- Source : https://www.wowhead.com/wotlk/ru/npc=37703
UPDATE `creature_template_locale` SET `Name` = '[Surging Water Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 37703;
-- OLD name : Строитель Луносвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=37707
UPDATE `creature_template_locale` SET `Name` = '[Silvermoon Builder]' WHERE `locale` = 'ruRU' AND `entry` = 37707;
-- OLD name : Эвакуационный портал
-- Source : https://www.wowhead.com/wotlk/ru/npc=37734
UPDATE `creature_template_locale` SET `Name` = '[Evacuation Portal]' WHERE `locale` = 'ruRU' AND `entry` = 37734;
-- OLD name : Драган Большой Глоток, subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=37742
UPDATE `creature_template_locale` SET `Name` = 'Другган Большой Глоток',`Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 37742;
-- OLD name : Кель'Делар
-- Source : https://www.wowhead.com/wotlk/ru/npc=37745
UPDATE `creature_template_locale` SET `Name` = '[Quel''Delar]' WHERE `locale` = 'ruRU' AND `entry` = 37745;
-- OLD name : Sunwell Caster Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=37746
UPDATE `creature_template_locale` SET `Name` = '[Sunwell Caster Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 37746;
-- OLD name : Дворфийский тотем воздуха
-- Source : https://www.wowhead.com/wotlk/ru/npc=37749
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Air Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37749;
-- OLD name : Дворфийский тотем земли
-- Source : https://www.wowhead.com/wotlk/ru/npc=37750
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Earth Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37750;
-- OLD name : Дворфийский тотем огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=37751
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Fire Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37751;
-- OLD name : Дворфийский тотем воды
-- Source : https://www.wowhead.com/wotlk/ru/npc=37752
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Water Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37752;
-- OLD name : Верховный магистр Роммат
-- Source : https://www.wowhead.com/wotlk/ru/npc=37763
UPDATE `creature_template_locale` SET `Name` = '[Grand Magister Rommath]' WHERE `locale` = 'ruRU' AND `entry` = 37763;
-- OLD name : Лор'темар Терон, subname : Правящий лорд Кель'Таласа
-- Source : https://www.wowhead.com/wotlk/ru/npc=37764
UPDATE `creature_template_locale` SET `Name` = '[Lor''themar Theron]',`Title` = '[Regent Lord of Quel''Thalas]' WHERE `locale` = 'ruRU' AND `entry` = 37764;
-- OLD name : Капитан Аурик Ловчий Солнца, subname : Представитель высших эльфов
-- Source : https://www.wowhead.com/wotlk/ru/npc=37765
UPDATE `creature_template_locale` SET `Name` = '[Captain Auric Sunchaser]',`Title` = '[High Elf Representative]' WHERE `locale` = 'ruRU' AND `entry` = 37765;
-- OLD name : Оркский тотем воздуха
-- Source : https://www.wowhead.com/wotlk/ru/npc=37766
UPDATE `creature_template_locale` SET `Name` = '[Orc Air Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37766;
-- OLD name : Оркский тотем земли
-- Source : https://www.wowhead.com/wotlk/ru/npc=37767
UPDATE `creature_template_locale` SET `Name` = '[Orc Earth Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37767;
-- OLD name : Тролльский тотем земли
-- Source : https://www.wowhead.com/wotlk/ru/npc=37768
UPDATE `creature_template_locale` SET `Name` = '[Troll Earth Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37768;
-- OLD name : Тролльский тотем воздуха
-- Source : https://www.wowhead.com/wotlk/ru/npc=37769
UPDATE `creature_template_locale` SET `Name` = '[Troll Air Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37769;
-- OLD name : Оркский тотем огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=37770
UPDATE `creature_template_locale` SET `Name` = '[Orc Fire Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37770;
-- OLD name : Тролльский тотем огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=37771
UPDATE `creature_template_locale` SET `Name` = '[Troll Fire Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37771;
-- OLD name : Оркский тотем воды
-- Source : https://www.wowhead.com/wotlk/ru/npc=37772
UPDATE `creature_template_locale` SET `Name` = '[Orc Water Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37772;
-- OLD name : Тролльский тотем воды
-- Source : https://www.wowhead.com/wotlk/ru/npc=37773
UPDATE `creature_template_locale` SET `Name` = '[Troll Water Totem]' WHERE `locale` = 'ruRU' AND `entry` = 37773;
-- OLD name : Стражник Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=37775
UPDATE `creature_template_locale` SET `Name` = '[Ironforge Guard]' WHERE `locale` = 'ruRU' AND `entry` = 37775;
-- OLD name : Почетный страж Солнечного Колодца
-- Source : https://www.wowhead.com/wotlk/ru/npc=37781
UPDATE `creature_template_locale` SET `Name` = '[Sunwell Honor Guard]' WHERE `locale` = 'ruRU' AND `entry` = 37781;
-- OLD name : Дарнасский часовой
-- Source : https://www.wowhead.com/wotlk/ru/npc=37790
UPDATE `creature_template_locale` SET `Name` = '[Darnassus Sentinel]' WHERE `locale` = 'ruRU' AND `entry` = 37790;
-- OLD name : Экзодарский миротворец
-- Source : https://www.wowhead.com/wotlk/ru/npc=37798
UPDATE `creature_template_locale` SET `Name` = '[Exodar Peacekeeper]' WHERE `locale` = 'ruRU' AND `entry` = 37798;
-- OLD name : Злой дух
-- Source : https://www.wowhead.com/wotlk/ru/npc=37799
UPDATE `creature_template_locale` SET `Name` = 'Зловещий дух' WHERE `locale` = 'ruRU' AND `entry` = 37799;
-- OLD name : Городской страж Луносвета
-- Source : https://www.wowhead.com/wotlk/ru/npc=37800
UPDATE `creature_template_locale` SET `Name` = '[Silvermoon City Guardian]' WHERE `locale` = 'ruRU' AND `entry` = 37800;
-- OLD name : Shadow's Edge Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=37801
UPDATE `creature_template_locale` SET `Name` = '[Shadow''s Edge Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 37801;
-- OLD name : Shadow's Edge Axe Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=37814
UPDATE `creature_template_locale` SET `Name` = '[Shadow''s Edge Axe Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 37814;
-- OLD name : Кор'кронский надзиратель
-- Source : https://www.wowhead.com/wotlk/ru/npc=37825
UPDATE `creature_template_locale` SET `Name` = '[Kor''kron Overseer]' WHERE `locale` = 'ruRU' AND `entry` = 37825;
-- OLD name : Отмщение Света
-- Source : https://www.wowhead.com/wotlk/ru/npc=37826
UPDATE `creature_template_locale` SET `Name` = '[Light''s Vengeance]' WHERE `locale` = 'ruRU' AND `entry` = 37826;
-- OLD name : Light's Vengeance Vehicle Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=37827
UPDATE `creature_template_locale` SET `Name` = '[Light''s Vengeance Vehicle Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 37827;
-- OLD name : Image of Thalorien Dawnseeker
-- Source : https://www.wowhead.com/wotlk/ru/npc=37828
UPDATE `creature_template_locale` SET `Name` = '[Image of Thalorien Dawnseeker]' WHERE `locale` = 'ruRU' AND `entry` = 37828;
-- OLD name : Проекция Алекстразы, subname : Королева драконов
-- Source : https://www.wowhead.com/wotlk/ru/npc=37829
UPDATE `creature_template_locale` SET `Name` = '[Image of Alexstrasza]',`Title` = '[Queen of the Dragons]' WHERE `locale` = 'ruRU' AND `entry` = 37829;
-- OLD name : Lich King Stun Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=37832
UPDATE `creature_template_locale` SET `Name` = '[Lich King Stun Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 37832;
-- OLD name : Проекция Анастериана
-- Source : https://www.wowhead.com/wotlk/ru/npc=37844
UPDATE `creature_template_locale` SET `Name` = '[Image of Anasterian]' WHERE `locale` = 'ruRU' AND `entry` = 37844;
-- OLD name : Изображение Морлена Ледяного Захвата
-- Source : https://www.wowhead.com/wotlk/ru/npc=37845
UPDATE `creature_template_locale` SET `Name` = '[Image of Morlen Coldgrip]' WHERE `locale` = 'ruRU' AND `entry` = 37845;
-- OLD name : Кровавая королева Лана'тель, subname : Сан'лейн
-- Source : https://www.wowhead.com/wotlk/ru/npc=37846
UPDATE `creature_template_locale` SET `Name` = '[Blood-Queen Lana''thel]',`Title` = '[The San''layn]' WHERE `locale` = 'ruRU' AND `entry` = 37846;
-- OLD name : Проекция Ануб'Рекана
-- Source : https://www.wowhead.com/wotlk/ru/npc=37850
UPDATE `creature_template_locale` SET `Name` = '[Anub''Rekhan Image]' WHERE `locale` = 'ruRU' AND `entry` = 37850;
-- OLD name : Проекция Нота Чумного
-- Source : https://www.wowhead.com/wotlk/ru/npc=37851
UPDATE `creature_template_locale` SET `Name` = '[Noth the Plaguebringer Image]' WHERE `locale` = 'ruRU' AND `entry` = 37851;
-- OLD name : Проекция инструктора Разувия
-- Source : https://www.wowhead.com/wotlk/ru/npc=37853
UPDATE `creature_template_locale` SET `Name` = '[Instructor Razuvious Image]' WHERE `locale` = 'ruRU' AND `entry` = 37853;
-- OLD name : Проекция Лоскутика
-- Source : https://www.wowhead.com/wotlk/ru/npc=37854
UPDATE `creature_template_locale` SET `Name` = '[Patchwerk Image]' WHERE `locale` = 'ruRU' AND `entry` = 37854;
-- OLD name : Проекция Малигоса
-- Source : https://www.wowhead.com/wotlk/ru/npc=37855
UPDATE `creature_template_locale` SET `Name` = '[Malygos Image]' WHERE `locale` = 'ruRU' AND `entry` = 37855;
-- OLD name : Огненный левиафан
-- Source : https://www.wowhead.com/wotlk/ru/npc=37856
UPDATE `creature_template_locale` SET `Name` = '[Flame Leviathan Image]' WHERE `locale` = 'ruRU' AND `entry` = 37856;
-- OLD name : Король-лич
-- Source : https://www.wowhead.com/wotlk/ru/npc=37857
UPDATE `creature_template_locale` SET `Name` = '[The Lich King]' WHERE `locale` = 'ruRU' AND `entry` = 37857;
-- OLD name : Проекция Острокрылой
-- Source : https://www.wowhead.com/wotlk/ru/npc=37858
UPDATE `creature_template_locale` SET `Name` = '[Razorscale Image]' WHERE `locale` = 'ruRU' AND `entry` = 37858;
-- OLD name : Проекция Повелителя Горнов Игниса
-- Source : https://www.wowhead.com/wotlk/ru/npc=37859
UPDATE `creature_template_locale` SET `Name` = '[Ignis the Furnace Master Image]' WHERE `locale` = 'ruRU' AND `entry` = 37859;
-- OLD name : Страж утесов
-- Source : https://www.wowhead.com/wotlk/ru/npc=37860
UPDATE `creature_template_locale` SET `Name` = '[Bluffwatcher]' WHERE `locale` = 'ruRU' AND `entry` = 37860;
-- OLD name : Проекция лорда Джараксуса
-- Source : https://www.wowhead.com/wotlk/ru/npc=37862
UPDATE `creature_template_locale` SET `Name` = '[Lord Jaraxxus Image]' WHERE `locale` = 'ruRU' AND `entry` = 37862;
-- OLD name : Проекция лорда Ребрада
-- Source : https://www.wowhead.com/wotlk/ru/npc=37864
UPDATE `creature_template_locale` SET `Name` = '[Lord Marrowgar Image]' WHERE `locale` = 'ruRU' AND `entry` = 37864;
-- OLD name : Оргриммарский рубака
-- Source : https://www.wowhead.com/wotlk/ru/npc=37869
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Grunt]' WHERE `locale` = 'ruRU' AND `entry` = 37869;
-- OLD name : Event Fail Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=37871
UPDATE `creature_template_locale` SET `Name` = '[Event Fail Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 37871;
-- OLD name : AoD Impact Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=37878
UPDATE `creature_template_locale` SET `Name` = '[AoD Impact Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 37878;
-- OLD name : Король Вариан Ринн, subname : Король Штормграда
-- Source : https://www.wowhead.com/wotlk/ru/npc=37879
UPDATE `creature_template_locale` SET `Name` = '[King Varian Wrynn]',`Title` = '[King of Stormwind]' WHERE `locale` = 'ruRU' AND `entry` = 37879;
-- OLD name : Портал в Штормград
-- Source : https://www.wowhead.com/wotlk/ru/npc=37880
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Portal]' WHERE `locale` = 'ruRU' AND `entry` = 37880;
-- OLD name : Презренный вурдалак
-- Source : https://www.wowhead.com/wotlk/ru/npc=37881
UPDATE `creature_template_locale` SET `Name` = '[Wretched Ghoul]' WHERE `locale` = 'ruRU' AND `entry` = 37881;
-- OLD name : Ледяной Трон
-- Source : https://www.wowhead.com/wotlk/ru/npc=37882
UPDATE `creature_template_locale` SET `Name` = '[The Frozen Throne]' WHERE `locale` = 'ruRU' AND `entry` = 37882;
-- OLD name : Bug 174037
-- Source : https://www.wowhead.com/wotlk/ru/npc=37883
UPDATE `creature_template_locale` SET `Name` = '[Bug 174037]' WHERE `locale` = 'ruRU' AND `entry` = 37883;
-- OLD name : Вегард Непрощенный
-- Source : https://www.wowhead.com/wotlk/ru/npc=37893
UPDATE `creature_template_locale` SET `Name` = '[Vegard the Unforgiven]' WHERE `locale` = 'ruRU' AND `entry` = 37893;
-- OLD name : Vegard Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=37894
UPDATE `creature_template_locale` SET `Name` = '[Vegard Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 37894;
-- OLD name : Инженер "Усмирителя небес"
-- Source : https://www.wowhead.com/wotlk/ru/npc=37898
UPDATE `creature_template_locale` SET `Name` = '[Skybreaker Engineer]' WHERE `locale` = 'ruRU' AND `entry` = 37898;
-- OLD name : Каменщик Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=37902
UPDATE `creature_template_locale` SET `Name` = '[Alliance Mason]' WHERE `locale` = 'ruRU' AND `entry` = 37902;
-- OLD name : Могущественный бес-кровосос
-- Source : https://www.wowhead.com/wotlk/ru/npc=37919
UPDATE `creature_template_locale` SET `Name` = '[Empowered Vampiric Fiend]' WHERE `locale` = 'ruRU' AND `entry` = 37919;
-- OLD name : Кор'кронский разоритель
-- Source : https://www.wowhead.com/wotlk/ru/npc=37920
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 37920;
-- OLD name : Осадный инженер "Молота Оргрима"
-- Source : https://www.wowhead.com/wotlk/ru/npc=37932
UPDATE `creature_template_locale` SET `Name` = '[Orgrim''s Hammer Siege Engineer]' WHERE `locale` = 'ruRU' AND `entry` = 37932;
-- OLD subname : Эмблема интенданта Мороза
-- Source : https://www.wowhead.com/wotlk/ru/npc=37941
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы льда' WHERE `locale` = 'ruRU' AND `entry` = 37941;
-- OLD subname : Эмблема интенданта Мороза
-- Source : https://www.wowhead.com/wotlk/ru/npc=37942
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы льда' WHERE `locale` = 'ruRU' AND `entry` = 37942;
-- OLD name : Штормградский патрульный
-- Source : https://www.wowhead.com/wotlk/ru/npc=37944
UPDATE `creature_template_locale` SET `Name` = '[Stormwind City Patroller]' WHERE `locale` = 'ruRU' AND `entry` = 37944;
-- OLD name : Light's Vengeance Vehicle Bunny 2
-- Source : https://www.wowhead.com/wotlk/ru/npc=37952
UPDATE `creature_template_locale` SET `Name` = '[Light''s Vengeance Vehicle Bunny 2]' WHERE `locale` = 'ruRU' AND `entry` = 37952;
-- OLD name : Вегард Непрощенный
-- Source : https://www.wowhead.com/wotlk/ru/npc=37976
UPDATE `creature_template_locale` SET `Name` = '[Vegard the Unforgiven]' WHERE `locale` = 'ruRU' AND `entry` = 37976;
-- OLD name : Гневный элементаль огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=37982
UPDATE `creature_template_locale` SET `Name` = '[Furious Fire Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 37982;
-- OLD name : Опаляющий элементаль огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=37983
UPDATE `creature_template_locale` SET `Name` = '[Searing Fire Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 37983;
-- OLD name : Light's Vengeance Bunny 2
-- Source : https://www.wowhead.com/wotlk/ru/npc=38001
UPDATE `creature_template_locale` SET `Name` = '[Light''s Vengeance Bunny 2]' WHERE `locale` = 'ruRU' AND `entry` = 38001;
-- OLD name : Забияка химической компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=38006
UPDATE `creature_template_locale` SET `Name` = '[Crown Hoodlum]' WHERE `locale` = 'ruRU' AND `entry` = 38006;
-- OLD name : Sunreaver Disguise (Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=38011
UPDATE `creature_template_locale` SET `Name` = '[Sunreaver Disguise (Male)]' WHERE `locale` = 'ruRU' AND `entry` = 38011;
-- OLD name : Sunreaver Disguise (Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=38012
UPDATE `creature_template_locale` SET `Name` = '[Sunreaver Disguise (Female)]' WHERE `locale` = 'ruRU' AND `entry` = 38012;
-- OLD name : Silver Covenant Disguise (Female)
-- Source : https://www.wowhead.com/wotlk/ru/npc=38013
UPDATE `creature_template_locale` SET `Name` = '[Silver Covenant Disguise (Female)]' WHERE `locale` = 'ruRU' AND `entry` = 38013;
-- OLD name : Silver Covenant Disguise (Male)
-- Source : https://www.wowhead.com/wotlk/ru/npc=38014
UPDATE `creature_template_locale` SET `Name` = '[Silver Covenant Disguise (Male)]' WHERE `locale` = 'ruRU' AND `entry` = 38014;
-- OLD name : Агент химической компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=38016
UPDATE `creature_template_locale` SET `Name` = '[Crown Agent]' WHERE `locale` = 'ruRU' AND `entry` = 38016;
-- OLD name : Анолис
-- Source : https://www.wowhead.com/wotlk/ru/npc=38019
UPDATE `creature_template_locale` SET `Name` = '[Anolis]' WHERE `locale` = 'ruRU' AND `entry` = 38019;
-- OLD name : Базилий
-- Source : https://www.wowhead.com/wotlk/ru/npc=38020
UPDATE `creature_template_locale` SET `Name` = '[Basiliscus]' WHERE `locale` = 'ruRU' AND `entry` = 38020;
-- OLD name : Конолофий
-- Source : https://www.wowhead.com/wotlk/ru/npc=38021
UPDATE `creature_template_locale` SET `Name` = '[Conolophus]' WHERE `locale` = 'ruRU' AND `entry` = 38021;
-- OLD name : Окропитель химической компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=38023
UPDATE `creature_template_locale` SET `Name` = '[Crown Sprinkler]' WHERE `locale` = 'ruRU' AND `entry` = 38023;
-- OLD name : Стажер химической компании
-- Source : https://www.wowhead.com/wotlk/ru/npc=38030
UPDATE `creature_template_locale` SET `Name` = '[Crown Underling]' WHERE `locale` = 'ruRU' AND `entry` = 38030;
-- OLD name : Эльф крови - странник
-- Source : https://www.wowhead.com/wotlk/ru/npc=38047
UPDATE `creature_template_locale` SET `Name` = '[Blood Elf Pilgrim]' WHERE `locale` = 'ruRU' AND `entry` = 38047;
-- OLD name : Высший эльф - странник
-- Source : https://www.wowhead.com/wotlk/ru/npc=38048
UPDATE `creature_template_locale` SET `Name` = '[High Elf Pilgrim]' WHERE `locale` = 'ruRU' AND `entry` = 38048;
-- OLD name : Юный странник
-- Source : https://www.wowhead.com/wotlk/ru/npc=38049
UPDATE `creature_template_locale` SET `Name` = '[Young Pilgrim]' WHERE `locale` = 'ruRU' AND `entry` = 38049;
-- OLD name : Оргриммарский рубака
-- Source : https://www.wowhead.com/wotlk/ru/npc=38050
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Grunt]' WHERE `locale` = 'ruRU' AND `entry` = 38050;
-- OLD name : Леди Лиадрин, subname : Повелительница рыцарей крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=38052
UPDATE `creature_template_locale` SET `Name` = '[Lady Liadrin]',`Title` = '[Blood Knight Matriarch]' WHERE `locale` = 'ruRU' AND `entry` = 38052;
-- OLD name : Хранитель ключей Галирос
-- Source : https://www.wowhead.com/wotlk/ru/npc=38056
UPDATE `creature_template_locale` SET `Name` = '[Chamberlain Galiros]' WHERE `locale` = 'ruRU' AND `entry` = 38056;
-- OLD name : Проекция Солнечного Колодца
-- Source : https://www.wowhead.com/wotlk/ru/npc=38116
UPDATE `creature_template_locale` SET `Name` = '[Image of the Sunwell]' WHERE `locale` = 'ruRU' AND `entry` = 38116;
-- OLD name : Soul Feast Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=38121
UPDATE `creature_template_locale` SET `Name` = '[Soul Feast Kill Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 38121;
-- OLD name : Пойманный горожанин
-- Source : https://www.wowhead.com/wotlk/ru/npc=38162
UPDATE `creature_template_locale` SET `Name` = '[Trapped Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 38162;
-- OLD name : Тотем освобождения
-- Source : https://www.wowhead.com/wotlk/ru/npc=38180
UPDATE `creature_template_locale` SET `Name` = '[Cleansing Totem]' WHERE `locale` = 'ruRU' AND `entry` = 38180;
-- OLD name : Грань Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=38191
UPDATE `creature_template_locale` SET `Name` = '[Shadow''s Edge]' WHERE `locale` = 'ruRU' AND `entry` = 38191;
-- OLD name : Представитель Серебряного союза
-- Source : https://www.wowhead.com/wotlk/ru/npc=38200
UPDATE `creature_template_locale` SET `Name` = 'Посланник Серебряного союза' WHERE `locale` = 'ruRU' AND `entry` = 38200;
-- OLD name : Большая ракета любви
-- Source : https://www.wowhead.com/wotlk/ru/npc=38204
UPDATE `creature_template_locale` SET `Name` = '"Сердцеед" X-45' WHERE `locale` = 'ruRU' AND `entry` = 38204;
-- OLD name : Большая ракета любви
-- Source : https://www.wowhead.com/wotlk/ru/npc=38207
UPDATE `creature_template_locale` SET `Name` = '[Flying Big Love Rocket]' WHERE `locale` = 'ruRU' AND `entry` = 38207;
-- OLD name : Wrath of the Lich King Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=38211
UPDATE `creature_template_locale` SET `Name` = '[Wrath of the Lich King Credit]' WHERE `locale` = 'ruRU' AND `entry` = 38211;
-- OLD name : Мутировавший профессор Мерзоцид
-- Source : https://www.wowhead.com/wotlk/ru/npc=38216
UPDATE `creature_template_locale` SET `Name` = '[Mutated Professor Putricide]' WHERE `locale` = 'ruRU' AND `entry` = 38216;
-- OLD name : Мстительная тень
-- Source : https://www.wowhead.com/wotlk/ru/npc=38222
UPDATE `creature_template_locale` SET `Name` = 'Мстительный дух' WHERE `locale` = 'ruRU' AND `entry` = 38222;
-- OLD name : Непобедимый
-- Source : https://www.wowhead.com/wotlk/ru/npc=38260
UPDATE `creature_template_locale` SET `Name` = '[Invincible]' WHERE `locale` = 'ruRU' AND `entry` = 38260;
-- OLD name : Превращение великана темных рун
-- Source : https://www.wowhead.com/wotlk/ru/npc=38264
UPDATE `creature_template_locale` SET `Name` = '[Dark Rune Giant Transform]' WHERE `locale` = 'ruRU' AND `entry` = 38264;
-- OLD name : Видение врайкула
-- Source : https://www.wowhead.com/wotlk/ru/npc=38271
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Illusion]' WHERE `locale` = 'ruRU' AND `entry` = 38271;
-- OLD name : Видение таунка
-- Source : https://www.wowhead.com/wotlk/ru/npc=38273
UPDATE `creature_template_locale` SET `Name` = '[Taunka Illusion]' WHERE `locale` = 'ruRU' AND `entry` = 38273;
-- OLD name : Мутировавшее поганище
-- Source : https://www.wowhead.com/wotlk/ru/npc=38285
UPDATE `creature_template_locale` SET `Name` = '[Mutated Abomination]' WHERE `locale` = 'ruRU' AND `entry` = 38285;
-- OLD name : Unholy Infusion KC Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=38289
UPDATE `creature_template_locale` SET `Name` = '[Unholy Infusion KC Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 38289;
-- OLD name : Melee Trinket - Tuskarr
-- Source : https://www.wowhead.com/wotlk/ru/npc=38291
UPDATE `creature_template_locale` SET `Name` = '[Melee Trinket - Tuskarr]' WHERE `locale` = 'ruRU' AND `entry` = 38291;
-- OLD name : Melee Trinket - Taunka
-- Source : https://www.wowhead.com/wotlk/ru/npc=38292
UPDATE `creature_template_locale` SET `Name` = '[Melee Trinket - Taunka]' WHERE `locale` = 'ruRU' AND `entry` = 38292;
-- OLD name : Invisible Stalker (Float, Uninteractible, LargeAOI) (3.00)
-- Source : https://www.wowhead.com/wotlk/ru/npc=38310
UPDATE `creature_template_locale` SET `Name` = '[Invisible Stalker (Float, Uninteractible, LargeAOI) (3.00)]' WHERE `locale` = 'ruRU' AND `entry` = 38310;
-- OLD name : Сфера Кровавой Королевы
-- Source : https://www.wowhead.com/wotlk/ru/npc=38353
UPDATE `creature_template_locale` SET `Name` = '[Blood Queen Orb]' WHERE `locale` = 'ruRU' AND `entry` = 38353;
-- OLD name : Tesla Coil Stalker
-- Source : https://www.wowhead.com/wotlk/ru/npc=38367
UPDATE `creature_template_locale` SET `Name` = '[Tesla Coil Stalker]' WHERE `locale` = 'ruRU' AND `entry` = 38367;
-- OLD name : Patchwerk (PTR All-Around Test)
-- Source : https://www.wowhead.com/wotlk/ru/npc=38386
UPDATE `creature_template_locale` SET `Name` = '[Patchwerk (PTR All-Around Test)]' WHERE `locale` = 'ruRU' AND `entry` = 38386;
-- OLD name : Рыцарь Серебряного Авангарда
-- Source : https://www.wowhead.com/wotlk/ru/npc=38497
UPDATE `creature_template_locale` SET `Name` = '[Argent Crusader (Mounted)]' WHERE `locale` = 'ruRU' AND `entry` = 38497;
-- OLD name : Blood Infusion Quest Credit Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=38503
UPDATE `creature_template_locale` SET `Name` = '[Blood Infusion Quest Credit Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 38503;
-- OLD name : Shadowmourne Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=38527
UPDATE `creature_template_locale` SET `Name` = '[Shadowmourne Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 38527;
-- OLD name : Shadowmourne Axe Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=38528
UPDATE `creature_template_locale` SET `Name` = '[Shadowmourne Axe Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 38528;
-- OLD name : Темная Скорбь
-- Source : https://www.wowhead.com/wotlk/ru/npc=38529
UPDATE `creature_template_locale` SET `Name` = '[Shadowmourne]' WHERE `locale` = 'ruRU' AND `entry` = 38529;
-- OLD name : Frost Infusion Quest Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=38546
UPDATE `creature_template_locale` SET `Name` = '[Frost Infusion Quest Credit]' WHERE `locale` = 'ruRU' AND `entry` = 38546;
-- OLD name : Sindragosa Quest Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=38547
UPDATE `creature_template_locale` SET `Name` = '[Sindragosa Quest Credit]' WHERE `locale` = 'ruRU' AND `entry` = 38547;
-- OLD name : Призрачное явление
-- Source : https://www.wowhead.com/wotlk/ru/npc=38566
UPDATE `creature_template_locale` SET `Name` = '[Phantom Hallucination]' WHERE `locale` = 'ruRU' AND `entry` = 38566;
-- OLD name : Bug 181860
-- Source : https://www.wowhead.com/wotlk/ru/npc=38572
UPDATE `creature_template_locale` SET `Name` = '[Bug 181860]' WHERE `locale` = 'ruRU' AND `entry` = 38572;
-- OLD name : Professor Putricide Proxy Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=38587
UPDATE `creature_template_locale` SET `Name` = '[Professor Putricide Proxy Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 38587;
-- OLD name : Blood Queen Proxy Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=38588
UPDATE `creature_template_locale` SET `Name` = '[Blood Queen Proxy Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 38588;
-- OLD name : Argent Valiant Credit (Aspirant Test), subname : С.С.М.
-- Source : https://www.wowhead.com/wotlk/ru/npc=38595
UPDATE `creature_template_locale` SET `Name` = '[Argent Valiant Credit (Aspirant Test)]',`Title` = '[S.T.O.U.T.]' WHERE `locale` = 'ruRU' AND `entry` = 38595;
-- OLD subname : Рыцарь ордена Серебряной Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=38608
UPDATE `creature_template_locale` SET `Title` = 'Рыцарь Серебряной Длани' WHERE `locale` = 'ruRU' AND `entry` = 38608;
-- OLD name : Верховный лорд Александрос Могрейн, subname : Испепелитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=38610
UPDATE `creature_template_locale` SET `Name` = '[Highlord Alexandros Mograine]',`Title` = '[The Ashbringer]' WHERE `locale` = 'ruRU' AND `entry` = 38610;
-- OLD name : Frostmourne Soul Transform Visual
-- Source : https://www.wowhead.com/wotlk/ru/npc=38710
UPDATE `creature_template_locale` SET `Name` = '[Frostmourne Soul Transform Visual]' WHERE `locale` = 'ruRU' AND `entry` = 38710;
-- OLD name : Магистр Телос
-- Source : https://www.wowhead.com/wotlk/ru/npc=38716
UPDATE `creature_template_locale` SET `Name` = '[Magister Thelos]' WHERE `locale` = 'ruRU' AND `entry` = 38716;
-- OLD name : Эйрин
-- Source : https://www.wowhead.com/wotlk/ru/npc=38825
UPDATE `creature_template_locale` SET `Name` = '[Aerin]' WHERE `locale` = 'ruRU' AND `entry` = 38825;
-- OLD name : Убитый страж утесов
-- Source : https://www.wowhead.com/wotlk/ru/npc=38831
UPDATE `creature_template_locale` SET `Name` = '[Slain Bluffwatcher]' WHERE `locale` = 'ruRU' AND `entry` = 38831;
-- OLD name : Стражник из клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=38839
UPDATE `creature_template_locale` SET `Name` = '[Dark Iron Guard]' WHERE `locale` = 'ruRU' AND `entry` = 38839;
-- OLD name : ПэттиМакс ЛК
-- Source : https://www.wowhead.com/wotlk/ru/npc=38857
UPDATE `creature_template_locale` SET `Name` = '[PattyMacks LK]' WHERE `locale` = 'ruRU' AND `entry` = 38857;
-- OLD subname : Старинные награды за очки справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=38858
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы льда' WHERE `locale` = 'ruRU' AND `entry` = 38858;
-- OLD name : Bug 184688
-- Source : https://www.wowhead.com/wotlk/ru/npc=38860
UPDATE `creature_template_locale` SET `Name` = '[Bug 184688  ]' WHERE `locale` = 'ruRU' AND `entry` = 38860;
-- OLD name : Unkillable Test Dummy 83 Rogue
-- Source : https://www.wowhead.com/wotlk/ru/npc=38863
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 83 Rogue]' WHERE `locale` = 'ruRU' AND `entry` = 38863;
-- OLD name : Горожанин из клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=38877
UPDATE `creature_template_locale` SET `Name` = '[Dark Iron Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 38877;
-- OLD name : ScottG Test
-- Source : https://www.wowhead.com/wotlk/ru/npc=38883
UPDATE `creature_template_locale` SET `Name` = '[ScottG Test]' WHERE `locale` = 'ruRU' AND `entry` = 38883;
-- OLD name : Аукционист Каварн
-- Source : https://www.wowhead.com/wotlk/ru/npc=38900
UPDATE `creature_template_locale` SET `Name` = '[Auctioneer Kavarn]' WHERE `locale` = 'ruRU' AND `entry` = 38900;
-- OLD name : Горожанин Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=38901
UPDATE `creature_template_locale` SET `Name` = '[Ironforge Civilian]' WHERE `locale` = 'ruRU' AND `entry` = 38901;
-- OLD name : Queue trigger
-- Source : https://www.wowhead.com/wotlk/ru/npc=38903
UPDATE `creature_template_locale` SET `Name` = '[Queue trigger]' WHERE `locale` = 'ruRU' AND `entry` = 38903;
-- OLD name : Аукционист Сарнкин
-- Source : https://www.wowhead.com/wotlk/ru/npc=38906
UPDATE `creature_template_locale` SET `Name` = '[Auctioneer Sarnkin]' WHERE `locale` = 'ruRU' AND `entry` = 38906;
-- OLD name : Queue Controller
-- Source : https://www.wowhead.com/wotlk/ru/npc=38907
UPDATE `creature_template_locale` SET `Name` = '[Queue Controller]' WHERE `locale` = 'ruRU' AND `entry` = 38907;
-- OLD name : Потревоженный дух земли
-- Source : https://www.wowhead.com/wotlk/ru/npc=39021
UPDATE `creature_template_locale` SET `Name` = '[Agitated Earth Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 39021;
-- OLD name : Лазурный конь смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=39045
UPDATE `creature_template_locale` SET `Name` = '[Azure Deathcharger]' WHERE `locale` = 'ruRU' AND `entry` = 39045;
-- OLD name : Потревоженный дух огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=39047
UPDATE `creature_template_locale` SET `Name` = '[Agitated Fire Spirit]' WHERE `locale` = 'ruRU' AND `entry` = 39047;
-- OLD name : Гаван Серое Перо
-- Source : https://www.wowhead.com/wotlk/ru/npc=39055
UPDATE `creature_template_locale` SET `Name` = '[Gavan Grayfeather]' WHERE `locale` = 'ruRU' AND `entry` = 39055;
-- OLD name : Бранн Бронзобород
-- Source : https://www.wowhead.com/wotlk/ru/npc=39060
UPDATE `creature_template_locale` SET `Name` = '[Brann Bronzebeard (Prologue)]' WHERE `locale` = 'ruRU' AND `entry` = 39060;
-- OLD name : Предмет: иллюзия Зиморожденных
-- Source : https://www.wowhead.com/wotlk/ru/npc=39089
UPDATE `creature_template_locale` SET `Name` = '[Item: Frostborn Illusion]' WHERE `locale` = 'ruRU' AND `entry` = 39089;
-- OLD name : Дуран Говорящий с Огнем, subname : Служители Земли
-- Source : https://www.wowhead.com/wotlk/ru/npc=39090
UPDATE `creature_template_locale` SET `Name` = '[Durak Flamespeaker]',`Title` = '[The Earthen Ring]' WHERE `locale` = 'ruRU' AND `entry` = 39090;
-- OLD name : Darnavan Kill Credit 10
-- Source : https://www.wowhead.com/wotlk/ru/npc=39091
UPDATE `creature_template_locale` SET `Name` = '[Darnavan Kill Credit 10]' WHERE `locale` = 'ruRU' AND `entry` = 39091;
-- OLD name : Darnavan Kill Credit 25
-- Source : https://www.wowhead.com/wotlk/ru/npc=39092
UPDATE `creature_template_locale` SET `Name` = '[Darnavan Kill Credit 25]' WHERE `locale` = 'ruRU' AND `entry` = 39092;
-- OLD name : Курьер Тормун, subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=39101
UPDATE `creature_template_locale` SET `Name` = '[Courier Tormun]',`Title` = '[Explorer''s League]' WHERE `locale` = 'ruRU' AND `entry` = 39101;
-- OLD name : Сумеречный искатель, subname : Сумеречный Молот
-- Source : https://www.wowhead.com/wotlk/ru/npc=39103
UPDATE `creature_template_locale` SET `Name` = '[Twilight Seeker]',`Title` = '[Twilight''s Hammer]' WHERE `locale` = 'ruRU' AND `entry` = 39103;
-- OLD name : Blood Quickening Credit 25
-- Source : https://www.wowhead.com/wotlk/ru/npc=39123
UPDATE `creature_template_locale` SET `Name` = '[Blood Quickening Credit 25]' WHERE `locale` = 'ruRU' AND `entry` = 39123;
-- OLD name : Валь'кира - страж Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=39125
UPDATE `creature_template_locale` SET `Name` = '[Val''kyr Shadowguard (Hover Height 20 Visual)]' WHERE `locale` = 'ruRU' AND `entry` = 39125;
-- OLD name : Пламенеющий слуга
-- Source : https://www.wowhead.com/wotlk/ru/npc=39130
UPDATE `creature_template_locale` SET `Name` = '[Blazing Servant]' WHERE `locale` = 'ruRU' AND `entry` = 39130;
-- OLD name : Водянистый слуга
-- Source : https://www.wowhead.com/wotlk/ru/npc=39131
UPDATE `creature_template_locale` SET `Name` = '[Watery Servant]' WHERE `locale` = 'ruRU' AND `entry` = 39131;
-- OLD name : Земляной слуга
-- Source : https://www.wowhead.com/wotlk/ru/npc=39132
UPDATE `creature_template_locale` SET `Name` = '[Earthen Servant]' WHERE `locale` = 'ruRU' AND `entry` = 39132;
-- OLD name : Prologue Portal Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=39135
UPDATE `creature_template_locale` SET `Name` = '[Prologue Portal Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 39135;
-- OLD name : Фаланг
-- Source : https://www.wowhead.com/wotlk/ru/npc=39158
UPDATE `creature_template_locale` SET `Name` = '[Phalanx 2.0]' WHERE `locale` = 'ruRU' AND `entry` = 39158;
-- OLD name : Ловушка духов
-- Source : https://www.wowhead.com/wotlk/ru/npc=39189
UPDATE `creature_template_locale` SET `Name` = 'Взрывной дух' WHERE `locale` = 'ruRU' AND `entry` = 39189;
-- OLD name : Водитель гномреганского механотанка
-- Source : https://www.wowhead.com/wotlk/ru/npc=39230
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Tank Pilot]' WHERE `locale` = 'ruRU' AND `entry` = 39230;
-- OLD name : The Lich King (Temp)
-- Source : https://www.wowhead.com/wotlk/ru/npc=39231
UPDATE `creature_template_locale` SET `Name` = '[The Lich King (Temp)]' WHERE `locale` = 'ruRU' AND `entry` = 39231;
-- OLD name : Гномреганский пехотинец
-- Source : https://www.wowhead.com/wotlk/ru/npc=39252
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Infantry]' WHERE `locale` = 'ruRU' AND `entry` = 39252;
-- OLD name : Гном-горожанин
-- Source : https://www.wowhead.com/wotlk/ru/npc=39253
UPDATE `creature_template_locale` SET `Name` = '[Gnome Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 39253;
-- OLD name : Гномреганский ветролет
-- Source : https://www.wowhead.com/wotlk/ru/npc=39259
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Flying Machine]' WHERE `locale` = 'ruRU' AND `entry` = 39259;
-- OLD name : Разобранный механотанк
-- Source : https://www.wowhead.com/wotlk/ru/npc=39263
UPDATE `creature_template_locale` SET `Name` = '[Disassembled Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 39263;
-- OLD name : Водитель гномреганского механотанка
-- Source : https://www.wowhead.com/wotlk/ru/npc=39264
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Tank Pilot]' WHERE `locale` = 'ruRU' AND `entry` = 39264;
-- OLD name : Спасенный беженец из Гномрегана
-- Source : https://www.wowhead.com/wotlk/ru/npc=39265
UPDATE `creature_template_locale` SET `Name` = '[Rescued Gnomeregan Evacuee]' WHERE `locale` = 'ruRU' AND `entry` = 39265;
-- OLD name : Главный механик Меггакрут, subname : Король гномов
-- Source : https://www.wowhead.com/wotlk/ru/npc=39271
UPDATE `creature_template_locale` SET `Name` = '[High Tinker Mekkatorque]',`Title` = '[King of Gnomes]' WHERE `locale` = 'ruRU' AND `entry` = 39271;
-- OLD name : "Док" Вертушка, subname : Начальник медицинской службы
-- Source : https://www.wowhead.com/wotlk/ru/npc=39273
UPDATE `creature_template_locale` SET `Name` = '["Doc" Cogspin]',`Title` = '[Surgeon General]' WHERE `locale` = 'ruRU' AND `entry` = 39273;
-- OLD name : Гномреганский медик
-- Source : https://www.wowhead.com/wotlk/ru/npc=39275
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Medic]' WHERE `locale` = 'ruRU' AND `entry` = 39275;
-- OLD name : Целительница земли Норсала, subname : Служители Земли
-- Source : https://www.wowhead.com/wotlk/ru/npc=39283
UPDATE `creature_template_locale` SET `Name` = '[Seer Bahura]',`Title` = '[The Earthen Ring]' WHERE `locale` = 'ruRU' AND `entry` = 39283;
-- OLD name : Вестник рока
-- Source : https://www.wowhead.com/wotlk/ru/npc=39328
UPDATE `creature_template_locale` SET `Name` = '[Doomsayer]' WHERE `locale` = 'ruRU' AND `entry` = 39328;
-- OLD name : Горожанин Оргриммара
-- Source : https://www.wowhead.com/wotlk/ru/npc=39343
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 39343;
-- OLD name : Гномреганский новобранец
-- Source : https://www.wowhead.com/wotlk/ru/npc=39349
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Trainee]' WHERE `locale` = 'ruRU' AND `entry` = 39349;
-- OLD name : Сержант-инструктор Парогон
-- Source : https://www.wowhead.com/wotlk/ru/npc=39368
UPDATE `creature_template_locale` SET `Name` = '[Drill Sergeant Steamcrank]' WHERE `locale` = 'ruRU' AND `entry` = 39368;
-- OLD name : Гаррош Адский Крик, subname : Предводитель армии Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=39372
UPDATE `creature_template_locale` SET `Name` = '[Garrosh Hellscream]',`Title` = '[Overlord of the Warsong Offensive]' WHERE `locale` = 'ruRU' AND `entry` = 39372;
-- OLD name : Пилот Винтоух
-- Source : https://www.wowhead.com/wotlk/ru/npc=39386
UPDATE `creature_template_locale` SET `Name` = '[Pilot Muzzlesprock]' WHERE `locale` = 'ruRU' AND `entry` = 39386;
-- OLD name : "Молния"
-- Source : https://www.wowhead.com/wotlk/ru/npc=39396
UPDATE `creature_template_locale` SET `Name` = '[''Thunderflash'']' WHERE `locale` = 'ruRU' AND `entry` = 39396;
-- OLD name : Радиометрозиметр
-- Source : https://www.wowhead.com/wotlk/ru/npc=39421
UPDATE `creature_template_locale` SET `Name` = '[Radiageigatron]' WHERE `locale` = 'ruRU' AND `entry` = 39421;
-- OLD name : Кровавый страж Торек
-- Source : https://www.wowhead.com/wotlk/ru/npc=39448
UPDATE `creature_template_locale` SET `Name` = '[Blood Guard Torek]' WHERE `locale` = 'ruRU' AND `entry` = 39448;
-- OLD name : Doomsayer Speech Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=39454
UPDATE `creature_template_locale` SET `Name` = '[Doomsayer Speech Credit]' WHERE `locale` = 'ruRU' AND `entry` = 39454;
-- OLD name : Owen Test Vendor
-- Source : https://www.wowhead.com/wotlk/ru/npc=39462
UPDATE `creature_template_locale` SET `Name` = '[Owen Test Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 39462;
-- OLD name : Сознательный горожанин
-- Source : https://www.wowhead.com/wotlk/ru/npc=39466
UPDATE `creature_template_locale` SET `Name` = '[Motivated Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 39466;
-- OLD name : Капитан Антон
-- Source : https://www.wowhead.com/wotlk/ru/npc=39508
UPDATE `creature_template_locale` SET `Name` = '[Captain Anton]' WHERE `locale` = 'ruRU' AND `entry` = 39508;
-- OLD name : Poster Marker - Orgrimmar
-- Source : https://www.wowhead.com/wotlk/ru/npc=39581
UPDATE `creature_template_locale` SET `Name` = '[Poster Marker - Orgrimmar ]' WHERE `locale` = 'ruRU' AND `entry` = 39581;
-- OLD name : Гном-горожанин
-- Source : https://www.wowhead.com/wotlk/ru/npc=39623
UPDATE `creature_template_locale` SET `Name` = '[Gnome Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 39623;
-- OLD name : Сознательный горожанин
-- Source : https://www.wowhead.com/wotlk/ru/npc=39624
UPDATE `creature_template_locale` SET `Name` = '[Motivated Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 39624;
-- OLD name : Горожанин Оргриммара
-- Source : https://www.wowhead.com/wotlk/ru/npc=39632
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 39632;
-- OLD name : Дозорный деревни Сен'джин
-- Source : https://www.wowhead.com/wotlk/ru/npc=39633
UPDATE `creature_template_locale` SET `Name` = '[Sen''jin Watcher]' WHERE `locale` = 'ruRU' AND `entry` = 39633;
-- OLD name : Беспокойный зомби
-- Source : https://www.wowhead.com/wotlk/ru/npc=39639
UPDATE `creature_template_locale` SET `Name` = '[Restless Zombie]' WHERE `locale` = 'ruRU' AND `entry` = 39639;
-- OLD name : Залазан
-- Source : https://www.wowhead.com/wotlk/ru/npc=39647
UPDATE `creature_template_locale` SET `Name` = '[Zalazane]' WHERE `locale` = 'ruRU' AND `entry` = 39647;
-- OLD name : Сектант Судного дня
-- Source : https://www.wowhead.com/wotlk/ru/npc=39648
UPDATE `creature_template_locale` SET `Name` = '[Doomsday Cultist]' WHERE `locale` = 'ruRU' AND `entry` = 39648;
-- OLD name : Вол'джин
-- Source : https://www.wowhead.com/wotlk/ru/npc=39654
UPDATE `creature_template_locale` SET `Name` = '[Vol''jin]' WHERE `locale` = 'ruRU' AND `entry` = 39654;
-- OLD name : Poster Marker - Stormwind
-- Source : https://www.wowhead.com/wotlk/ru/npc=39672
UPDATE `creature_template_locale` SET `Name` = '[Poster Marker - Stormwind]' WHERE `locale` = 'ruRU' AND `entry` = 39672;
-- OLD name : Капитан Ступ Искраж
-- Source : https://www.wowhead.com/wotlk/ru/npc=39675
UPDATE `creature_template_locale` SET `Name` = '[Captain Tread Sparknozzle]' WHERE `locale` = 'ruRU' AND `entry` = 39675;
-- OLD name : Тоби Зимехан, subname : Спичрайтер
-- Source : https://www.wowhead.com/wotlk/ru/npc=39678
UPDATE `creature_template_locale` SET `Name` = '[Toby Zeigear]',`Title` = '[Speechwriter]' WHERE `locale` = 'ruRU' AND `entry` = 39678;
-- OLD name : Механотанк-катапульта
-- Source : https://www.wowhead.com/wotlk/ru/npc=39682
UPDATE `creature_template_locale` SET `Name` = '[Ejector Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 39682;
-- OLD name : Житель Штормграда
-- Source : https://www.wowhead.com/wotlk/ru/npc=39686
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 39686;
-- OLD name : Цель атаки механотанка
-- Source : https://www.wowhead.com/wotlk/ru/npc=39711
UPDATE `creature_template_locale` SET `Name` = '[Mechano-Tank Attack Target]' WHERE `locale` = 'ruRU' AND `entry` = 39711;
-- OLD name : Главный механик Меггакрут, subname : Король гномов
-- Source : https://www.wowhead.com/wotlk/ru/npc=39712
UPDATE `creature_template_locale` SET `Name` = '[High Tinker Mekkatorque]',`Title` = '[King of Gnomes]' WHERE `locale` = 'ruRU' AND `entry` = 39712;
-- OLD name : Маневренный механотанк
-- Source : https://www.wowhead.com/wotlk/ru/npc=39713
UPDATE `creature_template_locale` SET `Name` = '[Scuttling Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 39713;
-- OLD name : Стреляющий механотанк
-- Source : https://www.wowhead.com/wotlk/ru/npc=39714
UPDATE `creature_template_locale` SET `Name` = '[Shooting Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 39714;
-- OLD name : Механотанк-катапульта
-- Source : https://www.wowhead.com/wotlk/ru/npc=39715
UPDATE `creature_template_locale` SET `Name` = '[Ejector Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 39715;
-- OLD name : Маневренный механотанк
-- Source : https://www.wowhead.com/wotlk/ru/npc=39716
UPDATE `creature_template_locale` SET `Name` = '[Scuttling Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 39716;
-- OLD name : Стреляющий механотанк
-- Source : https://www.wowhead.com/wotlk/ru/npc=39717
UPDATE `creature_template_locale` SET `Name` = '[Shooting Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 39717;
-- OLD name : Гномреганский бомбист
-- Source : https://www.wowhead.com/wotlk/ru/npc=39735
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Multi-Bomber]' WHERE `locale` = 'ruRU' AND `entry` = 39735;
-- OLD name : Облученный пехотинец
-- Source : https://www.wowhead.com/wotlk/ru/npc=39755
UPDATE `creature_template_locale` SET `Name` = '[Irradiated Infantry]' WHERE `locale` = 'ruRU' AND `entry` = 39755;
-- OLD name : Сектант Кагарн
-- Source : https://www.wowhead.com/wotlk/ru/npc=39757
UPDATE `creature_template_locale` SET `Name` = '[Cultist Kagarn]' WHERE `locale` = 'ruRU' AND `entry` = 39757;
-- OLD name : Сектант Агтар
-- Source : https://www.wowhead.com/wotlk/ru/npc=39758
UPDATE `creature_template_locale` SET `Name` = '[Cultist Agtar]' WHERE `locale` = 'ruRU' AND `entry` = 39758;
-- OLD name : Противотанковая пушка
-- Source : https://www.wowhead.com/wotlk/ru/npc=39759
UPDATE `creature_template_locale` SET `Name` = '[Tankbuster Cannon]' WHERE `locale` = 'ruRU' AND `entry` = 39759;
-- OLD name : Сектант Токка
-- Source : https://www.wowhead.com/wotlk/ru/npc=39760
UPDATE `creature_template_locale` SET `Name` = '[Cultist Tokka]' WHERE `locale` = 'ruRU' AND `entry` = 39760;
-- OLD name : Сектант Рокага
-- Source : https://www.wowhead.com/wotlk/ru/npc=39763
UPDATE `creature_template_locale` SET `Name` = '[Cultist Rokaga]' WHERE `locale` = 'ruRU' AND `entry` = 39763;
-- OLD name : Гашерикк
-- Source : https://www.wowhead.com/wotlk/ru/npc=39799
UPDATE `creature_template_locale` SET `Name` = '[Gasherikk]' WHERE `locale` = 'ruRU' AND `entry` = 39799;
-- OLD name : Проекция Чо'Галла, subname : Глава клана Сумеречного Молота
-- Source : https://www.wowhead.com/wotlk/ru/npc=39807
UPDATE `creature_template_locale` SET `Name` = '[Image of Cho''Gall]',`Title` = '[Leader of Twilight''s Hammer]' WHERE `locale` = 'ruRU' AND `entry` = 39807;
-- OLD name : Облученный механотанк
-- Source : https://www.wowhead.com/wotlk/ru/npc=39818
UPDATE `creature_template_locale` SET `Name` = '[Irradiated Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 39818;
-- OLD name : Облученный механотанк
-- Source : https://www.wowhead.com/wotlk/ru/npc=39819
UPDATE `creature_template_locale` SET `Name` = '[Irradiated Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 39819;
-- OLD name : Ракетомет
-- Source : https://www.wowhead.com/wotlk/ru/npc=39820
UPDATE `creature_template_locale` SET `Name` = '[Rocket Launcher]' WHERE `locale` = 'ruRU' AND `entry` = 39820;
-- OLD name : Cho'Gall Speech Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=39821
UPDATE `creature_template_locale` SET `Name` = '[Cho''Gall Speech Credit]' WHERE `locale` = 'ruRU' AND `entry` = 39821;
-- OLD name : Надзиратель Голбаз
-- Source : https://www.wowhead.com/wotlk/ru/npc=39825
UPDATE `creature_template_locale` SET `Name` = '[Overseer Golbaz]' WHERE `locale` = 'ruRU' AND `entry` = 39825;
-- OLD name : Облученный трогг
-- Source : https://www.wowhead.com/wotlk/ru/npc=39826
UPDATE `creature_template_locale` SET `Name` = '[Irradiated Trogg]' WHERE `locale` = 'ruRU' AND `entry` = 39826;
-- OLD name : Надзирательница Джинтак
-- Source : https://www.wowhead.com/wotlk/ru/npc=39827
UPDATE `creature_template_locale` SET `Name` = '[Overseer Jintak]' WHERE `locale` = 'ruRU' AND `entry` = 39827;
-- OLD name : Облученный кавалерист
-- Source : https://www.wowhead.com/wotlk/ru/npc=39836
UPDATE `creature_template_locale` SET `Name` = '[Irradiated Cavalry]' WHERE `locale` = 'ruRU' AND `entry` = 39836;
-- OLD name : Командир Задвижер
-- Source : https://www.wowhead.com/wotlk/ru/npc=39837
UPDATE `creature_template_locale` SET `Name` = '[Commander Boltcog]' WHERE `locale` = 'ruRU' AND `entry` = 39837;
-- OLD name : Invisible Stalker (Hostile, Ignore Combat, Float, Uninteractible, Large AOI)
-- Source : https://www.wowhead.com/wotlk/ru/npc=39842
UPDATE `creature_template_locale` SET `Name` = '[Invisible Stalker (Hostile, Ignore Combat, Float, Uninteractible, Large AOI)]' WHERE `locale` = 'ruRU' AND `entry` = 39842;
-- OLD name : Бушующий дух огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=39852
UPDATE `creature_template_locale` SET `Name` = '[Raging Fire Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 39852;
-- OLD name : Бушующий дух шторма
-- Source : https://www.wowhead.com/wotlk/ru/npc=39856
UPDATE `creature_template_locale` SET `Name` = '[Raging Storm Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 39856;
-- OLD name : Гномреганский механотанк
-- Source : https://www.wowhead.com/wotlk/ru/npc=39860
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 39860;
-- OLD name : Обеспокоенная горожанка
-- Source : https://www.wowhead.com/wotlk/ru/npc=39861
UPDATE `creature_template_locale` SET `Name` = '[Worried Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 39861;
-- OLD name : Cult Recruitment Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=39872
UPDATE `creature_template_locale` SET `Name` = '[Cult Recruitment Credit]' WHERE `locale` = 'ruRU' AND `entry` = 39872;
-- OLD name : Гномреганский медик
-- Source : https://www.wowhead.com/wotlk/ru/npc=39888
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Medic]' WHERE `locale` = 'ruRU' AND `entry` = 39888;
-- OLD name : Сектант Судного дня
-- Source : https://www.wowhead.com/wotlk/ru/npc=39891
UPDATE `creature_template_locale` SET `Name` = '[Doomsday Cultist]' WHERE `locale` = 'ruRU' AND `entry` = 39891;
-- OLD name : Бахвалобот Анжинера Термоштепселя
-- Source : https://www.wowhead.com/wotlk/ru/npc=39901
UPDATE `creature_template_locale` SET `Name` = '[Mekgineer Thermaplugg''s Brag-Bot]' WHERE `locale` = 'ruRU' AND `entry` = 39901;
-- OLD name : Гномреганский боевой робот
-- Source : https://www.wowhead.com/wotlk/ru/npc=39902
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Battle Suit]' WHERE `locale` = 'ruRU' AND `entry` = 39902;
-- OLD name : Облучатель-3000
-- Source : https://www.wowhead.com/wotlk/ru/npc=39903
UPDATE `creature_template_locale` SET `Name` = '[Irradiator 3000]' WHERE `locale` = 'ruRU' AND `entry` = 39903;
-- OLD name : Хинклс Жарюган
-- Source : https://www.wowhead.com/wotlk/ru/npc=39910
UPDATE `creature_template_locale` SET `Name` = '[Hinkles Fastblast]' WHERE `locale` = 'ruRU' AND `entry` = 39910;
-- OLD name : Караульный дирижабля
-- Source : https://www.wowhead.com/wotlk/ru/npc=39934
UPDATE `creature_template_locale` SET `Name` = '[Zeppelin Sentry]' WHERE `locale` = 'ruRU' AND `entry` = 39934;
-- OLD name : Дракон сумеречного искателя
-- Source : https://www.wowhead.com/wotlk/ru/npc=39938
UPDATE `creature_template_locale` SET `Name` = '[Twilight Seeker''s Mount]' WHERE `locale` = 'ruRU' AND `entry` = 39938;
-- OLD name : Мертвый искатель, subname : Сумеречный Молот
-- Source : https://www.wowhead.com/wotlk/ru/npc=39940
UPDATE `creature_template_locale` SET `Name` = '[Dead Seeker]',`Title` = '[Twilight''s Hammer]' WHERE `locale` = 'ruRU' AND `entry` = 39940;
-- OLD name : Сектант Летелин
-- Source : https://www.wowhead.com/wotlk/ru/npc=39967
UPDATE `creature_template_locale` SET `Name` = '[Cultist Lethelyn]' WHERE `locale` = 'ruRU' AND `entry` = 39967;
-- OLD name : Сектант Кайма
-- Source : https://www.wowhead.com/wotlk/ru/npc=39968
UPDATE `creature_template_locale` SET `Name` = '[Cultist Kaima]' WHERE `locale` = 'ruRU' AND `entry` = 39968;
-- OLD name : Сектант Ваймен
-- Source : https://www.wowhead.com/wotlk/ru/npc=39969
UPDATE `creature_template_locale` SET `Name` = '[Cultist Wyman]' WHERE `locale` = 'ruRU' AND `entry` = 39969;
-- OLD name : Сектант Орлунн
-- Source : https://www.wowhead.com/wotlk/ru/npc=39970
UPDATE `creature_template_locale` SET `Name` = '[Cultist Orlunn]' WHERE `locale` = 'ruRU' AND `entry` = 39970;
-- OLD name : Стремительный оранжевый механодолгоног
-- Source : https://www.wowhead.com/wotlk/ru/npc=39973
UPDATE `creature_template_locale` SET `Name` = '[Swift Orange Mechanostrider]' WHERE `locale` = 'ruRU' AND `entry` = 39973;
-- OLD name : East Zeppelin Tower Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=39975
UPDATE `creature_template_locale` SET `Name` = '[East Zeppelin Tower Credit]' WHERE `locale` = 'ruRU' AND `entry` = 39975;
-- OLD name : West Zeppelin Tower Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=39976
UPDATE `creature_template_locale` SET `Name` = '[West Zeppelin Tower Credit]' WHERE `locale` = 'ruRU' AND `entry` = 39976;
-- OLD name : Razor Hill Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=39977
UPDATE `creature_template_locale` SET `Name` = '[Razor Hill Credit]' WHERE `locale` = 'ruRU' AND `entry` = 39977;
-- OLD name : Щит Дурана
-- Source : https://www.wowhead.com/wotlk/ru/npc=40006
UPDATE `creature_template_locale` SET `Name` = '[Durak''s Shield]' WHERE `locale` = 'ruRU' AND `entry` = 40006;
-- OLD name : Гномреганский механоид
-- Source : https://www.wowhead.com/wotlk/ru/npc=40010
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Suit]' WHERE `locale` = 'ruRU' AND `entry` = 40010;
-- OLD name : Durak's Shield (stage 2)
-- Source : https://www.wowhead.com/wotlk/ru/npc=40037
UPDATE `creature_template_locale` SET `Name` = '[Durak''s Shield (stage 2)]' WHERE `locale` = 'ruRU' AND `entry` = 40037;
-- OLD name : Щит Дурана
-- Source : https://www.wowhead.com/wotlk/ru/npc=40038
UPDATE `creature_template_locale` SET `Name` = '[Durak''s Shield (stage 3)]' WHERE `locale` = 'ruRU' AND `entry` = 40038;
-- OLD name : Щит Дурана
-- Source : https://www.wowhead.com/wotlk/ru/npc=40039
UPDATE `creature_template_locale` SET `Name` = '[Durak''s Shield (stage 4)]' WHERE `locale` = 'ruRU' AND `entry` = 40039;
-- OLD name : Механодолгоног Меггакрута
-- Source : https://www.wowhead.com/wotlk/ru/npc=40057
UPDATE `creature_template_locale` SET `Name` = '[Mekkatorque''s Swift Blue Mechanostrider]' WHERE `locale` = 'ruRU' AND `entry` = 40057;
-- OLD name : Сфера Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=40083
UPDATE `creature_template_locale` SET `Name` = 'Темный шар' WHERE `locale` = 'ruRU' AND `entry` = 40083;
-- OLD name : Надзиратель Талатор
-- Source : https://www.wowhead.com/wotlk/ru/npc=40097
UPDATE `creature_template_locale` SET `Name` = '[Overseer Talathor]' WHERE `locale` = 'ruRU' AND `entry` = 40097;
-- OLD name : Надзирательница Силандра
-- Source : https://www.wowhead.com/wotlk/ru/npc=40098
UPDATE `creature_template_locale` SET `Name` = '[Overseer Sylandra]' WHERE `locale` = 'ruRU' AND `entry` = 40098;
-- OLD name : Сфера Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=40100
UPDATE `creature_template_locale` SET `Name` = 'Темный шар' WHERE `locale` = 'ruRU' AND `entry` = 40100;
-- OLD name : Valley of Heroes Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=40101
UPDATE `creature_template_locale` SET `Name` = '[Valley of Heroes Credit]' WHERE `locale` = 'ruRU' AND `entry` = 40101;
-- OLD name : Westbrook Garrison Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=40102
UPDATE `creature_template_locale` SET `Name` = '[Westbrook Garrison Credit]' WHERE `locale` = 'ruRU' AND `entry` = 40102;
-- OLD name : Goldshire Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=40103
UPDATE `creature_template_locale` SET `Name` = '[Goldshire Credit]' WHERE `locale` = 'ruRU' AND `entry` = 40103;
-- OLD name : Бушующий дух ветра
-- Source : https://www.wowhead.com/wotlk/ru/npc=40104
UPDATE `creature_template_locale` SET `Name` = '[Raging Wind Elemental]' WHERE `locale` = 'ruRU' AND `entry` = 40104;
-- OLD name : Обеспокоенная горожанка
-- Source : https://www.wowhead.com/wotlk/ru/npc=40110
UPDATE `creature_template_locale` SET `Name` = '[Worried Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 40110;
-- OLD name : Гномреганский механотанк
-- Source : https://www.wowhead.com/wotlk/ru/npc=40120
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 40120;
-- OLD name : Гномреганский пехотинец
-- Source : https://www.wowhead.com/wotlk/ru/npc=40122
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Infantry]' WHERE `locale` = 'ruRU' AND `entry` = 40122;
-- OLD name : Вестник рока
-- Source : https://www.wowhead.com/wotlk/ru/npc=40124
UPDATE `creature_template_locale` SET `Name` = '[Doomsayer]' WHERE `locale` = 'ruRU' AND `entry` = 40124;
-- OLD name : Житель Штормграда
-- Source : https://www.wowhead.com/wotlk/ru/npc=40125
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 40125;
-- OLD name : Штормградский стражник
-- Source : https://www.wowhead.com/wotlk/ru/npc=40138
UPDATE `creature_template_locale` SET `Name` = '[Stormwind City Guard (Corpse)]' WHERE `locale` = 'ruRU' AND `entry` = 40138;
-- OLD name : Щит Тормуна
-- Source : https://www.wowhead.com/wotlk/ru/npc=40141
UPDATE `creature_template_locale` SET `Name` = '[Tormun''s Shield]' WHERE `locale` = 'ruRU' AND `entry` = 40141;
-- OLD name : Пламенеющий гиппогриф
-- Source : https://www.wowhead.com/wotlk/ru/npc=40165
UPDATE `creature_template_locale` SET `Name` = '[Blazing Hippogryph]' WHERE `locale` = 'ruRU' AND `entry` = 40165;
-- OLD name : Гномреганский механотанк
-- Source : https://www.wowhead.com/wotlk/ru/npc=40175
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Tank]' WHERE `locale` = 'ruRU' AND `entry` = 40175;
-- OLD name : Сен'джинская лягушка
-- Source : https://www.wowhead.com/wotlk/ru/npc=40176
UPDATE `creature_template_locale` SET `Name` = '[Sen''jin Frog]' WHERE `locale` = 'ruRU' AND `entry` = 40176;
-- OLD name : Бвонсамди
-- Source : https://www.wowhead.com/wotlk/ru/npc=40182
UPDATE `creature_template_locale` SET `Name` = '[Bwonsamdi]' WHERE `locale` = 'ruRU' AND `entry` = 40182;
-- OLD name : Ванира
-- Source : https://www.wowhead.com/wotlk/ru/npc=40184
UPDATE `creature_template_locale` SET `Name` = '[Vanira]' WHERE `locale` = 'ruRU' AND `entry` = 40184;
-- OLD name : Сторожевой тотем Ваниры
-- Source : https://www.wowhead.com/wotlk/ru/npc=40187
UPDATE `creature_template_locale` SET `Name` = '[Vanira''s Sentry Totem]' WHERE `locale` = 'ruRU' AND `entry` = 40187;
-- OLD name : Заговоренная лягушка
-- Source : https://www.wowhead.com/wotlk/ru/npc=40188
UPDATE `creature_template_locale` SET `Name` = '[Attuned Frog]' WHERE `locale` = 'ruRU' AND `entry` = 40188;
-- OLD name : Джун'до Предатель
-- Source : https://www.wowhead.com/wotlk/ru/npc=40189
UPDATE `creature_template_locale` SET `Name` = '[Jun''do the Traitor]' WHERE `locale` = 'ruRU' AND `entry` = 40189;
-- OLD name : Белый шерстистый носорог
-- Source : https://www.wowhead.com/wotlk/ru/npc=40191
UPDATE `creature_template_locale` SET `Name` = '[Wooly White Rhino]' WHERE `locale` = 'ruRU' AND `entry` = 40191;
-- OLD name : Ванира
-- Source : https://www.wowhead.com/wotlk/ru/npc=40192
UPDATE `creature_template_locale` SET `Name` = '[Vanira]' WHERE `locale` = 'ruRU' AND `entry` = 40192;
-- OLD name : Безмозглый тролль
-- Source : https://www.wowhead.com/wotlk/ru/npc=40195
UPDATE `creature_template_locale` SET `Name` = '[Mindless Troll]' WHERE `locale` = 'ruRU' AND `entry` = 40195;
-- OLD name : Зен'табра
-- Source : https://www.wowhead.com/wotlk/ru/npc=40196
UPDATE `creature_template_locale` SET `Name` = '[Zen''tabra]' WHERE `locale` = 'ruRU' AND `entry` = 40196;
-- OLD name : Воин Тики
-- Source : https://www.wowhead.com/wotlk/ru/npc=40199
UPDATE `creature_template_locale` SET `Name` = '[Tiki Warrior]' WHERE `locale` = 'ruRU' AND `entry` = 40199;
-- OLD name : Нетопырь-разведчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=40203
UPDATE `creature_template_locale` SET `Name` = '[Recon Bat]' WHERE `locale` = 'ruRU' AND `entry` = 40203;
-- OLD name : Укротитель Марнлек, subname : Дрессировщик нетопырей
-- Source : https://www.wowhead.com/wotlk/ru/npc=40204
UPDATE `creature_template_locale` SET `Name` = '[Handler Marnlek]',`Title` = '[Bat Handler]' WHERE `locale` = 'ruRU' AND `entry` = 40204;
-- OLD name : Зом Боком, subname : Награды за очки чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=40205
UPDATE `creature_template_locale` SET `Name` = '[Zom Bocom]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 40205;
-- OLD name : Большой Зокк Крутируль, subname : Награды за очки завоевания
-- Source : https://www.wowhead.com/wotlk/ru/npc=40206
UPDATE `creature_template_locale` SET `Name` = '[Big Zokk Torquewrench]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 40206;
-- OLD name : Кеззик Гарпунер, subname : Элитные награды за очки завоевания
-- Source : https://www.wowhead.com/wotlk/ru/npc=40207
UPDATE `creature_template_locale` SET `Name` = '[Kezzik the Striker]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 40207;
-- OLD name : Крошка Линни "Улыбайка", subname : Награды за очки чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=40208
UPDATE `creature_template_locale` SET `Name` = '[Leeni "Smiley" Smalls]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 40208;
-- OLD name : Грекс Мозговар, subname : Классические тканевые и кожаные одеяния Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=40209
UPDATE `creature_template_locale` SET `Name` = '[Grex Brainboiler]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'ruRU' AND `entry` = 40209;
-- OLD name : Ксази Смолюга, subname : Награды за очки завоевания
-- Source : https://www.wowhead.com/wotlk/ru/npc=40210
UPDATE `creature_template_locale` SET `Name` = '[Xazi Smolderpipe]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 40210;
-- OLD name : Наргл Гибкошнур, subname : Элитные награды за очки завоевания
-- Source : https://www.wowhead.com/wotlk/ru/npc=40211
UPDATE `creature_template_locale` SET `Name` = '[Nargle Lashcord]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 40211;
-- OLD subname : Старинное оружие арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=40212
UPDATE `creature_template_locale` SET `Title` = 'Исключительное оружие для арены' WHERE `locale` = 'ruRU' AND `entry` = 40212;
-- OLD name : Эктон Меднотумблер, subname : Награды за очки чести
-- Source : https://www.wowhead.com/wotlk/ru/npc=40213
UPDATE `creature_template_locale` SET `Name` = '[Ecton Brasstumbler]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 40213;
-- OLD name : Иви Медипрыг, subname : Награды за очки завоевания
-- Source : https://www.wowhead.com/wotlk/ru/npc=40214
UPDATE `creature_template_locale` SET `Name` = '[Evee Copperspring]',`Title` = '[Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 40214;
-- OLD name : Арджекс Сталежорц, subname : Элитные награды за очки завоевания
-- Source : https://www.wowhead.com/wotlk/ru/npc=40215
UPDATE `creature_template_locale` SET `Name` = '[Argex Irongut]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'ruRU' AND `entry` = 40215;
-- OLD name : Блаззек Кусака, subname : Старинное оружие арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=40216
UPDATE `creature_template_locale` SET `Name` = '[Blazzek the Biter]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'ruRU' AND `entry` = 40216;
-- OLD name : Животное островов Эха
-- Source : https://www.wowhead.com/wotlk/ru/npc=40217
UPDATE `creature_template_locale` SET `Name` = '[Echo Isle Animal]' WHERE `locale` = 'ruRU' AND `entry` = 40217;
-- OLD name : Spy Frog Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=40218
UPDATE `creature_template_locale` SET `Name` = '[Spy Frog Credit]' WHERE `locale` = 'ruRU' AND `entry` = 40218;
-- OLD name : Нетопырь-шпион
-- Source : https://www.wowhead.com/wotlk/ru/npc=40222
UPDATE `creature_template_locale` SET `Name` = '[Scout Bat]' WHERE `locale` = 'ruRU' AND `entry` = 40222;
-- OLD name : Проклятый свирепый тролль
-- Source : https://www.wowhead.com/wotlk/ru/npc=40225
UPDATE `creature_template_locale` SET `Name` = '[Hexed Dire Troll]' WHERE `locale` = 'ruRU' AND `entry` = 40225;
-- OLD name : Проклятый тролль
-- Source : https://www.wowhead.com/wotlk/ru/npc=40231
UPDATE `creature_template_locale` SET `Name` = '[Hexed Troll]' WHERE `locale` = 'ruRU' AND `entry` = 40231;
-- OLD name : Воин Черного Копья
-- Source : https://www.wowhead.com/wotlk/ru/npc=40241
UPDATE `creature_template_locale` SET `Name` = '[Darkspear Warrior]' WHERE `locale` = 'ruRU' AND `entry` = 40241;
-- OLD name : Пьедестал для мгновенного возведения статуй
-- Source : https://www.wowhead.com/wotlk/ru/npc=40246
UPDATE `creature_template_locale` SET `Name` = '[Instant Statue Pedestal]' WHERE `locale` = 'ruRU' AND `entry` = 40246;
-- OLD name : Чемпион Уру'зин
-- Source : https://www.wowhead.com/wotlk/ru/npc=40253
UPDATE `creature_template_locale` SET `Name` = '[Champion Uru''zin]' WHERE `locale` = 'ruRU' AND `entry` = 40253;
-- OLD name : Тролль-горожанин
-- Source : https://www.wowhead.com/wotlk/ru/npc=40256
UPDATE `creature_template_locale` SET `Name` = '[Troll Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 40256;
-- OLD name : Тролль-горожанин
-- Source : https://www.wowhead.com/wotlk/ru/npc=40257
UPDATE `creature_template_locale` SET `Name` = '[Troll Citizen]' WHERE `locale` = 'ruRU' AND `entry` = 40257;
-- OLD name : Тролль-доброволец
-- Source : https://www.wowhead.com/wotlk/ru/npc=40260
UPDATE `creature_template_locale` SET `Name` = '[Troll Volunteer]' WHERE `locale` = 'ruRU' AND `entry` = 40260;
-- OLD name : Воин Тики
-- Source : https://www.wowhead.com/wotlk/ru/npc=40263
UPDATE `creature_template_locale` SET `Name` = '[Tiki Warrior]' WHERE `locale` = 'ruRU' AND `entry` = 40263;
-- OLD name : Тролль-доброволец
-- Source : https://www.wowhead.com/wotlk/ru/npc=40264
UPDATE `creature_template_locale` SET `Name` = '[Troll Volunteer]' WHERE `locale` = 'ruRU' AND `entry` = 40264;
-- OLD name : Беспокойный зомби
-- Source : https://www.wowhead.com/wotlk/ru/npc=40274
UPDATE `creature_template_locale` SET `Name` = '[Restless Zombie]' WHERE `locale` = 'ruRU' AND `entry` = 40274;
-- OLD name : Бвонсамди
-- Source : https://www.wowhead.com/wotlk/ru/npc=40279
UPDATE `creature_template_locale` SET `Name` = '[Bwonsamdi]' WHERE `locale` = 'ruRU' AND `entry` = 40279;
-- OLD name : Болид "Бей-Молоти"
-- Source : https://www.wowhead.com/wotlk/ru/npc=40281
UPDATE `creature_template_locale` SET `Name` = 'Болид Бей-Молоти' WHERE `locale` = 'ruRU' AND `entry` = 40281;
-- OLD name : Синий заводной ракетобот
-- Source : https://www.wowhead.com/wotlk/ru/npc=40295
UPDATE `creature_template_locale` SET `Name` = 'Заводной ракетобот' WHERE `locale` = 'ruRU' AND `entry` = 40295;
-- OLD name : Тигрица-матриарх
-- Source : https://www.wowhead.com/wotlk/ru/npc=40301
UPDATE `creature_template_locale` SET `Name` = '[Tiger Matriarch Credit]' WHERE `locale` = 'ruRU' AND `entry` = 40301;
-- OLD name : Дух тигра
-- Source : https://www.wowhead.com/wotlk/ru/npc=40305
UPDATE `creature_template_locale` SET `Name` = '[Spirit of the Tiger]' WHERE `locale` = 'ruRU' AND `entry` = 40305;
-- OLD name : Тигрица-матриарх
-- Source : https://www.wowhead.com/wotlk/ru/npc=40312
UPDATE `creature_template_locale` SET `Name` = '[Tiger Matriarch]' WHERE `locale` = 'ruRU' AND `entry` = 40312;
-- OLD name : Зен'табра
-- Source : https://www.wowhead.com/wotlk/ru/npc=40329
UPDATE `creature_template_locale` SET `Name` = '[Zen''tabra]' WHERE `locale` = 'ruRU' AND `entry` = 40329;
-- OLD name : Знахарь Хез'ток
-- Source : https://www.wowhead.com/wotlk/ru/npc=40352
UPDATE `creature_template_locale` SET `Name` = '[Witch Doctor Hez''tok]' WHERE `locale` = 'ruRU' AND `entry` = 40352;
-- OLD name : Исполнитель ритуального танца
-- Source : https://www.wowhead.com/wotlk/ru/npc=40356
UPDATE `creature_template_locale` SET `Name` = '[Ritual Dancer]' WHERE `locale` = 'ruRU' AND `entry` = 40356;
-- OLD name : Главный тролль-танцовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=40361
UPDATE `creature_template_locale` SET `Name` = '[Troll Dance Leader]' WHERE `locale` = 'ruRU' AND `entry` = 40361;
-- OLD name : Танцовщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=40363
UPDATE `creature_template_locale` SET `Name` = '[Dance Participant]' WHERE `locale` = 'ruRU' AND `entry` = 40363;
-- OLD name : Останки Залазана
-- Source : https://www.wowhead.com/wotlk/ru/npc=40368
UPDATE `creature_template_locale` SET `Name` = '[Zalazane''s Remains]' WHERE `locale` = 'ruRU' AND `entry` = 40368;
-- OLD name : Ритуалист-барабанщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=40373
UPDATE `creature_template_locale` SET `Name` = '[Ritual Drummer]' WHERE `locale` = 'ruRU' AND `entry` = 40373;
-- OLD name : Голос духов
-- Source : https://www.wowhead.com/wotlk/ru/npc=40374
UPDATE `creature_template_locale` SET `Name` = '[Voice of the Spirits]' WHERE `locale` = 'ruRU' AND `entry` = 40374;
-- OLD name : Omen Event Credit
-- Source : https://www.wowhead.com/wotlk/ru/npc=40387
UPDATE `creature_template_locale` SET `Name` = '[Omen Event Credit]' WHERE `locale` = 'ruRU' AND `entry` = 40387;
-- OLD name : Предок из племени Черного Копья
-- Source : https://www.wowhead.com/wotlk/ru/npc=40388
UPDATE `creature_template_locale` SET `Name` = '[Darkspear Ancestor]' WHERE `locale` = 'ruRU' AND `entry` = 40388;
-- OLD name : Вол'джин
-- Source : https://www.wowhead.com/wotlk/ru/npc=40391
UPDATE `creature_template_locale` SET `Name` = '[Vol''jin]' WHERE `locale` = 'ruRU' AND `entry` = 40391;
-- OLD name : Воин Черного Копья
-- Source : https://www.wowhead.com/wotlk/ru/npc=40392
UPDATE `creature_template_locale` SET `Name` = '[Darkspear Warrior]' WHERE `locale` = 'ruRU' AND `entry` = 40392;
-- OLD name : Тирантий, subname : Питомец Купиды
-- Source : https://www.wowhead.com/wotlk/ru/npc=40404
UPDATE `creature_template_locale` SET `Name` = '[Tyrantus]',`Title` = '[Kieupid''s Pet]' WHERE `locale` = 'ruRU' AND `entry` = 40404;
-- OLD name : Кости Бвонсамди
-- Source : https://www.wowhead.com/wotlk/ru/npc=40414
UPDATE `creature_template_locale` SET `Name` = '[Bones of Bwonsamdi]' WHERE `locale` = 'ruRU' AND `entry` = 40414;
-- OLD name : Нетопырь разведчика
-- Source : https://www.wowhead.com/wotlk/ru/npc=40415
UPDATE `creature_template_locale` SET `Name` = '[Scout''s Bat]' WHERE `locale` = 'ruRU' AND `entry` = 40415;
-- OLD name : Разведчик из племени Черного Копья
-- Source : https://www.wowhead.com/wotlk/ru/npc=40416
UPDATE `creature_template_locale` SET `Name` = '[Darkspear Scout]' WHERE `locale` = 'ruRU' AND `entry` = 40416;
-- OLD name : Тролль-вудуист
-- Source : https://www.wowhead.com/wotlk/ru/npc=40425
UPDATE `creature_template_locale` SET `Name` = '[Voodoo Troll]' WHERE `locale` = 'ruRU' AND `entry` = 40425;
-- OLD name : Коврик из луноткани
-- Source : https://www.wowhead.com/wotlk/ru/npc=40426
UPDATE `creature_template_locale` SET `Name` = '[Tiny Mooncloth Carpet]' WHERE `locale` = 'ruRU' AND `entry` = 40426;
-- OLD name : Плут из Хитрой Шестеренки, subname : Распорядитель подземелий
-- Source : https://www.wowhead.com/wotlk/ru/npc=40438
UPDATE `creature_template_locale` SET `Name` = '[Steamwheedle Shyster]',`Title` = '[Dungeonmaster]' WHERE `locale` = 'ruRU' AND `entry` = 40438;
-- OLD name : Сфера Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=40468
UPDATE `creature_template_locale` SET `Name` = 'Темный шар' WHERE `locale` = 'ruRU' AND `entry` = 40468;
-- OLD name : Сфера Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=40469
UPDATE `creature_template_locale` SET `Name` = 'Темный шар' WHERE `locale` = 'ruRU' AND `entry` = 40469;
-- OLD name : Элджин Щелкуняжка, subname : Ассистентка главного механика
-- Source : https://www.wowhead.com/wotlk/ru/npc=40478
UPDATE `creature_template_locale` SET `Name` = '[Elgin Clickspring]',`Title` = '[High Tinker''s Assistant]' WHERE `locale` = 'ruRU' AND `entry` = 40478;
-- OLD name : Повозка с камерой
-- Source : https://www.wowhead.com/wotlk/ru/npc=40479
UPDATE `creature_template_locale` SET `Name` = '[Camera Vehicle]' WHERE `locale` = 'ruRU' AND `entry` = 40479;
-- OLD name : Веселящийся тролль
-- Source : https://www.wowhead.com/wotlk/ru/npc=40481
UPDATE `creature_template_locale` SET `Name` = '[Troll Celebrant]' WHERE `locale` = 'ruRU' AND `entry` = 40481;
-- OLD name : Зилд'жиан, subname : Боевой барабанщик Вол'джина
-- Source : https://www.wowhead.com/wotlk/ru/npc=40492
UPDATE `creature_template_locale` SET `Name` = '[Zild''jian]',`Title` = '[Vol''jin''s Wardrummer]' WHERE `locale` = 'ruRU' AND `entry` = 40492;
-- OLD name : Залазан
-- Source : https://www.wowhead.com/wotlk/ru/npc=40502
UPDATE `creature_template_locale` SET `Name` = '[Zalazane]' WHERE `locale` = 'ruRU' AND `entry` = 40502;
-- OLD name : Explosion Bunny
-- Source : https://www.wowhead.com/wotlk/ru/npc=40506
UPDATE `creature_template_locale` SET `Name` = '[Explosion Bunny]' WHERE `locale` = 'ruRU' AND `entry` = 40506;
-- OLD name : Рыцарь-лейтенант К'ош Майрс, subname : Начальник снабжения доспехами Нордскола
-- Source : https://www.wowhead.com/wotlk/ru/npc=40606
UPDATE `creature_template_locale` SET `Name` = '[Knight-Lieutenant T''Maire Sydes]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 40606;
-- OLD name : Рыцарь-лейтенант К'ош Майрс, subname : Начальник снабжения доспехами Нордскола
-- Source : https://www.wowhead.com/wotlk/ru/npc=40607
UPDATE `creature_template_locale` SET `Name` = '[Knight-Lieutenant T''Maire Sydes]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'ruRU' AND `entry` = 40607;
-- OLD name : Небесный скакун
-- Source : https://www.wowhead.com/wotlk/ru/npc=40625
UPDATE `creature_template_locale` SET `Name` = '[Celestial Steed]' WHERE `locale` = 'ruRU' AND `entry` = 40625;
-- OLD name : Рубиновый дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=40627
UPDATE `creature_template_locale` SET `Name` = 'Рубиновый дракончик' WHERE `locale` = 'ruRU' AND `entry` = 40627;
-- OLD name : Врайкульский верховой протодракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=40704
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Proto-dragon Mount]' WHERE `locale` = 'ruRU' AND `entry` = 40704;
-- OLD name : Ремеслий Джонс, subname : Не вызывать
-- Source : https://www.wowhead.com/wotlk/ru/npc=40724
UPDATE `creature_template_locale` SET `Name` = '[Crafticus Jones]',`Title` = '[Do Not Spawn]' WHERE `locale` = 'ruRU' AND `entry` = 40724;
-- OLD name : Прогулочная ракета X-53
-- Source : https://www.wowhead.com/wotlk/ru/npc=40725
UPDATE `creature_template_locale` SET `Name` = '[X-53 Touring Rocket]' WHERE `locale` = 'ruRU' AND `entry` = 40725;
-- OLD name : Рубиновый дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=40842
UPDATE `creature_template_locale` SET `Name` = '[Ruby Drake]' WHERE `locale` = 'ruRU' AND `entry` = 40842;
