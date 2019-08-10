#include "Player.h"
#include "Language.h"

#define DEFAULT_PLAYER_BOUNDING_RADIUS      0.388999998569489f     // player size, also currently used (correctly?) for any non Unit world objects

void Player::SetUnderACKmount()
{
    m_mountTimer = 3000;
    m_ACKmounted = true;
}

void Player::SetRootACKUpd(uint32 delay)
{
    m_rootUpdTimer = 1500 + delay;
    m_rootUpd = true;
}

bool Player::CheckOnFlyHack()
{
    if (IsCanFlybyServer())
        return true;

    if (ToUnit()->IsFalling() || IsFalling())
        return true;

    if (m_mover != this)
        return true;

    if (sWorld->isMapDisabledForAC(GetMapId()))
        return true;

    if (IsFlying() && !CanFly()) // kick flyhacks
    {
        sLog->outString("Player::CheckOnFlyHack :  FlyHack Detected for Account id : %u, Player %s", GetSession()->GetAccountId(), GetName().c_str());
        sLog->outString("Player::========================================================");
        sLog->outString("Player IsFlying but CanFly is false");

        sWorld->SendGMText(LANG_GM_ANNOUNCE_AFH_CANFLYWRONG, GetName().c_str());
        return false;
    }

    if (IsFlying() || IsLevitating() || IsInFlight())
        return true;

    if (GetVehicle() || GetVehicleKit())
        return true;

    if (HasAuraType(SPELL_AURA_CONTROL_VEHICLE))
        return true;

    if (GetTransport() || HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT))
        return true;

    if (HasUnitState(UNIT_STATE_IGNORE_ANTISPEEDHACK))
        return true;

    if (UnderACKmount())
        return true;

    if (IsSkipOnePacketForASH())
        return true;

    Position npos;
    GetPosition(&npos);
    float pz = npos.GetPositionZ();
    if (!IsInWater() && HasUnitMovementFlag(MOVEMENTFLAG_SWIMMING))
    {
        float waterlevel = GetBaseMap()->GetWaterLevel(npos.GetPositionX(), npos.GetPositionY()); // water walking
        bool hovergaura = HasAuraType(SPELL_AURA_WATER_WALK) || HasAuraType(SPELL_AURA_HOVER);
        if (waterlevel && (pz - waterlevel) <= (hovergaura ? GetCollisionHeight(IsMounted()) + 2.5f : GetCollisionHeight(IsMounted()) + 1.5f))
            return true;

        sLog->outString("Player::CheckOnFlyHack :  FlyHack Detected for Account id : %u, Player %s", GetSession()->GetAccountId(), GetName().c_str());
        sLog->outString("Player::========================================================");
        sLog->outString("Player::CheckOnFlyHack :  Player has a MOVEMENTFLAG_SWIMMING, but not in water");

        sWorld->SendGMText(LANG_GM_ANNOUNCE_AFK_SWIMMING, GetName().c_str());
        return false;
    }
    else
    {
        float z = GetMap()->GetHeight(GetPhaseMask(), npos.GetPositionX(), npos.GetPositionY(), pz + GetCollisionHeight(IsMounted()) + 0.5f, true, 50.0f); // smart flyhacks -> SimpleFly
        float diff = pz - z;
        if (diff > 6.8f) // better calculate the second time for false situations, but not call GetHoverOffset everytime (economy resource)
        {
            float waterlevel = GetBaseMap()->GetWaterLevel(npos.GetPositionX(), npos.GetPositionY()); // water walking
            if (waterlevel && waterlevel + GetCollisionHeight(IsMounted()) > pz)
                return true;

            float cx, cy, cz;
            GetVoidClosePoint(cx, cy, cz, DEFAULT_PLAYER_BOUNDING_RADIUS, 2.0f, 0, 6.8f); // first check
            if (pz - cz > 6.8f)
            {
                GetMap()->getObjectHitPos(GetPhaseMask(), GetPositionX(), GetPositionY(), GetPositionZ() + GetCollisionHeight(IsMounted()), cx, cy, cz + GetCollisionHeight(IsMounted()), cx, cy, cz, -GetCollisionHeight(IsMounted()));
                if (pz - cz > 6.8f)
                {
                    sLog->outString("Player::CheckOnFlyHack :  FlyHack Detected for Account id : %u, Player %s", GetSession()->GetAccountId(), GetName().c_str());
                    sLog->outString("Player::========================================================");
                    sLog->outString("Player::CheckOnFlyHack :  playerZ = %f", pz);
                    sLog->outString("Player::CheckOnFlyHack :  normalZ = %f", z);
                    sLog->outString("Player::CheckOnFlyHack :  checkz = %f", cz);
                    sWorld->SendGMText(LANG_GM_ANNOUNCE_AFH, GetName().c_str());
                    return false;
                }
            }
        }
    }

    return true;
}

void Player::UpdateMovementInfo(MovementInfo const& movementInfo)
{
    SetLastMoveClientTimestamp(movementInfo.time);
    SetLastMoveServerTimestamp(getMSTime());
}

