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
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "LFGMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "shadowfang_keep.h"

enum ApothecarySpells
{
    SPELL_ALLURING_PERFUME      = 68589,
    SPELL_PERFUME_SPRAY         = 68607,
    SPELL_CHAIN_REACTION        = 68821,
    SPELL_SUMMON_TABLE          = 69218,
    SPELL_PERMANENT_FEIGN_DEATH = 29266,
    SPELL_QUIET_SUICIDE         = 3617,
    SPELL_COLOGNE_SPRAY         = 68948,
    SPELL_VALIDATE_AREA         = 68644,
    SPELL_THROW_COLOGNE         = 68841,
    SPELL_BUNNY_LOCKDOWN        = 69039,
    SPELL_THROW_PERFUME         = 68799,
    SPELL_PERFUME_SPILL         = 68798,
    SPELL_COLOGNE_SPILL         = 68614,
    SPELL_PERFUME_SPILL_DAMAGE  = 68927,
    SPELL_COLOGNE_SPILL_DAMAGE  = 68934
};

enum ApothecarySays
{
    SAY_INTRO_0         = 0,
    SAY_INTRO_1         = 1,
    SAY_INTRO_2         = 2,
    SAY_CALL_BAXTER     = 3,
    SAY_CALL_FRYE       = 4,
    SAY_HUMMEL_DEATH    = 5,
    SAY_SUMMON_ADDS     = 6,
    SAY_BAXTER_DEATH    = 0,
    SAY_FRYE_DEATH      = 0
};

enum ApothecaryMisc
{
    ACTION_START_EVENT      = 1,
    ACTION_START_FIGHT      = 2,
    GOSSIP_OPTION_START     = 0,
    GOSSIP_MENU_HUMMEL      = 10847,
    QUEST_YOUVE_BEEN_SERVED = 14488,
    NPC_APOTHECARY_FRYE     = 36272,
    NPC_APOTHECARY_BAXTER   = 36565,
    NPC_VIAL_BUNNY          = 36530,
    NPC_CROWN_APOTHECARY    = 36885,
    PHASE_ALL               = 0,
    PHASE_INTRO             = 1,
    PHASE_COMBAT            = 2
};

Position const BaxterMovePos = { -221.4115f, 2206.825f, 79.93151f, 0.0f };
Position const FryeMovePos   = { -196.2483f, 2197.224f, 79.9315f, 0.0f };

class boss_apothecary_hummel : public CreatureScript
{
public:
    boss_apothecary_hummel() : CreatureScript("boss_apothecary_hummel") { }

    struct boss_apothecary_hummelAI : public BossAI
    {
        boss_apothecary_hummelAI(Creature* creature) : BossAI(creature, DATA_APOTHECARY_HUMMEL), _deadCount(0), _isDead(false)
        {
            scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
        }

        void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
        {
            if (menuId == GOSSIP_MENU_HUMMEL && gossipListId == GOSSIP_OPTION_START)
            {
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                CloseGossipMenuFor(player);
                DoAction(ACTION_START_EVENT);
            }
        }

