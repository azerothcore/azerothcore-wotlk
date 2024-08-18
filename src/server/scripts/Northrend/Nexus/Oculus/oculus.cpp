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

#include "oculus.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "InstanceScript.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include <unordered_map>

enum Drakes
{
    SPELL_RIDE_RUBY_DRAKE_QUE               = 49463,
    SPELL_RIDE_AMBER_DRAKE_QUE              = 49459,
    SPELL_RIDE_EMERALD_DRAKE_QUE            = 49427,

    // Centrifuge Constructs
    SPELL_EMPOWERING_BLOWS                  = 50044,
    H_SPELL_EMPOWERING_BLOWS                = 59213,

    SPELL_AMBER_SHOCK_CHARGE                = 49836,
    SPELL_RUBY_EVASIVE_CHARGES              = 50241,

    // Common Drake
    SPELL_DRAKE_FLAG_VISUAL                 = 53797,
    SPELL_SOAR_TRIGGER                      = 50325,
    SPELL_SOAR_BUFF                         = 50024,
    SPELL_SCALE_STATS                       = 66667,
    // Ruby Drake
    SPELL_RUBY_EVASIVE_AURA                 = 50248,
    SPELL_RUBY_EVASIVE_MANEUVERS            = 50240,

    // Misc
    POINT_LAND                              = 2,
    POINT_TAKE_OFF                          = 3
};

enum DrakeGiverTexts
{
    GOSSIP_TEXTID_DRAKES                        = 13267,
    GOSSIP_TEXTID_BELGARISTRASZ1                = 12916,
    GOSSIP_TEXTID_BELGARISTRASZ2                = 13254,
    GOSSIP_TEXTID_VERDISA1                      = 12915,
    GOSSIP_TEXTID_VERDISA2                      = 13466,
    GOSSIP_TEXTID_VERDISA3                      = 13258,
    GOSSIP_TEXTID_ETERNOS1                      = 12917,
    GOSSIP_TEXTID_ETERNOS2                      = 13466,
    GOSSIP_TEXTID_ETERNOS3                      = 13256,
};

#define HAS_ESSENCE(a) ((a)->HasItemCount(ITEM_EMERALD_ESSENCE) || (a)->HasItemCount(ITEM_AMBER_ESSENCE) || (a)->HasItemCount(ITEM_RUBY_ESSENCE))

class npc_oculus_drakegiver : public CreatureScript
{
public:
    std::unordered_map<ObjectGuid, bool>openedMenu;

