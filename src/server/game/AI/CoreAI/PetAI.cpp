/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "PetAI.h"
#include "Errors.h"
#include "Pet.h"
#include "Player.h"
#include "DBCStores.h"
#include "Spell.h"
#include "ObjectAccessor.h"
#include "SpellMgr.h"
#include "Creature.h"
#include "World.h"
#include "Util.h"
#include "Group.h"
#include "SpellInfo.h"
#include "SpellAuraEffects.h"
#include "WorldSession.h"

int PetAI::Permissible(const Creature* creature)
{
    if (creature->IsPet())
        return PERMIT_BASE_SPECIAL;

    return PERMIT_BASE_NO;
}

PetAI::PetAI(Creature* c) : CreatureAI(c), i_tracker(TIME_INTERVAL_LOOK)
{
    UpdateAllies();
}

bool PetAI::_needToStop()
{
    // This is needed for charmed creatures, as once their target was reset other effects can trigger threat
    if (me->IsCharmed() && me->GetVictim() == me->GetCharmer())
        return true;

    // xinef: dont allow to follow targets out of visibility range
    if (me->GetExactDist(me->GetVictim()) > me->GetVisibilityRange()-5.0f)
        return true;

    // dont allow pets to follow targets far away from owner
    if (Unit* owner = me->GetCharmerOrOwner())
        if (owner->GetExactDist(me) >= (owner->GetVisibilityRange()-10.0f))
            return true;

    if (!me->_CanDetectFeignDeathOf(me->GetVictim()))
        return true;

    if (me->isTargetNotAcceptableByMMaps(me->GetVictim()->GetGUID(), sWorld->GetGameTime(), me->GetVictim()))
        return true;

    return !me->CanCreatureAttack(me->GetVictim());
}

void PetAI::_stopAttack()
{
    if (!me->IsAlive())
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outStaticDebug("Creature stoped attacking cuz his dead [guid=%u]", me->GetGUIDLow());
#endif
        me->GetMotionMaster()->Clear();
        me->GetMotionMaster()->MoveIdle();
        me->CombatStop();
        me->getHostileRefManager().deleteReferences();
        return;
    }

    me->AttackStop();
    me->InterruptNonMeleeSpells(false);
    me->GetCharmInfo()->SetIsCommandAttack(false);
    ClearCharmInfoFlags();
    HandleReturnMovement();
}

void PetAI::_doMeleeAttack()
{
    // Xinef: Imps cannot attack with melee
    if (!_canMeleeAttack())
        return;

    DoMeleeAttackIfReady();
}

bool PetAI::_canMeleeAttack() const
{
    return me->GetEntry() != 416 /*ENTRY_IMP*/ &&
        me->GetEntry() != 510 /*ENTRY_WATER_ELEMENTAL*/ &&
        me->GetEntry() != 37994 /*ENTRY_WATER_ELEMENTAL_PERM*/; 
}

