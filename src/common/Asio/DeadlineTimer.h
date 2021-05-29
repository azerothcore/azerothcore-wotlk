/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef DeadlineTimer_h__
#define DeadlineTimer_h__

#include <boost/asio/deadline_timer.hpp>

#if BOOST_VERSION >= 107000
#define BasicDeadlineTimerThirdTemplateArg , boost::asio::io_context::executor_type
#elif BOOST_VERSION >= 106600
#define BasicDeadlineTimerThirdTemplateArg
#else
#define BasicDeadlineTimerThirdTemplateArg , boost::asio::deadline_timer_service<boost::posix_time::ptime, boost::asio::time_traits<boost::posix_time::ptime>>
#endif

#define DeadlineTimerBase boost::asio::basic_deadline_timer<boost::posix_time::ptime, boost::asio::time_traits<boost::posix_time::ptime> BasicDeadlineTimerThirdTemplateArg>

namespace acore::Asio
{
    class DeadlineTimer : public DeadlineTimerBase
    {
    public:
        using DeadlineTimerBase::basic_deadline_timer;
    };
}

#endif // DeadlineTimer_h__
