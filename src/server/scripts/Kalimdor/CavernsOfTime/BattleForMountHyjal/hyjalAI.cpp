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
SDName: HyjalAI
SD%Complete: 90
SDComment:
SDCategory: Caverns of Time, Mount Hyjal
EndScriptData */

#include "hyjalAI.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "hyjal_trash.h"

enum Spawns
{
    SPAWN_GARG_GATE     = 0,
    SPAWN_WYRM_GATE     = 1,
    SPAWN_NEAR_TOWER    = 2,
};

#define YELL_HURRY  "Hurry, we don't have much time"

hyjalAI::hyjalAI(Creature* creature) : npc_escortAI(creature), Summons(me)
{
    instance = creature->GetInstanceScript();
    VeinsSpawned[0] = false;
    VeinsSpawned[1] = false;
    InfernalCount = 0;
    TeleportTimer = 1000;
    Overrun = false;
    Teleported = false;
    WaitForTeleport = false;
    OverrunCounter = 0;
    OverrunCounter2 = 0;
    InfernalPoint = 0;
    RespawnTimer = 10000;
    DoRespawn = false;
    DoHide = false;
    MassTeleportTimer = 0;
    DoMassTeleport = false;
}

void hyjalAI::JustSummoned(Creature* summoned)
{
    Summons.Summon(summoned);
}

void hyjalAI::SummonedCreatureDespawn(Creature* summoned)
{
    Summons.Despawn(summoned);
}

void hyjalAI::Reset()
{
    IsDummy = false;
    me->setActive(true);
    // GUIDs
    PlayerGUID.Clear();
    BossGUID[0].Clear();
    BossGUID[1].Clear();

    // Timers
    NextWaveTimer = 10000;
    CheckTimer = 0;
    RetreatTimer = 1000;

    // Misc
    WaveCount = 0;
    EnemyCount = 0;

    // Set faction properly based on Creature entry
    switch (me->GetEntry())
    {
        case JAINA:
            Faction = 0;
            DoCast(me, SPELL_BRILLIANCE_AURA, true);
            break;

        case THRALL:
            Faction = 1;
            break;

        case TYRANDE:
            Faction = 2;
            break;
    }

    //Bools
    EventBegun = false;
    FirstBossDead = false;
    SecondBossDead = false;
    Summon = false;
    bRetreat = false;
    Debug = false;

    //Flags
    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);

    //Initialize spells
    memset(Spells, 0, sizeof(Spell) * HYJAL_AI_MAX_SPELLS);

    //Reset Instance Data for trash count
    if ((!instance->GetData(DATA_ALLIANCE_RETREAT) && me->GetEntry() == JAINA) || (instance->GetData(DATA_ALLIANCE_RETREAT) && me->GetEntry() == THRALL))
    {
        //Reset World States
        instance->DoUpdateWorldState(WORLD_STATE_WAVES, 0);
        instance->DoUpdateWorldState(WORLD_STATE_ENEMY, 0);
        instance->DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, 0);
        instance->SetData(DATA_RESET_TRASH_COUNT, 0);
    }

    //Visibility
    DoHide = true;
}

void hyjalAI::EnterEvadeMode(EvadeReason /*why*/)
{
    if (me->GetEntry() != JAINA)
        me->RemoveAllAuras();
    me->GetThreatMgr().ClearAllThreat();
    me->CombatStop(true);
    me->LoadCreaturesAddon(true);

    if (me->IsAlive())
        me->GetMotionMaster()->MoveTargetedHome();

    me->SetLootRecipient(nullptr);
}

void hyjalAI::JustEngagedWith(Unit* /*who*/)
{
    if (IsDummy)return;
    for (uint8 i = 0; i < HYJAL_AI_MAX_SPELLS; ++i)
        if (Spells[i].Cooldown)
            SpellTimer[i] = Spells[i].Cooldown;

    Talk(ATTACKED);
}

