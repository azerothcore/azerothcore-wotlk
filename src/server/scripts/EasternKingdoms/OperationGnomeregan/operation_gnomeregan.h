/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
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

    // Press Fire
    SPELL_SHOOT_CREDIT          = 74184,
    SPELL_SHOOT_VISUAL          = 74179,
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

// Texts in Prepping the Speech
enum MEK_T
{
    MEK1_0_0 = 0,
    MEK1_0_1,
    MEK1_0_2,
    MEK1_0_3,
    MEK1_0_4,
    MEK1_0_5,
    MEK1_0_6,
    MEK1_0_7,

    MEK1_REPLY = 0,
};

enum STEAM_Texts
{
    STEAM_0 = 0,
    STEAM_1,
    STEAM_2,
    STEAM_3,
    STEAM_4,
    STEAM_5,
    STEAM_6,
    STEAM_7,
    STEAM_8,
    STEAM_9,
    STEAM_10,
    STEAM_11,
    STEAM_12,
    STEAM_13,
    STEAM_14,
    STEAM_15,
    STEAM_16,
    STEAM_17,
    STEAM_18,
};

#define MEK_1_1                 "Citizens and Friends of Gnomeregan!"
#define MEK_1_2                 "Today we could wrest from the vile traitor Thermaplugg our glorious city!"
#define MEK_1_3                 "Will stand shoulder to shoulder in the battle for the motherland!"
#define SOUND_MEK_1             17535 // 17150
#define MEK_2_1                 "Our people have learned enough anguish and humiliation. We were outcasts, slaves pulling the yoke of a madman fighting machine!"
#define SOUND_MEK_2             17536 // 12200
#define MEK_3_1                 "Board Thermaplugg comes to an end!"
#define MEK_3_2                 "Declare the total collection!"
#define SOUND_MEK_3             17537 // 7050
#define MEK_4_1                 "Military tactics and scientific progress, coupled with our determination to lead us to victory!"
#define MEK_4_2                 "Getting the offensive!"
#define SOUND_MEK_4             17538 // 10180
#define MEK_5_1                 "Operation 'Gnomeregan' BEGINS!"
#define MEK_5_2                 "First step: the capture of the airport."
#define MEK_5_3                 "Destroy the enemy Rocket Launcher, and we have air superiority!"
#define SOUND_MEK_5             17539 // 13500
#define MEK_6_1                 "Goal in sight! The guns at the ready! Rocket Launcher to destroy the enemy!"
#define SOUND_MEK_6             17541 // 6730
#define MEK_7_1                 "Ha ha, this is ready! We continue to advance!"
#define SOUND_MEK_7             17542 // 4970
#define MEK_8_1                 "Ha-ha, another broken! Do not loosen the onslaught!"
#define SOUND_MEK_8             17543 // 6160
#define MEK_9_1                 "Well done! Keep up the good work."
#define SOUND_MEK_9             17544 // 4140
#define MEK_10_1                "The airport was taken, and the sky above our Gnomeregan!"
#define MEK_10_2                "Now, our bombers can destroy the protected anti-tank guns Thermaplugg."
#define MEK_10_3                "The second phase of the operation: the capture of ground command post!"
#define SOUND_MEK_10            17546 // 16970
#define MEK_11_1                "Our bombers destroyed the protection of anti-tank guns! Destroy them and secure the ground command center!"
#define SOUND_MEK_11            17547 // 9740
#define MEK_12_1                "Ground part of the city captured. Operation 'Gnomeregan' pass with 93 percent efficiency ... All praise!"
#define MEK_12_2                "Turn off the radiation protection pumps. The troops, grab the remaining combat robots and move to the front door!"
#define SOUND_MEK_12            17548 // 16660
#define MEK_13_1                "We are near victory, my friends! Third step: get into the tunnels!"
#define MEK_13_2                "As soon seize the underground railroad and the loading dock, we will be able to break into the very heart of the city!"
#define MEK_13_3                "Victory is near!"
#define SOUND_MEK_13            17549 // 17600
#define THERM_1_1               "NEVER! So ... It is included? This button? One, two, one two ... Oh!"
#define THERM_1_2               "NEVER! Gnomeregan my Meggakrut!"
#define THERM_1_3               "You think you're just so you come to my city?"
#define THERM_1_4               "Activate the system once the nuclear defense! ISSUE Troggs!"
#define SOUND_THERM_1           17569 // 23190
#define MEK_14_1                "Yes, there seems to have gathered all of troggs! Soldiers dig in!"
#define MEK_14_2                "Fragmentation grenades and covering fire! HOLD STORY! To retreat is impossible!"
#define SOUND_MEK_14            17550 // 14230
#define MEK_15_1                "Thousand titanite snotty! I've never seen such a huge troggs! Continue to fire ... destroy it!"
#define SOUND_MEK_15            17551 // 9560
#define MEK_16_1                "Too quiet. Where troops Thermaplugg?"
#define SOUND_MEK_16            17552 // 5520
#define MEK_17_1                "What is it? It looks like a nuclear bomb, which killed ... Gnomeregan Whoa! The enemy is coming!"
#define SOUND_MEK_17            17553 // 9690
#define BOLTCOG_1               "Our defense will not be overcome. We are true sons of Gnomeregan!"
#define SOUND_BOLTCOG_1         17665 // 6100
#define THERM_2_1               "No! No, no, NO! I will not allow you to enter his kingdom, the usurper!"
#define THERM_2_2               "Activate the nuclear defense!"
#define THERM_2_3               "Disintegrate them all!"
#define SOUND_THERM_2           17570 // 14640
#define MEK_18_1                "It's a trap! It works irradiator!"
#define SOUND_MEK_18            17554 // 3830
#define THERM_3_1               "It is. And it is in twenty-six times more powerful than the first!"
#define THERM_3_2               "Meggakrut, you lose! I've won before you than you have time to join in my beautiful city."
#define THERM_3_3               "Now, DIE!"
#define THERM_3_4               "Oh, I'd like to see the face of this rogue. I swear it ... What? All else is included? OFF!"
#define SOUND_THERM_3           17571 // 22980
#define IRRADIATOR_1_1          "Illuminator 3000 is activated. Attention. Emergency. Do you still have 10 minutes to be at a minimum safe distance."
#define SOUND_IRRADIATOR_1      17635 // 10830
#define MEK_19_1                "10 Minutes? We are a hundred times neutralized the device."
#define MEK_19_2                "Hinkls, stretch-ka popping bronze mechanism, and give fresh water! Gears, Throw me a dirty robe and let troggs handful of copper bolts ..."
#define SOUND_MEK_19            17556 // 14930
#define THERM_4_1               "10 MINUTES! You left the factory settings? Idiot, quickly give the regulato"
#define SOUND_THERM_4           17572 // 9970
#define IRRADIATOR_2_1          "Attention. Emergency. Do you still have 10 seconds to be at a minimum safe distance."
#define SOUND_IRRADIATOR_2      17636 // 7670
#define MEK_20_1                "Get out of here! La Forge, but rather will teleport us!"
#define SOUND_MEK_20            17557 // 4790
#define MEK_21_1                "Damn! Had to retreat. But Thermaplugg lost, and he knows it ... He only got a small reprieve."
#define MEK_21_2                "We took over a surface, and when radiation levels decrease, we will return with an army twice and could wrest Gnomeregan!"
#define SOUND_MEK_21            17558 // 19280
