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

#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "InstanceScript.h"
#include "ScriptMgr.h"
#include "TemporarySummon.h"
#include "zulfarrak.h"

class instance_zulfarrak : public InstanceMapScript
{
public:
    instance_zulfarrak() : InstanceMapScript("instance_zulfarrak", 209) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_zulfarrak_InstanceMapScript(map);
    }

    struct instance_zulfarrak_InstanceMapScript : public InstanceScript
    {
        instance_zulfarrak_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            _pyramidEventProgress = NOT_STARTED;
            _gahzrillaSummoned = NOT_STARTED;
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            if (gameobject->GetEntry() == GO_END_DOOR && _pyramidEventProgress == DONE)
                gameobject->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == TYPE_PYRAMID_EVENT)
                return _pyramidEventProgress;
            return 0;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_PYRAMID_EVENT:
                    _pyramidEventProgress = data;
                    break;
                case TYPE_GAHZRILLA:
                    _gahzrillaSummoned = data;
                    break;
            }

            SaveToDB();
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "Z F " << _pyramidEventProgress << ' ' << _gahzrillaSummoned;
            return saveStream.str();
        }

        void Load(const char* str) override
        {
            if (!str)
                return;

            char dataHead1, dataHead2;
            std::istringstream loadStream(str);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'Z' && dataHead2 == 'F')
            {
                loadStream >> _pyramidEventProgress;
                loadStream >> _gahzrillaSummoned;
            }
        }

    private:
        uint32 _pyramidEventProgress;
        uint32 _gahzrillaSummoned;
    };
};

// 10247 - Summon Zul'Farrak Zombies
class spell_zulfarrak_summon_zulfarrak_zombies : public SpellScriptLoader
{
public:
    spell_zulfarrak_summon_zulfarrak_zombies() : SpellScriptLoader("spell_zulfarrak_summon_zulfarrak_zombies") { }

    class spell_zulfarrak_summon_zulfarrak_zombies_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_zulfarrak_summon_zulfarrak_zombies_SpellScript);

        void HandleSummon(SpellEffIndex effIndex)
        {
            if (effIndex == EFFECT_0)
            {
                if (roll_chance_i(30))
                {
                    PreventHitDefaultEffect(effIndex);
                    return;
                }
            }
            else if (roll_chance_i(40))
            {
                PreventHitDefaultEffect(effIndex);
                return;
            }
        }

        void Register() override
        {
            OnEffectHit += SpellEffectFn(spell_zulfarrak_summon_zulfarrak_zombies_SpellScript::HandleSummon, EFFECT_0, SPELL_EFFECT_SUMMON);
            OnEffectHit += SpellEffectFn(spell_zulfarrak_summon_zulfarrak_zombies_SpellScript::HandleSummon, EFFECT_1, SPELL_EFFECT_SUMMON);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_zulfarrak_summon_zulfarrak_zombies_SpellScript;
    }
};

// 10738 - Unlocking
class spell_zulfarrak_unlocking : public SpellScriptLoader
{
public:
    spell_zulfarrak_unlocking() : SpellScriptLoader("spell_zulfarrak_unlocking") { }

    class spell_zulfarrak_unlocking_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_zulfarrak_unlocking_SpellScript);

        void HandleOpenLock(SpellEffIndex  /*effIndex*/)
        {
            GameObject* cage = GetHitGObj();
            std::list<WorldObject*> cagesList;
            Acore::AllWorldObjectsInRange objects(GetCaster(), 15.0f);
            Acore::WorldObjectListSearcher<Acore::AllWorldObjectsInRange> searcher(GetCaster(), cagesList, objects);
            Cell::VisitAllObjects(GetCaster(), searcher, 15.0f);
            for (std::list<WorldObject*>::const_iterator itr = cagesList.begin(); itr != cagesList.end(); ++itr)
            {
                if (GameObject* go = (*itr)->ToGameObject())
                    if (go->GetDisplayId() == cage->GetDisplayId())
                        go->UseDoorOrButton(0, false, GetCaster());
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_zulfarrak_unlocking_SpellScript::HandleOpenLock, EFFECT_0, SPELL_EFFECT_OPEN_LOCK);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_zulfarrak_unlocking_SpellScript();
    }
};

void AddSC_instance_zulfarrak()
{
    new instance_zulfarrak();
    new spell_zulfarrak_summon_zulfarrak_zombies();
    new spell_zulfarrak_unlocking();
}
