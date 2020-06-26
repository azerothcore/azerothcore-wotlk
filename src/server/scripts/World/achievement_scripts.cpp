/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"

#include "BattlegroundAB.h"
#include "BattlegroundWS.h"
#include "BattlegroundIC.h"
#include "BattlegroundAV.h"
#include "BattlegroundSA.h"
#include "Vehicle.h"
#include "Player.h"
#include "Creature.h"

class achievement_resilient_victory : public AchievementCriteriaScript
{
    public:
        achievement_resilient_victory() : AchievementCriteriaScript("achievement_resilient_victory") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            return bg && bg->GetBgTypeID(true) == BATTLEGROUND_AB && bg->ToBattlegroundAB()->IsTeamScores500Disadvantage(source->GetTeamId());
        }
};

class achievement_bg_control_all_nodes : public AchievementCriteriaScript
{
    public:
        achievement_bg_control_all_nodes() : AchievementCriteriaScript("achievement_bg_control_all_nodes") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            return bg && bg->AllNodesConrolledByTeam(source->GetTeamId());
        }
};

class achievement_save_the_day : public AchievementCriteriaScript
{
    public:
        achievement_save_the_day() : AchievementCriteriaScript("achievement_save_the_day") { }

        bool OnCheck(Player* source, Unit* target)
        {
            if (!target)
                return false;

            if (Player const* player = target->ToPlayer())
            {
                Battleground* bg = source->GetBattleground();
                return bg && bg->GetBgTypeID(true) == BATTLEGROUND_WS && bg->ToBattlegroundWS()->GetFlagState(player->GetTeamId()) == BG_WS_FLAG_STATE_ON_BASE;
            }
            return false;
        }
};

class achievement_bg_ic_resource_glut : public AchievementCriteriaScript
{
    public:
        achievement_bg_ic_resource_glut() : AchievementCriteriaScript("achievement_bg_ic_resource_glut") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            return bg && bg->GetBgTypeID(true) == BATTLEGROUND_IC && bg->ToBattlegroundIC()->IsResourceGlutAllowed(source->GetTeamId());
        }
};

class achievement_bg_ic_glaive_grave : public AchievementCriteriaScript
{
    public:
        achievement_bg_ic_glaive_grave() : AchievementCriteriaScript("achievement_bg_ic_glaive_grave") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (Creature* vehicle = source->GetVehicleCreatureBase())
                return vehicle->GetEntry() == NPC_GLAIVE_THROWER_H ||  vehicle->GetEntry() == NPC_GLAIVE_THROWER_A;

            return false;
        }
};

class achievement_bg_ic_mowed_down : public AchievementCriteriaScript
{
    public:
        achievement_bg_ic_mowed_down() : AchievementCriteriaScript("achievement_bg_ic_mowed_down") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (Creature* vehicle = source->GetVehicleCreatureBase())
                return vehicle->GetEntry() == NPC_KEEP_CANNON;

            return false;
        }
};

class achievement_bg_sa_artillery : public AchievementCriteriaScript
{
    public:
        achievement_bg_sa_artillery() : AchievementCriteriaScript("achievement_bg_sa_artillery") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (Creature* vehicle = source->GetVehicleCreatureBase())
                return vehicle->GetEntry() == NPC_ANTI_PERSONNAL_CANNON;

            return false;
        }
};

class achievement_arena_by_type : public AchievementCriteriaScript
{
    public:
        achievement_arena_by_type(char const* name, uint8 arenaType) : AchievementCriteriaScript(name),
            _arenaType(arenaType)
        {
        }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            return source->InArena() && source->GetBattleground()->GetArenaType() == _arenaType;
        }

    private:
        uint8 const _arenaType;
};

class achievement_sickly_gazelle : public AchievementCriteriaScript
{
public:
    achievement_sickly_gazelle() : AchievementCriteriaScript("achievement_sickly_gazelle") { }

    bool OnCheck(Player* /*source*/, Unit* target)
    {
        if (!target)
            return false;

        if (Player* victim = target->ToPlayer())
            if (victim->IsMounted())
                return true;

        return false;
    }
};

