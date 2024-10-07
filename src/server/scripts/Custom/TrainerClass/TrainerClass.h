#ifndef NPC_TRAINER_H
#define NPC_TRAINER_H

enum GOSSIPS {
    GOSSIP_OPTION_MAINMENU                  = 20,
    GOSSIP_OPTION_NEWPET_EXOTIC             = 21,
    GOSSIP_OPTION_NEWPET                    = 22,
    GOSSIP_OPTION_CHIMERA                   = 23,
    GOSSIP_OPTION_CORE_HOUND                = 24,
    GOSSIP_OPTION_DEVILSAUR                 = 25,
    GOSSIP_OPTION_RHINO                     = 26,
    GOSSIP_OPTION_SILITHID                  = 27,
    GOSSIP_OPTION_WORM                      = 28,
    GOSSIP_OPTION_SPIRIT_BEAST              = 29,
    GOSSIP_OPTION_BAT                       = 30,
    GOSSIP_OPTION_BOAR                      = 31,
    GOSSIP_OPTION_BEAR                      = 32,
    GOSSIP_OPTION_CAT                       = 33,
    GOSSIP_OPTION_CARRION_BIRD              = 34,
    GOSSIP_OPTION_CROCOLISK                 = 35,
    GOSSIP_OPTION_CRAB                      = 36,
    GOSSIP_OPTION_DRAGONHAWK                = 37,
    GOSSIP_OPTION_GORILLA                   = 38,
    GOSSIP_OPTION_HOUND                     = 39,
    GOSSIP_OPTION_HYENA                     = 40,
    GOSSIP_OPTION_MOTH                      = 41,
    GOSSIP_OPTION_NETHER_RAY                = 42,
    GOSSIP_OPTION_OWL                       = 43,
    GOSSIP_OPTION_RAPTOR                    = 44,
    GOSSIP_OPTION_RAVAGER                   = 45,
    GOSSIP_OPTION_SCORPID                   = 46,
    GOSSIP_OPTION_SERPENT                   = 47,
    GOSSIP_OPTION_SPIDER                    = 48,
    GOSSIP_OPTION_TURTLE                    = 49,
    GOSSIP_OPTION_WASP                      = 50,
    GOSSIP_OPTION_WARP_STALKER              = 51,
    GOSSIP_OPTION_WIND_SERPENT              = 52,
    GOSSIP_OPTION_WOLF                      = 53,
    GOSSIP_OPTION_SPOREBAT                  = 55,
    GOSSIP_OPTION_TALLSTRIDER               = 56,
    GOSSIP_RESET_TAL                        = 57
};

enum NormalPetEntry {
    SPELL_PET_BAT                       = 46717,
    SPELL_PET_BOAR                      = 46718,
    SPELL_PET_BEAR                      = 64330,
    SPELL_PET_CAT                       = 46720,
    SPELL_PET_CARRION_BIRD              = 46719,
    SPELL_PET_CROCOLISK                 = 64332,
    SPELL_PET_CRAB                      = 64331,
    SPELL_PET_DRAGONHAWK                = 46721,
    SPELL_PET_HOUND                     = 46234,
    SPELL_PET_GORILLA                   = 64333,
    SPELL_PET_HYENA                     = 64335,
    SPELL_PET_MOTH                      = 64334,
    SPELL_PET_NETHER_RAY                = 46722,
    SPELL_PET_BIRD_OF_PREY              = 46723,
    SPELL_PET_RAPTOR                    = 46724,
    SPELL_PET_RAVAGER                   = 46725,
    SPELL_PET_SCORPID                   = 46726,
    SPELL_PET_SERPENT                   = 46727,
    SPELL_PET_SPIDER                    = 46728,
    SPELL_PET_SPOREBAT                  = 64336,
    SPELL_PET_TALLSTRIDER               = 64337,
    SPELL_PET_TURTLE                    = 64339,
    SPELL_PET_WASP                      = 64338,
    SPELL_PET_WARP_STALKER              = 46716,
    SPELL_PET_WIND_SERPENT              = 46729,
    SPELL_PET_WOLF                      = 46730,
};

