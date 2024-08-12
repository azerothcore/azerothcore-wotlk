#include "botspell.h"
#include "DBCStores.h"
#include "Log.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Timer.h"

#include <unordered_map>

typedef std::unordered_map<uint32, SpellInfo> SpellInfoOverridesMap;
typedef std::unordered_map<uint32, SpellProcEntry> SpellProcOverridesMap;
static SpellInfoOverridesMap botSpellInfoOverrides;
static SpellProcOverridesMap botSpellProcOverrides;

void GenerateBotCustomSpellProcs()
{
}

SpellInfo const* GetBotSpellInfoOverride(uint32 spellId)
{
    decltype(botSpellInfoOverrides)::const_iterator ci = botSpellInfoOverrides.find(spellId);
    return ci != botSpellInfoOverrides.cend() ? &ci->second : nullptr;
}

SpellInfo const* AssertBotSpellInfoOverride(uint32 spellId)
{
    decltype(botSpellInfoOverrides)::const_iterator ci = botSpellInfoOverrides.find(spellId);
    ASSERT(ci != botSpellInfoOverrides.cend(), "AssertBotSpellInfoOverride failed for spell Id %u!", spellId);
    return &ci->second;
}

SpellProcEntry const* GetBotSpellProceEntryOverride(uint32 spellId)
{
    decltype(botSpellProcOverrides)::const_iterator ci = botSpellProcOverrides.find(spellId);
    return ci != botSpellProcOverrides.cend() ? &ci->second : nullptr;
}