bool Player::CheckMovementInfo(MovementInfo const& movementInfo, bool jump)
{
    if (!sWorld->getBoolConfig(CONFIG_ANTICHEAT_SPEEDHACK_ENABLED))
        return true;

    if (sWorld->isMapDisabledForAC(GetMapId()))
        return true;

    uint32 ctime = GetLastMoveClientTimestamp();
    if (ctime)
    {
        if (ToUnit()->IsFalling() || IsInFlight())
            return true;

        if (GetVehicle() || GetVehicleKit())
            return true;

        if (HasAuraType(SPELL_AURA_CONTROL_VEHICLE))
            return true;

        bool transportflag = GetTransport() || (movementInfo.GetMovementFlags() & MOVEMENTFLAG_ONTRANSPORT) || HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT);

        if (sWorld->getBoolConfig(CONFIG_ANTICHEAT_SAFEMODE_ENABLED))
        {
            if (UnderACKmount() || transportflag)
                return true;
        }

        if (IsSkipOnePacketForASH())
        {
            SetSkipOnePacketForASH(false);
            return true;
        }

        Position npos = movementInfo.pos;
        if (sWorld->getBoolConfig(CONFIG_ANTICHEAT_IGNORE_CONTROL_MOVEMENT_ENABLED))
        {
            if (HasUnitState(UNIT_STATE_ROOT) && !UnderACKRootUpd())
            {
                bool unrestricted = npos.GetPositionX() != GetPositionX() || npos.GetPositionY() != GetPositionY();
                if (unrestricted)
                {
                    sLog->outString("CheckMovementInfo :  Ignore control Hack detected for Account id : %u, Player %s", GetSession()->GetAccountId(), GetName().c_str());
                    sWorld->SendGMText(LANG_GM_ANNOUNCE_MOVE_UNDER_CONTROL, GetSession()->GetAccountId(), GetName().c_str());
                    return false;
                }
            }
        }

        if (HasUnitState(UNIT_STATE_IGNORE_ANTISPEEDHACK))
            return true;

        float distance, movetime, speed, difftime, normaldistance, delay, delaysentrecieve, x, y;
        distance = npos.GetExactDist2d(this);

        if (!jump && !CanFly() && !isSwimming() && !transportflag)
        {
            float diffz = fabs(movementInfo.pos.GetPositionZ() - GetPositionZ());
            float tanangle = distance / diffz;

            if (movementInfo.pos.GetPositionZ() > GetPositionZ() &&
                diffz > 1.87f &&
                tanangle < 0.57735026919f) // 30 degrees
            {
                std::string mapname = GetMap()->GetMapName();
                sLog->outString("CheckMovementInfo :  Climb-Hack detected for Account id : %u, Player %s, diffZ = %f, distance = %f, angle = %f, Map = %s, mapId = %u, X = %f, Y = %f, Z = %f",
                    GetSession()->GetAccountId(), GetName().c_str(), diffz, distance, tanangle, mapname.c_str(), GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ());
                sWorld->SendGMText(LANG_GM_ANNOUNCE_WALLCLIMB, GetSession()->GetAccountId(), GetName().c_str(), diffz, distance, tanangle, mapname.c_str(), GetMapId(), GetPositionX(), GetPositionY(), GetPositionZ());
                return false;
            }
        }

        uint32 oldstime = GetLastMoveServerTimestamp();
        uint32 stime = getMSTime();
        uint32 ping, latency;
        movetime = movementInfo.time;
        latency = GetSession()->GetLatency();
        ping = std::max(uint32(60), latency);

        speed = GetSpeed(MOVE_RUN);
        if (isSwimming())
            speed = GetSpeed(MOVE_SWIM);
        if (IsFlying() || this->CanFly())
            speed = GetSpeed(MOVE_FLIGHT);

        delaysentrecieve = (ctime - oldstime) / 10000000000;
        delay = fabsf(movetime - stime) / 10000000000 + delaysentrecieve;
        difftime = (movetime - ctime + ping) * 0.001f + delay;
        normaldistance = speed * difftime; // if movetime faked and lower, difftime should be with "-"
        if (UnderACKmount())
            normaldistance *= 3.0f;

        if (distance < normaldistance)
            return true;

        GetPosition(x, y);

        sLog->outString("CheckMovementInfo :  SpeedHack Detected for Account id : %u, Player %s", GetSession()->GetAccountId(), GetName().c_str());
        sLog->outString("========================================================");
        sLog->outString("CheckMovementInfo :  oldX = %f", x);
        sLog->outString("CheckMovementInfo :  oldY = %f", y);
        sLog->outString("CheckMovementInfo :  newX = %f", npos.GetPositionX());
        sLog->outString("CheckMovementInfo :  newY = %f", npos.GetPositionY());
        sLog->outString("CheckMovementInfo :  packetdistance = %f", distance);
        sLog->outString("CheckMovementInfo :  available distance = %f", normaldistance);
        sLog->outString("CheckMovementInfo :  movetime = %f", movetime);
        sLog->outString("CheckMovementInfo :  delay sent ptk - recieve pkt (previous) = %f", delaysentrecieve);
        sLog->outString("CheckMovementInfo :  FullDelay = %f", delay);
        sLog->outString("CheckMovementInfo :  difftime = %f", difftime);
        sLog->outString("CheckMovementInfo :  latency = %u", latency);
        sLog->outString("CheckMovementInfo :  ping = %u", ping);

        sWorld->SendGMText(LANG_GM_ANNOUNCE_ASH, GetName().c_str(), normaldistance, distance);
    }
    else
        return true;

    return false;
}
