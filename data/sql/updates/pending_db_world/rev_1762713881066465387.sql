-- Update ruRU ; from WowHead WOTLK+ / Retail
-- OLD name : Никудышный шаромыжник
-- Source : https://www.wowhead.com/wotlk/ru/npc=38
UPDATE `creature_template_locale` SET `Name` = 'Лиходей из Братства Справедливости' WHERE `locale` = 'ruRU' AND `entry` = 38;
-- OLD name : Младший суккуб
-- Source : https://www.wowhead.com/wotlk/ru/npc=49
UPDATE `creature_template_locale` SET `Name` = 'Малый суккуб' WHERE `locale` = 'ruRU' AND `entry` = 49;
-- OLD subname : Оружейник
-- Source : https://www.wowhead.com/wotlk/ru/npc=54
UPDATE `creature_template_locale` SET `Title` = 'Оружейница' WHERE `locale` = 'ruRU' AND `entry` = 54;
-- OLD name : [UNUSED] Луглар Топотун (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=81
UPDATE `creature_template_locale` SET `Name` = 'Праздник – Тыквовин – гарнизон – призрачный хмелементаль' WHERE `locale` = 'ruRU' AND `entry` = 81;
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
-- OLD name : Чуббс (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=444
UPDATE `creature_template_locale` SET `Name` = 'Лорд Поросенок' WHERE `locale` = 'ruRU' AND `entry` = 444;
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
-- OLD subname : Fletching Supplies
-- Source : https://www.wowhead.com/wotlk/ru/npc=1455
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 1455;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (1455, 'ruRU',NULL,'Припасы для стрелков');
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
-- OLD subname : Cook
-- Source : https://www.wowhead.com/wotlk/ru/npc=1677
UPDATE `creature_template_locale` SET `Title` = 'Повар' WHERE `locale` = 'ruRU' AND `entry` = 1677;
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
-- OLD subname : Blacksmith Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=2220
UPDATE `creature_template_locale` SET `Title` = 'Учитель кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 2220;
-- OLD subname : Cooking Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=2223
UPDATE `creature_template_locale` SET `Title` = 'Учитель кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 2223;
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
-- OLD subname : Целитель душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=2815
UPDATE `creature_template_locale` SET `Title` = 'Целительница душ' WHERE `locale` = 'ruRU' AND `entry` = 2815;
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
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/ru/npc=2935
UPDATE `creature_template_locale` SET `Title` = 'Наставник демонов' WHERE `locale` = 'ruRU' AND `entry` = 2935;
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
-- OLD subname : Учитель подмастерьев алхимиков
-- Source : https://www.wowhead.com/wotlk/ru/npc=3070
UPDATE `creature_template_locale` SET `Title` = 'Алхимик *модель отсутствует*' WHERE `locale` = 'ruRU' AND `entry` = 3070;
-- OLD subname : Учитель травничества
-- Source : https://www.wowhead.com/wotlk/ru/npc=3071
UPDATE `creature_template_locale` SET `Title` = 'Травник <модель отсутствует>' WHERE `locale` = 'ruRU' AND `entry` = 3071;
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
-- OLD subname : Целитель душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=3303
UPDATE `creature_template_locale` SET `Title` = 'Целительница душ' WHERE `locale` = 'ruRU' AND `entry` = 3303;
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
-- OLD name : Принцесса Приливов из клана Зловещего Хвоста (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=3718
UPDATE `creature_template_locale` SET `Name` = 'Принцесса приливов из клана Зловещего Хвоста' WHERE `locale` = 'ruRU' AND `entry` = 3718;
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
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'ruRU' AND `entry` = 4045;
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
-- Source : https://www.wowhead.com/wotlk/ru/npc=4318
UPDATE `creature_template_locale` SET `Title` = 'Целительница душ' WHERE `locale` = 'ruRU' AND `entry` = 4318;
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
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=4579
UPDATE `creature_template_locale` SET `Title` = 'Учитель картографии' WHERE `locale` = 'ruRU' AND `entry` = 4579;
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
-- OLD subname : Торговец хлебом
-- Source : https://www.wowhead.com/wotlk/ru/npc=5131
UPDATE `creature_template_locale` SET `Title` = 'Торговка хлебом' WHERE `locale` = 'ruRU' AND `entry` = 5131;
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
-- OLD subname : Продавец гербовых накидок
-- Source : https://www.wowhead.com/wotlk/ru/npc=5192
UPDATE `creature_template_locale` SET `Title` = 'Торговец гербовыми накидками' WHERE `locale` = 'ruRU' AND `entry` = 5192;
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
-- OLD subname : Торговец легкими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=5813
UPDATE `creature_template_locale` SET `Title` = 'Торговка легкими доспехами' WHERE `locale` = 'ruRU' AND `entry` = 5813;
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
-- OLD name : [UNUSED] Лорек Белм (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=6783
UPDATE `creature_template_locale` SET `Name` = 'Gorgrond Smokebelcher Depot NPC Invisible Stalker "Our Gun''s Bigger" Quest Target ELM' WHERE `locale` = 'ruRU' AND `entry` = 6783;
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
-- OLD name : Йор, subname : NONE
-- Source : https://www.wowhead.com/wotlk/ru/npc=10237
UPDATE `creature_template_locale` SET `Name` = 'Yor',`Title` = 'UNUSED' WHERE `locale` = 'ruRU' AND `entry` = 10237;
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
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=10446
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по арбалетам' WHERE `locale` = 'ruRU' AND `entry` = 10446;
-- OLD subname : Учитель владения мечами
-- Source : https://www.wowhead.com/wotlk/ru/npc=10448
UPDATE `creature_template_locale` SET `Title` = 'Учительница владения мечами' WHERE `locale` = 'ruRU' AND `entry` = 10448;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/ru/npc=10450
UPDATE `creature_template_locale` SET `Title` = 'Эксперт по арбалетам' WHERE `locale` = 'ruRU' AND `entry` = 10450;
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
-- OLD subname : Укротитель ветрокрылов
-- Source : https://www.wowhead.com/wotlk/ru/npc=14242
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 14242;
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
-- OLD name : Blue Qiraji Battle Tank (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=15713
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 15713;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15713, 'ruRU','NPC',NULL);
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
-- OLD name : [UNUSED] Болотная тварь B [PH]
-- Source : https://www.wowhead.com/wotlk/ru/npc=16035
UPDATE `creature_template_locale` SET `Name` = 'Bog Beast B [PH]' WHERE `locale` = 'ruRU' AND `entry` = 16035;
-- OLD name : [UNUSED] Гончая Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=16038
UPDATE `creature_template_locale` SET `Name` = 'Гончая Смерти' WHERE `locale` = 'ruRU' AND `entry` = 16038;
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
-- OLD name : [UNUSED] Воздаятель-рыцарь смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=16451
UPDATE `creature_template_locale` SET `Name` = 'Рыцарь смерти - воздаятель' WHERE `locale` = 'ruRU' AND `entry` = 16451;
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
-- OLD name : [UNUSED] Владыка Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=16861
UPDATE `creature_template_locale` SET `Name` = 'Владыка смерти' WHERE `locale` = 'ruRU' AND `entry` = 16861;
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
-- OLD name : [UNUSED] Lykul Larva (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=17733
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 17733;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (17733, 'ruRU','NPC',NULL);
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
-- OLD subname : Питомец Владыки болот Мусел'ека
-- Source : https://www.wowhead.com/wotlk/ru/npc=17828
UPDATE `creature_template_locale` SET `Title` = 'Питомец владыки болот Мусел''ека' WHERE `locale` = 'ruRU' AND `entry` = 17828;
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
-- OLD name : [DND]Sunhawk Portal Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=17886
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 17886;
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
-- OLD name : Нораани, subname : Торговец реагентами
-- Source : https://www.wowhead.com/wotlk/ru/npc=18006
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 18006;
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
-- OLD name : [UNUSED]Анахорет Литеера
-- Source : https://www.wowhead.com/wotlk/ru/npc=18674
UPDATE `creature_template_locale` SET `Name` = 'Анахоретка Литира' WHERE `locale` = 'ruRU' AND `entry` = 18674;
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
-- OLD name : Центурион лагеря Затмения
-- Source : https://www.wowhead.com/wotlk/ru/npc=19792
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 19792;
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
-- OLD name : [DND]Kaliri Aura Dispel (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=21511
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 21511;
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
-- OLD name : [DND]Mok'Nathal Wand 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=21713
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 21713;
-- OLD name : [DND]Mok'Nathal Wand 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=21714
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 21714;
-- OLD name : [DND]Mok'Nathal Wand 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=21715
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 21715;
-- OLD name : [DND]Mok'Nathal Wand 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=21716
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 21716;
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
-- OLD name : [DND]Spirit 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22023
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22023;
-- OLD name : [ph] cave ant [not used] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22048
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22048;
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
-- OLD name : [DND]Whisper Spying Credit Marker 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22116
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22116;
-- OLD name : [DND]Whisper Spying Credit Marker 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22117
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22117;
-- OLD name : [DND]Whisper Spying Credit Marker 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22118
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22118;
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
-- OLD name : [DND]Green Spot Grog Keg Relay (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22349
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22349;
-- OLD name : [DND]Green Spot Grog Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22356
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22356;
-- OLD name : [DND]Ripe Moonshine Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22367
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22367;
-- OLD name : [DND]Fermented Seed Beer Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22368
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22368;
-- OLD name : Прислужник Террока
-- Source : https://www.wowhead.com/wotlk/ru/npc=22376
UPDATE `creature_template_locale` SET `Name` = 'Прислужник Терокка' WHERE `locale` = 'ruRU' AND `entry` = 22376;
-- OLD name : Паразит Змеиного Святилища
-- Source : https://www.wowhead.com/wotlk/ru/npc=22379
UPDATE `creature_template_locale` SET `Name` = 'Паразит из Змеиного святилища' WHERE `locale` = 'ruRU' AND `entry` = 22379;
-- OLD name : [DND]Bloodmaul Chatter Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22383
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22383;
-- OLD name : Коготарь Литика
-- Source : https://www.wowhead.com/wotlk/ru/npc=22388
UPDATE `creature_template_locale` SET `Name` = 'Коготарь Литик' WHERE `locale` = 'ruRU' AND `entry` = 22388;
-- OLD name : [DND]Ogre Pike Planted Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22434
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22434;
-- OLD name : [DND]Rexxar's Wyvern Freed Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22435
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22435;
-- OLD subname : Владелец академии разбойников
-- Source : https://www.wowhead.com/wotlk/ru/npc=22442
UPDATE `creature_template_locale` SET `Title` = 'Владелица академии разбойников' WHERE `locale` = 'ruRU' AND `entry` = 22442;
-- OLD name : Пушка Скверны Дверей Смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=22443
UPDATE `creature_template_locale` SET `Name` = 'Пушка Скверны Врат Смерти' WHERE `locale` = 'ruRU' AND `entry` = 22443;
-- OLD name : [DND]Sablemane's Trap Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22447
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22447;
-- OLD name : Ученый из Лиги исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=22464
UPDATE `creature_template_locale` SET `Name` = 'Ученый Лиги исследователей' WHERE `locale` = 'ruRU' AND `entry` = 22464;
-- OLD name : Часовой Шептунья Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=22488
UPDATE `creature_template_locale` SET `Name` = 'Часовая Шепот Луны' WHERE `locale` = 'ruRU' AND `entry` = 22488;
-- OLD name : [DND]Prophecy 1 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22798
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22798;
-- OLD name : [DND]Prophecy 2 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22799
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22799;
-- OLD name : [DND]Prophecy 3 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22800
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22800;
-- OLD name : [DND]Prophecy 4 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=22801
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 22801;
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
-- OLD name : Укротитель из Стражи Небес
-- Source : https://www.wowhead.com/wotlk/ru/npc=23016
UPDATE `creature_template_locale` SET `Name` = 'Укротительница из Стражи Небес' WHERE `locale` = 'ruRU' AND `entry` = 23016;
-- OLD name : Псарь клана Призрачной Луны
-- Source : https://www.wowhead.com/wotlk/ru/npc=23018
UPDATE `creature_template_locale` SET `Name` = 'Псарь из клана Призрачной Луны' WHERE `locale` = 'ruRU' AND `entry` = 23018;
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
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23548
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 23548;
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
-- OLD name : [PH] Зазывала Ярмарки Новолуния, ВНЕШНОСТЬ A (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=23629
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'ruRU' AND `entry` = 23629;
-- OLD name : [PH] Зазывала Ярмарки Новолуния, ВНЕШНОСТЬ B (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=23630
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'ruRU' AND `entry` = 23630;
-- OLD name : [PH] Зазывала Ярмарки Новолуния, ВНЕШНОСТЬ С (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=23631
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'ruRU' AND `entry` = 23631;
-- OLD name : [PH] Зазывала Ярмарки Новолуния, ВНЕШНОСТЬ D (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=23632
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'ruRU' AND `entry` = 23632;
-- OLD name : [PH] Зазывала Ярмарки Новолуния, ВНЕШНОСТЬ E (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=23633
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'ruRU' AND `entry` = 23633;
-- OLD name : [PH] Зазывала Ярмарки Новолуния, ВНЕШНОСТЬ F (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=23634
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'ruRU' AND `entry` = 23634;
-- OLD name : [DND] Brewfest Dark Iron Event Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=23703
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 23703;
-- OLD name : Clayton's Test Creature (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=23715
UPDATE `creature_template_locale` SET `Name` = 'Clayton''s Test Creature (2)' WHERE `locale` = 'ruRU' AND `entry` = 23715;
-- OLD name : Каменный лорд (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=23726
UPDATE `creature_template_locale` SET `Name` = 'Каменный владыка' WHERE `locale` = 'ruRU' AND `entry` = 23726;
-- OLD name : Трактирщица Хейзел Лаграс
-- Source : https://www.wowhead.com/wotlk/ru/npc=23731
UPDATE `creature_template_locale` SET `Name` = 'Хозяйка таверны Хейзел Лаграс' WHERE `locale` = 'ruRU' AND `entry` = 23731;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=23734
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 23734;
-- OLD name : Штейгер Майлз Макмади
-- Source : https://www.wowhead.com/wotlk/ru/npc=23738
UPDATE `creature_template_locale` SET `Name` = 'Старшина Майлз МакМуди' WHERE `locale` = 'ruRU' AND `entry` = 23738;
-- OLD name : Молодой протодракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=23750
UPDATE `creature_template_locale` SET `Name` = 'Детеныш протодракона' WHERE `locale` = 'ruRU' AND `entry` = 23750;
-- OLD name : Акула-молот бухты Кинжалов
-- Source : https://www.wowhead.com/wotlk/ru/npc=23785
UPDATE `creature_template_locale` SET `Name` = 'Рыба-молот бухты Кинжалов' WHERE `locale` = 'ruRU' AND `entry` = 23785;
-- OLD name : [DND] Brewfest Keg Move to Target (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=23808
UPDATE `creature_template_locale` SET `Name` = 'Бочонок Хмельного фестиваля - передвинуть к цели' WHERE `locale` = 'ruRU' AND `entry` = 23808;
-- OLD name : [DND] L70ETC FX Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=23830
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 23830;
-- OLD name : [DND] L70ETC Bergrisst Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=23845
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 23845;
-- OLD name : [DND] L70ETC Concert Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=23850
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 23850;
-- OLD name : [DND] L70ETC Mai'Kyl Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=23852
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 23852;
-- OLD name : [DND] L70ETC Samuro Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=23853
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 23853;
-- OLD name : [DND] L70ETC Sig Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=23854
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 23854;
-- OLD name : [DND] L70ETC Chief Thunder-Skins Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=23855
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 23855;
-- OLD name : Отрекшийся-арбалетчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=23883
UPDATE `creature_template_locale` SET `Name` = 'Лучник-Отрекшийся' WHERE `locale` = 'ruRU' AND `entry` = 23883;
-- OLD name : [DND] Brewfest Dark Iron Spawn Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=23894
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 23894;
-- OLD subname : Рыбная ловля: обучение и снасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=23896
UPDATE `creature_template_locale` SET `Title` = 'Торговец рыбой' WHERE `locale` = 'ruRU' AND `entry` = 23896;
-- OLD name : Трактирщица Селеста Доброклад
-- Source : https://www.wowhead.com/wotlk/ru/npc=23937
UPDATE `creature_template_locale` SET `Name` = 'Хозяйка таверны Селеста Доброклад' WHERE `locale` = 'ruRU' AND `entry` = 23937;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23967
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 23967;
-- OLD name : Торелий Мудрый
-- Source : https://www.wowhead.com/wotlk/ru/npc=23975
UPDATE `creature_template_locale` SET `Name` = 'Торалиус Мудрый' WHERE `locale` = 'ruRU' AND `entry` = 23975;
-- OLD name : Груженый мул Лиги исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=23984
UPDATE `creature_template_locale` SET `Name` = 'Груженый мул Лиги Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 23984;
-- OLD name : Ловчий смерти Разаэль
-- Source : https://www.wowhead.com/wotlk/ru/npc=23998
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти Разаэль' WHERE `locale` = 'ruRU' AND `entry` = 23998;
-- OLD name : Строитель баррикад
-- Source : https://www.wowhead.com/wotlk/ru/npc=24005
UPDATE `creature_template_locale` SET `Name` = 'Мельничный работник' WHERE `locale` = 'ruRU' AND `entry` = 24005;
-- OLD name : Некровладыка Мезхен
-- Source : https://www.wowhead.com/wotlk/ru/npc=24018
UPDATE `creature_template_locale` SET `Name` = 'Некро-владыка Мезхен' WHERE `locale` = 'ruRU' AND `entry` = 24018;
-- OLD name : Зловещий призыватель драконов
-- Source : https://www.wowhead.com/wotlk/ru/npc=24029
UPDATE `creature_template_locale` SET `Name` = 'Зловещий призыватель змей' WHERE `locale` = 'ruRU' AND `entry` = 24029;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24048
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24048;
-- OLD name : Чудовищный ужас
-- Source : https://www.wowhead.com/wotlk/ru/npc=24073
UPDATE `creature_template_locale` SET `Name` = 'Кошмарный ужас' WHERE `locale` = 'ruRU' AND `entry` = 24073;
-- OLD name : [DND] Brewfest Target Dummy Move To Target (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=24109
UPDATE `creature_template_locale` SET `Name` = 'Brewfest Target Dummy Move To Target' WHERE `locale` = 'ruRU' AND `entry` = 24109;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24122
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24122;
-- OLD name : Хранитель душ Зловещего Тотема
-- Source : https://www.wowhead.com/wotlk/ru/npc=24133
UPDATE `creature_template_locale` SET `Name` = 'Хранитель душ из племени Зловещего Тотема' WHERE `locale` = 'ruRU' AND `entry` = 24133;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24145
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24145;
-- OLD subname : Яды
-- Source : https://www.wowhead.com/wotlk/ru/npc=24148
UPDATE `creature_template_locale` SET `Title` = 'Торговец ядами' WHERE `locale` = 'ruRU' AND `entry` = 24148;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24150
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24150;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24151
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24151;
-- OLD name : [DND] Darkmoon Faire Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24171
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24171;
-- OLD name : [UNUSED] Привидение исследователя Джарена (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=24181
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge B' WHERE `locale` = 'ruRU' AND `entry` = 24181;
-- OLD name : [DND] Brewfest Barker Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24202
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24202;
-- OLD name : [DND] Brewfest Barker Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24203
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24203;
-- OLD name : [DND] Brewfest Barker Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24204
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24204;
-- OLD name : [DND] Brewfest Barker Bunny 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24205
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24205;
-- OLD name : Войско мертвых
-- Source : https://www.wowhead.com/wotlk/ru/npc=24207
UPDATE `creature_template_locale` SET `Name` = 'Вурдалак из войска мертвых' WHERE `locale` = 'ruRU' AND `entry` = 24207;
-- OLD name : [DND] Darkmoon Faire Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24220
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24220;
-- OLD name : [DND] Brewfest Speed Bunny Green (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24263
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24263;
-- OLD name : [DND] Brewfest Speed Bunny Yellow (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24264
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24264;
-- OLD name : [DND] Brewfest Speed Bunny Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24265
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24265;
-- OLD name : Древний врайкул
-- Source : https://www.wowhead.com/wotlk/ru/npc=24314
UPDATE `creature_template_locale` SET `Name` = 'Древний мужчина-врайкул' WHERE `locale` = 'ruRU' AND `entry` = 24314;
-- OLD name : Страж смерти Аптекарского поселка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24317
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти-экспедитор' WHERE `locale` = 'ruRU' AND `entry` = 24317;
-- OLD name : Валь'кира-похитительница душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=24327
UPDATE `creature_template_locale` SET `Name` = 'Валь''кира-душекрад' WHERE `locale` = 'ruRU' AND `entry` = 24327;
-- OLD name : Джейсон Доброклад, subname : Бармен
-- Source : https://www.wowhead.com/wotlk/ru/npc=24333
UPDATE `creature_template_locale` SET `Name` = 'Бармен Джейсон Доброклад',`Title` = 'Напитки' WHERE `locale` = 'ruRU' AND `entry` = 24333;
-- OLD name : [DND] Brewfest Delivery Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24337
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24337;
-- OLD name : Барнабас Фрай
-- Source : https://www.wowhead.com/wotlk/ru/npc=24341
UPDATE `creature_template_locale` SET `Name` = 'Барбанас Фрай' WHERE `locale` = 'ruRU' AND `entry` = 24341;
-- OLD name : Труп Харрисона
-- Source : https://www.wowhead.com/wotlk/ru/npc=24365
UPDATE `creature_template_locale` SET `Name` = 'Труп Вилли' WHERE `locale` = 'ruRU' AND `entry` = 24365;
-- OLD name : [UNUSED]Vazruden Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=24377
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge C' WHERE `locale` = 'ruRU' AND `entry` = 24377;
-- OLD name : [UNUSED]Nazan Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=24378
UPDATE `creature_template_locale` SET `Name` = '"Back To Bladespire Fortress" Flight Kill Credit' WHERE `locale` = 'ruRU' AND `entry` = 24378;
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
-- OLD name : Невидимый человек - без оружия (только сервер/скрыть тело)
-- Source : https://www.wowhead.com/wotlk/ru/npc=24417
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 24417;
-- OLD name : Проекция разрушителя Бурегорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=24432
UPDATE `creature_template_locale` SET `Name` = 'Проекция разрушителя из кузни бурь' WHERE `locale` = 'ruRU' AND `entry` = 24432;
-- OLD subname : Лунная пыль
-- Source : https://www.wowhead.com/wotlk/ru/npc=24456
UPDATE `creature_template_locale` SET `Title` = '"Лунная пыль"' WHERE `locale` = 'ruRU' AND `entry` = 24456;
-- OLD name : Пламя горна
-- Source : https://www.wowhead.com/wotlk/ru/npc=24471
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 24471;
-- OLD subname : Главный археолог экспедиции
-- Source : https://www.wowhead.com/wotlk/ru/npc=24473
UPDATE `creature_template_locale` SET `Title` = 'Главный архелог экспедиции' WHERE `locale` = 'ruRU' AND `entry` = 24473;
-- OLD name : Ассасин из Лагеря Возмездия
-- Source : https://www.wowhead.com/wotlk/ru/npc=24474
UPDATE `creature_template_locale` SET `Name` = 'Асассин из Лагеря Возмездия' WHERE `locale` = 'ruRU' AND `entry` = 24474;
-- OLD name : Вор Синдиката
-- Source : https://www.wowhead.com/wotlk/ru/npc=24477
UPDATE `creature_template_locale` SET `Name` = 'Вор из Синдиката' WHERE `locale` = 'ruRU' AND `entry` = 24477;
-- OLD name : Моджо
-- Source : https://www.wowhead.com/wotlk/ru/npc=24480
UPDATE `creature_template_locale` SET `Name` = 'Вудуистский амулет' WHERE `locale` = 'ruRU' AND `entry` = 24480;
-- OLD name : Страж смерти Флоренс
-- Source : https://www.wowhead.com/wotlk/ru/npc=24491
UPDATE `creature_template_locale` SET `Name` = 'Стражница смерти Флоренс' WHERE `locale` = 'ruRU' AND `entry` = 24491;
-- OLD subname : Продавец алкогольных напитков винокурни Дрона
-- Source : https://www.wowhead.com/wotlk/ru/npc=24501
UPDATE `creature_template_locale` SET `Title` = 'Торговец напитками винокурни Дрона' WHERE `locale` = 'ruRU' AND `entry` = 24501;
-- OLD subname : Продавец напитков Громоваров
-- Source : https://www.wowhead.com/wotlk/ru/npc=24545
UPDATE `creature_template_locale` SET `Title` = 'Торговец напитками Громоваров' WHERE `locale` = 'ruRU' AND `entry` = 24545;
-- OLD name : [UNUSED] Riplash Flayer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24575
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24575;
-- OLD name : [UNUSED] Riplash Tidehunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24577
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24577;
-- OLD name : [UNUSED] Riplash Serpent Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24578
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24578;
-- OLD name : [UNUSED] Riplash Tidelord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24579
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24579;
-- OLD name : [UNUSED] Tundra Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24617
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24617;
-- OLD name : [UNUSED] Tundra Wolf Alpha (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24620
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24620;
-- OLD name : [UNUSED] Riplash Hydra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24661
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24661;
-- OLD name : Лейтенант Ледяной Молот
-- Source : https://www.wowhead.com/wotlk/ru/npc=24665
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 24665;
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
-- OLD name : [UNUSED] Brightscale Serpent (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=24692
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24692;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (24692, 'ruRU',NULL,NULL);
-- OLD name : [UNUSED] Arcane Nightmare (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=24693
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24693;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (24693, 'ruRU',NULL,NULL);
-- OLD name : [UNUSED] Nether Shade (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=24695
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24695;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (24695, 'ruRU',NULL,NULL);
-- OLD name : [UNUSED] Sargeron Trickster (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=24699
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24699;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (24699, 'ruRU',NULL,NULL);
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
-- OLD name : Хранитель из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24762
UPDATE `creature_template_locale` SET `Name` = 'Хранитель Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 24762;
-- OLD name : [DND] Brewfest Face Me Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24766
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24766;
-- OLD name : Ловчий смерти Хейвард
-- Source : https://www.wowhead.com/wotlk/ru/npc=24768
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти Хейвард' WHERE `locale` = 'ruRU' AND `entry` = 24768;
-- OLD name : Часовой из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=24777
UPDATE `creature_template_locale` SET `Name` = 'Часовой Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 24777;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24807
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24807;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=24811
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 24811;
-- OLD name : Скакун Всадника без головы
-- Source : https://www.wowhead.com/wotlk/ru/npc=24814
UPDATE `creature_template_locale` SET `Name` = 'Верховое животное Всадника без головы' WHERE `locale` = 'ruRU' AND `entry` = 24814;
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
-- OLD name : Пиратка из Братства Справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=24860
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 24860;
-- OLD name : Вражеский отчаянный противник из Халаа
-- Source : https://www.wowhead.com/wotlk/ru/npc=24867
UPDATE `creature_template_locale` SET `Name` = 'Противник из Халаа' WHERE `locale` = 'ruRU' AND `entry` = 24867;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=24868
UPDATE `creature_template_locale` SET `Title` = 'Учитель мастеров инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 24868;
-- OLD subname : Смотритель стойл
-- Source : https://www.wowhead.com/wotlk/ru/npc=24905
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 24905;
-- OLD name : [PH]Avalanche (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=24912
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 24912;
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
-- OLD subname : Повелительница рыцарей крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=25246
UPDATE `creature_template_locale` SET `Title` = 'Матриарх рыцарей крови' WHERE `locale` = 'ruRU' AND `entry` = 25246;
-- OLD subname : Учитель начертания (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=25263
UPDATE `creature_template_locale` SET `Title` = 'Учительница начертания' WHERE `locale` = 'ruRU' AND `entry` = 25263;
-- OLD subname : Учитель инженерного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=25277
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер инженерного дела' WHERE `locale` = 'ruRU' AND `entry` = 25277;
-- OLD name : Штейгер Мортий
-- Source : https://www.wowhead.com/wotlk/ru/npc=25280
UPDATE `creature_template_locale` SET `Name` = 'Штейгер Мортуус' WHERE `locale` = 'ruRU' AND `entry` = 25280;
-- OLD name : Деревянный манекен
-- Source : https://www.wowhead.com/wotlk/ru/npc=25297
UPDATE `creature_template_locale` SET `Name` = 'Тренировочный манекен' WHERE `locale` = 'ruRU' AND `entry` = 25297;
-- OLD name : Ружейник Крепости Отваги
-- Source : https://www.wowhead.com/wotlk/ru/npc=25311
UPDATE `creature_template_locale` SET `Name` = 'Ружейник из крепости Отваги' WHERE `locale` = 'ruRU' AND `entry` = 25311;
-- OLD name : Craig Steele, subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/ru/npc=25323
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25323;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25323, 'ruRU','Крейг Стииле','Программер');
-- OLD name : Обжора Трупомол
-- Source : https://www.wowhead.com/wotlk/ru/npc=25329
UPDATE `creature_template_locale` SET `Name` = 'Крушитель Грек''лор' WHERE `locale` = 'ruRU' AND `entry` = 25329;
-- OLD name : Шитый ужас клана Песни Войны
-- Source : https://www.wowhead.com/wotlk/ru/npc=25332
UPDATE `creature_template_locale` SET `Name` = 'Лоскутный ужас клана Песни Войны' WHERE `locale` = 'ruRU' AND `entry` = 25332;
-- OLD name : Рубака Десница Гнева
-- Source : https://www.wowhead.com/wotlk/ru/npc=25336
UPDATE `creature_template_locale` SET `Name` = 'Рубака Гневная Длань' WHERE `locale` = 'ruRU' AND `entry` = 25336;
-- OLD name : Боевой маг Анзим
-- Source : https://www.wowhead.com/wotlk/ru/npc=25356
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Анзим' WHERE `locale` = 'ruRU' AND `entry` = 25356;
-- OLD name : Кабалист из клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25363
UPDATE `creature_template_locale` SET `Name` = 'Кабалист Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25363;
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
-- OLD name : Магмотский тотем огня
-- Source : https://www.wowhead.com/wotlk/ru/npc=25444
UPDATE `creature_template_locale` SET `Name` = 'Тотем огня магмота' WHERE `locale` = 'ruRU' AND `entry` = 25444;
-- OLD name : Чудесный ковер-самолет
-- Source : https://www.wowhead.com/wotlk/ru/npc=25460
UPDATE `creature_template_locale` SET `Name` = 'Великолепный ковер-самолет' WHERE `locale` = 'ruRU' AND `entry` = 25460;
-- OLD name : Солдат Ледяных Пустошей (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=25463
UPDATE `creature_template_locale` SET `Name` = 'Солдат ледяных пустошей' WHERE `locale` = 'ruRU' AND `entry` = 25463;
-- OLD name : Заступник клана Солнечного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=25507
UPDATE `creature_template_locale` SET `Name` = 'Заступник Солнечного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 25507;
-- OLD name : [DNT] Torch Tossing Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=25535
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25535;
-- OLD name : [DNT] Torch Tossing Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=25536
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25536;
-- OLD name : Craig's Test Human A
-- Source : https://www.wowhead.com/wotlk/ru/npc=25537
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25537;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25537, 'ruRU','Craig''s Test Human',NULL);
-- OLD name : Бонкер Тумблервольт
-- Source : https://www.wowhead.com/wotlk/ru/npc=25589
UPDATE `creature_template_locale` SET `Name` = 'Бонкер Тумблевольт' WHERE `locale` = 'ruRU' AND `entry` = 25589;
-- OLD name : Red Drake (Speed Mount)
-- Source : https://www.wowhead.com/wotlk/ru/npc=25695
UPDATE `creature_template_locale` SET `Name` = 'Красный дракон' WHERE `locale` = 'ruRU' AND `entry` = 25695;
-- OLD name : Жаркий сполох
-- Source : https://www.wowhead.com/wotlk/ru/npc=25706
UPDATE `creature_template_locale` SET `Name` = 'Сполох' WHERE `locale` = 'ruRU' AND `entry` = 25706;
-- OLD name : Чароплет Хладарры
-- Source : https://www.wowhead.com/wotlk/ru/npc=25719
UPDATE `creature_template_locale` SET `Name` = 'Чародей Хладарры' WHERE `locale` = 'ruRU' AND `entry` = 25719;
-- OLD name : Чаровяз Хладарры
-- Source : https://www.wowhead.com/wotlk/ru/npc=25722
UPDATE `creature_template_locale` SET `Name` = 'Чароплет Хладарры' WHERE `locale` = 'ruRU' AND `entry` = 25722;
-- OLD name : [ph] Coldarra Blue Dragon Patroller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=25723
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25723;
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
-- OLD name : [PH] Ahune Summon Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=25745
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25745;
-- OLD name : [PH] Ahune Loot Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=25746
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 25746;
-- OLD name : Механогном со станции Выкрутеня
-- Source : https://www.wowhead.com/wotlk/ru/npc=25814
UPDATE `creature_template_locale` SET `Name` = 'Мехагном со станции Выкрутеня' WHERE `locale` = 'ruRU' AND `entry` = 25814;
-- OLD name : Перепрограммированный караульный робот 57-K
-- Source : https://www.wowhead.com/wotlk/ru/npc=25823
UPDATE `creature_template_locale` SET `Name` = 'Перепрограммированный часовобот 57-K' WHERE `locale` = 'ruRU' AND `entry` = 25823;
-- OLD name : Дите Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=25824
UPDATE `creature_template_locale` SET `Name` = 'Дитя Бездны' WHERE `locale` = 'ruRU' AND `entry` = 25824;
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
-- OLD name : Craig's Test Human B (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26080
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26080;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26080, 'ruRU','NPC',NULL);
-- OLD name : Отдыхающий боевой страж
-- Source : https://www.wowhead.com/wotlk/ru/npc=26109
UPDATE `creature_template_locale` SET `Name` = 'Свободный боевой страж' WHERE `locale` = 'ruRU' AND `entry` = 26109;
-- OLD name : Храбрец Таунка'ле
-- Source : https://www.wowhead.com/wotlk/ru/npc=26157
UPDATE `creature_template_locale` SET `Name` = 'Храбрец таунка''ле' WHERE `locale` = 'ruRU' AND `entry` = 26157;
-- OLD name : Кодо из каравана Таунка'ле
-- Source : https://www.wowhead.com/wotlk/ru/npc=26160
UPDATE `creature_template_locale` SET `Name` = 'Кодо из каравана таунка''ле' WHERE `locale` = 'ruRU' AND `entry` = 26160;
-- OLD name : [PH] Torch Catching Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26188
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26188;
-- OLD name : [PH] Spank Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26190
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26190;
-- OLD name : Ракета Пустоты X-51
-- Source : https://www.wowhead.com/wotlk/ru/npc=26192
UPDATE `creature_template_locale` SET `Name` = 'Ракета Пустоты Х-51' WHERE `locale` = 'ruRU' AND `entry` = 26192;
-- OLD subname : Вождь Калу'ак с Драконьего Погоста
-- Source : https://www.wowhead.com/wotlk/ru/npc=26194
UPDATE `creature_template_locale` SET `Title` = 'Вождь Калу''ак c Драконьего Погоста' WHERE `locale` = 'ruRU' AND `entry` = 26194;
-- OLD name : Утонувший страж
-- Source : https://www.wowhead.com/wotlk/ru/npc=26224
UPDATE `creature_template_locale` SET `Name` = 'Страж-утопленник' WHERE `locale` = 'ruRU' AND `entry` = 26224;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26226
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 26226;
-- OLD subname : Повелительница рыцарей крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=26247
UPDATE `creature_template_locale` SET `Title` = 'Матриарх рыцарей крови' WHERE `locale` = 'ruRU' AND `entry` = 26247;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26258
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26258;
-- OLD name : [PH] Dragonblight Ancient (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26274
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26274;
-- OLD name : [PH] Dragonblight Black Dragon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26275
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26275;
-- OLD name : [PH] Dragonblight Green Dragon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26278
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26278;
-- OLD name : [PH] Dragonblight Elemental Obsidian Dragonshire (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26285
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26285;
-- OLD name : Змей затаившегося пламени
-- Source : https://www.wowhead.com/wotlk/ru/npc=26286
UPDATE `creature_template_locale` SET `Name` = 'Тлеющий змей' WHERE `locale` = 'ruRU' AND `entry` = 26286;
-- OLD name : Forgotten Shore Event Trigger
-- Source : https://www.wowhead.com/wotlk/ru/npc=26288
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 26288;
-- OLD name : [PH] Dragonblight Scourge Carrion Fields (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26292
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26292;
-- OLD name : [PH] Dragonblight Magma Wyrm (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26294
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26294;
-- OLD name : [PH] Dragonblight Scarlet Onslaught (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26296
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26296;
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
-- OLD name : [PH] Dragonblight Taunka (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26311
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26311;
-- OLD name : [PH] Dragonblight Taunka Spirit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26312
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26312;
-- OLD name : [PH] Dragonblight Treant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26313
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26313;
-- OLD name : [PH] Dragonblight Scourge Galakrond Rest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26317
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26317;
-- OLD name : [PH] Dragonblight Scourge Obsidian Dragonshire (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26318
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26318;
-- OLD name : [PH] Dragonblight Scourge Ruby Dragonshrine (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26320
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26320;
-- OLD name : Волшебный змейчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=26322
UPDATE `creature_template_locale` SET `Name` = 'Волшебный змей' WHERE `locale` = 'ruRU' AND `entry` = 26322;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - H (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26355
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26355;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26361
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 26361;
-- OLD name : Геодезист из Лиги исследователей, subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26362
UPDATE `creature_template_locale` SET `Name` = 'Геодезист из Лиги Исследователей',`Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 26362;
-- OLD name : Test - Brutallus Craig (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26376
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26376;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26376, 'ruRU','NPC',NULL);
-- OLD name : Иви Медипрыг, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=26378
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 26378;
-- OLD name : Гриккин Медипрыг, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=26383
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 26383;
-- OLD name : Фрикси Меднотумблер, subname : Продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=26384
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 26384;
-- OLD name : [PH] Ice Chest Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26391
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26391;
-- OLD name : Беженец из Таунка'ле (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26432
UPDATE `creature_template_locale` SET `Name` = 'Беженец из деревни Таунка''ле' WHERE `locale` = 'ruRU' AND `entry` = 26432;
-- OLD name : Беженец из Таунка'ле (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26433
UPDATE `creature_template_locale` SET `Name` = 'Беженка из деревни Таунка''ле' WHERE `locale` = 'ruRU' AND `entry` = 26433;
-- OLD name : Льдистый змей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26446
UPDATE `creature_template_locale` SET `Name` = 'Ледяной змей' WHERE `locale` = 'ruRU' AND `entry` = 26446;
-- OLD name : Проекция верховного мага Этаса Похитителя Солнца
-- Source : https://www.wowhead.com/wotlk/ru/npc=26471
UPDATE `creature_template_locale` SET `Name` = 'Проекция Этаса Похитителя Солнца' WHERE `locale` = 'ruRU' AND `entry` = 26471;
-- OLD name : Ордынский воин (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26486
UPDATE `creature_template_locale` SET `Name` = 'Воитель Орды' WHERE `locale` = 'ruRU' AND `entry` = 26486;
-- OLD name : [PH] Dragonblight Carrion Field Necromancer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26489
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26489;
-- OLD name : [PH] Dragonblight Carrion Field Zombie (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26490
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26490;
-- OLD name : [PH] Dragonblight Carrion Field Gargoyle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26491
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26491;
-- OLD name : Отрекшийся-призыватель гнили (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26508
UPDATE `creature_template_locale` SET `Name` = 'Отрекшийся - призыватель гнили' WHERE `locale` = 'ruRU' AND `entry` = 26508;
-- OLD subname : "Тот, что играет с едой"
-- Source : https://www.wowhead.com/wotlk/ru/npc=26510
UPDATE `creature_template_locale` SET `Title` = '"Тот, кто играет с едой"' WHERE `locale` = 'ruRU' AND `entry` = 26510;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26514
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 26514;
-- OLD subname : Рыцарь ордена Серебряной Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=26528
UPDATE `creature_template_locale` SET `Title` = 'Рыцарь Серебряной Длани' WHERE `locale` = 'ruRU' AND `entry` = 26528;
-- OLD name : [Demo] Craig Amai (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26535
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26535;
-- OLD subname : Начальник порта (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26551
UPDATE `creature_template_locale` SET `Title` = 'Начальник дока' WHERE `locale` = 'ruRU' AND `entry` = 26551;
-- OLD subname : Начальник порта (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26552
UPDATE `creature_template_locale` SET `Title` = 'Начальница дока' WHERE `locale` = 'ruRU' AND `entry` = 26552;
-- OLD subname : Укротитель дракондоров
-- Source : https://www.wowhead.com/wotlk/ru/npc=26560
UPDATE `creature_template_locale` SET `Title` = 'Укротительница дракондоров' WHERE `locale` = 'ruRU' AND `entry` = 26560;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26564
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 26564;
-- OLD name : Spiritual Insight Transform (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26594
UPDATE `creature_template_locale` SET `Name` = 'Видение' WHERE `locale` = 'ruRU' AND `entry` = 26594;
-- OLD name : Шарлиз Сугроба Из, subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=26596
UPDATE `creature_template_locale` SET `Name` = 'Чарли "Полярыч"',`Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 26596;
-- OLD name : Снегопадный олень
-- Source : https://www.wowhead.com/wotlk/ru/npc=26615
UPDATE `creature_template_locale` SET `Name` = 'Снегопадный лось' WHERE `locale` = 'ruRU' AND `entry` = 26615;
-- OLD name : Ануб'арская тюрьма
-- Source : https://www.wowhead.com/wotlk/ru/npc=26656
UPDATE `creature_template_locale` SET `Name` = 'Ануб''арский тюремщик' WHERE `locale` = 'ruRU' AND `entry` = 26656;
-- OLD name : [PH] Named Condor Shirrak (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26665
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26665;
-- OLD name : Rabid Dire Bear *Unused* (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26671
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26671;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26671, 'ruRU','NPC',NULL);
-- OLD subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=26709
UPDATE `creature_template_locale` SET `Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 26709;
-- OLD name : [DND] TAR Pedestal - Armor, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26724
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26724;
-- OLD name : [dnd] Fizzcrank Paratrooper Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26732
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26732;
-- OLD name : [DND] TAR Pedestal - Accessories (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26738
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26738;
-- OLD name : [DND] TAR Pedestal - Enchantments (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26739
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26739;
-- OLD name : [DND] TAR Pedestal - Gems (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26740
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26740;
-- OLD name : [DND] TAR Pedestal - General Goods (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26741
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26741;
-- OLD name : [DND] TAR Pedestal - Armor, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26742
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26742;
-- OLD name : [DND] TAR Pedestal - Glyph, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26743
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26743;
-- OLD name : [DND] TAR Pedestal - Glyph, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26744
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26744;
-- OLD name : [DND] TAR Pedestal - Weapons (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26745
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26745;
-- OLD name : [DND] TAR Pedestal - Arena Organizer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26747
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26747;
-- OLD name : [DND] TAR Pedestal - Beastmaster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26748
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26748;
-- OLD name : [DND] TAR Pedestal - Paymaster (-> Monk) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26749
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26749;
-- OLD name : [DND] TAR Pedestal - Teleporter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26750
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26750;
-- OLD name : [DND] TAR Pedestal - Trainer, Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26751
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26751;
-- OLD name : [DND] TAR Pedestal - Trainer, Hunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26752
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26752;
-- OLD name : [DND] TAR Pedestal - Trainer, Mage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26753
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26753;
-- OLD name : [DND] TAR Pedestal - Trainer, Paladin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26754
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26754;
-- OLD name : [DND] TAR Pedestal - Trainer, Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26755
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26755;
-- OLD name : [DND] TAR Pedestal - Trainer, Rogue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26756
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26756;
-- OLD name : [DND] TAR Pedestal - Trainer, Shaman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26757
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26757;
-- OLD name : [DND] TAR Pedestal - Trainer, Warlock (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26758
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26758;
-- OLD name : [DND] TAR Pedestal - Trainer, Warrior (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26759
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26759;
-- OLD name : Капитан Эмми Малин
-- Source : https://www.wowhead.com/wotlk/ru/npc=26762
UPDATE `creature_template_locale` SET `Name` = 'Капитан Эмми Мэлин' WHERE `locale` = 'ruRU' AND `entry` = 26762;
-- OLD subname : Официантка клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=26764
UPDATE `creature_template_locale` SET `Title` = 'Официантка из клана Черного Железа' WHERE `locale` = 'ruRU' AND `entry` = 26764;
-- OLD name : [DND] TAR Pedestal - Fight Promoter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26765
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26765;
-- OLD name : Выносливый гонец Таунка'ле
-- Source : https://www.wowhead.com/wotlk/ru/npc=26790
UPDATE `creature_template_locale` SET `Name` = 'Выносливый гонец таунка''ле' WHERE `locale` = 'ruRU' AND `entry` = 26790;
-- OLD name : Scott Keenan, subname : Thug Life
-- Source : https://www.wowhead.com/wotlk/ru/npc=26791
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26791;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26791, 'ruRU','Скотт Кинан','Вор');
-- OLD subname : Официантка клана Черного Железа
-- Source : https://www.wowhead.com/wotlk/ru/npc=26822
UPDATE `creature_template_locale` SET `Title` = 'Официантка из клана Черного Железа' WHERE `locale` = 'ruRU' AND `entry` = 26822;
-- OLD name : [PH] Dragonblight Shoveltusk Scavenger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26835
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26835;
-- OLD name : [PH] Dragonblight Named Frost Wyrm Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=26840
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 26840;
-- OLD subname : Укротитель ветрокрылов (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26842
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 26842;
-- OLD subname : Укротитель ветрокрылов (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26846
UPDATE `creature_template_locale` SET `Title` = 'Укротительница ветрокрылов' WHERE `locale` = 'ruRU' AND `entry` = 26846;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=26883
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 26883;
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
-- OLD name : Ледяной дракон-душегуб (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=26967
UPDATE `creature_template_locale` SET `Name` = 'Ледяной душегуб' WHERE `locale` = 'ruRU' AND `entry` = 26967;
-- OLD subname : Учитель портняжного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=26969
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер портняжного дела' WHERE `locale` = 'ruRU' AND `entry` = 26969;
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
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=27043
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 27043;
-- OLD name : Боевой маг Адами
-- Source : https://www.wowhead.com/wotlk/ru/npc=27046
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Адами' WHERE `locale` = 'ruRU' AND `entry` = 27046;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=27057
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 27057;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=27113
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 27113;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=27114
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 27114;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=27115
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 27115;
-- OLD name : Добытчик-ледохват
-- Source : https://www.wowhead.com/wotlk/ru/npc=27123
UPDATE `creature_template_locale` SET `Name` = 'Добытчик-ледолап' WHERE `locale` = 'ruRU' AND `entry` = 27123;
-- OLD subname : Товары для алхимиков
-- Source : https://www.wowhead.com/wotlk/ru/npc=27140
UPDATE `creature_template_locale` SET `Title` = 'Товары для алхимика' WHERE `locale` = 'ruRU' AND `entry` = 27140;
-- OLD name : Скакун Всадника без головы
-- Source : https://www.wowhead.com/wotlk/ru/npc=27152
UPDATE `creature_template_locale` SET `Name` = 'Конь Всадника без головы, игрок, в полете' WHERE `locale` = 'ruRU' AND `entry` = 27152;
-- OLD name : Копейщик Камагуа
-- Source : https://www.wowhead.com/wotlk/ru/npc=27167
UPDATE `creature_template_locale` SET `Name` = 'Копейшик Камагуа' WHERE `locale` = 'ruRU' AND `entry` = 27167;
-- OLD name : Боевой маг Каландра
-- Source : https://www.wowhead.com/wotlk/ru/npc=27173
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Каландра' WHERE `locale` = 'ruRU' AND `entry` = 27173;
-- OLD subname : Раб
-- Source : https://www.wowhead.com/wotlk/ru/npc=27191
UPDATE `creature_template_locale` SET `Title` = 'Гном-раб' WHERE `locale` = 'ruRU' AND `entry` = 27191;
-- OLD name : Броут, subname : Раб
-- Source : https://www.wowhead.com/wotlk/ru/npc=27198
UPDATE `creature_template_locale` SET `Name` = 'Брот',`Title` = 'Гном-раб' WHERE `locale` = 'ruRU' AND `entry` = 27198;
-- OLD name : [PH] New Hearthglen Scarlet Footman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=27205
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27205;
-- OLD name : [PH] New Hearthglen Scarlet Commander (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=27208
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27208;
-- OLD name : Истязатель Лекрафт
-- Source : https://www.wowhead.com/wotlk/ru/npc=27209
UPDATE `creature_template_locale` SET `Name` = 'Истязатель Альфонс' WHERE `locale` = 'ruRU' AND `entry` = 27209;
-- OLD name : [PH] New Hearthglen Scarlet Scout (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=27218
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27218;
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=27227
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 27227;
-- OLD name : Йормунгарский червь
-- Source : https://www.wowhead.com/wotlk/ru/npc=27228
UPDATE `creature_template_locale` SET `Name` = 'Йормунгарские черви' WHERE `locale` = 'ruRU' AND `entry` = 27228;
-- OLD subname : Гарантированное качество (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=27231
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 27231;
-- OLD name : Глава шпионов Репайн
-- Source : https://www.wowhead.com/wotlk/ru/npc=27337
UPDATE `creature_template_locale` SET `Name` = 'Госпожа шпионов Репина' WHERE `locale` = 'ruRU' AND `entry` = 27337;
-- OLD name : Аделина Чемберс
-- Source : https://www.wowhead.com/wotlk/ru/npc=27344
UPDATE `creature_template_locale` SET `Name` = 'Дрессировщица нетопырей Аделина' WHERE `locale` = 'ruRU' AND `entry` = 27344;
-- OLD name : Архонт-ворон Алого Натиска
-- Source : https://www.wowhead.com/wotlk/ru/npc=27357
UPDATE `creature_template_locale` SET `Name` = 'Вороний архонт Алого Натиска' WHERE `locale` = 'ruRU' AND `entry` = 27357;
-- OLD name : [DND] Stabled Pet Appearance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=27368
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27368;
-- OLD name : Главный писарь Баррига
-- Source : https://www.wowhead.com/wotlk/ru/npc=27378
UPDATE `creature_template_locale` SET `Name` = 'Главный писарь Киннедий' WHERE `locale` = 'ruRU' AND `entry` = 27378;
-- OLD name : Wintergarde Inner Gate Attack Trigger
-- Source : https://www.wowhead.com/wotlk/ru/npc=27380
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 27380;
-- OLD name : Тель'зан Мраконосец
-- Source : https://www.wowhead.com/wotlk/ru/npc=27384
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 27384;
-- OLD name : [DND] Valiance Keep Footman Spectator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=27387
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27387;
-- OLD name : Utgarde Duo Trigger
-- Source : https://www.wowhead.com/wotlk/ru/npc=27404
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 27404;
-- OLD name : Труп застрельщика
-- Source : https://www.wowhead.com/wotlk/ru/npc=27457
UPDATE `creature_template_locale` SET `Name` = 'Труп рыскателя' WHERE `locale` = 'ruRU' AND `entry` = 27457;
-- OLD name : Израненный застрельщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=27463
UPDATE `creature_template_locale` SET `Name` = 'Израненный рыскатель' WHERE `locale` = 'ruRU' AND `entry` = 27463;
-- OLD name : Пехотник Дружины Западного края
-- Source : https://www.wowhead.com/wotlk/ru/npc=27475
UPDATE `creature_template_locale` SET `Name` = 'Пехотинец Дружины Западного края' WHERE `locale` = 'ruRU' AND `entry` = 27475;
-- OLD subname : Продавец пива
-- Source : https://www.wowhead.com/wotlk/ru/npc=27487
UPDATE `creature_template_locale` SET `Title` = 'Торговец напитками' WHERE `locale` = 'ruRU' AND `entry` = 27487;
-- OLD name : Нордскольский всадник на грифоне (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=27504
UPDATE `creature_template_locale` SET `Name` = 'Нордскольский наездник на грифоне' WHERE `locale` = 'ruRU' AND `entry` = 27504;
-- OLD name : Clayton Dubin - TEST COPY DATA (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=27527
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (27527, 'ruRU','NPC',NULL);
-- OLD name : Стойла Торговой Компании (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=27568
UPDATE `creature_template_locale` SET `Name` = 'Стойла Торговой компании' WHERE `locale` = 'ruRU' AND `entry` = 27568;
-- OLD name : Лорд Афрасастраз, subname : Начальник стражи Храма Драконьего Покоя
-- Source : https://www.wowhead.com/wotlk/ru/npc=27575
UPDATE `creature_template_locale` SET `Name` = 'Лорд Деврестраз',`Title` = 'Командир стражи Храма Драконьего Покоя' WHERE `locale` = 'ruRU' AND `entry` = 27575;
-- OLD name : Лазурный драконоид
-- Source : https://www.wowhead.com/wotlk/ru/npc=27608
UPDATE `creature_template_locale` SET `Name` = 'Лазурный дракон' WHERE `locale` = 'ruRU' AND `entry` = 27608;
-- OLD name : [UNUSED] Wrath Gate Crypt Fiend (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=27630
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27630;
-- OLD name : Лазурный дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=27682
UPDATE `creature_template_locale` SET `Name` = 'Лазурный дракончик' WHERE `locale` = 'ruRU' AND `entry` = 27682;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=27703
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 27703;
-- OLD name : Горейс Олдер
-- Source : https://www.wowhead.com/wotlk/ru/npc=27704
UPDATE `creature_template_locale` SET `Name` = 'Гораций Олдер' WHERE `locale` = 'ruRU' AND `entry` = 27704;
-- OLD subname : Изучение порталов
-- Source : https://www.wowhead.com/wotlk/ru/npc=27705
UPDATE `creature_template_locale` SET `Title` = 'Мастер порталов' WHERE `locale` = 'ruRU' AND `entry` = 27705;
-- OLD name : [DND] Aldor Mailbox Malfunction Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=27723
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27723;
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
-- OLD name : Летающий аппарат Озера Ледяных Оков (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=27838
UPDATE `creature_template_locale` SET `Name` = 'Летающий аппарат с озера Ледяных Оков' WHERE `locale` = 'ruRU' AND `entry` = 27838;
-- OLD name : Тигрюша
-- Source : https://www.wowhead.com/wotlk/ru/npc=27849
UPDATE `creature_template_locale` SET `Name` = 'Пятнюга' WHERE `locale` = 'ruRU' AND `entry` = 27849;
-- OLD name : Patty's test vehicle TEST (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=27862
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - vehicle' WHERE `locale` = 'ruRU' AND `entry` = 27862;
-- OLD name : Крошшер Озера Ледяных Оков (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=27883
UPDATE `creature_template_locale` SET `Name` = 'Крошшер с озера Ледяных Оков' WHERE `locale` = 'ruRU' AND `entry` = 27883;
-- OLD name : Боевой маг Аркус
-- Source : https://www.wowhead.com/wotlk/ru/npc=27888
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Аркус' WHERE `locale` = 'ruRU' AND `entry` = 27888;
-- OLD name : Боевой маг Ваткинс
-- Source : https://www.wowhead.com/wotlk/ru/npc=27904
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Ваткинс' WHERE `locale` = 'ruRU' AND `entry` = 27904;
-- OLD name : Сиденье бомбометательного отсека Озера Ледяных Оков (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=27905
UPDATE `creature_template_locale` SET `Name` = 'Сиденье бомбометательного отсека озера Ледяных Оков' WHERE `locale` = 'ruRU' AND `entry` = 27905;
-- OLD name : Боевой маг Холлистер
-- Source : https://www.wowhead.com/wotlk/ru/npc=27906
UPDATE `creature_template_locale` SET `Name` = 'Военный маг Холлистер' WHERE `locale` = 'ruRU' AND `entry` = 27906;
-- OLD name : Корабль Кормчего
-- Source : https://www.wowhead.com/wotlk/ru/npc=27939
UPDATE `creature_template_locale` SET `Name` = 'Корабль кормчего' WHERE `locale` = 'ruRU' AND `entry` = 27939;
-- OLD name : Командир Альянса
-- Source : https://www.wowhead.com/wotlk/ru/npc=27949
UPDATE `creature_template_locale` SET `Name` = 'Командор Альянса' WHERE `locale` = 'ruRU' AND `entry` = 27949;
-- OLD name : Обветренный осколыш
-- Source : https://www.wowhead.com/wotlk/ru/npc=27974
UPDATE `creature_template_locale` SET `Name` = 'Выветренный осколыш' WHERE `locale` = 'ruRU' AND `entry` = 27974;
-- OLD name : [PH] Warp Stalker Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=27976
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 27976;
-- OLD name : Искаженная слизь
-- Source : https://www.wowhead.com/wotlk/ru/npc=27981
UPDATE `creature_template_locale` SET `Name` = 'Бесформенная слизь' WHERE `locale` = 'ruRU' AND `entry` = 27981;
-- OLD name : Лейтенант Ледяной Молот
-- Source : https://www.wowhead.com/wotlk/ru/npc=27994
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 27994;
-- OLD name : Кровавый червь
-- Source : https://www.wowhead.com/wotlk/ru/npc=28017
UPDATE `creature_template_locale` SET `Name` = 'Кровочервь' WHERE `locale` = 'ruRU' AND `entry` = 28017;
-- OLD name : Жуткий Капитан де Меза
-- Source : https://www.wowhead.com/wotlk/ru/npc=28048
UPDATE `creature_template_locale` SET `Name` = 'Жуткий капитан де Меза' WHERE `locale` = 'ruRU' AND `entry` = 28048;
-- OLD name : Королева Сапфирного улья
-- Source : https://www.wowhead.com/wotlk/ru/npc=28087
UPDATE `creature_template_locale` SET `Name` = 'Матка Сапфирного улья' WHERE `locale` = 'ruRU' AND `entry` = 28087;
-- OLD name : [ph] exploding barrel (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=28173
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28173;
-- OLD name : [ph] Goblin Construction Crew (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=28180
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28180;
-- OLD name : [DND] under water construction crew (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=28184
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28184;
-- OLD name : [DND] L70ETC Drums (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=28206
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28206;
-- OLD name : Воздушный патруль Торговой Компании (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=28241
UPDATE `creature_template_locale` SET `Name` = 'Воздушный патруль Торговой компании' WHERE `locale` = 'ruRU' AND `entry` = 28241;
-- OLD name : [DND] taxi flavor eagle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=28292
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28292;
-- OLD subname : Питомец Дебаар
-- Source : https://www.wowhead.com/wotlk/ru/npc=28346
UPDATE `creature_template_locale` SET `Title` = 'Питомец Дебаара' WHERE `locale` = 'ruRU' AND `entry` = 28346;
-- OLD subname : Учитель кожевничества (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=28400
UPDATE `creature_template_locale` SET `Title` = 'Учительница кожевничества' WHERE `locale` = 'ruRU' AND `entry` = 28400;
-- OLD name : Ярость
-- Source : https://www.wowhead.com/wotlk/ru/npc=28446
UPDATE `creature_template_locale` SET `Name` = 'Неистовый' WHERE `locale` = 'ruRU' AND `entry` = 28446;
-- OLD name : [UNUSED]Altar of Quetz'lun Gateway - Real World (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=28469
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28469;
-- OLD name : Ronakada (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=28501
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28501;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (28501, 'ruRU','NPC',NULL);
-- OLD name : Крестоносец Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28529
UPDATE `creature_template_locale` SET `Name` = 'Рыцарь Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28529;
-- OLD name : Свистящий клапан
-- Source : https://www.wowhead.com/wotlk/ru/npc=28539
UPDATE `creature_template_locale` SET `Name` = 'Паровой клапан' WHERE `locale` = 'ruRU' AND `entry` = 28539;
-- OLD name : Дистилло-матик 5000 (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=28545
UPDATE `creature_template_locale` SET `Name` = '"Дистиллобот-5000"' WHERE `locale` = 'ruRU' AND `entry` = 28545;
-- OLD name : Истязатель Лекрафт
-- Source : https://www.wowhead.com/wotlk/ru/npc=28554
UPDATE `creature_template_locale` SET `Name` = 'Истязатель Альфонс' WHERE `locale` = 'ruRU' AND `entry` = 28554;
-- OLD name : Генерал Бьярнгрим
-- Source : https://www.wowhead.com/wotlk/ru/npc=28586
UPDATE `creature_template_locale` SET `Name` = 'Генерал Бьярнгрин' WHERE `locale` = 'ruRU' AND `entry` = 28586;
-- OLD name : Пехотинец из Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28609
UPDATE `creature_template_locale` SET `Name` = 'Пехотинец Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28609;
-- OLD name : Рыцарь Серебряной Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=28612
UPDATE `creature_template_locale` SET `Name` = 'Рыцарь ордена Серебряной Длани' WHERE `locale` = 'ruRU' AND `entry` = 28612;
-- OLD name : Всадник на грифоне из Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28616
UPDATE `creature_template_locale` SET `Name` = 'Всадник на грифоне Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28616;
-- OLD name : Таинственный цыган (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=28652
UPDATE `creature_template_locale` SET `Name` = 'Таинственный торговец' WHERE `locale` = 'ruRU' AND `entry` = 28652;
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
-- OLD name : Эндора Мурхед
-- Source : https://www.wowhead.com/wotlk/ru/npc=28715
UPDATE `creature_template_locale` SET `Name` = 'Ендора Мурхед' WHERE `locale` = 'ruRU' AND `entry` = 28715;
-- OLD subname : Товары для алхимиков
-- Source : https://www.wowhead.com/wotlk/ru/npc=28725
UPDATE `creature_template_locale` SET `Title` = 'Товары для алхимика' WHERE `locale` = 'ruRU' AND `entry` = 28725;
-- OLD subname : Рыбная ловля: обучение и снасти
-- Source : https://www.wowhead.com/wotlk/ru/npc=28742
UPDATE `creature_template_locale` SET `Title` = 'Великий рыбак и торговец снастями' WHERE `locale` = 'ruRU' AND `entry` = 28742;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=28746
UPDATE `creature_template_locale` SET `Title` = 'Инструктор полетов в непогоду' WHERE `locale` = 'ruRU' AND `entry` = 28746;
-- OLD name : Харгус Калека
-- Source : https://www.wowhead.com/wotlk/ru/npc=28760
UPDATE `creature_template_locale` SET `Name` = 'Харгус Дух' WHERE `locale` = 'ruRU' AND `entry` = 28760;
-- OLD name : [Phase 1] Scarlet Crusade Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=28763
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28763;
-- OLD name : [Phase 1] Citizen of Havenshire Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=28764
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28764;
-- OLD name : [Phase 1] Havenshrie Horse Credit, Step 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=28767
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28767;
-- OLD name : Боевой разрушитель
-- Source : https://www.wowhead.com/wotlk/ru/npc=28781
UPDATE `creature_template_locale` SET `Name` = 'Разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 28781;
-- OLD subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=28791
UPDATE `creature_template_locale` SET `Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 28791;
-- OLD subname : Кузнец
-- Source : https://www.wowhead.com/wotlk/ru/npc=28796
UPDATE `creature_template_locale` SET `Title` = 'Кузница' WHERE `locale` = 'ruRU' AND `entry` = 28796;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=28800
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 28800;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=28813
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 28813;
-- OLD subname : Товары для алхимиков
-- Source : https://www.wowhead.com/wotlk/ru/npc=28829
UPDATE `creature_template_locale` SET `Title` = 'Товары для алхимика' WHERE `locale` = 'ruRU' AND `entry` = 28829;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=28831
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 28831;
-- OLD name : Наземная пушка Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28850
UPDATE `creature_template_locale` SET `Name` = 'Пушка Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28850;
-- OLD name : Кровь древнего бога
-- Source : https://www.wowhead.com/wotlk/ru/npc=28854
UPDATE `creature_template_locale` SET `Name` = 'Кровь Древнего Бога' WHERE `locale` = 'ruRU' AND `entry` = 28854;
-- OLD subname : Товары для алхимиков
-- Source : https://www.wowhead.com/wotlk/ru/npc=28866
UPDATE `creature_template_locale` SET `Title` = 'Товары для алхимика' WHERE `locale` = 'ruRU' AND `entry` = 28866;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=28872
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 28872;
-- OLD name : Всадник на грифоне из Алого ордена (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=28894
UPDATE `creature_template_locale` SET `Name` = 'Наездница на грифоне из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28894;
-- OLD name : Медик Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28895
UPDATE `creature_template_locale` SET `Name` = 'Медик из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28895;
-- OLD name : Капитан Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28898
UPDATE `creature_template_locale` SET `Name` = 'Капитан из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28898;
-- OLD name : Искра Ионара
-- Source : https://www.wowhead.com/wotlk/ru/npc=28926
UPDATE `creature_template_locale` SET `Name` = 'Искра Ионар' WHERE `locale` = 'ruRU' AND `entry` = 28926;
-- OLD name : Командир Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28936
UPDATE `creature_template_locale` SET `Name` = 'Командир из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28936;
-- OLD name : Крестоносец Алого ордена
-- Source : https://www.wowhead.com/wotlk/ru/npc=28940
UPDATE `creature_template_locale` SET `Name` = 'Рыцарь Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 28940;
-- OLD name : [Chapter II] Scarlet Crusader Test Dummy Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=28957
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 28957;
-- OLD subname : Наставница магов
-- Source : https://www.wowhead.com/wotlk/ru/npc=28958
UPDATE `creature_template_locale` SET `Title` = 'Наставник магов' WHERE `locale` = 'ruRU' AND `entry` = 28958;
-- OLD name : Титановый осадник
-- Source : https://www.wowhead.com/wotlk/ru/npc=28961
UPDATE `creature_template_locale` SET `Name` = 'Титановый воин' WHERE `locale` = 'ruRU' AND `entry` = 28961;
-- OLD name : Лорд Алого ордена Джессерия Маккри
-- Source : https://www.wowhead.com/wotlk/ru/npc=28964
UPDATE `creature_template_locale` SET `Name` = 'Лорд Алого ордена Бораг' WHERE `locale` = 'ruRU' AND `entry` = 28964;
-- OLD name : Командир Алого ордена Родрик
-- Source : https://www.wowhead.com/wotlk/ru/npc=29000
UPDATE `creature_template_locale` SET `Name` = 'Командир Родрик из Алого ордена' WHERE `locale` = 'ruRU' AND `entry` = 29000;
-- OLD subname : Торговец луками
-- Source : https://www.wowhead.com/wotlk/ru/npc=29014
UPDATE `creature_template_locale` SET `Title` = 'Торговец стрелами' WHERE `locale` = 'ruRU' AND `entry` = 29014;
-- OLD name : Портовый грузчик
-- Source : https://www.wowhead.com/wotlk/ru/npc=29019
UPDATE `creature_template_locale` SET `Name` = 'Портовый рабочий' WHERE `locale` = 'ruRU' AND `entry` = 29019;
-- OLD name : [DND] Dockhand w/Bag (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=29020
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 29020;
-- OLD name : [609] Ebon Hold Duel Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=29025
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 29025;
-- OLD name : [Chapter II] Torch Toss Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=29038
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 29038;
-- OLD name : [UNUSED] [ph] Stormwind Gryphon (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=29039
UPDATE `creature_template_locale` SET `Name` = 'REUSE' WHERE `locale` = 'ruRU' AND `entry` = 29039;
-- OLD name : Гоби Подрывайстер
-- Source : https://www.wowhead.com/wotlk/ru/npc=29068
UPDATE `creature_template_locale` SET `Name` = 'Гоби Покрышкинс' WHERE `locale` = 'ruRU' AND `entry` = 29068;
-- OLD name : [Chapter IV] Chapter IV Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=29192
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 29192;
-- OLD subname : Реагенты
-- Source : https://www.wowhead.com/wotlk/ru/npc=29203
UPDATE `creature_template_locale` SET `Title` = 'Продавец трупного праха' WHERE `locale` = 'ruRU' AND `entry` = 29203;
-- OLD subname : Учитель первой помощи
-- Source : https://www.wowhead.com/wotlk/ru/npc=29233
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер первой помощи' WHERE `locale` = 'ruRU' AND `entry` = 29233;
-- OLD name : [Chapter IV] Light of Dawn Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=29245
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 29245;
-- OLD name : Эфирная сфера
-- Source : https://www.wowhead.com/wotlk/ru/npc=29271
UPDATE `creature_template_locale` SET `Name` = 'Бесплотная сфера' WHERE `locale` = 'ruRU' AND `entry` = 29271;
-- OLD name : Бенджамин Эльгуэта
-- Source : https://www.wowhead.com/wotlk/ru/npc=29298
UPDATE `creature_template_locale` SET `Name` = 'Веджамин Эльгуэта' WHERE `locale` = 'ruRU' AND `entry` = 29298;
-- OLD name : Епископ-ворон Алого Натиска
-- Source : https://www.wowhead.com/wotlk/ru/npc=29338
UPDATE `creature_template_locale` SET `Name` = 'Вороний епископ Алого Натиска' WHERE `locale` = 'ruRU' AND `entry` = 29338;
-- OLD name : [PH]TEST Skater (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=29361
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 29361;
-- OLD name : Налетчик из клана Закаленных Бурей
-- Source : https://www.wowhead.com/wotlk/ru/npc=29377
UPDATE `creature_template_locale` SET `Name` = 'Мародер из клана Закаленных Бурей' WHERE `locale` = 'ruRU' AND `entry` = 29377;
-- OLD name : Фанатик с Холмов Снежной Слепоты
-- Source : https://www.wowhead.com/wotlk/ru/npc=29407
UPDATE `creature_template_locale` SET `Name` = 'Приверженец с Холмов Снежной Слепоты' WHERE `locale` = 'ruRU' AND `entry` = 29407;
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
-- OLD subname : Продавец фруктов
-- Source : https://www.wowhead.com/wotlk/ru/npc=29547
UPDATE `creature_template_locale` SET `Title` = 'Торговец фруктами' WHERE `locale` = 'ruRU' AND `entry` = 29547;
-- OLD name : Гнилостный протодракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=29590
UPDATE `creature_template_locale` SET `Name` = 'Чумной протодракон' WHERE `locale` = 'ruRU' AND `entry` = 29590;
-- OLD subname : Учитель кулинарии
-- Source : https://www.wowhead.com/wotlk/ru/npc=29631
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кулинарии' WHERE `locale` = 'ruRU' AND `entry` = 29631;
-- OLD name : Скакун Алого Натиска
-- Source : https://www.wowhead.com/wotlk/ru/npc=29710
UPDATE `creature_template_locale` SET `Name` = 'Боевой конь Алого Натиска' WHERE `locale` = 'ruRU' AND `entry` = 29710;
-- OLD name : Скиззл Ухомах
-- Source : https://www.wowhead.com/wotlk/ru/npc=29721
UPDATE `creature_template_locale` SET `Name` = 'Скиззл Гладкоезд' WHERE `locale` = 'ruRU' AND `entry` = 29721;
-- OLD name : Мастер топора из клана Зиморожденных
-- Source : https://www.wowhead.com/wotlk/ru/npc=29729
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по топорам из клана Зиморожденных' WHERE `locale` = 'ruRU' AND `entry` = 29729;
-- OLD name : Взбешенный ворг
-- Source : https://www.wowhead.com/wotlk/ru/npc=29735
UPDATE `creature_template_locale` SET `Name` = 'Дикий ворг' WHERE `locale` = 'ruRU' AND `entry` = 29735;
-- OLD subname : Распорядитель полетов (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=29749
UPDATE `creature_template_locale` SET `Title` = 'Распорядительница полетов' WHERE `locale` = 'ruRU' AND `entry` = 29749;
-- OLD name : [DND] Dalaran Toy Store Plane String Hook (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=29807
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 29807;
-- OLD name : [DND] Dalaran Toy Store Plane String Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=29812
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 29812;
-- OLD name : Жеребец смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=29818
UPDATE `creature_template_locale` SET `Name` = 'Конь смерти-жеребец' WHERE `locale` = 'ruRU' AND `entry` = 29818;
-- OLD name : Непоколебимость
-- Source : https://www.wowhead.com/wotlk/ru/npc=29863
UPDATE `creature_template_locale` SET `Name` = 'Упорство' WHERE `locale` = 'ruRU' AND `entry` = 29863;
-- OLD subname : Учитель кузнечного дела
-- Source : https://www.wowhead.com/wotlk/ru/npc=29924
UPDATE `creature_template_locale` SET `Title` = 'Великий мастер кузнечного дела' WHERE `locale` = 'ruRU' AND `entry` = 29924;
-- OLD subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=29926
UPDATE `creature_template_locale` SET `Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 29926;
-- OLD name : Хоргору Сборщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=29962
UPDATE `creature_template_locale` SET `Name` = 'Норгору Сборщик' WHERE `locale` = 'ruRU' AND `entry` = 29962;
-- OLD subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=29971
UPDATE `creature_template_locale` SET `Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 29971;
-- OLD name : Земельник-дозорный
-- Source : https://www.wowhead.com/wotlk/ru/npc=29981
UPDATE `creature_template_locale` SET `Name` = 'Земельник-страж-смотритель' WHERE `locale` = 'ruRU' AND `entry` = 29981;
-- OLD subname : Хозяйка таверны
-- Source : https://www.wowhead.com/wotlk/ru/npc=30005
UPDATE `creature_template_locale` SET `Title` = 'Хозяин таверны' WHERE `locale` = 'ruRU' AND `entry` = 30005;
-- OLD name : Грозовестник
-- Source : https://www.wowhead.com/wotlk/ru/npc=30013
UPDATE `creature_template_locale` SET `Name` = 'Орел-грозовестник' WHERE `locale` = 'ruRU' AND `entry` = 30013;
-- OLD subname : Чемпион племени Ледяной Секиры
-- Source : https://www.wowhead.com/wotlk/ru/npc=30023
UPDATE `creature_template_locale` SET `Title` = 'Герой Секиры Зимы' WHERE `locale` = 'ruRU' AND `entry` = 30023;
-- OLD name : Змей Грозовой Гряды (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30055
UPDATE `creature_template_locale` SET `Name` = 'Змей Грозовой гряды' WHERE `locale` = 'ruRU' AND `entry` = 30055;
-- OLD name : Мастер топора из клана Зиморожденных
-- Source : https://www.wowhead.com/wotlk/ru/npc=30065
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по топорам из клана Зиморожденных' WHERE `locale` = 'ruRU' AND `entry` = 30065;
-- OLD name : [DND]Wyrmrest Temple Beam Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30078
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30078;
-- OLD name : Сумеречный верующий
-- Source : https://www.wowhead.com/wotlk/ru/npc=30111
UPDATE `creature_template_locale` SET `Name` = 'Верующий из культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 30111;
-- OLD name : Сумеречный посвященный
-- Source : https://www.wowhead.com/wotlk/ru/npc=30114
UPDATE `creature_template_locale` SET `Name` = 'Посвященный культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 30114;
-- OLD name : Frostborn Floating Spirit
-- Source : https://www.wowhead.com/wotlk/ru/npc=30145
UPDATE `creature_template_locale` SET `Name` = 'Frostborn Floating Spirit 01' WHERE `locale` = 'ruRU' AND `entry` = 30145;
-- OLD name : Ледяной дракон-разрушитель (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30150
UPDATE `creature_template_locale` SET `Name` = 'Ледяной разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 30150;
-- OLD subname : Смотритель стойл (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30155
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл' WHERE `locale` = 'ruRU' AND `entry` = 30155;
-- OLD name : [DND] Anguish Spectator Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30156
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30156;
-- OLD name : Механогном-труженик
-- Source : https://www.wowhead.com/wotlk/ru/npc=30170
UPDATE `creature_template_locale` SET `Name` = 'Мехагном-работник' WHERE `locale` = 'ruRU' AND `entry` = 30170;
-- OLD name : Сумеречный апостол
-- Source : https://www.wowhead.com/wotlk/ru/npc=30179
UPDATE `creature_template_locale` SET `Name` = 'Апостол культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 30179;
-- OLD name : Южная штормовая кузня
-- Source : https://www.wowhead.com/wotlk/ru/npc=30212
UPDATE `creature_template_locale` SET `Name` = 'Южная штормовая кузница' WHERE `locale` = 'ruRU' AND `entry` = 30212;
-- OLD name : Раненый разведчик Серебряного союза (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30266
UPDATE `creature_template_locale` SET `Name` = 'Раненый разведчик Серебряного Союза' WHERE `locale` = 'ruRU' AND `entry` = 30266;
-- OLD name : Глубинный ползун
-- Source : https://www.wowhead.com/wotlk/ru/npc=30279
UPDATE `creature_template_locale` SET `Name` = 'Глубинный паук' WHERE `locale` = 'ruRU' AND `entry` = 30279;
-- OLD subname : Хозяйственные товары
-- Source : https://www.wowhead.com/wotlk/ru/npc=30311
UPDATE `creature_template_locale` SET `Title` = 'Хозяйственные припасы' WHERE `locale` = 'ruRU' AND `entry` = 30311;
-- OLD name : Сумеречный черный маг
-- Source : https://www.wowhead.com/wotlk/ru/npc=30319
UPDATE `creature_template_locale` SET `Name` = 'Черный маг культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 30319;
-- OLD name : Гнилап
-- Source : https://www.wowhead.com/wotlk/ru/npc=30326
UPDATE `creature_template_locale` SET `Name` = 'Гнилоклык' WHERE `locale` = 'ruRU' AND `entry` = 30326;
-- OLD name : Йормуттар
-- Source : https://www.wowhead.com/wotlk/ru/npc=30340
UPDATE `creature_template_locale` SET `Name` = 'Йоркуттар' WHERE `locale` = 'ruRU' AND `entry` = 30340;
-- OLD name : Командир Джастин Бартлетт
-- Source : https://www.wowhead.com/wotlk/ru/npc=30344
UPDATE `creature_template_locale` SET `Name` = 'Старший капитан Джастин Бартлетт' WHERE `locale` = 'ruRU' AND `entry` = 30344;
-- OLD name : Пехотинец с "Усмирителя небес"
-- Source : https://www.wowhead.com/wotlk/ru/npc=30352
UPDATE `creature_template_locale` SET `Name` = 'Пехотинец "Усмирителя небес"' WHERE `locale` = 'ruRU' AND `entry` = 30352;
-- OLD name : Мастер топора из клана Зиморожденных
-- Source : https://www.wowhead.com/wotlk/ru/npc=30356
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по топорам из клана Зиморожденных' WHERE `locale` = 'ruRU' AND `entry` = 30356;
-- OLD name : Сумеречный доброволец
-- Source : https://www.wowhead.com/wotlk/ru/npc=30385
UPDATE `creature_template_locale` SET `Name` = 'Доброволец культа Сумеречного Молота' WHERE `locale` = 'ruRU' AND `entry` = 30385;
-- OLD subname : Правитель Стальгорна
-- Source : https://www.wowhead.com/wotlk/ru/npc=30411
UPDATE `creature_template_locale` SET `Title` = 'Повелитель Стальгорна' WHERE `locale` = 'ruRU' AND `entry` = 30411;
-- OLD subname : Королева банши (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30426
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 30426;
-- OLD subname : Королева банши (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30427
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 30427;
-- OLD subname : Королева банши (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30428
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 30428;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=30437
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 30437;
-- OLD name : Макс "Честный"
-- Source : https://www.wowhead.com/wotlk/ru/npc=30464
UPDATE `creature_template_locale` SET `Name` = '"Честный" Макс' WHERE `locale` = 'ruRU' AND `entry` = 30464;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30476
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30476;
-- OLD name : Мастер топора из клана Зиморожденных
-- Source : https://www.wowhead.com/wotlk/ru/npc=30505
UPDATE `creature_template_locale` SET `Name` = 'Эксперт по топорам из клана Зиморожденных' WHERE `locale` = 'ruRU' AND `entry` = 30505;
-- OLD name : Грозовестник
-- Source : https://www.wowhead.com/wotlk/ru/npc=30506
UPDATE `creature_template_locale` SET `Name` = 'Орел-грозовестник' WHERE `locale` = 'ruRU' AND `entry` = 30506;
-- OLD name : Training Dummy (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30527
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (30527, 'ruRU','Тренировочный манекен',NULL);
-- OLD name : [UNUSED] Wrathstrike Gargoyle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30545
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30545;
-- OLD name : Фрас Сиаби
-- Source : https://www.wowhead.com/wotlk/ru/npc=30552
UPDATE `creature_template_locale` SET `Name` = 'Эзра Гримм' WHERE `locale` = 'ruRU' AND `entry` = 30552;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30559
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30559;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=30572
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 30572;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30578
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30578;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30580
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30580;
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
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30588
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30588;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30589
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30589;
-- OLD subname : Военачальник Берега Древних
-- Source : https://www.wowhead.com/wotlk/ru/npc=30590
UPDATE `creature_template_locale` SET `Title` = 'Полководец Берега Древних' WHERE `locale` = 'ruRU' AND `entry` = 30590;
-- OLD name : [UNUSED] Forgotten Depths High Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30594
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30594;
-- OLD subname : Arena Organizer
-- Source : https://www.wowhead.com/wotlk/ru/npc=30611
UPDATE `creature_template_locale` SET `Title` = 'Организатор боев на арене' WHERE `locale` = 'ruRU' AND `entry` = 30611;
-- OLD name : Батрак Озера Ледяных Оков (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30619
UPDATE `creature_template_locale` SET `Name` = 'Батрак с озера Ледяных Оков' WHERE `locale` = 'ruRU' AND `entry` = 30619;
-- OLD name : Крестьянин Озера Ледяных Оков (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30626
UPDATE `creature_template_locale` SET `Name` = 'Крестьянин с озера Ледяных Оков' WHERE `locale` = 'ruRU' AND `entry` = 30626;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30640
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30640;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Even (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30646
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30646;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30649
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30649;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Odd (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30651
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30651;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30655
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30655;
-- OLD name : Лазурный разрушитель заклятий
-- Source : https://www.wowhead.com/wotlk/ru/npc=30662
UPDATE `creature_template_locale` SET `Name` = 'Лазурный рушитель чар' WHERE `locale` = 'ruRU' AND `entry` = 30662;
-- OLD name : Лазурная чародейка
-- Source : https://www.wowhead.com/wotlk/ru/npc=30663
UPDATE `creature_template_locale` SET `Name` = 'Лазурный чароплет' WHERE `locale` = 'ruRU' AND `entry` = 30663;
-- OLD name : [DND] Icecrown Airship (H) - Cannon, Neutral (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30700
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30700;
-- OLD name : Огненная сфера
-- Source : https://www.wowhead.com/wotlk/ru/npc=30702
UPDATE `creature_template_locale` SET `Name` = 'Огненный шар' WHERE `locale` = 'ruRU' AND `entry` = 30702;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30707
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30707;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=30721
UPDATE `creature_template_locale` SET `Title` = 'Мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 30721;
-- OLD subname : Учитель начертания
-- Source : https://www.wowhead.com/wotlk/ru/npc=30722
UPDATE `creature_template_locale` SET `Title` = 'Мастер начертания' WHERE `locale` = 'ruRU' AND `entry` = 30722;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30749
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30749;
-- OLD name : Кор'кронский разоритель
-- Source : https://www.wowhead.com/wotlk/ru/npc=30755
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 30755;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=30832
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30832;
-- OLD name : Яростное пламя
-- Source : https://www.wowhead.com/wotlk/ru/npc=30847
UPDATE `creature_template_locale` SET `Name` = 'Бушующее пламя' WHERE `locale` = 'ruRU' AND `entry` = 30847;
-- OLD name : Инженер Озера Ледяных Оков (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30855
UPDATE `creature_template_locale` SET `Name` = 'Инженер с озера Ледяных Оков' WHERE `locale` = 'ruRU' AND `entry` = 30855;
-- OLD subname : Старинная экипировка арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=30885
UPDATE `creature_template_locale` SET `Title` = 'Продавец воды' WHERE `locale` = 'ruRU' AND `entry` = 30885;
-- OLD name : QA Test Dummy 80 Hostile Low Damage (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=30888
UPDATE `creature_template_locale` SET `Name` = 'Andrew Test Dummy 80 Hostile Low Damage' WHERE `locale` = 'ruRU' AND `entry` = 30888;
-- OLD name : Лазурная чародейка
-- Source : https://www.wowhead.com/wotlk/ru/npc=30918
UPDATE `creature_template_locale` SET `Name` = 'Лазурный чароплет' WHERE `locale` = 'ruRU' AND `entry` = 30918;
-- OLD subname : Всадник крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=30953
UPDATE `creature_template_locale` SET `Title` = 'Наездник крови' WHERE `locale` = 'ruRU' AND `entry` = 30953;
-- OLD name : Лазурный разрушитель заклятий
-- Source : https://www.wowhead.com/wotlk/ru/npc=30962
UPDATE `creature_template_locale` SET `Name` = 'Лазурный рушитель чар' WHERE `locale` = 'ruRU' AND `entry` = 30962;
-- OLD name : Лазурная чародейка
-- Source : https://www.wowhead.com/wotlk/ru/npc=31007
UPDATE `creature_template_locale` SET `Name` = 'Лазурный чароплет' WHERE `locale` = 'ruRU' AND `entry` = 31007;
-- OLD name : Лазурный разрушитель заклятий
-- Source : https://www.wowhead.com/wotlk/ru/npc=31009
UPDATE `creature_template_locale` SET `Name` = 'Лазурный рушитель чар' WHERE `locale` = 'ruRU' AND `entry` = 31009;
-- OLD name : [UNUSED] The Lich King (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=31014
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 31014;
-- OLD subname : Флорист
-- Source : https://www.wowhead.com/wotlk/ru/npc=31021
UPDATE `creature_template_locale` SET `Title` = 'Цветочник' WHERE `locale` = 'ruRU' AND `entry` = 31021;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/ru/npc=31025
UPDATE `creature_template_locale` SET `Title` = 'Боеприпасы' WHERE `locale` = 'ruRU' AND `entry` = 31025;
-- OLD name : Горящий скелет
-- Source : https://www.wowhead.com/wotlk/ru/npc=31048
UPDATE `creature_template_locale` SET `Name` = 'Пылающий скелет' WHERE `locale` = 'ruRU' AND `entry` = 31048;
-- OLD name : Лучник Рендольф
-- Source : https://www.wowhead.com/wotlk/ru/npc=31052
UPDATE `creature_template_locale` SET `Name` = 'Лучник Рандольф' WHERE `locale` = 'ruRU' AND `entry` = 31052;
-- OLD name : Russell Bernau Test NPC (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=31060
UPDATE `creature_template_locale` SET `Name` = 'Ali Garchanter [TEST]' WHERE `locale` = 'ruRU' AND `entry` = 31060;
-- OLD name : Reinforced Training Dummy (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=31143
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 31143;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31143, 'ruRU','NPC',NULL);
-- OLD name : Тренировочный манекен
-- Source : https://www.wowhead.com/wotlk/ru/npc=31144
UPDATE `creature_template_locale` SET `Name` = 'Тренировочный манекен великого мастера' WHERE `locale` = 'ruRU' AND `entry` = 31144;
-- OLD name : Тренировочный манекен рейдера
-- Source : https://www.wowhead.com/wotlk/ru/npc=31146
UPDATE `creature_template_locale` SET `Name` = 'Героический тренировочный манекен' WHERE `locale` = 'ruRU' AND `entry` = 31146;
-- OLD subname : Всадник крови
-- Source : https://www.wowhead.com/wotlk/ru/npc=31159
UPDATE `creature_template_locale` SET `Title` = 'Наездник крови' WHERE `locale` = 'ruRU' AND `entry` = 31159;
-- OLD name : V (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=31168
UPDATE `creature_template_locale` SET `Name` = 'zzOLDV' WHERE `locale` = 'ruRU' AND `entry` = 31168;
-- OLD name : [DND] Icecrown Airship Cannon Explosion Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=31246
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 31246;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=31247
UPDATE `creature_template_locale` SET `Title` = 'Инструктор полетов в непогоду' WHERE `locale` = 'ruRU' AND `entry` = 31247;
-- OLD name : Заступник Черного Клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=31250
UPDATE `creature_template_locale` SET `Name` = 'Защитник Черного Клинка' WHERE `locale` = 'ruRU' AND `entry` = 31250;
-- OLD name : Застрельщик Мрачного Свода
-- Source : https://www.wowhead.com/wotlk/ru/npc=31251
UPDATE `creature_template_locale` SET `Name` = 'Рыскатель Мрачного Свода' WHERE `locale` = 'ruRU' AND `entry` = 31251;
-- OLD name : [DND] Icecrown Airship (N) - Attack Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=31353
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 31353;
-- OLD name : Хрустальный змей
-- Source : https://www.wowhead.com/wotlk/ru/npc=31393
UPDATE `creature_template_locale` SET `Name` = 'Хрустальный дракон' WHERE `locale` = 'ruRU' AND `entry` = 31393;
-- OLD name : Валь'кира-надсмотрщица
-- Source : https://www.wowhead.com/wotlk/ru/npc=31396
UPDATE `creature_template_locale` SET `Name` = 'Валь''кира-надзиратель' WHERE `locale` = 'ruRU' AND `entry` = 31396;
-- OLD name : Лазурный чаровяз
-- Source : https://www.wowhead.com/wotlk/ru/npc=31403
UPDATE `creature_template_locale` SET `Name` = 'Лазурный чароплет' WHERE `locale` = 'ruRU' AND `entry` = 31403;
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
-- OLD name : Присутствие древнего бога
-- Source : https://www.wowhead.com/wotlk/ru/npc=31562
UPDATE `creature_template_locale` SET `Name` = 'Присутствие Древнего Бога' WHERE `locale` = 'ruRU' AND `entry` = 31562;
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
-- OLD name : Ордынский подрывник
-- Source : https://www.wowhead.com/wotlk/ru/npc=31654
UPDATE `creature_template_locale` SET `Name` = 'Ордынский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 31654;
-- OLD name : Завихрение
-- Source : https://www.wowhead.com/wotlk/ru/npc=31688
UPDATE `creature_template_locale` SET `Name` = 'Вихрь' WHERE `locale` = 'ruRU' AND `entry` = 31688;
-- OLD name : Bronze Drake (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=31696
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 31696;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31696, 'ruRU','NPC',NULL);
-- OLD name : Сумеречный дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=31698
UPDATE `creature_template_locale` SET `Name` = 'Сумеречный верховой дракон' WHERE `locale` = 'ruRU' AND `entry` = 31698;
-- OLD name : Небесный капитан Криолет
-- Source : https://www.wowhead.com/wotlk/ru/npc=31716
UPDATE `creature_template_locale` SET `Name` = 'Небесный капитан Криолёт' WHERE `locale` = 'ruRU' AND `entry` = 31716;
-- OLD name : Дворфийский хранитель душ
-- Source : https://www.wowhead.com/wotlk/ru/npc=31842
UPDATE `creature_template_locale` SET `Name` = 'Дворфский хранитель душ' WHERE `locale` = 'ruRU' AND `entry` = 31842;
-- OLD name : Наргл Гибкошнур, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=31863
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 31863;
-- OLD name : Ксази Смолюга
-- Source : https://www.wowhead.com/wotlk/ru/npc=31864
UPDATE `creature_template_locale` SET `Name` = 'Ксази Смолилка' WHERE `locale` = 'ruRU' AND `entry` = 31864;
-- OLD name : Зом Боком, subname : Младший продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=31865
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 31865;
-- OLD name : Джиун
-- Source : https://www.wowhead.com/wotlk/ru/npc=31910
UPDATE `creature_template_locale` SET `Name` = 'Джин' WHERE `locale` = 'ruRU' AND `entry` = 31910;
-- OLD name : Страж ужаса-погромщик
-- Source : https://www.wowhead.com/wotlk/ru/npc=32159
UPDATE `creature_template_locale` SET `Name` = 'Стражник ужаса-погромщик' WHERE `locale` = 'ruRU' AND `entry` = 32159;
-- OLD name : Гарольд Уинстон
-- Source : https://www.wowhead.com/wotlk/ru/npc=32172
UPDATE `creature_template_locale` SET `Name` = 'Гарольд Винстон' WHERE `locale` = 'ruRU' AND `entry` = 32172;
-- OLD name : [DND] Icecrown Airship Bomb (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=32193
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32193;
-- OLD name : Порабощенный прислужник
-- Source : https://www.wowhead.com/wotlk/ru/npc=32260
UPDATE `creature_template_locale` SET `Name` = 'Порабощенный слуга' WHERE `locale` = 'ruRU' AND `entry` = 32260;
-- OLD name : Хранитель времени
-- Source : https://www.wowhead.com/wotlk/ru/npc=32281
UPDATE `creature_template_locale` SET `Name` = 'Хранитель Времени' WHERE `locale` = 'ruRU' AND `entry` = 32281;
-- OLD name : Алумет Перерожденный
-- Source : https://www.wowhead.com/wotlk/ru/npc=32300
UPDATE `creature_template_locale` SET `Name` = 'Алумет Восходящий' WHERE `locale` = 'ruRU' AND `entry` = 32300;
-- OLD name : Драконоид из рода Бесконечности
-- Source : https://www.wowhead.com/wotlk/ru/npc=32306
UPDATE `creature_template_locale` SET `Name` = 'Дракон из рода Бесконечности' WHERE `locale` = 'ruRU' AND `entry` = 32306;
-- OLD name : Рыцарь черного клинка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32309
UPDATE `creature_template_locale` SET `Name` = 'Черный рыцарь' WHERE `locale` = 'ruRU' AND `entry` = 32309;
-- OLD name : [DND] Dalaran Sewer Arena - Controller - Death (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=32328
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32328;
-- OLD name : [DND] Dalaran Sewer Arena - Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=32339
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32339;
-- OLD name : Арджекс Сталежорц, subname : Опытный продавец экипировки арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=32359
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 32359;
-- OLD subname : Начальник снабжения ветеранскими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=32380
UPDATE `creature_template_locale` SET `Title` = 'Опытный начальник снабжения доспехами' WHERE `locale` = 'ruRU' AND `entry` = 32380;
-- OLD subname : Начальник снабжения доспехами для новичков
-- Source : https://www.wowhead.com/wotlk/ru/npc=32381
UPDATE `creature_template_locale` SET `Title` = 'Ученик начальника снабжения доспехами' WHERE `locale` = 'ruRU' AND `entry` = 32381;
-- OLD name : Сержант Громовой Рог, subname : Ученик начальника снабжения доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=32383
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'ruRU' AND `entry` = 32383;
-- OLD name : Дорисса Летуни, subname : Начальник снабжения ветеранскими доспехами
-- Source : https://www.wowhead.com/wotlk/ru/npc=32385
UPDATE `creature_template_locale` SET `Name` = 'Дорисса Волантий',`Title` = 'Опытный начальник снабжения доспехами' WHERE `locale` = 'ruRU' AND `entry` = 32385;
-- OLD name : Обезумевший беглец из деревни Инду'ле
-- Source : https://www.wowhead.com/wotlk/ru/npc=32409
UPDATE `creature_template_locale` SET `Name` = 'Выживший сумасшедший из деревни Инду''ле' WHERE `locale` = 'ruRU' AND `entry` = 32409;
-- OLD subname : Учитель рыбной ловли
-- Source : https://www.wowhead.com/wotlk/ru/npc=32474
UPDATE `creature_template_locale` SET `Title` = 'Великий рыбак' WHERE `locale` = 'ruRU' AND `entry` = 32474;
-- OLD name : [UNUSED] Spirit Healer (WGA) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=32536
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32536;
-- OLD name : Тренировочный манекен верховного лорда
-- Source : https://www.wowhead.com/wotlk/ru/npc=32547
UPDATE `creature_template_locale` SET `Name` = 'Наставник Немезиды верховного лорда' WHERE `locale` = 'ruRU' AND `entry` = 32547;
-- OLD name : Превращенная черная кошка (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=32570
UPDATE `creature_template_locale` SET `Name` = 'Жертва превращения в черную кошку' WHERE `locale` = 'ruRU' AND `entry` = 32570;
-- OLD name : Riding Protodrake, Blue (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=32585
UPDATE `creature_template_locale` SET `Name` = 'Синий ездовой протодракон' WHERE `locale` = 'ruRU' AND `entry` = 32585;
-- OLD name : Riding Protodrake, Bronze (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=32586
UPDATE `creature_template_locale` SET `Name` = 'Бронзовый ездовой протодракон' WHERE `locale` = 'ruRU' AND `entry` = 32586;
-- OLD name : Протодракончик
-- Source : https://www.wowhead.com/wotlk/ru/npc=32592
UPDATE `creature_template_locale` SET `Name` = 'Детеныш протодракона' WHERE `locale` = 'ruRU' AND `entry` = 32592;
-- OLD name : [DND] Cosmetic Book (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=32606
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32606;
-- OLD subname : Странствующий торговец
-- Source : https://www.wowhead.com/wotlk/ru/npc=32638
UPDATE `creature_template_locale` SET `Title` = 'Товары для путешественников' WHERE `locale` = 'ruRU' AND `entry` = 32638;
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
-- OLD name : Web Wrap Visual
-- Source : https://www.wowhead.com/wotlk/ru/npc=32785
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 32785;
-- OLD name : Портал для возвращения с Лунной поляны
-- Source : https://www.wowhead.com/wotlk/ru/npc=32788
UPDATE `creature_template_locale` SET `Name` = 'Портал для возвращения из Лунной поляны' WHERE `locale` = 'ruRU' AND `entry` = 32788;
-- OLD name : Превращенный кролик (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=32789
UPDATE `creature_template_locale` SET `Name` = 'Жертва превращения в кролика' WHERE `locale` = 'ruRU' AND `entry` = 32789;
-- OLD name : Страж огня Ревущего фьорда
-- Source : https://www.wowhead.com/wotlk/ru/npc=32804
UPDATE `creature_template_locale` SET `Name` = 'Страж огня Ревущего Фьорда' WHERE `locale` = 'ruRU' AND `entry` = 32804;
-- OLD name : Хранитель огня Ревущего фьорда
-- Source : https://www.wowhead.com/wotlk/ru/npc=32812
UPDATE `creature_template_locale` SET `Name` = 'Хранитель огня Ревущего Фьорда' WHERE `locale` = 'ruRU' AND `entry` = 32812;
-- OLD name : [PH] Pilgrim's Bounty Table - Turkey (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=32824
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32824;
-- OLD name : [PH] Pilgrim's Bounty Table - Yams (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=32825
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32825;
-- OLD name : [PH] Pilgrim's Bounty Table - Cranberry Sauce (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=32827
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32827;
-- OLD name : [PH] Pilgrim's Bounty Table - Pie (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=32829
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32829;
-- OLD name : [PH] Pilgrim's Bounty Table - Stuffing (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=32831
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 32831;
-- OLD name : Кровавый страж Зар'ши
-- Source : https://www.wowhead.com/wotlk/ru/npc=32832
UPDATE `creature_template_locale` SET `Name` = 'Кровь стража Зар''ши' WHERE `locale` = 'ruRU' AND `entry` = 32832;
-- OLD name : Разработчики WoW
-- Source : https://www.wowhead.com/wotlk/ru/npc=32842
UPDATE `creature_template_locale` SET `Name` = 'Команда разработчиков WoW' WHERE `locale` = 'ruRU' AND `entry` = 32842;
-- OLD name : Пленный наемник
-- Source : https://www.wowhead.com/wotlk/ru/npc=32883
UPDATE `creature_template_locale` SET `Name` = 'Пленный солдат' WHERE `locale` = 'ruRU' AND `entry` = 32883;
-- OLD name : Пленный наемник
-- Source : https://www.wowhead.com/wotlk/ru/npc=32885
UPDATE `creature_template_locale` SET `Name` = 'Пленный солдат' WHERE `locale` = 'ruRU' AND `entry` = 32885;
-- OLD name : Ледяная вспышка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32926
UPDATE `creature_template_locale` SET `Name` = 'Ледяная ловушка' WHERE `locale` = 'ruRU' AND `entry` = 32926;
-- OLD name : Ледяная вспышка
-- Source : https://www.wowhead.com/wotlk/ru/npc=32938
UPDATE `creature_template_locale` SET `Name` = 'Ледяная ловушка' WHERE `locale` = 'ruRU' AND `entry` = 32938;
-- OLD name : Олешек
-- Source : https://www.wowhead.com/wotlk/ru/npc=32939
UPDATE `creature_template_locale` SET `Name` = 'Олененок' WHERE `locale` = 'ruRU' AND `entry` = 32939;
-- OLD name : Взрывающаяся звезда
-- Source : https://www.wowhead.com/wotlk/ru/npc=32955
UPDATE `creature_template_locale` SET `Name` = 'Вспыхивающая звезда' WHERE `locale` = 'ruRU' AND `entry` = 32955;
-- OLD name : Прислужник клана Темных Рун (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=32957
UPDATE `creature_template_locale` SET `Name` = 'Прислужник из клана Темных Рун' WHERE `locale` = 'ruRU' AND `entry` = 32957;
-- OLD name : Элементаль молний
-- Source : https://www.wowhead.com/wotlk/ru/npc=32958
UPDATE `creature_template_locale` SET `Name` = 'Наэлектризованный элементаль' WHERE `locale` = 'ruRU' AND `entry` = 32958;
-- OLD name : Самец ледолапого медведя
-- Source : https://www.wowhead.com/wotlk/ru/npc=33008
UPDATE `creature_template_locale` SET `Name` = 'Самец ледопалого медведя' WHERE `locale` = 'ruRU' AND `entry` = 33008;
-- OLD name : Самка ледолапого медведя
-- Source : https://www.wowhead.com/wotlk/ru/npc=33011
UPDATE `creature_template_locale` SET `Name` = 'Самка ледопалого медведя' WHERE `locale` = 'ruRU' AND `entry` = 33011;
-- OLD subname : Продавец алкогольных напитков
-- Source : https://www.wowhead.com/wotlk/ru/npc=33026
UPDATE `creature_template_locale` SET `Title` = 'Алкоголь' WHERE `locale` = 'ruRU' AND `entry` = 33026;
-- OLD name : [ph] justin test backstab target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33049
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33049;
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
-- OLD name : [DND] TAR Pedestal - Trainer, Death Knight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33252
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33252;
-- OLD name : [DND] Tournament - TEST NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33305
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33305;
-- OLD name : [DND] Tournament - Ranged Target Dummy - Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33339
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33339;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Charge Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33340
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33340;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Block Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33341
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33341;
-- OLD name : Morgan Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=33351
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33351;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (33351, 'ruRU','NPC',NULL);
-- OLD name : Сетка наведения адского огня Мимирона
-- Source : https://www.wowhead.com/wotlk/ru/npc=33369
UPDATE `creature_template_locale` SET `Name` = 'Сетка наведения инферналя Мимирона' WHERE `locale` = 'ruRU' AND `entry` = 33369;
-- OLD name : Ловчий смерти Визери
-- Source : https://www.wowhead.com/wotlk/ru/npc=33373
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти Визери' WHERE `locale` = 'ruRU' AND `entry` = 33373;
-- OLD name : Боевой конь Отрекшихся
-- Source : https://www.wowhead.com/wotlk/ru/npc=33414
UPDATE `creature_template_locale` SET `Name` = 'Стремительный боевой конь Отрекшихся' WHERE `locale` = 'ruRU' AND `entry` = 33414;
-- OLD name : [ph] Tournament War Elekk - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33415
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33415;
-- OLD name : Лесной плеточник
-- Source : https://www.wowhead.com/wotlk/ru/npc=33431
UPDATE `creature_template_locale` SET `Name` = 'Лесной ползун' WHERE `locale` = 'ruRU' AND `entry` = 33431;
-- OLD name : Чемпион Сен'джина
-- Source : https://www.wowhead.com/wotlk/ru/npc=33474
UPDATE `creature_template_locale` SET `Name` = 'Чемпион Сен''джин' WHERE `locale` = 'ruRU' AND `entry` = 33474;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 01 - Weak Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33489
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33489;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 02 -Speedy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33490
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33490;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 03 - Block Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33491
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33491;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 04 - Strong Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33492
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33492;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 05 - Ultimate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33493
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33493;
-- OLD name : [ph] Tournament - Daily Combatant Summoner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33501
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33501;
-- OLD name : Приручаемая гончая Недр (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=33502
UPDATE `creature_template_locale` SET `Name` = 'Приручаемая гончая недр' WHERE `locale` = 'ruRU' AND `entry` = 33502;
-- OLD name : Трещина в земле
-- Source : https://www.wowhead.com/wotlk/ru/npc=33516
UPDATE `creature_template_locale` SET `Name` = 'Трещина в почве' WHERE `locale` = 'ruRU' AND `entry` = 33516;
-- OLD name : Грифон Черного рыцаря
-- Source : https://www.wowhead.com/wotlk/ru/npc=33519
UPDATE `creature_template_locale` SET `Name` = 'Черный боевой грифон' WHERE `locale` = 'ruRU' AND `entry` = 33519;
-- OLD name : [ph] Tournament - Mounted Combatant - Valiant Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33520
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33520;
-- OLD name : [ph] Tournament - Mounted Combatant - Champion Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33521
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33521;
-- OLD name : Волчер-сирота
-- Source : https://www.wowhead.com/wotlk/ru/npc=33532
UPDATE `creature_template_locale` SET `Name` = 'Сиротка-волчер' WHERE `locale` = 'ruRU' AND `entry` = 33532;
-- OLD name : Оракул-сирота
-- Source : https://www.wowhead.com/wotlk/ru/npc=33533
UPDATE `creature_template_locale` SET `Name` = 'Сиротка-оракул' WHERE `locale` = 'ruRU' AND `entry` = 33533;
-- OLD subname : Знаток лошадей
-- Source : https://www.wowhead.com/wotlk/ru/npc=33547
UPDATE `creature_template_locale` SET `Title` = 'Специалист по лошадям' WHERE `locale` = 'ruRU' AND `entry` = 33547;
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
-- OLD subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=33701
UPDATE `creature_template_locale` SET `Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 33701;
-- OLD name : Чемпион Сен'джина
-- Source : https://www.wowhead.com/wotlk/ru/npc=33745
UPDATE `creature_template_locale` SET `Name` = 'Чемпион Сен''джин' WHERE `locale` = 'ruRU' AND `entry` = 33745;
-- OLD name : Рокотан клана Темных Рун
-- Source : https://www.wowhead.com/wotlk/ru/npc=33754
UPDATE `creature_template_locale` SET `Name` = 'Рокотун из клана Темных Рун' WHERE `locale` = 'ruRU' AND `entry` = 33754;
-- OLD name : Опустошитель из клана Темных Рун
-- Source : https://www.wowhead.com/wotlk/ru/npc=33755
UPDATE `creature_template_locale` SET `Name` = 'Разрушитель из клана Темных Рун' WHERE `locale` = 'ruRU' AND `entry` = 33755;
-- OLD name : [ph] test tournament charger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=33784
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 33784;
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
-- OLD name : Точки фокусировки Мимирона
-- Source : https://www.wowhead.com/wotlk/ru/npc=33835
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 33835;
-- OLD subname : Эмблема завоевания Интендант
-- Source : https://www.wowhead.com/wotlk/ru/npc=33963
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы завоевания' WHERE `locale` = 'ruRU' AND `entry` = 33963;
-- OLD subname : Эмблема завоевания Интендант
-- Source : https://www.wowhead.com/wotlk/ru/npc=33964
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы завоевания' WHERE `locale` = 'ruRU' AND `entry` = 33964;
-- OLD name : Портал Бездны
-- Source : https://www.wowhead.com/wotlk/ru/npc=34001
UPDATE `creature_template_locale` SET `Name` = 'Зона вакуума' WHERE `locale` = 'ruRU' AND `entry` = 34001;
-- OLD name : Рация Бронзоборода
-- Source : https://www.wowhead.com/wotlk/ru/npc=34054
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'ruRU' AND `entry` = 34054;
-- OLD name : Чумная костяная телега (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=34128
UPDATE `creature_template_locale` SET `Name` = 'Чумной костяной фургон' WHERE `locale` = 'ruRU' AND `entry` = 34128;
-- OLD name : Ядошкурый равазавр
-- Source : https://www.wowhead.com/wotlk/ru/npc=34156
UPDATE `creature_template_locale` SET `Name` = 'Верховой ядошкурый равазавр' WHERE `locale` = 'ruRU' AND `entry` = 34156;
-- OLD name : Механогномский танк
-- Source : https://www.wowhead.com/wotlk/ru/npc=34164
UPDATE `creature_template_locale` SET `Name` = 'Мехагномский танк' WHERE `locale` = 'ruRU' AND `entry` = 34164;
-- OLD name : Страж передней
-- Source : https://www.wowhead.com/wotlk/ru/npc=34197
UPDATE `creature_template_locale` SET `Name` = 'Страж Вестибюля' WHERE `locale` = 'ruRU' AND `entry` = 34197;
-- OLD name : Взрыв мины
-- Source : https://www.wowhead.com/wotlk/ru/npc=34223
UPDATE `creature_template_locale` SET `Name` = 'Взрыв сапера' WHERE `locale` = 'ruRU' AND `entry` = 34223;
-- OLD name : [DND]Azeroth Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34281
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34281;
-- OLD name : [DND] Champion Go-To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34319
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34319;
-- OLD name : [DND]Northrend Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34381
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34381;
-- OLD name : Оракул-сирота
-- Source : https://www.wowhead.com/wotlk/ru/npc=34519
UPDATE `creature_template_locale` SET `Name` = 'Сиротка-оракул' WHERE `locale` = 'ruRU' AND `entry` = 34519;
-- OLD name : Волчер-сирота
-- Source : https://www.wowhead.com/wotlk/ru/npc=34520
UPDATE `creature_template_locale` SET `Name` = 'Сиротка-волчер' WHERE `locale` = 'ruRU' AND `entry` = 34520;
-- OLD name : ScottM Test Creature (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=34533
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34533;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (34533, 'ruRU','NPC',NULL);
-- OLD name : [DND] Stink Bomb Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34562
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34562;
-- OLD name : [DND] Warbot - Blue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34588
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34588;
-- OLD name : [DND] Warbot - Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34589
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34589;
-- OLD name : Нерубский копатель
-- Source : https://www.wowhead.com/wotlk/ru/npc=34607
UPDATE `creature_template_locale` SET `Name` = 'Нерубский землеглот' WHERE `locale` = 'ruRU' AND `entry` = 34607;
-- OLD name : Техник Дробз
-- Source : https://www.wowhead.com/wotlk/ru/npc=34719
UPDATE `creature_template_locale` SET `Name` = 'Техник Щебняк' WHERE `locale` = 'ruRU' AND `entry` = 34719;
-- OLD name : [DND] Magic Rooster (Tauren Male) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34732
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34732;
-- OLD name : Вильям Маллинс
-- Source : https://www.wowhead.com/wotlk/ru/npc=34768
UPDATE `creature_template_locale` SET `Name` = 'Вилльям Маллинс' WHERE `locale` = 'ruRU' AND `entry` = 34768;
-- OLD name : [ph] Argent Raid Spectator - FX - Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34883
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34883;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34887
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34887;
-- OLD name : [PH] Goss Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34889
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34889;
-- OLD name : [PH] Tournament Hippogryph Quest Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34891
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34891;
-- OLD name : [PH] Stabled Argent Hippogryph (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34893
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34893;
-- OLD name : [ph] Argent Raid Spectator - FX - Human (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34900
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34900;
-- OLD name : [ph] Argent Raid Spectator - FX - Orc (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34901
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34901;
-- OLD name : [ph] Argent Raid Spectator - FX - Troll (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34902
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34902;
-- OLD name : [ph] Argent Raid Spectator - FX - Tauren (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34903
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34903;
-- OLD name : [ph] Argent Raid Spectator - FX - Blood Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34904
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34904;
-- OLD name : [ph] Argent Raid Spectator - FX - Undead (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34905
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34905;
-- OLD name : [ph] Argent Raid Spectator - FX - Dwarf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34906
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34906;
-- OLD name : [ph] Argent Raid Spectator - FX - Draenei (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34908
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34908;
-- OLD name : [ph] Argent Raid Spectator - FX - Night Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34909
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34909;
-- OLD name : [ph] Argent Raid Spectator - FX - Gnome (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=34910
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 34910;
-- OLD name : Глубинный йормунгар
-- Source : https://www.wowhead.com/wotlk/ru/npc=34920
UPDATE `creature_template_locale` SET `Name` = 'Глубинный йогмунгар' WHERE `locale` = 'ruRU' AND `entry` = 34920;
-- OLD name : Плакия
-- Source : https://www.wowhead.com/wotlk/ru/npc=34985
UPDATE `creature_template_locale` SET `Name` = 'Мизери' WHERE `locale` = 'ruRU' AND `entry` = 34985;
-- OLD name : [ph] Argent Raid Spectator - Generic Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=35016
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 35016;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance Fireworks NOT USED (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=35066
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 35066;
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
-- OLD subname : Укротитель грифонов
-- Source : https://www.wowhead.com/wotlk/ru/npc=35131
UPDATE `creature_template_locale` SET `Title` = 'Хозяин грифонов' WHERE `locale` = 'ruRU' AND `entry` = 35131;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=35133
UPDATE `creature_template_locale` SET `Title` = 'Учитель верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 35133;
-- OLD subname : Летный инструктор
-- Source : https://www.wowhead.com/wotlk/ru/npc=35135
UPDATE `creature_template_locale` SET `Title` = 'Учитель верховой езды' WHERE `locale` = 'ruRU' AND `entry` = 35135;
-- OLD name : Серебряный гиппогриф (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=35146
UPDATE `creature_template_locale` SET `Name` = 'Гиппогриф Серебряного Авангарда' WHERE `locale` = 'ruRU' AND `entry` = 35146;
-- OLD subname : Наставница паладинов
-- Source : https://www.wowhead.com/wotlk/ru/npc=35281
UPDATE `creature_template_locale` SET `Title` = 'Наставник паладинов' WHERE `locale` = 'ruRU' AND `entry` = 35281;
-- OLD name : Королевский стражник Штормграда
-- Source : https://www.wowhead.com/wotlk/ru/npc=35322
UPDATE `creature_template_locale` SET `Name` = 'Королевский страж Штормграда' WHERE `locale` = 'ruRU' AND `entry` = 35322;
-- OLD name : Чемпион Сен'джина
-- Source : https://www.wowhead.com/wotlk/ru/npc=35323
UPDATE `creature_template_locale` SET `Name` = 'Чемпион Сен''джин' WHERE `locale` = 'ruRU' AND `entry` = 35323;
-- OLD name : Детеныш из Гундрака
-- Source : https://www.wowhead.com/wotlk/ru/npc=35400
UPDATE `creature_template_locale` SET `Name` = 'Детеныш Гундрака' WHERE `locale` = 'ruRU' AND `entry` = 35400;
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
-- OLD subname : Механический аукционист
-- Source : https://www.wowhead.com/wotlk/ru/npc=35594
UPDATE `creature_template_locale` SET `Title` = 'Механический аукционер' WHERE `locale` = 'ruRU' AND `entry` = 35594;
-- OLD subname : Механический аукционист
-- Source : https://www.wowhead.com/wotlk/ru/npc=35607
UPDATE `creature_template_locale` SET `Title` = 'Механический аукционер' WHERE `locale` = 'ruRU' AND `entry` = 35607;
-- OLD name : [DND] Dalaran Argent Tournament Herald Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=35608
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 35608;
-- OLD name : Кошка
-- Source : https://www.wowhead.com/wotlk/ru/npc=35610
UPDATE `creature_template_locale` SET `Name` = 'Кот' WHERE `locale` = 'ruRU' AND `entry` = 35610;
-- OLD name : Ловчий смерти Визери
-- Source : https://www.wowhead.com/wotlk/ru/npc=35617
UPDATE `creature_template_locale` SET `Name` = 'Страж смерти Визери' WHERE `locale` = 'ruRU' AND `entry` = 35617;
-- OLD name : Скакун ловчего смерти Визери
-- Source : https://www.wowhead.com/wotlk/ru/npc=35634
UPDATE `creature_template_locale` SET `Name` = 'Скакун стража смерти Визери' WHERE `locale` = 'ruRU' AND `entry` = 35634;
-- OLD name : [DNT] Test Dragonhawk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=35983
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 35983;
-- OLD name : [DND] Valgarde Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36154
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36154;
-- OLD name : Кор'кронский разоритель
-- Source : https://www.wowhead.com/wotlk/ru/npc=36164
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 36164;
-- OLD name : Морской пехотинец 7-го легиона
-- Source : https://www.wowhead.com/wotlk/ru/npc=36166
UPDATE `creature_template_locale` SET `Name` = 'Моряк 7-го легиона' WHERE `locale` = 'ruRU' AND `entry` = 36166;
-- OLD name : [DND] Bor'gorok Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36167
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36167;
-- OLD name : [DND] Bor'gorok Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36169
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36169;
-- OLD name : [DND]Northrend Children's Week Trigger 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36209
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36209;
-- OLD name : [DND] Crazed Apothecary Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36212
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36212;
-- OLD name : Надзиратель Краггош (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=36217
UPDATE `creature_template_locale` SET `Name` = 'Изуродованное тело' WHERE `locale` = 'ruRU' AND `entry` = 36217;
-- OLD name : Стремительный ордынский волк
-- Source : https://www.wowhead.com/wotlk/ru/npc=36223
UPDATE `creature_template_locale` SET `Name` = 'Стремительный волк Орды' WHERE `locale` = 'ruRU' AND `entry` = 36223;
-- OLD subname : Ловчие смерти
-- Source : https://www.wowhead.com/wotlk/ru/npc=36517
UPDATE `creature_template_locale` SET `Title` = 'Стражи смерти' WHERE `locale` = 'ruRU' AND `entry` = 36517;
-- OLD name : [DND] Valentine Boss - Vial Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36530
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36530;
-- OLD name : [DND] Valentine Boss Manager (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36643
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36643;
-- OLD name : [DND] Apothecary Table (Spell Effect) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36710
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36710;
-- OLD name : [PH] Icecrown Reanimated Crusader (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36726
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36726;
-- OLD name : Представитель Серебряного союза
-- Source : https://www.wowhead.com/wotlk/ru/npc=36774
UPDATE `creature_template_locale` SET `Name` = 'Посланник Серебряного союза' WHERE `locale` = 'ruRU' AND `entry` = 36774;
-- OLD subname : Спутник ночного эльфа – ирокеза (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=36778
UPDATE `creature_template_locale` SET `Title` = 'Спутник ночного эльфа - ирокеза' WHERE `locale` = 'ruRU' AND `entry` = 36778;
-- OLD name : [PH] Unused Quarry Overseer (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=36792
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36792;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36792, 'ruRU','NPC',NULL);
-- OLD name : [DND] Love Boat Summoner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36817
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36817;
-- OLD name : [PH] Icecrown Gauntlet Ghoul (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36875
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36875;
-- OLD name : Gryphon Hatchling 3.3.0 (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=36904
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36904;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36904, 'ruRU','NPC',NULL);
-- OLD name : Кор'кронский разоритель
-- Source : https://www.wowhead.com/wotlk/ru/npc=36957
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 36957;
-- OLD name : [DND] World Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=36966
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 36966;
-- OLD name : Ледяная гробница
-- Source : https://www.wowhead.com/wotlk/ru/npc=36980
UPDATE `creature_template_locale` SET `Name` = 'Ледяной склеп' WHERE `locale` = 'ruRU' AND `entry` = 36980;
-- OLD name : Липкая жижа
-- Source : https://www.wowhead.com/wotlk/ru/npc=37006
UPDATE `creature_template_locale` SET `Name` = 'Липучий слизнюк' WHERE `locale` = 'ruRU' AND `entry` = 37006;
-- OLD name : Кор'кронский разоритель
-- Source : https://www.wowhead.com/wotlk/ru/npc=37029
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 37029;
-- OLD name : [DND]Ground Cover Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37039
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37039;
-- OLD name : Колдун с "Усмирителя небес"
-- Source : https://www.wowhead.com/wotlk/ru/npc=37116
UPDATE `creature_template_locale` SET `Name` = 'Колдун "Усмирителя небес"' WHERE `locale` = 'ruRU' AND `entry` = 37116;
-- OLD name : [PH] Icecrown Shade (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37128
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37128;
-- OLD name : [DND] Summon Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37168
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37168;
-- OLD name : Командир Джастин Бартлетт
-- Source : https://www.wowhead.com/wotlk/ru/npc=37182
UPDATE `creature_template_locale` SET `Name` = 'Старший капитан Джастин Бартлетт' WHERE `locale` = 'ruRU' AND `entry` = 37182;
-- OLD name : [PH] Ice Stone 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37191
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37191;
-- OLD name : [PH] Ice Stone 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37192
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37192;
-- OLD name : [DND] Summon Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37201
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37201;
-- OLD name : [DND] Summon Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37202
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37202;
-- OLD subname : Рыцарь ордена Серебряной Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=37225
UPDATE `creature_template_locale` SET `Title` = 'Рыцарь Серебряной Длани' WHERE `locale` = 'ruRU' AND `entry` = 37225;
-- OLD name : Боец Служителей Льда
-- Source : https://www.wowhead.com/wotlk/ru/npc=37531
UPDATE `creature_template_locale` SET `Name` = 'Рабочий Служителей Льда' WHERE `locale` = 'ruRU' AND `entry` = 37531;
-- OLD name : [DND] Shaker (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37543
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37543;
-- OLD name : [DND]Something Stinks Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37558
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37558;
-- OLD name : [DND] Shaker - Small (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37574
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37574;
-- OLD name : Командир Алеча Сегард (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=37693
UPDATE `creature_template_locale` SET `Name` = 'Командор Алеша Сегар' WHERE `locale` = 'ruRU' AND `entry` = 37693;
-- OLD name : Драган Большой Глоток, subname : Лига исследователей
-- Source : https://www.wowhead.com/wotlk/ru/npc=37742
UPDATE `creature_template_locale` SET `Name` = 'Другган Большой Глоток',`Title` = 'Лига Исследователей' WHERE `locale` = 'ruRU' AND `entry` = 37742;
-- OLD subname : Правящий лорд Кель'Таласа (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=37764
UPDATE `creature_template_locale` SET `Title` = 'Лорд-регент Кель''Таласа' WHERE `locale` = 'ruRU' AND `entry` = 37764;
-- OLD name : [PH] Runner Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37788
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37788;
-- OLD name : Дарнасский часовой (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=37790
UPDATE `creature_template_locale` SET `Name` = 'Дарнасская часовая' WHERE `locale` = 'ruRU' AND `entry` = 37790;
-- OLD name : Злой дух
-- Source : https://www.wowhead.com/wotlk/ru/npc=37799
UPDATE `creature_template_locale` SET `Name` = 'Зловещий дух' WHERE `locale` = 'ruRU' AND `entry` = 37799;
-- OLD name : [PH] Captain (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37831
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37831;
-- OLD name : Огненный левиафан (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=37856
UPDATE `creature_template_locale` SET `Name` = '"Огненный Левиафан"' WHERE `locale` = 'ruRU' AND `entry` = 37856;
-- OLD name : Проекция Повелителя Горнов Игниса (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=37859
UPDATE `creature_template_locale` SET `Name` = 'Проекция повелителя горнов Игниса' WHERE `locale` = 'ruRU' AND `entry` = 37859;
-- OLD name : Кор'кронский разоритель
-- Source : https://www.wowhead.com/wotlk/ru/npc=37920
UPDATE `creature_template_locale` SET `Name` = 'Кор''кронский разрушитель' WHERE `locale` = 'ruRU' AND `entry` = 37920;
-- OLD subname : Эмблема интенданта Мороза
-- Source : https://www.wowhead.com/wotlk/ru/npc=37941
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы льда' WHERE `locale` = 'ruRU' AND `entry` = 37941;
-- OLD subname : Эмблема интенданта Мороза
-- Source : https://www.wowhead.com/wotlk/ru/npc=37942
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы льда' WHERE `locale` = 'ruRU' AND `entry` = 37942;
-- OLD name : [DND] Love Boat Summoner 02 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37964
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37964;
-- OLD name : [DND] Love Boat Summoner 03 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37981
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37981;
-- OLD name : [DND] Sample Quest Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=37990
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 37990;
-- OLD subname : Повелительница рыцарей крови (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=38052
UPDATE `creature_template_locale` SET `Title` = 'Матриарх рыцарей крови' WHERE `locale` = 'ruRU' AND `entry` = 38052;
-- OLD name : [DND] Fire Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38053
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38053;
-- OLD name : Горожанин Оргриммара (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=38067
UPDATE `creature_template_locale` SET `Name` = 'Житель Оргриммара' WHERE `locale` = 'ruRU' AND `entry` = 38067;
-- OLD name : [PH] Captain (Orgrimmar) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38164
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38164;
-- OLD name : Представитель Серебряного союза
-- Source : https://www.wowhead.com/wotlk/ru/npc=38200
UPDATE `creature_template_locale` SET `Name` = 'Посланник Серебряного союза' WHERE `locale` = 'ruRU' AND `entry` = 38200;
-- OLD name : Большая ракета любви
-- Source : https://www.wowhead.com/wotlk/ru/npc=38204
UPDATE `creature_template_locale` SET `Name` = '"Сердцеед" X-45' WHERE `locale` = 'ruRU' AND `entry` = 38204;
-- OLD name : Большая ракета любви (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=38207
UPDATE `creature_template_locale` SET `Name` = '"Сердцеед" X-45' WHERE `locale` = 'ruRU' AND `entry` = 38207;
-- OLD name : Мстительная тень
-- Source : https://www.wowhead.com/wotlk/ru/npc=38222
UPDATE `creature_template_locale` SET `Name` = 'Мстительный дух' WHERE `locale` = 'ruRU' AND `entry` = 38222;
-- OLD name : [DND] Fire Wall - No Scaling (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38226
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38226;
-- OLD name : [DND] Fire Wall (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38230
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38230;
-- OLD name : [DND] Fire Strat (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38236
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38236;
-- OLD name : [DND] Holiday - Love - Bank Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38340
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38340;
-- OLD name : [DND] Holiday - Love - AH Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38341
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38341;
-- OLD name : [DND] Holiday - Love - Barber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38342
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38342;
-- OLD name : Сфера Кровавой Королевы (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=38353
UPDATE `creature_template_locale` SET `Name` = 'Сфера кровавой королевы' WHERE `locale` = 'ruRU' AND `entry` = 38353;
-- OLD name : [PH] Matt Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38580
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38580;
-- OLD name : [PH] Matt Test NPC 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38581
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38581;
-- OLD subname : Рыцарь ордена Серебряной Длани
-- Source : https://www.wowhead.com/wotlk/ru/npc=38608
UPDATE `creature_template_locale` SET `Title` = 'Рыцарь Серебряной Длани' WHERE `locale` = 'ruRU' AND `entry` = 38608;
-- OLD name : [PH] Grimtotem Protector (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38830
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38830;
-- OLD name : [PH] Grimtotem Collector (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38843
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38843;
-- OLD name : [PH] Slain Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38846
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38846;
-- OLD subname : Старинные награды за очки справедливости
-- Source : https://www.wowhead.com/wotlk/ru/npc=38858
UPDATE `creature_template_locale` SET `Title` = 'Награды за эмблемы льда' WHERE `locale` = 'ruRU' AND `entry` = 38858;
-- OLD name : [DND] Dark Iron Guard Move To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38870
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38870;
-- OLD name : [DND] Mole Machine Spawner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38882
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38882;
-- OLD name : ScottG Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=38883
UPDATE `creature_template_locale` SET `Name` = 'Idle Before Scaling' WHERE `locale` = 'ruRU' AND `entry` = 38883;
-- OLD name : [PH] Grimtotem Vendor (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=38905
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 38905;
-- OLD name : [DND] TB Event Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39023
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39023;
-- OLD name : [DND] Fire Strat Auto (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39057
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39057;
-- OLD name : [PH] Orc Firefighter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39058
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39058;
-- OLD name : Ловушка духов
-- Source : https://www.wowhead.com/wotlk/ru/npc=39189
UPDATE `creature_template_locale` SET `Name` = 'Взрывной дух' WHERE `locale` = 'ruRU' AND `entry` = 39189;
-- OLD name : [DND] Flying Machine (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39229
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39229;
-- OLD name : Горожанин Оргриммара (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=39343
UPDATE `creature_template_locale` SET `Name` = 'Житель Оргриммара' WHERE `locale` = 'ruRU' AND `entry` = 39343;
-- OLD name : [DND] Salute Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39355
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39355;
-- OLD name : [DND] Roar Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39356
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39356;
-- OLD name : [DND] Dance Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39361
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39361;
-- OLD name : [DND] Cheer Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39362
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39362;
-- OLD name : [DND] Probe Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39420
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39420;
-- OLD name : Горожанин Оргриммара (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=39632
UPDATE `creature_template_locale` SET `Name` = 'Житель Оргриммара' WHERE `locale` = 'ruRU' AND `entry` = 39632;
-- OLD name : [DND] Quest Credit Bunny - Eject (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39683
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39683;
-- OLD name : [DND] Quest Credit Bunny - Move 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39691
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39691;
-- OLD name : [DND] Quest Credit Bunny - Move 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39692
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39692;
-- OLD name : [DND] Quest Credit Bunny - Move 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39695
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39695;
-- OLD name : [DND] Quest Credit Bunny - Attack (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39703
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39703;
-- OLD name : [DND] Attack Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39707
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39707;
-- OLD name : [DND] GT Bomber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39743
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39743;
-- OLD name : [PH] Mother Trogg (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39798
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39798;
-- OLD name : [DND] Boom Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=39841
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 39841;
-- OLD name : Бушующий дух огня (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=39852
UPDATE `creature_template_locale` SET `Name` = 'Бушующий элементаль огня' WHERE `locale` = 'ruRU' AND `entry` = 39852;
-- OLD name : Сфера Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=40083
UPDATE `creature_template_locale` SET `Name` = 'Темный шар' WHERE `locale` = 'ruRU' AND `entry` = 40083;
-- OLD name : Сфера Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=40100
UPDATE `creature_template_locale` SET `Name` = 'Темный шар' WHERE `locale` = 'ruRU' AND `entry` = 40100;
-- OLD name : Воин Тики (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=40199
UPDATE `creature_template_locale` SET `Name` = 'Воин тики' WHERE `locale` = 'ruRU' AND `entry` = 40199;
-- OLD subname : Старинное оружие арены
-- Source : https://www.wowhead.com/wotlk/ru/npc=40212
UPDATE `creature_template_locale` SET `Title` = 'Исключительное оружие для арены' WHERE `locale` = 'ruRU' AND `entry` = 40212;
-- OLD subname : Старинное оружие арены (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=40216
UPDATE `creature_template_locale` SET `Title` = 'Яростный гладиатор' WHERE `locale` = 'ruRU' AND `entry` = 40216;
-- OLD name : Проклятый свирепый тролль (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=40225
UPDATE `creature_template_locale` SET `Name` = 'Проклятый тролль-громила' WHERE `locale` = 'ruRU' AND `entry` = 40225;
-- OLD name : Воин Тики (RETAIL DATAS)
-- Source : https://www.wowhead.com/ru/npc=40263
UPDATE `creature_template_locale` SET `Name` = 'Воин тики' WHERE `locale` = 'ruRU' AND `entry` = 40263;
-- OLD name : [DND] Zen'tabra Cat Form (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=40265
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 40265;
-- OLD name : Болид "Бей-Молоти"
-- Source : https://www.wowhead.com/wotlk/ru/npc=40281
UPDATE `creature_template_locale` SET `Name` = 'Болид Бей-Молоти' WHERE `locale` = 'ruRU' AND `entry` = 40281;
-- OLD name : Синий заводной ракетобот
-- Source : https://www.wowhead.com/wotlk/ru/npc=40295
UPDATE `creature_template_locale` SET `Name` = 'Заводной ракетобот' WHERE `locale` = 'ruRU' AND `entry` = 40295;
-- OLD name : [DND] Quest Credit Bunny - ET Battle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=40428
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 40428;
-- OLD name : Сфера Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=40468
UPDATE `creature_template_locale` SET `Name` = 'Темный шар' WHERE `locale` = 'ruRU' AND `entry` = 40468;
-- OLD name : Сфера Тьмы
-- Source : https://www.wowhead.com/wotlk/ru/npc=40469
UPDATE `creature_template_locale` SET `Name` = 'Темный шар' WHERE `locale` = 'ruRU' AND `entry` = 40469;
-- OLD name : [DND] Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=40617
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 40617;
-- OLD name : Рубиновый дракон
-- Source : https://www.wowhead.com/wotlk/ru/npc=40627
UPDATE `creature_template_locale` SET `Name` = 'Рубиновый дракончик' WHERE `locale` = 'ruRU' AND `entry` = 40627;
-- OLD name : [DND] Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/ru/npc=41839
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 41839;

-- List of entries using retail datas :
-- 81,444,3718,6783,15713,17733,23629,23630,23631,23632,23633,23634,23715,23726,23808,24109,24181,24377,24378,24692,24693,24695,24699,25263,25463,26080,26376,26432,26433,26486,26508,26551,26552,26594,26671,26842,26846,26967,27231,27504,27527,27568,27838,27862,27883,27905,28241,28400,28501,28545,28652,28894,29039,29749,30055,30150,30155,30266,30426,30427,30428,30527,30619,30626,30855,30888,31060,31143,31168,31696,32570,32585,32586,32789,32957,33351,33502,34128,34533,35146,36217,36778,36792,36904,37693,37764,37790,37856,37859,38052,38067,38207,38353,38883,39343,39632,39852,40199,40216,40225,40263
-- END
