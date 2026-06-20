#ifndef MOD_BRANDING_CORE_PROFICIENCY_KNOWLEDGE_H
#define MOD_BRANDING_CORE_PROFICIENCY_KNOWLEDGE_H

#include "Types.h"
#include "common/Brand.h"

namespace Branding
{
    // May this account EARN proficiency in this brand? (Knowledge gate, design §6.)
    bool CanEarnProficiency(BrandId brand, KnowledgeState const& knowledge);

    // Anti-P2W use-time gate (design §1, §7.5): may the CURRENT account EXPRESS this brand right
    // now? Evaluated at effect time against the current account's access, not at earn time.
    bool CanExpressBrand(BrandId brand, KnowledgeState const& currentAccount);
}

#endif // MOD_BRANDING_CORE_PROFICIENCY_KNOWLEDGE_H
