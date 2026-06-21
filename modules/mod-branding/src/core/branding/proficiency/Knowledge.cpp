#include "Knowledge.h"

namespace Branding
{
    namespace
    {
        bool HasBrandBit(BrandId brand, KnowledgeState const& state)
        {
            return ((state.unlockedMask >> static_cast<int>(brand)) & 1u) != 0u;
        }
    }

    bool CanEarnProficiency(BrandId brand, KnowledgeState const& knowledge)
    {
        return HasBrandBit(brand, knowledge);
    }

    bool CanExpressBrand(BrandId brand, KnowledgeState const& currentAccount)
    {
        return HasBrandBit(brand, currentAccount);
    }

    bool UnlockBrand(BrandId brand, KnowledgeState& knowledge)
    {
        if (brand >= BrandId::COUNT)
            return false;

        uint32_t const bit = 1u << static_cast<int>(brand);
        if ((knowledge.unlockedMask & bit) != 0u)
            return false;

        knowledge.unlockedMask |= bit;
        return true;
    }
}
