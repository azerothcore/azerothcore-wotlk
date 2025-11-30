# Module Configuration Guide - Progressive Server

## 🎯 Configuration Strategy

### **Vision:**
- Solo play with bots is viable and fun
- Bots are good but real players are better
- Progressive difficulty scales properly
- No module conflicts

### **Key Decisions:**

1. **Solocraft: DISABLED** ❌
   - Conflicts with Autobalance
   - Our Progressive Systems handles scaling better
   - Autobalance is more flexible

2. **Autobalance: ENABLED & OPTIMIZED** ✅
   - Configured for solo-friendly scaling
   - Groups still get better rewards
   - Works with Progressive Systems

3. **Playerbots: ENABLED & ENHANCED** ✅
   - Better AI and behavior
   - Good gear and talents
   - But not as good as real players

---

## 📋 Module Status

### ✅ **Enabled & Configured:**

1. **mod-progressive-systems** - Core progression system
2. **mod-autobalance** - Solo/group scaling (replaces solocraft)
3. **mod-playerbots** - AI companions (enhanced)
4. **mod-eluna** - Lua scripting
5. **mod-transmog** - Visual customization
6. **mod-reward-shop** - Point spending
7. **mod-reward-played-time** - Time rewards
8. **mod-bg-reward** - PvP rewards
9. **mod-1v1-arena** - 1v1 PvP
10. **mod-arena-3v3-solo-queue** - Solo queue
11. **mod-account-achievements** - Account-wide achievements
12. **mod-account-mounts** - Account-wide mounts
13. **mod-character-tools** - Management tools
14. **mod-instance-reset** - Instance management (integrated into Progressive Systems)
15. **mod-learn-spells** - Auto-learn spells
16. **mod-npc-beastmaster** - Pet management
17. **mod-solo-lfg** - Solo LFG
18. **mod-random-enchants** - Item variety
19. **mod-premium** - Premium features
20. **mod-congrats-on-level** - Level rewards
21. **mod-gain-honor-guard** - Honor system

### ❌ **Disabled/Removed:**

1. **mod-solocraft** - DISABLED (conflicts with autobalance)
   - Set `Solocraft.Enable = 0` in config

### ⚠️ **Potentially Conflicting (Review Needed):**

1. **mod-instance-reset** - May conflict with Progressive Systems instance reset
   - **Solution:** Use Progressive Systems instance reset (more features)
   - Can disable mod-instance-reset if needed

2. **mod-azerothshard** - Large module with many sub-modules
   - Review for conflicts with Progressive Systems
   - May have duplicate features

---

## 🔧 Configuration Files

All config files have been pre-configured for the progressive vision:

1. **mod-progressive-systems.conf.dist** - Core progression
2. **mod-autobalance.conf.dist** - Solo/group scaling
3. **mod-playerbots.conf.dist** - Enhanced bots
4. **mod-solocraft.conf.dist** - DISABLED

---

## 📝 Next Steps

1. Copy all `.conf.dist` files to `etc/` directory
2. Review mod-azerothshard for conflicts
3. Test module interactions
4. Adjust configs based on gameplay feedback

---

## 🎮 Gameplay Balance

### Solo Play (with bots):
- Autobalance scales content to ~0.3-0.4x difficulty
- Bots provide good support
- Rewards: 1.2x XP and Money bonus
- Viable for all content

### Group Play (real players):
- Full difficulty (1.0x)
- Better coordination
- Group XP bonus (1.2x)
- More efficient clears
- **Still better than solo!**

### Bot Quality:
- Good gear (up to Rare quality)
- Proper talents and specs
- Smart AI behavior
- But: Real players have better coordination, strategy, and communication