enum ExoticPetEntry {
    SPELL_PET_CHIMAERA           = 63177,
    SPELL_PET_CORE_HOUND         = 63178,
    SPELL_PET_DEVILSAUR          = 63179,
    SPELL_PET_RHINO              = 63180,
    SPELL_PET_SILITHID           = 63183,
    SPELL_PET_WORM               = 63185,
    SPELL_PET_SPIRIT_BEAST       = 63184,
};

#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

constexpr static const std::array<uint32, 56> WAR_SPELL = { 7384, 47436, 47450, 11578, 47465, 47502, 34428, 1715, 2687, 71, 7386, 355,
                                                            72, 47437, 57823, 694, 2565, 676, 47520, 20230, 12678, 47471, 1161, 871,
                                                            2458, 20252, 47475, 18499, 1680, 6552, 47488, 1719, 23920, 47440,
                                                            3411, 64382, 55694, 57755, 674, 750, 5246, 3127, 5011, 202, 197, 200,
                                                            1180, 15590, 264, 198, 201, 196, 227, 266, 199, 2567 };

constexpr static const std::array<uint32, 57> PAL_SPELL = { 3127, 19746, 19752, 750, 48942, 48782, 48932, 20271, 498, 10308, 1152, 10278,
                                                            48788, 53408, 48950, 48936, 31789, 62124, 54043, 25780, 1044, 20217, 48819, 48801,
                                                            48785, 5502, 20164, 10326, 1038, 53407, 48943, 20165, 48945, 642, 48947, 20166, 4987,
                                                            48806, 6940, 48817, 48934, 48938, 25898, 32223, 31884, 54428, 61411, 53601, 33388,
                                                            33391, 199, 202, 197, 200, 198, 201, 196 };

constexpr static const std::array<uint32, 71> HUNT_SPELL = { 3043, 3127, 3045, 3034, 8737, 1494, 13163, 48996, 49001, 49045, 53338, 5116, 27044, 883,
                                                             2641, 6991, 982, 1515, 19883, 20736, 48990, 2974, 6197, 1002, 14327, 5118, 49056, 53339,
                                                             49048, 19884, 34074, 781, 14311, 1462, 19885, 19880, 13809, 13161, 5384, 1543, 19878,
                                                             49067, 3034, 13159, 19882, 58434, 49071, 49052, 19879, 19263, 19801, 34026, 34600, 34477,
                                                             61006, 61847, 53271, 60192, 62757, 674, 5011, 202, 197, 200, 1180, 15590, 264, 201, 196, 227, 266 };

constexpr static const std::array<uint32, 48> MAGE_SPELL = { 42921, 42842, 42995, 42833, 27090, 33717, 42873, 42846, 12826, 28271, 61780, 61721,
                                                             28272, 42917, 43015, 130, 42926, 43017, 475, 1953, 42940, 12051, 43010, 43020, 43012,
                                                             42859, 2139, 42931, 42985, 43008, 45438, 43024, 43002, 43046, 42897, 42914, 66, 58659,
                                                             30449, 42956, 47610, 61316, 61024, 55342, 53142, 7301, 1180, 201 };

constexpr static const std::array<uint32, 54> WARLOCK_SPELL = { 696, 47811, 47809, 688, 47813, 50511, 57946, 47864, 6215, 47878, 47855, 697, 47856,
                                                                47857, 5697, 47884, 47815, 47889, 47820, 698, 712, 126, 5138, 5500, 11719, 132, 60220,
                                                                18647, 61191, 47823, 691, 47865, 47891, 47888, 17928, 47860, 47825, 1122, 47867, 18540,
                                                                47893, 47838, 29858, 58887, 47836, 61290, 48018, 48020, 33388, 33391, 23161, 1180, 201, 227 };

