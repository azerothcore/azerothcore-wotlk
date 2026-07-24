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

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_mag_".
 */

#include "CombatAI.h"
#include "CreatureScript.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellMgr.h"

enum MageSpells
{
    SPELL_MAGE_CLONE_ME                 = 45204,
    SPELL_MAGE_MASTERS_THREAT_LIST      = 58838,
    SPELL_PET_HIT_SCALING               = 61013,
    SPELL_SUMMON_MIRROR_IMAGE1          = 58831,
    SPELL_SUMMON_MIRROR_IMAGE2          = 58833,
    SPELL_SUMMON_MIRROR_IMAGE3          = 58834,
    SPELL_SUMMON_MIRROR_IMAGE_GLYPH     = 65047,
    SPELL_MAGE_MIRROR_IMAGE_FROSTBOLT   = 59638,
    SPELL_MAGE_MIRROR_IMAGE_FIRE_BLAST  = 59637
};

class DeathEvent : public BasicEvent
{
public:
    DeathEvent(Creature& owner) : BasicEvent(), _owner(owner) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*diff*/) override
    {
        Unit::Kill(&_owner, &_owner);
        return true;
    }

private:
    Creature& _owner;
};

struct npc_pet_mage_mirror_image : CasterAI
{
    npc_pet_mage_mirror_image(Creature* creature) : CasterAI(creature) { }

    uint32 selectionTimer;
    ObjectGuid _ebonGargoyleGUID;
    uint32 checktarget;
    uint32 dist = urand(1, 5);
    bool _delayAttack;

    void InitializeAI() override
    {
        CasterAI::InitializeAI();

        _delayAttack = true;
        me->m_Events.AddEventAtOffset([this]()
        {
            _delayAttack = false;
        }, 1200ms);

        Unit* owner = me->GetOwner();
        if (!owner)
            return;

        // Clone Me!
        owner->CastSpell(me, SPELL_MAGE_CLONE_ME, true);

        // xinef: Glyph of Mirror Image (4th copy)
        float angle = 0.0f;
        switch (me->GetUInt32Value(UNIT_CREATED_BY_SPELL))
        {
            case SPELL_SUMMON_MIRROR_IMAGE1:
                angle = 0.5f * M_PI;
                break;
            case SPELL_SUMMON_MIRROR_IMAGE2:
                angle = M_PI;
                break;
            case SPELL_SUMMON_MIRROR_IMAGE3:
                angle = 1.5f * M_PI;
                break;
        }

        ((Minion*)me)->SetFollowAngle(angle);
        if (owner->IsInCombat())
            me->NearTeleportTo(me->GetPositionX() + cos(angle)*dist, me->GetPositionY() + std::sin(angle)*dist, me->GetPositionZ(), me->GetOrientation(), false, false, false, false);
        else
            me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle(), MOTION_SLOT_ACTIVE);

        me->SetReactState(REACT_DEFENSIVE);

        // Xinef: Inherit Master's Threat List (not yet implemented)
        //owner->CastSpell((Unit*)nullptr, SPELL_MAGE_MASTERS_THREAT_LIST, true);
        for (auto const& pair : owner->GetThreatMgr().GetThreatenedByMeList())
        {
            if (Unit* unit = pair.second->GetOwner())
                unit->GetThreatMgr().AddThreat(me, pair.second->GetThreat());
        }

        _ebonGargoyleGUID.Clear();

        // Xinef: copy caster auras
        Unit::VisibleAuraMap const* visibleAuraMap = owner->GetVisibleAuras();
        for (Unit::VisibleAuraMap::const_iterator itr = visibleAuraMap->begin(); itr != visibleAuraMap->end(); ++itr)
            if (Aura* visAura = itr->second->GetBase())
            {
                // Ebon Gargoyle
                if (visAura->GetId() == 49206 && me->GetUInt32Value(UNIT_CREATED_BY_SPELL) == SPELL_SUMMON_MIRROR_IMAGE1)
                {
                    if (Unit* gargoyle = visAura->GetCaster())
                        _ebonGargoyleGUID = gargoyle->GetGUID();
                    continue;
                }
                SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(visAura->GetId());
                if (bounds.first != bounds.second)
                    continue;
                std::vector<int32> const* spellTriggered = sSpellMgr->GetSpellLinked(visAura->GetId() + SPELL_LINK_AURA);
                if (!spellTriggered || !spellTriggered->empty())
                    continue;
                if (Aura* newAura = me->AddAura(visAura->GetId(), me))
                    newAura->SetDuration(visAura->GetDuration());
            }

