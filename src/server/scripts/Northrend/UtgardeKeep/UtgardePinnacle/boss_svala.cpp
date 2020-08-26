/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "utgarde_pinnacle.h"
#include "SpellScript.h"
#include "Player.h"
#include "PassiveAI.h"

enum Misc
{
    // SAY
    TALK_INTRO_A1                           = 0,
    TALK_INTRO_A2                           = 1,
    TALK_INTRO_S1                           = 0,
    TALK_INTRO_S2                           = 0,
    TALK_INTRO_S3                           = 1,
    SAY_AGGRO                               = 2,
    SAY_SLAY                                = 3,
    SAY_DEATH                               = 4,
    SAY_SACRIFICE_PLAYER                    = 5,

    // SPELLS
    // INTRO
    SPELL_ARTHAS_TRANSFORMING_SVALA         = 54142,
    SPELL_SVALA_TRANSFORMING1               = 54205,
    SPELL_SVALA_TRANSFORMING2               = 54140,

    // SORROWGRAVE
    SPELL_CALL_FLAMES                       = 48258,
    SPELL_BALL_OF_FLAME                     = 48246,
    SPELL_RITUAL_OF_THE_SWORD               = 48276,
    SPELL_RITUAL_STRIKE                     = 48331,
    SPELL_SINSTER_STRIKE_N                  = 15667,
    SPELL_SINSTER_STRIKE_H                  = 59409,
    EQUIP_SWORD                             = 40343,

    // CHANNELERS
    SPELL_PARALYZE                          = 48278,
    SPELL_SHADOWS_IN_THE_DARK               = 59407,
    SPELL_TELEPORT_VISUAL                   = 64446,

    // NPCS
    NPC_RITUAL_CHANNELER                    = 27281,
    NPC_ARTHAS                              = 29280,
    NPC_FLAME_BRAZIER                       = 27273,

    // ACTIONS
    ACTION_START_SORROWGRAVE                = 1,
};

enum Events
{
    // BASE EVENT START
    EVENT_SVALA_START                   = 1,
    EVENT_SVALA_TALK1                   = 2,
    EVENT_SVALA_TALK2                   = 3,
    EVENT_SVALA_TALK3                   = 4,
    EVENT_SVALA_TALK4                   = 5,
    EVENT_SVALA_TALK5                   = 6,
    EVENT_SVALA_TALK6                   = 7,
    EVENT_SVALA_TALK7                   = 8,
    EVENT_SVALA_TALK8                   = 9,
    EVENT_SVALA_TALK9                   = 20,

    // FIGHT
    EVENT_SORROWGRAVE_SS                = 10,
    EVENT_SORROWGRAVE_FLAMES            = 11,
    EVENT_SORROWGRAVE_FLAMES2           = 12,
    EVENT_SORROWGRAVE_RITUAL            = 13,
    EVENT_SORROWGRAVE_RITUAL_SPELLS     = 14,
    EVENT_SORROWGRAVE_FINISH_RITUAL     = 15,
};

const Position RitualChannelerLoc[3]=
{
    {296.42f, -355.01f, 90.94f, 0.0f},
    {302.36f, -352.01f, 90.54f, 0.0f},
    {291.39f, -350.89f, 90.54f, 0.0f}
};

/*######
## Boss Svala
######*/

