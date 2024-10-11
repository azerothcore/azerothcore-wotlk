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

#include "zulfarrak.h"
#include "Cell.h"
#include "CellImpl.h"
#include "CreatureScript.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "GridNotifiers.h"
#include "InstanceScript.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptSystem.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

/* ScriptData
SDName: Zulfarrak
SD%Complete: 50
SDComment: Consider it temporary, no instance script made for this instance yet.
SDCategory: Zul'Farrak
EndScriptData */

/* ContentData
npc_sergeant_bly
npc_weegli_blastfuse
EndContentData */

/*######
## npc_sergeant_bly
######*/

enum blySays
{
    SAY_1 = 0,
    SAY_2 = 1
};

enum blySpells
{
    SPELL_BLYS_BAND_ESCAPE     = 11365,
    SPELL_SHIELD_BASH          = 11972,
    SPELL_REVENGE              = 12170
};

#define GOSSIP_BLY                  "That's it!  I'm tired of helping you out.  It's time we settled things on the battlefield!"

class npc_sergeant_bly : public CreatureScript
{
public:
    npc_sergeant_bly() : CreatureScript("npc_sergeant_bly") { }

    struct npc_sergeant_blyAI : public ScriptedAI
    {
        npc_sergeant_blyAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        void InitializeAI() override
        {
            ableToPortHome = false;
            startedFight = false;
            me->SetFaction(FACTION_FRIENDLY);
            postGossipStep = 0;
            Text_Timer = 0;
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
        }

        InstanceScript* instance;

        bool startedFight;
        bool ableToPortHome;
        uint32 postGossipStep;
        uint32 Text_Timer;
        uint32 ShieldBash_Timer;
        uint32 Revenge_Timer; //this is wrong, spell should never be used unless me->GetVictim() dodge, parry or block attack. Trinity support required.
        uint32 Porthome_Timer;
        ObjectGuid PlayerGUID;

        void Reset() override
        {
            ShieldBash_Timer = 5000;
            Revenge_Timer = 8000;
            Porthome_Timer = 156000;
            ableToPortHome = false;
            startedFight = false;
        }

        void EnterEvadeMode(EvadeReason /*reason*/) override
        {
            if (ableToPortHome)
                return;

            if (instance->GetData(DATA_PYRAMID) == PYRAMID_KILLED_ALL_TROLLS)
            {
                ableToPortHome = true;
                Porthome_Timer = 156000;
            }
        }

        void MovementInform(uint32 type, uint32 /*id*/) override
        {
            if (type != POINT_MOTION_TYPE)
            {
                return;
            }

            if (instance->GetData(DATA_PYRAMID) == PYRAMID_WAVE_3)
            {
                if (Creature* shadowpriest = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_SHADOWPRIEST_SEZZZIZ)))
                {
                    AttackStart(shadowpriest);
                    shadowpriest->CallAssistance();
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (postGossipStep > 0 && postGossipStep < 4)
            {
                if (Text_Timer <= diff)
                {
                    switch (postGossipStep)
                    {
                        case 1:
                            startedFight = true;
                            //weegli doesn't fight - he goes & blows up the door
                            if (Creature* pWeegli = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_WEEGLI)))
                            {
                                pWeegli->AI()->DoAction(0);
                            }
                            Talk(SAY_1);
                            Text_Timer = 5000;
                            break;
                        case 2:
                            Talk(SAY_2);
                            Text_Timer = 5000;
                            break;
                        case 3:
                            me->SetFaction(FACTION_MONSTER);
                            Player* target = ObjectAccessor::GetPlayer(*me, PlayerGUID);

                            switchFactionIfAlive(NPC_WEEGLI, target);
                            switchFactionIfAlive(NPC_RAVEN, target);
                            switchFactionIfAlive(NPC_ORO, target);
                            switchFactionIfAlive(NPC_MURTA, target);

                            if (target)
                            {
                                AttackStart(target);
                            }
                    }

                    postGossipStep++;
                }
                else
                {
                    Text_Timer -= diff;
                }
            }

