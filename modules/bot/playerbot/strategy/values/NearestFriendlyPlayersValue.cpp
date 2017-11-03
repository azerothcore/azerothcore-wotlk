#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "NearestFriendlyPlayersValue.h"

#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"

using namespace BotAI;
using namespace Trinity;

void NearestFriendlyPlayersValue::FindUnits(list<Unit*> &targets)
{
	AnyFriendlyUnitInObjectRangeCheck u_check(bot, bot, range);
	UnitListSearcher<AnyFriendlyUnitInObjectRangeCheck> searcher(bot, targets, u_check);
	bot->VisitNearbyObject(bot->GetMap()->GetVisibilityRange(), searcher);
}

bool NearestFriendlyPlayersValue::AcceptUnit(Unit* unit)
{
	uint64 guid = unit->GetGUID();
	return IS_PLAYER_GUID(guid) && !((Player*)unit)->GetPlayerbotAI();
}
