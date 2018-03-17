/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "oculus.h"
#include "Vehicle.h"
#include "CombatAI.h"
#include "Player.h"
#include "SpellInfo.h"

enum DrakeGiverTexts
{
    GOSSIP_TEXTID_DRAKES                        = 13267,
    GOSSIP_TEXTID_BELGARISTRASZ1                = 12916,
    GOSSIP_TEXTID_BELGARISTRASZ2                = 13466,
    GOSSIP_TEXTID_BELGARISTRASZ3                = 13254,
    GOSSIP_TEXTID_VERDISA1                      = 1,
    GOSSIP_TEXTID_VERDISA2                      = 1,
    GOSSIP_TEXTID_VERDISA3                      = 1,
    GOSSIP_TEXTID_ETERNOS1                      = 1,
    GOSSIP_TEXTID_ETERNOS2                      = 1,
    GOSSIP_TEXTID_ETERNOS3                      = 13256,
};

#define GOSSIP_ITEM_DRAKES          "So where do we go from here?"
#define GOSSIP_ITEM_BELGARISTRASZ1  "I want to fly on the wings of the Red Flight"
#define GOSSIP_ITEM_BELGARISTRASZ2  "What abilities do Ruby Drakes have?"
#define GOSSIP_ITEM_VERDISA1        "I want to fly on the wings of the Green Flight"
#define GOSSIP_ITEM_VERDISA2        "What abilities do Emerald Drakes have?"
#define GOSSIP_ITEM_ETERNOS1        "I want to fly on the wings of the Bronze Flight"
#define GOSSIP_ITEM_ETERNOS2        "What abilities do Amber Drakes have?"

#define HAS_ESSENCE(a) ((a)->HasItemCount(ITEM_EMERALD_ESSENCE) || (a)->HasItemCount(ITEM_AMBER_ESSENCE) || (a)->HasItemCount(ITEM_RUBY_ESSENCE))


class npc_oculus_drakegiver : public CreatureScript
{
public:
    npc_oculus_drakegiver() : CreatureScript("npc_oculus_drakegiver") { }

    bool OnGossipHello(Player* pPlayer, Creature* pCreature)
    {
        if( pCreature->IsQuestGiver() )
            pPlayer->PrepareQuestMenu(pCreature->GetGUID());

        if( pCreature->GetInstanceScript()->GetData(DATA_DRAKOS) == DONE )
        {
            pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_DRAKES, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_DRAKES, pCreature->GetGUID());
        }

        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 /*uiSender*/, uint32 uiAction)
    {
        pPlayer->PlayerTalkClass->GetGossipMenu().ClearMenu();
        switch(pCreature->GetEntry())
        {
        case NPC_VERDISA:
            switch(uiAction)
            {
            case GOSSIP_ACTION_INFO_DEF + 1:
                if (!HAS_ESSENCE(pPlayer))
                {
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_VERDISA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_VERDISA2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VERDISA1, pCreature->GetGUID());
                }
                else
                {
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_VERDISA2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VERDISA2, pCreature->GetGUID());
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
            {
                ItemPosCountVec dest;
                uint8 msg = pPlayer->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, ITEM_EMERALD_ESSENCE, 1);
                if (msg == EQUIP_ERR_OK)
                    pPlayer->StoreNewItem(dest, ITEM_EMERALD_ESSENCE, true);
                pPlayer->CLOSE_GOSSIP_MENU();
                break;
            }
            case GOSSIP_ACTION_INFO_DEF + 3:
                if (!HAS_ESSENCE(pPlayer))
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_VERDISA1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_VERDISA3, pCreature->GetGUID());
                break;
            }
            break;
        case NPC_BELGARISTRASZ:
            switch(uiAction)
            {
            case GOSSIP_ACTION_INFO_DEF + 1:
                if (!HAS_ESSENCE(pPlayer))
                {
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BELGARISTRASZ1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BELGARISTRASZ2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_BELGARISTRASZ1, pCreature->GetGUID());
                }
                else
                {
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BELGARISTRASZ2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_BELGARISTRASZ2, pCreature->GetGUID());
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
            {
                ItemPosCountVec dest;
                uint8 msg = pPlayer->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, ITEM_RUBY_ESSENCE, 1);
                if (msg == EQUIP_ERR_OK)
                    pPlayer->StoreNewItem(dest, ITEM_RUBY_ESSENCE, true);
                pPlayer->CLOSE_GOSSIP_MENU();
                break;
            }
            case GOSSIP_ACTION_INFO_DEF + 3:
                if (!HAS_ESSENCE(pPlayer))
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_BELGARISTRASZ1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_BELGARISTRASZ3, pCreature->GetGUID());
                break;
            }
            break;
        case NPC_ETERNOS:
            switch(uiAction)
            {
            case GOSSIP_ACTION_INFO_DEF + 1:
                if (!HAS_ESSENCE(pPlayer))
                {
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ETERNOS1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ETERNOS2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ETERNOS1, pCreature->GetGUID());
                }
                else
                {
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ETERNOS2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                    pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ETERNOS2, pCreature->GetGUID());
                }
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
            {
                ItemPosCountVec dest;
                uint8 msg = pPlayer->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, ITEM_AMBER_ESSENCE, 1);
                if (msg == EQUIP_ERR_OK)
                    pPlayer->StoreNewItem(dest, ITEM_AMBER_ESSENCE, true);
                pPlayer->CLOSE_GOSSIP_MENU();
                break;
            }
            case GOSSIP_ACTION_INFO_DEF + 3:
                if (!HAS_ESSENCE(pPlayer))
                    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_ETERNOS1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                pPlayer->SEND_GOSSIP_MENU(GOSSIP_TEXTID_ETERNOS3, pCreature->GetGUID());
                break;
            }
            break;
        }

        return true;
    }
};

