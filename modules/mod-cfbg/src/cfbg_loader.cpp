/*
 * Copyright (С) since 2019 Andrei Guluaev (Winfidonarleyan/Kargatum) https://github.com/Winfidonarleyan
 * Copyright (С) since 2019+ AzerothCore <www.azerothcore.org>
 * Licence MIT https://opensource.org/MIT
 */

// From SC
void AddSC_CFBG();
void AddSC_cfbg_commandscript();
void AddSC_cfbg_bf_commandscript();

// Add all
void Addmod_cfbgScripts()
{
    AddSC_CFBG();
    AddSC_cfbg_commandscript();
    AddSC_cfbg_bf_commandscript();
}
