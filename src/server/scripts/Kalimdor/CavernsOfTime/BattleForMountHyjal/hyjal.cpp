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

#include "hyjal.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum Spells
{
    // Jaina
    SPELL_MASS_TELEPORT               = 16807,
    SPELL_SIMPLE_TELEPORT             = 12980,
    SPELL_SALVATION                   = 31745,
    SPELL_BRILLIANCE_AURA             = 31260,
    SPELL_BLIZZARD                    = 31266,
    SPELL_PYROBLAST                   = 31263,
    SPELL_SUMMON_ELEMENTALS           = 31264,

    // Thrall
    SPELL_CHAIN_LIGHTNING             = 31330,
    SPELL_FERAL_SPIRIT                = 31331,

    // Tyrande
    SPELL_STARFALL                    = 20687,
    SPELL_TRUESHOT_AURA               = 31519,
    SPELL_SUMMON_TEARS_OF_THE_GODDESS = 39118,

    // Ghoul
    SPELL_FRENZY                      = 31540,
    SPELL_CANNIBALIZE                 = 31537,

    // Crypt Fiend
    SPELL_CRYPT_SCARABS               = 31592,

    // Abomination
    SPELL_KNOCKDOWN                   = 31610,

    // Necromancer (Ranged)
    SPELL_RAISE_DEAD_1                = 31617,
    SPELL_RAISE_DEAD_2                = 31624,
    SPELL_RAISE_DEAD_3                = 31625,
    SPELL_UNHOLY_FRENZY               = 31626,
    SPELL_SHADOW_BOLT                 = 31627,

    // Banshee (Ranged)
    SPELL_BANSHEE_CURSE               = 31651,
    SPELL_ANTI_MAGIC_SHELL            = 31662,
    SPELL_BANSHEE_WAIL                = 38183,

    // Gargoyle (Ranged)
    SPELL_GARGOYLE_STRIKE             = 31664,

    // Frost Wyrm (Ranged)
    SPELL_FROST_BREATH                = 31688,

    // Fel Stalker
    SPELL_MANA_BURN                   = 31729,

    // Misc
    SPELL_DEATH_AND_DECAY             = 31258
};

enum Talk
{
    SAY_ATTACKED = 0,
    SAY_BEGIN    = 1,
    SAY_INCOMING = 2,
    SAY_RALLY    = 3,
    SAY_FAILURE  = 4,
    SAY_SUCCESS  = 5,
    SAY_DEATH    = 6,
    SAY_TELEPORT = 7
};

const float UNHOLY_FRENZY_RANGE = 30.0f;

class npc_hyjal_jaina : public CreatureScript
{
public:
    npc_hyjal_jaina() : CreatureScript("npc_hyjal_jaina") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new hyjalJainaAI(creature);
    }
    struct hyjalJainaAI : public ScriptedAI
    {
        hyjalJainaAI(Creature* creature) : ScriptedAI(creature)
        {
            me->ApplySpellImmune(SPELL_DEATH_AND_DECAY, IMMUNITY_ID, SPELL_DEATH_AND_DECAY, true);
        }

        void Reset() override
        {
            scheduler.CancelAll();
            if (InstanceScript* hyjal = me->GetInstanceScript())
                if (!hyjal->GetData(DATA_WAVE_STATUS))
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_ATTACKED);

            scheduler.Schedule(15s, 35s, [this](TaskContext context)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        DoCast(target, SPELL_BLIZZARD);
                    context.Repeat();
                }).Schedule(2s, 9s, [this](TaskContext context)
                    {
                        DoCastVictim(SPELL_PYROBLAST);
                        context.Repeat();
                    }).Schedule(15s, 45s, [this](TaskContext context)
                        {
                            DoCastSelf(SPELL_SUMMON_ELEMENTALS);
                            context.Repeat();
                        });
        }

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            DoCastSelf(SPELL_SIMPLE_TELEPORT, true);

            // Should wait 2400ms
            me->SetFacingTo(1.082104f);
            DoCastSelf(SPELL_MASS_TELEPORT);
            Talk(SAY_TELEPORT);
            if (InstanceScript* hyjal = me->GetInstanceScript())
                hyjal->SetData(DATA_HORDE_RETREAT, 0);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (InstanceScript* hyjal = me->GetInstanceScript())
                hyjal->SetData(DATA_RESET_ALLIANCE, 0);
        }

        void PathEndReached(uint32 /*pathId*/) override
        {
            DoCastSelf(SPELL_MASS_TELEPORT);
            Talk(SAY_TELEPORT);
            if (InstanceScript* hyjal = me->GetInstanceScript())
                hyjal->SetData(DATA_ALLIANCE_RETREAT, 0);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
            scheduler.Update(diff);
        }
    };

    bool OnGossipSelect(Player* /*player*/ , Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

        if (InstanceScript* hyjal = creature->GetInstanceScript())
        {
            if (hyjal->GetBossState(DATA_WINTERCHILL) != DONE || hyjal->GetBossState(DATA_ANETHERON) != DONE)
            {
                hyjal->SetData(DATA_RESET_WAVES, 0);
                hyjal->SetData(DATA_SPAWN_WAVES, 0);
            }
            else
            {
                creature->AI()->Talk(SAY_SUCCESS);
                creature->GetMotionMaster()->MovePath(JAINA_RETREAT_PATH, false);
            }
        }
        return true;
    }
};

