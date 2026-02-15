/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef TEST_AURA_H
#define TEST_AURA_H

#include "DBCStructure.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"

/**
 * TestAura - Concrete Aura subclass for testing.
 *
 * Provides a minimal Aura that skips CalcMaxDuration, script hooks, and
 * all the spell system machinery. Used only for injecting fake AuraEffects
 * into Unit::m_modAuras for testing aura-reading code paths.
 */
class TestAura : public Aura
{
public:
    TestAura(SpellInfo const* spellproto, ObjectGuid casterGUID,
             WorldObject* owner)
        : Aura(spellproto, casterGUID, owner, true /*testTag*/)
    {
    }

    // Aura is abstract — provide minimal overrides
    void Remove(AuraRemoveMode /*removeMode*/) override { }
    void FillTargetMap(std::map<Unit*, uint8>& /*targets*/,
                       Unit* /*caster*/) override { }
};

/**
 * Helper to create a complete test AuraEffect chain:
 *   SpellEntry → SpellInfo → TestAura → AuraEffect
 *
 * The caller must call DestroyTestAuraEffect() to free the chain.
 */
struct TestAuraEffectHelper
{
    SpellEntry* spellEntry = nullptr;
    SpellInfo* spellInfo = nullptr;
    TestAura* aura = nullptr;
    AuraEffect* effect = nullptr;

    /**
     * Create a test AuraEffect with the given aura type, misc value, and amount.
     *
     * @param auraType   The SPELL_AURA_* type (e.g. SPELL_AURA_MOD_TAUNT)
     * @param miscValue  The MiscValue for the effect (e.g. spell school mask)
     * @param amount     The effect amount (e.g. threat modifier %)
     * @param casterGUID GUID of the "caster" of the aura
     * @param owner      WorldObject that "owns" the aura (typically the target)
     * @param effIndex   Effect index (default 0)
     */
    void Create(uint32 auraType, int32 miscValue, int32 amount,
                ObjectGuid casterGUID, WorldObject* owner,
                uint8 effIndex = 0)
    {
        spellEntry = new SpellEntry{};
        spellEntry->EffectApplyAuraName[effIndex] = auraType;
        spellEntry->EffectMiscValue[effIndex] = miscValue;
        spellEntry->EffectBasePoints[effIndex] = amount;

        spellInfo = new SpellInfo(spellEntry);

        aura = new TestAura(spellInfo, casterGUID, owner);

        effect = new AuraEffect(aura, effIndex, amount, true /*testTag*/);
    }

    void Destroy()
    {
        if (effect)
            effect->TestDestroy();
        delete aura;
        delete spellInfo;
        delete spellEntry;
        effect = nullptr;
        aura = nullptr;
        spellInfo = nullptr;
        spellEntry = nullptr;
    }
};

#endif // TEST_AURA_H
