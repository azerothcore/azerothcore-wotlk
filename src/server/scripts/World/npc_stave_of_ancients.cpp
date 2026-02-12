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

#include "npc_stave_of_ancients.h"
#include "CreatureGroups.h"
#include "CreatureScript.h"
#include "GameTime.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Spell.h"

uint32 NPCStaveQuestAI::GetFormEntry(std::string type)
{
    uint32 currentEntry = me->GetEntry();
    uint32 entryKey = entryKeys[currentEntry];
    return entryList[entryKey][type];
}

bool NPCStaveQuestAI::InNormalForm()
{
    return me->GetEntry() == GetFormEntry("normal");
}

void NPCStaveQuestAI::RevealForm()
{
    if (encounterStarted && InNormalForm())
    {
        me->UpdateEntry(GetFormEntry("evil"));
        me->SetFullHealth();
        me->DespawnOrUnsummon(900s);
    }
}

void NPCStaveQuestAI::StorePlayerGUID()
{
    if (!playerGUID.IsEmpty())
    {
        return;
    }

    for (ThreatContainer::StorageType::const_iterator itr = threatList.begin(); itr != threatList.end(); ++itr)
    {
        if ((*itr)->getTarget()->IsPlayer())
        {
            playerGUID = (*itr)->getUnitGuid();
        }
    }
}

Player* NPCStaveQuestAI::GetGossipPlayer()
{
    return ObjectAccessor::GetPlayer(*me, gossipPlayerGUID);
}

bool NPCStaveQuestAI::IsAllowedEntry(uint32 entry)
{
    uint32 allowedEntries[4] = { 0, 12999, 19833, 19921 }; //player, World Invisible Trigger(traps) and snake trap snakes
    bool isAllowed = std::find(std::begin(allowedEntries), std::end(allowedEntries), entry) != std::end(allowedEntries);
    return isAllowed;
}

bool NPCStaveQuestAI::UnitIsUnfair(Unit* unit)
{
    if (!unit || playerGUID.IsEmpty())
    {
        return false;
    }

    if (unit->IsPlayer())
    {
        if (playerGUID != unit->GetGUID())
        {
            return true;
        }
    }
    else
    {
        if (unit->GetOwnerGUID() != playerGUID)
        {
            // if a creature attacking isn't owned by the player its unfair
            return true;
        }
        else if (!IsAllowedEntry(unit->GetEntry()))
        {
            // if not in the whitelist its unfair
            return true;
        }
    }

    return false;
}

bool NPCStaveQuestAI::IsFairFight()
{
    for (ThreatContainer::StorageType::const_iterator itr = threatList.begin(); itr != threatList.end(); ++itr)
    {
        Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid());

        if (!(*itr)->GetThreat())
        {
            // if target threat is 0 its fair, this prevents despawn in the case when
            // there is a bystander since UpdateVictim adds nearby enemies to the threatlist
            continue;
        }

        if (UnitIsUnfair(unit))
        {
            return false;
        }
    }

    return true;
}

bool NPCStaveQuestAI::ValidThreatlist()
{
    if (threatList.size() == 1)
    {
        return true;
    }

    bool isFair = IsFairFight();

    return isFair;
}

void NPCStaveQuestAI::SetHomePosition()
{
    Position homePosition = me->GetPosition();

    if (homePosition.IsPositionValid())
    {
        me->SetHomePosition(homePosition);
    }
}

void NPCStaveQuestAI::PrepareForEncounter()
{
    encounterStarted = true;
    me->GetMotionMaster()->MoveIdle();
    me->GetMotionMaster()->Clear();
    SetHomePosition();

    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
    me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
}

void NPCStaveQuestAI::ClearLootIfUnfair(Unit* killer)
{
    // Remove loot if there is more than 1 attacker or Player doesn't have the quest
    // this should prevent party kills and looting the quest item without putting any effort
    if (attackerGuids.size() > 1 || !PlayerEligibleForReward(killer))
    {
        me->loot.clear();
        return;
    }
}

bool NPCStaveQuestAI::PlayerEligibleForReward(Unit* killer)
{
    if (!killer)
    {
        return true;
    }

    if (Player* player = killer->ToPlayer())
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) != QUEST_STATUS_INCOMPLETE)
        {
            return false;
        }
    }

    return true;
}

