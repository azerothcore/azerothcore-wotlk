#include "cs_anticheat.h"
#include "AnticheatScripts.h"

void AddPassiveAnticheatScripts()
{
	startAnticheatScripts();
	AddSC_anticheat_commandscript();
}