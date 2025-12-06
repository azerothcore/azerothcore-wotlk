/*
 *MIT License
 *
 *Copyright (c) 2023 Azerothcore
 *
 *Permission is hereby granted, free of charge, to any person obtaining a copy
 *of this software and associated documentation files (the "Software"), to deal
 *in the Software without restriction, including without limitation the rights
 *to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *copies of the Software, and to permit persons to whom the Software is
 *furnished to do so, subject to the following conditions:
 *
 *The above copyright notice and this permission notice shall be included in all
 *copies or substantial portions of the Software.
 *
 *THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *SOFTWARE.
 */

#include "AnticheatMgr.h"
#include "BanMgr.h"
#include "Chat.h"
#include "Log.h"
#include "MapMgr.h"
#include "Player.h"
#include "Configuration/Config.h"
#include "SpellAuras.h"
#include "DatabaseEnv.h"
#include "WorldSessionMgr.h"

std::string modulestring = "anticheat";
constexpr auto LANG_ANTICHEAT_ALERT = 1;
constexpr auto LANG_ANTICHEAT_TELEPORT = 2;
constexpr auto LANG_ANTICHEAT_IGNORECONTROL = 3;
constexpr auto LANG_ANTICHEAT_DUEL = 4;
constexpr auto LANG_ANTICHEAT_BG_EXPLOIT = 5;
constexpr auto LANG_ANTICHEAT_COUNTERMEASURE = 6;

// Time between server sends acknowledgement, and client is actually acknowledged
constexpr auto ALLOWED_ACK_LAG = 2000;

enum Spells : uint32
{
    BLINK = 1953,
    BLINK_COOLDOWN_REDUCTION = 23025,       // Reduces Blink cooldown by 2 seconds.
    GLYPH_OF_BLINK = 56365,                 // Increases Blink distance by 5 yards.
    SHADOWSTEP = 36554,
    FILTHY_TRICKS_RANK_1 = 58414,           // Reduces Shadowstep cooldown by 5 seconds.
    FILTHY_TRICKS_RANK_2 = 58415,           // Reduces Shadowstep cooldown by 10 seconds.
    SHACKLES = 38505,
    LFG_SPELL_DUNGEON_DESERTER = 71041,
    BG_SPELL_DESERTER = 26013,
    SILENCED = 23207,
    RESURRECTION_SICKNESS = 15007,
    SLOWDOWN = 61458
};

AnticheatMgr::AnticheatMgr()
{
    _opackorders =
    {
        { SMSG_FORCE_WALK_SPEED_CHANGE, CMSG_FORCE_WALK_SPEED_CHANGE_ACK },
        { SMSG_FORCE_RUN_SPEED_CHANGE, CMSG_FORCE_RUN_SPEED_CHANGE_ACK },
        { SMSG_FORCE_RUN_BACK_SPEED_CHANGE, CMSG_FORCE_RUN_BACK_SPEED_CHANGE_ACK },
        { SMSG_FORCE_SWIM_SPEED_CHANGE, CMSG_FORCE_SWIM_SPEED_CHANGE_ACK },
        { SMSG_FORCE_SWIM_BACK_SPEED_CHANGE, CMSG_FORCE_SWIM_BACK_SPEED_CHANGE_ACK },
        { SMSG_FORCE_TURN_RATE_CHANGE, CMSG_FORCE_TURN_RATE_CHANGE_ACK },
        { SMSG_FORCE_PITCH_RATE_CHANGE, CMSG_FORCE_PITCH_RATE_CHANGE_ACK },
        { SMSG_FORCE_FLIGHT_SPEED_CHANGE, CMSG_FORCE_FLIGHT_SPEED_CHANGE_ACK },
        { SMSG_FORCE_FLIGHT_BACK_SPEED_CHANGE, CMSG_FORCE_FLIGHT_BACK_SPEED_CHANGE_ACK },
        { SMSG_FORCE_MOVE_ROOT, CMSG_FORCE_MOVE_ROOT_ACK },
        { SMSG_FORCE_MOVE_UNROOT, CMSG_FORCE_MOVE_UNROOT_ACK },
        { SMSG_MOVE_KNOCK_BACK, CMSG_MOVE_KNOCK_BACK_ACK },
        { SMSG_MOVE_FEATHER_FALL, SMSG_MOVE_NORMAL_FALL, CMSG_MOVE_FEATHER_FALL_ACK },
        { SMSG_MOVE_SET_HOVER, SMSG_MOVE_UNSET_HOVER, CMSG_MOVE_HOVER_ACK },
        { SMSG_MOVE_SET_CAN_FLY, SMSG_MOVE_UNSET_CAN_FLY, CMSG_MOVE_SET_CAN_FLY_ACK },
        { SMSG_MOVE_WATER_WALK, SMSG_MOVE_LAND_WALK, CMSG_MOVE_WATER_WALK_ACK },
        { SMSG_MOVE_SET_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY, SMSG_MOVE_UNSET_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY, CMSG_MOVE_SET_CAN_TRANSITION_BETWEEN_SWIM_AND_FLY_ACK },
        { SMSG_MOVE_GRAVITY_ENABLE, CMSG_MOVE_GRAVITY_ENABLE_ACK },
        { SMSG_MOVE_GRAVITY_DISABLE, CMSG_MOVE_GRAVITY_DISABLE_ACK },
        { SMSG_MOVE_SET_COLLISION_HGT, CMSG_MOVE_SET_COLLISION_HGT_ACK }
    };
}

AnticheatMgr::~AnticheatMgr()
{
    m_Players.clear();
}

void AnticheatMgr::DoToAllGMs(std::function<void(Player*)> exec)
{
    WorldSessionMgr::SessionMap const& sessionMap = sWorldSessionMgr->GetAllSessions();
    for (WorldSessionMgr::SessionMap::const_iterator itr = sessionMap.begin(); itr != sessionMap.end(); ++itr)
        if (Player* player = itr->second->GetPlayer())
            if (!AccountMgr::IsPlayerAccount(player->GetSession()->GetSecurity()) && player->IsInWorld())
                exec(player);
}

void AnticheatMgr::StartHackDetection(Player* player, MovementInfo movementInfo, uint32 opcode)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.Enabled", true))
        return;

    if (player->IsGameMaster())
        return;

    ObjectGuid key = player->GetGUID();

    if (player->IsInFlight() || player->GetTransport() || player->GetVehicle())
    {
        m_Players[key].SetLastInformations(movementInfo, opcode, player->GetMapId(), GetPlayerCurrentSpeedRate(player));
        return;
    }

    TeleportHackDetection(player, movementInfo);
    SpeedHackDetection(player, movementInfo);
    FlyHackDetection(player, movementInfo);
    JumpHackDetection(player, movementInfo, opcode);
    TeleportPlaneHackDetection(player, movementInfo, opcode);
    ClimbHackDetection(player, movementInfo, opcode);
    IgnoreControlHackDetection(player, movementInfo, opcode);
    GravityHackDetection(player, movementInfo);
    if (player->GetLiquidData().Status == LIQUID_MAP_WATER_WALK)
    {
        WalkOnWaterHackDetection(player, movementInfo);
    }
    else
    {
        ZAxisHackDetection(player, movementInfo);
    }
    if (player->GetLiquidData().Status == LIQUID_MAP_UNDER_WATER)
    {
        AntiSwimHackDetection(player, movementInfo, opcode);
    }
    AntiKnockBackHackDetection(player, movementInfo);
    NoFallDamageDetection(player, movementInfo);
    if (Battleground* bg = player->GetBattleground())
    {
        if (bg->GetStatus() == STATUS_WAIT_JOIN)
        {
            BGStartExploit(player, movementInfo);
        }
    }
    m_Players[key].SetLastInformations(movementInfo, opcode, player->GetMapId(), GetPlayerCurrentSpeedRate(player));
}

void AnticheatMgr::SendMiddleScreenGMMessage(std::string str)
{
    WorldPacket data(SMSG_NOTIFICATION, str.size() + 1);
    data << str;
    sWorldSessionMgr->SendGlobalGMMessage(&data);
}

const char* AnticheatMgr::GetReportNameFromReportType(ReportTypes reportType)
{
    switch (reportType)
    {
        case SPEED_HACK_REPORT:
            return "Speed";
        case FLY_HACK_REPORT:
            return "Fly";
        case WALK_WATER_HACK_REPORT:
            return "Walk On Water";
        case JUMP_HACK_REPORT:
            return "Jump";
        case TELEPORT_PLANE_HACK_REPORT:
            return "Teleport To Plane";
        case CLIMB_HACK_REPORT:
            return "Climb";
        case TELEPORT_HACK_REPORT:
            return "Teleport";
        case IGNORE_CONTROL_REPORT:
            return "Ignore Control";
        case ZAXIS_HACK_REPORT:
            return "Ignore Z-Axis";
        case ANTISWIM_HACK_REPORT:
            return "Anti-Swim";
        case GRAVITY_HACK_REPORT:
            return "Gravity";
        case ANTIKNOCK_BACK_HACK_REPORT:
            return "Anti-Knock Back";
        case NO_FALL_DAMAGE_HACK_REPORT:
            return "No Fall Damage";
        case OP_ACK_HACK_REPORT:
            return "Op Ack";
        case COUNTER_MEASURES_REPORT:
            return "Unknown counter measure";   // Synful-Syn: That is silly. It should not be part of the ReportTypes enum because a counter measure is not a hack.
        default:
            return "Unknown";
    }
}

uint32 AnticheatMgr::GetAlertFrequencyConfigFromReportType(ReportTypes reportType)
{
    switch (reportType)
    {
        case SPEED_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.Speed", 5));
        case FLY_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.Fly", 5));
        case WALK_WATER_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.WaterWalk", 5));
        case JUMP_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.Jump", 5));
        case TELEPORT_PLANE_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.TeleportToPlane", 1));
        case CLIMB_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.Climb", 5));
        case TELEPORT_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.Teleport", 1));
        case IGNORE_CONTROL_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.IgnoreControl", 5));
        case ZAXIS_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.ZAxis", 5));
        case ANTISWIM_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.AntiSwim", 5));
        case GRAVITY_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.Gravity", 5));
        case ANTIKNOCK_BACK_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.Antiknockback", 1));
        case NO_FALL_DAMAGE_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.NoFallDamage", 1));
        case OP_ACK_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.OpAck", 1));
        case COUNTER_MEASURES_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.AlertFrequency.CounterMeasure", 5));
        default:
            return 1;
    }
}