void hyjalAI::MoveInLineOfSight(Unit* who)
{
    if (IsDummy)
        return;

    npc_escortAI::MoveInLineOfSight(who);
}

void hyjalAI::SummonCreature(uint32 entry, float Base[4][3])
{
    uint32 random = rand() % 4;
    float SpawnLoc[3];

    for (uint8 i = 0; i < 3; ++i)
    {
        SpawnLoc[i] = Base[random][i];
    }
    Creature* creature = nullptr;
    switch (entry)
    {
        case 17906:    //GARGOYLE

            if (!FirstBossDead && (WaveCount == 1 || WaveCount == 3))
            {
                //summon at tower
                creature = me->SummonCreature(entry, SpawnPointSpecial[SPAWN_NEAR_TOWER][0] + irand(-20, 20), SpawnPointSpecial[SPAWN_NEAR_TOWER][1] + irand(-20, 20), SpawnPointSpecial[SPAWN_NEAR_TOWER][2] + irand(-10, 10), 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 120000);
                if (creature)
                    CAST_AI(hyjal_trashAI, creature->AI())->useFlyPath = true;
            }
            else
            {
                //summon at gate
                creature = me->SummonCreature(entry, SpawnPointSpecial[SPAWN_GARG_GATE][0] + irand(-10, 10), SpawnPointSpecial[SPAWN_GARG_GATE][1] + irand(-10, 10), SpawnPointSpecial[SPAWN_GARG_GATE][2] + irand(-10, 10), 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 120000);
            }
            break;
        case 17907:    //FROST_WYRM,
            if (FirstBossDead && WaveCount == 1) //summon at gate
                creature = me->SummonCreature(entry, SpawnPointSpecial[SPAWN_WYRM_GATE][0], SpawnPointSpecial[SPAWN_WYRM_GATE][1], SpawnPointSpecial[SPAWN_WYRM_GATE][2], 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 120000);
            else
            {
                creature = me->SummonCreature(entry, SpawnPointSpecial[SPAWN_NEAR_TOWER][0], SpawnPointSpecial[SPAWN_NEAR_TOWER][1], SpawnPointSpecial[SPAWN_NEAR_TOWER][2], 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 120000);
                if (creature)
                    CAST_AI(hyjal_trashAI, creature->AI())->useFlyPath = true;
            }
            break;
        case 17908:    //GIANT_INFERNAL
            ++InfernalCount;
            if (InfernalCount > 7)
                InfernalCount = 0;
            creature = me->SummonCreature(entry, InfernalPos[InfernalCount][0], InfernalPos[InfernalCount][1], InfernalPos[InfernalCount][2], 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 120000);
            break;
        default:
            creature = me->SummonCreature(entry, SpawnLoc[0], SpawnLoc[1], SpawnLoc[2], 0, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 120000);
            break;
    }

    if (creature)
    {
        // Increment Enemy Count to be used in World States and instance script
        ++EnemyCount;

        creature->SetWalk(false);
        creature->setActive(true);
        switch (entry)
        {
            case NECROMANCER:
            case ABOMINATION:
            case GHOUL:
            case BANSHEE:
            case CRYPT_FIEND:
            case GARGOYLE:
            case FROST_WYRM:
            case GIANT_INFERNAL:
            case FEL_STALKER:
            case RAGE_WINTERCHILL:
            case ANETHERON:
            case KAZROGAL:
            case AZGALOR:
                CAST_AI(hyjal_trashAI, creature->AI())->IsEvent = true;
                break;
        }
        if (instance->GetData(DATA_RAIDDAMAGE) < MINRAIDDAMAGE)
            creature->SetDisableReputationGain(true);//no repu for solo farming
        // Check if Creature is a boss.
        if (creature->isWorldBoss())
        {
            if (!FirstBossDead)  BossGUID[0] = creature->GetGUID();
            else                BossGUID[1] = creature->GetGUID();
            CheckTimer = 5000;
        }
    }
}

