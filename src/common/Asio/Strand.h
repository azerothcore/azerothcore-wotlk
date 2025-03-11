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

#ifndef Strand_h__
#define Strand_h__

#include "IoContext.h"
#include <boost/asio/bind_executor.hpp>
#include <boost/asio/strand.hpp>

namespace Acore::Asio
{
    /**
        Hack to make it possible to forward declare strand (which is a inner class)
    */
    class Strand : public IoContextBaseNamespace::IoContextBase::strand
    {
    public:
        Strand(IoContext& ioContext) : IoContextBaseNamespace::IoContextBase::strand(ioContext) { }
    };

    using boost::asio::bind_executor;
}

#endif // Strand_h__
