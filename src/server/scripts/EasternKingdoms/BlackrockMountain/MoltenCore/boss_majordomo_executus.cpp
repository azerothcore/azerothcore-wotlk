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

#include "CreatureScript.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "molten_core.h"

enum Texts
{
    SAY_AGGRO                               = 0,
    SAY_SPAWN                               = 1,
    SAY_SLAY                                = 2,
    SAY_DEFEAT                              = 3,
    SAY_SUMMON_MAJ                          = 4,
    SAY_ARRIVAL2_MAJ                        = 5,
    SAY_LAST_ADD                            = 6,

    SAY_DEFEAT_2                            = 7,
    SAY_DEFEAT_3                            = 8,

    // Ragnaros event
    // Majordomo
    SAY_RAG_SUM_1                           = 9,
    SAY_RAG_SUM_2                           = 10,
    SAY_DEATH                               = 11,

    // Ragnaros
    SAY_ARRIVAL1_RAG                        = 1,
    SAY_ARRIVAL3_RAG                        = 3,
};

enum Spells
{
    SPELL_MAGIC_REFLECTION                  = 20619,
    SPELL_DAMAGE_REFLECTION                 = 21075,
    SPELL_BLAST_WAVE                        = 20229,
    SPELL_AEGIS_OF_RAGNAROS                 = 20620,
    SPELL_TELEPORT_RANDOM                   = 20618,    // Teleport random target
    SPELL_TELEPORT_TARGET                   = 20534,    // Teleport Victim
    SPELL_ENCOURAGEMENT                     = 21086,
    SPELL_CHAMPION                          = 21090,    // Server side
    SPELL_IMMUNE_POLY                       = 21087,    // Server side
    SPELL_HATE_TO_ZERO                      = 20538,    // Threat reset after each teleport. Server side
    SPELL_SEPARATION_ANXIETY                = 21094,    // Aura cast on himself by Majordomo Executus, if adds move out of range, they will cast spell 21095 on themselves
    SPELL_SEPARATION_ANXIETY_MINION         = 21095,

    // Outro & Ragnaros intro
    SPELL_TELEPORT_SELF                     = 19484,
    SPELL_SUMMON_RAGNAROS                   = 19774,
    SPELL_ELEMENTAL_FIRE                    = 19773,
    SPELL_RAGNA_EMERGE                      = 20568,
    SPELL_RAGNAROS_FADE                     = 21107,
    SPELL_RAGNAROS_SUBMERGE_EFFECT          = 21859,    // Applies pacify state and applies all schools immunity
};

enum Events
{
    EVENT_SHIELD_REFLECTION                 = 1,
    EVENT_TELEPORT_RANDOM,
    EVENT_TELEPORT_TARGET,
    EVENT_AEGIS_OF_RAGNAROS,

    EVENT_DEFEAT_OUTRO_1                    = 1,
    EVENT_DEFEAT_OUTRO_2,
    EVENT_DEFEAT_OUTRO_3,

    EVENT_RAGNAROS_SUMMON_1                 = 1,
    EVENT_RAGNAROS_SUMMON_2,
    EVENT_RAGNAROS_SUMMON_3,
    EVENT_RAGNAROS_SUMMON_4,
    EVENT_RAGNAROS_SUMMON_5,
    EVENT_RAGNAROS_SUMMON_6,
    EVENT_RAGNAROS_SUMMON_7,
    EVENT_RAGNAROS_EMERGE,
};

enum Misc
{
    TEXT_ID_SUMMON_1                        = 4995,
    TEXT_ID_SUMMON_2                        = 5011,
    TEXT_ID_SUMMON_3                        = 5012,

    GOSSIP_ITEM_SUMMON_1                    = 4093,
    GOSSIP_ITEM_SUMMON_2                    = 4109,
    GOSSIP_ITEM_SUMMON_3                    = 4108,

    FACTION_MAJORDOMO_FRIENDLY              = 1080,
    SUMMON_GROUP_ADDS                       = 1,

    // Points
    POINT_RAGNAROS_SUMMON                   = 1,

    // Event phases
    PHASE_NONE                              = 1,
    PHASE_COMBAT                            = 2,
    PHASE_DEFEAT_OUTRO                      = 3,
    PHASE_RAGNAROS_SUMMONING                = 4,
};

Position const MajordomoRagnaros = { 848.933f, -812.875f, -229.601f, 4.046f };
Position const MajordomoSummonPos = {759.542f, -1173.43f, -118.974f, 3.3048f };
Position const MajordomoMoveRagPos = { 830.9636f, -814.7055f, -228.9733f, 0.0f };   // Position used at Ragnaros summoning event
Position const RagnarosSummonPos = { 838.3082f, -831.4665f, -232.1853f, 2.199115f };