class achievement_everything_counts : public AchievementCriteriaScript
{
    public:
        achievement_everything_counts() : AchievementCriteriaScript("achievement_everything_counts") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            return bg && bg->GetBgTypeID(true) == BATTLEGROUND_AV && bg->ToBattlegroundAV()->IsBothMinesControlledByTeam(source->GetTeamId());
        }
};

class achievement_bg_av_perfection : public AchievementCriteriaScript
{
    public:
        achievement_bg_av_perfection() : AchievementCriteriaScript("achievement_bg_av_perfection") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            return bg && bg->GetBgTypeID(true) == BATTLEGROUND_AV && bg->ToBattlegroundAV()->IsAllTowersControlledAndCaptainAlive(source->GetTeamId());
        }
};

class achievement_sa_defense_of_the_ancients : public AchievementCriteriaScript
{
    public:
        achievement_sa_defense_of_the_ancients() : AchievementCriteriaScript("achievement_sa_defense_of_the_ancients") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            Battleground* bg = source->GetBattleground();
            return bg && bg->GetBgTypeID(true) == BATTLEGROUND_SA && bg->ToBattlegroundSA()->AllowDefenseOfTheAncients(source);
        }
};

enum ArgentTournamentAreas
{
    AREA_ARGENT_TOURNAMENT_FIELDS  = 4658,
    AREA_RING_OF_ASPIRANTS         = 4670,
    AREA_RING_OF_ARGENT_VALIANTS   = 4671,
    AREA_RING_OF_ALLIANCE_VALIANTS = 4672,
    AREA_RING_OF_HORDE_VALIANTS    = 4673,
    AREA_RING_OF_CHAMPIONS         = 4669,
};

class achievement_tilted : public AchievementCriteriaScript
{
    public:
        achievement_tilted() : AchievementCriteriaScript("achievement_tilted") {}

        bool OnCheck(Player* player, Unit* /*target*/)
        {
            if (!player)
                return false;

            uint32 areaid = player->GetAreaId();
            bool checkArea =    areaid == AREA_ARGENT_TOURNAMENT_FIELDS ||
                                areaid == AREA_RING_OF_ASPIRANTS ||
                                areaid == AREA_RING_OF_ARGENT_VALIANTS ||
                                areaid == AREA_RING_OF_ALLIANCE_VALIANTS ||
                                areaid == AREA_RING_OF_HORDE_VALIANTS ||
                                areaid == AREA_RING_OF_CHAMPIONS;

            return checkArea && player->duel && player->duel->isMounted;
        }
};

class achievement_not_even_a_scratch : public AchievementCriteriaScript
{
    public:
        achievement_not_even_a_scratch() : AchievementCriteriaScript("achievement_not_even_a_scratch") { }

        bool OnCheck(Player* source, Unit* /*target*/)
        {
            if (!source)
                return false;

            Battleground* battleground = source->GetBattleground();
            return battleground && battleground->GetBgTypeID(true) == BATTLEGROUND_SA && battleground->ToBattlegroundSA()->notEvenAScratch(source->GetTeamId());
        }
};

class achievement_killed_exp_or_honor_target : public AchievementCriteriaScript
{
    public:
        achievement_killed_exp_or_honor_target() : AchievementCriteriaScript("achievement_killed_exp_or_honor_target") { }

        bool OnCheck(Player* player, Unit* target)
        {
            return target && player->isHonorOrXPTarget(target);
        }
};

void AddSC_achievement_scripts()
{
    new achievement_resilient_victory();
    new achievement_bg_control_all_nodes();
    new achievement_save_the_day();
    new achievement_bg_ic_resource_glut();
    new achievement_bg_ic_glaive_grave();
    new achievement_bg_ic_mowed_down();
    new achievement_bg_sa_artillery();
    new achievement_sickly_gazelle();
    new achievement_everything_counts();
    new achievement_bg_av_perfection();
    new achievement_arena_by_type("achievement_arena_2v2_check", ARENA_TYPE_2v2);
    new achievement_arena_by_type("achievement_arena_3v3_check", ARENA_TYPE_3v3);
    new achievement_arena_by_type("achievement_arena_5v5_check", ARENA_TYPE_5v5);
    new achievement_sa_defense_of_the_ancients();
    new achievement_tilted();
    new achievement_not_even_a_scratch();
    new achievement_killed_exp_or_honor_target();
}
