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

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "shadow_labyrinth.h"

enum GrandmasterVorpil
{
    SAY_INTRO                   = 0,
    SAY_AGGRO                   = 1,
    SAY_HELP                    = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,

    SPELL_RAIN_OF_FIRE_N        = 33617,
    SPELL_RAIN_OF_FIRE_H        = 39363,

    SPELL_DRAW_SHADOWS          = 33563,
    SPELL_SHADOWBOLT_VOLLEY     = 33841,
    SPELL_BANISH                = 38791,

    NPC_VOID_TRAVELER           = 19226,
    SPELL_SACRIFICE             = 33587,
    SPELL_SHADOW_NOVA           = 33846,
    SPELL_EMPOWERING_SHADOWS_N  = 33783,
    SPELL_EMPOWERING_SHADOWS_H  = 39364,

    NPC_VOID_PORTAL             = 19224,
    SPELL_VOID_PORTAL_VISUAL    = 33569,
};

float VorpilPosition[3] = {-253.548f, -263.646f, 17.0864f};

//x, y, z, and orientation
float VoidPortalCoords[5][4] =
{
    {-208.411f, -263.652f, 17.086313f, 3.121870040893554687f},  //portal A 33566
    {-261.676f, -297.69f, 17.087011f, 1.360249996185302734f},   //portal B 33614
    {-282.272f, -240.432f, 12.683899f, 5.580170154571533203f},  //portal C 33615
    {-291.833f, -268.595f, 12.682545f, 0.047733999788761138f},  //portal D 33567
    {-303.966f, -255.759f, 12.683404f, 6.012829780578613281f}   //portal E 33616
};

struct boss_grandmaster_vorpil : public BossAI
{
    boss_grandmaster_vorpil(Creature* creature) : BossAI(creature, DATA_GRANDMASTER_VORPIL)
    {
        sayIntro = false;
    }

    bool sayIntro, sayHelp;

    void Reset() override
    {
        _Reset();
        sayHelp = false;
    }

    void summonPortals()
    {
        for (uint8 i = 0; i < 5; ++i)
        {
            me->SummonCreature(NPC_VOID_PORTAL, VoidPortalCoords[i][0], VoidPortalCoords[i][1], VoidPortalCoords[i][2], VoidPortalCoords[i][3], TEMPSUMMON_CORPSE_DESPAWN, 3000000);
        }
    }

    void spawnVoidTraveler()
    {
        uint8 pos = urand(0, 4);
        me->SummonCreature(NPC_VOID_TRAVELER, VoidPortalCoords[pos][0], VoidPortalCoords[pos][1], VoidPortalCoords[pos][2], VoidPortalCoords[pos][3], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
        if (!sayHelp)
        {
            Talk(SAY_HELP);
            sayHelp = true;
        }
    }

    Milliseconds counterVoidSpawns(uint8 count)
    {
        switch (count)
        {
            case 1:
            case 2:
                return 13300ms;
            case 3:
                return 12100ms;
            case 4:
                return 10900ms;
            case 5:
            case 6:
                return 9700ms;
            case 7:
            case 8:
                return 7200ms;
            case 9:
                return 6000ms;
            default:
                return 4800ms;
        }

        return 1s;
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (summon->GetEntry() == NPC_VOID_TRAVELER)
        {
            summon->AI()->SetGUID(me->GetGUID());
        }
        else if (summon->GetEntry() == NPC_VOID_PORTAL)
        {
            summon->CastSpell(summon, SPELL_VOID_PORTAL_VISUAL, false);
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        _JustDied();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        summonPortals();

        scheduler.Schedule(9700ms, 20s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_SHADOWBOLT_VOLLEY);
            context.Repeat();
        }).Schedule(36400ms, [this](TaskContext context)
        {
            DoCastSelf(SPELL_DRAW_SHADOWS, true);

            me->GetMap()->DoForAllPlayers([&](Player* player)
            {
                if (player->IsAlive() && !player->HasAura(SPELL_BANISH))
                {
                    player->TeleportTo(me->GetMapId(), VorpilPosition[0], VorpilPosition[1], VorpilPosition[2], 0, TELE_TO_NOT_LEAVE_COMBAT);
                }
            });

            scheduler.Schedule(1s, [this](TaskContext /*context*/)
            {
                DoCastSelf(DUNGEON_MODE(SPELL_RAIN_OF_FIRE_N, SPELL_RAIN_OF_FIRE_H));
            });

            me->NearTeleportTo(VorpilPosition[0], VorpilPosition[1], VorpilPosition[2], 0.0f);
            context.Repeat(36400ms, 44950ms);
        }).Schedule(10900ms, [this](TaskContext context)
        {
            spawnVoidTraveler();
            context.Repeat(counterVoidSpawns(context.GetRepeatCounter()));
        });

        if (IsHeroic())
        {
            scheduler.Schedule(17s, 28s, [this](TaskContext context)
            {
                DoCastRandomTarget(SPELL_BANISH, 0, 30.0f, true);
                context.Repeat();
            });
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        ScriptedAI::MoveInLineOfSight(who);
        if (!sayIntro && who->GetTypeId() == TYPEID_PLAYER)
        {
            Talk(SAY_INTRO);
            sayIntro = true;
        }
    }
};

struct npc_voidtraveler : public ScriptedAI
{
    npc_voidtraveler(Creature* creature) : ScriptedAI(creature) {}

    ObjectGuid VorpilGUID;
    uint32 moveTimer;
    bool sacrificed;

    void Reset() override
    {
        moveTimer = 1000;
        sacrificed = false;
    }

    void SetGUID(ObjectGuid guid, int32) override
    {
        VorpilGUID = guid;
    }

    void UpdateAI(uint32 diff) override
    {
        moveTimer += diff;
        if (moveTimer >= 1000)
        {
            moveTimer = 0;
            Creature* Vorpil = ObjectAccessor::GetCreature(*me, VorpilGUID);
            if (!Vorpil)
            {
                me->DespawnOrUnsummon();
                return;
            }
            me->GetMotionMaster()->MoveFollow(Vorpil, 0.0f, 0.0f);

            if (sacrificed)
            {
                Vorpil->AddAura(DUNGEON_MODE(SPELL_EMPOWERING_SHADOWS_N, SPELL_EMPOWERING_SHADOWS_H), Vorpil);
                Vorpil->ModifyHealth(int32(Vorpil->CountPctFromMaxHealth(4)));
                DoCastAOE(SPELL_SHADOW_NOVA, true);
                me->KillSelf();
                return;
            }

            if (me->IsWithinDist(Vorpil, 3.0f))
            {
                DoCastSelf(SPELL_SACRIFICE);
                sacrificed = true;
                moveTimer = 500;
            }
        }
    }
};

void AddSC_boss_grandmaster_vorpil()
{
    RegisterShadowLabyrinthCreatureAI(boss_grandmaster_vorpil);
    RegisterShadowLabyrinthCreatureAI(npc_voidtraveler);
}
