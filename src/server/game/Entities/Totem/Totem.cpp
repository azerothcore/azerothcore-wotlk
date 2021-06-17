/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Group.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Totem.h"
#include "WorldPacket.h"

Totem::Totem(SummonPropertiesEntry const* properties, ObjectGuid owner) : Minion(properties, owner, false)
{
    m_unitTypeMask |= UNIT_MASK_TOTEM;
    m_duration = 0;
    m_type = TOTEM_PASSIVE;
}

void Totem::Update(uint32 time)
{
    if (!GetOwner()->IsAlive() || !IsAlive())
    {
        UnSummon();                                         // remove self
        return;
    }

    if (m_duration <= time)
    {
        UnSummon();                                         // remove self
        return;
    }
    else
        m_duration -= time;

    Creature::Update(time);
}

void Totem::InitStats(uint32 duration)
{
    // client requires SMSG_TOTEM_CREATED to be sent before adding to world and before removing old totem
    // Xinef: Set level for Unit totems
    if (Unit* owner = ObjectAccessor::GetUnit(*this, m_owner))
    {
        if (owner->GetTypeId() == TYPEID_PLAYER && m_Properties->Slot >= SUMMON_SLOT_TOTEM && m_Properties->Slot < MAX_TOTEM_SLOT)
        {
            WorldPacket data(SMSG_TOTEM_CREATED, 1 + 8 + 4 + 4);
            data << uint8(m_Properties->Slot - 1);
            data << GetGUID();
            data << uint32(duration);
            data << uint32(GetUInt32Value(UNIT_CREATED_BY_SPELL));
            owner->ToPlayer()->SendDirectMessage(&data);

            // set display id depending on caster's race
            SetDisplayId(owner->GetModelForTotem(PlayerTotemType(m_Properties->Id)));
        }

        SetLevel(owner->getLevel());
    }

    Minion::InitStats(duration);

    // Get spell cast by totem
    if (SpellInfo const* totemSpell = sSpellMgr->GetSpellInfo(GetSpell()))
        if (totemSpell->CalcCastTime())   // If spell has cast time -> its an active totem
            m_type = TOTEM_ACTIVE;

    m_duration = duration;
}

void Totem::InitSummon()
{
    if (m_type == TOTEM_PASSIVE && GetSpell())
        CastSpell(this, GetSpell(), true);

    // Some totems can have both instant effect and passive spell
    if(GetSpell(1))
        CastSpell(this, GetSpell(1), true);

    // xinef: this is better than the script, 100% sure to work
    if(GetEntry() == SENTRY_TOTEM_ENTRY)
    {
        SetReactState(REACT_AGGRESSIVE);
        GetOwner()->CastSpell(this, 6277, true);
    }

    this->GetMotionMaster()->MoveFall();
}

void Totem::UnSummon(uint32 msTime)
{
    if (msTime)
    {
        m_Events.AddEvent(new ForcedUnsummonDelayEvent(*this), m_Events.CalculateTime(msTime));
        return;
    }

    CombatStop();
    RemoveAurasDueToSpell(GetSpell(), GetGUID());

    Unit* owner = GetOwner();
    // clear owner's totem slot
    for (uint8 i = SUMMON_SLOT_TOTEM; i < MAX_TOTEM_SLOT; ++i)
    {
        if (owner->m_SummonSlot[i] == GetGUID())
        {
            owner->m_SummonSlot[i].Clear();
            break;
        }
    }

    owner->RemoveAurasDueToSpell(GetSpell(), GetGUID());

    // Remove Sentry Totem Aura
    if (GetEntry() == SENTRY_TOTEM_ENTRY)
        owner->RemoveAurasDueToSpell(SENTRY_TOTEM_SPELLID);

    //remove aura all party members too
    if (Player* player = owner->ToPlayer())
    {
        player->SendAutoRepeatCancel(this);

        if (SpellInfo const* spell = sSpellMgr->GetSpellInfo(GetUInt32Value(UNIT_CREATED_BY_SPELL)))
            player->SendCooldownEvent(spell, 0, nullptr, false);

        if (Group* group = player->GetGroup())
        {
            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                Player* target = itr->GetSource();
                if (target && target->IsInMap(player) && group->SameSubGroup(player, target))
                    target->RemoveAurasDueToSpell(GetSpell(), GetGUID());
            }
        }
    }

    AddObjectToRemoveList();
}

bool Totem::IsImmunedToSpellEffect(SpellInfo const* spellInfo, uint32 index) const
{
    // xinef: immune to all positive spells, except of stoneclaw totem absorb and sentry totem bind sight
    // totems positive spells have unit_caster target
    if (spellInfo->Effects[index].Effect != SPELL_EFFECT_DUMMY &&
            spellInfo->Effects[index].Effect != SPELL_EFFECT_SCRIPT_EFFECT &&
            spellInfo->IsPositive() && spellInfo->Effects[index].TargetA.GetTarget() != TARGET_UNIT_CASTER &&
            spellInfo->Effects[index].TargetA.GetCheckType() != TARGET_CHECK_ENTRY && spellInfo->Id != 55277 && spellInfo->Id != 6277)
        return true;

    // Cyclone shouldn't be casted on totems
    if (spellInfo->Id == SPELL_CYCLONE)
    {
        return true;
    }

    switch (spellInfo->Effects[index].ApplyAuraName)
    {
        // i think its wrong (xinef)
        //case SPELL_AURA_PERIODIC_LEECH:
        case SPELL_AURA_PERIODIC_DAMAGE:
        case SPELL_AURA_PERIODIC_DAMAGE_PERCENT:
        case SPELL_AURA_MOD_FEAR:
        case SPELL_AURA_TRANSFORM:
            return true;
        default:
            break;
    }

    return Creature::IsImmunedToSpellEffect(spellInfo, index);
}