class boss_svala : public CreatureScript
{
public:
    boss_svala() : CreatureScript("boss_svala") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_svalaAI (creature);
    }

    struct boss_svalaAI : public ScriptedAI
    {
        boss_svalaAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
            Started = false;
            ArthasGUID = 0;
        }

        uint64 ArthasGUID;
        bool Started;
        InstanceScript* instance;
        EventMap events;
        EventMap events2;
        SummonList summons;

        void Reset()
        {
            if (instance)
            {
                instance->SetData(DATA_SVALA_SORROWGRAVE, NOT_STARTED);
                instance->SetData(DATA_SVALA_ACHIEVEMENT, false);
            }

            summons.DespawnAll();
            events.Reset();
            events2.Reset();
            if (!Started)
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
            else
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                me->SetHover(true);
            }
        }

        void EnterEvadeMode()
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            ScriptedAI::EnterEvadeMode();
        }

        void SetData(uint32 data, uint32 param)
        {
            if (data != 1 || param != 1 || Started || (instance && instance->GetData(DATA_SVALA_SORROWGRAVE) == DONE))
                return;

            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
            Started = true;
            me->setActive(true);
            events2.ScheduleEvent(EVENT_SVALA_START, 5000);
            if (Creature* pArthas = me->SummonCreature(NPC_ARTHAS, 295.81f, -366.16f, 92.57f, 1.58f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 59000))
                ArthasGUID = pArthas->GetGUID();

            if (instance)
            {
                instance->SetData(DATA_SVALA_SORROWGRAVE, IN_PROGRESS);
                if (GameObject* mirror = ObjectAccessor::GetGameObject(*me, instance->GetData64(GO_SVALA_MIRROR)))
                    mirror->SetGoState(GO_STATE_READY);
            }
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
            if (summon->GetEntry() == NPC_RITUAL_CHANNELER)
                summon->CastSpell(summon, SPELL_TELEPORT_VISUAL, true);
        }

        void EnterCombat(Unit*)
        {
            me->SetInCombatWithZone();
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_SORROWGRAVE_SS, 3000);
            events.ScheduleEvent(EVENT_SORROWGRAVE_FLAMES, 11000);
            events.ScheduleEvent(EVENT_SORROWGRAVE_RITUAL, 25000);

            if (instance)
                instance->SetData(DATA_SVALA_SORROWGRAVE, IN_PROGRESS);
        }

        void JustDied(Unit*)
        {
            summons.DespawnAll();
            Talk(SAY_DEATH);
            if(instance)
                instance->SetData(DATA_SVALA_SORROWGRAVE, DONE);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetEntry() == NPC_SCOURGE_HULK && instance)
            {
                instance->SetData(DATA_SVALA_ACHIEVEMENT, true);
                instance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, 26555, 1, nullptr);
            }

            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void UpdateAI(uint32 diff)
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_SVALA_START:
                    Talk(TALK_INTRO_S1);
                    events2.ScheduleEvent(EVENT_SVALA_TALK1, 8000);
                    break;
                case EVENT_SVALA_TALK1:
                    if (Creature* Arthas = ObjectAccessor::GetCreature(*me, ArthasGUID))
                        Arthas->AI()->Talk(TALK_INTRO_A1);
                    events2.ScheduleEvent(EVENT_SVALA_TALK2, 9000);
                    break;
                case EVENT_SVALA_TALK2:
                    if (Creature* Arthas = ObjectAccessor::GetCreature(*me, ArthasGUID))
                        Arthas->CastSpell(me, SPELL_ARTHAS_TRANSFORMING_SVALA, false);
                    me->CastSpell(me, SPELL_SVALA_TRANSFORMING2, true);
                    events2.ScheduleEvent(EVENT_SVALA_TALK3, 3000);
                    break;
                case EVENT_SVALA_TALK3:
                    me->SetFloatValue(UNIT_FIELD_HOVERHEIGHT, 6.0f);
                    me->SetHover(true);
                    me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                    events2.ScheduleEvent(30, 1000);
                    events2.ScheduleEvent(EVENT_SVALA_TALK4, 9000);
                    break;
                case 30:
                {
                    WorldPacket data(SMSG_SPLINE_MOVE_SET_HOVER, 9);
                    data.append(me->GetPackGUID());
                    me->SendMessageToSet(&data, false);
                    break;
                }
                case EVENT_SVALA_TALK4:
                {
                    me->CastSpell(me, SPELL_SVALA_TRANSFORMING1, true);
                    me->UpdateEntry(NPC_SVALA_SORROWGRAVE);
                    me->SetCorpseDelay(sWorld->getIntConfig(CONFIG_CORPSE_DECAY_ELITE));
                    me->SetFloatValue(UNIT_FIELD_HOVERHEIGHT, 6.0f);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                    if (Creature* Arthas = ObjectAccessor::GetCreature(*me, ArthasGUID))
                        Arthas->InterruptNonMeleeSpells(false);
                    me->RemoveAllAuras();
                    me->SetWalk(false);
                    events2.ScheduleEvent(EVENT_SVALA_TALK5, 2000);

                    std::list<Creature*> creatureList;
                    me->GetCreaturesWithEntryInRange(creatureList, 100.0f, NPC_DRAGONFLAYER_SPECTATOR);
                    for (std::list<Creature*>::const_iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
                        (*itr)->AI()->SetData(1, 2);

                    break;
                }
                case EVENT_SVALA_TALK5:
                    Talk(TALK_INTRO_S2);
                    events2.ScheduleEvent(EVENT_SVALA_TALK6, 12000);
                    break;
                case EVENT_SVALA_TALK6:
                    if (Creature *Arthas = ObjectAccessor::GetCreature(*me, ArthasGUID))
                        Arthas->AI()->Talk(TALK_INTRO_A2);
                    events2.ScheduleEvent(EVENT_SVALA_TALK7, 9000);
                    break;
                case EVENT_SVALA_TALK7:
                    me->SetFacingTo(M_PI/2.0f);
                    Talk(TALK_INTRO_S3);
                    if (GameObject* mirror = ObjectAccessor::GetGameObject(*me, instance->GetData64(GO_SVALA_MIRROR)))
                        mirror->SetGoState(GO_STATE_ACTIVE);
                    events2.ScheduleEvent(EVENT_SVALA_TALK8, 13000);
                    break;
                case EVENT_SVALA_TALK8:
                    me->GetMotionMaster()->MoveFall(0, true);
                    events2.ScheduleEvent(EVENT_SVALA_TALK9, 2000);
                    break;
                case EVENT_SVALA_TALK9:
                    me->SetFloatValue(UNIT_FIELD_HOVERHEIGHT, 3.0f);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                    me->LoadEquipment(1, true);
                    me->setActive(false);
                    if (Player* target = SelectTargetFromPlayerList(100.0f))
                        AttackStart(target);
                    return;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SORROWGRAVE_SS:
                    me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_SINSTER_STRIKE_H : SPELL_SINSTER_STRIKE_N, false);
                    events.ScheduleEvent(EVENT_SORROWGRAVE_SS, urand(3000, 5000));
                    break;
                case EVENT_SORROWGRAVE_FLAMES:
                    summons.DespawnAll();
                    me->CastSpell(me, SPELL_CALL_FLAMES, false);
                    events.ScheduleEvent(EVENT_SORROWGRAVE_FLAMES2, 500);
                    events.ScheduleEvent(EVENT_SORROWGRAVE_FLAMES2, 1000);
                    events.ScheduleEvent(EVENT_SORROWGRAVE_FLAMES, urand(8000, 12000));
                    break;
                case EVENT_SORROWGRAVE_FLAMES2:
                {
                    std::list<Creature*> braziers;
                    me->GetCreaturesWithEntryInRange(braziers, 100.0f, NPC_FLAME_BRAZIER);
                    if (!braziers.empty())
                    {
                        for (std::list<Creature*>::const_iterator itr = braziers.begin(); itr != braziers.end(); ++itr)
                            (*itr)->CastCustomSpell(SPELL_BALL_OF_FLAME, SPELLVALUE_MAX_TARGETS, 1, (*itr), true);
                    }
                    break;
                }
                case EVENT_SORROWGRAVE_RITUAL:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    {
                        Talk(SAY_SACRIFICE_PLAYER);

                        for (uint8 i = 0; i < 3; ++i)
                            if (Creature* cr = me->SummonCreature(NPC_RITUAL_CHANNELER, RitualChannelerLoc[i], TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 360000))
                                cr->AI()->AttackStart(target);

                        me->GetMotionMaster()->MoveIdle();
                        DoTeleportPlayer(target, 296.632f, -346.075f, 90.63f, 4.6f);
                        me->NearTeleportTo(296.632f, -346.075f, 110.0f, 4.6f, false);
                        me->SetControlled(true, UNIT_STATE_ROOT);
                        me->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
                        me->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE_PERCENT);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    }

                    events.DelayEvents(25001); // +1 just to be sure
                    events.ScheduleEvent(EVENT_SORROWGRAVE_RITUAL_SPELLS, 0);
                    events.ScheduleEvent(EVENT_SORROWGRAVE_FINISH_RITUAL, 25000);
                    return;
                case EVENT_SORROWGRAVE_RITUAL_SPELLS:
                    //me->CastSpell(me, SPELL_RITUAL_OF_THE_SWORD, false);
                    me->CastSpell(me, SPELL_RITUAL_STRIKE, true);
                    return;
                case EVENT_SORROWGRAVE_FINISH_RITUAL:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    AttackStart(me->GetVictim());
                    me->GetMotionMaster()->MoveFall(0, true);
                    summons.DespawnAll();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## Mob Ritual Channeler