void PetAI::UpdateAI(uint32 diff)
{
    if (!me->IsAlive() || !me->GetCharmInfo())
        return;

    Unit* owner = me->GetCharmerOrOwner();

    //if Pet is in combat put player in combat
    if (me->IsInCombat())
        owner->IsInCombat();

    if (m_updateAlliesTimer <= diff)
        // UpdateAllies self set update timer
        UpdateAllies();
    else
        m_updateAlliesTimer -= diff;

    if (me->GetVictim() && me->GetVictim()->IsAlive())
    {
        // is only necessary to stop casting, the pet must not exit combat
        if (me->GetVictim()->HasBreakableByDamageCrowdControlAura(me))
        {
            me->InterruptNonMeleeSpells(false);
            return;
        }

        if (_needToStop())
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outStaticDebug("Pet AI stopped attacking [guid=%u]", me->GetGUIDLow());
#endif
            _stopAttack();
            return;
        }

        // Check before attacking to prevent pets from leaving stay position
        if (me->GetCharmInfo()->HasCommandState(COMMAND_STAY))
        {
            if (me->GetCharmInfo()->IsCommandAttack() || (me->GetCharmInfo()->IsAtStay() && me->IsWithinMeleeRange(me->GetVictim())))
                _doMeleeAttack();
        }
        else
            _doMeleeAttack();
    }
    else if (!me->GetCharmInfo() || (!me->GetCharmInfo()->GetForcedSpell() && !me->HasUnitState(UNIT_STATE_CASTING)))
    {
        if (me->HasReactState(REACT_AGGRESSIVE) || me->GetCharmInfo()->IsAtStay())
        {
            // Every update we need to check targets only in certain cases
            // Aggressive - Allow auto select if owner or pet don't have a target
            // Stay - Only pick from pet or owner targets / attackers so targets won't run by
            //   while chasing our owner. Don't do auto select.
            // All other cases (ie: defensive) - Targets are assigned by AttackedBy(), OwnerAttackedBy(), OwnerAttacked(), etc.
            Unit* nextTarget = SelectNextTarget(me->HasReactState(REACT_AGGRESSIVE));

            if (nextTarget)
                AttackStart(nextTarget);
            else
                HandleReturnMovement();
        }
        else
            HandleReturnMovement();
    }

    // xinef: charm info must be always available
    if (!me->GetCharmInfo())
        return;

    // Autocast (casted only in combat or persistent spells in any state)
    if (!me->HasUnitState(UNIT_STATE_CASTING))
    {
        if (owner && owner->GetTypeId() == TYPEID_PLAYER && me->GetCharmInfo()->GetForcedSpell() && me->GetCharmInfo()->GetForcedTarget())
        {
            owner->ToPlayer()->GetSession()->HandlePetActionHelper(me, me->GetGUID(), abs(me->GetCharmInfo()->GetForcedSpell()), ACT_ENABLED, me->GetCharmInfo()->GetForcedTarget());

            // xinef: if spell was casted properly and we are in passive mode, handle return
            if (!me->GetCharmInfo()->GetForcedSpell() && me->HasReactState(REACT_PASSIVE))
            {
                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    me->GetMotionMaster()->Clear(false);
                    me->StopMoving();
                }
                else
                    _stopAttack();
            }
            return;
        }

        // xinef: dont allow ghouls to cast spells below 75 energy
        if (me->IsPet() && me->ToPet()->IsPetGhoul() && me->GetPower(POWER_ENERGY) < 75)
            return;

        typedef std::vector<std::pair<Unit*, Spell*> > TargetSpellList;
        TargetSpellList targetSpellStore;

        for (uint8 i = 0; i < me->GetPetAutoSpellSize(); ++i)
        {
            uint32 spellID = me->GetPetAutoSpellOnPos(i);
            if (!spellID)
                continue;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellID);
            if (!spellInfo)
                continue;

            if (me->GetCharmInfo()->GetGlobalCooldownMgr().HasGlobalCooldown(spellInfo))
                continue;

            // check spell cooldown, this should be checked in CheckCast...
            if (me->HasSpellCooldown(spellInfo->Id))
                continue;

            if (spellInfo->IsPositive())
            {
                if (spellInfo->CanBeUsedInCombat())
                {
                    // Check if we're in combat or commanded to attack
                    if (!me->IsInCombat() && !me->GetCharmInfo()->IsCommandAttack())
                        continue;
                }

                Spell* spell = new Spell(me, spellInfo, TRIGGERED_NONE, 0);
                spell->LoadScripts(); // xinef: load for CanAutoCast (calling CheckPetCast)
                bool spellUsed = false;

                // Some spells can target enemy or friendly (DK Ghoul's Leap)
                // Check for enemy first (pet then owner)
                Unit* target = me->getAttackerForHelper();
                if (!target && owner)
                    target = owner->getAttackerForHelper();

                if (target)
                {
                    if (CanAttack(target) && spell->CanAutoCast(target))
                    {
                        targetSpellStore.push_back(std::make_pair(target, spell));
                        spellUsed = true;
                    }
                }

                // No enemy, check friendly
                if (!spellUsed)
                {
                    for (std::set<uint64>::const_iterator tar = m_AllySet.begin(); tar != m_AllySet.end(); ++tar)
                    {
                        Unit* ally = ObjectAccessor::GetUnit(*me, *tar);

                        //only buff targets that are in combat, unless the spell can only be cast while out of combat
                        if (!ally)
                            continue;

                        if (spell->CanAutoCast(ally))
                        {
                            targetSpellStore.push_back(std::make_pair(ally, spell));
                            spellUsed = true;
                            break;
                        }
                    }
                }

                // No valid targets at all
                if (!spellUsed)
                    delete spell;
            }
            else if (me->GetVictim() && CanAttack(me->GetVictim(), spellInfo) && spellInfo->CanBeUsedInCombat())
            {
                Spell* spell = new Spell(me, spellInfo, TRIGGERED_NONE, 0);
                if (spell->CanAutoCast(me->GetVictim()))
                    targetSpellStore.push_back(std::make_pair(me->GetVictim(), spell));
                else
                    delete spell;
            }
        }

        //found units to cast on to
        if (!targetSpellStore.empty())
        {
            uint32 index = urand(0, targetSpellStore.size() - 1);

            Spell* spell  = targetSpellStore[index].second;
            Unit*  target = targetSpellStore[index].first;

            targetSpellStore.erase(targetSpellStore.begin() + index);

            SpellCastTargets targets;
            targets.SetUnitTarget(target);

            if (!me->HasInArc(M_PI, target))
            {
                me->SetInFront(target);
                if (target && target->GetTypeId() == TYPEID_PLAYER)
                    me->SendUpdateToPlayer(target->ToPlayer());

                if (owner && owner->GetTypeId() == TYPEID_PLAYER)
                    me->SendUpdateToPlayer(owner->ToPlayer());
            }

            me->AddSpellCooldown(spell->m_spellInfo->Id, 0, 0);

            spell->prepare(&targets);
        }

        // deleted cached Spell objects
        for (TargetSpellList::const_iterator itr = targetSpellStore.begin(); itr != targetSpellStore.end(); ++itr)
            delete itr->second;
    }
}

