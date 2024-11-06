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
SDName: Boss_ZulJin
SD%Complete: 85%
SDComment:
EndScriptData */

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "zulaman.h"

enum Says
{
    SAY_INTRO                    = 0,
    SAY_AGGRO                    = 1,
    SAY_TRANSFORM_TO_BEAR        = 2,
    SAY_TRANSFORM_TO_EAGLE       = 3,
    SAY_TRANSFORM_TO_LYNX        = 4,
    SAY_TRANSFORM_TO_DRAGONHAWK  = 5,
    SAY_FIRE_BREATH              = 6,
    SAY_BERSERK                  = 7,
    SAY_KILL                     = 8,
    SAY_DEATH                    = 9
};

enum Spells
{
    // Troll Form
    SPELL_WHIRLWIND               = 17207,
    SPELL_GRIEVOUS_THROW          = 43093, // remove debuff after full healed
    // Bear Form
    SPELL_CREEPING_PARALYSIS      = 43095, // should cast on the whole raid
    SPELL_OVERPOWER               = 43456, // use after melee attack dodged
    // Eagle Form
    SPELL_ENERGY_STORM            = 43983, // enemy area aura, trigger 42577
    SPELL_ZAP_INFORM              = 42577,
    SPELL_ZAP_DAMAGE              = 43137, // 1250 damage
    SPELL_SUMMON_CYCLONE          = 43112, // summon four feather vortex
    CREATURE_FEATHER_VORTEX       = 24136,
    SPELL_CYCLONE_VISUAL          = 43119, // trigger 43147 visual
    SPELL_CYCLONE_PASSIVE         = 43120, // trigger 43121 (4y aoe) every second
    // Lynx Form
    SPELL_CLAW_RAGE_CHARGE        = 42583,
    SPELL_CLAW_RAGE_AURA          = 43149,
    SPELL_CLAW_RAGE_DAMAGE        = 43150,
    SPELL_LYNX_RUSH_HASTE         = 43152,
    SPELL_LYNX_RUSH_DAMAGE        = 43153,
    // Dragonhawk Form
    SPELL_FLAME_WHIRL             = 43213, // trigger two spells
    SPELL_FLAME_BREATH            = 43215,
    SPELL_SUMMON_PILLAR           = 43216, // summon 24187
    CREATURE_COLUMN_OF_FIRE       = 24187,
    SPELL_PILLAR_TRIGGER          = 43218, // trigger 43217
    // Cosmetic
    SPELL_SPIRIT_AURA             = 42466,
    SPELL_SIPHON_SOUL             = 43501,
    // Transforms:
    SPELL_SHAPE_OF_THE_BEAR       = 42594, // 15% dmg
    SPELL_SHAPE_OF_THE_EAGLE      = 42606,
    SPELL_SHAPE_OF_THE_LYNX       = 42607, // haste melee 30%
    SPELL_SHAPE_OF_THE_DRAGONHAWK = 42608,

    SPELL_BERSERK                 = 45078
};

enum Phase
{
    PHASE_BEAR                    = 0,
    PHASE_EAGLE                   = 1,
    PHASE_LYNX                    = 2,
    PHASE_DRAGONHAWK              = 3,
    PHASE_TROLL                   = 4
};

enum Misc
{
    GUID_CHARGE_TARGET            = 0
};

//coords for going for changing form
#define CENTER_X 120.148811f
#define CENTER_Y 703.713684f
#define CENTER_Z 45.111477f

struct SpiritInfoStruct
{
    uint32 entry;
    float x, y, z, orient;
};

static SpiritInfoStruct SpiritInfo[4] =
{
    {23878, 147.87f, 706.51f, 45.11f, 3.04f},
    {23880, 88.95f, 705.49f, 45.11f, 6.11f},
    {23877, 137.23f, 725.98f, 45.11f, 3.71f},
    {23879, 104.29f, 726.43f, 45.11f, 5.43f}
};

struct TransformStruct
{
    uint8  text;
    uint32 spell, unaura;
};

