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

#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "gnomeregan.h"

class instance_gnomeregan : public InstanceMapScript
{
public:
    instance_gnomeregan() : InstanceMapScript("instance_gnomeregan", MAP_GNOMEREGAN) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_gnomeregan_InstanceMapScript(map);
    }

    struct instance_gnomeregan_InstanceMapScript : public InstanceScript
    {
        instance_gnomeregan_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
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
                    gameobject->AllowSaveToDB(true);
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

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> _encounters[TYPE_GRUBBIS];
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << _encounters[TYPE_GRUBBIS];
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

        void SetGUID(ObjectGuid const& guid, int32) override
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
                    me->DespawnOrUnsummon(1s);
                }
            }
        }
    };
};

class spell_gnomeregan_radiation_bolt : public SpellScript
{
    PrepareSpellScript(spell_gnomeregan_radiation_bolt);

    void HandleTriggerSpell(SpellEffIndex effIndex)
    {
        if (roll_chance_i(80))
            PreventHitDefaultEffect(effIndex);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_gnomeregan_radiation_bolt::HandleTriggerSpell, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
    }
};

void AddSC_instance_gnomeregan()
{
    new instance_gnomeregan();
    new npc_kernobee();
    RegisterSpellScript(spell_gnomeregan_radiation_bolt);
}
