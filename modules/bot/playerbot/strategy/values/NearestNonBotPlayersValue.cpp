#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "NearestNonBotPlayersValue.h"

#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"

using namespace BotAI;
using namespace Trinity;

void NearestNonBotPlayersValue::FindUnits(list<Unit*> &targets)
{
	AnyUnitInObjectRangeCheck u_check(bot, range);
	UnitListSearcher<AnyUnitInObjectRangeCheck> searcher(bot, targets, u_check);
	bot->VisitNearbyObject(bot->GetMap()->GetVisibilityRange(), searcher);
}

bool NearestNonBotPlayersValue::AcceptUnit(Unit* unit)
{
	uint64 guid = unit->GetGUID();
    return IS_PLAYER_GUID(guid) && !((Player*)unit)->GetPlayerbotAI();
}