void hyjalAI::SummonNextWave(const Wave wave[18], uint32 Count, float Base[4][3])
{
    // 1 in 4 chance we give a rally yell. Not sure if the chance is offilike.
    if (rand() % 4 == 0)
        Talk(RALLY);

    InfernalCount = 0;//reset infernal count every new wave

    EnemyCount = instance->GetData(DATA_TRASH);
    for (uint8 i = 0; i < 18; ++i)
    {
        if (wave[Count].Mob[i])
            SummonCreature(wave[Count].Mob[i], Base);
    }

    if (!wave[Count].IsBoss)
    {
        uint32 stateValue = Count + 1;
        if (FirstBossDead)
            stateValue -= 9;                                // Subtract 9 from it to give the proper wave number if we are greater than 8

        // Set world state to our current wave number
        instance->DoUpdateWorldState(WORLD_STATE_WAVES, stateValue);    // Set world state to our current wave number
        // Enable world state
        instance->DoUpdateWorldState(WORLD_STATE_ENEMY, 1);             // Enable world state

        instance->SetData(DATA_TRASH, EnemyCount);         // Send data for instance script to update count

        if (!Debug)
            NextWaveTimer = wave[Count].WaveTimer;
        else
        {
            NextWaveTimer = 15000;
            //LOG_DEBUG("scripts", "HyjalAI: debug mode is enabled. Next Wave in 15 seconds");
        }
    }
    else
    {
        // Set world state for waves to 0 to disable it.
        instance->DoUpdateWorldState(WORLD_STATE_WAVES, 0);
        instance->DoUpdateWorldState(WORLD_STATE_ENEMY, 1);

        // Set World State for enemies invading to 1.
        instance->DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, 1);

        Summon = false;
    }
    CheckTimer = 5000;
}

void hyjalAI::StartEvent(Player* player)
{
    if (!player || IsDummy || !instance)
        return;

    Talk(BEGIN);

    EventBegun = true;
    Summon = true;

    NextWaveTimer = 15000;
    CheckTimer = 5000;
    PlayerGUID = player->GetGUID();

    me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

    instance->DoUpdateWorldState(WORLD_STATE_WAVES, 0);
    instance->DoUpdateWorldState(WORLD_STATE_ENEMY, 0);
    instance->DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, 0);

    DeSpawnVeins();
}

uint32 hyjalAI::GetInstanceData(uint32 Event)
{
    return instance->GetData(Event);
}

void hyjalAI::Retreat()
{
    instance->SetData(TYPE_RETREAT, SPECIAL);

    if (Faction == 0)
    {
        instance->SetData(DATA_ALLIANCE_RETREAT, 1);
        AddWaypoint(0, JainaWPs[0][0], JainaWPs[0][1], JainaWPs[0][2]);
        AddWaypoint(1, JainaWPs[1][0], JainaWPs[1][1], JainaWPs[1][2]);
        Start(false, false);
        SetDespawnAtEnd(false);//move to center of alliance base
    }
    if (Faction == 1)
    {
        instance->SetData(DATA_HORDE_RETREAT, 1);
        Creature* JainaDummy = me->SummonCreature(JAINA, JainaDummySpawn[0][0], JainaDummySpawn[0][1], JainaDummySpawn[0][2], JainaDummySpawn[0][3], TEMPSUMMON_TIMED_DESPAWN, 60000);
        if (JainaDummy)
        {
            JainaDummy->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            CAST_AI(hyjalAI, JainaDummy->AI())->IsDummy = true;
            DummyGuid = JainaDummy->GetGUID();
        }
        AddWaypoint(0, JainaDummySpawn[1][0], JainaDummySpawn[1][1], JainaDummySpawn[1][2]);
        Start(false, false);
        SetDespawnAtEnd(false);//move to center of alliance base
    }
    SpawnVeins();
    Overrun = true;
    me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);//cant talk after overrun event started
}

