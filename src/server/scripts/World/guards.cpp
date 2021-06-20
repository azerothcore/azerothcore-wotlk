/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "GuardAI.h"
#include "Player.h"
#include "SpellInfo.h"

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

        void Reset()
        {
            banishTimer = 5000;
            exileTimer = 8500;
            playerGUID = 0;
            canTeleport = false;
        }

        void UpdateAI(uint32 diff)
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
                    playerGUID = 0;
                    exileTimer = 8500;
                    canTeleport = false;
                } else exileTimer -= diff;
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
            } else banishTimer -= diff;

            DoMeleeAttackIfReady();
        }

    private:
        uint32 exileTimer;
        uint32 banishTimer;
        uint64 playerGUID;
        bool canTeleport;
    };

    CreatureAI* GetAI(Creature* creature) const
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

        void Reset()
        {
            banishTimer = 5000;
            exileTimer = 8500;
            playerGUID = 0;
            canTeleport = false;
        }

        void UpdateAI(uint32 diff)
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
                    playerGUID = 0;
                    exileTimer = 8500;
                    canTeleport = false;
                } else exileTimer -= diff;
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
            } else banishTimer -= diff;

            DoMeleeAttackIfReady();
        }
    private:
        uint32 exileTimer;
        uint32 banishTimer;
        uint64 playerGUID;
        bool canTeleport;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new guard_shattrath_aldorAI(creature);
    }
};

void AddSC_guards()
{
    new guard_shattrath_aldor();
    new guard_shattrath_scryer();
}