void PetAI::UpdateAllies()
{
    Unit* owner = me->GetCharmerOrOwner();
    Group* group = NULL;

    m_updateAlliesTimer = 10*IN_MILLISECONDS;                //update friendly targets every 10 seconds, lesser checks increase performance

    if (!owner)
        return;
    else if (owner->GetTypeId() == TYPEID_PLAYER)
        group = owner->ToPlayer()->GetGroup();

    //only pet and owner/not in group->ok
    if (m_AllySet.size() == 2 && !group)
        return;
    //owner is in group; group members filled in already (no raid -> subgroupcount = whole count)
    if (group && !group->isRaidGroup() && m_AllySet.size() == (group->GetMembersCount() + 2))
        return;

    m_AllySet.clear();
    m_AllySet.insert(me->GetGUID());
    if (group)                                              //add group
    {
        for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
        {
            Player* Target = itr->GetSource();
            if (!Target || !Target->IsInMap(owner) || !group->SameSubGroup(owner->ToPlayer(), Target))
                continue;

            if (Target->GetGUID() == owner->GetGUID())
                continue;

            m_AllySet.insert(Target->GetGUID());
        }
    }
    else                                                    //remove group
        m_AllySet.insert(owner->GetGUID());
}

void PetAI::KilledUnit(Unit* victim)
{
    // Called from Unit::Kill() in case where pet or owner kills something
    // if owner killed this victim, pet may still be attacking something else
    if (me->GetVictim() && me->GetVictim() != victim)
        return;

    // Xinef: if pet is channeling a spell and owner killed something different, dont interrupt it
    if (me->HasUnitState(UNIT_STATE_CASTING) && me->GetUInt64Value(UNIT_FIELD_CHANNEL_OBJECT) && me->GetUInt64Value(UNIT_FIELD_CHANNEL_OBJECT) != victim->GetGUID())
        return;

    // Clear target just in case. May help problem where health / focus / mana
    // regen gets stuck. Also resets attack command.
    // Can't use _stopAttack() because that activates movement handlers and ignores
    // next target selection
    me->AttackStop();
    me->InterruptNonMeleeSpells(false);

    // Before returning to owner, see if there are more things to attack
    if (Unit* nextTarget = SelectNextTarget(false))
        AttackStart(nextTarget);
    else
        HandleReturnMovement(); // Return
}

void PetAI::AttackStart(Unit* target)
{
    // Overrides Unit::AttackStart to correctly evaluate Pet states

    // Check all pet states to decide if we can attack this target
    if (!CanAttack(target))
        return;

    // Only chase if not commanded to stay or if stay but commanded to attack
    DoAttack(target, (!me->GetCharmInfo()->HasCommandState(COMMAND_STAY) || me->GetCharmInfo()->IsCommandAttack()));
}

void PetAI::OwnerAttackedBy(Unit* attacker)
{
    // Called when owner takes damage. This function helps keep pets from running off
    //  simply due to owner gaining aggro.

    if (!attacker)
        return;

    // Passive pets don't do anything
    if (me->HasReactState(REACT_PASSIVE))
        return;

    // Prevent pet from disengaging from current target
    if (me->GetVictim() && me->GetVictim()->IsAlive())
        return;

    // Continue to evaluate and attack if necessary
    AttackStart(attacker);
}

