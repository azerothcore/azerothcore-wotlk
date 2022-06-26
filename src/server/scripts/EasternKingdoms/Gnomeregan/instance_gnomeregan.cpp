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

#include "InstanceScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "gnomeregan.h"

class instance_gnomeregan : public InstanceMapScript
{
public:
    instance_gnomeregan() : InstanceMapScript("instance_gnomeregan", 90) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_gnomeregan_InstanceMapScript(map);
    }

    struct instance_gnomeregan_InstanceMapScript : public InstanceScript
    {
        instance_gnomeregan_InstanceMapScript(Map* map) : InstanceScript(map)
        {
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_EMI_SHORTFUSE:
                    if (_encounters[TYPE_GRUBBIS] == DONE)
                    {
                        creature->DespawnOrUnsummon();
                    }
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* gameobject) override
        {
            switch (gameobject->GetEntry())
            {
                case GO_CAVE_IN_1:
                case GO_CAVE_IN_2:
                case GO_WORKSHOP_DOOR:
                case GO_FINAL_CHAMBER_DOOR:
                    gameobject->UpdateSaveToDb(true);
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
            case TYPE_GRUBBIS:
                _encounters[type] = data;
                break;
            }

            if (data == DONE)
                SaveToDB();
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "D E " << _encounters[0];
            return saveStream.str();
        }

        void Load(const char* in) override
        {
            if (!in)
                return;

            char dataHead1, dataHead2;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;
            if (dataHead1 == 'D' && dataHead2 == 'E')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                {
                    loadStream >> _encounters[i];
                    if (_encounters[i] == IN_PROGRESS)
                        _encounters[i] = NOT_STARTED;
                }
            }
        }

    private:
        uint32 _encounters[MAX_ENCOUNTERS];
    };
};

enum eKernobee
{
    QUEST_A_FINE_MESS           = 2904,
};

class npc_kernobee : public CreatureScript
{
public:
    npc_kernobee() : CreatureScript("npc_kernobee") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetGnomereganAI<npc_kernobeeAI>(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) override
    {
        if (quest->GetQuestId() == QUEST_A_FINE_MESS)
        {
            creature->SetStandState(UNIT_STAND_STATE_STAND);
            creature->AI()->SetGUID(player->GetGUID(), 0);
            creature->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, M_PI, MOTION_SLOT_CONTROLLED);
        }
        return true;
    }

    struct npc_kernobeeAI : public PassiveAI
    {
        npc_kernobeeAI(Creature* creature) : PassiveAI(creature)
        {
            checkTimer = 0;
        }

        uint32 checkTimer;
        ObjectGuid playerGUID;

        void SetGUID(ObjectGuid guid, int32) override
        {
            playerGUID = guid;
        }

        void UpdateAI(uint32 diff) override
        {
            checkTimer += diff;
            if (checkTimer >= 2000)
            {
                checkTimer = 0;
                if (me->GetDistance(-332.2f, -2.8f, -152.8f) < 5.0f)
                {
                    if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                        player->GroupEventHappens(QUEST_A_FINE_MESS, me);
                    me->DespawnOrUnsummon(1000);
                }
            }
        }
    };
};

class spell_gnomeregan_radiation_bolt : public SpellScriptLoader
{
public:
    spell_gnomeregan_radiation_bolt() : SpellScriptLoader("spell_gnomeregan_radiation_bolt") { }

    class spell_gnomeregan_radiation_bolt_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_gnomeregan_radiation_bolt_SpellScript);

        void HandleTriggerSpell(SpellEffIndex effIndex)
        {
            if (roll_chance_i(80))
                PreventHitDefaultEffect(effIndex);
        }

        void Register() override
        {
            OnEffectHit += SpellEffectFn(spell_gnomeregan_radiation_bolt_SpellScript::HandleTriggerSpell, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_gnomeregan_radiation_bolt_SpellScript;
    }
};

void AddSC_instance_gnomeregan()
{
    new instance_gnomeregan();
    new npc_kernobee();
    new spell_gnomeregan_radiation_bolt();
}