            if (Porthome_Timer <= diff && ableToPortHome == true)
            {
                if (Creature* weegli = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_WEEGLI)))
                {
                    weegli->CastSpell(weegli, SPELL_BLYS_BAND_ESCAPE);
                    weegli->DespawnOrUnsummon(10000);
                }
                if (Creature* raven = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_RAVEN)))
                {
                    raven->CastSpell(raven, SPELL_BLYS_BAND_ESCAPE);
                    raven->DespawnOrUnsummon(10000);
                }
                if (Creature* oro = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_ORO)))
                {
                    oro->CastSpell(oro, SPELL_BLYS_BAND_ESCAPE);
                    oro->DespawnOrUnsummon(10000);
                }
                if (Creature* murta = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_MURTA)))
                {
                    murta->CastSpell(murta, SPELL_BLYS_BAND_ESCAPE);
                    murta->DespawnOrUnsummon(10000);
                }
                DoCastSelf(SPELL_BLYS_BAND_ESCAPE);
                me->DespawnOrUnsummon(10000);
                Porthome_Timer = 156000; //set timer back so that the event doesn't keep triggering
            }
            else
            {
                Porthome_Timer -= diff;
            }

            if (!UpdateVictim())
            {
                return;
            }

            if (ShieldBash_Timer <= diff)
            {
                DoCastVictim(SPELL_SHIELD_BASH);
                ShieldBash_Timer = 15000;
            }
            else
            {
                ShieldBash_Timer -= diff;
            }

            if (Revenge_Timer <= diff)
            {
                DoCastVictim(SPELL_REVENGE);
                Revenge_Timer = 10000;
            }
            else
            {
                Revenge_Timer -= diff;
            }

            DoMeleeAttackIfReady();
        }

        void DoAction(int32 /*param*/) override
        {
            ableToPortHome = false;
            postGossipStep = 1;
            Text_Timer = 0;
        }

        void switchFactionIfAlive(uint32 entry, Player* target)
        {
            if (Creature* crew = ObjectAccessor::GetCreature(*me, instance->GetGuidData(entry)))
            {
                if (crew->IsAlive())
                {
                    crew->SetFaction(FACTION_MONSTER);

                    if (target)
                    {
                        crew->AI()->AttackStart(target);
                    }
                }
            }
        }

        void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
        {
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            ClearGossipMenuFor(player);

            if (action == GOSSIP_ACTION_INFO_DEF + 1)
            {
                CloseGossipMenuFor(player);
                PlayerGUID = player->GetGUID();
                DoAction(0);
            }
        }

        void sGossipHello(Player* player) override
        {
            if (instance->GetData(DATA_PYRAMID) >= PYRAMID_MOVED_DOWNSTAIRS && !startedFight)
            {
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_BLY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                SendGossipMenuFor(player, 1517, me->GetGUID());
            }
            else
            {
                if (instance->GetData(DATA_PYRAMID) == PYRAMID_NOT_STARTED)
                {
                    SendGossipMenuFor(player, 1515, me->GetGUID());
                }
                else
                {
                    SendGossipMenuFor(player, 1516, me->GetGUID());
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulFarrakAI<npc_sergeant_blyAI>(creature);
    }
};

/*######
+## go_troll_cage
+######*/

class go_troll_cage : public GameObjectScript
{
public:
    go_troll_cage() : GameObjectScript("go_troll_cage") { }

    struct go_troll_cageAI : public GameObjectAI
    {
        go_troll_cageAI(GameObject* go) : GameObjectAI(go), instance(go->GetInstanceScript()) { }

        InstanceScript* instance;

        bool GossipHello(Player* /*player*/, bool reportUse) override
        {
            if (reportUse)
            {
                return true;
            }

            instance->SetData(DATA_PYRAMID, PYRAMID_CAGES_OPEN);

            //setting gossip option as soon as the cages open
            if (Creature* bly = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_BLY)))
            {
                bly->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            }

            if (Creature* weegli = ObjectAccessor::GetCreature(*me, instance->GetGuidData(NPC_WEEGLI)))
            {
                weegli->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            }

            //set bly & co to aggressive & start moving to top of stairs
            initBlyCrewMember(NPC_BLY, 1884.99f, 1263, 41.52f);
            initBlyCrewMember(NPC_RAVEN, 1882.5f, 1263, 41.52f);
            initBlyCrewMember(NPC_ORO, 1886.47f, 1270.68f, 41.68f);
            initBlyCrewMember(NPC_WEEGLI, 1890, 1263, 41.52f);
            initBlyCrewMember(NPC_MURTA, 1891.19f, 1272.03f, 41.60f);
            return false;
        }

    private:
        void initBlyCrewMember(uint32 entry, float x, float y, float z)
        {
            if (Creature* crew = ObjectAccessor::GetCreature(*me, instance->GetGuidData(entry)))
            {
                crew->SetReactState(REACT_AGGRESSIVE);
                crew->SetWalk(true);
                crew->SetHomePosition(x, y, z, 4.78f);
                crew->GetMotionMaster()->MovePoint(1, { x, y, z, 4.78f });
                crew->SetFaction(FACTION_ESCORT_N_NEUTRAL_ACTIVE);

            }
        }
    };

    GameObjectAI* GetAI(GameObject* go) const override
    {
        return GetZulFarrakAI<go_troll_cageAI>(go);
    }
};

