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

/* ScriptData
SDName: Silithus
SD%Complete: 100
SDComment: Quest support: 8304, 8507.
SDCategory: Silithus
EndScriptData */

/* ContentData
npcs_rutgar_and_frankal
quest_a_pawn_on_the_eternal_pawn
EndContentData */

#include "AccountMgr.h"
#include "CreatureScript.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "Group.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

/*####
# quest_a_pawn_on_the_eternal_board (Defines)
####*/
enum EternalBoard
{
    QUEST_A_PAWN_ON_THE_ETERNAL_BOARD   = 8519,

    C_ANACHRONOS                        = 15381,
    C_FANDRAL_STAGHELM                  = 15382,
    C_ARYGOS                            = 15380,
    C_MERITHRA                          = 15378,
    C_CAELESTRASZ                       = 15379,

    ANACHRONOS_SAY_1                    = 0,
    ANACHRONOS_SAY_2                    = 1,
    ANACHRONOS_SAY_3                    = 2,
    ANACHRONOS_SAY_4                    = 3,
    ANACHRONOS_SAY_5                    = 4,
    ANACHRONOS_SAY_6                    = 5,
    ANACHRONOS_SAY_7                    = 6,
    ANACHRONOS_SAY_8                    = 7,
    ANACHRONOS_SAY_9                    = 8,
    ANACHRONOS_SAY_10                   = 9,
    ANACHRONOS_EMOTE_1                  = 10,
    ANACHRONOS_EMOTE_2                  = 11,
    ANACHRONOS_EMOTE_3                  = 12,

    FANDRAL_SAY_1                       = 0,
    FANDRAL_SAY_2                       = 1,
    FANDRAL_SAY_3                       = 2,
    FANDRAL_SAY_4                       = 3,
    FANDRAL_SAY_5                       = 4,
    FANDRAL_SAY_6                       = 5,
    FANDRAL_EMOTE_1                     = 6,
    FANDRAL_EMOTE_2                     = 7,

    CAELESTRASZ_SAY_1                   = 0,
    CAELESTRASZ_SAY_2                   = 1,
    CAELESTRASZ_YELL_1                  = 2,

    ARYGOS_SAY_1                        = 0,
    ARYGOS_YELL_1                       = 1,
    ARYGOS_EMOTE_1                      = 2,

    MERITHRA_SAY_1                      = 0,
    MERITHRA_SAY_2                      = 1,
    MERITHRA_YELL_1                     = 2,
    MERITHRA_EMOTE_1                    = 3,

    GO_GATE_OF_AHN_QIRAJ                = 176146,
    GO_GLYPH_OF_AHN_QIRAJ               = 176148,
    GO_ROOTS_OF_AHN_QIRAJ               = 176147
};
/*#####
# Quest: A Pawn on the Eternal Board
#####*/

/* ContentData
A Pawn on the Eternal Board - creatures, gameobjects and defines
npc_qiraj_war_spawn : Adds that are summoned in the Qiraj gates battle.
npc_anachronos_the_ancient : Creature that controls the event.
npc_anachronos_quest_trigger: controls the spawning of the BG War mobs.
go_crystalline_tear : GameObject that begins the event and hands out quest
TO DO: get correct spell IDs and timings for spells cast upon dragon transformations
TO DO: Dragons should use the HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF) after transformation, but for some unknown reason it doesnt work.
EndContentData */

#define EVENT_AREA_RADIUS 65 //65yds
#define EVENT_COOLDOWN 500000 //in ms. appear after event completed or failed (should be = Adds despawn time)

struct QuestCinematic
{
    int32 TextId;
    uint32 Creature, Timer;
};

// Creature 0 - Anachronos, 1 - Fandral, 2 - Arygos, 3 - Merithra, 4 - Caelestrasz
static QuestCinematic EventAnim[] =
{
    {ANACHRONOS_SAY_1, 0, 2000},
    {FANDRAL_SAY_1, 1, 4000},
    {MERITHRA_EMOTE_1, 3, 500},
    {MERITHRA_SAY_1, 3, 500},
    {ARYGOS_EMOTE_1, 2, 2000},
    {CAELESTRASZ_SAY_1, 4, 8000},
    {MERITHRA_SAY_2, 3, 6000},
    {0, 3, 2000},
    {MERITHRA_YELL_1, 3, 2500},
    {0, 3, 3000}, //Morph
    {0, 3, 4000}, //EmoteLiftoff
    {0, 3, 4000}, // spell
    {0, 3, 1250}, //fly
    {0, 3, 250}, //remove flags
    {ARYGOS_SAY_1, 2, 3000},
    {0, 3, 2000},
    {ARYGOS_YELL_1, 2, 3000},
    {0, 3, 3000}, //Morph
    {0, 3, 4000}, //EmoteLiftoff
    {0, 3, 4000}, // spell
    {0, 3, 1000}, //fly
    {0, 3, 1000}, //remove flags
    {CAELESTRASZ_SAY_2, 4, 5000},
    {0, 3, 3000},
    {CAELESTRASZ_YELL_1, 4, 3000},
    {0, 3, 3000}, //Morph
    {0, 3, 4000}, //EmoteLiftoff
    {0, 3, 2500}, // spell
    {ANACHRONOS_SAY_2, 0, 2000},
    {0, 3, 250}, //fly
    {0, 3, 25}, //remove flags
    {FANDRAL_SAY_2, 1, 3000},
    {ANACHRONOS_SAY_3, 0, 10000}, //Both run through the armies
    {0, 3, 2000}, // Sands will stop
    {0, 3, 8000}, // Summon Gate
    {ANACHRONOS_SAY_4, 0, 4000},
    {0, 0, 2000}, //spell 1-> Arcane cosmetic (Mobs freeze)
    {0, 0, 5000}, //Spell 2-> Arcane long cosmetic (barrier appears) (Barrier -> Glyphs)
    {0, 0, 7000}, //BarrieR
    {0, 0, 4000}, //Glyphs
    {ANACHRONOS_SAY_5, 0, 2000},
    {0, 0, 4000}, // Roots
    {FANDRAL_SAY_3, 1, 3000}, //Root Text
    {FANDRAL_EMOTE_1, 1, 3000}, //falls knee
    {ANACHRONOS_SAY_6, 0, 3000},
    {ANACHRONOS_SAY_7, 0, 3000},
    {ANACHRONOS_SAY_8, 0, 8000},
    {ANACHRONOS_EMOTE_1, 0, 1000}, //Give Scepter
    {FANDRAL_SAY_4, 1, 3000},
    {FANDRAL_SAY_5, 1, 3000}, //->Equip hammer~Scepter, throw it at door
    {FANDRAL_EMOTE_2, 1, 3000}, //Throw hammer at door.
    {ANACHRONOS_SAY_9, 0, 3000},
    {FANDRAL_SAY_6, 1, 3000}, //fandral goes away
    {ANACHRONOS_EMOTE_2, 0, 3000},
    {ANACHRONOS_EMOTE_3, 0, 3000},
    {0, 0, 2000},
    {0, 0, 2000},
    {0, 0, 4000},
    {ANACHRONOS_SAY_10, 0, 3000},
    {0, 0, 2000},
    {0, 0, 3000},
    {0, 0, 15000},
    {0, 0, 5000},
    {0, 0, 3500},
    {0, 0, 5000},
    {0, 0, 3500},
    {0, 0, 5000},
    {0, 0, 0}
};

