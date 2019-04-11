#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "TellLosAction.h"


using namespace BotAI;

bool TellLosAction::Execute(Event event)
{
    string param = event.getParam();

    if (param.empty() || param == "targets")
    {
        list<uint64> targets = *context->GetValue<list<uint64> >("possible targets");
        ListUnits("--- Targets ---", targets);
    }

    if (param.empty() || param == "npcs")
    {
        list<uint64> npcs = *context->GetValue<list<uint64> >("nearest npcs");
        ListUnits("--- NPCs ---", npcs);
    }

    if (param.empty() || param == "corpses")
    {
        list<uint64> corpses = *context->GetValue<list<uint64> >("nearest corpses");
        ListUnits("--- Corpses ---", corpses);
    }

    if (param.empty() || param == "gos" || param == "game objects")
    {
        list<uint64> gos = *context->GetValue<list<uint64> >("nearest game objects");
        ListGameObjects("--- Game objects ---", gos);
    }

    return true;
}

void TellLosAction::ListUnits(string title, list<uint64> units)
{
    ai->TellMaster(title);

    for (list<uint64>::iterator i = units.begin(); i != units.end(); i++)
    {
        Unit* unit = ai->GetUnit(*i);
        if (unit)
            ai->TellMaster(unit->GetName());
    }

}
void TellLosAction::ListGameObjects(string title, list<uint64> gos)
{
    ai->TellMaster(title);

    for (list<uint64>::iterator i = gos.begin(); i != gos.end(); i++)
    {
        GameObject* go = ai->GetGameObject(*i);
        if (go)
            ai->TellMaster(chat->formatGameobject(go));
    }
}
