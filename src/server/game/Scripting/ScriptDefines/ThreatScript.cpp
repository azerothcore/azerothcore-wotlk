#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnAddThreat(Unit *victim, float threat)
{
    ExecuteScript<ThreatScript>([&](ThreatScript *script) {
        script->OnAddThreat(victim, threat);
    });
}

void ScriptMgr::OnRemoveHostileReferenceFromThreatContainer(HostileReference *hostileRef)
{
    ExecuteScript<ThreatScript>([&](ThreatScript *script) {
        script->OnRemoveHostileReferenceFromThreatContainer(hostileRef);
    });
}

void ScriptMgr::OnAddHostileReferenceToThreatContainer(HostileReference *hostileRef)
{
    ExecuteScript<ThreatScript>([&](ThreatScript *script) {
        script->OnAddHostileReferenceToThreatContainer(hostileRef);
    });
}