struct MajordomoAddData
{
    ObjectGuid guid;
    uint32 creatureEntry;
    Position spawnPos;

    MajordomoAddData() { }
    MajordomoAddData(ObjectGuid _guid, uint32 _creatureEntry, Position _spawnPos) : guid(_guid), creatureEntry(_creatureEntry), spawnPos(_spawnPos) { }
};

class boss_majordomo : public CreatureScript
{
public:
    boss_majordomo() : CreatureScript("boss_majordomo") {}

    struct boss_majordomoAI : public BossAI
    {
        boss_majordomoAI(Creature* creature) : BossAI(creature, DATA_MAJORDOMO_EXECUTUS) {}

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            me->DespawnOrUnsummon(10s, 0s);
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_RAGNAROS)
            {
                summon->CastSpell(summon, SPELL_RAGNAROS_FADE);
                summon->CastSpell(summon, SPELL_RAGNAROS_SUBMERGE_EFFECT, true);
                summon->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                summon->SetImmuneToAll(true);
                summon->SetReactState(REACT_PASSIVE);
            }
        }

        void InitializeAI() override
        {
            BossAI::InitializeAI();
            if (instance->GetBossState(DATA_MAJORDOMO_EXECUTUS) != DONE)
            {
                events.SetPhase(PHASE_COMBAT);

                std::list<TempSummon*> p_summons;
                me->SummonCreatureGroup(SUMMON_GROUP_ADDS, &p_summons);
                if (!p_summons.empty())
                {
                    for (TempSummon const* summon : p_summons)
                    {
                        if (summon)
                        {
                            static_minionsGUIDS.insert(summon->GetGUID());
                            majordomoSummonsData[summon->GetGUID().GetCounter()] = MajordomoAddData(summon->GetGUID(), summon->GetEntry(), summon->GetPosition());
                        }
                    }
                }
            }
            else
            {
                events.SetPhase(PHASE_NONE);
                me->SetImmuneToAll(true);
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->SetFaction(FACTION_MAJORDOMO_FRIENDLY);
            }
        }

        void Reset() override
        {
            me->ResetLootMode();
            events.Reset();
            aliveMinionsGUIDS.clear();

            if (instance->GetBossState(DATA_MAJORDOMO_EXECUTUS) != DONE)
            {
                events.SetPhase(PHASE_COMBAT);
                instance->SetBossState(DATA_MAJORDOMO_EXECUTUS, NOT_STARTED);

                for (auto const& summon : majordomoSummonsData)
                {
                    if (ObjectAccessor::GetCreature(*me, summon.second.guid))
                    {
                        continue;
                    }

                    if (Creature* spawn = me->SummonCreature(summon.second.creatureEntry, summon.second.spawnPos))
                    {
                        static_minionsGUIDS.erase(summon.second.guid); // Erase the guid from the previous, no longer existing, spawn.
                        static_minionsGUIDS.insert(spawn->GetGUID());
                        majordomoSummonsData.erase(summon.second.guid.GetCounter());
                        majordomoSummonsData[spawn->GetGUID().GetCounter()] = MajordomoAddData(spawn->GetGUID(), spawn->GetEntry(), spawn->GetPosition());
                    }
                }

                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            }
            else
            {
                static_minionsGUIDS.clear();
                majordomoSummonsData.clear();
                summons.DespawnAll();
            }
        }

        bool CanAIAttack(Unit const* /*target*/) const override
        {
            return instance->GetBossState(DATA_MAJORDOMO_EXECUTUS) != DONE;
        }

        void KilledUnit(Unit* victim) override
        {
            if (roll_chance_i(25) && victim->IsPlayer())
            {
                Talk(SAY_SLAY);
            }
        }

        void JustEngagedWith(Unit* /*attacker*/) override
        {
            if (!events.IsInPhase(PHASE_COMBAT))
            {
                return;
            }

            _JustEngagedWith();
            DoCastAOE(SPELL_SEPARATION_ANXIETY);
            Talk(SAY_AGGRO);
            DoCastSelf(SPELL_AEGIS_OF_RAGNAROS, true);

            events.ScheduleEvent(EVENT_SHIELD_REFLECTION, 30s, PHASE_COMBAT, PHASE_COMBAT);
            events.ScheduleEvent(EVENT_TELEPORT_RANDOM, 25s, PHASE_COMBAT, PHASE_COMBAT);
            events.ScheduleEvent(EVENT_TELEPORT_TARGET, 15s, PHASE_COMBAT, PHASE_COMBAT);

            aliveMinionsGUIDS.clear();
            aliveMinionsGUIDS = static_minionsGUIDS;
        }

        void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
        {
            aliveMinionsGUIDS.erase(summon->GetGUID());
            if (summon->GetEntry() == NPC_FLAMEWAKER_HEALER || summon->GetEntry() == NPC_FLAMEWAKER_ELITE)
            {
                uint32 const remainingAdds = std::count_if(aliveMinionsGUIDS.begin(), aliveMinionsGUIDS.end(), [](ObjectGuid const& summonGuid)
                {
                    return summonGuid.GetEntry() == NPC_FLAMEWAKER_HEALER || summonGuid.GetEntry() == NPC_FLAMEWAKER_ELITE;
                });

                // Last remaining add
                if (remainingAdds == 1)
                {
                    Talk(SAY_LAST_ADD);
                    DoCastAOE(SPELL_CHAMPION);
                }
                // 50% of adds
                else if (remainingAdds == 4)
                {
                    DoCastAOE(SPELL_IMMUNE_POLY);
                }
                else if (!remainingAdds)
                {
                    static_minionsGUIDS.clear();

                    instance->SetBossState(DATA_MAJORDOMO_EXECUTUS, DONE);
                    events.CancelEventGroup(PHASE_COMBAT);
                    me->GetMap()->UpdateEncounterState(ENCOUNTER_CREDIT_KILL_CREATURE, me->GetEntry(), me);
                    me->SetImmuneToAll(true);
                    me->SetFaction(FACTION_MAJORDOMO_FRIENDLY);
                    EnterEvadeMode();
                    Talk(SAY_DEFEAT);
                    return;
                }
                DoCastAOE(SPELL_ENCOURAGEMENT);
            }
        }

        void JustReachedHome() override
        {
            _JustReachedHome();
            if (instance->GetBossState(DATA_MAJORDOMO_EXECUTUS) == DONE)
            {
                events.Reset();
                events.SetPhase(PHASE_DEFEAT_OUTRO);
                events.ScheduleEvent(EVENT_DEFEAT_OUTRO_1, 7500ms, PHASE_DEFEAT_OUTRO, PHASE_DEFEAT_OUTRO);
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*dmgType*/, SpellSchoolMask /*school*/) override
        {
            if (events.IsInPhase(PHASE_COMBAT) && me->GetHealth() <= damage)
            {
                damage = 0;
            }
        }

        void UpdateAI(uint32 diff) override
        {

            switch (events.GetPhaseMask())
            {
                case  (1 << (PHASE_COMBAT - 1)):
                {
                    if (!UpdateVictim())
                    {
                        return;
                    }

                    events.Update(diff);

                    if (me->HasUnitState(UNIT_STATE_CASTING))
                    {
                        return;
                    }

                    while (uint32 const eventId = events.ExecuteEvent())
                    {
                        switch (eventId)
                        {
                            case EVENT_SHIELD_REFLECTION:
                            {
                                if (rand_chance() <= 50.f)
                                {
                                    DoCastSelf(SPELL_MAGIC_REFLECTION);
                                }
                                else
                                {
                                    DoCastSelf(SPELL_DAMAGE_REFLECTION);
                                }
                                events.RepeatEvent(30000);
                                break;
                            }
                            case EVENT_TELEPORT_RANDOM:
                            {
                                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 0.0f, true))
                                {
                                    DoCastSelf(SPELL_HATE_TO_ZERO, true);
                                    DoCast(target, SPELL_TELEPORT_RANDOM);
                                }

                                events.RepeatEvent(30000);
                                break;
                            }
                            case EVENT_TELEPORT_TARGET:
                            {
                                DoCastSelf(SPELL_HATE_TO_ZERO, true);
                                DoCastAOE(SPELL_TELEPORT_TARGET);
                                events.RepeatEvent(30000);
                                break;
                            }
                        }

                        if (me->HasUnitState(UNIT_STATE_CASTING))
                        {
                            return;
                        }
                    }

                    DoMeleeAttackIfReady();
                    break;
                }
                case (1 << (PHASE_DEFEAT_OUTRO - 1)):
                {
                    events.Update(diff);
                    while (uint32 const eventId = events.ExecuteEvent())
                    {
                        switch (eventId)
                        {
                            case EVENT_DEFEAT_OUTRO_1:
                            {
                                Talk(SAY_DEFEAT_2);
                                events.ScheduleEvent(EVENT_DEFEAT_OUTRO_2, 8s, PHASE_DEFEAT_OUTRO, PHASE_DEFEAT_OUTRO);
                                break;
                            }
                            case EVENT_DEFEAT_OUTRO_2:
                            {
                                Talk(SAY_DEFEAT_3);
                                events.ScheduleEvent(EVENT_DEFEAT_OUTRO_3, 21500ms, PHASE_DEFEAT_OUTRO, PHASE_DEFEAT_OUTRO);
                                break;
                            }
                            case EVENT_DEFEAT_OUTRO_3:
                            {
                                DoCastSelf(SPELL_TELEPORT_SELF);
                                break;
                            }
                        }
                    }
                    break;
                }
                case (1 << (PHASE_RAGNAROS_SUMMONING - 1)):
                {
                    events.Update(diff);
                    while (uint32 const eventId = events.ExecuteEvent())
                    {
                        switch (eventId)
                        {
                            case EVENT_RAGNAROS_SUMMON_1:
                            {
                                if (GameObject* lavaSplash = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(DATA_LAVA_SPLASH)))
                                {
                                    lavaSplash->SetRespawnTime(900);
                                    lavaSplash->Refresh();
                                }
                                if (GameObject* lavaSteam = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(DATA_LAVA_STEAM)))
                                {
                                    lavaSteam->SetRespawnTime(900);
                                    lavaSteam->Refresh();
                                }
                                Talk(SAY_RAG_SUM_2);
                                // Next event will get triggered in MovementInform
                                me->SetWalk(true);
                                me->GetMotionMaster()->MovePoint(POINT_RAGNAROS_SUMMON, MajordomoMoveRagPos, true, false);
                                break;
                            }
                            case EVENT_RAGNAROS_SUMMON_2:
                            {
                                if (GameObject* lavaSteam = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(DATA_LAVA_STEAM)))
                                {
                                    me->SetFacingToObject(lavaSteam);
                                }

                                Talk(SAY_SUMMON_MAJ);
                                events.ScheduleEvent(EVENT_RAGNAROS_SUMMON_3, 16700ms, PHASE_RAGNAROS_SUMMONING, PHASE_RAGNAROS_SUMMONING);
                                events.ScheduleEvent(EVENT_RAGNAROS_EMERGE, 15s, PHASE_RAGNAROS_SUMMONING, PHASE_RAGNAROS_SUMMONING);
                                break;
                            }
                            case EVENT_RAGNAROS_SUMMON_3:
                            {
                                if (Creature* ragnaros = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_RAGNAROS)))
                                {
                                    ragnaros->AI()->Talk(SAY_ARRIVAL1_RAG);
                                }
                                events.ScheduleEvent(EVENT_RAGNAROS_SUMMON_4, 11700ms, PHASE_RAGNAROS_SUMMONING, PHASE_RAGNAROS_SUMMONING);
                                break;
                            }
                            case EVENT_RAGNAROS_SUMMON_4:
                            {
                                Talk(SAY_ARRIVAL2_MAJ);
                                events.ScheduleEvent(EVENT_RAGNAROS_SUMMON_5, 8700ms, PHASE_RAGNAROS_SUMMONING, PHASE_RAGNAROS_SUMMONING);
                                break;
                            }
                            case EVENT_RAGNAROS_SUMMON_5:
                            {
                                if (Creature* ragnaros = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_RAGNAROS)))
                                {
                                    ragnaros->AI()->Talk(SAY_ARRIVAL3_RAG);
                                }

                                events.ScheduleEvent(EVENT_RAGNAROS_SUMMON_6, 16500ms, PHASE_RAGNAROS_SUMMONING, PHASE_RAGNAROS_SUMMONING);
                                break;
                            }
                            case EVENT_RAGNAROS_SUMMON_6:
                            {
                                if (Creature* ragnaros = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_RAGNAROS)))
                                {
                                    ragnaros->CastSpell(me, SPELL_ELEMENTAL_FIRE, true);
                                    ragnaros->AI()->DoAction(ACTION_FINISH_RAGNAROS_INTRO);
                                }
                                break;
                            }
                            // Additional events
                            case EVENT_RAGNAROS_EMERGE:
                            {
                                if (Creature* ragnaros = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_RAGNAROS)))
                                {
                                    ragnaros->RemoveAurasDueToSpell(SPELL_RAGNAROS_FADE);
                                    ragnaros->CastSpell(ragnaros, SPELL_RAGNA_EMERGE);
                                }
                            }break;
                        }
                    }
                    break;
                }
            }
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            if (type == POINT_MOTION_TYPE && pointId == POINT_RAGNAROS_SUMMON)
            {
                DoCastAOE(SPELL_SUMMON_RAGNAROS);
                events.ScheduleEvent(EVENT_RAGNAROS_SUMMON_2, 11500ms, PHASE_RAGNAROS_SUMMONING, PHASE_RAGNAROS_SUMMONING);
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
        {
            if (events.IsInPhase(PHASE_DEFEAT_OUTRO) && spellInfo->Id == SPELL_TELEPORT_SELF)
            {
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->SetHomePosition(MajordomoRagnaros);
                me->NearTeleportTo(MajordomoRagnaros.GetPositionX(), MajordomoRagnaros.GetPositionY(), MajordomoRagnaros.GetPositionZ(), MajordomoRagnaros.GetOrientation());
                events.SetPhase(PHASE_NONE);
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_RAGNAROS_INTRO && !events.IsInPhase(PHASE_RAGNAROS_SUMMONING))
            {
                events.SetPhase(PHASE_RAGNAROS_SUMMONING);
                events.ScheduleEvent(EVENT_RAGNAROS_SUMMON_1, 5s, PHASE_RAGNAROS_SUMMONING, PHASE_RAGNAROS_SUMMONING);
            }
        }
    private:
        GuidSet static_minionsGUIDS;    // contained data should be changed on encounter completion
        GuidSet aliveMinionsGUIDS;      // used for calculations
        std::unordered_map<uint32, MajordomoAddData> majordomoSummonsData;
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        AddGossipItemFor(player, GOSSIP_ITEM_SUMMON_1, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        SendGossipMenuFor(player, TEXT_ID_SUMMON_1, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
            {
                AddGossipItemFor(player, GOSSIP_ITEM_SUMMON_2, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                SendGossipMenuFor(player, TEXT_ID_SUMMON_2, creature->GetGUID());
                break;
            }
            case GOSSIP_ACTION_INFO_DEF+1:
            {
                AddGossipItemFor(player, GOSSIP_ITEM_SUMMON_2, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, TEXT_ID_SUMMON_2, creature->GetGUID());
                break;
            }
            case GOSSIP_ACTION_INFO_DEF+2:
            {
                AddGossipItemFor(player, GOSSIP_ITEM_SUMMON_3, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                SendGossipMenuFor(player, TEXT_ID_SUMMON_3, creature->GetGUID());
                break;
            }
            case GOSSIP_ACTION_INFO_DEF+3:
            {
                CloseGossipMenuFor(player);
                creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                creature->AI()->Talk(SAY_RAG_SUM_1, player);
                creature->AI()->DoAction(ACTION_START_RAGNAROS_INTRO);
                break;
            }
            default:
                CloseGossipMenuFor(player);
                break;
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_majordomoAI>(creature);
    }
};

// 20538 Hate to Zero (SERVERSIDE)
class spell_hate_to_zero : public SpellScript
{
    PrepareSpellScript(spell_hate_to_zero);

    bool Load() override
    {
        return GetCaster()->GetTypeId() == TYPEID_UNIT;
    }

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Creature* creatureCaster = caster->ToCreature())
            {
                creatureCaster->GetThreatMgr().ResetAllThreat();
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hate_to_zero::HandleHit, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 21094 Separation Anxiety (server side)
class spell_majordomo_separation_anxiety_aura : public AuraScript
{
    PrepareAuraScript(spell_majordomo_separation_anxiety_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_SEPARATION_ANXIETY_MINION });
    }

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        Unit const* caster = GetCaster();
        Unit* target = GetTarget();
        if (caster && target && target->GetDistance(caster) > 40.0f && !target->HasAura(SPELL_SEPARATION_ANXIETY_MINION))
        {
            target->CastSpell(target, SPELL_SEPARATION_ANXIETY_MINION, true, nullptr, aurEff);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_majordomo_separation_anxiety_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 19774 Summon Ragnaros
class spell_summon_ragnaros : public SpellScript
{
    PrepareSpellScript(spell_summon_ragnaros);

    void HandleHit()
    {
        if (Unit* caster = GetCaster())
        {
            caster->SummonCreature(NPC_RAGNAROS, RagnarosSummonPos, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 2 * HOUR * IN_MILLISECONDS);
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_summon_ragnaros::HandleHit);
    }
};

void AddSC_boss_majordomo()
{
    new boss_majordomo();

    // Spells
    RegisterSpellScript(spell_hate_to_zero);
    RegisterSpellScript(spell_majordomo_separation_anxiety_aura);
    RegisterSpellScript(spell_summon_ragnaros);
}