void hyjalAI::SpawnVeins()
{
    if (Faction == 0)
    {
        if (VeinsSpawned[0])//prevent any buggers
            return;
        for (uint8 i = 0; i < 7; ++i)
        {
            GameObject* gem = me->SummonGameObject(GO_ANCIENT_VEIN, VeinPos[i][0], VeinPos[i][1], VeinPos[i][2], VeinPos[i][3], VeinPos[i][4], VeinPos[i][5], VeinPos[i][6], VeinPos[i][7], 0);
            if (gem)
                VeinGUID[i] = gem->GetGUID();
        }
        VeinsSpawned[0] = true;
    }
    else
    {
        if (VeinsSpawned[1])
            return;
        for (uint8 i = 7; i < 14; ++i)
        {
            GameObject* gem = me->SummonGameObject(GO_ANCIENT_VEIN, VeinPos[i][0], VeinPos[i][1], VeinPos[i][2], VeinPos[i][3], VeinPos[i][4], VeinPos[i][5], VeinPos[i][6], VeinPos[i][7], 0);
            if (gem)
                VeinGUID[i] = gem->GetGUID();
        }
        VeinsSpawned[1] = true;
    }
}

void hyjalAI::DeSpawnVeins()
{
    if (Faction == 1)
    {
        Creature* unit = ObjectAccessor::GetCreature((*me), instance->GetGuidData(DATA_JAINAPROUDMOORE));
        if (!unit)return;
        hyjalAI* ai = CAST_AI(hyjalAI, unit->AI());
        if (!ai)return;
        for (uint8 i = 0; i < 7; ++i)
        {
            if (GameObject* gem = instance->instance->GetGameObject(ai->VeinGUID[i]))
                gem->Delete();
        }
    }
    else if (Faction)
    {
        Creature* unit = ObjectAccessor::GetCreature((*me), instance->GetGuidData(DATA_THRALL));
        if (!unit)return;
        hyjalAI* ai = CAST_AI(hyjalAI, unit->AI());
        if (!ai)return;
        for (uint8 i = 7; i < 14; ++i)
        {
            if (GameObject* gem = instance->instance->GetGameObject(ai->VeinGUID[i]))
                gem->Delete();
        }
    }
}