void PetAI::OwnerAttacked(Unit* target)
{
    // Called when owner attacks something. Allows defensive pets to know
    //  that they need to assist

    // Target might be NULL if called from spell with invalid cast targets
    if (!target)
        return;

    // Passive pets don't do anything
    if (me->HasReactState(REACT_PASSIVE))
        return;

    // Prevent pet from disengaging from current target
    if (me->GetVictim() && me->GetVictim()->IsAlive())
        return;

    // Continue to evaluate and attack if necessary
    AttackStart(target);
}

Unit* PetAI::SelectNextTarget(bool allowAutoSelect) const
{
    // Provides next target selection after current target death.
    // This function should only be called internally by the AI
    // Targets are not evaluated here for being valid targets, that is done in _CanAttack()
    // The parameter: allowAutoSelect lets us disable aggressive pet auto targeting for certain situations

    // Passive pets don't do next target selection
    if (me->HasReactState(REACT_PASSIVE))
        return NULL;

    // Check pet attackers first so we don't drag a bunch of targets to the owner
    if (Unit* myAttacker = me->getAttackerForHelper())
        if (!myAttacker->HasBreakableByDamageCrowdControlAura() && me->_CanDetectFeignDeathOf(myAttacker) && me->CanCreatureAttack(myAttacker) && !me->isTargetNotAcceptableByMMaps(myAttacker->GetGUID(), sWorld->GetGameTime(), myAttacker))
            return myAttacker;

    // Check pet's attackers first to prevent dragging mobs back to owner
    if (me->HasAuraType(SPELL_AURA_MOD_TAUNT))
    {
        const Unit::AuraEffectList& tauntAuras = me->GetAuraEffectsByType(SPELL_AURA_MOD_TAUNT);
        if (!tauntAuras.empty())
            for (Unit::AuraEffectList::const_reverse_iterator itr = tauntAuras.rbegin(); itr != tauntAuras.rend(); ++itr)
                if (Unit* caster = (*itr)->GetCaster())
                    if (me->_CanDetectFeignDeathOf(caster) && me->CanCreatureAttack(caster) && !caster->HasAuraTypeWithCaster(SPELL_AURA_IGNORED, me->GetGUID()))
                        return caster;
    }

    // Not sure why we wouldn't have an owner but just in case...
    Unit* owner = me->GetCharmerOrOwner();
    if (!owner)
        return NULL;

    // Check owner attackers
    if (Unit* ownerAttacker = owner->getAttackerForHelper())
        if (!ownerAttacker->HasBreakableByDamageCrowdControlAura() && me->_CanDetectFeignDeathOf(ownerAttacker) && me->CanCreatureAttack(ownerAttacker) && !me->isTargetNotAcceptableByMMaps(ownerAttacker->GetGUID(), sWorld->GetGameTime(), ownerAttacker))
            return ownerAttacker;

    // Check owner victim
    // 3.0.2 - Pets now start attacking their owners victim in defensive mode as soon as the hunter does
    if (Unit* ownerVictim = owner->GetVictim())
        if (me->_CanDetectFeignDeathOf(ownerVictim) && me->CanCreatureAttack(ownerVictim) && !me->isTargetNotAcceptableByMMaps(ownerVictim->GetGUID(), sWorld->GetGameTime(), ownerVictim))
            return ownerVictim;

    // Neither pet or owner had a target and aggressive pets can pick any target
    // To prevent aggressive pets from chain selecting targets and running off, we
    // only select a random target if certain conditions are met.
    if (allowAutoSelect)
        if (!me->GetCharmInfo()->IsReturning() || me->GetCharmInfo()->IsFollowing() || me->GetCharmInfo()->IsAtStay())
            if (Unit* nearTarget = me->ToCreature()->SelectNearestTargetInAttackDistance(MAX_AGGRO_RADIUS))
                return nearTarget;

    // Default - no valid targets
    return NULL;
}

