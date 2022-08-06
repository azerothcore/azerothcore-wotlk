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
#include "ScriptObject.h"
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

    EVENT_SPELL_SHADOWBOLT      = 1,
    EVENT_SPELL_DRAWSHADOWS     = 2,
    EVENT_SUMMON_TRAVELER       = 3,
    EVENT_SPELL_BANISH          = 4
};

float VorpilPosition[3] = {-252.8820f, -264.3030f, 17.1f};

float VoidPortalCoords[5][3] =
{
    {-283.5894f, -239.5718f, 12.7f},
    {-306.5853f, -258.4539f, 12.7f},
    {-295.8789f, -269.0899f, 12.7f},
    {-209.3401f, -262.7564f, 17.1f},
    {-261.4533f, -297.3298f, 17.1f}
};

class boss_grandmaster_vorpil : public CreatureScript
{
public:
    boss_grandmaster_vorpil() : CreatureScript("boss_grandmaster_vorpil") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetShadowLabyrinthAI<boss_grandmaster_vorpilAI>(creature);
    }

    struct boss_grandmaster_vorpilAI : public ScriptedAI
    {
        boss_grandmaster_vorpilAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
            sayIntro = false;
        }

        InstanceScript* instance;
        EventMap events;
        SummonList summons;

        bool sayIntro, sayHelp;

        void Reset() override
        {
            sayHelp = false;
            events.Reset();
            summons.DespawnAll();

            if (instance)
                instance->SetData(DATA_GRANDMASTERVORPILEVENT, NOT_STARTED);
        }

        void summonPortals()
        {
            for (uint8 i = 0; i < 5; ++i)
                me->SummonCreature(NPC_VOID_PORTAL, VoidPortalCoords[i][0], VoidPortalCoords[i][1], VoidPortalCoords[i][2], 0, TEMPSUMMON_CORPSE_DESPAWN, 3000000);
        }

        void spawnVoidTraveler()
        {
            uint8 pos = urand(0, 4);
            me->SummonCreature(NPC_VOID_TRAVELER, VoidPortalCoords[pos][0], VoidPortalCoords[pos][1], VoidPortalCoords[pos][2], 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
            if (!sayHelp)
            {
                Talk(SAY_HELP);
                sayHelp = true;
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            if (summon->GetEntry() == NPC_VOID_TRAVELER)
                summon->AI()->SetGUID(me->GetGUID());
            else if (summon->GetEntry() == NPC_VOID_PORTAL)
                summon->CastSpell(summon, SPELL_VOID_PORTAL_VISUAL, false);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            summons.DespawnAll();

            if (instance)
                instance->SetData(DATA_GRANDMASTERVORPILEVENT, DONE);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            summonPortals();

            events.ScheduleEvent(EVENT_SPELL_SHADOWBOLT, urand(7000, 14000));
            events.ScheduleEvent(EVENT_SPELL_DRAWSHADOWS, 45000);
            events.ScheduleEvent(EVENT_SUMMON_TRAVELER, 5000);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_BANISH, 17000);

            if (instance)
                instance->SetData(DATA_GRANDMASTERVORPILEVENT, IN_PROGRESS);
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

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_SHADOWBOLT:
                    me->CastSpell(me, SPELL_SHADOWBOLT_VOLLEY, false);
                    events.RepeatEvent(urand(15000, 30000));
                    break;
                case EVENT_SPELL_BANISH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30, false))
                        me->CastSpell(target, SPELL_BANISH, false);
                    events.RepeatEvent(16000);
                    break;
                case EVENT_SUMMON_TRAVELER:
                    spawnVoidTraveler();
                    events.RepeatEvent(HealthBelowPct(20) ? 5000 : 10000);
                    break;
                case EVENT_SPELL_DRAWSHADOWS:
                    {
                        Map* map = me->GetMap();
                        Map::PlayerList const& PlayerList = map->GetPlayers();
                        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                            if (Player* player = i->GetSource())
                                if (player->IsAlive() && !player->HasAura(SPELL_BANISH))
                                    player->TeleportTo(me->GetMapId(), VorpilPosition[0], VorpilPosition[1], VorpilPosition[2], 0, TELE_TO_NOT_LEAVE_COMBAT);

                        me->NearTeleportTo(VorpilPosition[0], VorpilPosition[1], VorpilPosition[2], 0.0f);
                        me->CastSpell(me, SPELL_DRAW_SHADOWS, true);
                        me->CastSpell(me, SPELL_RAIN_OF_FIRE_N);

                        events.RepeatEvent(24000);
                        events.DelayEvents(6000);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_voidtraveler : public CreatureScript
{
public:
    npc_voidtraveler() : CreatureScript("npc_voidtraveler") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetShadowLabyrinthAI<npc_voidtravelerAI>(creature);
    }

    struct npc_voidtravelerAI : public ScriptedAI
    {
        npc_voidtravelerAI(Creature* creature) : ScriptedAI(creature)
        {
            moveTimer = 1000;
            sacrificed = false;
        }

        ObjectGuid VorpilGUID;
        uint32 moveTimer;
        bool sacrificed;

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
                    me->AddAura(DUNGEON_MODE(SPELL_EMPOWERING_SHADOWS_N, SPELL_EMPOWERING_SHADOWS_H), Vorpil);
                    Vorpil->ModifyHealth(int32(Vorpil->CountPctFromMaxHealth(4)));
                    me->CastSpell(me, SPELL_SHADOW_NOVA, true);
                    Unit::Kill(me, me);
                    return;
                }

                if (me->IsWithinDist(Vorpil, 3.0f))
                {
                    me->CastSpell(me, SPELL_SACRIFICE, false);
                    sacrificed = true;
                    moveTimer = 500;
                }
            }
        }
    };
};

void AddSC_boss_grandmaster_vorpil()
{
    new boss_grandmaster_vorpil();
    new npc_voidtraveler();
}
