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

#include "TemporarySummon.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"

TempSummon::TempSummon(SummonPropertiesEntry const* properties, ObjectGuid owner) :
    Creature(), m_Properties(properties), m_type(TEMPSUMMON_MANUAL_DESPAWN),
    m_timer(0), m_lifetime(0), _visibleBySummonerOnly(false)
{
    if (owner)
    {
        m_summonerGUID = owner;
    }

    m_unitTypeMask |= UNIT_MASK_SUMMON;
}

WorldObject* TempSummon::GetSummoner() const
{
    return m_summonerGUID ? ObjectAccessor::GetWorldObject(*this, m_summonerGUID) : nullptr;
}

Unit* TempSummon::GetSummonerUnit() const
{
    if (WorldObject* summoner = GetSummoner())
    {
        return summoner->ToUnit();
    }

    return nullptr;
}

Creature* TempSummon::GetSummonerCreatureBase() const
{
    return m_summonerGUID ? ObjectAccessor::GetCreature(*this, m_summonerGUID) : nullptr;
}

GameObject* TempSummon::GetSummonerGameObject() const
{
    if (WorldObject* summoner = GetSummoner())
        return summoner->ToGameObject();
    return nullptr;
}

void TempSummon::Update(uint32 diff)
{
    Creature::Update(diff);

    if (m_deathState == DeathState::Dead)
    {
        UnSummon();
        return;
    }
    switch (m_type)
    {
        case TEMPSUMMON_MANUAL_DESPAWN:
        case TEMPSUMMON_DESPAWNED:
            break;
        case TEMPSUMMON_TIMED_DESPAWN:
            {
                if (m_timer <= diff)
                {
                    UnSummon();
                    return;
                }

                m_timer -= diff;
                break;
            }
        case TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT:
            {
                if (!IsInCombat())
                {
                    if (m_timer <= diff)
                    {
                        UnSummon();
                        return;
                    }

                    m_timer -= diff;
                }
                else if (m_timer != m_lifetime)
                    m_timer = m_lifetime;

                break;
            }
        case TEMPSUMMON_TIMED_DESPAWN_OOC_ALIVE:
            {
                if (!IsInCombat() && m_deathState != DeathState::Corpse)
                {
                    if (m_timer <= diff)
                    {
                        UnSummon();
                        return;
                    }

                    m_timer -= diff;
                }
                else if (m_timer != m_lifetime)
                    m_timer = m_lifetime;

                break;
            }
        case TEMPSUMMON_CORPSE_TIMED_DESPAWN:
            {
                if (m_deathState == DeathState::Corpse)
                {
                    if (m_timer <= diff)
                    {
                        UnSummon();
                        return;
                    }

                    m_timer -= diff;
                }
                break;
            }
        case TEMPSUMMON_CORPSE_DESPAWN:
            {
                // if m_deathState is DEAD, CORPSE was skipped
                if (m_deathState == DeathState::Corpse)
                {
                    UnSummon();
                    return;
                }

                break;
            }
        case TEMPSUMMON_DEAD_DESPAWN:
            {
                break;
            }
        case TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN:
            {
                // if m_deathState is DEAD, CORPSE was skipped
                if (m_deathState == DeathState::Corpse)
                {
                    UnSummon();
                    return;
                }

                if (!IsInCombat())
                {
                    if (m_timer <= diff)
                    {
                        UnSummon();
                        return;
                    }
                    else
                        m_timer -= diff;
                }
                else if (m_timer != m_lifetime)
                    m_timer = m_lifetime;
                break;
            }
        case TEMPSUMMON_TIMED_OR_DEAD_DESPAWN:
            {
                if (!IsInCombat() && IsAlive())
                {
                    if (m_timer <= diff)
                    {
                        UnSummon();
                        return;
                    }
                    else
                        m_timer -= diff;
                }
                else if (m_timer != m_lifetime)
                    m_timer = m_lifetime;
                break;
            }
        default:
            UnSummon();
            LOG_ERROR("entities.unit", "Temporary summoned creature (entry: {}) have unknown type {} of ", GetEntry(), m_type);
            break;
    }
}

