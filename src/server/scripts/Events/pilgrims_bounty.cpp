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

#include "AchievementCriteriaScript.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"

///////////////////////////////////////
////// TABLE EVENT
///////////////////////////////////////

enum tableEvent
{
    // Spells
    SPELL_PASS_TURKEY               = 66250,
    SPELL_PASS_STUFFING             = 66259,
    SPELL_PASS_PIE                  = 66260,
    SPELL_PASS_CRANBERRY            = 66261,
    SPELL_PASS_SWEET_POTATO         = 66262,

    SPELL_VISUAL_THROW_TURKEY       = 61822,
    SPELL_VISUAL_THROW_STUFFING     = 61823,
    SPELL_VISUAL_THROW_PIE          = 61825,
    SPELL_VISUAL_THROW_CRANBERRY    = 61821,
    SPELL_VISUAL_THROW_SWEET_POTATO = 61824,

    SPELL_VISUAL_BOUNCE_TURKEY      = 61928,
    SPELL_VISUAL_BOUNCE_STUFFING    = 61927,
    SPELL_VISUAL_BOUNCE_PIE         = 61926,
    SPELL_VISUAL_BOUNCE_CRANBERRY   = 61925,
    SPELL_VISUAL_BOUNCE_SWEET_POTATO = 61929,

    SPELL_PLATE_TURKEY              = 61835,
    SPELL_PLATE_STUFFING            = 61836,
    SPELL_PLATE_PIE                 = 61838,
    SPELL_PLATE_CRANBERRY           = 61833,
    SPELL_PLATE_SWEET_POTATO        = 61837,

    SPELL_STORE_TURKEY              = 61807,
    SPELL_STORE_STUFFING            = 61806,
    SPELL_STORE_PIE                 = 61805,
    SPELL_STORE_CRANBERRY           = 61804,
    SPELL_STORE_SWEET_POTATO        = 61808,

    SPELL_CAN_EAT_TURKEY            = 61801,
    SPELL_CAN_EAT_STUFFING          = 61800,
    SPELL_CAN_EAT_PIE               = 61799,
    SPELL_CAN_EAT_CRANBERRY         = 61798,
    SPELL_CAN_EAT_SWEET_POTATO      = 61802,

    SPELL_FEAST_ON_TURKEY           = 61784,
    SPELL_FEAST_ON_STUFFING         = 61788,
    SPELL_FEAST_ON_PIE              = 61787,
    SPELL_FEAST_ON_CRANBERRY        = 61785,
    SPELL_FEAST_ON_SWEET_POTATOES   = 61786,

    SPELL_PLAYER_TURKEY             = 61842,
    SPELL_PLAYER_STUFFING           = 61843,
    SPELL_PLAYER_PIE                = 61845,
    SPELL_PLAYER_CRANBERRY          = 61841,
    SPELL_PLAYER_SWEET_POTATOES     = 61844,

    SPELL_WELL_FED_TURKEY           = 65414,
    SPELL_WELL_FED_STUFFING         = 65416,
    SPELL_WELL_FED_PIE              = 65415,
    SPELL_WELL_FED_CRANBERRY        = 65412,
    SPELL_WELL_FED_SWEET_POTATOES   = 65410,

    SPELL_ACHI_PASS_TURKEY          = 66373,
    SPELL_ACHI_PASS_STUFFING        = 66375,
    SPELL_ACHI_PASS_PIE             = 66374,
    SPELL_ACHI_PASS_CRANBERRY       = 66372,
    SPELL_ACHI_PASS_SWEET_POTATOES  = 66376,

    SPELL_SPIRIT_OF_SHARING         = 61849,

    // NPCs
    NPC_STRUDY_PLATE                = 32839,
    NPC_BOUNTIFUL_TABLE             = 32823,
};

/////////////////////////////
// NPCs
/////////////////////////////

struct npc_pilgrims_bounty_chair : public VehicleAI
{
    npc_pilgrims_bounty_chair(Creature* creature) : VehicleAI(creature)
    {
        plateGUID.Clear();
        timerSpawnPlate = 1;
        timerRotateChair = 0;
        me->SetReactState(REACT_PASSIVE);
    }