//Cordinates for Spawns
Position const SpawnLocation[] =
{
    {-8085.0f, 1528.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8080.0f, 1526.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8085.0f, 1524.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8080.0f, 1522.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8085.0f, 1520.0f, 2.61f, 3.141592f}, //Kaldorei Infantry

    {-8085.0f, 1524.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8080.0f, 1522.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8085.0f, 1520.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8080.0f, 1518.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8085.0f, 1516.0f, 2.61f, 3.141592f}, //Kaldorei Infantry

    {-8085.0f, 1518.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8080.0f, 1516.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8080.0f, 1520.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8080.0f, 1424.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8085.0f, 1422.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    // 2 waves of warriors
    {-8082.0f, 1528.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8078.0f, 1525.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8082.0f, 1524.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8078.0f, 1526.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8082.0f, 1527.0f, 2.61f, 3.141592f}, //Kaldorei Infantry

    {-8082.0f, 1524.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8078.0f, 1522.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8082.0f, 1520.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8078.0f, 1518.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8082.0f, 1516.0f, 2.61f, 3.141592f}, //Kaldorei Infantry

    {-8082.0f, 1523.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8078.0f, 1521.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8082.0f, 1528.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8078.0f, 1519.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8082.0f, 1526.0f, 2.61f, 3.141592f}, //Kaldorei Infantry

    {-8082.0f, 1524.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8078.0f, 1522.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8082.0f, 1520.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8078.0f, 1518.0f, 2.61f, 3.141592f}, //Kaldorei Infantry
    {-8082.0f, 1516.0f, 2.61f, 3.141592f}, //Kaldorei Infantry

    {-8088.0f, 1510.0f, 2.61f, 0.0f}, //Anubisath Conqueror
    {-8084.0f, 1520.0f, 2.61f, 0.0f}, //Anubisath Conqueror
    {-8088.0f, 1530.0f, 2.61f, 0.0f}, //Anubisath Conqueror

    {-8080.0f, 1513.0f, 2.61f, 0.0f}, //Qiraj Wasp
    {-8082.0f, 1523.0f, 2.61f, 0.0f}, //Qiraj Wasp
    {-8085.0f, 1518.0f, 2.61f, 0.0f}, //Qiraj Wasp
    {-8082.0f, 1516.0f, 2.61f, 0.0f}, //Qiraj Wasp
    {-8085.0f, 1520.0f, 2.61f, 0.0f}, //Qiraj Wasp
    {-8080.0f, 1528.0f, 2.61f, 0.0f}, //Qiraj Wasp

    {-8082.0f, 1513.0f, 2.61f, 0.0f}, //Qiraj Wasp
    {-8079.0f, 1523.0f, 2.61f, 0.0f}, //Qiraj Wasp
    {-8080.0f, 1531.0f, 2.61f, 0.0f}, //Qiraj Wasp
    {-8079.0f, 1516.0f, 2.61f, 0.0f}, //Qiraj Wasp
    {-8082.0f, 1520.0f, 2.61f, 0.0f}, //Qiraj Wasp
    {-8080.0f, 1518.0f, 2.61f, 0.0f}, //Qiraj Wasp

    {-8081.0f, 1514.0f, 2.61f, 0.0f}, //Qiraj Tank
    {-8081.0f, 1520.0f, 2.61f, 0.0f}, //Qiraj Tank
    {-8081.0f, 1526.0f, 2.61f, 0.0f}, //Qiraj Tank
    {-8081.0f, 1512.0f, 2.61f, 0.0f}, //Qiraj Tank
    {-8082.0f, 1520.0f, 2.61f, 0.0f}, //Qiraj Tank
    {-8081.0f, 1528.0f, 2.61f, 0.0f}, //Qiraj Tank

    {-8082.0f, 1513.0f, 2.61f, 3.141592f}, //Anubisath Conqueror
    {-8082.0f, 1520.0f, 2.61f, 3.141592f}, //Anubisath Conqueror
    {-8082.0f, 1527.0f, 2.61f, 3.141592f}, //Anubisath Conqueror
};

struct WaveData
{
    uint8 SpawnCount, UsedSpawnPoint;
    uint32 CreatureId, SpawnTimer, YellTimer, DespTimer;
    int32 WaveTextId;
};

static WaveData WavesInfo[5] =
{
    {30,  0, 15423, 0, 0, 24000, 0},    // Kaldorei Soldier
    { 3, 35, 15424, 0, 0, 24000, 0},    // Anubisath Conqueror
    {12, 38, 15414, 0, 0, 24000, 0},    // Qiraji Wasps
    { 6, 50, 15422, 0, 0, 24000, 0},    // Qiraji Tanks
    {15, 15, 15423, 0, 0, 24000, 0}     // Kaldorei Soldier
};

struct SpawnSpells
{
    uint32 Timer1, Timer2, SpellId;
};

static SpawnSpells SpawnCast[4] =
{
    {100000, 2000, 33652},   // Stop Time
    {38500, 300000, 28528},  // Poison Cloud
    {58000, 300000, 35871},  // Frost Debuff (need correct spell)
    {80950, 300000, 42075},  // Fire Explosion (need correct spell however this one looks cool)
};
/*#####
# npc_anachronos_the_ancient
######*/
class npc_anachronos_the_ancient : public CreatureScript
{
public:
    npc_anachronos_the_ancient() : CreatureScript("npc_anachronos_the_ancient") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_anachronos_the_ancientAI(creature);
    }

    struct npc_anachronos_the_ancientAI : public ScriptedAI
    {
        npc_anachronos_the_ancientAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 AnimationTimer;
        uint8 AnimationCount;

        ObjectGuid AnachronosQuestTriggerGUID;
        ObjectGuid MerithraGUID;
        ObjectGuid ArygosGUID;
        ObjectGuid CaelestraszGUID;
        ObjectGuid FandralGUID;
        ObjectGuid PlayerGUID;
        bool eventEnd;

        void Reset() override
        {
            AnimationTimer = 1500;
            AnimationCount = 0;
            AnachronosQuestTriggerGUID.Clear();
            MerithraGUID.Clear();
            ArygosGUID.Clear();
            CaelestraszGUID.Clear();
            FandralGUID.Clear();
            PlayerGUID.Clear();
            eventEnd = false;

            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        }

        void HandleAnimation()
        {
            Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID);

            if (!player)
            {
                return;
            }

            Creature* Fandral = player->FindNearestCreature(C_FANDRAL_STAGHELM, 100.0f);
            Creature* Arygos = player->FindNearestCreature(C_ARYGOS, 100.0f);
            Creature* Caelestrasz = player->FindNearestCreature(C_CAELESTRASZ, 100.0f);
            Creature* Merithra = player->FindNearestCreature(C_MERITHRA, 100.0f);

            if (!Fandral || !Arygos || !Caelestrasz || !Merithra)
                return;

            AnimationTimer = EventAnim[AnimationCount].Timer;
            if (!eventEnd)
            {
                switch (AnimationCount)
                {
                    case 0:
                        Talk(ANACHRONOS_SAY_1, Fandral);
                        break;
                    case 1:
                        Fandral->SetTarget(me->GetGUID());
                        Fandral->AI()->Talk(FANDRAL_SAY_1, me);
                        break;
                    case 2:
                        Fandral->SetTarget();
                        Merithra->AI()->Talk(MERITHRA_EMOTE_1);
                        break;
                    case 3:
                        Merithra->AI()->Talk(MERITHRA_SAY_1);
                        break;
                    case 4:
                        Arygos->AI()->Talk(ARYGOS_EMOTE_1);
                        break;
                    case 5:
                        Caelestrasz->SetTarget(Fandral->GetGUID());
                        Caelestrasz->AI()->Talk(CAELESTRASZ_SAY_1);
                        break;
                    case 6:
                        Merithra->AI()->Talk(MERITHRA_SAY_2);
                        break;
                    case 7:
                        Caelestrasz->SetTarget();
                        Merithra->GetMotionMaster()->MoveCharge(-8065, 1530, 2.61f, 10);
                        break;
                    case 8:
                        Merithra->AI()->Talk(MERITHRA_YELL_1);
                        break;
                    case 9:
                        Merithra->CastSpell(Merithra, 25105, true);
                        break;
                    case 10:
                        Merithra->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                        Merithra->SetDisableGravity(true);
                        Merithra->GetMotionMaster()->MoveCharge(-8065, 1530, 6.61f, 3);
                        break;
                    case 11:
                        Merithra->CastSpell(Merithra, 24818, false);
                        break;
                    case 12:
                        Merithra->GetMotionMaster()->MoveCharge(-8100, 1530, 50, 42);
                        break;
                    case 13:
                        break;
                    case 14:
                        Arygos->AI()->Talk(ARYGOS_SAY_1);
                        Merithra->SetVisible(false);
                        break;
                    case 15:
                        Arygos->GetMotionMaster()->MoveCharge(-8065, 1530, 2.61f, 10);
                        Merithra->GetMotionMaster()->MoveCharge(-8034.535f, 1535.14f, 2.61f, 42);
                        break;
                    case 16:
                        Arygos->AI()->Talk(ARYGOS_YELL_1);
                        break;
                    case 17:
                        Arygos->CastSpell(Arygos, 25107, true);
                        break;
                    case 18:
                        Arygos->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                        Arygos->SetDisableGravity(true);
                        Arygos->GetMotionMaster()->MoveCharge(-8065, 1530, 6.61f, 42);
                        break;
                    case 19:
                        Arygos->CastSpell(Arygos, 50505, false);
                        break;
                    case 20:
                        Arygos->GetMotionMaster()->MoveCharge(-8095, 1530, 50, 42);
                        break;
                    case 21:
                        break;
                    case 22:
                        Caelestrasz->AI()->Talk(CAELESTRASZ_SAY_2, Fandral);
                        break;
                    case 23:
                        Caelestrasz->GetMotionMaster()->MoveCharge(-8065, 1530, 2.61f, 10);
                        Arygos->SetVisible(false);
                        Arygos->GetMotionMaster()->MoveCharge(-8034.535f, 1535.14f, 2.61f, 10);
                        break;
                    case 24:
                        Caelestrasz->AI()->Talk(CAELESTRASZ_YELL_1);
                        break;
                    case 25:
                        Caelestrasz->CastSpell(Caelestrasz, 25106, true);
                        break;
                    case 26:
                        Caelestrasz->HandleEmoteCommand(254);
                        Caelestrasz->SetDisableGravity(true);
                        Caelestrasz->GetMotionMaster()->MoveCharge(-8065, 1530, 7.61f, 4);
                        break;
                    case 27:
                        Caelestrasz->CastSpell(Caelestrasz, 54293, false);
                        break;
                    case 28:
                        Talk(ANACHRONOS_SAY_2, Fandral);
                        break;
                    case 29:
                        Caelestrasz->GetMotionMaster()->MoveCharge(-8095, 1530, 50, 42);
                        Fandral->AI()->Talk(FANDRAL_SAY_2);
                        break;
                    case 30:
                        break;
                    case 31:
                        Talk(ANACHRONOS_SAY_3, Fandral);
                        break;
                    case 32:
                        Caelestrasz->SetVisible(false);
                        Caelestrasz->GetMotionMaster()->MoveCharge(-8034.535f, 1535.14f, 2.61f, 42);
                        Fandral->GetMotionMaster()->MoveCharge(-8108, 1529, 2.77f, 8);
                        me->GetMotionMaster()->MoveCharge(-8113, 1525, 2.77f, 8);
                        break;//both run to the gate
                    case 33:
                        Talk(ANACHRONOS_SAY_4);
                        Caelestrasz->GetMotionMaster()->MoveCharge(-8050, 1473, 65, 15);
                        break; //Text: sands will stop
                    case 34:
                        DoCast(player, 23017, true);//Arcane Channeling
                        break;
                    case 35:
                        me->CastSpell(-8088, 1520.43f, 2.67f, 25158, true);
                        break;
                    case 36:
                        DoCast(player, 25159, true);
                        break;
                    case 37:
                        me->SummonGameObject(GO_GATE_OF_AHN_QIRAJ, -8130, 1525, 17.5f, 0, 0, 0, 0, 0, 0);
                        break;
                    case 38:
                        DoCast(player, 25166, true);
                        me->SummonGameObject(GO_GLYPH_OF_AHN_QIRAJ, -8130, 1525, 17.5f, 0, 0, 0, 0, 0, 0);
                        break;
                    case 39:
                        Talk(ANACHRONOS_SAY_5, Fandral);
                        break;
                    case 40:
                        Fandral->CastSpell(me, 25167, true);
                        break;
                    case 41:
                        Fandral->SummonGameObject(GO_ROOTS_OF_AHN_QIRAJ, -8130, 1525, 17.5f, 0, 0, 0, 0, 0, 0);
                        Fandral->AI()->Talk(FANDRAL_SAY_3);
                        break;
                    case 42:
                        me->CastStop();
                        Fandral->AI()->Talk(FANDRAL_EMOTE_1);
                        break;
                    case 43:
                        Fandral->CastStop();
                        break;
                    case 44:
                        Talk(ANACHRONOS_SAY_6);
                        break;
                    case 45:
                        Talk(ANACHRONOS_SAY_7);
                        break;
                    case 46:
                        Talk(ANACHRONOS_SAY_8);
                        me->GetMotionMaster()->MoveCharge(-8110, 1527, 2.77f, 4);
                        break;
                    case 47:
                        Talk(ANACHRONOS_EMOTE_1);
                        break;
                    case 48:
                        Fandral->AI()->Talk(FANDRAL_SAY_4, me);
                        break;
                    case 49:
                        Fandral->AI()->Talk(FANDRAL_SAY_5, me);
                        break;
                    case 50:
                        Fandral->AI()->Talk(FANDRAL_EMOTE_2);
                        Fandral->CastSpell(-8127, 1525, 17.5f, 33806, true);
                        break;
                    case 51:
                        {
                            std::list<Creature*> constructList;

                            me->GetCreatureListWithEntryInGrid(constructList, 15423, 100.0f);
                            me->GetCreatureListWithEntryInGrid(constructList, 15424, 100.0f);
                            me->GetCreatureListWithEntryInGrid(constructList, 15414, 100.0f);
                            me->GetCreatureListWithEntryInGrid(constructList, 15422, 100.0f);

                            if (!constructList.empty())
                            {
                                for (std::list<Creature*>::const_iterator itr = constructList.begin(); itr != constructList.end(); ++itr)
                                {
                                    (*itr)->RemoveFromWorld();
                                }
                            }

                            break;
                        }
                    case 52:
                        Fandral->GetMotionMaster()->MoveCharge(-8028.75f, 1538.795f, 2.61f, 4);
                        Talk(ANACHRONOS_SAY_9);
                        break;
                    case 53:
                        Fandral->AI()->Talk(FANDRAL_SAY_6);
                        break;
                    case 54:
                        Talk(ANACHRONOS_EMOTE_2);
                        break;
                    case 55:
                        //Fandral should not dispear atm.
                        //Fandral->SetVisible(false);
                        break;
                    case 56:
                        Talk(ANACHRONOS_EMOTE_3);
                        me->GetMotionMaster()->MoveCharge(-8116, 1522, 3.65f, 4);
                        break;
                    case 57:
                        me->GetMotionMaster()->MoveCharge(-8116.7f, 1527, 3.7f, 4);
                        break;
                    case 58:
                        me->GetMotionMaster()->MoveCharge(-8112.67f, 1529.9f, 2.86f, 4);
                        break;
                    case 59:
                        me->GetMotionMaster()->MoveCharge(-8117.99f, 1532.24f, 3.94f, 4);
                        break;
                    case 60:
                        Talk(ANACHRONOS_SAY_10, player);
                        me->GetMotionMaster()->MoveCharge(-8113.46f, 1524.16f, 2.89f, 4);
                        break;
                    case 61:
                        me->GetMotionMaster()->MoveCharge(-8057.1f, 1470.32f, 2.61f, 6);
                        if (player->IsInRange(me, 0, 15))
                            player->GroupEventHappens(QUEST_A_PAWN_ON_THE_ETERNAL_BOARD, me);
                        break;
                    case 62:
                        me->SetDisplayId(15500);
                        break;
                    case 63:
                        me->HandleEmoteCommand(254);
                        me->SetDisableGravity(true);
                        break;
                    case 64:
                        me->GetMotionMaster()->MoveCharge(-8000, 1400, 150, 9);
                        break;
                    case 65:
                        me->SetVisible(false);
                        if (Creature* AnachronosQuestTrigger = (ObjectAccessor::GetCreature(*me, AnachronosQuestTriggerGUID)))
                        {
                            Talk(ARYGOS_YELL_1);
                            AnachronosQuestTrigger->AI()->EnterEvadeMode();
                            eventEnd = true;
                        }
                        break;
                }
            }
            ++AnimationCount;
        }
        void UpdateAI(uint32 diff) override
        {
            if (AnimationTimer)
            {
                if (AnimationTimer <= diff)
                    HandleAnimation();
                else AnimationTimer -= diff;
            }
            if (AnimationCount < 65)
                me->CombatStop();
            if (AnimationCount == 65 || eventEnd)
                EnterEvadeMode();
        }
    };
};