void TempSummon::InitStats(uint32 duration)
{
    ASSERT(!IsPet());

    Unit* owner = GetSummonerUnit();
    if (owner)
        if (Player* player = owner->ToPlayer())
            sScriptMgr->OnPlayerBeforeTempSummonInitStats(player, this, duration);

    m_timer = duration;
    m_lifetime = duration;

    if (m_type == TEMPSUMMON_MANUAL_DESPAWN)
        m_type = (duration == 0) ? TEMPSUMMON_DEAD_DESPAWN : TEMPSUMMON_TIMED_DESPAWN;

    if (owner)
    {
        if (IsTrigger() && m_spells[0])
        {
            SetFaction(owner->GetFaction());
            SetLevel(owner->GetLevel());
            if (owner->IsPlayer())
                m_ControlledByPlayer = true;
        }

        if (owner->IsPlayer())
            m_CreatedByPlayer = true;
    }

    if (!m_Properties)
        return;

    if (owner)
    {
        if (uint32 slot = m_Properties->Slot)
        {
            if (owner->m_SummonSlot[slot] && owner->m_SummonSlot[slot] != GetGUID())
            {
                Creature* oldSummon = GetMap()->GetCreature(owner->m_SummonSlot[slot]);
                if (oldSummon && oldSummon->IsSummon())
                    oldSummon->ToTempSummon()->UnSummon();
            }
            owner->m_SummonSlot[slot] = GetGUID();
        }
    }

    if (m_Properties->Faction)
        SetFaction(m_Properties->Faction);
    else if (IsVehicle() && owner) // properties should be vehicle
        SetFaction(owner->GetFaction());
}

void TempSummon::InitSummon()
{
    WorldObject* owner = GetSummoner();
    if (owner)
    {
        if (owner->IsCreature())
        {
            if (owner->ToCreature()->IsAIEnabled)
            {
                owner->ToCreature()->AI()->JustSummoned(this);
            }
        }
        else if (owner->IsGameObject())
        {
            if (owner->ToGameObject()->AI())
            {
                owner->ToGameObject()->AI()->JustSummoned(this);
            }
        }

        if (IsAIEnabled)
            AI()->IsSummonedBy(owner);
    }
}

void TempSummon::UpdateObjectVisibilityOnCreate()
{
    WorldObject::UpdateObjectVisibility(true);
}

void TempSummon::SetTempSummonType(TempSummonType type)
{
    m_type = type;
}

void TempSummon::UnSummon(Milliseconds msTime)
{
    if (msTime > 0ms)
    {
        ForcedUnsummonDelayEvent* pEvent = new ForcedUnsummonDelayEvent(*this);
        m_Events.AddEventAtOffset(pEvent, msTime);
        return;
    }

    // Dont allow to call this function twice (possible)
    if (m_type == TEMPSUMMON_DESPAWNED)
        return;
    SetTempSummonType(TEMPSUMMON_DESPAWNED);

    //ASSERT(!IsPet());
    if (IsPet())
    {
        ToPet()->Remove(PET_SAVE_NOT_IN_SLOT);
        ASSERT(!IsInWorld());
        return;
    }

    if (WorldObject* owner = GetSummoner())
    {
        if (owner->IsCreature() && owner->ToCreature()->IsAIEnabled)
            owner->ToCreature()->AI()->SummonedCreatureDespawn(this);
        else if (owner->IsGameObject() && owner->ToGameObject()->AI())
            owner->ToGameObject()->AI()->SummonedCreatureDespawn(this);
    }

    AddObjectToRemoveList();
}

bool ForcedUnsummonDelayEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    m_owner.UnSummon();
    return true;
}

void TempSummon::RemoveFromWorld()
{
    if (!IsInWorld())
        return;

    if (m_Properties)
        if (uint32 slot = m_Properties->Slot)
            if (Unit* owner = GetSummonerUnit())
                if (owner->m_SummonSlot[slot] == GetGUID())
                    owner->m_SummonSlot[slot].Clear();

    //if (GetOwnerGUID())
    //    LOG_ERROR("entities.unit", "Unit {} has owner guid when removed from world", GetEntry());

    Creature::RemoveFromWorld();
}

std::string TempSummon::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << Creature::GetDebugInfo() << "\n"
        << std::boolalpha
        << "TempSummonType : " << std::to_string(GetSummonType()) << " Summoner: " << GetSummonerGUID().ToString();
    return sstr.str();
}

Minion::Minion(SummonPropertiesEntry const* properties, ObjectGuid owner) : TempSummon(properties, owner)
    , m_owner(owner)
{
    ASSERT(m_owner);
    m_unitTypeMask |= UNIT_MASK_MINION;
    m_followAngle = PET_FOLLOW_ANGLE;
}

void Minion::InitStats(uint32 duration)
{
    TempSummon::InitStats(duration);

    SetReactState(REACT_PASSIVE);

    if (Unit* owner = GetOwner())
    {
        SetCreatorGUID(owner->GetGUID());
        SetFaction(owner->GetFaction());
        owner->SetMinion(this, true);
    }
}

