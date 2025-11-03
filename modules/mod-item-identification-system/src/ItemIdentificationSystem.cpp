#include "ItemIdentificationSystem.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "Item.h"
#include "Config.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "ItemTemplate.h"
#include "ObjectMgr.h"
#include "Log.h"
#include <vector>
#include <map>
#include <string>
#include <random>
#include <cstdarg>

// 模块集成 - 自动检测可用的模块并定义宏
// 使用 __has_include 检测头文件是否存在，避免依赖CMake宏定义
#if __has_include("ItemGrowthMgr.h")
    #ifndef MODULE_ITEM_GROWTH
        #define MODULE_ITEM_GROWTH
    #endif
    #include "ItemGrowthMgr.h"
    #if __has_include("ItemGrowthCommands.h")
        #include "ItemGrowthCommands.h"
    #endif
#endif

#if __has_include("ItemEnhancementMgr.h")
    #ifndef MODULE_ITEM_ENHANCEMENT
        #define MODULE_ITEM_ENHANCEMENT
    #endif
    #include "ItemEnhancementMgr.h"
#endif

#if __has_include("ItemAttributesGenerator.h")
    #ifndef MODULE_ITEM_ATTRIBUTES
        #define MODULE_ITEM_ATTRIBUTES
    #endif
    #include "ItemAttributesGenerator.h"
#endif

#if __has_include("RuneSystemMgr.h")
    #ifndef MODULE_RUNE_SYSTEM
        #define MODULE_RUNE_SYSTEM
    #endif
#endif

#ifdef MODULE_RUNE_SYSTEM
#include "RuneSystem.h"
#endif

#if __has_include("ItemSkillsManager.h")
    #ifndef MODULE_ITEM_SKILLS
        #define MODULE_ITEM_SKILLS
    #endif
    #include "ItemSkillsManager.h"
    #include "ItemSkillsDBHelper.h"
#endif

#ifdef MODULE_REQUIREMENT_TEMPLATE
#include "RequirementSystem.h"
#endif

#ifdef MODULE_ITEM_SETS
#include "ItemSets.h"
#endif

// 前向声明辅助函数
std::vector<uint32> ParseCommaSeparatedNumbers(const std::string& str);
uint32 SelectRandomFromList(const std::vector<uint32>& list);
uint32 GenerateRandomNumber(uint32 min, uint32 max);

// 单例实例
ItemIdentificationSystem* ItemIdentificationSystem::_instance = nullptr;

// 获取单例实例
ItemIdentificationSystem* ItemIdentificationSystem::instance()
{
    if (!_instance)
        _instance = new ItemIdentificationSystem();
    return _instance;
}

// 初始化系统
void ItemIdentificationSystem::Initialize()
{
    // 加载配置（在服务器完全启动后执行）
    LoadConfig(false);

    // 加载鉴定模板（在服务器完全启动后执行）
    LoadIdentificationTemplates();

    // 显示模块初始化信息
    if (_enabled)
    {

    }
    else
    {
        LOG_INFO("server.loading", "物品鉴定系统: 已禁用");
    }
}

// 加载配置
void ItemIdentificationSystem::LoadConfig(bool reload)
{
    _enabled = sConfigMgr->GetOption<bool>("ItemIdentificationSystem.Enable", true);
    _baseSuccessRate = sConfigMgr->GetOption<uint32>("ItemIdentificationSystem.BaseSuccessRate", 100);
    _destroyOnFail = sConfigMgr->GetOption<bool>("ItemIdentificationSystem.DestroyOnFail", false);
    _cost = sConfigMgr->GetOption<uint32>("ItemIdentificationSystem.Cost", 10000);
    _enableAnnounce = sConfigMgr->GetOption<bool>("ItemIdentificationSystem.EnableAnnounce", true);
    _debugMode = sConfigMgr->GetOption<bool>("ItemIdentificationSystem.Debug", false);

    if (reload)
    {
        LOG_INFO("server.loading", "物品鉴定系统配置已重新加载");
    }
}

// 鉴定模板结构
struct IdentificationTemplate
{
    uint32 id;
    uint32 group;
    uint32 level;
    uint32 randomChance;
    std::string comment;

    // 模块关联字段
    std::string itemGrowthGroups;
    std::string itemEnhancementGroups;
    std::string itemAttributesGroups;
    std::string itemAttributesAdditionalGroups;
    std::string itemSkillsGroups;
    std::string runeSystemGroups;
    std::string skillSetGroups;
    uint32 requirementTemplate;

    // 基础属性配置
    uint32 baseAttrMinCount;
    uint32 baseAttrMaxCount;
    uint32 baseAttrMinValue;
    uint32 baseAttrMaxValue;
    bool baseAttrAllowDuplicate;

    // 追加属性配置
    uint32 additionalAttrMinCount;
    uint32 additionalAttrMaxCount;
    uint32 additionalAttrMinValue;
    uint32 additionalAttrMaxValue;
    bool additionalAttrAllowDuplicate;

    // 追加技能配置
    uint32 additionalSkillMinCount;
    uint32 additionalSkillMaxCount;
    bool additionalSkillAllowDuplicate;

    // 符文配置
    uint32 runeSlotMinCount;
    uint32 runeSlotMaxCount;

    // 显示配置
    std::string qualityDisplay;
    std::string namePrefix;
    std::string nameSuffix;
    std::string nameColors;
    std::string bottomDescription;
    uint32 announcementTemplate;
};

// 存储所有鉴定模板
std::map<uint32, IdentificationTemplate> _identificationTemplates;

