/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "naxxramas.h"
#include "Player.h"

enum Spells
{
    SPELL_BERSERK                       = 26662,

    // Marks
    SPELL_MARK_OF_KORTHAZZ              = 28832,
    SPELL_MARK_OF_BLAUMEUX              = 28833,
    SPELL_MARK_OF_RIVENDARE             = 28834,
    SPELL_MARK_OF_ZELIEK                = 28835,
    SPELL_MARK_DAMAGE                   = 28836,

    // Korth'azz
    SPELL_KORTHAZZ_METEOR_10            = 28884,
    SPELL_KORTHAZZ_METEOR_25            = 57467,

    // Blaumeux
    SPELL_BLAUMEUX_SHADOW_BOLT_10       = 57374,
    SPELL_BLAUMEUX_SHADOW_BOLT_25       = 57464,
    SPELL_BLAUMEUX_VOID_ZONE_10         = 28863,
    SPELL_BLAUMEUX_VOID_ZONE_25         = 57463,
    SPELL_BLAUMEUX_UNYIELDING_PAIN      = 57381,

    // Zeliek
    SPELL_ZELIEK_HOLY_WRATH_10          = 28883,
    SPELL_ZELIEK_HOLY_WRATH_25          = 57466,
    SPELL_ZELIEK_HOLY_BOLT_10           = 57376,
    SPELL_ZELIEK_HOLY_BOLT_25           = 57465,
    SPELL_ZELIEK_CONDEMNATION           = 57377,

    // Rivendare
    SPELL_RIVENDARE_UNHOLY_SHADOW_10    = 28882,
    SPELL_RIVENDARE_UNHOLY_SHADOW_25    = 57369,
};

enum Events
{
    EVENT_SPELL_MARK_CAST               = 1,
    EVENT_SPELL_PRIMARY                 = 2,
    EVENT_SPELL_SECONDARY               = 3,
    EVENT_SPELL_PUNISH                  = 4,
    EVENT_BERSERK                       = 5,
};

enum Misc
{
    // Movement
    MOVE_PHASE_NONE                     = 0,
    MOVE_PHASE_STARTED                  = 1,
    MOVE_PHASE_FINISHED                 = 2,

    // Horseman
    HORSEMAN_ZELIEK                     = 0,
    HORSEMAN_BLAUMEUX                   = 1,
    HORSEMAN_RIVENDARE                  = 2,
    HORSEMAN_KORTHAZZ                   = 3,
};

enum FourHorsemen
{
    SAY_AGGRO       = 0,
    SAY_TAUNT       = 1,
    SAY_SPECIAL     = 2,
    SAY_SLAY        = 3,
    SAY_DEATH       = 4
};

// MARKS
const uint32 TABLE_SPELL_MARK[4] = {SPELL_MARK_OF_ZELIEK, SPELL_MARK_OF_BLAUMEUX, SPELL_MARK_OF_RIVENDARE, SPELL_MARK_OF_KORTHAZZ};

// SPELL PRIMARY
const uint32 TABLE_SPELL_PRIMARY_10[4] = {SPELL_ZELIEK_HOLY_BOLT_10, SPELL_BLAUMEUX_SHADOW_BOLT_10, SPELL_RIVENDARE_UNHOLY_SHADOW_10, SPELL_KORTHAZZ_METEOR_10};
const uint32 TABLE_SPELL_PRIMARY_25[4] = {SPELL_ZELIEK_HOLY_BOLT_25, SPELL_BLAUMEUX_SHADOW_BOLT_25, SPELL_RIVENDARE_UNHOLY_SHADOW_25, SPELL_KORTHAZZ_METEOR_25};

// PUNISH
const uint32 TABLE_SPELL_PUNISH[4] = {SPELL_ZELIEK_CONDEMNATION, SPELL_BLAUMEUX_UNYIELDING_PAIN, 0, 0};

// SPELL SECONDARY
const uint32 TABLE_SPELL_SECONDARY_10[4] = {SPELL_ZELIEK_HOLY_WRATH_10, SPELL_BLAUMEUX_VOID_ZONE_10, 0, 0};
const uint32 TABLE_SPELL_SECONDARY_25[4] = {SPELL_ZELIEK_HOLY_WRATH_25, SPELL_BLAUMEUX_VOID_ZONE_25, 0, 0};