/*######
## npc_weegli_blastfuse
######*/

enum weegliSpells
{
    SPELL_BOMB                  = 8858,
    SPELL_GOBLIN_LAND_MINE      = 21688,
    SPELL_SHOOT                 = 6660,
    SPELL_WEEGLIS_BARREL        = 10772
};

enum weegliSays
{
    SAY_WEEGLI_OHNO             = 0,
    SAY_WEEGLI_OK_I_GO          = 1,
    SAY_WEEGLI_OUT_OF_HERE      = 2
};

#define GOSSIP_WEEGLI               "Will you blow up that door now?"

class npc_weegli_blastfuse : public CreatureScript
{
public:
    npc_weegli_blastfuse() : CreatureScript("npc_weegli_blastfuse") { }

    struct npc_weegli_blastfuseAI : public ScriptedAI
    {
        npc_weegli_blastfuseAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
            destroyingDoor = false;
            outroTimer = 2000;
            outroStage = 0;
        }

        uint32 Bomb_Timer;
        uint32 LandMine_Timer;
        uint32 outroTimer;
        uint8 outroStage;
        bool destroyingDoor;
        InstanceScript* instance;

        void InitializeAI() override
        {
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            Reset();
        }

        void Reset() override
        {
            Bomb_Timer     = 10000;
            LandMine_Timer = 30000;
        }

        void AttackStart(Unit* victim) override
        {
            AttackStartCaster(victim, 10);//keep back & toss bombs/shoot
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                if (destroyingDoor)
                {
                    if (outroTimer <= diff)
                    {
                        switch (outroStage)
                        {
                            case 0:
                                DoCastSelf(SPELL_WEEGLIS_BARREL);
                                outroTimer = 2000;
                                ++outroStage;
                                break;
                            case 1:
                                me->GetMotionMaster()->MovePoint(2, 1871.18f, 1100.f, 8.88f);
                                Talk(SAY_WEEGLI_OUT_OF_HERE);
                                me->DespawnOrUnsummon(8000);
                                instance->SetData(DATA_PYRAMID, PYRAMID_GATES_DESTROYED);
                                destroyingDoor = false;
                                break;
                        }
                    }
                    else
                    {
                        outroTimer -= diff;
                    }
                }

                return;
            }

            if (Bomb_Timer <= diff)
            {
                DoCastVictim(SPELL_BOMB);
                Bomb_Timer = 10000;
            }
            else
            {
                Bomb_Timer -= diff;
            }

            if (LandMine_Timer <= diff)
            {
                DoCastSelf(SPELL_GOBLIN_LAND_MINE);
                LandMine_Timer = 30000;
            }
            else
            {
                LandMine_Timer -= diff;
            }