// 从数据库加载鉴定模板
void ItemIdentificationSystem::LoadIdentificationTemplates()
{
    DebugLog("正在加载物品鉴定模板...");
    _identificationTemplates.clear();

    QueryResult result = WorldDatabase.Query("SELECT * FROM 物品_鉴定系统");

    if (!result)
    {
       // LOG_WARN("server.loading", "物品鉴定系统: 未找到鉴定模板数据");
        return;
    }

    uint32 count = 0;
    std::set<uint32> groups;

    do
    {
        Field* fields = result->Fetch();
        IdentificationTemplate tmpl;

        // 字段顺序对应CREATE TABLE的实际顺序
        // 0:注释, 1:id, 2:组, 3:等级, 4:随机几率,
        // 5:物品成长_系统, 6:物品强化_系统, 7:物品属性_模板,
        // 8:基础属性最小数量, 9:基础属性最大数量, 10:基础最小属性值, 11:基础最大属性值, 12:基础属性允许重复,
        // 13:物品属性_模板_组, 14:追加属性最小数量, 15:追加属性最大数量, 16:追加属性最小值, 17:追加属性最大值, 18:追加属性允许重复,
        // 19:物品技能_模板_组, 20:追加技能最小数量, 21:追加技能最大数量, 22:追加技能允许重复,
        // 23:鉴定品质显示, 24:物品名字前缀, 25:物品名字后缀, 26:物品名字颜色, 27:物品底部描述,
        // 28:需求_模板, 29:符文系统_符文, 30:符文凹槽最小数量, 31:符文凹槽最大数量, 32:技能模板_套装_组, 33:公告模板

        tmpl.comment = fields[0].Get<std::string>();
        tmpl.id = fields[1].Get<uint32>();
        tmpl.group = fields[2].Get<uint32>();
        tmpl.level = fields[3].Get<uint32>();
        tmpl.randomChance = fields[4].Get<uint32>();

        // 模块关联字段
        tmpl.itemGrowthGroups = fields[5].Get<std::string>();                    // 物品成长_系统
        tmpl.itemEnhancementGroups = fields[6].Get<std::string>();              // 物品强化_系统
        tmpl.itemAttributesGroups = fields[7].Get<std::string>();               // 物品属性_模板（基础属性）

        // 基础属性配置
        tmpl.baseAttrMinCount = fields[8].Get<uint32>();                        // 基础属性最小数量
        tmpl.baseAttrMaxCount = fields[9].Get<uint32>();                        // 基础属性最大数量
        tmpl.baseAttrMinValue = fields[10].Get<uint32>();                       // 基础最小属性值
        tmpl.baseAttrMaxValue = fields[11].Get<uint32>();                       // 基础最大属性值
        tmpl.baseAttrAllowDuplicate = fields[12].Get<uint32>() == 0;            // 基础属性允许重复

        // 追加属性配置
        tmpl.itemAttributesAdditionalGroups = fields[13].Get<std::string>();    // 物品属性_模板_组（追加属性）
        tmpl.additionalAttrMinCount = fields[14].Get<uint32>();                 // 追加属性最小数量
        tmpl.additionalAttrMaxCount = fields[15].Get<uint32>();                 // 追加属性最大数量
        tmpl.additionalAttrMinValue = fields[16].Get<uint32>();                 // 追加属性最小值
        tmpl.additionalAttrMaxValue = fields[17].Get<uint32>();                 // 追加属性最大值
        tmpl.additionalAttrAllowDuplicate = fields[18].Get<uint32>() == 0;      // 追加属性允许重复

        // 追加技能配置
        tmpl.itemSkillsGroups = fields[19].Get<std::string>();                  // 物品技能_模板_组
        tmpl.additionalSkillMinCount = fields[20].Get<uint32>();                // 追加技能最小数量
        tmpl.additionalSkillMaxCount = fields[21].Get<uint32>();                // 追加技能最大数量
        tmpl.additionalSkillAllowDuplicate = fields[22].Get<uint32>() == 0;     // 追加技能允许重复

        // 显示配置
        tmpl.qualityDisplay = fields[23].Get<std::string>();                    // 鉴定品质显示
        tmpl.namePrefix = fields[24].Get<std::string>();                        // 物品名字前缀
        tmpl.nameSuffix = fields[25].Get<std::string>();                        // 物品名字后缀
        tmpl.nameColors = fields[26].Get<std::string>();                        // 物品名字颜色
        tmpl.bottomDescription = fields[27].Get<std::string>();                 // 物品底部描述

        // 其他配置
        tmpl.requirementTemplate = fields[28].Get<uint32>();                    // 需求_模板

        // 符文配置
        tmpl.runeSystemGroups = fields[29].Get<std::string>();                  // 符文系统_符文
        tmpl.runeSlotMinCount = fields[30].Get<uint32>();                       // 符文凹槽最小数量
        tmpl.runeSlotMaxCount = fields[31].Get<uint32>();                       // 符文凹槽最大数量

        // 套装配置
        tmpl.skillSetGroups = fields[32].Get<std::string>();                    // 技能模板_套装_组

        // 公告配置
        tmpl.announcementTemplate = fields[33].Get<uint32>();                   // 公告模板

        _identificationTemplates[tmpl.id] = tmpl;
        groups.insert(tmpl.group);
        count++;

        if (_debugMode)
        {
            DebugLog("加载鉴定模板: ID={}, 组={}, 等级={}, 注释='{}'",
                     tmpl.id, tmpl.group, tmpl.level, tmpl.comment);
        }

    } while (result->NextRow());

    LOG_INFO("server.loading", "物品鉴定系统: 已加载 {} 个鉴定模板 (共 {} 个组)", count, groups.size());
}

// 检查物品是否可以鉴定
bool ItemIdentificationSystem::CanIdentify(Player* player, Item* item, bool sendError)
{
    LOG_INFO("module", "【鉴定系统】开始CanIdentify检查");
    
    if (!_enabled)
    {
        LOG_INFO("module", "【鉴定系统】检查失败：系统未启用");
        if (sendError)
            ChatHandler(player->GetSession()).SendNotification("物品鉴定系统当前已禁用");
        return false;
    }

    if (!player || !item)
    {
        LOG_INFO("module", "【鉴定系统】检查失败：玩家或物品为空");
        return false;
    }

    LOG_INFO("module", "【鉴定系统】物品信息 - ID: {}, 名称: {}, 是否绑定: {}", 
             item->GetEntry(), item->GetTemplate()->Name1, item->IsSoulBound() ? "是" : "否");

    // 检查物品是否已绑定（改为允许绑定物品鉴定）
    // if (item->IsSoulBound())
    // {
    //     LOG_INFO("module", "【鉴定系统】检查失败：物品已绑定");
    //     if (sendError)
    //         ChatHandler(player->GetSession()).SendNotification("已绑定的物品无法鉴定");
    //     return false;
    // }

    // 检查物品是否可装备
    ItemTemplate const* proto = item->GetTemplate();
    if (!proto)
    {
        LOG_INFO("module", "【鉴定系统】检查失败：无法获取物品模板");
        return false;
    }
    
    LOG_INFO("module", "【鉴定系统】物品类型: {}", proto->Class);
    
    if (proto->Class != ITEM_CLASS_WEAPON && proto->Class != ITEM_CLASS_ARMOR)
    {
        LOG_INFO("module", "【鉴定系统】检查失败：物品类型不是武器或护甲");
        if (sendError)
            ChatHandler(player->GetSession()).SendNotification("只有武器和护甲可以鉴定");
        return false;
    }

    // 检查玩家金币是否足够
    uint32 playerMoney = player->GetMoney();
    LOG_INFO("module", "【鉴定系统】玩家金币: {}, 需要: {}", playerMoney, _cost);
    
    if (playerMoney < _cost)
    {
        LOG_INFO("module", "【鉴定系统】检查失败：金币不足");
        if (sendError)
            ChatHandler(player->GetSession()).SendNotification("你没有足够的金币进行鉴定");
        return false;
    }

    LOG_INFO("module", "【鉴定系统】所有检查通过");
    return true;
}

// 获取鉴定成功率
uint32 ItemIdentificationSystem::GetSuccessRate(Player* player, Item* item)
{
    // 直接使用配置文件中的基础成功率，不做任何调整
    uint32 successRate = _baseSuccessRate;
    LOG_INFO("module", "【成功率计算】使用配置文件成功率: {}%", successRate);

    // 确保成功率在合理范围内
    if (successRate < 1)
        successRate = 1;
    if (successRate > 100)
        successRate = 100;

    return successRate;
}

