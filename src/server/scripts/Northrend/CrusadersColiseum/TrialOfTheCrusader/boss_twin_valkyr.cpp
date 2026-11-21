/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "trial_of_the_crusader.h"
/*
    (!) ACTUALLY FJOLA CONTROLLS THE WHOLE FIGHT (SPECIAL ABILITIES, ETC.) SINCE THEY DIE SIMULTANEOUSLY
*/

enum Yells
{
    SAY_AGGRO               = 0,
    SAY_NIGHT               = 2,
    SAY_LIGHT               = 1,
    EMOTE_VORTEX            = 3,
    EMOTE_TWINK_PACT        = 4,
    SAY_TWINK_PACT          = 5,
    SAY_KILL_PLAYER         = 6,
    SAY_BERSERK             = 7,
    SAY_DEATH               = 8,
    EMOTE_BERSERK           = 10, // Eydis only
    EMOTE_TOUCH             = 11,
};

enum Equipment
{
    EQUIP_MAIN_1         = 49303,
    EQUIP_OFFHAND_1      = 47146,
    EQUIP_RANGED_1       = 47267,
    EQUIP_MAIN_2         = 45990,
    EQUIP_OFFHAND_2      = 47470,
    EQUIP_RANGED_2       = 47267,
};

enum ValkyrNPCs
{
    NPC_DARK_ESSENCE         = 34567,
    NPC_LIGHT_ESSENCE        = 34568,
    NPC_BULLET_STALKER_DARK  = 34704,
    NPC_BULLET_STALKER_LIGHT = 34720,
    NPC_BULLET_CONTROLLER    = 34743,
};

enum ValkyrSpells
{
    SPELL_LIGHT_ESSENCE         = 65686,
    SPELL_LIGHT_ESSENCE_2       = 65811,
    SPELL_DARK_ESSENCE          = 65684,
    SPELL_DARK_ESSENCE_2        = 65827,

    SPELL_UNLEASHED_DARK        = 65808,
    SPELL_UNLEASHED_LIGHT       = 65795,
    SPELL_POWERING_UP           = 67590,
    SPELL_EMPOWERED_DARK        = 65724,
    SPELL_EMPOWERED_LIGHT       = 65748,
    SPELL_SURGE_OF_SPEED        = 65828,

    SPELL_LIGHT_TWIN_SPIKE      = 66075,
    SPELL_LIGHT_SURGE           = 65766,
    SPELL_LIGHT_SHIELD          = 65858,
    SPELL_LIGHT_TWIN_PACT       = 65876,
    SPELL_LIGHT_VORTEX          = 66046,
    SPELL_LIGHT_TOUCH           = 67297,

    SPELL_DARK_TWIN_SPIKE       = 66069,
    SPELL_DARK_SURGE            = 65768,
    SPELL_DARK_SHIELD           = 65874,
    SPELL_DARK_TWIN_PACT        = 65875,
    SPELL_DARK_VORTEX           = 66058,
    SPELL_DARK_TOUCH            = 67282,

    SPELL_TWIN_POWER            = 65916,
    SPELL_BERSERK               = 64238,

    SPELL_TWIN_EMPATHY_DARK     = 66132,
    SPELL_TWIN_EMPATHY_LIGHT    = 66133,

    SPELL_CLEAR_VALKYR_ESSENCE  = 67547,
    SPELL_CLEAR_VALKYR_TOUCH    = 68084,

    SPELL_BULLET_CONTROLLER_PERIODIC     = 66149,
    SPELL_BULLET_CONTROLLER_SUMMON_LIGHT = 66152,
    SPELL_BULLET_CONTROLLER_SUMMON_DARK  = 66153,
    SPELL_BULLET_SUMMON_TRIGGER          = 66077,
    SPELL_LIGHT_BALL_PASSIVE             = 65794,
    SPELL_DARK_BALL_PASSIVE              = 65796,
    SPELL_LIGHT_BALL_PASSIVE_TRIGGER     = 66312,
    SPELL_DARK_BALL_PASSIVE_TRIGGER      = 66314,
};

enum ValkyrBullets
{
    // The periodic controller summons an orb only while fewer than this many of its colour are alive
    BULLET_CONTROLLER_ORB_CAP = 16,
    POINT_BULLET_STALKER      = 1,
};