void PetAI::HandleReturnMovement()
{
    // Handles moving the pet back to stay or owner

    // Prevent activating movement when under control of spells
    // such as "Eyes of the Beast"
    if (me->isPossessed())
        return;

    if (me->GetCharmInfo()->HasCommandState(COMMAND_STAY))
    {
        if (!me->GetCharmInfo()->IsAtStay() && !me->GetCharmInfo()->IsReturning())
        {
            if (me->GetCharmInfo()->HasStayPosition())
            {
                // Return to previous position where stay was clicked
                if (me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_CONTROLLED) == NULL_MOTION_TYPE)
                {
                    float x, y, z;
                    me->GetCharmInfo()->GetStayPosition(x, y, z);
                    ClearCharmInfoFlags();
                    me->GetCharmInfo()->SetIsReturning(true);
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MovePoint(me->GetUInt32Value(OBJECT_FIELD_GUID), x, y, z);
                }
            }
        }
    }
    else // COMMAND_FOLLOW
    {
        if (!me->GetCharmInfo()->IsFollowing() && !me->GetCharmInfo()->IsReturning())
        {
            if (me->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_CONTROLLED) == NULL_MOTION_TYPE)
            {
                ClearCharmInfoFlags();
                me->GetCharmInfo()->SetIsReturning(true);
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveFollow(me->GetCharmerOrOwner(), PET_FOLLOW_DIST, me->GetFollowAngle());
            }
        }
    }

    me->GetCharmInfo()->SetForcedSpell(0);
    me->GetCharmInfo()->SetForcedTargetGUID(0);

    // xinef: remember that npcs summoned by npcs can also be pets
    me->DeleteThreatList();
    me->ClearInPetCombat();
}

void PetAI::SpellHit(Unit* caster, const SpellInfo* spellInfo)
{
    // Xinef: taunt behavior code
    if (spellInfo->HasAura(SPELL_AURA_MOD_TAUNT) && !me->HasReactState(REACT_PASSIVE))
    {
        me->GetCharmInfo()->SetForcedSpell(0);
        me->GetCharmInfo()->SetForcedTargetGUID(0);
        AttackStart(caster);
    }
}

void PetAI::DoAttack(Unit* target, bool chase)
{
    // Handles attack with or without chase and also resets flags
    // for next update / creature kill

    if (me->Attack(target, true))
    {
        // xinef: properly fix fake combat after pet is sent to attack
        if (Unit* owner = me->GetOwner())
            owner->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PET_IN_COMBAT);

        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PET_IN_COMBAT);

        // Play sound to let the player know the pet is attacking something it picked on its own
        if (me->HasReactState(REACT_AGGRESSIVE) && !me->GetCharmInfo()->IsCommandAttack())
            me->SendPetAIReaction(me->GetGUID());

        if (CharmInfo* ci = me->GetCharmInfo())
        {
            ci->SetIsAtStay(false);
            ci->SetIsCommandFollow(false);
            ci->SetIsFollowing(false);
            ci->SetIsReturning(false);
        }

        if (chase)
        {
            me->GetMotionMaster()->MoveChase(target, !_canMeleeAttack() ? 20.0f: 0.0f, me->GetAngle(target));
        }
        else // (Stay && ((Aggressive || Defensive) && In Melee Range)))
        {
            me->GetCharmInfo()->SetIsAtStay(true);
            me->GetMotionMaster()->MovementExpiredOnSlot(MOTION_SLOT_ACTIVE, false);
            me->GetMotionMaster()->MoveIdle();
        }
    }
}

void PetAI::MovementInform(uint32 moveType, uint32 data)
{
    // Receives notification when pet reaches stay or follow owner
    switch (moveType)
    {
        case POINT_MOTION_TYPE:
        {
            // Pet is returning to where stay was clicked. data should be
            // pet's GUIDLow since we set that as the waypoint ID
            if (data == me->GetGUIDLow() && me->GetCharmInfo()->IsReturning())
            {
                ClearCharmInfoFlags();
                me->GetCharmInfo()->SetIsAtStay(true);
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveIdle();
            }
            break;
        }
        case FOLLOW_MOTION_TYPE:
        {
            // If data is owner's GUIDLow then we've reached follow point,
            // otherwise we're probably chasing a creature
            if (me->GetCharmerOrOwner() && me->GetCharmInfo() && data == me->GetCharmerOrOwner()->GetGUIDLow() && me->GetCharmInfo()->IsReturning())
            {
                ClearCharmInfoFlags();
                me->GetCharmInfo()->SetIsFollowing(true);
            }
            break;
        }
        default:
            break;
    }
}