// 鉴定物品（需要指定组ID）
bool ItemIdentificationSystem::IdentifyItem(Player* player, Item* item, uint32 groupId)
{
    LOG_INFO("module", "【鉴定系统】===== IdentifyItem开始 =====");
    LOG_INFO("module", "【鉴定系统】参数检查 - 玩家: {}, 物品ID: {}, 组ID: {}", 
             player ? player->GetName() : "NULL", item ? item->GetEntry() : 0, groupId);
    
    if (!CanIdentify(player, item))
    {
        LOG_INFO("module", "【鉴定系统】CanIdentify检查失败");
        return false;
    }

    LOG_INFO("module", "【鉴定系统】CanIdentify检查通过");
    LOG_INFO("module", "【鉴定系统】开始鉴定物品，组ID: {}, 物品ID: {}", groupId, item->GetEntry());

    // 扣除金币
    LOG_INFO("module", "【鉴定系统】准备扣除金币: {} 铜币", _cost);
    player->ModifyMoney(-static_cast<int32>(_cost));
    ChatHandler(player->GetSession()).SendNotification("已扣除 {} 铜币用于鉴定", _cost);
    LOG_INFO("module", "【鉴定系统】金币已扣除");

    // 计算成功率
    LOG_INFO("module", "【鉴定系统】开始计算成功率");
    uint32 successRate = GetSuccessRate(player, item);
    LOG_INFO("module", "【鉴定系统】成功率: {}%", successRate);

    // 随机决定是否成功
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(1, 100);
    uint32 roll = dis(gen);
    bool success = roll <= successRate;
    
    LOG_INFO("module", "【鉴定系统】随机结果: {}, 成功率: {}, 是否成功: {}", roll, successRate, success ? "是" : "否");

    if (success)
    {
        LOG_INFO("module", "【鉴定系统】鉴定判定成功，开始应用鉴定效果");
        
        // 鉴定成功
        bool applyResult = ApplyIdentification(player, item, groupId);
        LOG_INFO("module", "【鉴定系统】ApplyIdentification返回: {}", applyResult ? "成功" : "失败");
        
        if (applyResult)
        {
            LOG_INFO("module", "【鉴定系统】鉴定效果应用成功");
            ChatHandler(player->GetSession()).SendNotification("物品鉴定成功！");

            // 发送公告（暂时禁用，避免API兼容性问题）
            if (_enableAnnounce)
            {
                // TODO: 实现全服公告功能
                LOG_INFO("module", "【鉴定系统】玩家 {} 成功鉴定了 {}", player->GetName(), item->GetTemplate()->Name1);
            }

            return true;
        }
        else
        {
            // 应用鉴定失败
            ChatHandler(player->GetSession()).SendSysMessage("鉴定失败：无法应用鉴定效果");
            return false;
        }
    }
    else
    {
        // 鉴定失败
        ChatHandler(player->GetSession()).SendNotification("鉴定失败！");

        // 是否销毁物品
        if (_destroyOnFail)
        {
            player->DestroyItem(item->GetBagSlot(), item->GetSlot(), true);
            ChatHandler(player->GetSession()).SendNotification("物品已被销毁");
        }

        return false;
    }
}

// 根据组ID和物品ID随机选择一个鉴定模板（根据几率加权）
uint32 ItemIdentificationSystem::SelectIdentificationTemplate(uint32 groupId, Item* item)
{
    LOG_INFO("module", "【鉴定系统】选择模板：组ID={}, 物品ID={}", groupId, item->GetEntry());

    // 查询指定组ID的所有模板（不考虑装备等级，只按组ID筛选）
    std::string query = "SELECT id, 组, 等级, 随机几率 FROM 物品_鉴定系统 WHERE 组 = " +
                        std::to_string(groupId);

    LOG_INFO("module", "【鉴定系统】SQL查询: {}", query);

    QueryResult result = WorldDatabase.Query(query.c_str());
    if (!result)
    {
        LOG_INFO("module", "【鉴定系统】未找到匹配的模板，组ID={}", groupId);
        return 0; // 返回0表示未找到
    }

    // 根据随机几率选择模板
    std::vector<std::pair<uint32, uint32>> templates; // <模板ID, 几率>
    uint32 totalChance = 0;

    do
    {
        Field* fields = result->Fetch();
        uint32 id = fields[0].Get<uint32>();
        uint32 chance = fields[3].Get<uint32>(); // 随机几率字段

        templates.push_back(std::make_pair(id, chance));
        totalChance += chance;
        LOG_INFO("module", "【鉴定系统】找到模板ID: {}, 几率: {}", id, chance);
    } while (result->NextRow());

    LOG_INFO("module", "【鉴定系统】总几率: {}, 模板数量: {}", totalChance, templates.size());

    if (templates.empty() || totalChance == 0)
    {
        LOG_INFO("module", "【鉴定系统】模板列表为空或总几率为0");
        return 0;
    }

    // 随机选择一个模板
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(1, totalChance);
    uint32 roll = dis(gen);

    LOG_INFO("module", "【鉴定系统】随机结果: {}", roll);

    uint32 currentChance = 0;
    for (auto& pair : templates)
    {
        currentChance += pair.second;
        if (roll <= currentChance)
        {
            LOG_INFO("module", "【鉴定系统】选中模板ID: {}", pair.first);
            return pair.first;
        }
    }

    // 如果出现问题，返回第一个模板
    LOG_INFO("module", "【鉴定系统】默认选择第一个模板ID: {}", templates[0].first);
    return templates[0].first;
}

