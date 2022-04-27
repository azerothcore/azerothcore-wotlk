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

/* ScriptData
SDName: Stranglethorn_Vale
SD%Complete: 100
SDComment: Quest support: 592
SDCategory: Stranglethorn Vale
EndScriptData */

/* ContentData
npc_yenniku
EndContentData */

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"

/*######
## npc_yenniku
######*/

class npc_yenniku : public CreatureScript
{
public:
    npc_yenniku() : CreatureScript("npc_yenniku") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_yennikuAI(creature);
    }

    struct npc_yennikuAI : public ScriptedAI
    {
        npc_yennikuAI(Creature* creature) : ScriptedAI(creature)
        {
            bReset = false;
        }

        uint32 Reset_Timer;
        bool bReset;

        void Reset() override
        {
            Reset_Timer = 0;
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (bReset || spell->Id != 3607)
                return;

            if (Player* player = caster->ToPlayer())
            {
                if (player->GetQuestStatus(592) == QUEST_STATUS_INCOMPLETE)     //Yenniku's Release
                {
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_STUN);
                    me->CombatStop();                                           //stop combat
                    me->GetThreatMgr().ClearAllThreat();                        //unsure of this
                    me->SetFaction(FACTION_HORDE_GENERIC);

                    bReset = true;
                    Reset_Timer = 60000;
                }
            }
        }

        void EnterCombat(Unit* /*who*/) override { }

        void UpdateAI(uint32 diff) override
        {
            if (bReset)
            {
                if (Reset_Timer <= diff)
                {
                    EnterEvadeMode();
                    bReset = false;
                    me->SetFaction(FACTION_TROLL_BLOODSCALP);
                    return;
                }

                Reset_Timer -= diff;

                if (me->IsInCombat() && me->GetVictim())
                {
                    if (Player* player = me->GetVictim()->ToPlayer())
                    {
                        if (player->GetTeamId() == TEAM_HORDE)
                        {
                            me->CombatStop();
                            me->GetThreatMgr().ClearAllThreat();
                        }
                    }
                }
            }

            //Return since we have no target
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
##
######*/

void AddSC_stranglethorn_vale()
{
    new npc_yenniku();
}
