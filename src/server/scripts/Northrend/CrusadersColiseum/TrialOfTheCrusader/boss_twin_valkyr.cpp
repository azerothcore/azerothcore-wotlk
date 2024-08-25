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
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "trial_of_the_crusader.h"
/*
    (!) ACTUALLY FJOLA CONTROLLS THE WHOLE FIGHT (SPECIAL ABILITIES, SHARED HEALTH, ETC.) SINCE THEY DIE SIMULTANEOUSLY
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
    NPC_DARK_ESSENCE      = 34567,
    NPC_LIGHT_ESSENCE     = 34568,
    NPC_CONCENTRATED_DARK = 34628,
    NPC_CONCENTRATED_LIGHT = 34630,
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
};

enum ValkyrEvents
{
    EVENT_BERSERK = 1,
    EVENT_SUMMON_BALLS_1,
    EVENT_SUMMON_BALLS_2,
    EVENT_SUMMON_BALLS_3,
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
        me->SetModifierValue(UNIT_MOD_DAMAGE_OFFHAND, TOTAL_PCT, 1.0f);
        me->UpdateDamagePhysical(OFF_ATTACK);
        LastSynchroHP = (int32)me->GetMaxHealth();
        SpecialMask = 0;
        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_HASTE_SPELLS, true);

        events.Reset();
        if( me->GetEntry() == NPC_LIGHTBANE )
        {
            if( pInstance )
                pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, 21853);

            // special events here
            events.RescheduleEvent(EVENT_BERSERK, IsHeroic() ? 6min : 10min);
            events.RescheduleEvent(EVENT_SUMMON_BALLS_1, 10s, 15s);
            events.RescheduleEvent(EVENT_SPECIAL, 45s);
        }
        events.RescheduleEvent(EVENT_SPELL_SPIKE, 5s, 8s);
        if( IsHeroic() )
            events.RescheduleEvent(EVENT_SPELL_TOUCH, 10s, 25s, 1);

        me->SetCanFly(true);
        me->SetDisableGravity(true);
    }

    InstanceScript* pInstance;
    SummonList summons;
    EventMap events;
    int32 LastSynchroHP;
    uint8 SpecialMask;

    void DoAction(int32 a) override
    {
        switch( a )
        {
            case -1:
                summons.DespawnAll();
                if( pInstance && me->GetEntry() == NPC_LIGHTBANE )
                {
                    uint32 essenceId1 = 0, empoweredId1 = 0, touchId1 = 0, essenceId2 = 0, empoweredId2 = 0, touchId2 = 0;
                    switch( me->GetMap()->GetDifficulty() )
                    {
                        case 0:
                            essenceId1 = 65684;
                            empoweredId1 = 65724;
                            touchId1 = 65950;
                            essenceId2 = 65686;
                            empoweredId2 = 65748;
                            touchId2 = 66001;
                            break;
                        case 1:
                            essenceId1 = 67176;
                            empoweredId1 = 67213;
                            touchId1 = 67296;
                            essenceId2 = 67222;
                            empoweredId2 = 67216;
                            touchId2 = 67281;
                            break;
                        case 2:
                            essenceId1 = 67177;
                            empoweredId1 = 67214;
                            touchId1 = 67297;
                            essenceId2 = 67223;
                            empoweredId2 = 67217;
                            touchId2 = 67282;
                            break;
                        case 3:
                            essenceId1 = 67178;
                            empoweredId1 = 67215;
                            touchId1 = 67298;
                            essenceId2 = 67224;
                            empoweredId2 = 67218;
                            touchId2 = 67283;
                            break;
                    }
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(essenceId1);
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(empoweredId1);
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(touchId1);
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(essenceId2);
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(empoweredId2);
                    pInstance->DoRemoveAurasDueToSpellOnPlayers(touchId2);
                }
                break;
            case -3:
                me->SetCanDualWield(true);
                me->CastSpell(me, SPELL_TWIN_POWER, true);
                events.RescheduleEvent(EVENT_REMOVE_DUAL_WIELD, 15s);
                break;
        }
    }

    Creature* GetSister()
    {
        return ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(me->GetEntry() == NPC_DARKBANE ? NPC_LIGHTBANE : NPC_DARKBANE));
    }

    /*void AttackStart(Unit* victim)
    {
        if( victim && me->Attack(victim, true) )
            me->GetMotionMaster()->MoveChase(victim, 0.0f, 0.0f, 6.0f);
    }*/

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->setActive(true);
        me->LowerPlayerDamageReq(me->GetMaxHealth());
        DoZoneInCombat();
        if( Creature* twin = GetSister() )
            if( !twin->IsInCombat() )
                if( Unit* target = twin->SelectNearestTarget(200.0f) )
                    twin->AI()->AttackStart(target);

        Talk(SAY_AGGRO);
        me->CastSpell(me, me->GetEntry() == NPC_LIGHTBANE ? SPELL_LIGHT_SURGE : SPELL_DARK_SURGE, true);

        if( pInstance && me->GetEntry() == NPC_LIGHTBANE )
            pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, 21853);
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

    void UpdateSharedHealth()
    {
        // lightbane synchronizes
        if( me->GetEntry() == NPC_LIGHTBANE )
            if( Creature* twin = GetSister() )
                if( twin->IsAlive() && me->IsAlive() )
                {
                    int32 d = CAST_AI(boss_twin_valkyrAI, twin->AI())->LastSynchroHP - (int32)twin->GetHealth();
                    int32 newhealth = (int32)me->GetHealth() - d;
                    if( newhealth <= 0 )
                        newhealth = 1;
                    me->SetHealth( (uint32)newhealth );
                    twin->SetHealth(me->GetHealth());
                    CAST_AI(boss_twin_valkyrAI, twin->AI())->LastSynchroHP = (int32)twin->GetHealth();
                }
    }

    void UpdateAI(uint32 diff) override
    {
        if( !UpdateVictim() )
            return;

        UpdateSharedHealth();
        events.Update(diff);

        if( me->HasUnitState(UNIT_STATE_CASTING) )
            return;

        uint8 eventId = events.ExecuteEvent();

        switch(eventId)
        {
            case 0:
                break;
            case EVENT_BERSERK:
                me->CastSpell(me, SPELL_BERSERK, true);
                Talk(SAY_BERSERK);
                if( Creature* twin = GetSister() )
                {
                    twin->CastSpell(twin, SPELL_BERSERK, true);
                    twin->AI()->Talk(SAY_BERSERK);
                }

                break;
            case EVENT_SUMMON_BALLS_1:
            case EVENT_SUMMON_BALLS_2:
            case EVENT_SUMMON_BALLS_3:
                {
                    uint8 count = 0;
                    if( IsHeroic() )
                        count = eventId == EVENT_SUMMON_BALLS_3 ? 36 : 6;
                    else
                        count = eventId == EVENT_SUMMON_BALLS_3 ? 24 : 4;
                    for( uint8 i = 0; i < count; ++i )
                    {
                        float angle = rand_norm() * 2 * M_PI;
                        if( Creature* ball = me->SummonCreature((i % 2) ? NPC_CONCENTRATED_DARK : NPC_CONCENTRATED_LIGHT, Locs[LOC_CENTER].GetPositionX() + cos(angle) * 47.0f, Locs[LOC_CENTER].GetPositionY() + std::sin(angle) * 47.0f, Locs[LOC_CENTER].GetPositionZ() + 1.5f, 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 1500) )
                            boss_twin_valkyrAI::JustSummoned(ball);
                    }

                    switch( eventId )
                    {
                        case EVENT_SUMMON_BALLS_1:
                            events.RescheduleEvent(EVENT_SUMMON_BALLS_2, 8s);
                            break;
                        case EVENT_SUMMON_BALLS_2:
                            events.RescheduleEvent(EVENT_SUMMON_BALLS_3, 8s);
                            break;
                        case EVENT_SUMMON_BALLS_3:
                            events.RescheduleEvent(EVENT_SUMMON_BALLS_1, 15s);
                            break;
                    }
                }
                break;
            case EVENT_SPELL_SPIKE:
                me->CastSpell(me->GetVictim(), me->GetEntry() == NPC_LIGHTBANE ? SPELL_LIGHT_TWIN_SPIKE : SPELL_DARK_TWIN_SPIKE, false);
                events.Repeat(7s, 10s);
                break;
            case EVENT_SPELL_TOUCH:
                {
                    uint32 essenceId = 0;
                    switch( me->GetEntry() )
                    {
                        case NPC_LIGHTBANE:
                            switch( GetDifficulty() )
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
                            switch( GetDifficulty() )
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
                    if( Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, essenceId) )
                        me->CastSpell(target, me->GetEntry()==NPC_LIGHTBANE ? SPELL_LIGHT_TOUCH : SPELL_DARK_TOUCH, false);
                    events.RepeatEvent(urand(45000,50000));
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
                    switch( s )
                    {
                        case 0: // light vortex
                            me->CastSpell((Unit*)nullptr, SPELL_LIGHT_VORTEX, false);
                            Talk(EMOTE_VORTEX);
                            Talk(SAY_LIGHT);
                            if( Creature* twin = GetSister() )
                                twin->AI()->Talk(SAY_LIGHT);
                            break;
                        case 1: // dark vortex
                            if( Creature* twin = GetSister() )
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
                            if( Creature* twin = GetSister() )
                            {
                                twin->AI()->Talk(SAY_TWINK_PACT);
                                twin->AI()->DoAction(-3);
                            }
                            me->CastSpell(me, SPELL_LIGHT_SHIELD, true);
                            me->CastSpell(me, SPELL_LIGHT_TWIN_PACT, false);
                            break;
                        case 3: // dark pact
                            if( Creature* twin = GetSister() )
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
                    if( (SpecialMask & 0xF) == 0xF )
                        SpecialMask = 0;
                    events.Repeat(45s);
                    events.DelayEventsToMax(15000, 1); // no touch of light/darkness during special abilities!
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
        DoAction(-1);
        Talk(SAY_DEATH);
        if( pInstance )
        {
            pInstance->SetData(TYPE_VALKYR, DONE);
            pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_POWERING_UP);
        }
        if( Creature* twin = GetSister() )
            if( twin->IsAlive() )
            {
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
        if( who->IsPlayer() )
        {
            Talk(SAY_KILL_PLAYER);
            if( Creature* twin = GetSister() )
                twin->AI()->Talk(SAY_KILL_PLAYER);
        }
    }

    void EnterEvadeMode(EvadeReason /* why */) override
    {
        if( pInstance )
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
            if( Creature* c = me->SummonCreature(NPC_DARK_ESSENCE, Locs[LOC_DARKESS_1]) )
                boss_twin_valkyrAI::JustSummoned(c);
            if( Creature* c = me->SummonCreature(NPC_DARK_ESSENCE, Locs[LOC_DARKESS_2]) )
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
            if( Creature* c = me->SummonCreature(NPC_LIGHT_ESSENCE, Locs[LOC_LIGHTESS_1]) )
                boss_twin_valkyrAI::JustSummoned(c);
            if( Creature* c = me->SummonCreature(NPC_LIGHT_ESSENCE, Locs[LOC_LIGHTESS_2]) )
                boss_twin_valkyrAI::JustSummoned(c);
        }

        void JustSummoned(Creature*  /*s*/) override {}
    };
};

class npc_essence_of_twin : public CreatureScript
{
public:
    npc_essence_of_twin() : CreatureScript("npc_essence_of_twin") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        switch( creature->GetEntry() )
        {
            case NPC_LIGHT_ESSENCE:
                {
                    uint32 essenceId = 0;
                    uint32 effect2Id = 0;
                    //uint32 empoweredId = 0;
                    uint32 touchId1 = 0;
                    //uint32 touchId2 = 0;
                    switch( creature->GetMap()->GetDifficulty() )
                    {
                        case 0:
                            essenceId = 65684;
                            //empoweredId = 65724;
                            touchId1 = 65950;
                            //touchId2 = 66001;
                            effect2Id = 65827;
                            break;
                        case 1:
                            essenceId = 67176;
                            //empoweredId = 67213;
                            touchId1 = 67296;
                            //touchId2 = 67281;
                            effect2Id = 67179;
                            break;
                        case 2:
                            essenceId = 67177;
                            //empoweredId = 67214;
                            touchId1 = 67297;
                            //touchId2 = 67282;
                            effect2Id = 67180;
                            break;
                        case 3:
                            essenceId = 67178;
                            //empoweredId = 67215;
                            touchId1 = 67298;
                            //touchId2 = 67283;
                            effect2Id = 67181;
                            break;
                    }
                    player->RemoveAura(essenceId);
                    player->RemoveAura(effect2Id);
                    player->RemoveAura(touchId1);
                    //player->RemoveAura(touchId2); // dont remove black touch here - only white can have black touch - so white changing to white - so no change of color
                    //player->RemoveAura(empoweredId); // apply new empowered?
                    player->CastSpell(player, SPELL_LIGHT_ESSENCE, true);
                }
                break;
            case NPC_DARK_ESSENCE:
                {
                    uint32 essenceId = 0;
                    uint32 effect2Id = 0;
                    //uint32 empoweredId = 0;
                    //uint32 touchId1 = 0;
                    uint32 touchId2 = 0;
                    switch( creature->GetMap()->GetDifficulty() )
                    {
                        case 0:
                            essenceId = 65686;
                            //empoweredId = 65748;
                            //touchId1 = 65950;
                            touchId2 = 66001;
                            effect2Id = 65811;
                            break;
                        case 1:
                            essenceId = 67222;
                            //empoweredId = 67216;
                            //touchId1 = 67296;
                            touchId2 = 67281;
                            effect2Id = 67511;
                            break;
                        case 2:
                            essenceId = 67223;
                            //empoweredId = 67217;
                            //touchId1 = 67297;
                            touchId2 = 67282;
                            effect2Id = 67512;
                            break;
                        case 3:
                            essenceId = 67224;
                            //empoweredId = 67218;
                            //touchId1 = 67298;
                            touchId2 = 67283;
                            effect2Id = 67513;
                            break;
                    }
                    player->RemoveAura(essenceId);
                    player->RemoveAura(effect2Id);
                    //player->RemoveAura(touchId1); // dont remove white touch here - only black can have white touch - so black changing to black - so no change of color
                    player->RemoveAura(touchId2);
                    //player->RemoveAura(empoweredId); // apply new empowered?
                    player->CastSpell(player, SPELL_DARK_ESSENCE, true);
                }
                break;
            default:
                break;
        }
        CloseGossipMenuFor(player);
        return true;
    }
};