// 应用鉴定结果到物品（需要指定组ID）
bool ItemIdentificationSystem::ApplyIdentification(Player* player, Item* item, uint32 groupId)
{
    // 获取选择的模板ID
    uint32 templateId = SelectIdentificationTemplate(groupId, item);
    if (!templateId || _identificationTemplates.find(templateId) == _identificationTemplates.end())
    {
        LOG_INFO("module", "【鉴定系统】未找到鉴定模板ID: {}", templateId);
        return false;
    }

    const IdentificationTemplate& tmpl = _identificationTemplates[templateId];

    LOG_INFO("module", "【鉴定流程】===== 开始应用鉴定模板 =====");
    LOG_INFO("module", "【鉴定流程】模板ID: {}", templateId);
    LOG_INFO("module", "【鉴定流程】物品ID: {}, 物品名称: {}", item->GetEntry(), item->GetTemplate()->Name1);
    LOG_INFO("module", "【鉴定流程】模板配置 - 成长组: '{}'", tmpl.itemGrowthGroups);
    LOG_INFO("module", "【鉴定流程】模板配置 - 强化组: '{}'", tmpl.itemEnhancementGroups);
    LOG_INFO("module", "【鉴定流程】模板配置 - 属性组: '{}'", tmpl.itemAttributesGroups);

    // 0. 检查物品是否已鉴定（防止重复鉴定）
    uint32 itemGuid = item->GetGUID().GetCounter();
    if (IsItemIdentified(itemGuid))
    {
        DebugLog("物品已经被鉴定过了: GUID={}", itemGuid);
        ChatHandler(player->GetSession()).SendSysMessage("此物品已经鉴定过了");
        return false;
    }

    // 1. 检查需求条件
    if (!CheckRequirements(player, item, tmpl))
    {
        DebugLog("玩家不满足鉴定需求条件");
        return false;
    }

    // 创建鉴定记录
    ItemIdentificationRecord record;
    record.playerGuid = player->GetGUID().GetCounter();
    record.itemGuid = itemGuid;
    record.itemEntry = item->GetEntry();
    record.templateId = templateId;
    record.costGold = _cost;
    record.successRate = GetSuccessRate(player, item);
    
    // 初始化所有标记为false
    record.hasGrowth = false;
    record.hasEnhancement = false;
    record.hasBaseAttributes = false;
    record.hasAdditionalAttributes = false;
    record.hasRuneSlots = false;
    record.hasSkills = false;
    record.hasSet = false;

    // 2. 应用物品成长系统
    LOG_INFO("module", "【鉴定流程】步骤2：检查成长系统配置");
    LOG_INFO("module", "【鉴定流程】成长组配置: '{}'", tmpl.itemGrowthGroups);
    LOG_INFO("module", "【鉴定流程】配置是否为空: {}", tmpl.itemGrowthGroups.empty() ? "是" : "否");
    
    if (!tmpl.itemGrowthGroups.empty())
    {
        LOG_INFO("module", "【鉴定流程】开始调用ApplyItemGrowth");
        uint32 appliedGroup = ApplyItemGrowth(player, item, tmpl);
        LOG_INFO("module", "【鉴定流程】ApplyItemGrowth返回值: {}", appliedGroup);
        
        if (appliedGroup > 0)
        {
            record.hasGrowth = true;
            record.growthGroup = appliedGroup; // 使用实际应用的组号
            LOG_INFO("module", "【鉴定流程】成长系统应用成功，组号: {}", appliedGroup);
        }
        else
        {
            LOG_INFO("module", "【鉴定流程】成长系统应用失败，返回值为0");
        }
    }
    else
    {
        LOG_INFO("module", "【鉴定流程】成长组配置为空，跳过成长系统");
    }

    // 3. 应用物品强化系统
    LOG_INFO("module", "【鉴定流程】步骤3：检查强化系统配置");
    LOG_INFO("module", "【鉴定流程】强化组配置: '{}'", tmpl.itemEnhancementGroups);
    LOG_INFO("module", "【鉴定流程】配置是否为空: {}", tmpl.itemEnhancementGroups.empty() ? "是" : "否");
    
    if (!tmpl.itemEnhancementGroups.empty())
    {
        LOG_INFO("module", "【鉴定流程】开始调用ApplyItemEnhancement");
        uint32 appliedGroup = ApplyItemEnhancement(player, item, tmpl);
        LOG_INFO("module", "【鉴定流程】ApplyItemEnhancement返回值: {}", appliedGroup);
        
        if (appliedGroup > 0)
        {
            record.hasEnhancement = true;
            record.enhancementGroup = appliedGroup; // 使用实际应用的组号
            LOG_INFO("module", "【鉴定流程】强化系统应用成功，组号: {}", appliedGroup);
        }
        else
        {
            LOG_INFO("module", "【鉴定流程】强化系统应用失败，返回值为0");
        }
    }
    else
    {
        LOG_INFO("module", "【鉴定流程】强化组配置为空，跳过强化系统");
    }

    // 4. 应用基础属性
    if (!tmpl.itemAttributesGroups.empty() && tmpl.baseAttrMaxCount > 0)
    {
        ApplyBaseAttributes(player, item, tmpl);
        record.hasBaseAttributes = true;
        record.baseAttrCount = GenerateRandomNumber(tmpl.baseAttrMinCount, tmpl.baseAttrMaxCount);
        record.baseAttrGroup = SelectRandomFromList(ParseCommaSeparatedNumbers(tmpl.itemAttributesGroups));
    }

    // 5. 应用追加属性
    if (!tmpl.itemAttributesAdditionalGroups.empty() && tmpl.additionalAttrMaxCount > 0)
    {
        ApplyAdditionalAttributes(player, item, tmpl);
        record.hasAdditionalAttributes = true;
        record.additionalAttrCount = GenerateRandomNumber(tmpl.additionalAttrMinCount, tmpl.additionalAttrMaxCount);
        record.additionalAttrGroups = tmpl.itemAttributesAdditionalGroups;
    }

    // 6. 应用追加技能
    if (!tmpl.itemSkillsGroups.empty() && tmpl.additionalSkillMaxCount > 0)
    {
        ApplyAdditionalSkills(player, item, tmpl);
        record.hasSkills = true;
        record.skillGroups = tmpl.itemSkillsGroups;
    }

    // 7. 应用符文系统
    if (!tmpl.runeSystemGroups.empty() || tmpl.runeSlotMaxCount > 0)
    {
        ApplyRuneSystem(player, item, tmpl);
        record.hasRuneSlots = true;
        record.runeSlotCount = GenerateRandomNumber(tmpl.runeSlotMinCount, tmpl.runeSlotMaxCount);
    }

    // 8. 应用技能套装
    if (!tmpl.skillSetGroups.empty())
    {
        ApplySkillSets(player, item, tmpl);
        record.hasSet = true;
        record.setGroup = SelectRandomFromList(ParseCommaSeparatedNumbers(tmpl.skillSetGroups));
        record.setId = 0; // 套装系统会分配具体的套装ID
    }

    // 9. 应用名称和描述
    ApplyNameAndDescription(item, tmpl);

    // 10. 将物品绑定到玩家
    item->SetBinding(true);

    // 11. 更新物品状态
    item->SetState(ITEM_CHANGED, player);

    // 12. 保存鉴定记录到数据库
    SaveIdentificationRecord(record);

    // 13. 刷新物品显示
    RefreshItem(player, item);

    DebugLog("成功应用鉴定模板到物品，记录已保存");
    return true;
}

// 工具方法：解析逗号分隔的字符串为数字列表
std::vector<uint32> ParseCommaSeparatedNumbers(const std::string& str)
{
    std::vector<uint32> result;
    if (str.empty())
    {
        LOG_INFO("module", "【解析工具】输入字符串为空");
        return result;
    }

    LOG_INFO("module", "【解析工具】开始解析字符串: '{}'", str);
    
    std::stringstream ss(str);
    std::string item;
    while (std::getline(ss, item, ','))
    {
        if (!item.empty())
        {
            try {
                uint32 num = std::stoul(item);
                result.push_back(num);
                LOG_INFO("module", "【解析工具】解析到数字: {}", num);
            } catch (...) {
                LOG_INFO("module", "【解析工具】解析失败，无效字符串: '{}'", item);
            }
        }
    }
    
    LOG_INFO("module", "【解析工具】解析完成，共{}个数字", result.size());
    return result;
}

// 工具方法：从列表中随机选择一个元素
uint32 SelectRandomFromList(const std::vector<uint32>& list)
{
    if (list.empty()) return 0;

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(0, list.size() - 1);
    return list[dis(gen)];
}

// 工具方法：生成指定范围内的随机数
uint32 GenerateRandomNumber(uint32 min, uint32 max)
{
    if (min >= max) return min;

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(min, max);
    return dis(gen);
}

// 检查需求条件
bool ItemIdentificationSystem::CheckRequirements(Player* player, Item* item, const IdentificationTemplate& tmpl)
{
    if (tmpl.requirementTemplate == 0)
        return true;

    DebugLog("检查需求模板ID: {}", tmpl.requirementTemplate);

#ifdef MODULE_REQUIREMENT_TEMPLATE
    // 调用需求模板系统检查条件
    if (sRequirementTemplateMgr)
    {
        bool meetsRequirements = sRequirementTemplateMgr->CheckRequirements(player, tmpl.requirementTemplate, true);
        
        if (meetsRequirements)
        {
            DebugLog("玩家满足需求模板ID: {}", tmpl.requirementTemplate);
        }
        else
        {
            DebugLog("玩家不满足需求模板ID: {}", tmpl.requirementTemplate);
            ChatHandler(player->GetSession()).PSendSysMessage("不满足鉴定条件");
        }
        
        return meetsRequirements;
    }
    else
    {
        DebugLog("需求模板系统不可用");
    }
#else
    DebugLog("需求模板系统模块未编译");
#endif

    // 如果没有需求系统或系统不可用，默认返回true
    return true;
}