    npc_oculus_drakegiver() : CreatureScript("npc_oculus_drakegiver") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetOculusAI<npc_oculus_drakegiverAI>(creature);
    }

    struct  npc_oculus_drakegiverAI : public ScriptedAI {
        npc_oculus_drakegiverAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = me->GetInstanceScript();
            if (m_pInstance->GetData(DATA_DRAKOS) == DONE)
            {
                resetPosition = true;
                moved = true;
            }
            else {
                moved = false;
                resetPosition = false;
            }
            timer = 0;
        }

        InstanceScript* m_pInstance;
        bool resetPosition, moved;
        uint32 timer;

        void UpdateAI(uint32 diff) override
        {
            if (m_pInstance->GetData(DATA_DRAKOS) == DONE)
            {
                if (!moved)
                {
                    timer += diff;

                    if (timer > 3000)
                    {
                        moved = true;
                        me->SetWalk(true);
                        switch (me->GetEntry())
                        {
                        case NPC_VERDISA:
                            me->GetMotionMaster()->MovePoint(POINT_MOVE_DRAKES, VerdisaPOS);
                            break;
                        case NPC_BELGARISTRASZ:
                            me->GetMotionMaster()->MovePoint(POINT_MOVE_DRAKES, BelgaristraszPOS);
                            break;
                        case NPC_ETERNOS:
                            me->GetMotionMaster()->MovePoint(POINT_MOVE_DRAKES, EternosPOS);
                            break;
                        }
                    }
                }
                if (resetPosition)
                {
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                    switch (me->GetEntry())
                    {
                    case NPC_VERDISA:
                        me->SetPosition(VerdisaPOS);
                        break;
                    case NPC_BELGARISTRASZ:
                        me->SetPosition(BelgaristraszPOS);
                        break;
                    case NPC_ETERNOS:
                        me->SetPosition(EternosPOS);
                        break;
                    }
                    resetPosition = false;
                }
            }
        }

        void MovementInform(uint32 /*type*/, uint32 id) override
        {
            if (id != POINT_MOVE_DRAKES)
            {
                return;
            }

            if(me->GetEntry() == NPC_BELGARISTRASZ)
            {
                Talk(SAY_BELGARISTRASZ);
            }
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if(creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if(creature->GetInstanceScript()->GetData(DATA_DRAKOS) == DONE)
        {
            switch (creature->GetEntry())
            {
            case NPC_VERDISA:
                AddGossipItemFor(player, 9573, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                if (player->HasItemCount(ITEM_AMBER_ESSENCE))
                {
                    AddGossipItemFor(player, 9573, 2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                }
                else if (player->HasItemCount(ITEM_RUBY_ESSENCE))
                {
                    AddGossipItemFor(player, 9573, 3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                }
                else if (!player->HasItemCount(ITEM_EMERALD_ESSENCE))
                {
                    AddGossipItemFor(player, 9573, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                }
                AddGossipItemFor(player, 9573, 4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                SendGossipMenuFor(player, GOSSIP_TEXTID_VERDISA1, creature->GetGUID());
                break;
            case NPC_BELGARISTRASZ:
                if (HAS_ESSENCE(player))
                {
                    openedMenu[player->GetGUID()] = true;
                }

                if (!openedMenu[player->GetGUID()])
                {
                    AddGossipItemFor(player, 9708, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                    SendGossipMenuFor(player, GOSSIP_TEXTID_DRAKES, creature->GetGUID());
                }
                else
                {
                    OnGossipSelect(player, creature, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                }
                break;
            case NPC_ETERNOS:
                AddGossipItemFor(player, 9574, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                if (player->HasItemCount(ITEM_EMERALD_ESSENCE))
                {
                    AddGossipItemFor(player, 9574, 2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                }
                else if (player->HasItemCount(ITEM_RUBY_ESSENCE))
                {
                    AddGossipItemFor(player, 9574, 3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                }
                else if (!player->HasItemCount(ITEM_AMBER_ESSENCE))
                {
                    AddGossipItemFor(player, 9574, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                }
                AddGossipItemFor(player, 9574, 4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                SendGossipMenuFor(player, GOSSIP_TEXTID_ETERNOS1, creature->GetGUID());
                break;
            }
        }

        return true;
    }

    void StoreEssence(Player* player, uint32 itemId)
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, 1);
        if (msg == EQUIP_ERR_OK)
        {
            if (Item* item = player->StoreNewItem(dest, itemId, true))
            {
                player->SendNewItem(item, 1, true, true);
            }
        }
    }

    void RemoveEssence(Player* player, uint32 itemId)
    {
        player->DestroyItemCount(itemId, 1, true);
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction) override
    {
        ClearGossipMenuFor(player);
        switch(creature->GetEntry())
        {
        case NPC_VERDISA:
            switch(uiAction)
            {
            case GOSSIP_ACTION_INFO_DEF:
                SendGossipMenuFor(player, GOSSIP_TEXTID_VERDISA2, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 4:
                SendGossipMenuFor(player, GOSSIP_TEXTID_VERDISA3, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 1:
                RemoveEssence(player, ITEM_AMBER_ESSENCE);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                RemoveEssence(player, ITEM_RUBY_ESSENCE);
                break;
            }
            StoreEssence(player, ITEM_EMERALD_ESSENCE);
            CloseGossipMenuFor(player);
            break;
        case NPC_BELGARISTRASZ:
            switch(uiAction)
            {
            case GOSSIP_ACTION_INFO_DEF:
                openedMenu[player->GetGUID()] = true;
                if (player->HasItemCount(ITEM_AMBER_ESSENCE))
                {
                    AddGossipItemFor(player, 9575, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                }
                else if (player->HasItemCount(ITEM_EMERALD_ESSENCE))
                {
                    AddGossipItemFor(player, 9575, 2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                }
                else if (!player->HasItemCount(ITEM_RUBY_ESSENCE))
                {
                    AddGossipItemFor(player, 9575, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                }
                AddGossipItemFor(player, 9575, 3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                SendGossipMenuFor(player, GOSSIP_TEXTID_BELGARISTRASZ1, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 4:
                SendGossipMenuFor(player, GOSSIP_TEXTID_BELGARISTRASZ2, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 1:
                RemoveEssence(player, ITEM_AMBER_ESSENCE);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                RemoveEssence(player, ITEM_EMERALD_ESSENCE);
                break;
            }
            StoreEssence(player, ITEM_RUBY_ESSENCE);
            CloseGossipMenuFor(player);
            break;
        case NPC_ETERNOS:
            switch (uiAction)
            {
            case GOSSIP_ACTION_INFO_DEF:
                SendGossipMenuFor(player, GOSSIP_TEXTID_ETERNOS2, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 4:
                SendGossipMenuFor(player, GOSSIP_TEXTID_ETERNOS3, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 1:
                RemoveEssence(player, ITEM_EMERALD_ESSENCE);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                RemoveEssence(player, ITEM_RUBY_ESSENCE);
                break;
            }
            StoreEssence(player, ITEM_AMBER_ESSENCE);
            CloseGossipMenuFor(player);
            break;
        }

        return true;
    }
};

class npc_oculus_drake : public CreatureScript
{
public:
    npc_oculus_drake() : CreatureScript("npc_oculus_drake") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetOculusAI<npc_oculus_drakeAI>(creature);
    }

    struct npc_oculus_drakeAI : public VehicleAI
    {
        npc_oculus_drakeAI(Creature* creature) : VehicleAI(creature)
        {
            m_pInstance = me->GetInstanceScript();
            JustSummoned = true;
        }

        InstanceScript* m_pInstance;
        bool JustSummoned;
        uint16 despawnTimer;

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (summoner->GetTypeId() != TYPEID_PLAYER)
            {
                return;
            }

            if (m_pInstance->GetBossState(DATA_EREGOS) == IN_PROGRESS)
                if (Creature* eregos = me->FindNearestCreature(NPC_EREGOS, 450.0f, true))
                    eregos->DespawnOrUnsummon(); // On retail this kills abusive call of drake during engaged Eregos

            me->SetFacingToObject(summoner);

            switch (me->GetEntry())
            {
                case NPC_RUBY_DRAKE:
                    me->CastSpell(summoner->ToUnit(), SPELL_RIDE_RUBY_DRAKE_QUE);
                    break;
                case NPC_EMERALD_DRAKE:
                    me->CastSpell(summoner->ToUnit(), SPELL_RIDE_EMERALD_DRAKE_QUE);
                    break;
                case NPC_AMBER_DRAKE:
                    me->CastSpell(summoner->ToUnit(), SPELL_RIDE_AMBER_DRAKE_QUE);
                    break;
                default:
                    return;
            }

            Position pos = summoner->GetPosition();
            me->GetMotionMaster()->MovePoint(POINT_LAND, pos);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_LAND)
                me->SetDisableGravity(false); // Needed this for proper animation after spawn, the summon in air fall to ground bug leave no other option for now, if this isn't used the drake will only walk on move.
        }

        void PassengerBoarded(Unit* passenger, int8 /*seatid*/, bool add) override
        {
            //npcbot
            if (passenger->IsNPCBot() && add)
            {
                despawnTimer = 0;
                return;
            }
            //end npcbot

            if (passenger->GetTypeId() != TYPEID_PLAYER)
                return;

            if (add)
            {
                despawnTimer = 0;
            }
            else
            {
                me->DespawnOrUnsummon(2050);
                me->SetOrientation(2.5f);
                me->SetSpeedRate(MOVE_FLIGHT, 1.0f);
                Position pos = me->GetPosition();
                Position offset = { 10.0f, 10.0f, 12.0f, 0.0f };
                pos.RelocateOffset(offset);
                me->SetDisableGravity(true);
                me->GetMotionMaster()->MovePoint(POINT_TAKE_OFF, pos);
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            for( uint8 i = 0; i < 8; ++i )
                if( me->m_spells[i] == spell->Id )
                {
                    if( target && target->IsAlive() && !target->CanFly() && target->IsHostileTo(me) && !spell->IsTargetingArea())
                    {
                        if( Unit* charmer = me->GetCharmer() )
                            Unit::Kill(charmer, charmer, false);
                    }
                    break;
                }
        }

        void UpdateAI(uint32 diff) override
        {
            if (JustSummoned)
            {
                despawnTimer = 1;
                //npcbot
                if (Vehicle const* v = me->GetVehicleKit())
                    if (Unit const* passenger = v->GetPassenger(0))
                        if (passenger->IsNPCBot())
                            despawnTimer = 0;
                //end npcbot
                JustSummoned = false;
                if (m_pInstance)
                {
                    if (!m_pInstance->IsEncounterInProgress() || m_pInstance->GetData(DATA_EREGOS) == IN_PROGRESS)
                    {
                        if (me->GetVehicleKit() && me->IsSummon())
                            if (!me->GetVehicleKit()->GetPassenger(0))
                            {
                                if (m_pInstance->GetData(DATA_UROM) == DONE)
                                {
                                    switch (me->GetEntry())
                                    {
                                        case 27692:
                                            me->m_spells[5] = 50344;
                                            break;
                                        case 27755:
                                            me->m_spells[5] = 49592;
                                            break;
                                        case 27756:
                                            me->m_spells[5] = 50253;
                                            break;
                                    }
                                }
                            }
                    }
                    else
                    {
                        me->DespawnOrUnsummon(2050);
                        me->SetOrientation(2.5f);
                        me->SetSpeedRate(MOVE_FLIGHT, 1.0f);
                        Position pos = me->GetPosition();
                        Position offset = { 10.0f, 10.0f, 12.0f, 0.0f };
                        pos.RelocateOffset(offset);
                        me->SetDisableGravity(true);
                        me->GetMotionMaster()->MovePoint(POINT_TAKE_OFF, pos);
                        return;
                    }
                }
            }

            if (despawnTimer)
            {
                if (despawnTimer >= 5000)
                {
                    me->DespawnOrUnsummon(2050);
                    me->SetOrientation(2.5f);
                    Position pos = me->GetPosition();
                    Position offset = { 10.0f, 10.0f, 12.0f, 0.0f };
                    pos.RelocateOffset(offset);
                    return;
                }
                else
                    despawnTimer += diff;
            }

            VehicleAI::UpdateAI(diff);
        }
    };
};

class npc_centrifuge_construct : public CreatureScript
{
public:
    npc_centrifuge_construct() : CreatureScript("npc_centrifuge_construct") { }

    struct npc_centrifuge_constructAI : public ScriptedAI
    {
        npc_centrifuge_constructAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() override {}

        void JustEngagedWith(Unit* /*who*/) override
        {
            DoCast(IsHeroic() ? H_SPELL_EMPOWERING_BLOWS : SPELL_EMPOWERING_BLOWS);
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

        void DamageTaken(Unit* attacker, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (attacker)
            {
                Unit* player = attacker->GetCharmer();
                if (player && !player->IsInCombat())
                    player->SetInCombatWith(me);
            }
        }
    };
    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetOculusAI<npc_centrifuge_constructAI>(creature);
    }
};

// 49838 - Stop Time
class spell_oculus_stop_time_aura : public AuraScript
{
    PrepareAuraScript(spell_oculus_stop_time_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_AMBER_SHOCK_CHARGE });
    }

    void Apply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        Unit* target = GetTarget();
        for (uint32 i = 0; i < 5; ++i)
            caster->CastSpell(target, SPELL_AMBER_SHOCK_CHARGE, true);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_oculus_stop_time_aura::Apply, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
    }
};

// 50240 - Evasive Maneuvers
class spell_oculus_evasive_maneuvers_aura : public AuraScript
{
    PrepareAuraScript(spell_oculus_evasive_maneuvers_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_RUBY_EVASIVE_CHARGES });
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->RemoveAuraFromStack(SPELL_RUBY_EVASIVE_CHARGES);
        if (!GetTarget()->HasAura(SPELL_RUBY_EVASIVE_CHARGES))
            SetDuration(0);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_oculus_evasive_maneuvers_aura::HandleProc, EFFECT_2, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 49840 - Shock Lance
class spell_oculus_shock_lance : public SpellScript
{
    PrepareSpellScript(spell_oculus_shock_lance);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_AMBER_SHOCK_CHARGE });
    }

    void CalcDamage()
    {
        int32 damage = GetHitDamage();
        if (Unit* target = GetHitUnit())
            if (Aura* aura = target->GetAura(SPELL_AMBER_SHOCK_CHARGE, GetCaster()->GetGUID())) // shock charges from same caster
            {
                damage += aura->GetStackAmount() * 6525;
                aura->Remove();
            }

        SetHitDamage(damage);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_oculus_shock_lance::CalcDamage);
    }
};

// 49592 - Temporal Rift
class spell_oculus_temporal_rift_aura : public AuraScript
{
    PrepareAuraScript(spell_oculus_temporal_rift_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_AMBER_SHOCK_CHARGE });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();

        if (!damageInfo || !damageInfo->GetDamage())
        {
            return;
        }

        int32 amount = aurEff->GetAmount() + damageInfo->GetDamage();

        uint8 num = amount / 15000;
        if (amount >= 15000)
        {
            if (Unit* caster = GetCaster())
                for (uint8 i  = 0; i < num; ++i )
                    caster->CastSpell(GetTarget(), SPELL_AMBER_SHOCK_CHARGE, true);
        }

        const_cast<AuraEffect*>(aurEff)->SetAmount(amount - 15000 * num);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_oculus_temporal_rift_aura::HandleProc, EFFECT_2, SPELL_AURA_DUMMY);
    }
};

// 50341 - Touch the Nightmare
class spell_oculus_touch_the_nightmare : public SpellScript
{
    PrepareSpellScript(spell_oculus_touch_the_nightmare);

    void HandleDamageCalc(SpellEffIndex /*effIndex*/)
    {
        SetHitDamage(int32(GetCaster()->CountPctFromMaxHealth(30)));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_oculus_touch_the_nightmare::HandleDamageCalc, EFFECT_2, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

// 50344 - Dream Funnel
class spell_oculus_dream_funnel_aura : public AuraScript
{
    PrepareAuraScript(spell_oculus_dream_funnel_aura);

    void HandleEffectCalcAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& canBeRecalculated)
    {
        if (Unit* caster = GetCaster())
            amount = int32(caster->CountPctFromMaxHealth(5));

        canBeRecalculated = false;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_oculus_dream_funnel_aura::HandleEffectCalcAmount, EFFECT_0, SPELL_AURA_PERIODIC_HEAL);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_oculus_dream_funnel_aura::HandleEffectCalcAmount, EFFECT_2, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_oculus_call_ruby_emerald_amber_drake : public SpellScript
{
    PrepareSpellScript(spell_oculus_call_ruby_emerald_amber_drake);

    void SetDest(SpellDestination& dest)
    {
        // Adjust effect summon position
        Position const offset = { 0.0f, 0.0f, 12.0f, 0.0f };
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_oculus_call_ruby_emerald_amber_drake::SetDest, EFFECT_0, TARGET_DEST_CASTER_FRONT);
    }
};

class spell_oculus_ride_ruby_emerald_amber_drake_que_aura : public AuraScript
{
    PrepareAuraScript(spell_oculus_ride_ruby_emerald_amber_drake_que_aura);

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        // caster of the triggered spell is wrong for an unknown reason, handle it here correctly
        PreventDefaultAction();
        if (Unit* caster = GetCaster())
            GetTarget()->CastSpell(caster, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_oculus_ride_ruby_emerald_amber_drake_que_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_oculus_evasive_charges_aura : public AuraScript
{
    PrepareAuraScript(spell_oculus_evasive_charges_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_RUBY_EVASIVE_MANEUVERS });
    }

    void HandleOnEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->ModifyAuraState(AURA_STATE_UNKNOWN22, true);
    }

    void HandleOnEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
        {
            caster->RemoveAurasDueToSpell(SPELL_RUBY_EVASIVE_MANEUVERS);
            caster->ModifyAuraState(AURA_STATE_UNKNOWN22, false);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_oculus_evasive_charges_aura::HandleOnEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        OnEffectRemove += AuraEffectRemoveFn(spell_oculus_evasive_charges_aura::HandleOnEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_oculus_soar_aura : public AuraScript
{
    PrepareAuraScript(spell_oculus_soar_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SOAR_BUFF });
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        Unit* caster = GetCaster();

        if (!caster)
            return;

        if (!caster->getAttackers().empty())
        {
            if (caster->HasAura(SPELL_SOAR_BUFF))
                caster->RemoveAurasDueToSpell(SPELL_SOAR_BUFF);

            PreventDefaultAction();
            return;
        }

        if (!caster->HasAura(SPELL_SOAR_BUFF))
            caster->CastSpell(caster, SPELL_SOAR_BUFF, true);

        // We handle the health regen here, normal heal regen isn't working....
        if (caster->GetHealth() < caster->GetMaxHealth())
            caster->SetHealth(caster->GetHealth() + (uint32)((double)caster->GetMaxHealth() * 0.2));
    }

    void HandleOnEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();

        if (!caster)
            return;

        if (!caster->HasAura(SPELL_SOAR_BUFF))
            caster->CastSpell(caster, SPELL_SOAR_BUFF, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_oculus_soar_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        OnEffectApply += AuraEffectApplyFn(spell_oculus_soar_aura::HandleOnEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_oculus_rider_aura : public AuraScript
{
    PrepareAuraScript(spell_oculus_rider_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SOAR_TRIGGER, SPELL_RUBY_EVASIVE_AURA, SPELL_DRAKE_FLAG_VISUAL });
    }

    ObjectGuid _drakeGUID;

    void HandleOnEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        Creature* drake = caster->GetVehicleCreatureBase();

        if (!drake)
            return;

        switch (aurEff->GetEffIndex())
        {
            case EFFECT_1:
                _drakeGUID = drake->GetGUID();
                caster->AddAura(SPELL_DRAKE_FLAG_VISUAL, caster);
                caster->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                caster->RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);
                drake->CastSpell(drake, SPELL_SOAR_TRIGGER);
                if (drake->GetEntry() == NPC_RUBY_DRAKE)
                    drake->CastSpell(drake, SPELL_RUBY_EVASIVE_AURA);
                break;
            case EFFECT_2:
                caster->AddAura(SPELL_SCALE_STATS, drake);
                PreventDefaultAction();
                break;
        }
    }

    void HandleOnEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();

        if (!caster)
            return;

        Creature* drake = ObjectAccessor::GetCreature(*caster, _drakeGUID);

        if (drake)
        {
            drake->RemoveUnitFlag(UNIT_FLAG_POSSESSED);
            drake->RemoveAurasDueToSpell(GetId());
            drake->RemoveAurasDueToSpell(SPELL_SOAR_TRIGGER);
            drake->RemoveAurasDueToSpell(SPELL_RUBY_EVASIVE_AURA);
        }
        caster->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        caster->RemoveAurasDueToSpell(SPELL_DRAKE_FLAG_VISUAL);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_oculus_rider_aura::HandleOnEffectApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        OnEffectApply += AuraEffectApplyFn(spell_oculus_rider_aura::HandleOnEffectApply, EFFECT_2, SPELL_AURA_LINKED, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        OnEffectRemove += AuraEffectRemoveFn(spell_oculus_rider_aura::HandleOnEffectRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

class spell_oculus_drake_flag_aura : public AuraScript
{
    PrepareAuraScript(spell_oculus_drake_flag_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DRAKE_FLAG_VISUAL });
    }

    void HandleOnEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();

        if (!caster)
            return;

        Creature* drake = caster->GetVehicleCreatureBase();

        if (!drake)
        {
            caster->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            caster->RemoveAurasDueToSpell(SPELL_DRAKE_FLAG_VISUAL);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_oculus_drake_flag_aura::HandleOnEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

void AddSC_oculus()
{
    new npc_oculus_drakegiver();
    new npc_oculus_drake();
    new npc_centrifuge_construct();

    RegisterSpellScript(spell_oculus_stop_time_aura);
    RegisterSpellScript(spell_oculus_evasive_maneuvers_aura);
    RegisterSpellScript(spell_oculus_shock_lance);
    RegisterSpellScript(spell_oculus_temporal_rift_aura);
    RegisterSpellScript(spell_oculus_touch_the_nightmare);
    RegisterSpellScript(spell_oculus_dream_funnel_aura);
    RegisterSpellScript(spell_oculus_call_ruby_emerald_amber_drake);
    RegisterSpellScript(spell_oculus_ride_ruby_emerald_amber_drake_que_aura);
    RegisterSpellScript(spell_oculus_evasive_charges_aura);
    RegisterSpellScript(spell_oculus_soar_aura);
    RegisterSpellScript(spell_oculus_rider_aura);
    RegisterSpellScript(spell_oculus_drake_flag_aura);
}