        void Reset() override
        {
            _Reset();
            _deadCount = 0;
            _isDead = false;
            _phase = PHASE_ALL;
            me->SetFaction(FACTION_FRIENDLY);
            me->SummonCreatureGroup(1);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_EVENT && _phase == PHASE_ALL)
            {
                _phase = PHASE_INTRO;
                scheduler.Schedule(1ms, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_0);
                })
                .Schedule(4s, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_1);
                })
                .Schedule(8s, [this](TaskContext /*context*/)
                {
                    Talk(SAY_INTRO_2);
                })
                .Schedule(12s, [this](TaskContext context)
                {
                    me->SetImmuneToAll(false);
                    _phase = PHASE_COMBAT;
                    DoZoneInCombat();

                    context.Schedule(6s, [this](TaskContext /*context*/) // Call Baxter
                    {
                        Talk(SAY_CALL_BAXTER);
                        EntryCheckPredicate pred(NPC_APOTHECARY_BAXTER);
                        summons.DoAction(ACTION_START_FIGHT, pred);
                        summons.DoZoneInCombat(NPC_APOTHECARY_BAXTER);
                    })
                    .Schedule(14s, [this](TaskContext /*context*/) // Call Frye
                    {
                        Talk(SAY_CALL_FRYE);
                        EntryCheckPredicate pred(NPC_APOTHECARY_FRYE);
                        summons.DoAction(ACTION_START_FIGHT, pred);
                    })
                    .Schedule(3640ms, [this](TaskContext context) // Perfume spray
                    {
                        DoCastVictim(SPELL_PERFUME_SPRAY);
                        context.Repeat(3640ms);
                    })
                    .Schedule(15s, [this](TaskContext context) // Chain Reaction
                    {
                        DoCastVictim(SPELL_SUMMON_TABLE, true);
                        DoCastAOE(SPELL_CHAIN_REACTION);
                        context.Repeat(25s);
                    })
                    .Schedule(15s, [this](TaskContext /*context*/) // Call Crazed Apothecary (text)
                    {
                        Talk(SAY_SUMMON_ADDS);
                    })
                    .Schedule(15s, [this](TaskContext context) // Call Crazed Apothecary
                    {
                        instance->SetData(DATA_SPAWN_VALENTINE_ADDS, 0);
                        context.Repeat(4s, 6s);
                    });

                    std::list<Creature*> trashs;
                    me->GetCreatureListWithEntryInGrid(trashs, NPC_CROWN_APOTHECARY, 100.f);
                    for (Creature* crea : trashs)
                    {
                        crea->DespawnOrUnsummon();
                    }
                });

                me->SetImmuneToPC(true);
                me->SetFaction(FACTION_MONSTER);
                summons.DoAction(ACTION_START_EVENT);
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                if (_deadCount < 2)
                {
                    damage = me->GetHealth() - 1;
                    if (!_isDead)
                    {
                        _isDead = true;
                        me->RemoveAurasDueToSpell(SPELL_ALLURING_PERFUME);
                        DoCastSelf(SPELL_PERMANENT_FEIGN_DEATH, true);
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        Talk(SAY_HUMMEL_DEATH);
                    }
                }
            }
        }

        void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
        {
            if (summon->GetEntry() == NPC_APOTHECARY_FRYE || summon->GetEntry() == NPC_APOTHECARY_BAXTER)
            {
                _deadCount++;
            }

            if (me->HasAura(SPELL_PERMANENT_FEIGN_DEATH) && _deadCount == 2)
            {
                DoCastSelf(SPELL_QUIET_SUICIDE, true);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (!_isDead)
            {
                Talk(SAY_HUMMEL_DEATH);
            }

            _JustDied();
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            if (!players.IsEmpty())
            {
                if (Group* group = players.begin()->GetSource()->GetGroup())
                {
                    if (group->isLFGGroup())
                    {
                        sLFGMgr->FinishDungeon(group->GetGUID(), 288, me->GetMap());
                    }
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() && _phase != PHASE_INTRO)
            {
                return;
            }

            scheduler.Update(diff, [this]
            {
                DoMeleeAttackIfReady();
            });
        }

    private:
        uint8 _deadCount;
        bool _isDead;
        uint8 _phase;
    };

    bool OnQuestReward(Player* /*player*/, Creature* creature, const Quest* quest, uint32 /*slot*/) override
    {
        if (quest->GetQuestId() == QUEST_YOUVE_BEEN_SERVED)
        {
            if (creature && creature->AI())
            {
                creature->AI()->DoAction(ACTION_START_EVENT);
            }
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_apothecary_hummelAI(creature);
    }
};

struct npc_apothecary_genericAI : public ScriptedAI
{
    npc_apothecary_genericAI(Creature* creature, Position pos) : ScriptedAI(creature), _movePos(pos) { }

    void DoAction(int32 action) override
    {
        if (action == ACTION_START_EVENT)
        {
            me->SetImmuneToPC(true);
            me->SetFaction(FACTION_MONSTER);
            me->GetMotionMaster()->MovePoint(1, _movePos);
        }
        else if (action == ACTION_START_FIGHT)
        {
            me->SetImmuneToAll(false);
            DoZoneInCombat();
        }
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (type == POINT_MOTION_TYPE && pointId == 1)
        {
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USE_STANDING);
        }
    }

protected:
    Position _movePos;
};

struct npc_apothecary_frye : public npc_apothecary_genericAI
{
    npc_apothecary_frye(Creature* creature) : npc_apothecary_genericAI(creature, FryeMovePos) { }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_FRYE_DEATH);
    }
};