void hyjalAI::UpdateAI(uint32 diff)
{
    if (IsDummy)
    {
        if (MassTeleportTimer < diff && DoMassTeleport)
        {
            DoCast(me, SPELL_MASS_TELEPORT, false);
            DoMassTeleport = false;
        }
        else MassTeleportTimer -= diff;
        return;
    }
    if (DoHide)
    {
        DoHide = false;
        switch (me->GetEntry())
        {
            case JAINA:
                if (instance->GetData(DATA_ALLIANCE_RETREAT))
                {
                    me->SetVisible(false);
                    HideNearPos(me->GetPositionX(), me->GetPositionY());
                    HideNearPos(5037.76f, -1889.71f);
                    for (uint8 i = 0; i < 92; ++i)//summon fires
                        me->SummonGameObject(GO_ROARING_FLAME, AllianceFirePos[i][0], AllianceFirePos[i][1], AllianceFirePos[i][2], AllianceFirePos[i][3], AllianceFirePos[i][4], AllianceFirePos[i][5], AllianceFirePos[i][6], AllianceFirePos[i][7], 0);
                }
                else me->SetVisible(true);
                break;
            case THRALL: //thrall
                if (instance->GetData(DATA_HORDE_RETREAT))
                {
                    me->SetVisible(false);
                    HideNearPos(me->GetPositionX(), me->GetPositionY());
                    HideNearPos(5563, -2763.19f);
                    HideNearPos(5542.2f, -2629.36f);
                    for (uint8 i = 0; i < 65; ++i)//summon fires
                        me->SummonGameObject(GO_ROARING_FLAME, HordeFirePos[i][0], HordeFirePos[i][1], HordeFirePos[i][2], HordeFirePos[i][3], HordeFirePos[i][4], HordeFirePos[i][5], HordeFirePos[i][6], HordeFirePos[i][7], 0);
                }
                else me->SetVisible(true);
                break;
        }
    }
    if (DoRespawn)
    {
        if (RespawnTimer <= diff)
        {
            DoRespawn = false;
            RespawnNearPos(me->GetPositionX(), me->GetPositionY());
            if (Faction == 0)
            {
                RespawnNearPos(5037.76f, -1889.71f);
            }
            else if (Faction == 1)
            {
                RespawnNearPos(5563, -2763.19f);
                RespawnNearPos(5542.2f, -2629.36f);
            }
            me->SetVisible(true);
        }
        else
        {
            RespawnTimer -= diff;
            me->SetVisible(false);
        }
        return;
    }
    if (Overrun)
        DoOverrun(Faction, diff);
    if (bRetreat)
    {
        if (RetreatTimer <= diff)
        {
            IsDummy = true;
            bRetreat = false;
            HideNearPos(me->GetPositionX(), me->GetPositionY());
            switch (me->GetEntry())
            {
                case JAINA://jaina
                    HideNearPos(5037.76f, -1889.71f);
                    break;
                case THRALL://thrall
                    HideNearPos(5563, -2763.19f);
                    HideNearPos(5542.2f, -2629.36f);
                    HideNearPos(5603.75f, -2853.12f);
                    break;
            }
            me->SetVisible(false);
        }
        else RetreatTimer -= diff;
    }

    if (!EventBegun)
        return;

    if (Summon)
    {
        if (EnemyCount)
        {
            EnemyCount = instance->GetData(DATA_TRASH);
            if (!EnemyCount)
                NextWaveTimer = 5000;
        }

        if (NextWaveTimer <= diff)
        {
            if (Faction == 0)
                SummonNextWave(AllianceWaves, WaveCount, AllianceBase);
            else if (Faction == 1)
                SummonNextWave(HordeWaves, WaveCount, HordeBase);
            ++WaveCount;
        }
        else NextWaveTimer -= diff;
    }

    if (CheckTimer <= diff)
    {
        for (uint8 i = 0; i < 2; ++i)
        {
            if (BossGUID[i])
            {
                Unit* unit = ObjectAccessor::GetUnit(*me, BossGUID[i]);
                if (unit && (!unit->IsAlive()))
                {
                    if (BossGUID[i] == BossGUID[0])
                    {
                        Talk(INCOMING);
                        FirstBossDead = true;
                    }
                    else if (BossGUID[i] == BossGUID[1])
                    {
                        Talk(SUCCESS);
                        SecondBossDead = true;
                    }
                    EventBegun = false;
                    CheckTimer = 0;
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    BossGUID[i].Clear();
                    instance->DoUpdateWorldState(WORLD_STATE_ENEMY, 0); // Reset world state for enemies to disable it
                }
            }
        }
        CheckTimer = 5000;
    }
    else CheckTimer -= diff;

    if (!UpdateVictim())
        return;

    for (uint8 i = 0; i < HYJAL_AI_MAX_SPELLS; ++i)
    {
        if (Spells[i].SpellId)
        {
            if (SpellTimer[i] <= diff)
            {
                if (me->IsNonMeleeSpellCast(false))
                    me->InterruptNonMeleeSpells(false);

                Unit* target = nullptr;

                switch (Spells[i].TargetType)
                {
                    case TARGETTYPE_SELF:
                        target = me;
                        break;

                    case TARGETTYPE_RANDOM:
                        target = SelectTarget(SelectTargetMethod::Random, 0);
                        break;

                    case TARGETTYPE_VICTIM:
                        target = me->GetVictim();
                        break;
                }

                if (target && target->IsAlive())
                {
                    DoCast(target, Spells[i].SpellId);
                    SpellTimer[i] = Spells[i].Cooldown;
                }
            }
            else SpellTimer[i] -= diff;
        }
    }

    DoMeleeAttackIfReady();
}

