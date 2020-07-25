/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"
#include "PassiveAI.h"

const float HeiganPos[2] = {2796, -3707};
const float HeiganEruptionSlope[3] =
{
    (-3685 - HeiganPos[1]) / (2724 - HeiganPos[0]),
    (-3647 - HeiganPos[1]) / (2749 - HeiganPos[0]),
    (-3637 - HeiganPos[1]) / (2771 - HeiganPos[0]),
};

inline uint8 GetEruptionSection(float x, float y)
{
    y -= HeiganPos[1];
    if (y < 1.0f)
        return 0;

    x -= HeiganPos[0];
    if (x > -1.0f)
        return 3;

    float slope = y/x;
    for (uint32 i = 0; i < 3; ++i)
        if (slope > HeiganEruptionSlope[i])
            return i;
    return 3;
}

class instance_naxxramas : public InstanceMapScript
{
public:
    instance_naxxramas() : InstanceMapScript("instance_naxxramas", 533) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_naxxramas_InstanceMapScript(pMap);
    }

    struct instance_naxxramas_InstanceMapScript : public InstanceScript
    {
        explicit instance_naxxramas_InstanceMapScript(Map* pMap) : InstanceScript(pMap)
        {
            SetBossNumber(MAX_ENCOUNTERS);
            for (auto & i : HeiganEruption)
                i.clear();

            // GOs
            _patchwerkGateGUID = 0;
            _gluthGateGUID = 0;
            _nothGateGUID = 0;
            _heiganGateGUID = 0;
            _heiganGateExitGUID = 0;
            _loathebGateGUID = 0;
            _anubGateGUID = 0;
            _anubNextGateGUID = 0;
            _faerlinaGateGUID = 0;
            _maexxnaGateGUID = 0;
            _thaddiusGateGUID = 0;
            _horsemanGateGUID = 0;
            _kelthuzadfloorGUID = 0;
            _kelthuzadgateGUID = 0;
            _sapphironGateGUID = 0;
            _horsemanPortalGUID = 0;
            _loathebPortalGUID = 0;
            _maexxnaPortalGUID = 0;
            _thaddiusPortalGUID = 0;
            _deathknightEyePortalGUID = 0;
            _plagueEyePortalGUID = 0;
            _spiderEyePortalGUID = 0;
            _abomEyePortalGUID = 0;
			
            // NPCs
            PatchwerkRoomTrash.clear();
            _patchwerkGUID = 0;
            _thaddiusGUID = 0;
            _stalaggGUID = 0;
            _feugenGUID = 0;
            _zeliekGUID = 0;
            _rivendareGUID = 0;
            _blaumeuxGUID = 0;
            _korthazzGUID = 0;
            _sapphironGUID = 0;
            _kelthuzadGUID = 0;
            _lichkingGUID = 0;

            // Controls
            _horsemanKilled = 0;
            _speakTimer = 0;
            _horsemanTimer = 0;
            _screamTimer = 2 * MINUTE * IN_MILLISECONDS;
            _hadThaddiusGreet = false;
            _currentWingTaunt = SAY_FIRST_WING_TAUNT;
            _horsemanLoadDoneState = false;

            // Achievements
            abominationsKilled = 0;
            faerlinaAchievement = true;
            thaddiusAchievement = true;
            loathebAchievement = true;
            sapphironAchievement = true;
            heiganAchievement = true;
            immortalAchievement = 1;

        }

        std::set<GameObject*> HeiganEruption[4];

        // GOs
        uint64 _patchwerkGateGUID;
        uint64 _gluthGateGUID;
        uint64 _nothGateGUID;
        uint64 _heiganGateGUID;
        uint64 _heiganGateExitGUID;
        uint64 _loathebGateGUID;
        uint64 _anubGateGUID;
        uint64 _anubNextGateGUID;
        uint64 _faerlinaGateGUID;
        uint64 _maexxnaGateGUID;
        uint64 _thaddiusGateGUID;
        uint64 _gothikEnterGateGUID{};
        uint64 _gothikInnerGateGUID{};
        uint64 _gothikExitGateGUID{};
        uint64 _horsemanGateGUID;
        uint64 _kelthuzadfloorGUID;
        uint64 _kelthuzadgateGUID;
        uint64 _sapphironGateGUID;
        uint64 _horsemanPortalGUID;
        uint64 _loathebPortalGUID;
        uint64 _maexxnaPortalGUID;
        uint64 _thaddiusPortalGUID;
        uint64 _deathknightEyePortalGUID;
        uint64 _plagueEyePortalGUID;
        uint64 _spiderEyePortalGUID;
        uint64 _abomEyePortalGUID;
		
        // NPCs
        std::list<uint64> PatchwerkRoomTrash;
        uint64 _patchwerkGUID;
        uint64 _thaddiusGUID;
        uint64 _stalaggGUID;
        uint64 _feugenGUID;
        uint64 _zeliekGUID;
        uint64 _rivendareGUID;
        uint64 _blaumeuxGUID;
        uint64 _korthazzGUID;
        uint64 _sapphironGUID;
        uint64 _kelthuzadGUID;
        uint64 _lichkingGUID;

        // Controls
        uint8 _horsemanKilled;
        uint32 _speakTimer;
        uint32 _horsemanTimer;
        uint32 _screamTimer;
        bool _hadThaddiusGreet;
        EventMap events;
        uint8 _currentWingTaunt;
        bool _horsemanLoadDoneState;

        // Achievements
        uint8 abominationsKilled;
        bool faerlinaAchievement;
        bool thaddiusAchievement;
        bool loathebAchievement;
        bool sapphironAchievement;
        bool heiganAchievement;
        uint32 immortalAchievement;

        void HeiganEruptSections(uint32 section)
        {
            for (uint8 i = 0; i < 4; ++i)
            {
                if (i == section)
                    continue;

                for (auto itr : HeiganEruption[i])
                {
                    itr->SendCustomAnim(itr->GetGoAnimProgress());
                    itr->CastSpell(nullptr, SPELL_ERUPTION);
                }
            }
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
            {
                if (GetBossState(i) == IN_PROGRESS)
                    return true;
            }
            return false;
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch(creature->GetEntry())
            {
                case NPC_PATCHWERK:
                    _patchwerkGUID = creature->GetGUID();
                    return;
                case NPC_PATCHWORK_GOLEM:
                    PatchwerkRoomTrash.push_back(creature->GetGUID());
                    return;
                case NPC_BILE_RETCHER:
                    if (creature->GetPositionY() > -3258.0f) // we want only those inside the room, not before
                        PatchwerkRoomTrash.push_back(creature->GetGUID());
                    return;
                case NPC_SLUDGE_BELCHER:
                    if (creature->GetPositionY() > -3258.0f) // we want only those inside the room, not before
                        PatchwerkRoomTrash.push_back(creature->GetGUID());
                    return;
                case NPC_MAD_SCIENTIST:
                    PatchwerkRoomTrash.push_back(creature->GetGUID());
                    return;
                case NPC_LIVING_MONSTROSITY:
                    PatchwerkRoomTrash.push_back(creature->GetGUID());
                    return;
                case NPC_SURGICAL_ASSIST:
                    PatchwerkRoomTrash.push_back(creature->GetGUID());
                    return;
                case NPC_THADDIUS:
                    _thaddiusGUID = creature->GetGUID();
                    return;
                case NPC_STALAGG:
                    _stalaggGUID = creature->GetGUID();
                    return;
                case NPC_FEUGEN:
                    _feugenGUID = creature->GetGUID();
                    return;
                case NPC_LADY_BLAUMEUX:
                    _blaumeuxGUID = creature->GetGUID();
                    return;
                case NPC_SIR_ZELIEK:
                    _zeliekGUID = creature->GetGUID();
                    return;
                case NPC_BARON_RIVENDARE:
                    _rivendareGUID = creature->GetGUID();
                    return;
                case NPC_THANE_KORTHAZZ:
                    _korthazzGUID = creature->GetGUID();
                    return;
                case NPC_SAPPHIRON:
                    _sapphironGUID = creature->GetGUID();
                    return;
                case NPC_KELTHUZAD:
                    _kelthuzadGUID = creature->GetGUID();
                    return;
                case NPC_LICH_KING:
                    _lichkingGUID = creature->GetGUID();
                    return;
            }
        }

        void OnGameObjectCreate(GameObject* pGo) override
        {
            if (pGo->GetGOInfo()->displayId == 6785 || pGo->GetGOInfo()->displayId == 1287)
            {
                HeiganEruption[GetEruptionSection(pGo->GetPositionX(), pGo->GetPositionY())].insert(pGo);
                return;
            }

            switch(pGo->GetEntry())
            {
                case GO_PATCHWERK_GATE:
                    _patchwerkGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_PATCHWERK) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_GLUTH_GATE:
                    _gluthGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_GLUTH) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_NOTH_GATE:
                    _nothGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_NOTH) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_HEIGAN_ENTERANCE_GATE:
                    _heiganGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_HEIGAN) == DONE || GetBossState(BOSS_NOTH) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_HEIGAN_EXIT_GATE:
                    _heiganGateExitGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_HEIGAN) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_LOATHEB_GATE:
                    _loathebGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_LOATHEB) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_ANUB_GATE:
                    _anubGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_ANUB) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_ANUB_NEXT_GATE:
                    _anubNextGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_ANUB) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_FAERLINA_GATE:
                    _faerlinaGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_FAERLINA) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_MAEXXNA_GATE:
                    _maexxnaGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_FAERLINA) == DONE) // faerlina is correct
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_THADDIUS_GATE:
                    _thaddiusGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_GLUTH) == DONE) // gluth is correct
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_GOTHIK_ENTER_GATE:
                    _gothikEnterGateGUID = pGo->GetGUID();
                    break;
                case GO_GOTHIK_INNER_GATE:
                    _gothikInnerGateGUID = pGo->GetGUID();
                    break;
                case GO_GOTHIK_EXIT_GATE:
                    _gothikExitGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_GOTHIK) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_HORSEMAN_GATE:
                    _horsemanGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_GOTHIK) == DONE) // correct
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_KELTHUZAD_FLOOR:
                    _kelthuzadfloorGUID = pGo->GetGUID();
                    break;
                case GO_KELTHUZAD_GATE:
                    _kelthuzadgateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_SAPPHIRON) == DONE && _speakTimer==0)
                        pGo->SetGoState(GO_STATE_ACTIVE);
               	    break;
                case GO_SAPPHIRON_GATE:
                    _sapphironGateGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_SAPPHIRON) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_DEATHKNIGHT_WING: 
                    _loathebPortalGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_LOATHEB) == DONE)
                        pGo->SetPhaseMask(1, true);
                    break;
                case GO_THADDIUS_PORTAL: 
                    _thaddiusPortalGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_THADDIUS) == DONE)
                        pGo->SetPhaseMask(1, true);
                    break;
                case GO_MAEXXNA_PORTAL: 
                    _maexxnaPortalGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_MAEXXNA) == DONE)
                        pGo->SetPhaseMask(1, true);
                    break;
                case GO_HORSEMAN_PORTAL: 
                    _horsemanPortalGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_HORSEMAN) == DONE)
                        pGo->SetPhaseMask(1, true);
                    break;
                case GO_DEATHKNIGHT_EYE_PORTAL:
                    _deathknightEyePortalGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_HORSEMAN) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_PLAGUE_EYE_PORTAL:
                    _plagueEyePortalGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_LOATHEB) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_SPIDER_EYE_PORTAL:
                    _spiderEyePortalGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_MAEXXNA) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_ABOM_EYE_PORTAL:
                    _abomEyePortalGUID = pGo->GetGUID();
                    if (GetBossState(BOSS_THADDIUS) == DONE)
                        pGo->SetGoState(GO_STATE_ACTIVE);
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* pGo) override
        {
            if (pGo->GetGOInfo()->displayId == 6785 || pGo->GetGOInfo()->displayId == 1287)
            {
                uint32 section = GetEruptionSection(pGo->GetPositionX(), pGo->GetPositionY());
                HeiganEruption[section].erase(pGo);
                return;
            }

            if (pGo->GetEntry() == GO_SAPPHIRON_BIRTH)
                if (Creature* cr = instance->GetCreature(_sapphironGUID))
                    cr->AI()->DoAction(ACTION_SAPPHIRON_BIRTH);
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch (criteria_id)
            {
                case 7600: // And They Would All Go Down Together (10 player)
                case 7601: // And They Would All Go Down Together (25 player)
                    return (_horsemanTimer < 15*IN_MILLISECONDS);
                case 7614: // Just Can't Get Enough (10 player)
                case 7615: // Just Can't Get Enough (25 player)
                    return abominationsKilled >= 18;
                case 7265: // Momma Said Knock You Out (10 player)
                case 7549: // Momma Said Knock You Out (25 player)
                    return faerlinaAchievement;
                case 7604: // Shocking! (10 player)
                case 7605: // Shocking! (25 player)
                    return thaddiusAchievement;
                case 7612: // Spore Loser (10 player)
                case 7613: // Spore Loser (25 player)
                    return loathebAchievement;
                case 7264: // The Safety Dance (10 player)
                case 7548: // The Safety Dance (25 player)
                    return heiganAchievement;
                case 7608: // Subtraction (10 player)
                // The Dedicated few (10 player)
                case 6802: case 7146: case 7147: case 7148: case 7149:
                case 7150: case 7151: case 7152: case 7153: case 7154:
                case 7155: case 7156: case 7157: case 7158:
                    return (instance->GetPlayersCountExceptGMs() < 9);
                case 7609: // Subtraction (25 player)
                // The Dedicated few (25 player)
                case 7159: case 7160: case 7161: case 7162: case 7163:
                case 7164: case 7165: case 7166: case 7167: case 7168:
                case 7169: case 7170: case 7171: case 7172:
                    return (instance->GetPlayersCountExceptGMs() < 21);
                case 7567: // The Hundred Club (10 player)
                case 7568: // The Hundred Club (25 player)
                    return sapphironAchievement;
                // The Undying
                case 7617: case 13237: case 13238: case 13239: case 13240:
                // The Immortal
                case 7616: case 13233: case 13234: case 13235: case 13236:
                {
                    uint8 count = 0;
                    for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                        if (GetBossState(i) == NOT_STARTED)
                            ++count;

                    return !count && immortalAchievement;
                }

                default:
                    return false;
            }
        }

        void SetData(uint32 id, uint32 data) override
        {
            switch(id)
            {
                case DATA_ABOMINATION_KILLED:
                    abominationsKilled++;
                    return;
                case DATA_FRENZY_REMOVED:
                    faerlinaAchievement = false;
                    return;
                case DATA_CHARGES_CROSSED:
                    thaddiusAchievement = false;
                    return;
                case DATA_SPORE_KILLED:
                    loathebAchievement = false;
                    return;
                case DATA_HUNDRED_CLUB:
                    sapphironAchievement = false;
                    return;
                case DATA_DANCE_FAIL:
                    heiganAchievement = false;
                    return;
                case DATA_IMMORTAL_FAIL:
                    immortalAchievement = 0;
                    SaveToDB();
                    return;
                case DATA_HEIGAN_ERUPTION:
                    HeiganEruptSections(data);
                    return;
                case DATA_HAD_THADDIUS_GREET:
                    _hadThaddiusGreet = (data == 1);
                default:
                    return;
            }
        }

        uint32 GetData(uint32 id) const override
        {
            if (id == DATA_HAD_THADDIUS_GREET && _hadThaddiusGreet)
                return 1;

            return 0;
        }

        bool SetBossState(uint32 bossId, EncounterState state) override
        {
            // pull all the trash if not killed
            if (bossId == BOSS_PATCHWERK && state == IN_PROGRESS)
            {
                if (Creature* patch = instance->GetCreature(_patchwerkGUID))
                {
                    for (auto &itr : PatchwerkRoomTrash)
                    {
                        Creature* trash = ObjectAccessor::GetCreature(*patch, itr);
                        if (trash && trash->IsAlive() && !trash->IsInCombat())
                            trash->AI()->AttackStart(patch->GetVictim());
                    }
                }
            }

            // Horseman handling
            if (bossId == BOSS_HORSEMAN && _horsemanLoadDoneState == false)
            {
                if (state == DONE)
                {
                    _horsemanTimer++;
                    _horsemanKilled++;
                    if (_horsemanKilled < 4) {
                        return false;
                    }

                    // All horsemans are killed
                    if (Creature* cr = instance->GetCreature(_blaumeuxGUID))
                        cr->CastSpell(cr, 59450, true); // credit
                }

                // respawn
                else if (state == NOT_STARTED && _horsemanKilled > 0)
                {
                    Creature* cr;
                    _horsemanKilled = 0;
                    if ((cr = instance->GetCreature(_blaumeuxGUID)))
                        if (!cr->IsAlive())
                        {
                            cr->SetPosition(cr->GetHomePosition());
                            cr->Respawn();
                        }
                    if ((cr = instance->GetCreature(_rivendareGUID)))
                        if (!cr->IsAlive())
                        {
                            cr->SetPosition(cr->GetHomePosition());
                            cr->Respawn();
                        }
                    if ((cr = instance->GetCreature(_zeliekGUID)))
                        if (!cr->IsAlive())
                        {
                            cr->SetPosition(cr->GetHomePosition());
                            cr->Respawn();
                        }
                    if ((cr = instance->GetCreature(_korthazzGUID)))
                        if (!cr->IsAlive())
                        {
                            cr->SetPosition(cr->GetHomePosition());
                            cr->Respawn();
                        }
                }
                else if (state == IN_PROGRESS)
                {
                    Creature* cr;
                    if ((cr = instance->GetCreature(_blaumeuxGUID)))
                        cr->SetInCombatWithZone();
                    if ((cr = instance->GetCreature(_rivendareGUID)))
                        cr->SetInCombatWithZone();
                    if ((cr = instance->GetCreature(_zeliekGUID)))
                        cr->SetInCombatWithZone();
                    if ((cr = instance->GetCreature(_korthazzGUID)))
                        cr->SetInCombatWithZone();
                }

                if (state == NOT_STARTED)
                    _horsemanTimer = 0;
            }
            
            
            if (!InstanceScript::SetBossState(bossId, state))
                return false;
            
            // Bosses data
            switch(bossId)
            {
                case BOSS_KELTHUZAD:
                    if (state == NOT_STARTED)
                        abominationsKilled = 0;
                    break;
                case BOSS_FAERLINA:
                    if (state == NOT_STARTED)
                        faerlinaAchievement = true;
                    break;
                case BOSS_THADDIUS:
                    if (state == NOT_STARTED)
                        thaddiusAchievement = true;
                    break;
                case BOSS_LOATHEB:
                    if (state == NOT_STARTED)
                        loathebAchievement = true;
                    break;
                case BOSS_HEIGAN:
                    if (state == NOT_STARTED)
                        heiganAchievement = true;
                    break;
                case BOSS_SAPPHIRON:
                    if (state == DONE)
                    {
                        _speakTimer = 1;
                        // Load KT's grid so he can talk
                        instance->LoadGrid(3763.43f, -5115.87f);
                    }
                    else if (state == NOT_STARTED)
                        sapphironAchievement = true;
                    break;
                default:
                    break;
            }
                    
            // Save instance and open gates
            if (state == DONE)
            {
                SaveToDB();

                switch (bossId)
                {
                    case BOSS_PATCHWERK:
                        if (GameObject* go = instance->GetGameObject(_patchwerkGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case BOSS_GLUTH:
                        if (GameObject* go = instance->GetGameObject(_gluthGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        if (GameObject* go = instance->GetGameObject(_thaddiusGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case BOSS_NOTH:
                        if (GameObject* go = instance->GetGameObject(_nothGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        if (GameObject* go = instance->GetGameObject(_heiganGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case BOSS_HEIGAN:
                        if (GameObject* go = instance->GetGameObject(_heiganGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        if (GameObject* go = instance->GetGameObject(_heiganGateExitGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case BOSS_LOATHEB:
                        if (GameObject* go = instance->GetGameObject(_loathebGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        if (GameObject* go = instance->GetGameObject(_loathebPortalGUID))
                            go->SetPhaseMask(1, true);
                        if (GameObject* go = instance->GetGameObject(_plagueEyePortalGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        events.ScheduleEvent(EVENT_KELTHUZAD_WING_TAUNT, 6000);
                        break;
                    case BOSS_ANUB:
                        if (GameObject* go = instance->GetGameObject(_anubGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        if (GameObject* go = instance->GetGameObject(_anubNextGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case BOSS_FAERLINA:
                        if (GameObject* go = instance->GetGameObject(_faerlinaGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        if (GameObject* go = instance->GetGameObject(_maexxnaGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case BOSS_MAEXXNA:
                        if (GameObject* go = instance->GetGameObject(_maexxnaGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        if (GameObject* go = instance->GetGameObject(_maexxnaPortalGUID))
                            go->SetPhaseMask(1, true);
                        if (GameObject* go = instance->GetGameObject(_spiderEyePortalGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        events.ScheduleEvent(EVENT_KELTHUZAD_WING_TAUNT, 6000);
                        break;
                    case BOSS_GOTHIK:
                        if (GameObject* go = instance->GetGameObject(_gothikEnterGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        if (GameObject* go = instance->GetGameObject(_gothikExitGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        if (GameObject* go = instance->GetGameObject(_horsemanGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case BOSS_SAPPHIRON:
                        if (GameObject* go = instance->GetGameObject(_sapphironGateGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    case BOSS_THADDIUS:
                        if (GameObject* go = instance->GetGameObject(_thaddiusPortalGUID))
                            go->SetPhaseMask(1, true);
                        if (GameObject* go = instance->GetGameObject(_abomEyePortalGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        events.ScheduleEvent(EVENT_KELTHUZAD_WING_TAUNT, 6000);
                        break;
                    case BOSS_HORSEMAN:
                        if (GameObject* go = instance->GetGameObject(_horsemanPortalGUID))
                            go->SetPhaseMask(1, true);
                        if (GameObject* go = instance->GetGameObject(_deathknightEyePortalGUID))
                            go->SetGoState(GO_STATE_ACTIVE);
                        events.ScheduleEvent(EVENT_KELTHUZAD_WING_TAUNT, 6000);
                        break;
                    default:
                        break;
                }
            }
                
            return true;
        }

        void Update(uint32 diff) override
        {
            if (_speakTimer)
            {
                Creature* kel = instance->GetCreature(_kelthuzadGUID);
                Creature* lich = instance->GetCreature(_lichkingGUID);
                if (kel && lich)
                    _speakTimer += diff;
                else
                    return;
                if (_speakTimer > 10000 && _speakTimer < 20000)
                {
                    kel->AI()->Talk(SAY_SAPP_DIALOG1);
                    _speakTimer = 20000;
                }
                else if (_speakTimer > 30000 && _speakTimer < 40000)
                {
                    lich->AI()->Talk(SAY_SAPP_DIALOG2_LICH);
                    _speakTimer = 40000;
                }
                else if (_speakTimer > 54000 && _speakTimer < 60000)
                {
                    kel->AI()->Talk(SAY_SAPP_DIALOG3);
                    _speakTimer = 60000;
                }
                else if (_speakTimer > 70000 && _speakTimer < 80000)
                {
                    lich->AI()->Talk(SAY_SAPP_DIALOG4_LICH);
                    _speakTimer = 80000;
                }
                else if (_speakTimer > 92000 && _speakTimer < 100000)
                {
                    kel->AI()->Talk(SAY_SAPP_DIALOG5);
                    _speakTimer = 100000;
                }
                else if (_speakTimer > 105000)
                {
                    kel->AI()->Talk(SAY_SAPP_DIALOG6);
                    _speakTimer = 0;
                    if (GameObject* go = instance->GetGameObject(_kelthuzadgateGUID))
                        go->SetGoState(GO_STATE_ACTIVE);
                }
            }

            // And They would all
            if (_horsemanTimer)
                _horsemanTimer += diff;

            if (_screamTimer && GetBossState(BOSS_THADDIUS) != DONE)
            {
                if (_screamTimer <= diff)
                {
                    instance->PlayDirectSoundToMap(SOUND_SCREAM + urand(0, 3));
                    _screamTimer = (2 * MINUTE + urand(0, 30)) * IN_MILLISECONDS;
                }
                else
                    _screamTimer -= diff;
            }

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_KELTHUZAD_WING_TAUNT:
                    // Loads Kel'Thuzad's grid. We need this as he must be active in order for his texts to work.
                    instance->LoadGrid(3749.67f, -5114.06f);
                    if (Creature* kelthuzad = instance->GetCreature(_kelthuzadGUID))
                        kelthuzad->AI()->Talk(_currentWingTaunt);
                    ++_currentWingTaunt;
                    events.PopEvent();
                    break;
            }
        }

        uint64 GetData64(uint32 id) const override
        {
            switch (id)
            {
                // GameObjects
                case DATA_HEIGAN_ENTER_GATE:
                    return _heiganGateGUID;
                case DATA_LOATHEB_GATE:
                    return _loathebGateGUID;
                case DATA_ANUB_GATE:
                    return _anubGateGUID;
                case DATA_MAEXXNA_GATE:
                    return _maexxnaGateGUID;
                case DATA_GOTHIK_ENTER_GATE:
                    return _gothikEnterGateGUID;
                case DATA_GOTHIK_INNER_GATE:
                    return _gothikInnerGateGUID;
                case DATA_GOTHIK_EXIT_GATE:
                    return _gothikExitGateGUID;
                case DATA_KELTHUZAD_FLOOR:
                    return _kelthuzadfloorGUID;
                case DATA_KELTHUZAD_GATE:
                    return _kelthuzadgateGUID;

                // NPCs
                case DATA_THADDIUS_BOSS:
                    return _thaddiusGUID;
                case DATA_STALAGG_BOSS:
                    return _stalaggGUID;
                case DATA_FEUGEN_BOSS:
                    return _feugenGUID;
                case DATA_LICH_KING_BOSS:
                    return _lichkingGUID;

                default:
                    return 0;
            }
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "N X X " << GetBossSaveData() << ' ' << immortalAchievement;

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* in) override
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2, dataHead3;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> dataHead3;

            if (dataHead1 == 'N' && dataHead2 == 'X' && dataHead3 == 'X')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS)
                        tmpState = NOT_STARTED;
                    if (i == BOSS_HORSEMAN && tmpState == DONE)
                        _horsemanLoadDoneState = true;
                    SetBossState(i, EncounterState(tmpState));
                }
                loadStream >> immortalAchievement;

                OUT_LOAD_INST_DATA_COMPLETE;
            }
            else
                OUT_LOAD_INST_DATA_FAIL;
        }
            
    };
};
class boss_naxxramas_misc : public CreatureScript
{
public:
    boss_naxxramas_misc() : CreatureScript("boss_naxxramas_misc") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_naxxramas_miscAI (pCreature);
    }

    struct boss_naxxramas_miscAI : public NullCreatureAI
    {
        explicit boss_naxxramas_miscAI(Creature* c) : NullCreatureAI(c)
        {
            timer = 0;
        }

        uint32 timer;

        void JustDied(Unit* ) override
        {
            if (me->GetEntry() == NPC_MR_BIGGLESWORTH && me->GetInstanceScript())
            {
                if (Creature* cr = me->SummonCreature(20350/*NPC_KELTHUZAD*/, *me, TEMPSUMMON_TIMED_DESPAWN, 1))
                {
                    cr->SetDisplayId(11686);
                    cr->AI()->Talk(SAY_CAT_DIED);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (me->GetEntry() == NPC_NAXXRAMAS_TRIGGER)
            {
                timer += diff;
                if (timer >= 5000)
                {
                    if (Creature* cr = me->SummonCreature(NPC_LIVING_POISON, *me, TEMPSUMMON_TIMED_DESPAWN, 9000))
                    {
                        cr->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                        cr->GetMotionMaster()->MovePoint(0, me->GetPositionX()+50*cos(me->GetOrientation()), me->GetPositionY()+50*sin(me->GetOrientation()), me->GetPositionZ(), false);
                    }
                    timer = 0;
                }
            }
            else if (me->GetEntry() == NPC_LIVING_POISON)
            {
                Unit* target = nullptr;
                acore::AnyUnfriendlyUnitInObjectRangeCheck u_check(me, me, 0.5f);
                acore::UnitLastSearcher<acore::AnyUnfriendlyUnitInObjectRangeCheck> searcher(me, target, u_check);
                me->VisitNearbyObject(1.5f, searcher);
                if (target)
                    me->CastSpell(me, SPELL_FROGGER_EXPLODE, true);
            }
        }
    };
};

void AddSC_instance_naxxramas()
{
    new instance_naxxramas();
    new boss_naxxramas_misc();
}