constexpr static const std::array<uint32, 42> ROGUE_SPELL = { 3127, 674, 48668, 48638, 1784, 48657, 921, 1776, 26669, 51724, 6774, 11305, 1766, 48676,
                                                              48659, 1804, 8647, 48691, 51722, 48672, 1725, 26889, 2836, 1833, 1842, 8643, 2094, 1860,
                                                              57993, 48674, 31224, 5938, 57934, 51723, 5011, 1180, 15590, 264, 198, 201, 196, 266 };

constexpr static const std::array<uint32, 44> PRIEST_SPELL = { 528, 2053, 48161, 48123, 48125, 48066, 586, 48068, 48127, 48171, 48168, 10890,
                                                               6064, 988, 48300, 6346, 48071, 48135, 48078, 453, 10955, 10909, 8129, 48073, 605,
                                                               48072, 48169, 552, 1706, 48063, 48162, 48170, 48074, 48158, 48120, 34433, 48113,
                                                               32375, 64843, 64901, 53023, 1180, 198, 227 };

constexpr static const std::array<uint32, 47> DK_SPELL = { 3127, 50842, 49941, 49930, 47476, 45529, 3714, 56222, 48743, 48263, 49909, 47528,
                                                           45524, 48792, 57623, 56815, 47568, 49895, 50977, 49576, 49921, 46584, 49938, 48707,
                                                           48265, 61999, 42650, 53428, 53331, 54447, 53342, 54446, 53323, 53344, 70164, 62158,
                                                           33391, 48778, 51425, 49924, 199, 202, 197, 200, 198, 201, 196 };

constexpr static const std::array<uint32, 61> SHAMAN_SPELL = { 2062, 8737, 49273, 49238, 10399, 49231, 58753, 2484, 49281, 58582, 49233, 58790,
                                                               58704, 58643, 49277, 61657, 8012, 526, 2645, 57994, 8143, 49236, 58796, 58757,
                                                               49276, 57960, 131, 58745, 6196, 58734, 58774, 58739, 58656, 546, 556, 66842, 51994,
                                                               8177, 58749, 20608, 36936, 36936, 58804, 49271, 8512, 6495, 8170, 66843, 55459, 66844,
                                                               3738, 2894, 60043, 51514, 199, 197, 1180, 15590, 198, 196, 227 };

constexpr static const std::array<uint32, 68> DRUID_SPELL = { 48378, 48469, 48461, 48463, 48441, 53307, 53308, 5487, 48560, 6795, 48480, 53312,
                                                              18960, 5229, 48443, 50763, 8983, 8946, 1066, 48562, 783, 770, 16857, 18658, 768,
                                                              1082,5215, 48477, 49800, 48465, 48572, 26995, 48574, 2782, 50213, 2893, 33357, 5209,
                                                              48575, 48447, 48577, 48579, 5225, 22842, 49803, 9634, 20719, 48467, 29166, 62600, 22812,
                                                              48470, 33943, 49802, 48451, 48568, 33786, 40120, 62078, 52610, 50464, 48570, 199, 200,
                                                              1180, 15590, 198, 227 };

/************************************************   custom_NPC_LearnAll.cpp  ********************************************/

#define EN_player_learn_1 "|TInterface/ICONS/Ability_hunter_pet_chimera:22:22:-1|t > Chimera"
#define RU_player_learn_1 "|TInterface/ICONS/Ability_hunter_pet_chimera:22:22:-1|t > Химера"

#define EN_player_learn_2 "|TInterface/ICONS/Ability_hunter_pet_corehound:22:22:-1|t > Core Hound"
#define RU_player_learn_2 "|TInterface/ICONS/Ability_hunter_pet_corehound:22:22:-1|t > Гончая недр"

#define EN_player_learn_3 "|TInterface/ICONS/Ability_hunter_pet_devilsaur:22:22:-1|t > Devilsaur"
#define RU_player_learn_3 "|TInterface/ICONS/Ability_hunter_pet_devilsaur:22:22:-1|t > Дьявозавр"

#define EN_player_learn_4 "|TInterface/ICONS/Ability_hunter_pet_rhino:22:22:-1|t > Rhino"
#define RU_player_learn_4 "|TInterface/ICONS/Ability_hunter_pet_rhino:22:22:-1|t > Люторог"