/*######
# npc_qiraj_war_spawn
######*/

class npc_qiraj_war_spawn : public CreatureScript
{
public:
    npc_qiraj_war_spawn() : CreatureScript("npc_qiraj_war_spawn") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_qiraj_war_spawnAI(creature);
    }

    struct npc_qiraj_war_spawnAI : public ScriptedAI
    {
        npc_qiraj_war_spawnAI(Creature* creature) : ScriptedAI(creature) { }

        ObjectGuid MobGUID;
        ObjectGuid PlayerGUID;
        uint32 SpellTimer1, SpellTimer2, SpellTimer3, SpellTimer4;
        bool Timers;
        bool hasTarget;

        void Reset() override
        {
            MobGUID.Clear();
            PlayerGUID.Clear();
            Timers = false;
            hasTarget = false;
        }

        void JustEngagedWith(Unit* /*who*/) override { }
        void JustDied(Unit* /*slayer*/) override;

        void UpdateAI(uint32 diff) override
        {
            if (!Timers)
            {
                if (me->GetEntry() == 15424 || me->GetEntry() == 15422 || me->GetEntry() == 15414) //all but Kaldorei Soldiers
                {
                    SpellTimer1 = SpawnCast[1].Timer1;
                    SpellTimer2 = SpawnCast[2].Timer1;
                    SpellTimer3 = SpawnCast[3].Timer1;
                }
                if (me->GetEntry() == 15423 || me->GetEntry() == 15424 || me->GetEntry() == 15422 || me->GetEntry() == 15414)
                    SpellTimer4 = SpawnCast[0].Timer1;
                Timers = true;
            }
            if (me->GetEntry() == 15424 || me->GetEntry() == 15422 || me->GetEntry() == 15414)
            {
                if (SpellTimer1 <= diff)
                {
                    DoCast(me, SpawnCast[1].SpellId);
                    DoCast(me, 24319);
                    SpellTimer1 = SpawnCast[1].Timer2;
                }
                else SpellTimer1 -= diff;
                if (SpellTimer2 <= diff)
                {
                    DoCast(me, SpawnCast[2].SpellId);
                    SpellTimer2 = SpawnCast[2].Timer2;
                }
                else SpellTimer2 -= diff;
                if (SpellTimer3 <= diff)
                {
                    DoCast(me, SpawnCast[3].SpellId);
                    SpellTimer3 = SpawnCast[3].Timer2;
                }
                else SpellTimer3 -= diff;
            }
            if (me->GetEntry() == 15423 || me->GetEntry() == 15424 || me->GetEntry() == 15422 || me->GetEntry() == 15414)
            {
                if (SpellTimer4 <= diff)
                {
                    me->RemoveAllAttackers();
                    me->AttackStop();
                    DoCast(me, 15533);
                    SpellTimer4 = SpawnCast[0].Timer2;
                }
                else SpellTimer4 -= diff;
            }
            if (!hasTarget)
            {
                Unit* target = nullptr;
                if (me->GetEntry() == 15424 || me->GetEntry() == 15422 || me->GetEntry() == 15414)
                    target = me->FindNearestCreature(15423, 20, true);
                if (me->GetEntry() == 15423)
                {
                    uint8 tar = urand(0, 2);

                    if (tar == 0)
                        target = me->FindNearestCreature(15422, 20, true);
                    else if (tar == 1)
                        target = me->FindNearestCreature(15424, 20, true);
                    else if (tar == 2)
                        target = me->FindNearestCreature(15414, 20, true);
                }
                hasTarget = true;
                if (target)
                    AttackStart(target);
            }
            if (!(me->FindNearestCreature(15379, 60)))
                DoCast(me, 33652);

            if (!UpdateVictim())
            {
                hasTarget = false;
                return;
            }

            DoMeleeAttackIfReady();
        }
    };
};

