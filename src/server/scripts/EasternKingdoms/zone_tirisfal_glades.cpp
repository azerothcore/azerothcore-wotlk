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

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"

/*######
## npc_calvin_montague
######*/

enum Calvin
{
    SAY_COMPLETE    = 0,
    SPELL_FOOD      = 7737,
    QUEST_590       = 590
};

enum event
{
    EVENT_EMOTE                     = 1,
    EVENT_TALK                      = 2,
    EVENT_DRINK_AND_QUEST_COMQUEST  = 3,
    EVENT_END                       = 4
};

class npc_calvin_montague : public CreatureScript
{
public:
    npc_calvin_montague() : CreatureScript("npc_calvin_montague") {}

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_590)
        {
            creature->SetFaction(FACTION_MONSTER);
            creature->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
            creature->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);//This is reset when out of combat
            creature->SetUnitFlag(UNIT_FLAG_PET_IN_COMBAT);
            creature->SetReactState(REACT_AGGRESSIVE);
            creature->AI()->AttackStart(player);
        }
        return true;
    }

    struct npc_calvin_montagueAI : public ScriptedAI
    {
        npc_calvin_montagueAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() override
        {
            if (!m_uiPhase)
            {
                me->SetReactState(REACT_DEFENSIVE);
                me->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
            }
        }

        void JustReachedHome() override
        {
            if (m_uiPhase)
                events.ScheduleEvent(EVENT_EMOTE, 2500ms);
            else
                events.ScheduleEvent(EVENT_END, 3min);
       }

        void JustEngagedWith(Unit* /*who*/) override
        {
            m_uiPhase = 0;
            events.Reset();
        }

        void DamageTaken(Unit* pDoneBy, uint32& uiDamage, DamageEffectType, SpellSchoolMask) override
        {
            if (!pDoneBy)
                return;

            if (uiDamage >= me->GetHealth())
            {
                uiDamage = 0;
                me->SetHealth(1);
            }

            if (pDoneBy->GetTypeId() == TYPEID_PLAYER)
            {
                m_uiPlayerGUID = pDoneBy->GetGUID();
            }
            else if (pDoneBy->IsPet())
            {
                if (Unit* owner = pDoneBy->GetOwner())
                {
                    // not sure if this is needed.
                    if (owner->GetTypeId() == TYPEID_PLAYER)
                    {
                        m_uiPlayerGUID = owner->GetGUID();
                    }
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!m_uiPhase && me->HealthBelowPct(30))
            {
                m_uiPhase = 1;
                me->RestoreFaction();
                me->RemoveAllAuras();
                me->CombatStop(true);
                EnterEvadeMode();
            }
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_EMOTE:
                        if (Player* player = ObjectAccessor::GetPlayer(*me, m_uiPlayerGUID))
                            me->SetFacingToObject(player);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_RUDE);
                        events.ScheduleEvent(EVENT_TALK, 4s);
                        break;
                    case EVENT_TALK:
                        me->AI()->Talk(SAY_COMPLETE);
                        events.ScheduleEvent(EVENT_DRINK_AND_QUEST_COMQUEST, 6300ms);
                        break;
                    case EVENT_DRINK_AND_QUEST_COMQUEST:
                        DoCastSelf(SPELL_FOOD);
                        //Sniffing is used with spell 7737, but this will immediately interrupt the visual effect of eating
                        //It seems that Blizzard forgot to take this move into EVENT_END events
                        me->SetStandState(UNIT_STAND_STATE_STAND);
                        if (Player* player = ObjectAccessor::GetPlayer(*me, m_uiPlayerGUID))
                            player->AreaExploredOrEventHappens(QUEST_590);
                        events.ScheduleEvent(EVENT_END, 12900ms);
                        break;
                    case EVENT_END:
                        me->RestoreFaction();
                        me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_QUESTGIVER);
                        me->SetStandState(UNIT_STAND_STATE_STAND);
                        me->SetSheath(SHEATH_STATE_MELEE);
                        m_uiPlayerGUID.Clear();
                        m_uiPhase = 0;
                        me->GetMotionMaster()->Initialize();
                        events.Reset();
                        break;
                    default:
                        break;
                }
            }

            if (!UpdateVictim())
                return;
            DoMeleeAttackIfReady();
        }

    private:
        uint32 m_uiPhase = 0;
        ObjectGuid m_uiPlayerGUID;
    };
    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_calvin_montagueAI(creature);
    }
};

void AddSC_tirisfal_glades()
{
    new npc_calvin_montague();
}