enum ValkyrEvents
{
    EVENT_BERSERK = 1,
    EVENT_BULLET_BURST,
    EVENT_SPELL_SPIKE,
    EVENT_SPELL_TOUCH,
    EVENT_SPECIAL,
    EVENT_REMOVE_DUAL_WIELD,
};

struct boss_twin_valkyrAI : public ScriptedAI
{
    boss_twin_valkyrAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
    {
        pInstance = pCreature->GetInstanceScript();
        me->SetReactState(REACT_PASSIVE);
        me->SetStatPctModifier(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_PCT, 1.0f);
        me->UpdateDamagePhysical(OFF_ATTACK);
        SpecialMask = 0;
        _firstBulletBurst = true;
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_HASTE_SPELLS, true);

        events.Reset();
        if (me->GetEntry() == NPC_LIGHTBANE )
        {
            if (pInstance)
                pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, 21853);

            // special events here
            events.RescheduleEvent(EVENT_BERSERK, IsHeroic() ? 6min : 8min);
            events.RescheduleEvent(EVENT_BULLET_BURST, 24s);
            events.RescheduleEvent(EVENT_SPECIAL, 45s);
        }
        events.RescheduleEvent(EVENT_SPELL_SPIKE, 5s, 8s);
        if (IsHeroic())
            events.RescheduleEvent(EVENT_SPELL_TOUCH, 10s, 25s, 1);

        me->SetCanFly(true);
        me->SetDisableGravity(true);
    }

    InstanceScript* pInstance;
    SummonList summons;
    EventMap events;
    uint8 SpecialMask;
    bool _firstBulletBurst;

    void DoAction(int32 a) override
    {
        switch (a)
        {
            case ACTION_DESPAWN_SUMMONS:
                summons.DespawnAll();
                if (me->GetEntry() == NPC_LIGHTBANE)
                {
                    if (Creature* controller = me->FindNearestCreature(NPC_BULLET_CONTROLLER, 200.0f))
                        controller->RemoveAurasDueToSpell(sSpellMgr->GetSpellIdForDifficulty(SPELL_BULLET_CONTROLLER_PERIODIC, controller));
                    DoCastAOE(SPELL_CLEAR_VALKYR_ESSENCE, true);
                    DoCastAOE(SPELL_CLEAR_VALKYR_TOUCH, true);
                }
                break;
            case -3:
                me->SetCanDualWield(true);
                me->CastSpell(me, SPELL_TWIN_POWER, true);
                events.RescheduleEvent(EVENT_REMOVE_DUAL_WIELD, 15s);
                break;
            default:
                break;
        }
    }

    Creature* GetSister()
    {
        return ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(me->GetEntry() == NPC_DARKBANE ? DATA_LIGHTBANE : DATA_DARKBANE));
    }

    static void ApplyTwinEmpathy(Creature* caster, Creature* sister)
    {
        caster->AddAura(caster->GetEntry() == NPC_LIGHTBANE ? SPELL_TWIN_EMPATHY_DARK : SPELL_TWIN_EMPATHY_LIGHT, sister);
    }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        // The first twin is summoned alone, so the second links both before anyone can hit them
        if (Creature* twin = GetSister())
        {
            ApplyTwinEmpathy(me, twin);
            ApplyTwinEmpathy(twin, me);
        }
    }

    /*void AttackStart(Unit* victim)
    {
        if (victim && me->Attack(victim, true))
            me->GetMotionMaster()->MoveChase(victim, 0.0f, 0.0f, 6.0f);
    }*/

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->setActive(true);
        me->LowerPlayerDamageReq(me->GetMaxHealth());
        DoZoneInCombat();
        if (Creature* twin = GetSister())
        {
            ApplyTwinEmpathy(me, twin);
            if (!twin->IsInCombat())
                if (Unit* target = twin->SelectNearestTarget(200.0f))
                    twin->AI()->AttackStart(target);
        }

        Talk(SAY_AGGRO);
        me->CastSpell(me, me->GetEntry() == NPC_LIGHTBANE ? SPELL_LIGHT_SURGE : SPELL_DARK_SURGE, true);

        if (me->GetEntry() == NPC_LIGHTBANE)
        {
            if (pInstance)
                pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, 21853);

            if (Creature* controller = me->FindNearestCreature(NPC_BULLET_CONTROLLER, 200.0f))
                controller->CastSpell(controller, SPELL_BULLET_CONTROLLER_PERIODIC, true);
        }
    }

    void JustReachedHome() override
    {
        me->setActive(false);
    }

    void myDoMeleeAttackIfReady()
    {
        DoMeleeAttackIfReady();
        return;

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        Unit* victim = me->GetVictim();
        if (!victim || !victim->IsInWorld())
            return;

        float allowedDist = std::sqrt(MELEE_RANGE * MELEE_RANGE + 6.0f * 6.0f);
        if (!me->IsWithinMeleeRange(victim, allowedDist))
            return;

        if (me->isAttackReady())
        {
            me->AttackerStateUpdate(victim);
            me->resetAttackTimer();
        }

        if (me->haveOffhandWeapon() && me->isAttackReady(OFF_ATTACK))
        {
            me->AttackerStateUpdate(victim, OFF_ATTACK);
            me->resetAttackTimer(OFF_ATTACK);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        uint8 eventId = events.ExecuteEvent();

        switch (eventId)
        {
            case 0:
                break;
            case EVENT_BERSERK:
                me->CastSpell(me, SPELL_BERSERK, true);
                Talk(SAY_BERSERK);
                if (Creature* twin = GetSister())
                {
                    twin->CastSpell(twin, SPELL_BERSERK, true);
                    twin->AI()->Talk(EMOTE_BERSERK);
                    twin->AI()->Talk(SAY_BERSERK);
                }

                break;
            case EVENT_BULLET_BURST:
                {
                    // Base points carry how many stalkers of each colour summon an orb.
                    // Only the first burst has Dark orbs, and none in 25-player.
                    int32 lightCount = Is25ManRaid() ? (_firstBulletBurst ? 15 : urand(11, 13)) : 10;
                    int32 darkCount = (_firstBulletBurst && !Is25ManRaid()) ? 10 : 0;
                    me->CastSpell(me, SPELL_BULLET_SUMMON_TRIGGER, CastSpellExtraArgs(TRIGGERED_FULL_MASK)
                        .AddSpellMod(SPELLVALUE_BASE_POINT0, lightCount)
                        .AddSpellMod(SPELLVALUE_BASE_POINT1, darkCount));
                    _firstBulletBurst = false;
                    events.Repeat(45s, 100s);
                }
                break;
            case EVENT_SPELL_SPIKE:
                me->CastSpell(me->GetVictim(), me->GetEntry() == NPC_LIGHTBANE ? SPELL_LIGHT_TWIN_SPIKE : SPELL_DARK_TWIN_SPIKE, false);
                events.Repeat(7s, 10s);
                break;
            case EVENT_SPELL_TOUCH:
                {
                    uint32 essenceId = 0;
                    switch (me->GetEntry())
                    {
                        case NPC_LIGHTBANE:
                            switch (GetDifficulty())
                            {
                                case 0:
                                    essenceId = 65684;
                                    break;
                                case 1:
                                    essenceId = 67176;
                                    break;
                                case 2:
                                    essenceId = 67177;
                                    break;
                                case 3:
                                    essenceId = 67178;
                                    break;
                            }
                            break;
                        case NPC_DARKBANE:
                            switch (GetDifficulty())
                            {
                                case 0:
                                    essenceId = 65686;
                                    break;
                                case 1:
                                    essenceId = 67222;
                                    break;
                                case 2:
                                    essenceId = 67223;
                                    break;
                                case 3:
                                    essenceId = 67224;
                                    break;
                            }
                            break;
                    }

                    /*
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, essenceId))
                        me->CastSpell(target, me->GetEntry()==NPC_LIGHTBANE ? SPELL_LIGHT_TOUCH : SPELL_DARK_TOUCH, false);
                    events.Repeat(45s,50s);
                    */

                    GuidVector tList;
                    Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                    if (pList.getSize())
                    {
                        for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                            if (Player* plr = itr->GetSource())
                                if (Creature* sister = GetSister())
                                    if ((!me->GetVictim() || me->GetVictim()->GetGUID() != plr->GetGUID()) && (!sister->GetVictim() || sister->GetVictim()->GetGUID() != plr->GetGUID()) && plr->HasAura(essenceId))
                                        tList.push_back(plr->GetGUID());

                        if (!tList.empty())
                            if (Player* target = ObjectAccessor::GetPlayer(*me, tList[urand(0, tList.size() - 1)]))
                            {
                                me->CastSpell(target, me->GetEntry() == NPC_LIGHTBANE ? SPELL_LIGHT_TOUCH : SPELL_DARK_TOUCH, false);
                                events.Repeat(45s, 50s);
                                break;
                            }
                    }
                    events.Repeat(10s);
                }
                break;
            case EVENT_SPECIAL:
                {
                    uint8 s;
                    do s = urand(0, 3);
                    while( SpecialMask & (1 << s) && (SpecialMask & 0xF) != 0xF );
                    SpecialMask |= (1 << s);
                    switch (s)
                    {
                        case 0: // light vortex
                            me->CastSpell((Unit*)nullptr, SPELL_LIGHT_VORTEX, false);
                            Talk(EMOTE_VORTEX);
                            Talk(SAY_LIGHT);
                            if (Creature* twin = GetSister())
                                twin->AI()->Talk(SAY_LIGHT);
                            break;
                        case 1: // dark vortex
                            if (Creature* twin = GetSister())
                            {
                                twin->CastSpell((Unit*)nullptr, SPELL_DARK_VORTEX, false);
                                twin->AI()->Talk(EMOTE_VORTEX);
                                twin->AI()->Talk(SAY_NIGHT);
                                Talk(SAY_NIGHT);
                            }
                            break;
                        case 2: // light pact
                            Talk(EMOTE_TWINK_PACT);
                            Talk(SAY_TWINK_PACT);
                            if (Creature* twin = GetSister())
                            {
                                twin->AI()->Talk(SAY_TWINK_PACT);
                                twin->AI()->DoAction(-3);
                            }
                            me->CastSpell(me, SPELL_LIGHT_SHIELD, true);
                            me->CastSpell(me, SPELL_LIGHT_TWIN_PACT, false);
                            break;
                        case 3: // dark pact
                            if (Creature* twin = GetSister())
                            {
                                twin->AI()->Talk(EMOTE_TWINK_PACT);
                                twin->AI()->Talk(SAY_TWINK_PACT);
                                Talk(SAY_TWINK_PACT);
                                twin->CastSpell(twin, SPELL_DARK_SHIELD, true);
                                twin->CastSpell(twin, SPELL_DARK_TWIN_PACT, false);
                                DoAction(-3);
                            }
                            break;
                    }
                    if ((SpecialMask & 0xF) == 0xF )
                        SpecialMask = 0;
                    events.Repeat(45s);
                    events.DelayEventsToMax(15s, 1); // no touch of light/darkness during special abilities!
                }
                break;
            case EVENT_REMOVE_DUAL_WIELD:
                me->SetCanDualWield(false);

                break;
        }

        myDoMeleeAttackIfReady();
    }

    void JustDied(Unit* /*pKiller*/) override
    {
        DoAction(ACTION_DESPAWN_SUMMONS);
        Talk(SAY_DEATH);
        if (pInstance)
            pInstance->SetBossState(BOSS_TWIN_VALKYR, DONE);
        if (Creature* twin = GetSister())
            if (twin->IsAlive())
            {
                // she kills herself, so if no player hit her she has no tap and drops no loot
                if (!twin->hasLootRecipient())
                    if (Player* recipient = me->GetLootRecipient())
                    {
                        twin->LowerPlayerDamageReq(twin->GetMaxHealth());
                        twin->SetLootRecipient(recipient);
                    }
                twin->SetHealth(1);
                Unit::Kill(twin, twin);
            }
    }

    void JustSummoned(Creature* s) override
    {
        summons.Summon(s);
    }

    void SummonedCreatureDespawn(Creature* s) override
    {
        summons.Despawn(s);
    }

    void KilledUnit(Unit* who) override
    {
        if (who->IsPlayer())
        {
            Talk(SAY_KILL_PLAYER);
            if (Creature* twin = GetSister())
                twin->AI()->Talk(SAY_KILL_PLAYER);
        }
    }

    void EnterEvadeMode(EvadeReason /* why */) override
    {
        if (pInstance)
            pInstance->SetData(TYPE_FAILED, 0);
    }
};