    void MoveInLineOfSight(Unit*  /*who*/) override {}
    void AttackStart(Unit*) override {}

    void PassengerBoarded(Unit* who, int8  /*seatId*/, bool apply) override
    {
        if (apply && who->GetTypeId() == TYPEID_PLAYER)
            who->ToPlayer()->SetClientControl(me, 0, true);
    }

    ObjectGuid plateGUID;
    uint32 timerSpawnPlate;
    uint32 timerRotateChair;

    Creature* GetPlate() { return plateGUID ? ObjectAccessor::GetCreature(*me, plateGUID) : nullptr; }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        damage = 0;
    }

    void DoAction(int32 param) override
    {
        switch (param)
        {
            case SPELL_VISUAL_THROW_TURKEY:
            case SPELL_VISUAL_BOUNCE_TURKEY:
                me->CastSpell(me, SPELL_STORE_TURKEY, true);
                me->CastSpell(me, SPELL_CAN_EAT_TURKEY, true);
                if (Unit* plate = GetPlate())
                    plate->CastSpell(plate, SPELL_PLATE_TURKEY, true);
                break;
            case SPELL_VISUAL_THROW_STUFFING:
            case SPELL_VISUAL_BOUNCE_STUFFING:
                me->CastSpell(me, SPELL_STORE_STUFFING, true);
                me->CastSpell(me, SPELL_CAN_EAT_STUFFING, true);
                if (Unit* plate = GetPlate())
                    plate->CastSpell(plate, SPELL_PLATE_STUFFING, true);
                break;
            case SPELL_VISUAL_THROW_PIE:
            case SPELL_VISUAL_BOUNCE_PIE:
                me->CastSpell(me, SPELL_STORE_PIE, true);
                me->CastSpell(me, SPELL_CAN_EAT_PIE, true);
                if (Unit* plate = GetPlate())
                    plate->CastSpell(plate, SPELL_PLATE_PIE, true);
                break;
            case SPELL_VISUAL_THROW_CRANBERRY:
            case SPELL_VISUAL_BOUNCE_CRANBERRY:
                me->CastSpell(me, SPELL_STORE_CRANBERRY, true);
                me->CastSpell(me, SPELL_CAN_EAT_CRANBERRY, true);
                if (Unit* plate = GetPlate())
                    plate->CastSpell(plate, SPELL_PLATE_CRANBERRY, true);
                break;
            case SPELL_VISUAL_THROW_SWEET_POTATO:
            case SPELL_VISUAL_BOUNCE_SWEET_POTATO:
                me->CastSpell(me, SPELL_STORE_SWEET_POTATO, true);
                me->CastSpell(me, SPELL_CAN_EAT_SWEET_POTATO, true);
                if (Unit* plate = GetPlate())
                    plate->CastSpell(plate, SPELL_PLATE_SWEET_POTATO, true);
                break;

            // AURA REMOVAL
            case SPELL_STORE_SWEET_POTATO:
                me->RemoveAura(SPELL_CAN_EAT_SWEET_POTATO);
                if (Unit* plate = GetPlate())
                    plate->RemoveAura(SPELL_PLATE_SWEET_POTATO);
                break;
            case SPELL_STORE_TURKEY:
                me->RemoveAura(SPELL_CAN_EAT_TURKEY);
                if (Unit* plate = GetPlate())
                    plate->RemoveAura(SPELL_PLATE_TURKEY);
                break;
            case SPELL_STORE_PIE:
                me->RemoveAura(SPELL_CAN_EAT_PIE);
                if (Unit* plate = GetPlate())
                    plate->RemoveAura(SPELL_PLATE_PIE);
                break;
            case SPELL_STORE_STUFFING:
                me->RemoveAura(SPELL_CAN_EAT_STUFFING);
                if (Unit* plate = GetPlate())
                    plate->RemoveAura(SPELL_PLATE_STUFFING);
                break;
            case SPELL_STORE_CRANBERRY:
                me->RemoveAura(SPELL_CAN_EAT_CRANBERRY);
                if (Unit* plate = GetPlate())
                    plate->RemoveAura(SPELL_PLATE_CRANBERRY);
                break;
        }
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
    {
        Unit* charm = target->GetCharm();
        if (!charm || !charm->ToCreature())
            return;

        charm->ToCreature()->AI()->DoAction(spellInfo->Id);
    }

    void SpellHit(Unit*  /*target*/, SpellInfo const* spellInfo) override
    {
        switch (spellInfo->Id)
        {
            case SPELL_FEAST_ON_SWEET_POTATOES:
                if (Aura* aur = me->GetAura(SPELL_STORE_SWEET_POTATO))
                    aur->ModStackAmount(-1);
                break;
            case SPELL_FEAST_ON_TURKEY:
                if (Aura* aur = me->GetAura(SPELL_STORE_TURKEY))
                    aur->ModStackAmount(-1);
                break;
            case SPELL_FEAST_ON_PIE:
                if (Aura* aur = me->GetAura(SPELL_STORE_PIE))
                    aur->ModStackAmount(-1);
                break;
            case SPELL_FEAST_ON_STUFFING:
                if (Aura* aur = me->GetAura(SPELL_STORE_STUFFING))
                    aur->ModStackAmount(-1);
                break;
            case SPELL_FEAST_ON_CRANBERRY:
                if (Aura* aur = me->GetAura(SPELL_STORE_CRANBERRY))
                    aur->ModStackAmount(-1);
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (timerSpawnPlate)
        {
            timerSpawnPlate += diff;
            if (timerSpawnPlate >= 1000)
            {
                if (Vehicle* table = me->GetVehicle())
                    if (Unit* plateHolder = table->GetPassenger(6))
                    {
                        SeatMap::const_iterator itr = table->GetSeatIteratorForPassenger(me);
                        if (itr == table->Seats.end())
                            return;

                        uint8 vehicleSeatId = itr->first;
                        Creature* plate = me->SummonCreature(NPC_STRUDY_PLATE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f);
                        if (!plate)
                            return;

                        plateGUID = plate->GetGUID();
                        plate->EnterVehicle(plateHolder, vehicleSeatId);
                        timerSpawnPlate = 0;
                        timerRotateChair = 1;
                    }
            }
        }
        if (timerRotateChair)
        {
            timerRotateChair += diff;
            if (timerRotateChair >= 1000)
            {
                if (Creature* plate = GetPlate())
                    me->SetFacingToObject(plate);

                timerRotateChair = 0;
            }
        }
    }
};

struct npc_pilgrims_bounty_plate : public NullCreatureAI
{
    npc_pilgrims_bounty_plate(Creature* creature) : NullCreatureAI(creature) { }

    void SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo) override
    {
        switch (spellInfo->Id)
        {
            case SPELL_VISUAL_THROW_TURKEY:
            case SPELL_VISUAL_THROW_STUFFING:
            case SPELL_VISUAL_THROW_PIE:
            case SPELL_VISUAL_THROW_CRANBERRY:
            case SPELL_VISUAL_THROW_SWEET_POTATO:
                if (TempSummon* ts = me->ToTempSummon())
                    if (Unit* owner = ts->GetSummonerUnit())
                        owner->ToCreature()->AI()->DoAction(spellInfo->Id);
                break;
        }
    }
};