class npc_concentrated_ball : public CreatureScript
{
public:
    npc_concentrated_ball() : CreatureScript("npc_concentrated_ball") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetTrialOfTheCrusaderAI<npc_concentrated_ballAI>(pCreature);
    }

    struct npc_concentrated_ballAI : public NullCreatureAI
    {
        npc_concentrated_ballAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetCanFly(true);
            me->SetDisableGravity(true);
            me->CastSpell(me, 100101, true); // custom periodic dummy spell
            despawning = false;
        }

        bool despawning;

        void DoAction(int32 param) override
        {
            if (param == 1)
                despawning = true;
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if( type != POINT_MOTION_TYPE || id != 0 )
                return;

            if( urand(0, 2) )
                me->DespawnOrUnsummon(0);
        }

        void MoveToNextPoint()
        {
            float angle = rand_norm() * 2 * M_PI;
            me->GetMotionMaster()->MovePoint(0, Locs[LOC_CENTER].GetPositionX() + cos(angle) * 47.0f, Locs[LOC_CENTER].GetPositionY() + std::sin(angle) * 47.0f, me->GetPositionZ());
        }

        void UpdateAI(uint32  /*diff*/) override
        {
            if( despawning )
                return;

            if( me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE )
                MoveToNextPoint();
        }
    };
};