/*#####
# npc_anachronos_quest_trigger
#####*/

class npc_anachronos_quest_trigger : public CreatureScript
{
public:
    npc_anachronos_quest_trigger() : CreatureScript("npc_anachronos_quest_trigger") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_anachronos_quest_triggerAI(creature);
    }

    struct npc_anachronos_quest_triggerAI : public ScriptedAI
    {
        npc_anachronos_quest_triggerAI(Creature* creature) : ScriptedAI(creature) { }

        ObjectGuid PlayerGUID;

        uint32 WaveTimer;
        uint32 AnnounceTimer;

        int8 LiveCount;
        uint8 WaveCount;

        bool EventStarted;
        bool Announced;
        bool Failed;

        void Reset() override
        {
            PlayerGUID.Clear();

            WaveTimer = 2000;
            AnnounceTimer = 1000;
            LiveCount = 0;
            WaveCount = 0;

            EventStarted = false;
            Announced = false;
            Failed = false;

            me->SetVisible(false);
        }

        void SummonNextWave()
        {
            uint8 locIndex = WavesInfo[WaveCount].UsedSpawnPoint;
            uint8 count = locIndex + WavesInfo[WaveCount].SpawnCount;

            for (uint8 i = locIndex; i <= count; ++i)
            {
                uint32 desptimer = WavesInfo[WaveCount].DespTimer;

                if (Creature* spawn = me->SummonCreature(WavesInfo[WaveCount].CreatureId, SpawnLocation[i], TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, desptimer))
                {
                    if (spawn->GetEntry() == 15423)
                        spawn->SetUInt32Value(UNIT_FIELD_DISPLAYID, 15427 + rand() % 4);
                    if (i >= 30) WaveCount = 1;
                    if (i >= 33) WaveCount = 2;
                    if (i >= 45) WaveCount = 3;
                    if (i >= 51) WaveCount = 4;

                    if (WaveCount < 5) //1-4 Wave
                    {
                        if (npc_qiraj_war_spawn::npc_qiraj_war_spawnAI* spawnAI = CAST_AI(npc_qiraj_war_spawn::npc_qiraj_war_spawnAI, spawn->AI()))
                        {
                            spawnAI->MobGUID = me->GetGUID();
                            spawnAI->PlayerGUID = PlayerGUID;
                        }
                    }
                }
            }

            WaveTimer = WavesInfo[WaveCount].SpawnTimer;
            AnnounceTimer = WavesInfo[WaveCount].YellTimer;
        }

        void CheckEventFail()
        {
            Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID);
            if (!player)
                return;

            if (Group* EventGroup = player->GetGroup())
            {
                uint8 GroupMemberCount = 0;
                uint8 FailedMemberCount = 0;

                Group::MemberSlotList const& members = EventGroup->GetMemberSlots();

                for (Group::member_citerator itr = members.begin(); itr != members.end(); ++itr)
                {
                    Player* groupMember = ObjectAccessor::GetPlayer(*me, itr->guid);
                    if (!groupMember)
                        continue;
                    if (!groupMember->IsWithinDistInMap(me, EVENT_AREA_RADIUS) && groupMember->GetQuestStatus(QUEST_A_PAWN_ON_THE_ETERNAL_BOARD) == QUEST_STATUS_INCOMPLETE)
                    {
                        groupMember->FailQuest(QUEST_A_PAWN_ON_THE_ETERNAL_BOARD);
                        ++FailedMemberCount;
                    }
                    ++GroupMemberCount;
                }

                if (GroupMemberCount == FailedMemberCount || !player->IsWithinDistInMap(me, EVENT_AREA_RADIUS))
                    Failed = true; //only so event can restart
            }
        }

        void LiveCounter()
        {
            --LiveCount;
            if (!LiveCount)
                Announced = false;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!PlayerGUID || !EventStarted)
                return;

            if (WaveCount < 4)
            {
                if (!Announced && AnnounceTimer <= diff)
                {
                    Talk(WavesInfo[WaveCount].WaveTextId);
                    Announced = true;
                }
                else AnnounceTimer -= diff;

                if (WaveTimer <= diff)
                    SummonNextWave();
                else WaveTimer -= diff;
            }
            CheckEventFail();
            if (WaveCount == 4 || Failed)
                EnterEvadeMode();
        };
    };
};

