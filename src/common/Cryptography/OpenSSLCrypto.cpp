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

#include "OpenSSLCrypto.h"
#include <openssl/crypto.h> // NOTE: this import is NEEDED (even though some IDEs report it as unused)
#include <openssl/provider.h>

OSSL_PROVIDER* LegacyProvider;
OSSL_PROVIDER* DefaultProvider;

#if AC_PLATFORM == AC_PLATFORM_WINDOWS
#include <boost/dll/runtime_symbol_info.hpp>
#include <filesystem>

void SetupLibrariesForWindows()
{
    namespace fs = std::filesystem;

    fs::path programLocation{ boost::dll::program_location().remove_filename().string() };
    fs::path libLegacy{ boost::dll::program_location().remove_filename().string() + "/legacy.dll" };

    ASSERT(fs::exists(libLegacy), "Not found 'legacy.dll'. Please copy library 'legacy.dll' from OpenSSL default dir to '{}'", programLocation.generic_string());
    OSSL_PROVIDER_set_default_search_path(nullptr, programLocation.generic_string().c_str());
}
#endif

void OpenSSLCrypto::threadsSetup()
{
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    SetupLibrariesForWindows();
#endif
    LegacyProvider = OSSL_PROVIDER_load(nullptr, "legacy");
    DefaultProvider = OSSL_PROVIDER_load(nullptr, "default");
}

void OpenSSLCrypto::threadsCleanup()
{
    OSSL_PROVIDER_unload(LegacyProvider);
    OSSL_PROVIDER_unload(DefaultProvider);
    OSSL_PROVIDER_set_default_search_path(nullptr, nullptr);
}