######*/

class npc_ritual_channeler : public CreatureScript
{
public:
    npc_ritual_channeler() : CreatureScript("npc_ritual_channeler") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ritual_channelerAI (pCreature);
    }

    struct npc_ritual_channelerAI : public NullCreatureAI
    {
        npc_ritual_channelerAI(Creature* pCreature) : NullCreatureAI(pCreature) {}

        void AttackStart(Unit* pWho)
        {
            if (me->GetMap()->GetDifficulty() == DUNGEON_DIFFICULTY_HEROIC)
                me->AddAura(SPELL_SHADOWS_IN_THE_DARK, me);

            if (pWho)
            {
                me->AddThreat(pWho, 10000000.0f);
                me->CastSpell(pWho, SPELL_PARALYZE, false);
            }
        }
    };
};

class spell_svala_ritual_strike : public SpellScriptLoader
{
    public:
        spell_svala_ritual_strike() : SpellScriptLoader("spell_svala_ritual_strike") { }

        class spell_svala_ritual_strike_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_svala_ritual_strike_SpellScript);

            void HandleDummyEffect(SpellEffIndex /*effIndex*/)
            {
                if (Unit* unitTarget = GetHitUnit())
                {
                    if (unitTarget->GetTypeId() != TYPEID_UNIT)
                        return;

                    Unit::DealDamage(GetCaster(), unitTarget, 7000, NULL, DIRECT_DAMAGE);
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_svala_ritual_strike_SpellScript::HandleDummyEffect, EFFECT_2, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript *GetSpellScript() const
        {
            return new spell_svala_ritual_strike_SpellScript();
        }

        class spell_svala_ritual_strike_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_svala_ritual_strike_AuraScript);

            void CalculateAmount(AuraEffect const * /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // Set amount based on difficulty
                amount = (GetCaster()->GetMap()->IsHeroic() ? 2000 : 1000);
            }

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_svala_ritual_strike_AuraScript::CalculateAmount, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
            }
        };

        AuraScript *GetAuraScript() const
        {
            return new spell_svala_ritual_strike_AuraScript();
        }
};

void AddSC_boss_svala()
{
    new boss_svala();
    new npc_ritual_channeler();
    new spell_svala_ritual_strike();
}