class npc_hyjal_thrall : public CreatureScript
{
public:
    npc_hyjal_thrall() : CreatureScript("npc_hyjal_thrall") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new hyjalThrallAI(creature);
    }
    struct hyjalThrallAI : public ScriptedAI
    {
        hyjalThrallAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            scheduler.CancelAll();
            if (InstanceScript* hyjal = me->GetInstanceScript())
                if (!hyjal->GetData(DATA_WAVE_STATUS))
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_ATTACKED);

            scheduler.Schedule(13s, 19s, [this](TaskContext context)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        DoCast(target, SPELL_CHAIN_LIGHTNING);
                    context.Repeat();
                }).Schedule(15s, 45s, [this](TaskContext context)
                    {
                        DoCastSelf(SPELL_FERAL_SPIRIT);
                        context.Repeat();
                    });
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (InstanceScript* hyjal = me->GetInstanceScript())
                hyjal->SetData(DATA_RESET_HORDE, 0);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
            scheduler.Update(diff);
        }
    };

    bool OnGossipSelect(Player* /*player*/, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

        if (InstanceScript* hyjal = creature->GetInstanceScript())
        {
            if (hyjal->GetBossState(DATA_KAZROGAL) != DONE || hyjal->GetBossState(DATA_AZGALOR) != DONE)
            {
                hyjal->SetData(DATA_RESET_WAVES, 0);
                hyjal->SetData(DATA_SPAWN_WAVES, 0);
            }
            else
            {
                creature->AI()->Talk(SAY_SUCCESS);
                creature->SummonCreatureGroup(0);
            }
        }
        return true;
    }
};

class npc_hyjal_tyrande : public CreatureScript
{
public:
    npc_hyjal_tyrande() : CreatureScript("npc_hyjal_tyrande") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new hyjalTyrandeAI(creature);
    }
    struct hyjalTyrandeAI : public ScriptedAI
    {
        hyjalTyrandeAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            scheduler.CancelAll();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_ATTACKED);

            scheduler.Schedule(60s, 70s, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_STARFALL);
                    context.Repeat();
                }).Schedule(4s, [this](TaskContext context)
                    {
                        DoCastSelf(SPELL_TRUESHOT_AURA);
                        context.Repeat();
                    });
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (InstanceScript* hyjal = me->GetInstanceScript())
                hyjal->SetData(DATA_RESET_NIGHT_ELF, 0);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
            scheduler.Update(diff);
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        creature->AI()->DoCast(player, SPELL_SUMMON_TEARS_OF_THE_GODDESS, true);
        return true;
    }

};

// 31538 - Cannibalize (Heal)
class spell_cannibalize_heal : public SpellScript
{
    PrepareSpellScript(spell_cannibalize_heal);

    void HandleHeal(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
        {
            uint32 heal = caster->CountPctFromMaxHealth(7);
            SetHitHeal(heal);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_cannibalize_heal::HandleHeal, EFFECT_0, SPELL_EFFECT_HEAL);
    }
};

