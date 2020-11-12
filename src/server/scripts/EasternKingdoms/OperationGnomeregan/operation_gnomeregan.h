/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2011 gmlt.A
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */
 
enum eSpells
{
    // quests
    SPELL_SALUTE_CREDIT         = 73771,
    SPELL_DANCE_CREDIT          = 73830,
    SPELL_ROAR_CREDIT           = 73832,
    SPELL_CHEER_CREDIT          = 73833,
    
    // Prepping the Speech
    SPELL_CREATE_TELEPORTER     = 74206,
    SPELL_CREDIT_OZZIE          = 74154,
    SPELL_CREDIT_MILLI          = 74155,
    SPELL_CREDIT_TOG            = 74156,

    // intro
    SPELL_MUSIC_START           = 75760,
    SPELL_MUSIC                 = 75765,
    SPELL_MUSIC_END             = 75767,

    SPELL_TRIGGER               = 72400, // 100% wrong. Used for some special cases

    SPELL_HEALTH_REGEN          = 74503,
    SPELL_BRILLIANT_TACTICS     = 74501,

    SPELL_ATTACK                = 74413,
    SPELL_SHOOT                 = 74414,
    SPELL_GRENADE               = 74707,

    SPELL_RAD_GRENADE           = 74764,

    SPELL_MACHINE_GUN           = 74438,
    SPELL_FLAME_SPRAY           = 74440,

    SPELL_EXPLOSION             = 74550,
    SPELL_CANNON_SHOT           = 74307,
    SPELL_CANNON_SHIELD         = 74458,
    SPELL_ROCKET                = 64979, // May be wrong

    SPELL_PARACHUTE             = 79397,
    SPELL_PARACHUTE_AURA        = 79404,

    SPELL_WRENCH_THROW          = 74785, // Seems to have wrong throw model

///-------Used in final cinematic------
  //SPELL_ATTACH_CAMERA         = 75512, // [Unused]
    SPELL_SPAWN_INVISIBILITY    = 75513,
    SPELL_SEE_INVISIBILITY      = 75514,
    SPELL_BINDSIGHT             = 75517, // Custom spell

  //SPELL_RECALL_TRIGGER        = 75553, // Triggers Camera Vehicle summon [Unused]
    SPELL_RECALL                = 75510, // Teleport to camera start position
    SPELL_RECALL_FINAL          = 74412, // Realy final?

    SPELL_RAD_EXPLOSION         = 75545,
};

enum eCreatures
{
///----------------Allies---------------
    NPC_MEKKATORQUE             = 39271,
    NPC_BATTLE_SUIT             = 39902,
    NPC_FASTBLAST               = 39910,
    NPC_INFANTRY                = 39252,
    NPC_COGSPIN                 = 39273,
    NPC_BOMBER                  = 39735,
    NPC_ELGIN                   = 40478,
    NPC_TANK                    = 39860,
    NPC_TRAINEE                 = 39349,

///----------------Enemies--------------
    NPC_I_INFANTRY              = 39755,
    NPC_IRRADIATOR              = 39903,
    NPC_I_CAVALRY               = 39836,
    NPC_GASHERIKK               = 39799,
    NPC_BRAG_BOT                = 39901,
    NPC_BOLTCOG                 = 39837,
    NPC_I_TROGG                 = 39826,
    NPC_I_TANK                  = 39819,
    NPC_CANNON                  = 39759, // Tankbuster Cannon
    NPC_RL                      = 39820, // Rocket Launcher

///--------------Bunnies----------------
    NPC_EXPLOSION_BUNNY         = 40506,
    NPC_CAMERA_VEHICLE          = 40479,

    // Prepping Speech
    NPC_OZZIE                   = 1268,
    NPC_MILLI                   = 7955,
    NPC_TOG                     = 6119,
    NPC_SUMMONING_PAD           = 39817,

    NPC_DRIVEABLE_MECHANOTANK   = 39713,
};

enum eObjects
{
    GO_PLR_LANDING_PLATFORM    = 202760,
    GO_TELE_DISK               = 202733,
    GO_HAZ_LIGHT               = 202713,
    GO_BANNER                  = 194498,
    GO_RAD_CONTROL             = 202767,
    GO_IRRADIATOR              = 202922,
    GO_CRAP_TABLE              = 202564,
};

enum eMisc
{
    QUEST_OPERATION_GNOMEREGAN  = 25393,
    DATA_MOUNT_MEK              = 31692,
    DATA_MOUNT_FAST             = 6569,
    DATA_MOUNT_COG              = 9473,
    FACTION_GNOMEREGAN          = 1770,
    QUEST_ONE_STEP_FORWARD      = 25289,
};