const Position WaypointPositions[12] =
{
    // Thane waypoints
    {2542.3f, -2984.1f, 241.49f, 5.362f},
    {2547.6f, -2999.4f, 241.34f, 5.049f},
    {2542.9f, -3015.0f, 241.35f, 4.654f},
    // Lady waypoints
    {2498.3f, -2961.8f, 241.28f, 3.267f},
    {2487.7f, -2959.2f, 241.28f, 2.890f},
    {2469.4f, -2947.6f, 241.28f, 2.576f},
    // Baron waypoints
    {2553.8f, -2968.4f, 241.33f, 5.757f},
    {2564.3f, -2972.5f, 241.33f, 5.890f},
    {2583.9f, -2971.6f, 241.35f, 0.008f},
    // Sir waypoints
    {2534.5f, -2921.7f, 241.53f, 1.363f},
    {2523.5f, -2902.8f, 241.28f, 2.095f},
    {2517.8f, -2896.6f, 241.28f, 2.315f},
};

class boss_four_horsemen : public CreatureScript
{
public:
    boss_four_horsemen() : CreatureScript("boss_four_horsemen") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_four_horsemenAI (pCreature);
    }

    struct boss_four_horsemenAI : public BossAI
    {
        explicit boss_four_horsemenAI(Creature *c) : BossAI(c, BOSS_HORSEMAN)
        {
            pInstance = me->GetInstanceScript();
            switch (me->GetEntry())
            {
                case NPC_SIR_ZELIEK:
                    horsemanId = HORSEMAN_ZELIEK;
                    break;
                case NPC_LADY_BLAUMEUX:
                    horsemanId = HORSEMAN_BLAUMEUX;
                    break;
                case NPC_BARON_RIVENDARE:
                    horsemanId = HORSEMAN_RIVENDARE;
                    break;
                case NPC_THANE_KORTHAZZ:
                    horsemanId = HORSEMAN_KORTHAZZ;
                    break;
            }
        }

        EventMap events;
        InstanceScript* pInstance;
        uint8 currentWaypoint{};
        uint8 movementPhase{};
        uint8 horsemanId;

        void MoveToCorner()
        {
            switch(me->GetEntry())
            {
                case NPC_THANE_KORTHAZZ:  currentWaypoint = 0; break;
                case NPC_LADY_BLAUMEUX:   currentWaypoint = 3; break;
                case NPC_BARON_RIVENDARE: currentWaypoint = 6; break;
                case NPC_SIR_ZELIEK:      currentWaypoint = 9; break;
            }
            me->GetMotionMaster()->MovePoint(currentWaypoint, WaypointPositions[currentWaypoint]);
        }

        bool IsInRoom()
        {
            if (me->GetExactDist(2535.1f, -2968.7f, 241.3f) > 100.0f)
            {
                EnterEvadeMode();
                return false;
            }

            return true;
        }

        void Reset() override
        {
            BossAI::Reset();
            me->SetPosition(me->GetHomePosition());
            movementPhase = MOVE_PHASE_NONE;
            currentWaypoint = 0;
            me->SetReactState(REACT_AGGRESSIVE);
            events.Reset();

            // Schedule Events
            events.RescheduleEvent(EVENT_SPELL_MARK_CAST, 24000);
            events.RescheduleEvent(EVENT_BERSERK, 100*15000);

            if ((me->GetEntry() != NPC_LADY_BLAUMEUX && me->GetEntry() != NPC_SIR_ZELIEK))
                events.RescheduleEvent(EVENT_SPELL_PRIMARY, 10000+rand()%5000);
            else
            {
                events.RescheduleEvent(EVENT_SPELL_PUNISH, 5000);
                events.RescheduleEvent(EVENT_SPELL_SECONDARY, 15000);
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            // final waypoint
            if (id % 3 == 2)
            {
                movementPhase = MOVE_PHASE_FINISHED;
                me->SetReactState(REACT_AGGRESSIVE);

                me->SetInCombatWithZone();
                if (!UpdateVictim())
                {
                    EnterEvadeMode();
                    return;
                }

                if (me->GetEntry() == NPC_LADY_BLAUMEUX || me->GetEntry() == NPC_SIR_ZELIEK)
                {
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                }
                return;
            }

            currentWaypoint = id+1;
        }

        void AttackStart(Unit* who) override
        {
            if (movementPhase == MOVE_PHASE_FINISHED)
            {
                if (me->GetEntry() == NPC_LADY_BLAUMEUX || me->GetEntry() == NPC_SIR_ZELIEK)
                    me->Attack(who, false);
                else
                    ScriptedAI::AttackStart(who);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_SLAY);

            if (pInstance)
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            if (pInstance)
            {
                if (pInstance->GetBossState(BOSS_HORSEMAN) == DONE) {
                    if (!me->GetMap()->GetPlayers().isEmpty())
                        if (Player* player = me->GetMap()->GetPlayers().getFirst()->GetSource())
                            player->SummonGameObject(RAID_MODE(GO_HORSEMEN_CHEST_10, GO_HORSEMEN_CHEST_25), 2514.8f, -2944.9f, 245.55f, 5.51f, 0, 0, 0, 0, 0);
                }
            }

            Talk(SAY_DEATH);
        }

        void EnterCombat(Unit * who) override
        {
            BossAI::EnterCombat(who);
            if (movementPhase == MOVE_PHASE_NONE)
            {
                Talk(SAY_AGGRO);

                me->SetReactState(REACT_PASSIVE);
                movementPhase = MOVE_PHASE_STARTED;
                me->SetSpeed(MOVE_RUN, me->GetSpeedRate(MOVE_RUN), true);
                MoveToCorner();
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (movementPhase == MOVE_PHASE_STARTED && currentWaypoint)
            {
                me->GetMotionMaster()->MovePoint(currentWaypoint, WaypointPositions[currentWaypoint]);
                currentWaypoint = 0;
            }

            if (!IsInRoom())
                return;

            if (movementPhase < MOVE_PHASE_FINISHED || !UpdateVictim())
                return;
            
            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_MARK_CAST:
                    me->CastSpell(me, TABLE_SPELL_MARK[horsemanId], false);
                    events.RepeatEvent((me->GetEntry() == NPC_LADY_BLAUMEUX || me->GetEntry() == NPC_SIR_ZELIEK) ? 15000 : 12000);
                    return;
                case EVENT_BERSERK:
                    Talk(SAY_SPECIAL);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    events.PopEvent();
                    return;
                case EVENT_SPELL_PRIMARY:
                    Talk(SAY_TAUNT);

                    me->CastSpell(me->GetVictim(), RAID_MODE(TABLE_SPELL_PRIMARY_10[horsemanId], TABLE_SPELL_PRIMARY_25[horsemanId]), false);
                    events.RepeatEvent(15000);
                    return;
                case EVENT_SPELL_PUNISH:
                    if (!SelectTarget(SELECT_TARGET_NEAREST, 0, 45.0f, true))
                        me->CastSpell(me, TABLE_SPELL_PUNISH[horsemanId], false);
                    events.RepeatEvent(3000);
                    return;
                case EVENT_SPELL_SECONDARY:
                    me->CastSpell(me->GetVictim(), RAID_MODE(TABLE_SPELL_SECONDARY_10[horsemanId], TABLE_SPELL_SECONDARY_25[horsemanId]), false);
                    events.RepeatEvent(15000);
                    return;
            }

            if ((me->GetEntry() == NPC_LADY_BLAUMEUX || me->GetEntry() == NPC_SIR_ZELIEK))
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 45.0f, true))
                    me->CastSpell(target, RAID_MODE(TABLE_SPELL_PRIMARY_10[horsemanId], TABLE_SPELL_PRIMARY_25[horsemanId]), false);
            }
            else
                DoMeleeAttackIfReady();
        }
    };
};

class spell_four_horsemen_mark : public SpellScriptLoader
{
    public:
        spell_four_horsemen_mark() : SpellScriptLoader("spell_four_horsemen_mark") { }

        class spell_four_horsemen_mark_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_four_horsemen_mark_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                {
                    int32 damage;
                    switch (GetStackAmount())
                    {
                        case 1:
                            damage = 0;
                            break;
                        case 2:
                            damage = 500;
                            break;
                        case 3:
                            damage = 1000;
                            break;
                        case 4:
                            damage = 1500;
                            break;
                        case 5:
                            damage = 4000;
                            break;
                        case 6:
                            damage = 12000;
                            break;
                        default:
                            damage = 20000 + 1000 * (GetStackAmount() - 7);
                            break;
                    }
                    if (damage)
                        caster->CastCustomSpell(SPELL_MARK_DAMAGE, SPELLVALUE_BASE_POINT0, damage, GetTarget());
                }
            }

            void Register() override
            {
                AfterEffectApply += AuraEffectApplyFn(spell_four_horsemen_mark_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_four_horsemen_mark_AuraScript();
        }
};

void AddSC_boss_four_horsemen()
{
    new boss_four_horsemen();
    new spell_four_horsemen_mark();
}
