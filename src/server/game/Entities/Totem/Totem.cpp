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

#include "Totem.h"
#include "Group.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "TotemPackets.h"

//npcbot
#include "botmgr.h"
#include "ObjectAccessor.h"
//end npcbot

Totem::Totem(SummonPropertiesEntry const* properties, ObjectGuid owner) : Minion(properties, owner, false)
{
    m_unitTypeMask |= UNIT_MASK_TOTEM;
    m_duration = 0;
    m_type = TOTEM_PASSIVE;
}

void Totem::Update(uint32 time)
{
    Unit* owner = GetOwner();
    //npcbot: do not despawn bot totem if master is dead
    Creature const* botOwner = (owner && owner->IsPlayer() && owner->ToPlayer()->HaveBot()) ?
       owner->ToPlayer()->GetBotMgr()->GetBot(GetCreatorGUID()) : nullptr;

    if (botOwner)
    {
        if (!botOwner->IsAlive() || !IsAlive() || m_duration <= time)
        {
            UnSummon();
            return;
        }
    }
    else
    //end npcbot
    if (!owner || !owner->IsAlive() || !IsAlive() || m_duration <= time)
    {
        UnSummon();                                         // remove self
        return;
    }

    m_duration -= time;
    Creature::Update(time);
}

void Totem::InitStats(uint32 duration)
{
    // client requires SMSG_TOTEM_CREATED to be sent before adding to world and before removing old totem
    // Xinef: Set level for Unit totems
    if (Unit* owner = ObjectAccessor::GetUnit(*this, m_owner))
    {
        uint32 slot = m_Properties->Slot;
        if (owner->GetTypeId() == TYPEID_PLAYER && slot >= SUMMON_SLOT_TOTEM && slot < MAX_TOTEM_SLOT)
        {
            WorldPackets::Totem::TotemCreated data;
            data.Totem = GetGUID();
            data.Slot = slot - SUMMON_SLOT_TOTEM;
            data.Duration = duration;
            data.SpellID = GetUInt32Value(UNIT_CREATED_BY_SPELL);
            owner->ToPlayer()->SendDirectMessage(data.Write());

            // set display id depending on caster's race
            SetDisplayId(owner->GetModelForTotem(PlayerTotemType(m_Properties->Id)));
        }

        SetLevel(owner->GetLevel());
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
    Minion::InitSummon();

    if (m_type == TOTEM_PASSIVE && GetSpell())
    {
        if (TotemSpellIds(GetUInt32Value(UNIT_CREATED_BY_SPELL)) == TotemSpellIds::FireTotemSpell)
        {
            m_Events.AddEventAtOffset([this]()
            {
                CastSpell(this, GetSpell(), true);
            }, 4s);
        }
        else
        {
            CastSpell(this, GetSpell(), true);
        }
    }

    // Some totems can have both instant effect and passive spell
    if (GetSpell(1))
    {
        CastSpell(this, GetSpell(1), true);
    }

    // xinef: this is better than the script, 100% sure to work
    if (GetEntry() == SENTRY_TOTEM_ENTRY)
    {
        SetReactState(REACT_AGGRESSIVE);
        GetOwner()->CastSpell(this, 6277, true);

        // Farsight objects should be active
        setActive(true);
        SetVisibilityDistanceOverride(VisibilityDistanceType::Infinite);
    }

    if (!IsInWater())
    {
        GetMotionMaster()->MoveFall();
    }
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

    if (Unit* owner = GetOwner())
    {
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
            owner->RemoveAurasDueToSpell(static_cast<uint32>(TotemSpellIds::SentryTotemSpell));

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
    }

    //npcbot: send SummonedCreatureDespawn()
    if (Unit* creator = GetCreator())
        if (creator->IsNPCBot())
            creator->ToCreature()->OnBotDespawn(this);
    //end npcbot

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
