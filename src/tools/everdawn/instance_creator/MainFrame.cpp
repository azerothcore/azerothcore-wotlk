#include "MainFrame.hpp"

namespace everdawn
{


    MainFrame::MainFrame(const wxString& title, const wxPoint& pos, const wxSize& size)
        : wxFrame(NULL, wxID_ANY, title, pos, size)
    {
        wxMenu* menuFile = new wxMenu;

        menuFile->AppendSeparator();
        menuFile->Append(wxID_EXIT);
        wxMenu* menuHelp = new wxMenu;
        menuHelp->Append(wxID_ABOUT);
        wxMenuBar* menuBar = new wxMenuBar;
        menuBar->Append(menuFile, wxT("&File"));
        menuBar->Append(menuHelp, wxT("&Help"));
        SetMenuBar(menuBar);

        CreateStatusBar(3);
    }
    void MainFrame::OnExit(wxCommandEvent& event)
    {
        Close(true);
    }
    void MainFrame::OnAbout(wxCommandEvent& event)
    {
        wxMessageBox(wxT("Everdawn tool."),
            wxT("About Instance Creator"), wxOK | wxICON_INFORMATION);
    }
    void MainFrame::OnStatusChange(StatusChangeEvent& event)
    {
        switch (event.status.code)
        {
        case StatusCode::loading:
            this->Disable();
            SetStatusText(wxString::Format(wxT("Loading! -- %s"), event.status.message), 0);
            break;
        case StatusCode::ready:
            this->Enable();
            SetStatusText(wxString::Format(wxT("Ready! -- %s"), event.status.message), 0);
            break;
        case StatusCode::error:
            this->Enable();
            SetStatusText(wxString::Format(wxT("Error! -- %s"), event.status.message), 0);
            break;
        default:
            break;
        }
    }

    wxBEGIN_EVENT_TABLE(MainFrame, wxFrame)
        EVT_MENU(wxID_EXIT, MainFrame::OnExit)
        EVT_MENU(wxID_ABOUT, MainFrame::OnAbout)
        EVT_STATUS_CHANGE(wxID_ANY, MainFrame::OnStatusChange)
        wxEND_EVENT_TABLE()
} // namespace everdawn