void npc_qiraj_war_spawn::npc_qiraj_war_spawnAI::JustDied(Unit* /*slayer*/)
{
    me->RemoveCorpse();

    if (!MobGUID)
        return;

    if (Creature* mob = ObjectAccessor::GetCreature(*me, MobGUID))
        if (npc_anachronos_quest_trigger::npc_anachronos_quest_triggerAI* triggerAI = CAST_AI(npc_anachronos_quest_trigger::npc_anachronos_quest_triggerAI, mob->AI()))
            triggerAI->LiveCounter();
}

/*#####
# go_crystalline_tear
######*/

class go_crystalline_tear : public GameObjectScript
{
public:
    go_crystalline_tear() : GameObjectScript("go_crystalline_tear") { }

    bool OnQuestAccept(Player* player, GameObject* go, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_A_PAWN_ON_THE_ETERNAL_BOARD)
        {
            if (Creature* trigger = go->FindNearestCreature(15454, 100, player))
            {
                Unit* Merithra = trigger->SummonCreature(15378, -8034.535f, 1535.14f, 2.61f, 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 220000);
                Unit* Caelestrasz = trigger->SummonCreature(15379, -8032.767f, 1533.148f, 2.61f, 1.5f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 220000);
                Unit* Arygos = trigger->SummonCreature(15380, -8034.52f, 1537.843f, 2.61f, 5.7f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 220000);
                /* Unit* Fandral = */ trigger->SummonCreature(15382, -8028.462f, 1535.843f, 2.61f, 3.141592f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 220000);
                Creature* Anachronos = trigger->SummonCreature(15381, -8028.75f, 1538.795f, 2.61f, 4, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 220000);

                if (Merithra)
                {
                    Merithra->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                    Merithra->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
                    Merithra->SetUInt32Value(UNIT_FIELD_DISPLAYID, 15420);
                    Merithra->SetFaction(FACTION_FRIENDLY);
                }

                if (Caelestrasz)
                {
                    Caelestrasz->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                    Caelestrasz->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
                    Caelestrasz->SetUInt32Value(UNIT_FIELD_DISPLAYID, 15419);
                    Caelestrasz->SetFaction(FACTION_FRIENDLY);
                }

                if (Arygos)
                {
                    Arygos->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                    Arygos->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
                    Arygos->SetUInt32Value(UNIT_FIELD_DISPLAYID, 15418);
                    Arygos->SetFaction(FACTION_FRIENDLY);
                }

                if (Anachronos)
                {
                    if (npc_anachronos_the_ancient::npc_anachronos_the_ancientAI* anachronosAI = CAST_AI(npc_anachronos_the_ancient::npc_anachronos_the_ancientAI, Anachronos->AI()))
                        anachronosAI->PlayerGUID = player->GetGUID();

                    if (npc_anachronos_quest_trigger::npc_anachronos_quest_triggerAI* triggerAI = CAST_AI(npc_anachronos_quest_trigger::npc_anachronos_quest_triggerAI, trigger->AI()))
                    {
                        triggerAI->Failed = false;
                        triggerAI->PlayerGUID = player->GetGUID();
                        triggerAI->EventStarted = true;
                        triggerAI->Announced = true;
                    }
                }
            }
        }
        return true;
    }
};