class npc_oculus_drake : public CreatureScript
{
public:
    npc_oculus_drake() : CreatureScript("npc_oculus_drake") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_oculus_drakeAI (pCreature);
    }

    struct npc_oculus_drakeAI : public VehicleAI
    {
        npc_oculus_drakeAI(Creature *pCreature) : VehicleAI(pCreature)
        {
            m_pInstance = me->GetInstanceScript();
            JustSummoned = true;
        }

        InstanceScript* m_pInstance;
        bool JustSummoned;
        uint16 despawnTimer;

        void PassengerBoarded(Unit*  /*who*/, int8  /*seatid*/, bool add)
        {
            if (add)
            {
                me->SetDisableGravity(false);
                me->SendMovementFlagUpdate();
                despawnTimer = 0;
            }
            else
            {
                me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                me->DisappearAndDie();
                me->DespawnOrUnsummon(1);
            }
        }

        void JustDied(Unit*  /*killer*/)
        {
            me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
            me->DisappearAndDie();
            me->DespawnOrUnsummon(1);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell)
        {
            for( uint8 i = 0; i < 8; ++i )
                if( me->m_spells[i] == spell->Id )
                {
                    if( target && target->IsAlive() && !target->CanFly() && target->IsHostileTo(me) && !spell->IsTargetingArea())
                    {
                        me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                        if( Unit* charmer = me->GetCharmer() )
                            Unit::Kill(charmer, charmer, false);
                        me->DisappearAndDie();
                        me->DespawnOrUnsummon(1);
                    }
                    break;
                }
        }

        void UpdateAI(uint32 diff)
        {
            if( JustSummoned )
            {
                despawnTimer = 1;
                JustSummoned = false;
                if( m_pInstance )
                {
                    if( !m_pInstance->IsEncounterInProgress() || m_pInstance->GetData(DATA_EREGOS)==IN_PROGRESS )
                    {
                        if( me->GetVehicleKit() && me->IsSummon() )
                            if( !me->GetVehicleKit()->GetPassenger(0) )
                            {
                                TempSummon* ts = (TempSummon*)me;
                                if( Unit* summoner = ts->GetSummoner() )
                                {
                                    if( m_pInstance->GetData(DATA_UROM) == DONE )
                                    {
                                        switch( me->GetEntry() )
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

                                    uint32 spell = 0;
                                    switch (me->GetEntry())
                                    {
                                        case 27692: spell = 49427; break;
                                        case 27755: spell = 49459; break;
                                        case 27756: spell = 49463; break;
                                    }

                                    //summoner->EnterVehicle(me);
                                    if (spell)
                                        me->CastSpell(summoner, spell, true);
                                    me->SetCanFly(true);
                                    me->SetSpeed(MOVE_FLIGHT, me->GetSpeedRate(MOVE_RUN), true);
                                }
                            }
                    }
                    else
                    {
                        me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                        me->DisappearAndDie();
                        me->DespawnOrUnsummon(1);
                        return;
                    }
                }
            }

            if (despawnTimer)
            {
                if (despawnTimer >= 5000)
                {
                    despawnTimer = 0;
                    me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                    me->DisappearAndDie();
                    me->DespawnOrUnsummon(1);
                    return;
                }
                else
                    despawnTimer += diff;
            }

            VehicleAI::UpdateAI(diff);
        }
    };
};

