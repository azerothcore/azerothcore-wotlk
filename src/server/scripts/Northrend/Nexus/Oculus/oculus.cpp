/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "CombatAI.h"
#include "InstanceScript.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "oculus.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellScript.h"
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
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
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
            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
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

                if (openedMenu[player->GetGUID()] != true)
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

        void IsSummonedBy(Unit* summoner) override
        {
            if (m_pInstance->GetBossState(DATA_EREGOS) == IN_PROGRESS)
                if (Creature* eregos = me->FindNearestCreature(NPC_EREGOS, 450.0f, true))
                    eregos->DespawnOrUnsummon(); // On retail this kills abusive call of drake during engaged Eregos

            me->SetFacingToObject(summoner);

            switch (me->GetEntry())
            {
                case NPC_RUBY_DRAKE:
                    me->CastSpell(summoner, SPELL_RIDE_RUBY_DRAKE_QUE);
                    break;
                case NPC_EMERALD_DRAKE:
                    me->CastSpell(summoner, SPELL_RIDE_EMERALD_DRAKE_QUE);
                    break;
                case NPC_AMBER_DRAKE:
                    me->CastSpell(summoner, SPELL_RIDE_AMBER_DRAKE_QUE);
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

        void EnterCombat(Unit* /*who*/) override
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
class spell_oculus_stop_time : public SpellScriptLoader
{
public:
    spell_oculus_stop_time() : SpellScriptLoader("spell_oculus_stop_time") { }

    class spell_oculus_stop_time_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_oculus_stop_time_AuraScript);

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
            AfterEffectApply += AuraEffectApplyFn(spell_oculus_stop_time_AuraScript::Apply, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_oculus_stop_time_AuraScript();
    }
};

// 50240 - Evasive Maneuvers
class spell_oculus_evasive_maneuvers : public SpellScriptLoader
{
public:
    spell_oculus_evasive_maneuvers() : SpellScriptLoader("spell_oculus_evasive_maneuvers") { }

    class spell_oculus_evasive_maneuvers_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_oculus_evasive_maneuvers_AuraScript);

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
            OnEffectProc += AuraEffectProcFn(spell_oculus_evasive_maneuvers_AuraScript::HandleProc, EFFECT_2, SPELL_AURA_PROC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_oculus_evasive_maneuvers_AuraScript();
    }
};

// 49840 - Shock Lance
class spell_oculus_shock_lance : public SpellScriptLoader
{
public:
    spell_oculus_shock_lance() : SpellScriptLoader("spell_oculus_shock_lance") { }

    class spell_oculus_shock_lance_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_oculus_shock_lance_SpellScript);

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
            OnHit += SpellHitFn(spell_oculus_shock_lance_SpellScript::CalcDamage);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_oculus_shock_lance_SpellScript();
    }
};

// 49592 - Temporal Rift
class spell_oculus_temporal_rift : public SpellScriptLoader
{
public:
    spell_oculus_temporal_rift() : SpellScriptLoader("spell_oculus_temporal_rift") { }

    class spell_oculus_temporal_rift_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_oculus_temporal_rift_AuraScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo({ SPELL_AMBER_SHOCK_CHARGE });
        }

        void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
        {
            PreventDefaultAction();
            int32 amount = aurEff->GetAmount() + eventInfo.GetDamageInfo()->GetDamage();

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
            OnEffectProc += AuraEffectProcFn(spell_oculus_temporal_rift_AuraScript::HandleProc, EFFECT_2, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_oculus_temporal_rift_AuraScript();
    }
};

// 50341 - Touch the Nightmare
class spell_oculus_touch_the_nightmare : public SpellScriptLoader
{
public:
    spell_oculus_touch_the_nightmare() : SpellScriptLoader("spell_oculus_touch_the_nightmare") { }

    class spell_oculus_touch_the_nightmare_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_oculus_touch_the_nightmare_SpellScript);

        void HandleDamageCalc(SpellEffIndex /*effIndex*/)
        {
            SetHitDamage(int32(GetCaster()->CountPctFromMaxHealth(30)));
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_oculus_touch_the_nightmare_SpellScript::HandleDamageCalc, EFFECT_2, SPELL_EFFECT_SCHOOL_DAMAGE);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_oculus_touch_the_nightmare_SpellScript();
    }
};

// 50344 - Dream Funnel
class spell_oculus_dream_funnel : public SpellScriptLoader
{
public:
    spell_oculus_dream_funnel() : SpellScriptLoader("spell_oculus_dream_funnel") { }

    class spell_oculus_dream_funnel_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_oculus_dream_funnel_AuraScript);

        void HandleEffectCalcAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& canBeRecalculated)
        {
            if (Unit* caster = GetCaster())
                amount = int32(caster->CountPctFromMaxHealth(5));

            canBeRecalculated = false;
        }

        void Register() override
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_oculus_dream_funnel_AuraScript::HandleEffectCalcAmount, EFFECT_0, SPELL_AURA_PERIODIC_HEAL);
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_oculus_dream_funnel_AuraScript::HandleEffectCalcAmount, EFFECT_2, SPELL_AURA_PERIODIC_DAMAGE);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_oculus_dream_funnel_AuraScript();
    }
};