/*###
## go_wind_stone
###*/

enum WindStone
{
    AURA_TWILIGHT_SET    = 24746,
    AURA_MEDALLION       = 24748,
    AURA_RING            = 24782,
    SPELL_PUNISHMENT     = 24803,
    SPELL_SPAWN_IN       = 25035,
    SPELL_TEMPLAR_RANDOM = 24745,
    SPELL_TEMPLAR_FIRE   = 24747,
    SPELL_TEMPLAR_AIR    = 24757,
    SPELL_TEMPLAR_EARTH  = 24759,
    SPELL_TEMPLAR_WATER  = 24761,
    SPELL_DUKE_RANDOM    = 24762,
    SPELL_DUKE_FIRE      = 24766,
    SPELL_DUKE_AIR       = 24769,
    SPELL_DUKE_EARTH     = 24771,
    SPELL_DUKE_WATER     = 24773,
    SPELL_ROYAL_RANDOM   = 24785,
    SPELL_ROYAL_FIRE     = 24787,
    SPELL_ROYAL_AIR      = 24791,
    SPELL_ROYAL_EARTH    = 24792,
    SPELL_ROYAL_WATER    = 24793,
    GOSSIPID_LESSER_WS   = 6540,
    GOSSIPID_WS          = 6542,
    GOSSIPID_GREATER_WS  = 6543,
    NPC_TEMPLAR_FIRE     = 15209,
    NPC_TEMPLAR_WATER    = 15211,
    NPC_TEMPLAR_AIR      = 15212,
    NPC_TEMPLAR_EARTH    = 15307,
    NPC_DUKE_FIRE        = 15206,
    NPC_DUKE_WATER       = 15207,
    NPC_DUKE_EARTH       = 15208,
    NPC_DUKE_AIR         = 15220,
    NPC_ROYAL_FIRE       = 15203,
    NPC_ROYAL_AIR        = 15204,
    NPC_ROYAL_EARTH      = 15205,
    NPC_ROYAL_WATER      = 15305,
    SAY_ON_SPAWN_IN      = 0
};

