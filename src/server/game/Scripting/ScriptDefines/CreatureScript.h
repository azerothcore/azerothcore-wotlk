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

#ifndef SCRIPT_OBJECT_CREATURE_SCRIPT_H_
#define SCRIPT_OBJECT_CREATURE_SCRIPT_H_

#include "QuestDef.h"
#include "ScriptObject.h"

class CreatureScript : public ScriptObject, public UpdatableScript<Creature>
{
protected:
    CreatureScript(const char* name);

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return true; }

    // Called when a player opens a gossip dialog with the creature.
    [[nodiscard]] virtual bool OnGossipHello(Player* /*player*/, Creature* /*creature*/) { return false; }

    // Called when a player selects a gossip item in the creature's gossip menu.
    [[nodiscard]] virtual bool OnGossipSelect(Player* /*player*/, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/) { return false; }

    // Called when a player selects a gossip with a code in the creature's gossip menu.
    [[nodiscard]] virtual bool OnGossipSelectCode(Player* /*player*/, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/, const char* /*code*/) { return false; }

    // Called when a player accepts a quest from the creature.
    [[nodiscard]] virtual bool OnQuestAccept(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) { return false; }

    // Called when a player selects a quest in the creature's quest menu.
    [[nodiscard]] virtual bool OnQuestSelect(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) { return false; }

    // Called when a player completes a quest with the creature.
    [[nodiscard]] virtual bool OnQuestComplete(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) { return false; }

    // Called when a player selects a quest reward.
    [[nodiscard]] virtual bool OnQuestReward(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/, uint32 /*opt*/) { return false; }

    // Called when the dialog status between a player and the creature is requested.
    virtual uint32 GetDialogStatus(Player* /*player*/, Creature* /*creature*/) { return DIALOG_STATUS_SCRIPTED_NO_STATUS; }

    // Called when a CreatureAI object is needed for the creature.
    virtual CreatureAI* GetAI(Creature* /*creature*/) const { return nullptr; }

    //Called whenever the UNIT_BYTE2_FLAG_FFA_PVP bit is Changed on the player
    virtual void OnFfaPvpStateUpdate(Creature* /*player*/, bool /*result*/) { }
};

template <class AI>
class GenericCreatureScript : public CreatureScript
{
public:
    GenericCreatureScript(char const* name) : CreatureScript(name) { }
    CreatureAI* GetAI(Creature* me) const override { return new AI(me); }
};

#define RegisterCreatureAI(ai_name) new GenericCreatureScript<ai_name>(#ai_name)

template <class AI, AI*(*AIFactory)(Creature*)>
class FactoryCreatureScript : public CreatureScript
{
public:
    FactoryCreatureScript(char const* name) : CreatureScript(name) { }
    CreatureAI* GetAI(Creature* me) const override { return AIFactory(me); }
};

#define RegisterCreatureAIWithFactory(ai_name, factory_fn) new FactoryCreatureScript<ai_name, &factory_fn>(#ai_name)

#endif