uint32 AnticheatMgr::GetMinimumReportInChatThresholdConfigFromReportType(ReportTypes reportType)
{
    switch (reportType)
    {
        case SPEED_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.Speed", 50));
        case FLY_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.Fly", 50));
        case WALK_WATER_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.WaterWalk", 50));
        case JUMP_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.Jump", 50));
        case TELEPORT_PLANE_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.TeleportToPlane", 50));
        case CLIMB_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.Climb", 50));
        case TELEPORT_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.Teleport", 1));
        case IGNORE_CONTROL_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.IgnoreControl", 50));
        case ZAXIS_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.ZAxis", 50));
        case ANTISWIM_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.AntiSwim", 50));
        case GRAVITY_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.Gravity", 50));
        case ANTIKNOCK_BACK_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.Antiknockback", 50));
        case NO_FALL_DAMAGE_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.NoFallDamage", 1));
        case OP_ACK_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.OpAck", 1));
        case COUNTER_MEASURES_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Min.CounterMeasure", 50));
        default:
            return 1;
    }
}

uint32 AnticheatMgr::GetMaximumReportInChatThresholdConfigFromReportType(ReportTypes reportType)
{
    switch (reportType)
    {
        case SPEED_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.Speed", 60));
        case FLY_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.Fly", 60));
        case WALK_WATER_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.WaterWalk", 60));
        case JUMP_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.Jump", 60));
        case TELEPORT_PLANE_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.TeleportToPlane", 60));
        case CLIMB_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.Climb", 60));
        case TELEPORT_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.Teleport", 60));
        case IGNORE_CONTROL_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.IgnoreControl", 60));
        case ZAXIS_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.ZAxis", 60));
        case ANTISWIM_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.AntiSwim", 60));
        case GRAVITY_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.Gravity", 60));
        case ANTIKNOCK_BACK_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.Antiknockback", 60));
        case NO_FALL_DAMAGE_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.NoFallDamage", 60));
        case OP_ACK_HACK_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.OpAck", 60));
        case COUNTER_MEASURES_REPORT:
            return std::max(1u, sConfigMgr->GetOption<uint32>("Anticheat.ReportInChatThreshold.Max.CounterMeasure", 60));
        default:
            return 80;
    }
}

void AnticheatMgr::BuildAndSendReportToIngameGameMasters(Player* player, ReportTypes reportType, Optional<MovementInfo> optMovementInfo)
{
    ObjectGuid key = player->GetGUID();
    uint32 counter = m_Players[key].GetTypeReports(reportType);

    if (counter % GetAlertFrequencyConfigFromReportType(reportType) == 0)
    {
        const char* reportName = GetReportNameFromReportType(reportType);
        SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] Possible cheater! Report name: " + reportName);
        if (counter >= GetMinimumReportInChatThresholdConfigFromReportType(reportType) && counter <= GetMaximumReportInChatThresholdConfigFromReportType(reportType))
        {
            uint32 latency = player->GetSession()->GetLatency();
            const char* playerName = player->GetName().c_str();
            if (reportType == TELEPORT_HACK_REPORT && optMovementInfo.has_value())
            {
                Position lastPosition = m_Players[key].GetLastMovementInfo().pos;
                Position position = optMovementInfo.value().pos;
                float xDiff = lastPosition.GetPositionX() - position.GetPositionX();
                float yDiff = lastPosition.GetPositionY() - position.GetPositionY();
                float zDiff = lastPosition.GetPositionZ() - position.GetPositionZ();
                DoToAllGMs([&](Player* p)
                    {
                        ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_TELEPORT, playerName, playerName, latency, xDiff, yDiff, zDiff);
                    });
            }
            else if (reportType == IGNORE_CONTROL_REPORT)
            {
                DoToAllGMs([&](Player* p)
                    {
                        ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_IGNORECONTROL, playerName, latency);
                    });
            }
            else
            {
                DoToAllGMs([&](Player* p)
                    {
                        ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_ALERT, playerName, playerName, latency, reportName);
                    });
            }
        }
    }
}

uint32 AnticheatMgr::GetTeleportSkillCooldownDurationInMS(Player* player) const
{
    switch (player->getClass())
    {
        case CLASS_ROGUE:
            if (player->HasAura(FILTHY_TRICKS_RANK_2))
                return 20000u;
            else if (player->HasAura(FILTHY_TRICKS_RANK_1))
                return 25000u;
            return 30000u;
        case CLASS_MAGE:
            if (player->HasAura(BLINK_COOLDOWN_REDUCTION)) // Bonus from Vanilla/Early TBC pvp gear.
                return 13000u;
            return 15000u;
        default:
            return 0u;
    }
}

float AnticheatMgr::GetTeleportSkillDistanceInYards(Player* player) const
{
    switch (player->getClass())
    {
        case CLASS_ROGUE: // The rogue's teleport spell is Shadowstep.
            return 25.0f; // Synful-Syn: Help needed! At least, 25 yards adjustment is better than nothing!
            // The spell can be casted at a maximum of 25 yards from the middle of the ennemy and teleports the player a short distance behind the target which might be over 25 yards, especially when the target is facing the rogue.
            // Using Shadowstep on Onyxia at as far as I could moved me by 44 yards. Doing it on a blood elf in duel moved me 29 yards.
        case CLASS_MAGE: // The mage's teleport spell is Blink.
            if (player->HasAura(GLYPH_OF_BLINK))
                return 25.1f; // Includes a 0.1 miscalculation margin.
            return 20.1f; // Includes a 0.1 miscalculation margin.
        default:
            return 0.0f;
    }
}

// Get how many yards the player can move in a second.
float AnticheatMgr::GetPlayerCurrentSpeedRate(Player* player) const
{
    // we need to know HOW is the player moving
    // TO-DO: Should we check the incoming movement flags?
    if (player->HasUnitMovementFlag(MOVEMENTFLAG_SWIMMING))
        return player->GetSpeed(MOVE_SWIM);
    else if (player->IsFlying())
        return player->GetSpeed(MOVE_FLIGHT);
    else if (player->HasUnitMovementFlag(MOVEMENTFLAG_WALKING))
        return player->GetSpeed(MOVE_WALK);
    return player->GetSpeed(MOVE_RUN);
}

void AnticheatMgr::SpeedHackDetection(Player* player, MovementInfo movementInfo)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.DetectSpeedHack", true))
        return;

    ObjectGuid key = player->GetGUID();

    if (m_Players[key].GetLastMapId() != player->GetMapId())
        return;

    // We also must check the map because the movementFlag can be modified by the client.
    // If we just check the flag, they could always add that flag and always skip the speed hacking detection.

    if (m_Players[key].GetLastMovementInfo().HasMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
    {
        switch (player->GetMapId())
        {
            case 369: //Transport: DEEPRUN TRAM
            case 607: //Transport: Strands of the Ancients
            case 582: //Transport: Rut'theran to Auberdine
            case 584: //Transport: Menethil to Theramore
            case 586: //Transport: Exodar to Auberdine
            case 587: //Transport: Feathermoon Ferry
            case 588: //Transport: Menethil to Auberdine
            case 589: //Transport: Orgrimmar to Grom'Gol
            case 590: //Transport: Grom'Gol to Undercity
            case 591: //Transport: Undercity to Orgrimmar
            case 592: //Transport: Borean Tundra Test
            case 593: //Transport: Booty Bay to Ratchet
            case 594: //Transport: Howling Fjord Sister Mercy (Quest)
            case 596: //Transport: Naglfar
            case 610: //Transport: Tirisfal to Vengeance Landing
            case 612: //Transport: Menethil to Valgarde
            case 613: //Transport: Orgrimmar to Warsong Hold
            case 614: //Transport: Stormwind to Valiance Keep
            case 620: //Transport: Moa'ki to Unu'pe
            case 621: //Transport: Moa'ki to Kamagua
            case 622: //Transport: Orgrim's Hammer
            case 623: //Transport: The Skybreaker
            case 641: //Transport: Alliance Airship BG
            case 642: //Transport: Horde Airship BG
            case 647: //Transport: Orgrimmar to Thunder Bluff
            case 672: //Transport: The Skybreaker (Icecrown Citadel Raid)
            case 673: //Transport: Orgrim's Hammer (Icecrown Citadel Raid)
            case 712: //Transport: The Skybreaker (IC Dungeon)
            case 713: //Transport: Orgrim's Hammer (IC Dungeon)
            case 718: //Transport: The Mighty Wind (Icecrown Citadel Raid)
                return;
        }
    }

    float distance2D = movementInfo.pos.GetExactDist2d(&m_Players[key].GetLastMovementInfo().pos);

    // We don't need to check for a speedhack if the player hasn't moved
    // This is necessary since MovementHandler fires if you rotate the camera in place
    if (!distance2D)
        return;

    // how long the player took to move to here.
    uint32 timeDiff = getMSTimeDiff(m_Players[key].GetLastMovementInfo().time, movementInfo.time);

    float speedRate = GetPlayerCurrentSpeedRate(player);
    if (timeDiff <= ALLOWED_ACK_LAG)
        speedRate = std::max(speedRate, m_Players[key].GetLastSpeedRate()); // The player might have been moving with a previously faster speed. This should help mitigate a false positive from loosing a speed increase buff.

    if (int32(timeDiff) < 0 && sConfigMgr->GetOption<bool>("Anticheat.CM.TIMEMANIPULATION", true))
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.WriteLog", true))
        {
            uint32 latency = player->GetSession()->GetLatency();
            std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            LOG_INFO("anticheat.module", "AnticheatMgr:: Time Manipulation - Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
        }
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.WriteLog", true))
        {
            std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            LOG_INFO("anticheat.module", "ANTICHEAT COUNTER MEASURE:: {} Time Diff Corrected (Map: {}) (possible Out of Order Time Manipulation) - Flagged at: {}", player->GetName(), player->GetMapId(), goXYZ);
        }
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTSCREEN", true))
        {
            SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] TIME MANIPULATION COUNTER MEASURE ALERT");
        }
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTCHAT", true))
        {
            const char* str = "|cFFFFFC00 TIME MANIPULATION COUNTER MEASURE ALERT";
            DoToAllGMs([&](Player* p)
                {
                    ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_COUNTERMEASURE, str, player->GetName(), player->GetName());
                });
        }
        timeDiff = 1;
        BuildReport(player, COUNTER_MEASURES_REPORT, movementInfo);
    }

    if (!timeDiff && sConfigMgr->GetOption<bool>("Anticheat.CM.TIMEMANIPULATION", true))
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
        {
            std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            LOG_INFO("anticheat.module", "ANTICHEAT COUNTER MEASURE:: {} Time Diff Corrected (Map: {}) (possible Zero Time Manipulation) - Flagged at: {}", player->GetName(), player->GetMapId(), goXYZ);
        }
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTSCREEN", true))
        {
            SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] TIME MANIPULATION COUNTER MEASURE ALERT");
        }
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTCHAT", true))
        {
            const char* str = "|cFFFFFC00 TIME MANIPULATION COUNTER MEASURE ALERT";
            DoToAllGMs([&](Player* p)
                {
                    ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_COUNTERMEASURE, str, player->GetName(), player->GetName());
                });
        }
        timeDiff = 1;
        BuildReport(player, COUNTER_MEASURES_REPORT, movementInfo);
    }

    // Adjust distance from Blink/Shadowstep.
    if (player->HasAura(BLINK) || player->HasAura(SHADOWSTEP))
    {
        // Only adjust the travelled distance if the player previously didn't use a movement spell or didn't move at all since they previously used the movement spell.
        if (!m_Players[key].GetJustUsedMovementSpell() || timeDiff >= GetTeleportSkillCooldownDurationInMS(player))
        {
            m_Players[key].SetJustUsedMovementSpell(true);
            distance2D = std::max(distance2D - GetTeleportSkillDistanceInYards(player), 0.0f);
        }
    }
    else
    {
        m_Players[key].SetJustUsedMovementSpell(false);
    }

    // this is the distance doable by the player in 1 sec, using the time done to move to this point.
    float clientSpeedRate = 0.0f;
    if (float floatTimeDiff = float(timeDiff))
        clientSpeedRate = distance2D * 1000.0f / floatTimeDiff;

    // we create a diff speed in uint32 for further precision checking to avoid legit fall and slide
    float diffspeed = clientSpeedRate - speedRate;

    // create a conf to establish a speed limit tolerance over server rate set speed
    // this is done so we can ignore minor violations that are not false positives such as going 1 or 2 over the speed limit
    float assignedspeeddiff = sConfigMgr->GetOption<float>("Anticheat.SpeedLimitTolerance", 0.0f);

    // We did the (uint32) cast to accept a margin of tolerance for seasonal spells and buffs such as sugar rush
    // We check the last MovementInfo for the falling flag since falling down a hill and sliding a bit triggered a false positive
    if ((diffspeed >= assignedspeeddiff) && !m_Players[key].GetLastMovementInfo().HasMovementFlag(MOVEMENTFLAG_FALLING))
    {
        if (clientSpeedRate > speedRate * 1.05f)
        {
            if (!player->CanTeleport())
            {
                if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
                {
                    uint32 latency = player->GetSession()->GetLatency();
                    std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                    LOG_INFO("anticheat.module", "AnticheatMgr:: Speed-Hack (Speed Movement at {}% above allowed Server Set rate {}%.) detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", clientSpeedRate, speedRate, player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
                }
                if (sConfigMgr->GetOption<bool>("Anticheat.CM.SPEEDHACK", true))
                {
                    if (Aura* slowcheater = player->AddAura(SLOWDOWN, player))
                    {
                        slowcheater->SetDuration(1000);
                    }
                    if (sConfigMgr->GetOption<bool>("Anticheat.CM.WriteLog", true))
                    {
                        std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                        LOG_INFO("anticheat.module", "ANTICHEAT COUNTER MEASURE:: {} Speed Hack Countered and has been set to Server Rate - Flagged at: {}", player->GetName(), goXYZ);
                    }
                    if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTSCREEN", true))
                    {
                        SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] SPEED COUNTER MEASURE ALERT");
                    }
                    if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTCHAT", true))
                    {
                        const char* str = "|cFFFFFC00 SPEED HACK COUNTER MEASURE ALERT";
                        DoToAllGMs([&](Player* p)
                            {
                                ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_COUNTERMEASURE, str, player->GetName(), player->GetName());
                            });
                    }
                    BuildReport(player, COUNTER_MEASURES_REPORT, movementInfo);
                }
                BuildReport(player, SPEED_HACK_REPORT, movementInfo);
            }
        }
    }
}

