/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>
 */

#ifndef _WORLD_CONFIG_H
#define _WORLD_CONFIG_H

#include "Common.h"
#include <unordered_map>

enum class WorldConfigType : uint8
{
	GAME_CONFIG_TYPE_BOOL,
	GAME_CONFIG_TYPE_INT,
	GAME_CONFIG_TYPE_FLOAT,
	GAME_CONFIG_TYPE_STRING,

	GAME_CONFIG_TYPE_UNKNOWN
};

class AC_GAME_API WorldConfig
{
public:
	static WorldConfig* instance();

	void Load();

	// Get config options
	bool GetBoolConfig(std::string const& configName);
	int32 GetIntConfig(std::string const& configName);
	float GetFloatConfig(std::string const& configName);
	std::string GetStringConfig(std::string const& configName);

private:
	// Add config options
	void AddOption(std::string const& configName, WorldConfigType type, std::string const& value, std::string const& defaultValue);

	void AddBoolOption(std::string const& configName, bool value = false);
	void AddIntOption(std::string const& configName, int32 value = 0);
	void AddFloatOption(std::string const& configName, float value = 1.0f);
	void AddStringOption(std::string const& configName, std::string const& value = "");

	void CleanAll();

	std::unordered_map<std::string, bool> _boolOptions;
	std::unordered_map<std::string, int32> _intOptions;
	std::unordered_map<std::string, float> _floatOptions;
	std::unordered_map<std::string, std::string> _stringOptions;
};

#define sWorldConfig WorldConfig::instance()

#endif // _WORLD_CONFIG_H
