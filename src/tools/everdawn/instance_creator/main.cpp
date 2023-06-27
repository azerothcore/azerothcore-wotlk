#include "MainFrame.hpp"
#include "WorldDataBaseFacade.hpp"
#include "Models/Status.hpp"

#include <thread>


namespace everdawn {
    class InstanceCreator : public wxApp
    {
    public:
        virtual bool OnInit();
    };

    bool InstanceCreator::OnInit()
    {
        const auto frame = new MainFrame("Realm manager", wxPoint(50, 50), wxSize(450, 340));
        frame->Show(true);


        WorldDatabaseFacade::GetStatus().Subscribe([frame](const Status& status)
            {
                 const StatusChangeEvent event(status);
                 wxPostEvent(frame, event);
            });

        WorldDatabaseFacade::Load();

        return true;
    }

} // namespace everdawn

wxIMPLEMENT_APP(everdawn::InstanceCreator);