class boss_eydis : public CreatureScript
{
public:
    boss_eydis() : CreatureScript("boss_eydis") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<boss_eydisAI>(pCreature);
    }

    struct boss_eydisAI : public boss_twin_valkyrAI
    {
        boss_eydisAI(Creature* pCreature) : boss_twin_valkyrAI(pCreature)
        {
            me->SetFlag(UNIT_FIELD_AURASTATE, 1 << (19 - 1));
            SetEquipmentSlots(false, EQUIP_MAIN_2, EQUIP_OFFHAND_2, EQUIP_RANGED_2);
            if (Creature* c = me->SummonCreature(NPC_DARK_ESSENCE, Locs[LOC_DARKESS_1]))
                boss_twin_valkyrAI::JustSummoned(c);
            if (Creature* c = me->SummonCreature(NPC_DARK_ESSENCE, Locs[LOC_DARKESS_2]))
                boss_twin_valkyrAI::JustSummoned(c);
        }

        void JustSummoned(Creature*  /*s*/) override {}
    };
};

class boss_fjola : public CreatureScript
{
public:
    boss_fjola() : CreatureScript("boss_fjola") {}

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<boss_fjolaAI>(pCreature);
    }

    struct boss_fjolaAI : public boss_twin_valkyrAI
    {
        boss_fjolaAI(Creature* pCreature) : boss_twin_valkyrAI(pCreature)
        {
            me->SetFlag(UNIT_FIELD_AURASTATE, 1 << (22 - 1));
            SetEquipmentSlots(false, EQUIP_MAIN_1, EQUIP_OFFHAND_1, EQUIP_RANGED_1);
            if (Creature* c = me->SummonCreature(NPC_LIGHT_ESSENCE, Locs[LOC_LIGHTESS_1]))
                boss_twin_valkyrAI::JustSummoned(c);
            if (Creature* c = me->SummonCreature(NPC_LIGHT_ESSENCE, Locs[LOC_LIGHTESS_2]))
                boss_twin_valkyrAI::JustSummoned(c);
        }

        // Orbs are summoned by the Bullet Stalkers and handed over by the instance's summon data
        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_CONCENTRATED_LIGHT || summon->GetEntry() == NPC_CONCENTRATED_DARK)
                boss_twin_valkyrAI::JustSummoned(summon);
        }
    };
};

