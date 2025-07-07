/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/** \file
    \ingroup world
*/

#include "Weather.h"
#include "MiscPackets.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Util.h"
#include "World.h"
#include "WorldSessionMgr.h"

/// Create the Weather object
Weather::Weather(uint32 zoneID, WeatherData const* weatherChances)
    : _zone(zoneID), _weatherChances(weatherChances)
{
    _timer.SetInterval(sWorld->getIntConfig(CONFIG_INTERVAL_CHANGEWEATHER));
    _type = WEATHER_TYPE_FINE;
    _intensity = 0;

    LOG_DEBUG("weather", "WORLD: Starting weather system for zone {} (change every {} minutes).", _zone, (uint32)(_timer.GetInterval() / (MINUTE * IN_MILLISECONDS)));
}

/// Launch a weather update
bool Weather::Update(uint32 diff)
{
    if (_timer.GetCurrent() >= 0)
        _timer.Update(diff);
    else
        _timer.SetCurrent(0);

    ///- If the timer has passed, ReGenerate the weather
    if (_timer.Passed())
    {
        _timer.Reset();
        // update only if Regenerate has changed the weather
        if (ReGenerate())
        {
            ///- Weather will be removed if not updated (no players in zone anymore)
            if (!UpdateWeather())
                return false;
        }
    }

    sScriptMgr->OnWeatherUpdate(this, diff);
    return true;
}

/// Calculate the new weather
bool Weather::ReGenerate()
{
    if (!_weatherChances)
    {
        _type = WEATHER_TYPE_FINE;
        _intensity = 0.0f;
        return false;
    }

    /// Weather statistics:
    ///- 30% - no change
    ///- 30% - weather gets better (if not fine) or change weather type
    ///- 30% - weather worsens (if not fine)
    ///- 10% - radical change (if not fine)
    uint32 u = urand(0, 99);

    if (u < 30)
        return false;

    // remember old values
    WeatherType old_type = _type;
    float old_intensity = _intensity;

    //78 days between January 1st and March 20nd; 365/4=91 days by season
    // season source http://aa.usno.navy.mil/data/docs/EarthSeasons.html
    uint32 season = ((Acore::Time::GetDayInYear() - 78 + 365) / 91) % 4;

    static char const* seasonName[WEATHER_SEASONS] = { "spring", "summer", "fall", "winter" };
    LOG_DEBUG("weather", "Generating a change in {} weather for zone {}.", seasonName[season], _zone);

    if ((u < 60) && (_intensity < 0.33333334f))                // Get fair
    {
        _type = WEATHER_TYPE_FINE;
        _intensity = 0.0f;
    }

    if ((u < 60) && (_type != WEATHER_TYPE_FINE))          // Get better
    {
        _intensity -= 0.33333334f;
        return true;
    }

    if ((u < 90) && (_type != WEATHER_TYPE_FINE))          // Get worse
    {
        _intensity += 0.33333334f;
        return true;
    }

    if (_type != WEATHER_TYPE_FINE)
    {
        /// Radical change:
        ///- if light -> heavy
        ///- if medium -> change weather type
        ///- if heavy -> 50% light, 50% change weather type

        if (_intensity < 0.33333334f)
        {
            _intensity = 0.9999f;                              // go nuts
            return true;
        }
        else
        {
            if (_intensity > 0.6666667f)
            {
                // Severe change, but how severe?
                uint32 rnd = urand(0, 99);
                if (rnd < 50)
                {
                    _intensity -= 0.6666667f;
                    return true;
                }
            }
            _type = WEATHER_TYPE_FINE;                     // clear up
            _intensity = 0;
        }
    }

    // At this point, only weather that isn't doing anything remains but that have weather data
    uint32 chance1 = _weatherChances->data[season].rainChance;
    uint32 chance2 = chance1 + _weatherChances->data[season].snowChance;
    uint32 chance3 = chance2 + _weatherChances->data[season].stormChance;

    uint32 rnd = urand(1, 100);
    if (rnd <= chance1)
        _type = WEATHER_TYPE_RAIN;
    else if (rnd <= chance2)
        _type = WEATHER_TYPE_SNOW;
    else if (rnd <= chance3)
        _type = WEATHER_TYPE_STORM;
    else
        _type = WEATHER_TYPE_FINE;

    /// New weather statistics (if not fine):
    ///- 85% light
    ///- 7% medium
    ///- 7% heavy
    /// If fine 100% sun (no fog)

    if (_type == WEATHER_TYPE_FINE)
    {
        _intensity = 0.0f;
    }
    else if (u < 90)
    {
        _intensity = (float)rand_norm() * 0.3333f;
    }
    else
    {
        // Severe change, but how severe?
        rnd = urand(0, 99);
        if (rnd < 50)
            _intensity = (float)rand_norm() * 0.3333f + 0.3334f;
        else
            _intensity = (float)rand_norm() * 0.3333f + 0.6667f;
    }

    // return true only in case weather changes
    return _type != old_type || _intensity != old_intensity;
}