class DelayedWindstoneSummonEvent : public BasicEvent
{
public:
    DelayedWindstoneSummonEvent(TempSummon* summon, ObjectGuid playerGUID) : _summon(summon), _playerGUID(playerGUID) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        if (Player* player = ObjectAccessor::FindPlayer(_playerGUID))
        {
            _summon->AI()->AttackStart(player);
        }

        return true;
    }

private:
    TempSummon* _summon;
    ObjectGuid _playerGUID;
};

class go_wind_stone : public GameObjectScript
{
public:
    go_wind_stone() : GameObjectScript("go_wind_stone") {}

    struct go_wind_stoneAI : public GameObjectAI
    {
        go_wind_stoneAI(GameObject* go) : GameObjectAI(go) {}

        void InitializeAI() override
        {
            me->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
        }

        bool GossipHello(Player* player, bool reportUse) override
        {
            if (reportUse)
            {
                uint32 gossipId         = me->GetGOInfo()->GetGossipMenuId();
                bool   _twilightSetAura = (player->HasAura(AURA_TWILIGHT_SET, player->GetGUID()));
                bool   _medallionAura   = (player->HasAura(AURA_MEDALLION, player->GetGUID()));
                bool   _ringAura        = (player->HasAura(AURA_RING, player->GetGUID()));

                switch (gossipId)
                {
                case GOSSIPID_LESSER_WS:
                {
                    if (!_twilightSetAura)
                        me->CastSpell(player, SPELL_PUNISHMENT);
                    break;
                }
                case GOSSIPID_WS:
                {
                    if (!_twilightSetAura || !_medallionAura)
                        me->CastSpell(player, SPELL_PUNISHMENT);
                    break;
                }
                case GOSSIPID_GREATER_WS:
                {
                    if (!_twilightSetAura || !_medallionAura || !_ringAura)
                        me->CastSpell(player, SPELL_PUNISHMENT);
                    break;
                }
                default:
                    break;
                }
            }
            return false;
        }

