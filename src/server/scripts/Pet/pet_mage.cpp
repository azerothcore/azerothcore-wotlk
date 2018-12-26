/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_mag_".
 */

#include "ScriptMgr.h"
#include "ScriptPCH.h"
#include "ScriptedCreature.h"
#include "CombatAI.h"
#include "Pet.h"

enum MageSpells
{
    SPELL_MAGE_CLONE_ME                 = 45204,
    SPELL_MAGE_MASTERS_THREAT_LIST      = 58838,
    SPELL_PET_HIT_SCALING               = 61013,
    SPELL_SUMMON_MIRROR_IMAGE1          = 58831,
    SPELL_SUMMON_MIRROR_IMAGE2          = 58833,
    SPELL_SUMMON_MIRROR_IMAGE3          = 58834,
    SPELL_SUMMON_MIRROR_IMAGE_GLYPH     = 65047
};

class DeathEvent : public BasicEvent
{
    public:
        DeathEvent(Creature& owner) : BasicEvent(), _owner(owner) { }

        bool Execute(uint64 /*eventTime*/, uint32 /*diff*/)
        {
            Unit::Kill(&_owner, &_owner);
            return true;
        }

    private:
        Creature& _owner;
};

class npc_pet_mage_mirror_image : public CreatureScript
{
    public:
        npc_pet_mage_mirror_image() : CreatureScript("npc_pet_mage_mirror_image") { }

        struct npc_pet_mage_mirror_imageAI : CasterAI
        {
            npc_pet_mage_mirror_imageAI(Creature* creature) : CasterAI(creature) { }

            uint32 selectionTimer;
            uint64 _ebonGargoyleGUID;
            uint32 checktarget;
            uint32 dist = urand(1, 5);

            void InitializeAI()
            {
                CasterAI::InitializeAI();
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
                    me->NearTeleportTo(me->GetPositionX() + cos(angle)*dist, me->GetPositionY() + sin(angle)*dist, me->GetPositionZ(), me->GetOrientation(), false, false, false, false);
                else
                    me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle(), MOTION_SLOT_ACTIVE);

                me->SetReactState(REACT_DEFENSIVE);

                // Xinef: Inherit Master's Threat List (not yet implemented)
                //owner->CastSpell((Unit*)NULL, SPELL_MAGE_MASTERS_THREAT_LIST, true);
                HostileReference* ref = owner->getHostileRefManager().getFirst();
                while (ref)
                {
                    if (Unit* unit = ref->GetSource()->GetOwner())
                        unit->AddThreat(me, ref->getThreat() - ref->getTempThreatModifier());
                    ref = ref->next();
                }

                _ebonGargoyleGUID = 0;

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

                me->m_Events.AddEvent(new DeathEvent(*me), me->m_Events.CalculateTime(29500));
            }

            // Do not reload Creature templates on evade mode enter - prevent visual lost
            void EnterEvadeMode()
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
                    _ebonGargoyleGUID = 0;
                }
                Unit* owner = me->GetOwner();
                if (owner && owner->GetTypeId() == TYPEID_PLAYER)
                {
                    Unit* selection = owner->ToPlayer()->GetSelectedUnit();

                    if (selection)
                    {
                        me->getThreatManager().resetAllAggro();
                        me->AddThreat(selection, 1000000.0f);

                        if (owner->IsInCombat())
                            AttackStart(selection);
                    }

                    if (!owner->IsInCombat() && !me->GetVictim())
                        EnterEvadeMode();
                }
            }

            void Reset()
            {
                selectionTimer = 0;
                checktarget = 0;
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);
                if (events.GetTimer() < 1200)
                    return;

                if (!me->IsInCombat() || !me->GetVictim())
                {
                    MySelectNextTarget();
                    return;
                }

                checktarget += diff;

                if (checktarget >= 1000)
                {
                    if (me->GetVictim()->HasBreakableByDamageCrowdControlAura() || !me->GetVictim()->IsAlive())
                    {
                        MySelectNextTarget();
                        me->InterruptNonMeleeSpells(true); // Stop casting if target is CC or not Alive.
                        return;
                    }
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (uint32 spellId = events.GetEvent())
                {
                    events.RescheduleEvent(spellId, spellId == 59637 ? 6500 : 2500);
                    me->CastSpell(me->GetVictim(), spellId, false);
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_pet_mage_mirror_imageAI(creature);
        }
};

void AddSC_mage_pet_scripts()
{
    new npc_pet_mage_mirror_image();
}