enum eEvents
{
    EVENT_SUMMON_TROGG          = 0,
};

enum eWorldstates
{
    WORLDSTATE_IN_PROCCESS                              = 4981,
    WORLDSTATE_RL_DESTROYED                             = 5027,
    WORLDSTATE_RL_DESTROYED_CTRL                        = 5040,
    WORLDSTATE_BATTLE_NEAR_WORKSHOPS                    = 5018,
    WORLDSTATE_AIRFIELD_ATTACKED                        = 5039,
    WORLDSTATE_AIRFIELD_CAPTURED                        = 5044,
    WORLDSTATE_CANNONS_DESTROYED                        = 5006,
    WORLDSTATE_CANNONS_DESTROYED_CTRL                   = 5018,
    WORLDSTATE_AIRFIELD_AND_COMMAND_CENTER_CAPTURED     = 5043,
    WORLDSTATE_BATTLE_NEAR_ENTRANCE                     = 5019,
    WORLDSTATE_SURFACE_CAPTURED                         = 5045,
    WORLDSTATE_BATLLE_IN_TUNNELS                        = 5021,
    WORLDSTATE_TUNNELS_CAPTURED                         = 5011,
    WORLDSTATE_COUNTDOWN                                = 5037,
    WORLDSTATE_COUNTDOWN_CTRL                           = 5038,
};

const Position decor_beginning_teleport_platforms[6] = {
    // Teleport Platforms 202733
    {-5414.52, 474.504, 383.974, 0.645772},
    {-5420.38, 473.085, 383.956, 0.663223},
    {-5411.08, 472.309, 384.004, 0.575957},
    {-5413.32, 468.844, 384.21, 0.575957},
    {-5418.15, 476.55, 384.068, 0.663223},
    {-5416.76, 471.038, 383.984, 0.645772}
};

const Position decor_gnomish_tables[2] = {
    {-5430.01, 535.743, 386.827,-1.41372},
    {-5463.99, -626.967, 393.529,0},
};

const Position decor_gnomeregan_banners[32] = {
    // P1 INTRO (8)
    {-5418.68, 459.585, 386.622, -2.44346},
    {-5404.91, 462.189, 384.779, -0.837758},
    {-5376.39, 472.72, 384.283, -0.837758},
    {-5375.15, 482.976, 384.449, 0.575957},
    {-5455.16, 515.398, 387.598, -2.3911},
    {-5429.35, 547.783, 386.938, 0.575957},
    {-5389.39, 550.753, 386.725, -2.44346},
    {-5373.3, 525.882, 387.03, -2.93214},
    // P2 AIRFIELD (5)
    {-5310.91, 586.951, 389.693, -1.25664},
    {-5268.48, 568.033, 387.138, -1.13446},
    {-5336.79, 562.766, 395.812, -0.837758},
    {-5334.65, 555.167, 384.071, -0.523598},
    {-5305.06, 532.271, 384.891, -0.680679},
    // P3 SMALL HOUSE (5)
    {-5153.77, 454.16, 393.133, 2.56563},
    {-5117.25, 444.118, 397.804, 2.56563},
    {-5087.5, 482.637, 401.899, -2.14675},
    {-5141.51, 471.094, 392.839, 2.56563},
    {-5080.71, 451.729, 410.369, 2.53072},
    // P4 OUTSIDE CAVE (5)
    {-5180.89, 530.708, 389.413, -1.62316},
    {-5145.07, 556.821, 413.427, -2.18166},
    {-5198.83, 534.108, 389.122, -1.62316},
    {-5190.92, 596.262, 408.516, -1.51844},
    {-5176.98, 596.332, 408.102, -1.64061},
    // P5 INSIDE GNOMEREGAN (9)
    {-5156.54, 662.779, 245.188, -1.74533},
    {-5154.93, 671.948, 248.057, 1.72787},
    {-5169.41, 664.198, 245.406, -1.71042},
    {-5171.89, 641.462, 347.195, 1.27409},
    {-5157.88, 639.892, 347.195, 1.71042},
    {-5170.58, 672.648, 248.057, 1.29154},
    {-5174.28, 719.535, 369.765, -1.76278},
    {-5165.14, 640.599, 348.922, 1.48353},
    {-5153.2, 713.705, 369.589, -3.08918},
    // P6 BOMB PLATFORM INSIDE GNOMEREGAN
};

