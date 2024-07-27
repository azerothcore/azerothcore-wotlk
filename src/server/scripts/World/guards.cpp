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
SDName: Guards
SD%Complete: 100
SDComment:
SDCategory: Guards
EndScriptData */

/* ContentData
guard_generic
guard_shattrath_aldor
guard_shattrath_scryer
EndContentData */

#include "CreatureScript.h"
#include "GuardAI.h"
#include "Player.h"
#include "ScriptedCreature.h"

enum GuardShattrath
{
    SPELL_BANISHED_SHATTRATH_A = 36642,
    SPELL_BANISHED_SHATTRATH_S = 36671,
    SPELL_BANISH_TELEPORT      = 36643,
    SPELL_EXILE                = 39533
};

class guard_shattrath_scryer : public CreatureScript
{
public:
    guard_shattrath_scryer() : CreatureScript("guard_shattrath_scryer") { }

    struct guard_shattrath_scryerAI : public GuardAI
    {
        guard_shattrath_scryerAI(Creature* creature) : GuardAI(creature) { }

        void Reset() override
        {
            banishTimer = 5000;
            exileTimer = 8500;
            playerGUID.Clear();
            canTeleport = false;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (canTeleport)
            {
                if (exileTimer <= diff)
                {
                    if (Unit* temp = ObjectAccessor::GetUnit(*me, playerGUID))
                    {
                        temp->CastSpell(temp, SPELL_EXILE, true);
                        temp->CastSpell(temp, SPELL_BANISH_TELEPORT, true);
                    }
                    playerGUID.Clear();
                    exileTimer = 8500;
                    canTeleport = false;
                }
                else exileTimer -= diff;
            }
            else if (banishTimer <= diff)
            {
                Unit* temp = me->GetVictim();
                if (temp && temp->GetTypeId() == TYPEID_PLAYER)
                {
                    DoCast(temp, SPELL_BANISHED_SHATTRATH_A);
                    banishTimer = 9000;
                    playerGUID = temp->GetGUID();
                    if (playerGUID)
                        canTeleport = true;
                }
            }
            else banishTimer -= diff;

            DoMeleeAttackIfReady();
        }

    private:
        uint32 exileTimer;
        uint32 banishTimer;
        ObjectGuid playerGUID;
        bool canTeleport;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new guard_shattrath_scryerAI(creature);
    }
};

class guard_shattrath_aldor : public CreatureScript
{
public:
    guard_shattrath_aldor() : CreatureScript("guard_shattrath_aldor") { }

    struct guard_shattrath_aldorAI : public GuardAI
    {
        guard_shattrath_aldorAI(Creature* creature) : GuardAI(creature) { }

        void Reset() override
        {
            banishTimer = 5000;
            exileTimer = 8500;
            playerGUID.Clear();
            canTeleport = false;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (canTeleport)
            {
                if (exileTimer <= diff)
                {
                    if (Unit* temp = ObjectAccessor::GetUnit(*me, playerGUID))
                    {
                        temp->CastSpell(temp, SPELL_EXILE, true);
                        temp->CastSpell(temp, SPELL_BANISH_TELEPORT, true);
                    }
                    playerGUID.Clear();
                    exileTimer = 8500;
                    canTeleport = false;
                }
                else exileTimer -= diff;
            }
            else if (banishTimer <= diff)
            {
                Unit* temp = me->GetVictim();
                if (temp && temp->GetTypeId() == TYPEID_PLAYER)
                {
                    DoCast(temp, SPELL_BANISHED_SHATTRATH_S);
                    banishTimer = 9000;
                    playerGUID = temp->GetGUID();
                    if (playerGUID)
                        canTeleport = true;
                }
            }
            else banishTimer -= diff;

            DoMeleeAttackIfReady();
        }
    private:
        uint32 exileTimer;
        uint32 banishTimer;
        ObjectGuid playerGUID;
        bool canTeleport;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new guard_shattrath_aldorAI(creature);
    }
};

void AddSC_guards()
{
    new guard_shattrath_aldor();
    new guard_shattrath_scryer();
}