struct npc_hyjal_ground_trash : public ScriptedAI
{
    npc_hyjal_ground_trash(Creature* creature) : ScriptedAI(creature)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        scheduler.CancelAll();
    }

    void AttackStart(Unit* who) override
    {
        switch (me->GetEntry())
        {
        case NPC_NECRO:
        case NPC_BANSH:
            if (!who)
                return;

            if (me->Attack(who, true))
                me->GetMotionMaster()->MoveChase(who, 30.0f);
            break;
        default:
            ScriptedAI::AttackStart(who);
            break;
        }

    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        switch (me->GetEntry())
        {
        case NPC_GHOUL:
        {
            scheduler.Schedule(3s, 7s, [this](TaskContext context)
                {
                    DoCastSelf(SPELL_FRENZY);
                    context.Repeat(15s, 30s);
                }).Schedule(1200ms, [this](TaskContext context)
                    {
                        if (me->GetHealthPct() <= 7)
                            DoCastSelf(SPELL_CANNIBALIZE);
                        else
                            context.Repeat();
                    });
                break;
        }
        case NPC_CRYPT:
        {
            scheduler.Schedule(0s, 2400ms, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_CRYPT_SCARABS);
                    context.Repeat(2400ms, 8s);
                });
            break;
        }
        case NPC_ABOMI:
        {
            scheduler.Schedule(13s, 17s, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_KNOCKDOWN);
                    context.Repeat(16s, 25s);
                });
            break;
        }
        case NPC_NECRO:
        {
            scheduler.Schedule(0s, 2400ms, [this](TaskContext context)
                {
                    DoCastVictim(SPELL_SHADOW_BOLT);
                    context.Repeat(2400ms, 4800ms);
                }).Schedule(5s, 10s, [this](TaskContext context)
                    {
                        // TODO: Should target corpse, and skeletons should spawn at the target
                        switch (urand(1, 3))
                        {
                        case 1:
                            DoCastSelf(SPELL_RAISE_DEAD_1);
                            break;
                        case 2:
                            DoCastSelf(SPELL_RAISE_DEAD_2);
                            break;
                        case 3:
                            DoCastSelf(SPELL_RAISE_DEAD_3);
                            break;
                        }
                        context.Repeat(10s, 20s);
                    }).Schedule(15s, 20s, [this](TaskContext context)
                    {
                        if (Creature* target = GetNearbyFriendlyTrashCreature(UNHOLY_FRENZY_RANGE))
                        {
                            DoCast(target, SPELL_UNHOLY_FRENZY);
                        }
                        context.Repeat(15s, 20s);
                    });
            break;
        }
        case NPC_BANSH:
        {
            scheduler.Schedule(10s, 15s, [this](TaskContext context)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        DoCast(target, SPELL_BANSHEE_CURSE);
                    context.Repeat(18s, 24s);
                }).Schedule(5s, 15s, [this](TaskContext context)
                    {
                        DoCastSelf(SPELL_ANTI_MAGIC_SHELL);
                        context.Repeat(18s, 24s);
                    }).Schedule(0s, 1s, [this](TaskContext context)
                        {
                            DoCastVictim(SPELL_BANSHEE_WAIL);
                            context.Repeat(1800ms, 2200ms);
                        });

            break;
        }
        case NPC_STALK:
        {
            scheduler.Schedule(3s, 6s, [this](TaskContext context)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, Powers(POWER_MANA), 30.f, true)))
                        DoCast(target, SPELL_MANA_BURN);
                    context.Repeat(6s, 9s);
                });
            break;
        }
        }

    }

    void DoAction(int32 action) override
    {
        me->setActive(true);
        switch (action)
        {
        case DATA_WINTERCHILL:
        case DATA_ANETHERON:
        case DATA_ALLIANCE_RETREAT:
            me->GetMotionMaster()->MovePath(urand(ALLIANCE_BASE_CHARGE_1, ALLIANCE_BASE_CHARGE_3), false);
            break;
        case DATA_KAZROGAL:
        case DATA_AZGALOR:
        case DATA_HORDE_RETREAT:
            me->GetMotionMaster()->MovePath(urand(HORDE_BASE_CHARGE_1, HORDE_BASE_CHARGE_3), false);
            break;
        case DATA_ARCHIMONDE:
            me->GetMotionMaster()->MovePath(urand(NIGHT_ELF_BASE_CHARGE_1, NIGHT_ELF_BASE_CHARGE_3), false);
            break;
        }
    }

    void PathEndReached(uint32 pathId) override
    {
        // Delay is required because we are calling the movement generator from inside the pathing hook.
        // If we issue another call here, it will be flushed before it is executed.
        switch (pathId)
        {
        case ALLIANCE_BASE_CHARGE_1:
        case ALLIANCE_BASE_CHARGE_2:
        case ALLIANCE_BASE_CHARGE_3:
            me->m_Events.AddEventAtOffset([this]()
                {
                    me->GetMotionMaster()->MovePath(urand(ALLIANCE_BASE_PATROL_1, ALLIANCE_BASE_PATROL_3), true);
                }, 1s);
            break;
        case HORDE_BASE_CHARGE_1:
        case HORDE_BASE_CHARGE_2:
        case HORDE_BASE_CHARGE_3:
            me->m_Events.AddEventAtOffset([this]()
                {
                    me->GetMotionMaster()->MovePath(urand(HORDE_BASE_PATROL_1, HORDE_BASE_PATROL_3), true);
                }, 1s);
            break;
        case NIGHT_ELF_BASE_CHARGE_1:
        case NIGHT_ELF_BASE_CHARGE_2:
        case NIGHT_ELF_BASE_CHARGE_3:
            me->m_Events.AddEventAtOffset([this]()
                {
                    me->GetMotionMaster()->MoveRandom(5.f);
                }, 1s);
            break;
        }
    }

    Creature* GetNearbyFriendlyTrashCreature(float radius)
    {
        //need accurate timer
        Creature* creatureToReturn = nullptr;
        std::list<Creature*> creatureList;
        GetCreatureListWithEntryInGrid(creatureList, me, NPC_ABOMI, radius);
        GetCreatureListWithEntryInGrid(creatureList, me, NPC_BANSH, radius);
        GetCreatureListWithEntryInGrid(creatureList, me, NPC_STALK, radius);
        GetCreatureListWithEntryInGrid(creatureList, me, NPC_NECRO, radius);
        GetCreatureListWithEntryInGrid(creatureList, me, NPC_CRYPT, radius);
        GetCreatureListWithEntryInGrid(creatureList, me, NPC_GHOUL, radius);
        GetCreatureListWithEntryInGrid(creatureList, me, NPC_SKELETON_INVADER, radius);
        Acore::Containers::RandomResize(creatureList, 1);
        if (creatureList.size() > 0)
        {
            creatureToReturn = creatureList.front();
        }
        creatureList.clear();
        return creatureToReturn;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
        scheduler.Update(diff);
    }

};