// 34628 - Concentrated Darkness, 34630 - Concentrated Light
struct npc_concentrated_ball : public ScriptedAI
{
    npc_concentrated_ball(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        scheduler.CancelAll();
        me->SetReactState(REACT_PASSIVE);
        DoCastSelf(me->GetEntry() == NPC_CONCENTRATED_LIGHT ? SPELL_LIGHT_BALL_PASSIVE : SPELL_DARK_BALL_PASSIVE, true);
        scheduler.Schedule(2900ms, 3600ms, [this](TaskContext /*context*/)
        {
            MoveToRandomStalker();
        });
    }

    // Orbs roam from one Bullet Stalker of either colour to another until a player touches them
    void MoveToRandomStalker()
    {
        std::list<Creature*> stalkers;
        me->GetCreatureListWithEntryInGrid(stalkers, { NPC_BULLET_STALKER_DARK, NPC_BULLET_STALKER_LIGHT }, 200.0f);
        if (stalkers.empty())
            return;

        Creature* stalker = Acore::Containers::SelectRandomContainerElement(stalkers);
        me->GetMotionMaster()->MovePoint(POINT_BULLET_STALKER, stalker->GetPosition());
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE || id != POINT_BULLET_STALKER)
            return;

        scheduler.Schedule(0ms, 1300ms, [this](TaskContext /*context*/)
        {
            MoveToRandomStalker();
        });
    }

    // Unleashed Light/Dark kills the orb through Quiet Suicide; the corpse lingers briefly
    void JustDied(Unit* /*killer*/) override
    {
        scheduler.CancelAll();
        me->DespawnOrUnsummon(randtime(1s, 2600ms));
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }
};

