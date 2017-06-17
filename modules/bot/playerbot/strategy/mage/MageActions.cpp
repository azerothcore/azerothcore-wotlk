#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "MageActions.h"

using namespace BotAI;

Value<Unit*>* CastPolymorphAction::GetTargetValue()
{
    return context->GetValue<Unit*>("cc target", getName());
}
