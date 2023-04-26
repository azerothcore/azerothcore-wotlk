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

#ifndef AZEROTHCORE_CRYPTO_CONSTANTS_H
#define AZEROTHCORE_CRYPTO_CONSTANTS_H

#include "Define.h"

namespace Acore::Crypto
{
    struct Constants
    {
        static constexpr size_t MD5_DIGEST_LENGTH_BYTES = 16;
        static constexpr size_t SHA1_DIGEST_LENGTH_BYTES = 20;
        static constexpr size_t SHA256_DIGEST_LENGTH_BYTES = 32;
    };
}

#endif