void NPCStaveQuestAI::StoreAttackerGuidValue(Unit* attacker)
{
    if (!attacker)
    {
        return;
    }

    uint64 guidValue = attacker->GetGUID().GetRawValue();
    bool isGUIDPresent = std::find(attackerGuids.begin(), attackerGuids.end(), guidValue) != attackerGuids.end();

    // don't store snaketrap's snakes and trap triggers
    if (isGUIDPresent || (IsAllowedEntry(attacker->GetEntry()) && !attacker->IsPlayer()))
    {
        return;
    }
    else
    {
        attackerGuids.push_back(guidValue);
    }
}

bool NPCStaveQuestAI::QuestIncomplete(Unit* unit, uint32 questItem)
{
    if (!unit || !unit->IsPlayer())
    {
        return true;
    }

    QuestStatus questStatus = unit->ToPlayer()->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS);
    bool hasQuestItem = unit->ToPlayer()->HasItemCount(questItem, 1, true);
    bool isIncomplete = questStatus == QUEST_STATUS_INCOMPLETE && !hasQuestItem;

    return isIncomplete;
}

void NPCStaveQuestAI::ResetState(uint32 aura = 0)
{
    encounterStarted = false;
    playerGUID.Clear();
    attackerGuids.clear();

    if (InNormalForm())
    {
        me->m_Events.KillAllEvents(true);
        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
    }

    me->RemoveAura(aura);
}

void NPCStaveQuestAI::EvadeOnFeignDeath()
{
    Player* player = ObjectAccessor::GetPlayer(*me, playerGUID);
    if (player && player->HasAura(SPELL_FEIGN_DEATH))
    {
        EnterEvadeMode();
    }
}

void NPCStaveQuestAI::AttackStart(Unit* target)
{
    if (playerGUID.IsEmpty() && !InNormalForm())
    {
        StorePlayerGUID();
    }

    ScriptedAI::AttackStart(target);
}

void NPCStaveQuestAI::AttackedBy(Unit* attacker)
{
    StoreAttackerGuidValue(attacker);
}

void NPCStaveQuestAI::JustDied(Unit* killer)
{
    // Prevent looting if killer doesn't have the quest
    ClearLootIfUnfair(killer);
}