void Minion::RemoveFromWorld()
{
    if (!IsInWorld())
        return;

    if (Unit* owner = GetOwner())
        owner->SetMinion(this, false);

    TempSummon::RemoveFromWorld();
}

Unit* Minion::GetOwner() const
{
    return ObjectAccessor::GetUnit(*this, m_owner);
}

bool Minion::IsGuardianPet() const
{
    return IsPet() || (m_Properties && m_Properties->Category == SUMMON_CATEGORY_PET);
}

void Minion::setDeathState(DeathState s, bool despawn)
{
    Creature::setDeathState(s, despawn);
    if (s == DeathState::JustDied && IsGuardianPet())
        if (Unit* owner = GetOwner())
            if (owner->IsPlayer() && owner->GetMinionGUID() == GetGUID())
                for (Unit::ControlSet::const_iterator itr = owner->m_Controlled.begin(); itr != owner->m_Controlled.end(); ++itr)
                    if ((*itr)->IsAlive() && (*itr)->GetEntry() == GetEntry())
                    {
                        owner->SetMinionGUID((*itr)->GetGUID());
                        owner->SetPetGUID((*itr)->GetGUID());
                        owner->ToPlayer()->CharmSpellInitialize();
                    }
}

std::string Minion::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << TempSummon::GetDebugInfo() << "\n"
        << std::boolalpha
        << "Owner: " << (GetOwner() ? GetOwner()->GetGUID().ToString() : "");
    return sstr.str();
}

Guardian::Guardian(SummonPropertiesEntry const* properties, ObjectGuid owner) : Minion(properties, owner)
{
    m_unitTypeMask |= UNIT_MASK_GUARDIAN;
    if (properties && (properties->Type == SUMMON_TYPE_PET || properties->Category == SUMMON_CATEGORY_PET))
    {
        m_unitTypeMask |= UNIT_MASK_CONTROLLABLE_GUARDIAN;
        InitCharmInfo();
    }
}

void Guardian::InitStats(uint32 duration)
{
    Minion::InitStats(duration);

    if (Unit* m_owner = GetOwner())
    {
        InitStatsForLevel(m_owner->GetLevel());

        if (m_owner->IsPlayer() && HasUnitTypeMask(UNIT_MASK_CONTROLLABLE_GUARDIAN))
            m_charmInfo->InitCharmCreateSpells();
    }

    SetReactState(REACT_AGGRESSIVE);
}

void Guardian::InitSummon()
{
    TempSummon::InitSummon();

    if (Unit* m_owner = GetOwner())
    {
        if (m_owner->IsPlayer() && m_owner->GetMinionGUID() == GetGUID() && !m_owner->GetCharmGUID())
        {
            m_owner->ToPlayer()->CharmSpellInitialize();
        }
    }
}

std::string Guardian::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << Minion::GetDebugInfo();
    return sstr.str();
}

Puppet::Puppet(SummonPropertiesEntry const* properties, ObjectGuid owner) : Minion(properties, owner), m_owner(owner)
{
    ASSERT(owner.IsPlayer());
    m_unitTypeMask |= UNIT_MASK_PUPPET;
}

void Puppet::InitStats(uint32 duration)
{
    Minion::InitStats(duration);
    SetLevel(GetOwner()->GetLevel());
    SetReactState(REACT_PASSIVE);
}

void Puppet::InitSummon()
{
    Minion::InitSummon();
    if (!SetCharmedBy(GetOwner(), CHARM_TYPE_POSSESS))
    {
        if (Player* p = GetOwner())
            LOG_INFO("misc", "Puppet::InitSummon (A1) - {}, {}, {}, {}, {}, {}, {}, {}", p->GetGUID().ToString(), p->GetMapId(), p->GetInstanceId(), p->FindMap()->GetId(), p->IsInWorld() ? 1 : 0, p->IsDuringRemoveFromWorld() ? 1 : 0, p->IsBeingTeleported() ? 1 : 0, p->isBeingLoaded() ? 1 : 0);
        else
        {
            LOG_INFO("misc", "Puppet::InitSummon (B1)");
            //ABORT();
        }
    }
}

void Puppet::Update(uint32 time)
{
    Minion::Update(time);
    //check if caster is channelling?
    if (IsInWorld())
    {
        if (!IsAlive())
        {
            UnSummon();
            /// @todo: why long distance .die does not remove it
        }
    }
}

void Puppet::RemoveFromWorld()
{
    if (!IsInWorld())
        return;

    RemoveCharmedBy(nullptr);
    Minion::RemoveFromWorld();
}

Player* Puppet::GetOwner() const
{
    return ObjectAccessor::GetPlayer(*this, m_owner);
}