#define EN_player_learn_5 "|TInterface/ICONS/Ability_hunter_pet_silithid:22:22:-1|t > Silithid"
#define RU_player_learn_5 "|TInterface/ICONS/Ability_hunter_pet_silithid:22:22:-1|t > Силитид"

#define EN_player_learn_6 "|TInterface/ICONS/Ability_hunter_pet_worm:22:22:-1|t > Worm"
#define RU_player_learn_6 "|TInterface/ICONS/Ability_hunter_pet_worm:22:22:-1|t > Червь"

#define EN_player_learn_7 "|TInterface/ICONS/Ability_druid_primalprecision:22:22:-1|t > Spirit Beast (tigr)"
#define RU_player_learn_7 "|TInterface/ICONS/Ability_druid_primalprecision:22:22:-1|t > Дух зверя (тигр)"

#define EN_player_learn_9 "|TInterface\\icons\\spell_nature_swiftness:22:22:-1|t > Horse Riding"
#define RU_player_learn_9 "|TInterface\\icons\\spell_nature_swiftness:22:22:-1|t > Прокачать Верховую езду"

#define EN_player_learn_10 "|TInterface\\icons\\Ability_warrior_offensivestance:22:22:-1|t > Increase all skills before 400"
#define RU_player_learn_10 "|TInterface\\icons\\Ability_warrior_offensivestance:22:22:-1|t > Повысить все навыки до 400"

#define EN_player_learn_11 "|TInterface\\icons\\Achievement_general:22:22:-1|t > Learn the second set of talents"
#define RU_player_learn_11 "|TInterface\\icons\\Achievement_general:22:22:-1|t > Изучить второй набор талантов"

#define EN_player_learn_12 "|TInterface\\icons\\Inv_misc_gear_01:22:22:-1|t > Reset my talents"
#define RU_player_learn_12 "|TInterface\\icons\\Inv_misc_gear_01:22:22:-1|t > Сбросить мои таланты"

#define EN_player_learn_13 "You already have a pet!"
#define RU_player_learn_13 "У вас уже есть пет!"

#define EN_player_learn_14 "You must be a hunter to use this service.!"
#define RU_player_learn_14 "Вы должны быть охотником для использование данной услугой!"

#define EN_player_learn_15 "|TInterface/ICONS/Ability_hunter_beastmastery:22:22:-1|t > Exotic pets"
#define RU_player_learn_15 "|TInterface/ICONS/Ability_hunter_beastmastery:22:22:-1|t > Экзотические питомцы"

#define EN_player_learn_16 "|TInterface/ICONS/Ability_hunter_beasttaming:22:22:-1|t > I want to tame a pet."
#define RU_player_learn_16 "|TInterface/ICONS/Ability_hunter_beasttaming:22:22:-1|t > Я хочу приручить питомца."

#define EN_player_learn_17 "|TInterface/ICONS/Inv_misc_food_99:22:22:-1|t > I need food for my pet."
#define RU_player_learn_17 "|TInterface/ICONS/Inv_misc_food_99:22:22:-1|t > Мне нужна еда для питомца."

#define EN_player_learn_18 "|TInterface/Icons/INV_Box_PetCarrier_01:22:22:-1|t > Stall"
#define RU_player_learn_18 "|TInterface/Icons/INV_Box_PetCarrier_01:22:22:-1|t > Стойло"

#define EN_player_learn_19 "|TInterface/Icons/INV_Scroll_11:22:22:-1|t > Rename Pet"
#define RU_player_learn_19 "|TInterface/Icons/INV_Scroll_11:22:22:-1|t > Переименовать питомца"

#define EN_player_learn_20 "|TInterface/ICONS/Spell_magic_polymorphrabbit:22:22:-1|t > Reset the talents of my pet."
#define RU_player_learn_20 "|TInterface/ICONS/Spell_magic_polymorphrabbit:22:22:-1|t > Сбросить таланты моего питомца."