class npc_artorius : public CreatureScript
{
public:
    npc_artorius() : CreatureScript("npc_artorius") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_artoriusAI(creature);
    }

    struct npc_artoriusAI : public NPCStaveQuestAI
    {
        npc_artoriusAI(Creature *creature) : NPCStaveQuestAI(creature) { }

        EventMap events;

        void Reset() override
        {
            ResetState(ARTORIUS_SPELL_STINGING_TRAUMA);
            events.Reset();
        }

        void JustEngagedWith(Unit* who) override
        {
            RevealForm();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

            if (InNormalForm())
            {
                return;
            }

            if (who && (UnitIsUnfair(who) || !QuestIncomplete(who, ARTORIUS_HEAD)))
            {
                me->CastSpell(who, SPELL_FOOLS_PLIGHT, true);
            }

            events.ScheduleEvent(EVENT_FOOLS_PLIGHT, 2s, 3s);
            events.ScheduleEvent(EVENT_RANGE_CHECK, 1s);
            events.ScheduleEvent(EVENT_UNFAIR_FIGHT, 1s);
            events.ScheduleEvent(ARTORIUS_EVENT_DEMONIC_DOOM, 3s, 5s);
            events.ScheduleEvent(ARTORIUS_EVENT_DEMONIC_ENRAGE, 6s, 8s);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            uint32 eventId = events.ExecuteEvent();

            // Out of combat events
            switch (eventId)
            {
                case EVENT_ENCOUNTER_START:
                    me->Say(ARTORIUS_SAY);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    events.ScheduleEvent(EVENT_REVEAL, 5s);
                    break;
                case EVENT_REVEAL:
                    RevealForm();
                    break;
            }

            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                EvadeOnFeignDeath();
            }
            else
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            // In combat events
            switch (eventId)
            {
                case EVENT_FOOLS_PLIGHT:
                    if (UnitIsUnfair(me->GetVictim()) || !QuestIncomplete(me->GetVictim(), ARTORIUS_HEAD))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_FOOLS_PLIGHT, true);
                    }
                    events.Repeat(3s, 6s);
                    break;
                case EVENT_RANGE_CHECK:
                    if (!me->GetVictim() || !me->GetVictim()->IsWithinDist2d(me, 60.0f))
                    {
                        EnterEvadeMode();
                    }
                    else
                    {
                        events.Repeat(2s);
                    }
                    break;
                case EVENT_UNFAIR_FIGHT:
                    if (!ValidThreatlist())
                    {
                        SetHomePosition();
                        me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1);
                        me->SetImmuneToAll(true);
                        me->DespawnOrUnsummon(5s);
                        break;
                    }
                    events.Repeat(2s);
                    break;
                case ARTORIUS_EVENT_DEMONIC_DOOM:
                    if (!me->GetVictim()->HasAura(ARTORIUS_SPELL_DEMONIC_DOOM))
                    {
                        me->CastSpell(me->GetVictim(), ARTORIUS_SPELL_DEMONIC_DOOM, false);
                    }
                    events.Repeat(5s, 10s);
                    break;
                case ARTORIUS_EVENT_DEMONIC_ENRAGE:
                    me->CastSpell(me, SPELL_DEMONIC_ENRAGE, false);
                    events.Repeat(22s, 39s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (attacker == me)
            {
                me->LowerPlayerDamageReq(damage);
            }
        }

        void SpellHit(Unit* /*Caster*/, SpellInfo const* Spell) override
        {
            uint32 serpentStings[12] = { 1978, 13549, 13550, 13551, 13552, 13553, 13554, 13555, 25295, 27016, 49000, 49001 };

            if (!InNormalForm())
            {
                bool applyAura = std::find(std::begin(serpentStings), std::end(serpentStings), Spell->Id) != std::end(serpentStings);

                if (applyAura)
                {
                    me->AddAura(ARTORIUS_SPELL_STINGING_TRAUMA, me);
                    me->TextEmote(ARTORIUS_WEAKNESS_EMOTE);
                }
            }
        }

        void DoAction(int32 action) override
        {
            if (action == EVENT_ENCOUNTER_START)
            {
                PrepareForEncounter();
                events.ScheduleEvent(EVENT_ENCOUNTER_START, 5s);
            }
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        creature->AI()->DoAction(EVENT_ENCOUNTER_START);

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(ARTORIUS_HEAD, 1, true))
        {
            uint32 gossipMenuId = creature->GetCreatureTemplate()->GossipMenuId;
            AddGossipItemFor(player, gossipMenuId, GOSSIP_EVENT_START_OPTION_ID, GOSSIP_SENDER_MAIN, 0);
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

class npc_precious : public CreatureScript
{
public:
    npc_precious() : CreatureScript("npc_precious") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_preciousAI(creature);
    }

    struct npc_preciousAI : public NPCStaveQuestAI
    {
        npc_preciousAI(Creature *creature) : NPCStaveQuestAI(creature) { }

        EventMap events;
        bool flaggedForDespawn;

        void InitializeAI() override
        {
            flaggedForDespawn = false;
        }

        void JustReachedHome() override
        {
            if (flaggedForDespawn)
            {
                me->DespawnOrUnsummon(0ms);
                flaggedForDespawn = false;
            }
        }

        void Reset() override
        {
            ResetState();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            RevealForm();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                EvadeOnFeignDeath();
            }
            else
            {
                return;
            }

            DoMeleeAttackIfReady();
        }

        void FlagForDespawn()
        {
            flaggedForDespawn = true;
        }
    };
};