class spell_valkyr_essence : public SpellScriptLoader
{
public:
    spell_valkyr_essence() : SpellScriptLoader("spell_valkyr_essence") { }

    class spell_valkyr_essence_auraAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_valkyr_essence_auraAuraScript)

        void HandleAfterEffectAbsorb(AuraEffect* /*aurEff*/, DamageInfo& /*dmgInfo*/, uint32& absorbAmount)
        {
            uint16 count = absorbAmount / 1000;
            if( !count || !GetOwner() )
                return;

            if( SpellInfo const* se = GetAura()->GetSpellInfo() )
                if( Unit* owner = GetOwner()->ToUnit() )
                {
                    uint32 auraId = 0;
                    uint32 empoweredId = 0;
                    switch( se->Id )
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
                    if( !owner->HasAura(auraId) )
                    {
                        owner->CastSpell(owner, SPELL_POWERING_UP, true);
                        if( --count == 0 )
                            return;
                    }
                    if( Aura* aur = owner->GetAura(auraId) )
                    {
                        if( aur->GetStackAmount() + count < 100 )
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

        void Register() override
        {
            AfterEffectAbsorb += AuraEffectAbsorbFn(spell_valkyr_essence_auraAuraScript::HandleAfterEffectAbsorb, EFFECT_0);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_valkyr_essence_auraAuraScript();
    }
};

class spell_valkyr_touch : public SpellScriptLoader
{
public:
    spell_valkyr_touch() : SpellScriptLoader("spell_valkyr_touch") { }

    class spell_valkyr_touchAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_valkyr_touchAuraScript)

        void HandleEffectPeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            Unit* caster = GetCaster();
            if( !caster )
                return;
            if( caster->GetMap()->GetId() == 649 )
            {
                uint32 excludedID = GetSpellInfo()->ExcludeTargetAuraSpell;
                Map::PlayerList const& pl = caster->GetMap()->GetPlayers();
                for( Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr )
                    if( Player* plr = itr->GetSource() )
                        if( plr->IsAlive() && !plr->HasAura(excludedID) && !plr->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION) )
                        {
                            uint32 absorb = 0;
                            uint32 resist = 0;
                            CleanDamage(0, 0, BASE_ATTACK, MELEE_HIT_NORMAL);
                            int32 dmg = urand(2925, 3075) * (caster->GetMap()->GetDifficulty() - 1);
                            uint32 damage = dmg;
                            int32 resilienceReduction = damage;
                            if (caster->CanApplyResilience())
                                Unit::ApplyResilience(plr, nullptr, &dmg, false, CR_CRIT_TAKEN_SPELL);
                            resilienceReduction = damage - resilienceReduction;
                            damage -= resilienceReduction;
                            uint32 mitigated_damage = resilienceReduction;
                            DamageInfo dmgInfo(caster, plr, damage, GetSpellInfo(), GetSpellInfo()->GetSchoolMask(), DOT, mitigated_damage);
                            Unit::CalcAbsorbResist(dmgInfo);
                            Unit::DealDamageMods(plr, damage, &absorb);
                            int32 overkill = damage - plr->GetHealth();
                            if (overkill < 0)
                                overkill = 0;
                            SpellPeriodicAuraLogInfo pInfo(aurEff, damage, overkill, absorb, resist, 0.0f, false);
                            plr->SendPeriodicAuraLog(&pInfo);
                            Unit::DealDamage(caster, plr, damage, 0, DOT, GetSpellInfo()->GetSchoolMask(), GetSpellInfo(), true);
                        }
            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_valkyr_touchAuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_valkyr_touchAuraScript();
    }
};