enum oculusSpells
{
    SPELL_AMBER_SHOCK_CHARGE            = 49836,
    SPELL_RUBY_EVASIVE_CHARGES          = 50241,
};

// 49838 - Stop Time
class spell_oculus_stop_time : public SpellScriptLoader
{
    public:
        spell_oculus_stop_time() : SpellScriptLoader("spell_oculus_stop_time") { }

        class spell_oculus_stop_time_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_oculus_stop_time_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_AMBER_SHOCK_CHARGE))
                    return false;
                return true;
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

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_oculus_stop_time_AuraScript::Apply, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
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

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_RUBY_EVASIVE_CHARGES))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
            {
                PreventDefaultAction();
                GetTarget()->RemoveAuraFromStack(SPELL_RUBY_EVASIVE_CHARGES);
                if (!GetTarget()->HasAura(SPELL_RUBY_EVASIVE_CHARGES))
                    SetDuration(0);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_oculus_evasive_maneuvers_AuraScript::HandleProc, EFFECT_2, SPELL_AURA_PROC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
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

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_AMBER_SHOCK_CHARGE))
                    return false;
                return true;
            }

            void CalcDamage()
            {
                int32 damage = GetHitDamage();
                if (Unit* target = GetHitUnit())
                    if (Aura* aura = target->GetAura(SPELL_AMBER_SHOCK_CHARGE, GetCaster()->GetGUID())) // shock charges from same caster
                    {
                        damage += aura->GetStackAmount()*6525;
                        aura->Remove();
                    }

                SetHitDamage(damage);
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_oculus_shock_lance_SpellScript::CalcDamage);
            }
        };

        SpellScript* GetSpellScript() const
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

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_AMBER_SHOCK_CHARGE))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                int32 amount = aurEff->GetAmount() + eventInfo.GetDamageInfo()->GetDamage();

                uint8 num = amount/15000;
                if (amount >= 15000)
                {
                    if (Unit* caster = GetCaster())
                        for (uint8 i  =0; i < num; ++i )
                            caster->CastSpell(GetTarget(), SPELL_AMBER_SHOCK_CHARGE, true);
                }

                const_cast<AuraEffect*>(aurEff)->SetAmount(amount - 15000*num);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_oculus_temporal_rift_AuraScript::HandleProc, EFFECT_2, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
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

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_oculus_touch_the_nightmare_SpellScript::HandleDamageCalc, EFFECT_2, SPELL_EFFECT_SCHOOL_DAMAGE);
            }
        };

        SpellScript* GetSpellScript() const
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

            void Register()
            {
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_oculus_dream_funnel_AuraScript::HandleEffectCalcAmount, EFFECT_0, SPELL_AURA_PERIODIC_HEAL);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_oculus_dream_funnel_AuraScript::HandleEffectCalcAmount, EFFECT_2, SPELL_AURA_PERIODIC_DAMAGE);
            }
        };

        AuraScript* GetAuraScript() const
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

            void Register()
            {
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_oculus_call_ruby_emerald_amber_drake_SpellScript::SetDest, EFFECT_0, TARGET_DEST_CASTER_FRONT);
            }
        };

        SpellScript* GetSpellScript() const
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

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_oculus_ride_ruby_emerald_amber_drake_que_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_oculus_ride_ruby_emerald_amber_drake_que_AuraScript();
        }
};


void AddSC_oculus()
{
    new npc_oculus_drakegiver();
    new npc_oculus_drake();

    new spell_oculus_stop_time();
    new spell_oculus_evasive_maneuvers();
    new spell_oculus_shock_lance();
    new spell_oculus_temporal_rift();
    new spell_oculus_touch_the_nightmare();
    new spell_oculus_dream_funnel();
    new spell_oculus_call_ruby_emerald_amber_drake();
    new spell_oculus_ride_ruby_emerald_amber_drake_que();
}
