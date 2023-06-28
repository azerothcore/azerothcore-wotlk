#include "MainFrame.hpp"
#include "WorldDataBaseFacade.hpp"
#include "Status.hpp"
#include "SmartEnum.h"

#include <wx/splash.h>
#include <wx/graphics.h>
#include <wx/dcbuffer.h>
#include <wx/progdlg.h>

#include <thread>
#include <random>

namespace everdawn {
    class InstanceCreator : public wxApp
    {
        MainFrame* m_frame = nullptr;
        wxProgressDialog* m_progressDialog = nullptr;
        Observable<Status>::Subscription m_subscription;
    public:
        virtual bool OnInit();
        virtual int OnRun();
        virtual int OnExit();
    };

    bool InstanceCreator::OnInit()
    {
        m_frame = new MainFrame("Realm manager", wxDefaultPosition, wxSize(800, 600));
        m_frame->CentreOnScreen();
        m_frame->Show(true);

        m_subscription = WorldDatabaseFacade::GetStatus().Subscribe([&](const Status& status)
            {
                switch (status.code)
                {
                case 1:
                    m_frame->Enable(false);
                    wxMessageBox(status.message, wxT("Error"), wxOK | wxICON_ERROR);
                    m_frame->Close();
                    break;
                case StatusCode::Loading:
                    m_frame->Enable(false);
                    m_progressDialog = new wxProgressDialog("Loading", status.message, 100, m_frame, wxPD_APP_MODAL | wxPD_AUTO_HIDE | wxPD_SMOOTH | wxPD_CAN_ABORT);
                    break;
                case StatusCode::Ready:
                    if (m_progressDialog != nullptr)
                        m_progressDialog->Close();
                    m_frame->Enable(true);
                default:
                    break;
                }
                wxPostEvent(m_frame, StatusChangeEvent(status));
            });

        return true;
    }

    int InstanceCreator::OnRun()
    {
        WorldDatabaseFacade::Load();
        return wxApp::OnRun();
    }

    int InstanceCreator::OnExit()
    {
        m_subscription.Unsubscribe();
        return wxApp::OnExit();
    }

} // namespace everdawn

wxIMPLEMENT_APP(everdawn::InstanceCreator);