class npc_simone : public CreatureScript
{
public:
    npc_simone() : CreatureScript("npc_simone") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_simoneAI(creature);
    }

    struct npc_simoneAI : public NPCStaveQuestAI
    {
        npc_simoneAI(Creature *creature) : NPCStaveQuestAI(creature) { }

        EventMap events;
        ObjectGuid preciousGUID;

        void SetPreciousGUID()
        {
            if (CreatureGroup* formation = me->GetFormation())
            {
                const CreatureGroup::CreatureGroupMemberType& members = formation->GetMembers();
                for (CreatureGroup::CreatureGroupMemberType::const_iterator itr = members.begin(); itr != members.end(); ++itr)
                {
                    if (itr->first && itr->first->GetOriginalEntry() == PRECIOUS_NORMAL_ENTRY)
                    {
                        preciousGUID = itr->first->GetGUID();
                    }
                }
            }
        }

        Creature* Precious()
        {
            if (preciousGUID.IsEmpty())
            {
                SetPreciousGUID();
            }

            if (!preciousGUID.IsEmpty())
            {
                return ObjectAccessor::GetCreature(*me, preciousGUID);
            }

            return nullptr;
        }

        npc_precious::npc_preciousAI* PreciousAI()
        {
            if (Precious())
            {
                return CAST_AI(npc_precious::npc_preciousAI, Precious()->AI());
            }

            return nullptr;
        }

        void RespawnPet()
        {
            Position current = me->GetNearPosition(-5.0f, 0.0f);
            Precious()->RemoveCorpse(false, false);
            Precious()->SetPosition(current);
            Precious()->SetHomePosition(current);
            Precious()->setDeathState(DeathState::JustRespawned);
            Precious()->UpdateObjectVisibility(true);
        }

        void HandlePetRespawn()
        {
            if (Precious() && Precious()->isDead())
            {
                RespawnPet();
            }
        }

        void JustRespawned() override
        {
            // Using Respawn() instead of HandlePetRespawn because we want to respawn pet in
            // normal entry form
            if (Precious())
            {
                Precious()->Respawn();
            }
            Reset();
        }

        void JustDied(Unit* killer) override
        {
            NPCStaveQuestAI::JustDied(killer);

            if (!Precious())
            {
                return;
            }

            if (Precious()->isDead())
            {
                // Make it so that Precious respawns after Simone
                uint32 respawnTime = me->GetRespawnTime() - GameTime::GetGameTime().count();
                Precious()->SetRespawnTime(respawnTime);
                return;
            }

            Position petResetPos = me->GetNearPosition(-5.0f, 0.0f);

            if (petResetPos.IsPositionValid())
            {
                Precious()->SetHomePosition(petResetPos);
            }
        }

        void CorpseRemoved(uint32& /*respawnDelay*/) override
        {
            if (!Precious())
            {
                return;
            }

            if (Precious()->IsInCombat())
            {
                // If Simone corpse is removed but pet is InCombat, EnterEvadeMode and auto despawn on pet reaching home
                PreciousAI()->EnterEvadeMode();
                PreciousAI()->FlagForDespawn();
            }
            else
            {
                Precious()->DespawnOrUnsummon(0ms);
            }
        }

        void Reset() override
        {
            ResetState(SIMONE_SPELL_SILENCE);
            events.Reset();

            events.ScheduleEvent(SIMONE_EVENT_CHECK_PET_STATE, 2s);
        }

        void JustEngagedWith(Unit* who) override
        {
            RevealForm();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

            if (!InNormalForm())
            {
                if (who && (UnitIsUnfair(who) || !QuestIncomplete(who, SIMONE_HEAD)))
                {
                    me->CastSpell(who, SPELL_FOOLS_PLIGHT, true);
                }

                events.ScheduleEvent(EVENT_RANGE_CHECK, 1s);
                events.ScheduleEvent(EVENT_UNFAIR_FIGHT, 1s);
                events.ScheduleEvent(SIMONE_EVENT_CHAIN_LIGHTNING, 3s);
                events.ScheduleEvent(SIMONE_EVENT_TEMPTRESS_KISS, 1s);
            }

            events.ScheduleEvent(EVENT_FOOLS_PLIGHT, 2s, 3s);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            uint32 eventId = events.ExecuteEvent();

            // Out of combat events
            switch (eventId)
            {
                case EVENT_ENCOUNTER_START:
                    me->TextEmote(SIMONE_EMOTE, GetGossipPlayer());
                    me->HandleEmoteCommand(EMOTE_ONESHOT_NONE);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    events.ScheduleEvent(SIMONE_EVENT_TALK, 4s);
                    break;
                case SIMONE_EVENT_TALK:
                    me->Say(SIMONE_SAY, GetGossipPlayer());
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    if (Precious())
                    {
                        Precious()->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    }
                    events.ScheduleEvent(EVENT_REVEAL, 5s);
                    break;
                case EVENT_REVEAL:
                    RevealForm();
                    if (PreciousAI())
                    {
                        PreciousAI()->RevealForm();
                    }
                    break;
                // Prevent hunters from figthing Simone alone
                case SIMONE_EVENT_CHECK_PET_STATE:
                    if (!me->IsInCombat() && !me->IsInEvadeMode())
                    {
                        if (Precious() && Precious()->isDead())
                        {
                            HandlePetRespawn();
                        }

                        events.ScheduleEvent(SIMONE_EVENT_CHECK_PET_STATE, 1s);
                    }
                    break;
            }

            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                EvadeOnFeignDeath();
            }
            else
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING) && eventId != EVENT_RANGE_CHECK && eventId != EVENT_UNFAIR_FIGHT)
            {
                events.Repeat(1s);
                return;
            }

            // In combat events
            switch (eventId)
            {
                case EVENT_FOOLS_PLIGHT:
                    if (InNormalForm() || UnitIsUnfair(me->GetVictim()) || !QuestIncomplete(me->GetVictim(), SIMONE_HEAD))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_FOOLS_PLIGHT, true);
                    }
                    events.Repeat(3s, 6s);
                    break;
                case EVENT_RANGE_CHECK:
                    if (!me->GetVictim()->IsWithinDist2d(me, 60.0f))
                    {
                        EnterEvadeMode();
                    }
                    else
                    {
                        events.Repeat(2s);
                    }
                    break;
                case EVENT_UNFAIR_FIGHT:
                    if (!ValidThreatlist() || (PreciousAI() && !PreciousAI()->ValidThreatlist()))
                    {
                        SetHomePosition();
                        PreciousAI()->SetHomePosition();

                        Precious()->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1);
                        Precious()->SetImmuneToAll(true);
                        me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1);
                        me->SetImmuneToAll(true);

                        Precious()->DespawnOrUnsummon(5s);

                        me->DespawnOrUnsummon(5s);
                        break;
                    }
                    events.Repeat(2s);
                    break;
                case SIMONE_EVENT_CHAIN_LIGHTNING:
                    me->CastSpell(me->GetVictim(), SIMONE_SPELL_CHAIN_LIGHTNING, false);
                    events.Repeat(7s);
                    break;
                case SIMONE_EVENT_TEMPTRESS_KISS:
                    me->CastSpell(me->GetVictim(), SIMONE_SPELL_TEMPTRESS_KISS, false);
                    events.Repeat(45s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* /*Caster*/, SpellInfo const* Spell) override
        {
            if (!InNormalForm())
            {
                if (Spell->Id == SIMONE_SPELL_WEAKNESS_VIPER_STING)
                {
                    me->AddAura(SIMONE_SPELL_SILENCE, me);
                    me->TextEmote(SIMONE_WEAKNESS_EMOTE);
                }
            }
        }

        void ScheduleEncounterStart(ObjectGuid playerGUID)
        {
            PrepareForEncounter();
            if (PreciousAI())
            {
                PreciousAI()->PrepareForEncounter();
            }
            gossipPlayerGUID = playerGUID;
            events.ScheduleEvent(EVENT_ENCOUNTER_START, 1s);
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        if (creature->AI() && CAST_AI(npc_simone::npc_simoneAI, creature->AI()))
        {
            CAST_AI(npc_simone::npc_simoneAI, creature->AI())->ScheduleEncounterStart(player->GetGUID());
        }

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(SIMONE_HEAD, 1, true))
        {
            uint32 gossipMenuId = creature->GetCreatureTemplate()->GossipMenuId;
            AddGossipItemFor(player, gossipMenuId, GOSSIP_EVENT_START_OPTION_ID, GOSSIP_SENDER_MAIN, 0);
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

class npc_nelson : public CreatureScript
{
public:
    npc_nelson() : CreatureScript("npc_nelson") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_nelsonAI(creature);
    }

    struct npc_nelsonAI : public NPCStaveQuestAI
    {
        npc_nelsonAI(Creature *creature) : NPCStaveQuestAI(creature) { }

        EventMap events;
        bool shouldDespawn;

        void JustSummoned(Creature* summon) override
        {
            if (!summon)
            {
                return;
            }

            // Workaround for increasing the Summoned Guardian damage by using the template modifier value
            summon->Unit::UpdateDamagePhysical(BASE_ATTACK);

            if (me->IsInCombat())
            {
                summon->AI()->AttackStart(me->GetVictim());
            }
        }

        void SummonedCreatureDies(Creature* /*summon*/, Unit* killer) override
        {
            // This should trigger the despawn event when a another player or unit
            // kills a creeping doom unit
            if (UnitIsUnfair(killer))
            {
                shouldDespawn = true;
            }
        }

        void Reset() override
        {
            ResetState(NELSON_SPELL_CRIPPLING_CLIP);
            shouldDespawn = false;
            events.Reset();

            me->RemoveAllMinionsByEntry(CREEPING_DOOM_ENTRY);
        }

        void JustEngagedWith(Unit* who) override
        {
            RevealForm();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

            if (InNormalForm())
            {
                return;
            }

            if (encounterStarted)
            {
                me->CastSpell(me, NELSON_SPELL_SOUL_FLAME, true);
            }

            if (who && (UnitIsUnfair(who) || !QuestIncomplete(who, NELSON_HEAD)))
            {
                me->CastSpell(who, SPELL_FOOLS_PLIGHT, true);
            }

            events.ScheduleEvent(EVENT_FOOLS_PLIGHT, 2s, 3s);
            events.ScheduleEvent(EVENT_RANGE_CHECK, 1s);
            events.ScheduleEvent(EVENT_UNFAIR_FIGHT, 1s);
            events.ScheduleEvent(NELSON_EVENT_DREADFUL_FRIGHT, 10s);
            events.ScheduleEvent(NELSON_EVENT_CREEPING_DOOM, 5s);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            uint32 eventId = events.ExecuteEvent();

            // Out of combat events
            switch (eventId)
            {
                case EVENT_ENCOUNTER_START:
                    me->Say(NELSON_SAY);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    events.ScheduleEvent(EVENT_REVEAL, 5s);
                    break;
                case EVENT_REVEAL:
                    RevealForm();
                    break;
            }

            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                EvadeOnFeignDeath();
            }
            else
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                events.Repeat(1s);
                return;
            }

            // In combat events
            switch (eventId)
            {
                case EVENT_FOOLS_PLIGHT:
                    if (UnitIsUnfair(me->GetVictim()) || !QuestIncomplete(me->GetVictim(), NELSON_HEAD))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_FOOLS_PLIGHT, true);
                    }
                    events.Repeat(3s, 6s);
                    break;
                case EVENT_RANGE_CHECK:
                    if (!me->GetVictim()->IsWithinDist2d(me, 60.0f))
                    {
                        EnterEvadeMode();
                    }
                    else
                    {
                        events.Repeat(2s);
                    }
                    break;
                case EVENT_UNFAIR_FIGHT:
                    if (!ValidThreatlist() || shouldDespawn)
                    {
                        SetHomePosition();
                        me->RemoveAllMinionsByEntry(CREEPING_DOOM_ENTRY);
                        me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1);
                        me->SetImmuneToAll(true);
                        me->CombatStop(true);
                        me->Say(NELSON_DESPAWN_SAY);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        me->DespawnOrUnsummon(5s);
                        break;
                    }
                    events.Repeat(2s);
                    break;
                case NELSON_EVENT_DREADFUL_FRIGHT:
                    me->CastSpell(me->GetVictim(), NELSON_SPELL_DREADFUL_FRIGHT, false);
                    events.Repeat(12s, 19s);
                    break;
                case NELSON_EVENT_CREEPING_DOOM:
                    me->CastSpell(me->GetVictim(), NELSON_SPELL_CREEPING_DOOM, false);
                    events.Repeat(10s, 12s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* /*Caster*/, SpellInfo const* Spell) override
        {
            if (InNormalForm())
                return;

            if (me->HasAllAuras(NELSON_SPELL_SOUL_FLAME, NELSON_WEAKNESS_FROST_TRAP))
                me->RemoveAura(NELSON_SPELL_SOUL_FLAME);

            if (!me->HasAura(NELSON_SPELL_CRIPPLING_CLIP) && Spell->Id == NELSON_WEAKNESS_WING_CLIP)
            {
                me->AddAura(NELSON_SPELL_CRIPPLING_CLIP, me);
                me->TextEmote(NELSON_WEAKNESS_EMOTE);
            }
        }

        void DoAction(int32 action) override
        {
            if (action == EVENT_ENCOUNTER_START)
            {
                PrepareForEncounter();
                events.ScheduleEvent(EVENT_ENCOUNTER_START, 5s);
            }
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        creature->AI()->DoAction(EVENT_ENCOUNTER_START);

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(NELSON_HEAD, 1, true))
        {
            uint32 gossipMenuId = creature->GetCreatureTemplate()->GossipMenuId;
            AddGossipItemFor(player, gossipMenuId, GOSSIP_EVENT_START_OPTION_ID, GOSSIP_SENDER_MAIN, 0);
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

class npc_franklin : public CreatureScript
{
public:
    npc_franklin() : CreatureScript("npc_franklin") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_franklinAI(creature);
    }

    struct npc_franklinAI : public NPCStaveQuestAI
    {
        npc_franklinAI(Creature *creature) : NPCStaveQuestAI(creature) { }

        EventMap events;

        void Reset() override
        {
            ResetState();
            events.Reset();
        }

        void JustEngagedWith(Unit* who) override
        {
            RevealForm();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

            if (!InNormalForm())
            {
                if (who && (UnitIsUnfair(who) || !QuestIncomplete(who, FRANKLIN_HEAD)))
                {
                    me->CastSpell(who, SPELL_FOOLS_PLIGHT, true);
                }

                events.ScheduleEvent(FRANKLIN_EVENT_DEMONIC_ENRAGE, 9s, 13s);
                events.ScheduleEvent(EVENT_RANGE_CHECK, 1s);
                events.ScheduleEvent(EVENT_UNFAIR_FIGHT, 1s);
            }

            events.ScheduleEvent(EVENT_FOOLS_PLIGHT, 2s, 3s);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            uint32 eventId = events.ExecuteEvent();

            // Out of combat events
            switch (eventId)
            {
                case EVENT_ENCOUNTER_START:
                    me->Say(FRANKLIN_SAY, GetGossipPlayer());
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    events.ScheduleEvent(EVENT_REVEAL, 5s);
                    break;
                case EVENT_REVEAL:
                    RevealForm();
                    break;
            }

            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                EvadeOnFeignDeath();
            }
            else
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                events.Repeat(1s);
                return;
            }

            // In combat events
            switch (eventId)
            {
                case EVENT_FOOLS_PLIGHT:
                    if (InNormalForm() || UnitIsUnfair(me->GetVictim()) || !QuestIncomplete(me->GetVictim(), FRANKLIN_HEAD))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_FOOLS_PLIGHT, true);
                    }
                    events.Repeat(3s, 6s);
                    break;
                case EVENT_RANGE_CHECK:
                    if (!me->GetVictim()->IsWithinDist2d(me, 60.0f))
                    {
                        EnterEvadeMode();
                    }
                    else
                    {
                        events.Repeat(2s);
                    }
                    break;
                case EVENT_UNFAIR_FIGHT:
                    if (!ValidThreatlist())
                    {
                        SetHomePosition();
                        me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1);
                        me->SetImmuneToAll(true);
                        me->CombatStop(true);
                        me->Say(FRANKLIN_DESPAWN_SAY);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        me->DespawnOrUnsummon(5s);
                        break;
                    }
                    events.Repeat(2s);
                    break;
                case FRANKLIN_EVENT_DEMONIC_ENRAGE:
                    me->CastSpell(me, SPELL_DEMONIC_ENRAGE, false);
                    me->TextEmote(FRANKLIN_ENRAGE_EMOTE);
                    events.Repeat(9s, 22s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* /*Caster*/, SpellInfo const* Spell) override
        {
            if (InNormalForm())
            {
                return;
            }

            if (Spell->Id == FRANKLIN_WEAKNESS_SCORPID_STING)
            {
                me->CastSpell(me, FRANKLIN_SPELL_ENTROPIC_STING, false);
            }
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (attacker == me)
            {
                me->LowerPlayerDamageReq(damage);
            }
        }

        void ScheduleEncounterStart(ObjectGuid playerGUID)
        {
            PrepareForEncounter();
            gossipPlayerGUID = playerGUID;
            events.ScheduleEvent(EVENT_ENCOUNTER_START, 5s);
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        if (creature->AI() && CAST_AI(npc_franklin::npc_franklinAI, creature->AI()))
        {
            CAST_AI(npc_franklin::npc_franklinAI, creature->AI())->ScheduleEncounterStart(player->GetGUID());
        }

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(FRANKLIN_HEAD, 1, true))
        {
            uint32 gossipMenuId = creature->GetCreatureTemplate()->GossipMenuId;
            AddGossipItemFor(player, gossipMenuId, GOSSIP_EVENT_START_OPTION_ID, GOSSIP_SENDER_MAIN, 0);
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

void AddSC_npc_stave_of_ancients()
{
    new npc_artorius();
    new npc_precious();
    new npc_simone();
    new npc_nelson();
    new npc_franklin();
}