#define EN_player_learn_21 "|TInterface/ICONS/Ability_hunter_pet_bat:22:22:-1|t > Bat"
#define RU_player_learn_21 "|TInterface/ICONS/Ability_hunter_pet_bat:22:22:-1|t > Летучая мышь"

#define EN_player_learn_22 "|TInterface/ICONS/Ability_hunter_pet_boar:22:22:-1|t > Boar"
#define RU_player_learn_22 "|TInterface/ICONS/Ability_hunter_pet_boar:22:22:-1|t > Вепрь"

#define EN_player_learn_23 "|TInterface/ICONS/Ability_hunter_pet_bear:22:22:-1|t > Bear"
#define RU_player_learn_23 "|TInterface/ICONS/Ability_hunter_pet_bear:22:22:-1|t > Медведь"

#define EN_player_learn_24 "|TInterface/ICONS/Ability_hunter_pet_cat:22:22:-1|t > Cat"
#define RU_player_learn_24 "|TInterface/ICONS/Ability_hunter_pet_cat:22:22:-1|t > Кошка"

#define EN_player_learn_25 "|TInterface/ICONS/Ability_hunter_pet_vulture:22:22:-1|t > Carrion Bird"
#define RU_player_learn_25 "|TInterface/ICONS/Ability_hunter_pet_vulture:22:22:-1|t > Падальщик"

#define EN_player_learn_26 "|TInterface/ICONS/Ability_hunter_pet_crocolisk:22:22:-1|t > Crocolisk"
#define RU_player_learn_26 "|TInterface/ICONS/Ability_hunter_pet_crocolisk:22:22:-1|t > Кроколиск"

#define EN_player_learn_27 "|TInterface/ICONS/Ability_hunter_pet_crab:22:22:-1|t > Crab"
#define RU_player_learn_27 "|TInterface/ICONS/Ability_hunter_pet_crab:22:22:-1|t > Краб"

#define EN_player_learn_28 "|TInterface/ICONS/Ability_hunter_pet_dragonhawk:22:22:-1|t > Dragonhawk"
#define RU_player_learn_28 "|TInterface/ICONS/Ability_hunter_pet_dragonhawk:22:22:-1|t > Дракондор"

#define EN_player_learn_29 "|TInterface/ICONS/Ability_hunter_pet_gorilla:22:22:-1|t > Gorilla"
#define RU_player_learn_29 "|TInterface/ICONS/Ability_hunter_pet_gorilla:22:22:-1|t > Горилла"

#define EN_player_learn_30 "|TInterface/ICONS/Ability_hunter_pet_hyena:22:22:-1|t > Hyena"
#define RU_player_learn_30 "|TInterface/ICONS/Ability_hunter_pet_hyena:22:22:-1|t > Гиена"

#define EN_player_learn_31 "|TInterface/ICONS/Ability_hunter_pet_moth:22:22:-1|t > Moth"
#define RU_player_learn_31 "|TInterface/ICONS/Ability_hunter_pet_moth:22:22:-1|t > Мотылек"

#define EN_player_learn_32 "|TInterface/ICONS/Ability_hunter_pet_netherray:22:22:-1|t > Nether Ray"
#define RU_player_learn_32 "|TInterface/ICONS/Ability_hunter_pet_netherray:22:22:-1|t > Скат пустоты"

#define EN_player_learn_33 "|TInterface/ICONS/Ability_hunter_pet_owl:22:22:-1|t > Owl"
#define RU_player_learn_33 "|TInterface/ICONS/Ability_hunter_pet_owl:22:22:-1|t > Сова"

#define EN_player_learn_34 "|TInterface/ICONS/Ability_hunter_pet_raptor:22:22:-1|t > Raptor"
#define RU_player_learn_34 "|TInterface/ICONS/Ability_hunter_pet_raptor:22:22:-1|t > Ящер"

#define EN_player_learn_35 "|TInterface/ICONS/Ability_hunter_pet_ravager:22:22:-1|t > Ravager"
#define RU_player_learn_35 "|TInterface/ICONS/Ability_hunter_pet_ravager:22:22:-1|t > Опустошитель"

