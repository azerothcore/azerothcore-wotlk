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
        // Instantiate one of these to allow modification.
        // The observers will be notified when this is destroyed after the modification.
        class Transaction
        {
        public:
            explicit Transaction(Observable& parent) :
                object(parent.object), parent(parent) {}
            ~Transaction() { parent.changed(object); }
            Type& object;

        private:
            Transaction(const Transaction&);    // prevent copying
            void operator=(const Transaction&); // prevent assignment

            Observable& parent;
        };

        void Next(Type object)
        {
            this->object = object;
            changed(this->object);
        }

        // Connect an observer to this object.
        template <typename Slot>
        void Subscribe(const Slot& slot) { changed.connect(slot); }

        // Read-only access to the object.
        const Type& Get() const { return object; }

    private:
        boost::signals2::signal<void(const Type&)> changed;
        Type object;
    };
} // namespace everdawn

#endif // EVERDAWN_OBSERVABLE_HPP
