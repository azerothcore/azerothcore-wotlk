#ifndef EVERDAWN_OBSERVABLE_HPP
#define EVERDAWN_OBSERVABLE_HPP

#include <boost/signals2.hpp>

namespace everdawn
{
    // Based on https://stackoverflow.com/questions/3185374/observable-container-for-c
    // Also see https://gist.github.com/sraaphorst/52ee617c2f95814636109eb396234c46
    // Wrapper to allow notification when an object is modified.
    template <typename Type>
    class Observable
    {
    public:
        class Subscription
        {
            const Observable* m_observable;
            friend class Observable;
            boost::signals2::connection connection;
        public:
            explicit Subscription(const Observable* observable = nullptr)
                : m_observable(observable)
            {
            }
            void Unsubscribe()
            {
                if (m_observable)
                {
                    m_observable->changed.disconnect(connection);
                    m_observable = nullptr;
                }
            }
        };

        void Next(Type object)
        {
            this->object = object;
            changed(this->object);
        }

        template <typename Slot>
        Subscription Subscribe(const Slot& slot) const
        {
            auto subscription = Subscription(this);
            subscription.connection = changed.connect(slot);
            return subscription;
        }

        const Type& Get() const { return object; }
    private:
        mutable boost::signals2::signal<void(const Type&)> changed;
        Type object;
    };
} // namespace everdawn

#endif // EVERDAWN_OBSERVABLE_HPP