class spell_valkyr_ball_periodic_dummy : public SpellScriptLoader
{
public:
    spell_valkyr_ball_periodic_dummy() : SpellScriptLoader("spell_valkyr_ball_periodic_dummy") { }

    class spell_valkyr_ball_periodic_dummyAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_valkyr_ball_periodic_dummyAuraScript)

        void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
        {
            if (Unit* target = GetTarget())
                if (target->GetDisplayId() != 11686)
                    if (Creature* creature = target->ToCreature())
                        if (Player* player = creature->SelectNearestPlayer(2.75f))
                            if (creature->GetExactDist2d(player) <= 2.75f)
                            {
                                creature->AI()->DoAction(1); // despawning = true;
                                creature->GetMotionMaster()->MoveIdle();
                                creature->CastSpell((Unit*)nullptr, creature->GetEntry() == NPC_CONCENTRATED_LIGHT ? SPELL_UNLEASHED_LIGHT : SPELL_UNLEASHED_DARK, false);
                                creature->SetDisplayId(11686);
                                creature->DespawnOrUnsummon(1500);
                            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_valkyr_ball_periodic_dummyAuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_valkyr_ball_periodic_dummyAuraScript();
    }
};

void AddSC_boss_twin_valkyr()
{
    new boss_fjola();
    new boss_eydis();
    new npc_essence_of_twin();
    new npc_concentrated_ball();
    new spell_valkyr_essence();
    new spell_valkyr_touch();
    new spell_valkyr_ball_periodic_dummy();
}