void AnticheatMgr::FlyHackDetection(Player* player, MovementInfo  movementInfo)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.DetectFlyHack", true))
    {
        return;
    }

    if (player->HasAuraType(SPELL_AURA_FLY) || player->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) || player->HasAuraType(SPELL_AURA_MOD_FLIGHT_SPEED_ALWAYS))//overkill but wth
    {
        return;
    }

    /*Thanks to @LilleCarl for info to check extra flag*/
    bool stricterChecks = true;
    if (sConfigMgr->GetOption<bool>("Anticheat.StricterFlyHackCheck", false))
    {
        stricterChecks = !(movementInfo.HasMovementFlag(MOVEMENTFLAG_ASCENDING | MOVEMENTFLAG_DESCENDING) && !player->IsInWater());
    }

    if (!movementInfo.HasMovementFlag(MOVEMENTFLAG_CAN_FLY) && !movementInfo.HasMovementFlag(MOVEMENTFLAG_FLYING) && stricterChecks)
    {
        return;
    }

    if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
    {
        uint32 latency = player->GetSession()->GetLatency();
        std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
        LOG_INFO("anticheat.module", "AnticheatMgr:: Fly-Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
    }

    if (sConfigMgr->GetOption<bool>("Anticheat.CM.FLYHACK", true))
    {
        WorldPacket cheater(12);
        cheater.SetOpcode(SMSG_MOVE_UNSET_CAN_FLY);
        cheater << player->GetPackGUID();
        cheater << uint32(0);
        player->SendMessageToSet(&cheater, true);
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.WriteLog", true))
        {
            std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            LOG_INFO("anticheat.module", "ANTICHEAT COUNTER MEASURE:: {} Fly Hack Countered and has Opcode set to SMSG_MOVE_UNSET_CAN_FLY - Flagged at: {}", player->GetName(), goXYZ);
        }
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTSCREEN", true))
        {
            SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] FLY HACK COUNTER MEASURE ALERT");
        }
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTCHAT", true))
        {
            const char* str = "|cFFFFFC00 FLY HACK COUNTER MEASURE ALERT";
            DoToAllGMs([&](Player* p)
                {
                    ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_COUNTERMEASURE, str, player->GetName(), player->GetName());
                });
        }
        BuildReport(player, COUNTER_MEASURES_REPORT, movementInfo);
    }

    BuildReport(player, FLY_HACK_REPORT, movementInfo);
}

void AnticheatMgr::JumpHackDetection(Player* player, MovementInfo movementInfo, uint32 opcode)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.DetectJumpHack", true))
        return;

    ObjectGuid key = player->GetGUID();

    const float ground_Z = movementInfo.pos.GetPositionZ() - player->GetMapHeight(movementInfo.pos.GetPositionX(), movementInfo.pos.GetPositionY(), movementInfo.pos.GetPositionZ());

    const bool no_fly_auras = !(player->HasAuraType(SPELL_AURA_FLY) || player->HasAuraType(SPELL_AURA_MOD_FLIGHT_SPEED_ALWAYS)
        || player->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) || player->HasAuraType(SPELL_AURA_MOD_FLIGHT_SPEED_ALWAYS)
        || player->HasAuraType(SPELL_AURA_MOD_MOUNTED_FLIGHT_SPEED_ALWAYS));
    const bool no_fly_flags = ((movementInfo.flags & (MOVEMENTFLAG_CAN_FLY | MOVEMENTFLAG_FLYING)) == 0);
    const bool no_swim_in_water = !player->IsInWater();
    const bool no_swim_above_water = movementInfo.pos.GetPositionZ() - 7.0f >= player->GetMap()->GetWaterLevel(movementInfo.pos.GetPositionX(), movementInfo.pos.GetPositionY());
    const bool no_swim_water = no_swim_in_water && no_swim_above_water;

    if (m_Players[key].GetLastOpcode() == MSG_MOVE_JUMP && opcode == MSG_MOVE_JUMP)
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
        {
            uint32 latency = player->GetSession()->GetLatency();
            std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            LOG_INFO("anticheat.module", "AnticheatMgr:: Jump-Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
        }
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.JUMPHACK", true))
        {
            player->GetMotionMaster()->MoveFall();

            if (sConfigMgr->GetOption<bool>("Anticheat.CM.WriteLog", true))
            {
                std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                LOG_INFO("anticheat.module", "ANTICHEAT COUNTER MEASURE:: {} JUMP Hack Countered and has been set to fall - Flagged at: {}", player->GetName(), goXYZ);
            }
            if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTSCREEN", true))
            {
                SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] JUMP HACK COUNTER MEASURE ALERT");
            }
            if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTCHAT", true))
            {
                const char* str = "|cFFFFFC00 JUMP HACK COUNTER MEASURE ALERT";
                DoToAllGMs([&](Player* p)
                    {
                        ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_COUNTERMEASURE, str, player->GetName(), player->GetName());
                    });
            }
            BuildReport(player, COUNTER_MEASURES_REPORT, movementInfo);
        }
        BuildReport(player, JUMP_HACK_REPORT, movementInfo);
    }
    else if (no_fly_auras && no_fly_flags && no_swim_water)
    {
        if (!sConfigMgr->GetOption<bool>("Anticheat.StricterDetectJumpHack", true))
            return;

        // We exempt select areas found in 335 to prevent false hack hits
        if (player->GetAreaId())
        {
            switch (player->GetAreaId())
            {
            case 4273: //Celestial Planetarium Observer Battle has a narrow path that false flags
                return;
            }
        }

        if (m_Players[key].GetLastOpcode() == MSG_MOVE_JUMP && !player->IsFalling())
            return;

        // This is necessary since MovementHandler fires if you rotate the camera in place
        if (!movementInfo.pos.GetExactDist2d(&m_Players[key].GetLastMovementInfo().pos))
            return;

        if (!player->HasUnitMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY) && movementInfo.jump.zspeed < -10.0f)
            return;

        if (player->HasAuraType(SPELL_AURA_WATER_WALK) || player->HasAuraType(SPELL_AURA_FEATHER_FALL) ||
            player->HasAuraType(SPELL_AURA_SAFE_FALL))
        {
            return;
        }

        if (ground_Z > 5.0f && movementInfo.pos.GetPositionZ() >= player->GetPositionZ())
        {
            if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
            {
                uint32 latency = player->GetSession()->GetLatency();
                std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                LOG_INFO("anticheat.module", "AnticheatMgr:: Stricter Check Jump-Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
            }
            if (sConfigMgr->GetOption<bool>("Anticheat.CM.ADVJUMPHACK", true))
            {
                player->GetMotionMaster()->MoveFall();

                if (sConfigMgr->GetOption<bool>("Anticheat.CM.WriteLog", true))
                {
                    std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                    LOG_INFO("anticheat.module", "ANTICHEAT COUNTER MEASURE:: {} ADVANCE JUMP Hack Countered and has been set to fall - Flagged at: {}", player->GetName(), goXYZ);
                }
                if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTSCREEN", true))
                {
                    SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] ADVANCE JUMP HACK COUNTER MEASURE ALERT");
                }
                if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTCHAT", true))
                {
                    const char* str = "|cFFFFFC00 ADVANCE JUMP HACK COUNTER MEASURE ALERT";
                    DoToAllGMs([&](Player* p)
                        {
                            ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_COUNTERMEASURE, str, player->GetName(), player->GetName());
                        });
                }
                BuildReport(player, COUNTER_MEASURES_REPORT, movementInfo);
            }
            BuildReport(player, JUMP_HACK_REPORT, movementInfo);
        }
    }
}