void GenerateBotCustomSpells()
{
    botSpellInfoOverrides.clear();

    uint32 spellId, triggerSpellId;
    SpellInfo* sinfo;

    //COMMON
    //1) SPELL_TELEPORT_LOCAL
    spellId = SPELL_TELEPORT_LOCAL; //7794
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->InterruptFlags = SPELL_INTERRUPT_FLAG_ABORT_ON_DMG;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(6); //5000ms
    //sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(4); //1000ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(1); //self
    sinfo->ExplicitTargetMask = TARGET_FLAG_DEST_LOCATION;
    sinfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES | SPELL_ATTR0_ALLOW_WHILE_MOUNTED;
    sinfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;

    sinfo->Effects[0].Effect = SPELL_EFFECT_TELEPORT_UNITS;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    sinfo->Effects[0].BasePoints = 1;

    // SPELL_NULLIFY_POISON
    spellId = SPELL_NULLIFY_POISON; //550
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    sinfo->SpellLevel = 0;
    sinfo->MaxLevel = 0;
    sinfo->RecoveryTime = 0;
    sinfo->StartRecoveryCategory = 0;
    sinfo->StartRecoveryTime = 0;
    sinfo->ManaCost = 0;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); //0
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(21); //-1
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(1); //self
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes &= ~(SPELL_ATTR0_NOT_SHAPESHIFTED);
    sinfo->Attributes |= SPELL_ATTR0_PASSIVE | SPELL_ATTR0_DO_NOT_DISPLAY | SPELL_ATTR0_DO_NOT_LOG;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].BasePoints = -200;
    sinfo->Effects[0].MiscValue = DISPEL_POISON;
    sinfo->Effects[0].RealPointsPerLevel = 0.0f;
    sinfo->Effects[0].BonusMultiplier = 0.0f;
    sinfo->Effects[0].DamageMultiplier = 0.0f;
    // END SPELL_NULLIFY_POISON

    //BLADEMASTER
    //2) SPELL_COMBAT_SPECIAL_2H_ATTACK
    spellId = SPELL_COMBAT_SPECIAL_2H_ATTACK; //44079
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(6); //6 - 100 yds
    sinfo->Attributes &= ~(SPELL_ATTR0_NOT_IN_COMBAT_ONLY_PEACEFUL);
    sinfo->AttributesEx2 |= SPELL_ATTR2_ALLOW_DEAD_TARGET;
    //2) END SPELL_COMBAT_SPECIAL_2H_ATTACK

    //3) WINDWALK
    //3.1) TRANSPARENCY
    spellId = SPELL_TRANSPARENCY_50; //44816
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);
    triggerSpellId = spellId;

    sinfo->Attributes |= (SPELL_ATTR0_NOT_SHAPESHIFTED | SPELL_ATTR0_ALLOW_WHILE_SITTING);
    sinfo->AttributesEx |= (SPELL_ATTR1_ALLOW_WHILE_STEALTHED);
    sinfo->AuraInterruptFlags =
        AURA_INTERRUPT_FLAG_SPELL_ATTACK | AURA_INTERRUPT_FLAG_MELEE_ATTACK |
        AURA_INTERRUPT_FLAG_NOT_ABOVEWATER | AURA_INTERRUPT_FLAG_MOUNT; //0x00003C07;vanish
    sinfo->CasterAuraStateNot = 0;
    //3.1) END TRANSPARENCY

    spellId = SPELL_NETHERWALK; //31599
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellLevel = 0;
    sinfo->MaxLevel = 0;
    sinfo->RecoveryTime = 5000;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 75 * 5;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->Attributes &= ~(SPELL_ATTR0_WEARER_CASTS_PROC_TRIGGER);
    sinfo->Attributes |= (SPELL_ATTR0_NOT_SHAPESHIFTED | SPELL_ATTR0_ALLOW_WHILE_SITTING | SPELL_ATTR0_NO_IMMUNITIES);
    sinfo->AttributesEx &= ~SPELL_ATTR1_AURA_UNIQUE;
    sinfo->AttributesEx |= (SPELL_ATTR1_ALLOW_WHILE_STEALTHED | SPELL_ATTR1_NO_THREAT);
    sinfo->AttributesEx2 |= SPELL_ATTR2_NO_SHAPESHIFT_UI;
    sinfo->AuraInterruptFlags =
        AURA_INTERRUPT_FLAG_SPELL_ATTACK | AURA_INTERRUPT_FLAG_MELEE_ATTACK |
        AURA_INTERRUPT_FLAG_NOT_ABOVEWATER | AURA_INTERRUPT_FLAG_MOUNT; //0x00003C07;vanish
    sinfo->CasterAuraStateNot = 0;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[0].BasePoints = 100;
    sinfo->Effects[0].RealPointsPerLevel = 2.5f;
    sinfo->Effects[0].ValueMultiplier = 1.0f;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_MOD_INVISIBILITY;
    sinfo->Effects[0].Amplitude = 0;
    sinfo->Effects[0].TriggerSpell = 0;
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_0_YARDS);

    sinfo->Effects[1].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[1].BasePoints = 10;
    sinfo->Effects[1].RealPointsPerLevel = 0.5f;
    sinfo->Effects[1].ValueMultiplier = 1.0f;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[1].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_MOD_INCREASE_SPEED;
    sinfo->Effects[1].Amplitude = 0;
    sinfo->Effects[1].TriggerSpell = 0;
    sinfo->Effects[1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_0_YARDS); //14

    sinfo->Effects[2].Effect = SPELL_EFFECT_TRIGGER_SPELL;
    sinfo->Effects[2].BasePoints = 0;
    sinfo->Effects[2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[2].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[2].ApplyAuraName = SPELL_AURA_NONE;
    sinfo->Effects[2].Amplitude = 0;
    sinfo->Effects[2].TriggerSpell = triggerSpellId;
    sinfo->Effects[2].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_0_YARDS); //14
    //3) END WINDWALK

    //4) MIRROR IMAGE (BLADEMASTER)
    spellId = SPELL_MIRROR_IMAGE_BM; //69936
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(1); //1 - self only //6 - 100 yds
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(566); //566 - 0 sec //3 - 60 sec //1 - 10 sec //32 - 6 seconds
    sinfo->RecoveryTime = 8000;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 125 * 5;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->Attributes |= (SPELL_ATTR0_NOT_SHAPESHIFTED/* | SPELL_ATTR0_ALLOW_WHILE_SITTING | SPELL_ATTR0_NO_IMMUNITIES*/);
    sinfo->AttributesEx2 &= ~(SPELL_ATTR2_IGNORE_LINE_OF_SIGHT);
    //sinfo->AttributesEx3 |= SPELL_ATTR3_DONT_DISPLAY_RANGE;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[0].MiscValue = 0;
    sinfo->Effects[0].MiscValueB = 0;
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_0_YARDS);
    //4) END MIRROR IMAGE (BLADEMASTER)

    //SPHYNX
    //5) SHADOW BLAST (SPLASH ATTACK)
    //TODO: balance
    spellId = SPELL_SHADOW_BLAST; //38085
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->SpellLevel = 60;
    sinfo->MaxLevel = 83;
    sinfo->ManaCost = BASE_MANA_SPHYNX / 16;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->CastTimeEntry = nullptr;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT | TARGET_FLAG_DEST_LOCATION;
    //sinfo->MaxAffectedTargets = 1000;
    //sinfo->Attributes |= SPELL_ATTR0_DO_NOT_LOG | SPELL_ATTR0_HIDDEN_CLIENTSIDE | SPELL_ATTR0_DO_NOT_SHEATH;
    sinfo->Attributes &= ~(SPELL_ATTR0_SCALES_WITH_CREATURE_LEVEL);
    //sinfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;

    sinfo->Effects[0].BasePoints = 300;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].BonusMultiplier = 0.f;
    sinfo->Effects[0].DamageMultiplier = 0.75f;
    sinfo->Effects[0].RealPointsPerLevel = 50.f;
    //sinfo->Effects[0].ValueMultiplier = 1.f;

    sinfo->Effects[1].Effect = SPELL_EFFECT_SCHOOL_DAMAGE;
    sinfo->Effects[1].BasePoints = 50;
    sinfo->Effects[1].BonusMultiplier = 1.0f;
    sinfo->Effects[1].DamageMultiplier = 0.5f;
    sinfo->Effects[1].DieSides = /*17*/25;
    sinfo->Effects[1].RealPointsPerLevel = 30.f;
    //sinfo->Effects[1].ValueMultiplier = 1.f;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[1].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ENEMY);
    sinfo->Effects[1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_12_YARDS);
    //5) END SHADOW BLAST (SPLASH ATTACK)

    //6) SHADOW BOLT (BASE ATTACK)
    spellId = SPELL_SHADOW_BOLT1; //16408
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    sinfo->SpellLevel = 60;
    sinfo->MaxLevel = 83;
    sinfo->ManaCost = 0;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->CastTimeEntry = nullptr;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    //sinfo->Attributes |= SPELL_ATTR0_DO_NOT_LOG | SPELL_ATTR0_HIDDEN_CLIENTSIDE | SPELL_ATTR0_DO_NOT_SHEATH;
    //sinfo->AttributesEx3 |= SPELL_ATTR3_DONT_DISPLAY_RANGE;

    sinfo->Effects[0].BasePoints = 200;
    sinfo->Effects[0].DieSides = /*12*/25;
    sinfo->Effects[0].BonusMultiplier = 1.15f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 10.f;
    //sinfo->Effects[0].ValueMultiplier = 1.f;
    //6) END SHADOW BOLT (BASE ATTACK)

    //7) ATTACK ANIMATION
    spellId = SPELL_ATTACK_MELEE_RANDOM; //42902
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->Attributes &= ~(SPELL_ATTR0_NOT_IN_COMBAT_ONLY_PEACEFUL);
    //7) END ATTACK ANIMATION

    //8) SPLASH ANIMATION
    spellId = SHADOWFURY_VISUAL; //48582
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellLevel = 0;
    sinfo->MaxLevel = 0;
    sinfo->ManaCost = 0;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(6); //100 yds
    sinfo->ExplicitTargetMask = TARGET_FLAG_DEST_LOCATION;
    sinfo->MaxAffectedTargets = 1;
    sinfo->Stances = 0;
    sinfo->Speed = 0.f;
    sinfo->Attributes |= SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD | SPELL_ATTR0_NO_IMMUNITIES;
    sinfo->AttributesEx |= SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS | SPELL_ATTR1_NO_THREAT;
    sinfo->AttributesEx2 |= SPELL_ATTR2_ALLOW_DEAD_TARGET | SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    sinfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_WHILE_STUNNED | SPELL_ATTR5_ALLOW_WHILE_CONFUSED | SPELL_ATTR5_ALLOW_WHILE_FLEEING;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[0].RealPointsPerLevel = 0.f;
    sinfo->Effects[0].ValueMultiplier = 0.f;
    sinfo->Effects[0].RealPointsPerLevel = 0.f;
    sinfo->Effects[0].DamageMultiplier = 0.f;
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_0_YARDS);
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    //8) END SPLASH ANIMATION

    //9) DEVOUR MAGIC
    spellId = SPELL_DEVOUR_MAGIC; //17012
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->InterruptFlags = 0xF;
    sinfo->SpellLevel = 0;
    sinfo->MaxLevel = 0;
    sinfo->MaxTargetLevel = 0;
    sinfo->RecoveryTime = 7000;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 0;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(4); //1000ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(5); //40 yds
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    sinfo->ExplicitTargetMask = TARGET_FLAG_DEST_LOCATION;
    //sinfo->MaxAffectedTargets = 100;
    sinfo->Attributes |= SPELL_ATTR0_NO_IMMUNITIES;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
    //sinfo->Attributes &= ~(SPELL_ATTR0_DO_NOT_LOG);
    //sinfo->AttributesEx3 |= SPELL_ATTR3_DONT_DISPLAY_RANGE;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DISPEL;
    sinfo->Effects[0].BasePoints = 2;
    sinfo->Effects[0].MiscValue = DISPEL_MAGIC;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ALLY);
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_20_YARDS);

    sinfo->Effects[1].Effect = SPELL_EFFECT_DISPEL;
    sinfo->Effects[1].BasePoints = 2;
    sinfo->Effects[1].MiscValue = DISPEL_CURSE;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ALLY);
    sinfo->Effects[1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_20_YARDS);

    sinfo->Effects[2].Effect = SPELL_EFFECT_DISPEL;
    sinfo->Effects[2].BasePoints = 2;
    sinfo->Effects[2].MiscValue = DISPEL_MAGIC;
    sinfo->Effects[2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ENEMY);
    sinfo->Effects[2].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_20_YARDS);
    //9) END DEVOUR MAGIC

    //10) DRAIN MANA
    spellId = SPELL_DRAIN_MANA; //25755
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellLevel = 0;
    sinfo->MaxLevel = 0;
    sinfo->MaxTargetLevel = 0;
    sinfo->RecoveryTime = 0;//60000;
    //sinfo->PowerType = POWER_MANA;
    //sinfo->ManaCost = 0;
    //sinfo->ManaCostPercentage = 0;
    //sinfo->ManaCostPerlevel = 0;
    sinfo->Speed = 0.f;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(4); //1000ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(5); //40 yds
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    //sinfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;

    //sinfo->Effects[0].Effect = SPELL_EFFECT_POWER_DRAIN;
    sinfo->Effects[0].BasePoints = 999999;
    sinfo->Effects[0].RealPointsPerLevel = 0.f;
    sinfo->Effects[0].ValueMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 0.f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);

    sinfo->Effects[1].Effect = 0;
    //10) END DRAIN MANA

    //11) REPLENISH MANA
    spellId = SPELL_REPLENISH_MANA; //33394
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->SpellLevel = 0;
    sinfo->RecoveryTime = 3000;
    sinfo->CategoryRecoveryTime = 0;
    sinfo->CategoryEntry = nullptr;
    sinfo->PowerType = POWER_MANA;
    sinfo->CastTimeEntry = nullptr;//sSpellCastTimesStore.LookupEntry(2); //250ms
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->MaxAffectedTargets = 100;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_DO_NOT_LOG_IMMUNE_MISSES | SPELL_ATTR0_DO_NOT_LOG;
    sinfo->AttributesEx |= SPELL_ATTR1_USE_ALL_MANA/* | SPELL_ATTR1_EXCLUDE_CASTER*/;
    sinfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    sinfo->AttributesEx4 |= SPELL_ATTR4_AURA_NEVER_BOUNCES;
    sinfo->AttributesEx5 |= SPELL_ATTR5_AI_DOESNT_FACE_TARGET;
    sinfo->AttributesEx6 |= SPELL_ATTR6_NO_AURA_LOG;

    sinfo->Effects[0].Effect = SPELL_EFFECT_TRIGGER_SPELL;
    sinfo->Effects[0].BasePoints = 3;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].RealPointsPerLevel = 0.f;
    sinfo->Effects[0].ValueMultiplier = 0.f;
    sinfo->Effects[0].RealPointsPerLevel = 0.f;
    sinfo->Effects[0].DamageMultiplier = 0.f;
    sinfo->Effects[0].TriggerSpell = SPELL_TRIGGERED_ENERGIZE;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ALLY);
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_25_YARDS);
    //11) END REPLENISH MANA

    //12) REPLENISH HEALTH
    spellId = SPELL_REPLENISH_HEALTH; //34756
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->SpellLevel = 0;
    sinfo->RecoveryTime = 3000;
    sinfo->CategoryEntry = nullptr;
    sinfo->PowerType = POWER_MANA;
    sinfo->CastTimeEntry = nullptr;//sSpellCastTimesStore.LookupEntry(2); //250ms
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->MaxAffectedTargets = 100;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_DO_NOT_LOG_IMMUNE_MISSES | SPELL_ATTR0_DO_NOT_LOG;
    sinfo->AttributesEx |= SPELL_ATTR1_USE_ALL_MANA/* | SPELL_ATTR1_EXCLUDE_CASTER*/;
    sinfo->AttributesEx &= ~(SPELL_ATTR1_EXCLUDE_CASTER);
    sinfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    sinfo->AttributesEx4 |= SPELL_ATTR4_AURA_NEVER_BOUNCES;
    sinfo->AttributesEx5 |= SPELL_ATTR5_AI_DOESNT_FACE_TARGET;
    sinfo->AttributesEx6 |= SPELL_ATTR6_NO_AURA_LOG;

    sinfo->Effects[0].Effect = SPELL_EFFECT_TRIGGER_SPELL;
    sinfo->Effects[0].BasePoints = 3;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].RealPointsPerLevel = 0.f;
    sinfo->Effects[0].ValueMultiplier = 0.f;
    sinfo->Effects[0].RealPointsPerLevel = 0.f;
    sinfo->Effects[0].DamageMultiplier = 0.f;
    sinfo->Effects[0].TriggerSpell = SPELL_TRIGGERED_HEAL;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ALLY);
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_25_YARDS);
    //12) END REPLENISH HEALTH

    //ARCHMAGE
    //13) BRILLIANCE AURA
    spellId = SPELL_BRILLIANCE_AURA; //1234
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellLevel = 0;
    sinfo->MaxLevel = 0;
    sinfo->MaxTargetLevel = 0;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(1); //0 yds
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_PASSIVE;
    sinfo->AttributesEx4 |= SPELL_ATTR4_ALLOW_ENETRING_ARENA;
    sinfo->AttributesEx7 |= SPELL_ATTR7_DO_NOT_COUNT_FOR_PVP_SCOREBOARD;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AREA_AURA_RAID;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_MOD_POWER_REGEN_PERCENT;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[0].BasePoints = 100;
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_40_YARDS);

    sinfo->Effects[1].Effect = SPELL_EFFECT_APPLY_AREA_AURA_RAID;
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_MOD_INCREASE_ENERGY_PERCENT;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[1].BasePoints = 10;
    sinfo->Effects[1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_40_YARDS);

    //for stacking rule
    /*
    sinfo->Effects[2].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[2].ApplyAuraName = SPELL_AURA_DUMMY;
    sinfo->Effects[2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[2].BasePoints = 1;
    sinfo->Effects[2].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_0_YARDS);
    */
    //13) END BRILLIANCE AURA

    //14) FIREBALL (MAIN_ATTACK)
    //TODO: balance
    spellId = SPELL_FIREBALL; //9488
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellLevel = 20;
    sinfo->BaseLevel = 20;
    sinfo->MaxLevel = 81;
    sinfo->ManaCost = 0;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->CastTimeEntry = nullptr;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_FIRE | SPELL_SCHOOL_MASK_ARCANE;
    //sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    //sinfo->MaxAffectedTargets = 1000;
    sinfo->Attributes |= SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_ALLOW_WHILE_MOUNTED;
    sinfo->Attributes &= ~(SPELL_ATTR0_SCALES_WITH_CREATURE_LEVEL);
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;

    sinfo->Effects[0].BasePoints = 15;
    sinfo->Effects[0].DieSides = 9;
    sinfo->Effects[0].BonusMultiplier = 0.5f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 15.f;
    sinfo->Effects[0].ValueMultiplier = 1.f;
    //14) END FIREBALL (MAIN ATTACK)

    //15) BLIZZARD
    //TODO: balance
    spellId = SPELL_BLIZZARD; //15783
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_MAGE;
    sinfo->SpellLevel = 20;
    sinfo->BaseLevel = 20;
    sinfo->MaxLevel = 0;
    sinfo->ManaCost = 75 * 5;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->CastTimeEntry = nullptr;
    sinfo->RecoveryTime = 6000;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_FROST | SPELL_SCHOOL_MASK_ARCANE;
    ///sinfo->ExplicitTargetMask = TARGET_FLAG_DEST_LOCATION;
    //sinfo->MaxAffectedTargets = 1000;
    sinfo->Attributes |= SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_ALLOW_WHILE_MOUNTED;
    sinfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT | SPELL_ATTR2_NO_INITIAL_THREAD;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    sinfo->AttributesEx5 |= SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC;

    sinfo->Effects[0].BasePoints = 26;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].BonusMultiplier = 1.f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 15.f;
    sinfo->Effects[0].ValueMultiplier = 1.f;
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_13_YARDS);
    sinfo->Effects[0].Amplitude = 1000;
    //15) END BLIZZARD

    //16) SUMMON WATER ELEMENTAL (dummy spell)
    spellId = SPELL_SUMMON_WATER_ELEMENTAL; //35593
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_MAGE;
    sinfo->SpellLevel = 20;
    sinfo->BaseLevel = 20;
    sinfo->MaxLevel = 0;
    sinfo->RecoveryTime = 20000;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 125 * 5;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(3); //500ms
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_FROST | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    //sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_0_YARDS);
    //16) END SUMMON WATER ELEMENTAL

    //17) WATERBOLT (MAIN_ATTACK)
    //TODO: balance, we only have 1 of 3 possible elementals so boost damage
    spellId = SPELL_WATERBOLT; //72898
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_GENERIC;
    sinfo->SpellLevel = 20;
    sinfo->BaseLevel = 20;
    sinfo->MaxTargetLevel = 0;
    sinfo->ManaCost = 0;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(5); //2000ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_FROST | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;

    sinfo->Effects[0].BasePoints = 25;
    sinfo->Effects[0].DieSides = 20;
    sinfo->Effects[0].BonusMultiplier = 1.f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 25.f;
    sinfo->Effects[0].ValueMultiplier = 1.f;
    //17) END WATERBOLT (MAIN ATTACK)

    //DREADLORD
    //18) VAMPIRIC AURA
    spellId = SPELL_VAMPIRIC_AURA; //20810
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->ProcFlags = PROC_FLAG_DONE_MELEE_AUTO_ATTACK | PROC_FLAG_DONE_SPELL_MELEE_DMG_CLASS;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_NONE;
    sinfo->SpellLevel = 0;
    sinfo->BaseLevel = 0;
    sinfo->MaxTargetLevel = 0;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(1); //0 yds
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_PASSIVE;
    sinfo->AttributesEx3 |= SPELL_ATTR3_CAN_PROC_FROM_PROCS;
    sinfo->AttributesEx4 |= SPELL_ATTR4_ALLOW_ENETRING_ARENA;
    sinfo->AttributesEx7 |= SPELL_ATTR7_DO_NOT_COUNT_FOR_PVP_SCOREBOARD;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AREA_AURA_RAID;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_MOD_CRIT_DAMAGE_BONUS;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[0].BasePoints = 5;
    sinfo->Effects[0].MiscValue = SPELL_SCHOOL_MASK_NORMAL;
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_40_YARDS);

    sinfo->Effects[1].Effect = SPELL_EFFECT_APPLY_AREA_AURA_RAID;
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_PROC_TRIGGER_SPELL;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[1].BasePoints = 1;
    sinfo->Effects[1].TriggerSpell = SPELL_TRIGGERED_HEAL;
    sinfo->Effects[1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_40_YARDS);

    //for stacking rule
    /*
    sinfo->Effects[2].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[2].ApplyAuraName = SPELL_AURA_DUMMY;
    sinfo->Effects[2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[2].BasePoints = 1;
    sinfo->Effects[2].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_0_YARDS);
    */
    //18) END VAMPIRIC AURA

    //19) VAMPIRIC HEAL
    spellId = SPELL_TRIGGERED_HEAL; //25155
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_NONE;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->Attributes &= ~(SPELL_ATTR0_NOT_SHAPESHIFTED);
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REFLECTION | SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_THREAT;
    sinfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_INSTANT_TARGET_PROCS | SPELL_ATTR3_CAN_PROC_FROM_PROCS | SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;

    sinfo->Effects[0].BasePoints = 1;

    sinfo->Effects[1].Effect = 0;
    //19) END VAMPIRIC HEAL

    //20) SLEEP
    spellId = SPELL_SLEEP; //20663
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->InterruptFlags = 0xF;
    sinfo->SpellLevel = 0;
    sinfo->BaseLevel = 0;
    sinfo->MaxTargetLevel = 0;
    sinfo->Dispel = DISPEL_MAGIC;
    sinfo->Mechanic = MECHANIC_SLEEP;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(3); //500ms
    sinfo->RecoveryTime = 6000;
    //sinfo->StartRecoveryCategory = 133;
    //sinfo->StartRecoveryTime = 1000;
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(3); //60000ms
    sinfo->ManaCost = 50 * 5;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_DIRECT_DAMAGE;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes &= ~(SPELL_ATTR0_NOT_SHAPESHIFTED | SPELL_ATTR0_HEARTBEAT_RESIST);
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_REFLECTION;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;

    //sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    //sinfo->Effects[0].ApplyAuraName = SPELL_AURA_MOD_STUN;
    //sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    //sinfo->Effects[0].BasePoints = 1;

    sinfo->Effects[1].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_MOD_RESISTANCE_PCT;
    sinfo->Effects[1].MiscValue = SPELL_SCHOOL_MASK_NORMAL;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[1].BasePoints = -100;
    //20) END SLEEP

    //21) CARRION SWARM
    //TODO: balance
    spellId = SPELL_CARRION_SWARM; //34240
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    sinfo->SpellLevel = 40;
    sinfo->BaseLevel = 40;
    sinfo->MaxTargetLevel = 0;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->RecoveryTime = 10000;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 110 * 5;
    //sinfo->MaxAffectedTargets = 1000;
    //sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes &= ~(SPELL_ATTR0_WEARER_CASTS_PROC_TRIGGER);
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_REFLECTION;
    sinfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT/* | SPELL_ATTR2_IGNORE_LINE_OF_SIGHT*/;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;

    //sinfo->Effects[0].Effect = SPELL_EFFECT_SCHOOL_DAMAGE;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CONE_ENEMY_104);
    sinfo->Effects[0].BasePoints = 425;
    sinfo->Effects[0].DieSides = 150;
    sinfo->Effects[0].BonusMultiplier = 2.f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 37.5f; //2000 avg at 80
    sinfo->Effects[0].ValueMultiplier = 1.f;
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_40_YARDS);
    //21) END CARRION SWARM

    //22) INFERNO (dummy summon)
    spellId = SPELL_INFERNO; //12740
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->SpellLevel = 60;
    sinfo->BaseLevel = 60;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(3); //500ms
    sinfo->RecoveryTime = 180000;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 175 * 5;
    sinfo->ExplicitTargetMask = TARGET_FLAG_DEST_LOCATION;
    sinfo->Attributes &= ~(SPELL_ATTR0_IS_ABILITY);
    sinfo->AttributesEx |= /*SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS | */SPELL_ATTR1_NO_THREAT;
    //sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    sinfo->Effects[0].BasePoints = 1;
    //22) END INFERNO

    //23) INFERNO VISUAL (dummy summon)
    spellId = SPELL_INFERNO_METEOR_VISUAL; //5739
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->ExplicitTargetMask = TARGET_FLAG_DEST_LOCATION;

    //sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    //23) END INFERNO VISUAL

    //SPELL BREAKER
    //24) STEAL MAGIC
    spellId = SPELL_STEAL_MAGIC; //30036
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_PALADIN;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(34); //25 yds
    sinfo->RecoveryTime = 2000;
    sinfo->ManaCost = 75 * 5;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_REFLECTION;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    sinfo->AttributesEx6 |= SPELL_ATTR6_NO_AURA_LOG;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);

    sinfo->Effects[1].Effect = 0;
    //24) END STEAL MAGIC

    //24.1) STEAL MAGIC VISUAL
    spellId = SPELL_STEAL_MAGIC_VISUAL; //11084
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellLevel = 1;
    sinfo->BaseLevel = 1;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(6); //100 yds
    sinfo->RecoveryTime = 0;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_REFLECTION;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].RealPointsPerLevel = 0.f;
    sinfo->Effects[0].BonusMultiplier = 0.f;
    //24.1) END STEAL MAGIC VISUAL

    //25) FEEDBACK
    spellId = SPELL_FEEDBACK; //32897
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_PALADIN;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_ARCANE;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    sinfo->SpellLevel = 0;
    sinfo->BaseLevel = 0;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(13); //50000 yds
    sinfo->ManaCost = 0;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes &= ~(SPELL_ATTR0_NOT_SHAPESHIFTED);
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_REFLECTION | SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS;
    sinfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;

    sinfo->Effects[0].Effect = SPELL_EFFECT_POWER_BURN;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].ValueMultiplier = 1.f;
    //25) END FEEDBACK

    // DARK RANGER
    //26) BLACK ARROW
    //TODO: balance
    spellId = SPELL_BLACK_ARROW; //20733
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    //sinfo->SpellFamilyFlags[0] = 0x0;
    sinfo->SpellFamilyFlags[1] = 0x4; //custom, not present in db
    //sinfo->SpellFamilyFlags[2] = 0x0;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_RANGED;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_PACIFY;
    sinfo->Dispel = DISPEL_NONE;
    sinfo->Mechanic = MECHANIC_NONE;
    sinfo->SpellLevel = 40;
    sinfo->BaseLevel = 40;
    sinfo->MaxTargetLevel = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(3); //500ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //5-30 yds
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(85); //18 sec
    sinfo->RecoveryTime = 3000;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 6 * 5 * 2; //need to increase cost since ability is not autocast, has cd and deals more damage
    sinfo->MaxAffectedTargets = 1;
    sinfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_CHANGE_MAP;
    //sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_NO_ACTIVE_DEFENSE | SPELL_ATTR0_AURA_IS_DEBUFF;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_REFLECTION;
    sinfo->AttributesEx2 |= SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS/* | SPELL_ATTR2_CANT_CRIT*/;
    sinfo->AttributesEx4 |= SPELL_ATTR4_NO_CAST_LOG;

    sinfo->Effects[1].Effect = SPELL_EFFECT_WEAPON_PERCENT_DAMAGE;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_NONE;
    sinfo->Effects[1].BasePoints = 150;
    sinfo->Effects[1].DieSides = 0;
    sinfo->Effects[1].BonusMultiplier = 1.f;
    sinfo->Effects[1].DamageMultiplier = 1.f;
    sinfo->Effects[1].RealPointsPerLevel = 0.f;
    sinfo->Effects[1].ValueMultiplier = 1.f;
    sinfo->Effects[1].RadiusEntry = nullptr;

    //sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    //sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    //sinfo->Effects[0].ApplyAuraName = SPELL_AURA_PERIODIC_DAMAGE;
    sinfo->Effects[0].BasePoints = 100;
    //sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].BonusMultiplier = 1.5f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 10.f;
    //sinfo->Effects[0].ValueMultiplier = 1.f;
    //sinfo->Effects[0].RadiusEntry = nullptr;
    sinfo->Effects[0].Amplitude = 2000;
    //26) END BLACK ARROW

    //27) DRAIN LIFE
    //TODO: balance
    spellId = SPELL_DRAIN_LIFE; //17238
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_MAGIC;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_SILENCE;
    sinfo->Dispel = DISPEL_NONE;
    sinfo->Mechanic = MECHANIC_NONE;
    sinfo->SpellLevel = 40;
    sinfo->BaseLevel = 40;
    sinfo->MaxTargetLevel = 0;
    sinfo->CastTimeEntry = nullptr;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    //sinfo->DurationEntry = sSpellDurationStore.LookupEntry(85); //18 sec
    sinfo->RecoveryTime = 5000;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 75 * 5;
    sinfo->MaxAffectedTargets = 1;
    sinfo->AuraInterruptFlags = 0x0;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_NO_ACTIVE_DEFENSE;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_REFLECTION;
    sinfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS | SPELL_ATTR3_ALWAYS_HIT;
    sinfo->AttributesEx4 |= SPELL_ATTR4_NO_CAST_LOG;
    sinfo->AttributesEx5 |= SPELL_ATTR5_EXTRA_INITIAL_PERIOD;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_PERIODIC_LEECH;
    sinfo->Effects[0].BasePoints = 45;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].BonusMultiplier = 1.f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 6.f;
    sinfo->Effects[0].ValueMultiplier = 2.f;
    sinfo->Effects[0].RadiusEntry = nullptr;
    sinfo->Effects[0].Amplitude = 1000;
    //27) END DRAIN LIFE

    //28) SILENCE
    //TODO: balance
    spellId = SPELL_SILENCE; //29943
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_NONE;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_SILENCE;
    sinfo->Dispel = DISPEL_MAGIC;
    sinfo->Mechanic = MECHANIC_SILENCE;
    sinfo->SpellLevel = 60;
    sinfo->BaseLevel = 60;
    sinfo->MaxTargetLevel = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(2); //250ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    //sinfo->DurationEntry = sSpellDurationStore.LookupEntry(85); //18 sec
    sinfo->RecoveryTime = 15000;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 75 * 5;
    sinfo->MaxAffectedTargets = 5;
    sinfo->AuraInterruptFlags = 0x0;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT | TARGET_FLAG_DEST_LOCATION;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REFLECTION | SPELL_ATTR1_NO_REDIRECTION;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_DEST_AREA_ENEMY);
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_MOD_SILENCE;
    sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_15_YARDS);
    //28) END SILENCE

    // NECROMANCER
    //29) SHADOW BOLT (MAIN_ATTACK)
    //TODO: balance
    spellId = SPELL_SHADOW_BOLT2; //17509
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->SpellLevel = 20;
    sinfo->BaseLevel = 20;
    sinfo->MaxLevel = 82;
    sinfo->ManaCost = 0;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->CastTimeEntry = nullptr;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->Attributes |= SPELL_ATTR0_DO_NOT_SHEATH;

    sinfo->Effects[0].BasePoints = 15;
    sinfo->Effects[0].DieSides = 9;
    sinfo->Effects[0].BonusMultiplier = 0.75f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 8.f;
    sinfo->Effects[0].ValueMultiplier = 1.f;
    //29) END SHADOW BOLT (MAIN_ATTACK)

    //30) RAISE DEAD
    spellId = SPELL_RAISE_DEAD; //34011
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW;
    sinfo->InterruptFlags = 0xF;
    sinfo->SpellLevel = 20;
    sinfo->BaseLevel = 20;
    sinfo->MaxTargetLevel = 0;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(34); //25 yds
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(3); //500ms
    sinfo->RecoveryTime = 8000;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 50 * 5;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->ExplicitTargetMask = TARGET_FLAG_CORPSE_ENEMY;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[1].Effect = 0;
    sinfo->Effects[2].Effect = 0;
    //30) END RAISE DEAD

    //31) UNHOLY FRENZY
    spellId = SPELL_UNHOLY_FRENZY; //52499
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_NONE;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW;
    sinfo->SpellLevel = 30;
    sinfo->BaseLevel = 30;
    sinfo->MaxTargetLevel = 0;
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(22); //566 - 0 sec //3 - 60 sec //1 - 10 sec //32 - 6 sec //22 - 45 sec
    sinfo->RecoveryTime = 2000; //original 1000
    sinfo->CategoryEntry = nullptr;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 50 * 5;
    sinfo->ManaCostPercentage = 0;
    sinfo->ManaCostPerlevel = 0;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REFLECTION | SPELL_ATTR1_NO_REDIRECTION;
    sinfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    sinfo->AttributesEx4 |= SPELL_ATTR4_NO_CAST_LOG;

    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_MOD_ATTACKSPEED;
    sinfo->Effects[0].BasePoints = 75;
    sinfo->Effects[1].Amplitude = 3000;
    sinfo->Effects[1].BasePoints = 1;
    //31) END UNHOLY FRENZY

    //32) CRIPPLE
    spellId = SPELL_CRIPPLE; //50379
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_NONE;
    sinfo->Dispel = DISPEL_CURSE; //TODO: check if works
    sinfo->SpellLevel = 50;
    sinfo->BaseLevel = 50;
    sinfo->MaxLevel = 0;
    sinfo->MaxTargetLevel = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(0); //0ms
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(3); //60 sec
    sinfo->RecoveryTime = 10000;
    sinfo->CategoryEntry = nullptr;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 175 * 5;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REFLECTION | SPELL_ATTR1_NO_REDIRECTION;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    //32) END CRIPPLE

    //33) CORPSE EXPLOSION
    spellId = SPELL_CORPSE_EXPLOSION; //61614
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARLOCK;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_NONE;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW;
    sinfo->TargetCreatureType = 0x0000037F;
    sinfo->InterruptFlags = 0xF;
    sinfo->SpellLevel = 40;
    sinfo->BaseLevel = 40;
    sinfo->MaxTargetLevel = 0;
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(21); //-1
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(110); //750ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(3); //20 yds
    sinfo->RecoveryTime = 1500;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 100 * 5;
    sinfo->ExplicitTargetMask = TARGET_FLAG_CORPSE_ENEMY;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH;
    sinfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_DUMMY;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS);
    sinfo->Effects[0].SpellClassMask[0] = 0;
    sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[1].Effect = 0;
    //33) END CORPSE EXPLOSION

    //SEA WITCH
    //35) FORKED LIGHTNING
    spellId = SPELL_FORKED_LIGHTNING; //63541
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_MAGE;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_NATURE | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_SILENCE;
    sinfo->InterruptFlags = 0x9;
    sinfo->SpellLevel = 4;
    sinfo->BaseLevel = 4;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(110); //750ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->RecoveryTime = 11000;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 110 * 5;
    sinfo->MaxAffectedTargets = 2;
    sinfo->Speed = 1000.f;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    sinfo->AttributesEx5 |= SPELL_ATTR5_AI_DOESNT_FACE_TARGET;
    //sinfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_PHASE_SHIFT;

    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CONE_ENEMY_24);
    //sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_CONE_ENEMY_24);
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_30_YARDS);
    sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[0].DieSides = 49;
    sinfo->Effects[0].BonusMultiplier = 0.0f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 15.f;
    sinfo->Effects[0].ValueMultiplier = 1.f;
    //35) END FORKED LIGHTNING

    //36) FORKED LIGHTNING EFFECT
    spellId = SPELL_FORKED_LIGHTNING_EFFECT; //50900
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_MAGE;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_NATURE | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->Dispel = DISPEL_MAGIC;
    sinfo->Mechanic = MECHANIC_STUN;
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(39); //2000ms
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); //instant
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(6); //100 yds
    sinfo->ManaCost = 0;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    sinfo->AttributesEx5 |= SPELL_ATTR5_AI_DOESNT_FACE_TARGET;
    sinfo->AttributesEx6 |= SPELL_ATTR6_IGNORE_PHASE_SHIFT;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_MOD_STUN;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[0].RadiusEntry = nullptr;
    //36) END FORKED LIGHTNING EFFECT

    //37) FROST ARROW
    spellId = SPELL_FROST_ARROW; //38942
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_MAGE;
    //sinfo->SpellFamilyFlags[0] = 0x0;
    sinfo->SpellFamilyFlags[1] = 0x4; //custom, not present in db
    //sinfo->SpellFamilyFlags[2] = 0x0;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_RANGED;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_FROST | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_PACIFY;
    sinfo->Dispel = DISPEL_NONE;
    sinfo->Mechanic = MECHANIC_NONE;
    sinfo->SpellLevel = 4;
    sinfo->BaseLevel = 4;
    sinfo->MaxTargetLevel = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(110); //750ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(35); //0-35 yds
    sinfo->DurationEntry = nullptr;
    sinfo->RecoveryTime = 0;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 750;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 10 * 5;
    sinfo->MaxAffectedTargets = 1;
    sinfo->AuraInterruptFlags = AURA_INTERRUPT_FLAG_CHANGE_MAP;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_NO_ACTIVE_DEFENSE | SPELL_ATTR0_DO_NOT_SHEATH;
    sinfo->Attributes &= ~(SPELL_ATTR0_USES_RANGED_SLOT);
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_REFLECTION;
    sinfo->AttributesEx2 |= SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS/* | SPELL_ATTR2_CANT_CRIT*/;
    sinfo->AttributesEx4 |= SPELL_ATTR4_NO_CAST_LOG;
    sinfo->AttributesEx4 &= ~(SPELL_ATTR4_FORCE_DISPLAY_CASTBAR);

    sinfo->Effects[0].Effect = SPELL_EFFECT_WEAPON_DAMAGE;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[0].BasePoints = 10;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].BonusMultiplier = 0.5f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 2.f;
    sinfo->Effects[0].ValueMultiplier = 1.f;
    sinfo->Effects[0].RadiusEntry = nullptr;
    sinfo->Effects[1].Effect = 0;
    //37) END FROST ARROW

    //38) FROST ARROW EFFECT
    spellId = SPELL_FROST_ARROW_EFFECT; //56095
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_GENERIC;
    //sinfo->SpellFamilyFlags[0] = 0x0;
    sinfo->SpellFamilyFlags[1] = 0x4; //custom, not present in db
    //sinfo->SpellFamilyFlags[2] = 0x0;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_FROST | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->Dispel = DISPEL_MAGIC;
    sinfo->Mechanic = MECHANIC_SNARE;
    sinfo->Attributes &= ~(SPELL_ATTR0_TRACK_TARGET_IN_CAST_PLAYER_ONLY);
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_REFLECTION;
    sinfo->AttributesEx4 |= SPELL_ATTR4_NO_CAST_LOG;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_MOD_SPEED_SLOW_ALL;
    sinfo->Effects[0].Mechanic = MECHANIC_SLOW_ATTACK;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[0].BasePoints = -30;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].BonusMultiplier = 1.f;
    sinfo->Effects[0].DamageMultiplier = 1.f;
    sinfo->Effects[0].RealPointsPerLevel = 0.f;
    sinfo->Effects[0].ValueMultiplier = 1.f;
    sinfo->Effects[0].RadiusEntry = nullptr;
    sinfo->Effects[1].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_MOD_DECREASE_SPEED;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[1].BasePoints = -30;
    sinfo->Effects[1].DieSides = 0;
    sinfo->Effects[1].BonusMultiplier = 1.f;
    sinfo->Effects[1].DamageMultiplier = 1.f;
    sinfo->Effects[1].RealPointsPerLevel = 0.f;
    sinfo->Effects[1].ValueMultiplier = 1.f;
    sinfo->Effects[1].RadiusEntry = nullptr;
    //38) END FROST ARROW EFFECT

    //39) MANA SHIELD
    spellId = SPELL_MANA_SHIELD; //35064
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->Dispel = DISPEL_NONE;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    sinfo->SpellLevel = 0;
    sinfo->BaseLevel = 0;
    sinfo->MaxTargetLevel = 0;
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(21); //-1
    sinfo->RecoveryTime = 10000;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_COOLDOWN_ON_EVENT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    sinfo->AttributesEx4 |= SPELL_ATTR4_CANNOT_BE_STOLEN;

    sinfo->Effects[0].BasePoints = 1000000000;
    sinfo->Effects[0].ValueMultiplier = 10.f;
    //39) END MANA SHIELD

    //40) TORNADO
    spellId = SPELL_TORNADO; //34695
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_MAGE;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_NATURE | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->InterruptFlags = 0x9;
    sinfo->SpellLevel = 60;
    sinfo->BaseLevel = 60;
    sinfo->MaxTargetLevel = 0;
    sinfo->DurationEntry = nullptr;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(15); //4000ms
    //sinfo->RangeEntry = sSpellRangeStore.LookupEntry(5); //40 yds
    sinfo->RecoveryTime = 120000;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->ManaCost = 250 * 5;
    sinfo->ExplicitTargetMask = TARGET_FLAG_DEST_LOCATION;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_ONLY_OUTDOORS;
    sinfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT | SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    sinfo->AttributesEx3 &= ~(SPELL_ATTR3_ONLY_ON_PLAYER);
    sinfo->AttributesEx4 = 0;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].RadiusEntry = nullptr;
    sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[0].TriggerSpell = 0;
    sinfo->Effects[0].Amplitude = 0;
    sinfo->Effects[1].Effect = 0;
    //40) END TORNADO

    //41) TORNADO EFFECT
    spellId = SPELL_TORNADO_EFFECT; //21990
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_MAGE;
    //sinfo->SpellFamilyFlags[0] = 0x0;
    sinfo->SpellFamilyFlags[1] = 0x4; //custom, not present in db
    //sinfo->SpellFamilyFlags[2] = 0x0;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_NATURE | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->Dispel = DISPEL_MAGIC;
    sinfo->Mechanic = MECHANIC_NONE; //MECHANIC_KNOCKOUT
    sinfo->InterruptFlags = 0x0;
    sinfo->SpellLevel = 60;
    sinfo->BaseLevel = 60;
    sinfo->MaxTargetLevel = 0;
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(29); //12000ms
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); //0ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(2); //5 yds
    sinfo->RecoveryTime = 3000;
    //sinfo->StartRecoveryCategory = 133;
    //sinfo->StartRecoveryTime = 1500;
    //sinfo->ManaCost = 250 * 5;
    sinfo->MaxAffectedTargets = 1;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_ONLY_OUTDOORS;
    sinfo->Attributes &= ~(SPELL_ATTR0_HEARTBEAT_RESIST);
    sinfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT | SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_IGNORE_CASTER_MODIFIERS;
    sinfo->AttributesEx3 &= ~(SPELL_ATTR3_ONLY_ON_PLAYER);
    sinfo->AttributesEx4 = 0;
    sinfo->AttributesEx5 = 0;

    //sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    //sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    //sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    //sinfo->Effects[0].RadiusEntry = nullptr;
    //sinfo->Effects[0].BasePoints = 1;
    //sinfo->Effects[0].TriggerSpell = 0;
    //sinfo->Effects[0].Amplitude = 0;
    sinfo->Effects[1].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_MOD_RESISTANCE_PCT;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[1].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[1].BasePoints = -100;
    sinfo->Effects[1].MiscValue = SPELL_SCHOOL_MASK_ALL;
    sinfo->Effects[2].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[2].ApplyAuraName = SPELL_AURA_PERIODIC_DAMAGE;
    sinfo->Effects[2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[2].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[2].BasePoints = 212;
    sinfo->Effects[2].DieSides = 183;
    sinfo->Effects[2].RealPointsPerLevel = 35.f;
    sinfo->Effects[2].BonusMultiplier = 0.25f;
    sinfo->Effects[2].Amplitude = 1500;
    //41) END TORNADO EFFECT

    //42) TORNADO EFFECT2
    spellId = SPELL_TORNADO_EFFECT2; //34683
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_MAGE;
    //sinfo->SpellFamilyFlags[0] = 0x0;
    //sinfo->SpellFamilyFlags[1] = 0x4; //custom, not present in db
    //sinfo->SpellFamilyFlags[2] = 0x0;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_NATURE | SPELL_SCHOOL_MASK_ARCANE;
    //sinfo->Dispel = DISPEL_MAGIC;
    //sinfo->Mechanic = MECHANIC_DISORIENTED;
    sinfo->ProcFlags = 0;
    sinfo->InterruptFlags = 0x0;
    sinfo->SpellLevel = 60;
    sinfo->BaseLevel = 60;
    sinfo->MaxTargetLevel = 0;
    sinfo->DurationEntry = nullptr;
    //sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); //0ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(7); //10 yds
    sinfo->RecoveryTime = 4500;
    //sinfo->StartRecoveryCategory = 133;
    //sinfo->StartRecoveryTime = 1500;
    //sinfo->ManaCost = 250 * 5;
    sinfo->MaxAffectedTargets = 1;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_ONLY_OUTDOORS;
    sinfo->Attributes &= ~(SPELL_ATTR0_WEARER_CASTS_PROC_TRIGGER);
    sinfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    sinfo->AttributesEx4 = 0;
    sinfo->AttributesEx5 = 0;

    sinfo->Effects[0].Effect = SPELL_EFFECT_SCHOOL_DAMAGE;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    //sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_10_YARDS);
    sinfo->Effects[0].BasePoints = 541;
    sinfo->Effects[0].DieSides = 215;
    sinfo->Effects[0].RealPointsPerLevel = 40.f;
    sinfo->Effects[0].BonusMultiplier = 0.5f;
    //42) END TORNADO EFFECT2

    //43) TORNADO EFFECT3
    spellId = SPELL_TORNADO_EFFECT3; //39261
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_MAGE;
    //sinfo->SpellFamilyFlags[0] = 0x0;
    //sinfo->SpellFamilyFlags[1] = 0x4; //custom, not present in db
    //sinfo->SpellFamilyFlags[2] = 0x0;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_NATURE | SPELL_SCHOOL_MASK_ARCANE;
    //sinfo->Dispel = DISPEL_NONE;
    //sinfo->Mechanic = MECHANIC_DISORIENTED;
    //sinfo->ProcFlags = 0;
    //sinfo->InterruptFlags = 0x0;
    sinfo->SpellLevel = 0;
    sinfo->BaseLevel = 0;
    //sinfo->MaxTargetLevel = 0;
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(21); //-1
    //sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); //0ms
    //sinfo->RangeEntry = sSpellRangeStore.LookupEntry(1); //self
    //sinfo->RecoveryTime = 4500;
    //sinfo->StartRecoveryCategory = 133;
    //sinfo->StartRecoveryTime = 1500;
    //sinfo->ManaCost = 250 * 5;
    //sinfo->MaxAffectedTargets = 1;
    //sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_ONLY_OUTDOORS;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_THREAT;
    sinfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    sinfo->AttributesEx4 = 0;
    sinfo->AttributesEx5 = 0;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AREA_AURA_ENEMY;
    //sinfo->Effects[0].ApplyAuraName = SPELL_AURA_MOD_DECREASE_SPEED;
    //sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
    //sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENEMY);
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_5_YARDS);
    //sinfo->Effects[0].BasePoints = -50;
    sinfo->Effects[1].Effect = SPELL_EFFECT_APPLY_AREA_AURA_ENEMY;
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_MOD_DECREASE_SPEED;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
    sinfo->Effects[1].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENEMY);
    sinfo->Effects[1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_5_YARDS);
    sinfo->Effects[1].BasePoints = -60;
    //sinfo->AttributesCu &= ~(SPELL_ATTR0_CU_NEGATIVE_EFF1);
    //43) END TORNADO EFFECT3

    //44) SHOOT
    spellId = SPELL_SHOOT_BOW; //41188
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_MAGE;
    sinfo->DmgClass = SPELL_DAMAGE_CLASS_RANGED;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_PACIFY;
    sinfo->SpellLevel = 1;
    sinfo->BaseLevel = 1;
    sinfo->CategoryEntry = sSpellCategoryStore.LookupEntry(76);
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(110); //750ms
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(35); //0-35 yds
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 750;
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_NO_ACTIVE_DEFENSE/* | SPELL_ATTR0_DO_NOT_SHEATH*/;
    sinfo->Attributes &= ~(SPELL_ATTR0_USES_RANGED_SLOT/* | SPELL_ATTR0_IS_ABILITY*/ | SPELL_ATTR0_TRACK_TARGET_IN_CAST_PLAYER_ONLY | SPELL_ATTR0_SCALES_WITH_CREATURE_LEVEL | SPELL_ATTR0_NO_IMMUNITIES);
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_REFLECTION;
    sinfo->AttributesEx &= ~(SPELL_ATTR1_TRACK_TARGET_IN_CHANNEL | SPELL_ATTR1_NO_THREAT);
    sinfo->AttributesEx2 |= SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS;
    sinfo->AttributesEx2 &= ~(SPELL_ATTR2_IGNORE_LINE_OF_SIGHT);
    sinfo->AttributesEx3 |= SPELL_ATTR3_NORMAL_RANGED_ATTACK;

    sinfo->Effects[0].Effect = SPELL_EFFECT_WEAPON_PERCENT_DAMAGE;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].BasePoints = 100;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].BonusMultiplier = 1.f;
    //44) END SHOOT

    //CRYPT LORD
    //45) IMPALE
    spellId = SPELL_IMPALE; //53458
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARRIOR;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_PACIFY;
    sinfo->SpellLevel = 20;
    sinfo->BaseLevel = 20;
    sinfo->CategoryEntry = nullptr;
    sinfo->RecoveryTime = 9000;
    sinfo->CategoryRecoveryTime = 0;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 100 * 5;
    sinfo->MaxAffectedTargets = 0;
    sinfo->InterruptFlags = 0x1;
    sinfo->ChannelInterruptFlags = 0x0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); //0
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(5); //40 yds
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(592); //400ms
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_DO_NOT_DISPLAY | SPELL_ATTR0_IS_ABILITY;
    sinfo->AttributesEx |= SPELL_ATTR1_IS_SELF_CHANNELED | SPELL_ATTR1_TRACK_TARGET_IN_CHANNEL | SPELL_ATTR1_NO_THREAT;
    sinfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_DUMMY;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CONE_ENEMY_24);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_40_YARDS);
    sinfo->Effects[0].MiscValue = 0;
    sinfo->Effects[0].MiscValueB = 0;
    sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[0].Amplitude = 0;
    sinfo->Effects[0].RealPointsPerLevel = 0.0f;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].DamageMultiplier = 0.0f;
    sinfo->Effects[0].BonusMultiplier = 0.0f;

    sinfo->Effects[1].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_DUMMY;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_SRC_CASTER);
    sinfo->Effects[1].TargetB = SpellImplicitTargetInfo(TARGET_UNIT_SRC_AREA_ENEMY);
    sinfo->Effects[1].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_8_YARDS);
    sinfo->Effects[1].MiscValue = 0;
    sinfo->Effects[1].MiscValueB = 0;
    sinfo->Effects[1].BasePoints = 1;
    sinfo->Effects[1].Amplitude = 0;
    sinfo->Effects[1].RealPointsPerLevel = 0.0f;
    sinfo->Effects[1].DieSides = 0;
    sinfo->Effects[1].DamageMultiplier = 0.0f;
    sinfo->Effects[1].BonusMultiplier = 0.0f;
    //45) END IMPALE

    //46) IMPALE DAMAGE
    spellId = SPELL_IMPALE_DAMAGE; //53454
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARRIOR;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    sinfo->SpellLevel = 20;
    sinfo->BaseLevel = 20;
    sinfo->CategoryEntry = nullptr;
    sinfo->RecoveryTime = 0;
    sinfo->CategoryRecoveryTime = 0;
    sinfo->StartRecoveryCategory = 0;
    sinfo->StartRecoveryTime = 0;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 0;
    sinfo->MaxAffectedTargets = 1;
    sinfo->ChannelInterruptFlags = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); //0
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(36); //45 yds
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(32); //6000ms
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT_ENEMY;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD | SPELL_ATTR0_ALLOW_WHILE_SITTING;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REFLECTION | SPELL_ATTR1_NO_REDIRECTION;
    sinfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT;
    sinfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_WHILE_STUNNED;
    sinfo->AttributesEx6 |= SPELL_ATTR6_ALLOW_WHILE_RIDING_VEHICLE | SPELL_ATTR6_IGNORE_PHASE_SHIFT;

    sinfo->Effects[0].Effect = SPELL_EFFECT_SCHOOL_DAMAGE;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_NONE;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].RadiusEntry = nullptr;
    sinfo->Effects[0].MiscValue = 0;
    sinfo->Effects[0].MiscValueB = 0;
    sinfo->Effects[0].BasePoints = 150;
    sinfo->Effects[0].Amplitude = 0;
    sinfo->Effects[0].RealPointsPerLevel = 35.0f;
    sinfo->Effects[0].DieSides = 200;
    sinfo->Effects[0].DamageMultiplier = 0.0f;
    sinfo->Effects[0].BonusMultiplier = 0.0f;

    sinfo->Effects[1].Effect = SPELL_EFFECT_KNOCK_BACK;
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_NONE;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[1].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[1].RadiusEntry = nullptr;
    sinfo->Effects[1].Mechanic = MECHANIC_KNOCKOUT;
    sinfo->Effects[1].MiscValue = 5;
    sinfo->Effects[1].MiscValueB = 0;
    sinfo->Effects[1].BasePoints = 180;
    sinfo->Effects[1].Amplitude = 0;
    sinfo->Effects[1].RealPointsPerLevel = 0.0;
    sinfo->Effects[1].DieSides = 0;
    sinfo->Effects[1].DamageMultiplier = 0.0f;
    sinfo->Effects[1].BonusMultiplier = 0.0f;

    sinfo->Effects[2].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[2].ApplyAuraName = SPELL_AURA_MOD_STUN;
    //sinfo->Effects[2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    //sinfo->Effects[2].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[2].TargetA = sinfo->Effects[0].TargetA;
    sinfo->Effects[2].TargetB = sinfo->Effects[0].TargetB;
    sinfo->Effects[2].RadiusEntry = nullptr;
    sinfo->Effects[2].Mechanic = MECHANIC_NONE;
    sinfo->Effects[2].MiscValue = 0;
    sinfo->Effects[2].MiscValueB = 0;
    sinfo->Effects[2].BasePoints = 1;
    sinfo->Effects[2].Amplitude = 0;
    sinfo->Effects[2].RealPointsPerLevel = 0.0;
    sinfo->Effects[2].DieSides = 0;
    sinfo->Effects[2].DamageMultiplier = 0.0f;
    sinfo->Effects[2].BonusMultiplier = 0.0f;
    //46) END IMPALE DAMAGE

    //47) IMPALE VISUAL
    spellId = SPELL_IMPALE_VISUAL; //53454
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARRIOR;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_NONE;
    sinfo->SpellLevel = 20;
    sinfo->BaseLevel = 20;
    sinfo->CategoryEntry = nullptr;
    sinfo->RecoveryTime = 0;
    sinfo->CategoryRecoveryTime = 0;
    sinfo->StartRecoveryCategory = 0;
    sinfo->StartRecoveryTime = 0;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 0;
    sinfo->MaxAffectedTargets = 1;
    sinfo->ChannelInterruptFlags = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); //0
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(36); //45 yds
    sinfo->ExplicitTargetMask = TARGET_FLAG_DEST_LOCATION;
    sinfo->Attributes |= SPELL_ATTR0_IS_ABILITY | SPELL_ATTR0_DO_NOT_SHEATH | SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD | SPELL_ATTR0_ALLOW_WHILE_SITTING;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REFLECTION | SPELL_ATTR1_NO_REDIRECTION | SPELL_ATTR1_NO_THREAT;
    sinfo->AttributesEx2 |= SPELL_ATTR2_IGNORE_LINE_OF_SIGHT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_ALWAYS_HIT | SPELL_ATTR3_SUPRESS_TARGET_PROCS;
    sinfo->AttributesEx5 |= SPELL_ATTR5_ALLOW_WHILE_STUNNED;
    sinfo->AttributesEx6 |= SPELL_ATTR6_ALLOW_WHILE_RIDING_VEHICLE | SPELL_ATTR6_IGNORE_PHASE_SHIFT;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_NONE;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_DEST_DEST);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].RadiusEntry = sSpellRadiusStore.LookupEntry(EFFECT_RADIUS_0_5_YARDS);
    sinfo->Effects[0].MiscValue = 0;
    sinfo->Effects[0].MiscValueB = 0;
    sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[0].Amplitude = 0;
    sinfo->Effects[0].RealPointsPerLevel = 0.0f;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].DamageMultiplier = 0.0f;
    sinfo->Effects[0].BonusMultiplier = 0.0f;

    sinfo->Effects[1].Effect = 0;
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_NONE;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(0);
    sinfo->Effects[1].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[1].RadiusEntry = nullptr;
    sinfo->Effects[1].MiscValueB = 0;
    sinfo->Effects[1].BasePoints = 0;
    sinfo->Effects[1].Amplitude = 0;
    sinfo->Effects[1].RealPointsPerLevel = 0.0;
    sinfo->Effects[1].DieSides = 0;
    sinfo->Effects[1].DamageMultiplier = 0.0f;
    sinfo->Effects[1].BonusMultiplier = 0.0f;
    //47) END IMPALE VISUAL

    //48) CARRION BEETLES
    spellId = SPELL_CARRION_BEETLES; //53520
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARRIOR;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_PACIFY;
    sinfo->SpellLevel = 10;
    sinfo->BaseLevel = 10;
    sinfo->RecoveryTime = 6000;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 50 * 5;
    sinfo->MaxAffectedTargets = 1;
    sinfo->InterruptFlags = 0x1;
    sinfo->ChannelInterruptFlags = 0x100C;
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(327); //500ms // (36); // 1000ms // (327); //500ms
    sinfo->ExplicitTargetMask = TARGET_FLAG_CORPSE_ENEMY;
    sinfo->Attributes |= SPELL_ATTR0_DO_NOT_DISPLAY | SPELL_ATTR0_IS_ABILITY;
    sinfo->AttributesEx |= SPELL_ATTR1_TRACK_TARGET_IN_CHANNEL;
    sinfo->AttributesEx2 |= SPELL_ATTR2_ALLOW_DEAD_TARGET;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_NONE;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ANY);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[0].Amplitude = 500;
    sinfo->Effects[0].RealPointsPerLevel = 0.0f;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].DamageMultiplier = 0.0f;
    sinfo->Effects[0].BonusMultiplier = 0.0f;
    //48) END CARRION BEETLES

    //49) LOCUST SWARM
    spellId = SPELL_LOCUST_SWARM; //28785
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARRIOR;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_PACIFY;
    sinfo->SpellLevel = 40;
    sinfo->BaseLevel = 40;
    sinfo->CategoryEntry = nullptr;
    sinfo->RecoveryTime = 180000;
    sinfo->CategoryRecoveryTime = 0;
    sinfo->StartRecoveryCategory = 133;
    sinfo->StartRecoveryTime = 1500;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 50 * 5;
    sinfo->MaxAffectedTargets = 0;
    sinfo->StackAmount = 0;
    sinfo->InterruptFlags = 0x1;
    sinfo->ChannelInterruptFlags = 0x100C;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); //0
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(4); //30 yds
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(35); //4000ms
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_DO_NOT_DISPLAY | SPELL_ATTR0_DO_NOT_LOG;
    sinfo->AttributesEx |= SPELL_ATTR1_IS_SELF_CHANNELED | SPELL_ATTR1_NO_AURA_ICON | SPELL_ATTR1_NO_THREAT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_SUPRESS_TARGET_PROCS;

    sinfo->Effects[0].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_DUMMY;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_CASTER);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].TriggerSpell = 0;
    sinfo->Effects[0].RadiusEntry = nullptr;
    sinfo->Effects[0].MiscValue = 0;
    sinfo->Effects[0].MiscValueB = 0;
    sinfo->Effects[0].BasePoints = 1;
    sinfo->Effects[0].Amplitude = 0;
    sinfo->Effects[0].RealPointsPerLevel = 0.0f;
    sinfo->Effects[0].DieSides = 0;
    sinfo->Effects[0].DamageMultiplier = 0.0f;
    sinfo->Effects[0].BonusMultiplier = 0.0f;

    for (uint8 i = EFFECT_1; i < MAX_SPELL_EFFECTS; ++i)
    {
        sinfo->Effects[i].Effect = 0;
        sinfo->Effects[i].ApplyAuraName = SPELL_AURA_NONE;
        sinfo->Effects[i].TargetA = SpellImplicitTargetInfo(0);
        sinfo->Effects[i].TargetB = SpellImplicitTargetInfo(0);
        sinfo->Effects[i].RadiusEntry = nullptr;
        sinfo->Effects[i].MiscValue = 0;
        sinfo->Effects[i].MiscValueB = 0;
        sinfo->Effects[i].BasePoints = 0;
        sinfo->Effects[i].Amplitude = 0;
        sinfo->Effects[i].RealPointsPerLevel = 0.0f;
        sinfo->Effects[i].DieSides = 0;
        sinfo->Effects[i].DamageMultiplier = 0.0f;
        sinfo->Effects[i].BonusMultiplier = 0.0f;
    }
    //49) END LOCUST SWARM

    //50) SOUL BITE
    spellId = SPELL_SOUL_BITE; //11016
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SpellFamilyName = SPELLFAMILY_WARRIOR;
    sinfo->PreventionType = SPELL_PREVENTION_TYPE_PACIFY;
    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW | SPELL_SCHOOL_MASK_ARCANE;
    sinfo->SpellLevel = 40;
    sinfo->BaseLevel = 40;
    sinfo->CategoryEntry = nullptr;
    sinfo->RecoveryTime = 0;
    sinfo->CategoryRecoveryTime = 0;
    sinfo->StartRecoveryCategory = 0;
    sinfo->StartRecoveryTime = 0;
    sinfo->PowerType = POWER_MANA;
    sinfo->ManaCost = 0;
    sinfo->MaxAffectedTargets = 0;
    sinfo->StackAmount = 10;
    sinfo->ChannelInterruptFlags = 0;
    sinfo->CastTimeEntry = sSpellCastTimesStore.LookupEntry(1); //0
    sinfo->RangeEntry = sSpellRangeStore.LookupEntry(11); //15 yds
    sinfo->DurationEntry = sSpellDurationStore.LookupEntry(568); // 1250ms // (36); //1000ms
    sinfo->ExplicitTargetMask = TARGET_FLAG_UNIT;
    sinfo->Attributes |= SPELL_ATTR0_DO_NOT_LOG;
    sinfo->AttributesEx |= SPELL_ATTR1_NO_REFLECTION | SPELL_ATTR1_NO_REDIRECTION;
    sinfo->AttributesEx2 |= SPELL_ATTR2_CANT_CRIT;
    sinfo->AttributesEx3 |= SPELL_ATTR3_IGNORE_CASTER_MODIFIERS | SPELL_ATTR3_ALWAYS_HIT;
    sinfo->AttributesEx4 |= SPELL_ATTR4_IGNORE_DAMAGE_TAKEN_MODIFIERS;
    sinfo->AttributesCu &= ~(SPELL_ATTR0_CU_AURA_CC);

    sinfo->Effects[0].Effect = SPELL_EFFECT_HEALTH_LEECH;
    sinfo->Effects[0].ApplyAuraName = SPELL_AURA_NONE;
    sinfo->Effects[0].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[0].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[0].RadiusEntry = nullptr;
    sinfo->Effects[0].MiscValue = 0;
    sinfo->Effects[0].MiscValueB = 0;
    sinfo->Effects[0].BasePoints = 10;
    sinfo->Effects[0].Amplitude = 0;
    sinfo->Effects[0].RealPointsPerLevel = 0.0f;
    sinfo->Effects[0].DieSides = 25;
    sinfo->Effects[0].DamageMultiplier = 0.0f;
    sinfo->Effects[0].ValueMultiplier = 0.0f;
    sinfo->Effects[0].BonusMultiplier = 0.0f;

    sinfo->Effects[1].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[1].ApplyAuraName = SPELL_AURA_MOD_PACIFY_SILENCE;
    sinfo->Effects[1].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[1].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[1].RadiusEntry = nullptr;
    sinfo->Effects[1].MiscValue = 0;
    sinfo->Effects[1].MiscValueB = 0;
    sinfo->Effects[1].BasePoints = 1;
    sinfo->Effects[1].Amplitude = 0;
    sinfo->Effects[1].RealPointsPerLevel = 0.0f;
    sinfo->Effects[1].DieSides = 0;
    sinfo->Effects[1].DamageMultiplier = 0.0f;
    sinfo->Effects[1].ValueMultiplier = 0.0f;
    sinfo->Effects[1].BonusMultiplier = 0.0f;

    sinfo->Effects[2].Effect = SPELL_EFFECT_APPLY_AURA;
    sinfo->Effects[2].ApplyAuraName = SPELL_AURA_MOD_DECREASE_SPEED;
    sinfo->Effects[2].TargetA = SpellImplicitTargetInfo(TARGET_UNIT_TARGET_ENEMY);
    sinfo->Effects[2].TargetB = SpellImplicitTargetInfo(0);
    sinfo->Effects[2].Mechanic = MECHANIC_SNARE;
    sinfo->Effects[2].RadiusEntry = nullptr;
    sinfo->Effects[2].MiscValue = 0;
    sinfo->Effects[2].MiscValueB = 0;
    sinfo->Effects[2].BasePoints = -3;
    sinfo->Effects[2].Amplitude = 0;
    sinfo->Effects[2].RealPointsPerLevel = 0.0f;
    sinfo->Effects[2].DieSides = 0;
    sinfo->Effects[2].DamageMultiplier = 0.0f;
    sinfo->Effects[2].ValueMultiplier = 0.0f;
    sinfo->Effects[2].BonusMultiplier = 0.0f;
    //50) END SOUL BITE

    //51) ENERGIZE VISUAL
    spellId = SPELL_ENERGIZE_VISUAL; //59198
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);

    sinfo->SchoolMask = SPELL_SCHOOL_MASK_SHADOW;
    sinfo->SpellLevel = 1;
    sinfo->BaseLevel = 1;

    sinfo->Effects[0].Effect = SPELL_EFFECT_DUMMY;
    sinfo->Effects[0].BasePoints = 0;
    sinfo->Effects[0].DieSides = 0;
    //51) END ENERGIZE VISUAL


    //XX) FIXES
    spellId = 48155; // Mind Flay (Rank 8)
    botSpellInfoOverrides.insert({ spellId, *sSpellMgr->GetSpellInfo(spellId) });
    sinfo = &botSpellInfoOverrides.at(spellId);
    sinfo->InterruptFlags &= SPELL_INTERRUPT_FLAG_MOVEMENT;

    for (auto& p : botSpellInfoOverrides)
    {
        for (auto& eff : p.second.Effects)
        {
            eff.OverrideSpellInfo(&p.second);
        }
    }

    LOG_INFO("server.loading", ">> Bot spellInfo overrides generated for {} spells", uint32(botSpellInfoOverrides.size()));

    GenerateBotCustomSpellProcs();
}