static TransformStruct Transform[4] =
{
    {SAY_TRANSFORM_TO_BEAR, SPELL_SHAPE_OF_THE_BEAR, SPELL_WHIRLWIND},
    {SAY_TRANSFORM_TO_EAGLE, SPELL_SHAPE_OF_THE_EAGLE, SPELL_SHAPE_OF_THE_BEAR},
    {SAY_TRANSFORM_TO_LYNX, SPELL_SHAPE_OF_THE_LYNX, SPELL_SHAPE_OF_THE_EAGLE},
    {SAY_TRANSFORM_TO_DRAGONHAWK, SPELL_SHAPE_OF_THE_DRAGONHAWK, SPELL_SHAPE_OF_THE_LYNX}
};

struct boss_zuljin : public BossAI
{
    boss_zuljin(Creature* creature) : BossAI(creature, DATA_ZULJIN) { }

    ObjectGuid ClawTargetGUID;
    ObjectGuid TankGUID;

    uint32 Phase;
    uint32 health_20;

    uint32 Whirlwind_Timer;
    uint32 Grievous_Throw_Timer;

    uint32 Creeping_Paralysis_Timer;
    uint32 Overpower_Timer;

    uint32 Claw_Rage_Timer;
    uint32 Lynx_Rush_Timer;
    uint32 Claw_Counter;
    uint32 Claw_Loop_Timer;

    uint32 Flame_Whirl_Timer;
    uint32 Flame_Breath_Timer;
    uint32 Pillar_Of_Fire_Timer;

    void Reset() override
    {
        _Reset();
        Phase = 0;

        health_20 = me->CountPctFromMaxHealth(20);

        me->m_Events.AddEventAtOffset([&]() {
            DoCastSelf(SPELL_BERSERK, true);
            Talk(SAY_BERSERK);
        }, 10min);

        Claw_Rage_Timer = 5000;
        Lynx_Rush_Timer = 14000;
        Claw_Loop_Timer = 0;
        Claw_Counter = 0;

        Flame_Whirl_Timer = 5000;
        Flame_Breath_Timer = 6000;
        Pillar_Of_Fire_Timer = 7000;

        me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, 33975);
        me->m_Events.KillAllEvents(false);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        DoZoneInCombat();

        Talk(SAY_INTRO);
        SpawnAdds();
        //EnterPhase(0);

        Talk(SAY_AGGRO, 37s);

        ScheduleTimedEvent(7s, [&] {
            DoCastAOE(SPELL_WHIRLWIND);
        }, 15s, 20s);

        ScheduleTimedEvent(8s, [&] {
            DoCastRandomTarget(SPELL_GRIEVOUS_THROW, 0, 100.0f);
        }, 10s);

        // Phase 2: Bear Form.
        ScheduleHealthCheckEvent({ 80 }, [&] {
            scheduler.CancelAll();
            ScheduleTimedEvent(7s, [&] {
                DoCastAOE(SPELL_CREEPING_PARALYSIS);
            }, 20s);

            ScheduleTimedEvent(1s, [&] {
                if (!me->HasSpellCooldown(SPELL_OVERPOWER))
                {
                    if (me->GetVictim() && me->GetComboPoints())
                        DoCastVictim(SPELL_OVERPOWER);
                }
            }, 1s);
        });

        // Phase 3: Eagle Form.
        ScheduleHealthCheckEvent({ 60 }, [&] {
            scheduler.CancelAll();
            me->GetMotionMaster()->Clear();
            DoCast(me, SPELL_ENERGY_STORM, true); // enemy aura
            for (uint8 i = 0; i < 4; ++i)
            {
                if (Creature* vortex = DoSpawnCreature(CREATURE_FEATHER_VORTEX, 0, 0, 0, 0, TEMPSUMMON_CORPSE_DESPAWN, 0))
                {
                    vortex->CastSpell(vortex, SPELL_CYCLONE_PASSIVE, true);
                    vortex->CastSpell(vortex, SPELL_CYCLONE_VISUAL, true);
                    vortex->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    vortex->SetSpeed(MOVE_RUN, 1.0f);
                    DoZoneInCombat(vortex);
                }
            }
        });

        // Phase 4: Lynx Form.
        ScheduleHealthCheckEvent({ 40 }, [&] {
            scheduler.CancelAll();
            me->RemoveAurasDueToSpell(SPELL_ENERGY_STORM);
            summons.DespawnEntry(CREATURE_FEATHER_VORTEX);
            me->ResumeChasingVictim();

            ScheduleTimedEvent(5s, [&] {
                DoCastRandomTarget(SPELL_CLAW_RAGE_CHARGE);
            }, 15s, 20s);
        });