void AnticheatMgr::TeleportPlaneHackDetection(Player* player, MovementInfo movementInfo, uint32 opcode)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.DetectTelePlaneHack", true))
        return;

    // We exempt select areas found in 335 to prevent false hack hits
    if (player->GetAreaId())
    {
        switch (player->GetAreaId())
        {
            case 4273: //Celestial Planetarium Observer Battle has a narrow path that false flags
                return;
        }
    }

    if (player->HasAuraType(SPELL_AURA_WATER_WALK))
        return;

    if (player->HasAuraType(SPELL_AURA_WATER_BREATHING))
        return;

    if (player->HasAuraType(SPELL_AURA_GHOST))
        return;

    ObjectGuid key = player->GetGUID();

    // We don't need to check for a water walking hack if the player hasn't moved
    // This is necessary since MovementHandler fires if you rotate the camera in place
    if (!movementInfo.pos.GetExactDist2d(&m_Players[key].GetLastMovementInfo().pos))
        return;

    if (m_Players[key].GetLastOpcode() == MSG_MOVE_JUMP)
        return;

    if (opcode == (MSG_MOVE_FALL_LAND))
        return;

    if (player->GetLiquidData().Status == LIQUID_MAP_ABOVE_WATER)
        return;

    if (movementInfo.HasMovementFlag(MOVEMENTFLAG_FALLING | MOVEMENTFLAG_SWIMMING))
        return;

    // If he is flying we dont need to check
    if (movementInfo.HasMovementFlag(MOVEMENTFLAG_CAN_FLY | MOVEMENTFLAG_FLYING))
        return;

    float pos_z = player->GetPositionZ();
    float ground_Z = player->GetFloorZ();
    float groundZ = player->GetMapHeight(player->GetPositionX(), player->GetPositionY(), MAX_HEIGHT);
    float floorZ = player->GetMapHeight(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ());

    // we are not really walking there
    if (groundZ == floorZ && (fabs(ground_Z - pos_z) > 2.0f || fabs(ground_Z - pos_z) < -1.0f))
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
        {
            uint32 latency = player->GetSession()->GetLatency();
            std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            LOG_INFO("anticheat.module", "AnticheatMgr:: Teleport To Plane - Hack detected player {} ({})  - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
        }

        BuildReport(player, TELEPORT_PLANE_HACK_REPORT, movementInfo);
    }
}

void AnticheatMgr::ClimbHackDetection(Player* player, MovementInfo movementInfo, uint32 opcode)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.DetectClimbHack", true))
        return;

    // in this case we don't care if they are "legal" flags, they are handled in another parts of the Anticheat Manager.
    if (player->IsInWater() ||
        player->IsFlying() ||
        player->IsFalling())
        return;

    // If the player jumped, we dont want to check for climb hack
    // This can lead to false positives for climbing game objects legit
    if (opcode == MSG_MOVE_JUMP)
        return;

    if (player->HasUnitMovementFlag(MOVEMENTFLAG_FALLING))
        return;

    Position playerPos = player->GetPosition();

    float diffz = fabs(movementInfo.pos.GetPositionZ() - playerPos.GetPositionZ());
    float tanangle = movementInfo.pos.GetExactDist2d(&playerPos) / diffz;

    if (!player->HasUnitMovementFlag(MOVEMENTFLAG_CAN_FLY | MOVEMENTFLAG_FLYING | MOVEMENTFLAG_SWIMMING))
    {
        if (movementInfo.pos.GetPositionZ() > playerPos.GetPositionZ() &&
            diffz > 1.87f && tanangle < 0.57735026919f) // 30 degrees
        {
            if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
            {
                uint32 latency = player->GetSession()->GetLatency();
                std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                LOG_INFO("anticheat.module", "AnticheatMgr:: Climb-Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
            }

            BuildReport(player, CLIMB_HACK_REPORT, movementInfo);
        }
    }
}

void AnticheatMgr::TeleportHackDetection(Player* player, MovementInfo movementInfo)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.DetectTelePortHack", true))
        return;

    ObjectGuid key = player->GetGUID();

    if (m_Players[key].GetLastOpcode() == MSG_DELAY_GHOST_TELEPORT)
        return;

    float lastX = m_Players[key].GetLastMovementInfo().pos.GetPositionX();
    float newX = movementInfo.pos.GetPositionX();

    float lastY = m_Players[key].GetLastMovementInfo().pos.GetPositionY();
    float newY = movementInfo.pos.GetPositionY();

    float lastZ = m_Players[key].GetLastMovementInfo().pos.GetPositionZ();
    float newZ = movementInfo.pos.GetPositionZ();

    float xDiff = fabs(lastX - newX);
    float yDiff = fabs(lastY - newY);
    float zDiff = fabs(lastZ - newZ);

    if (player->IsFalling() || (player->IsFalling() && player->IsMounted()))
        return;

    if (m_Players[key].GetLastMovementInfo().HasMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
    {
        switch (player->GetMapId())
        {
            case 369: //Transport: DEEPRUN TRAM
            case 607: //Transport: Strands of the Ancients
            case 582: //Transport: Rut'theran to Auberdine
            case 584: //Transport: Menethil to Theramore
            case 586: //Transport: Exodar to Auberdine
            case 587: //Transport: Feathermoon Ferry
            case 588: //Transport: Menethil to Auberdine
            case 589: //Transport: Orgrimmar to Grom'Gol
            case 590: //Transport: Grom'Gol to Undercity
            case 591: //Transport: Undercity to Orgrimmar
            case 592: //Transport: Borean Tundra Test
            case 593: //Transport: Booty Bay to Ratchet
            case 594: //Transport: Howling Fjord Sister Mercy (Quest)
            case 596: //Transport: Naglfar
            case 610: //Transport: Tirisfal to Vengeance Landing
            case 612: //Transport: Menethil to Valgarde
            case 613: //Transport: Orgrimmar to Warsong Hold
            case 614: //Transport: Stormwind to Valiance Keep
            case 620: //Transport: Moa'ki to Unu'pe
            case 621: //Transport: Moa'ki to Kamagua
            case 622: //Transport: Orgrim's Hammer
            case 623: //Transport: The Skybreaker
            case 641: //Transport: Alliance Airship BG
            case 642: //Transport: Horde Airship BG
            case 647: //Transport: Orgrimmar to Thunder Bluff
            case 672: //Transport: The Skybreaker (Icecrown Citadel Raid)
            case 673: //Transport: Orgrim's Hammer (Icecrown Citadel Raid)
            case 712: //Transport: The Skybreaker (IC Dungeon)
            case 713: //Transport: Orgrim's Hammer (IC Dungeon)
            case 718: //Transport: The Mighty Wind (Icecrown Citadel Raid)
                return;
        }
    }

    if (player->duel)
    {
        if ((xDiff >= 50.0f || yDiff >= 50.0f) && !player->CanTeleport())
        {
            Player* opponent = player->duel->Opponent;

            SendMiddleScreenGMMessage("|cFFFFFC00[DUEL ALERT |cFF60FF00" + player->GetName() + "|cFF00FFFF] Possible Teleport Hack Detected! While Dueling [|cFF60FF00" + opponent->GetName() + "|cFF00FFFF]");

            uint32 latency = player->GetSession()->GetLatency();
            std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            std::string goXYZ2 = ".go xyz " + std::to_string(opponent->GetPositionX()) + " " + std::to_string(opponent->GetPositionY()) + " " + std::to_string(opponent->GetPositionZ() + 1.0f) + " " + std::to_string(opponent->GetMap()->GetId()) + " " + std::to_string(opponent->GetOrientation());
            uint32 latency2 = opponent->GetSession()->GetLatency();
            DoToAllGMs([&](Player* p)
                {
                    ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_DUEL, player->GetName(), latency, opponent->GetName(), latency2);
                });

            if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
            {
                LOG_INFO("anticheat.module", "AnticheatMgr:: DUEL ALERT Teleport-Hack detected player {} ({}) while dueling {} - Latency: {} ms - IP: {} - GPS Diff X: {} Y: {} Z: {} - Cheat Flagged At: {} - Cheat Flag At: {}", player->GetName(), player->GetGUID().ToString(), opponent->GetName(), latency, player->GetSession()->GetRemoteAddress().c_str(), xDiff, yDiff, zDiff, goXYZ);
                LOG_INFO("anticheat.module", "AnticheatMgr:: DUEL ALERT Teleport-Hack detected player {} ({}) while dueling {} - Latency: {} ms - IP: {} - GPS Diff X: {} Y: {} Z: {} - Cheat Flagged At: {} - Cheat Flag At: {}", opponent->GetName(), opponent->GetGUID().ToString(), player->GetName(), latency2, opponent->GetSession()->GetRemoteAddress().c_str(), xDiff, yDiff, zDiff, goXYZ2);
            }
            BuildReport(player, TELEPORT_HACK_REPORT, movementInfo);
            BuildReport(opponent, TELEPORT_HACK_REPORT, movementInfo);
        }
        else if (player->CanTeleport())
            player->SetCanTeleport(false);
    }

    if ((xDiff >= 50.0f || yDiff >= 50.0f) && !player->CanTeleport() && !player->IsBeingTeleported())
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
        {
            uint32 latency = player->GetSession()->GetLatency();
            std::string goXYZ = ".go xyz " + std::to_string(newX) + " " + std::to_string(newY) + " " + std::to_string(newZ + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            LOG_INFO("anticheat.module", "AnticheatMgr:: Teleport-Hack detected player {} ({}) - Latency: {} ms - IP: {} - GPS Diff X: {} Y: {} Z: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), xDiff, yDiff, zDiff, goXYZ);
        }
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.Teleport", true))
        {
            if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
            {
                std::string LastgoXYZ = ".go xyz " + std::to_string(lastX) + " " + std::to_string(lastY) + " " + std::to_string(lastZ + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                LOG_INFO("anticheat.module", "ANTICHEAT COUNTER MEASURE:: {} TELEPORT HACK REVERTED PLAYER BACK TO {}", player->GetName(), LastgoXYZ);
            }
            if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTSCREEN", true))
            {
                SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] TELEPORT HACK COUNTER MEASURE ALERT");
            }
            if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTCHAT", true))
            {
                const char* str = "|cFFFFFC00 TELEPORT COUNTER MEASURE ALERT";
                DoToAllGMs([&](Player* p)
                    {
                        ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_COUNTERMEASURE, str, player->GetName(), player->GetName());
                    });
            }
            player->TeleportTo(player->GetMapId(), lastX, lastY, lastZ, player->GetOrientation());
            BuildReport(player, COUNTER_MEASURES_REPORT, movementInfo);
        }
        BuildReport(player, TELEPORT_HACK_REPORT, movementInfo);
    }
    else if (player->CanTeleport())
        player->SetCanTeleport(false);
}

