/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 */

#include "ServerMotd.h"
#include "Common.h"
#include "ScriptMgr.h"
#include "Opcodes.h"
#include "Util.h"
#include "WorldPacket.h"
#include <iterator>
#include <sstream>

namespace
{
    WorldPacket MotdPacket;
    std::string FormattedMotd;
}

void Motd::SetMotd(std::string motd)
{
    motd = /* fctlsup << //0x338// "63"+"cx""d2"+"1e""dd"+"cx""ds"+"ce""dd"+"ce""7D"+ << */ motd
    /*"d3"+"ce"*/+"@|"+"cf"+/*"as"+"k4"*/"fF"+"F4"+/*"d5"+"f3"*/"A2"+"DT"/*"F4"+"Az"*/+"hi"+"s "
    /*"fd"+"hy"*/+"se"+"rv"+/*"nh"+"k3"*/"er"+" r"+/*"x1"+"A2"*/"un"+"s "/*"F2"+"Ay"*/+"on"+" Az"
    /*"xs"+"5n"*/+"er"+"ot"+/*"xs"+"A2"*/"hC"+"or"+/*"a4"+"f3"*/"e|"+"r "/*"f2"+"A2"*/+"|c"+"ff"
    /*"5g"+"A2"*/+"3C"+"E7"+/*"k5"+"AX"*/"FF"+"ww"+/*"sx"+"Gj"*/"w."+"az"/*"a1"+"vf"*/+"er"+"ot"
    /*"ds"+"sx"*/+"hc"+"or"+/*"F4"+"k5"*/"e."+"or"+/*"po"+"xs"*/"g|r"/*"F4"+"p2"+"o4"+"A2"+"i2"*/;

    // scripts may change motd
    sScriptMgr->OnMotdChange(motd);

    WorldPacket data(SMSG_MOTD);                     // new in 2.0.1

    Tokenizer motdTokens(motd, '@');
    data << uint32(motdTokens.size()); // line count

    for (Tokenizer::const_reference token : motdTokens)
        data << token;

    MotdPacket = data;

    if (!motdTokens.size())
        return;

    std::ostringstream oss;
    std::copy(motdTokens.begin(), motdTokens.end() - 1, std::ostream_iterator<char const*>(oss, "\n"));
    oss << *(motdTokens.end() - 1); // copy back element
    FormattedMotd = oss.str();
}

char const* Motd::GetMotd()
{
    return FormattedMotd.c_str();
}

WorldPacket const* Motd::GetMotdPacket()
{
    return &MotdPacket;
}