void Weather::SendWeatherUpdateToPlayer(Player* player)
{
    WorldPackets::Misc::Weather weather(GetWeatherState(), _intensity);
    player->SendDirectMessage(weather.Write());
}

/// Send the new weather to all players in the zone
bool Weather::UpdateWeather()
{
    ///- Send the weather packet to all players in this zone
    if (_intensity >= 1)
        _intensity = 0.9999f;
    else if (_intensity < 0)
        _intensity = 0.0001f;

    WeatherState state = GetWeatherState();

    WorldPackets::Misc::Weather weather(state, _intensity);

    //- Returns false if there were no players found to update
    if (!sWorldSessionMgr->SendZoneMessage(_zone, weather.Write()))
        return false;

    ///- Log the event
    char const* wthstr;
    switch (state)
    {
        case WEATHER_STATE_FOG:
            wthstr = "fog";
            break;
        case WEATHER_STATE_LIGHT_RAIN:
            wthstr = "light rain";
            break;
        case WEATHER_STATE_MEDIUM_RAIN:
            wthstr = "medium rain";
            break;
        case WEATHER_STATE_HEAVY_RAIN:
            wthstr = "heavy rain";
            break;
        case WEATHER_STATE_LIGHT_SNOW:
            wthstr = "light snow";
            break;
        case WEATHER_STATE_MEDIUM_SNOW:
            wthstr = "medium snow";
            break;
        case WEATHER_STATE_HEAVY_SNOW:
            wthstr = "heavy snow";
            break;
        case WEATHER_STATE_LIGHT_SANDSTORM:
            wthstr = "light sandstorm";
            break;
        case WEATHER_STATE_MEDIUM_SANDSTORM:
            wthstr = "medium sandstorm";
            break;
        case WEATHER_STATE_HEAVY_SANDSTORM:
            wthstr = "heavy sandstorm";
            break;
        case WEATHER_STATE_THUNDERS:
            wthstr = "thunders";
            break;
        case WEATHER_STATE_BLACKRAIN:
            wthstr = "blackrain";
            break;
        case WEATHER_STATE_FINE:
        default:
            wthstr = "fine";
            break;
    }

    LOG_DEBUG("weather", "Change the weather of zone {} to {}.", _zone, wthstr);
    sScriptMgr->OnWeatherChange(this, state, _intensity);
    return true;
}

/// Set the weather
void Weather::SetWeather(WeatherType type, float intensity)
{
    if (_type == type && _intensity == intensity)
        return;

    _type = type;
    _intensity = intensity;
    UpdateWeather();
}

/// Get the sound number associated with the current weather
WeatherState Weather::GetWeatherState() const
{
    if (_intensity < 0.27f)
        return WEATHER_STATE_FINE;

    switch (_type)
    {
        case WEATHER_TYPE_RAIN:
            if (_intensity < 0.40f)
                return WEATHER_STATE_LIGHT_RAIN;
            else if (_intensity < 0.70f)
                return WEATHER_STATE_MEDIUM_RAIN;
            else
                return WEATHER_STATE_HEAVY_RAIN;
        case WEATHER_TYPE_SNOW:
            if (_intensity < 0.40f)
                return WEATHER_STATE_LIGHT_SNOW;
            else if (_intensity < 0.70f)
                return WEATHER_STATE_MEDIUM_SNOW;
            else
                return WEATHER_STATE_HEAVY_SNOW;
        case WEATHER_TYPE_STORM:
            if (_intensity < 0.40f)
                return WEATHER_STATE_LIGHT_SANDSTORM;
            else if (_intensity < 0.70f)
                return WEATHER_STATE_MEDIUM_SANDSTORM;
            else
                return WEATHER_STATE_HEAVY_SANDSTORM;
        case WEATHER_TYPE_BLACKRAIN:
            return WEATHER_STATE_BLACKRAIN;
        case WEATHER_TYPE_THUNDERS:
            return WEATHER_STATE_THUNDERS;
        case WEATHER_TYPE_FINE:
        default:
            return WEATHER_STATE_FINE;
    }
}