const Position decor_beginning_hazard_lights[20] = {
    // Hazard Light Red 02
    {-5440.04, 524.285, 388.257, 1.29154},
    {-5435.77, 517.83, 388.278, 1.29154},
    {-5429.48, 522.066, 388.259, 1.29154},
    {-5437.63, 527.63, 388.275, 1.29154},
    {-5433.61, 528.453, 388.305, 1.29154},
    {-5439.32, 520.198, 388.265, 1.29154},
    {-5430.19, 526.101, 388.255, 1.29154},
    {-5431.73, 518.66, 388.255, 1.29154},
    {-5389.46, -604.698, 393.345, 1.29154},
    {-5391.94, -609.545, 393.589, 1.29154},
    {-5393.62, -612.368, 393.799, 1.29154},
    {-5396.01, -617.333, 393.741, 1.29154},
    {-5410.24, -654.898, 393.749, 1.29154},
    {-5412.61, -659.821, 393.915, 1.29154},
    {-5414.69, -662.712, 394.14, 1.29154},
    {-5417.49, -667.495, 394.616, 1.29154},
    {-5428.03, -692.396, 394.648, 1.29154},
    {-5430.65, -697.174, 394.863, 1.29154},
    {-5432.19, -700.075, 395.037, 1.29154},
    {-5434.78, -704.911, 395.076, 1.29154}
};

const Position iInfantrySpawn[26] =
{
    {-5355.43f, 530.67f, 385.17f, 3.37f},
    {-5356.68f, 535.13f, 385.54f, 3.43f},
    {-5360.16f, 549.49f, 387.26f, 2.87f},
    {-5360.22f, 555.62f, 387.21f, 3.02f},
    {-5359.59f, 561.08f, 387.01f, 3.02f},
    {-5336.43f, 541.66f, 384.97f, 2.67f},
    {-5333.62f, 541.52f, 384.91f, 3.29f},
    {-5345.95f, 532.78f, 384.68f, 2.82f},
    {-5145.95f, 452.20f, 393.56f, 2.32f},
    {-5137.67f, 460.88f, 393.24f, 2.34f},
    {-5115.88f, 434.75f, 397.49f, 1.91f},
    {-5128.01f, 430.56f, 396.55f, 1.70f},
    {-5107.13f, 462.23f, 402.25f, 3.70f},
    {-5103.22f, 455.80f, 402.69f, 3.66f},
    {-5095.57f, 470.80f, 403.48f, 3.96f},
    {-5090.65f, 466.22f, 404.34f, 3.96f},
    {-5081.96f, 453.46f, 409.65f, 2.18f},
    {-5087.25f, 448.15f, 409.30f, 2.17f},
    {-5189.41f, 583.61f, 404.02f, 4.82f},
    {-5178.16f, 583.22f, 403.94f, 4.60f},
    {-5193.70f, 594.34f, 408.54f, 5.20f},
    {-5195.24f, 597.54f, 409.39f, 5.20f},
    {-5191.03f, 598.42f, 408.85f, 4.92f},
    {-5171.88f, 593.29f, 407.82f, 4.17f},
    {-5174.75f, 596.12f, 408.08f, 4.17f},
    {-5171.76f, 597.32f, 408.66f, 4.17f}
};

const Position iTankSpawn[4] =
{
    {-5338.99f, 535.53f, 384.99f, 2.88f},
    {-5349.29f, 556.11f, 385.13f, 3.47f},
    {-5303.43f, 584.31f, 389.94f, 3.79f},
    {-5085.88f, 475.44f, 402.24f, 3.92f}
};

const Position iSoldierSpawn[5] =
{
    {-5040.80f, 739.75f, 256.47f, 6.2f},
    {-5043.66f, 731.75f, 256.47f, 6.2f},
    {-5039.70f, 734.17f, 256.47f, 6.2f},
    {-5044.24f, 737.27f, 256.47f, 6.2f},
    {-5046.30f, 733.86f, 256.47f, 6.2f}
};

