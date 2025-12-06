# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore
## mod-bg-reward
- Latest build status with azerothcore: [![Build Status](https://github.com/azerothcore/mod-bg-reward/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-bg-reward)


## Modules based WarheadCore module [mod-bg-reward](https://github.com/WarheadCore/WarheadCore/tree/master/modules/mod-bg-reward)

### Description:
If you win or lose on the battleground, you get an additional reward

### Configuration:
```ini
###################################################################################################
#	mod-bg-reward
#
#    BG.Reward.Enable
#        Description: Enable battleground reward system.
#        Default: 1
#
#    BG.Reward.ItemID.WSG
#        Description: Reward item on battleground Warsong Gulch.
#        Default: 20558
#
#    BG.Reward.ItemID.Arathi 
#        Description: Reward item on battleground Arathi Basin.
#        Default: 20559
#
#    BG.Reward.ItemID.Alterac
#        Description: Reward item on battleground Alterac Valley.
#        Default: 20560
#
#    BG.Reward.ItemID.Isle
#        Description: Reward item on battleground Isle of Conquest.
#        Default: 47395
#
#    BG.Reward.ItemID.Ancients
#        Description: Reward item on battleground Strand of the Ancients.
#        Default: 42425
#
#    BG.Reward.ItemID.Eye
#        Description: Reward item on battleground Eye of the Storm.
#        Default: 29024
#
#    BG.Reward.WinnerTeam.Count
#        Description: Reward item count battleground winner team.
#        Default: 3
#
#    BG.Reward.LoserTeam.Count
#        Description: Reward item count battleground looser team.
#        Default: 1
#

BGReward.Enable = 1
BGReward.ItemID.WSG = 20558
BGReward.ItemID.Arathi = 20559
BGReward.ItemID.Alterac = 20560
BGReward.ItemID.Isle = 47395
BGReward.ItemID.Ancients = 42425
BGReward.ItemID.Eye = 29024
BGReward.WinnerTeam.Count = 3
BGReward.LoserTeam.Count = 1
###################################################################################################
```

### How to use:
Change config and try to win or lose BG.