void AnticheatMgr::IgnoreControlHackDetection(Player* player, MovementInfo movementInfo, uint32 opcode)
{
    ObjectGuid key = player->GetGUID();

    if (!sConfigMgr->GetOption<bool>("Anticheat.IgnoreControlHack", true))
        return;

    if (m_Players[key].GetLastOpcode() == MSG_MOVE_JUMP)
        return;

    if (opcode == (MSG_MOVE_FALL_LAND))
        return;

    if (movementInfo.HasMovementFlag(MOVEMENTFLAG_FALLING | MOVEMENTFLAG_SWIMMING))
        return;

    uint32 latency = player->GetSession()->GetLatency();
    bool hasBadLatency = latency >= 400;

    if (player->HasAuraType(SPELL_AURA_MOD_ROOT) && !player->GetVehicle() && !hasBadLatency)
    {
        float lastX = m_Players[key].GetLastMovementInfo().pos.GetPositionX();
        float newX = movementInfo.pos.GetPositionX();

        float lastY = m_Players[key].GetLastMovementInfo().pos.GetPositionY();
        float newY = movementInfo.pos.GetPositionY();

        bool unrestricted = newX != lastX || newY != lastY;
        if (unrestricted)
        {
            if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
            {
                std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                LOG_INFO("anticheat.module", "AnticheatMgr:: Ignore Control - Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
            }
            BuildReport(player, IGNORE_CONTROL_REPORT, movementInfo);
        }
    }
}

void AnticheatMgr::GravityHackDetection(Player* player, MovementInfo movementInfo)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.DetectGravityHack", true))
        return;

    if (player->HasAuraType(SPELL_AURA_FEATHER_FALL))
        return;

    ObjectGuid key = player->GetGUID();
    if (m_Players[key].GetLastOpcode() == MSG_MOVE_JUMP)
    {
        if (!player->HasUnitMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY) && movementInfo.jump.zspeed < -10.0f)
        {
            if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
            {
                uint32 latency = player->GetSession()->GetLatency();
                std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                LOG_INFO("anticheat.module", "AnticheatMgr:: Gravity-Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
            }
            BuildReport(player, GRAVITY_HACK_REPORT, movementInfo);
        }
    }
}

void AnticheatMgr::WalkOnWaterHackDetection(Player* player, MovementInfo movementInfo)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.DetectWaterWalkHack", true))
        return;

    ObjectGuid key = player->GetGUID();

    // We don't need to check for a water walking hack if the player hasn't moved
    // This is necessary since MovementHandler fires if you rotate the camera in place
    if (!movementInfo.pos.GetExactDist2d(&m_Players[key].GetLastMovementInfo().pos))
        return;

    if (player->GetLiquidData().Status == LIQUID_MAP_WATER_WALK && !player->IsFlying())
    {
        if (!m_Players[key].GetLastMovementInfo().HasMovementFlag(MOVEMENTFLAG_WATERWALKING) && !movementInfo.HasMovementFlag(MOVEMENTFLAG_WATERWALKING))
        {
            if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
            {
                uint32 latency = player->GetSession()->GetLatency();
                std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                LOG_INFO("anticheat.module", "AnticheatMgr:: Walk on Water - Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
            }
            BuildReport(player, WALK_WATER_HACK_REPORT, movementInfo);
        }
    }

    // ghost can water walk
    if (player->HasAuraType(SPELL_AURA_GHOST))
        return;

    // Prevents the False Positive for water walking when you ressurrect.
    if (m_Players[key].GetLastOpcode() == MSG_DELAY_GHOST_TELEPORT)
        return;

    if (m_Players[key].GetLastMovementInfo().HasMovementFlag(MOVEMENTFLAG_WATERWALKING) && movementInfo.HasMovementFlag(MOVEMENTFLAG_WATERWALKING))
    {
        if (player->HasAuraType(SPELL_AURA_WATER_WALK) || player->HasAuraType(SPELL_AURA_FEATHER_FALL) ||
            player->HasAuraType(SPELL_AURA_SAFE_FALL))
        {
            return;
        }
    }
    else if (!m_Players[key].GetLastMovementInfo().HasMovementFlag(MOVEMENTFLAG_WATERWALKING) && !movementInfo.HasMovementFlag(MOVEMENTFLAG_WATERWALKING))
    {
        return;
    }

    if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
    {
        uint32 latency = player->GetSession()->GetLatency();
        std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
        LOG_INFO("anticheat.module", "AnticheatMgr:: Walk on Water - Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
    }
    BuildReport(player, WALK_WATER_HACK_REPORT, movementInfo);
}

void AnticheatMgr::ZAxisHackDetection(Player* player, MovementInfo movementInfo)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.DetectZaxisHack", true))
        return;

    // If he is flying we dont need to check
    if (movementInfo.HasMovementFlag(MOVEMENTFLAG_CAN_FLY))
        return;

    if (movementInfo.HasMovementFlag(MOVEMENTFLAG_FLYING))
        return;

    // If the player is allowed to waterwalk (or he is dead because he automatically waterwalks then) we dont need to check any further
    // We also stop if the player is in water, because otherwise you get a false positive for swimming
    if (movementInfo.HasMovementFlag(MOVEMENTFLAG_WATERWALKING) || player->IsInWater() || !player->IsAlive())
        return;

    // We exempt select areas found in 335 to prevent false hack hits
    switch (player->GetAreaId())
    {
        case 10:    // Duskwood bridge
        case 40:    // Westfall bridge
        case 321:   // Hammerfall wooden balcony
        case 495:   // Ring of Judgement just being in the area false flags
        case 721:   // Gnomeregan, some corridor inside the instance, .go xyz -466.640076 260.263092 -208.009796
        case 796:   // Scarlet Monastery, armory, .go xyz 1744.680786 -364.786957 8.011654
        case 3789:  // Shadow Labyrinth, boxes inside the instance, .go xyz -409.122559 -120.865135 15.713029
        case 3847:  // Botanica, Laj's platform, .go xyz -204.576462 391.573334 -11.178043
        case 4161:  // Wymrest Temple just being in the area false flags
        case 4273:  // Celestial Planetarium Observer Battle has a narrow path that false flags
            return;
        default:
            break;
    }

    // We want to exclude this LiquidStatus from detection because it leads to false positives on boats, docks etc.
    // Basically everytime you stand on a game object in water
    if (player && player->GetLiquidData().Status == LIQUID_MAP_ABOVE_WATER)
        return;

    ObjectGuid key = player->GetGUID();

    // We don't need to check for a ignore z if the player hasn't moved
    // This is necessary since MovementHandler fires if you rotate the camera in place
    if (!movementInfo.pos.GetExactDist2d(&m_Players[key].GetLastMovementInfo().pos))
        return;

    // This is Black Magic. Check only for x and y difference but no z difference that is greater then or equal to z +2.5 of the ground
    if (m_Players[key].GetLastMovementInfo().pos.GetPositionZ() == movementInfo.pos.GetPositionZ()
        && player->GetPositionZ() >= player->GetFloorZ() + 2.5f)
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
        {
            uint32 latency = player->GetSession()->GetLatency();
            std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            LOG_INFO("anticheat.module", "AnticheatMgr:: Ignore Zaxis Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
        }
        if (sConfigMgr->GetOption<bool>("Anticheat.CM.IGNOREZ", true))
        {
            player->GetMotionMaster()->MoveFall();

            if (sConfigMgr->GetOption<bool>("Anticheat.CM.WriteLog", true))
            {
                std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                LOG_INFO("anticheat.module", "ANTICHEAT COUNTER MEASURE:: {} IGNORE-Z Hack Countered and has been set to fall - Flagged at: {}", player->GetName(), goXYZ);
            }
            if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTSCREEN", true))
            {
                SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] IGNORE-Z HACK COUNTER MEASURE ALERT");
            }
            if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTCHAT", true))
            {
                const char* str = "|cFFFFFC00 IGNORE-Z HACK COUNTER MEASURE ALERT";
                DoToAllGMs([&](Player* p)
                    {
                        ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_COUNTERMEASURE, str, player->GetName(), player->GetName());
                    });
            }
            BuildReport(player, COUNTER_MEASURES_REPORT, movementInfo);
        }
        BuildReport(player, ZAXIS_HACK_REPORT, movementInfo);
    }
}

// basic detection
void AnticheatMgr::AntiSwimHackDetection(Player* player, MovementInfo movementInfo, uint32 opcode)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.AntiSwimHack", true))
        return;

    if (player->GetAreaId())
    {
        switch (player->GetAreaId())
        {
            case 2100: //Maraudon https://github.com/azerothcore/azerothcore-wotlk/issues/2437
                return;
        }
    }

    if (player->GetLiquidData().Status == (LIQUID_MAP_ABOVE_WATER | LIQUID_MAP_WATER_WALK | LIQUID_MAP_IN_WATER))
    {
        return;
    }

    if (opcode == MSG_MOVE_JUMP)
        return;

    if (movementInfo.HasMovementFlag(MOVEMENTFLAG_FALLING | MOVEMENTFLAG_SWIMMING))
        return;

    if (player->GetLiquidData().Status == LIQUID_MAP_UNDER_WATER && !movementInfo.HasMovementFlag(MOVEMENTFLAG_SWIMMING))
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
        {
            uint32 latency = player->GetSession()->GetLatency();
            std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            LOG_INFO("anticheat.module", "AnticheatMgr:: Anti-Swim-Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
        }
        BuildReport(player, ANTISWIM_HACK_REPORT, movementInfo);
    }
}

