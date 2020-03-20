import React, { useState, useEffect } from 'react';
import './Root.css';
import { RootNavigation } from './RootNavigation';
import { Route, Switch, Redirect, useLocation, useHistory } from 'react-router-dom';
import { Alert } from 'components/Alert/Alert';
import { ToastContainer, Flip } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { CreateAccountPage } from 'pages/CreateAccountPage/CreateAccount';

interface _NavigationState {
    fromNotFoundPage: boolean;
}

export type NavigationState = Partial<_NavigationState>


export function Root() {
    const location = useLocation<NavigationState>();
    const fromNotFoundPage = Boolean((location.state || {}).fromNotFoundPage);
    const [showPageNotFoundAlert, setShowPageNotFoundAlert] = useState(false);
    const history = useHistory();

    useEffect(() => {
        setShowPageNotFoundAlert(fromNotFoundPage);
    }, [fromNotFoundPage]);

    return (
        <div className="Root">
            <RootNavigation />
            <main className="Root-children-container">
                {showPageNotFoundAlert &&
                    <Alert
                        type='warning'
                        onCloseRequest={() => {
                            // create a new history entry without the alert
                            history.push({
                                ...history.location,
                                state: {
                                    ...history.location.state, fromNotFoundPage: false
                                }
                            });
                            setShowPageNotFoundAlert(false)
                        }}
                    >
                        The page you were trying to visit does not exist. Redirected to Home.
                    </Alert>}
                <Switch>
                    <Route path='/' exact>
                        <Redirect to='/create-account' />
                    </Route>
                    <Route path='/create-account'>
                        <CreateAccountPage />
                    </Route>
                    <Route>
                        <Redirect push to={{ pathname: '/create-account', state: { fromNotFoundPage: true } }} />
                    </Route>
                </Switch>
            </main>
            <ToastContainer transition={Flip} position='bottom-right' />
        </div>
    )
}