const Position InfantrySpawn[19] =
{
    {-5334.11f, 563.10f, 395.79f, 0.71f},
    {-5303.73f, 588.68f, 390.12f, 5.27f},
    {-5308.05f, 587.04f, 389.93f, 5.08f},
    {-5271.25f, 572.90f, 387.12f, 4.93f},
    {-5280.78f, 564.26f, 386.08f, 5.65f},
    {-5085.68f, 480.86f, 401.69f, 4.12f},
    {-5080.83f, 477.69f, 401.76f, 4.12f},
    {-5085.44f, 446.00f, 410.11f, 2.51f},
    {-5081.82f, 451.51f, 410.33f, 2.46f},
    {-5152.82f, 455.32f, 392.82f, 2.49f},
    {-5142.35f, 468.65f, 392.38f, 2.33f},
    {-5191.10f, 574.74f, 400.96f, 1.51f},
    {-5177.70f, 574.41f, 400.40f, 1.51f},
    {-4975.04f, 736.62f, 256.91f, 3.04f},
    {-4976.25f, 723.63f, 256.91f, 3.04f},
    {-5103.44f, 724.77f, 257.77f, 6.24f},
    {-5109.18f, 725.26f, 255.98f, 6.24f},
    {-5104.79f, 717.42f, 257.53f, 6.24f},
    {-5109.95f, 717.81f, 255.92f, 6.24f}
};

const Position RLSpawn[4] =
{
    {-5350.35f, 574.63f, 387.12f, 4.7f},
    {-5331.62f, 545.17f, 385.22f, 5.0f},
    {-5324.26f, 588.66f, 389.01f, 3.7f},
    {-5294.58f, 571.73f, 386.93f, 5.3f}
};

const Position CannonSpawn[6] =
{
    {-5140.57f, 428.39f, 395.89f, 2.1f},
    {-5109.37f, 426.51f, 399.66f, 2.4f},
    {-5109.00f, 481.10f, 398.45f, 3.9f},
    {-5071.21f, 457.83f, 410.94f, 3.0f},
    {-5087.23f, 434.92f, 411.78f, 1.9f},
    {-5092.15f, 450.84f, 406.63f, 1.4f}
};

const Position BattleSuitDriverSpawn[3] =
{
    {-5158.31f, 470.63f, 390.47f, 5.0f},
    {-5156.70f, 473.46f, 390.56f, 5.0f},
    {-5154.23f, 475.71f, 390.82f, 5.0f}
};

const Position BattleSuitSpawn[6] =
{
    {-5073.81f, 481.83f, 401.48f, 5.0f},
    {-5069.55f, 485.22f, 401.49f, 4.8f},
    {-5064.04f, 486.30f, 401.48f, 4.8f},
    {-5086.02f, 713.15f, 260.56f, 6.3f},
    {-5085.04f, 725.92f, 260.56f, 6.3f},
    {-5085.31f, 477.48f, 401.95f, 3.9f}
};

const Position TankSpawn[5] =
{
    {-5402.421387f, 543.972229f, 387.243896f, 6.1f},
    {-5404.228516f, 530.777527f, 387.151581f, 0.2f},
    {-5394.222656f, 519.042908f, 386.308929f, 1.0f},
    {-5280.954102f, 559.265808f, 385.679932f, 5.0f},
    {-5263.007813f, 572.262085f, 388.673157f, 5.0f}
};

const Position BragBotSpawn[2] =
{
    {-5183.73f, 599.90f, 408.96f, 4.6f},
    {-4933.62f, 717.18f, 261.65f, 1.6f}
};

const uint32 Worldstates[15] = 
{
    4981,
    5027,
    5040,
    5018,                      
    5039,
    5044,
    5006,
    5018,
    5043,
    5019,
    5045,
    5021,
    5011,
    5037,
    5038
};

const Position BomberSpawn              = {-5314.53f, 564.82f, 391.43f, 5.7f};
const Position RadControlSpawn          = {-5072.80f, 441.48f, 410.97f, 2.6f};

const Position TroggSpawn               = {-5181.74f, 631.21f, 398.54f, 4.7f};

const Position ExplosionBunnySpawn      = {-5183.24f, 608.97f, 410.89f, 4.7f};

//#define SOUND_NAME            soundID // Duration
#define MEK1_1_0    "They may take our lives, but they'll never take..."
#define MEK1_1_1    "...our INNOVATION!"
#define LIS1_1_0    "What? I don't even know what you're talking about! That's terrible!"
#define MEK1_2_0    "We will not go quietly into the night! We will not vanish without a fight!"
#define MEK1_2_1    "We're going to live on! We're going to survive! Today we celebrate..."
#define MEK1_2_2    "...our Autonomy Day!"
#define LIS1_2_0    "Horrible! Well, all right, maybe it just needs a little cleaning up?"
#define MEK1_3_0    "What I want out of each and every one of you is a hard-target search of every refuelling station, residence, warehouse, farmhouse, henhouse, outhouse and doghouse in this area."
#define MEK1_3_1    "Your fugitive's name is Mekgineer Thermaplugg."
#define MEK1_3_2    "Go get him."
#define LIS1_3_0    "Hmm, I suppose it could work.  But it could really use a little more umph!"



