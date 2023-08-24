//#include "LoadForgeSpells.cpp"
//#include "CellImpl.h"
//#include "GridNotifiers.h"
//#include "ScriptMgr.h"
//#include "SpellAuraEffects.h"
//#include "SpellMgr.h"
//#include "SpellScript.h"
//
//enum DeathKnightSpells
//{
//    SPELL_DK_PESTILENCE                         = 50842,    
//    SPELL_DK_BONE_SHIELD                        = 49222,
//    SPELL_DK_DEATH_AND_DECAY_TRIGGER            = 52212,
//    SPELL_DK_GLYPH_OF_SCOURGE_STRIKE            = 58642,
//    SPELL_DK_WANDERING_PLAGUE_TRIGGER           = 1150002,
//    SPELL_DK_GLYPH_OF_THE_GHOUL                 = 58686,
//    SPELL_SHADOWMOURNE_CHAOS_BANE_DAMAGE        = 71904,
//    SPELL_SHADOWMOURNE_SOUL_FRAGMENT            = 71905,
//    SPELL_SHADOWMOURNE_CHAOS_BANE_BUFF          = 73422,
//    SPELL_DK_ANTI_MAGIC_SHELL_TALENT            = 51052,
//    SPELL_DK_BLACK_ICE_R1                       = 49140,
//    SPELL_DK_BLOOD_BOIL_TRIGGERED               = 65658,
//    SPELL_DK_BLOOD_GORGED_HEAL                  = 50454,
//    SPELL_DK_BLOOD_PRESENCE                     = 48266,
//    SPELL_DK_CORPSE_EXPLOSION_TRIGGERED         = 43999,
//    SPELL_DK_CORPSE_EXPLOSION_VISUAL            = 51270,
//    SPELL_DK_DEATH_COIL_DAMAGE                  = 47632,
//    SPELL_DK_DEATH_COIL_HEAL                    = 47633,
//    SPELL_DK_DEATH_STRIKE_HEAL                  = 45470,
//    SPELL_DK_FROST_FEVER                        = 55095,
//    SPELL_DK_SCARLET_FEVER                      = 1150007,
//    SPELL_DK_GHOUL_EXPLODE                      = 47496,
//    SPELL_DK_GLYPH_OF_ICEBOUND_FORTITUDE        = 58625,
//    SPELL_DK_ITEM_SIGIL_VENGEFUL_HEART          = 64962,
//    SPELL_DK_ITEM_T8_MELEE_4P_BONUS             = 64736,
//    SPELL_DK_MASTER_OF_GHOULS                   = 52143,
//    SPELL_DK_MASTER_OF_UNDEATH                  = 1150006,
//    SPELL_DK_BLOOD_PLAGUE                       = 55078,
//    SPELL_DK_RAISE_DEAD_USE_REAGENT             = 48289,
//    SPELL_DK_RUNIC_POWER_ENERGIZE               = 49088,
//    SPELL_DK_SCENT_OF_BLOOD                     = 1150082,
//    SPELL_DK_WILL_OF_THE_NECROPOLIS_TALENT_R1   = 49189,
//    SPELL_DK_WILL_OF_THE_NECROPOLIS_AURA_R1     = 52284,
//    SPELL_DK_UNHOLY_EMPOWERMENT_AURA            = 63622,
//    SPELL_DK_VENGEANCE                          = 1150076,
//    SPELL_DK_VENGEANCE_TRIGGERED                = 1150077,
//    SPELL_DK_IMP_BONE_SHIELD                    = 1150084,
//    SPELL_DK_IMP_BONE_SHIELD_TRIGGERED          = 1150084,
//
//    FORGE_FESTERING_STRIKE                      = 1159900,
//    FORGE_FESTERING_STRIKE_CLONE                = 1159912,
//    FORGE_FESTERING_STRIKE_TAINTING             = 1159903,
//    FORGE_FESTERING_STRIKE_REAPERS              = 1159905,
//    FORGE_FESTERING_STRIKE_FM                   = 1159908,
//    FORGE_FESTERING_STRIKE_FI                   = 1159909,
//    FORGE_FESTERING_STRIKE_FI_CLEAVE            = 1159910,
//    FORGE_FESTERING_STRIKE_FI_ECHO              = 1159911,
//    FORGE_FESTERING_STRIKE_FI_CLEAVE_2          = 1159913,
//    FORGE_FESTERING_STRIKE_FI_ECHO_2            = 1159914,
//    FORGE_FESTERING_STRIKE_FM_CRIT              = 1159915,
//    FORGE_FESTERING_STRIKE_FM_MORE              = 1159920,
//    FORGE_FESTERING_STRIKE_FM_WOUND             = 1159922,
//    FORGE_FESTERING_STRIKE_FM_WOUND_DOT         = 1159922,
//
//    FORGE_DEATHS_CARESS                         = 1159922,
//    FORGE_DEATHS_CARESS_CLONE                   = 1159925,
//    FORGE_DEATHS_CARESS_CLEAVE                  = 1159923,
//    FORGE_DEATHS_CARESS_ECHO                    = 1159924,
//    FORGE_DEATHS_CARESS_BONE_SHIELD             = 1159932,
//    FORGE_DEATHS_CARESS_LICH                    = 1159933,
//    FORGE_DEATHS_CARESS_LICH_AURA               = 1159934,
//
//    FORGE_PLAGUE_SCYTHE                         = 1159935,
//    FORGE_PLAGUE_SCYTHE_SHIELD                  = 1159936,
//    FORGE_PLAGUE_SCYTHE_SHIELD_ACTIVE           = 1159939,
//    FORGE_PLAGUE_SCYTHE_SIPHON                  = 1159940,
//    FORGE_PLAGUE_SCYTHE_SIPHON_ACTIVE           = 1159943,
//    FORGE_PLAGUE_SCYTHE_RUNEREND                = 1159944,
//    FORGE_PLAGUE_SCYTHE_DRAW_POWER              = 1159947,
//    FORGE_PLAGUE_SCYTHE_DRAW_POWER_ACTIVE       = 1159949,
//    FORGE_PLAGUE_SCYTHE_PLAGUE_SHADOW_ACTIVE    = 1159952,
//    FORGE_PLAGUE_SCYTHE_PLAGUE_SHADOW_SCALING   = 10,
//    FORGE_PLAGUE_SCYTHE_PLAGUE_SHADOW           = 1159953
//    
//};
//
///* 51996 - Death Knight Pet Scaling 02
//   54566 - Death Knight Pet Scaling 01
//   61697 - Death Knight Pet Scaling 03 
//   1150009 - Death Knight Pet Scaling 04 */
//class spell_dk_pet_scaling : public AuraScript
//{
//    PrepareAuraScript(spell_dk_pet_scaling);
//
//    void CalculateStatAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
//    {
//        Stats stat = Stats(aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].MiscValue);
//
//
//        if (Unit* owner = GetUnitOwner()->GetOwner())
//        {
//            int32 modifier = 100;
//
//            // Check just if owner has Ravenous Dead since it's effect is not an aura
//            if (AuraEffect const* rdEff = owner->GetAuraEffect(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, SPELLFAMILY_DEATHKNIGHT, 3010, 0))
//            {
//                SpellInfo const* spellInfo = rdEff->GetSpellInfo();                                                 // Then get the SpellProto and add the dummy effect value
//                AddPct(modifier, spellInfo->Effects[EFFECT_1].CalcValue());                                          // Ravenous Dead edits the original scale
//            }
//
//            // xinef: Glyph of the Ghoul
//            if (AuraEffect const* glyphEff = owner->GetAuraEffect(SPELL_DK_GLYPH_OF_THE_GHOUL, EFFECT_0))
//                modifier += glyphEff->GetAmount();
//
//            amount = CalculatePct(std::max<int32>(0, owner->GetStat(stat)), modifier);
//        }
//    }
//
//    void CalculateSPAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
//    {
//        // xinef: dk gargoyle inherits 33% of SP
//        if (GetUnitOwner()->GetEntry() != NPC_EBON_GARGOYLE)
//            return;
//
//        if (Unit* owner = GetUnitOwner()->GetOwner())
//        {
//            int32 modifier = 33;
//
//            // xinef: impurity
//            if (owner->GetDummyAuraEffect(SPELLFAMILY_DEATHKNIGHT, 1986, 0))
//                modifier = 40;
//
//            amount = CalculatePct(std::max<int32>(0, owner->GetTotalAttackPowerValue(BASE_ATTACK)), modifier);
//
//            // xinef: Update appropriate player field
//            if (owner->GetTypeId() == TYPEID_PLAYER)
//                owner->SetUInt32Value(PLAYER_PET_SPELL_POWER, (uint32)amount);
//        }
//    }
//
//    void CalculateHasteAmount(AuraEffect const*  /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
//    {
//        // xinef: scale haste with owners melee haste
//        if (Unit* owner = GetUnitOwner()->GetOwner())
//            if (owner->m_modAttackSpeedPct[BASE_ATTACK] < 1.0f) // inherit haste only
//                amount = std::min<int32>(100, int32(((1.0f / owner->m_modAttackSpeedPct[BASE_ATTACK]) - 1.0f) * 100.0f));
//    }
//
//    void HandleEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
//    {
//        if (aurEff->GetAuraType() != SPELL_AURA_MELEE_SLOW)
//            return;
//
//        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_CASTING_SPEED_NOT_STACK, true, SPELL_BLOCK_TYPE_POSITIVE);
//        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_MELEE_RANGED_HASTE, true, SPELL_BLOCK_TYPE_POSITIVE);
//        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MELEE_SLOW, true, SPELL_BLOCK_TYPE_POSITIVE);
//
//        if (GetUnitOwner()->IsPet())
//            return;
//
//        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_STAT, true, SPELL_BLOCK_TYPE_POSITIVE);
//        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, true, SPELL_BLOCK_TYPE_POSITIVE);
//        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true, SPELL_BLOCK_TYPE_POSITIVE);
//        GetUnitOwner()->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER_PCT, true, SPELL_BLOCK_TYPE_POSITIVE);
//    }
//
//    void CalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
//    {
//        if (!GetUnitOwner()->IsPet())
//            return;
//
//        isPeriodic = true;
//        amplitude = 2 * IN_MILLISECONDS;
//    }
//
//    void HandlePeriodic(AuraEffect const* aurEff)
//    {
//        PreventDefaultAction();
//        if (aurEff->GetAuraType() == SPELL_AURA_MOD_STAT && (aurEff->GetMiscValue() == STAT_STAMINA || aurEff->GetMiscValue() == STAT_INTELLECT))
//        {
//            int32 currentAmount = aurEff->GetAmount();
//            int32 newAmount = GetEffect(aurEff->GetEffIndex())->CalculateAmount(GetCaster());
//            if (newAmount != currentAmount)
//            {
//                if (aurEff->GetMiscValue() == STAT_STAMINA)
//                {
//                    uint32 actStat = GetUnitOwner()->GetHealth();
//                    GetEffect(aurEff->GetEffIndex())->ChangeAmount(newAmount, false);
//                    GetUnitOwner()->SetHealth(std::min<uint32>(GetUnitOwner()->GetMaxHealth(), actStat));
//                }
//                else
//                {
//                    uint32 actStat = GetUnitOwner()->GetPower(POWER_MANA);
//                    GetEffect(aurEff->GetEffIndex())->ChangeAmount(newAmount, false);
//                    GetUnitOwner()->SetPower(POWER_MANA, std::min<uint32>(GetUnitOwner()->GetMaxPower(POWER_MANA), actStat));
//                }
//            }
//        }
//        else
//            GetEffect(aurEff->GetEffIndex())->RecalculateAmount();
//    }
//
//    void Register() override
//    {
//        if (m_scriptSpellId == 54566)
//        {
//            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling::CalculateStatAmount, EFFECT_ALL, SPELL_AURA_MOD_STAT);
//            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling::CalculateSPAmount, EFFECT_ALL, SPELL_AURA_MOD_DAMAGE_DONE);
//        }
//
//        if (m_scriptSpellId == 51996)
//            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_dk_pet_scaling::CalculateHasteAmount, EFFECT_ALL, SPELL_AURA_MELEE_SLOW);
//
//        OnEffectApply += AuraEffectApplyFn(spell_dk_pet_scaling::HandleEffectApply, EFFECT_ALL, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
//        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_dk_pet_scaling::CalcPeriodic, EFFECT_ALL, SPELL_AURA_ANY);
//        OnEffectPeriodic += AuraEffectPeriodicFn(spell_dk_pet_scaling::HandlePeriodic, EFFECT_ALL, SPELL_AURA_ANY);
//    }
//};
//
//// 52143 - Master of Ghouls
//class spell_dk_master_of_ghouls : public AuraScript
//{
//    PrepareAuraScript(spell_dk_master_of_ghouls);
//
//    void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
//    {
//        Unit* target = GetTarget();
//        if (target->GetTypeId() == TYPEID_PLAYER)
//            target->ToPlayer()->SetShowDKPet(true);
//    }
//
//    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
//    {
//        Unit* target = GetTarget();
//        if (target->GetTypeId() == TYPEID_PLAYER)
//            target->ToPlayer()->SetShowDKPet(false);
//    }
//
//    void Register() override
//    {
//        OnEffectApply += AuraEffectApplyFn(spell_dk_master_of_ghouls::HandleEffectApply, EFFECT_0, SPELL_AURA_ADD_FLAT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
//        OnEffectRemove += AuraEffectRemoveFn(spell_dk_master_of_ghouls::HandleEffectRemove, EFFECT_0, SPELL_AURA_ADD_FLAT_MODIFIER, AURA_EFFECT_HANDLE_REAL);
//    }
//};
//
//class RaiseDeadCheck
//{
//public:
//    explicit RaiseDeadCheck(Player const* caster) : _caster(caster) { }
//
//    bool operator()(WorldObject* obj) const
//    {
//        if (Unit* target = obj->ToUnit())
//        {
//            if (!target->IsAlive()
//                    && _caster->isHonorOrXPTarget(target)
//                    && target->GetCreatureType() == CREATURE_TYPE_HUMANOID
//                    && target->GetDisplayId() == target->GetNativeDisplayId())
//                return false;
//        }
//
//        return true;
//    }
//
//private:
//    Player const* _caster;
//};
//
//// 46584 - Raise Dead
//class spell_dk_raise_dead : public SpellScript
//{
//    PrepareSpellScript(spell_dk_raise_dead);
//
//    bool Validate(SpellInfo const* /*spellInfo*/) override
//    {
//        return ValidateSpellInfo(
//            {
//                SPELL_DK_MASTER_OF_GHOULS,
//                SPELL_DK_MASTER_OF_UNDEATH
//            });
//    }
//
//    bool Load() override
//    {
//        _result = SPELL_CAST_OK;
//        _corpse = false;
//        return GetCaster()->GetTypeId() == TYPEID_PLAYER;
//    }
//
//    SpellCastResult CheckCast()
//    {
//        /// process spell target selection before cast starts
//        /// targets of effect_1 are used to check cast
//        GetSpell()->SelectSpellTargets();
//        /// cleanup spell target map, and fill it again on normal way
//        GetSpell()->CleanupTargetList();
//        /// _result is set in spell target selection
//        return _result;
//    }
//
//    SpellCastResult CheckReagents()
//    {
//        return SPELL_CAST_OK;
//    }
//
//    void CheckTargets(std::list<WorldObject*>& targets)
//    {
//        targets.remove_if(RaiseDeadCheck(GetCaster()->ToPlayer()));
//
//        if (targets.empty())
//        {
//            if (GetSpell()->getState() == SPELL_STATE_PREPARING)
//                _result = CheckReagents();
//            return;
//        }
//
//        WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
//        targets.clear();
//        targets.push_back(target);
//        _corpse = true;
//    }
//
//    void CheckTarget(WorldObject*& target)
//    {
//        // Don't add caster to target map, if we found a corpse to raise dead
//        if (_corpse)
//            target = nullptr;
//    }
//
//    uint32 GetGhoulSpellId()
//    {
//        // Master of Ghouls
//        if (GetCaster()->HasAura(SPELL_DK_MASTER_OF_GHOULS)){
//            // Master of Undeath
//            if(GetCaster()->ToPlayer()->HasTalent(SPELL_DK_MASTER_OF_UNDEATH, GetCaster()->ToPlayer()->GetActiveSpec())) {
//                return GetSpellInfo()->Effects[EFFECT_0].CalcValue();
//            }
//            return GetSpellInfo()->Effects[EFFECT_2].CalcValue();
//        }
//        // or guardian
//        return GetSpellInfo()->Effects[EFFECT_1].CalcValue();
//
//    }
//
//    void HandleRaiseDead(SpellEffIndex /*effIndex*/)
//    {
//        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(GetGhoulSpellId());
//        SpellCastTargets targets;
//        targets.SetDst(*GetHitUnit());
//
//        GetCaster()->CastSpell(targets, spellInfo, nullptr, TRIGGERED_FULL_MASK, nullptr, nullptr, GetCaster()->GetGUID());
//        GetCaster()->ToPlayer()->RemoveSpellCooldown(GetSpellInfo()->Id, true);
//    }
//
//    void Register() override
//    {
//        OnCheckCast += SpellCheckCastFn(spell_dk_raise_dead::CheckCast);
//        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_dk_raise_dead::CheckTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENTRY);
//        OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_dk_raise_dead::CheckTarget, EFFECT_2, TARGET_UNIT_CASTER);
//        OnEffectHitTarget += SpellEffectFn(spell_dk_raise_dead::HandleRaiseDead, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
//        OnEffectHitTarget += SpellEffectFn(spell_dk_raise_dead::HandleRaiseDead, EFFECT_2, SPELL_EFFECT_DUMMY);
//    }
//
//private:
//    SpellCastResult _result;
//    bool _corpse;
//};
//
//void convertNRunes(Player* caster, uint8 nRunes){
//    for (uint8 i = 0; i < MAX_RUNES && nRunes; ++i)
//    {
//        if (caster->GetCurrentRune(i) == RUNE_DEATH ||
//            caster->GetBaseRune(i) == RUNE_UNHOLY)
//            continue;
//        if (caster->GetRuneCooldown(i) != caster->GetRuneBaseCooldown(i, false))
//            continue;
//        --nRunes;
//        caster->ConvertRune(i, RUNE_DEATH);
//    }
//}
//
//void DiseasesHelper(Player* caster, Unit* target){
//    static const AuraType diseaseAuraTypes[] =
//    {
//        SPELL_AURA_PERIODIC_DAMAGE, // Frost Fever and Blood Plague
//        SPELL_AURA_LINKED,          // Crypt Fever
//        SPELL_AURA_NONE
//    };
//
//    ObjectGuid drwGUID = caster->getRuneWeaponGUID();
//    for (uint8 index = 0; diseaseAuraTypes[index] != SPELL_AURA_NONE; ++index)
//    {
//        std::list<AuraEffect*> effects = target->GetAuraEffectsByType(diseaseAuraTypes[index]);
//        for (auto i = effects.begin(); i != effects.end();)
//        {
//            if ((*i)->GetSpellInfo()->Dispel == DISPEL_DISEASE
//                    && ((*i)->GetCasterGUID() == caster->GetGUID() || (*i)->GetCasterGUID() == drwGUID))
//            {
//                if(Aura* aura = (*i)->GetBase()){
//                    uint32 countMin = aura->GetMaxDuration();
//                    uint32 countMax = aura->GetSpellInfo()->GetMaxDuration() + 12000;
//
//                    if (!aura->IsRemoved() && aura->GetDuration() > 0){
//                        if (countMin < countMax){
//                            aura->SetDuration(uint32(aura->GetDuration() + 3000));
//                            aura->SetMaxDuration(countMin + 3000);
//                        }
//                        else if (caster->HasSpell(FORGE_FESTERING_STRIKE_FI) && index < 1) {
//                            caster->CastSpell(target, SPELL_DK_PESTILENCE, true);
//                        }
//                    }
//                }
//            }
//            ++i;
//        }
//    }
//}
//
//void CleaveSpellNTimesForDamageNearbyTarget(Player* caster, uint32 spellId, uint8 cleaves, int32 damage, Unit* target) {
//    for (auto i = 0; i < cleaves; i++) {
//        if (target = caster->SelectNearbyNoTotemTarget(target)) {
//            caster->CastCustomSpell(target, spellId, &damage, nullptr, nullptr, true);
//
//            switch (spellId) {
//            case FORGE_FESTERING_STRIKE_CLONE:
//                DiseasesHelper(caster, target);
//                break;
//            case FORGE_DEATHS_CARESS_CLONE:
//                if (caster->HasSpell(FORGE_DEATHS_CARESS_BONE_SHIELD))
//                    caster->CastSpell(caster, SPELL_DK_BONE_SHIELD, true);
//                if (caster->HasSpell(FORGE_DEATHS_CARESS_LICH))
//                    caster->CastSpell(caster, FORGE_DEATHS_CARESS_LICH_AURA, true);
//                break;
//            }
//        }
//    }
//}
//
//void AddNBoneShieldStacks(Player* player, uint8 n) {
//    for (auto i = 0; i < n; i++) {
//        player->CastSpell(player, SPELL_DK_BONE_SHIELD, true);
//    }
//}
//
//// 1159900 Festering Strike
//class spell_dk_festering_strike : public SpellScript
//{
//    PrepareSpellScript(spell_dk_festering_strike);
//    ObjectGuid guid;
//
//    bool Load() override
//    {
//        guid.Clear();
//        return true;
//    }
//
//    void HandleDummy()
//    {
//        if (GetSpellInfo()->Id) {
//            if (Unit* unitTarget = GetHitUnit())
//            {
//                auto damage = GetHitDamage();
//                if (Player* caster = GetCaster()->ToPlayer()) {
//                    std::vector<SpellInfo*> spellInfos = sSpellMgr->GetSpellInfosForDummyA(GetSpellInfo()->Id);
//                    for (auto* info : spellInfos) {
//                        if (SpellInfo* spell = caster->GetLatestSpellEffectForEnhacement(info->Effects[0].MiscValueB)) {
//                            switch (spell->Effects[0].MiscValueB) {
//                            case FORGE_FESTERING_STRIKE_TAINTING:
//                                if (roll_chance_i(spell->Effects[0].CalcValue()) && !caster->HasSpell(FORGE_FESTERING_STRIKE_FM))
//                                    DiseasesHelper(caster, unitTarget);
//                                break;
//                            case FORGE_FESTERING_STRIKE_REAPERS:
//                                if (roll_chance_i(spell->Effects[0].CalcValue()))
//                                    convertNRunes(caster, 2);
//                                break;
//                            case FORGE_FESTERING_STRIKE_FI_CLEAVE:
//                                CleaveSpellNTimesForDamageNearbyTarget(caster,FORGE_FESTERING_STRIKE_CLONE, spell->Effects[0].CalcValue(), damage/2, unitTarget);
//                                break;
//                            case FORGE_FESTERING_STRIKE_FI_ECHO:
//                                if (roll_chance_i(spell->Effects[0].CalcValue())){
//                                    caster->CastCustomSpell(unitTarget, FORGE_FESTERING_STRIKE_CLONE, &damage, nullptr, nullptr, true);
//                                    DiseasesHelper(caster, unitTarget);
//                                }
//                                break;
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    void Register() override
//    {
//        AfterHit += SpellHitFn(spell_dk_festering_strike::HandleDummy);
//    }
//};
//
//// 1159923 Death's Caress
//class spell_dk_deaths_embrace : public SpellScript
//{
//    PrepareSpellScript(spell_dk_deaths_embrace);
//    ObjectGuid guid;
//    bool boneshield = false;
//
//    void HandleAfterCast()
//    {
//        if (boneshield) {
//            Unit* caster = GetCaster();
//            if (Player* ply = caster->ToPlayer())
//                AddNBoneShieldStacks(ply, 2);
//        }
//    }
//
//    void HandleDummy()
//    {
//        if (GetSpellInfo()->Id) {
//            if (Unit* unitTarget = GetHitUnit())
//            {
//                auto damage = GetHitDamage();
//                if (Player* caster = GetCaster()->ToPlayer()) {
//                    std::vector<SpellInfo*> spellInfos = sSpellMgr->GetSpellInfosForDummyA(GetSpellInfo()->Id);
//                    for (auto* info : spellInfos) {
//                        if (SpellInfo* spell = caster->GetLatestSpellEffectForEnhacement(info->Effects[0].MiscValueB)) {
//                            switch (spell->Effects[0].MiscValueB) {
//                            case FORGE_DEATHS_CARESS_CLEAVE:
//                                CleaveSpellNTimesForDamageNearbyTarget(caster,FORGE_DEATHS_CARESS_CLONE, spell->Effects[0].CalcValue(), damage/2, unitTarget);
//                                break;
//                            case FORGE_DEATHS_CARESS_ECHO:
//                                if (roll_chance_i(spell->Effects[0].CalcValue())){
//                                    caster->CastCustomSpell(unitTarget, FORGE_DEATHS_CARESS_CLONE, &damage, nullptr, nullptr, true);
//                                }
//                                break;
//                            case FORGE_DEATHS_CARESS_BONE_SHIELD:
//                                boneshield = true;
//                                break;
//                            case FORGE_DEATHS_CARESS_LICH:
//                                caster->CastSpell(caster, FORGE_DEATHS_CARESS_LICH_AURA, true);
//                                break;
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    void Register() override
//    {
//        AfterHit += SpellHitFn(spell_dk_deaths_embrace::HandleDummy);
//        AfterCast += SpellCastFn(spell_dk_deaths_embrace::HandleAfterCast);
//    }
//};
//
//// 1159935 Plague Scythe
//class spell_dk_plague_scythe : public SpellScript
//{
//    PrepareSpellScript(spell_dk_plague_scythe);
//    ObjectGuid guid;
//    int32 damage;
//
//    bool Load() override
//    {
//        guid.Clear();
//        return true;
//    }
//
//    void HandleDummy()
//    {
//        if (GetSpellInfo()->Id) {
//            if (Unit* unitTarget = GetHitUnit()) {
//                if (Player* caster = GetCaster()->ToPlayer()) {
//                    std::vector<SpellInfo*> spellInfos = sSpellMgr->GetSpellInfosForDummyA(GetSpellInfo()->Id);
//                    for (auto* info : spellInfos) {
//                        if (SpellInfo* spell = caster->GetLatestSpellEffectForEnhacement(info->Effects[0].MiscValueB)) {
//                            int32 value = 0;
//                            switch (spell->Effects[0].MiscValueB) {
//                            case FORGE_PLAGUE_SCYTHE_SHIELD:
//                                LOG_INFO("server.worldserver", "damage saved = {}", damage);
//                                value = spell->Effects[0].CalcValue() * (damage / 1000);
//                                caster->CastCustomSpell(unitTarget, FORGE_PLAGUE_SCYTHE_SHIELD_ACTIVE, &value, nullptr, nullptr, true);
//                                break;
//                            case FORGE_PLAGUE_SCYTHE_SIPHON:
//                                value = spell->Effects[0].CalcValue() * (damage / (int32) 1000);
//                                caster->CastCustomSpell(unitTarget, FORGE_PLAGUE_SCYTHE_SHIELD_ACTIVE, &value, nullptr, nullptr, true);
//                                break;
//                            case FORGE_PLAGUE_SCYTHE_DRAW_POWER:
//                                caster->CastCustomSpell(FORGE_PLAGUE_SCYTHE_DRAW_POWER_ACTIVE, SPELLVALUE_BASE_POINT0, spell->Effects[0].CalcValue(), GetCaster(), true);
//                                break;
//                            case FORGE_PLAGUE_SCYTHE_RUNEREND:
//                                if (roll_chance_i(spell->Effects[0].CalcValue())) {
//                                    if (Item* item = caster->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND)) {
//                                        for (uint8 slot = 0; slot < MAX_ENCHANTMENT_SLOT; ++slot) {
//                                            SpellItemEnchantmentEntry const* enchant = sSpellItemEnchantmentStore.LookupEntry(item->GetEnchantmentId(EnchantmentSlot(slot)));
//                                            if (!enchant)
//                                                continue;
//                                            for (uint8 s = 0; s < 3; ++s) {
//                                                if (enchant->type[s] != ITEM_ENCHANTMENT_TYPE_COMBAT_SPELL)
//                                                    continue;
//
//                                                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(enchant->spellid[s]);
//                                                if (!spellInfo)
//                                                {
//                                                    LOG_ERROR("misc", "Player::CastItemCombatSpell Enchant {}, player (Name: {}, {}) cast unknown spell {}",
//                                                        enchant->ID, caster->GetName(), caster->GetGUID().ToString(), enchant->spellid[s]);
//                                                    continue;
//                                                }
//
//                                                // Proc only DK runes
//                                                if (spellInfo->SpellFamilyName != SPELLFAMILY_DEATHKNIGHT)
//                                                    continue;
//
//                                                if (spellInfo->IsPositive())
//                                                    caster->CastSpell(caster, enchant->spellid[s], true, item);
//                                                else
//                                                    caster->CastSpell(unitTarget, enchant->spellid[s], true, item);
//                                            }
//                                        }
//                                    }
//                                }
//                                break;
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    void HandlePostHit()
//    {
//        if (Unit* unitTarget = GetHitUnit()) {
//            if (Player* caster = GetCaster()->ToPlayer()) {
//                if (!unitTarget->HasAura(SPELL_DK_BLOOD_PLAGUE)) {
//                    caster->CastSpell(unitTarget, SPELL_DK_BLOOD_PLAGUE);
//                }
//                else if (GetCaster()->HasSpell(FORGE_PLAGUE_SCYTHE_PLAGUE_SHADOW)) {
//                    int32 diseases = unitTarget->GetDiseasesByCaster(caster->GetGUID(), 0);
//                    int32 weaponDamage = FORGE_PLAGUE_SCYTHE_PLAGUE_SHADOW_SCALING * diseases;
//                    GetCaster()->CastCustomSpell(unitTarget, FORGE_PLAGUE_SCYTHE_PLAGUE_SHADOW_ACTIVE, &weaponDamage, nullptr, nullptr, true);
//                }
//            }
//        }
//    }
//
//    void HandleHit()
//    {
//        if (Unit* unitTarget = GetHitUnit()) {
//            if (Player* player = GetCaster()->ToPlayer()) {
//                if (player->HasSpell(FORGE_PLAGUE_SCYTHE_PLAGUE_SHADOW)) {
//                    damage = GetHitDamage();
//                    SetHitDamage(0);
//                }
//            }
//        }
//    }
//
//    void Register() override
//    {
//        OnHit += SpellHitFn(spell_dk_plague_scythe::HandleHit);
//        AfterHit += SpellHitFn(spell_dk_plague_scythe::HandleDummy);
//        AfterHit += SpellHitFn(spell_dk_plague_scythe::HandlePostHit);
//    }
//};
//
//// -1150076 Vengeance
//class spell_dk_vengeance : public AuraScript
//{
//    PrepareAuraScript(spell_dk_vengeance);
//
//    bool Validate(SpellInfo const* /*spellInfo*/) override
//    {
//        return ValidateSpellInfo({ SPELL_DK_VENGEANCE_TRIGGERED });
//    }
//
//    bool CheckProc(ProcEventInfo& eventInfo)
//    {
//        return eventInfo.GetDamageInfo() && eventInfo.GetDamageInfo()->GetAttacker()
//            && eventInfo.GetDamageInfo()->GetAttacker()->GetTypeId() != TYPEID_PLAYER;
//    }
//
//    void HandleEffectProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
//    {
//        PreventDefaultAction();
//        Unit* caster = GetTarget();
//
//        if (!caster->GetAura(SPELL_DK_VENGEANCE_TRIGGERED, caster->GetGUID()))
//        {
//            uint32 healthCap = CalculatePct(caster->GetCreateHealth(), 10) + caster->GetStat(STAT_STAMINA);
//            uint32 damageBonus = CalculatePct(eventInfo.GetDamageInfo()->GetDamage(), 33);
//            int32 bp = std::min<int32>(damageBonus, healthCap);
//            caster->CastCustomSpell(caster, SPELL_DK_VENGEANCE_TRIGGERED, &bp, &bp, nullptr, true);
//        }
//    }
//
//    void Register() override
//    {
//        DoCheckProc += AuraCheckProcFn(spell_dk_vengeance::CheckProc);
//        OnEffectProc += AuraEffectProcFn(spell_dk_vengeance::HandleEffectProc, EFFECT_0, SPELL_AURA_DUMMY);
//    }
//};
//
//// 1150081 - Scent of Blood
//class spell_dk_scent_of_blood : public AuraScript
//{
//    PrepareAuraScript(spell_dk_scent_of_blood);
//
//    bool Validate(SpellInfo const* /*spellInfo*/) override
//    {
//        return ValidateSpellInfo({ SPELL_DK_SCENT_OF_BLOOD });
//    }
//
//    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
//    {
//        PreventDefaultAction();
//        GetTarget()->CastSpell(GetTarget(), SPELL_DK_SCENT_OF_BLOOD, true, nullptr, aurEff);
//        GetTarget()->RemoveAuraFromStack(GetSpellInfo()->Id);
//    }
//
//    void Register() override
//    {
//        OnEffectProc += AuraEffectProcFn(spell_dk_scent_of_blood::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
//    }
//};
//
//// 49222 - Bone Shield
//class spell_dk_bone_shield : public AuraScript
//{
//    PrepareAuraScript(spell_dk_bone_shield);
//
//    void HandleProc(ProcEventInfo& eventInfo)
//    {
//        PreventDefaultAction();
//        if (!eventInfo.GetSpellInfo() || !eventInfo.GetSpellInfo()->IsTargetingArea()) {
//            DropCharge();
//            if (Player* ply = GetCaster()->ToPlayer()) {
//                if (ply->HasAura(SPELL_DK_IMP_BONE_SHIELD_TRIGGERED)) {
//                    ply->GetAura(SPELL_DK_IMP_BONE_SHIELD_TRIGGERED)->DropCharge();
//                }
//            }
//        }
//    }
//
//    void HandleAuraApply()
//    {
//        if (Player* caster = GetCaster()->ToPlayer()) {
//            if (caster->HasSpell(SPELL_DK_IMP_BONE_SHIELD)) {
//                caster->CastSpell(caster, SPELL_DK_IMP_BONE_SHIELD_TRIGGERED, true);
//            }
//        }
//    }
//
//    void Register() override
//    {
//        OnAuraApply += AuraApplyFn(spell_dk_bone_shield::HandleAuraApply);
//        OnProc += AuraProcFn(spell_dk_bone_shield::HandleProc);
//    }
//};
//
//// 1150001 - Wandering Plague
//class spell_dk_wandering_plague_aura : public AuraScript
//{
//    PrepareAuraScript(spell_dk_wandering_plague_aura);
//
//    bool CheckProc(ProcEventInfo& eventInfo)
//    {
//        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
//        if (!spellInfo || !eventInfo.GetActionTarget() || !eventInfo.GetDamageInfo() || !eventInfo.GetActor())
//            return false;
//
//        if (!roll_chance_f(eventInfo.GetActor()->GetUnitCriticalChance(BASE_ATTACK, eventInfo.GetActionTarget())))
//            return false;
//
//        return !eventInfo.GetActor()->HasSpellCooldown(SPELL_DK_WANDERING_PLAGUE_TRIGGER);
//    }
//
//    // xinef: prevent default proc with castItem passed, which applies 30 sec cooldown to procing of the aura
//    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
//    {
//        PreventDefaultAction();
//
//        eventInfo.GetActor()->AddSpellCooldown(SPELL_DK_WANDERING_PLAGUE_TRIGGER, 0, 1000);
//        eventInfo.GetActor()->CastSpell(eventInfo.GetActionTarget(), SPELL_DK_WANDERING_PLAGUE_TRIGGER, true);
//    }
//
//    void Register() override
//    {
//        DoCheckProc += AuraCheckProcFn(spell_dk_wandering_plague_aura::CheckProc);
//        OnEffectProc += AuraEffectProcFn(spell_dk_wandering_plague_aura::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
//    }
//};
//
//class LoadDKSpells : LoadForgeSpells
//{
//public:
//    LoadDKSpells() : LoadForgeSpells()
//    {
//
//    }
//
//    void Load() override
//    {
//        RegisterSpellScript(spell_dk_festering_strike);
//        RegisterSpellScript(spell_dk_deaths_embrace);
//        RegisterSpellScript(spell_dk_plague_scythe);
//        RegisterSpellScript(spell_dk_raise_dead);
//        RegisterSpellScript(spell_dk_vengeance);
//        RegisterSpellScript(spell_dk_scent_of_blood);
//        RegisterSpellScript(spell_dk_bone_shield);
//    }
//};