void hyjalAI::JustDied(Unit* /*killer*/)
{
    if (IsDummy)return;
    me->Respawn();
    me->SetVisible(false);
    DoRespawn = true;
    RespawnTimer = 120000;
    Talk(DEATH);
    Summons.DespawnAll();//despawn all wave's summons
    //reset encounter if boss is despawned (ex: thrall is killed, boss despawns, event stucks at inprogress)
    if (instance->GetData(DATA_RAGEWINTERCHILLEVENT) == IN_PROGRESS)
        instance->SetData(DATA_RAGEWINTERCHILLEVENT, NOT_STARTED);
    if (instance->GetData(DATA_ANETHERONEVENT) == IN_PROGRESS)
        instance->SetData(DATA_ANETHERONEVENT, NOT_STARTED);
    if (instance->GetData(DATA_KAZROGALEVENT) == IN_PROGRESS)
        instance->SetData(DATA_KAZROGALEVENT, NOT_STARTED);
    if (instance->GetData(DATA_AZGALOREVENT) == IN_PROGRESS)
        instance->SetData(DATA_AZGALOREVENT, NOT_STARTED);
    instance->SetData(DATA_RESET_RAIDDAMAGE, 0);//reset damage on die
}

void hyjalAI::HideNearPos(float x, float y)
{
    // First get all creatures.
    std::list<Creature*> creatures;
    Acore::AllFriendlyCreaturesInGrid creature_check(me);
    Acore::CreatureListSearcher<Acore::AllFriendlyCreaturesInGrid> creature_searcher(me, creatures, creature_check);

    Cell::VisitGridObjects(x, y, me->GetMap(), creature_searcher, me->GetGridActivationRange());

    if (!creatures.empty())
    {
        for (std::list<Creature*>::const_iterator itr = creatures.begin(); itr != creatures.end(); ++itr)
        {
            (*itr)->SetVisible(false);
            (*itr)->SetFaction(FACTION_FRIENDLY); // make them friendly so mobs won't attack them
        }
    }
}

void hyjalAI::RespawnNearPos(float x, float y)
{
    Acore::RespawnDo u_do;
    Acore::WorldObjectWorker<Acore::RespawnDo> worker(me, u_do);
    Cell::VisitGridObjects(x, y, me->GetMap(), worker, me->GetGridActivationRange());
}