        // Phase 5: Dragonhawk Form.
        ScheduleHealthCheckEvent({ 20 }, [&] {
        });
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_CLAW_RAGE_CHARGE && target != me)
        {
            DoCastSelf(SPELL_CLAW_RAGE_AURA);
            _chargeTargetGUID = target->GetGUID();
        }
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_KILL);
    }

    ObjectGuid GetGUID(int32 index) const override
    {
        if (index == GUID_CHARGE_TARGET)
            return _chargeTargetGUID;

        return ObjectGuid::Empty;
    }

    void JustDied(Unit* /*killer*/) override
    {
        instance->SetBossState(DATA_ZULJIN, DONE);
        Talk(SAY_DEATH);
        summons.DespawnEntry(CREATURE_COLUMN_OF_FIRE);

        if (Unit* Temp = summons.GetCreatureWithEntry(23877))
            Temp->SetUInt32Value(UNIT_FIELD_BYTES_1, UNIT_STAND_STATE_DEAD);
    }

    void SpawnAdds()
    {
        for (auto const& spiritInfo : SpiritInfo)
        {
            if (Creature* creature = me->SummonCreature(spiritInfo.entry, spiritInfo.x, spiritInfo.y, spiritInfo.z, spiritInfo.orient, TEMPSUMMON_DEAD_DESPAWN, 0))
            {
                creature->CastSpell(creature, SPELL_SPIRIT_AURA, true);
                creature->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                creature->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            }
        }
    }

    void EnterPhase(uint32 NextPhase)
    {
        switch (NextPhase)
        {
        case 0:
            break;
        case 1:
        case 2:
        case 3:
        case 4:
            me->NearTeleportTo(CENTER_X, CENTER_Y, CENTER_Z, me->GetOrientation());
            DoResetThreatList();
            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, 0);
            me->RemoveAurasDueToSpell(Transform[Phase].unaura);
            DoCast(me, Transform[Phase].spell);
            Talk(Transform[Phase].text);
            if (Phase > 0)
            {
                //if (Unit* Temp = ObjectAccessor::GetUnit(*me, SpiritGUID[Phase - 1]))
                    //Temp->SetUInt32Value(UNIT_FIELD_BYTES_1, UNIT_STAND_STATE_DEAD);
            }
            //if (Unit* Temp = ObjectAccessor::GetUnit(*me, SpiritGUID[NextPhase - 1]))
                //Temp->CastSpell(me, SPELL_SIPHON_SOUL, false); // should m cast on temp
            break;
        default:
            break;
        }
    }

    private:
        ObjectGuid _chargeTargetGUID;
};

struct npc_zuljin_vortex : public ScriptedAI
{
    npc_zuljin_vortex(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override { }

    void JustEngagedWith(Unit* /*target*/) override { }

    void SpellHit(Unit* caster, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_ZAP_INFORM)
            DoCast(caster, SPELL_ZAP_DAMAGE, true);
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        //if the vortex reach the target, it change his target to another player
        if (me->IsWithinMeleeRange(me->GetVictim()))
            AttackStart(SelectTarget(SelectTargetMethod::Random, 0));
    }
};

// 43149 
class spell_claw_rage_aura : public AuraScript
{
    PrepareAuraScript(spell_claw_rage_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CLAW_RAGE_DAMAGE });
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        if (Creature* caster = GetCaster()->ToCreature())
        {
            if (Player* target = ObjectAccessor::GetPlayer(*caster, caster->AI()->GetGUID(GUID_CHARGE_TARGET)))
            {
                if (caster->CanSeeOrDetect(target) && !target->HasAuraType(SPELL_AURA_FEIGN_DEATH))
                    GetCaster()->CastSpell(target, SPELL_CLAW_RAGE_DAMAGE);
                else
                    GetCaster()->RemoveAurasDueToSpell(SPELL_CLAW_RAGE_AURA);
            }
            else
                GetCaster()->RemoveAurasDueToSpell(SPELL_CLAW_RAGE_AURA);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_claw_rage_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_boss_zuljin()
{
    RegisterZulAmanCreatureAI(boss_zuljin);
    RegisterZulAmanCreatureAI(npc_zuljin_vortex);
    RegisterSpellScript(spell_claw_rage_aura);
}