struct npc_hyjal_gargoyle : public ScriptedAI
{
    npc_hyjal_gargoyle(Creature* creature) : ScriptedAI(creature)
    {
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void Reset() override
    {
        scheduler.CancelAll();
    }

    void AttackStart(Unit* who) override
    {
        if (!who)
            return;

        if (me->Attack(who, true))
            me->GetMotionMaster()->MoveChase(who, 25.0f);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.Schedule(0s, 2s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_GARGOYLE_STRIKE);
                context.Repeat(2s, 3s);
            });
    }

    void DoAction(int32 action) override
    {
        me->setActive(true);
        switch (action)
        {
        case DATA_ALLIANCE_RETREAT:
            // TODO: Set up to attack NPC_BUILD
            break;
        case DATA_KAZROGAL:
        case DATA_AZGALOR:
        case DATA_HORDE_RETREAT:
            if (me->GetPositionX() < 5500.f)
                me->GetMotionMaster()->MovePath(urand(GARGOYLE_PATH_FORTRESS_1, GARGOYLE_PATH_FORTRESS_3), false);
            else
                me->GetMotionMaster()->MovePath(urand(GARGOYLE_PATH_TROLL_CAMP_1, GARGOYLE_PATH_TROLL_CAMP_3), false);
            break;
        default:
            break;
        }
    }

    void PathEndReached(uint32 /* pathId */) override
    {
        // TODO: Do they do something special after finishing the path?
        me->m_Events.AddEventAtOffset([this]()
            {
                me->GetMotionMaster()->MoveRandom(30.f);
            }, 1s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
        scheduler.Update(diff);
    }

};

struct npc_hyjal_frost_wyrm : public ScriptedAI
{
    npc_hyjal_frost_wyrm(Creature* creature) : ScriptedAI(creature)
    {
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void Reset() override
    {
        scheduler.CancelAll();
    }

    void AttackStart(Unit* who) override
    {
        if (!who)
            return;

        if (me->Attack(who, true))
            me->GetMotionMaster()->MoveChase(who, 25.0f);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.Schedule(0s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_FROST_BREATH);
                context.Repeat(3500ms, 4s);
            });
    }

    void DoAction(int32 action) override
    {
        me->setActive(true);
        switch (action)
        {
        case DATA_KAZROGAL:
        case DATA_AZGALOR:
        case DATA_HORDE_RETREAT:
            if (me->GetPositionX() < 5500.f)
                me->GetMotionMaster()->MovePath(FROST_WYRM_FORTRESS, false);
            else
                me->GetMotionMaster()->MovePath(FROST_WYRM_TROLL_CAMP, false);
            break;
        default:
            break;
        }
    }

    void PathEndReached(uint32 pathId) override
    {
        if (pathId == FROST_WYRM_FORTRESS)
        {
            me->m_Events.AddEventAtOffset([this]()
                {
                    me->GetMotionMaster()->MovePath(FROST_WYRM_FORTRESS_PATROL, true);
                }, 1s);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
        scheduler.Update(diff);
    }

};

void AddSC_hyjal()
{
    new npc_hyjal_jaina();
    new npc_hyjal_thrall();
    new npc_hyjal_tyrande();
    RegisterHyjalAI(npc_hyjal_ground_trash);
    RegisterHyjalAI(npc_hyjal_gargoyle);
    RegisterHyjalAI(npc_hyjal_frost_wyrm);
    RegisterSpellScript(spell_cannibalize_heal);
}