#define STEAM_0 "Well, a bunch of useless gears, let's get to work!"
#define STEAM_1 "I will teach you everything you must know how to be a real soldier!"
#define STEAM_2 "First of all, you need to go drill."
#define STEAM_3 "At the signal, show me how to welcome the commander for the charter!"
#define STEAM_4 "So recruits saluted his commander!"
#define STEAM_5 "Great job!"
#define STEAM_6 "On the battlefield, it is important to intimidate the enemy furious battle roar!"
#define STEAM_7 "As soon as I give the signal, show me what real fury!"
#define STEAM_8 "Show me now furious!"
#define STEAM_9 "Wow, nice!"
#define STEAM_10 "Remember that the most important factor in any battle - is the spirit!"
#define STEAM_11 "Get ready to show me how the soldiers should be happy to win!"
#define STEAM_12 "Let's! Express your enthusiasm!"
#define STEAM_13 "Terrific!"
#define STEAM_14 "However, the most important in the battle - to be able to correctly mark earned sweat and blood of victory!"
#define STEAM_15 "Execute me your best victory dance! Start the alarm!"
#define STEAM_16 "And now - dance!"
#define STEAM_17 "Great!"
#define STEAM_18 "You - are the best squad of recruits that I have ever seen Let's repeat everything!"


