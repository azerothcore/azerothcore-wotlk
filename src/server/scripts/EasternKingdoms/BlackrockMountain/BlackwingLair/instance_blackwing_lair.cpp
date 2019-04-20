/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "PassiveAI.h"
#include "blackwing_lair.h"
#include "Player.h"

/*
Blackwing Lair Encounter:
1 - boss_razorgore.cpp
2 - boss_vaelastrasz.cpp
3 - boss_broodlord_lashlayer.cpp
4 - boss_firemaw.cpp
5 - boss_ebonroc.cpp
6 - boss_flamegor.cpp
7 - boss_chromaggus.cpp
8 - boss_nefarian.cpp
*/

class instance_blackwing_lair : public InstanceMapScript
{
public:
    instance_blackwing_lair() : InstanceMapScript(BRLScriptName, 469) { }

    struct instance_blackwing_lair_InstanceMapScript : public InstanceScript
    {
        instance_blackwing_lair_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(EncounterCount);
        }

        void Initialize()
        {
            // Razorgore
            EggCount = 0;
            EggEvent = 0;
            RazorgoreTheUntamedGUID = 0;
            RazorgoreDoorGUID = 0;
            GrethokGUID = 0;
            EggList.clear();
            // Vaelastrasz the Corrupt
            VaelastraszTheCorruptGUID = 0;
            VaelastraszDoorGUID = 0;
            // Broodlord Lashlayer
            BroodlordLashlayerGUID = 0;
            BroodlordDoorGUID = 0;
            // 3 Dragons
            FiremawGUID = 0;
            EbonrocGUID = 0;
            FlamegorGUID = 0;
            ChrommagusDoorGUID = 0;
            // Chormaggus
            ChromaggusGUID = 0;
            NefarianDoorGUID = 0;
            // Nefarian
            LordVictorNefariusGUID = 0;
            NefarianGUID = 0;
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch (creature->GetEntry())
            {
                case NPC_RAZORGORE:
                    RazorgoreTheUntamedGUID = creature->GetGUID();
                    break;
                case NPC_GRETHOK_THE_CONTROLLER:
                    GrethokGUID = creature->GetGUID();
                    break;
                case NPC_BLACKWING_DRAGON:
                case NPC_BLACKWING_GUARDSMAN:
                    RazorgoreTrash.push_back(creature->GetGUID());
                    break;
                case NPC_VAELASTRAZ:
                    VaelastraszTheCorruptGUID = creature->GetGUID();
                    break;
                case NPC_BROODLORD:
                    BroodlordLashlayerGUID = creature->GetGUID();
                    break;
                case NPC_FIRENAW:
                    FiremawGUID = creature->GetGUID();
                    break;
                case NPC_EBONROC:
                    EbonrocGUID = creature->GetGUID();
                    break;
                case NPC_FLAMEGOR:
                    FlamegorGUID = creature->GetGUID();
                    break;
                case NPC_CHROMAGGUS:
                    ChromaggusGUID = creature->GetGUID();
                    break;
                case NPC_VICTOR_NEFARIUS:
                    LordVictorNefariusGUID = creature->GetGUID();
                    break;
                case NPC_NEFARIAN:
                    NefarianGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {
            switch (go->GetEntry())
            {
                case GO_PORTICULIS:
                    PorticulisGUID = go->GetGUID();
                    break;
                case 177807: // Egg
                    if (GetBossState(BOSS_FIREMAW) == DONE)
                        go->SetPhaseMask(2, true);
                    else
                        EggList.push_back(go->GetGUID());
                    break;
                case 175946: // Door
                    RazorgoreDoorGUID = go->GetGUID();
                    HandleGameObject(0, GetBossState(BOSS_RAZORGORE) == DONE, go);
                    break;
                case 175185: // Door
                    VaelastraszDoorGUID = go->GetGUID();
                    HandleGameObject(0, GetBossState(BOSS_VAELASTRAZ) == DONE, go);
                    break;
                case 180424: // Door
                    BroodlordDoorGUID = go->GetGUID();
                    HandleGameObject(0, GetBossState(BOSS_BROODLORD) == DONE, go);
                    break;
                case 185483: // Door
                    ChrommagusDoorGUID = go->GetGUID();
                    HandleGameObject(0, GetBossState(BOSS_FIREMAW) == DONE && GetBossState(BOSS_EBONROC) == DONE && GetBossState(BOSS_FLAMEGOR) == DONE, go);
                    break;
                case 181125: // Door
                    NefarianDoorGUID = go->GetGUID();
                    HandleGameObject(0, GetBossState(BOSS_CHROMAGGUS) == DONE, go);
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go)
        {
            if (go->GetEntry() == GO_RAZORGORE_EGG) // Egg
                EggList.remove(go->GetGUID());
        }

        bool SetBossState(uint32 bossId, EncounterState state)
        {
            // pussywizard:
            if (GetBossState(bossId) == DONE && state != DONE) // prevent undoneing a boss xd
                return false;

            if (!InstanceScript::SetBossState(bossId, state))
                return false;

            switch (bossId)
            {
                case BOSS_RAZORGORE:
                    if (state == DONE)
                    {
                        HandleGameObject(RazorgoreDoorGUID, true); // Open the door after encounter complete
                        for (std::list<uint64>::const_iterator itr = EggList.begin(); itr != EggList.end(); ++itr)
                            if (GameObject* egg = instance->GetGameObject((*itr)))
                                egg->SetPhaseMask(2, true);
                    }
                    else if (state == IN_PROGRESS)
                    {
                        if (Creature* grethok = instance->GetCreature(GrethokGUID))
                        {
                            if (Creature* razorgore = instance->GetCreature(RazorgoreTheUntamedGUID))
                            {
                                if (razorgore && razorgore->IsAlive() && !razorgore->IsInCombat())
                                    razorgore->AI()->AttackStart(grethok->GetVictim());
                                HandleGameObject(PorticulisGUID, false);
                            }
                        }
                    }
                    else if (state == NOT_STARTED)
                    {
                        HandleGameObject(PorticulisGUID, false);
                    }
                    // SetData(DATA_EGG_EVENT, NOT_STARTED);
                    break;
                case BOSS_VAELASTRAZ:
                    HandleGameObject(VaelastraszDoorGUID, state == DONE);
                    break;
                case BOSS_BROODLORD:
                    HandleGameObject(BroodlordDoorGUID, state == DONE);
                    break;
                case BOSS_FIREMAW:
                case BOSS_EBONROC:
                case BOSS_FLAMEGOR:
                    HandleGameObject(ChrommagusDoorGUID, GetBossState(BOSS_FIREMAW) == DONE && GetBossState(BOSS_EBONROC) == DONE && GetBossState(BOSS_FLAMEGOR) == DONE);
                    break;
                case BOSS_CHROMAGGUS:
                    HandleGameObject(NefarianDoorGUID, state == DONE);
                    break;
                case BOSS_NEFARIAN:
                    switch (state)
                    {
                        case NOT_STARTED:
                            if (Creature* nefarian = instance->GetCreature(NefarianGUID))
                                nefarian->DespawnOrUnsummon();
                            break;
                        case FAIL:
                            _events.ScheduleEvent(EVENT_RESPAWN_NEFARIUS, 15*IN_MILLISECONDS*MINUTE);
                            SetBossState(BOSS_NEFARIAN, NOT_STARTED);
                            break;
                        default:
                            break;
                    }
                    break;
            }
            return true;
        }

        uint64 GetData64(uint32 id) const
        {
            switch (id)
            {
                case DATA_RAZORGORE_THE_UNTAMED:  return RazorgoreTheUntamedGUID;
                case DATA_VAELASTRAZ_THE_CORRUPT: return VaelastraszTheCorruptGUID;
                case DATA_BROODLORD_LASHLAYER:    return BroodlordLashlayerGUID;
                case DATA_FIRENAW:                return FiremawGUID;
                case DATA_EBONROC:                return EbonrocGUID;
                case DATA_FLAMEGOR:               return FlamegorGUID;
                case DATA_CHROMAGGUS:             return ChromaggusGUID;
                case DATA_LORD_VICTOR_NEFARIUS:   return LordVictorNefariusGUID;
                case DATA_NEFARIAN:               return NefarianGUID;
            }

            return 0;
        }

        void SetData(uint32 type, uint32 data)
        {
            if (type == DATA_EGG_EVENT)
            {
                switch (data)
                {
                    case IN_PROGRESS:
                        EggEvent = data;
                        EggCount = 0;
                        break;
                    case NOT_STARTED:
                        EggEvent = data;
                        EggCount = 0;
                        break;
                    case SPECIAL:
                        if (++EggCount == 15)
                        {
                            if (Creature* razor = instance->GetCreature(RazorgoreTheUntamedGUID))
                            {
                                SetData(DATA_EGG_EVENT, DONE);
                                razor->RemoveAurasDueToSpell(42013); // MindControl
                                DoRemoveAurasDueToSpellOnPlayers(42013);
                            }
                            _events.ScheduleEvent(EVENT_RAZOR_PHASE_TWO, IN_MILLISECONDS);
                        }
                        if (EggEvent == NOT_STARTED)
                            SetData(DATA_EGG_EVENT, IN_PROGRESS);
                        break;
                }
            }
        }

        void OnUnitDeath(Unit* unit)
        {
            //! HACK, needed because of buggy CreatureAI after charm
            if (unit->GetEntry() == NPC_RAZORGORE && GetBossState(BOSS_RAZORGORE) != DONE)
                SetBossState(BOSS_RAZORGORE, DONE);
        }

        void Update(uint32 diff)
        {
            if (_events.Empty())
                return;

            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_RAZOR_PHASE_TWO:
                        if (Creature* razor = instance->GetCreature(RazorgoreTheUntamedGUID))
                            razor->AI()->DoAction(ACTION_PHASE_TWO);
                        break;
                    case EVENT_RESPAWN_NEFARIUS:
                        if (Creature* nefarius = instance->GetCreature(LordVictorNefariusGUID))
                        {
                            nefarius->SetPhaseMask(1, true);
                            nefarius->setActive(true);
                            nefarius->Respawn();
                            nefarius->GetMotionMaster()->MoveTargetedHome();
                        }
                        break;
                }
            }
        }

    protected:
        // Misc
        EventMap _events;
        // Razorgore
        uint8 EggCount;
        uint32 EggEvent;
        uint64 RazorgoreTheUntamedGUID, RazorgoreDoorGUID, PorticulisGUID, GrethokGUID;
        std::list<uint64> RazorgoreTrash, EggList;

        // Vaelastrasz the Corrupt
        uint64 VaelastraszTheCorruptGUID;
        uint64 VaelastraszDoorGUID;

        // Broodlord Lashlayer
        uint64 BroodlordLashlayerGUID;
        uint64 BroodlordDoorGUID;

        // 3 Dragons
        uint64 FiremawGUID;
        uint64 EbonrocGUID;
        uint64 FlamegorGUID;
        uint64 ChrommagusDoorGUID;

        // Chormaggus
        uint64 ChromaggusGUID;
        uint64 NefarianDoorGUID;

        // Nefarian
        uint64 LordVictorNefariusGUID;
        uint64 NefarianGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const
    {
        return new instance_blackwing_lair_InstanceMapScript(map);
    }
};

void AddSC_instance_blackwing_lair()
{
    new instance_blackwing_lair();
}
