/*
 * DecrypteD wuz here! xD https://sololeveling.wtf
 */

#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnMetricLogging()
{
    ExecuteScript<MetricScript>([&](MetricScript* script)
    {
        script->OnMetricLogging();
    });
}