#define MEK_1_1                 "Граждане и друзья Гномрегана!"
#define MEK_1_2                 "Сегодня мы отвоюем у подлого предателя Термоштепселя наш славный город!"
#define MEK_1_3                 "Встанем плечом к плечу в битве за родину!"
#define SOUND_MEK_1             17535 // 17150
#define MEK_2_1                 "Наш народ познал достаточно мук и унижений. Мы были изгоями, рабами, тянущими ярмо боевой машины безумца!"
#define SOUND_MEK_2             17536 // 12200
#define MEK_3_1                 "Правлению Термоштепселя приходит конец!"
#define MEK_3_2                 "Объявляю общий сбор!"
#define SOUND_MEK_3             17537 // 7050
#define MEK_4_1                 "Военная тактика и научный прогресс, вкупе с нашей решимостью, приведут нас к победе!"
#define MEK_4_2                 "Начинаем наступление!"
#define SOUND_MEK_4             17538 // 10180
#define MEK_5_1                 "Операция 'Гномреган' НАЧИНАЕТСЯ!"
#define MEK_5_2                 "Первый этап: захват аэродрома."
#define MEK_5_3                 "Уничтожтье ракетомёты врага, и мы получим превосходство в воздухе!"
#define SOUND_MEK_5             17539 // 13500
#define MEK_6_1                 "Цель в зоне видимости! Орудия к бою! Уничтожить ракетомёты противника!"
#define SOUND_MEK_6             17541 // 6730
#define MEK_7_1                 "Ха-ха, этот готов! Продолжаем наступление!"
#define SOUND_MEK_7             17542 // 4970
#define MEK_8_1                 "Ха-ха, ещё один разбит! Не ослабляйте натиск!"
#define SOUND_MEK_8             17543 // 6160
#define MEK_9_1                 "Отличная работа! Продолжайте в том же духе."
#define SOUND_MEK_9             17544 // 4140
#define MEK_10_1                "Аэродром взят, и небо над Гномреганом наше!"
#define MEK_10_2                "Теперь наши бомбисты могут уничтожить защищённые противотанковые пушки Термоштепселя."
#define MEK_10_3                "Второй этап операции: захват наземного командного поста!"
#define SOUND_MEK_10            17546 // 16970
#define MEK_11_1                "Наши бомбисты разрушили защиту противотанковых пушек! Уничтожьте их и обеспечьте безопасность наземного командного пункта!"
#define SOUND_MEK_11            17547 // 9740
#define MEK_12_1                "Наземная часть города захвачена. Операция 'Гномреган' проходит с эффективностью 93 процента... Всех хвалю!"
#define MEK_12_2                "Отключаю защитные радиационные насосы. Отряды, захватите оставшихся боевых роботов и продвигайтесь к главному входу!"
#define SOUND_MEK_12            17548 // 16660
#define MEK_13_1                "Мы стоим на пороге победы, друзья мои! Третий этап: проникнуть в туннели!"
#define MEK_13_2                "Как только захватим подземную железную дорогу и погрузочную платформу, мы сможем ворваться в самое сердце города!"
#define MEK_13_3                "Победа близка!"
#define SOUND_MEK_13            17549 // 17600
#define THERM_1_1               "НИКОГДА!!! Так... Оно включено? Эта кнопка? Раз-два, раз-два... О!"
#define THERM_1_2               "НИКОГДА!!! Гномреган МОЙ, Меггакрут!"
#define THERM_1_3               "Думаешь ты просто так войдёшь в МОЙ город?"
#define THERM_1_4               "Активировать систему однократной атомной защиты! ВЫПУСТИТЬ ТРОГГОВ!"
#define SOUND_THERM_1           17569 // 23190
#define MEK_14_1                "Ёлки-шестерёнки... Да тут, похоже, собрались все трогги города! Солдаты, окопаться!"
#define MEK_14_2                "Осколочные гранаты и заградительный огонь! ДЕРЖАТЬ СТРОЙ! Отступать нельзя!"
#define SOUND_MEK_14            17550 // 14230
#define MEK_15_1                "Тысяча сопливых титанят! Никогда не видел такого огромного трогга! Продолжать обстрел... уничтожить его!!!"
#define SOUND_MEK_15            17551 // 9560
#define MEK_16_1                "Слишком уж тихо. Где войска Термоштепселя?"
#define SOUND_MEK_16            17552 // 5520
#define MEK_17_1                "Что это? Похоже на ядерную бомбу, которая погубила Гномреган... Стоять! Враг идёт!"
#define SOUND_MEK_17            17553 // 9690
#define BOLTCOG_1               "Нашу защиту вам не преодолеть. МЫ истинные сыны Гномрегана!"
#define SOUND_BOLTCOG_1         17665 // 6100
#define THERM_2_1               "Нет! Нет, нет, НЕТ! Я не позволю тебе войти в своё королевство, узурпатор!"
#define THERM_2_2               "Активировать систему атомной защиты!"
#define THERM_2_3               "ДЕЗИНТЕГРИРОВАТЬ ИХ ВСЕХ!"
#define SOUND_THERM_2           17570 // 14640
#define MEK_18_1                "ЭТО ЛОВУШКА! Здесь работает облучатель!"
#define SOUND_MEK_18            17554 // 3830
#define THERM_3_1               "Так и есть. И она в ДВАДЦАТЬ ШЕСТЬ РАЗ мощнее первой!"
#define THERM_3_2               "Меггакрут, ты ПРОИГРАЛ! Я победил тебя раньше чем ты успел вступить в мой прекрасный город."
#define THERM_3_3               "А теперь УМРИ!"
#define THERM_3_4               "О, хотел бы я увидеть лицо этого жулика. Клянусь он... Что? Всё ещё включено? ВЫКЛЮЧИ!!!"
#define SOUND_THERM_3           17571 // 22980
#define IRRADIATOR_1_1          "Облучатель 3000 активирован. Внимание. Чрезвычайная ситуация. У вас осталось 10 минут для того, чтобы оказаться на минимальном безопасном расстоянии."
#define SOUND_IRRADIATOR_1      17635 // 10830
#define MEK_19_1                "Десять минут? Мы сто раз обезвредим устройство."
#define MEK_19_2                "Хинклс, протяни-ка трещащий бронзовый механизм и дай свежей воды! Шестерёнок, швырни мне грязное одеяние трогга и дай горсть медных винтов..."
#define SOUND_MEK_19            17556 // 14930
#define THERM_4_1               "ДЕСЯТЬ МИНУТ?! Ты оставил заводские настройки? Идиот, быстро отдай регулятор!"
#define SOUND_THERM_4           17572 // 9970
#define IRRADIATOR_2_1          "Внимание. Чрезвычайная ситуация. У вас осталось 10 секунд для того, чтобы оказаться на минимальном безопасном расстоянии."
#define SOUND_IRRADIATOR_2      17636 // 7670
#define MEK_20_1                "Надо убираться отсюда! Ла Форж, скорее телепортируй нас!"
#define SOUND_MEK_20            17557 // 4790
#define MEK_21_1                "Проклятье! Пришлось отступить. Но Термоштепсель проиграл, и он это знает... Он лишь получил небольшую отсрочку."
#define MEK_21_2                "Мы завладели поверхностью, а когда уровень радиации снизится, вернёмся с вдвое большей армией и отвоюем Гномреган!"
#define SOUND_MEK_21            17558 // 19280