void hyjalAI::WaypointReached(uint32 waypointId)
{
    if (waypointId == 1 || (waypointId == 0 && me->GetEntry() == THRALL))
    {
        me->Yell(YELL_HURRY, LANG_UNIVERSAL);
        WaitForTeleport = true;
        TeleportTimer = 20000;
        if (me->GetEntry() == JAINA)
            DoCast(me, SPELL_MASS_TELEPORT, false);
        if (me->GetEntry() == THRALL && DummyGuid)
        {
            if (Creature* creature = ObjectAccessor::GetCreature(*me, DummyGuid))
            {
                hyjalAI* ai = CAST_AI(hyjalAI, creature->AI());
                ai->DoMassTeleport = true;
                ai->MassTeleportTimer = 20000;
                creature->CastSpell(me, SPELL_MASS_TELEPORT, false);
            }
        }
        //do some talking
        //all alive guards walk near here
        // First get all creatures.
        std::list<Creature*> creatures;
        Acore::AllFriendlyCreaturesInGrid creature_check(me);
        Acore::CreatureListSearcher<Acore::AllFriendlyCreaturesInGrid> creature_searcher(me, creatures, creature_check);
        Cell::VisitGridObjects(me, creature_searcher, me->GetGridActivationRange());

        if (!creatures.empty())
        {
            for (std::list<Creature*>::const_iterator itr = creatures.begin(); itr != creatures.end(); ++itr)
            {
                if ((*itr) && (*itr)->IsAlive() && (*itr) != me && (*itr)->GetEntry() != JAINA)
                {
                    if (!(*itr)->IsWithinDist(me, 60))
                        (*itr)->SetWalk(false);
                    float x, y, z;
                    (*itr)->SetDefaultMovementType(IDLE_MOTION_TYPE);
                    (*itr)->GetMotionMaster()->Initialize();
                    float range = 10;
                    if (me->GetEntry() == THRALL)range = 20;
                    me->GetNearPoint(me, x, y, z, range, 0, me->GetAngle((*itr)));
                    (*itr)->GetMotionMaster()->MovePoint(0, x + irand(-5, 5), y + irand(-5, 5), me->GetPositionZ());
                }
            }
        }
    }
}
void hyjalAI::DoOverrun(uint32 faction, const uint32 diff)
{
    npc_escortAI::UpdateAI(diff);
    if (WaitForTeleport)
    {
        if (TeleportTimer <= diff)
        {
            std::list<Creature*> creatures;
            Acore::AllFriendlyCreaturesInGrid creature_check(me);
            Acore::CreatureListSearcher<Acore::AllFriendlyCreaturesInGrid> creature_searcher(me, creatures, creature_check);
            Cell::VisitGridObjects(me, creature_searcher, me->GetGridActivationRange());

            if (!creatures.empty())
            {
                for (std::list<Creature*>::const_iterator itr = creatures.begin(); itr != creatures.end(); ++itr)
                {
                    if ((*itr) && (*itr)->IsAlive())
                    {
                        (*itr)->CastSpell(*itr, SPELL_TELEPORT_VISUAL, true);
                        (*itr)->SetFaction(FACTION_FRIENDLY); // make them friendly so mobs won't attack them
                        (*itr)->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    }
                }
                DoCast(me, SPELL_TELEPORT_VISUAL);
                bRetreat = true;
                RetreatTimer = 1000;
            }

            WaitForTeleport = false;
            Teleported = true;
        }
        TeleportTimer -= diff;
    }
    if (!Teleported)
        return;
    Overrun = false;//execute once
    switch (faction)
    {
        case 0://alliance
            for (uint8 i = 0; i < 92; ++i)//summon fires
                me->SummonGameObject(GO_ROARING_FLAME, AllianceFirePos[i][0], AllianceFirePos[i][1], AllianceFirePos[i][2], AllianceFirePos[i][3], AllianceFirePos[i][4], AllianceFirePos[i][5], AllianceFirePos[i][6], AllianceFirePos[i][7], 0);

            for (uint8 i = 0; i < 25; ++i)//summon 25 ghouls
            {
                uint8 r = rand() % 4;
                Creature* unit = me->SummonCreature(GHOUL, AllianceBase[r][0] + irand(-15, 15), AllianceBase[r][1] + irand(-15, 15), AllianceBase[r][2], 0, TEMPSUMMON_MANUAL_DESPAWN, 2 * 60 * 1000);
                if (unit)
                {
                    CAST_AI(hyjal_trashAI, unit->AI())->faction = Faction;
                    CAST_AI(hyjal_trashAI, unit->AI())->IsOverrun = true;
                    CAST_AI(hyjal_trashAI, unit->AI())->OverrunType = i;
                    unit->setActive(true);
                }
            }
            for (uint8 i = 0; i < 3; ++i)//summon 3 abominations
            {
                uint8 r = rand() % 4;
                Creature* unit = me->SummonCreature(ABOMINATION, AllianceBase[r][0] + irand(-15, 15), AllianceBase[r][1] + irand(-15, 15), AllianceBase[r][2], 0, TEMPSUMMON_MANUAL_DESPAWN, 2 * 60 * 1000);
                if (unit)
                {
                    CAST_AI(hyjal_trashAI, unit->AI())->faction = Faction;
                    CAST_AI(hyjal_trashAI, unit->AI())->IsOverrun = true;
                    CAST_AI(hyjal_trashAI, unit->AI())->OverrunType = i;
                    unit->setActive(true);
                }
            }
            for (uint8 i = 0; i < 5; ++i)//summon 5 gargoyles
            {
                Creature* unit = me->SummonCreature(GARGOYLE, AllianceOverrunGargPos[i][0], AllianceOverrunGargPos[i][1], AllianceOverrunGargPos[i][2], AllianceOverrunGargPos[i][3], TEMPSUMMON_MANUAL_DESPAWN, 2 * 60 * 1000);
                if (unit)
                {
                    unit->SetHomePosition(AllianceOverrunGargPos[i][0], AllianceOverrunGargPos[i][1], AllianceOverrunGargPos[i][2], AllianceOverrunGargPos[i][3]);
                    CAST_AI(hyjal_trashAI, unit->AI())->faction = Faction;
                    CAST_AI(hyjal_trashAI, unit->AI())->IsOverrun = true;
                    CAST_AI(hyjal_trashAI, unit->AI())->OverrunType = i;
                    unit->setActive(true);
                }
            }
            break;
        case 1://horde
            for (uint8 i = 0; i < 65; ++i)//summon fires
                me->SummonGameObject(GO_ROARING_FLAME, HordeFirePos[i][0], HordeFirePos[i][1], HordeFirePos[i][2], HordeFirePos[i][3], HordeFirePos[i][4], HordeFirePos[i][5], HordeFirePos[i][6], HordeFirePos[i][7], 0);

            for (uint8 i = 0; i < 26; ++i)//summon infernals
            {
                Creature* unit = me->SummonCreature(GIANT_INFERNAL, InfernalSPWP[i][0], InfernalSPWP[i][1], InfernalSPWP[i][2], InfernalSPWP[i][3], TEMPSUMMON_MANUAL_DESPAWN, 2 * 60 * 1000);
                if (unit)
                {
                    unit->SetHomePosition(InfernalSPWP[i][0], InfernalSPWP[i][1], InfernalSPWP[i][2], InfernalSPWP[i][3]);
                    CAST_AI(hyjal_trashAI, unit->AI())->faction = Faction;
                    CAST_AI(hyjal_trashAI, unit->AI())->IsOverrun = true;
                    CAST_AI(hyjal_trashAI, unit->AI())->OverrunType = i;
                    unit->setActive(true);
                }
            }
            for (uint8 i = 0; i < 25; ++i)//summon 25 ghouls
            {
                uint8 r = rand() % 4;
                Creature* unit = me->SummonCreature(GHOUL, HordeBase[r][0] + irand(-15, 15), HordeBase[r][1] + irand(-15, 15), HordeBase[r][2], 0, TEMPSUMMON_MANUAL_DESPAWN, 2 * 60 * 1000);
                if (unit)
                {
                    CAST_AI(hyjal_trashAI, unit->AI())->faction = Faction;
                    CAST_AI(hyjal_trashAI, unit->AI())->IsOverrun = true;
                    CAST_AI(hyjal_trashAI, unit->AI())->OverrunType = i;
                    unit->setActive(true);
                }
            }
            for (uint8 i = 0; i < 5; ++i)//summon 5 abominations
            {
                uint8 r = rand() % 4;
                Creature* unit = me->SummonCreature(ABOMINATION, HordeBase[r][0] + irand(-15, 15), HordeBase[r][1] + irand(-15, 15), HordeBase[r][2], 0, TEMPSUMMON_MANUAL_DESPAWN, 2 * 60 * 1000);
                if (unit)
                {
                    CAST_AI(hyjal_trashAI, unit->AI())->faction = Faction;
                    CAST_AI(hyjal_trashAI, unit->AI())->IsOverrun = true;
                    CAST_AI(hyjal_trashAI, unit->AI())->OverrunType = i;
                    unit->setActive(true);
                }
            }
            break;
    }
}
