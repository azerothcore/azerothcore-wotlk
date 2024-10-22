//
// Created by Tristan Cormier on 2024-10-21.
//

#ifndef MAPWEATHER_H
#define MAPWEATHER_H

#include "Common.h"
#include "SharedDefines.h"
#include "Timer.h"

class Player;

#define WEATHER_SEASONS 4
struct WeatherSeasonChances
{
  uint32 rainChance;
  uint32 snowChance;
  uint32 stormChance;
};

struct WeatherData
{
  WeatherSeasonChances data[WEATHER_SEASONS];
  uint32 ScriptId;
};

enum WeatherState : uint32
{
  WEATHER_STATE_FINE              = 0,
  WEATHER_STATE_FOG               = 1,
  WEATHER_STATE_LIGHT_RAIN        = 3,
  WEATHER_STATE_MEDIUM_RAIN       = 4,
  WEATHER_STATE_HEAVY_RAIN        = 5,
  WEATHER_STATE_LIGHT_SNOW        = 6,
  WEATHER_STATE_MEDIUM_SNOW       = 7,
  WEATHER_STATE_HEAVY_SNOW        = 8,
  WEATHER_STATE_LIGHT_SANDSTORM   = 22,
  WEATHER_STATE_MEDIUM_SANDSTORM  = 41,
  WEATHER_STATE_HEAVY_SANDSTORM   = 42,
  WEATHER_STATE_THUNDERS          = 86,
  WEATHER_STATE_BLACKRAIN         = 90,
  WEATHER_STATE_BLACKSNOW         = 106
};

enum WEATHER_TYPE {
  WEATHER_TYPE_FINE   = 0x0,
  WEATHER_TYPE_RAIN   = 0x1,
  WEATHER_TYPE_SNOW   = 0x2,
  WEATHER_TYPE_STORM  = 0x3,
  MAX_WEATHER_TYPE    = 0x4,
  //TODO:
  WEATHER_TYPE_THUNDERS   = 86,
  WEATHER_TYPE_BLACKRAIN  = 90
};

/// Weather for one zone
class Weather
{
public:
  Weather(uint32 zone, WeatherData const* weatherChances);
  ~Weather() = default;

  bool Update(uint32 diff);
  bool ReGenerate();
  bool UpdateWeather();

  void SendWeatherUpdateToPlayer(Player* player);
  void SetWeather(WEATHER_TYPE type, float grade);

  /// For which zone is this weather?
  [[nodiscard]] uint32 GetZone() const { return m_zone; };
  [[nodiscard]] uint32 GetScriptId() const { return m_weatherChances->ScriptId; }

private:
  [[nodiscard]] WeatherState GetWeatherState() const;
  uint32 m_zone;
  WEATHER_TYPE m_type;
  float m_grade;
  IntervalTimer m_timer;
  WeatherData const* m_weatherChances;
};

/////////

#include "Define.h"

class Weather;
class Player;

namespace WeatherMgr
{
  void LoadWeatherData();

  Weather* FindWeather(uint32 id);
  Weather* AddWeather(uint32 zone_id);
  void RemoveWeather(uint32 zone_id);

  void SendFineWeatherUpdateToPlayer(Player* player);

  void Update(uint32 diff);
}

#endif //MAPWEATHER_H