        bool GossipSelect(Player* player, uint32 sender, uint32 action) override
        {
            Seconds respawnTimer{};
            player->PlayerTalkClass->SendCloseGossip();

            Creature* lastSpawn = ObjectAccessor::GetCreature(*me, _creatureGuid);
            if (lastSpawn && lastSpawn->IsAlive())
            {
                // We already summoned something recently, return.
                CloseGossipMenuFor(player);
                return true;
            }
            else
            {
                _creatureGuid.Clear();
            }

            if (sender == GOSSIPID_LESSER_WS)
            {
                respawnTimer = 300s; // Lesser Windstone respawn in 5 minutes

                switch (action)
                {
                case 0:
                    SummonNPC(me, player, RAND(NPC_TEMPLAR_WATER, NPC_TEMPLAR_FIRE, NPC_TEMPLAR_EARTH, NPC_TEMPLAR_AIR), SPELL_TEMPLAR_RANDOM);
                    break;
                case 1:
                    SummonNPC(me, player, NPC_TEMPLAR_FIRE, SPELL_TEMPLAR_FIRE);
                    break;
                case 2:
                    SummonNPC(me, player, NPC_TEMPLAR_WATER, SPELL_TEMPLAR_WATER);
                    break;
                case 3:
                    SummonNPC(me, player, NPC_TEMPLAR_EARTH, SPELL_TEMPLAR_EARTH);
                    break;
                case 4:
                    SummonNPC(me, player, NPC_TEMPLAR_AIR, SPELL_TEMPLAR_AIR);
                    break;
                default:
                    break;
                }
            }
            else if (sender == GOSSIPID_WS)
            {
                respawnTimer = 900s; // Windstone respawn in 15 minutes

                switch (action)
                {
                case 0:
                    SummonNPC(me, player, RAND(NPC_DUKE_WATER, NPC_DUKE_FIRE, NPC_DUKE_EARTH, NPC_DUKE_AIR), SPELL_DUKE_RANDOM);
                    break;
                case 1:
                    SummonNPC(me, player, NPC_DUKE_FIRE, SPELL_DUKE_FIRE);
                    break;
                case 2:
                    SummonNPC(me, player, NPC_DUKE_WATER, SPELL_DUKE_WATER);
                    break;
                case 3:
                    SummonNPC(me, player, NPC_DUKE_EARTH, SPELL_DUKE_EARTH);
                    break;
                case 4:
                    SummonNPC(me, player, NPC_DUKE_AIR, SPELL_DUKE_AIR);
                    break;
                default:
                    break;
                }
            }
            else if (sender == GOSSIPID_GREATER_WS)
            {
                respawnTimer = 10800s; // Greater Windstone respawn in 3 hours

                switch (action)
                {
                case 0:
                    SummonNPC(me, player, RAND(NPC_ROYAL_WATER, NPC_ROYAL_FIRE, NPC_ROYAL_EARTH, NPC_ROYAL_AIR), SPELL_ROYAL_RANDOM);
                    break;
                case 1:
                    SummonNPC(me, player, NPC_ROYAL_FIRE, SPELL_ROYAL_FIRE);
                    break;
                case 2:
                    SummonNPC(me, player, NPC_ROYAL_WATER, SPELL_ROYAL_WATER);
                    break;
                case 3:
                    SummonNPC(me, player, NPC_ROYAL_EARTH, SPELL_ROYAL_EARTH);
                    break;
                case 4:
                    SummonNPC(me, player, NPC_ROYAL_AIR, SPELL_ROYAL_AIR);
                    break;
                default:
                    break;
                }
            }

            me->DespawnOrUnsummon(5000ms, respawnTimer); // Despawn in 5 Seconds for respawnTimer value
            me->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
            CloseGossipMenuFor(player);
            return false;
        }

        void SummonNPC(GameObject* go, Player* player, uint32 npc, uint32 spellId)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
            if (!spellInfo)
                return;
            SpellInfo const* spellInfoTrigger = sSpellMgr->GetSpellInfo(spellInfo->Effects[EFFECT_0].TriggerSpell);
            if (!spellInfoTrigger)
                return;
            Spell*          spell  = new Spell(player, spellInfoTrigger, TRIGGERED_NONE);
            SpellCastResult result = spell->CheckCast(true);
            delete spell;
            if (result != SPELL_CAST_OK)
            {
                return;
            }
            player->CastSpell(player, spellInfoTrigger->Id, false);
            if (TempSummon* summons = go->SummonCreature(npc, go->GetPositionX(), go->GetPositionY(), go->GetPositionZ(), player->GetOrientation() - M_PI, TEMPSUMMON_TIMED_DESPAWN_OOC_ALIVE, 6000))
            {
                summons->SetCorpseDelay(5 * MINUTE);
                summons->SetTarget(player->GetGUID());
                summons->SetLootRecipient(player);
                summons->CastSpell(summons, SPELL_SPAWN_IN, false);
                summons->AI()->Talk(SAY_ON_SPAWN_IN, player);
                summons->m_Events.AddEvent(new DelayedWindstoneSummonEvent(summons, player->GetGUID()), summons->m_Events.CalculateTime(5200));
                _creatureGuid = summons->GetGUID();
            }
        }

        private:
            ObjectGuid _creatureGuid;
    };

    GameObjectAI* GetAI(GameObject* go) const
    {
        return new go_wind_stoneAI(go);
    }

};

void AddSC_silithus()
{
    new go_crystalline_tear();
    new npc_anachronos_quest_trigger();
    new npc_anachronos_the_ancient();
    new npc_qiraj_war_spawn();
    new go_wind_stone();
}