// 应用物品成长系统（返回实际应用的组号，0表示失败）
uint32 ItemIdentificationSystem::ApplyItemGrowth(Player* player, Item* item, const IdentificationTemplate& tmpl)
{
    LOG_INFO("module", "【成长系统】===== 开始应用物品成长系统 =====");
    LOG_INFO("module", "【成长系统】物品ID: {}, 物品名称: {}", item->GetEntry(), item->GetTemplate()->Name1);
    LOG_INFO("module", "【成长系统】原始配置字符串: '{}'", tmpl.itemGrowthGroups);
    
    std::vector<uint32> growthGroups = ParseCommaSeparatedNumbers(tmpl.itemGrowthGroups);
    LOG_INFO("module", "【成长系统】解析后的组数量: {}", growthGroups.size());
    
    if (growthGroups.empty())
    {
        LOG_INFO("module", "【成长系统】组列表为空，退出");
        return 0;
    }

    LOG_INFO("module", "【成长系统】组列表内容: {}", tmpl.itemGrowthGroups);

#ifdef MODULE_ITEM_GROWTH
    LOG_INFO("module", "【成长系统】检查成长系统模块状态");
    LOG_INFO("module", "【成长系统】sItemGrowthMgr指针: {}", sItemGrowthMgr ? "有效" : "空");
    
    if (!sItemGrowthMgr)
    {
        LOG_INFO("module", "【成长系统】错误：sItemGrowthMgr为空指针");
        return 0;
    }
    
    LOG_INFO("module", "【成长系统】成长系统是否启用: {}", sItemGrowthMgr->IsEnabled() ? "是" : "否");
    
    if (!sItemGrowthMgr->IsEnabled())
    {
        LOG_INFO("module", "【成长系统】成长系统未启用");
        return 0;
    }

    // 随机选择一个成长组
    uint32 selectedGroup = SelectRandomFromList(growthGroups);
    LOG_INFO("module", "【成长系统】从组列表中选择的组: {}", selectedGroup);
    
    if (selectedGroup == 0)
    {
        LOG_INFO("module", "【成长系统】错误：选择的组号为0");
        return 0;
    }

    // 直接调用成长系统API设置物品成长属性
    LOG_INFO("module", "【成长系统】开始调用sItemGrowthMgr->SetItemCanGrow");
    LOG_INFO("module", "【成长系统】参数 - 玩家: {}, 物品ID: {}, 属性组: {}", player->GetName(), item->GetEntry(), selectedGroup);
    
    try
    {
        // 使用成长系统的API设置物品可成长，并指定属性组
        sItemGrowthMgr->SetItemCanGrow(player, item, selectedGroup);
        LOG_INFO("module", "【成长系统】✅ 成长系统应用成功！组号: {}", selectedGroup);
        ChatHandler(player->GetSession()).PSendSysMessage("物品获得成长属性（组{}）", selectedGroup);
        return selectedGroup; // 返回实际应用的组号
    }
    catch (...)
    {
        LOG_INFO("module", "【成长系统】❌ 成长系统应用时发生异常");
        return 0;
    }
#else
    LOG_INFO("module", "【成长系统】错误：MODULE_ITEM_GROWTH未定义，成长系统模块未编译");
    return 0;
#endif
}

// 应用物品强化系统（返回实际应用的组号，0表示失败）
uint32 ItemIdentificationSystem::ApplyItemEnhancement(Player* player, Item* item, const IdentificationTemplate& tmpl)
{
    LOG_INFO("module", "【强化系统】===== 开始应用物品强化系统 =====" );
    LOG_INFO("module", "【强化系统】物品ID: {}, 物品名称: {}", item->GetEntry(), item->GetTemplate()->Name1);
    LOG_INFO("module", "【强化系统】原始配置字符串: '{}'", tmpl.itemEnhancementGroups);
    
    std::vector<uint32> enhancementGroups = ParseCommaSeparatedNumbers(tmpl.itemEnhancementGroups);
    LOG_INFO("module", "【强化系统】解析后的组数量: {}", enhancementGroups.size());
    
    if (enhancementGroups.empty())
    {
        LOG_INFO("module", "【强化系统】组列表为空，退出");
        return 0;
    }

    LOG_INFO("module", "【强化系统】组列表内容: {}", tmpl.itemEnhancementGroups);

#ifdef MODULE_ITEM_ENHANCEMENT
    LOG_INFO("module", "【强化系统】检查强化系统模块状态");
    LOG_INFO("module", "【强化系统】sItemEnhancementMgr指针: {}", sItemEnhancementMgr ? "有效" : "空");
    
    if (!sItemEnhancementMgr)
    {
        LOG_INFO("module", "【强化系统】错误：sItemEnhancementMgr为空指针");
        return 0;
    }
    
    LOG_INFO("module", "【强化系统】强化系统是否启用: {}", sItemEnhancementMgr->IsEnabled() ? "是" : "否");
    
    if (!sItemEnhancementMgr->IsEnabled())
    {
        LOG_INFO("module", "【强化系统】强化系统未启用");
        return 0;
    }

    // 随机选择一个强化组
    uint32 selectedGroup = SelectRandomFromList(enhancementGroups);
    LOG_INFO("module", "【强化系统】从组列表中选择的组: {}", selectedGroup);
    
    if (selectedGroup == 0)
    {
        LOG_INFO("module", "【强化系统】错误：选择的组号为0");
        return 0;
    }

    // 检查物品是否可以强化
    if (!sItemEnhancementMgr->CanEnhanceItem(player, item))
    {
        LOG_INFO("module", "【强化系统】物品无法强化");
        return 0;
    }

    // 创建强化记录
    LOG_INFO("module", "【强化系统】开始调用sItemEnhancementMgr->EnhanceItem");
    LOG_INFO("module", "【强化系统】参数 - 玩家: {}, 物品ID: {}, 选择组: {}", player->GetName(), item->GetEntry(), selectedGroup);
    
    try
    {
        // 调用强化系统API，传递组号参数
        if (sItemEnhancementMgr->EnhanceItem(player, item, selectedGroup))
        {
            LOG_INFO("module", "【强化系统】✅ 强化系统应用成功！组号: {}, 等级: 1", selectedGroup);
            ChatHandler(player->GetSession()).PSendSysMessage("物品获得强化属性（组{}）", selectedGroup);
            return selectedGroup; // 返回选择的组号
        }
        else
        {
            LOG_INFO("module", "【强化系统】❌ 强化系统应用失败");
            return 0;
        }
    }
    catch (...)
    {
        LOG_INFO("module", "【强化系统】❌ 强化系统应用时发生异常");
        return 0;
    }
#else
    LOG_INFO("module", "【强化系统】错误：MODULE_ITEM_ENHANCEMENT未定义，强化系统模块未编译");
    return 0;
#endif
}

// 应用基础属性
void ItemIdentificationSystem::ApplyBaseAttributes(Player* player, Item* item, const IdentificationTemplate& tmpl)
{
    std::vector<uint32> attributeGroups = ParseCommaSeparatedNumbers(tmpl.itemAttributesGroups);
    if (attributeGroups.empty()) return;

    uint32 attrCount = GenerateRandomNumber(tmpl.baseAttrMinCount, tmpl.baseAttrMaxCount);
    if (attrCount == 0) return;

    DebugLog("应用基础属性，组列表: {}，数量: {}", tmpl.itemAttributesGroups, attrCount);

#ifdef MODULE_ITEM_ATTRIBUTES
    if (sItemAttributesGenerator)
    {
        // 随机选择一个属性组
        uint32 selectedGroup = SelectRandomFromList(attributeGroups);
        
        // 构建属性生成选项
        ItemAttributeGenerateOptions options;
        options.minAttributes = attrCount;
        options.maxAttributes = attrCount;
        options.attributeGroup = selectedGroup;
        options.minItemLevel = 0;
        options.maxItemLevel = 1000;
        options.respectChance = true;
        options.allowDuplicateTypes = tmpl.baseAttrAllowDuplicate;
        
        // 生成随机属性
        if (sItemAttributesGenerator->GenerateRandomAttributes(item, options))
        {
            DebugLog("成功应用基础属性组: {}，数量: {}", selectedGroup, attrCount);
            ChatHandler(player->GetSession()).PSendSysMessage("物品获得{}个基础属性", attrCount);
        }
        else
        {
            DebugLog("基础属性应用失败");
        }
    }
    else
    {
        DebugLog("属性生成器不可用");
    }
#else
    DebugLog("属性系统模块未编译");
#endif
}

