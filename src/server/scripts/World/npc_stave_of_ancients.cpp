/* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 *
 *
 * This program is free software licensed under GPL version 2
 * Please see the included DOCS/LICENSE.TXT for more information */

#include "CreatureGroups.h"
#include "CreatureTextMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "npc_stave_of_ancients.h"

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
        me->DespawnOrUnsummon(900000);
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
        if ((*itr)->getTarget()->GetTypeId() == TYPEID_PLAYER)
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

        if (!(*itr)->getThreat())
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
    Position homePosition;
    me->GetPosition(&homePosition);

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

    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
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
    if(isGUIDPresent || (IsAllowedEntry(attacker->GetEntry()) && attacker->GetTypeId() != TYPEID_PLAYER)) {
        return;
    } else {
        attackerGuids.push_back(guidValue);
    }
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

        void JustDied(Unit* killer) override
        {
            // Prevent looting if killer doesn't have the quest
            ClearLootIfUnfair(killer);
        }

        void Reset() override
        {
            encounterStarted = false;
            playerGUID.Clear();
            attackerGuids.clear();
            events.Reset();

            if (InNormalForm())
            {
                me->m_Events.KillAllEvents(true);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }

            if (me->HasAura(ARTORIUS_SPELL_STINGING_TRAUMA))
            {
                me->RemoveAura(ARTORIUS_SPELL_STINGING_TRAUMA);
            }
        }

        void AttackStart(Unit* target) override
        {
            if (playerGUID.IsEmpty() && !InNormalForm())
            {
                StorePlayerGUID();
            }

            ScriptedAI::AttackStart(target);
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            RevealForm();
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            if (!InNormalForm())
            {
                events.ScheduleEvent(ARTORIUS_EVENT_DEMONIC_DOOM, urand(3000, 5000));
                events.ScheduleEvent(ARTORIUS_EVENT_DEMONIC_ENRAGE, urand(6000, 8000));
                events.ScheduleEvent(EVENT_RANGE_CHECK, 1000);
                events.ScheduleEvent(EVENT_UNFAIR_FIGHT, 1000);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            uint32 eventId = events.ExecuteEvent();

            // Out of combat events
            switch (eventId)
            {
                case EVENT_ENCOUNTER_START:
                    me->MonsterSay(ARTORIUS_SAY, LANG_UNIVERSAL, 0);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    events.ScheduleEvent(EVENT_REVEAL, 8000);
                    break;
                case EVENT_REVEAL:
                    RevealForm();
                    break;
            }

            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                if (!playerGUID.IsEmpty() && ObjectAccessor::GetPlayer(*me, playerGUID)->HasAura(5384))
                {
                    playerGUID.Clear();
                    EnterEvadeMode();
                    return;
                }
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
                case EVENT_RANGE_CHECK:
                    if (!me->GetVictim()->IsWithinDist2d(me, 60.0f))
                    {
                        EnterEvadeMode();
                    }
                    else
                    {
                        events.RepeatEvent(2000);
                    }
                    break;
                case EVENT_UNFAIR_FIGHT:
                    if (!ValidThreatlist())
                    {
                        SetHomePosition();
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1 | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                        me->DespawnOrUnsummon(5000);
                        break;
                    }
                    events.RepeatEvent(2000);
                    break;
                case ARTORIUS_EVENT_DEMONIC_DOOM:
                    if (!me->GetVictim()->HasAura(ARTORIUS_SPELL_DEMONIC_DOOM))
                    {
                        me->CastSpell(me->GetVictim(), ARTORIUS_SPELL_DEMONIC_DOOM, false);
                    }
                    events.RepeatEvent(urand(5000, 10000));
                    break;
                case ARTORIUS_EVENT_DEMONIC_ENRAGE:
                    me->CastSpell(me, ARTORIUS_SPELL_DEMONIC_ENRAGE, false);
                    events.RepeatEvent(urand(22000, 39000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* /*Caster*/, const SpellInfo* Spell) override
        {
            uint32 serpentStings[12] = { 1978, 13549, 13550, 13551, 13552, 13553, 13554, 13555, 25295, 27016, 49000, 49001 };

            if (!InNormalForm())
            {
                bool applyAura = std::find(std::begin(serpentStings), std::end(serpentStings), Spell->Id) != std::end(serpentStings);

                if (applyAura)
                {
                    me->AddAura(ARTORIUS_SPELL_STINGING_TRAUMA, me);
                    me->MonsterTextEmote(ARTORIUS_WEAKNESS_EMOTE, 0);
                }
            }
        }

        void DamageTaken(Unit* attacker, uint32& /*damage*/, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            StoreAttackerGuidValue(attacker);
        }

        void DoAction(int32 action) override
        {
            if (action == EVENT_ENCOUNTER_START)
            {
                PrepareForEncounter();
                events.ScheduleEvent(EVENT_ENCOUNTER_START, 2000);
            }
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        creature->AI()->DoAction(EVENT_ENCOUNTER_START);

        return true;
    }

    bool OnGossipHello(Player *player, Creature * creature) override
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(ARTORIUS_HEAD, 1, true))
        {
            std::string const& gossipOptionText = sCreatureTextMgr->GetLocalizedChatString(ARTORIUS_GOSSIP_OPTION_TEXT, 0, 0, 0, LOCALE_enUS);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, gossipOptionText, GOSSIP_SENDER_MAIN, 0);
        }

        SendGossipMenuFor(player, ARTORIUS_GOSSIP_TEXT, creature->GetGUID());

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
                me->DespawnOrUnsummon(0);
                flaggedForDespawn = false;
            }
        }

        void Reset() override
        {
            encounterStarted = false;
            playerGUID.Clear();

            if (InNormalForm())
            {
                me->m_Events.KillAllEvents(true);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }
        }

        void AttackStart(Unit* target) override
        {
            if (playerGUID.IsEmpty() && !InNormalForm())
            {
                StorePlayerGUID();
            }

            ScriptedAI::AttackStart(target);
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            RevealForm();
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                if (!playerGUID.IsEmpty() && ObjectAccessor::GetPlayer(*me, playerGUID)->HasAura(5384))
                {
                    playerGUID.Clear();
                    EnterEvadeMode();
                    return;
                }
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

    bool OnGossipHello(Player *player, Creature * creature) override
    {
        SendGossipMenuFor(player, PRECIOUS_GOSSIP_TEXT, creature->GetGUID());

        return true;
    }
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
        bool petDespawned;
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
            Position current;
            me->GetNearPosition(current, -5.0f, 0.0f);
            Precious()->RemoveCorpse(false, false);
            Precious()->SetPosition(current);
            Precious()->SetHomePosition(current);
            Precious()->setDeathState(JUST_RESPAWNED);
            Precious()->UpdateObjectVisibility(true);
        }

        void HandlePetRespawn()
        {
            if (Precious() && !preciousGUID.IsEmpty())
            {
                if (Precious()->isDead())
                {
                    RespawnPet();
                }
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
            // Prevent looting if recipient doesn't have the quest
            ClearLootIfUnfair(killer);

            if (!Precious())
            {
                return;
            }

            if (Precious()->isDead())
            {
                // Make it so that Precious respawns after Simone
                uint32 respawnTime = me->GetRespawnTime() - time(nullptr);
                Precious()->SetRespawnTime(respawnTime);
                return;
            }

            Position petResetPos;
            me->GetNearPosition(petResetPos, -5.0f, 0.0f);

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
                Precious()->DespawnOrUnsummon(0);
            }
        }

        void Reset() override
        {
            encounterStarted = false;
            playerGUID.Clear();
            attackerGuids.clear();
            events.Reset();

            if (InNormalForm())
            {
                me->m_Events.KillAllEvents(true);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }

            events.ScheduleEvent(SIMONE_EVENT_CHECK_PET_STATE, 2000);

            if (me->HasAura(SIMONE_SPELL_SILENCE))
            {
                me->RemoveAura(SIMONE_SPELL_SILENCE);
            }
        }

        void AttackStart(Unit* target) override
        {
            if (playerGUID.IsEmpty() && !InNormalForm())
            {
                StorePlayerGUID();
            }

            ScriptedAI::AttackStart(target);
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            RevealForm();
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            if (InNormalForm())
            {
                events.ScheduleEvent(EVENT_FOOLS_PLIGHT, urand(2000, 3000));
            }
            else
            {
                events.ScheduleEvent(SIMONE_EVENT_CHAIN_LIGHTNING, 3000);
                events.ScheduleEvent(SIMONE_EVENT_TEMPTRESS_KISS, 1000);
                events.ScheduleEvent(EVENT_RANGE_CHECK, 1000);
                events.ScheduleEvent(EVENT_UNFAIR_FIGHT, 1000);
            }
        }

        void DamageTaken(Unit* attacker, uint32& /*damage*/, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            StoreAttackerGuidValue(attacker);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            uint32 eventId = events.ExecuteEvent();

            // Out of combat events
            switch (eventId)
            {
                case EVENT_ENCOUNTER_START:
                    me->MonsterTextEmote(SIMONE_EMOTE, GetGossipPlayer());
                    me->HandleEmoteCommand(EMOTE_ONESHOT_NONE);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    events.ScheduleEvent(SIMONE_EVENT_TALK, 4000);
                    break;
                case SIMONE_EVENT_TALK:
                    me->MonsterSay(SIMONE_SAY, LANG_UNIVERSAL, GetGossipPlayer());
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    if (Precious())
                    {
                        Precious()->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    }
                    events.ScheduleEvent(EVENT_REVEAL, 5000);
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

                        events.ScheduleEvent(SIMONE_EVENT_CHECK_PET_STATE, 1000);
                    }
                    break;
            }

            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                if (!playerGUID.IsEmpty() && ObjectAccessor::GetPlayer(*me, playerGUID)->HasAura(5384))
                {
                    playerGUID.Clear();
                    EnterEvadeMode();
                    return;
                }
            }
            else
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING) && eventId != EVENT_RANGE_CHECK && eventId != EVENT_UNFAIR_FIGHT)
            {
                events.RepeatEvent(1000);
                return;
            }

            // In combat events
            switch (eventId)
            {
                case EVENT_FOOLS_PLIGHT:
                    me->CastSpell(me->GetVictim(), SPELL_FOOLS_PLIGHT, true);
                    events.RepeatEvent(urand(6000, 9000));
                    break;
                case EVENT_RANGE_CHECK:
                    if (!me->GetVictim()->IsWithinDist2d(me, 60.0f))
                    {
                        EnterEvadeMode();
                    }
                    else
                    {
                        events.RepeatEvent(2000);
                    }
                    break;
                case EVENT_UNFAIR_FIGHT:
                    if (!ValidThreatlist() || (PreciousAI() && !PreciousAI()->ValidThreatlist()))
                    {
                        SetHomePosition();
                        PreciousAI()->SetHomePosition();

                        petDespawned = true;
                        Precious()->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1 | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1 | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);

                        Precious()->DespawnOrUnsummon(5000);

                        me->DespawnOrUnsummon(5000);
                        break;
                    }
                    events.RepeatEvent(2000);
                    break;
                case SIMONE_EVENT_CHAIN_LIGHTNING:
                    me->CastSpell(me->GetVictim(), SIMONE_SPELL_CHAIN_LIGHTNING, false);
                    events.RepeatEvent(7000);
                    break;
                case SIMONE_EVENT_TEMPTRESS_KISS:
                    me->CastSpell(me->GetVictim(), SIMONE_SPELL_TEMPTRESS_KISS, false);
                    events.RepeatEvent(45000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* /*Caster*/, const SpellInfo* Spell) override
        {
            if (!InNormalForm())
            {
                if (Spell->Id == SIMONE_SPELL_WEAKNESS_VIPER_STING)
                {
                    me->AddAura(SIMONE_SPELL_SILENCE, me);
                    me->MonsterTextEmote(SIMONE_WEAKNESS_EMOTE, 0);
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
            events.ScheduleEvent(EVENT_ENCOUNTER_START, 1000);
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

    bool OnGossipHello(Player *player, Creature * creature) override
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(SIMONE_HEAD, 1, true))
        {
            std::string const& gossipOptionText = sCreatureTextMgr->GetLocalizedChatString(SIMONE_GOSSIP_OPTION_TEXT, 0, 0, 0, LOCALE_enUS);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, gossipOptionText, GOSSIP_SENDER_MAIN, 0);
        }

        SendGossipMenuFor(player, SIMONE_GOSSIP_TEXT, creature->GetGUID());

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

        void JustDied(Unit* killer) override
        {
            // Prevent looting if killer doesn't have the quest
            ClearLootIfUnfair(killer);
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
            encounterStarted = false;
            shouldDespawn = false;
            playerGUID.Clear();
            attackerGuids.clear();
            events.Reset();

            if (InNormalForm())
            {
                me->m_Events.KillAllEvents(true);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }

            me->RemoveAllMinionsByEntry(CREEPING_DOOM_ENTRY);

            if (me->HasAura(NELSON_SPELL_CRIPPLING_CLIP))
            {
                me->RemoveAura(NELSON_SPELL_CRIPPLING_CLIP);
            }
        }

        void AttackStart(Unit* target) override
        {
            if (playerGUID.IsEmpty() && !InNormalForm())
            {
                StorePlayerGUID();
            }

            ScriptedAI::AttackStart(target);
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            RevealForm();
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            if (!InNormalForm())
            {
                if (encounterStarted)
                {
                    me->CastSpell(me, NELSON_SPELL_SOUL_FLAME, true);
                }

                events.ScheduleEvent(NELSON_EVENT_CREEPING_DOOM, 5000);
                events.ScheduleEvent(NELSON_EVENT_DREADFUL_FRIGHT, 10000);
                events.ScheduleEvent(EVENT_RANGE_CHECK, 1000);
                events.ScheduleEvent(EVENT_UNFAIR_FIGHT, 1000);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            uint32 eventId = events.ExecuteEvent();

            // Out of combat events
            switch (eventId)
            {
                case EVENT_ENCOUNTER_START:
                    me->MonsterSay(NELSON_SAY, LANG_UNIVERSAL, 0);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    events.ScheduleEvent(EVENT_REVEAL, 5000);
                    break;
                case EVENT_REVEAL:
                    RevealForm();
                    break;
            }

            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                if (!playerGUID.IsEmpty() && ObjectAccessor::GetPlayer(*me, playerGUID)->HasAura(5384))
                {
                    playerGUID.Clear();
                    EnterEvadeMode();
                    return;
                }
            }
            else
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                events.RepeatEvent(1000);
                return;
            }

            // In combat events
            switch (eventId)
            {
                case EVENT_RANGE_CHECK:
                    if (!me->GetVictim()->IsWithinDist2d(me, 60.0f))
                    {
                        EnterEvadeMode();
                    }
                    else
                    {
                        events.RepeatEvent(2000);
                    }
                    break;
                case EVENT_UNFAIR_FIGHT:
                    if (!ValidThreatlist() || shouldDespawn)
                    {
                        SetHomePosition();
                        me->RemoveAllMinionsByEntry(CREEPING_DOOM_ENTRY);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1 | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                        me->CombatStop(true);
                        me->MonsterSay(NELSON_DESPAWN_SAY, LANG_UNIVERSAL, 0);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        me->DespawnOrUnsummon(5000);
                        break;
                    }
                    events.RepeatEvent(2000);
                    break;
                case NELSON_EVENT_CREEPING_DOOM:
                    me->CastSpell(me->GetVictim(), NELSON_SPELL_CREEPING_DOOM, false);
                    events.RepeatEvent(urand(10000, 12000));
                    break;
                case NELSON_EVENT_DREADFUL_FRIGHT:
                    me->CastSpell(me->GetVictim(), NELSON_SPELL_DREADFUL_FRIGHT, false);
                    events.RepeatEvent(urand(12000, 19000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* /*Caster*/, const SpellInfo* Spell) override
        {
            if (InNormalForm())
            {
                return;
            }

            if (me->HasAura(NELSON_SPELL_SOUL_FLAME) && me->HasAura(NELSON_WEAKNESS_FROST_TRAP))
            {
                me->RemoveAura(NELSON_SPELL_SOUL_FLAME);
            }

            if (!me->HasAura(NELSON_SPELL_CRIPPLING_CLIP) && Spell->Id == NELSON_WEAKNESS_WING_CLIP)
            {
                me->AddAura(NELSON_SPELL_CRIPPLING_CLIP, me);
                me->MonsterTextEmote(NELSON_WEAKNESS_EMOTE, 0);
            }
        }

        void DamageTaken(Unit* attacker, uint32& /*damage*/, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            StoreAttackerGuidValue(attacker);
        }

        void DoAction(int32 action) override
        {
            if (action == EVENT_ENCOUNTER_START)
            {
                PrepareForEncounter();
                events.ScheduleEvent(EVENT_ENCOUNTER_START, 5000);
            }
        }
    };

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
    {
        CloseGossipMenuFor(player);
        creature->AI()->DoAction(EVENT_ENCOUNTER_START);

        return true;
    }

    bool OnGossipHello(Player *player, Creature * creature) override
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(NELSON_HEAD, 1, true))
        {
            std::string const& gossipOptionText = sCreatureTextMgr->GetLocalizedChatString(NELSON_GOSSIP_OPTION_TEXT, 0, 0, 0, LOCALE_enUS);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, gossipOptionText, GOSSIP_SENDER_MAIN, 0);
        }

        SendGossipMenuFor(player, NELSON_GOSSIP_TEXT, creature->GetGUID());

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

        void JustDied(Unit* killer) override
        {
            // Prevent looting if killer doesn't have the quest
            ClearLootIfUnfair(killer);
        }

        void Reset() override
        {
            encounterStarted = false;
            playerGUID.Clear();
            attackerGuids.clear();
            events.Reset();

            if (InNormalForm())
            {
                me->m_Events.KillAllEvents(true);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }
        }

        void AttackStart(Unit* target) override
        {
            if (playerGUID.IsEmpty() && !InNormalForm())
            {
                StorePlayerGUID();
            }

            ScriptedAI::AttackStart(target);
        }

         void EnterCombat(Unit* /*victim*/) override
        {
            RevealForm();
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

            if (InNormalForm())
            {
                events.ScheduleEvent(EVENT_FOOLS_PLIGHT, urand(2000, 3000));
            }
            else
            {
                events.ScheduleEvent(FRANKLIN_EVENT_DEMONIC_ENRAGE, urand(9000, 13000));
                events.ScheduleEvent(EVENT_RANGE_CHECK, 1000);
                events.ScheduleEvent(EVENT_UNFAIR_FIGHT, 1000);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            uint32 eventId = events.ExecuteEvent();

            // Out of combat events
            switch (eventId)
            {
                case EVENT_ENCOUNTER_START:
                    me->MonsterSay(FRANKLIN_SAY, LANG_UNIVERSAL, GetGossipPlayer());
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    events.ScheduleEvent(EVENT_REVEAL, 5000);
                    break;
                case EVENT_REVEAL:
                    RevealForm();
                    break;
            }

            if (UpdateVictim())
            {
                // This should prevent hunters from staying in combat when feign death is used and there is a bystander with 0 threat
                if (!playerGUID.IsEmpty() && ObjectAccessor::GetPlayer(*me, playerGUID)->HasAura(5384))
                {
                    playerGUID.Clear();
                    EnterEvadeMode();
                    return;
                }
            }
            else
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                events.RepeatEvent(1000);
                return;
            }

            // In combat events
            switch (eventId)
            {
                case EVENT_FOOLS_PLIGHT:
                    me->CastSpell(me->GetVictim(), SPELL_FOOLS_PLIGHT, true);
                    events.RepeatEvent(urand(6000, 9000));
                    break;
                case EVENT_RANGE_CHECK:
                    if (!me->GetVictim()->IsWithinDist2d(me, 60.0f))
                    {
                        EnterEvadeMode();
                    }
                    else
                    {
                        events.RepeatEvent(2000);
                    }
                    break;
                case EVENT_UNFAIR_FIGHT:
                    if (!ValidThreatlist())
                    {
                        SetHomePosition();
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1 | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                        me->CombatStop(true);
                        me->MonsterSay(FRANKLIN_DESPAWN_SAY, LANG_UNIVERSAL, 0);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        me->DespawnOrUnsummon(5000);
                        break;
                    }
                    events.RepeatEvent(2000);
                    break;
                case FRANKLIN_EVENT_DEMONIC_ENRAGE:
                    me->CastSpell(me, FRANKLIN_SPELL_DEMONIC_ENRAGE, false);
                    me->MonsterTextEmote(FRANKLIN_ENRAGE_EMOTE, 0);
                    events.RepeatEvent(urand(9000, 22000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* /*Caster*/, const SpellInfo* Spell) override
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

        void DamageTaken(Unit* attacker, uint32& /*damage*/, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override
        {
            StoreAttackerGuidValue(attacker);
        }

        void ScheduleEncounterStart(ObjectGuid playerGUID)
        {
            PrepareForEncounter();
            gossipPlayerGUID = playerGUID;
            events.ScheduleEvent(EVENT_ENCOUNTER_START, 5000);
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

    bool OnGossipHello(Player *player, Creature * creature) override
    {
        if (player->GetQuestStatus(QUEST_STAVE_OF_THE_ANCIENTS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(FRANKLIN_HEAD, 1, true))
        {
            std::string const& gossipOptionText = sCreatureTextMgr->GetLocalizedChatString(FRANKLIN_GOSSIP_OPTION_TEXT, 0, 0, 0, LOCALE_enUS);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, gossipOptionText, GOSSIP_SENDER_MAIN, 0);
        }

        SendGossipMenuFor(player, FRANKLIN_GOSSIP_TEXT, creature->GetGUID());

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