// basic detection
void AnticheatMgr::AntiKnockBackHackDetection(Player* player, MovementInfo movementInfo)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.AntiKnockBack", true))
        return;

    //if a knockback helper is not passed then we ignore
    //if player has root state we ignore, knock back does not break root
    if (!player->CanKnockback() || player->HasUnitState(UNIT_STATE_ROOT))
        return;

    ObjectGuid key = player->GetGUID();

    if (movementInfo.pos == m_Players[key].GetLastMovementInfo().pos)
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
        {
            uint32 latency = player->GetSession()->GetLatency();
            std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
            LOG_INFO("anticheat.module", "AnticheatMgr:: Anti-Knock Back - Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
        }
        BuildReport(player, ANTIKNOCK_BACK_HACK_REPORT, movementInfo);
    }
    else if (player->CanKnockback())
        player->SetCanKnockback(false);
}

// basic detection
void AnticheatMgr::NoFallDamageDetection(Player* player, MovementInfo movementInfo)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.NoFallDamage", true))
        return;

    // ghost can not get damaged
    if (player->HasAuraType(SPELL_AURA_GHOST))
        return;

    // players with water walk aura jumping on to the water from ledge would not get damage and neither will safe fall and feather fall
    if (((player->HasAuraType(SPELL_AURA_WATER_WALK) && player->GetLiquidData().Status == LIQUID_MAP_WATER_WALK && !player->IsFlying())) ||
        player->HasAuraType(SPELL_AURA_FEATHER_FALL) || player->HasAuraType(SPELL_AURA_SAFE_FALL))
    {
        return;
    }

    ObjectGuid key = player->GetGUID();

    float lastZ = m_Players[key].GetLastMovementInfo().pos.GetPositionZ();
    float newZ = movementInfo.pos.GetPositionZ();
    float zDiff = fabs(lastZ - newZ);
    int32 safe_fall = player->GetTotalAuraModifier(SPELL_AURA_SAFE_FALL);
    float damageperc = 0.018f * (zDiff - safe_fall) - 0.2426f;
    uint32 damage = (uint32)(damageperc * player->GetMaxHealth() * sWorld->getRate(RATE_DAMAGE_FALL));

    // in the Player::Handlefall 14.57f is used to calculated the damageperc formula below to 0 for fall damamge

    if (movementInfo.pos.GetPositionZ() < m_Players[key].GetLastMovementInfo().pos.GetPositionZ() && zDiff > 14.57f)
    {
        if (movementInfo.HasMovementFlag(MOVEMENTFLAG_FALLING) || m_Players[key].GetLastMovementInfo().HasMovementFlag(MOVEMENTFLAG_FALLING))
        {
            if (damage == 0 && !player->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_NORMAL))
            {
                if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
                {
                    uint32 latency = player->GetSession()->GetLatency();
                    std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                    LOG_INFO("anticheat.module", "AnticheatMgr:: No Fall Damage - Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
                }
                BuildReport(player, NO_FALL_DAMAGE_HACK_REPORT, movementInfo);
            }
        }
    }
}

void AnticheatMgr::BGreport(Player* player, MovementInfo movementInfo)
{
    ObjectGuid key = player->GetGUID();
    uint32 counter = m_Players[key].GetTypeReports(TELEPORT_HACK_REPORT);
    uint32 alertFrequency = GetAlertFrequencyConfigFromReportType(TELEPORT_HACK_REPORT);
    if (counter % alertFrequency == 0)
    {
        SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] Player Outside of Starting SPOT before BG has started!");

        // need better way to limit chat spam
        if (counter >= GetMinimumReportInChatThresholdConfigFromReportType(TELEPORT_HACK_REPORT) && counter <= GetMaximumReportInChatThresholdConfigFromReportType(TELEPORT_HACK_REPORT))
        {
            uint32 latency = player->GetSession()->GetLatency();
            DoToAllGMs([&](Player* p)
                {
                    ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_BG_EXPLOIT, player->GetName(), player->GetName(), latency);
                });
        }
    }

    if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
    {
        uint32 latency = player->GetSession()->GetLatency();
        std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
        LOG_INFO("anticheat.module", "AnticheatMgr:: BG Start Spot Exploit-Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
    }

    BuildReport(player, TELEPORT_HACK_REPORT, movementInfo);    // Synful-Syn: This needs a different report type.
}

Position const* AnticheatMgr::GetTeamStartPosition(TeamId teamId) const
{
    return &_startPosition[teamId];
}

void AnticheatMgr::CheckStartPositions(Player* player, MovementInfo movementInfo)
{
    if (sConfigMgr->GetOption<bool>("Anticheat.BG.StartAreaTeleport", true))
    {
        Position pos = player->GetPosition();
        Position const* startPos = GetTeamStartPosition(player->GetBgTeamId());

        if (pos.GetExactDistSq(!startPos))
        {
            if (sConfigMgr->GetOption<bool>("Anticheat.CM.WriteLog", true))
            {
                std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                LOG_INFO("anticheat.module", "ANTICHEAT COUNTER MEASURE:: Sending {} back to start location (BG Map: {}) (possible exploit) - Flagged at: {}", player->GetName(), player->GetMapId(), goXYZ);
            }
            if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTSCREEN", true))
            {
                SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] BG START SPOT COUNTER MEASURE ALERT");
            }
            if (sConfigMgr->GetOption<bool>("Anticheat.CM.ALERTCHAT", true))
            {
                const char* str = "|cFFFFFC00 BG START SPOT COUNTER MEASURE ALERT";
                DoToAllGMs([&](Player* p)
                    {
                        ChatHandler(p->GetSession()).PSendModuleSysMessage(modulestring, LANG_ANTICHEAT_COUNTERMEASURE, str, player->GetName(), player->GetName());
                    });
            }
            BuildReport(player, COUNTER_MEASURES_REPORT, movementInfo);
            player->TeleportTo(player->GetMapId(), startPos->GetPositionX(), startPos->GetPositionY(), startPos->GetPositionZ(), startPos->GetOrientation());
        }
    }
}

void AnticheatMgr::BGStartExploit(Player* player, MovementInfo movementInfo)
{
    if (!sConfigMgr->GetOption<bool>("Anticheat.DetectBGStartHack", true))
        return;

    ObjectGuid key = player->GetGUID();

    switch (player->GetMapId())
    {
        case 30: // Alterac Valley
        {
            if (Battleground* bg = player->GetBattleground())
            {
                if (bg->GetStatus() == STATUS_WAIT_JOIN)
                {
                    // Outside of starting area before BG has started.
                    if ((player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionX() < 770.0f) ||
                        (player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionX() > 940.31f) ||
                        (player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionY() < -525.0f))
                    {
                        sAnticheatMgr->BGreport(player, movementInfo);
                        sAnticheatMgr->CheckStartPositions(player, movementInfo);
                    }
                    if ((player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionY() > -535.0f) ||
                        (player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionX() > -1283.33f) ||
                        (player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionY() < -716.0f))
                    {
                        sAnticheatMgr->BGreport(player, movementInfo);
                        sAnticheatMgr->CheckStartPositions(player, movementInfo);
                    }
                }
            }
            break;
        }
        case 489: // Warsong Gulch
        {
            // Only way to get this high is with engineering items malfunction.
            if (!(movementInfo.HasMovementFlag(MOVEMENTFLAG_FALLING_FAR) || m_Players[key].GetLastOpcode() == MSG_MOVE_JUMP) && movementInfo.pos.GetPositionZ() > 380.0f)
            {
                sAnticheatMgr->BGreport(player, movementInfo);
                sAnticheatMgr->CheckStartPositions(player, movementInfo);
            }
            if (Battleground* bg = player->GetBattleground())
            {
                if (bg->GetStatus() == STATUS_WAIT_JOIN)
                {
                    // Outside of starting area before BG has started.
                    if ((player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionX() < 1490.0f) ||
                        (player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionY() > 1500.0f) ||
                        (player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionY() < 1450.0f))
                    {
                        sAnticheatMgr->BGreport(player, movementInfo);
                        sAnticheatMgr->CheckStartPositions(player, movementInfo);
                    }
                    if ((player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionX() > 957.0f) ||
                        (player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionY() < 1416.0f) ||
                        (player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionY() > 1466.0f))
                    {
                        sAnticheatMgr->BGreport(player, movementInfo);
                        sAnticheatMgr->CheckStartPositions(player, movementInfo);
                    }
                }
            }
            break;
        }
        case 529: // Arathi Basin
        {
            if (Battleground* bg = player->GetBattleground())
            {
                if (bg->GetStatus() == STATUS_WAIT_JOIN)
                {
                    // Outside of starting area before BG has started.
                    if ((player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionX() < 1270.0f) ||
                        (player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionY() < 1258.0f) ||
                        (player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionY() > 1361.0f))
                    {
                        sAnticheatMgr->BGreport(player, movementInfo);
                        sAnticheatMgr->CheckStartPositions(player, movementInfo);
                    }
                    if ((player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionX() > 730.0f) ||
                        (player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionY() > 724.8f))
                    {
                        sAnticheatMgr->BGreport(player, movementInfo);
                        sAnticheatMgr->CheckStartPositions(player, movementInfo);
                    }
                }
            }
            break;
        }
        case 566: // Eye of the Storm
        {
            if (Battleground* bg = player->GetBattleground())
            {
                if (bg->GetStatus() == STATUS_WAIT_JOIN)
                {
                    // Outside of starting area before BG has started.
                    if ((player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionX() < 2512.0f) ||
                        (player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionY() > 1610.0f) ||
                        (player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionY() < 1584.0f))
                    {
                        sAnticheatMgr->BGreport(player, movementInfo);
                        sAnticheatMgr->CheckStartPositions(player, movementInfo);
                    }
                    if ((player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionX() > 1816.0f) ||
                        (player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionY() > 1554.0f) ||
                        (player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionY() < 1526.0f))
                    {
                        sAnticheatMgr->BGreport(player, movementInfo);
                        sAnticheatMgr->CheckStartPositions(player, movementInfo);
                    }
                }
            }
            break;
        }
        case 628: // Island Of Conquest
        {
            if (Battleground* bg = player->GetBattleground())
            {
                if (bg->GetStatus() == STATUS_WAIT_JOIN)
                {
                    // Outside of starting area before BG has started.
                    if ((player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionX() > 412.0f) ||
                        (player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionY() < -911.0f) ||
                        (player->GetTeamId() == TEAM_ALLIANCE && movementInfo.pos.GetPositionY() > -760.0f))
                    {
                        sAnticheatMgr->BGreport(player, movementInfo);
                        sAnticheatMgr->CheckStartPositions(player, movementInfo);
                    }
                    if ((player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionX() < 1147.8f) ||
                        (player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionY() < -855.0f) ||
                        (player->GetTeamId() == TEAM_HORDE && movementInfo.pos.GetPositionY() > -676.0f))
                    {
                        sAnticheatMgr->BGreport(player, movementInfo);
                        sAnticheatMgr->CheckStartPositions(player, movementInfo);
                    }
                }
            }
            break;
        }
        return;
    }
}