/////////////////////////////
// Spells
/////////////////////////////

class spell_pilgrims_bounty_pass_generic : public SpellScript
{
    PrepareSpellScript(spell_pilgrims_bounty_pass_generic);

    uint32 GetVisualThrow(uint32 passSpell, bool isPlayer)
    {
        if (isPlayer)
        {
            switch (passSpell)
            {
                case SPELL_PASS_TURKEY:
                    return SPELL_VISUAL_BOUNCE_TURKEY;
                case SPELL_PASS_STUFFING:
                    return SPELL_VISUAL_BOUNCE_STUFFING;
                case SPELL_PASS_PIE:
                    return SPELL_VISUAL_BOUNCE_PIE;
                case SPELL_PASS_CRANBERRY:
                    return SPELL_VISUAL_BOUNCE_CRANBERRY;
                case SPELL_PASS_SWEET_POTATO:
                    return SPELL_VISUAL_BOUNCE_SWEET_POTATO;
            }
        }
        else
        {
            switch (passSpell)
            {
                case SPELL_PASS_TURKEY:
                    return SPELL_VISUAL_THROW_TURKEY;
                case SPELL_PASS_STUFFING:
                    return SPELL_VISUAL_THROW_STUFFING;
                case SPELL_PASS_PIE:
                    return SPELL_VISUAL_THROW_PIE;
                case SPELL_PASS_CRANBERRY:
                    return SPELL_VISUAL_THROW_CRANBERRY;
                case SPELL_PASS_SWEET_POTATO:
                    return SPELL_VISUAL_THROW_SWEET_POTATO;
            }
        }

        return 0;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            uint32 spellId = 0;
            switch (GetSpellInfo()->Id)
            {
                case SPELL_PASS_TURKEY:
                    spellId = SPELL_STORE_TURKEY;
                    break;
                case SPELL_PASS_STUFFING:
                    spellId = SPELL_STORE_STUFFING;
                    break;
                case SPELL_PASS_PIE:
                    spellId = SPELL_STORE_PIE;
                    break;
                case SPELL_PASS_CRANBERRY:
                    spellId = SPELL_STORE_CRANBERRY;
                    break;
                case SPELL_PASS_SWEET_POTATO:
                    spellId = SPELL_STORE_SWEET_POTATO;
                    break;
            }

            // player case
            if (target->IsVehicle() && target->ToCreature())
            {
                if (Player* player = target->GetCharmerOrOwnerPlayerOrPlayerItself())
                {
                    GetCaster()->CastSpell(player, GetVisualThrow(GetSpellInfo()->Id, true), true);
                    if (AuraEffect* aur = target->GetAuraEffectDummy(spellId))
                    {
                        if (aur->GetBase()->GetStackAmount() >= 5)
                        {
                            if (Player* casterPlayer = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself())
                            {
                                casterPlayer->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL2, GetVisualThrow(GetSpellInfo()->Id, true));
                            }
                        }
                    }
                }
            }
            // normal case
            else
            {
                if (TempSummon* ts = target->ToTempSummon())
                    if (Unit* owner = ts->GetSummonerUnit())
                        if (owner->GetEntry() == GetCaster()->GetEntry())
                            return;

                GetCaster()->CastSpell(target, GetVisualThrow(GetSpellInfo()->Id, false), true);
            }
        }

        // Get chair charmer, passing achievement
        if (Player* player = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself())
        {
            uint32 spellId = 0;
            switch (GetSpellInfo()->Id)
            {
                case SPELL_PASS_TURKEY:
                    spellId = SPELL_ACHI_PASS_TURKEY;
                    break;
                case SPELL_PASS_STUFFING:
                    spellId = SPELL_ACHI_PASS_STUFFING;
                    break;
                case SPELL_PASS_PIE:
                    spellId = SPELL_ACHI_PASS_PIE;
                    break;
                case SPELL_PASS_CRANBERRY:
                    spellId = SPELL_ACHI_PASS_CRANBERRY;
                    break;
                case SPELL_PASS_SWEET_POTATO:
                    spellId = SPELL_ACHI_PASS_SWEET_POTATOES;
                    break;
            }

            if (spellId)
                player->CastSpell(player, spellId, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pilgrims_bounty_pass_generic::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_pilgrims_bounty_feast_on_generic : public SpellScript
{
    PrepareSpellScript(spell_pilgrims_bounty_feast_on_generic);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* player = GetCaster()->GetCharmerOrOwnerPlayerOrPlayerItself();
        if (!player)
            return;

        uint32 spellId = 0;
        switch (GetSpellInfo()->Id)
        {
            case SPELL_FEAST_ON_TURKEY:
                spellId = SPELL_PLAYER_TURKEY;
                break;
            case SPELL_FEAST_ON_STUFFING:
                spellId = SPELL_PLAYER_STUFFING;
                break;
            case SPELL_FEAST_ON_PIE:
                spellId = SPELL_PLAYER_PIE;
                break;
            case SPELL_FEAST_ON_CRANBERRY:
                spellId = SPELL_PLAYER_CRANBERRY;
                break;
            case SPELL_FEAST_ON_SWEET_POTATOES:
                spellId = SPELL_PLAYER_SWEET_POTATOES;
                break;
        }

        if (spellId)
        {
            player->CastSpell(player, spellId, true);
            if (AuraEffect* aur = player->GetAuraEffectDummy(spellId))
            {
                if (aur->GetBase()->GetStackAmount() >= 5)
                {
                    switch (spellId)
                    {
                        case SPELL_PLAYER_TURKEY:
                            player->CastSpell(player, SPELL_WELL_FED_TURKEY, true);
                            break;
                        case SPELL_PLAYER_STUFFING:
                            player->CastSpell(player, SPELL_WELL_FED_STUFFING, true);
                            break;
                        case SPELL_PLAYER_PIE:
                            player->CastSpell(player, SPELL_WELL_FED_PIE, true);
                            break;
                        case SPELL_PLAYER_CRANBERRY:
                            player->CastSpell(player, SPELL_WELL_FED_CRANBERRY, true);
                            break;
                        case SPELL_PLAYER_SWEET_POTATOES:
                            player->CastSpell(player, SPELL_WELL_FED_SWEET_POTATOES, true);
                            break;
                    }

                    uint8 count = 0;
                    Unit::AuraEffectList const& dummyAuras = player->GetAuraEffectsByType(SPELL_AURA_DUMMY);
                    for (Unit::AuraEffectList::const_iterator i = dummyAuras.begin(); i != dummyAuras.end(); ++i)
                    {
                        if ((*i)->GetId() >= SPELL_PLAYER_CRANBERRY && (*i)->GetId() <= SPELL_PLAYER_PIE)
                            if ((*i)->GetBase()->GetStackAmount() >= 5)
                                ++count;
                    }

                    // Cast spirit of sharing
                    if (count >= 5)
                        player->CastSpell(player, SPELL_SPIRIT_OF_SHARING, true);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pilgrims_bounty_feast_on_generic::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum tTracker
{
    SPELL_TURKEY_TRACKER                = 62014,
    SPELL_ACHI_TURKINATOR_CREDIT        = 62021
};

enum Say
{
    SAY_TURKEY_HUNTER                       = 33163,
    SAY_TURKEY_DOMINATION                   = 33164,
    SAY_TURKEY_SLAUGHTER                    = 33165,
    SAY_TURKEY_TRIUMPH                      = 33167
};

class spell_pilgrims_bounty_turkey_tracker : public SpellScript
{
    PrepareSpellScript(spell_pilgrims_bounty_turkey_tracker);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Player* target = GetHitPlayer())
        {
            if (AuraEffect* aurEff = target->GetAuraEffectDummy(SPELL_TURKEY_TRACKER))
            {
                uint32 stackAmount = aurEff->GetBase()->GetStackAmount();
                switch (stackAmount)
                {
                    case 10:
                        target->Whisper(SAY_TURKEY_HUNTER, target, true);
                        break;
                    case 20:
                        target->Whisper(SAY_TURKEY_DOMINATION, target, true);
                        break;
                    case 30:
                        target->Whisper(SAY_TURKEY_SLAUGHTER, target, true);
                        break;
                    case 40:
                        target->Whisper(SAY_TURKEY_TRIUMPH, target, true);
                        target->CastSpell(target, SPELL_ACHI_TURKINATOR_CREDIT, true);
                        aurEff->GetBase()->Remove();
                        break;
                }
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pilgrims_bounty_turkey_tracker::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_pilgrims_bounty_serve_generic : public AuraScript
{
    PrepareAuraScript(spell_pilgrims_bounty_serve_generic);

    void OnAuraRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (target->GetTypeId() == TYPEID_UNIT)
            target->ToCreature()->AI()->DoAction(GetSpellInfo()->Id);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_pilgrims_bounty_serve_generic::OnAuraRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_pilgrims_bounty_food_aura : public AuraScript
{
    PrepareAuraScript(spell_pilgrims_bounty_food_aura);

    void RecalculateHook(AuraEffect const* /*aurEffect*/, int32& amount, bool& canBeRecalculated)
    {
        if (GetCaster())
        {
            if (GetId() == 66041)
                amount = CalculatePct(GetCaster()->GetMaxPower(POWER_MANA), 20);
            else
                amount = CalculatePct(GetCaster()->GetMaxHealth(), 15);
        }
        canBeRecalculated = true;
    }

    void Register() override
    {
        if (m_scriptSpellId == 66041)
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pilgrims_bounty_food_aura::RecalculateHook, EFFECT_0, SPELL_AURA_MOD_POWER_REGEN);
        else if (m_scriptSpellId != 66477)
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_pilgrims_bounty_food_aura::RecalculateHook, EFFECT_0, SPELL_AURA_MOD_REGEN);
    }
};

class spell_pilgrims_bounty_food : public SpellScript
{
    PrepareSpellScript(spell_pilgrims_bounty_food);

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            target->AddAura(sSpellMgr->GetSpellInfo(65422), 1, target);
            target->CastSpell(target, 66041, true);
            target->CastSpell(target, 66622, true);
        }
    }

    void Register() override
    {
        if (m_scriptSpellId == 66477)
            OnEffectHitTarget += SpellEffectFn(spell_pilgrims_bounty_food::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/////////////////////////////
// Achievements
/////////////////////////////
enum pilgrimsPeril
{
    ITEM_PILGRIMS_ROBE          = 46824,
    ITEM_PILGRIMS_ATTIRE        = 46800,
    ITEM_PILGRIMS_DRESS         = 44785,
    ITEM_PILGRIMS_HAT           = 46723,
};

class achievement_pb_pilgrims_peril : public AchievementCriteriaScript
{
public:
    achievement_pb_pilgrims_peril() : AchievementCriteriaScript("achievement_pb_pilgrims_peril") { }

    bool OnCheck(Player* source, Unit* /*target*/, uint32 /*criteria_id*/) override
    {
        if (source->HasItemOrGemWithIdEquipped(ITEM_PILGRIMS_DRESS, 1) || source->HasItemOrGemWithIdEquipped(ITEM_PILGRIMS_ROBE, 1) || source->HasItemOrGemWithIdEquipped(ITEM_PILGRIMS_ATTIRE, 1))
            return true;

        return false;
    }
};

class achievement_pb_terokkar_turkey_time : public AchievementCriteriaScript
{
public:
    achievement_pb_terokkar_turkey_time() : AchievementCriteriaScript("achievement_pb_terokkar_turkey_time") { }

    bool OnCheck(Player* source, Unit* /*target*/, uint32 /*criteria_id*/) override
    {
        if (source->HasItemOrGemWithIdEquipped(ITEM_PILGRIMS_HAT, 1) && (source->HasItemOrGemWithIdEquipped(ITEM_PILGRIMS_DRESS, 1) || source->HasItemOrGemWithIdEquipped(ITEM_PILGRIMS_ROBE, 1) || source->HasItemOrGemWithIdEquipped(ITEM_PILGRIMS_ATTIRE, 1)))
            return true;

        return false;
    }
};

void AddSC_event_pilgrims_end_scripts()
{
    // Spells
    RegisterSpellScript(spell_pilgrims_bounty_pass_generic);
    RegisterSpellScript(spell_pilgrims_bounty_feast_on_generic);
    RegisterSpellScript(spell_pilgrims_bounty_turkey_tracker);
    RegisterSpellScript(spell_pilgrims_bounty_serve_generic);
    RegisterSpellAndAuraScriptPair(spell_pilgrims_bounty_food, spell_pilgrims_bounty_food_aura);

    // Npcs
    RegisterCreatureAI(npc_pilgrims_bounty_chair);
    RegisterCreatureAI(npc_pilgrims_bounty_plate);

    // Achievements
    new achievement_pb_pilgrims_peril();
    new achievement_pb_terokkar_turkey_time();
}