            if (me->isAttackReady() && !me->IsWithinMeleeRange(me->GetVictim()))
            {
                DoCastVictim(SPELL_SHOOT);
                me->SetSheath(SHEATH_STATE_RANGED);
            }
            else
            {
                me->SetSheath(SHEATH_STATE_MELEE);
                DoMeleeAttackIfReady();
            }
        }

        void JustReachedHome() override
        {
            if (instance->GetData(DATA_PYRAMID) == PYRAMID_CAGES_OPEN)
            {
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                instance->SetData(DATA_PYRAMID, PYRAMID_ARRIVED_AT_STAIR);
                Talk(SAY_WEEGLI_OHNO);
            }
            else if (instance->GetData(DATA_PYRAMID) >= PYRAMID_KILLED_ALL_TROLLS && instance->GetData(DATA_PYRAMID) < PYRAMID_DESTROY_GATES)
            {
                instance->SetData(DATA_PYRAMID, PYRAMID_MOVED_DOWNSTAIRS);
            }
            else if (instance->GetData(DATA_PYRAMID) == PYRAMID_DESTROY_GATES)
            {
                destroyingDoor = true;
            }
        }

        void MovementInform(uint32 type, uint32 /*id*/) override
        {
            if (type != POINT_MOTION_TYPE)
            {
                return;
            }

            if (instance->GetData(DATA_PYRAMID) == PYRAMID_CAGES_OPEN)
            {
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                instance->SetData(DATA_PYRAMID, PYRAMID_ARRIVED_AT_STAIR);
                Talk(SAY_WEEGLI_OHNO);
            }
            else if (instance->GetData(DATA_PYRAMID) >= PYRAMID_KILLED_ALL_TROLLS && instance->GetData(DATA_PYRAMID) < PYRAMID_DESTROY_GATES)
            {
                instance->SetData(DATA_PYRAMID, PYRAMID_MOVED_DOWNSTAIRS);
            }
            else if (instance->GetData(DATA_PYRAMID) == PYRAMID_DESTROY_GATES)
            {
                destroyingDoor = true;
            }
        }

        void DestroyDoor()
        {
            if (me->IsAlive())
            {
                me->SetFaction(FACTION_FRIENDLY);
                me->SetWalk(false);
                me->GetMotionMaster()->MovePoint(0, { 1858.57f, 1146.35f, 14.745f, 3.85f });
                me->SetHomePosition(1858.57f, 1146.35f, 14.745f, 3.85f);
                Talk(SAY_WEEGLI_OK_I_GO);
                instance->SetData(DATA_PYRAMID, PYRAMID_DESTROY_GATES);
            }
        }

        void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
        {
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            ClearGossipMenuFor(player);

            if (action == GOSSIP_ACTION_INFO_DEF + 1)
            {
                CloseGossipMenuFor(player);
                //here we make him run to door, set the charge and run away off to nowhere
                DestroyDoor();
            }
        }

        void sGossipHello(Player* player) override
        {
            switch (instance->GetData(DATA_PYRAMID))
            {
                case PYRAMID_MOVED_DOWNSTAIRS:
                case PYRAMID_KILLED_ALL_TROLLS:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_WEEGLI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    SendGossipMenuFor(player, 1514, me->GetGUID());  //if event can proceed to end
                    break;
                case PYRAMID_NOT_STARTED:
                    SendGossipMenuFor(player, 1511, me->GetGUID());  //if event not started
                    break;
                default:
                    SendGossipMenuFor(player, 1513, me->GetGUID());  //if event is in progress
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulFarrakAI<npc_weegli_blastfuseAI>(creature);
    }
};

enum ShadowPriestSezzizEnum
{
    SPELL_SHADOW_BOLT       = 15537,
    SPELL_PSYCHIC_SCREEM    = 13704,
    SPELL_RENEW             = 8362,
    SPELL_HEAL              = 12039
};

std::array<std::vector<std::pair<uint32, Position>>, 4> shadowpriestSezzizAdds =
{ {
    { { NPC_SANDFURY_ZEALOT, { 1874.12f, 1198.90f, 8.87f } }, { NPC_SANDFURY_ACOLYTE, { 1874.12f, 1198.90f, 8.87f } } },
    { { NPC_SANDFURY_ACOLYTE, { 895.26f, 1199.09f, 8.87f } }, { NPC_SANDFURY_ACOLYTE, { 895.26f, 1199.088f, 8.87f } } },
    { { NPC_SANDFURY_ZEALOT, { 1874.12f, 1198.90f, 8.87f } }, { NPC_SANDFURY_ACOLYTE, { 895.26f, 1199.09f, 8.87f } }, { NPC_SANDFURY_ACOLYTE, { 895.26f, 1199.09f, 8.87f } } },
    { { NPC_SANDFURY_ZEALOT, { 895.26f, 1199.09f, 8.87f } }, { NPC_SANDFURY_ZEALOT, { 1874.12f, 1198.90f, 8.87f } }, { NPC_SANDFURY_ACOLYTE, { 1874.12f, 1198.90f } }, { NPC_SANDFURY_ACOLYTE, { 895.26f, 1199.09f, 8.87f } } }
} };

