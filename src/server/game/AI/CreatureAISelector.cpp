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

#include "CreatureAISelector.h"
#include "Creature.h"
#include "CreatureAIFactory.h"
#include "MovementGenerator.h"
#include "PassiveAI.h"
#include "Pet.h"
#include "ScriptMgr.h"
#include "TemporarySummon.h"

namespace FactorySelector
{
    CreatureAI* selectAI(Creature* creature)
    {
        const CreatureAICreator* ai_factory = nullptr;
        CreatureAIRegistry& ai_registry(*CreatureAIRegistry::instance());

        // xinef: if we have controlable guardian, define petai for players as they can steer him, otherwise db / normal ai
        // xinef: dont remember why i changed this qq commented out as may break some quests
        if (creature->IsPet()/* || (creature->HasUnitTypeMask(UNIT_MASK_CONTROLABLE_GUARDIAN) && ((Guardian*)creature)->GetOwner()->GetTypeId() == TYPEID_PLAYER)*/)
            ai_factory = ai_registry.GetRegistryItem("PetAI");

        //scriptname in db
        if (!ai_factory)
            if (CreatureAI* scriptedAI = sScriptMgr->GetCreatureAI(creature))
                return scriptedAI;

        // AIname in db
        std::string ainame = creature->GetAIName();
        if (!ai_factory && !ainame.empty())
            ai_factory = ai_registry.GetRegistryItem(ainame);

        // select by NPC flags
        if (!ai_factory)
        {
            if (creature->IsVehicle())
                ai_factory = ai_registry.GetRegistryItem("VehicleAI");
            else if (creature->HasUnitTypeMask(UNIT_MASK_CONTROLABLE_GUARDIAN) && ((Guardian*)creature)->GetOwner()->GetTypeId() == TYPEID_PLAYER)
                ai_factory = ai_registry.GetRegistryItem("PetAI");
            else if (creature->HasNpcFlag(UNIT_NPC_FLAG_SPELLCLICK))
                ai_factory = ai_registry.GetRegistryItem("NullCreatureAI");
            else if (creature->IsGuard())
                ai_factory = ai_registry.GetRegistryItem("GuardAI");
            else if (creature->HasUnitTypeMask(UNIT_MASK_CONTROLABLE_GUARDIAN))
                ai_factory = ai_registry.GetRegistryItem("PetAI");
            else if (creature->IsTotem())
                ai_factory = ai_registry.GetRegistryItem("TotemAI");
            else if (creature->IsTrigger())
            {
                if (creature->m_spells[0])
                    ai_factory = ai_registry.GetRegistryItem("TriggerAI");
                else
                    ai_factory = ai_registry.GetRegistryItem("NullCreatureAI");
            }
            else if (creature->IsCritter() && !creature->HasUnitTypeMask(UNIT_MASK_GUARDIAN))
                ai_factory = ai_registry.GetRegistryItem("CritterAI");
        }

        // select by permit check
        if (!ai_factory)
        {
            int best_val = -1;
            typedef CreatureAIRegistry::RegistryMapType RMT;
            RMT const& l = ai_registry.GetRegisteredItems();
            for (RMT::const_iterator iter = l.begin(); iter != l.end(); ++iter)
            {
                const CreatureAICreator* factory = iter->second;
                const SelectableAI* p = dynamic_cast<const SelectableAI*>(factory);
                ASSERT(p);
                int val = p->Permit(creature);
                if (val > best_val)
                {
                    best_val = val;
                    ai_factory = p;
                }
            }
        }

        // select NullCreatureAI if not another cases
        ainame = (!ai_factory) ? "NullCreatureAI" : ai_factory->key();
        LOG_DEBUG("scripts.ai", "Creature {} used AI is {}.", creature->GetGUID().ToString(), ainame);
        return (!ai_factory ? new NullCreatureAI(creature) : ai_factory->Create(creature));
    }

    MovementGenerator* selectMovementGenerator(Creature* creature)
    {
        MovementGeneratorRegistry& mv_registry(*MovementGeneratorRegistry::instance());
        ASSERT(creature->GetCreatureTemplate());
        const MovementGeneratorCreator* mv_factory = mv_registry.GetRegistryItem(creature->GetDefaultMovementType());

        /* if (mv_factory == nullptr)
        {
            int best_val = -1;
            std::vector<std::string> l;
            mv_registry.GetRegisteredItems(l);
            for (std::vector<std::string>::iterator iter = l.begin(); iter != l.end(); ++iter)
            {
            const MovementGeneratorCreator *factory = mv_registry.GetRegistryItem((*iter).c_str());
            const SelectableMovement *p = dynamic_cast<const SelectableMovement *>(factory);
            ASSERT(p != nullptr);
            int val = p->Permit(creature);
            if (val > best_val)
            {
                best_val = val;
                mv_factory = p;
            }
            }
        }*/

        return (!mv_factory ? nullptr : mv_factory->Create(creature));
    }

    GameObjectAI* SelectGameObjectAI(GameObject* go)
    {
        const GameObjectAICreator* ai_factory = nullptr;
        GameObjectAIRegistry& ai_registry(*GameObjectAIRegistry::instance());

        if (GameObjectAI* scriptedAI = sScriptMgr->GetGameObjectAI(go))
            return scriptedAI;

        ai_factory = ai_registry.GetRegistryItem(go->GetAIName());

        //future goAI types go here

        std::string ainame = (!ai_factory || go->GetScriptId()) ? "NullGameObjectAI" : ai_factory->key();
        LOG_DEBUG("scripts.ai", "GameObject {} used AI is {}.", go->GetGUID().ToString(), ainame);

        return (!ai_factory ? new NullGameObjectAI(go) : ai_factory->Create(go));
    }
}