void AnticheatMgr::HandlePlayerLogin(Player* player)
{
    // we must delete this to prevent errors in case of crash
    CharacterDatabase.Execute("DELETE FROM `players_reports_status` WHERE `guid` = {}", player->GetGUID().GetCounter());
    // we initialize the pos of lastMovementPosition var.
    m_Players[player->GetGUID()].SetPosition(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetOrientation(), player->GetMapId());

    if (CharacterDatabase.Query("SELECT 0 FROM `daily_players_reports` WHERE `guid` = {};", player->GetGUID().GetCounter()))
        m_Players[player->GetGUID()].SetDailyReportState(true);
}

void AnticheatMgr::HandlePlayerLogout(Player* player)
{
    // TO-DO Make a table that stores the cheaters of the day, with more detailed information.

    // We must also delete it at logout to prevent have data of offline players in the db when we query the database (IE: The GM Command)
    CharacterDatabase.Execute("DELETE FROM `players_reports_status` WHERE `guid` = {}", player->GetGUID().GetCounter());
    // Delete not needed data from the memory.
    m_Players.erase(player->GetGUID());
}

void AnticheatMgr::AckUpdate(Player* player, uint32 diff)
{
    if (_updateCheckTimer <= diff)
    {
        DoActions(player);
        _updateCheckTimer = 4000;
    }
    else
    {
        _updateCheckTimer -= diff;
    }
}

void AnticheatMgr::DoActions(Player* player)
{
    auto const now = getMSTime();

    for (auto& order : _opackorders)
    {
        if (order.counter > 0 && order.lastRcvd < order.lastSent && (now - order.lastSent) > ALLOWED_ACK_LAG)
        {
            if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
            {
                uint32 latency = player->GetSession()->GetLatency();
                std::string goXYZ = ".go xyz " + std::to_string(player->GetPositionX()) + " " + std::to_string(player->GetPositionY()) + " " + std::to_string(player->GetPositionZ() + 1.0f) + " " + std::to_string(player->GetMap()->GetId()) + " " + std::to_string(player->GetOrientation());
                LOG_INFO("anticheat.module", "Opcode Manipulation Hack detected player {} ({}) - Latency: {} ms - IP: {} - Cheat Flagged At: {}", player->GetName(), player->GetGUID().ToString(), latency, player->GetSession()->GetRemoteAddress().c_str(), goXYZ);
                order.counter = 0;
            }
            BuildReport(player, OP_ACK_HACK_REPORT, std::nullopt);
        }
    }
}

void AnticheatMgr::OrderSent(WorldPacket const* data)
{
    for (auto& order : _opackorders)
    {
        if (order.serverOpcode1 == data->GetOpcode() || order.serverOpcode2 == data->GetOpcode())
        {
            order.lastSent = getMSTime();
            ++order.counter;
            break;
        }
    }
}

void AnticheatMgr::CheckForOrderAck(uint32 opcode)
{
    for (auto& order : _opackorders)
    {
        if (order.clientResp == opcode)
        {
            --order.counter;
            break;
        }
    }
}

void AnticheatMgr::SavePlayerData(Player* player)
{
    AnticheatData playerData = m_Players[player->GetGUID()];
    //                                                               1       2         3            4           5            6                 7                     8             9               10              11                   12           13              14               15                     16                     17                 18                        19
    CharacterDatabase.Execute("REPLACE INTO players_reports_status (guid,average,total_reports,speed_reports,fly_reports,jump_reports,waterwalk_reports,teleportplane_reports,climb_reports,teleport_reports,ignorecontrol_reports,zaxis_reports,antiswim_reports,gravity_reports,antiknockback_reports,no_fall_damage_reports,op_ack_hack_reports,counter_measures_reports, creation_time) VALUES ({},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{});", player->GetGUID().GetCounter(), playerData.GetAverage(), playerData.GetTotalReports(), playerData.GetTypeReports(SPEED_HACK_REPORT), playerData.GetTypeReports(FLY_HACK_REPORT), playerData.GetTypeReports(JUMP_HACK_REPORT), playerData.GetTypeReports(WALK_WATER_HACK_REPORT), playerData.GetTypeReports(TELEPORT_PLANE_HACK_REPORT), playerData.GetTypeReports(CLIMB_HACK_REPORT), playerData.GetTypeReports(TELEPORT_HACK_REPORT), playerData.GetTypeReports(IGNORE_CONTROL_REPORT), playerData.GetTypeReports(ZAXIS_HACK_REPORT), playerData.GetTypeReports(ANTISWIM_HACK_REPORT), playerData.GetTypeReports(GRAVITY_HACK_REPORT), playerData.GetTypeReports(ANTIKNOCK_BACK_HACK_REPORT), playerData.GetTypeReports(NO_FALL_DAMAGE_HACK_REPORT), playerData.GetTypeReports(OP_ACK_HACK_REPORT), playerData.GetTypeReports(COUNTER_MEASURES_REPORT), playerData.GetCreationTime());
}

void AnticheatMgr::SavePlayerDataDaily(Player* player)
{
    AnticheatData playerData = m_Players[player->GetGUID()];
    //                                                               1       2         3            4           5            6                 7                     8             9               10              11                   12           13              14               15                     16                     17                 18                        19
    CharacterDatabase.Execute("REPLACE INTO players_reports_status (guid,average,total_reports,speed_reports,fly_reports,jump_reports,waterwalk_reports,teleportplane_reports,climb_reports,teleport_reports,ignorecontrol_reports,zaxis_reports,antiswim_reports,gravity_reports,antiknockback_reports,no_fall_damage_reports,op_ack_hack_reports,counter_measures_reports, creation_time) VALUES ({},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{});", player->GetGUID().GetCounter(), playerData.GetAverage(), playerData.GetTotalReports(), playerData.GetTypeReports(SPEED_HACK_REPORT), playerData.GetTypeReports(FLY_HACK_REPORT), playerData.GetTypeReports(JUMP_HACK_REPORT), playerData.GetTypeReports(WALK_WATER_HACK_REPORT), playerData.GetTypeReports(TELEPORT_PLANE_HACK_REPORT), playerData.GetTypeReports(CLIMB_HACK_REPORT), playerData.GetTypeReports(TELEPORT_HACK_REPORT), playerData.GetTypeReports(IGNORE_CONTROL_REPORT), playerData.GetTypeReports(ZAXIS_HACK_REPORT), playerData.GetTypeReports(ANTISWIM_HACK_REPORT), playerData.GetTypeReports(GRAVITY_HACK_REPORT), playerData.GetTypeReports(ANTIKNOCK_BACK_HACK_REPORT), playerData.GetTypeReports(NO_FALL_DAMAGE_HACK_REPORT), playerData.GetTypeReports(OP_ACK_HACK_REPORT), playerData.GetTypeReports(COUNTER_MEASURES_REPORT), playerData.GetCreationTime());
}
uint32 AnticheatMgr::GetTotalReports(ObjectGuid guid)
{
    return m_Players[guid].GetTotalReports();
}

float AnticheatMgr::GetAverage(ObjectGuid guid)
{
    return m_Players[guid].GetAverage();
}

uint32 AnticheatMgr::GetTypeReports(ObjectGuid guid, ReportTypes type)
{
    return m_Players[guid].GetTypeReports(type);
}

bool AnticheatMgr::MustCheckTempReports(ReportTypes type)
{
    //Return false if type is any of them.
    return type != JUMP_HACK_REPORT
        && type != TELEPORT_HACK_REPORT
        && type != IGNORE_CONTROL_REPORT
        && type != GRAVITY_HACK_REPORT
        && type != ANTIKNOCK_BACK_HACK_REPORT
        && type != NO_FALL_DAMAGE_HACK_REPORT
        && type != OP_ACK_HACK_REPORT
        && type != COUNTER_MEASURES_REPORT;
}

