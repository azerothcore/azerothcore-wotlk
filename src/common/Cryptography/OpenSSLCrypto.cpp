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
#include "Errors.h"
#include <openssl/crypto.h> // NOTE: this import is NEEDED (even though some IDEs report it as unused)

#if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER < 0x1010000fL
#include <vector>
#include <thread>
#include <mutex>

std::vector<std::mutex*> cryptoLocks;

static void lockingCallback(int mode, int type, char const* /*file*/, int /*line*/)
{
    if (mode & CRYPTO_LOCK)
        cryptoLocks[type]->lock();
    else
        cryptoLocks[type]->unlock();
}

static void threadIdCallback(CRYPTO_THREADID * id)
{
    (void)id;
    CRYPTO_THREADID_set_numeric(id, std::hash<std::thread::id>()(std::this_thread::get_id()));
}
#elif OPENSSL_VERSION_NUMBER >= 0x30000000L
#include <openssl/provider.h>
OSSL_PROVIDER* LegacyProvider;
OSSL_PROVIDER* DefaultProvider;
#endif

#if OPENSSL_VERSION_NUMBER >= 0x30000000L && AC_PLATFORM == AC_PLATFORM_WINDOWS
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
#if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER < 0x1010000fL
    cryptoLocks.resize(CRYPTO_num_locks());

    for (int i = 0 ; i < CRYPTO_num_locks(); ++i)
    {
        cryptoLocks[i] = new std::mutex();
    }

    (void)&threadIdCallback;
    CRYPTO_THREADID_set_callback(threadIdCallback);

    (void)&lockingCallback;
    CRYPTO_set_locking_callback(lockingCallback);
#elif OPENSSL_VERSION_NUMBER >= 0x30000000L
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    SetupLibrariesForWindows();
#endif
    LegacyProvider = OSSL_PROVIDER_load(nullptr, "legacy");
    DefaultProvider = OSSL_PROVIDER_load(nullptr, "default");
#endif
}

void OpenSSLCrypto::threadsCleanup()
{
#if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER < 0x1010000fL
    CRYPTO_set_locking_callback(nullptr);
    CRYPTO_THREADID_set_callback(nullptr);

    for (int i = 0 ; i < CRYPTO_num_locks(); ++i)
    {
        delete cryptoLocks[i];
    }

    cryptoLocks.resize(0);
#elif OPENSSL_VERSION_NUMBER >= 0x30000000L
    OSSL_PROVIDER_unload(LegacyProvider);
    OSSL_PROVIDER_unload(DefaultProvider);
    OSSL_PROVIDER_set_default_search_path(nullptr, nullptr);
#endif
}