struct npc_apothecary_baxter : public npc_apothecary_genericAI
{
    npc_apothecary_baxter(Creature* creature) : npc_apothecary_genericAI(creature, BaxterMovePos)
    {
        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        _scheduler.Schedule(7s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_COLOGNE_SPRAY);
            context.Repeat(4s);
        })
        .Schedule(12s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SUMMON_TABLE);
            DoCastVictim(SPELL_CHAIN_REACTION);
            context.Repeat(25s);
        });
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_BAXTER_DEATH);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        _scheduler.Update(diff, [this]
        {
            DoMeleeAttackIfReady();
        });
    }

private:
    TaskScheduler _scheduler;
};

// 68965 - [DND] Lingering Fumes Targetting (starter)
class spell_apothecary_lingering_fumes : public SpellScript
{
    PrepareSpellScript(spell_apothecary_lingering_fumes);

    void HandleAfterCast()
    {
        Unit* caster = GetCaster();
        if (!caster->IsInCombat() || roll_chance_i(50))
            return;

        std::list<Creature*> triggers;
        caster->GetCreatureListWithEntryInGrid(triggers, NPC_VIAL_BUNNY, 100.0f);
        if (triggers.empty())
            return;

        Creature* trigger = Acore::Containers::SelectRandomContainerElement(triggers);
        caster->GetMotionMaster()->MovePoint(0, trigger->GetPosition());

    }

    void HandleScript(SpellEffIndex /*effindex*/)
    {
        Unit* caster = GetCaster();
        caster->CastSpell(GetHitUnit(), SPELL_VALIDATE_AREA, true);
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_apothecary_lingering_fumes::HandleAfterCast);
        OnEffectHitTarget += SpellEffectFn(spell_apothecary_lingering_fumes::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 68644 - [DND] Valentine Boss Validate Area
class spell_apothecary_validate_area : public SpellScript
{
    PrepareSpellScript(spell_apothecary_validate_area);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BUNNY_LOCKDOWN, SPELL_THROW_COLOGNE, SPELL_THROW_PERFUME });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_BUNNY_LOCKDOWN));
        if (targets.empty())
            return;

        WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
        targets.clear();
        targets.push_back(target);
    }

    void HandleScript(SpellEffIndex /*effindex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_BUNNY_LOCKDOWN, true);
        GetCaster()->CastSpell(GetHitUnit(), RAND(SPELL_THROW_COLOGNE, SPELL_THROW_PERFUME), true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_apothecary_validate_area::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_apothecary_validate_area::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 69038 - Throw Cologne
class spell_apothecary_throw_cologne : public SpellScript
{
    PrepareSpellScript(spell_apothecary_throw_cologne);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_COLOGNE_SPILL });
    }

    void HandleScript(SpellEffIndex /*effindex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_COLOGNE_SPILL, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_apothecary_throw_cologne::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 68966 - Throw Perfume
class spell_apothecary_throw_perfume : public SpellScript
{
    PrepareSpellScript(spell_apothecary_throw_perfume);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PERFUME_SPILL });
    }

    void HandleScript(SpellEffIndex /*effindex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_PERFUME_SPILL, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_apothecary_throw_perfume::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 68798 - Concentrated Alluring Perfume Spill
class spell_apothecary_perfume_spill : public AuraScript
{
    PrepareAuraScript(spell_apothecary_perfume_spill);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PERFUME_SPILL_DAMAGE });
    }

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        GetTarget()->CastSpell(GetTarget(), SPELL_PERFUME_SPILL_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_apothecary_perfume_spill::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 68614 - Concentrated Irresistible Cologne Spill
class spell_apothecary_cologne_spill : public AuraScript
{
    PrepareAuraScript(spell_apothecary_cologne_spill);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_COLOGNE_SPILL_DAMAGE });
    }

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        GetTarget()->CastSpell(GetTarget(), SPELL_COLOGNE_SPILL_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_apothecary_cologne_spill::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

void AddSC_boss_apothecary_hummel()
{
    new boss_apothecary_hummel();
    RegisterShadowfangKeepCreatureAI(npc_apothecary_baxter);
    RegisterShadowfangKeepCreatureAI(npc_apothecary_frye);
    RegisterSpellScript(spell_apothecary_lingering_fumes);
    RegisterSpellScript(spell_apothecary_validate_area);
    RegisterSpellScript(spell_apothecary_throw_cologne);
    RegisterSpellScript(spell_apothecary_throw_perfume);
    RegisterSpellScript(spell_apothecary_perfume_spill);
    RegisterSpellScript(spell_apothecary_cologne_spill);
}