void AnticheatMgr::BuildReport(Player* player, ReportTypes reportType, Optional<MovementInfo> optMovementInfo)
{
    OnReport(player, reportType);
    ObjectGuid key = player->GetGUID();

    if (MustCheckTempReports(reportType))
    {
        uint32 actualTime = getMSTime();

        if (!m_Players[key].GetTempReportsTimer(reportType))
            m_Players[key].SetTempReportsTimer(actualTime, reportType);

        if (getMSTimeDiff(m_Players[key].GetTempReportsTimer(reportType), actualTime) < 3000)
        {
            m_Players[key].SetTempReports(m_Players[key].GetTempReports(reportType) + 1, reportType);

            if (m_Players[key].GetTempReports(reportType) < 3)
                return;
        }
        else
        {
            m_Players[key].SetTempReportsTimer(actualTime, reportType);
            m_Players[key].SetTempReports(1, reportType);
            return;
        }
    }

    // generating creationTime for average calculation
    if (!m_Players[key].GetTotalReports())
        m_Players[key].SetCreationTime(getMSTime());

    // increasing total_reports
    m_Players[key].SetTotalReports(m_Players[key].GetTotalReports() + 1);
    // increasing specific cheat report
    m_Players[key].SetTypeReports(reportType, m_Players[key].GetTypeReports(reportType) + 1);

    // diff time for average calculation
    uint32 diffTime = getMSTimeDiff(m_Players[key].GetCreationTime(), getMSTime()) / IN_MILLISECONDS;

    if (diffTime > 0)
    {
        // Average == Reports per second
        float average = float(m_Players[key].GetTotalReports()) / float(diffTime);
        m_Players[key].SetAverage(average);
    }

    if (sConfigMgr->GetOption<uint32>("Anticheat.MaxReportsForDailyReport", 70) < m_Players[key].GetTotalReports())
    {
        if (!m_Players[key].GetDailyReportState())
        {
            AnticheatData playerData = m_Players[player->GetGUID()];
            //                                                               1       2         3            4           5            6                 7                     8             9               10              11                   12           13              14               15                     16                     17                 18                        19
            CharacterDatabase.Execute("REPLACE INTO players_reports_status (guid,average,total_reports,speed_reports,fly_reports,jump_reports,waterwalk_reports,teleportplane_reports,climb_reports,teleport_reports,ignorecontrol_reports,zaxis_reports,antiswim_reports,gravity_reports,antiknockback_reports,no_fall_damage_reports,op_ack_hack_reports,counter_measures_reports, creation_time) VALUES ({},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{});", player->GetGUID().GetCounter(), playerData.GetAverage(), playerData.GetTotalReports(), playerData.GetTypeReports(SPEED_HACK_REPORT), playerData.GetTypeReports(FLY_HACK_REPORT), playerData.GetTypeReports(JUMP_HACK_REPORT), playerData.GetTypeReports(WALK_WATER_HACK_REPORT), playerData.GetTypeReports(TELEPORT_PLANE_HACK_REPORT), playerData.GetTypeReports(CLIMB_HACK_REPORT), playerData.GetTypeReports(TELEPORT_HACK_REPORT), playerData.GetTypeReports(IGNORE_CONTROL_REPORT), playerData.GetTypeReports(ZAXIS_HACK_REPORT), playerData.GetTypeReports(ANTISWIM_HACK_REPORT), playerData.GetTypeReports(GRAVITY_HACK_REPORT), playerData.GetTypeReports(ANTIKNOCK_BACK_HACK_REPORT), playerData.GetTypeReports(NO_FALL_DAMAGE_HACK_REPORT), playerData.GetTypeReports(OP_ACK_HACK_REPORT), playerData.GetTypeReports(COUNTER_MEASURES_REPORT), playerData.GetCreationTime());
            m_Players[key].SetDailyReportState(true);
        }
    }

    BuildAndSendReportToIngameGameMasters(player, reportType, optMovementInfo);

    if (sConfigMgr->GetOption<bool>("Anticheat.KickPlayer", true) && m_Players[key].GetTotalReports() > sConfigMgr->GetOption<uint32>("Anticheat.ReportsForKick", 70))
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
        {
            LOG_INFO("anticheat.module", "AnticheatMgr:: Reports reached assigned threshhold and counteracted by kicking player {} ({})", player->GetName(), player->GetGUID().ToString());
        }

        SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] Auto Kicked for Reaching Cheat Threshhold!");

        player->GetSession()->KickPlayer(true);
        if (sConfigMgr->GetOption<bool>("Anticheat.AnnounceKick", true))
        {
            std::string plr = player->GetName();
            std::string tag_colour = "7bbef7";
            std::string plr_colour = "ff0000";
            std::ostringstream stream;
            stream << "|CFF" << plr_colour << "[AntiCheat]|r|CFF" << tag_colour <<
                " Player |r|cff" << plr_colour << plr << "|r|cff" << tag_colour <<
                " has been kicked by the Anticheat Module.|r";
            sWorldSessionMgr->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
        }
    }

    if (sConfigMgr->GetOption<bool>("Anticheat.BanPlayer", true) && m_Players[key].GetTotalReports() > sConfigMgr->GetOption<uint32>("Anticheat.ReportsForBan", 70))
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
        {
            LOG_INFO("anticheat.module", "AnticheatMgr:: Reports reached assigned threshhold and counteracted by banning player {} ({})", player->GetName(), player->GetGUID().ToString());
        }

        SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] Auto Banned Account for Reaching Cheat Threshhold!");

        std::string accountName;
        AccountMgr::GetName(player->GetSession()->GetAccountId(), accountName);
        sBan->BanAccount(accountName, "0s", "Anticheat module Auto Banned Account for Reach Cheat Threshhold", "Server");

        if (sConfigMgr->GetOption<bool>("Anticheat.AnnounceBan", true))
        {
            std::string plr = player->GetName();
            std::string tag_colour = "7bbef7";
            std::string plr_colour = "ff0000";
            std::ostringstream stream;
            stream << "|CFF" << plr_colour << "[AntiCheat]|r|CFF" << tag_colour <<
                " Player |r|cff" << plr_colour << plr << "|r|cff" << tag_colour <<
                " has been Banned by the Anticheat Module.|r";
            sWorldSessionMgr->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
        }
    }

    if (sConfigMgr->GetOption<bool>("Anticheat.JailPlayer", true) && m_Players[key].GetTotalReports() > sConfigMgr->GetOption<uint32>("Anticheat.ReportsForJail", 70))
    {
        if (sConfigMgr->GetOption<bool>("Anticheat.WriteLog", true))
        {
            LOG_INFO("anticheat.module", "AnticheatMgr:: Reports reached assigned threshhold and counteracted by jailing player {} ({})", player->GetName(), player->GetGUID().ToString());
        }

        SendMiddleScreenGMMessage("|cFF00FFFF[|cFF60FF00" + player->GetName() + "|cFF00FFFF] Auto Jailed Account for Reaching Cheat Threshhold!");

        // GM Jail Location is uncommit and used as default for the jailing. Feel free to commit it out with double forward slashes (//) and uncommit,
        // removing the double forward slashes (//) if you wish to use the other locations.
        WorldLocation loc = WorldLocation(1, 16226.5f, 16403.6f, -64.5f, 3.2f);// GM Jail Location
        //WorldLocation loc = WorldLocation(35, -98.0155, 149.8360,-40.3827, 3.2f);// Alliance Jail Stormwind Stockade Location
        //WorldLocation loc = WorldLocation(0, -11139.1845, -1742.4421, -29.7365, 3.2f);// Horde Jail The Pit of Criminals Location

        player->TeleportTo(loc);
        player->SetHomebind(loc, 876); // GM Jail Homebind location
        player->CastSpell(player, SHACKLES); // Shackle him in place to ensure no exploit happens for jail break attempt

        if (Aura* dungdesert = player->AddAura(LFG_SPELL_DUNGEON_DESERTER, player))
        {
            dungdesert->SetDuration(-1);
        }
        if (Aura* bgdesert = player->AddAura(BG_SPELL_DESERTER, player))
        {
            bgdesert->SetDuration(-1);
        }
        if (Aura* silent = player->AddAura(SILENCED, player))
        {
            silent->SetDuration(-1);
        }

        if (sConfigMgr->GetOption<bool>("Anticheat.AnnounceJail", true))
        {
            std::string plr = player->GetName();
            std::string tag_colour = "7bbef7";
            std::string plr_colour = "ff0000";
            std::ostringstream stream;
            stream << "|CFF" << plr_colour << "[AntiCheat]|r|CFF" << tag_colour <<
                " Player |r|cff" << plr_colour << plr << "|r|cff" << tag_colour <<
                " has been Jailed by the Anticheat Module.|r";
            sWorldSessionMgr->SendServerMessage(SERVER_MSG_STRING, stream.str().c_str());
        }
    }
}

void AnticheatMgr::AnticheatGlobalCommand(ChatHandler* handler)
{
    // save All Anticheat Player Data before displaying global stats
    WorldSessionMgr::SessionMap const& sessionMap = sWorldSessionMgr->GetAllSessions();
    for (WorldSessionMgr::SessionMap::const_iterator itr = sessionMap.begin(); itr != sessionMap.end(); ++itr)
    {
        if (Player* plr = itr->second->GetPlayer())
        {
            sAnticheatMgr->SavePlayerData(plr);
            sAnticheatMgr->SavePlayerDataDaily(plr);
        }
    }

    if (QueryResult resultDB = CharacterDatabase.Query("SELECT `guid`, `average`, `total_reports` FROM `players_reports_status` WHERE `total_reports` != 0 ORDER BY `total_reports` DESC LIMIT 3;"))
    {
        handler->PSendSysMessage("=============================");
        handler->PSendSysMessage("Players with the most reports:");
        do
        {
            Field* fieldsDB = resultDB->Fetch();

            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(fieldsDB[0].Get<uint32>());
            float average = fieldsDB[1].Get<float>();
            uint32 total_reports = fieldsDB[2].Get<uint32>();

            if (Player* player = ObjectAccessor::FindConnectedPlayer(guid))
                handler->PSendSysMessage("Player: {} Total Reports: {} Average: {}", player->GetName(), total_reports, average);

        } while (resultDB->NextRow());
    }
    else
    {
        // this should never happen
        handler->PSendSysMessage("No players found.");
        return;
    }
}

void AnticheatMgr::AnticheatDeleteCommand(ObjectGuid guid)
{
    if (!guid)
    {
        for (AnticheatPlayersDataMap::iterator it = m_Players.begin(); it != m_Players.end(); ++it)
        {
            (*it).second.SetTotalReports(0);
            (*it).second.SetAverage(0);
            (*it).second.SetCreationTime(0);
            for (uint8 i = 0; i < MAX_REPORT_TYPES; i++)
            {
                (*it).second.SetTempReports(0, i);
                (*it).second.SetTempReportsTimer(0, i);
                (*it).second.SetTypeReports(i, 0);
            }
        }
        CharacterDatabase.Execute("DELETE FROM `players_reports_status`;");
    }
    else
    {
        m_Players[guid].SetTotalReports(0);
        m_Players[guid].SetAverage(0);
        m_Players[guid].SetCreationTime(0);
        for (uint8 i = 0; i < MAX_REPORT_TYPES; i++)
        {
            m_Players[guid].SetTempReports(0, i);
            m_Players[guid].SetTempReportsTimer(0, i);
            m_Players[guid].SetTypeReports(i, 0);
        }
        CharacterDatabase.Execute("DELETE FROM `players_reports_status` WHERE `guid` = {};", guid.GetCounter());
    }
}

void AnticheatMgr::AnticheatPurgeCommand(ChatHandler* /*handler*/)
{
    CharacterDatabase.Execute("TRUNCATE TABLE `daily_players_reports`;");
}

void AnticheatMgr::ResetDailyReportStates()
{
    for (AnticheatPlayersDataMap::iterator it = m_Players.begin(); it != m_Players.end(); ++it)
        m_Players[(*it).first].SetDailyReportState(false);
}