// 应用追加属性
void ItemIdentificationSystem::ApplyAdditionalAttributes(Player* player, Item* item, const IdentificationTemplate& tmpl)
{
    std::vector<uint32> attributeGroups = ParseCommaSeparatedNumbers(tmpl.itemAttributesAdditionalGroups);
    if (attributeGroups.empty()) return;

    uint32 attrCount = GenerateRandomNumber(tmpl.additionalAttrMinCount, tmpl.additionalAttrMaxCount);
    if (attrCount == 0) return;

    DebugLog("应用追加属性，组列表: {}，数量: {}", tmpl.itemAttributesAdditionalGroups, attrCount);

#ifdef MODULE_ITEM_ATTRIBUTES
    if (sItemAttributesGenerator)
    {
        // 按顺序从每个组应用一个属性
        uint32 appliedCount = 0;
        for (uint32 i = 0; i < attrCount && i < attributeGroups.size(); ++i)
        {
            uint32 groupId = attributeGroups[i];
            
            // 构建属性生成选项
            ItemAttributeGenerateOptions options;
            options.minAttributes = 1;
            options.maxAttributes = 1;
            options.attributeGroup = groupId;
            options.minItemLevel = 0;
            options.maxItemLevel = 1000;
            options.respectChance = true;
            options.allowDuplicateTypes = tmpl.additionalAttrAllowDuplicate;
            
            // 生成属性
            if (sItemAttributesGenerator->GenerateRandomAttributes(item, options))
            {
                appliedCount++;
                DebugLog("成功应用追加属性组: {}", groupId);
            }
        }
        
        if (appliedCount > 0)
        {
            ChatHandler(player->GetSession()).PSendSysMessage("物品获得{}个追加属性", appliedCount);
        }
    }
    else
    {
        DebugLog("属性生成器不可用");
    }
#else
    DebugLog("属性系统模块未编译");
#endif
}

// 应用追加技能
void ItemIdentificationSystem::ApplyAdditionalSkills(Player* player, Item* item, const IdentificationTemplate& tmpl)
{
    std::vector<uint32> skillGroups = ParseCommaSeparatedNumbers(tmpl.itemSkillsGroups);
    if (skillGroups.empty()) return;

    uint32 skillCount = GenerateRandomNumber(tmpl.additionalSkillMinCount, tmpl.additionalSkillMaxCount);
    if (skillCount == 0) return;

    DebugLog("应用追加技能，组列表: {}，数量: {}", tmpl.itemSkillsGroups, skillCount);

#ifdef MODULE_ITEM_SKILLS
    if (sItemSkillsManager && sItemSkillsDBHelper)
    {
        uint32 appliedCount = 0;
        uint32 itemId = item->GetEntry();

        // 从配置的技能组中选择技能并应用到物品
        for (uint32 i = 0; i < skillCount && i < skillGroups.size(); ++i)
        {
            uint32 groupId = skillGroups[i];

            // 从指定的技能组中按权重随机选择一个技能
            ItemSkillTemplate const* skillTemplate = sItemSkillsManager->SelectSkillByWeight(itemId, groupId);

            if (skillTemplate)
            {
                // 将技能添加到物品
                sItemSkillsDBHelper->AddSkillToItem(item, skillTemplate->id);
                appliedCount++;
                DebugLog("成功应用技能组: {}，技能模板ID: {}, 技能ID: {}", groupId, skillTemplate->id, skillTemplate->spellId);
            }
            else
            {
                DebugLog("从技能组{}中未找到合适的技能", groupId);
            }
        }

        if (appliedCount > 0)
        {
            ChatHandler(player->GetSession()).PSendSysMessage("物品获得{}个技能效果", appliedCount);
        }
        else
        {
            DebugLog("未成功应用任何技能");
        }
    }
    else
    {
        DebugLog("技能系统或数据库辅助类不可用");
    }
#else
    DebugLog("技能系统模块未编译");
#endif
}

// 应用符文系统
void ItemIdentificationSystem::ApplyRuneSystem(Player* player, Item* item, const IdentificationTemplate& tmpl)
{
#ifdef MODULE_RUNE_SYSTEM
    if (sRuneManager)
    {
        // 创建符文凹槽
        if (tmpl.runeSlotMaxCount > 0)
        {
            uint32 slotCount = GenerateRandomNumber(tmpl.runeSlotMinCount, tmpl.runeSlotMaxCount);

            if (slotCount > 0)
            {
                DebugLog("尝试为物品创建{}个符文凹槽", slotCount);

                if (sRuneManager->AddRuneSlotToItem(item, slotCount))
                {
                    DebugLog("成功为物品创建{}个符文凹槽", slotCount);
                    ChatHandler(player->GetSession()).PSendSysMessage("物品获得{}个符文凹槽", slotCount);
                }
                else
                {
                    DebugLog("创建符文凹槽失败");
                }
            }
        }

        // 记录符文组信息（符文组配置用于玩家自行选择镶嵌的符文）
        std::vector<uint32> runeGroups = ParseCommaSeparatedNumbers(tmpl.runeSystemGroups);
        if (!runeGroups.empty())
        {
            DebugLog("物品符文组配置: {}（玩家可以使用这些组中的符文进行镶嵌）", tmpl.runeSystemGroups);
            // 注意：当前符文系统设计中，玩家需要自行镶嵌符文
            // 符文组信息可用于提示玩家可以使用哪些符文
            ChatHandler(player->GetSession()).PSendSysMessage("物品可以镶嵌符文（推荐符文组: {}）", tmpl.runeSystemGroups);
        }
    }
    else
    {
        DebugLog("符文系统不可用");
    }
#else
    DebugLog("符文系统模块未编译");
#endif
}

// 应用技能套装
void ItemIdentificationSystem::ApplySkillSets(Player* player, Item* item, const IdentificationTemplate& tmpl)
{
    std::vector<uint32> skillSetGroups = ParseCommaSeparatedNumbers(tmpl.skillSetGroups);
    if (skillSetGroups.empty()) return;

    // 随机选择一个套装组
    uint32 selectedGroup = SelectRandomFromList(skillSetGroups);
    DebugLog("应用技能套装组: {}", selectedGroup);

#ifdef MODULE_ITEM_SETS
    if (sItemSetsManager)
    {
        // 调用套装系统API为物品分配套装
        // AssignRandomSetToItem会从指定的套装组中随机选择一个套装分配给物品
        uint32 itemId = item->GetEntry();
        
        // 注意：这里需要先调用GetRandomSetForGroup获取具体的套装ID
        // 然后将物品标记为该套装的一部分
        uint32 selectedSetId = sItemSetsManager->GetRandomSetForGroup(selectedGroup, player);
        
        if (selectedSetId > 0)
        {
            // 使用AssignRandomSetToItem方法将物品分配到套装
            // 该方法会自动处理物品GUID存储和套装关联
            if (sItemSetsManager->AssignRandomSetToItem(player, itemId, 0))
            {
                DebugLog("成功将物品分配到套装组: {}，套装ID: {}", selectedGroup, selectedSetId);
                ChatHandler(player->GetSession()).PSendSysMessage("物品获得套装属性（组{}）", selectedGroup);
                
                // 立即刷新玩家的套装效果
                sItemSetsManager->RefreshPlayerSetEffects(player);
            }
            else
            {
                DebugLog("套装分配失败");
            }
        }
        else
        {
            DebugLog("从套装组{}中未找到合适的套装", selectedGroup);
        }
    }
    else
    {
        DebugLog("套装系统不可用");
    }
#else
    DebugLog("套装系统模块未编译");
#endif
}

