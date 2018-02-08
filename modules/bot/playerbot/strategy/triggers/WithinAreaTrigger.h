#pragma once
#include "../Trigger.h"
#include "../values/LastMovementValue.h"

namespace BotAI
{
    class WithinAreaTrigger : public Trigger {
    public:
        WithinAreaTrigger(PlayerbotAI* ai) : Trigger(ai, "within area trigger") {}

        virtual bool IsActive()
		{


            LastMovement& movement = context->GetValue<LastMovement&>("last movement")->Get();
            if (!movement.lastAreaTrigger)
                return false;

			AreaTrigger const* atEntry = sObjectMgr->GetAreaTrigger(movement.lastAreaTrigger);
            if(!atEntry)
                return false;

            AreaTrigger const* at = sObjectMgr->GetAreaTrigger(movement.lastAreaTrigger);
            if (!at)
                return false;

            return IsPointInAreaTriggerZone(atEntry, bot->GetMapId(), bot->GetPositionX(), bot->GetPositionY(), bot->GetPositionZ(), 0.5f);
        }

    private:
        bool IsPointInAreaTriggerZone(AreaTrigger const* atEntry, uint32 mapid, float x, float y, float z, float delta)
        {
            if (mapid != atEntry->map)
                return false;

            if (atEntry->radius > 0)
            {
                // if we have radius check it
                float dist2 = (x - atEntry->x) * (x - atEntry->x) + (y - atEntry->y) * (y - atEntry->y) + (z - atEntry->z) * (z - atEntry->z);
                if (dist2 > (atEntry->radius + delta) * (atEntry->radius + delta))
                    return false;
            }
            else
            {
                // we have only extent

                // rotate the players position instead of rotating the whole cube, that way we can make a simplified
                // is-in-cube check and we have to calculate only one point instead of 4

                // 2PI = 360, keep in mind that ingame orientation is counter-clockwise
                double rotation = 2 * M_PI - atEntry->orientation;
                double sinVal = sin(rotation);
                double cosVal = cos(rotation);

                float playerBoxDistX = x - atEntry->x;
                float playerBoxDistY = y - atEntry->y;

                float rotPlayerX = float(atEntry->x + playerBoxDistX * cosVal - playerBoxDistY * sinVal);
                float rotPlayerY = float(atEntry->y + playerBoxDistY * cosVal + playerBoxDistX * sinVal);

                // box edges are parallel to coordiante axis, so we can treat every dimension independently :D
                float dz = z - atEntry->z;
                float dx = rotPlayerX - atEntry->x;
                float dy = rotPlayerY - atEntry->y;
                if ((fabs(dx) > atEntry->length / 2 + delta) ||
                        (fabs(dy) > atEntry->length / 2 + delta) ||
                        (fabs(dz) > atEntry->length / 2 + delta))
                {
                    return false;
                }
            }

            return true;
        }
    };
}