bool PetAI::CanAttack(Unit* target, const SpellInfo* spellInfo)
{
    // Evaluates wether a pet can attack a specific target based on CommandState, ReactState and other flags
    // IMPORTANT: The order in which things are checked is important, be careful if you add or remove checks

    // Hmmm...
    if (!target)
        return false;

    if (!target->IsAlive())
    {
        // xinef: if target is invalid, pet should evade automaticly
        // Clear target to prevent getting stuck on dead targets
        //me->AttackStop();
        //me->InterruptNonMeleeSpells(false);
        return false;
    }

    // xinef: check unit states of pet
    if (me->HasUnitState(UNIT_STATE_LOST_CONTROL))
        return false;

    // xinef: pets of mounted players have stunned flag only, check this also
    if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED))
        return false;

    // pussywizard: ZOMG! TEMP!
    if (!me->GetCharmInfo())
    {
        sLog->outMisc("PetAI::CanAttack (A1) - %u, %u", me->GetEntry(), GUID_LOPART(me->GetOwnerGUID()));
        return false;
    }

    // Passive - passive pets can attack if told to
    if (me->HasReactState(REACT_PASSIVE))
        return me->GetCharmInfo()->IsCommandAttack();

    // CC - mobs under crowd control can be attacked if owner commanded
    if (target->HasBreakableByDamageCrowdControlAura() && (!spellInfo || !spellInfo->HasAttribute(SPELL_ATTR4_DAMAGE_DOESNT_BREAK_AURAS)))
        return me->GetCharmInfo()->IsCommandAttack();

    // Returning - pets ignore attacks only if owner clicked follow
    if (me->GetCharmInfo()->IsReturning())
        return !me->GetCharmInfo()->IsCommandFollow();

    // Stay - can attack if target is within range or commanded to
    if (me->GetCharmInfo()->HasCommandState(COMMAND_STAY))
        return (me->IsWithinMeleeRange(target) || me->GetCharmInfo()->IsCommandAttack());
    
    //  Pets attacking something (or chasing) should only switch targets if owner tells them to
    if (me->GetVictim() && me->GetVictim() != target)
    {
        // Check if our owner selected this target and clicked "attack"
        Unit* ownerTarget = NULL;
        if (Player* owner = me->GetCharmerOrOwner()->ToPlayer())
            ownerTarget = owner->GetSelectedUnit();
        else
            ownerTarget = me->GetCharmerOrOwner()->GetVictim();
    
        if (ownerTarget && me->GetCharmInfo()->IsCommandAttack())
            return (target->GetGUID() == ownerTarget->GetGUID());
    }

    // Follow
    if (me->GetCharmInfo()->HasCommandState(COMMAND_FOLLOW))
        return !me->GetCharmInfo()->IsReturning();        

    // default, though we shouldn't ever get here
    return false;
}

void PetAI::ReceiveEmote(Player* player, uint32 emote)
{
    if (me->GetOwnerGUID() && me->GetOwnerGUID() == player->GetGUID())
        switch (emote)
        {
            case TEXT_EMOTE_COWER:
                if (me->IsPet() && me->ToPet()->IsPetGhoul())
                    me->HandleEmoteCommand(/*EMOTE_ONESHOT_ROAR*/EMOTE_ONESHOT_OMNICAST_GHOUL);
                break;
            case TEXT_EMOTE_ANGRY:
                if (me->IsPet() && me->ToPet()->IsPetGhoul())
                    me->HandleEmoteCommand(/*EMOTE_ONESHOT_COWER*/EMOTE_STATE_STUN);
                break;
            case TEXT_EMOTE_GLARE:
                if (me->IsPet() && me->ToPet()->IsPetGhoul())
                    me->HandleEmoteCommand(EMOTE_STATE_STUN);
                break;
            case TEXT_EMOTE_SOOTHE:
                if (me->IsPet() && me->ToPet()->IsPetGhoul())
                    me->HandleEmoteCommand(EMOTE_ONESHOT_OMNICAST_GHOUL);
                break;
        }
}

void PetAI::ClearCharmInfoFlags()
{
    // Quick access to set all flags to FALSE

    CharmInfo* ci = me->GetCharmInfo();

    if (ci)
    {
        ci->SetIsAtStay(false);
        ci->SetIsCommandAttack(false);
        ci->SetIsCommandFollow(false);
        ci->SetIsFollowing(false);
        ci->SetIsReturning(false);
    }
}

void PetAI::AttackedBy(Unit* attacker)
{
    // Called when pet takes damage. This function helps keep pets from running off
    //  simply due to gaining aggro.

    if (!attacker)
        return;

    // Passive pets don't do anything
    if (me->HasReactState(REACT_PASSIVE))
        return;

    // Prevent pet from disengaging from current target
    if (me->GetVictim() && me->GetVictim()->IsAlive())
        return;

    // Continue to evaluate and attack if necessary
    AttackStart(attacker);
}