// 应用名称和描述
void ItemIdentificationSystem::ApplyNameAndDescription(Item* item, const IdentificationTemplate& tmpl)
{
    if (!item)
        return;

    DebugLog("应用名称和描述到物品: {}", item->GetEntry());

    // 在AzerothCore中，物品的名称显示受到限制
    // 我们通过以下方式记录和处理自定义名称和描述：

    // 1. 构建完整的自定义名称
    std::string customName;
    if (!tmpl.namePrefix.empty())
    {
        customName += tmpl.namePrefix;
        DebugLog("添加名称前缀: {}", tmpl.namePrefix);
    }

    // 原始物品名称
    ItemTemplate const* proto = item->GetTemplate();
    if (proto)
    {
        if (!customName.empty())
            customName += " ";
        customName += proto->Name1;
    }

    if (!tmpl.nameSuffix.empty())
    {
        if (!customName.empty())
            customName += " ";
        customName += tmpl.nameSuffix;
        DebugLog("添加名称后缀: {}", tmpl.nameSuffix);
    }

    DebugLog("最终物品名称: {}", customName);

    // 2. 构建完整的描述信息（包括品质显示和底部描述）
    std::string fullDescription;

    if (!tmpl.qualityDisplay.empty())
    {
        fullDescription += "[" + tmpl.qualityDisplay + "]";
        DebugLog("添加品质显示: {}", tmpl.qualityDisplay);
    }

    if (!tmpl.bottomDescription.empty())
    {
        if (!fullDescription.empty())
            fullDescription += " ";
        fullDescription += tmpl.bottomDescription;
        DebugLog("添加底部描述: {}", tmpl.bottomDescription);
    }

    // 3. 记录颜色信息（用于客户端显示或其他用途）
    if (!tmpl.nameColors.empty())
    {
        DebugLog("物品名称颜色配置: {}", tmpl.nameColors);
        // 颜色信息可以在客户端显示时使用
        // 格式例如：|cffff00ff,|cffff0080 表示多种颜色
    }

    DebugLog("完整物品信息 - 名称: '{}', 描述: '{}'", customName, fullDescription);

    // 4. 在AzerothCore中，如果需要永久保存这些信息，可以：
    //    - 将其保存到item_instance表的text_0-text_1字段（如果这些字段存在）
    //    - 或创建一个自定义表来存储这些信息
    //    - 或使用物品的flags_custom字段来标记这是一个已鉴定的物品

    // 标记物品为已鉴定（可选，使用自定义标志位）
    // item->SetUInt32Value(ITEM_FIELD_FLAGS_CUSTOM, item->GetUInt32Value(ITEM_FIELD_FLAGS_CUSTOM) | 0x01);

    DebugLog("物品名称和描述应用完成");
}

// 处理鉴定失败
void ItemIdentificationSystem::HandleFailure(Player* player, Item* item)
{
    if (_destroyOnFail)
    {
        // 销毁物品
        player->DestroyItem(item->GetBagSlot(), item->GetSlot(), true);
        ChatHandler(player->GetSession()).SendNotification("物品在鉴定过程中被摧毁了！");
    }
    else
    {
        // 不销毁物品，可以添加其他失败效果
        // 例如：降低物品耐久度
        uint32 maxDurability = item->GetUInt32Value(ITEM_FIELD_MAXDURABILITY);
        if (maxDurability > 0)
        {
            uint32 currentDurability = item->GetUInt32Value(ITEM_FIELD_DURABILITY);
            uint32 newDurability = currentDurability > maxDurability / 4 ? currentDurability - maxDurability / 4 : 1;
            item->SetUInt32Value(ITEM_FIELD_DURABILITY, newDurability);
            ChatHandler(player->GetSession()).SendNotification("物品在鉴定过程中受到了损伤！");
        }
    }
}

// 发送鉴定公告
void ItemIdentificationSystem::SendAnnouncement(Player* player, Item* item, uint32 identificationId)
{
    if (!_enableAnnounce)
        return;

    // 查询公告模板
    std::string query = "SELECT 公告模板 FROM 物品_鉴定系统 WHERE id = " + std::to_string(identificationId);

    QueryResult result = WorldDatabase.Query(query.c_str());
    if (!result)
        return;

    Field* fields = result->Fetch();
    uint32 announceTemplateId = fields[0].Get<uint32>();

    if (announceTemplateId == 0)
        return;

    // 尝试通过模块管理器获取公告模块接口
    if (AnnouncementInterface* announceModule = sModuleManager->GetAnnouncementModule())
    {
        // 使用公告模块发送公告
        announceModule->SendAnnouncement(player, announceTemplateId, true);

        if (_debugMode)
            DebugLog("通过公告模块发送鉴定公告ID: {}", announceTemplateId);
    }
    else
    {
        // 如果公告模块未加载，使用传统方式发送公告
        // 获取物品信息
        ItemTemplate const* proto = item->GetTemplate();
        if (!proto)
            return;

        // 构建公告消息
        std::string message = "|cffff0000[物品鉴定系统]|r 恭喜玩家 |cff00ff00" + player->GetName() + "|r 成功鉴定出 ";

        // 根据物品品质添加颜色
        switch (proto->Quality)
        {
            case ITEM_QUALITY_POOR:
                message += "|cff9d9d9d";
                break;
            case ITEM_QUALITY_NORMAL:
                message += "|cffffffff";
                break;
            case ITEM_QUALITY_UNCOMMON:
                message += "|cff1eff00";
                break;
            case ITEM_QUALITY_RARE:
                message += "|cff0070dd";
                break;
            case ITEM_QUALITY_EPIC:
                message += "|cffa335ee";
                break;
            case ITEM_QUALITY_LEGENDARY:
                message += "|cffff8000";
                break;
            default:
                message += "|cffffffff";
                break;
        }

        message += proto->Name1 + "|r！";

        // 发送全服公告
        ChatHandler(nullptr).SendWorldText(message.c_str());

        if (_debugMode)
            DebugLog("公告模块未加载，使用传统方式发送鉴定公告");
    }
}

// 调试日志已在头文件中实现为模板函数

// 命令处理类实现
ItemIdentificationCommandScript::ItemIdentificationCommandScript() : CommandScript("ItemIdentificationCommandScript") { }

std::vector<Acore::ChatCommands::ChatCommandBuilder> ItemIdentificationCommandScript::GetCommands() const
{
    using namespace Acore::ChatCommands;

    // 主命令 - 直接使用 .鉴定物品 格式
    static ChatCommandTable commandTable =
    {
        { "鉴定物品", HandleIdentifyCommand, SEC_PLAYER, Console::No },
        { "identifyitem", HandleIdentifyCommand, SEC_PLAYER, Console::No }
    };

    return commandTable;
}

