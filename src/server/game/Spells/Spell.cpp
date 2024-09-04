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

#include "Spell.h"
#include "ArenaSpectator.h"
#include "BattlefieldMgr.h"
#include "Battleground.h"
#include "BattlegroundIC.h"
#include "CharmInfo.h"
#include "CellImpl.h"
#include "Common.h"
#include "ConditionMgr.h"
#include "DisableMgr.h"
#include "DynamicObject.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Log.h"
#include "LootMgr.h"
#include "MapMgr.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "TemporarySummon.h"
#include "Totem.h"
#include "Unit.h"
#include "UpdateData.h"
#include "UpdateMask.h"
#include "Util.h"
#include "VMapFactory.h"
#include "Vehicle.h"
#include "World.h"
#include "WorldPacket.h"
#include <cmath>

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

//npcbot
#include "botmgr.h"
//end npcbot

extern pEffect SpellEffects[TOTAL_SPELL_EFFECTS];

SpellDestination::SpellDestination()
{
    _position.Relocate(0, 0, 0, 0);
    _transportOffset.Relocate(0, 0, 0, 0);
}

SpellDestination::SpellDestination(float x, float y, float z, float orientation, uint32 mapId)
{
    _position.Relocate(x, y, z, orientation);
    _position.m_mapId = mapId;
    _transportOffset.Relocate(0, 0, 0, 0);
}

SpellDestination::SpellDestination(Position const& pos)
{
    _position.Relocate(pos);
    _transportOffset.Relocate(0, 0, 0, 0);
}

SpellDestination::SpellDestination(WorldObject const& wObj)
{
    _transportGUID = wObj.GetTransGUID();
    _transportOffset.Relocate(wObj.GetTransOffsetX(), wObj.GetTransOffsetY(), wObj.GetTransOffsetZ(), wObj.GetTransOffsetO());
    _position.Relocate(wObj);
}

void SpellDestination::Relocate(Position const& pos)
{
    if (_transportGUID)
    {
        Position offset;
        _position.GetPositionOffsetTo(pos, offset);
        _transportOffset.RelocateOffset(offset);
    }
    _position.Relocate(pos);
}

void SpellDestination::RelocateOffset(Position const& offset)
{
    if (_transportGUID)
        _transportOffset.RelocateOffset(offset);

    _position.RelocateOffset(offset);
}

SpellCastTargets::SpellCastTargets() : m_elevation(0), m_speed(0), m_strTarget()
{
    m_objectTarget = nullptr;
    m_itemTarget = nullptr;

    m_itemTargetEntry  = 0;

    m_targetMask = 0;
}

SpellCastTargets::~SpellCastTargets()
{
}

void SpellCastTargets::Read(ByteBuffer& data, Unit* caster)
{
    data >> m_targetMask;

    if (m_targetMask == TARGET_FLAG_NONE)
        return;

    if (m_targetMask & (TARGET_FLAG_UNIT | TARGET_FLAG_UNIT_MINIPET | TARGET_FLAG_GAMEOBJECT | TARGET_FLAG_CORPSE_ENEMY | TARGET_FLAG_CORPSE_ALLY))
        data >> m_objectTargetGUID.ReadAsPacked();

    if (m_targetMask & (TARGET_FLAG_ITEM | TARGET_FLAG_TRADE_ITEM))
        data >> m_itemTargetGUID.ReadAsPacked();

    if (m_targetMask & TARGET_FLAG_SOURCE_LOCATION)
    {
        data >> m_src._transportGUID.ReadAsPacked();
        if (m_src._transportGUID)
            data >> m_src._transportOffset.PositionXYZStream();
        else
            data >> m_src._position.PositionXYZStream();
    }
    else
    {
        m_src._transportGUID = caster->GetTransGUID();
        if (m_src._transportGUID)
            m_src._transportOffset.Relocate(caster->GetTransOffsetX(), caster->GetTransOffsetY(), caster->GetTransOffsetZ(), caster->GetTransOffsetO());
        else
            m_src._position.Relocate(caster);
    }

    if (m_targetMask & TARGET_FLAG_DEST_LOCATION)
    {
        data >> m_dst._transportGUID.ReadAsPacked();
        if (m_dst._transportGUID)
            data >> m_dst._transportOffset.PositionXYZStream();
        else
            data >> m_dst._position.PositionXYZStream();
    }
    else
    {
        m_dst._transportGUID = caster->GetTransGUID();
        if (m_dst._transportGUID)
            m_dst._transportOffset.Relocate(caster->GetTransOffsetX(), caster->GetTransOffsetY(), caster->GetTransOffsetZ(), caster->GetTransOffsetO());
        else
            m_dst._position.Relocate(caster);
    }

    if (m_targetMask & TARGET_FLAG_STRING)
        data >> m_strTarget;

    Update(caster);
}

void SpellCastTargets::Write(ByteBuffer& data)
{
    data << uint32(m_targetMask);

    if (m_targetMask & (TARGET_FLAG_UNIT | TARGET_FLAG_CORPSE_ALLY | TARGET_FLAG_GAMEOBJECT | TARGET_FLAG_CORPSE_ENEMY | TARGET_FLAG_UNIT_MINIPET))
        data << m_objectTargetGUID.WriteAsPacked();

    if (m_targetMask & (TARGET_FLAG_ITEM | TARGET_FLAG_TRADE_ITEM))
    {
        if (m_itemTarget)
            data << m_itemTarget->GetPackGUID();
        else
            data << uint8(0);
    }

    if (m_targetMask & TARGET_FLAG_SOURCE_LOCATION)
    {
        data << m_src._transportGUID.WriteAsPacked(); // relative position guid here - transport for example
        if (m_src._transportGUID)
            data << m_src._transportOffset.PositionXYZStream();
        else
            data << m_src._position.PositionXYZStream();
    }

    if (m_targetMask & TARGET_FLAG_DEST_LOCATION)
    {
        data << m_dst._transportGUID.WriteAsPacked(); // relative position guid here - transport for example
        if (m_dst._transportGUID)
            data << m_dst._transportOffset.PositionXYZStream();
        else
            data << m_dst._position.PositionXYZStream();
    }

    if (m_targetMask & TARGET_FLAG_STRING)
        data << m_strTarget;
}

ObjectGuid SpellCastTargets::GetUnitTargetGUID() const
{
    switch (m_objectTargetGUID.GetHigh())
    {
        case HighGuid::Player:
        case HighGuid::Vehicle:
        case HighGuid::Unit:
        case HighGuid::Pet:
            return m_objectTargetGUID;
        default:
            break;
    }

    return ObjectGuid::Empty;
}

Unit* SpellCastTargets::GetUnitTarget() const
{
    if (m_objectTarget)
        return m_objectTarget->ToUnit();
    return nullptr;
}

void SpellCastTargets::SetUnitTarget(Unit* target)
{
    if (!target)
        return;

    m_objectTarget = target;
    m_objectTargetGUID = target->GetGUID();
    m_targetMask |= TARGET_FLAG_UNIT;
}

ObjectGuid SpellCastTargets::GetGOTargetGUID() const
{
    switch (m_objectTargetGUID.GetHigh())
    {
        case HighGuid::Transport:
        case HighGuid::Mo_Transport:
        case HighGuid::GameObject:
            return m_objectTargetGUID;
        default:
            break;
    }

    return ObjectGuid::Empty;
}

GameObject* SpellCastTargets::GetGOTarget() const
{
    if (m_objectTarget)
        return m_objectTarget->ToGameObject();
    return nullptr;
}

void SpellCastTargets::SetGOTarget(GameObject* target)
{
    if (!target)
        return;

    m_objectTarget = target;
    m_objectTargetGUID = target->GetGUID();
    m_targetMask |= TARGET_FLAG_GAMEOBJECT;
}

ObjectGuid SpellCastTargets::GetCorpseTargetGUID() const
{
    switch (m_objectTargetGUID.GetHigh())
    {
        case HighGuid::Corpse:
            return m_objectTargetGUID;
        default:
            break;
    }

    return ObjectGuid::Empty;
}

Corpse* SpellCastTargets::GetCorpseTarget() const
{
    if (m_objectTarget)
        return m_objectTarget->ToCorpse();
    return nullptr;
}

void SpellCastTargets::SetCorpseTarget(Corpse* target)
{
    if (!target)
        return;

    m_objectTarget = target;
    m_objectTargetGUID = target->GetGUID();
    m_targetMask |= TARGET_FLAG_CORPSE_MASK;
}

WorldObject* SpellCastTargets::GetObjectTarget() const
{
    return m_objectTarget;
}

ObjectGuid SpellCastTargets::GetObjectTargetGUID() const
{
    return m_objectTargetGUID;
}

void SpellCastTargets::RemoveObjectTarget()
{
    m_objectTarget = nullptr;
    m_objectTargetGUID.Clear();
    m_targetMask &= ~(TARGET_FLAG_UNIT_MASK | TARGET_FLAG_CORPSE_MASK | TARGET_FLAG_GAMEOBJECT_MASK);
}

void SpellCastTargets::SetItemTarget(Item* item)
{
    if (!item)
        return;

    m_itemTarget = item;
    m_itemTargetGUID = item->GetGUID();
    m_itemTargetEntry = item->GetEntry();
    m_targetMask |= TARGET_FLAG_ITEM;
}

void SpellCastTargets::SetTradeItemTarget(Player* caster)
{
    m_itemTargetGUID.Set(uint64(TRADE_SLOT_NONTRADED));
    m_itemTargetEntry = 0;
    m_targetMask |= TARGET_FLAG_TRADE_ITEM;

    Update(caster);
}

void SpellCastTargets::UpdateTradeSlotItem()
{
    if (m_itemTarget && (m_targetMask & TARGET_FLAG_TRADE_ITEM))
    {
        m_itemTargetGUID = m_itemTarget->GetGUID();
        m_itemTargetEntry = m_itemTarget->GetEntry();
    }
}

SpellDestination const* SpellCastTargets::GetSrc() const
{
    return &m_src;
}

Position const* SpellCastTargets::GetSrcPos() const
{
    return &m_src._position;
}

void SpellCastTargets::SetSrc(float x, float y, float z)
{
    m_src = SpellDestination(x, y, z);
    m_targetMask |= TARGET_FLAG_SOURCE_LOCATION;
}

void SpellCastTargets::SetSrc(Position const& pos)
{
    m_src = SpellDestination(pos);
    m_targetMask |= TARGET_FLAG_SOURCE_LOCATION;
}

void SpellCastTargets::SetSrc(WorldObject const& wObj)
{
    m_src = SpellDestination(wObj);
    m_targetMask |= TARGET_FLAG_SOURCE_LOCATION;
}

void SpellCastTargets::ModSrc(Position const& pos)
{
    ASSERT(m_targetMask & TARGET_FLAG_SOURCE_LOCATION);
    m_src.Relocate(pos);
}

void SpellCastTargets::RemoveSrc()
{
    m_targetMask &= ~(TARGET_FLAG_SOURCE_LOCATION);
}

SpellDestination const* SpellCastTargets::GetDst() const
{
    return &m_dst;
}

WorldLocation const* SpellCastTargets::GetDstPos() const
{
    return &m_dst._position;
}

void SpellCastTargets::SetDst(float x, float y, float z, float orientation, uint32 mapId)
{
    m_dst = SpellDestination(x, y, z, orientation, mapId);
    m_targetMask |= TARGET_FLAG_DEST_LOCATION;
}

void SpellCastTargets::SetDst(Position const& pos)
{
    m_dst = SpellDestination(pos);
    m_targetMask |= TARGET_FLAG_DEST_LOCATION;
}

void SpellCastTargets::SetDst(WorldObject const& wObj)
{
    m_dst = SpellDestination(wObj);
    m_targetMask |= TARGET_FLAG_DEST_LOCATION;
}

void SpellCastTargets::SetDst(SpellDestination const& spellDest)
{
    m_dst = spellDest;
    m_targetMask |= TARGET_FLAG_DEST_LOCATION;
}

void SpellCastTargets::SetDst(SpellCastTargets const& spellTargets)
{
    m_dst = spellTargets.m_dst;
    m_targetMask |= TARGET_FLAG_DEST_LOCATION;
}

void SpellCastTargets::ModDst(Position const& pos)
{
    ASSERT(m_targetMask & TARGET_FLAG_DEST_LOCATION);
    m_dst.Relocate(pos);
}

void SpellCastTargets::ModDst(SpellDestination const& spellDest)
{
    ASSERT(m_targetMask & TARGET_FLAG_DEST_LOCATION);
    m_dst = spellDest;
}

void SpellCastTargets::RemoveDst()
{
    m_targetMask &= ~(TARGET_FLAG_DEST_LOCATION);
}

// Xinef: Channel Data
void SpellCastTargets::SetObjectTargetChannel(ObjectGuid targetGUID)
{
    m_objectTargetGUIDChannel = targetGUID;
}

void SpellCastTargets::SetDstChannel(SpellDestination const& spellDest)
{
    m_dstChannel = spellDest;
}

WorldObject* SpellCastTargets::GetObjectTargetChannel(Unit* caster) const
{
    return m_objectTargetGUIDChannel ? ((m_objectTargetGUIDChannel == caster->GetGUID()) ? caster : ObjectAccessor::GetWorldObject(*caster, m_objectTargetGUIDChannel)) : nullptr;
}

bool SpellCastTargets::HasDstChannel() const
{
    return m_dstChannel._position.GetExactDist(0, 0, 0) > 0.001f;
}

SpellDestination const* SpellCastTargets::GetDstChannel() const
{
    return &m_dstChannel;
}

void SpellCastTargets::Update(Unit* caster)
{
    m_objectTarget = m_objectTargetGUID ? ((m_objectTargetGUID == caster->GetGUID()) ? caster : ObjectAccessor::GetWorldObject(*caster, m_objectTargetGUID)) : nullptr;

    m_itemTarget = nullptr;
    if (caster->IsPlayer())
    {
        Player* player = caster->ToPlayer();
        if (m_targetMask & TARGET_FLAG_ITEM)
            m_itemTarget = player->GetItemByGuid(m_itemTargetGUID);
        else if (m_targetMask & TARGET_FLAG_TRADE_ITEM)
            if (m_itemTargetGUID.GetRawValue() == TRADE_SLOT_NONTRADED) // here it is not guid but slot. Also prevents hacking slots
                if (TradeData* pTrade = player->GetTradeData())
                    m_itemTarget = pTrade->GetTraderData()->GetItem(TRADE_SLOT_NONTRADED);

        if (m_itemTarget)
            m_itemTargetEntry = m_itemTarget->GetEntry();
    }

    // update positions by transport move
    if (HasSrc() && m_src._transportGUID)
    {
        if (WorldObject* transport = ObjectAccessor::GetWorldObject(*caster, m_src._transportGUID))
        {
            m_src._position.Relocate(transport);
            m_src._position.RelocateOffset(m_src._transportOffset);
        }
    }

    if (HasDst() && m_dst._transportGUID)
    {
        if (WorldObject* transport = ObjectAccessor::GetWorldObject(*caster, m_dst._transportGUID))
        {
            m_dst._position.Relocate(transport);
            m_dst._position.RelocateOffset(m_dst._transportOffset);
        }
    }
}

class SpellEvent : public BasicEvent
{
    public:
        SpellEvent(Spell* spell);
        ~SpellEvent();

        bool Execute(uint64 e_time, uint32 p_time);
        void Abort(uint64 e_time);
        bool IsDeletable() const;

    protected:
        Spell* m_Spell;
};

void SpellCastTargets::OutDebug() const
{
    if (!m_targetMask)
        LOG_INFO("spells", "No targets");

    LOG_INFO("spells", "target mask: {}", m_targetMask);
    if (m_targetMask & (TARGET_FLAG_UNIT_MASK | TARGET_FLAG_CORPSE_MASK | TARGET_FLAG_GAMEOBJECT_MASK))
        LOG_INFO("spells", "Object target: {}", m_objectTargetGUID.ToString());
    if (m_targetMask & TARGET_FLAG_ITEM)
        LOG_INFO("spells", "Item target: {}", m_itemTargetGUID.ToString());
    if (m_targetMask & TARGET_FLAG_TRADE_ITEM)
        LOG_INFO("spells", "Trade item target: {}", m_itemTargetGUID.ToString());
    if (m_targetMask & TARGET_FLAG_SOURCE_LOCATION)
        LOG_INFO("spells", "Source location: transport guid: {} trans offset: {} position: {}",
            m_src._transportGUID.ToString(), m_src._transportOffset.ToString(), m_src._position.ToString());
    if (m_targetMask & TARGET_FLAG_DEST_LOCATION)
        LOG_INFO("spells", "Destination location: transport guid: {} trans offset: {} position: {}",
            m_dst._transportGUID.ToString(), m_dst._transportOffset.ToString(), m_dst._position.ToString());
    if (m_targetMask & TARGET_FLAG_STRING)
        LOG_INFO("spells", "String: {}", m_strTarget);
    LOG_INFO("spells", "speed: {}", m_speed);
    LOG_INFO("spells", "elevation: {}", m_elevation);
}

SpellValue::SpellValue(SpellInfo const* proto)
{
    for (uint32 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        EffectBasePoints[i] = proto->Effects[i].BasePoints;
    MaxAffectedTargets = proto->MaxAffectedTargets;
    RadiusMod = 1.0f;
    AuraStackAmount = 1;
    AuraDuration = 0;
    ForcedCritResult = false;
}

Spell::Spell(Unit* caster, SpellInfo const* info, TriggerCastFlags triggerFlags, ObjectGuid originalCasterGUID, bool skipCheck) :
//npcbot: override spellInfo
/*
    m_spellInfo(sSpellMgr->GetSpellForDifficultyFromSpell(info, caster)),
*/
    m_spellInfo((caster->IsNPCBot() ? info : sSpellMgr->GetSpellForDifficultyFromSpell(info, caster))->TryGetSpellInfoOverride(caster)),
//end npcbot
    m_caster((info->HasAttribute(SPELL_ATTR6_ORIGINATE_FROM_CONTROLLER) && caster->GetCharmerOrOwner()) ? caster->GetCharmerOrOwner() : caster)
    , m_spellValue(new SpellValue(m_spellInfo)), _spellEvent(nullptr)
{
    m_customError = SPELL_CUSTOM_ERROR_NONE;
    m_skipCheck = skipCheck;
    m_selfContainer = nullptr;
    m_referencedFromCurrentSpell = false;
    m_executedCurrently = false;
    m_needComboPoints = m_spellInfo->NeedsComboPoints();
    m_comboPointGain = 0;
    m_comboTarget = nullptr;
    m_delayStart = 0;
    m_delayAtDamageCount = 0;

    m_applyMultiplierMask = 0;
    m_auraScaleMask = 0;
    memset(m_damageMultipliers, 0, sizeof(m_damageMultipliers));

    // Get data for type of attack
    switch (m_spellInfo->DmgClass)
    {
        case SPELL_DAMAGE_CLASS_MELEE:
            if (m_spellInfo->HasAttribute(SPELL_ATTR3_REQUIRES_OFF_HAND_WEAPON))
                m_attackType = OFF_ATTACK;
            else
                m_attackType = BASE_ATTACK;
            break;
        case SPELL_DAMAGE_CLASS_RANGED:
            m_attackType = m_spellInfo->IsRangedWeaponSpell() ? RANGED_ATTACK : BASE_ATTACK;
            break;
        default:
            // Wands
            if (m_spellInfo->HasAttribute(SPELL_ATTR2_AUTO_REPEAT))
                m_attackType = RANGED_ATTACK;
            else
                m_attackType = BASE_ATTACK;
            break;
    }

    m_spellSchoolMask = info->GetSchoolMask();           // Can be override for some spell (wand shoot for example)

    if (m_attackType == RANGED_ATTACK)
        // wand case
        if ((m_caster->getClassMask() & CLASSMASK_WAND_USERS) != 0 && m_caster->IsPlayer())
            if (Item* pItem = m_caster->ToPlayer()->GetWeaponForAttack(RANGED_ATTACK))
                m_spellSchoolMask = SpellSchoolMask(1 << pItem->GetTemplate()->Damage[0].DamageType);

    //npcbot: ranged weapon dmg school
    if (m_attackType == RANGED_ATTACK && m_caster->IsNPCBot() &&
        ((1<<(m_caster->ToCreature()->GetBotClass()-1)) & CLASSMASK_WAND_USERS))
    {
        if (Item const* pItem = m_caster->ToCreature()->GetBotEquips(2))
            m_spellSchoolMask = SpellSchoolMask(1 << pItem->GetTemplate()->Damage[0].DamageType);
    }
    //end npcbot

    if (originalCasterGUID)
        m_originalCasterGUID = originalCasterGUID;
    else
        m_originalCasterGUID = m_caster->GetGUID();

    if (m_originalCasterGUID == m_caster->GetGUID())
        m_originalCaster = m_caster;
    else
    {
        m_originalCaster = ObjectAccessor::GetUnit(*m_caster, m_originalCasterGUID);
        if (m_originalCaster && !m_originalCaster->IsInWorld())
            m_originalCaster = nullptr;
    }

    m_spellState = SPELL_STATE_NULL;
    _triggeredCastFlags = triggerFlags;
    if (info->HasAttribute(SPELL_ATTR4_ALLOW_CAST_WHILE_CASTING))
        _triggeredCastFlags = TriggerCastFlags(uint32(_triggeredCastFlags) | TRIGGERED_IGNORE_CAST_IN_PROGRESS | TRIGGERED_CAST_DIRECTLY);

    m_CastItem = nullptr;

    unitTarget = nullptr;
    itemTarget = nullptr;
    gameObjTarget = nullptr;
    destTarget = nullptr;
    damage = 0;
    effectHandleMode = SPELL_EFFECT_HANDLE_LAUNCH;
    m_diminishLevel = DIMINISHING_LEVEL_1;
    m_diminishGroup = DIMINISHING_NONE;
    m_damage = 0;
    m_healing = 0;
    m_procAttacker = 0;
    m_procVictim = 0;
    m_procEx = 0;
    focusObject = nullptr;
    m_cast_count = 0;
    m_glyphIndex = 0;
    m_preCastSpell = 0;
    m_spellAura = nullptr;
    _scriptsLoaded = false;

    //Auto Shot & Shoot (wand)
    m_autoRepeat = m_spellInfo->IsAutoRepeatRangedSpell();

    m_runesState = 0;
    m_powerCost = 0;                                        // setup to correct value in Spell::prepare, must not be used before.
    m_casttime = 0;                                         // setup to correct value in Spell::prepare, must not be used before.
    m_timer = 0;                                            // will set to castime in prepare
    m_channeledDuration = 0;                                // will be setup in Spell::handle_immediate
    m_immediateHandled = false;

    m_channelTargetEffectMask = 0;

    m_spellFlags = SPELL_FLAG_NORMAL;

    // Determine if spell can be reflected back to the caster
    // Patch 1.2 notes: Spell Reflection no longer reflects abilities
    m_canReflect = m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_MAGIC && !m_spellInfo->HasAttribute(SPELL_ATTR0_IS_ABILITY)
                   && !m_spellInfo->HasAttribute(SPELL_ATTR1_NO_REFLECTION) && !m_spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES)
                   && !m_spellInfo->IsPassive() && (!m_spellInfo->IsPositive() || m_spellInfo->HasEffect(SPELL_EFFECT_DISPEL));

    CleanupTargetList();
    memset(m_effectExecuteData, 0, MAX_SPELL_EFFECTS * sizeof(ByteBuffer*));

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        m_destTargets[i] = SpellDestination(*m_caster);

    // xinef:
    _spellTargetsSelected = false;

    m_weaponItem = nullptr;
}

Spell::~Spell()
{
    // unload scripts
    while (!m_loadedScripts.empty())
    {
        std::list<SpellScript*>::iterator itr = m_loadedScripts.begin();
        (*itr)->_Unload();
        delete (*itr);
        m_loadedScripts.erase(itr);
    }

    if (m_referencedFromCurrentSpell && m_selfContainer && *m_selfContainer == this)
    {
        // Clean the reference to avoid later crash.
        // If this error is repeating, we may have to add an ASSERT to better track down how we get into this case.
        LOG_ERROR("spells", "Spell::~Spell: deleting spell for spell ID {}. However, spell still referenced.", m_spellInfo->Id);
        *m_selfContainer = nullptr;
    }

    delete m_spellValue;

    CheckEffectExecuteData();
}

void Spell::InitExplicitTargets(SpellCastTargets const& targets)
{
    m_targets = targets;
    // this function tries to correct spell explicit targets for spell
    // client doesn't send explicit targets correctly sometimes - we need to fix such spells serverside
    // this also makes sure that we correctly send explicit targets to client (removes redundant data)
    uint32 neededTargets = m_spellInfo->GetExplicitTargetMask();

    if (WorldObject* target = m_targets.GetObjectTarget())
    {
        // check if object target is valid with needed target flags
        // for unit case allow corpse target mask because player with not released corpse is a unit target
        if ((target->ToUnit() && !(neededTargets & (TARGET_FLAG_UNIT_MASK | TARGET_FLAG_CORPSE_MASK)))
                || (target->ToGameObject() && !(neededTargets & TARGET_FLAG_GAMEOBJECT_MASK))
                || (target->ToCorpse() && !(neededTargets & TARGET_FLAG_CORPSE_MASK)))
            m_targets.RemoveObjectTarget();
    }
    else
    {
        // try to select correct unit target if not provided by client or by serverside cast
        if (neededTargets & (TARGET_FLAG_UNIT_MASK))
        {
            Unit* unit = nullptr;
            // try to use player selection as a target
            if (Player* playerCaster = m_caster->ToPlayer())
            {
                // selection has to be found and to be valid target for the spell
                if (Unit* selectedUnit = ObjectAccessor::GetUnit(*m_caster, playerCaster->GetTarget()))
                    if (m_spellInfo->CheckExplicitTarget(m_caster, selectedUnit) == SPELL_CAST_OK)
                        unit = selectedUnit;
            }
            // try to use attacked unit as a target
            else if ((m_caster->IsCreature()) && neededTargets & (TARGET_FLAG_UNIT_ENEMY | TARGET_FLAG_UNIT))
                unit = m_caster->GetVictim();

            // didn't find anything - let's use self as target
            if (!unit && neededTargets & (TARGET_FLAG_UNIT_RAID | TARGET_FLAG_UNIT_PARTY | TARGET_FLAG_UNIT_ALLY))
                unit = m_caster;

            m_targets.SetUnitTarget(unit);
        }
    }

    // check if spell needs dst target
    if (neededTargets & TARGET_FLAG_DEST_LOCATION)
    {
        // and target isn't set
        if (!m_targets.HasDst())
        {
            // try to use unit target if provided
            if (WorldObject* target = targets.GetObjectTarget())
                m_targets.SetDst(*target);
            // or use self if not available
            else
                m_targets.SetDst(*m_caster);
        }
    }
    else
        m_targets.RemoveDst();

    if (neededTargets & TARGET_FLAG_SOURCE_LOCATION)
    {
        if (!targets.HasSrc())
            m_targets.SetSrc(*m_caster);
    }
    else
        m_targets.RemoveSrc();
}

void Spell::SelectExplicitTargets()
{
    // here go all explicit target changes made to explicit targets after spell prepare phase is finished
    if (Unit* target = m_targets.GetUnitTarget())
    {
        // check for explicit target redirection, for Grounding Totem for example
        if (m_spellInfo->GetExplicitTargetMask() & TARGET_FLAG_UNIT_ENEMY
                || (m_spellInfo->GetExplicitTargetMask() & TARGET_FLAG_UNIT
                    && (!m_spellInfo->IsPositive() || (!m_caster->IsFriendlyTo(target) && m_spellInfo->HasEffect(SPELL_EFFECT_DISPEL)))))
        {
            Unit* redirect;
            switch (m_spellInfo->DmgClass)
            {
                case SPELL_DAMAGE_CLASS_MAGIC:
                    redirect = m_caster->GetMagicHitRedirectTarget(target, m_spellInfo);
                    break;
                case SPELL_DAMAGE_CLASS_MELEE:
                case SPELL_DAMAGE_CLASS_RANGED:
                    redirect = m_caster->GetMeleeHitRedirectTarget(target, m_spellInfo);
                    break;
                default:
                    redirect = nullptr;
                    break;
            }
            if (redirect && (redirect != target))
            {
                m_targets.SetUnitTarget(redirect);
                m_spellFlags |= SPELL_FLAG_REDIRECTED;
            }
        }
    }
}

void Spell::SelectSpellTargets()
{
    // select targets for cast phase
    SelectExplicitTargets();

    uint32 processedAreaEffectsMask = 0;
    for (uint32 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        // not call for empty effect.
        // Also some spells use not used effect targets for store targets for dummy effect in triggered spells
        if (!m_spellInfo->Effects[i].IsEffect())
            continue;

        // set expected type of implicit targets to be sent to client
        uint32 implicitTargetMask = GetTargetFlagMask(m_spellInfo->Effects[i].TargetA.GetObjectType()) | GetTargetFlagMask(m_spellInfo->Effects[i].TargetB.GetObjectType());
        if (implicitTargetMask & TARGET_FLAG_UNIT)
            m_targets.SetTargetFlag(TARGET_FLAG_UNIT);
        if (implicitTargetMask & (TARGET_FLAG_GAMEOBJECT | TARGET_FLAG_GAMEOBJECT_ITEM))
            m_targets.SetTargetFlag(TARGET_FLAG_GAMEOBJECT);

        SelectEffectImplicitTargets(SpellEffIndex(i), m_spellInfo->Effects[i].TargetA, processedAreaEffectsMask);
        SelectEffectImplicitTargets(SpellEffIndex(i), m_spellInfo->Effects[i].TargetB, processedAreaEffectsMask);

        // Select targets of effect based on effect type
        // those are used when no valid target could be added for spell effect based on spell target type
        // some spell effects use explicit target as a default target added to target map (like SPELL_EFFECT_LEARN_SPELL)
        // some spell effects add target to target map only when target type specified (like SPELL_EFFECT_WEAPON)
        // some spell effects don't add anything to target map (confirmed with sniffs) (like SPELL_EFFECT_DESTROY_ALL_TOTEMS)
        SelectEffectTypeImplicitTargets(i);

        if (m_targets.HasDst())
            AddDestTarget(*m_targets.GetDst(), i);

        if (m_spellInfo->IsChanneled())
        {
            // maybe do this for all spells?
            if (!focusObject && m_UniqueTargetInfo.empty() && m_UniqueGOTargetInfo.empty() && m_UniqueItemInfo.empty() && !m_targets.HasDst())
            {
                SendCastResult(SPELL_FAILED_BAD_IMPLICIT_TARGETS);
                finish(false);
                return;
            }

            uint8 mask = (1 << i);
            for (auto ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
            {
                if (ihit->effectMask & mask)
                {
                    m_channelTargetEffectMask |= mask;
                    break;
                }
            }
        }
        else if (m_auraScaleMask)
        {
            bool checkLvl = !m_UniqueTargetInfo.empty();
            m_UniqueTargetInfo.erase(std::remove_if(std::begin(m_UniqueTargetInfo), std::end(m_UniqueTargetInfo), [&](TargetInfo const& targetInfo) -> bool
            {
                // remove targets which did not pass min level check
                if (m_auraScaleMask && targetInfo.effectMask == m_auraScaleMask)
                {
                    if (!targetInfo.scaleAura && targetInfo.targetGUID != m_caster->GetGUID())
                        return true;
                }

                return false;
            }), std::end(m_UniqueTargetInfo));

            if (checkLvl && m_UniqueTargetInfo.empty())
            {
                SendCastResult(SPELL_FAILED_LOWLEVEL);
                finish(false);
            }
        }
    }

    if (uint64 dstDelay = CalculateDelayMomentForDst())
        m_delayMoment = dstDelay;
}

uint64 Spell::CalculateDelayMomentForDst() const
{
    if (m_targets.HasDst())
    {
        if (m_targets.HasTraj())
        {
            float speed = m_targets.GetSpeedXY();
            if (speed > 0.0f)
                return (uint64)std::floor(m_targets.GetDist2d() / speed * 1000.0f);
        }
        else if (m_spellInfo->Speed > 0.0f)
        {
            // We should not subtract caster size from dist calculation (fixes execution time desync with animation on client, eg. Malleable Goo cast by PP)
            float dist = m_caster->GetExactDist(*m_targets.GetDstPos());
            return (uint64)std::floor(dist / m_spellInfo->Speed * 1000.0f);
        }
    }

    return 0;
}

void Spell::RecalculateDelayMomentForDst()
{
    m_delayMoment = CalculateDelayMomentForDst();
    m_caster->m_Events.ModifyEventTime(_spellEvent, Milliseconds(GetDelayStart() + m_delayMoment));
}

void Spell::SelectEffectImplicitTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType, uint32& processedEffectMask)
{
    if (!targetType.GetTarget())
        return;

    uint32 effectMask = 1 << effIndex;
    // set the same target list for all effects
    // some spells appear to need this, however this requires more research
    switch (targetType.GetSelectionCategory())
    {
        case TARGET_SELECT_CATEGORY_NEARBY:
        case TARGET_SELECT_CATEGORY_CONE:
        case TARGET_SELECT_CATEGORY_AREA:
        {
            // targets for effect already selected
            if (effectMask & processedEffectMask)
            {
                return;
            }

            auto const& effects = GetSpellInfo()->Effects;

            // choose which targets we can select at once
            for (uint32 j = effIndex + 1; j < MAX_SPELL_EFFECTS; ++j)
            {
                if (effects[j].IsEffect() &&
                    effects[effIndex].TargetA.GetTarget() == effects[j].TargetA.GetTarget() &&
                    effects[effIndex].TargetB.GetTarget() == effects[j].TargetB.GetTarget() &&
                    effects[effIndex].ImplicitTargetConditions == effects[j].ImplicitTargetConditions &&
                    effects[effIndex].CalcRadius(m_caster) == effects[j].CalcRadius(m_caster) &&
                    CheckScriptEffectImplicitTargets(effIndex, j))
                {
                    effectMask |= 1 << j;
                }
            }
            processedEffectMask |= effectMask;
            break;
        }
        default:
            break;
    }

    switch (targetType.GetSelectionCategory())
    {
        case TARGET_SELECT_CATEGORY_CHANNEL:
            SelectImplicitChannelTargets(effIndex, targetType);
            break;
        case TARGET_SELECT_CATEGORY_NEARBY:
            SelectImplicitNearbyTargets(effIndex, targetType, effectMask);
            break;
        case TARGET_SELECT_CATEGORY_CONE:
            SelectImplicitConeTargets(effIndex, targetType, effectMask);
            break;
        case TARGET_SELECT_CATEGORY_AREA:
            SelectImplicitAreaTargets(effIndex, targetType, effectMask);
            break;
        case TARGET_SELECT_CATEGORY_TRAJ:
            // just in case there is no dest, explanation in SelectImplicitDestDestTargets
            CheckDst();

            SelectImplicitTrajTargets(effIndex, targetType);
            break;
        case TARGET_SELECT_CATEGORY_DEFAULT:
            switch (targetType.GetObjectType())
            {
                case TARGET_OBJECT_TYPE_SRC:
                    switch (targetType.GetReferenceType())
                    {
                        case TARGET_REFERENCE_TYPE_CASTER:
                            m_targets.SetSrc(*m_caster);
                            break;
                        default:
                            ASSERT(false && "Spell::SelectEffectImplicitTargets: received not implemented select target reference type for TARGET_TYPE_OBJECT_SRC");
                            break;
                    }
                    break;
                case TARGET_OBJECT_TYPE_DEST:
                    switch (targetType.GetReferenceType())
                    {
                        case TARGET_REFERENCE_TYPE_CASTER:
                            SelectImplicitCasterDestTargets(effIndex, targetType);
                            break;
                        case TARGET_REFERENCE_TYPE_TARGET:
                            SelectImplicitTargetDestTargets(effIndex, targetType);
                            break;
                        case TARGET_REFERENCE_TYPE_DEST:
                            SelectImplicitDestDestTargets(effIndex, targetType);
                            break;
                        default:
                            ASSERT(false && "Spell::SelectEffectImplicitTargets: received not implemented select target reference type for TARGET_TYPE_OBJECT_DEST");
                            break;
                    }
                    break;
                default:
                    switch (targetType.GetReferenceType())
                    {
                        case TARGET_REFERENCE_TYPE_CASTER:
                            SelectImplicitCasterObjectTargets(effIndex, targetType);
                            break;
                        case TARGET_REFERENCE_TYPE_TARGET:
                            SelectImplicitTargetObjectTargets(effIndex, targetType);
                            break;
                        default:
                            ASSERT(false && "Spell::SelectEffectImplicitTargets: received not implemented select target reference type for TARGET_TYPE_OBJECT");
                            break;
                    }
                    break;
            }
            break;
        case TARGET_SELECT_CATEGORY_NYI:
            LOG_DEBUG("spells.aura", "SPELL: target type {}, found in spellID {}, effect {} is not implemented yet!", m_spellInfo->Id, effIndex, targetType.GetTarget());
            break;
        default:
            ASSERT(false && "Spell::SelectEffectImplicitTargets: received not implemented select target category");
            break;
    }
}

void Spell::SelectImplicitChannelTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType)
{
    if (targetType.GetReferenceType() != TARGET_REFERENCE_TYPE_CASTER)
    {
        ASSERT(false && "Spell::SelectImplicitChannelTargets: received not implemented target reference type");
        return;
    }

    switch (targetType.GetTarget())
    {
        case TARGET_UNIT_CHANNEL_TARGET:
            {
                // Xinef: All channel selectors have needed data passed in m_targets structure
                WorldObject* target = m_targets.GetObjectTargetChannel(m_caster);
                if (target)
                {
                    CallScriptObjectTargetSelectHandlers(target, effIndex, targetType);
                    // unit target may be no longer avalible - teleported out of map for example
                    if (target && target->ToUnit())
                        AddUnitTarget(target->ToUnit(), 1 << effIndex);
                }
                else
                {
                    LOG_DEBUG("spells.aura", "SPELL: cannot find channel spell target for spell ID {}, effect {}", m_spellInfo->Id, effIndex);
                }
                break;
            }
        case TARGET_DEST_CHANNEL_TARGET:
            if (m_targets.HasDstChannel())
                m_targets.SetDst(*m_targets.GetDstChannel());
            else if (WorldObject* target = m_targets.GetObjectTargetChannel(m_caster))
            {
                CallScriptObjectTargetSelectHandlers(target, effIndex, targetType);
                if (target)
                    m_targets.SetDst(*target);
            }
            else if (Spell* channeledSpell = m_originalCaster->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
            {
                if (channeledSpell->m_targets.GetUnitTarget())
                    m_targets.SetDst(*channeledSpell->m_targets.GetUnitTarget());
            }
            else //if (!m_targets.HasDst())
            {
                LOG_DEBUG("spells.aura", "SPELL: cannot find channel spell destination for spell ID {}, effect {}", m_spellInfo->Id, effIndex);
            }
            break;
        case TARGET_DEST_CHANNEL_CASTER:
            if (GetOriginalCaster())
                m_targets.SetDst(*GetOriginalCaster());
            break;
        default:
            ASSERT(false && "Spell::SelectImplicitChannelTargets: received not implemented target type");
            break;
    }
}

void Spell::SelectImplicitNearbyTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType, uint32 effMask)
{
    if (targetType.GetReferenceType() != TARGET_REFERENCE_TYPE_CASTER)
    {
        ASSERT(false && "Spell::SelectImplicitNearbyTargets: received not implemented target reference type");
        return;
    }

    float range = 0.0f;
    switch (targetType.GetCheckType())
    {
        case TARGET_CHECK_ENEMY:
            range = m_spellInfo->GetMaxRange(false, m_caster, this);
            break;
        case TARGET_CHECK_ALLY:
        case TARGET_CHECK_PARTY:
        case TARGET_CHECK_RAID:
        case TARGET_CHECK_RAID_CLASS:
            range = m_spellInfo->GetMaxRange(true, m_caster, this);
            break;
        case TARGET_CHECK_ENTRY:
        case TARGET_CHECK_DEFAULT:
            range = m_spellInfo->GetMaxRange(m_spellInfo->IsPositive(), m_caster, this);
            break;
        default:
            ASSERT(false && "Spell::SelectImplicitNearbyTargets: received not implemented selection check type");
            break;
    }

    ConditionList* condList = m_spellInfo->Effects[effIndex].ImplicitTargetConditions;

    // handle emergency case - try to use other provided targets if no conditions provided
    if (targetType.GetCheckType() == TARGET_CHECK_ENTRY && (!condList || condList->empty()))
    {
        LOG_DEBUG("spells.aura", "Spell::SelectImplicitNearbyTargets: no conditions entry for target with TARGET_CHECK_ENTRY of spell ID {}, effect {} - selecting default targets", m_spellInfo->Id, effIndex);
        switch (targetType.GetObjectType())
        {
            case TARGET_OBJECT_TYPE_GOBJ:
                if (m_spellInfo->RequiresSpellFocus)
                {
                    if (focusObject)
                        AddGOTarget(focusObject, effMask);
                    return;
                }
                break;
            case TARGET_OBJECT_TYPE_DEST:
                if (m_spellInfo->RequiresSpellFocus)
                {
                    if (focusObject)
                        m_targets.SetDst(*focusObject);
                    return;
                }
                break;
            default:
                break;
        }
    }

    WorldObject* target = SearchNearbyTarget(range, targetType.GetObjectType(), targetType.GetCheckType(), condList);
    if (!target)
    {
        LOG_DEBUG("spells.aura", "Spell::SelectImplicitNearbyTargets: cannot find nearby target for spell ID {}, effect {}", m_spellInfo->Id, effIndex);
        return;
    }

    CallScriptObjectTargetSelectHandlers(target, effIndex, targetType);
    if (!target)
    {
        //LOG_DEBUG("spells", "Spell::SelectImplicitNearbyTargets: OnObjectTargetSelect script hook for spell Id {} set nullptr target, effect {}", m_spellInfo->Id, effIndex);
        return;
    }

    switch (targetType.GetObjectType())
    {
        case TARGET_OBJECT_TYPE_UNIT:
            {
                if (Unit* unit = target->ToUnit())
                {
                    AddUnitTarget(unit, effMask, true, false);
                    // xinef: important! if channeling spell have nearby entry, it has no unitTarget by default
                    // and if channeled spell has target 77, it requires unitTarget, set it here!
                    // xinef: if we have NO unit target
                    if (!m_targets.GetUnitTarget())
                    {
                        m_targets.SetUnitTarget(unit);
                    }
                }
                else
                {
                    //LOG_DEBUG("spells", "Spell::SelectImplicitNearbyTargets: OnObjectTargetSelect script hook for spell Id {} set object of wrong type, expected unit, got {}, effect {}", m_spellInfo->Id, target->GetGUID().GetTypeName(), effMask);
                    return;
                }
                break;
            }
        case TARGET_OBJECT_TYPE_GOBJ:
            if (GameObject* gobjTarget = target->ToGameObject())
                AddGOTarget(gobjTarget, effMask);
            else
            {
                //LOG_DEBUG("spells", "Spell::SelectImplicitNearbyTargets: OnObjectTargetSelect script hook for spell Id {} set object of wrong type, expected gameobject, got {}, effect {}", m_spellInfo->Id, target->GetGUID().GetTypeName(), effMask);
                return;
            }
            break;
        case TARGET_OBJECT_TYPE_DEST:
            m_targets.SetDst(*target);
            break;
        default:
            ASSERT(false && "Spell::SelectImplicitNearbyTargets: received not implemented target object type");
            break;
    }

    SelectImplicitChainTargets(effIndex, targetType, target, effMask);
}

void Spell::SelectImplicitConeTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType, uint32 effMask)
{
    if (targetType.GetReferenceType() != TARGET_REFERENCE_TYPE_CASTER)
    {
        ASSERT(false && "Spell::SelectImplicitConeTargets: received not implemented target reference type");
        return;
    }
    std::list<WorldObject*> targets;
    SpellTargetObjectTypes objectType = targetType.GetObjectType();
    SpellTargetCheckTypes selectionType = targetType.GetCheckType();
    ConditionList* condList = m_spellInfo->Effects[effIndex].ImplicitTargetConditions;
    float coneAngle = M_PI / 2;
    float radius = m_spellInfo->Effects[effIndex].CalcRadius(m_caster) * m_spellValue->RadiusMod;

    if (uint32 containerTypeMask = GetSearcherTypeMask(objectType, condList))
    {
        Acore::WorldObjectSpellConeTargetCheck check(coneAngle, radius, m_caster, m_spellInfo, selectionType, condList);
        Acore::WorldObjectListSearcher<Acore::WorldObjectSpellConeTargetCheck> searcher(m_caster, targets, check, containerTypeMask);
        SearchTargets<Acore::WorldObjectListSearcher<Acore::WorldObjectSpellConeTargetCheck> >(searcher, containerTypeMask, m_caster, m_caster, radius);

        CallScriptObjectAreaTargetSelectHandlers(targets, effIndex, targetType);

        if (!targets.empty())
        {
            // Other special target selection goes here
            if (uint32 maxTargets = m_spellValue->MaxAffectedTargets)
            {
                Unit::AuraEffectList const& Auras = m_caster->GetAuraEffectsByType(SPELL_AURA_MOD_MAX_AFFECTED_TARGETS);
                for (Unit::AuraEffectList::const_iterator j = Auras.begin(); j != Auras.end(); ++j)
                    if ((*j)->IsAffectedOnSpell(m_spellInfo))
                        maxTargets += (*j)->GetAmount();

                //npcbot - apply bot spell max targets mods
                if (m_caster->IsNPCBot())
                    m_caster->ToCreature()->ApplyCreatureSpellMaxTargetsMods(m_spellInfo, maxTargets);
                //end npcbot

                Acore::Containers::RandomResize(targets, maxTargets);
            }

            for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
            {
                if (Unit* unit = (*itr)->ToUnit())
                {
                    AddUnitTarget(unit, effMask, false);
                }
                else if (GameObject* gObjTarget = (*itr)->ToGameObject())
                {
                    AddGOTarget(gObjTarget, effMask);
                }
            }
        }
    }
}

void Spell::SelectImplicitAreaTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType, uint32 effMask)
{
    Unit* referer = nullptr;
    switch (targetType.GetReferenceType())
    {
        case TARGET_REFERENCE_TYPE_SRC:
        case TARGET_REFERENCE_TYPE_DEST:
        case TARGET_REFERENCE_TYPE_CASTER:
            referer = m_caster;
            break;
        case TARGET_REFERENCE_TYPE_TARGET:
            referer = m_targets.GetUnitTarget();
            break;
        case TARGET_REFERENCE_TYPE_LAST:
            {
                // find last added target for this effect
                for (std::list<TargetInfo>::reverse_iterator ihit = m_UniqueTargetInfo.rbegin(); ihit != m_UniqueTargetInfo.rend(); ++ihit)
                {
                    if (ihit->effectMask & (1 << effIndex))
                    {
                        referer = ObjectAccessor::GetUnit(*m_caster, ihit->targetGUID);
                        break;
                    }
                }
                break;
            }
        default:
            ASSERT(false && "Spell::SelectImplicitAreaTargets: received not implemented target reference type");
            return;
    }
    if (!referer)
        return;

    Position const* center = nullptr;
    switch (targetType.GetReferenceType())
    {
        case TARGET_REFERENCE_TYPE_SRC:
            center = m_targets.GetSrcPos();
            break;
        case TARGET_REFERENCE_TYPE_DEST:
            center = m_targets.GetDstPos();
            break;
        case TARGET_REFERENCE_TYPE_CASTER:
        case TARGET_REFERENCE_TYPE_TARGET:
        case TARGET_REFERENCE_TYPE_LAST:
            center = referer;
            break;
        default:
            ASSERT(false && "Spell::SelectImplicitAreaTargets: received not implemented target reference type");
            return;
    }

    // Xinef: the distance should be increased by caster size, it is neglected in latter calculations
    std::list<WorldObject*> targets;
    float radius = m_spellInfo->Effects[effIndex].CalcRadius(m_caster) * m_spellValue->RadiusMod;
    SearchAreaTargets(targets, radius, center, referer, targetType.GetObjectType(), targetType.GetCheckType(), m_spellInfo->Effects[effIndex].ImplicitTargetConditions);

    CallScriptObjectAreaTargetSelectHandlers(targets, effIndex, targetType);

    if (!targets.empty())
    {
        // Other special target selection goes here
        if (uint32 maxTargets = m_spellValue->MaxAffectedTargets)
        {
            Unit::AuraEffectList const& Auras = m_caster->GetAuraEffectsByType(SPELL_AURA_MOD_MAX_AFFECTED_TARGETS);
            for (Unit::AuraEffectList::const_iterator j = Auras.begin(); j != Auras.end(); ++j)
                if ((*j)->IsAffectedOnSpell(m_spellInfo))
                    maxTargets += (*j)->GetAmount();

            Acore::Containers::RandomResize(targets, maxTargets);
        }

        for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
        {
            if (Unit* unitTarget = (*itr)->ToUnit())
                AddUnitTarget(unitTarget, effMask, false);
            else if (GameObject* gObjTarget = (*itr)->ToGameObject())
                AddGOTarget(gObjTarget, effMask);
        }
    }
}

void Spell::SelectImplicitCasterDestTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType)
{
    SpellDestination dest(*m_caster);

    switch (targetType.GetTarget())
    {
        case TARGET_DEST_CASTER:
        case TARGET_DEST_CASTER_36:
            break;
        case TARGET_DEST_HOME:
            if (Player* playerCaster = m_caster->ToPlayer())
                dest = SpellDestination(playerCaster->m_homebindX, playerCaster->m_homebindY, playerCaster->m_homebindZ, playerCaster->GetOrientation(), playerCaster->m_homebindMapId);
            break;
        case TARGET_DEST_DB:
            if (SpellTargetPosition const* st = sSpellMgr->GetSpellTargetPosition(m_spellInfo->Id, effIndex))
            {
                /// @todo fix this check
                if (m_spellInfo->HasEffect(SPELL_EFFECT_TELEPORT_UNITS) || m_spellInfo->HasEffect(SPELL_EFFECT_BIND))
                    dest = SpellDestination(st->target_X, st->target_Y, st->target_Z, st->target_Orientation, (int32)st->target_mapId);
                else if (st->target_mapId == m_caster->GetMapId())
                    dest = SpellDestination(st->target_X, st->target_Y, st->target_Z, st->target_Orientation);
            }
            else
            {
                LOG_DEBUG("spells.aura", "SPELL: unknown target coordinates for spell ID {}", m_spellInfo->Id);
                if (WorldObject* target = m_targets.GetObjectTarget())
                    dest = SpellDestination(*target);
            }
            break;
        case TARGET_DEST_CASTER_FISHING:
            {
                float min_dis = m_spellInfo->GetMinRange(true);
                float max_dis = m_spellInfo->GetMaxRange(true);
                float dis = (float)rand_norm() * (max_dis - min_dis) + min_dis;
                float x, y, z, angle;
                angle = (float)rand_norm() * static_cast<float>(M_PI * 35.0f / 180.0f) - static_cast<float>(M_PI * 17.5f / 180.0f);
                //m_caster->GetClosePoint(x, y, z, DEFAULT_WORLD_OBJECT_SIZE, dis, angle); this contains extra code that breaks fishing
                m_caster->GetNearPoint(m_caster, x, y, z, DEFAULT_WORLD_OBJECT_SIZE, dis, m_caster->GetOrientation() + angle);

                float ground = m_caster->GetMapHeight(x, y, z, true);
                float liquidLevel = VMAP_INVALID_HEIGHT_VALUE;
                LiquidData const& liquidData = m_caster->GetMap()->GetLiquidData(m_caster->GetPhaseMask(), x, y, z, m_caster->GetCollisionHeight(), MAP_ALL_LIQUIDS);
                if (liquidData.Status)
                    liquidLevel = liquidData.Level;

                if (liquidLevel <= ground) // When there is no liquid Map::GetWaterOrGroundLevel returns ground level
                {
                    SendCastResult(SPELL_FAILED_NOT_HERE);
                    SendChannelUpdate(0);
                    finish(false);
                    return;
                }

                if (ground + 0.75 > liquidLevel)
                {
                    SendCastResult(SPELL_FAILED_TOO_SHALLOW);
                    SendChannelUpdate(0);
                    finish(false);
                    return;
                }

                if (!m_caster->IsWithinLOS(x, y, z))
                {
                    SendCastResult(SPELL_FAILED_LINE_OF_SIGHT);
                    SendChannelUpdate(0);
                    finish(false);
                    return;
                }

                dest = SpellDestination(x, y, liquidLevel, m_caster->GetOrientation());
                break;
            }
        case TARGET_DEST_CASTER_FRONT_LEAP:
            {
                float distance = m_spellInfo->Effects[effIndex].CalcRadius(m_caster);
                Map* map = m_caster->GetMap();
                uint32 mapid = m_caster->GetMapId();
                uint32 phasemask = m_caster->GetPhaseMask();
                float collisionHeight = m_caster->GetCollisionHeight();
                float destz = 0.0f, startx = 0.0f, starty = 0.0f, startz = 0.0f, starto = 0.0f;

                Position pos;
                Position lastpos;
                m_caster->GetPosition(startx, starty, startz, starto);
                pos.Relocate(startx, starty, startz, starto);
                float destx = pos.GetPositionX() + distance * cos(pos.GetOrientation());
                float desty = pos.GetPositionY() + distance * sin(pos.GetOrientation());

                float ground = map->GetHeight(phasemask, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ());

                bool isCasterInWater = m_caster->IsInWater();
                if (!m_caster->HasUnitMovementFlag(MOVEMENTFLAG_FALLING) || (pos.GetPositionZ() - ground < distance))
                {
                    float tstX = 0.0f, tstY = 0.0f, tstZ = 0.0f, prevX = 0.0f, prevY = 0.0f, prevZ = 0.0f;
                    float tstZ1 = 0.0f, tstZ2 = 0.0f, tstZ3 = 0.0f, destz1 = 0.0f, destz2 = 0.0f, destz3 = 0.0f, srange = 0.0f, srange1 = 0.0f, srange2 = 0.0f, srange3 = 0.0f;
                    float maxtravelDistZ = 2.65f;
                    float overdistance = 0.0f;
                    float totalpath = 0.0f;
                    float beforewaterz = 0.0f;
                    bool inwater = false;
                    bool wcol = false;
                    const float  step = 2.0f;
                    const uint8 numChecks = std::ceil(std::fabs(distance / step));
                    const float DELTA_X = (destx - pos.GetPositionX()) / numChecks;
                    const float DELTA_Y = (desty - pos.GetPositionY()) / numChecks;
                    int j = 1;
                    for (; j < (numChecks + 1); j++)
                    {
                        prevX = pos.GetPositionX() + (float(j - 1) * DELTA_X);
                        prevY = pos.GetPositionY() + (float(j - 1) * DELTA_Y);
                        tstX = pos.GetPositionX() + (float(j) * DELTA_X);
                        tstY = pos.GetPositionY() + (float(j) * DELTA_Y);

                        if (j < 2)
                        {
                            prevZ = pos.GetPositionZ();
                        }
                        else
                        {
                            prevZ = tstZ;
                        }

                        tstZ = map->GetHeight(phasemask, tstX, tstY, prevZ + maxtravelDistZ, true);
                        ground = tstZ;

                        if (!isCasterInWater)
                        {
                            if (map->IsInWater(phasemask, tstX, tstY, tstZ, collisionHeight))
                            {
                                if (!(beforewaterz != 0.0f))
                                {
                                    beforewaterz = prevZ;
                                }
                                tstZ = beforewaterz;
                                srange = sqrt((tstY - prevY) * (tstY - prevY) + (tstX - prevX) * (tstX - prevX));
                                //LOG_ERROR("spells", "(start was from land) step in water , number of cycle = {} , distance of step = {}, total path = {}, Z = {}", j, srange, totalpath, tstZ);
                            }
                        }
                        else if (map->IsInWater(phasemask, tstX, tstY, tstZ, collisionHeight))
                        {
                            prevZ = pos.GetPositionZ();
                            tstZ = pos.GetPositionZ();
                            srange = sqrt((tstY - prevY) * (tstY - prevY) + (tstX - prevX) * (tstX - prevX));

                            inwater = true;
                            if (inwater && (fabs(tstZ - ground) < 2.0f))
                            {
                                wcol = true;
                                //LOG_ERROR("spells", "step in water with collide and use standart check (for continue way after possible collide), number of cycle = {} ", j);
                            }

                            // if (j < 2)
                            //    LOG_ERROR("spells", "(start in water) step in water, number of cycle = {} , distance of step = {}, total path = {}", j, srange, totalpath);
                            // else
                            //    LOG_ERROR("spells", "step in water, number of cycle = {} , distance of step = {}, total path = {}", j, srange, totalpath);
                        }

                        bool IsInWater = map->IsInWater(phasemask, tstX, tstY, tstZ, collisionHeight);
                        if ((!IsInWater && tstZ != beforewaterz) || wcol)  // second safety check z for blink way if on the ground
                        {
                            if (inwater && !IsInWater)
                                inwater = false;

                            // highest available point
                            tstZ1 = map->GetHeight(phasemask, tstX, tstY, prevZ + maxtravelDistZ, true, 25.0f);
                            // upper or floor
                            tstZ2 = map->GetHeight(phasemask, tstX, tstY, prevZ, true, 25.0f);
                            //lower than floor
                            tstZ3 = map->GetHeight(phasemask, tstX, tstY, prevZ - maxtravelDistZ / 2, true, 25.0f);

                            //distance of rays, will select the shortest in 3D
                            srange1 = sqrt((tstY - prevY) * (tstY - prevY) + (tstX - prevX) * (tstX - prevX) + (tstZ1 - prevZ) * (tstZ1 - prevZ));
                            //LOG_ERROR("spells", "step = {}, distance of ray1 = {}", j, srange1);
                            srange2 = sqrt((tstY - prevY) * (tstY - prevY) + (tstX - prevX) * (tstX - prevX) + (tstZ2 - prevZ) * (tstZ2 - prevZ));
                            //LOG_ERROR("spells", "step = {}, distance of ray2 = {}", j, srange2);
                            srange3 = sqrt((tstY - prevY) * (tstY - prevY) + (tstX - prevX) * (tstX - prevX) + (tstZ3 - prevZ) * (tstZ3 - prevZ));
                            //LOG_ERROR("spells", "step = {}, distance of ray3 = {}", j, srange3);

                            if (srange1 < srange2)
                            {
                                tstZ = tstZ1;
                                srange = srange1;
                            }
                            else if (srange3 < srange2)
                            {
                                tstZ = tstZ3;
                                srange = srange3;
                            }
                            else
                            {
                                tstZ = tstZ2;
                                srange = srange2;
                            }

                            //LOG_ERROR("spells", "step on ground, number of cycle = {} , distance of step = {}, total path = {}", j, srange, totalpath);
                        }

                        destx = tstX;
                        desty = tstY;
                        destz = tstZ;

                        totalpath += srange;

                        if (totalpath > distance)
                        {
                            overdistance = totalpath - distance;
                            //LOG_ERROR("spells", "total path > than distance in 3D , need to move back a bit for save distance, total path = {}, overdistance = {}", totalpath, overdistance);
                        }

                        bool col = VMAP::VMapFactory::createOrGetVMapMgr()->GetObjectHitPos(mapid, prevX, prevY, prevZ + 0.5f, tstX, tstY, tstZ + 0.5f, tstX, tstY, tstZ, -0.5f);
                        // check dynamic collision
                        bool dcol = m_caster->GetMap()->GetObjectHitPos(phasemask, prevX, prevY, prevZ + 0.5f, tstX, tstY, tstZ + 0.5f, tstX, tstY, tstZ, -0.5f);

                        // collision occured
                        if (col || dcol || (overdistance > 0.0f && !map->IsInWater(phasemask, tstX, tstY, ground, collisionHeight)) || (fabs(prevZ - tstZ) > maxtravelDistZ && (tstZ > prevZ)))
                        {
                            if ((overdistance > 0.0f) && (overdistance < 1.f))
                            {
                                destx = prevX + overdistance * cos(pos.GetOrientation());
                                desty = prevY + overdistance * sin(pos.GetOrientation());
                                //LOG_ERROR("spells", "(collision) collision occured 1");
                            }
                            else
                            {
                                // move back a bit
                                destx = tstX - (0.6 * cos(pos.GetOrientation()));
                                desty = tstY - (0.6 * sin(pos.GetOrientation()));
                                //LOG_ERROR("spells", "(collision) collision occured 2");
                            }

                            // highest available point
                            destz1 = map->GetHeight(phasemask, destx, desty, prevZ + maxtravelDistZ, true, 25.0f);
                            // upper or floor
                            destz2 = map->GetHeight(phasemask, destx, desty, prevZ, true, 25.0f);
                            //lower than floor
                            destz3 = map->GetHeight(phasemask, destx, desty, prevZ - maxtravelDistZ / 2, true, 25.0f);

                            //distance of rays, will select the shortest in 3D
                            srange1 = sqrt((desty - prevY) * (desty - prevY) + (destx - prevX) * (destx - prevX) + (destz1 - prevZ) * (destz1 - prevZ));
                            srange2 = sqrt((desty - prevY) * (desty - prevY) + (destx - prevX) * (destx - prevX) + (destz2 - prevZ) * (destz2 - prevZ));
                            srange3 = sqrt((desty - prevY) * (desty - prevY) + (destx - prevX) * (destx - prevX) + (destz3 - prevZ) * (destz3 - prevZ));

                            if (srange1 < srange2)
                                destz = destz1;
                            else if (srange3 < srange2)
                                destz = destz3;
                            else
                                destz = destz2;

                            if (inwater && destz < prevZ && !wcol)
                                destz = prevZ;
                            //LOG_ERROR("spells", "(collision) destZ rewrited in prevZ");

                            // Don't make the player move backward from the xy adjustments by collisions.
                            if ((DELTA_X > 0 && startx > destx) || (DELTA_X < 0 && startx < destx) ||
                                (DELTA_Y > 0 && starty > desty) || (DELTA_Y < 0 && starty < desty))
                            {
                                destx = startx;
                                desty = starty;
                                destz = startz;
                            }

                            break;
                        }
                        // we have correct destz now
                    }

                    lastpos.Relocate(destx, desty, destz, pos.GetOrientation());
                    dest = SpellDestination(lastpos);
                }
                else
                {
                    float z = pos.GetPositionZ();
                    bool col = VMAP::VMapFactory::createOrGetVMapMgr()->GetObjectHitPos(mapid, pos.GetPositionX(), pos.GetPositionY(), z, destx, desty, z, destx, desty, z, -0.5f);
                    // check dynamic collision
                    bool dcol = m_caster->GetMap()->GetObjectHitPos(phasemask, pos.GetPositionX(), pos.GetPositionY(), z, destx, desty, z, destx, desty, z, -0.5f);

                    // collision occured
                    if (col || dcol)
                    {
                        // move back a bit
                        destx = destx - (0.6 * cos(pos.GetOrientation()));
                        desty = desty - (0.6 * sin(pos.GetOrientation()));
                    }

                    lastpos.Relocate(destx, desty, z, pos.GetOrientation());
                    dest = SpellDestination(lastpos);
                    //float range = sqrt((desty - pos.GetPositionY())*(desty - pos.GetPositionY()) + (destx - pos.GetPositionX())*(destx - pos.GetPositionX()));
                    //LOG_ERROR("spells", "Blink number 2, in falling but at a hight, distance of blink = {}", range);
                }
                break;
            }
        default:
            {
                float dist = m_spellInfo->Effects[effIndex].CalcRadius(m_caster);
                float angle = targetType.CalcDirectionAngle();
                float objSize = m_caster->GetCombatReach();

                switch (targetType.GetTarget())
                {
                case TARGET_DEST_CASTER_SUMMON:
                    dist = PET_FOLLOW_DIST;
                    break;
                case TARGET_DEST_CASTER_RANDOM:
                    if (dist > objSize)
                        dist = objSize + (dist - objSize) * float(rand_norm());
                    break;
                case TARGET_DEST_CASTER_FRONT_LEFT:
                case TARGET_DEST_CASTER_BACK_LEFT:
                case TARGET_DEST_CASTER_FRONT_RIGHT:
                case TARGET_DEST_CASTER_BACK_RIGHT:
                {
                    static float const DefaultTotemDistance = 3.0f;
                    if (!m_spellInfo->Effects[effIndex].HasRadius())
                        dist = DefaultTotemDistance;
                    break;
                }
                default:
                    break;
                }

                if (dist < objSize)
                {
                    dist = objSize;
                }

                Position pos = dest._position;
                m_caster->MovePositionToFirstCollision(pos, dist, angle);

                dest.Relocate(pos);
                break;
            }
    }

    CallScriptDestinationTargetSelectHandlers(dest, effIndex, targetType);
    m_targets.SetDst(dest);
}

void Spell::SelectImplicitTargetDestTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType)
{
    WorldObject* target = m_targets.GetObjectTarget();

    SpellDestination dest(*target);

    switch (targetType.GetTarget())
    {
        case TARGET_DEST_TARGET_ENEMY:
        case TARGET_DEST_TARGET_ANY:
            break;
        default:
        {
            float angle = targetType.CalcDirectionAngle();
            float dist = m_spellInfo->Effects[effIndex].CalcRadius(nullptr);
            if (targetType.GetTarget() == TARGET_DEST_TARGET_RANDOM)
            {
                dist *= float(rand_norm());
            }

            if (targetType.GetTarget() == TARGET_DEST_TARGET_BACK)
            {
                dist += target->GetFloatValue(UNIT_FIELD_BOUNDINGRADIUS);
            }

            Position pos = dest._position;
            target->MovePositionToFirstCollision(pos, dist, angle);

            dest.Relocate(pos);
            break;
        }
    }

    CallScriptDestinationTargetSelectHandlers(dest, effIndex, targetType);
    m_targets.SetDst(dest);
}

void Spell::SelectImplicitDestDestTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType)
{
    // set destination to caster if no dest provided
    // can only happen if previous destination target could not be set for some reason
    // (not found nearby target, or channel target for example
    // maybe we should abort the spell in such case?
    CheckDst();

    SpellDestination dest(*m_targets.GetDst());

    switch (targetType.GetTarget())
    {
        case TARGET_DEST_DYNOBJ_ENEMY:
        case TARGET_DEST_DYNOBJ_ALLY:
        case TARGET_DEST_DYNOBJ_NONE:
        case TARGET_DEST_DEST:
            return;
        case TARGET_DEST_TRAJ:
            SelectImplicitTrajTargets(effIndex, targetType);
            return;
        default:
        {
            float angle = targetType.CalcDirectionAngle();
            float dist = m_spellInfo->Effects[effIndex].CalcRadius(m_caster);
            if (targetType.GetTarget() == TARGET_DEST_DEST_RANDOM)
                dist *= float(rand_norm());

            Position pos = dest._position;
            m_caster->MovePosition(pos, dist, angle);

            dest.Relocate(pos);
            break;
        }
    }

    CallScriptDestinationTargetSelectHandlers(dest, effIndex, targetType);
    m_targets.ModDst(dest);
}

void Spell::SelectImplicitCasterObjectTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType)
{
    WorldObject* target = nullptr;
    bool checkIfValid = true;

    switch (targetType.GetTarget())
    {
        case TARGET_UNIT_CASTER:
            target = m_caster;
            checkIfValid = false;
            break;
        case TARGET_UNIT_MASTER:
            target = m_caster->GetCharmerOrOwner();
            break;
        case TARGET_UNIT_PET:
            target = m_caster->GetGuardianPet();
            if (!target)
                target = m_caster->GetCharm();
            //npcbot: allow bot pet as target
            if (!target && m_caster->IsNPCBot())
                target = m_caster->ToCreature()->GetBotsPet();
            //end npcbot
            break;
        case TARGET_UNIT_SUMMONER:
            if (m_caster->IsSummon())
                target = m_caster->ToTempSummon()->GetSummonerUnit();
            break;
        case TARGET_UNIT_VEHICLE:
            target = m_caster->GetVehicleBase();
            break;
        case TARGET_UNIT_PASSENGER_0:
        case TARGET_UNIT_PASSENGER_1:
        case TARGET_UNIT_PASSENGER_2:
        case TARGET_UNIT_PASSENGER_3:
        case TARGET_UNIT_PASSENGER_4:
        case TARGET_UNIT_PASSENGER_5:
        case TARGET_UNIT_PASSENGER_6:
        case TARGET_UNIT_PASSENGER_7:
            if (m_caster->IsCreature() && m_caster->ToCreature()->IsVehicle())
                target = m_caster->GetVehicleKit()->GetPassenger(targetType.GetTarget() - TARGET_UNIT_PASSENGER_0);
            break;
        default:
            break;
    }

    CallScriptObjectTargetSelectHandlers(target, effIndex, targetType);

    if (target && target->ToUnit())
        AddUnitTarget(target->ToUnit(), 1 << effIndex, checkIfValid);
}

void Spell::SelectImplicitTargetObjectTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType)
{
    ASSERT((m_targets.GetObjectTarget() || m_targets.GetItemTarget()) && "Spell::SelectImplicitTargetObjectTargets - no explicit object or item target available!");

    WorldObject* target = m_targets.GetObjectTarget();

    CallScriptObjectTargetSelectHandlers(target, effIndex, targetType);

    if (target)
    {
        if (Unit* unit = target->ToUnit())
            AddUnitTarget(unit, 1 << effIndex, true, false);
        else if (GameObject* gobj = target->ToGameObject())
            AddGOTarget(gobj, 1 << effIndex);

        SelectImplicitChainTargets(effIndex, targetType, target, 1 << effIndex);
    }
    // Script hook can remove object target and we would wrongly land here
    else if (Item* item = m_targets.GetItemTarget())
        AddItemTarget(item, 1 << effIndex);
}

void Spell::SelectImplicitChainTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType, WorldObject* target, uint32 effMask)
{
    uint32 maxTargets = m_spellInfo->Effects[effIndex].ChainTarget;
    if (Player* modOwner = m_caster->GetSpellModOwner())
        modOwner->ApplySpellMod(m_spellInfo->Id, SPELLMOD_JUMP_TARGETS, maxTargets, this);

    //npcbot - apply bot spell max targets mods
    if (m_caster->IsNPCBot())
        m_caster->ToCreature()->ApplyCreatureSpellMaxTargetsMods(m_spellInfo, maxTargets);
    //end npcbot

    if (maxTargets > 1)
    {
        // mark damage multipliers as used
        for (uint32 k = effIndex; k < MAX_SPELL_EFFECTS; ++k)
            if (effMask & (1 << k))
                m_damageMultipliers[k] = 1.0f;
        m_applyMultiplierMask |= effMask;

        std::list<WorldObject*> targets;
        SearchChainTargets(targets, maxTargets - 1, target, targetType.GetObjectType(), targetType.GetCheckType(), targetType.GetSelectionCategory()
                           , m_spellInfo->Effects[effIndex].ImplicitTargetConditions, targetType.GetTarget() == TARGET_UNIT_TARGET_CHAINHEAL_ALLY);

        // Chain primary target is added earlier
        CallScriptObjectAreaTargetSelectHandlers(targets, effIndex, targetType);

        for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
            if (Unit* unitTarget = (*itr)->ToUnit())
                AddUnitTarget(unitTarget, effMask, false);
    }
}

float tangent(float x)
{
    x = tan(x);
    //if (x < std::numeric_limits<float>::max() && x > -std::numeric_limits<float>::max()) return x;
    //if (x >= std::numeric_limits<float>::max()) return std::numeric_limits<float>::max();
    //if (x <= -std::numeric_limits<float>::max()) return -std::numeric_limits<float>::max();
    if (x < 100000.0f && x > -100000.0f) return x;
    if (x >= 100000.0f) return 100000.0f;
    if (x <= 100000.0f) return -100000.0f;
    return 0.0f;
}

#define DEBUG_TRAJ(a) //a

void Spell::SelectImplicitTrajTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType)
{
    if (!m_targets.HasTraj())
        return;

    float dist2d = m_targets.GetDist2d();
    if (!dist2d)
        return;

    float srcToDestDelta = m_targets.GetDstPos()->m_positionZ - m_targets.GetSrcPos()->m_positionZ;

    // xinef: supply correct target type, DEST_DEST and similar are ALWAYS undefined
    // xinef: correct target is stored in TRIGGERED SPELL, however as far as i noticed, all checks are ENTRY, ENEMY
    std::list<WorldObject*> targets;
    Acore::WorldObjectSpellTrajTargetCheck check(dist2d, m_targets.GetSrcPos(), m_caster, m_spellInfo, TARGET_CHECK_ENEMY /*targetCheckType*/, m_spellInfo->Effects[effIndex].ImplicitTargetConditions);
    Acore::WorldObjectListSearcher<Acore::WorldObjectSpellTrajTargetCheck> searcher(m_caster, targets, check, GRID_MAP_TYPE_MASK_ALL);
    SearchTargets<Acore::WorldObjectListSearcher<Acore::WorldObjectSpellTrajTargetCheck> > (searcher, GRID_MAP_TYPE_MASK_ALL, m_caster, m_targets.GetSrcPos(), dist2d);
    if (targets.empty())
        return;

    targets.sort(Acore::ObjectDistanceOrderPred(m_caster));

    float b = tangent(m_targets.GetElevation());
    float a = (srcToDestDelta - dist2d * b) / (dist2d * dist2d);
    if (a > -0.0001f)
        a = 0;

    LOG_DEBUG("spells", "Spell::SelectTrajTargets: a {} b {}", a, b);

    // Xinef: hack for distance, many trajectory spells have RangeEntry 1 (self)
    float bestDist = m_spellInfo->GetMaxRange(false) * 2;
    if (bestDist < 1.0f)
        bestDist = 300.0f;

    std::list<WorldObject*>::const_iterator itr = targets.begin();
    for (; itr != targets.end(); ++itr)
    {
        if (Unit* unitTarget = (*itr)->ToUnit())
            if (m_caster == *itr || m_caster->IsOnVehicle(unitTarget) || (unitTarget)->GetVehicle())//(*itr)->IsOnVehicle(m_caster))
                continue;

        const float size = std::max((*itr)->GetObjectSize() * 0.7f, 1.0f); // 1/sqrt(3)
        /// @todo: all calculation should be based on src instead of m_caster
        const float objDist2d = std::fabs(m_targets.GetSrcPos()->GetExactDist2d(*itr) * cos(m_targets.GetSrcPos()->GetRelativeAngle(*itr)));
        const float dz = std::fabs((*itr)->GetPositionZ() - m_targets.GetSrcPos()->m_positionZ);

        LOG_DEBUG("spells", "Spell::SelectTrajTargets: check {}, dist between {} {}, height between {} {}.",
            (*itr)->GetEntry(), objDist2d - size, objDist2d + size, dz - size, dz + size);

        float dist = objDist2d - size;
        float height = dist * (a * dist + b);

        LOG_DEBUG("spells", "Spell::SelectTrajTargets: dist {}, height {}.", dist, height);

        if (dist < bestDist && height < dz + size && height > dz - size)
        {
            bestDist = dist > 0 ? dist : 0;
            break;
        }

#define CHECK_DIST {\
            LOG_DEBUG("spells", "Spell::SelectTrajTargets: dist {}, height {}.", dist, height);\
            if (dist > bestDist)\
                continue;\
            if (dist < objDist2d + size && dist > objDist2d - size)\
            {\
                bestDist = dist;\
                break;\
            }\
        }

        // RP-GG only, search in straight line, as item have no trajectory
        if (m_CastItem)
        {
            if (dist < bestDist && std::fabs(dz) < 6.0f) // closes target, also check Z difference)
            {
                bestDist = dist;
                break;
            }

            continue;
        }

        if (!a)
        {
            // Xinef: everything remade
            dist = m_targets.GetSrcPos()->GetExactDist(*itr);
            height = m_targets.GetSrcPos()->GetExactDist2d(*itr) * b;

            if (height < dz + size * (b + 1) && height > dz - size * (b + 1) && dist < bestDist)
            {
                bestDist = dist;
                break;
            }

            continue;
        }

        height = dz - size;
        float sqrt1 = b * b + 4 * a * height;
        if (sqrt1 > 0)
        {
            sqrt1 = std::sqrt(sqrt1);
            dist = (sqrt1 - b) / (2 * a);
            CHECK_DIST;
        }

        height = dz + size;
        float sqrt2 = b * b + 4 * a * height;
        if (sqrt2 > 0)
        {
            sqrt2 = std::sqrt(sqrt2);
            dist = (sqrt2 - b) / (2 * a);
            CHECK_DIST;

            dist = (-sqrt2 - b) / (2 * a);
            CHECK_DIST;
        }

        if (sqrt1 > 0)
        {
            dist = (-sqrt1 - b) / (2 * a);
            CHECK_DIST;
        }
    }

    if (m_targets.GetSrcPos()->GetExactDist2d(m_targets.GetDstPos()) > bestDist)
    {
        float x = m_targets.GetSrcPos()->m_positionX + cos(m_caster->GetOrientation()) * bestDist;
        float y = m_targets.GetSrcPos()->m_positionY + std::sin(m_caster->GetOrientation()) * bestDist;
        float z = m_targets.GetSrcPos()->m_positionZ + bestDist * (a * bestDist + b);

        if (itr != targets.end())
        {
            float distSq = (*itr)->GetExactDistSq(x, y, z);
            float sizeSq = (*itr)->GetObjectSize();
            sizeSq *= sizeSq;
            LOG_DEBUG("spells", "Spell::SelectTrajTargets: Initial {} {} {} {} {}", x, y, z, distSq, sizeSq);
            if (distSq > sizeSq)
            {
                float factor = 1 - std::sqrt(sizeSq / distSq);
                x += factor * ((*itr)->GetPositionX() - x);
                y += factor * ((*itr)->GetPositionY() - y);
                z += factor * ((*itr)->GetPositionZ() - z);

                distSq = (*itr)->GetExactDistSq(x, y, z);
                LOG_DEBUG("spells", "Spell::SelectTrajTargets: Initial {} {} {} {} {}", x, y, z, distSq, sizeSq);
            }
        }

        Position trajDst;
        trajDst.Relocate(x, y, z, m_caster->GetOrientation());
        SpellDestination dest(*m_targets.GetDst());
        dest.Relocate(trajDst);

        CallScriptDestinationTargetSelectHandlers(dest, effIndex, targetType);
        m_targets.ModDst(dest);
    }
}

void Spell::SelectEffectTypeImplicitTargets(uint8 effIndex)
{
    // special case for SPELL_EFFECT_SUMMON_RAF_FRIEND and SPELL_EFFECT_SUMMON_PLAYER
    /// @todo: this is a workaround - target shouldn't be stored in target map for those spells
    switch (m_spellInfo->Effects[effIndex].Effect)
    {
        case SPELL_EFFECT_SUMMON_RAF_FRIEND:
        case SPELL_EFFECT_SUMMON_PLAYER:
            if (m_caster->IsPlayer() && m_caster->ToPlayer()->GetTarget())
            {
                WorldObject* target = ObjectAccessor::FindPlayer(m_caster->ToPlayer()->GetTarget());

                CallScriptObjectTargetSelectHandlers(target, SpellEffIndex(effIndex), SpellImplicitTargetInfo());

                if (target && target->ToPlayer())
                    AddUnitTarget(target->ToUnit(), 1 << effIndex, false);
            }
            return;
        default:
            break;
    }

    // select spell implicit targets based on effect type
    if (!m_spellInfo->Effects[effIndex].GetImplicitTargetType())
        return;

    uint32 targetMask = m_spellInfo->Effects[effIndex].GetMissingTargetMask();

    if (!targetMask)
        return;

    WorldObject* target = nullptr;

    switch (m_spellInfo->Effects[effIndex].GetImplicitTargetType())
    {
        // add explicit object target or self to the target map
        case EFFECT_IMPLICIT_TARGET_EXPLICIT:
            // player which not released his spirit is Unit, but target flag for it is TARGET_FLAG_CORPSE_MASK
            if (targetMask & (TARGET_FLAG_UNIT_MASK | TARGET_FLAG_CORPSE_MASK))
            {
                if (Unit* unitTarget = m_targets.GetUnitTarget())
                    target = unitTarget;
                else if (targetMask & TARGET_FLAG_CORPSE_MASK)
                {
                    if (Corpse* corpseTarget = m_targets.GetCorpseTarget())
                    {
                        /// @todo: this is a workaround - corpses should be added to spell target map too, but we can't do that so we add owner instead
                        if (Player* owner = ObjectAccessor::FindPlayer(corpseTarget->GetOwnerGUID()))
                            target = owner;
                    }
                }
                else //if (targetMask & TARGET_FLAG_UNIT_MASK)
                    target = m_caster;
            }
            if (targetMask & TARGET_FLAG_ITEM_MASK)
            {
                if (Item* itemTarget = m_targets.GetItemTarget())
                    AddItemTarget(itemTarget, 1 << effIndex);
                return;
            }
            if (targetMask & TARGET_FLAG_GAMEOBJECT_MASK)
                target = m_targets.GetGOTarget();
            break;
        // add self to the target map
        case EFFECT_IMPLICIT_TARGET_CASTER:
            if (targetMask & TARGET_FLAG_UNIT_MASK)
                target = m_caster;
            break;
        default:
            break;
    }

    CallScriptObjectTargetSelectHandlers(target, SpellEffIndex(effIndex), SpellImplicitTargetInfo());

    if (target)
    {
        if (target->ToUnit())
            AddUnitTarget(target->ToUnit(), 1 << effIndex, false);
        else if (target->ToGameObject())
            AddGOTarget(target->ToGameObject(), 1 << effIndex);
    }
}

uint32 Spell::GetSearcherTypeMask(SpellTargetObjectTypes objType, ConditionList* condList)
{
    // this function selects which containers need to be searched for spell target
    uint32 retMask = GRID_MAP_TYPE_MASK_ALL;

    // filter searchers based on searched object type
    switch (objType)
    {
        case TARGET_OBJECT_TYPE_UNIT:
        case TARGET_OBJECT_TYPE_UNIT_AND_DEST:
        case TARGET_OBJECT_TYPE_CORPSE:
        case TARGET_OBJECT_TYPE_CORPSE_ENEMY:
        case TARGET_OBJECT_TYPE_CORPSE_ALLY:
            retMask &= GRID_MAP_TYPE_MASK_PLAYER | GRID_MAP_TYPE_MASK_CORPSE | GRID_MAP_TYPE_MASK_CREATURE;
            break;
        case TARGET_OBJECT_TYPE_GOBJ:
        case TARGET_OBJECT_TYPE_GOBJ_ITEM:
            retMask &= GRID_MAP_TYPE_MASK_GAMEOBJECT;
            break;
        default:
            break;
    }
    if (!m_spellInfo->HasAttribute(SPELL_ATTR2_ALLOW_DEAD_TARGET))
        retMask &= ~GRID_MAP_TYPE_MASK_CORPSE;
    if (m_spellInfo->HasAttribute(SPELL_ATTR3_ONLY_ON_PLAYER))
    {
        //npcbot: do not exclude creatures, see WorldObjectSpellNearbyTargetCheck, WorldObjectSpellAreaTargetCheck
        if (retMask & GRID_MAP_TYPE_MASK_CREATURE)
            retMask &= GRID_MAP_TYPE_MASK_CORPSE | GRID_MAP_TYPE_MASK_PLAYER | GRID_MAP_TYPE_MASK_CREATURE;
        else
        //end npcbot
        retMask &= GRID_MAP_TYPE_MASK_CORPSE | GRID_MAP_TYPE_MASK_PLAYER;
    }
    if (m_spellInfo->HasAttribute(SPELL_ATTR3_ONLY_ON_GHOSTS))
        retMask &= GRID_MAP_TYPE_MASK_PLAYER;

    if (condList)
        retMask &= sConditionMgr->GetSearcherTypeMaskForConditionList(*condList);
    return retMask;
}

template<class SEARCHER>
void Spell::SearchTargets(SEARCHER& searcher, uint32 containerMask, Unit* referer, Position const* pos, float radius)
{
    if (!containerMask)
        return;

    // search world and grid for possible targets
    bool searchInGrid = containerMask & (GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_GAMEOBJECT);
    bool searchInWorld = containerMask & (GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER | GRID_MAP_TYPE_MASK_CORPSE);

    if (searchInGrid || searchInWorld)
    {
        float x, y;
        x = pos->GetPositionX();
        y = pos->GetPositionY();

        CellCoord p(Acore::ComputeCellCoord(x, y));
        Cell cell(p);
        cell.SetNoCreate();

        Map* map = referer->GetMap();

        if (searchInWorld)
            Cell::VisitWorldObjects(x, y, map, searcher, radius);

        if (searchInGrid)
            Cell::VisitGridObjects(x, y, map, searcher, radius);
    }
}

WorldObject* Spell::SearchNearbyTarget(float range, SpellTargetObjectTypes objectType, SpellTargetCheckTypes selectionType, ConditionList* condList)
{
    WorldObject* target = nullptr;
    uint32 containerTypeMask = GetSearcherTypeMask(objectType, condList);
    if (!containerTypeMask)
        return nullptr;
    Acore::WorldObjectSpellNearbyTargetCheck check(range, m_caster, m_spellInfo, selectionType, condList);
    Acore::WorldObjectLastSearcher<Acore::WorldObjectSpellNearbyTargetCheck> searcher(m_caster, target, check, containerTypeMask);
    SearchTargets<Acore::WorldObjectLastSearcher<Acore::WorldObjectSpellNearbyTargetCheck> > (searcher, containerTypeMask, m_caster, m_caster, range);
    return target;
}

void Spell::SearchAreaTargets(std::list<WorldObject*>& targets, float range, Position const* position, Unit* referer, SpellTargetObjectTypes objectType, SpellTargetCheckTypes selectionType, ConditionList* condList)
{
    uint32 containerTypeMask = GetSearcherTypeMask(objectType, condList);
    if (!containerTypeMask)
        return;
    Acore::WorldObjectSpellAreaTargetCheck check(range, position, m_caster, referer, m_spellInfo, selectionType, condList);
    Acore::WorldObjectListSearcher<Acore::WorldObjectSpellAreaTargetCheck> searcher(m_caster, targets, check, containerTypeMask);
    SearchTargets<Acore::WorldObjectListSearcher<Acore::WorldObjectSpellAreaTargetCheck> > (searcher, containerTypeMask, m_caster, position, range);
}

void Spell::SearchChainTargets(std::list<WorldObject*>& targets, uint32 chainTargets, WorldObject* target, SpellTargetObjectTypes objectType, SpellTargetCheckTypes selectType, SpellTargetSelectionCategories  /*selectCategory*/, ConditionList* condList, bool isChainHeal)
{
    // max dist for jump target selection
    float jumpRadius = 0.0f;
    switch (m_spellInfo->DmgClass)
    {
        case SPELL_DAMAGE_CLASS_RANGED:
            // 7.5y for multi shot
            jumpRadius = 7.5f;
            break;
        case SPELL_DAMAGE_CLASS_MELEE:
            // 5y for swipe, cleave and similar
            jumpRadius = 5.0f;
            break;
        case SPELL_DAMAGE_CLASS_NONE:
        case SPELL_DAMAGE_CLASS_MAGIC:
            // 12.5y for chain heal spell since 3.2 patch
            if (isChainHeal)
                jumpRadius = 12.5f;
            // 10y as default for magic chain spells
            else
                jumpRadius = 10.0f;
            break;
    }

    // chain lightning/heal spells and similar - allow to jump at larger distance and go out of los
    bool isBouncingFar = (m_spellInfo->HasAttribute(SPELL_ATTR4_BOUNCY_CHAIN_MISSILES)
                          || m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_NONE
                          || m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_MAGIC);

    // max dist which spell can reach
    float searchRadius = jumpRadius;
    if (isBouncingFar)
        searchRadius *= chainTargets;

    std::list<WorldObject*> tempTargets;
    SearchAreaTargets(tempTargets, searchRadius, target, m_caster, objectType, selectType, condList);
    tempTargets.remove(target);

    // remove targets which are always invalid for chain spells
    // for some spells allow only chain targets in front of caster (swipe for example)
    if (!isBouncingFar)
    {
        for (std::list<WorldObject*>::iterator itr = tempTargets.begin(); itr != tempTargets.end();)
        {
            std::list<WorldObject*>::iterator checkItr = itr++;
            if (!m_caster->HasInArc(static_cast<float>(M_PI), *checkItr))
                tempTargets.erase(checkItr);
        }
    }

    while (chainTargets)
    {
        // try to get unit for next chain jump
        std::list<WorldObject*>::iterator foundItr = tempTargets.end();
        // get unit with highest hp deficit in dist
        if (isChainHeal)
        {
            uint32 maxHPDeficit = 0;
            for (std::list<WorldObject*>::iterator itr = tempTargets.begin(); itr != tempTargets.end(); ++itr)
            {
                if (Unit* unit = (*itr)->ToUnit())
                {
                    uint32 deficit = unit->GetMaxHealth() - unit->GetHealth();
                    if ((deficit > maxHPDeficit || foundItr == tempTargets.end()) && target->IsWithinDist(unit, jumpRadius) && target->IsWithinLOSInMap(unit, VMAP::ModelIgnoreFlags::M2))
                    {
                        foundItr = itr;
                        maxHPDeficit = deficit;
                    }
                }
            }
        }
        // get closest object
        else
        {
            for (std::list<WorldObject*>::iterator itr = tempTargets.begin(); itr != tempTargets.end(); ++itr)
            {
                if (foundItr == tempTargets.end())
                {
                    if ((!isBouncingFar || target->IsWithinDist(*itr, jumpRadius)) && target->IsWithinLOSInMap(*itr, VMAP::ModelIgnoreFlags::M2))
                        foundItr = itr;
                }
                else if (target->GetDistanceOrder(*itr, *foundItr) && target->IsWithinLOSInMap(*itr, VMAP::ModelIgnoreFlags::M2))
                    foundItr = itr;
            }
        }
        // not found any valid target - chain ends
        if (foundItr == tempTargets.end())
            break;
        target = *foundItr;
        tempTargets.erase(foundItr);
        targets.push_back(target);
        --chainTargets;
    }
}

void Spell::prepareDataForTriggerSystem(AuraEffect const* /*triggeredByAura*/)
{
    //==========================================================================================
    // Now fill data for trigger system, need know:
    // can spell trigger another or not (m_canTrigger)
    // Create base triggers flags for Attacker and Victim (m_procAttacker, m_procVictim and m_procEx)
    //==========================================================================================

    m_procVictim = m_procAttacker = 0;
    // Get data for type of attack and fill base info for trigger
    switch (m_spellInfo->DmgClass)
    {
        case SPELL_DAMAGE_CLASS_MELEE:
            m_procAttacker = PROC_FLAG_DONE_SPELL_MELEE_DMG_CLASS;
            if (m_attackType == OFF_ATTACK)
                m_procAttacker |= PROC_FLAG_DONE_OFFHAND_ATTACK;
            else
                m_procAttacker |= PROC_FLAG_DONE_MAINHAND_ATTACK;
            m_procVictim   = PROC_FLAG_TAKEN_SPELL_MELEE_DMG_CLASS;
            break;
        case SPELL_DAMAGE_CLASS_RANGED:
            // Auto attack
            if (m_spellInfo->HasAttribute(SPELL_ATTR2_AUTO_REPEAT))
            {
                m_procAttacker = PROC_FLAG_DONE_RANGED_AUTO_ATTACK;
                m_procVictim   = PROC_FLAG_TAKEN_RANGED_AUTO_ATTACK;
            }
            else // Ranged spell attack
            {
                m_procAttacker = PROC_FLAG_DONE_SPELL_RANGED_DMG_CLASS;
                m_procVictim   = PROC_FLAG_TAKEN_SPELL_RANGED_DMG_CLASS;
            }
            break;
        default:
            if (m_spellInfo->EquippedItemClass == ITEM_CLASS_WEAPON &&
                    m_spellInfo->EquippedItemSubClassMask & (1 << ITEM_SUBCLASS_WEAPON_WAND)
                    && m_spellInfo->HasAttribute(SPELL_ATTR2_AUTO_REPEAT)) // Wands auto attack
            {
                m_procAttacker = PROC_FLAG_DONE_RANGED_AUTO_ATTACK;
                m_procVictim   = PROC_FLAG_TAKEN_RANGED_AUTO_ATTACK;
            }
            // For other spells trigger procflags are set in Spell::DoAllEffectOnTarget
            // Because spell positivity is dependant on target
    }
    m_procEx = PROC_EX_NONE;

    // Hunter trap spells - activation proc for Lock and Load, Entrapment and Misdirection
    if (m_spellInfo->SpellFamilyName == SPELLFAMILY_HUNTER &&
            (m_spellInfo->SpellFamilyFlags[0] & 0x18 ||              // Freezing and Frost Trap, Freezing Arrow
             m_spellInfo->Id == 57879 || m_spellInfo->Id == 45145 ||  // Snake Trap - done this way to avoid double proc
             m_spellInfo->SpellFamilyFlags[2] & 0x00064000))          // Explosive and Immolation Trap
    {
        m_procAttacker |= PROC_FLAG_DONE_TRAP_ACTIVATION;
    }

    /* Effects which are result of aura proc from triggered spell cannot proc
        to prevent chain proc of these spells */

    // Hellfire Effect - trigger as DOT
    if (m_spellInfo->SpellFamilyName == SPELLFAMILY_WARLOCK && m_spellInfo->SpellFamilyFlags[0] & 0x00000040)
    {
        m_procAttacker = PROC_FLAG_DONE_PERIODIC;
        m_procVictim   = PROC_FLAG_TAKEN_PERIODIC;
    }

    // Ranged autorepeat attack is set as triggered spell - ignore it
    if (!(m_procAttacker & PROC_FLAG_DONE_RANGED_AUTO_ATTACK))
    {
        if (HasTriggeredCastFlag(TRIGGERED_DISALLOW_PROC_EVENTS) &&
                (m_spellInfo->HasAttribute(SPELL_ATTR2_ACTIVE_THREAT) ||
                 m_spellInfo->HasAttribute(SPELL_ATTR3_NOT_A_PROC)))
            m_procEx |= PROC_EX_INTERNAL_CANT_PROC;
        else if (HasTriggeredCastFlag(TRIGGERED_DISALLOW_PROC_EVENTS))
            m_procEx |= PROC_EX_INTERNAL_TRIGGERED;
    }
    // Totem casts require spellfamilymask defined in spell_proc_event to proc
    if (m_originalCaster && m_caster != m_originalCaster && m_caster->IsCreature() && m_caster->ToCreature()->IsTotem() && m_caster->IsControlledByPlayer())
        m_procEx |= PROC_EX_INTERNAL_REQ_FAMILY;
}

void Spell::CleanupTargetList()
{
    m_UniqueTargetInfo.clear();
    m_UniqueGOTargetInfo.clear();
    m_UniqueItemInfo.clear();
    m_delayMoment = 0;
    m_delayTrajectory = 0;
}

void Spell::AddUnitTarget(Unit* target, uint32 effectMask, bool checkIfValid /*= true*/, bool implicit /*= true*/)
{
    for (uint32 effIndex = 0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
        if (!m_spellInfo->Effects[effIndex].IsEffect() || !CheckEffectTarget(target, effIndex))
            effectMask &= ~(1 << effIndex);

    // no effects left
    if (!effectMask)
        return;

    if (checkIfValid)
    {
        SpellCastResult res = m_spellInfo->CheckTarget(m_caster, target, implicit);
        if (res != SPELL_CAST_OK)
            return;
    }

    // Check for effect immune skip if immuned
    for (uint32 effIndex = 0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
        if (target->IsImmunedToSpellEffect(m_spellInfo, effIndex))
            effectMask &= ~(1 << effIndex);

    ObjectGuid targetGUID = target->GetGUID();

    // Lookup target in already in list
    for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
    {
        if (targetGUID == ihit->targetGUID)             // Found in list
        {
            ihit->effectMask |= effectMask;             // Immune effects removed from mask
            ihit->scaleAura = false;
            if (m_auraScaleMask && ihit->effectMask == m_auraScaleMask && m_caster != target)
            {
                SpellInfo const* auraSpell = m_spellInfo->GetFirstRankSpell();
                if (uint32(target->GetLevel() + 10) >= auraSpell->SpellLevel)
                    ihit->scaleAura = true;
            }

            sScriptMgr->OnScaleAuraUnitAdd(this, target, effectMask, checkIfValid, implicit, m_auraScaleMask, *ihit);
            return;
        }
    }

    // This is new target calculate data for him

    // Get spell hit result on target
    TargetInfo targetInfo;
    targetInfo.targetGUID = targetGUID;                         // Store target GUID
    targetInfo.effectMask = effectMask;                         // Store all effects not immune
    targetInfo.processed  = false;                              // Effects not apply on target
    targetInfo.alive      = target->IsAlive();
    targetInfo.damage     = 0;
    targetInfo.crit       = false;
    targetInfo.scaleAura  = false;
    if (m_auraScaleMask && targetInfo.effectMask == m_auraScaleMask && m_caster != target)
    {
        SpellInfo const* auraSpell = m_spellInfo->GetFirstRankSpell();
        if (uint32(target->GetLevel() + 10) >= auraSpell->SpellLevel)
            targetInfo.scaleAura = true;
    }

    sScriptMgr->OnScaleAuraUnitAdd(this, target, effectMask, checkIfValid, implicit, m_auraScaleMask, targetInfo);

    // Calculate hit result
    if (m_originalCaster)
    {
        targetInfo.missCondition = m_originalCaster->SpellHitResult(target, this, m_canReflect);
        if (m_skipCheck && targetInfo.missCondition != SPELL_MISS_IMMUNE)
        {
            targetInfo.missCondition = SPELL_MISS_NONE;
        }
    }
    else
        targetInfo.missCondition = SPELL_MISS_EVADE; //SPELL_MISS_NONE;

    // Spell have speed - need calculate incoming time
    // Incoming time is zero for self casts. At least I think so.
    if (m_spellInfo->Speed > 0.0f && m_caster != target)
    {
        // calculate spell incoming interval
        /// @todo: this is a hack
        float dist = m_caster->GetDistance(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ());

        if (dist < 5.0f)
            dist = 5.0f;
        targetInfo.timeDelay = (uint64) std::floor(dist / m_spellInfo->Speed * 1000.0f);

        // Calculate minimum incoming time
        if (m_delayMoment == 0 || m_delayMoment > targetInfo.timeDelay)
            m_delayMoment = targetInfo.timeDelay;
    }
    else
        targetInfo.timeDelay = 0LL;

    // If target reflect spell back to caster
    if (targetInfo.missCondition == SPELL_MISS_REFLECT)
    {
        // Calculate reflected spell result on caster
        targetInfo.reflectResult = m_caster->SpellHitResult(m_caster, this, m_canReflect);

        if (targetInfo.reflectResult == SPELL_MISS_REFLECT)     // Impossible reflect again, so simply deflect spell
            targetInfo.reflectResult = SPELL_MISS_PARRY;

        // Increase time interval for reflected spells by 1.5
        m_caster->m_Events.AddEvent(new ReflectEvent(m_caster, targetInfo.targetGUID, m_spellInfo), m_caster->m_Events.CalculateTime(targetInfo.timeDelay));
        targetInfo.timeDelay += targetInfo.timeDelay >> 1;

        m_spellFlags |= SPELL_FLAG_REFLECTED;

        // HACK: workaround check for succubus seduction case
        /// @todo: seduction should be casted only on humanoids (not demons)
        if (m_caster->IsPet())
        {
            CreatureTemplate const* ci = sObjectMgr->GetCreatureTemplate(m_caster->GetEntry());
            switch (ci->family)
            {
                case CREATURE_FAMILY_SUCCUBUS:
                    {
                        if (m_spellInfo->SpellIconID != 694) // Soothing Kiss
                            cancel();
                    }
                    break;
                    return;
            }
        }
    }
    else
        targetInfo.reflectResult = SPELL_MISS_NONE;

    // Add target to list
    m_UniqueTargetInfo.push_back(targetInfo);
}

void Spell::AddGOTarget(GameObject* go, uint32 effectMask)
{
    for (uint32 effIndex = 0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
    {
        if (!m_spellInfo->Effects[effIndex].IsEffect())
            effectMask &= ~(1 << effIndex);
        else
        {
            switch (m_spellInfo->Effects[effIndex].Effect)
            {
                case SPELL_EFFECT_GAMEOBJECT_DAMAGE:
                case SPELL_EFFECT_GAMEOBJECT_REPAIR:
                case SPELL_EFFECT_GAMEOBJECT_SET_DESTRUCTION_STATE:
                    if (go->GetGoType() != GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING)
                        effectMask &= ~(1 << effIndex);
                    break;
                default:
                    break;
            }
        }
    }

    if (!effectMask)
        return;

    ObjectGuid targetGUID = go->GetGUID();

    // Lookup target in already in list
    for (std::list<GOTargetInfo>::iterator ihit = m_UniqueGOTargetInfo.begin(); ihit != m_UniqueGOTargetInfo.end(); ++ihit)
    {
        if (targetGUID == ihit->targetGUID)                 // Found in list
        {
            ihit->effectMask |= effectMask;                 // Add only effect mask
            return;
        }
    }

    // This is new target calculate data for him

    GOTargetInfo target;
    target.targetGUID = targetGUID;
    target.effectMask = effectMask;
    target.processed  = false;                              // Effects not apply on target

    // Spell have speed - need calculate incoming time
    if (m_spellInfo->Speed > 0.0f)
    {
        // calculate spell incoming interval
        float dist = m_caster->GetDistance(go->GetPositionX(), go->GetPositionY(), go->GetPositionZ());
        if (dist < 5.0f)
            dist = 5.0f;
        target.timeDelay = uint64(std::floor(dist / m_spellInfo->Speed * 1000.0f));
        if (m_delayMoment == 0 || m_delayMoment > target.timeDelay)
            m_delayMoment = target.timeDelay;
    }
    else
        target.timeDelay = 0LL;

    // Add target to list
    m_UniqueGOTargetInfo.push_back(target);
}

void Spell::AddItemTarget(Item* item, uint32 effectMask)
{
    for (uint32 effIndex = 0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
        if (!m_spellInfo->Effects[effIndex].IsEffect())
            effectMask &= ~(1 << effIndex);

    // no effects left
    if (!effectMask)
        return;

    // Lookup target in already in list
    for (std::list<ItemTargetInfo>::iterator ihit = m_UniqueItemInfo.begin(); ihit != m_UniqueItemInfo.end(); ++ihit)
    {
        if (item == ihit->item)                            // Found in list
        {
            ihit->effectMask |= effectMask;                 // Add only effect mask
            return;
        }
    }

    // This is new target add data

    ItemTargetInfo target;
    target.item       = item;
    target.effectMask = effectMask;

    m_UniqueItemInfo.push_back(target);
}

void Spell::AddDestTarget(SpellDestination const& dest, uint32 effIndex)
{
    m_destTargets[effIndex] = dest;
}

void Spell::DoAllEffectOnTarget(TargetInfo* target)
{
    if (!target || target->processed)
        return;

    target->processed = true;                               // Target checked in apply effects procedure

    // Get mask of effects for target
    uint8 mask = target->effectMask;

    Unit* effectUnit = m_caster->GetGUID() == target->targetGUID ? m_caster : ObjectAccessor::GetUnit(*m_caster, target->targetGUID);
    if (!effectUnit && !target->targetGUID.IsPlayer()) // only players may be targeted across maps
        return;

    if (!effectUnit || m_spellInfo->Id == 45927)
    {
        uint8 farMask = 0;
        // create far target mask
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            if (m_spellInfo->Effects[i].IsFarUnitTargetEffect())
                if ((1 << i) & mask)
                    farMask |= (1 << i);

        if (!farMask)
            return;
        // find unit in world
        // Xinef: FindUnit Access without Map check!!! Intended
        effectUnit = ObjectAccessor::FindPlayer(target->targetGUID);
        if (!effectUnit)
            return;

        // do far effects on the unit
        // can't use default call because of threading, do stuff as fast as possible
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            if (farMask & (1 << i))
                HandleEffects(effectUnit, nullptr, nullptr, i, SPELL_EFFECT_HANDLE_HIT_TARGET);
        return;
    }

    if (effectUnit->IsAlive() != target->alive)
        return;

    // Xinef: absorb delayed projectiles for 500ms
    if (getState() == SPELL_STATE_DELAYED && !m_spellInfo->IsTargetingArea() && !m_spellInfo->IsPositive() &&
            (GameTime::GetGameTimeMS().count() - target->timeDelay) <= effectUnit->m_lastSanctuaryTime && GameTime::GetGameTimeMS().count() < (effectUnit->m_lastSanctuaryTime + 500) &&
            effectUnit->FindMap() && !effectUnit->FindMap()->IsDungeon()
       )
        return;                                             // No missinfo in that case

    // Get original caster (if exist) and calculate damage/healing from him data
    Unit* caster = m_originalCaster ? m_originalCaster : m_caster;

    // Skip if m_originalCaster not avaiable
    if (!caster)
        return;

    SpellMissInfo missInfo = target->missCondition;

    // Need init unitTarget by default unit (can changed in code on reflect)
    // Or on missInfo != SPELL_MISS_NONE unitTarget undefined (but need in trigger subsystem)
    unitTarget = effectUnit;

    // Reset damage/healing counter
    m_damage = target->damage;
    m_healing = -target->damage;

    m_spellAura = nullptr; // Set aura to null for every target-make sure that pointer is not used for unit without aura applied

    PrepareScriptHitHandlers();
    CallScriptBeforeHitHandlers(missInfo);

    //Spells with this flag cannot trigger if effect is casted on self
    bool canEffectTrigger = !m_spellInfo->HasAttribute(SPELL_ATTR3_SUPRESS_CASTER_PROCS) && unitTarget->CanProc() && (CanExecuteTriggersOnHit(mask) || missInfo == SPELL_MISS_IMMUNE2);
    bool reflectedSpell = missInfo == SPELL_MISS_REFLECT;
    Unit* spellHitTarget = nullptr;

    if (missInfo == SPELL_MISS_NONE)                          // In case spell hit target, do all effect on that target
        spellHitTarget = unitTarget;
    else if (missInfo == SPELL_MISS_REFLECT)                // In case spell reflect from target, do all effect on caster (if hit)
    {
        missInfo = target->reflectResult;
        if (missInfo == SPELL_MISS_NONE)       // If reflected spell hit caster -> do all effect on him
        {
            spellHitTarget = m_caster;
            unitTarget = m_caster;
            if (m_caster->IsCreature())
                m_caster->ToCreature()->LowerPlayerDamageReq(target->damage);
        }
    }

    if (spellHitTarget)
    {
        SpellMissInfo missInfo2 = DoSpellHitOnUnit(spellHitTarget, mask, target->scaleAura);
        if (missInfo2 != SPELL_MISS_NONE)
        {
            if (missInfo2 != SPELL_MISS_MISS)
                m_caster->SendSpellMiss(spellHitTarget, m_spellInfo->Id, missInfo2);
            m_damage = 0;
            spellHitTarget = nullptr;

            // Xinef: if missInfo2 is MISS_EVADE, override base missinfo data
            if (missInfo2 == SPELL_MISS_EVADE)
                missInfo = SPELL_MISS_EVADE;
        }
    }

    // Do not take combo points on dodge and miss
    if (missInfo != SPELL_MISS_NONE && m_needComboPoints && m_targets.GetUnitTargetGUID() == target->targetGUID)
    {
        m_needComboPoints = false;
        // Restore spell mods for a miss/dodge/parry Cold Blood
        /// @todo: check how broad this rule should be
        if (m_caster->IsPlayer() && (missInfo == SPELL_MISS_MISS || missInfo == SPELL_MISS_DODGE || missInfo == SPELL_MISS_PARRY))
            m_caster->ToPlayer()->RestoreSpellMods(this, 14177);
    }

    // Fill base trigger info
    uint32 procAttacker = m_procAttacker;
    uint32 procVictim   = m_procVictim;
    uint32 procEx = m_procEx;

    // Trigger info was not filled in spell::preparedatafortriggersystem - we do it now
    if (canEffectTrigger && !procAttacker && !procVictim)
    {
        bool positive = true;
        if (m_damage > 0)
            positive = false;
        else if (!m_healing)
        {
            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                // If at least one effect negative spell is negative hit
                // Xinef: if missInfo is immune state check all effects to properly determine positiveness of spell
                if ((missInfo == SPELL_MISS_IMMUNE2 || (mask & (1 << i))) && !m_spellInfo->IsPositiveEffect(i))
                {
                    positive = false;
                    break;
                }
        }
        switch (m_spellInfo->DmgClass)
        {
            case SPELL_DAMAGE_CLASS_MAGIC:
                if (positive)
                {
                    procAttacker |= PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS;
                    procVictim   |= PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_POS;
                }
                else
                {
                    procAttacker |= PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG;
                    procVictim   |= PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG;
                }
                break;
            case SPELL_DAMAGE_CLASS_NONE:
                if (positive)
                {
                    procAttacker |= PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_POS;
                    procVictim   |= PROC_FLAG_TAKEN_SPELL_NONE_DMG_CLASS_POS;
                }
                else
                {
                    procAttacker |= PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_NEG;
                    procVictim   |= PROC_FLAG_TAKEN_SPELL_NONE_DMG_CLASS_NEG;
                }
                break;
        }
    }
    CallScriptOnHitHandlers();

    // All calculated do it!
    // Do healing and triggers
    if (m_healing > 0)
    {
        bool crit = target->crit;
        uint32 addhealth = m_healing;

        if (crit)
        {
            procEx |= PROC_EX_CRITICAL_HIT;
            addhealth = Unit::SpellCriticalHealingBonus(caster, m_spellInfo, addhealth, nullptr);
        }
        else
            procEx |= PROC_EX_NORMAL_HIT;

        HealInfo healInfo(caster, unitTarget, addhealth, m_spellInfo, m_spellInfo->GetSchoolMask());

        // Xinef: override with forced crit, only visual result
        if (GetSpellValue()->ForcedCritResult)
        {
            crit = true;
            procEx |= PROC_EX_CRITICAL_HIT;
        }

        int32 gain = caster->HealBySpell(healInfo, crit);
        unitTarget->getHostileRefMgr().threatAssist(caster, float(gain) * 0.5f, m_spellInfo);
        m_healing = gain;

        // Xinef: if heal acutally healed something, add no overheal flag
        if (m_healing)
            procEx |= PROC_EX_NO_OVERHEAL;

        // Do triggers for unit (reflect triggers passed on hit phase for correct drop charge)
        if (canEffectTrigger)
            Unit::ProcDamageAndSpell(caster, unitTarget, procAttacker, procVictim, procEx, addhealth, m_attackType, m_spellInfo, m_triggeredByAuraSpell.spellInfo,
                m_triggeredByAuraSpell.effectIndex, this, nullptr, &healInfo);
    }
    // Do damage and triggers
    else if (m_damage > 0)
    {
        caster->SetLastDamagedTargetGuid(unitTarget->GetGUID());

        // Fill base damage struct (unitTarget - is real spell target)
        SpellNonMeleeDamage damageInfo(caster, unitTarget, m_spellInfo, m_spellSchoolMask);

        // Add bonuses and fill damageInfo struct
        // Dancing Rune Weapon...
        if (m_caster->GetEntry() == 27893)
        {
            if (Unit* owner = m_caster->GetOwner())
                owner->CalculateSpellDamageTaken(&damageInfo, m_damage, m_spellInfo, m_attackType,  target->crit);
        }
        else
            caster->CalculateSpellDamageTaken(&damageInfo, m_damage, m_spellInfo, m_attackType,  target->crit);

        // xinef: override miss info after absorb / block calculations
        if (missInfo == SPELL_MISS_NONE && damageInfo.damage == 0)
        {
            //if (damageInfo.absorb > 0)
            //  missInfo = SPELL_MISS_ABSORB;
            if (damageInfo.blocked)
                missInfo = SPELL_MISS_BLOCK;
        }

        // Xinef: override with forced crit, only visual result
        if (GetSpellValue()->ForcedCritResult)
        {
            damageInfo.HitInfo |= SPELL_HIT_TYPE_CRIT;
        }

        Unit::DealDamageMods(damageInfo.target, damageInfo.damage, &damageInfo.absorb);

        // xinef: health leech handling
        if (m_spellInfo->HasEffect(SPELL_EFFECT_HEALTH_LEECH))
        {
            uint8 effIndex = EFFECT_0;
            for (; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
                if (m_spellInfo->Effects[effIndex].Effect == SPELL_EFFECT_HEALTH_LEECH)
                    break;

            float healMultiplier = m_spellInfo->Effects[effIndex].CalcValueMultiplier(m_originalCaster, this);

            // get max possible damage, don't count overkill for heal
            uint32 healthGain = uint32(-unitTarget->GetHealthGain(-int32(damageInfo.damage)) * healMultiplier);

            if (m_caster->IsAlive())
            {
                healthGain = m_caster->SpellHealingBonusDone(m_caster, m_spellInfo, healthGain, HEAL, effIndex);
                healthGain = m_caster->SpellHealingBonusTaken(m_caster, m_spellInfo, healthGain, HEAL);

                HealInfo healInfo(m_caster, m_caster, healthGain, m_spellInfo, m_spellInfo->GetSchoolMask());
                m_caster->HealBySpell(healInfo);
            }
        }

        // Send log damage message to client
        caster->SendSpellNonMeleeDamageLog(&damageInfo);
        // Xinef: send info to target about reflect
        if (reflectedSpell)
            effectUnit->SendSpellNonMeleeReflectLog(&damageInfo, effectUnit);

        procEx |= createProcExtendMask(&damageInfo, missInfo);
        procVictim |= PROC_FLAG_TAKEN_DAMAGE;

        caster->DealSpellDamage(&damageInfo, true, this);

        // do procs after damage, eg healing effects
        // no need to check if target is alive, done in procdamageandspell

        // Do triggers for unit (reflect triggers passed on hit phase for correct drop charge)
        if (canEffectTrigger)
        {
            DamageInfo dmgInfo(damageInfo, SPELL_DIRECT_DAMAGE);
            Unit::ProcDamageAndSpell(caster, unitTarget, procAttacker, procVictim, procEx, damageInfo.damage, m_attackType, m_spellInfo, m_triggeredByAuraSpell.spellInfo,
                m_triggeredByAuraSpell.effectIndex, this, &dmgInfo);

            if (caster->IsPlayer() && m_spellInfo->HasAttribute(SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT) == 0 &&
                    m_spellInfo->HasAttribute(SPELL_ATTR4_SUPRESS_WEAPON_PROCS) == 0 && (m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_MELEE || m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_RANGED))
                caster->ToPlayer()->CastItemCombatSpell(unitTarget, m_attackType, procVictim, procEx);

            //npcbot
            if (caster->IsNPCBot() &&
                !m_spellInfo->HasAttribute(SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT) && !m_spellInfo->HasAttribute(SPELL_ATTR4_SUPRESS_WEAPON_PROCS) &&
                (m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_MELEE || m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_RANGED))
                caster->ToCreature()->CastCreatureItemCombatSpell(dmgInfo);
            //end npcbot
        }

        m_damage = damageInfo.damage;
    }
    // Passive spell hits/misses or active spells only misses (only triggers)
    else
    {
        // Fill base damage struct (unitTarget - is real spell target)
        SpellNonMeleeDamage damageInfo(caster, unitTarget, m_spellInfo, m_spellSchoolMask);
        procEx |= createProcExtendMask(&damageInfo, missInfo);
        // Do triggers for unit (reflect triggers passed on hit phase for correct drop charge)
        if (canEffectTrigger)
        {
            DamageInfo dmgInfo(damageInfo, NODAMAGE);
            Unit::ProcDamageAndSpell(caster, unitTarget, procAttacker, procVictim, procEx, 0, m_attackType, m_spellInfo, m_triggeredByAuraSpell.spellInfo,
                m_triggeredByAuraSpell.effectIndex, this, &dmgInfo);

            // Xinef: eg. rogue poisons can proc off cheap shot, etc. so this block should be here also
            // Xinef: ofc count only spells that HIT the target, little hack used to fool the system
            if ((procEx & PROC_EX_NORMAL_HIT || procEx & PROC_EX_CRITICAL_HIT) && caster->IsPlayer() && m_spellInfo->HasAttribute(SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT) == 0 &&
                    m_spellInfo->HasAttribute(SPELL_ATTR4_SUPRESS_WEAPON_PROCS) == 0 && (m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_MELEE || m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_RANGED))
                caster->ToPlayer()->CastItemCombatSpell(unitTarget, m_attackType, procVictim | PROC_FLAG_TAKEN_DAMAGE, procEx);
        }

        // Failed Pickpocket, reveal rogue
        if (missInfo == SPELL_MISS_RESIST && m_spellInfo->HasAttribute(SPELL_ATTR0_CU_PICKPOCKET) && unitTarget->IsCreature() && m_caster)
        {
            m_caster->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TALK);
            if (unitTarget->ToCreature()->IsAIEnabled)
                unitTarget->ToCreature()->AI()->AttackStart(m_caster);
        }
    }

    if (m_caster)
    {
        if (missInfo != SPELL_MISS_EVADE && !m_caster->IsFriendlyTo(effectUnit) && (!m_spellInfo->IsPositive() || m_spellInfo->HasEffect(SPELL_EFFECT_DISPEL)))
        {
            m_caster->CombatStart(effectUnit, !(m_spellInfo->AttributesEx3 & SPELL_ATTR3_SUPRESS_TARGET_PROCS));

            // Patch 3.0.8: All player spells which cause a creature to become aggressive to you will now also immediately cause the creature to be tapped.
            if (effectUnit->IsInCombatWith(m_caster))
            {
                if (Creature* creature = effectUnit->ToCreature())
                {
                    if (!creature->hasLootRecipient() && m_caster->IsPlayer())
                    {
                        creature->SetLootRecipient(m_caster);
                    }
                }
            }

            // Unsure if there are more spells that are not supposed to stop enemy from
            // regenerating HP from food, so for now it stays as an ID.
            const uint32 SPELL_PREMEDITATION = 14183;
            if (m_spellInfo->Id != SPELL_PREMEDITATION)
            {
                if (!effectUnit->IsStandState())
                {
                    effectUnit->SetStandState(UNIT_STAND_STATE_STAND);
                }
            }
        }
    }

    if (missInfo != SPELL_MISS_EVADE && effectUnit != m_caster && m_caster->IsFriendlyTo(effectUnit) && m_spellInfo->IsPositive() &&
        effectUnit->IsInCombat() && !m_spellInfo->HasAttribute(SPELL_ATTR1_NO_THREAT))
    {
        m_caster->SetInCombatWith(effectUnit);
    }

    // Check for SPELL_ATTR7_CAN_CAUSE_INTERRUPT
    if (m_spellInfo->HasAttribute(SPELL_ATTR7_CAN_CAUSE_INTERRUPT) && !effectUnit->IsPlayer())
        caster->CastSpell(effectUnit, SPELL_INTERRUPT_NONPLAYER, true);

    if (spellHitTarget)
    {
        //AI functions
        if (spellHitTarget->IsCreature())
        {
            if (spellHitTarget->ToCreature()->IsAIEnabled)
                spellHitTarget->ToCreature()->AI()->SpellHit(m_caster, m_spellInfo);
        }

        if (m_caster->IsCreature() && m_caster->ToCreature()->IsAIEnabled)
            m_caster->ToCreature()->AI()->SpellHitTarget(spellHitTarget, m_spellInfo);

        //npcbot: vehicle spell hits
        if (m_caster->GetTypeId() == TYPEID_UNIT && m_caster->ToCreature()->IsVehicle() && m_caster->ToCreature()->GetCharmerGUID().IsCreature())
        {
            Unit const* bot = m_caster->ToCreature()->GetCharmer();
            if (bot && bot->ToCreature()->IsNPCBot())
                bot->ToCreature()->AI()->SpellHitTarget(spellHitTarget, m_spellInfo);
        }
        //end npcbot

        // Needs to be called after dealing damage/healing to not remove breaking on damage auras
        DoTriggersOnSpellHit(spellHitTarget, mask);

        // if target is fallged for pvp also flag caster if a player
        // xinef: do not flag spells with aura bind sight (no special attribute)
        if (effectUnit->IsPvP() && effectUnit != m_caster && effectUnit->GetOwnerGUID() != m_caster->GetGUID() &&
            m_caster->IsPlayer() && !m_spellInfo->HasAttribute(SPELL_ATTR0_CU_NO_PVP_FLAG))
        {
            m_caster->ToPlayer()->UpdatePvP(true);
        }

        CallScriptAfterHitHandlers();
    }
}

SpellMissInfo Spell::DoSpellHitOnUnit(Unit* unit, uint32 effectMask, bool scaleAura)
{
    if (!unit || !effectMask)
        return SPELL_MISS_EVADE;

    // For delayed spells immunity may be applied between missile launch and hit - check immunity for that case
    if (m_spellInfo->Speed && ((m_damage > 0 && unit->IsImmunedToDamage(this)) || unit->IsImmunedToSchool(this) || unit->IsImmunedToSpell(m_spellInfo, this)))
    {
        return SPELL_MISS_IMMUNE;
    }

    // disable effects to which unit is immune
    SpellMissInfo returnVal = SPELL_MISS_IMMUNE;
    for (uint32 effectNumber = 0; effectNumber < MAX_SPELL_EFFECTS; ++effectNumber)
    {
        if (effectMask & (1 << effectNumber))
        {
            if (unit->IsImmunedToSpellEffect(m_spellInfo, effectNumber))
                effectMask &= ~(1 << effectNumber);
            // Xinef: Buggs out polymorph
            // Xinef: And this is checked in MagicSpellHitResult, why we check resistance twice?
            // Xinef: And why we check every spell effect basing on rand and generic dispel info? some effects will be appliend and some wont?
            /*else if (m_spellInfo->Effects[effectNumber].IsAura() && !m_spellInfo->IsPositiveEffect(effectNumber))
            {
                int32 debuff_resist_chance = unit->GetMaxPositiveAuraModifierByMiscValue(SPELL_AURA_MOD_DEBUFF_RESISTANCE, int32(m_spellInfo->Dispel));
                debuff_resist_chance += unit->GetMaxNegativeAuraModifierByMiscValue(SPELL_AURA_MOD_DEBUFF_RESISTANCE, int32(m_spellInfo->Dispel));

                if (debuff_resist_chance > 0)
                    if (irand(0,10000) <= (debuff_resist_chance * 100))
                    {
                        effectMask &= ~(1 << effectNumber);
                        returnVal = SPELL_MISS_RESIST;
                    }
            }*/
        }
    }
    if (!effectMask)
        return returnVal;

    if (unit->IsPlayer())
    {
        unit->ToPlayer()->StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_SPELL_TARGET, m_spellInfo->Id);
        unit->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, m_spellInfo->Id, 0, m_caster);
        unit->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2, m_spellInfo->Id, 0, m_caster);
    }

    if (m_caster->IsPlayer())
    {
        m_caster->ToPlayer()->StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_SPELL_CASTER, m_spellInfo->Id);
        m_caster->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL2, m_spellInfo->Id, 0, unit);
    }

    if (m_caster != unit)
    {
        // Recheck  UNIT_FLAG_NON_ATTACKABLE for delayed spells
        // Xinef: Also check evade state
        if (m_spellInfo->Speed > 0.0f)
        {
            if (unit->IsCreature() && unit->ToCreature()->IsInEvadeMode())
                return SPELL_MISS_EVADE;

            if (unit->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE) && unit->GetCharmerOrOwnerGUID() != m_caster->GetGUID())
                return SPELL_MISS_EVADE;
        }

        if (m_caster->_IsValidAttackTarget(unit, m_spellInfo) && /*Intervene Trigger*/ m_spellInfo->Id != 59667)
        {
            unit->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_HITBYSPELL);
        }
        else if (m_caster->IsFriendlyTo(unit))
        {
            // for delayed spells ignore negative spells (after duel end) for friendly targets
            /// @todo: this cause soul transfer bugged
            if(!IsTriggered() && m_spellInfo->Speed > 0.0f && unit->IsPlayer() && !m_spellInfo->IsPositive())
                return SPELL_MISS_EVADE;

            // assisting case, healing and resurrection
            if (unit->HasUnitState(UNIT_STATE_ATTACK_PLAYER))
            {
                m_caster->SetContestedPvP();
                if (m_caster->IsPlayer() && !m_spellInfo->HasAttribute(SPELL_ATTR0_CU_NO_PVP_FLAG))
                    m_caster->ToPlayer()->UpdatePvP(true);
                //npcbot: bot assist case
                else if (m_caster->IsNPCBotOrPet() && m_caster->ToCreature()->IsFreeBot())
                {
                    if (Unit const* bot = m_caster->IsNPCBotPet() ? m_caster->ToUnit()->GetCreator() : m_caster->ToUnit())
                        BotMgr::SetBotContestedPvP(bot->ToCreature());
                }
                //end npcbot
            }

            // xinef: triggered spells should not prolong combat
            if (unit->IsInCombat() && !m_spellInfo->HasAttribute(SPELL_ATTR3_SUPRESS_TARGET_PROCS) && !m_triggeredByAuraSpell)
            {
                m_caster->SetInCombatState(unit->GetCombatTimer() > 0, unit);
                unit->getHostileRefMgr().threatAssist(m_caster, 0.0f);
            }
        }
    }

    uint8 aura_effmask = 0;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (effectMask & (1 << i) && m_spellInfo->Effects[i].IsUnitOwnedAuraEffect())
            aura_effmask |= 1 << i;

    Unit* originalCaster = GetOriginalCaster();
    if (!originalCaster)
        originalCaster = m_caster;

    // Get Data Needed for Diminishing Returns, some effects may have multiple auras, so this must be done on spell hit, not aura add
    // Xinef: Do not increase diminishing level for self cast
    m_diminishGroup = GetDiminishingReturnsGroupForSpell(m_spellInfo, m_triggeredByAuraSpell.spellInfo);
    // xinef: do not increase diminish level for bosses (eg. Void Reaver silence is never diminished)
    if (((m_spellFlags & SPELL_FLAG_REFLECTED) && !(unit->HasAuraType(SPELL_AURA_REFLECT_SPELLS))) || (aura_effmask && m_diminishGroup && unit != m_caster && (!m_caster->IsCreature() || !m_caster->ToCreature()->isWorldBoss())))
    {
        m_diminishLevel = unit->GetDiminishing(m_diminishGroup);
        DiminishingReturnsType type = GetDiminishingReturnsGroupType(m_diminishGroup);

        uint32 flagsExtra = unit->IsCreature() ? unit->ToCreature()->GetCreatureTemplate()->flags_extra : 0;

        // Increase Diminishing on unit, current informations for actually casts will use values above
        if ((type == DRTYPE_PLAYER && (unit->IsCharmedOwnedByPlayerOrPlayer() || flagsExtra & CREATURE_FLAG_EXTRA_ALL_DIMINISH ||
            (m_diminishGroup == DIMINISHING_TAUNT && (flagsExtra & CREATURE_FLAG_EXTRA_OBEYS_TAUNT_DIMINISHING_RETURNS)))) || type == DRTYPE_ALL)
        {
            // Do not apply diminish return if caster is NPC
            if (m_caster->IsCharmedOwnedByPlayerOrPlayer())
            {
                unit->IncrDiminishing(m_diminishGroup);
            }
            //npcbot
            else if (m_caster->IsNPCBotOrPet())
                unit->IncrDiminishing(m_diminishGroup);
            //end npcbot
        }
    }

    if (m_caster != unit && m_caster->IsHostileTo(unit) && !m_spellInfo->IsPositive() && !m_triggeredByAuraSpell && !m_spellInfo->HasAttribute(SPELL_ATTR0_CU_DONT_BREAK_STEALTH))
    {
        unit->RemoveAurasByType(SPELL_AURA_MOD_STEALTH);
    }

    if (aura_effmask)
    {
        // Select rank for aura with level requirements only in specific cases
        // Unit has to be target only of aura effect, both caster and target have to be players, target has to be other than unit target
        SpellInfo const* aurSpellInfo = m_spellInfo;
        int32 basePoints[3];
        if (scaleAura)
        {
            aurSpellInfo = m_spellInfo->GetAuraRankForLevel(unitTarget->GetLevel());
            ASSERT(aurSpellInfo);
            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            {
                basePoints[i] = aurSpellInfo->Effects[i].BasePoints;
                if (m_spellInfo->Effects[i].Effect != aurSpellInfo->Effects[i].Effect)
                {
                    aurSpellInfo = m_spellInfo;
                    break;
                }
            }
        }

        if (m_originalCaster)
        {
            bool refresh = false;
            bool refreshPeriodic = m_spellInfo->StackAmount < 2 && !HasTriggeredCastFlag(TRIGGERED_NO_PERIODIC_RESET);
            m_spellAura = Aura::TryRefreshStackOrCreate(aurSpellInfo, effectMask, unit, m_originalCaster,
                          (aurSpellInfo == m_spellInfo) ? &m_spellValue->EffectBasePoints[0] : &basePoints[0], m_CastItem, ObjectGuid::Empty, &refresh, refreshPeriodic);

            // xinef: if aura was not refreshed, add proc ex
            if (!refresh)
                m_procEx |= PROC_EX_NO_AURA_REFRESH;

            if (m_spellAura)
            {
                // Set aura stack amount to desired value
                if (m_spellValue->AuraStackAmount > 1)
                {
                    if (!refresh)
                        m_spellAura->SetStackAmount(m_spellValue->AuraStackAmount);
                    else
                        m_spellAura->ModStackAmount(m_spellValue->AuraStackAmount);
                }

                // Now Reduce spell duration using data received at spell hit
                int32 duration = m_spellAura->GetMaxDuration();
                int32 limitduration = GetDiminishingReturnsLimitDuration(m_diminishGroup, aurSpellInfo);

                // Xinef: if unit == caster - test versus original unit if available
                float diminishMod = 1.0f;
                if (unit == m_caster && m_targets.GetUnitTarget())
                    diminishMod = m_targets.GetUnitTarget()->ApplyDiminishingToDuration(m_diminishGroup, duration, m_originalCaster, m_diminishLevel, limitduration);
                else
                    diminishMod = unit->ApplyDiminishingToDuration(m_diminishGroup, duration, m_originalCaster, m_diminishLevel, limitduration);

                // unit is immune to aura if it was diminished to 0 duration
                if (diminishMod == 0.0f)
                {
                    m_spellAura->Remove();
                    if (m_diminishGroup == DIMINISHING_TAUNT)
                        return SPELL_MISS_IMMUNE;
                    bool found = false;
                    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                        if (effectMask & (1 << i) && m_spellInfo->Effects[i].Effect != SPELL_EFFECT_APPLY_AURA)
                            found = true;
                    if (!found)
                        return SPELL_MISS_IMMUNE;
                }
                else
                {
                    ((UnitAura*)m_spellAura)->SetDiminishGroup(m_diminishGroup);

                    bool positive = m_spellAura->GetSpellInfo()->IsPositive();
                    if (AuraApplication* aurApp = m_spellAura->GetApplicationOfTarget(m_originalCaster->GetGUID()))
                        positive = aurApp->IsPositive();

                    duration = m_originalCaster->ModSpellDuration(aurSpellInfo, unit, duration, positive, effectMask);

                    // xinef: haste affects duration of those spells twice
                    if (m_originalCaster->HasAuraTypeWithAffectMask(SPELL_AURA_PERIODIC_HASTE, aurSpellInfo) || m_spellInfo->HasAttribute(SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC))
                        duration = int32(duration * m_originalCaster->GetFloatValue(UNIT_MOD_CAST_SPEED));

                    if (m_spellValue->AuraDuration != 0)
                    {
                        if (m_spellAura->GetMaxDuration() != -1)
                        {
                            m_spellAura->SetMaxDuration(m_spellValue->AuraDuration);
                        }

                        m_spellAura->SetDuration(m_spellValue->AuraDuration);
                    }
                    else if (duration != m_spellAura->GetMaxDuration())
                    {
                        m_spellAura->SetMaxDuration(duration);
                        m_spellAura->SetDuration(duration);
                    }

                    // xinef: apply relic cooldown, imo best place to add this
                    if (m_CastItem && m_CastItem->GetTemplate()->InventoryType == INVTYPE_RELIC && m_triggeredByAuraSpell)
                        m_caster->AddSpellCooldown(SPELL_RELIC_COOLDOWN, m_CastItem->GetEntry(), duration);

                    m_spellAura->SetTriggeredByAuraSpellInfo(m_triggeredByAuraSpell.spellInfo);
                    m_spellAura->_RegisterForTargets();
                }
            }
        }
    }

    int8 sanct_effect = -1;

    for (uint32 effectNumber = 0; effectNumber < MAX_SPELL_EFFECTS; ++effectNumber)
    {
        // handle sanctuary effects after aura apply!
        if (m_spellInfo->Effects[effectNumber].Effect == SPELL_EFFECT_SANCTUARY)
        {
            sanct_effect = effectNumber;
            continue;
        }

        if (effectMask & (1 << effectNumber))
            HandleEffects(unit, nullptr, nullptr, effectNumber, SPELL_EFFECT_HANDLE_HIT_TARGET);
    }

    if( sanct_effect >= 0 && (effectMask & (1 << sanct_effect)) )
        HandleEffects(unit, nullptr, nullptr, sanct_effect, SPELL_EFFECT_HANDLE_HIT_TARGET);

    return SPELL_MISS_NONE;
}

void Spell::DoTriggersOnSpellHit(Unit* unit, uint8 effMask)
{
    // Apply additional spell effects to target
    /// @todo: move this code to scripts
    if (m_preCastSpell)
    {
        // Paladin immunity shields
        if (m_preCastSpell == 61988)
        {
            // Cast Forbearance
            m_caster->CastSpell(unit, 25771, true);
            // Cast Avenging Wrath Marker
            unit->CastSpell(unit, 61987, true);
        }

        // Avenging Wrath
        if (m_preCastSpell == 61987)
            // Cast the serverside immunity shield marker
            m_caster->CastSpell(unit, 61988, true);

        // Fearie Fire (Feral) - damage
        if( m_preCastSpell == 60089 )
            m_caster->CastSpell(unit, m_preCastSpell, true);
        else if (sSpellMgr->GetSpellInfo(m_preCastSpell))
            // Blizz seems to just apply aura without bothering to cast
            m_caster->AddAura(m_preCastSpell, unit);
    }

    // handle SPELL_AURA_ADD_TARGET_TRIGGER auras
    // this is executed after spell proc spells on target hit
    // spells are triggered for each hit spell target
    // info confirmed with retail sniffs of permafrost and shadow weaving
    if (!m_hitTriggerSpells.empty())
    {
        int _duration = 0;
        for (HitTriggerSpellList::const_iterator i = m_hitTriggerSpells.begin(); i != m_hitTriggerSpells.end(); ++i)
        {
            if (CanExecuteTriggersOnHit(effMask, i->triggeredByAura) && roll_chance_i(i->chance))
            {
                m_caster->CastSpell(unit, i->triggeredSpell->Id, true);
                LOG_DEBUG("spells.aura", "Spell {} triggered spell {} by SPELL_AURA_ADD_TARGET_TRIGGER aura", m_spellInfo->Id, i->triggeredSpell->Id);

                // SPELL_AURA_ADD_TARGET_TRIGGER auras shouldn't trigger auras without duration
                // set duration of current aura to the triggered spell
                if (i->triggeredSpell->GetDuration() == -1)
                {
                    if (Aura* triggeredAur = unit->GetAura(i->triggeredSpell->Id, m_caster->GetGUID()))
                    {
                        // get duration from aura-only once
                        if (!_duration)
                        {
                            Aura* aur = unit->GetAura(m_spellInfo->Id, m_caster->GetGUID());
                            _duration = aur ? aur->GetDuration() : -1;
                        }
                        triggeredAur->SetDuration(_duration);
                    }
                }
            }
        }
    }

    // trigger linked auras remove/apply
    /// @todo: remove/cleanup this, as this table is not documented and people are doing stupid things with it
    if (std::vector<int32> const* spellTriggered = sSpellMgr->GetSpellLinked(m_spellInfo->Id + SPELL_LINK_HIT))
    {
        for (std::vector<int32>::const_iterator i = spellTriggered->begin(); i != spellTriggered->end(); ++i)
            if (*i < 0)
            {
                unit->RemoveAurasDueToSpell(-(*i));
            }
            else
            {
                unit->CastSpell(unit, *i, true, 0, 0, m_caster->GetGUID());
            }
    }
}

void Spell::DoAllEffectOnTarget(GOTargetInfo* target)
{
    if (target->processed)                                  // Check target
        return;
    target->processed = true;                               // Target checked in apply effects procedure

    uint32 effectMask = target->effectMask;
    if (!effectMask)
        return;

    GameObject* go = m_caster->GetMap()->GetGameObject(target->targetGUID);
    if (!go)
        return;

    PrepareScriptHitHandlers();
    CallScriptBeforeHitHandlers(SPELL_MISS_NONE);

    for (uint32 effectNumber = 0; effectNumber < MAX_SPELL_EFFECTS; ++effectNumber)
        if (effectMask & (1 << effectNumber))
            HandleEffects(nullptr, nullptr, go, effectNumber, SPELL_EFFECT_HANDLE_HIT_TARGET);

    // xinef: inform ai about spellhit
    go->AI()->SpellHit(m_caster, m_spellInfo);

    CallScriptOnHitHandlers();

    CallScriptAfterHitHandlers();
}

void Spell::DoAllEffectOnTarget(ItemTargetInfo* target)
{
    uint32 effectMask = target->effectMask;
    if (!target->item || !effectMask)
        return;

    PrepareScriptHitHandlers();
    CallScriptBeforeHitHandlers(SPELL_MISS_NONE);

    for (uint32 effectNumber = 0; effectNumber < MAX_SPELL_EFFECTS; ++effectNumber)
        if (effectMask & (1 << effectNumber))
            HandleEffects(nullptr, target->item, nullptr, effectNumber, SPELL_EFFECT_HANDLE_HIT_TARGET);

    CallScriptOnHitHandlers();

    CallScriptAfterHitHandlers();
}

bool Spell::UpdateChanneledTargetList()
{
    // Not need check return true
    if (m_channelTargetEffectMask == 0)
        return true;

    uint8 channelTargetEffectMask = m_channelTargetEffectMask;
    uint8 channelAuraMask = 0;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (m_spellInfo->Effects[i].Effect == SPELL_EFFECT_APPLY_AURA)
            channelAuraMask |= 1 << i;

    channelAuraMask &= channelTargetEffectMask;

    float range = 0;
    if (channelAuraMask)
    {
        range = m_spellInfo->GetMaxRange(m_spellInfo->IsPositive());
        if (range == 0)
            for(int i = EFFECT_0; i <= EFFECT_2; ++i)
                if (channelAuraMask & (1 << i) && m_spellInfo->Effects[i].RadiusEntry)
                {
                    range = m_spellInfo->Effects[i].CalcRadius(nullptr, nullptr);
                    break;
                }

        if (Player* modOwner = m_caster->GetSpellModOwner())
            modOwner->ApplySpellMod(m_spellInfo->Id, SPELLMOD_RANGE, range, this);

        //npcbot: apply range mods
        if (m_caster->IsNPCBot())
            m_caster->ToCreature()->ApplyCreatureSpellRangeMods(m_spellInfo, range);
        //end npcbot

        // xinef: add little tolerance level
        range += std::min(3.0f, range * 0.1f); // 10% but no more than 3yd
    }

    for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
    {
        if (ihit->missCondition == SPELL_MISS_NONE && (channelTargetEffectMask & ihit->effectMask))
        {
            Unit* unit = m_caster->GetGUID() == ihit->targetGUID ? m_caster : ObjectAccessor::GetUnit(*m_caster, ihit->targetGUID);

            if (!unit)
                continue;

            if (IsValidDeadOrAliveTarget(unit))
            {
                if (channelAuraMask & ihit->effectMask)
                {
                    if (AuraApplication* aurApp = unit->GetAuraApplication(m_spellInfo->Id, m_originalCasterGUID))
                    {
                        if (m_caster != unit)
                        {
                            if (!m_caster->IsWithinDistInMap(unit, range))
                            {
                                ihit->effectMask &= ~aurApp->GetEffectMask();
                                unit->RemoveAura(aurApp);
                                continue;
                            }
                            // Xinef: Update Orientation server side (non players wont sent appropriate packets)
                            else if (m_spellInfo->HasAttribute(SPELL_ATTR1_TRACK_TARGET_IN_CHANNEL))
                                m_caster->UpdateOrientation(m_caster->GetAngle(unit));
                        }
                    }
                    else // aura is dispelled
                        continue;
                }

                channelTargetEffectMask &= ~ihit->effectMask;   // remove from need alive mask effect that have alive target
            }
        }
    }

    // Xinef: not all effects are covered, remove applications from all targets
    if (channelTargetEffectMask != 0)
    {
        for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
            if (ihit->missCondition == SPELL_MISS_NONE && (channelAuraMask & ihit->effectMask))
                if (Unit* unit = m_caster->GetGUID() == ihit->targetGUID ? m_caster : ObjectAccessor::GetUnit(*m_caster, ihit->targetGUID))
                    if (IsValidDeadOrAliveTarget(unit))
                        if (AuraApplication* aurApp = unit->GetAuraApplication(m_spellInfo->Id, m_originalCasterGUID))
                        {
                            ihit->effectMask &= ~aurApp->GetEffectMask();
                            unit->RemoveAura(aurApp);
                        }
    }

    // is all effects from m_needAliveTargetMask have alive targets
    return channelTargetEffectMask == 0;
}

SpellCastResult Spell::prepare(SpellCastTargets const* targets, AuraEffect const* triggeredByAura)
{
    if (m_CastItem)
    {
        m_castItemGUID = m_CastItem->GetGUID();
    }
    else
    {
        m_castItemGUID = ObjectGuid::Empty;
    }

    InitExplicitTargets(*targets);

    if (!sScriptMgr->CanPrepare(this, targets, triggeredByAura))
    {
        finish(false);
        return SPELL_FAILED_UNKNOWN;
    }

    // Fill aura scaling information
    if (sScriptMgr->CanScalingEverything(this) || m_caster->IsTotem() || (m_caster->IsControlledByPlayer() && !m_spellInfo->IsPassive() && m_spellInfo->SpellLevel && !m_spellInfo->IsChanneled() && !HasTriggeredCastFlag(TRIGGERED_IGNORE_AURA_SCALING)))
    {
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (m_spellInfo->Effects[i].Effect == SPELL_EFFECT_APPLY_AURA ||
                    m_spellInfo->Effects[i].Effect == SPELL_EFFECT_APPLY_AREA_AURA_PARTY ||
                    m_spellInfo->Effects[i].Effect == SPELL_EFFECT_APPLY_AREA_AURA_RAID)
            {
                // Change aura with ranks only if basepoints are taken from spellInfo and aura is positive
                if (m_spellInfo->IsPositiveEffect(i))
                {
                    m_auraScaleMask |= (1 << i);
                    if (m_spellValue->EffectBasePoints[i] != m_spellInfo->Effects[i].BasePoints)
                    {
                        m_auraScaleMask = 0;
                        break;
                    }
                }
            }
        }
    }

    m_spellState = SPELL_STATE_PREPARING;

    if (triggeredByAura)
    {
        m_triggeredByAuraSpell.Init(triggeredByAura);
    }

    // create and add update event for this spell
    _spellEvent = new SpellEvent(this);
    m_caster->m_Events.AddEvent(_spellEvent, m_caster->m_Events.CalculateTime(1));

    if (DisableMgr::IsDisabledFor(DISABLE_TYPE_SPELL, m_spellInfo->Id, m_caster))
    {
        SendCastResult(SPELL_FAILED_SPELL_UNAVAILABLE);
        finish(false);
        return SPELL_FAILED_SPELL_UNAVAILABLE;
    }

    //Prevent casting at cast another spell (ServerSide check)
    if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_CAST_IN_PROGRESS) && m_caster->IsNonMeleeSpellCast(false, true, true, m_spellInfo->Id == 75) && m_cast_count)
    {
        SendCastResult(SPELL_FAILED_SPELL_IN_PROGRESS);
        finish(false);
        return SPELL_FAILED_SPELL_IN_PROGRESS;
    }

    LoadScripts();

    OnSpellLaunch();

    m_powerCost = m_CastItem ? 0 : m_spellInfo->CalcPowerCost(m_caster, m_spellSchoolMask, this);

    // Set combo point requirement
    if (HasTriggeredCastFlag(TRIGGERED_IGNORE_COMBO_POINTS) || m_CastItem)
        m_needComboPoints = false;

    SpellCastResult result = CheckCast(true);
    if (result != SPELL_CAST_OK && !IsAutoRepeat())          //always cast autorepeat dummy for triggering
    {
        // Periodic auras should be interrupted when aura triggers a spell which can't be cast
        // for example bladestorm aura should be removed on disarm as of patch 3.3.5
        // channeled periodic spells should be affected by this (arcane missiles, penance, etc)
        // a possible alternative sollution for those would be validating aura target on unit state change
        if (m_caster->IsPlayer() && triggeredByAura && triggeredByAura->IsPeriodic() && !triggeredByAura->GetBase()->IsPassive())
        {
            SendChannelUpdate(0);
            triggeredByAura->GetBase()->SetDuration(0);
        }

        // Allows to cast melee attack spell if result is SPELL_FAILED_OUT_OF_RANGE
        if (!IsNextMeleeSwingSpell() || result != SPELL_FAILED_OUT_OF_RANGE)
        {
            SendCastResult(result);

            finish(false);
            return result;
        }
    }

    // Prepare data for triggers
    prepareDataForTriggerSystem(triggeredByAura);

    // calculate cast time (calculated after first CheckCast check to prevent charge counting for first CheckCast fail)
    m_casttime = HasTriggeredCastFlag(TRIGGERED_CAST_DIRECTLY) ? 0 : m_spellInfo->CalcCastTime(m_caster, this);

    if (m_caster->IsPlayer())
        if (m_caster->ToPlayer()->GetCommandStatus(CHEAT_CASTTIME))
            m_casttime = 0;

    // don't allow channeled spells / spells with cast time to be casted while moving
    // (even if they are interrupted on moving, spells with almost immediate effect get to have their effect processed before movement interrupter kicks in)
    if ((m_spellInfo->IsChanneled() || m_casttime) && m_caster->IsPlayer() && m_caster->isMoving() && m_spellInfo->InterruptFlags & SPELL_INTERRUPT_FLAG_MOVEMENT && !IsTriggered())
    {
        // 1. Has casttime, 2. Or doesn't have flag to allow action during channel
        if (m_casttime || !m_spellInfo->IsActionAllowedChannel())
        {
            SendCastResult(SPELL_FAILED_MOVING);
            finish(false);
            return SPELL_FAILED_MOVING;
        }
    }

    // xinef: if spell have nearby target entry only, do not allow to cast if no targets are found
    if (m_CastItem)
    {
        bool selectTargets = false;
        bool nearbyDest = false;

        for (uint8 i = EFFECT_0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (!m_spellInfo->Effects[i].IsEffect())
                continue;

            if (m_spellInfo->Effects[i].TargetA.GetSelectionCategory() != TARGET_SELECT_CATEGORY_NEARBY || m_spellInfo->Effects[i].TargetA.GetCheckType() != TARGET_CHECK_ENTRY)
            {
                selectTargets = false;
                break;
            }

            if (m_spellInfo->Effects[i].TargetA.GetObjectType() == TARGET_OBJECT_TYPE_DEST)
            {
                nearbyDest = true;
            }

            // xinef: by default set it to false, and to true if any valid target is found
            selectTargets = true;
        }

        if (selectTargets)
        {
            SelectSpellTargets();
            _spellTargetsSelected = true;
            bool spellFailed = false;

            if (m_UniqueTargetInfo.empty() && m_UniqueGOTargetInfo.empty())
            {
                // no valid nearby target unit or game object found; check if nearby destination type
                if (nearbyDest)
                {
                    if (!m_targets.HasDst())
                    {
                        // no valid target destination
                        spellFailed = true;
                    }
                }
                else
                {
                    spellFailed = true;
                }
            }

            if (spellFailed)
            {
                SendCastResult(SPELL_FAILED_CASTER_AURASTATE);
                finish(false);
                return SPELL_FAILED_CASTER_AURASTATE;
            }
        }
    }

    // set timer base at cast time
    ReSetTimer();

    LOG_DEBUG("spells.aura", "Spell::prepare: spell id {} source {} caster {} customCastFlags {} mask {}", m_spellInfo->Id, m_caster->GetEntry(), m_originalCaster ? m_originalCaster->GetEntry() : -1, _triggeredCastFlags, m_targets.GetTargetMask());

    if (!(m_spellInfo->AuraInterruptFlags & AURA_INTERRUPT_FLAG_NOT_SEATED) && !(m_spellInfo->Attributes & SPELL_ATTR0_ALLOW_WHILE_SITTING) && !m_triggeredByAuraSpell && m_caster->IsSitState())
    {
        //npcbot
        if (!m_originalCaster || m_caster == m_originalCaster)
        //end npcbot
        m_caster->SetStandState(UNIT_STAND_STATE_STAND);
    }

    //Containers for channeled spells have to be set
    //TODO:Apply this to all casted spells if needed
    // Why check duration? 29350: channelled triggers channelled
    if (HasTriggeredCastFlag(TRIGGERED_CAST_DIRECTLY) && (!m_spellInfo->IsChanneled() || !m_spellInfo->GetMaxDuration()))
        cast(true);
    else
    {
        // stealth must be removed at cast starting (at show channel bar)
        // skip triggered spell (item equip spell casting and other not explicit character casts/item uses)
        if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_AURA_INTERRUPT_FLAGS) && m_spellInfo->IsBreakingStealth())
        {
            // Farsight spells exception
            uint32 exceptSpellId = 0;
            if (m_spellInfo->HasEffect(SPELL_EFFECT_ADD_FARSIGHT))
            {
                exceptSpellId = m_spellInfo->Id;
            }

            m_caster->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_CAST, exceptSpellId, m_spellInfo->Id == 75);
            m_caster->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_SPELL_ATTACK, exceptSpellId, m_spellInfo->Id == 75);
        }

        m_caster->SetCurrentCastedSpell(this);
        SendSpellStart();

        // set target for proper facing
        if ((m_casttime || m_spellInfo->IsChanneled()) && !HasTriggeredCastFlag(TRIGGERED_IGNORE_SET_FACING))
        {
            if (m_caster->IsCreature() && !m_caster->ToCreature()->IsInEvadeMode() &&
                    ((m_targets.GetObjectTarget() && m_caster != m_targets.GetObjectTarget()) || m_spellInfo->IsPositive()))
            {
                // Xinef: Creature should focus to cast target if there is explicit target or self if casting positive spell
                // Xinef: Creature should not rotate when casting spell... based on halion behavior
                m_caster->ToCreature()->FocusTarget(this, m_targets.GetObjectTarget() != nullptr ? m_targets.GetObjectTarget() : m_caster);
            }
        }

        //npcbot
        // Call CreatureAI hook OnSpellStart
        if (Creature* caster = m_caster->ToCreature())
            if (caster->IsAIEnabled)
                caster->AI()->OnSpellStart(GetSpellInfo());
        //end npcbot

        //item: first cast may destroy item and second cast causes crash
        // xinef: removed !m_spellInfo->StartRecoveryTime
        // second los check failed in events
        // xinef: removed itemguid check, currently there is no such item in database
        if (!m_casttime && /*!m_castItemGUID &&*/ GetCurrentContainer() == CURRENT_GENERIC_SPELL)
            cast(true);

        if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_GCD))
            TriggerGlobalCooldown();
    }

    return SPELL_CAST_OK;
}

void Spell::cancel(bool bySelf)
{
    if (m_spellState == SPELL_STATE_FINISHED)
        return;

    uint32 oldState = m_spellState;
    m_spellState = SPELL_STATE_FINISHED;

    m_autoRepeat = false;
    switch (oldState)
    {
        case SPELL_STATE_PREPARING:
            CancelGlobalCooldown();
            SendCastResult(SPELL_FAILED_INTERRUPTED);

            if (m_caster->IsPlayer())
            {
                if (m_caster->ToPlayer()->NeedSendSpectatorData())
                    ArenaSpectator::SendCommand_Spell(m_caster->FindMap(), m_caster->GetGUID(), "SPE", m_spellInfo->Id, bySelf ? 99998 : 99999);
            }
            [[fallthrough]];
        case SPELL_STATE_DELAYED:
            SendInterrupted(SPELL_FAILED_INTERRUPTED);
            break;
        case SPELL_STATE_CASTING:
            if (!bySelf)
            {
                for (std::list<TargetInfo>::const_iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
                    if ((*ihit).missCondition == SPELL_MISS_NONE)
                        if (Unit* unit = m_caster->GetGUID() == ihit->targetGUID ? m_caster : ObjectAccessor::GetUnit(*m_caster, ihit->targetGUID))
                            unit->RemoveOwnedAura(m_spellInfo->Id, m_originalCasterGUID, 0, AURA_REMOVE_BY_CANCEL);

                if (m_caster->IsPlayer() && m_spellInfo->IsCooldownStartedOnEvent())
                    m_caster->ToPlayer()->RemoveSpellCooldown(m_spellInfo->Id, true);

                SendChannelUpdate(0);
                SendInterrupted(SPELL_FAILED_INTERRUPTED);
            }

            if (m_caster->IsPlayer() && m_caster->ToPlayer()->NeedSendSpectatorData())
                ArenaSpectator::SendCommand_Spell(m_caster->FindMap(), m_caster->GetGUID(), "SPE", m_spellInfo->Id, bySelf ? 99998 : 99999);

            // spell is canceled-take mods and clear list
            if (Player* player = m_caster->GetSpellModOwner())
                player->RemoveSpellMods(this);

            m_appliedMods.clear();
            break;
        default:
            break;
    }

    SetReferencedFromCurrent(false);
    if (m_selfContainer && *m_selfContainer == this)
        *m_selfContainer = nullptr;

    // Do not remove current far sight object (already done in Spell::EffectAddFarsight) to prevent from reset viewpoint to player
    if (!(bySelf && m_spellInfo->HasEffect(SPELL_EFFECT_ADD_FARSIGHT)))
    {
        m_caster->RemoveDynObject(m_spellInfo->Id);
    }

    if (m_spellInfo->IsChanneled()) // if not channeled then the object for the current cast wasn't summoned yet
        m_caster->RemoveGameObject(m_spellInfo->Id, true);

    //set state back so finish will be processed
    m_spellState = oldState;

    finish(false);
}

void Spell::cast(bool skipCheck)
{
    Player* modOwner = m_caster->GetSpellModOwner();
    Spell* lastMod = nullptr;
    if (modOwner)
    {
        lastMod = modOwner->m_spellModTakingSpell;
        if (lastMod)
            modOwner->SetSpellModTakingSpell(lastMod, false);
    }

    _cast(skipCheck);

    if (lastMod)
        modOwner->SetSpellModTakingSpell(lastMod, true);
}

void Spell::_cast(bool skipCheck)
{
    // update pointers base at GUIDs to prevent access to non-existed already object
    if (!UpdatePointers())
    {
        // cancel the spell if UpdatePointers() returned false, something wrong happened there
        cancel();
        return;
    }

    // cancel at lost explicit target during cast
    if (m_targets.GetObjectTargetGUID() && !m_targets.GetObjectTarget())
    {
        cancel();
        return;
    }

    // Xinef: implement attribute SPELL_ATTR1_DISMISS_PET_FIRST, on spell cast current pet is dismissed and charms are removed
    if (m_spellInfo->HasAttribute(SPELL_ATTR1_DISMISS_PET_FIRST))
    {
        if (m_caster->IsPlayer() && !m_spellInfo->HasEffect(SPELL_EFFECT_SUMMON_PET))
            if (Pet* pet = m_caster->ToPlayer()->GetPet())
                m_caster->ToPlayer()->RemovePet(pet, PET_SAVE_AS_CURRENT);

        if (Unit* charm = m_caster->GetCharm())
            charm->RemoveAurasByType(SPELL_AURA_MOD_CHARM, m_caster->GetGUID());
    }

    if (Player* playerCaster = m_caster->ToPlayer())
    {
        // now that we've done the basic check, now run the scripts
        // should be done before the spell is actually executed
        sScriptMgr->OnPlayerSpellCast(playerCaster, this, skipCheck);

        // As of 3.0.2 pets begin attacking their owner's target immediately
        // Let any pets know we've attacked something. Check DmgClass for harmful spells only
        // This prevents spells such as Hunter's Mark from triggering pet attack
        // xinef: take into account SPELL_ATTR3_SUPRESS_TARGET_PROCS
        if ((m_targets.GetTargetMask() & TARGET_FLAG_UNIT) && GetSpellInfo()->DmgClass != SPELL_DAMAGE_CLASS_NONE && !GetSpellInfo()->HasAttribute(SPELL_ATTR3_SUPRESS_TARGET_PROCS))
            if (!playerCaster->m_Controlled.empty())
                for (Unit::ControlSet::iterator itr = playerCaster->m_Controlled.begin(); itr != playerCaster->m_Controlled.end(); ++itr)
                    if (Unit* pet = *itr)
                        if (pet->IsAlive() && pet->IsCreature())
                            pet->ToCreature()->AI()->OwnerAttacked(m_targets.GetUnitTarget());
    }

    SetExecutedCurrently(true);

    if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_SET_FACING))
        if (m_caster->IsCreature() && m_targets.GetObjectTarget() && m_caster != m_targets.GetObjectTarget())
            m_caster->SetInFront(m_targets.GetObjectTarget());

    CallScriptBeforeCastHandlers();

    Player* modOwner = m_caster->GetSpellModOwner();
    // skip check if done already (for instant cast spells for example)
    if (!skipCheck)
    {
        SpellCastResult castResult = CheckCast(false);
        if (castResult != SPELL_CAST_OK)
        {
            SendCastResult(castResult);
            SendInterrupted(0);

            //npcbot - hook for spellcast finish (unsuccessful)
            if (m_caster->IsNPCBotOrPet())
                BotMgr::OnBotSpellGo(m_caster->ToCreature(), this, false);
            //end npcbot

            finish(false);
            SetExecutedCurrently(false);
            return;
        }

        // additional check after cast bar completes (must not be in CheckCast)
        // if trade not complete then remember it in trade data
        if (m_targets.GetTargetMask() & TARGET_FLAG_TRADE_ITEM)
        {
            if (m_caster->IsPlayer())
            {
                if (TradeData* my_trade = m_caster->ToPlayer()->GetTradeData())
                {
                    if (!my_trade->IsInAcceptProcess())
                    {
                        // Spell will be casted at completing the trade. Silently ignore at this place
                        my_trade->SetSpell(m_spellInfo->Id, m_CastItem);
                        SendCastResult(SPELL_FAILED_DONT_REPORT);
                        SendInterrupted(0);

                        finish(false);
                        SetExecutedCurrently(false);
                        return;
                    }
                }
            }
        }
    }

    if (modOwner)
        modOwner->SetSpellModTakingSpell(this, true);

    if (!_spellTargetsSelected)
        SelectSpellTargets();

    if (modOwner)
        modOwner->SetSpellModTakingSpell(this, false);

    // Spell may be finished after target map check
    if (m_spellState == SPELL_STATE_FINISHED)
    {
        SendInterrupted(0);
        finish(false);

        //npcbot - hook for spellcast finish (unsuccessful)
        if (m_caster->IsNPCBotOrPet())
            BotMgr::OnBotSpellGo(m_caster->ToCreature(), this, false);
        //end npcbot

        SetExecutedCurrently(false);
        return;
    }

    if (modOwner)
        modOwner->SetSpellModTakingSpell(this, true);

    PrepareTriggersExecutedOnHit();

    CallScriptOnCastHandlers();

    if (modOwner)
        modOwner->SetSpellModTakingSpell(this, false);

    // traded items have trade slot instead of guid in m_itemTargetGUID
    // set to real guid to be sent later to the client
    m_targets.UpdateTradeSlotItem();

    if (m_caster->IsPlayer())
    {
        if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_CAST_ITEM) && m_CastItem)
        {
            m_caster->ToPlayer()->StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_ITEM, m_CastItem->GetEntry());
            m_caster->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_USE_ITEM, m_CastItem->GetEntry());
        }

        m_caster->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_CAST_SPELL, m_spellInfo->Id, 0, (m_targets.GetUnitTarget() ? m_targets.GetUnitTarget() : m_caster));
    }

    if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_POWER_AND_REAGENT_COST))
    {
        // Powers have to be taken before SendSpellGo
        TakePower();
        TakeReagents();                                         // we must remove reagents before HandleEffects to allow place crafted item in same slot
    }
    else if (Item* targetItem = m_targets.GetItemTarget())
    {
        /// Not own traded item (in trader trade slot) req. reagents including triggered spell case
        if (targetItem->GetOwnerGUID() != m_caster->GetGUID())
            TakeReagents();
    }

    SendSpellCooldown();

    // CAST SPELL
    if (modOwner)
        modOwner->SetSpellModTakingSpell(this, true);

    PrepareScriptHitHandlers();

    HandleLaunchPhase();

    // we must send smsg_spell_go packet before m_castItem delete in TakeCastItem()...
    SendSpellGo();

    if (modOwner)
        modOwner->SetSpellModTakingSpell(this, false);

    if (m_originalCaster)
    {
        // Handle procs on cast
        uint32 procAttacker = m_procAttacker;
        if (!procAttacker)
        {
            bool IsPositive = m_spellInfo->IsPositive();
            if (m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_MAGIC)
            {
                procAttacker = IsPositive ? PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS : PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG;
            }
            else
            {
                procAttacker = IsPositive ? PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_POS : PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_NEG;
            }
        }

        uint32 procEx = PROC_EX_NORMAL_HIT;

        for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
        {
            if (ihit->missCondition != SPELL_MISS_NONE)
            {
                continue;
            }

            if (!ihit->crit)
            {
                continue;
            }

            procEx |= PROC_EX_CRITICAL_HIT;
            break;
        }

        Unit::ProcDamageAndSpell(m_originalCaster, m_originalCaster, procAttacker, PROC_FLAG_NONE, procEx, 1, BASE_ATTACK, m_spellInfo, m_triggeredByAuraSpell.spellInfo,
            m_triggeredByAuraSpell.effectIndex, this, nullptr, nullptr, PROC_SPELL_PHASE_CAST);
    }

    if (modOwner)
        modOwner->SetSpellModTakingSpell(this, true);

    bool resetAttackTimers = IsAutoActionResetSpell() && !m_spellInfo->HasAttribute(SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS);
    if (resetAttackTimers)
    {
        Unit::AuraEffectList const& vIgnoreReset = m_caster->GetAuraEffectsByType(SPELL_AURA_IGNORE_MELEE_RESET);
        for (Unit::AuraEffectList::const_iterator i = vIgnoreReset.begin(); i != vIgnoreReset.end(); ++i)
        {
            if ((*i)->IsAffectedOnSpell(m_spellInfo))
            {
                resetAttackTimers = false;
                break;
            }
        }
    }

    // Okay, everything is prepared. Now we need to distinguish between immediate and evented delayed spells
    if ((m_spellInfo->Speed > 0.0f && !m_spellInfo->IsChanneled())/* xinef: we dont need this || m_spellInfo->Id == 14157*/)
    {
        // Remove used for cast item if need (it can be already nullptr after TakeReagents call
        // in case delayed spell remove item at cast delay start
        TakeCastItem();

        // Okay, maps created, now prepare flags
        m_immediateHandled = false;
        m_spellState = SPELL_STATE_DELAYED;
        SetDelayStart(0);

        if (m_caster->HasUnitState(UNIT_STATE_CASTING) && !m_caster->IsNonMeleeSpellCast(false, false, true))
            m_caster->ClearUnitState(UNIT_STATE_CASTING);

        // remove all applied mods at this point
        // dont allow user to use them twice in case spell did not reach current target
        if (modOwner)
            modOwner->RemoveSpellMods(this);

        // Xinef: why do we keep focus after spell is sent to air?
        // Xinef: Because of this, in the middle of some animation after setting targetguid to 0 etc
        // Xinef: we get focused to it out of nowhere...
        if (Creature* creatureCaster = m_caster->ToCreature())
            creatureCaster->ReleaseFocus(this);
    }
    else
    {
        // Immediate spell, no big deal
        handle_immediate();
    }

    //npcbot - hook for spellcast finish
    if (m_caster->IsNPCBotOrPet())
        BotMgr::OnBotSpellGo(m_caster->ToCreature(), this);
    //npcbot - hook for master's spellcast finish
    else if (m_caster->GetTypeId() == TYPEID_PLAYER && m_caster->ToPlayer()->HaveBot())
        BotMgr::OnBotOwnerSpellGo(m_caster->ToPlayer(), this);
    //npcbot - hook for master's vehicle spellcast finish
    else if (m_caster->ToUnit() && m_caster->ToUnit()->IsVehicle())
        BotMgr::OnVehicleSpellGo(m_caster->ToUnit(), this);
    //end npcbot

    if (resetAttackTimers)
    {
        if (m_casttime == 0 && m_spellInfo->CalcCastTime())
        {
            resetAttackTimers = false;
        }

        if (resetAttackTimers)
        {
            m_caster->resetAttackTimer(BASE_ATTACK);

            if (m_caster->haveOffhandWeapon())
            {
                m_caster->resetAttackTimer(OFF_ATTACK);
            }

            m_caster->resetAttackTimer(RANGED_ATTACK);
        }
    }

    CallScriptAfterCastHandlers();

    if (modOwner)
        modOwner->SetSpellModTakingSpell(this, false);

    if (const std::vector<int32>* spell_triggered = sSpellMgr->GetSpellLinked(m_spellInfo->Id))
    {
        for (std::vector<int32>::const_iterator i = spell_triggered->begin(); i != spell_triggered->end(); ++i)
            if (*i < 0)
                m_caster->RemoveAurasDueToSpell(-(*i));
            else
                m_caster->CastSpell(m_targets.GetUnitTarget() ? m_targets.GetUnitTarget() : m_caster, *i, true);
    }

    // Interrupt Spell casting
    // handle this here, in other places SpellHitTarget can be set to nullptr, if there is an error in this function
    if (m_spellInfo->HasAttribute(SPELL_ATTR7_CAN_CAUSE_INTERRUPT))
        if (Unit* target = m_targets.GetUnitTarget())
            if (target->IsCreature())
                m_caster->CastSpell(target, 32747, true);

    // xinef: start combat at cast for delayed spells, only for explicit target
    if (Unit* target = m_targets.GetUnitTarget())
        if (m_caster->IsPlayer() || (m_caster->IsPet() && m_caster->IsControlledByPlayer()))
            if (GetDelayMoment() > 0 && !m_caster->IsFriendlyTo(target) && !m_spellInfo->HasAura(SPELL_AURA_BIND_SIGHT) && (!m_spellInfo->IsPositive() || m_spellInfo->HasEffect(SPELL_EFFECT_DISPEL)))
                m_caster->CombatStartOnCast(target, !m_spellInfo->HasAttribute(SPELL_ATTR3_SUPRESS_TARGET_PROCS), GetDelayMoment() + 500); // xinef: increase this time so we dont leave and enter combat in a moment

    if (m_caster->IsPlayer())
        if (m_caster->ToPlayer()->GetCommandStatus(CHEAT_COOLDOWN))
            m_caster->ToPlayer()->RemoveSpellCooldown(m_spellInfo->Id, true);

    SetExecutedCurrently(false);
}

void Spell::handle_immediate()
{
    // start channeling if applicable
    if (m_spellInfo->IsChanneled())
    {
        int32 duration = m_spellInfo->GetDuration();
        if (HasTriggeredCastFlag(TRIGGERED_IGNORE_EFFECTS))
            duration = -1;

        if (duration > 0)
        {
            // First mod_duration then haste - see Missile Barrage
            // Apply duration mod
            if (Player* modOwner = m_caster->GetSpellModOwner())
                modOwner->ApplySpellMod(m_spellInfo->Id, SPELLMOD_DURATION, duration);

            // Apply haste mods
            if (m_caster->HasAuraTypeWithAffectMask(SPELL_AURA_PERIODIC_HASTE, m_spellInfo) || m_spellInfo->HasAttribute(SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC))
                duration = int32(duration * m_caster->GetFloatValue(UNIT_MOD_CAST_SPEED));

            m_spellState = SPELL_STATE_CASTING;
            m_caster->AddInterruptMask(m_spellInfo->ChannelInterruptFlags);
            m_channeledDuration = duration;
            SendChannelStart(duration);
        }
        else if (duration == -1)
        {
            m_spellState = SPELL_STATE_CASTING;
            m_caster->AddInterruptMask(m_spellInfo->ChannelInterruptFlags);
            SendChannelStart(duration);
        }
    }

    PrepareTargetProcessing();

    // process immediate effects (items, ground, etc.) also initialize some variables
    _handle_immediate_phase();

    for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
        DoAllEffectOnTarget(&(*ihit));

    for (std::list<GOTargetInfo>::iterator ihit = m_UniqueGOTargetInfo.begin(); ihit != m_UniqueGOTargetInfo.end(); ++ihit)
        DoAllEffectOnTarget(&(*ihit));

    FinishTargetProcessing();

    // spell is finished, perform some last features of the spell here
    _handle_finish_phase();

    // Remove used for cast item if need (it can be already nullptr after TakeReagents call
    TakeCastItem();

    // handle ammo consumption for Hunter's volley spell
    if (m_spellInfo->IsRangedWeaponSpell() && m_spellInfo->IsChanneled())
        TakeAmmo();

    if (m_spellState != SPELL_STATE_CASTING)
        finish(true);                                       // successfully finish spell cast (not last in case autorepeat or channel spell)
}

uint64 Spell::handle_delayed(uint64 t_offset)
{
    if (!UpdatePointers())
    {
        // finish the spell if UpdatePointers() returned false, something wrong happened there
        finish(false);
        return 0;
    }

    Player* modOwner = m_caster->GetSpellModOwner();
    if (modOwner)
        modOwner->SetSpellModTakingSpell(this, true);

    uint64 next_time = m_delayTrajectory;

    PrepareTargetProcessing();

    if (!m_immediateHandled && m_delayTrajectory <= t_offset)
    {
        _handle_immediate_phase();
        m_immediateHandled = true;
        m_delayTrajectory = 0;
        next_time = 0;
    }

    bool single_missile = (m_targets.HasDst());

    // now recheck units targeting correctness (need before any effects apply to prevent adding immunity at first effect not allow apply second spell effect and similar cases)
    for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
    {
        if (ihit->processed == false)
        {
            if (single_missile || ihit->timeDelay <= t_offset)
            {
                ihit->timeDelay = t_offset;
                DoAllEffectOnTarget(&(*ihit));
            }
            else if (next_time == 0 || ihit->timeDelay < next_time)
                next_time = ihit->timeDelay;
        }
    }

    // now recheck gameobject targeting correctness
    for (std::list<GOTargetInfo>::iterator ighit = m_UniqueGOTargetInfo.begin(); ighit != m_UniqueGOTargetInfo.end(); ++ighit)
    {
        if (ighit->processed == false)
        {
            if (single_missile || ighit->timeDelay <= t_offset)
                DoAllEffectOnTarget(&(*ighit));
            else if (next_time == 0 || ighit->timeDelay < next_time)
                next_time = ighit->timeDelay;
        }
    }

    FinishTargetProcessing();

    if (modOwner)
        modOwner->SetSpellModTakingSpell(this, false);

    // All targets passed - need finish phase
    if (next_time == 0)
    {
        // spell is finished, perform some last features of the spell here
        _handle_finish_phase();

        finish(true);                                       // successfully finish spell cast

        // return zero, spell is finished now
        return 0;
    }
    else
    {
        // spell is unfinished, return next execution time
        return next_time;
    }
}

void Spell::_handle_immediate_phase()
{
    m_spellAura = nullptr;
    // initialize Diminishing Returns Data
    m_diminishLevel = DIMINISHING_LEVEL_1;
    m_diminishGroup = DIMINISHING_NONE;

    // handle some immediate features of the spell here
    HandleThreatSpells();

    PrepareScriptHitHandlers();

    // handle effects with SPELL_EFFECT_HANDLE_HIT mode
    for (uint32 j = 0; j < MAX_SPELL_EFFECTS; ++j)
    {
        // don't do anything for empty effect
        if (!m_spellInfo->Effects[j].IsEffect())
            continue;

        // call effect handlers to handle destination hit
        HandleEffects(nullptr, nullptr, nullptr, j, SPELL_EFFECT_HANDLE_HIT);
    }

    // process items
    for (std::list<ItemTargetInfo>::iterator ihit = m_UniqueItemInfo.begin(); ihit != m_UniqueItemInfo.end(); ++ihit)
        DoAllEffectOnTarget(&(*ihit));
}

void Spell::_handle_finish_phase()
{
    // Take for real after all targets are processed
    if (m_needComboPoints)
    {
        m_caster->ClearComboPoints();
    }

    // Real add combo points from effects
    if (m_comboTarget && m_comboPointGain)
    {
        // remove Premed-like effects unless they were caused by ourselves
        // (this Aura removes the already-added CP when it expires from duration - now that we've added CP, this shouldn't happen anymore!)
        if (!m_spellInfo->HasAura(SPELL_AURA_RETAIN_COMBO_POINTS))
        {
            m_caster->RemoveAurasByType(SPELL_AURA_RETAIN_COMBO_POINTS);
        }

        m_caster->AddComboPoints(m_comboTarget, m_comboPointGain);
    }

    if (m_spellInfo->HasEffect(SPELL_EFFECT_ADD_EXTRA_ATTACKS))
    {
        m_caster->SetLastExtraAttackSpell(m_spellInfo->Id);
    }

    if (!IsAutoRepeat() && !IsNextMeleeSwingSpell())
        if (m_caster->GetCharmerOrOwnerPlayerOrPlayerItself())
            for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
            {
                // Xinef: Properly clear infinite cooldowns in some cases
                if (ihit->targetGUID == m_caster->GetGUID() && ihit->missCondition != SPELL_MISS_NONE)
                    if (m_caster->IsPlayer() && m_spellInfo->IsCooldownStartedOnEvent())
                        m_caster->ToPlayer()->SendCooldownEvent(m_spellInfo);
            }

    // Handle procs on finish
    if (m_originalCaster)
    {
        uint32 procAttacker = m_procAttacker;
        if (!procAttacker)
        {
            bool IsPositive = m_spellInfo->IsPositive();
            if (m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_MAGIC)
            {
                procAttacker = IsPositive ? PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS : PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG;
            }
            else
            {
                procAttacker = IsPositive ? PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_POS : PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_NEG;
            }
        }

        uint32 procEx = PROC_EX_NORMAL_HIT;
        for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
        {
            if (ihit->missCondition != SPELL_MISS_NONE)
            {
                continue;
            }

            if (!ihit->crit)
            {
                continue;
            }

            procEx |= PROC_EX_CRITICAL_HIT;
            break;
        }

        Unit::ProcDamageAndSpell(m_originalCaster, m_originalCaster, procAttacker, PROC_FLAG_NONE, procEx, 1, BASE_ATTACK, m_spellInfo, m_triggeredByAuraSpell.spellInfo,
            m_triggeredByAuraSpell.effectIndex, this, nullptr, nullptr, PROC_SPELL_PHASE_FINISH);
    }
}

void Spell::SendSpellCooldown()
{
    // xinef: properly add creature cooldowns
    if (!m_caster->IsPlayer())
    {
        if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD))
        {
            // xinef: this should be added here
            //m_caster->AddSpellCooldown(m_spellInfo->Id, 0, 0);

            // xinef: this adds cooldowns to vehicle spells which misses them client-side (when we overwrote dbc info in eg.)
            if (m_spellInfo->RequireCooldownInfo())
                if (Player* player = m_caster->GetCharmerOrOwnerPlayerOrPlayerItself())
                {
                    WorldPacket data(SMSG_SPELL_COOLDOWN, 8 + 1 + 4 + 4);
                    data << m_caster->GetGUID();
                    data << uint8(SPELL_COOLDOWN_FLAG_INCLUDE_GCD);
                    data << uint32(m_spellInfo->Id);
                    data << uint32(m_spellInfo->RecoveryTime);
                    player->SendDirectMessage(&data);
                }
        }
        return;
    }

    Player* _player = m_caster->ToPlayer();

    // mana/health/etc potions, disabled by client (until combat out as declarate)
    if (m_CastItem && (m_CastItem->IsPotion() || m_spellInfo->IsCooldownStartedOnEvent()))
    {
        // need in some way provided data for Spell::finish SendCooldownEvent
        _player->SetLastPotionId(m_CastItem->GetEntry());
        return;
    }

    // have infinity cooldown but set at aura apply
    // do not set cooldown for triggered spells (needed by reincarnation)
    if (m_spellInfo->IsCooldownStartedOnEvent()
        || m_spellInfo->IsPassive()
        || (HasTriggeredCastFlag(TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD) && !m_CastItem)
        || HasTriggeredCastFlag(TRIGGERED_IGNORE_EFFECTS))
        return;

    _player->AddSpellAndCategoryCooldowns(m_spellInfo, m_CastItem ? m_CastItem->GetEntry() : 0, this);
}

void Spell::update(uint32 difftime)
{
    // update pointers based at it's GUIDs
    if (!UpdatePointers())
    {
        // cancel the spell if UpdatePointers() returned false, something wrong happened there
        cancel();
        return;
    }

    if (m_targets.GetUnitTargetGUID() && !m_targets.GetUnitTarget())
    {
        LOG_DEBUG("spells.aura", "Spell {} is cancelled due to removal of target.", m_spellInfo->Id);
        cancel();
        return;
    }

    // check if the player caster has moved before the spell finished
    // xinef: added preparing state (real cast, skip channels as they have other flags for this)
    if ((m_caster->IsPlayer() && m_timer != 0) &&
            m_caster->isMoving() && (m_spellInfo->InterruptFlags & SPELL_INTERRUPT_FLAG_MOVEMENT) && m_spellState == SPELL_STATE_PREPARING &&
            (m_spellInfo->Effects[0].Effect != SPELL_EFFECT_STUCK || !m_caster->HasUnitMovementFlag(MOVEMENTFLAG_FALLING_FAR)))
    {
        // don't cancel for melee, autorepeat, triggered and instant spells
        if (!IsNextMeleeSwingSpell() && !IsAutoRepeat() && !IsTriggered())
            cancel(true);
    }

    switch (m_spellState)
    {
        case SPELL_STATE_PREPARING:
            {
                if (m_timer > 0)
                {
                    if (difftime >= (uint32)m_timer)
                        m_timer = 0;
                    else
                        m_timer -= difftime;
                }

                if (m_timer == 0 && !IsNextMeleeSwingSpell() && !IsAutoRepeat())
                    // don't CheckCast for instant spells - done in spell::prepare, skip duplicate checks, needed for range checks for example
                    cast(!m_casttime);
                break;
            }
        case SPELL_STATE_CASTING:
            {
                if (m_timer)
                {
                    if (m_timer > 0)
                    {
                        if (difftime >= (uint32)m_timer)
                            m_timer = 0;
                        else
                            m_timer -= difftime;
                    }
                }

                if (m_timer == 0)
                {
                    SendChannelUpdate(0);

                    finish();

                    //npcbot: signal channel finish to botmgr
                    if (m_caster->IsNPCBot())
                        BotMgr::OnBotChannelFinish(m_caster->ToUnit(), this);
                    //end npcbot
                }
                // Xinef: Dont update channeled target list on last tick, allow auras to update duration properly
                // Xinef: Added this strange check because of diffrent update routines for players / creatures
                // Xinef: If creature gets new aura in 800ms and in 840ms its updated with diff 270, not 40 is removed from duration but 270
                // Xinef: so the aura can be removed in different updates for all units
                else if ((m_timer < 0 || m_timer > 300) && !UpdateChanneledTargetList())
                {
                    LOG_DEBUG("spells.aura", "Channeled spell {} is removed due to lack of targets", m_spellInfo->Id);
                    SendChannelUpdate(0);
                    finish();

                    //npcbot: signal channel finish to botmgr
                    if (m_caster->IsNPCBot())
                        BotMgr::OnBotChannelFinish(m_caster->ToUnit(), this);
                    //end npcbot
                }
                break;
            }
        default:
            break;
    }
}

void Spell::finish(bool ok)
{
    if (!m_caster)
        return;

    if (m_spellState == SPELL_STATE_FINISHED)
        return;
    m_spellState = SPELL_STATE_FINISHED;

    if (m_spellInfo->IsChanneled())
        m_caster->UpdateInterruptMask();

    if (m_caster->HasUnitState(UNIT_STATE_CASTING) && !m_caster->IsNonMeleeSpellCast(false, false, true))
        m_caster->ClearUnitState(UNIT_STATE_CASTING);

    // Unsummon summon as possessed creatures on spell cancel
    if (m_spellInfo->IsChanneled() && m_caster->IsPlayer())
    {
        if (Unit* charm = m_caster->GetCharm())
            if (charm->IsCreature()
                    && charm->ToCreature()->HasUnitTypeMask(UNIT_MASK_PUPPET)
                    && charm->GetUInt32Value(UNIT_CREATED_BY_SPELL) == m_spellInfo->Id)
                ((Puppet*)charm)->UnSummon();
    }

    if (Creature* creatureCaster = m_caster->ToCreature())
        creatureCaster->ReleaseFocus(this);

    //npcbot
    if (!ok && m_caster->IsNPCBotOrPet())
        BotMgr::OnBotSpellGo(m_caster, this, false);
    //end npcbot

    if (ok)
    {
        if (m_caster->IsPlayer() && m_spellInfo->IsChanneled() && m_spellInfo->IsCooldownStartedOnEvent())
            m_caster->ToPlayer()->RemoveSpellCooldown(m_spellInfo->Id, true);
    }
    else
    {
        if (m_caster->IsPlayer())
        {
            // Xinef: Restore spell mods in case of fail cast
            m_caster->ToPlayer()->RestoreSpellMods(this);

            // Xinef: Reset cooldown event in case of fail cast
            if (m_spellInfo->IsCooldownStartedOnEvent())
                m_caster->ToPlayer()->SendCooldownEvent(m_spellInfo, 0, 0, false);
        }
        return;
    }

    // pussywizard:
    if (m_spellInfo->HasAttribute(SPELL_ATTR0_CU_ENCOUNTER_REWARD) && m_caster->FindMap())
        m_caster->FindMap()->UpdateEncounterState(ENCOUNTER_CREDIT_CAST_SPELL, m_spellInfo->Id, m_caster);

    if (m_caster->IsCreature() && m_caster->ToCreature()->IsSummon())
    {
        // Unsummon statue
        uint32 spell = m_caster->GetUInt32Value(UNIT_CREATED_BY_SPELL);
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell);
        if (spellInfo && spellInfo->SpellIconID == 2056)
        {
            LOG_DEBUG("spells.aura", "Statue {} is unsummoned in spell {} finish", m_caster->GetGUID().ToString(), m_spellInfo->Id);
            m_caster->setDeathState(DeathState::JustDied);
            return;
        }
    }

    // potions disabled by client, send event "not in combat" if need
    if (m_caster->IsPlayer() && !m_triggeredByAuraSpell)
        m_caster->ToPlayer()->UpdatePotionCooldown(this);

    // Take mods after trigger spell (needed for 14177 to affect 48664)
    // mods are taken only on succesfull cast and independantly from targets of the spell
    if (Player* player = m_caster->GetSpellModOwner())
        player->RemoveSpellMods(this);

    // xinef: clear reactive auras states after spell cast
    if (m_spellInfo->CasterAuraState == AURA_STATE_DEFENSE || m_spellInfo->CasterAuraState == AURA_STATE_HUNTER_PARRY)
        m_caster->ModifyAuraState(AuraStateType(m_spellInfo->CasterAuraState), false);

    // Stop Attack for some spells
    if (m_spellInfo->HasAttribute(SPELL_ATTR0_CANCELS_AUTO_ATTACK_COMBAT))
    //npcbot: disable for npcbots
    if (!m_caster->IsNPCBot())
    //end npcbot
        m_caster->AttackStop();
}

void Spell::WriteCastResultInfo(WorldPacket& data, Player* caster, SpellInfo const* spellInfo, uint8 castCount, SpellCastResult result, SpellCustomErrors customError)
{
    data << uint8(castCount);                               // single cast or multi 2.3 (0/1)
    data << uint32(spellInfo->Id);
    data << uint8(result);                                  // problem
    switch (result)
    {
        case SPELL_FAILED_REQUIRES_SPELL_FOCUS:
            data << uint32(spellInfo->RequiresSpellFocus);  // SpellFocusObject.dbc id
            break;
        case SPELL_FAILED_REQUIRES_AREA:                    // AreaTable.dbc id
            // hardcode areas limitation case
            switch (spellInfo->Id)
            {
                case 41617:                                 // Cenarion Mana Salve
                case 41619:                                 // Cenarion Healing Salve
                    data << uint32(3905);
                    break;
                case 41618:                                 // Bottled Nethergon Energy
                case 41620:                                 // Bottled Nethergon Vapor
                    data << uint32(3842);
                    break;
                case 45373:                                 // Bloodberry Elixir
                    data << uint32(4075);
                    break;
                default:                                    // default case (don't must be)
                    data << uint32(0);
                    break;
            }
            break;
        case SPELL_FAILED_TOTEMS:
            if (spellInfo->Totem[0])
                data << uint32(spellInfo->Totem[0]);
            if (spellInfo->Totem[1])
                data << uint32(spellInfo->Totem[1]);
            break;
        case SPELL_FAILED_TOTEM_CATEGORY:
            if (spellInfo->TotemCategory[0])
                data << uint32(spellInfo->TotemCategory[0]);
            if (spellInfo->TotemCategory[1])
                data << uint32(spellInfo->TotemCategory[1]);
            break;
        case SPELL_FAILED_EQUIPPED_ITEM_CLASS:
        case SPELL_FAILED_EQUIPPED_ITEM_CLASS_MAINHAND:
        case SPELL_FAILED_EQUIPPED_ITEM_CLASS_OFFHAND:
            data << uint32(spellInfo->EquippedItemClass);
            data << uint32(spellInfo->EquippedItemSubClassMask);
            break;
        case SPELL_FAILED_TOO_MANY_OF_ITEM:
            {
                uint32 item = 0;
                for (int8 eff = 0; eff < MAX_SPELL_EFFECTS; eff++)
                    if (spellInfo->Effects[eff].ItemType)
                        item = spellInfo->Effects[eff].ItemType;
                ItemTemplate const* proto = sObjectMgr->GetItemTemplate(item);
                if (proto && proto->ItemLimitCategory)
                    data << uint32(proto->ItemLimitCategory);
                break;
            }
        case SPELL_FAILED_CUSTOM_ERROR:
            data << uint32(customError);
            break;
        case SPELL_FAILED_REAGENTS:
            {
                uint32 missingItem = 0;
                for (uint32 i = 0; i < MAX_SPELL_REAGENTS; i++)
                {
                    if (spellInfo->Reagent[i] <= 0)
                        continue;

                    uint32 itemid    = spellInfo->Reagent[i];
                    uint32 itemcount = spellInfo->ReagentCount[i];

                    if (!caster->HasItemCount(itemid, itemcount))
                    {
                        missingItem = itemid;
                        break;
                    }
                }

                data << uint32(missingItem);  // first missing item
                break;
            }
        case SPELL_FAILED_PREVENTED_BY_MECHANIC:
            data << uint32(spellInfo->Mechanic);
            break;
        case SPELL_FAILED_NEED_EXOTIC_AMMO:
            data << uint32(spellInfo->EquippedItemSubClassMask);
            break;
        case SPELL_FAILED_NEED_MORE_ITEMS:
            data << uint32(0); // Item entry
            data << uint32(0); // Count
            break;
        case SPELL_FAILED_MIN_SKILL:
            data << uint32(0); // SkillLine.dbc Id
            data << uint32(0); // Amount
            break;
        case SPELL_FAILED_FISHING_TOO_LOW:
            data << uint32(0); // Skill level
            break;
        default:
            break;
    }
}

void Spell::SendCastResult(Player* caster, SpellInfo const* spellInfo, uint8 castCount, SpellCastResult result, SpellCustomErrors customError /*= SPELL_CUSTOM_ERROR_NONE*/)
{
    if (result == SPELL_CAST_OK)
        return;

    WorldPacket data(SMSG_CAST_FAILED, 1 + 4 + 1);
    WriteCastResultInfo(data, caster, spellInfo, castCount, result, customError);

    caster->GetSession()->SendPacket(&data);
}

void Spell::SendCastResult(SpellCastResult result)
{
    if (result == SPELL_CAST_OK)
        return;

    if (!m_caster->IsPlayer() || m_caster->IsCharmed())
        return;

    if (m_caster->ToPlayer()->GetSession()->PlayerLoading())  // don't send cast results at loading time
        return;

    // Xinef: override every possible result, except for gm fail result... breaks many things and goes unnoticed because of this and makes me rage when i find this out
    if (HasTriggeredCastFlag(TRIGGERED_DONT_REPORT_CAST_ERROR) && result != SPELL_FAILED_BM_OR_INVISGOD)
        result = SPELL_FAILED_DONT_REPORT;

    SendCastResult(m_caster->ToPlayer(), m_spellInfo, m_cast_count, result, m_customError);
}

void Spell::SendPetCastResult(SpellCastResult result)
{
    if (result == SPELL_CAST_OK)
        return;

    Unit* owner = m_caster->GetCharmerOrOwner();
    if (!owner)
        return;

    Player* player = owner->ToPlayer();
    if (!player)
        return;

    WorldPacket data(SMSG_PET_CAST_FAILED, 1 + 4 + 1);
    WriteCastResultInfo(data, player, m_spellInfo, m_cast_count, result, m_customError);

    player->GetSession()->SendPacket(&data);
}

void Spell::SendSpellStart()
{
    if (!IsNeedSendToClient(false))
        return;

    //LOG_DEBUG("spells.aura", "Sending SMSG_SPELL_START id={}", m_spellInfo->Id);

    uint32 castFlags = CAST_FLAG_HAS_TRAJECTORY;

    if (((IsTriggered() && !m_spellInfo->IsAutoRepeatRangedSpell()) || m_triggeredByAuraSpell) && !m_cast_count && !(m_spellInfo->IsChanneled() || (m_spellInfo->CastTimeEntry && m_spellInfo->CastTimeEntry->CastTime > 0)))
        castFlags |= CAST_FLAG_PENDING;

    if (m_spellInfo->HasAttribute(SPELL_ATTR0_USES_RANGED_SLOT) || m_spellInfo->HasAttribute(SPELL_ATTR0_CU_NEEDS_AMMO_DATA))
        castFlags |= CAST_FLAG_PROJECTILE;

    if (m_caster->IsPlayer() || m_caster->IsPet())
    {
        switch (m_spellInfo->PowerType)
        {
            case POWER_HEALTH:
                break;
            case POWER_RUNE:
                castFlags |= CAST_FLAG_POWER_LEFT_SELF;
                break;
            default:
                if (m_powerCost != 0)
                {
                    castFlags |= CAST_FLAG_POWER_LEFT_SELF;
                }
                break;
        }
    }

    if (m_spellInfo->RuneCostID && m_spellInfo->PowerType == POWER_RUNE)
        castFlags |= CAST_FLAG_NO_GCD; // not needed, but Blizzard sends it

    PackedGuid realCasterGUID = m_caster->GetPackGUID();
    if (TempSummon const* tempSummon = m_caster->ToTempSummon())
    {
        if (tempSummon->GetEntry() == WORLD_TRIGGER)
        {
            if (GameObject* casterGameobject = tempSummon->GetSummonerGameObject())
            {
                realCasterGUID = casterGameobject->GetPackGUID();
            }
        }
    }

    WorldPacket data(SMSG_SPELL_START, (8 + 8 + 4 + 4 + 2));
    if (m_CastItem)
        data << m_CastItem->GetPackGUID();
    else
        data << realCasterGUID;

    data << realCasterGUID;
    data << uint8(m_cast_count);                            // pending spell cast?
    data << uint32(m_spellInfo->Id);                        // spellId
    data << uint32(castFlags);                              // cast flags
    data << int32(m_timer);                                 // delay?

    m_targets.Write(data);

    if (castFlags & CAST_FLAG_POWER_LEFT_SELF)
        data << uint32(m_caster->GetPower((Powers)m_spellInfo->PowerType));

    if (castFlags & CAST_FLAG_PROJECTILE)
        WriteAmmoToPacket(&data);

    if (castFlags & CAST_FLAG_UNKNOWN_23)
    {
        data << uint32(0);
        data << uint32(0);
    }

    m_caster->SendMessageToSet(&data, true);

    if (!m_spellInfo->IsChanneled() && m_caster->IsPlayer() && m_caster->ToPlayer()->NeedSendSpectatorData())
        ArenaSpectator::SendCommand_Spell(m_caster->FindMap(), m_caster->GetGUID(), "SPE", m_spellInfo->Id, m_timer);
}

void Spell::SendSpellGo()
{
    // not send invisible spell casting
    if (!IsNeedSendToClient(true))
        return;

    //LOG_DEBUG("spells.aura", "Sending SMSG_SPELL_GO id={}", m_spellInfo->Id);

    uint32 castFlags = CAST_FLAG_UNKNOWN_9;

    // triggered spells with spell visual != 0
    if (((IsTriggered() && !m_spellInfo->IsAutoRepeatRangedSpell()) || m_triggeredByAuraSpell) && !m_cast_count && !(m_spellInfo->IsChanneled() || (m_spellInfo->CastTimeEntry && m_spellInfo->CastTimeEntry->CastTime > 0)))
        castFlags |= CAST_FLAG_PENDING;

    if (m_spellInfo->HasAttribute(SPELL_ATTR0_USES_RANGED_SLOT) || m_spellInfo->HasAttribute(SPELL_ATTR0_CU_NEEDS_AMMO_DATA))
        castFlags |= CAST_FLAG_PROJECTILE;                        // arrows/bullets visual

    // should only be sent to self, but the current messaging doesn't make that possible
    if (m_caster->IsPlayer() || m_caster->IsPet())
    {
        switch (m_spellInfo->PowerType)
        {
            case POWER_HEALTH:
                break;
            case POWER_RUNE:
                castFlags |= CAST_FLAG_POWER_LEFT_SELF;
                break;
            default:
                if (m_powerCost != 0)
                {
                    castFlags |= CAST_FLAG_POWER_LEFT_SELF;
                }
                break;
        }
    }

    if ((m_caster->IsPlayer())
            && (m_caster->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
            && m_spellInfo->RuneCostID
            && m_spellInfo->PowerType == POWER_RUNE)
    {
        castFlags |= CAST_FLAG_NO_GCD;                       // not needed, but Blizzard sends it
        castFlags |= CAST_FLAG_RUNE_LIST;                    // rune cooldowns list
    }

    if (m_spellInfo->HasEffect(SPELL_EFFECT_ACTIVATE_RUNE))
        castFlags |= CAST_FLAG_RUNE_LIST;                    // rune cooldowns list

    if (m_targets.HasTraj())
        castFlags |= CAST_FLAG_ADJUST_MISSILE;

    if (!m_spellInfo->StartRecoveryTime)
        castFlags |= CAST_FLAG_NO_GCD;

    PackedGuid realCasterGUID = m_caster->GetPackGUID();
    if (TempSummon const* tempSummon = m_caster->ToTempSummon())
    {
        if (tempSummon->GetEntry() == WORLD_TRIGGER)
        {
            if (GameObject* casterGameobject = tempSummon->GetSummonerGameObject())
            {
                realCasterGUID = casterGameobject->GetPackGUID();
            }
        }
    }

    WorldPacket data(SMSG_SPELL_GO, 150);                    // guess size

    if (m_CastItem)
        data << m_CastItem->GetPackGUID();
    else
        data << realCasterGUID;

    data << realCasterGUID;
    data << uint8(m_cast_count);                            // pending spell cast?
    data << uint32(m_spellInfo->Id);                        // spellId
    data << uint32(castFlags);                              // cast flags
    data << uint32(GameTime::GetGameTimeMS().count());                 // timestamp

    WriteSpellGoTargets(&data);

    m_targets.Write(data);

    if (castFlags & CAST_FLAG_POWER_LEFT_SELF)
        data << uint32(m_caster->GetPower((Powers)m_spellInfo->PowerType));

    if (castFlags & CAST_FLAG_RUNE_LIST)                   // rune cooldowns list
    {
        //TODO: There is a crash caused by a spell with CAST_FLAG_RUNE_LIST casted by a creature
        //The creature is the mover of a player, so HandleCastSpellOpcode uses it as the caster
        if (Player* player = m_caster->ToPlayer())
        {
            uint8 runeMaskInitial = m_runesState;
            uint8 runeMaskAfterCast = player->GetRunesState();
            data << uint8(runeMaskInitial);                     // runes state before
            data << uint8(runeMaskAfterCast);                   // runes state after
            for (uint8 i = 0; i < MAX_RUNES; ++i)
            {
                uint8 mask = (1 << i);
                if (mask & runeMaskInitial && !(mask & runeMaskAfterCast))  // usable before andon cooldown now...
                {
                    // float casts ensure the division is performed on floats as we need float result
                    float baseCd = float(player->GetRuneBaseCooldown(i, true));
                    data << uint8((baseCd - float(player->GetRuneCooldown(i))) / baseCd * 255); // rune cooldown passed
                }
            }
        }
    }
    if (castFlags & CAST_FLAG_ADJUST_MISSILE)
    {
        data << m_targets.GetElevation();
        data << uint32(m_delayTrajectory ? m_delayTrajectory : m_delayMoment);
    }

    if (castFlags & CAST_FLAG_PROJECTILE)
        WriteAmmoToPacket(&data);

    if (castFlags & CAST_FLAG_VISUAL_CHAIN)
    {
        data << uint32(0);
        data << uint32(0);
    }

    if (m_targets.GetTargetMask() & TARGET_FLAG_DEST_LOCATION)
    {
        data << uint8(0);
    }

    m_caster->SendMessageToSet(&data, true);
}

void Spell::WriteAmmoToPacket(WorldPacket* data)
{
    uint32 ammoInventoryType = 0;
    uint32 ammoDisplayID = 0;

    if (m_caster->IsPlayer())
    {
        Item* pItem = m_caster->ToPlayer()->GetWeaponForAttack(RANGED_ATTACK);
        if (pItem)
        {
            ammoInventoryType = pItem->GetTemplate()->InventoryType;
            if (ammoInventoryType == INVTYPE_THROWN)
                ammoDisplayID = pItem->GetTemplate()->DisplayInfoID;
            else
            {
                uint32 ammoID = m_caster->ToPlayer()->GetUInt32Value(PLAYER_AMMO_ID);
                if (ammoID)
                {
                    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(ammoID);
                    if (pProto)
                    {
                        ammoDisplayID = pProto->DisplayInfoID;
                        ammoInventoryType = pProto->InventoryType;
                    }
                }
                else if (m_caster->HasAura(46699))      // Requires No Ammo
                {
                    ammoDisplayID = 5996;                   // normal arrow
                    ammoInventoryType = INVTYPE_AMMO;
                }
            }
        }
    }
    else
    {
        uint32 nonRangedAmmoDisplayID = 0;
        uint32 nonRangedAmmoInventoryType = 0;
        for (uint8 i = 0; i < 3; ++i)
        {
            if (uint32 item_id = m_caster->GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + i))
            {
                if (ItemEntry const* itemEntry = sItemStore.LookupEntry(item_id))
                {
                    if (itemEntry->ClassID == ITEM_CLASS_WEAPON)
                    {
                        switch (itemEntry->SubclassID)
                        {
                            case ITEM_SUBCLASS_WEAPON_THROWN:
                                ammoDisplayID = itemEntry->DisplayInfoID;
                                ammoInventoryType = itemEntry->InventoryType;
                                break;
                            case ITEM_SUBCLASS_WEAPON_BOW:
                            case ITEM_SUBCLASS_WEAPON_CROSSBOW:
                                ammoDisplayID = 5996;       // is this need fixing?
                                ammoInventoryType = INVTYPE_AMMO;
                                break;
                            case ITEM_SUBCLASS_WEAPON_GUN:
                                ammoDisplayID = 5998;       // is this need fixing?
                                ammoInventoryType = INVTYPE_AMMO;
                                break;
                            default:
                                nonRangedAmmoDisplayID = itemEntry->DisplayInfoID;
                                nonRangedAmmoInventoryType = itemEntry->InventoryType;
                                break;
                        }

                        if (ammoDisplayID)
                            break;
                    }
                }
            }
        }

        if (!ammoDisplayID && !ammoInventoryType)
        {
            ammoDisplayID = nonRangedAmmoDisplayID;
            ammoInventoryType = nonRangedAmmoInventoryType;
        }
    }

    *data << uint32(ammoDisplayID);
    *data << uint32(ammoInventoryType);
}

/// Writes miss and hit targets for a SMSG_SPELL_GO packet
void Spell::WriteSpellGoTargets(WorldPacket* data)
{
    // This function also fill data for channeled spells:
    // m_needAliveTargetMask req for stop channelig if one target die
    for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
    {
        if ((*ihit).effectMask == 0)                  // No effect apply - all immuned add state
            // possibly SPELL_MISS_IMMUNE2 for this??
            ihit->missCondition = SPELL_MISS_IMMUNE2;
    }

    // Hit and miss target counts are both uint8, that limits us to 255 targets for each
    // sending more than 255 targets crashes the client (since count sent would be wrong)
    // Spells like 40647 (with a huge radius) can easily reach this limit (spell might need
    // target conditions but we still need to limit the number of targets sent and keeping
    // correct count for both hit and miss).

    uint32 hit = 0;
    std::size_t hitPos = data->wpos();
    *data << (uint8)0; // placeholder
    for (std::list<TargetInfo>::const_iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end() && hit < 255; ++ihit)
    {
        if ((*ihit).missCondition == SPELL_MISS_NONE)       // Add only hits
        {
            *data << ihit->targetGUID;
            // Xinef: No channeled spell checked, no anything
            //m_channelTargetEffectMask |=ihit->effectMask;
            ++hit;
        }
    }

    for (std::list<GOTargetInfo>::const_iterator ighit = m_UniqueGOTargetInfo.begin(); ighit != m_UniqueGOTargetInfo.end() && hit < 255; ++ighit)
    {
        *data << ighit->targetGUID;                 // Always hits
        ++hit;
    }

    uint32 miss = 0;
    std::size_t missPos = data->wpos();
    *data << (uint8)0; // placeholder
    for (std::list<TargetInfo>::const_iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end() && miss < 255; ++ihit)
    {
        if (ihit->missCondition != SPELL_MISS_NONE)        // Add only miss
        {
            *data << ihit->targetGUID;
            *data << uint8(ihit->missCondition);
            if (ihit->missCondition == SPELL_MISS_REFLECT)
                *data << uint8(ihit->reflectResult);
            ++miss;
        }
    }
    // Reset m_needAliveTargetMask for non channeled spell
    // Xinef: Why do we reset something that is not set??????
    //if (!m_spellInfo->IsChanneled())
    //    m_channelTargetEffectMask = 0;

    data->put<uint8>(hitPos, (uint8)hit);
    data->put<uint8>(missPos, (uint8)miss);
}

void Spell::SendLogExecute()
{
    WorldPacket data(SMSG_SPELLLOGEXECUTE, (8 + 4 + 4 + 4 + 4 + 8));

    data << m_caster->GetPackGUID();

    data << uint32(m_spellInfo->Id);

    uint8 effCount = 0;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (m_effectExecuteData[i])
            ++effCount;
    }

    if (!effCount)
        return;

    data << uint32(effCount);
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (!m_effectExecuteData[i])
            continue;

        data << uint32(m_spellInfo->Effects[i].Effect);             // spell effect

        data.append(*m_effectExecuteData[i]);

        delete m_effectExecuteData[i];
        m_effectExecuteData[i] = nullptr;
    }
    m_caster->SendMessageToSet(&data, true);
}

void Spell::ExecuteLogEffectTakeTargetPower(uint8 effIndex, Unit* target, uint32 PowerType, uint32 powerTaken, float gainMultiplier)
{
    InitEffectExecuteData(effIndex);
    *m_effectExecuteData[effIndex] << target->GetPackGUID();
    *m_effectExecuteData[effIndex] << uint32(powerTaken);
    *m_effectExecuteData[effIndex] << uint32(PowerType);
    *m_effectExecuteData[effIndex] << float(gainMultiplier);
}

void Spell::ExecuteLogEffectExtraAttacks(uint8 effIndex, Unit* victim, uint32 attCount)
{
    InitEffectExecuteData(effIndex);
    *m_effectExecuteData[effIndex] << victim->GetPackGUID();
    *m_effectExecuteData[effIndex] << uint32(attCount);
}

void Spell::ExecuteLogEffectInterruptCast(uint8 effIndex, Unit* victim, uint32 spellId)
{
    InitEffectExecuteData(effIndex);
    *m_effectExecuteData[effIndex] << victim->GetPackGUID();
    *m_effectExecuteData[effIndex] << uint32(spellId);
}

void Spell::ExecuteLogEffectDurabilityDamage(uint8 effIndex, Unit* victim, int32 itemId, int32 slot)
{
    InitEffectExecuteData(effIndex);
    *m_effectExecuteData[effIndex] << victim->GetPackGUID();
    *m_effectExecuteData[effIndex] << int32(itemId);
    *m_effectExecuteData[effIndex] << int32(slot);
}

void Spell::ExecuteLogEffectOpenLock(uint8 effIndex, Object* obj)
{
    InitEffectExecuteData(effIndex);
    *m_effectExecuteData[effIndex] << obj->GetPackGUID();
}

void Spell::ExecuteLogEffectCreateItem(uint8 effIndex, uint32 entry)
{
    InitEffectExecuteData(effIndex);
    *m_effectExecuteData[effIndex] << uint32(entry);
}

void Spell::ExecuteLogEffectDestroyItem(uint8 effIndex, uint32 entry)
{
    InitEffectExecuteData(effIndex);
    *m_effectExecuteData[effIndex] << uint32(entry);
}

void Spell::ExecuteLogEffectSummonObject(uint8 effIndex, WorldObject* obj)
{
    InitEffectExecuteData(effIndex);
    *m_effectExecuteData[effIndex] << obj->GetPackGUID();
}

void Spell::ExecuteLogEffectUnsummonObject(uint8 effIndex, WorldObject* obj)
{
    InitEffectExecuteData(effIndex);
    *m_effectExecuteData[effIndex] << obj->GetPackGUID();
}

void Spell::ExecuteLogEffectResurrect(uint8 effIndex, Unit* target)
{
    InitEffectExecuteData(effIndex);
    *m_effectExecuteData[effIndex] << target->GetPackGUID();
}

void Spell::SendInterrupted(uint8 result)
{
    WorldPacket data(SMSG_SPELL_FAILURE, (8 + 1 + 4 + 1));
    data << m_caster->GetPackGUID();
    data << uint8(m_cast_count);
    data << uint32(m_spellInfo->Id);
    data << uint8(result);
    m_caster->SendMessageToSet(&data, true);

    data.Initialize(SMSG_SPELL_FAILED_OTHER, (8 + 1 + 4 + 1));
    data << m_caster->GetPackGUID();
    data << uint8(m_cast_count);
    data << uint32(m_spellInfo->Id);
    data << uint8(result);
    m_caster->SendMessageToSet(&data, true);
}

void Spell::SendChannelUpdate(uint32 time)
{
    if (time == 0)
    {
        m_caster->SetGuidValue(UNIT_FIELD_CHANNEL_OBJECT, ObjectGuid::Empty);
        m_caster->SetUInt32Value(UNIT_CHANNEL_SPELL, 0);
    }

    WorldPacket data(MSG_CHANNEL_UPDATE, 8 + 4);
    data << m_caster->GetPackGUID();
    data << uint32(time);

    m_caster->SendMessageToSet(&data, true);
}

void Spell::SendChannelStart(uint32 duration)
{
    ObjectGuid channelTarget = m_targets.GetObjectTargetGUID();
    if (!channelTarget && !m_spellInfo->NeedsExplicitUnitTarget())
        if (m_UniqueTargetInfo.size() + m_UniqueGOTargetInfo.size() == 1)   // this is for TARGET_SELECT_CATEGORY_NEARBY
            channelTarget = !m_UniqueTargetInfo.empty() ? m_UniqueTargetInfo.front().targetGUID : m_UniqueGOTargetInfo.front().targetGUID;

    WorldPacket data(MSG_CHANNEL_START, (8 + 4 + 4));
    data << m_caster->GetPackGUID();
    data << uint32(m_spellInfo->Id);
    data << uint32(duration);

    m_caster->SendMessageToSet(&data, true);

    if (m_caster->IsPlayer() && m_caster->ToPlayer()->NeedSendSpectatorData())
        ArenaSpectator::SendCommand_Spell(m_caster->FindMap(), m_caster->GetGUID(), "SPE", m_spellInfo->Id, -((int32)duration));

    m_timer = duration;
    if (channelTarget)
        m_caster->SetGuidValue(UNIT_FIELD_CHANNEL_OBJECT, channelTarget);

    m_caster->SetUInt32Value(UNIT_CHANNEL_SPELL, m_spellInfo->Id);
}

void Spell::SendResurrectRequest(Player* target)
{
    // get resurrector name for creature resurrections, otherwise packet will be not accepted
    // for player resurrections the name is looked up by guid
    std::string const sentName(m_caster->IsPlayer()
                               ? ""
                               : m_caster->GetNameForLocaleIdx(target->GetSession()->GetSessionDbLocaleIndex()));

    WorldPacket data(SMSG_RESURRECT_REQUEST, (8 + 4 + sentName.size() + 1 + 1 + 1 + 4));
    data << m_caster->GetGUID();
    data << uint32(sentName.size() + 1);

    data << sentName;
    data << uint8(0); // null terminator

    data << uint8(m_caster->IsPlayer() ? 0 : 1); // "you'll be afflicted with resurrection sickness"
    // override delay sent with SMSG_CORPSE_RECLAIM_DELAY, set instant resurrection for spells with this attribute
    if (m_spellInfo->HasAttribute(SPELL_ATTR3_NO_RES_TIMER))
        data << uint32(0);
    target->GetSession()->SendPacket(&data);
}

void Spell::TakeCastItem()
{
    if (!m_CastItem || !m_caster->IsPlayer())
        return;

    // not remove cast item at triggered spell (equipping, weapon damage, etc)
    if (HasTriggeredCastFlag(TRIGGERED_IGNORE_CAST_ITEM))
        return;

    ItemTemplate const* proto = m_CastItem->GetTemplate();

    if (!proto)
    {
        // This code is to avoid a crash
        // I'm not sure, if this is really an error, but I guess every item needs a prototype
        LOG_ERROR("spells", "Cast item has no item prototype {}", m_CastItem->GetGUID().ToString());
        return;
    }

    bool expendable = false;
    bool withoutCharges = false;

    for (int i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
    {
        if (proto->Spells[i].SpellId)
        {
            // item has limited charges
            if (proto->Spells[i].SpellCharges)
            {
                if (proto->Spells[i].SpellCharges < 0)
                    expendable = true;

                int32 charges = m_CastItem->GetSpellCharges(i);

                // item has charges left
                if (charges)
                {
                    (charges > 0) ? --charges : ++charges;  // std::abs(charges) less at 1 after use
                    if (proto->Stackable == 1)
                        m_CastItem->SetSpellCharges(i, charges);
                    m_CastItem->SetState(ITEM_CHANGED, m_caster->ToPlayer());
                }

                // all charges used
                withoutCharges = (charges == 0);
            }
        }
    }

    if (expendable && withoutCharges)
    {
        uint32 count = 1;
        m_caster->ToPlayer()->DestroyItemCount(m_CastItem, count, true);

        // prevent crash at access to deleted m_targets.GetItemTarget
        if (m_CastItem == m_targets.GetItemTarget())
            m_targets.SetItemTarget(nullptr);

        m_CastItem = nullptr;
        m_castItemGUID.Clear();
    }
}

void Spell::TakePower()
{
    if (m_CastItem || m_triggeredByAuraSpell)
        return;

    //Don't take power if the spell is cast while .cheat power is enabled.
    if (m_caster->IsPlayer())
        if (m_caster->ToPlayer()->GetCommandStatus(CHEAT_POWER))
            return;

    Powers PowerType = Powers(m_spellInfo->PowerType);
    bool hit = true;
    if (m_caster->IsPlayer())
    {
        if (PowerType == POWER_RAGE || PowerType == POWER_ENERGY || PowerType == POWER_RUNE || PowerType == POWER_RUNIC_POWER)
            if (ObjectGuid targetGUID = m_targets.GetUnitTargetGUID())
                for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
                    if (ihit->targetGUID == targetGUID)
                    {
                        if (ihit->missCondition != SPELL_MISS_NONE && ihit->missCondition != SPELL_MISS_BLOCK && ihit->missCondition != SPELL_MISS_ABSORB && ihit->missCondition != SPELL_MISS_REFLECT)
                        {
                            hit = false;
                            //lower spell cost on fail (by talent aura)
                            if (Player* modOwner = m_caster->ToPlayer()->GetSpellModOwner())
                                modOwner->ApplySpellMod(m_spellInfo->Id, SPELLMOD_SPELL_COST_REFUND_ON_FAIL, m_powerCost, this);
                        }
                        break;
                    }
    }

    //npcbot: handle SPELLMOD_SPELL_COST_REFUND_ON_FAIL (druid Primal Precision)
    if (m_caster->IsNPCBot() && m_caster->ToCreature()->GetBotClass() == CLASS_DRUID)
    {
        if (PowerType == POWER_ENERGY/* || PowerType == POWER_RAGE || PowerType == POWER_RUNE*/)
        {
            if (ObjectGuid targetGUID = m_targets.GetUnitTargetGUID())
            {
                //auto ihit = std::find_if(std::being());
                for (std::list<TargetInfo>::iterator ihit= m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
                {
                    if (ihit->targetGUID == targetGUID && ihit->missCondition != SPELL_MISS_NONE)
                    {
                        hit = false;
                        //Primal Precision: 80% refund
                        if ((m_spellInfo->SpellFamilyFlags[0] & 0x800000) || (m_spellInfo->SpellFamilyFlags[1] & 0x10000080))
                            m_powerCost = m_powerCost / 5;
                    }
                    break;
                }
            }
        }
    }
    //end npcbot

    if (PowerType == POWER_RUNE)
    {
        TakeRunePower(hit);

        //npcbot: spend runes (pass hit result)
        if (m_caster->IsNPCBot() && m_caster->ToCreature()->GetBotClass() == CLASS_DEATH_KNIGHT)
            m_caster->ToCreature()->SpendBotRunes(m_spellInfo, hit);
        //end npcbot

        return;
    }

    if (!m_powerCost)
        return;

    // health as power used
    if (PowerType == POWER_HEALTH)
    {
        m_caster->ModifyHealth(-(int32)m_powerCost);
        return;
    }

    if (PowerType >= MAX_POWERS)
    {
        LOG_ERROR("spells", "Spell::TakePower: Unknown power type '{}'", PowerType);
        return;
    }

    if (hit)
        m_caster->ModifyPower(PowerType, -m_powerCost);
    else
        m_caster->ModifyPower(PowerType, -irand(0, m_powerCost / 4));

    // Set the five second timer
    if (PowerType == POWER_MANA && m_powerCost > 0)
    {
        m_caster->SetLastManaUse(GameTime::GetGameTimeMS().count());
    }
}

void Spell::TakeAmmo()
{
    if (m_attackType == RANGED_ATTACK && m_caster->IsPlayer())
    {
        Item* pItem = m_caster->ToPlayer()->GetWeaponForAttack(RANGED_ATTACK);

        // wands don't have ammo
        if (!pItem  || pItem->IsBroken() || pItem->GetTemplate()->SubClass == ITEM_SUBCLASS_WEAPON_WAND)
            return;

        if (pItem->GetTemplate()->InventoryType == INVTYPE_THROWN)
        {
            if (pItem->GetMaxStackCount() == 1)
            {
                // decrease durability for non-stackable throw weapon
                m_caster->ToPlayer()->DurabilityPointLossForEquipSlot(EQUIPMENT_SLOT_RANGED);
            }
            else
            {
                // decrease items amount for stackable throw weapon
                uint32 count = 1;
                m_caster->ToPlayer()->DestroyItemCount(pItem, count, true);
            }
        }
        else if (uint32 ammo = m_caster->ToPlayer()->GetUInt32Value(PLAYER_AMMO_ID))
            m_caster->ToPlayer()->DestroyItemCount(ammo, 1, true);
    }
}

SpellCastResult Spell::CheckRuneCost(uint32 RuneCostID)
{
    if (m_spellInfo->PowerType != POWER_RUNE || !RuneCostID)
        return SPELL_CAST_OK;

    if (!m_caster->IsPlayer())
        return SPELL_CAST_OK;

    Player* player = m_caster->ToPlayer();
    //If we are in .cheat power mode we dont need to check the cost as we are expected to be able to use it anyways (infinite power)
    if (player->GetCommandStatus(CHEAT_POWER))
    {
        return SPELL_CAST_OK;
    }

    if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
        return SPELL_CAST_OK;

    SpellRuneCostEntry const* src = sSpellRuneCostStore.LookupEntry(RuneCostID);

    if (!src)
        return SPELL_CAST_OK;

    if (src->NoRuneCost())
        return SPELL_CAST_OK;

    int32 runeCost[NUM_RUNE_TYPES];                         // blood, frost, unholy, death

    for (uint32 i = 0; i < RUNE_DEATH; ++i)
    {
        runeCost[i] = src->RuneCost[i];
        if (Player* modOwner = m_caster->GetSpellModOwner())
            modOwner->ApplySpellMod(m_spellInfo->Id, SPELLMOD_COST, runeCost[i], this);
    }

    runeCost[RUNE_DEATH] = MAX_RUNES;                       // calculated later

    for (uint32 i = 0; i < MAX_RUNES; ++i)
    {
        RuneType rune = player->GetCurrentRune(i);
        if ((player->GetRuneCooldown(i) == 0) && (runeCost[rune] > 0))
            runeCost[rune]--;
    }

    for (uint32 i = 0; i < RUNE_DEATH; ++i)
        if (runeCost[i] > 0)
            runeCost[RUNE_DEATH] += runeCost[i];

    if (runeCost[RUNE_DEATH] > MAX_RUNES)
        return SPELL_FAILED_NO_POWER;                       // not sure if result code is correct

    return SPELL_CAST_OK;
}

void Spell::TakeRunePower(bool didHit)
{
    if (!m_caster->IsPlayer() || !m_caster->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
        return;

    SpellRuneCostEntry const* runeCostData = sSpellRuneCostStore.LookupEntry(m_spellInfo->RuneCostID);
    if (!runeCostData || (runeCostData->NoRuneCost() && runeCostData->NoRunicPowerGain()))
        return;

    Player* player = m_caster->ToPlayer();
    m_runesState = player->GetRunesState();                 // store previous state

    int32 runeCost[NUM_RUNE_TYPES];                         // blood, frost, unholy, death

    for (uint32 i = 0; i < RUNE_DEATH; ++i)
    {
        runeCost[i] = runeCostData->RuneCost[i];
        if (Player* modOwner = m_caster->GetSpellModOwner())
            modOwner->ApplySpellMod(m_spellInfo->Id, SPELLMOD_COST, runeCost[i], this);
    }

    runeCost[RUNE_DEATH] = 0;                               // calculated later

    for (uint32 i = 0; i < MAX_RUNES; ++i)
    {
        RuneType rune = player->GetCurrentRune(i);
        if (!player->GetRuneCooldown(i) && runeCost[rune] > 0)
        {
            player->SetRuneCooldown(i, didHit ? player->GetRuneBaseCooldown(i, false) : uint32(RUNE_MISS_COOLDOWN));
            player->SetLastUsedRune(rune);
            runeCost[rune]--;
        }
    }

    // Xinef: firstly consume death runes of base type
    // Xinef: in second loop consume all available
    for (uint8 loop = 0; loop < 2; ++loop)
    {
        runeCost[RUNE_DEATH] = runeCost[RUNE_BLOOD] + runeCost[RUNE_UNHOLY] + runeCost[RUNE_FROST];
        if (runeCost[RUNE_DEATH] > 0)
        {
            for (uint8 i = 0; i < MAX_RUNES; ++i)
            {
                RuneType rune = player->GetCurrentRune(i);
                if (!player->GetRuneCooldown(i) && rune == RUNE_DEATH && (loop ? true : (runeCost[player->GetBaseRune(i)] > 0)))
                {
                    player->SetRuneCooldown(i, didHit ? player->GetRuneBaseCooldown(i, false) : uint32(RUNE_MISS_COOLDOWN));
                    player->SetLastUsedRune(rune);
                    runeCost[rune]--;
                    if (!loop)
                        runeCost[player->GetBaseRune(i)]--;

                    // keep Death Rune type if missed
                    if (didHit)
                        player->RestoreBaseRune(i);

                    if (runeCost[RUNE_DEATH] == 0)
                        break;
                }
            }
        }
    }

    // you can gain some runic power when use runes
    if (didHit)
        if (int32 rp = int32(runeCostData->runePowerGain * sWorld->getRate(RATE_POWER_RUNICPOWER_INCOME)))
            player->ModifyPower(POWER_RUNIC_POWER, int32(rp));
}

void Spell::TakeReagents()
{
    if (!m_caster->IsPlayer())
        return;

    ItemTemplate const* castItemTemplate = m_CastItem ? m_CastItem->GetTemplate() : nullptr;

    // do not take reagents for these item casts
    if (castItemTemplate && castItemTemplate->HasFlag(ITEM_FLAG_NO_REAGENT_COST))
        return;

    Player* p_caster = m_caster->ToPlayer();
    if (p_caster->CanNoReagentCast(m_spellInfo))
        return;

    for (uint32 x = 0; x < MAX_SPELL_REAGENTS; ++x)
    {
        if (m_spellInfo->Reagent[x] <= 0)
            continue;

        uint32 itemid = m_spellInfo->Reagent[x];
        uint32 itemcount = m_spellInfo->ReagentCount[x];

        // if CastItem is also spell reagent
        if (castItemTemplate && castItemTemplate->ItemId == itemid)
        {
            for (int s = 0; s < MAX_ITEM_PROTO_SPELLS; ++s)
            {
                // CastItem will be used up and does not count as reagent
                int32 charges = m_CastItem->GetSpellCharges(s);
                if (castItemTemplate->Spells[s].SpellCharges < 0 && std::abs(charges) < 2)
                {
                    ++itemcount;
                    break;
                }
            }

            m_CastItem = nullptr;
            m_castItemGUID.Clear();
        }

        // if GetItemTarget is also spell reagent
        if (m_targets.GetItemTargetEntry() == itemid)
            m_targets.SetItemTarget(nullptr);

        p_caster->DestroyItemCount(itemid, itemcount, true);
    }
}

void Spell::HandleThreatSpells()
{
    if (m_UniqueTargetInfo.empty())
        return;

    if (m_spellInfo->HasAttribute(SPELL_ATTR1_NO_THREAT) || m_spellInfo->HasAttribute(SPELL_ATTR3_SUPRESS_TARGET_PROCS))
        return;

    float threat = 0.0f;
    if (SpellThreatEntry const* threatEntry = sSpellMgr->GetSpellThreatEntry(m_spellInfo->Id))
    {
        if (threatEntry->apPctMod != 0.0f)
            threat += threatEntry->apPctMod * m_caster->GetTotalAttackPowerValue(BASE_ATTACK);

        threat += threatEntry->flatMod;
    }
    else if (!m_spellInfo->HasAttribute(SPELL_ATTR0_CU_NO_INITIAL_THREAT))
        threat += m_spellInfo->SpellLevel;

    // past this point only multiplicative effects occur
    if (threat == 0.0f)
        return;

    // since 2.0.1 threat from positive effects also is distributed among all targets, so the overall caused threat is at most the defined bonus
    threat /= m_UniqueTargetInfo.size();

    for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
    {
        float threatToAdd = threat;
        if (ihit->missCondition != SPELL_MISS_NONE)
            threatToAdd = 0.0f;

        Unit* target = ObjectAccessor::GetUnit(*m_caster, ihit->targetGUID);
        if (!target)
            continue;

        bool IsFriendly = m_caster->IsFriendlyTo(target);
        // positive spells distribute threat among all units that are in combat with target, like healing
        if (m_spellInfo->_IsPositiveSpell() && IsFriendly)
            target->getHostileRefMgr().threatAssist(m_caster, threatToAdd, m_spellInfo);
        // for negative spells threat gets distributed among affected targets
        else if (!m_spellInfo->_IsPositiveSpell() && !IsFriendly && target->CanHaveThreatList())
            target->AddThreat(m_caster, threatToAdd, m_spellInfo->GetSchoolMask(), m_spellInfo);
    }
    LOG_DEBUG("spells.aura", "Spell {}, added an additional {} threat for {} {} target(s)", m_spellInfo->Id, threat, m_spellInfo->_IsPositiveSpell() ? "assisting" : "harming", uint32(m_UniqueTargetInfo.size()));
}

void Spell::HandleEffects(Unit* pUnitTarget, Item* pItemTarget, GameObject* pGOTarget, uint32 i, SpellEffectHandleMode mode)
{
    if (HasTriggeredCastFlag(TRIGGERED_IGNORE_EFFECTS))
        return;

    effectHandleMode = mode;
    unitTarget = pUnitTarget;
    itemTarget = pItemTarget;
    gameObjTarget = pGOTarget;
    destTarget = &m_destTargets[i]._position;

    uint8 eff = m_spellInfo->Effects[i].Effect;

    LOG_DEBUG("spells.aura", "Spell: {} Effect : {}", m_spellInfo->Id, eff);

    // we do not need DamageMultiplier here.
    damage = CalculateSpellDamage(i, nullptr);

    bool preventDefault = CallScriptEffectHandlers((SpellEffIndex)i, mode);

    if (!preventDefault && eff < TOTAL_SPELL_EFFECTS)
    {
        (this->*SpellEffects[eff])((SpellEffIndex)i);
    }
}

SpellCastResult Spell::CheckCast(bool strict)
{
    // check death state
    if (!m_caster->IsAlive() && !m_spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && !(m_spellInfo->HasAttribute(SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD) || (IsTriggered() && !m_triggeredByAuraSpell)))
        return SPELL_FAILED_CASTER_DEAD;

    // Spectator check
    if (m_caster->IsPlayer())
        if (((Player const*)m_caster)->IsSpectator() && m_spellInfo->Id != SPECTATOR_SPELL_BINDSIGHT)
            return SPELL_FAILED_NOT_HERE;

    SpellCastResult res = SPELL_CAST_OK;

    sScriptMgr->OnSpellCheckCast(this, strict, res);

    if (res != SPELL_CAST_OK)
        return res;

    // check cooldowns to prevent cheating
    if (!m_spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE))
    {
        if (m_caster->IsPlayer())
        {
            //can cast triggered (by aura only?) spells while have this flag
            if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_CASTER_AURASTATE) && m_caster->ToPlayer()->HasPlayerFlag(PLAYER_ALLOW_ONLY_ABILITY) && !IsNextMeleeSwingSpell())
                return SPELL_FAILED_SPELL_IN_PROGRESS;

            if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD) && m_caster->ToPlayer()->HasSpellCooldown(m_spellInfo->Id))
            {
                if (m_triggeredByAuraSpell)
                    return SPELL_FAILED_DONT_REPORT;
                else
                    return SPELL_FAILED_NOT_READY;
            }

            // check if we are using a potion in combat for the 2nd+ time. Cooldown is added only after caster gets out of combat
            if (m_caster->ToPlayer()->GetLastPotionId() && m_CastItem && (m_CastItem->IsPotion() || m_spellInfo->IsCooldownStartedOnEvent()))
                return SPELL_FAILED_NOT_READY;
        }
        else if (!IsTriggered() && m_caster->IsCreature() && m_caster->ToCreature()->IsSpellProhibited(m_spellInfo->GetSchoolMask()))
            return SPELL_FAILED_NOT_READY;

        //npcbot
        if (m_caster->IsNPCBot() && m_caster->ToCreature()->HasSpellCooldown(m_spellInfo->Id) && !IsIgnoringCooldowns())
        {
            //TC_LOG_ERROR("spells", "%s has cd of %u on %s", m_caster->GetName().c_str(), m_caster->ToCreature()->GetCreatureSpellCooldownDelay(m_spellInfo->Id), m_spellInfo->SpellName[0]);
            if (m_triggeredByAuraSpell)
                return SPELL_FAILED_DONT_REPORT;
            //else
            //    return SPELL_FAILED_NOT_READY;
        }
        //end npcbot
    }

    if (m_spellInfo->HasAttribute(SPELL_ATTR7_DEBUG_SPELL) && !m_caster->HasUnitFlag2(UNIT_FLAG2_ALLOW_CHEAT_SPELLS))
    {
        m_customError = SPELL_CUSTOM_ERROR_GM_ONLY;
        return SPELL_FAILED_CUSTOM_ERROR;
    }

    // Check global cooldown
    if (strict && !HasTriggeredCastFlag(TRIGGERED_IGNORE_GCD) && HasGlobalCooldown())
        return SPELL_FAILED_NOT_READY;

    // only triggered spells can be processed an ended battleground
    if (!IsTriggered() && m_caster->IsPlayer())
        if (Battleground* bg = m_caster->ToPlayer()->GetBattleground())
            if (bg->GetStatus() == STATUS_WAIT_LEAVE)
                return SPELL_FAILED_DONT_REPORT;

    if (m_caster->IsPlayer() /*&& VMAP::VMapFactory::createOrGetVMapMgr()->isLineOfSightCalcEnabled()*/) // pussywizard: optimization (commented)
    {
        if (m_spellInfo->HasAttribute(SPELL_ATTR0_ONLY_OUTDOORS) &&
                !m_caster->IsOutdoors())
            return SPELL_FAILED_ONLY_OUTDOORS;

        if (m_spellInfo->HasAttribute(SPELL_ATTR0_ONLY_INDOORS) &&
                m_caster->IsOutdoors())
            return SPELL_FAILED_ONLY_INDOORS;
    }

    // only check at first call, Stealth auras are already removed at second call
    // for now, ignore triggered spells
    if (strict && !HasTriggeredCastFlag(TRIGGERED_IGNORE_SHAPESHIFT))
    {
        bool checkForm = true;
        // Ignore form req aura
        Unit::AuraEffectList const& ignore = m_caster->GetAuraEffectsByType(SPELL_AURA_MOD_IGNORE_SHAPESHIFT);
        for (Unit::AuraEffectList::const_iterator i = ignore.begin(); i != ignore.end(); ++i)
        {
            if (!(*i)->IsAffectedOnSpell(m_spellInfo))
                continue;
            checkForm = false;
            break;
        }
        if (checkForm)
        {
            // Cannot be used in this stance/form
            SpellCastResult shapeError = m_spellInfo->CheckShapeshift(m_caster->GetShapeshiftForm());
            if (shapeError != SPELL_CAST_OK)
                return shapeError;

            if (m_spellInfo->HasAttribute(SPELL_ATTR0_ONLY_STEALTHED) && !(m_caster->HasStealthAura()))
                return SPELL_FAILED_ONLY_STEALTHED;
        }
    }

    Unit::AuraEffectList const& blockSpells = m_caster->GetAuraEffectsByType(SPELL_AURA_BLOCK_SPELL_FAMILY);
    for (Unit::AuraEffectList::const_iterator blockItr = blockSpells.begin(); blockItr != blockSpells.end(); ++blockItr)
        if (uint32((*blockItr)->GetMiscValue()) == m_spellInfo->SpellFamilyName)
            return SPELL_FAILED_SPELL_UNAVAILABLE;

    bool reqCombat = true;
    Unit::AuraEffectList const& stateAuras = m_caster->GetAuraEffectsByType(SPELL_AURA_ABILITY_IGNORE_AURASTATE);
    for (Unit::AuraEffectList::const_iterator j = stateAuras.begin(); j != stateAuras.end(); ++j)
    {
        if ((*j)->IsAffectedOnSpell(m_spellInfo))
        {
            m_needComboPoints = false;
            if ((*j)->GetMiscValue() == 1)
            {
                reqCombat = false;
                break;
            }
        }
    }

    // caster state requirements
    // not for triggered spells (needed by execute)
    if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_CASTER_AURASTATE))
    {
        if (m_spellInfo->CasterAuraState && !m_caster->HasAuraState(AuraStateType(m_spellInfo->CasterAuraState), m_spellInfo, m_caster))
            return SPELL_FAILED_CASTER_AURASTATE;
        if (m_spellInfo->CasterAuraStateNot && m_caster->HasAuraState(AuraStateType(m_spellInfo->CasterAuraStateNot), m_spellInfo, m_caster))
            return SPELL_FAILED_CASTER_AURASTATE;

        // Note: spell 62473 requres CasterAuraSpell = triggering spell
        if (m_spellInfo->CasterAuraSpell && !m_caster->HasAura(sSpellMgr->GetSpellIdForDifficulty(m_spellInfo->CasterAuraSpell, m_caster)))
            return SPELL_FAILED_CASTER_AURASTATE;
        if (m_spellInfo->ExcludeCasterAuraSpell && m_caster->HasAura(sSpellMgr->GetSpellIdForDifficulty(m_spellInfo->ExcludeCasterAuraSpell, m_caster)))
            return SPELL_FAILED_CASTER_AURASTATE;

        if (reqCombat && m_caster->IsInCombat() && !m_spellInfo->CanBeUsedInCombat())
            return SPELL_FAILED_AFFECTING_COMBAT;
    }

    // Xinef: exploit protection
    if (reqCombat && !m_spellInfo->CanBeUsedInCombat() && (m_spellInfo->HasEffect(SPELL_EFFECT_RESURRECT) || m_spellInfo->HasEffect(SPELL_EFFECT_RESURRECT_NEW)))
    {
        if (m_caster->IsPlayer() && m_caster->GetMap()->IsDungeon())
            if (InstanceScript* instanceScript = m_caster->GetInstanceScript())
                if (instanceScript->IsEncounterInProgress())
                {
                    if (Group* group = m_caster->ToPlayer()->GetGroup())
                        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                            if (Player* member = itr->GetSource())
                                if (member->IsInMap(m_caster))
                                    if (Unit* victim = member->GetVictim())
                                        if (victim->IsInCombat() && m_caster->GetDistance(victim) < m_caster->GetVisibilityRange())
                                        {
                                            m_caster->CombatStart(victim);
                                            victim->AddThreat(m_caster, 1.0f);
                                            break;
                                        }
                    return SPELL_FAILED_TARGET_CANNOT_BE_RESURRECTED;
                }
    }

    // cancel autorepeat spells if cast start when moving
    // (not wand currently autorepeat cast delayed to moving stop anyway in spell update code)
    if (m_caster->IsPlayer() && m_caster->ToPlayer()->isMoving() && !IsTriggered())
    {
        // skip stuck spell to allow use it in falling case and apply spell limitations at movement
        if ((!m_caster->HasUnitMovementFlag(MOVEMENTFLAG_FALLING_FAR) || m_spellInfo->Effects[0].Effect != SPELL_EFFECT_STUCK) &&
                (IsAutoRepeat() || (m_spellInfo->AuraInterruptFlags & AURA_INTERRUPT_FLAG_NOT_SEATED) != 0))
            return SPELL_FAILED_MOVING;
    }

    Vehicle* vehicle = m_caster->GetVehicle();
    if (vehicle && !HasTriggeredCastFlag(TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE))
    {
        uint16 checkMask = 0;
        for (uint8 effIndex = EFFECT_0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
        {
            SpellEffectInfo const* effInfo = &m_spellInfo->Effects[effIndex];
            if (effInfo->ApplyAuraName == SPELL_AURA_MOD_SHAPESHIFT)
            {
                SpellShapeshiftFormEntry const* shapeShiftEntry = sSpellShapeshiftFormStore.LookupEntry(effInfo->MiscValue);
                if (shapeShiftEntry && (shapeShiftEntry->flags1 & 1) == 0)  // unk flag
                    checkMask |= VEHICLE_SEAT_FLAG_UNCONTROLLED;
                break;
            }
        }

        if (m_spellInfo->HasAura(SPELL_AURA_MOUNTED))
            checkMask |= VEHICLE_SEAT_FLAG_CAN_CAST_MOUNT_SPELL;

        if (!checkMask)
            checkMask = VEHICLE_SEAT_FLAG_CAN_ATTACK;

        // All creatures should be able to cast as passengers freely, restriction and attribute are only for players
        VehicleSeatEntry const* vehicleSeat = vehicle->GetSeatForPassenger(m_caster);
        if (!m_spellInfo->HasAttribute(SPELL_ATTR6_ALLOW_WHILE_RIDING_VEHICLE) && !m_spellInfo->HasAttribute(SPELL_ATTR0_ALLOW_WHILE_MOUNTED)
                && (vehicleSeat->m_flags & checkMask) != checkMask && m_caster->IsPlayer())
            return SPELL_FAILED_DONT_REPORT;
    }

    // check spell cast conditions from database
    {
        ConditionSourceInfo condInfo = ConditionSourceInfo(m_caster);
        condInfo.mConditionTargets[1] = m_targets.GetObjectTarget();
        ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_SPELL, m_spellInfo->Id);
        if (!conditions.empty() && !sConditionMgr->IsObjectMeetToConditions(condInfo, conditions))
        {
            // mLastFailedCondition can be nullptr if there was an error processing the condition in Condition::Meets (i.e. wrong data for ConditionTarget or others)
            if (condInfo.mLastFailedCondition && condInfo.mLastFailedCondition->ErrorType)
            {
                if (condInfo.mLastFailedCondition->ErrorType == SPELL_FAILED_CUSTOM_ERROR)
                    m_customError = SpellCustomErrors(condInfo.mLastFailedCondition->ErrorTextId);
                return SpellCastResult(condInfo.mLastFailedCondition->ErrorType);
            }
            if (!condInfo.mLastFailedCondition || !condInfo.mLastFailedCondition->ConditionTarget)
                return SPELL_FAILED_CASTER_AURASTATE;
            return SPELL_FAILED_BAD_TARGETS;
        }
    }

    // Don't check explicit target for passive spells (workaround) (check should be skipped only for learn case)
    // those spells may have incorrect target entries or not filled at all (for example 15332)
    // such spells when learned are not targeting anyone using targeting system, they should apply directly to caster instead
    // also, such casts shouldn't be sent to client
    // Xinef: do not check explicit casts for self cast of triggered spells (eg. reflect case)
    if (!(m_spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && (!m_targets.GetUnitTarget() || m_targets.GetUnitTarget() == m_caster)))
    {
        // Check explicit target for m_originalCaster - todo: get rid of such workarounds
        // Xinef: do not check explicit target for triggered spell casted on self with targetflag enemy
        if (!m_triggeredByAuraSpell || m_targets.GetUnitTarget() != m_caster || !(m_spellInfo->GetExplicitTargetMask() & TARGET_FLAG_UNIT_ENEMY))
        {
            SpellCastResult castResult = m_spellInfo->CheckExplicitTarget((m_originalCaster && m_caster->GetEntry() != WORLD_TRIGGER) ? m_originalCaster : m_caster, m_targets.GetObjectTarget(), m_targets.GetItemTarget());
            if (castResult != SPELL_CAST_OK)
                return castResult;
        }
    }

    if (Unit* target = m_targets.GetUnitTarget())
    {
        SpellCastResult castResult = m_spellInfo->CheckTarget(m_caster, target, false);
        if (castResult != SPELL_CAST_OK)
            return castResult;

        if (target != m_caster)
        {
            // Must be behind the target
            if (m_spellInfo->HasAttribute(SPELL_ATTR0_CU_REQ_CASTER_BEHIND_TARGET) && target->HasInArc(static_cast<float>(M_PI), m_caster))
                return SPELL_FAILED_NOT_BEHIND;

            // Target must be facing you
            if (m_spellInfo->HasAttribute(SPELL_ATTR0_CU_REQ_TARGET_FACING_CASTER) && !target->HasInArc(static_cast<float>(M_PI), m_caster))
                return SPELL_FAILED_NOT_INFRONT;

            if ((!m_caster->IsTotem() || !m_spellInfo->IsPositive()) && !m_spellInfo->HasAttribute(SPELL_ATTR2_IGNORE_LINE_OF_SIGHT) &&
                !m_spellInfo->HasAttribute(SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT) && !(m_spellFlags & SPELL_FLAG_REDIRECTED))
            {
                bool castedByGameobject = false;
                uint32 losChecks = LINEOFSIGHT_ALL_CHECKS;
                if (m_originalCasterGUID.IsGameObject())
                {
                    castedByGameobject = m_caster->GetMap()->GetGameObject(m_originalCasterGUID) != nullptr;
                }
                else if (m_caster->GetEntry() == WORLD_TRIGGER)
                {
                    if (TempSummon* tempSummon = m_caster->ToTempSummon())
                    {
                        castedByGameobject = tempSummon->GetSummonerGameObject() != nullptr;
                    }
                }

                if (castedByGameobject)
                {
                    // If spell casted by gameobject then ignore M2 models
                    losChecks &= ~LINEOFSIGHT_CHECK_GOBJECT_M2;
                }

                if (!m_caster->IsWithinLOSInMap(target, VMAP::ModelIgnoreFlags::M2, LineOfSightChecks(losChecks)))
                {
                    return SPELL_FAILED_LINE_OF_SIGHT;
                }
            }
        }
    }

    // Check for line of sight for spells with dest
    if (m_targets.HasDst())
    {
        float x, y, z;
        m_targets.GetDstPos()->GetPosition(x, y, z);

        if ((!m_caster->IsTotem() || !m_spellInfo->IsPositive()) && !m_spellInfo->HasAttribute(SPELL_ATTR2_IGNORE_LINE_OF_SIGHT) &&
            !m_spellInfo->HasAttribute(SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT))
        {
            bool castedByGameobject = false;
            uint32 losChecks = LINEOFSIGHT_ALL_CHECKS;
            if (m_originalCasterGUID.IsGameObject())
            {
                castedByGameobject = m_caster->GetMap()->GetGameObject(m_originalCasterGUID) != nullptr;
            }
            else if (m_caster->GetEntry() == WORLD_TRIGGER)
            {
                if (TempSummon* tempSummon = m_caster->ToTempSummon())
                {
                    castedByGameobject = tempSummon->GetSummonerGameObject() != nullptr;
                }
            }

            if (castedByGameobject)
            {
                // If spell casted by gameobject then ignore M2 models
                losChecks &= ~LINEOFSIGHT_CHECK_GOBJECT_M2;
            }

            if (!m_caster->IsWithinLOS(x, y, z, VMAP::ModelIgnoreFlags::M2, LineOfSightChecks((losChecks))))
            {
                return SPELL_FAILED_LINE_OF_SIGHT;
            }
        }
    }

    // check pet presence
    for (int j = 0; j < MAX_SPELL_EFFECTS; ++j)
    {
        if (m_spellInfo->Effects[j].TargetA.GetTarget() == TARGET_UNIT_PET)
        {
            //npcbot: allow bot pet as target
            if (m_caster->IsNPCBot() && m_caster->ToCreature()->GetBotsPet())
                break;
            else
            //end npcbot
            if (!m_caster->GetGuardianPet() && !m_caster->GetCharm())
            {
                if (m_triggeredByAuraSpell.spellInfo) // not report pet not existence for triggered spells
                    return SPELL_FAILED_DONT_REPORT;
                else
                    return SPELL_FAILED_NO_PET;
            }
            break;
        }
    }
    // Spell casted only on battleground
    if (m_spellInfo->HasAttribute(SPELL_ATTR3_ONLY_BATTLEGROUNDS) &&  m_caster->IsPlayer())
        if (!m_caster->ToPlayer()->InBattleground())
            return SPELL_FAILED_ONLY_BATTLEGROUNDS;

    // do not allow spells to be cast in arenas
    // - with greater than 10 min CD without SPELL_ATTR4_IGNORE_DEFAULT_ARENA_RESTRICTIONS flag
    // - with SPELL_ATTR4_NOT_IN_ARENA_OR_RATED_BATTLEGROUND flag
    if (m_spellInfo->HasAttribute(SPELL_ATTR4_NOT_IN_ARENA_OR_RATED_BATTLEGROUND) ||
            (m_spellInfo->GetRecoveryTime() >= 10 * MINUTE * IN_MILLISECONDS && !m_spellInfo->HasAttribute(SPELL_ATTR4_IGNORE_DEFAULT_ARENA_RESTRICTIONS)))
        if (MapEntry const* mapEntry = sMapStore.LookupEntry(m_caster->GetMapId()))
            if (mapEntry->IsBattleArena())
                return SPELL_FAILED_NOT_IN_ARENA;

    // zone check
    //npcbot: do not check location for bots (to avoid crash introduced in TC rev. 5cb8409f1ee57e8d)
    if (m_caster->IsNPCBot())
    {}
    else
    //end npcbot
    if (m_caster->IsCreature() || !m_caster->ToPlayer()->IsGameMaster())
    {
        uint32 zone, area;
        m_caster->GetZoneAndAreaId(zone, area);

        SpellCastResult locRes = m_spellInfo->CheckLocation(m_caster->GetMapId(), zone, area,
                                 m_caster->IsPlayer() ? m_caster->ToPlayer() : nullptr);
        if (locRes != SPELL_CAST_OK)
            return locRes;
    }

    // not let players cast spells at mount (and let do it to creatures)
    if (m_caster->IsMounted() && m_caster->IsPlayer() && !HasTriggeredCastFlag(TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE) &&
            !m_spellInfo->IsPassive() && !m_spellInfo->HasAttribute(SPELL_ATTR0_ALLOW_WHILE_MOUNTED))
    {
        if (m_caster->IsInFlight())
            return SPELL_FAILED_NOT_ON_TAXI;
        else
            return SPELL_FAILED_NOT_MOUNTED;
    }

    SpellCastResult castResult = SPELL_CAST_OK;

    // always (except passive spells) check items (focus object can be required for any type casts)
    if (!m_spellInfo->IsPassive())
    {
        // spell focus needs to be checked not only for players! there are vehicle spells that require spell focus
        castResult = CheckSpellFocus();
        if (castResult != SPELL_CAST_OK)
            return castResult;

        castResult = CheckItems();
        if (castResult != SPELL_CAST_OK)
            return castResult;
    }

    // Triggered spells also have range check
    /// @todo: determine if there is some flag to enable/disable the check
    castResult = CheckRange(strict);
    if (castResult != SPELL_CAST_OK)
        return castResult;

    if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_POWER_AND_REAGENT_COST))
    {
        castResult = CheckPower();
        if (castResult != SPELL_CAST_OK)
            return castResult;
    }

    if (HasTriggeredCastFlag(TRIGGERED_IGNORE_EFFECTS))
    {
        return SPELL_CAST_OK;
    }

    // xinef: do not skip triggered spells if they posses prevention type (eg. Bladestorm vs Hand of Protection)
    if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_CASTER_AURAS) || (m_spellInfo->PreventionType > SPELL_PREVENTION_TYPE_NONE && m_triggeredByAuraSpell && m_triggeredByAuraSpell.spellInfo->IsPositive()))
    {
        castResult = CheckCasterAuras(HasTriggeredCastFlag(TRIGGERED_IGNORE_CASTER_AURAS));
        if (castResult != SPELL_CAST_OK)
            return castResult;

        // xinef: Enraged Regeneration: While this is active, the warrior is blocked from using abilities that trigger being enraged (which would do nothing and waste the cooldowns).
        if (m_spellInfo->Mechanic && m_spellInfo->IsSelfCast())
        {
            SpellImmuneList const& mechanicList = m_caster->m_spellImmune[IMMUNITY_MECHANIC];
            for (SpellImmuneList::const_iterator itr = mechanicList.begin(); itr != mechanicList.end(); ++itr)
                if (itr->type == m_spellInfo->Mechanic)
                    return SPELL_FAILED_DAMAGE_IMMUNE;
        }
    }

    // script hook
    castResult = CallScriptCheckCastHandlers();
    if (castResult != SPELL_CAST_OK)
        return castResult;

    bool hasDispellableAura = false;
    bool hasNonDispelEffect = false;
    uint32 dispelMask = 0;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (m_spellInfo->Effects[i].Effect == SPELL_EFFECT_DISPEL)
        {
            if (m_spellInfo->Effects[i].IsTargetingArea() || m_spellInfo->HasAttribute(SPELL_ATTR1_INITIATE_COMBAT))
            {
                hasDispellableAura = true;
                break;
            }

            dispelMask |= SpellInfo::GetDispelMask(DispelType(m_spellInfo->Effects[i].MiscValue));
        }
        else if (m_spellInfo->Effects[i].IsEffect())
        {
            hasNonDispelEffect = true;
            break;
        }

    if (!hasNonDispelEffect && !hasDispellableAura && dispelMask && !IsTriggered())
    {
        if (Unit* target = m_targets.GetUnitTarget())
        {
            // Xinef: do not allow to cast on hostile targets in sanctuary
            if (!m_caster->IsFriendlyTo(target))
            {
                if (m_caster->IsInSanctuary() || target->IsInSanctuary())
                {
                    // Xinef: fix for duels
                    Player* player = m_caster->ToPlayer();
                    if (!player || !player->duel || target != player->duel->Opponent)
                        return SPELL_FAILED_NOTHING_TO_DISPEL;
                }
            }

            DispelChargesList dispelList;
            target->GetDispellableAuraList(m_caster, dispelMask, dispelList, m_spellInfo);

            if (dispelList.empty())
                return SPELL_FAILED_NOTHING_TO_DISPEL;
        }
    }

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        // for effects of spells that have only one target
        switch (m_spellInfo->Effects[i].Effect)
        {
            case SPELL_EFFECT_LEARN_SPELL:
                {
                    if (!m_caster->IsPlayer())
                        return SPELL_FAILED_BAD_TARGETS;

                    if (m_spellInfo->Effects[i].TargetA.GetTarget() != TARGET_UNIT_PET)
                        break;

                    Pet* pet = m_caster->ToPlayer()->GetPet();

                    if (!pet)
                        return SPELL_FAILED_NO_PET;

                    SpellInfo const* learn_spellproto = sSpellMgr->GetSpellInfo(m_spellInfo->Effects[i].TriggerSpell);

                    if (!learn_spellproto)
                        return SPELL_FAILED_NOT_KNOWN;

                    if (m_spellInfo->SpellLevel > pet->GetLevel())
                        return SPELL_FAILED_LOWLEVEL;

                    break;
                }
            case SPELL_EFFECT_LEARN_PET_SPELL:
                {
                    // check target only for unit target case
                    if (Unit* unitTarget = m_targets.GetUnitTarget())
                    {
                        if (!m_caster->IsPlayer())
                            return SPELL_FAILED_BAD_TARGETS;

                        Pet* pet = unitTarget->ToPet();
                        if (!pet || pet->GetOwner() != m_caster)
                            return SPELL_FAILED_BAD_TARGETS;

                        SpellInfo const* learn_spellproto = sSpellMgr->GetSpellInfo(m_spellInfo->Effects[i].TriggerSpell);

                        if (!learn_spellproto)
                            return SPELL_FAILED_NOT_KNOWN;

                        if (m_spellInfo->SpellLevel > pet->GetLevel())
                            return SPELL_FAILED_LOWLEVEL;
                    }
                    break;
                }
            case SPELL_EFFECT_APPLY_GLYPH:
                {
                    uint32 glyphId = m_spellInfo->Effects[i].MiscValue;
                    if (GlyphPropertiesEntry const* gp = sGlyphPropertiesStore.LookupEntry(glyphId))
                        if (m_caster->HasAura(gp->SpellId))
                            return SPELL_FAILED_UNIQUE_GLYPH;
                    break;
                }
            case SPELL_EFFECT_FEED_PET:
                {
                    if (!m_caster->IsPlayer())
                        return SPELL_FAILED_BAD_TARGETS;

                    Item* foodItem = m_targets.GetItemTarget();
                    if (!foodItem)
                        return SPELL_FAILED_BAD_TARGETS;

                    Pet* pet = m_caster->ToPlayer()->GetPet();

                    if (!pet)
                        return SPELL_FAILED_NO_PET;

                    if (!pet->HaveInDiet(foodItem->GetTemplate()))
                        return SPELL_FAILED_WRONG_PET_FOOD;

                    if (!pet->GetCurrentFoodBenefitLevel(foodItem->GetTemplate()->ItemLevel))
                        return SPELL_FAILED_FOOD_LOWLEVEL;

                    if (m_caster->IsInCombat() || pet->IsInCombat())
                        return SPELL_FAILED_AFFECTING_COMBAT;

                    break;
                }
            case SPELL_EFFECT_POWER_BURN:
            case SPELL_EFFECT_POWER_DRAIN:
                {
                    // Can be area effect, Check only for players and not check if target - caster (spell can have multiply drain/burn effects)
                    if (m_caster->IsPlayer())
                        if (Unit* target = m_targets.GetUnitTarget())
                            if (target != m_caster && !target->HasActivePowerType(Powers(m_spellInfo->Effects[i].MiscValue)))
                                return SPELL_FAILED_BAD_TARGETS;
                    break;
                }
            case SPELL_EFFECT_CHARGE:
                {
                    if (m_caster->HasUnitState(UNIT_STATE_CHARGING))
                    {
                        return SPELL_FAILED_DONT_REPORT;
                    }

                    if (m_spellInfo->SpellFamilyName == SPELLFAMILY_WARRIOR)
                    {
                        // Warbringer - can't be handled in proc system - should be done before checkcast root check and charge effect process
                        if (strict && m_caster->IsScriptOverriden(m_spellInfo, 6953))
                            m_caster->RemoveMovementImpairingAuras(true);
                    }
                    if (m_caster->HasUnitState(UNIT_STATE_ROOT))
                    {
                        // Exception for Master's Call
                        if (m_spellInfo->Id != 54216)
                        {
                            return SPELL_FAILED_ROOTED;
                        }
                    }
                    if (m_caster->IsPlayer())
                        if (Unit* target = m_targets.GetUnitTarget())
                            if (!target->IsAlive())
                                return SPELL_FAILED_BAD_TARGETS;
                    // Xinef: Pass only explicit unit target spells
                    // pussywizard:
                    if (DisableMgr::IsPathfindingEnabled(m_caster->FindMap()) && m_spellInfo->NeedsExplicitUnitTarget())
                    {
                        Unit* target = m_targets.GetUnitTarget();
                        if (!target)
                            return SPELL_FAILED_DONT_REPORT;

                        // first we must check to see if the target is in LoS. A path can usually be built but LoS matters for charge spells
                        if (!target->IsWithinLOSInMap(m_caster)) //Do full LoS/Path check. Don't exclude m2
                            return SPELL_FAILED_LINE_OF_SIGHT;

                        float objSize = target->GetCombatReach();
                        float range = m_spellInfo->GetMaxRange(true, m_caster, this) * 1.5f + objSize; // can't be overly strict

                        m_preGeneratedPath = std::make_unique<PathGenerator>(m_caster);
                        m_preGeneratedPath->SetPathLengthLimit(range);

                        // first try with raycast, if it fails fall back to normal path
                        bool result = m_preGeneratedPath->CalculatePath(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), false);
                        if (m_preGeneratedPath->GetPathType() & PATHFIND_SHORT)
                            return SPELL_FAILED_NOPATH;
                        else if (!result || m_preGeneratedPath->GetPathType() & (PATHFIND_NOPATH | PATHFIND_INCOMPLETE))
                            return SPELL_FAILED_NOPATH;
                        else if (m_preGeneratedPath->IsInvalidDestinationZ(target)) // Check position z, if not in a straight line
                            return SPELL_FAILED_NOPATH;

                        m_preGeneratedPath->ShortenPathUntilDist(G3D::Vector3(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ()), objSize); // move back
                    }
                    if (Player* player = m_caster->ToPlayer())
                        player->SetCanTeleport(true);
                    break;
                }
            case SPELL_EFFECT_SKINNING:
                {
                    if (!m_caster->IsPlayer() || !m_targets.GetUnitTarget() || !m_targets.GetUnitTarget()->IsCreature())
                        return SPELL_FAILED_BAD_TARGETS;

                    if (!(m_targets.GetUnitTarget()->GetUnitFlags() & UNIT_FLAG_SKINNABLE))
                        return SPELL_FAILED_TARGET_UNSKINNABLE;

                    Creature* creature = m_targets.GetUnitTarget()->ToCreature();
                    if (!creature->IsCritter() && !creature->loot.isLooted())
                        return SPELL_FAILED_TARGET_NOT_LOOTED;

                    uint32 skill = creature->GetCreatureTemplate()->GetRequiredLootSkill();

                    int32 skillValue = m_caster->ToPlayer()->GetSkillValue(skill);
                    int32 TargetLevel = m_targets.GetUnitTarget()->GetLevel();
                    int32 ReqValue = (skillValue < 100 ? (TargetLevel - 10) * 10 : TargetLevel * 5);
                    if (ReqValue > skillValue)
                        return SPELL_FAILED_LOW_CASTLEVEL;

                    break;
                }
            case SPELL_EFFECT_OPEN_LOCK:
                {
                    if (m_spellInfo->Effects[i].TargetA.GetTarget() != TARGET_GAMEOBJECT_TARGET &&
                            m_spellInfo->Effects[i].TargetA.GetTarget() != TARGET_GAMEOBJECT_ITEM_TARGET)
                        break;

                //npcbot
                if (m_caster->IsNPCBot())
                {
                    if (m_spellInfo->Effects[i].TargetA.GetTarget() == TARGET_GAMEOBJECT_TARGET && !m_targets.GetGOTarget())
                        return SPELL_FAILED_BAD_TARGETS;
                    break;
                }
                //end npcbot

                    if (!m_caster->IsPlayer()  // only players can open locks, gather etc.
                            // we need a go target in case of TARGET_GAMEOBJECT_TARGET
                            || (m_spellInfo->Effects[i].TargetA.GetTarget() == TARGET_GAMEOBJECT_TARGET && !m_targets.GetGOTarget()))
                        return SPELL_FAILED_BAD_TARGETS;

                    Item* pTempItem = nullptr;
                    if (m_targets.GetTargetMask() & TARGET_FLAG_TRADE_ITEM)
                    {
                        if (TradeData* pTrade = m_caster->ToPlayer()->GetTradeData())
                            pTempItem = pTrade->GetTraderData()->GetItem(TradeSlots(m_targets.GetItemTargetGUID().GetRawValue()));
                    }
                    else if (m_targets.GetTargetMask() & TARGET_FLAG_ITEM)
                        pTempItem = m_caster->ToPlayer()->GetItemByGuid(m_targets.GetItemTargetGUID());

                    // we need a go target, or an openable item target in case of TARGET_GAMEOBJECT_ITEM_TARGET
                    if (m_spellInfo->Effects[i].TargetA.GetTarget() == TARGET_GAMEOBJECT_ITEM_TARGET &&
                            !m_targets.GetGOTarget() &&
                            (!pTempItem || !pTempItem->GetTemplate()->LockID || !pTempItem->IsLocked()))
                        return SPELL_FAILED_BAD_TARGETS;

                    // We must also ensure the gameobject we are opening is still closed by the time the spell finishes.
                    if (GameObject* go = m_targets.GetGOTarget())
                    {
                        if (go->GetGoType() == GAMEOBJECT_TYPE_DOOR && go->GetGoState() != GO_STATE_READY)
                        {
                            return SPELL_FAILED_ALREADY_OPEN;
                        }
                    }
                    if (m_spellInfo->Id != 1842 || (m_targets.GetGOTarget() &&
                                                    m_targets.GetGOTarget()->GetGOInfo()->type != GAMEOBJECT_TYPE_TRAP))
                    {
                        if (m_targets.GetGOTarget() && m_targets.GetGOTarget()->GetEntry() == 179697)
                        {
                            if (!m_caster->ToPlayer()->CanUseBattlegroundObject(nullptr))
                                return SPELL_FAILED_TRY_AGAIN;
                        }
                        else if (m_caster->ToPlayer()->InBattleground() && // In Battleground players can use only flags and banners, or Gurubashi chest
                                 !m_caster->ToPlayer()->CanUseBattlegroundObject(m_targets.GetGOTarget()))
                            return SPELL_FAILED_TRY_AGAIN;
                    }

                    // get the lock entry
                    uint32 lockId = 0;
                    if (GameObject* go = m_targets.GetGOTarget())
                    {
                        lockId = go->GetGOInfo()->GetLockId();
                        if (!lockId)
                            return SPELL_FAILED_BAD_TARGETS;
                    }
                    else if (Item* itm = m_targets.GetItemTarget())
                        lockId = itm->GetTemplate()->LockID;

                    SkillType skillId = SKILL_NONE;
                    int32 reqSkillValue = 0;
                    int32 skillValue = 0;

                    // check lock compatibility
                    SpellCastResult res = CanOpenLock(i, lockId, skillId, reqSkillValue, skillValue);
                    if (res != SPELL_CAST_OK)
                        return res;

                    // chance for fail at lockpicking attempt
                    // second check prevent fail at rechecks
                    // herbalism and mining cannot fail as of patch 3.1.0
                    if (skillId != SKILL_NONE && skillId != SKILL_HERBALISM && skillId != SKILL_MINING && (!m_selfContainer || ((*m_selfContainer) != this)))
                    {
                        // chance for failure in orange lockpick
                        if (skillId == SKILL_LOCKPICKING && reqSkillValue > irand(skillValue - 25, skillValue + 37))
                        {
                            return SPELL_FAILED_TRY_AGAIN;
                        }
                    }
                    break;
                }
            case SPELL_EFFECT_RESURRECT_PET:
                {
                    Unit* unitCaster = m_caster->ToUnit();
                    if (!unitCaster)
                    {
                        return SPELL_FAILED_BAD_TARGETS;
                    }

                    Creature* pet = unitCaster->GetGuardianPet();
                    if (pet)
                    {
                        if (pet->IsAlive())
                        {
                            return SPELL_FAILED_ALREADY_HAVE_SUMMON;
                        }
                    }
                    else if (Player* playerCaster = m_caster->ToPlayer())
                    {
                        PetStable& petStable = playerCaster->GetOrInitPetStable();
                        if (!petStable.CurrentPet && petStable.UnslottedPets.empty())
                        {
                            return SPELL_FAILED_NO_PET;
                        }
                    }

                    break;
                }
            // This is generic summon effect
            case SPELL_EFFECT_SUMMON:
                {
                    SummonPropertiesEntry const* SummonProperties = sSummonPropertiesStore.LookupEntry(m_spellInfo->Effects[i].MiscValueB);
                    if (!SummonProperties || m_spellInfo->HasAttribute(SPELL_ATTR1_DISMISS_PET_FIRST))
                        break;
                    switch (SummonProperties->Category)
                    {
                        case SUMMON_CATEGORY_PET:
                            if (m_caster->GetPetGUID())
                                return SPELL_FAILED_ALREADY_HAVE_SUMMON;
                            [[fallthrough]];
                        case SUMMON_CATEGORY_PUPPET:
                            if (m_caster->GetCharmGUID())
                                return SPELL_FAILED_ALREADY_HAVE_CHARM;
                            break;
                    }
                    break;
                }
            case SPELL_EFFECT_CREATE_TAMED_PET:
                {
                    if (m_targets.GetUnitTarget())
                    {
                        if (!m_targets.GetUnitTarget()->IsPlayer())
                            return SPELL_FAILED_BAD_TARGETS;
                        if (m_targets.GetUnitTarget()->GetPetGUID())
                            return SPELL_FAILED_ALREADY_HAVE_SUMMON;
                    }
                    break;
                }
            case SPELL_EFFECT_SUMMON_PET:
                {
                    Unit* unitCaster = m_caster->ToUnit();
                    if (!unitCaster)
                        return SPELL_FAILED_BAD_TARGETS;

                    if (!m_spellInfo->HasAttribute(SPELL_ATTR1_DISMISS_PET_FIRST))
                    {
                        if (m_caster->GetPetGUID())
                            return SPELL_FAILED_ALREADY_HAVE_SUMMON;
                        if (m_caster->GetCharmGUID())
                            return SPELL_FAILED_ALREADY_HAVE_CHARM;
                    }

                    if (m_caster->IsPlayer() && m_caster->IsClass(CLASS_WARLOCK, CLASS_CONTEXT_PET) && strict)
                        if (Pet* pet = m_caster->ToPlayer()->GetPet())
                            pet->CastSpell(pet, 32752, true, nullptr, nullptr, pet->GetGUID()); //starting cast, trigger pet stun (cast by pet so it doesn't attack player)

                    Player* playerCaster = unitCaster->ToPlayer();
                    if (playerCaster && playerCaster->GetPetStable())
                    {
                        std::pair<PetStable::PetInfo const*, PetSaveMode> info = Pet::GetLoadPetInfo(*playerCaster->GetPetStable(), m_spellInfo->Effects[i].MiscValue, 0, false);
                        if (info.first)
                        {
                            if (info.first->Type == HUNTER_PET)
                            {
                                if (!info.first->Health)
                                {
                                    playerCaster->SendTameFailure(PET_TAME_DEAD);
                                    return SPELL_FAILED_DONT_REPORT;
                                }

                                CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(info.first->CreatureId);
                                if (!creatureInfo || !creatureInfo->IsTameable(playerCaster->CanTameExoticPets()))
                                {
                                    // if problem in exotic pet
                                    if (creatureInfo && creatureInfo->IsTameable(true))
                                        playerCaster->SendTameFailure(PET_TAME_CANT_CONTROL_EXOTIC);
                                    else
                                        playerCaster->SendTameFailure(PET_TAME_NOPET_AVAILABLE);

                                    return SPELL_FAILED_DONT_REPORT;
                                }
                            }
                        }
                        else if (!m_spellInfo->Effects[i].MiscValue) // when miscvalue is present it is allowed to create new pets
                        {
                            playerCaster->SendTameFailure(PET_TAME_NOPET_AVAILABLE);
                            return SPELL_FAILED_DONT_REPORT;
                        }
                    }
                    break;
                }
            case SPELL_EFFECT_SUMMON_PLAYER:
                {
                    if (!m_caster->IsPlayer())
                        return SPELL_FAILED_BAD_TARGETS;
                    if (!m_caster->GetTarget())
                        return SPELL_FAILED_BAD_TARGETS;

                    Player* target = ObjectAccessor::FindPlayer(m_caster->ToPlayer()->GetTarget());
                    if (!target || (!target->IsInSameRaidWith(m_caster->ToPlayer()) && m_spellInfo->Id != 48955)) // refer-a-friend spell
                        return SPELL_FAILED_BAD_TARGETS;

                    // Xinef: Implement summon pending error
                    if (target->GetSummonExpireTimer() > GameTime::GetGameTime().count())
                        return SPELL_FAILED_SUMMON_PENDING;

                    // check if our map is dungeon
                    MapEntry const* map = sMapStore.LookupEntry(m_caster->GetMapId());
                    if (map->IsDungeon())
                    {
                        uint32 mapId = m_caster->GetMap()->GetId();
                        Difficulty difficulty = m_caster->GetMap()->GetDifficulty();
                        /*if (map->IsRaid())
                            if (InstancePlayerBind* targetBind = target->GetBoundInstance(mapId, difficulty))
                                if (targetBind->perm && targetBind != m_caster->ToPlayer()->GetBoundInstance(mapId, difficulty))
                                    return SPELL_FAILED_TARGET_LOCKED_TO_RAID_INSTANCE;*/

                        InstanceTemplate const* instance = sObjectMgr->GetInstanceTemplate(mapId);
                        if (!instance)
                            return SPELL_FAILED_TARGET_NOT_IN_INSTANCE;
                        if (!target->Satisfy(sObjectMgr->GetAccessRequirement(mapId, difficulty), mapId))
                            return SPELL_FAILED_BAD_TARGETS;
                    }
                    break;
                }
            // RETURN HERE
            case SPELL_EFFECT_SUMMON_RAF_FRIEND:
                {
                    if (!m_caster->IsPlayer())
                        return SPELL_FAILED_BAD_TARGETS;

                    Player* playerCaster = m_caster->ToPlayer();
                    //
                    if (!(playerCaster->GetTarget()))
                        return SPELL_FAILED_BAD_TARGETS;

                    Player* target = ObjectAccessor::FindPlayer(m_caster->ToPlayer()->GetTarget());

                    if (!target ||
                            !(target->GetSession()->GetRecruiterId() == playerCaster->GetSession()->GetAccountId() || target->GetSession()->GetAccountId() == playerCaster->GetSession()->GetRecruiterId()))
                        return SPELL_FAILED_BAD_TARGETS;

                    // Xinef: Implement summon pending error
                    if (target->GetSummonExpireTimer() > GameTime::GetGameTime().count())
                        return SPELL_FAILED_SUMMON_PENDING;

                    break;
                }
            case SPELL_EFFECT_LEAP:
            case SPELL_EFFECT_TELEPORT_UNITS_FACE_CASTER:
                {
                    //Do not allow to cast it before BG starts.
                    if (m_caster->IsPlayer())
                        if (Battleground const* bg = m_caster->ToPlayer()->GetBattleground())
                            if (bg->GetStatus() != STATUS_IN_PROGRESS)
                                return SPELL_FAILED_TRY_AGAIN;
                    break;
                }
            case SPELL_EFFECT_STEAL_BENEFICIAL_BUFF:
                {
                    if( !m_targets.GetUnitTarget() || m_targets.GetUnitTarget() == m_caster)
                        return SPELL_FAILED_BAD_TARGETS;

                    bool found = false;
                    Unit::VisibleAuraMap const* visibleAuras = m_targets.GetUnitTarget()->GetVisibleAuras();
                    for(Unit::VisibleAuraMap::const_iterator itr = visibleAuras->begin(); itr != visibleAuras->end(); ++itr)
                    {
                        if( itr->second->GetBase()->IsPassive() )
                            continue;

                        if( !itr->second->IsPositive() )
                            continue;

                        found = true;
                        break;
                    }

                    if( !found )
                        return SPELL_FAILED_NOTHING_TO_STEAL;

                    break;
                }
            case SPELL_EFFECT_LEAP_BACK:
                {
                    if (m_caster->HasUnitState(UNIT_STATE_ROOT))
                    {
                        if (m_caster->IsPlayer())
                            return SPELL_FAILED_ROOTED;
                        else
                            return SPELL_FAILED_DONT_REPORT;
                    }
                    break;
                }
            // xinef: do not allow to use leaps while rooted
            case SPELL_EFFECT_JUMP:
            case SPELL_EFFECT_JUMP_DEST:
                {
                    if (m_caster->HasUnitState(UNIT_STATE_ROOT))
                        return SPELL_FAILED_ROOTED;
                    break;
                }
            case SPELL_EFFECT_TALENT_SPEC_SELECT:
                if (!sScriptMgr->CanSelectSpecTalent(this))
                    return SPELL_FAILED_DONT_REPORT;
                // can't change during already started arena/battleground
                if (m_caster->IsPlayer())
                    if (Battleground const* bg = m_caster->ToPlayer()->GetBattleground())
                        if (bg->GetStatus() == STATUS_IN_PROGRESS)
                            return SPELL_FAILED_NOT_IN_BATTLEGROUND;
                break;
            default:
                break;
        }
    }

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        switch (m_spellInfo->Effects[i].ApplyAuraName)
        {
            case SPELL_AURA_DUMMY:
                break;
            case SPELL_AURA_MOD_POSSESS_PET:
                {
                    if (!m_caster->IsPlayer())
                        return SPELL_FAILED_NO_PET;

                    Pet* pet = m_caster->ToPlayer()->GetPet();
                    if (!pet)
                        return SPELL_FAILED_NO_PET;

                    if (pet->GetCharmerGUID())
                        return SPELL_FAILED_CHARMED;
                    break;
                }
            case SPELL_AURA_MOD_POSSESS:
            case SPELL_AURA_MOD_CHARM:
            case SPELL_AURA_AOE_CHARM:
                {
                    if (m_caster->GetCharmerGUID())
                        return SPELL_FAILED_CHARMED;

                    // Xinef: allow SPELL_AURA_MOD_POSSESS to posses target if caster has some pet
                    if (m_spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_CHARM && !m_spellInfo->HasAttribute(SPELL_ATTR1_DISMISS_PET_FIRST))
                    {
                        if (m_caster->GetPetGUID())
                            return SPELL_FAILED_ALREADY_HAVE_SUMMON;

                        if (m_caster->GetCharmGUID())
                            return SPELL_FAILED_ALREADY_HAVE_CHARM;
                    }
                    else if (m_spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_POSSESS)
                    {
                        if (m_caster->GetCharmGUID())
                            return SPELL_FAILED_ALREADY_HAVE_CHARM;
                    }

                    if (Unit* target = m_targets.GetUnitTarget())
                    {
                        if (target->IsCreature() && target->ToCreature()->IsVehicle())
                            return SPELL_FAILED_BAD_IMPLICIT_TARGETS;

                        if (target->IsMounted())
                            return SPELL_FAILED_CANT_BE_CHARMED;

                        if (target->GetCharmerGUID())
                            return SPELL_FAILED_CHARMED;

                        //npcbot: do not allow to charm owned npcbots
                        if (target->GetCreator() && target->GetCreator()->IsPlayer())
                            return SPELL_FAILED_TARGET_IS_PLAYER_CONTROLLED;
                        else if (target->IsNPCBotOrPet())
                            return SPELL_FAILED_CANT_BE_CHARMED;
                        //end npcbot

                        if (target->GetOwnerGUID() && target->GetOwnerGUID().IsPlayer())
                            return SPELL_FAILED_TARGET_IS_PLAYER_CONTROLLED;

                        if (target->IsPet() && (!target->GetOwner() || target->GetOwner()->ToPlayer()))
                            return SPELL_FAILED_CANT_BE_CHARMED;

                        int32 damage = CalculateSpellDamage(i, target);
                        if (damage && int32(target->GetLevel()) > damage)
                            return SPELL_FAILED_HIGHLEVEL;
                    }

                    break;
                }
            case SPELL_AURA_MOUNTED:
                {
                    // Disallow casting flying mounts in water
                    if (m_caster->IsInWater() && m_spellInfo->HasAura(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED))
                        return SPELL_FAILED_ONLY_ABOVEWATER;

                    // Ignore map check if spell have AreaId. AreaId already checked and this prevent special mount spells
                    bool allowMount = !m_caster->GetMap()->IsDungeon() || m_caster->GetMap()->IsBattlegroundOrArena();
                    InstanceTemplate const* it = sObjectMgr->GetInstanceTemplate(m_caster->GetMapId());
                    if (it)
                        allowMount = it->AllowMount;
                    if (m_caster->IsPlayer() && !allowMount && !m_spellInfo->AreaGroupId)
                        return SPELL_FAILED_NO_MOUNTS_ALLOWED;

                    if (m_caster->IsInDisallowedMountForm())
                        return SPELL_FAILED_NOT_SHAPESHIFT;

                    // xinef: dont allow to cast mounts in specific transforms
                    if (m_caster->getTransForm())
                        if (SpellInfo const* transformSpellInfo = sSpellMgr->GetSpellInfo(m_caster->getTransForm()))
                            if (transformSpellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) &&
                                    !transformSpellInfo->HasAttribute(SpellAttr0(SPELL_ATTR0_ALLOW_WHILE_MOUNTED | SPELL_ATTR0_AURA_IS_DEBUFF)))
                                return SPELL_FAILED_NOT_SHAPESHIFT;

                    break;
                }
            case SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS:
                {
                    if (!m_targets.GetUnitTarget())
                        return SPELL_FAILED_BAD_IMPLICIT_TARGETS;

                    // can be casted at non-friendly unit or own pet/charm
                    if (m_caster->IsFriendlyTo(m_targets.GetUnitTarget()))
                        return SPELL_FAILED_TARGET_FRIENDLY;

                    break;
                }
            case SPELL_AURA_FLY:
            case SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED:
                {
                    // Xinef: added water check
                    if (m_caster->IsInWater())
                        return SPELL_FAILED_ONLY_ABOVEWATER;

                    // not allow cast fly spells if not have req. skills  (all spells is self target)
                    // allow always ghost flight spells
                    if (m_originalCaster && m_originalCaster->IsPlayer() && m_originalCaster->IsAlive())
                    {
                        Battlefield* Bf = sBattlefieldMgr->GetBattlefieldToZoneId(m_originalCaster->GetZoneId());
                        if (AreaTableEntry const* pArea = sAreaTableStore.LookupEntry(m_originalCaster->GetAreaId()))
                            if ((pArea->flags & AREA_FLAG_NO_FLY_ZONE) || (Bf && !Bf->CanFlyIn()))
                                return SPELL_FAILED_NOT_HERE;
                    }
                    break;
                }
            case SPELL_AURA_PERIODIC_MANA_LEECH:
                {
                    if (m_spellInfo->Effects[i].IsTargetingArea())
                        break;

                    if (!m_caster->IsPlayer() || m_CastItem)
                        break;

                    if (!m_targets.GetUnitTarget())
                        return SPELL_FAILED_BAD_IMPLICIT_TARGETS;

                    if (!m_targets.GetUnitTarget()->HasActivePowerType(POWER_MANA))
                        return SPELL_FAILED_BAD_TARGETS;

                    break;
                }
            case SPELL_AURA_HOVER:
                {
                    if ((m_spellInfo->AuraInterruptFlags & AURA_INTERRUPT_FLAG_MOUNT) != 0 && m_targets.GetUnitTarget() && m_targets.GetUnitTarget()->IsMounted())
                    {
                        return SPELL_FAILED_NOT_ON_MOUNTED;
                    }
                    break;
                }
            case SPELL_AURA_MOD_SHAPESHIFT:
                {
                    if (m_caster && m_caster->HasAura(23397)) // Nefarian Class Call (Warrior): Berserk -- Nefertum: I don't really like this but I didn't find another way.
                    {
                        return SPELL_FAILED_NOT_SHAPESHIFT;
                    }
                    break;
                }
            default:
                break;
        }
    }

    // check trade slot case (last, for allow catch any another cast problems)
    if (m_targets.GetTargetMask() & TARGET_FLAG_TRADE_ITEM)
    {
        if (m_CastItem)
            return SPELL_FAILED_ITEM_ENCHANT_TRADE_WINDOW;

        if (!m_caster->IsPlayer())
            return SPELL_FAILED_NOT_TRADING;

        TradeData* my_trade = m_caster->ToPlayer()->GetTradeData();

        if (!my_trade)
            return SPELL_FAILED_NOT_TRADING;

        TradeSlots slot = TradeSlots(m_targets.GetItemTargetGUID().GetRawValue());
        if (slot != TRADE_SLOT_NONTRADED)
            return SPELL_FAILED_BAD_TARGETS;

        if (!IsTriggered())
            if (my_trade->GetSpell())
                return SPELL_FAILED_ITEM_ALREADY_ENCHANTED;
    }

    // check if caster has at least 1 combo point on target for spells that require combo points
    if (m_needComboPoints)
    {
        //npcbot
        if (m_caster->ToCreature() && m_caster->ToCreature()->IsNPCBot())
        {
            if (!m_caster->ToCreature()->GetCreatureComboPoints())
                return SPELL_FAILED_NO_COMBO_POINTS;
        }
        else
        //end npcbot
        if (m_spellInfo->NeedsExplicitUnitTarget())
        {
            if (!m_caster->GetComboPoints(m_targets.GetUnitTarget()))
            {
                return SPELL_FAILED_NO_COMBO_POINTS;
            }
        }
        else
        {
            if (!m_caster->GetComboPoints())
            {
                return SPELL_FAILED_NO_COMBO_POINTS;
            }
        }
    }

    // xinef: check relic cooldown
    if (m_CastItem && m_CastItem->GetTemplate()->InventoryType == INVTYPE_RELIC && m_triggeredByAuraSpell)
        if (m_caster->HasSpellCooldown(SPELL_RELIC_COOLDOWN) && !m_caster->HasSpellItemCooldown(SPELL_RELIC_COOLDOWN, m_CastItem->GetEntry()))
            return SPELL_FAILED_NOT_READY;

    // all ok
    return SPELL_CAST_OK;
}

SpellCastResult Spell::CheckPetCast(Unit* target)
{
    if (m_caster->HasUnitState(UNIT_STATE_CASTING) && !HasTriggeredCastFlag(TRIGGERED_IGNORE_CAST_IN_PROGRESS))              //prevent spellcast interruption by another spellcast
        return SPELL_FAILED_SPELL_IN_PROGRESS;

    // dead owner (pets still alive when owners ressed?)
    if (Unit* owner = m_caster->GetCharmerOrOwner())
        if (!owner->IsAlive() && m_caster->GetEntry() != 30230) // Rise Ally
            return SPELL_FAILED_CASTER_DEAD;

    if (!target && m_targets.GetUnitTarget())
        target = m_targets.GetUnitTarget();

    if (m_spellInfo->NeedsExplicitUnitTarget())
    {
        if (!target)
            return SPELL_FAILED_BAD_IMPLICIT_TARGETS;
        m_targets.SetUnitTarget(target);
    }

    // xinef: Calculate power cost here, so funciton checking power can work properly and dont return bad results
    m_powerCost = m_spellInfo->CalcPowerCost(m_caster, m_spellSchoolMask, this);

    // cooldown
    if (Creature const* creatureCaster = m_caster->ToCreature())
        if (creatureCaster->HasSpellCooldown(m_spellInfo->Id))
            return SPELL_FAILED_NOT_READY;

    // Check if spell is affected by GCD
    if (m_spellInfo->StartRecoveryCategory > 0)
        if (m_caster->GetCharmInfo() && m_caster->GetCharmInfo()->GetGlobalCooldownMgr().HasGlobalCooldown(m_spellInfo))
            return SPELL_FAILED_NOT_READY;

    return CheckCast(true);
}

SpellCastResult Spell::CheckCasterAuras(bool preventionOnly) const
{
    // spells totally immuned to caster auras (wsg flag drop, give marks etc)
    if (m_spellInfo->HasAttribute(SPELL_ATTR6_NOT_AN_ATTACK))
        return SPELL_CAST_OK;

    uint8 school_immune = 0;
    uint32 mechanic_immune = 0;
    uint32 dispel_immune = 0;

    // Check if the spell grants school or mechanic immunity.
    // We use bitmasks so the loop is done only once and not on every aura check below.
    if (m_spellInfo->HasAttribute(SPELL_ATTR1_IMMUNITY_PURGES_EFFECT))
    {
        for (int i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (m_spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_SCHOOL_IMMUNITY)
                school_immune |= uint32(m_spellInfo->Effects[i].MiscValue);
            else if (m_spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MECHANIC_IMMUNITY)
                mechanic_immune |= 1 << uint32(m_spellInfo->Effects[i].MiscValue);
            else if (m_spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_DISPEL_IMMUNITY)
                dispel_immune |= SpellInfo::GetDispelMask(DispelType(m_spellInfo->Effects[i].MiscValue));
        }
        // immune movement impairment and loss of control
        //         PVP trinket                   EMFH                   TOC PVP trinket               Bullheaded                  Bestial Wrath             // Beath Within         // Medalion of Immunity
        if (m_spellInfo->Id == 42292 || m_spellInfo->Id == 59752 || m_spellInfo->Id == 65547 || m_spellInfo->Id == 53490 || m_spellInfo->Id == 19574 || m_spellInfo->Id == 34471 || m_spellInfo->Id == 46227)
            mechanic_immune = IMMUNE_TO_MOVEMENT_IMPAIRMENT_AND_LOSS_CONTROL_MASK;
    }

    bool usableInStun = m_spellInfo->HasAttribute(SPELL_ATTR5_ALLOW_WHILE_STUNNED);

    // Glyph of Pain Suppression
    // there is no other way to handle it
    if (m_spellInfo->Id == 33206 && !m_caster->HasAura(63248))
        usableInStun = false;

    // Check whether the cast should be prevented by any state you might have.
    SpellCastResult prevented_reason = SPELL_CAST_OK;
    // Have to check if there is a stun aura. Otherwise will have problems with ghost aura apply while logging out
    uint32 unitflag = m_caster->GetUnitFlags();     // Get unit state

    // Xinef: if spell is triggered check preventionType only
    if (!preventionOnly)
    {
        if (unitflag & UNIT_FLAG_STUNNED)
        {
            // spell is usable while stunned, check if caster has only mechanic stun auras, another stun types must prevent cast spell
            if (usableInStun)
            {
                bool foundNotStun = false;
                uint32 mask = (1 << MECHANIC_STUN) | (1 << MECHANIC_FREEZE) | (1 << MECHANIC_HORROR);
                // Barkskin should skip sleep effects, sap and fears
                if (m_spellInfo->Id == 22812)
                    mask |= 1 << MECHANIC_SAPPED | 1 << MECHANIC_HORROR | 1 << MECHANIC_SLEEP;
                // Hand of Freedom, can be used while sapped
                if (m_spellInfo->Id == 1044)
                    mask |= 1 << MECHANIC_SAPPED;
                Unit::AuraEffectList const& stunAuras = m_caster->GetAuraEffectsByType(SPELL_AURA_MOD_STUN);
                for (Unit::AuraEffectList::const_iterator i = stunAuras.begin(); i != stunAuras.end(); ++i)
                {
                    if ((*i)->GetSpellInfo()->GetAllEffectsMechanicMask() && !((*i)->GetSpellInfo()->GetAllEffectsMechanicMask() & mask))
                    {
                        foundNotStun = true;
                        break;
                    }
                }
                if (foundNotStun)
                    prevented_reason = SPELL_FAILED_STUNNED;
            }
            else
                prevented_reason = SPELL_FAILED_STUNNED;
        }
        else if (unitflag & UNIT_FLAG_CONFUSED && !m_spellInfo->HasAttribute(SPELL_ATTR5_ALLOW_WHILE_CONFUSED))
            prevented_reason = SPELL_FAILED_CONFUSED;
        else if (unitflag & UNIT_FLAG_FLEEING && !m_spellInfo->HasAttribute(SPELL_ATTR5_ALLOW_WHILE_FLEEING))
            prevented_reason = SPELL_FAILED_FLEEING;
    }

    // Xinef: if there is no prevented_reason, check prevention types
    if (prevented_reason == SPELL_CAST_OK)
    {
        if (unitflag & UNIT_FLAG_SILENCED && m_spellInfo->PreventionType == SPELL_PREVENTION_TYPE_SILENCE)
            prevented_reason = SPELL_FAILED_SILENCED;
        else if (unitflag & UNIT_FLAG_PACIFIED && m_spellInfo->PreventionType == SPELL_PREVENTION_TYPE_PACIFY)
            prevented_reason = SPELL_FAILED_PACIFIED;
    }

    // Attr must make flag drop spell totally immune from all effects
    if (prevented_reason != SPELL_CAST_OK)
    {
        if (school_immune || mechanic_immune || dispel_immune)
        {
            //Checking auras is needed now, because you are prevented by some state but the spell grants immunity.
            Unit::AuraApplicationMap const& auras = m_caster->GetAppliedAuras();
            for (Unit::AuraApplicationMap::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
            {
                Aura const* aura = itr->second->GetBase();
                SpellInfo const* auraInfo = aura->GetSpellInfo();
                if (auraInfo->GetAllEffectsMechanicMask() & mechanic_immune)
                    continue;
                if (auraInfo->GetSchoolMask() & school_immune && !auraInfo->HasAttribute(SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS))
                    continue;
                if (auraInfo->GetDispelMask() & dispel_immune)
                    continue;

                //Make a second check for spell failed so the right SPELL_FAILED message is returned.
                //That is needed when your casting is prevented by multiple states and you are only immune to some of them.
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                {
                    if (AuraEffect* part = aura->GetEffect(i))
                    {
                        switch (part->GetAuraType())
                        {
                            case SPELL_AURA_MOD_STUN:
                                {
                                    uint32 mask = 1 << MECHANIC_STUN;
                                    // Barkskin should skip sleep effects, sap and fears
                                    if (m_spellInfo->Id == 22812)
                                        mask |= 1 << MECHANIC_SAPPED | 1 << MECHANIC_HORROR | 1 << MECHANIC_SLEEP;
                                    // Hand of Freedom, can be used while sapped
                                    if (m_spellInfo->Id == 1044)
                                        mask |= 1 << MECHANIC_SAPPED;

                                    if (!usableInStun || !(auraInfo->GetAllEffectsMechanicMask() & mask))
                                        return SPELL_FAILED_STUNNED;
                                    break;
                                }
                            case SPELL_AURA_MOD_CONFUSE:
                                if (!m_spellInfo->HasAttribute(SPELL_ATTR5_ALLOW_WHILE_CONFUSED))
                                    return SPELL_FAILED_CONFUSED;
                                break;
                            case SPELL_AURA_MOD_FEAR:
                                if (!m_spellInfo->HasAttribute(SPELL_ATTR5_ALLOW_WHILE_FLEEING))
                                    return SPELL_FAILED_FLEEING;
                                break;
                            case SPELL_AURA_MOD_SILENCE:
                            case SPELL_AURA_MOD_PACIFY:
                            case SPELL_AURA_MOD_PACIFY_SILENCE:
                                if (m_spellInfo->PreventionType == SPELL_PREVENTION_TYPE_PACIFY)
                                    return SPELL_FAILED_PACIFIED;
                                else if (m_spellInfo->PreventionType == SPELL_PREVENTION_TYPE_SILENCE)
                                    return SPELL_FAILED_SILENCED;
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
        }
        // You are prevented from casting and the spell casted does not grant immunity. Return a failed error.
        else
            return prevented_reason;
    }
    return SPELL_CAST_OK;
}

bool Spell::CanAutoCast(Unit* target)
{
    ObjectGuid targetguid = target->GetGUID();

    for (uint32 j = 0; j < MAX_SPELL_EFFECTS; ++j)
    {
        if (m_spellInfo->Effects[j].Effect == SPELL_EFFECT_APPLY_AURA)
        {
            if (m_spellInfo->StackAmount <= 1)
            {
                if (target->HasAuraEffect(m_spellInfo->Id, j))
                    return false;
            }
            else
            {
                if (AuraEffect* aureff = target->GetAuraEffect(m_spellInfo->Id, j))
                    if (aureff->GetBase()->GetStackAmount() >= m_spellInfo->StackAmount)
                        return false;
            }
        }
        else if (m_spellInfo->Effects[j].IsAreaAuraEffect())
        {
            if (target->HasAuraEffect(m_spellInfo->Id, j))
                return false;
        }
    }

    SpellCastResult result = CheckPetCast(target);

    if (result == SPELL_CAST_OK || result == SPELL_FAILED_UNIT_NOT_INFRONT)
    {
        SelectSpellTargets();
        //check if among target units, our WANTED target is as well (->only self cast spells return false)
        for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
            if (ihit->targetGUID == targetguid)
                return true;
    }
    return false;                                           //target invalid
}

SpellCastResult Spell::CheckRange(bool strict)
{
    // Don't check for instant cast spells
    if (!strict && m_casttime == 0)
        return SPELL_CAST_OK;

    uint32 range_type = 0;

    if (m_spellInfo->RangeEntry)
    {
        // check needed by 68766 51693 - both spells are cast on enemies and have 0 max range
        // these are triggered by other spells - possibly we should omit range check in that case?
        if (m_spellInfo->RangeEntry->ID == 1)
            return SPELL_CAST_OK;

        range_type = m_spellInfo->RangeEntry->Flags;
    }

    Unit* target = m_targets.GetUnitTarget();
    float max_range = m_caster->GetSpellMaxRangeForTarget(target, m_spellInfo);
    float min_range = m_caster->GetSpellMinRangeForTarget(target, m_spellInfo);

    //npcbot: apply range mods
    if (m_caster->IsNPCBot())
        m_caster->ToCreature()->ApplyCreatureSpellRangeMods(m_spellInfo, max_range);
    //end npcbot

    // xinef: hack for npc shooters
    if (min_range && GetCaster()->IsCreature() && !GetCaster()->GetOwnerGUID().IsPlayer() && min_range <= 6.0f)
        range_type = SPELL_RANGE_RANGED;

    if (Player* modOwner = m_caster->GetSpellModOwner())
        modOwner->ApplySpellMod(m_spellInfo->Id, SPELLMOD_RANGE, max_range, this);

    // xinef: dont check max_range to strictly after cast
    if (range_type != SPELL_RANGE_MELEE && !strict)
        max_range += std::min(3.0f, max_range * 0.1f); // 10% but no more than 3yd

    if (target)
    {
        if (target != m_caster)
        {
            // Xinef: Spells with 5yd range can hit target 9yd away?
            if (range_type == SPELL_RANGE_MELEE)
            {
                float real_max_range = max_range;
                if (!m_caster->IsCreature() && m_caster->isMoving() && target->isMoving() && !m_caster->IsWalking() && !target->IsWalking())
                    real_max_range -= MIN_MELEE_REACH; // Because of lag, we can not check too strictly here (is only used if both caster and target are moving)
                else
                    real_max_range -= 2 * MIN_MELEE_REACH;

                if (!m_caster->IsWithinMeleeRange(target, std::max(real_max_range, 0.0f)))
                    return SPELL_FAILED_OUT_OF_RANGE;
            }
            else if (!m_caster->IsWithinCombatRange(target, max_range))
                return SPELL_FAILED_OUT_OF_RANGE; //0x5A;

            if (m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_RANGED && range_type == SPELL_RANGE_RANGED)
            {
                if (m_caster->IsWithinMeleeRange(target))
                    return SPELL_FAILED_TOO_CLOSE;
            }

            if (m_caster->IsPlayer() && (m_spellInfo->FacingCasterFlags & SPELL_FACING_FLAG_INFRONT) && !m_caster->HasInArc(static_cast<float>(M_PI), target))
                return SPELL_FAILED_UNIT_NOT_INFRONT;
        }

        // Xinef: check min range for self casts
        if (min_range && range_type != SPELL_RANGE_RANGED && m_caster->IsWithinCombatRange(target, min_range)) // skip this check if min_range = 0
            return SPELL_FAILED_TOO_CLOSE;
    }

    if (GameObject* goTarget = m_targets.GetGOTarget())
    {
        //npcbot
        if (!m_caster->IsPlayer())
        {
            if (!goTarget->IsAtInteractDistance(*m_caster, m_spellInfo->GetMaxRange(m_spellInfo->IsPositive())))
                return SPELL_FAILED_OUT_OF_RANGE;
        }
        else
        //end npcbot
        if (!goTarget->IsAtInteractDistance(m_caster->ToPlayer(), m_spellInfo))
        {
            return SPELL_FAILED_OUT_OF_RANGE;
        }
    }

    if (m_targets.HasDst() && !m_targets.HasTraj())
    {
        if (!m_caster->IsWithinDist3d(m_targets.GetDstPos(), max_range))
            return SPELL_FAILED_OUT_OF_RANGE;
        if (min_range && m_caster->IsWithinDist3d(m_targets.GetDstPos(), min_range))
            return SPELL_FAILED_TOO_CLOSE;
    }

    return SPELL_CAST_OK;
}

SpellCastResult Spell::CheckPower()
{
    // item cast not used power
    if (m_CastItem)
        return SPELL_CAST_OK;

    //While .cheat power is enabled dont check if we need power to cast the spell
    if (m_caster->IsPlayer())
    {
        if (m_caster->ToPlayer()->GetCommandStatus(CHEAT_POWER))
        {
            return SPELL_CAST_OK;
        }
    }

    // health as power used - need check health amount
    if (m_spellInfo->PowerType == POWER_HEALTH)
    {
        if (int32(m_caster->GetHealth()) <= m_powerCost)
            return SPELL_FAILED_CASTER_AURASTATE;
        return SPELL_CAST_OK;
    }
    // Check valid power type
    if (m_spellInfo->PowerType >= MAX_POWERS)
    {
        LOG_ERROR("spells", "Spell::CheckPower: Unknown power type '{}'", m_spellInfo->PowerType);
        return SPELL_FAILED_UNKNOWN;
    }

    //check rune cost only if a spell has PowerType == POWER_RUNE
    if (m_spellInfo->PowerType == POWER_RUNE)
    {
        SpellCastResult failReason = CheckRuneCost(m_spellInfo->RuneCostID);
        if (failReason != SPELL_CAST_OK)
            return failReason;
    }

    // Check power amount
    Powers PowerType = Powers(m_spellInfo->PowerType);
    if (int32(m_caster->GetPower(PowerType)) < m_powerCost)
        return SPELL_FAILED_NO_POWER;
    else
        return SPELL_CAST_OK;
}

SpellCastResult Spell::CheckItems()
{
    Player* player = m_caster->ToPlayer();
    if (!player)
    {
        // Non-player case: Check if creature is disarmed
        if (!m_caster->CanUseAttackType(m_attackType) && (m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_MELEE || m_spellInfo->DmgClass == SPELL_DAMAGE_CLASS_RANGED))
        {
            return SPELL_FAILED_EQUIPPED_ITEM_CLASS;
        }

        return SPELL_CAST_OK;
    }

    if (!m_CastItem)
    {
        if (m_castItemGUID)
            return SPELL_FAILED_ITEM_NOT_READY;
    }
    else
    {
        uint32 itemid = m_CastItem->GetEntry();
        if (!player->HasItemCount(itemid))
            return SPELL_FAILED_ITEM_NOT_READY;

        ItemTemplate const* proto = m_CastItem->GetTemplate();
        if (!proto)
            return SPELL_FAILED_ITEM_NOT_READY;

        for (int i = 0; i < MAX_ITEM_SPELLS; ++i)
            if (proto->Spells[i].SpellCharges)
                if (m_CastItem->GetSpellCharges(i) == 0)
                    return SPELL_FAILED_NO_CHARGES_REMAIN;

        // consumable cast item checks
        if (proto->Class == ITEM_CLASS_CONSUMABLE && m_targets.GetUnitTarget())
        {
            // such items should only fail if there is no suitable effect at all - see Rejuvenation Potions for example
            SpellCastResult failReason = SPELL_CAST_OK;
            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; i++)
            {
                // skip check, pet not required like checks, and for TARGET_UNIT_PET m_targets.GetUnitTarget() is not the real target but the caster
                if (m_spellInfo->Effects[i].TargetA.GetTarget() == TARGET_UNIT_PET)
                    continue;

                if (m_spellInfo->Effects[i].Effect == SPELL_EFFECT_HEAL)
                {
                    if (m_targets.GetUnitTarget()->IsFullHealth())
                    {
                        failReason = SPELL_FAILED_ALREADY_AT_FULL_HEALTH;
                        continue;
                    }
                    else
                    {
                        failReason = SPELL_CAST_OK;
                        break;
                    }
                }

                // Mana Potion, Rage Potion, Thistle Tea(Rogue), ...
                if (m_spellInfo->Effects[i].Effect == SPELL_EFFECT_ENERGIZE)
                {
                    if (m_spellInfo->Effects[i].MiscValue < 0 || m_spellInfo->Effects[i].MiscValue >= int8(MAX_POWERS))
                    {
                        failReason = SPELL_FAILED_ALREADY_AT_FULL_POWER;
                        continue;
                    }

                    Powers power = Powers(m_spellInfo->Effects[i].MiscValue);
                    if (m_targets.GetUnitTarget()->GetPower(power) == m_targets.GetUnitTarget()->GetMaxPower(power))
                    {
                        failReason = SPELL_FAILED_ALREADY_AT_FULL_POWER;
                        continue;
                    }
                    else
                    {
                        failReason = SPELL_CAST_OK;
                        break;
                    }
                }
            }
            if (failReason != SPELL_CAST_OK)
                return failReason;
        }
    }

    // check target item
    if (m_targets.GetItemTargetGUID())
    {
        if (!m_caster->IsPlayer())
            return SPELL_FAILED_BAD_TARGETS;

        if (!m_targets.GetItemTarget())
            return SPELL_FAILED_ITEM_GONE;

        if (!m_targets.GetItemTarget()->IsFitToSpellRequirements(m_spellInfo))
            return SPELL_FAILED_EQUIPPED_ITEM_CLASS;
    }
    // if not item target then required item must be equipped
    else
    {
        // Xinef: this is not true in my opinion, in eg bladestorm will not be canceled after disarm
        //if (!HasTriggeredCastFlag(TRIGGERED_IGNORE_EQUIPPED_ITEM_REQUIREMENT))
        if (m_caster->IsPlayer() && !m_caster->ToPlayer()->HasItemFitToSpellRequirements(m_spellInfo))
            return SPELL_FAILED_EQUIPPED_ITEM_CLASS;
    }

    // do not take reagents for these item casts
    if (!(m_CastItem && m_CastItem->GetTemplate()->HasFlag(ITEM_FLAG_NO_REAGENT_COST)))
    {
        bool checkReagents = !HasTriggeredCastFlag(TRIGGERED_IGNORE_POWER_AND_REAGENT_COST) && !player->CanNoReagentCast(m_spellInfo);
        // Not own traded item (in trader trade slot) requires reagents even if triggered spell
        if (!checkReagents)
            if (Item* targetItem = m_targets.GetItemTarget())
                if (targetItem->GetOwnerGUID() != m_caster->GetGUID())
                    checkReagents = true;

        // check reagents (ignore triggered spells with reagents processed by original spell) and special reagent ignore case.
        if (checkReagents)
        {
            for (uint32 i = 0; i < MAX_SPELL_REAGENTS; i++)
            {
                if (m_spellInfo->Reagent[i] <= 0)
                    continue;

                uint32 itemid    = m_spellInfo->Reagent[i];
                uint32 itemcount = m_spellInfo->ReagentCount[i];

                // if CastItem is also spell reagent
                if (m_CastItem && m_CastItem->GetEntry() == itemid)
                {
                    ItemTemplate const* proto = m_CastItem->GetTemplate();
                    if (!proto)
                        return SPELL_FAILED_ITEM_NOT_READY;
                    for (int s = 0; s < MAX_ITEM_PROTO_SPELLS; ++s)
                    {
                        // CastItem will be used up and does not count as reagent
                        int32 charges = m_CastItem->GetSpellCharges(s);
                        if (proto->Spells[s].SpellCharges < 0 && std::abs(charges) < 2)
                        {
                            ++itemcount;
                            break;
                        }
                    }
                }
                if (!player->HasItemCount(itemid, itemcount))
                    return SPELL_FAILED_REAGENTS;
            }
        }

        // check totem-item requirements (items presence in inventory)
        uint32 totems = 2;
        for (int i = 0; i < 2; ++i)
        {
            if (m_spellInfo->Totem[i] != 0)
            {
                if (player->HasItemCount(m_spellInfo->Totem[i]))
                {
                    totems -= 1;
                    continue;
                }
            }
            else
                totems -= 1;
        }
        if (totems != 0)
            return SPELL_FAILED_TOTEMS;                         //0x7C

        // Check items for TotemCategory  (items presence in inventory)
        uint32 TotemCategory = 2;
        for (int i = 0; i < 2; ++i)
        {
            if (m_spellInfo->TotemCategory[i] != 0)
            {
                if (player->HasItemTotemCategory(m_spellInfo->TotemCategory[i]))
                {
                    TotemCategory -= 1;
                    continue;
                }
            }
            else
                TotemCategory -= 1;
        }
        if (TotemCategory != 0)
            return SPELL_FAILED_TOTEM_CATEGORY;                 //0x7B
    }

    // special checks for spell effects
    for (int i = 0; i < MAX_SPELL_EFFECTS; i++)
    {
        switch (m_spellInfo->Effects[i].Effect)
        {
            case SPELL_EFFECT_CREATE_ITEM:
            case SPELL_EFFECT_CREATE_ITEM_2:
            {
                // m_targets.GetUnitTarget() means explicit cast, otherwise we dont check for possible equip error
                Unit* target = m_targets.GetUnitTarget() ? m_targets.GetUnitTarget() : player;
                if (target->IsPlayer() && !IsTriggered())
                {
                    // SPELL_EFFECT_CREATE_ITEM_2 differs from SPELL_EFFECT_CREATE_ITEM in that it picks the random item to create from a pool of potential items,
                    // so we need to make sure there is at least one free space in the player's inventory
                    if (m_spellInfo->Effects[i].Effect == SPELL_EFFECT_CREATE_ITEM_2)
                        if (target->ToPlayer()->GetFreeInventorySpace() == 0)
                        {
                            player->SendEquipError(EQUIP_ERR_INVENTORY_FULL, nullptr, nullptr, m_spellInfo->Effects[i].ItemType);
                            return SPELL_FAILED_DONT_REPORT;
                        }

                    if (m_spellInfo->Effects[i].ItemType)
                    {
                        ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(m_spellInfo->Effects[i].ItemType);
                        if (!itemTemplate)
                            return SPELL_FAILED_ITEM_NOT_FOUND;

                        uint32 createCount = std::clamp<uint32>(m_spellInfo->Effects[i].CalcValue(), 1u, itemTemplate->GetMaxStackSize());
                        ItemPosCountVec dest;
                        InventoryResult msg = target->ToPlayer()->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, m_spellInfo->Effects[i].ItemType, createCount);
                        if (msg != EQUIP_ERR_OK)
                        {
                            /// @todo Needs review
                            if (!itemTemplate->ItemLimitCategory)
                            {
                                player->SendEquipError(msg, nullptr, nullptr, m_spellInfo->Effects[i].ItemType);
                                return SPELL_FAILED_DONT_REPORT;
                            }
                            else
                            {
                                // Conjure Food/Water/Refreshment spells
                                if (m_spellInfo->SpellFamilyName != SPELLFAMILY_MAGE || (!(m_spellInfo->SpellFamilyFlags[0] & 0x40000000)))
                                    return SPELL_FAILED_TOO_MANY_OF_ITEM;
                                else if (!(target->ToPlayer()->HasItemCount(m_spellInfo->Effects[i].ItemType)))
                                {
                                    player->SendEquipError(msg, nullptr, nullptr, m_spellInfo->Effects[i].ItemType);
                                    return SPELL_FAILED_DONT_REPORT;
                                }
                                else
                                    player->CastSpell(player, m_spellInfo->Effects[EFFECT_1].CalcValue(), false);        // move this to anywhere

                                return SPELL_FAILED_DONT_REPORT;
                            }
                        }
                    }
                }
                break;
            }
            case SPELL_EFFECT_CREATE_RANDOM_ITEM:
            {
                if (player->GetFreeInventorySpace() == 0)
                {
                    player->SendEquipError(EQUIP_ERR_INVENTORY_FULL, nullptr, nullptr, m_spellInfo->Effects[i].ItemType);
                    return SPELL_FAILED_DONT_REPORT;
                }
                break;
            }
            case SPELL_EFFECT_ENCHANT_ITEM:
                if (m_spellInfo->Effects[i].ItemType && m_targets.GetItemTarget()
                        && (m_targets.GetItemTarget()->IsWeaponVellum() || m_targets.GetItemTarget()->IsArmorVellum()))
                {
                    // cannot enchant vellum for other player
                    if (m_targets.GetItemTarget()->GetOwner() != m_caster)
                        return SPELL_FAILED_NOT_TRADEABLE;
                    // do not allow to enchant vellum from scroll made by vellum-prevent exploit
                    if (m_CastItem && m_CastItem->GetTemplate()->HasFlag(ITEM_FLAG_NO_REAGENT_COST))
                        return SPELL_FAILED_TOTEM_CATEGORY;
                    ItemPosCountVec dest;
                    InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, m_spellInfo->Effects[i].ItemType, 1);
                    if (msg != EQUIP_ERR_OK)
                    {
                        player->SendEquipError(msg, nullptr, nullptr, m_spellInfo->Effects[i].ItemType);
                        return SPELL_FAILED_DONT_REPORT;
                    }
                }
                [[fallthrough]]; /// @todo: Not sure whether the fallthrough was a mistake (forgetting a break) or intended. This should be double-checked.
            case SPELL_EFFECT_ENCHANT_ITEM_PRISMATIC:
                {
                    Item* targetItem = m_targets.GetItemTarget();
                    if (!targetItem)
                        return SPELL_FAILED_ITEM_NOT_FOUND;

                    // xinef: required level has to be checked also! Exploit fix
                    if (targetItem->GetTemplate()->ItemLevel < m_spellInfo->BaseLevel || (targetItem->GetTemplate()->RequiredLevel && targetItem->GetTemplate()->RequiredLevel < m_spellInfo->BaseLevel))
                        return SPELL_FAILED_LOWLEVEL;

                    bool isItemUsable = false;
                    for (uint8 e = 0; e < MAX_ITEM_PROTO_SPELLS; ++e)
                    {
                        ItemTemplate const* proto = targetItem->GetTemplate();
                        if (proto->Spells[e].SpellId && (
                                    proto->Spells[e].SpellTrigger == ITEM_SPELLTRIGGER_ON_USE ||
                                    proto->Spells[e].SpellTrigger == ITEM_SPELLTRIGGER_ON_NO_DELAY_USE))
                        {
                            isItemUsable = true;
                            break;
                        }
                    }

                    SpellItemEnchantmentEntry const* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(m_spellInfo->Effects[i].MiscValue);
                    // do not allow adding usable enchantments to items that have use effect already
                    if (enchantEntry)
                    {
                        for (uint8 s = 0; s < MAX_SPELL_ITEM_ENCHANTMENT_EFFECTS; ++s)
                        {
                            switch (enchantEntry->type[s])
                            {
                                case ITEM_ENCHANTMENT_TYPE_USE_SPELL:
                                    if (isItemUsable)
                                        return SPELL_FAILED_ON_USE_ENCHANT;
                                    break;
                                case ITEM_ENCHANTMENT_TYPE_PRISMATIC_SOCKET:
                                    {
                                        uint32 numSockets = 0;
                                        for (uint32 socket = 0; socket < MAX_ITEM_PROTO_SOCKETS; ++socket)
                                            if (targetItem->GetTemplate()->Socket[socket].Color)
                                                ++numSockets;

                                        if (numSockets == MAX_ITEM_PROTO_SOCKETS || targetItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT))
                                            return SPELL_FAILED_MAX_SOCKETS;
                                        break;
                                    }
                            }
                        }
                    }

                    // Not allow enchant in trade slot for some enchant type
                    if (targetItem->GetOwner() != m_caster)
                    {
                        if (!enchantEntry)
                            return SPELL_FAILED_ERROR;
                        if (enchantEntry->slot & ENCHANTMENT_CAN_SOULBOUND)
                            return SPELL_FAILED_NOT_TRADEABLE;
                    }
                    break;
                }
            case SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY:
                {
                    Item* item = m_targets.GetItemTarget();
                    if (!item)
                        return SPELL_FAILED_ITEM_NOT_FOUND;
                    // Not allow enchant in trade slot for some enchant type
                    if (item->GetOwner() != m_caster)
                    {
                        uint32 enchant_id = m_spellInfo->Effects[i].MiscValue;
                        SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(enchant_id);
                        if (!pEnchant)
                            return SPELL_FAILED_ERROR;
                        if (pEnchant->slot & ENCHANTMENT_CAN_SOULBOUND)
                            return SPELL_FAILED_NOT_TRADEABLE;
                    }

                    // Xinef: Apply item level restriction if the enchanting spell has max level restrition set
                    if (m_CastItem && m_spellInfo->MaxLevel > 0)
                    {
                        if (item->GetTemplate()->ItemLevel < m_CastItem->GetTemplate()->RequiredLevel)
                            return SPELL_FAILED_LOWLEVEL;
                        if (item->GetTemplate()->ItemLevel > m_spellInfo->MaxLevel)
                            return SPELL_FAILED_HIGHLEVEL;
                    }

                    break;
                }
            case SPELL_EFFECT_ENCHANT_HELD_ITEM:
                // check item existence in effect code (not output errors at offhand hold item effect to main hand for example
                break;
            case SPELL_EFFECT_DISENCHANT:
                {
                    if (!m_targets.GetItemTarget())
                        return SPELL_FAILED_CANT_BE_DISENCHANTED;

                    // prevent disenchanting in trade slot
                    if (m_targets.GetItemTarget()->GetOwnerGUID() != m_caster->GetGUID())
                        return SPELL_FAILED_CANT_BE_DISENCHANTED;

                    ItemTemplate const* itemProto = m_targets.GetItemTarget()->GetTemplate();
                    if (!itemProto)
                        return SPELL_FAILED_CANT_BE_DISENCHANTED;

                    uint32 item_quality = itemProto->Quality;
                    // 2.0.x addon: Check player enchanting level against the item disenchanting requirements
                    uint32 item_disenchantskilllevel = itemProto->RequiredDisenchantSkill;
                    if (item_disenchantskilllevel == uint32(-1))
                        return SPELL_FAILED_CANT_BE_DISENCHANTED;
                    if (item_disenchantskilllevel > player->GetSkillValue(SKILL_ENCHANTING))
                        return SPELL_FAILED_LOW_CASTLEVEL;
                    if (item_quality > 4 || item_quality < 2)
                        return SPELL_FAILED_CANT_BE_DISENCHANTED;
                    if (itemProto->Class != ITEM_CLASS_WEAPON && itemProto->Class != ITEM_CLASS_ARMOR)
                        return SPELL_FAILED_CANT_BE_DISENCHANTED;
                    if (!itemProto->DisenchantID)
                        return SPELL_FAILED_CANT_BE_DISENCHANTED;
                    break;
                }
            case SPELL_EFFECT_PROSPECTING:
                {
                    if (!m_targets.GetItemTarget())
                        return SPELL_FAILED_CANT_BE_PROSPECTED;
                    //ensure item is a prospectable ore
                    if (!(m_targets.GetItemTarget()->GetTemplate()->HasFlag(ITEM_FLAG_IS_PROSPECTABLE)))
                        return SPELL_FAILED_CANT_BE_PROSPECTED;
                    //prevent prospecting in trade slot
                    if (m_targets.GetItemTarget()->GetOwnerGUID() != m_caster->GetGUID())
                        return SPELL_FAILED_CANT_BE_PROSPECTED;
                    //Check for enough skill in jewelcrafting
                    uint32 item_prospectingskilllevel = m_targets.GetItemTarget()->GetTemplate()->RequiredSkillRank;
                    if (item_prospectingskilllevel > player->GetSkillValue(SKILL_JEWELCRAFTING))
                        return SPELL_FAILED_LOW_CASTLEVEL;
                    //make sure the player has the required ores in inventory
                    if (m_targets.GetItemTarget()->GetCount() < 5)
                        return SPELL_FAILED_NEED_MORE_ITEMS;

                    if (!LootTemplates_Prospecting.HaveLootFor(m_targets.GetItemTargetEntry()))
                        return SPELL_FAILED_CANT_BE_PROSPECTED;

                    break;
                }
            case SPELL_EFFECT_MILLING:
                {
                    if (!m_targets.GetItemTarget())
                        return SPELL_FAILED_CANT_BE_MILLED;
                    //ensure item is a millable herb
                    if (!(m_targets.GetItemTarget()->GetTemplate()->HasFlag(ITEM_FLAG_IS_MILLABLE)))
                        return SPELL_FAILED_CANT_BE_MILLED;
                    //prevent milling in trade slot
                    if (m_targets.GetItemTarget()->GetOwnerGUID() != m_caster->GetGUID())
                        return SPELL_FAILED_CANT_BE_MILLED;
                    //Check for enough skill in inscription
                    uint32 item_millingskilllevel = m_targets.GetItemTarget()->GetTemplate()->RequiredSkillRank;
                    if (item_millingskilllevel > player->GetSkillValue(SKILL_INSCRIPTION))
                        return SPELL_FAILED_LOW_CASTLEVEL;
                    //make sure the player has the required herbs in inventory
                    if (m_targets.GetItemTarget()->GetCount() < 5)
                        return SPELL_FAILED_NEED_MORE_ITEMS;

                    if (!LootTemplates_Milling.HaveLootFor(m_targets.GetItemTargetEntry()))
                        return SPELL_FAILED_CANT_BE_MILLED;

                    break;
                }
            case SPELL_EFFECT_WEAPON_DAMAGE:
            case SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL:
                {
                    if (!m_caster->IsPlayer())
                        return SPELL_FAILED_TARGET_NOT_PLAYER;

                    if (m_attackType != RANGED_ATTACK)
                        break;

                    Item* pItem = m_caster->ToPlayer()->GetWeaponForAttack(m_attackType);
                    if (!pItem || pItem->IsBroken())
                        return SPELL_FAILED_EQUIPPED_ITEM;

                    switch (pItem->GetTemplate()->SubClass)
                    {
                        case ITEM_SUBCLASS_WEAPON_THROWN:
                            {
                                uint32 ammo = pItem->GetEntry();
                                if (!m_caster->ToPlayer()->HasItemCount(ammo))
                                    return SPELL_FAILED_NO_AMMO;
                            };
                            break;
                        case ITEM_SUBCLASS_WEAPON_GUN:
                        case ITEM_SUBCLASS_WEAPON_BOW:
                        case ITEM_SUBCLASS_WEAPON_CROSSBOW:
                            {
                                uint32 ammo = m_caster->ToPlayer()->GetUInt32Value(PLAYER_AMMO_ID);
                                if (!ammo)
                                {
                                    // Requires No Ammo
                                    if (m_caster->HasAura(46699))
                                        break;                      // skip other checks

                                    return SPELL_FAILED_NO_AMMO;
                                }

                                ItemTemplate const* ammoProto = sObjectMgr->GetItemTemplate(ammo);
                                if (!ammoProto)
                                    return SPELL_FAILED_NO_AMMO;

                                if (ammoProto->Class != ITEM_CLASS_PROJECTILE)
                                    return SPELL_FAILED_NO_AMMO;

                                // check ammo ws. weapon compatibility
                                switch (pItem->GetTemplate()->SubClass)
                                {
                                    case ITEM_SUBCLASS_WEAPON_BOW:
                                    case ITEM_SUBCLASS_WEAPON_CROSSBOW:
                                        if (ammoProto->SubClass != ITEM_SUBCLASS_ARROW)
                                            return SPELL_FAILED_NO_AMMO;
                                        break;
                                    case ITEM_SUBCLASS_WEAPON_GUN:
                                        if (ammoProto->SubClass != ITEM_SUBCLASS_BULLET)
                                            return SPELL_FAILED_NO_AMMO;
                                        break;
                                    default:
                                        return SPELL_FAILED_NO_AMMO;
                                }

                                if (!m_caster->ToPlayer()->HasItemCount(ammo))
                                {
                                    m_caster->ToPlayer()->SetUInt32Value(PLAYER_AMMO_ID, 0);
                                    return SPELL_FAILED_NO_AMMO;
                                }
                            };
                            break;
                        case ITEM_SUBCLASS_WEAPON_WAND:
                            break;
                        default:
                            break;
                    }
                    break;
                }
            case SPELL_EFFECT_CREATE_MANA_GEM:
                {
                    uint32 item_id = m_spellInfo->Effects[i].ItemType;
                    ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(item_id);

                    if (!pProto)
                        return SPELL_FAILED_ITEM_AT_MAX_CHARGES;

                    if (Item* pitem = player->GetItemByEntry(item_id))
                    {
                        for (int x = 0; x < MAX_ITEM_PROTO_SPELLS; ++x)
                            if (pProto->Spells[x].SpellCharges != 0 && pitem->GetSpellCharges(x) == pProto->Spells[x].SpellCharges)
                                return SPELL_FAILED_ITEM_AT_MAX_CHARGES;
                    }
                    break;
                }
            default:
                break;
        }
    }

    // check weapon presence in slots for main/offhand weapons
    if (/*never skip those checks !HasTriggeredCastFlag(TRIGGERED_IGNORE_EQUIPPED_ITEM_REQUIREMENT) &&*/ m_spellInfo->EquippedItemClass >= 0)
    {
        // main hand weapon required
        if (m_spellInfo->HasAttribute(SPELL_ATTR3_REQUIRES_MAIN_HAND_WEAPON))
        {
            Item* item = m_caster->ToPlayer()->GetWeaponForAttack(BASE_ATTACK);

            // skip spell if no weapon in slot or broken
            if (!item || item->IsBroken())
                return SPELL_FAILED_EQUIPPED_ITEM_CLASS_MAINHAND;

            // skip spell if weapon not fit to triggered spell
            if (!item->IsFitToSpellRequirements(m_spellInfo))
                return SPELL_FAILED_EQUIPPED_ITEM_CLASS_MAINHAND;
        }

        // offhand hand weapon required
        if (m_spellInfo->HasAttribute(SPELL_ATTR3_REQUIRES_OFF_HAND_WEAPON))
        {
            Item* item = m_caster->ToPlayer()->GetWeaponForAttack(OFF_ATTACK);

            // skip spell if no weapon in slot or broken
            if (!item || item->IsBroken())
                return SPELL_FAILED_EQUIPPED_ITEM_CLASS_OFFHAND;

            // skip spell if weapon not fit to triggered spell
            if (!item->IsFitToSpellRequirements(m_spellInfo))
                return SPELL_FAILED_EQUIPPED_ITEM_CLASS_OFFHAND;
        }

        m_weaponItem = m_caster->ToPlayer()->GetWeaponForAttack(m_attackType, true);
    }

    return SPELL_CAST_OK;
}

SpellCastResult Spell::CheckSpellFocus()
{
    // check spell focus object
    if (m_spellInfo->RequiresSpellFocus)
    {
        CellCoord p(Acore::ComputeCellCoord(m_caster->GetPositionX(), m_caster->GetPositionY()));
        Cell cell(p);

        GameObject* ok = nullptr;
        Acore::GameObjectFocusCheck go_check(m_caster, m_spellInfo->RequiresSpellFocus);
        Acore::GameObjectSearcher<Acore::GameObjectFocusCheck> checker(m_caster, ok, go_check);

        TypeContainerVisitor<Acore::GameObjectSearcher<Acore::GameObjectFocusCheck>, GridTypeMapContainer > object_checker(checker);
        Map& map = *m_caster->GetMap();
        cell.Visit(p, object_checker, map, *m_caster, m_caster->GetVisibilityRange());

        if (!ok)
            return SPELL_FAILED_REQUIRES_SPELL_FOCUS;

        focusObject = ok;                                   // game object found in range
    }
    return SPELL_CAST_OK;
}

void Spell::Delayed() // only called in DealDamage()
{
    if (!m_caster)// || !m_caster->IsPlayer())
        return;

    //if (m_spellState == SPELL_STATE_DELAYED)
    //    return;                                             // spell is active and can't be time-backed

    if (isDelayableNoMore())                                 // Spells may only be delayed twice
        return;

    if (m_spellInfo->HasAttribute(SPELL_ATTR6_NO_PUSHBACK))
        return;

    // spells not loosing casting time (slam, dynamites, bombs..)
    //if (!(m_spellInfo->InterruptFlags & SPELL_INTERRUPT_FLAG_DAMAGE))
    //    return;

    //check pushback reduce
    int32 delaytime = 500;                                  // spellcasting delay is normally 500ms
    int32 delayReduce = 100;                                // must be initialized to 100 for percent modifiers
    m_caster->ToPlayer()->ApplySpellMod(m_spellInfo->Id, SPELLMOD_NOT_LOSE_CASTING_TIME, delayReduce, this);
    delayReduce += m_caster->GetTotalAuraModifier(SPELL_AURA_REDUCE_PUSHBACK) - 100;
    if (delayReduce >= 100)
        return;

    AddPct(delaytime, -delayReduce);

    if (m_timer + delaytime > m_casttime)
    {
        delaytime = m_casttime - m_timer;
        m_timer = m_casttime;
    }
    else
        m_timer += delaytime;

    LOG_DEBUG("spells", "Spell {} partially interrupted for ({}) ms at damage", m_spellInfo->Id, delaytime);

    WorldPacket data(SMSG_SPELL_DELAYED, 8 + 4);
    data << m_caster->GetPackGUID();
    data << uint32(delaytime);

    m_caster->SendMessageToSet(&data, true);
}

void Spell::DelayedChannel()
{
    if (!m_caster || !m_caster->IsPlayer() || getState() != SPELL_STATE_CASTING)
        return;

    if (isDelayableNoMore())                                    // Spells may only be delayed twice
        return;

    if (m_spellInfo->HasAttribute(SPELL_ATTR6_NO_PUSHBACK))
        return;

    //check pushback reduce
    // should be affected by modifiers, not take the dbc duration.
    int32 duration = ((m_channeledDuration > 0) ? m_channeledDuration : m_spellInfo->GetDuration());

    int32 delaytime = CalculatePct(duration, 25); // channeling delay is normally 25% of its time per hit
    int32 delayReduce = 100;                                    // must be initialized to 100 for percent modifiers
    m_caster->ToPlayer()->ApplySpellMod(m_spellInfo->Id, SPELLMOD_NOT_LOSE_CASTING_TIME, delayReduce, this);
    delayReduce += m_caster->GetTotalAuraModifier(SPELL_AURA_REDUCE_PUSHBACK) - 100;
    if (delayReduce >= 100)
        return;

    AddPct(delaytime, -delayReduce);

    if (m_timer <= delaytime)
    {
        delaytime = m_timer;
        m_timer = 0;
    }
    else
        m_timer -= delaytime;

    LOG_DEBUG("spells.aura", "Spell {} partially interrupted for {} ms, new duration: {} ms", m_spellInfo->Id, delaytime, m_timer);

    for (std::list<TargetInfo>::const_iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
        if ((*ihit).missCondition == SPELL_MISS_NONE)
            if (Unit* unit = (m_caster->GetGUID() == ihit->targetGUID) ? m_caster : ObjectAccessor::GetUnit(*m_caster, ihit->targetGUID))
                unit->DelayOwnedAuras(m_spellInfo->Id, m_originalCasterGUID, delaytime);

    // partially interrupt persistent area auras
    if (DynamicObject* dynObj = m_caster->GetDynObject(m_spellInfo->Id))
        dynObj->Delay(delaytime);

    SendChannelUpdate(m_timer);
}

bool Spell::UpdatePointers()
{
    if (m_originalCasterGUID == m_caster->GetGUID())
        m_originalCaster = m_caster;
    else
    {
        m_originalCaster = ObjectAccessor::GetUnit(*m_caster, m_originalCasterGUID);
        if (m_originalCaster && !m_originalCaster->IsInWorld())
            m_originalCaster = nullptr;
    }

    if (m_castItemGUID && m_caster->IsPlayer())
    {
        m_CastItem = m_caster->ToPlayer()->GetItemByGuid(m_castItemGUID);
        // cast item not found, somehow the item is no longer where we expected
        if (!m_CastItem)
            return false;
    }
    else
    //npcbot
    if (!m_caster->IsNPCBot())
    //end npcbot
        m_CastItem = nullptr;

    m_targets.Update(m_caster);

    // further actions done only for dest targets
    if (!m_targets.HasDst())
        return true;

    // cache last transport
    WorldObject* transport = nullptr;

    // update effect destinations (in case of moved transport dest target)
    for (uint8 effIndex = 0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
    {
        SpellDestination& dest = m_destTargets[effIndex];
        if (!dest._transportGUID)
            continue;

        if (!transport || transport->GetGUID() != dest._transportGUID)
            transport = ObjectAccessor::GetWorldObject(*m_caster, dest._transportGUID);

        if (transport)
        {
            dest._position.Relocate(transport);
            dest._position.RelocateOffset(dest._transportOffset);
        }
    }

    return true;
}

CurrentSpellTypes Spell::GetCurrentContainer() const
{
    if (IsNextMeleeSwingSpell())
        return(CURRENT_MELEE_SPELL);
    else if (IsAutoRepeat())
        return(CURRENT_AUTOREPEAT_SPELL);
    else if (m_spellInfo->IsChanneled())
        return(CURRENT_CHANNELED_SPELL);
    else
        return(CURRENT_GENERIC_SPELL);
}

bool Spell::CheckEffectTarget(Unit const* target, uint32 eff) const
{
    switch (m_spellInfo->Effects[eff].ApplyAuraName)
    {
        case SPELL_AURA_MOD_POSSESS:
        case SPELL_AURA_MOD_CHARM:
        case SPELL_AURA_MOD_POSSESS_PET:
        case SPELL_AURA_AOE_CHARM:
            if (target->IsCreature() && target->IsVehicle())
                return false;
            if (target->IsMounted())
                return false;
            if (target->GetCharmerGUID())
                return false;
            if (int32 damage = CalculateSpellDamage(eff, target))
                if ((int32)target->GetLevel() > damage)
                    return false;
            break;
        default:
            break;
    }

    // xinef: skip los checking if spell has appropriate attribute, or target requires specific entry
    // this is only for target addition and target has to have unselectable flag, this is valid for FLAG_EXTRA_TRIGGER and quest triggers however there are some without this flag, used not_selectable
    if (m_spellInfo->HasAttribute(SPELL_ATTR2_IGNORE_LINE_OF_SIGHT) || (target->IsCreature() && target->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE) && (m_spellInfo->Effects[eff].TargetA.GetCheckType() == TARGET_CHECK_ENTRY || m_spellInfo->Effects[eff].TargetB.GetCheckType() == TARGET_CHECK_ENTRY)))
        return true;

     // if spell is triggered, need to check for LOS disable on the aura triggering it and inherit that behaviour
    if (IsTriggered() && m_triggeredByAuraSpell && (m_triggeredByAuraSpell.spellInfo->HasAttribute(SPELL_ATTR2_IGNORE_LINE_OF_SIGHT) ||
        DisableMgr::IsDisabledFor(DISABLE_TYPE_SPELL, m_triggeredByAuraSpell.spellInfo->Id, nullptr, SPELL_DISABLE_LOS)))
    {
        return true;
    }

    /// @todo: below shouldn't be here, but it's temporary
    //Check targets for LOS visibility (except spells without range limitations)
    switch (m_spellInfo->Effects[eff].Effect)
    {
        case SPELL_EFFECT_RESURRECT_NEW:
            // player far away, maybe his corpse near?
            if (target != m_caster && !target->IsWithinLOSInMap(m_caster))
            {
                if (!m_targets.GetCorpseTargetGUID())
                    return false;

                Corpse* corpse = ObjectAccessor::GetCorpse(*m_caster, m_targets.GetCorpseTargetGUID());
                if (!corpse)
                    return false;

                if (target->GetGUID() != corpse->GetOwnerGUID())
                    return false;

                if (!corpse->IsWithinLOSInMap(m_caster) && !(m_spellFlags & SPELL_FLAG_REDIRECTED))
                    return false;
            }
            break;
        case SPELL_EFFECT_SKIN_PLAYER_CORPSE:
            {
                if (!m_targets.GetCorpseTargetGUID())
                {
                    if (target->IsWithinLOSInMap(m_caster, VMAP::ModelIgnoreFlags::M2) && target->HasUnitFlag(UNIT_FLAG_SKINNABLE))
                        return true;

                    return false;
                }

                Corpse* corpse = ObjectAccessor::GetCorpse(*m_caster, m_targets.GetCorpseTargetGUID());
                if (!corpse)
                    return false;

                if (target->GetGUID() != corpse->GetOwnerGUID())
                    return false;

                if (!corpse->HasFlag(CORPSE_FIELD_FLAGS, CORPSE_FLAG_LOOTABLE))
                    return false;

                if (!corpse->IsWithinLOSInMap(m_caster, VMAP::ModelIgnoreFlags::M2))
                    return false;
            }
            break;
        case SPELL_EFFECT_SUMMON_RAF_FRIEND:
            if (!m_caster->IsPlayer() || !target->IsPlayer())
                return false;
            if (m_caster->ToPlayer()->GetSession()->IsARecruiter() && target->ToPlayer()->GetSession()->GetRecruiterId() != m_caster->ToPlayer()->GetSession()->GetAccountId())
                return false;
            if (m_caster->ToPlayer()->GetSession()->GetRecruiterId() != target->ToPlayer()->GetSession()->GetAccountId() && target->ToPlayer()->GetSession()->IsARecruiter())
                return false;
            if (target->ToPlayer()->GetLevel() >= sWorld->getIntConfig(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL))
                return false;
            break;
        default: // normal case
        {
            uint32 losChecks = LINEOFSIGHT_ALL_CHECKS;
            GameObject* gobCaster = nullptr;
            if (m_originalCasterGUID.IsGameObject())
            {
                gobCaster = m_caster->GetMap()->GetGameObject(m_originalCasterGUID);
            }
            else if (m_caster->GetEntry() == WORLD_TRIGGER)
            {
                if (TempSummon* tempSummon = m_caster->ToTempSummon())
                {
                    gobCaster = tempSummon->GetSummonerGameObject();
                }
            }

            if (gobCaster)
            {
                if (gobCaster->GetGOInfo()->IsIgnoringLOSChecks())
                {
                    return true;
                }

                // If spell casted by gameobject then ignore M2 models
                losChecks &= ~LINEOFSIGHT_CHECK_GOBJECT_M2;
            }

            if (target != m_caster)
            {
                if (m_targets.HasDst())
                {
                    float x = m_targets.GetDstPos()->GetPositionX();
                    float y = m_targets.GetDstPos()->GetPositionY();
                    float z = m_targets.GetDstPos()->GetPositionZ();

                    if (!target->IsWithinLOS(x, y, z, VMAP::ModelIgnoreFlags::M2, LineOfSightChecks(losChecks)))
                    {
                        return false;
                    }
                }
                else if (!m_caster->IsWithinLOSInMap(target, VMAP::ModelIgnoreFlags::M2, LineOfSightChecks(losChecks)))
                {
                    return false;
                }
            }
            break;
        }
    }

    return true;
}

bool Spell::IsNextMeleeSwingSpell() const
{
    return m_spellInfo->HasAttribute(SPELL_ATTR0_ON_NEXT_SWING_NO_DAMAGE);
}

bool Spell::IsIgnoringCooldowns() const
{
    return HasTriggeredCastFlag(TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD) != 0;
}

bool Spell::IsAutoActionResetSpell() const
{
    /// @todo changed SPELL_INTERRUPT_FLAG_AUTOATTACK -> SPELL_INTERRUPT_FLAG_INTERRUPT to fix compile - is this check correct at all?
    if (IsTriggered() || !(m_spellInfo->InterruptFlags & SPELL_INTERRUPT_FLAG_INTERRUPT))
    {
        return false;
    }

    if (!m_casttime && m_spellInfo->HasAttribute(SPELL_ATTR6_DOESNT_RESET_SWING_TIMER_IF_INSTANT))
    {
        return false;
    }

    return true;
}

bool Spell::IsNeedSendToClient(bool go) const
{
    if (HasTriggeredCastFlag(TRIGGERED_IGNORE_EFFECTS))
        return false;

    return m_spellInfo->SpellVisual[0] || m_spellInfo->SpellVisual[1] || m_spellInfo->IsChanneled() ||
           m_spellInfo->Speed > 0.0f || (!m_triggeredByAuraSpell && !IsTriggered()) ||
           (go && m_triggeredByAuraSpell && m_triggeredByAuraSpell.spellInfo->IsChanneled());
}

bool Spell::HaveTargetsForEffect(uint8 effect) const
{
    for (std::list<TargetInfo>::const_iterator itr = m_UniqueTargetInfo.begin(); itr != m_UniqueTargetInfo.end(); ++itr)
        if (itr->effectMask & (1 << effect))
            return true;

    for (std::list<GOTargetInfo>::const_iterator itr = m_UniqueGOTargetInfo.begin(); itr != m_UniqueGOTargetInfo.end(); ++itr)
        if (itr->effectMask & (1 << effect))
            return true;

    for (std::list<ItemTargetInfo>::const_iterator itr = m_UniqueItemInfo.begin(); itr != m_UniqueItemInfo.end(); ++itr)
        if (itr->effectMask & (1 << effect))
            return true;

    return false;
}

SpellEvent::SpellEvent(Spell* spell) : BasicEvent()
{
    m_Spell = spell;
}

SpellEvent::~SpellEvent()
{
    if (m_Spell->getState() != SPELL_STATE_FINISHED)
        m_Spell->cancel();

    if (m_Spell->IsDeletable())
    {
        delete m_Spell;
    }
    else
    {
        LOG_ERROR("spells", "~SpellEvent: {} {} tried to delete non-deletable spell {}. Was not deleted, causes memory leak.",
                       (m_Spell->GetCaster()->IsPlayer() ? "Player" : "Creature"), m_Spell->GetCaster()->GetGUID().ToString(), m_Spell->m_spellInfo->Id);
        ABORT();
    }
}

bool SpellEvent::Execute(uint64 e_time, uint32 p_time)
{
    // update spell if it is not finished
    if (m_Spell->getState() != SPELL_STATE_FINISHED)
        m_Spell->update(p_time);

    // check spell state to process
    switch (m_Spell->getState())
    {
        case SPELL_STATE_FINISHED:
            {
                // spell was finished, check deletable state
                if (m_Spell->IsDeletable())
                {
                    // check, if we do have unfinished triggered spells
                    return true;                                // spell is deletable, finish event
                }
                // event will be re-added automatically at the end of routine)
            }
            break;

        case SPELL_STATE_DELAYED:
            {
                // first, check, if we have just started
                if (m_Spell->GetDelayStart() != 0)
                {
                    {
                        // run the spell handler and think about what we can do next
                        uint64 t_offset = e_time - m_Spell->GetDelayStart();
                        uint64 n_offset = m_Spell->handle_delayed(t_offset);
                        if (n_offset)
                        {
                            // re-add us to the queue
                            m_Spell->GetCaster()->m_Events.AddEvent(this, m_Spell->GetDelayStart() + n_offset, false);
                            return false;                       // event not complete
                        }
                        // event complete
                        // finish update event will be re-added automatically at the end of routine)
                    }
                }
                else
                {
                    // delaying had just started, record the moment
                    m_Spell->SetDelayStart(e_time);
                    // re-plan the event for the delay moment
                    m_Spell->GetCaster()->m_Events.AddEvent(this, e_time + m_Spell->GetDelayMoment(), false);
                    return false;                               // event not complete
                }
            }
            break;

        default:
            {
                // all other states
                // event will be re-added automatically at the end of routine)
            } break;
    }

    // spell processing not complete, plan event on the next update interval
    m_Spell->GetCaster()->m_Events.AddEvent(this, e_time + 1, false);
    return false;                                           // event not complete
}

void SpellEvent::Abort(uint64 /*e_time*/)
{
    // oops, the spell we try to do is aborted
    if (m_Spell->getState() != SPELL_STATE_FINISHED)
        m_Spell->cancel();
}

bool SpellEvent::IsDeletable() const
{
    return m_Spell->IsDeletable();
}

bool ReflectEvent::Execute(uint64  /*e_time*/, uint32  /*p_time*/)
{
    Unit* target = ObjectAccessor::GetUnit(*_caster, _targetGUID);
    if (target && _caster->IsInMap(target))
        Unit::ProcDamageAndSpell(_caster, target, PROC_FLAG_NONE, PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG, PROC_EX_REFLECT, 1, BASE_ATTACK, _spellInfo);
    return true;
}

bool Spell::IsValidDeadOrAliveTarget(Unit const* target) const
{
    if (target->IsAlive())
        return !m_spellInfo->IsRequiringDeadTarget();

    return m_spellInfo->IsAllowingDeadTarget();
}

void Spell::HandleLaunchPhase()
{
    // handle effects with SPELL_EFFECT_HANDLE_LAUNCH mode
    for (uint32 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        // don't do anything for empty effect
        if (!m_spellInfo->Effects[i].IsEffect())
            continue;

        HandleEffects(nullptr, nullptr, nullptr, i, SPELL_EFFECT_HANDLE_LAUNCH);
    }

    float multiplier[MAX_SPELL_EFFECTS];
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (m_applyMultiplierMask & (1 << i))
            multiplier[i] = m_spellInfo->Effects[i].CalcDamageMultiplier(m_originalCaster, this);

    bool usesAmmo = m_spellInfo->HasAttribute(SPELL_ATTR0_CU_DIRECT_DAMAGE);
    Unit::AuraEffectList const& Auras = m_caster->GetAuraEffectsByType(SPELL_AURA_ABILITY_CONSUME_NO_AMMO);
    for (Unit::AuraEffectList::const_iterator j = Auras.begin(); j != Auras.end(); ++j)
    {
        if ((*j)->IsAffectedOnSpell(m_spellInfo))
            usesAmmo = false;
    }

    PrepareTargetProcessing();

    for (std::list<TargetInfo>::iterator ihit = m_UniqueTargetInfo.begin(); ihit != m_UniqueTargetInfo.end(); ++ihit)
    {
        TargetInfo& target = *ihit;

        uint32 mask = target.effectMask;
        if (!mask)
            continue;

        // do not consume ammo anymore for Hunter's volley spell
        if (IsTriggered() && m_spellInfo->SpellFamilyName == SPELLFAMILY_HUNTER && m_spellInfo->IsTargetingArea())
            usesAmmo = false;

        if (usesAmmo)
        {
            bool ammoTaken = false;
            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; i++)
            {
                if (!(mask & 1 << i))
                    continue;
                switch (m_spellInfo->Effects[i].Effect)
                {
                    case SPELL_EFFECT_SCHOOL_DAMAGE:
                    case SPELL_EFFECT_WEAPON_DAMAGE:
                    case SPELL_EFFECT_WEAPON_DAMAGE_NOSCHOOL:
                    case SPELL_EFFECT_NORMALIZED_WEAPON_DMG:
                    case SPELL_EFFECT_WEAPON_PERCENT_DAMAGE:
                        ammoTaken = true;
                        TakeAmmo();
                }
                if (ammoTaken)
                    break;
            }
        }

        DoAllEffectOnLaunchTarget(target, multiplier);
    }

    FinishTargetProcessing();
}

void Spell::DoAllEffectOnLaunchTarget(TargetInfo& targetInfo, float* multiplier)
{
    Unit* unit = nullptr;
    // In case spell hit target, do all effect on that target
    if (targetInfo.missCondition == SPELL_MISS_NONE)
        unit = m_caster->GetGUID() == targetInfo.targetGUID ? m_caster : ObjectAccessor::GetUnit(*m_caster, targetInfo.targetGUID);
    // In case spell reflect from target, do all effect on caster (if hit)
    else if (targetInfo.missCondition == SPELL_MISS_REFLECT && targetInfo.reflectResult == SPELL_MISS_NONE)
        unit = m_caster;
    if (!unit)
        return;

    for (uint32 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (targetInfo.effectMask & (1 << i))
        {
            m_damage = 0;
            m_healing = 0;

            HandleEffects(unit, nullptr, nullptr, i, SPELL_EFFECT_HANDLE_LAUNCH_TARGET);

            if (m_damage > 0)
            {
                // Xinef: Area Auras, AoE Targetting spells AND Chain Target spells (cleave etc.)
                if (m_spellInfo->Effects[i].IsAreaAuraEffect() || m_spellInfo->Effects[i].IsTargetingArea() || (m_spellInfo->Effects[i].ChainTarget > 1 && m_spellInfo->DmgClass != SPELL_DAMAGE_CLASS_MAGIC))
                {
                    m_damage = unit->CalculateAOEDamageReduction(m_damage, m_spellInfo->SchoolMask, m_caster);
                    if (m_caster->IsPlayer())
                    {
                        uint32 targetAmount = m_UniqueTargetInfo.size();
                        if (targetAmount > 10)
                            m_damage = m_damage * 10 / targetAmount;
                    }
                }
            }

            if (m_applyMultiplierMask & (1 << i))
            {
                m_damage = int32(m_damage * m_damageMultipliers[i]);
                m_damageMultipliers[i] *= multiplier[i];
            }
            targetInfo.damage += m_damage;
        }
    }

    // xinef: totem's inherit owner crit chance and dancing rune weapon
    Unit* caster = m_caster;
    if (m_caster->IsTotem() || m_caster->GetEntry() == 27893)
    {
        if (Unit* owner = m_caster->GetOwner())
            caster = owner;
    }
    else if (m_originalCaster)
        caster = m_originalCaster;

    float critChance = caster->SpellDoneCritChance(unit, m_spellInfo, m_spellSchoolMask, m_attackType, false);
    critChance = unit->SpellTakenCritChance(caster, m_spellInfo, m_spellSchoolMask, critChance, m_attackType, false);
    targetInfo.crit = roll_chance_f(std::max(0.0f, critChance));
}

SpellCastResult Spell::CanOpenLock(uint32 effIndex, uint32 lockId, SkillType& skillId, int32& reqSkillValue, int32& skillValue)
{
    if (!lockId)                                             // possible case for GO and maybe for items.
        return SPELL_CAST_OK;

    // Get LockInfo
    LockEntry const* lockInfo = sLockStore.LookupEntry(lockId);

    if (!lockInfo)
        return SPELL_FAILED_BAD_TARGETS;

    bool reqKey = false;                                    // some locks not have reqs

    for (int j = 0; j < MAX_LOCK_CASE; ++j)
    {
        switch (lockInfo->Type[j])
        {
            // check key item (many fit cases can be)
            case LOCK_KEY_ITEM:
                if (lockInfo->Index[j] && m_CastItem && m_CastItem->GetEntry() == lockInfo->Index[j])
                    return SPELL_CAST_OK;
                reqKey = true;
                break;
            // check key skill (only single first fit case can be)
            case LOCK_KEY_SKILL:
                {
                    reqKey = true;

                    // wrong locktype, skip
                    if (uint32(m_spellInfo->Effects[effIndex].MiscValue) != lockInfo->Index[j])
                        continue;

                    skillId = SkillByLockType(LockType(lockInfo->Index[j]));

                    if (skillId != SKILL_NONE)
                    {
                        reqSkillValue = lockInfo->Skill[j];

                        // castitem check: rogue using skeleton keys. the skill values should not be added in this case.
                        skillValue = m_CastItem || !m_caster->IsPlayer() ?
                                     0 : m_caster->ToPlayer()->GetSkillValue(skillId);

                        //npcbot: use bot skill if cast through gossip
                        if (m_originalCasterGUID)
                            if (Unit const* unit = ObjectAccessor::GetUnit(*m_caster, m_originalCasterGUID))
                                if (unit->GetTypeId() == TYPEID_UNIT && unit->ToCreature()->GetBotClass() == CLASS_ROGUE)
                                    skillValue = std::max<int32>(skillValue, int32(unit->GetLevel() * 5));
                        //end npcbot

                        // skill bonus provided by casting spell (mostly item spells)
                        // add the effect base points modifier from the spell casted (cheat lock / skeleton key etc.)
                        if ((m_spellInfo->Effects[effIndex].TargetA.GetTarget() == TARGET_GAMEOBJECT_ITEM_TARGET || m_spellInfo->Effects[effIndex].TargetB.GetTarget() == TARGET_GAMEOBJECT_ITEM_TARGET)
                            && !m_spellInfo->IsAbilityOfSkillType(SKILL_LOCKPICKING))
                        {
                            skillValue += m_spellInfo->Effects[effIndex].CalcValue();
                        }

                        if (skillValue < reqSkillValue)
                            return SPELL_FAILED_LOW_CASTLEVEL;
                    }

                    return SPELL_CAST_OK;
                }
            case LOCK_KEY_SPELL:
                {
                    if (m_spellInfo->Id == lockInfo->Index[j])
                    {
                        return SPELL_CAST_OK;
                    }
                    reqKey = true;
                    break;
                }
        }
    }

    if (reqKey)
        return SPELL_FAILED_BAD_TARGETS;

    return SPELL_CAST_OK;
}

void Spell::SetSpellValue(SpellValueMod mod, int32 value)
{
    switch (mod)
    {
        case SPELLVALUE_BASE_POINT0:
            m_spellValue->EffectBasePoints[0] = m_spellInfo->Effects[EFFECT_0].CalcBaseValue(value);
            break;
        case SPELLVALUE_BASE_POINT1:
            m_spellValue->EffectBasePoints[1] = m_spellInfo->Effects[EFFECT_1].CalcBaseValue(value);
            break;
        case SPELLVALUE_BASE_POINT2:
            m_spellValue->EffectBasePoints[2] = m_spellInfo->Effects[EFFECT_2].CalcBaseValue(value);
            break;
        case SPELLVALUE_RADIUS_MOD:
            m_spellValue->RadiusMod = (float)value / 10000;
            break;
        case SPELLVALUE_MAX_TARGETS:
            m_spellValue->MaxAffectedTargets = (uint32)value;
            break;
        case SPELLVALUE_AURA_STACK:
            m_spellValue->AuraStackAmount = uint8(value);
            break;
        case SPELLVALUE_AURA_DURATION:
            m_spellValue->AuraDuration = value;
            break;
        case SPELLVALUE_FORCED_CRIT_RESULT:
            m_spellValue->ForcedCritResult = (bool)value;
            break;
    }
}

void Spell::PrepareTargetProcessing()
{
    CheckEffectExecuteData();
}

void Spell::FinishTargetProcessing()
{
    SendLogExecute();
}

void Spell::InitEffectExecuteData(uint8 effIndex)
{
    ASSERT(effIndex < MAX_SPELL_EFFECTS);
    if (!m_effectExecuteData[effIndex])
    {
        m_effectExecuteData[effIndex] = new ByteBuffer(0x20);
        // first dword - target counter
        *m_effectExecuteData[effIndex] << uint32(1);
    }
    else
    {
        // increase target counter by one
        uint32 count = (*m_effectExecuteData[effIndex]).read<uint32>(0);
        (*m_effectExecuteData[effIndex]).put<uint32>(0, ++count);
    }
}

void Spell::CheckEffectExecuteData()
{
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        ASSERT(!m_effectExecuteData[i]);
}

void Spell::LoadScripts()
{
    if (_scriptsLoaded)
        return;
    _scriptsLoaded = true;
    sScriptMgr->CreateSpellScripts(m_spellInfo->Id, m_loadedScripts);
    for (std::list<SpellScript*>::iterator itr = m_loadedScripts.begin(); itr != m_loadedScripts.end();)
    {
        if (!(*itr)->_Load(this))
        {
            std::list<SpellScript*>::iterator bitr = itr;
            ++itr;
            delete (*bitr);
            m_loadedScripts.erase(bitr);
            continue;
        }
        LOG_DEBUG("spells.aura", "Spell::LoadScripts: Script `{}` for spell `{}` is loaded now", (*itr)->_GetScriptName()->c_str(), m_spellInfo->Id);
        (*itr)->Register();
        ++itr;
    }
}

void Spell::CallScriptBeforeCastHandlers()
{
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(SPELL_SCRIPT_HOOK_BEFORE_CAST);
        std::list<SpellScript::CastHandler>::iterator hookItrEnd = (*scritr)->BeforeCast.end(), hookItr = (*scritr)->BeforeCast.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            (*hookItr).Call(*scritr);

        (*scritr)->_FinishScriptCall();
    }
}

void Spell::CallScriptOnCastHandlers()
{
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(SPELL_SCRIPT_HOOK_ON_CAST);
        std::list<SpellScript::CastHandler>::iterator hookItrEnd = (*scritr)->OnCast.end(), hookItr = (*scritr)->OnCast.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            (*hookItr).Call(*scritr);

        (*scritr)->_FinishScriptCall();
    }
}

void Spell::CallScriptAfterCastHandlers()
{
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(SPELL_SCRIPT_HOOK_AFTER_CAST);
        std::list<SpellScript::CastHandler>::iterator hookItrEnd = (*scritr)->AfterCast.end(), hookItr = (*scritr)->AfterCast.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            (*hookItr).Call(*scritr);

        (*scritr)->_FinishScriptCall();
    }
}

SpellCastResult Spell::CallScriptCheckCastHandlers()
{
    SpellCastResult retVal = SPELL_CAST_OK;
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(SPELL_SCRIPT_HOOK_CHECK_CAST);
        std::list<SpellScript::CheckCastHandler>::iterator hookItrEnd = (*scritr)->OnCheckCast.end(), hookItr = (*scritr)->OnCheckCast.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
        {
            SpellCastResult tempResult = (*hookItr).Call(*scritr);
            if (retVal == SPELL_CAST_OK)
                retVal = tempResult;
        }

        (*scritr)->_FinishScriptCall();
    }
    return retVal;
}

void Spell::PrepareScriptHitHandlers()
{
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
        (*scritr)->_InitHit();
}

bool Spell::CallScriptEffectHandlers(SpellEffIndex effIndex, SpellEffectHandleMode mode)
{
    // execute script effect handler hooks and check if effects was prevented
    bool preventDefault = false;
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        std::list<SpellScript::EffectHandler>::iterator effItr, effEndItr;
        SpellScriptHookType hookType;
        switch (mode)
        {
            case SPELL_EFFECT_HANDLE_LAUNCH:
                effItr = (*scritr)->OnEffectLaunch.begin();
                effEndItr = (*scritr)->OnEffectLaunch.end();
                hookType = SPELL_SCRIPT_HOOK_EFFECT_LAUNCH;
                break;
            case SPELL_EFFECT_HANDLE_LAUNCH_TARGET:
                effItr = (*scritr)->OnEffectLaunchTarget.begin();
                effEndItr = (*scritr)->OnEffectLaunchTarget.end();
                hookType = SPELL_SCRIPT_HOOK_EFFECT_LAUNCH_TARGET;
                break;
            case SPELL_EFFECT_HANDLE_HIT:
                effItr = (*scritr)->OnEffectHit.begin();
                effEndItr = (*scritr)->OnEffectHit.end();
                hookType = SPELL_SCRIPT_HOOK_EFFECT_HIT;
                break;
            case SPELL_EFFECT_HANDLE_HIT_TARGET:
                effItr = (*scritr)->OnEffectHitTarget.begin();
                effEndItr = (*scritr)->OnEffectHitTarget.end();
                hookType = SPELL_SCRIPT_HOOK_EFFECT_HIT_TARGET;
                break;
            default:
                ABORT();
                return false;
        }
        (*scritr)->_PrepareScriptCall(hookType);
        for (; effItr != effEndItr; ++effItr)
            // effect execution can be prevented
            if (!(*scritr)->_IsEffectPrevented(effIndex) && (*effItr).IsEffectAffected(m_spellInfo, effIndex))
                (*effItr).Call(*scritr, effIndex);

        if (!preventDefault)
            preventDefault = (*scritr)->_IsDefaultEffectPrevented(effIndex);

        (*scritr)->_FinishScriptCall();
    }
    return preventDefault;
}

void Spell::CallScriptBeforeHitHandlers(SpellMissInfo missInfo)
{
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(SPELL_SCRIPT_HOOK_BEFORE_HIT);
        std::list<SpellScript::BeforeHitHandler>::iterator hookItrEnd = (*scritr)->BeforeHit.end(), hookItr = (*scritr)->BeforeHit.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            (*hookItr).Call(*scritr, missInfo);

        (*scritr)->_FinishScriptCall();
    }
}

void Spell::CallScriptOnHitHandlers()
{
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(SPELL_SCRIPT_HOOK_HIT);
        std::list<SpellScript::HitHandler>::iterator hookItrEnd = (*scritr)->OnHit.end(), hookItr = (*scritr)->OnHit.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            (*hookItr).Call(*scritr);

        (*scritr)->_FinishScriptCall();
    }
}

void Spell::CallScriptAfterHitHandlers()
{
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(SPELL_SCRIPT_HOOK_AFTER_HIT);
        std::list<SpellScript::HitHandler>::iterator hookItrEnd = (*scritr)->AfterHit.end(), hookItr = (*scritr)->AfterHit.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            (*hookItr).Call(*scritr);

        (*scritr)->_FinishScriptCall();
    }
}

void Spell::CallScriptObjectAreaTargetSelectHandlers(std::list<WorldObject*>& targets, SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType)
{
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(SPELL_SCRIPT_HOOK_OBJECT_AREA_TARGET_SELECT);
        std::list<SpellScript::ObjectAreaTargetSelectHandler>::iterator hookItrEnd = (*scritr)->OnObjectAreaTargetSelect.end(), hookItr = (*scritr)->OnObjectAreaTargetSelect.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            if (hookItr->IsEffectAffected(m_spellInfo, effIndex) && targetType.GetTarget() == hookItr->GetTarget())
                hookItr->Call(*scritr, targets);

        (*scritr)->_FinishScriptCall();
    }
}

void Spell::CallScriptObjectTargetSelectHandlers(WorldObject*& target, SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType)
{
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(SPELL_SCRIPT_HOOK_OBJECT_TARGET_SELECT);
        std::list<SpellScript::ObjectTargetSelectHandler>::iterator hookItrEnd = (*scritr)->OnObjectTargetSelect.end(), hookItr = (*scritr)->OnObjectTargetSelect.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            if (hookItr->IsEffectAffected(m_spellInfo, effIndex) && targetType.GetTarget() == hookItr->GetTarget())
                hookItr->Call(*scritr, target);

        (*scritr)->_FinishScriptCall();
    }
}

void Spell::CallScriptDestinationTargetSelectHandlers(SpellDestination& target, SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType)
{
    for (std::list<SpellScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(SPELL_SCRIPT_HOOK_DESTINATION_TARGET_SELECT);
        std::list<SpellScript::DestinationTargetSelectHandler>::iterator hookItrEnd = (*scritr)->OnDestinationTargetSelect.end(), hookItr = (*scritr)->OnDestinationTargetSelect.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            if (hookItr->IsEffectAffected(m_spellInfo, effIndex) && targetType.GetTarget() == hookItr->GetTarget())
                hookItr->Call(*scritr, target);

        (*scritr)->_FinishScriptCall();
    }
}

bool Spell::CheckScriptEffectImplicitTargets(uint32 effIndex, uint32 effIndexToCheck)
{
    // Skip if there are not any script
    if (!m_loadedScripts.size())
        return true;

    for (std::list<SpellScript*>::iterator itr = m_loadedScripts.begin(); itr != m_loadedScripts.end(); ++itr)
    {
        std::list<SpellScript::ObjectTargetSelectHandler>::iterator targetSelectHookEnd = (*itr)->OnObjectTargetSelect.end(), targetSelectHookItr = (*itr)->OnObjectTargetSelect.begin();
        for (; targetSelectHookItr != targetSelectHookEnd; ++targetSelectHookItr)
            if (((*targetSelectHookItr).IsEffectAffected(m_spellInfo, effIndex) && !(*targetSelectHookItr).IsEffectAffected(m_spellInfo, effIndexToCheck)) ||
                    (!(*targetSelectHookItr).IsEffectAffected(m_spellInfo, effIndex) && (*targetSelectHookItr).IsEffectAffected(m_spellInfo, effIndexToCheck)))
                return false;

        std::list<SpellScript::ObjectAreaTargetSelectHandler>::iterator areaTargetSelectHookEnd = (*itr)->OnObjectAreaTargetSelect.end(), areaTargetSelectHookItr = (*itr)->OnObjectAreaTargetSelect.begin();
        for (; areaTargetSelectHookItr != areaTargetSelectHookEnd; ++areaTargetSelectHookItr)
            if (((*areaTargetSelectHookItr).IsEffectAffected(m_spellInfo, effIndex) && !(*areaTargetSelectHookItr).IsEffectAffected(m_spellInfo, effIndexToCheck)) ||
                    (!(*areaTargetSelectHookItr).IsEffectAffected(m_spellInfo, effIndex) && (*areaTargetSelectHookItr).IsEffectAffected(m_spellInfo, effIndexToCheck)))
                return false;
    }
    return true;
}

bool Spell::CanExecuteTriggersOnHit(uint8 effMask, SpellInfo const* triggeredByAura) const
{
    // Relentless strikes, proc only from first effect
    if (triggeredByAura && triggeredByAura->SpellIconID == 559)
        return effMask & (1 << EFFECT_0);

    bool only_on_caster = (triggeredByAura && triggeredByAura->HasAttribute(SPELL_ATTR4_CLASS_TRIGGER_ONLY_ON_TARGET));
    // If triggeredByAura has SPELL_ATTR4_CLASS_TRIGGER_ONLY_ON_TARGET then it can only proc on a casted spell with TARGET_UNIT_CASTER
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if ((effMask & (1 << i)) && (!only_on_caster || (m_spellInfo->Effects[i].TargetA.GetTarget() == TARGET_UNIT_CASTER)))
            return true;
    }
    return effMask;
}

void Spell::PrepareTriggersExecutedOnHit()
{
    /// @todo: move this to scripts
    if (m_spellInfo->SpellFamilyName)
    {
        SpellInfo const* excludeCasterSpellInfo = sSpellMgr->GetSpellInfo(m_spellInfo->ExcludeCasterAuraSpell);
        if (excludeCasterSpellInfo && !excludeCasterSpellInfo->IsPositive())
            m_preCastSpell = m_spellInfo->ExcludeCasterAuraSpell;
        SpellInfo const* excludeTargetSpellInfo = sSpellMgr->GetSpellInfo(m_spellInfo->ExcludeTargetAuraSpell);
        if (excludeTargetSpellInfo && !excludeTargetSpellInfo->IsPositive())
            m_preCastSpell = m_spellInfo->ExcludeTargetAuraSpell;
    }

    /// @todo: move this to scripts
    switch (m_spellInfo->SpellFamilyName)
    {
        case SPELLFAMILY_PALADIN:
            {
                if( m_spellInfo->SpellFamilyFlags[1] & 0x40000000 )
                {
                    Unit::AuraEffectList const& mVindication = m_caster->GetAuraEffectsByType(SPELL_AURA_PROC_TRIGGER_SPELL);
                    for(Unit::AuraEffectList::const_iterator itr = mVindication.begin(); itr != mVindication.end(); ++itr)
                    {
                        if( (*itr)->GetSpellInfo()->Effects[EFFECT_0].TriggerSpell == 26017 )
                        {
                            m_preCastSpell = 26017;
                            break;
                        }
                        else if( (*itr)->GetSpellInfo()->Effects[EFFECT_0].TriggerSpell == 67 )
                            m_preCastSpell = 67;
                    }
                }
                break;
            }
        case SPELLFAMILY_DRUID:
            {
                // Faerie Fire (Feral)
                if( m_spellInfo->Id == 16857 && (m_caster->GetShapeshiftForm() == FORM_BEAR || m_caster->GetShapeshiftForm() == FORM_DIREBEAR) )
                    m_preCastSpell = 60089;

                break;
            }
    }

    // handle SPELL_AURA_ADD_TARGET_TRIGGER auras:
    // save auras which were present on spell caster on cast, to prevent triggered auras from affecting caster
    // and to correctly calculate proc chance when combopoints are present
    Unit::AuraEffectList const& targetTriggers = m_caster->GetAuraEffectsByType(SPELL_AURA_ADD_TARGET_TRIGGER);
    for (Unit::AuraEffectList::const_iterator i = targetTriggers.begin(); i != targetTriggers.end(); ++i)
    {
        if (!(*i)->IsAffectedOnSpell(m_spellInfo))
            continue;
        SpellInfo const* auraSpellInfo = (*i)->GetSpellInfo();
        uint32 auraSpellIdx = (*i)->GetEffIndex();
        if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(auraSpellInfo->Effects[auraSpellIdx].TriggerSpell))
        {
            // calculate the chance using spell base amount, because aura amount is not updated on combo-points change
            // this possibly needs fixing
            int32 auraBaseAmount = (*i)->GetBaseAmount();
            // proc chance is stored in effect amount
            int32 chance = m_caster->CalculateSpellDamage(nullptr, auraSpellInfo, auraSpellIdx, &auraBaseAmount);
            // build trigger and add to the list
            HitTriggerSpell spellTriggerInfo;
            spellTriggerInfo.triggeredSpell = spellInfo;
            spellTriggerInfo.triggeredByAura = auraSpellInfo;
            spellTriggerInfo.triggeredByEffIdx = (*i)->GetEffIndex();
            spellTriggerInfo.chance = chance * (*i)->GetBase()->GetStackAmount();
            m_hitTriggerSpells.push_back(spellTriggerInfo);
        }
    }
}

// Global cooldowns management
enum GCDLimits
{
    MIN_GCD = 1000,
    MAX_GCD = 1500
};

bool Spell::HasGlobalCooldown() const
{
    // Only player or controlled units have global cooldown
    if (m_caster->GetCharmInfo())
        return m_caster->GetCharmInfo()->GetGlobalCooldownMgr().HasGlobalCooldown(m_spellInfo);
    else if (m_caster->IsPlayer())
        return m_caster->ToPlayer()->GetGlobalCooldownMgr().HasGlobalCooldown(m_spellInfo);
    else
        return false;
}

void Spell::TriggerGlobalCooldown()
{
    int32 gcd = m_spellInfo->StartRecoveryTime;
    if (!gcd)
    {
        // Xinef: fix for charmed pet spells with no cooldown info
        if (m_spellInfo->RecoveryTime == 0 && m_spellInfo->CategoryRecoveryTime == 0 && m_caster->GetCharmInfo())
            gcd = MIN_GCD;
        else
            return;
    }

    if (m_caster->IsPlayer())
        if (m_caster->ToPlayer()->GetCommandStatus(CHEAT_COOLDOWN))
            return;

    // Global cooldown can't leave range 1..1.5 secs
    // There are some spells (mostly not casted directly by player) that have < 1 sec and > 1.5 sec global cooldowns
    // but as tests show are not affected by any spell mods.
    if (m_spellInfo->StartRecoveryTime >= MIN_GCD && m_spellInfo->StartRecoveryTime <= MAX_GCD)
    {
        // gcd modifier auras are applied only to own spells and only players have such mods
        if (m_caster->IsPlayer())
            m_caster->ToPlayer()->ApplySpellMod(m_spellInfo->Id, SPELLMOD_GLOBAL_COOLDOWN, gcd, this);

        // Apply haste rating
        if (m_spellInfo->StartRecoveryCategory == 133 && m_spellInfo->StartRecoveryTime == 1500 && m_spellInfo->DmgClass != SPELL_DAMAGE_CLASS_MELEE &&
            m_spellInfo->DmgClass != SPELL_DAMAGE_CLASS_RANGED && !m_spellInfo->HasAttribute(SPELL_ATTR0_USES_RANGED_SLOT) && !m_spellInfo->HasAttribute(SPELL_ATTR0_IS_ABILITY))
        {
            gcd = int32(float(gcd) * m_caster->GetFloatValue(UNIT_MOD_CAST_SPEED));
        }

        if (gcd < MIN_GCD)
            gcd = MIN_GCD;
        else if (gcd > MAX_GCD)
            gcd = MAX_GCD;
    }

    // Only players or controlled units have global cooldown
    if (m_caster->GetCharmInfo())
        m_caster->GetCharmInfo()->GetGlobalCooldownMgr().AddGlobalCooldown(m_spellInfo, gcd);
    else if (m_caster->IsPlayer())
        m_caster->ToPlayer()->GetGlobalCooldownMgr().AddGlobalCooldown(m_spellInfo, gcd);
}

void Spell::CancelGlobalCooldown()
{
    if (!m_spellInfo->StartRecoveryTime)
        return;

    // Cancel global cooldown when interrupting current cast
    if (m_caster->GetCurrentSpell(CURRENT_GENERIC_SPELL) != this)
        return;

    // Only players or controlled units have global cooldown
    if (m_caster->GetCharmInfo())
        m_caster->GetCharmInfo()->GetGlobalCooldownMgr().CancelGlobalCooldown(m_spellInfo);
    else if (m_caster->IsPlayer())
        m_caster->ToPlayer()->GetGlobalCooldownMgr().CancelGlobalCooldown(m_spellInfo);
}

void Spell::OnSpellLaunch()
{
    if (!m_caster || !m_caster->IsInWorld())
        return;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(24390);

    // Make sure the player is sending a valid GO target and lock ID. SPELL_EFFECT_OPEN_LOCK
    // can succeed with a lockId of 0
    if (m_spellInfo->Id == 21651)
    {
        if (GameObject* go = m_targets.GetGOTarget())
        {
            LockEntry const* lockInfo = sLockStore.LookupEntry(go->GetGOInfo()->GetLockId());
            if (lockInfo && lockInfo->Index[1] == LOCKTYPE_SLOW_OPEN)
            {
                Spell* visual = new Spell(m_caster, spellInfo, TRIGGERED_NONE);
                visual->prepare(&m_targets);
            }
        }
    }
}

void TriggeredByAuraSpellData::Init(AuraEffect const* aurEff)
{
    spellInfo = aurEff->GetSpellInfo();
    effectIndex = aurEff->GetEffIndex();
    tickNumber = aurEff->GetTickNumber();
}

std::string Spell::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << std::boolalpha
        << "Id: " << GetSpellInfo()->Id << " OriginalCaster: " << m_originalCasterGUID.ToString()
        << " State: " << getState();
    return sstr.str();
}

namespace Acore
{

    WorldObjectSpellTargetCheck::WorldObjectSpellTargetCheck(Unit* caster, Unit* referer, SpellInfo const* spellInfo,
            SpellTargetCheckTypes selectionType, ConditionList* condList) : _caster(caster), _referer(referer), _spellInfo(spellInfo),
        _targetSelectionType(selectionType), _condList(condList)
    {
        if (condList)
            _condSrcInfo = new ConditionSourceInfo(nullptr, caster);
        else
            _condSrcInfo = nullptr;
    }

    WorldObjectSpellTargetCheck::~WorldObjectSpellTargetCheck()
    {
        if (_condSrcInfo)
            delete _condSrcInfo;
    }

    bool WorldObjectSpellTargetCheck::operator()(WorldObject* target)
    {
        if (_spellInfo->CheckTarget(_caster, target, true) != SPELL_CAST_OK)
            return false;
        Unit* unitTarget = target->ToUnit();
        if (Corpse* corpseTarget = target->ToCorpse())
        {
            // use ofter for party/assistance checks
            if (Player* owner = ObjectAccessor::FindPlayer(corpseTarget->GetOwnerGUID()))
                unitTarget = owner;
            else
                return false;
        }
        if (unitTarget)
        {
            switch (_targetSelectionType)
            {
                case TARGET_CHECK_ENEMY:
                    if (unitTarget->IsTotem())
                        return false;
                    if (!_caster->_IsValidAttackTarget(unitTarget, _spellInfo))
                        return false;
                    break;
                case TARGET_CHECK_ALLY:
                    if (unitTarget->IsTotem())
                        return false;
                    if (!_caster->_IsValidAssistTarget(unitTarget, _spellInfo))
                        return false;
                    break;
                case TARGET_CHECK_PARTY:
                    if (unitTarget->IsTotem())
                        return false;
                    if (!_caster->_IsValidAssistTarget(unitTarget, _spellInfo))
                        return false;
                    if (!_referer->IsInPartyWith(unitTarget))
                        return false;
                    break;
                case TARGET_CHECK_RAID_CLASS:
                    if (_referer->getClass() != unitTarget->getClass())
                        return false;
                    [[fallthrough]];
                case TARGET_CHECK_RAID:
                    if (unitTarget->IsTotem())
                        return false;
                    if (!_caster->_IsValidAssistTarget(unitTarget, _spellInfo))
                        return false;
                    if (!_referer->IsInRaidWith(unitTarget))
                        return false;
                    break;
                case TARGET_CHECK_CORPSE:
                    if (_caster->IsFriendlyTo(unitTarget))
                        return false;
                    break;
                default:
                    break;
            }
        }
        if (!_condSrcInfo)
            return true;
        _condSrcInfo->mConditionTargets[0] = target;
        return sConditionMgr->IsObjectMeetToConditions(*_condSrcInfo, *_condList);
    }

    WorldObjectSpellNearbyTargetCheck::WorldObjectSpellNearbyTargetCheck(float range, Unit* caster, SpellInfo const* spellInfo,
            SpellTargetCheckTypes selectionType, ConditionList* condList)
        : WorldObjectSpellTargetCheck(caster, caster, spellInfo, selectionType, condList), _range(range), _position(caster)
    {
    }

    bool WorldObjectSpellNearbyTargetCheck::operator()(WorldObject* target)
    {
        //npcbot: custom check 1 for targeting bots by spells with SPELL_ATTR3_ONLY_ON_PLAYER
        if (_spellInfo->HasAttribute(SPELL_ATTR3_ONLY_ON_PLAYER) && target->GetTypeId() == TYPEID_UNIT && !target->IsNPCBot())
            return false;
        //end npcbot

        float dist = target->GetDistance(*_position);
        if (dist < _range && WorldObjectSpellTargetCheck::operator ()(target))
        {
            _range = dist;
            return true;
        }
        return false;
    }

    WorldObjectSpellAreaTargetCheck::WorldObjectSpellAreaTargetCheck(float range, Position const* position, Unit* caster,
            Unit* referer, SpellInfo const* spellInfo, SpellTargetCheckTypes selectionType, ConditionList* condList)
        : WorldObjectSpellTargetCheck(caster, referer, spellInfo, selectionType, condList), _range(range), _position(position)
    {
    }

    bool WorldObjectSpellAreaTargetCheck::operator()(WorldObject* target)
    {
        if (target->IsGameObject())
        {
            if (!target->ToGameObject()->IsInRange(_position->GetPositionX(), _position->GetPositionY(), _position->GetPositionZ(), _range))
                return false;
        }
        else if (!target->IsWithinDist3d(_position, _range))
            return false;
        else if (target->IsCreature() && target->ToCreature()->IsAvoidingAOE()) // pussywizard
            return false;
        //npcbot: custom check 2 for targeting bots by spells with SPELL_ATTR3_ONLY_ON_PLAYER
        else if (_spellInfo->HasAttribute(SPELL_ATTR3_ONLY_ON_PLAYER) && target->GetTypeId() == TYPEID_UNIT && !target->IsNPCBot())
            return false;
        //end npcbot

        return WorldObjectSpellTargetCheck::operator ()(target);
    }

    WorldObjectSpellConeTargetCheck::WorldObjectSpellConeTargetCheck(float coneAngle, float range, Unit* caster,
            SpellInfo const* spellInfo, SpellTargetCheckTypes selectionType, ConditionList* condList)
        : WorldObjectSpellAreaTargetCheck(range, caster, caster, caster, spellInfo, selectionType, condList), _coneAngle(coneAngle)
    {
    }

    bool WorldObjectSpellConeTargetCheck::operator()(WorldObject* target)
    {
        if (_spellInfo->HasAttribute(SPELL_ATTR0_CU_CONE_BACK))
        {
            if (!_caster->isInBack(target, _coneAngle))
                return false;
        }
        else if (_spellInfo->HasAttribute(SPELL_ATTR0_CU_CONE_LINE))
        {
            if (!_caster->HasInLine(target, _caster->GetObjectSize() + target->GetObjectSize()))
                return false;
        }
        else
        {
            if (!_caster->isInFront(target, _coneAngle))
                return false;
        }
        return WorldObjectSpellAreaTargetCheck::operator ()(target);
    }

    WorldObjectSpellTrajTargetCheck::WorldObjectSpellTrajTargetCheck(float range, Position const* position, Unit* caster,
            SpellInfo const* spellInfo, SpellTargetCheckTypes selectionType, ConditionList* condList)
        : WorldObjectSpellAreaTargetCheck(range, position, caster, caster, spellInfo, selectionType, condList)
    {
    }

    bool WorldObjectSpellTrajTargetCheck::operator()(WorldObject* target)
    {
        // return all targets on missile trajectory (0 - size of a missile)
        if (!_caster->HasInLine(target, target->GetObjectSize()))
            return false;
        return WorldObjectSpellAreaTargetCheck::operator ()(target);
    }

} //namespace Acore