        me->m_Events.AddEventAtOffset(new DeathEvent(*me), 29500ms);
    }

    // Do not reload Creature templates on evade mode enter - prevent visual lost
    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        if (me->IsInEvadeMode() || !me->IsAlive())
            return;

        Unit* owner = me->GetCharmerOrOwner();

        me->CombatStop(true);
        if (owner && !me->HasUnitState(UNIT_STATE_FOLLOW))
        {
            me->GetMotionMaster()->Clear(false);
            me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle(), MOTION_SLOT_ACTIVE);
        }
    }

    void MySelectNextTarget()
    {
        if (_ebonGargoyleGUID)
        {
            Unit* gargoyle = ObjectAccessor::GetUnit(*me, _ebonGargoyleGUID);
            if (gargoyle && gargoyle->GetAI())
                gargoyle->GetAI()->AttackStart(me);
            _ebonGargoyleGUID.Clear();
        }
        Unit* owner = me->GetOwner();
        if (owner && owner->IsPlayer())
        {
            Unit* selection = owner->ToPlayer()->GetSelectedUnit();

            if (selection && me->CanSeeOrDetect(selection))
            {
                me->GetThreatMgr().ResetAllThreat();
                me->AddThreat(selection, 1000000.0f);

                if (owner->IsInCombat())
                    AttackStart(selection);
            }

            if (!owner->IsInCombat() && !me->GetVictim())
                EnterEvadeMode(EVADE_REASON_OTHER);
        }
    }

    void Reset() override
    {
        selectionTimer = 0;
        checktarget = 0;
    }

    void UpdateAI(uint32 diff) override
    {
        if (_delayAttack)
            return;

        events.Update(diff);

        if (!me->IsInCombat() || !me->GetVictim())
        {
            MySelectNextTarget();
            return;
        }

        // A dead target, or one we lost sight of, is invalid: drop it and reselect.
        // CanSeeOrDetect is comparatively expensive, so throttle the sight check to ~1s.
        bool lostTarget = !me->GetVictim()->IsAlive();

        checktarget += diff;
        if (checktarget >= 1000)
        {
            checktarget = 0;
            if (!me->CanSeeOrDetect(me->GetVictim()))
                lostTarget = true;
        }

        if (lostTarget)
        {
            MySelectNextTarget();
            me->InterruptNonMeleeSpells(false);
            return;
        }

        // A cast already in progress when the crowd control lands is allowed to finish (3.1.2),
        // except a Frostbolt on a target that is now Polymorphed: 3.2.0 cancels that cast so it
        // cannot break the Polymorph. Other breakable CC keeps the "let it finish" behaviour.
        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            if (me->GetVictim()->HasAuraWithMechanic(1ULL << MECHANIC_POLYMORPH)
                && me->FindCurrentSpellBySpellId(SPELL_MAGE_MIRROR_IMAGE_FROSTBOLT))
                me->InterruptNonMeleeSpells(false, SPELL_MAGE_MIRROR_IMAGE_FROSTBOLT);

            return;
        }

        // Never start a new cast on a target under a breakable-by-damage CC aura (Polymorph,
        // Dragon's Breath, ...) - that is what would break the crowd control.
        if (me->GetVictim()->HasBreakableByDamageCrowdControlAura(me))
            return;

        if (uint32 spellId = events.ExecuteEvent())
        {
            events.RescheduleEvent(spellId, spellId == SPELL_MAGE_MIRROR_IMAGE_FIRE_BLAST ? 6500ms : 2500ms);
            me->CastSpell(me->GetVictim(), spellId, false);
        }
    }
};

void AddSC_mage_pet_scripts()
{
    RegisterCreatureAI(npc_pet_mage_mirror_image);
}