bool ItemIdentificationCommandScript::HandleIdentifyCommand(ChatHandler* handler, const char* args)
{
    Player* player = handler->GetSession()->GetPlayer();
    if (!player)
        return false;

    // 检查系统是否启用
    if (!sItemIdentificationSystem->_enabled)
    {
        handler->SendSysMessage("物品鉴定系统当前已禁用");
        return true;
    }

    // 获取参数：组ID 物品ID
    if (!*args)
    {
        handler->SendSysMessage("用法: .鉴定物品 <组ID> <物品ID>");
        handler->SendSysMessage("示例: .鉴定物品 1 25  (使用组1鉴定物品25)");
        return true;
    }

    char* groupIdStr = strtok((char*)args, " ");
    char* itemIdStr = strtok(nullptr, " ");

    if (!groupIdStr || !itemIdStr)
    {
        handler->SendSysMessage("参数不足！用法: .鉴定物品 <组ID> <物品ID>");
        return true;
    }

    uint32 groupId = atoi(groupIdStr);
    uint32 itemId = atoi(itemIdStr);
    if (itemId == 0)
    {
        handler->SendSysMessage("无效的物品ID");
        return true;
    }

    // 检查物品模板是否存在
    ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemId);
    if (!itemTemplate)
    {
        handler->PSendSysMessage("物品ID {} 不存在", itemId);
        return true;
    }

    // 在玩家背包和装备栏中查找该物品
    Item* item = nullptr;
    
    // 优先查找背包中的物品
    for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
    {
        Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem && pItem->GetEntry() == itemId)
        {
            item = pItem;
            break;
        }
    }

    // 如果背包没找到，查找背包袋子中的物品
    if (!item)
    {
        for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        {
            if (Bag* pBag = player->GetBagByPos(i))
            {
                for (uint32 j = 0; j < pBag->GetBagSize(); ++j)
                {
                    Item* pItem = pBag->GetItemByPos(j);
                    if (pItem && pItem->GetEntry() == itemId)
                    {
                        item = pItem;
                        break;
                    }
                }
                if (item) break;
            }
        }
    }

    // 如果还没找到，查找装备栏（通常不鉴定已装备的）
    if (!item)
    {
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
        {
            Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (pItem && pItem->GetEntry() == itemId)
            {
                item = pItem;
                break;
            }
        }
    }

    if (!item)
    {
        handler->PSendSysMessage("您的背包中没有物品ID为 {} 的物品", itemId);
        handler->PSendSysMessage("物品名称: {}", itemTemplate->Name1);
        return true;
    }

    // 尝试鉴定物品
    handler->PSendSysMessage("正在鉴定物品: {} [{}]，使用组ID: {}", itemTemplate->Name1, itemId, groupId);
    
    LOG_INFO("module", "【命令处理】准备调用IdentifyItem，玩家: {}, 物品ID: {}, 组ID: {}", 
             player->GetName(), itemId, groupId);
    LOG_INFO("module", "【命令处理】sItemIdentificationSystem指针: {}", 
             sItemIdentificationSystem ? "有效" : "NULL");
    
    if (sItemIdentificationSystem->IdentifyItem(player, item, groupId))
    {
        LOG_INFO("module", "【命令处理】IdentifyItem返回成功");
        handler->SendSysMessage("物品鉴定成功！");
    }
    else
    {
        LOG_INFO("module", "【命令处理】IdentifyItem返回失败");
        // 错误消息已在IdentifyItem方法中发送
    }
    
    LOG_INFO("module", "【命令处理】命令执行完成");
    return true;
}

// 模块加载器实现
ItemIdentificationSystemModuleLoader::ItemIdentificationSystemModuleLoader() : WorldScript("ItemIdentificationSystemModuleLoader"), _loaded(false), _startTime(0) { }

void ItemIdentificationSystemModuleLoader::OnAfterConfigLoad(bool reload)
{
    // 如果是重新加载配置，才执行加载操作
    // 初始加载将在服务器完全启动后由OnUpdate执行
    if (reload)
    {
        sItemIdentificationSystem->LoadConfig(reload);
    }
}

void ItemIdentificationSystemModuleLoader::OnUpdate(uint32 diff)
{
    // 延迟1秒初始化模块，确保服务器完全启动
    if (!_loaded)
    {
        if (_startTime == 0)
            _startTime = getMSTime();
        else if (getMSTime() - _startTime > 1000)
        {
            _loaded = true;

            // 注册命令脚本
            new ItemIdentificationCommandScript();

            // 初始化模块
            sItemIdentificationSystem->Initialize();

            // 显示加载信息
            LOG_INFO("server.loading", "→物品鉴定系统√");
        }
    }
}

// 鉴定记录管理实现
bool ItemIdentificationSystem::IsItemIdentified(uint32 itemGuid)
{
    QueryResult result = CharacterDatabase.Query("SELECT 记录ID FROM 物品_鉴定记录 WHERE 物品GUID = {}", itemGuid);
    return result != nullptr;
}

void ItemIdentificationSystem::SaveIdentificationRecord(const ItemIdentificationRecord& record)
{
    CharacterDatabase.Execute(
        "INSERT INTO 物品_鉴定记录 ("
        "玩家GUID, 物品GUID, 物品ID, 鉴定模板ID, "
        "是否获得成长, 成长组ID, "
        "是否获得强化, 强化组ID, "
        "是否获得基础属性, 基础属性数量, 基础属性组ID, "
        "是否获得追加属性, 追加属性数量, 追加属性组ID列表, "
        "是否获得符文凹槽, 符文凹槽数量, "
        "是否获得技能, 技能组ID列表, "
        "是否获得套装, 套装组ID, 套装ID, "
        "消耗金币, 成功率"
        ") VALUES ({}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, '{}', {}, {}, {}, '{}', {}, {}, {}, {}, {})",
        record.playerGuid, record.itemGuid, record.itemEntry, record.templateId,
        record.hasGrowth ? 1 : 0, record.growthGroup,
        record.hasEnhancement ? 1 : 0, record.enhancementGroup,
        record.hasBaseAttributes ? 1 : 0, record.baseAttrCount, record.baseAttrGroup,
        record.hasAdditionalAttributes ? 1 : 0, record.additionalAttrCount, record.additionalAttrGroups,
        record.hasRuneSlots ? 1 : 0, record.runeSlotCount,
        record.hasSkills ? 1 : 0, record.skillGroups,
        record.hasSet ? 1 : 0, record.setGroup, record.setId,
        record.costGold, record.successRate
    );
    
    DebugLog("保存鉴定记录: 玩家GUID={}, 物品GUID={}, 模板ID={}", 
             record.playerGuid, record.itemGuid, record.templateId);
}

ItemIdentificationRecord* ItemIdentificationSystem::GetIdentificationRecord(uint32 itemGuid)
{
    // 这里简化实现，实际应用中可以缓存记录
    // 暂时返回nullptr，完整实现需要从数据库加载
    return nullptr;
}

void ItemIdentificationSystem::RefreshItem(Player* player, Item* item)
{
    if (!player || !item)
        return;
    
    // 保存物品到数据库
    item->SaveToDB(nullptr);
    
    // 如果物品已装备
    if (item->IsEquipped())
    {
        // 更新装备槽位显示
        player->SetVisibleItemSlot(item->GetSlot(), item);
        
        // 重新计算所有属性
        player->UpdateAllStats();
        
        DebugLog("刷新已装备物品: GUID={}, 槽位={}", 
                 item->GetGUID().GetCounter(), item->GetSlot());
    }
    else
    {
        // 发送物品更新到客户端
        item->SendUpdateToPlayer(player);
        
        DebugLog("刷新背包物品: GUID={}", item->GetGUID().GetCounter());
    }
}

// 添加脚本
void AddItemIdentificationSystemScripts()
{
    // 添加命令脚本
    new ItemIdentificationCommandScript();
    
    // 添加模块加载器
    new ItemIdentificationSystemModuleLoader();
}