class spell_oculus_call_ruby_emerald_amber_drake : public SpellScriptLoader
{
public:
    spell_oculus_call_ruby_emerald_amber_drake() : SpellScriptLoader("spell_oculus_call_ruby_emerald_amber_drake") { }

    class spell_oculus_call_ruby_emerald_amber_drake_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_oculus_call_ruby_emerald_amber_drake_SpellScript);

        void SetDest(SpellDestination& dest)
        {
            // Adjust effect summon position
            Position const offset = { 0.0f, 0.0f, 12.0f, 0.0f };
            dest.RelocateOffset(offset);
        }

        void Register() override
        {
            OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_oculus_call_ruby_emerald_amber_drake_SpellScript::SetDest, EFFECT_0, TARGET_DEST_CASTER_FRONT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_oculus_call_ruby_emerald_amber_drake_SpellScript();
    }
};

class spell_oculus_ride_ruby_emerald_amber_drake_que : public SpellScriptLoader
{
public:
    spell_oculus_ride_ruby_emerald_amber_drake_que() : SpellScriptLoader("spell_oculus_ride_ruby_emerald_amber_drake_que") { }

    class spell_oculus_ride_ruby_emerald_amber_drake_que_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_oculus_ride_ruby_emerald_amber_drake_que_AuraScript);

        void HandlePeriodic(AuraEffect const* aurEff)
        {
            // caster of the triggered spell is wrong for an unknown reason, handle it here correctly
            PreventDefaultAction();
            if (Unit* caster = GetCaster())
                GetTarget()->CastSpell(caster, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_oculus_ride_ruby_emerald_amber_drake_que_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_oculus_ride_ruby_emerald_amber_drake_que_AuraScript();
    }
};

class spell_oculus_evasive_charges : public SpellScriptLoader
{
public:
    spell_oculus_evasive_charges() : SpellScriptLoader("spell_oculus_evasive_charges") { }

    class spell_oculus_evasive_chargesAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_oculus_evasive_chargesAuraScript);

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
            OnEffectApply += AuraEffectApplyFn(spell_oculus_evasive_chargesAuraScript::HandleOnEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            OnEffectRemove += AuraEffectRemoveFn(spell_oculus_evasive_chargesAuraScript::HandleOnEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_oculus_evasive_chargesAuraScript();
    }
};

class spell_oculus_soar : public SpellScriptLoader
{
public:
    spell_oculus_soar() : SpellScriptLoader("spell_oculus_soar") { }

    class spell_oculus_soarAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_oculus_soarAuraScript);

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
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_oculus_soarAuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            OnEffectApply += AuraEffectApplyFn(spell_oculus_soarAuraScript::HandleOnEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_oculus_soarAuraScript();
    }
};

class spell_oculus_rider_aura : public SpellScriptLoader
{
public:
    spell_oculus_rider_aura() : SpellScriptLoader("spell_oculus_rider_aura") { }

    class spell_oculus_rider_auraAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_oculus_rider_auraAuraScript);

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
                    caster->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
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
                drake->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_POSSESSED);
                drake->RemoveAurasDueToSpell(GetId());
                drake->RemoveAurasDueToSpell(SPELL_SOAR_TRIGGER);
                drake->RemoveAurasDueToSpell(SPELL_RUBY_EVASIVE_AURA);
            }
            caster->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            caster->RemoveAurasDueToSpell(SPELL_DRAKE_FLAG_VISUAL);
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_oculus_rider_auraAuraScript::HandleOnEffectApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            OnEffectApply += AuraEffectApplyFn(spell_oculus_rider_auraAuraScript::HandleOnEffectApply, EFFECT_2, SPELL_AURA_LINKED, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            OnEffectRemove += AuraEffectRemoveFn(spell_oculus_rider_auraAuraScript::HandleOnEffectRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_oculus_rider_auraAuraScript();
    }
};

class spell_oculus_drake_flag : public SpellScriptLoader
{
public:
    spell_oculus_drake_flag() : SpellScriptLoader("spell_oculus_drake_flag") { }

    class spell_oculus_drake_flagAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_oculus_drake_flagAuraScript);

        void HandleOnEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* caster = GetCaster();

            if (!caster)
                return;

            Creature* drake = caster->GetVehicleCreatureBase();

            if (!drake)
            {
                caster->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                caster->RemoveAurasDueToSpell(SPELL_DRAKE_FLAG_VISUAL);
            }
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_oculus_drake_flagAuraScript::HandleOnEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_oculus_drake_flagAuraScript();
    }
};

void AddSC_oculus()
{
    new npc_oculus_drakegiver();
    new npc_oculus_drake();
    new npc_centrifuge_construct();

    new spell_oculus_stop_time();
    new spell_oculus_evasive_maneuvers();
    new spell_oculus_shock_lance();
    new spell_oculus_temporal_rift();
    new spell_oculus_touch_the_nightmare();
    new spell_oculus_dream_funnel();
    new spell_oculus_call_ruby_emerald_amber_drake();
    new spell_oculus_ride_ruby_emerald_amber_drake_que();
    new spell_oculus_evasive_charges();
    new spell_oculus_soar();
    new spell_oculus_rider_aura();
    new spell_oculus_drake_flag();
}