#define EN_player_learn_36 "|TInterface/ICONS/Ability_hunter_pet_scorpid:22:22:-1|t > Scorpid"
#define RU_player_learn_36 "|TInterface/ICONS/Ability_hunter_pet_scorpid:22:22:-1|t > Скорпид"

#define EN_player_learn_37 "|TInterface/ICONS/Spell_nature_guardianward:22:22:-1|t > Snake"
#define RU_player_learn_37 "|TInterface/ICONS/Spell_nature_guardianward:22:22:-1|t > Змей"

#define EN_player_learn_38 "|TInterface/ICONS/Ability_hunter_pet_spider:22:22:-1|t > Spider"
#define RU_player_learn_38 "|TInterface/ICONS/Ability_hunter_pet_spider:22:22:-1|t > Паук"

#define EN_player_learn_39 "|TInterface/ICONS/Ability_hunter_pet_sporebat:22:22:-1|t > Sporebat"
#define RU_player_learn_39 "|TInterface/ICONS/Ability_hunter_pet_sporebat:22:22:-1|t > Спороскат"

#define EN_player_learn_40 "|TInterface/ICONS/Ability_hunter_pet_tallstrider:22:22:-1|t > Tallstrider"
#define RU_player_learn_40 "|TInterface/ICONS/Ability_hunter_pet_tallstrider:22:22:-1|t > Долгоног"

#define EN_player_learn_41 "|TInterface/ICONS/Ability_hunter_pet_turtle:22:22:-1|t > Turtle"
#define RU_player_learn_41 "|TInterface/ICONS/Ability_hunter_pet_turtle:22:22:-1|t > Черепаха"

#define EN_player_learn_42 "|TInterface/ICONS/Ability_hunter_pet_warpstalker:22:22:-1|t > Warp Stalker"
#define RU_player_learn_42 "|TInterface/ICONS/Ability_hunter_pet_warpstalker:22:22:-1|t > Прыгуана"

#define EN_player_learn_43 "|TInterface/ICONS/Ability_hunter_pet_wasp:22:22:-1|t > Wasp"
#define RU_player_learn_43 "|TInterface/ICONS/Ability_hunter_pet_wasp:22:22:-1|t > Оса"

#define EN_player_learn_44 "|TInterface/ICONS/Ability_hunter_pet_windserpent:22:22:-1|t > Wind Serpent"
#define RU_player_learn_44 "|TInterface/ICONS/Ability_hunter_pet_windserpent:22:22:-1|t > Крылатый змей"

#define EN_player_learn_45 "|TInterface/ICONS/Ability_hunter_pet_wolf:22:22:-1|t > Wolf"
#define RU_player_learn_45 "|TInterface/ICONS/Ability_hunter_pet_wolf:22:22:-1|t > Волк"

#define EN_player_learn_46 "You have successfully trained the ability to fly."
#define RU_player_learn_46 "Вы успешно обучили умение полётов."

#define EN_player_learn_47 "You have successfully dropped your talents."
#define RU_player_learn_47 "Вы успешно сбросили ваши таланты."

#define EN_player_learn_48 "You have successfully dropped the talents of the pet."
#define RU_player_learn_48 "Вы успешно сбросили таланты пету."

#define EN_player_learn_49 "|TInterface/ICONS/ability_rogue_shadowstrikes:22:22:-1|t > Learn spells"
#define RU_player_learn_49 "|TInterface/ICONS/ability_rogue_shadowstrikes:22:22:-1|t > Выучить заклинания"

#define EN_player_learn_8 "|TInterface\\icons\\inv_glyph_minorpriest:22:22:-1|t > Glyph"
#define RU_player_learn_8 "|TInterface\\icons\\inv_glyph_minorpriest:22:22:-1|t > Символы"

#define EN_player_learnspell "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:22:22:-1|t > Update"
#define RU_player_learnspell "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:22:22:-1|t > Обновить"

#endif