class npc_shadowpriest_sezziz : public CreatureScript
{
public:
    npc_shadowpriest_sezziz() : CreatureScript("npc_shadowpriest_sezziz") {}

    struct npc_shadowpriest_sezzizAI : public ScriptedAI
    {
        npc_shadowpriest_sezzizAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            _shadowBoltTimer = urand(0, 1 * IN_MILLISECONDS);
            _physicScreemTimer = urand(1 * IN_MILLISECONDS, 16 * IN_MILLISECONDS);
            _missingHPForRenewTimer = urand(10 * IN_MILLISECONDS, 15 * IN_MILLISECONDS);
            _missingHPForHealTimer = urand(7 * IN_MILLISECONDS, 10 * IN_MILLISECONDS);
            _summonAddsTimer = 12 * IN_MILLISECONDS;
            _summmonAddsCount = 0;
        }

        void AttackStart(Unit* victim) override
        {
            ScriptedAI::AttackStartCaster(victim, 40.f);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            if (_summonAddsTimer <= diff)
            {
                for (auto& itr : shadowpriestSezzizAdds[_summmonAddsCount])
                {
                    if (Creature* add = me->SummonCreature(itr.first, itr.second, TEMPSUMMON_DEAD_DESPAWN, 10 * IN_MILLISECONDS))
                    {
                        add->AI()->AttackStart(me->GetVictim());
                    }
                }

                if (++_summmonAddsCount >= 4)
                {
                    _summmonAddsCount = 0;
                }

                _summonAddsTimer = urand(10 * IN_MILLISECONDS, 14 * IN_MILLISECONDS);
            }
            else
            {
                _summonAddsTimer -= diff;
            }

            if (_missingHPForHealTimer <= diff)
            {
                Unit* unit = nullptr;
                Acore::MostHPMissingInRange u_check(me, 40.f, 1500);
                Acore::UnitLastSearcher<Acore::MostHPMissingInRange> searcher(me, unit, u_check);
                Cell::VisitGridObjects(me, searcher, 40.f);
                if (unit)
                {
                    DoCast(unit, SPELL_HEAL);
                }

                _missingHPForHealTimer = urand(7 * IN_MILLISECONDS, 10 * IN_MILLISECONDS);
            }
            else
            {
                _missingHPForHealTimer -= diff;
            }

            if (_missingHPForRenewTimer <= diff)
            {
                Unit* unit = nullptr;
                Acore::MostHPMissingInRange u_check(me, 40.f, 700);
                Acore::UnitLastSearcher<Acore::MostHPMissingInRange> searcher(me, unit, u_check);
                Cell::VisitGridObjects(me, searcher, 40.f);
                if (unit)
                {
                    DoCast(unit, SPELL_RENEW);
                }

                _missingHPForRenewTimer = urand(10 * IN_MILLISECONDS, 15 * IN_MILLISECONDS);
            }
            else
            {
                _missingHPForRenewTimer -= diff;
            }

            if (_physicScreemTimer <= diff)
            {
                DoCastVictim(SPELL_PSYCHIC_SCREEM);
                _physicScreemTimer = urand(22 * IN_MILLISECONDS, 30 * IN_MILLISECONDS);
            }
            else
            {
                _physicScreemTimer -= diff;
            }

            if (_shadowBoltTimer <= diff)
            {
                DoCastVictim(SPELL_SHADOW_BOLT);
                _shadowBoltTimer = urand(3 * IN_MILLISECONDS, 4 * IN_MILLISECONDS);
            }
            else
            {
                _shadowBoltTimer -= diff;
            }
        }

    private:
        uint32 _shadowBoltTimer;
        uint32 _physicScreemTimer;
        uint32 _missingHPForRenewTimer;
        uint32 _missingHPForHealTimer;
        uint32 _summonAddsTimer;
        uint8 _summmonAddsCount;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulFarrakAI<npc_shadowpriest_sezzizAI>(creature);
    }
};

void AddSC_zulfarrak()
{
    new npc_sergeant_bly();
    new npc_weegli_blastfuse();
    new npc_shadowpriest_sezziz();
    new go_troll_cage();
}