class spell_valkyr_essence_aura : public AuraScript
{
    PrepareAuraScript(spell_valkyr_essence_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_POWERING_UP, SPELL_SURGE_OF_SPEED, SPELL_LIGHT_ESSENCE, SPELL_DARK_ESSENCE, SPELL_LIGHT_TOUCH, SPELL_DARK_TOUCH });
    }

    void HandleAfterEffectAbsorb(AuraEffect* /*aurEff*/, DamageInfo& /*dmgInfo*/, uint32& absorbAmount)
    {
        uint16 count = absorbAmount / 1000;
        if (!count || !GetOwner())
            return;

        if (SpellInfo const* se = GetAura()->GetSpellInfo())
            if (Unit* owner = GetOwner()->ToUnit())
            {
                uint32 auraId = 0;
                uint32 empoweredId = 0;
                switch (se->Id)
                {
                    case 65686:
                        auraId = 67590;
                        empoweredId = 65748;
                        break;
                    case 65684:
                        auraId = 67590;
                        empoweredId = 65724;
                        break;
                    case 67222:
                        auraId = 67602;
                        empoweredId = 65748;
                        break;
                    case 67176:
                        auraId = 67602;
                        empoweredId = 65724;
                        break;
                    case 67223:
                        auraId = 67603;
                        empoweredId = 65748;
                        break;
                    case 67177:
                        auraId = 67603;
                        empoweredId = 65724;
                        break;
                    case 67224:
                        auraId = 67604;
                        empoweredId = 65748;
                        break;
                    case 67178:
                        auraId = 67604;
                        empoweredId = 65724;
                        break;
                }
                if (!owner->HasAura(auraId))
                {
                    owner->CastSpell(owner, SPELL_POWERING_UP, true);
                    if (--count == 0)
                        return;
                }
                if (Aura* aur = owner->GetAura(auraId))
                {
                    if (aur->GetStackAmount() + count < 100 )
                    {
                        aur->ModStackAmount(count);

                        if (roll_chance_i(30)) // 30% chance to gain extra speed for collecting
                            owner->CastSpell(owner, SPELL_SURGE_OF_SPEED, true);
                    }
                    else
                    {
                        owner->CastSpell(owner, empoweredId, true);
                        aur->Remove();
                    }
                }
            }
    }

    // Taking an essence removes the other one and clears the Touch of its own colour, which can no longer harm the player
    void HandleAfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        bool const isLight = GetId() == sSpellMgr->GetSpellIdForDifficulty(SPELL_LIGHT_ESSENCE, target);
        target->RemoveAurasDueToSpell(sSpellMgr->GetSpellIdForDifficulty(isLight ? SPELL_DARK_ESSENCE : SPELL_LIGHT_ESSENCE, target));
        target->RemoveAurasDueToSpell(sSpellMgr->GetSpellIdForDifficulty(isLight ? SPELL_LIGHT_TOUCH : SPELL_DARK_TOUCH, target));
    }

    void Register() override
    {
        AfterEffectAbsorb += AuraEffectAbsorbFn(spell_valkyr_essence_aura::HandleAfterEffectAbsorb, EFFECT_0);
        AfterEffectApply += AuraEffectApplyFn(spell_valkyr_essence_aura::HandleAfterApply, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_valkyr_touch_aura : public AuraScript
{
    PrepareAuraScript(spell_valkyr_touch_aura);

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        Unit* caster = GetCaster();
        // Only the touched player takes damage, and the matching essence absorbs it
        Unit* target = GetTarget();
        if (!caster || !caster->GetMap()->IsHeroic() || !target->IsAlive() || target->HasSpiritOfRedemptionAura())
            return;

        int32 dmg = urand(2925, 3075) * (caster->GetMap()->GetDifficulty() - 1);
        uint32 damage = dmg;
        int32 resilienceReduction = damage;
        if (caster->CanApplyResilience())
            Unit::ApplyResilience(target, nullptr, &dmg, false, CR_CRIT_TAKEN_SPELL);
        resilienceReduction = damage - resilienceReduction;
        damage -= resilienceReduction;
        uint32 mitigated_damage = resilienceReduction;
        DamageInfo dmgInfo(caster, target, damage, GetSpellInfo(), GetSpellInfo()->GetSchoolMask(), DOT, mitigated_damage);
        Unit::CalcAbsorbResist(dmgInfo);
        uint32 absorb = dmgInfo.GetAbsorb();
        uint32 resist = dmgInfo.GetResist();
        damage = dmgInfo.GetDamage();
        Unit::DealDamageMods(target, damage, &absorb);
        int32 overkill = damage - target->GetHealth();
        if (overkill < 0)
            overkill = 0;
        SpellPeriodicAuraLogInfo pInfo(aurEff, damage, overkill, absorb, resist, 0.0f, false);
        target->SendPeriodicAuraLog(&pInfo);
        Unit::DealDamage(caster, target, damage, 0, DOT, GetSpellInfo()->GetSchoolMask(), GetSpellInfo(), true);
    }

    void HandleAfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            if (Creature* valkyr = caster->ToCreature())
                valkyr->AI()->Talk(EMOTE_TOUCH, GetTarget());
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_valkyr_touch_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        AfterEffectApply += AuraEffectApplyFn(spell_valkyr_touch_aura::HandleAfterApply, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

// 66312 - Light Ball Passive
// 66314 - Dark Ball Passive
class spell_valkyr_ball_passive : public SpellScript
{
    PrepareSpellScript(spell_valkyr_ball_passive);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_UNLEASHED_LIGHT, SPELL_UNLEASHED_DARK });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        // The first player hit already made the orb explode and die
        Unit* caster = GetCaster();
        if (!caster->IsAlive())
            return;

        caster->CastSpell(caster, GetSpellInfo()->Id == SPELL_LIGHT_BALL_PASSIVE_TRIGGER ? SPELL_UNLEASHED_LIGHT : SPELL_UNLEASHED_DARK, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_valkyr_ball_passive::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 66149, 68396 - Bullet Controller Periodic
class spell_valkyr_bullet_controller : public AuraScript
{
    PrepareAuraScript(spell_valkyr_bullet_controller);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BULLET_CONTROLLER_SUMMON_LIGHT, SPELL_BULLET_CONTROLLER_SUMMON_DARK });
    }

    void SummonBelowCap(uint32 summonSpellId, uint32 orbEntry)
    {
        Unit* controller = GetTarget();
        std::list<Creature*> orbs;
        controller->GetCreatureListWithEntryInGrid(orbs, orbEntry, 200.0f);
        if (std::count_if(orbs.begin(), orbs.end(), [](Creature const* orb) { return orb->IsAlive(); }) >= BULLET_CONTROLLER_ORB_CAP)
            return;

        controller->CastSpell(controller, summonSpellId, CastSpellExtraArgs(TRIGGERED_FULL_MASK).AddSpellMod(SPELLVALUE_MAX_TARGETS, 1));
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        SummonBelowCap(SPELL_BULLET_CONTROLLER_SUMMON_LIGHT, NPC_CONCENTRATED_LIGHT);
        SummonBelowCap(SPELL_BULLET_CONTROLLER_SUMMON_DARK, NPC_CONCENTRATED_DARK);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_valkyr_bullet_controller::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 66077, 67152, 67153, 67154 - Bullet Summon Trigger
class spell_valkyr_bullet_summon_trigger : public SpellScript
{
    PrepareSpellScript(spell_valkyr_bullet_summon_trigger);

    // The caster sets each effect's base points to the number of stalkers that summon an orb
    void HandleForceCast(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        int32 stalkerCount = GetEffectValue();
        if (stalkerCount <= 0)
            return;

        Unit* target = GetHitUnit();
        target->CastSpell(target, GetSpellInfo()->Effects[effIndex].TriggerSpell, CastSpellExtraArgs(TRIGGERED_FULL_MASK).AddSpellMod(SPELLVALUE_MAX_TARGETS, stalkerCount));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_valkyr_bullet_summon_trigger::HandleForceCast, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
        OnEffectHitTarget += SpellEffectFn(spell_valkyr_bullet_summon_trigger::HandleForceCast, EFFECT_1, SPELL_EFFECT_FORCE_CAST);
    }
};

// 67547 - Clear Val'kyr Essence
// 68084 - Clear Val'kyr Touch of Light/Dark
class spell_valkyr_clear_auras : public SpellScript
{
    PrepareSpellScript(spell_valkyr_clear_auras);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        // Each effect's base points hold the 10-player Normal id of an aura to remove
        for (SpellEffectInfo const& effect : GetSpellInfo()->GetEffects())
            if (uint32 spellId = effect.CalcValue())
                GetHitUnit()->RemoveAurasDueToSpell(sSpellMgr->GetSpellIdForDifficulty(spellId, GetCaster()));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_valkyr_clear_auras::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_twin_valkyr()
{
    new boss_fjola();
    new boss_eydis();
    RegisterTrialOfTheCrusaderCreatureAI(npc_concentrated_ball);
    RegisterSpellScript(spell_valkyr_essence_aura);
    RegisterSpellScript(spell_valkyr_touch_aura);
    RegisterSpellScript(spell_valkyr_ball_passive);
    RegisterSpellScript(spell_valkyr_bullet_controller);
    RegisterSpellScript(spell_valkyr_bullet_summon_trigger);
    RegisterSpellScript(spell_valkyr_clear_auras);
}
