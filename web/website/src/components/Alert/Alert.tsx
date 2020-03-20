import React from 'react';
import './Alert.css';
import { classNames } from 'util/classNames';

interface AlertProps {
    type?: 'info' | 'warning';
    typeLabel?: React.ReactChild;
    onCloseRequest?(): void;
    hideAlertType?: boolean;
    onClick?(): void;
}

export const Alert: React.SFC<AlertProps> = (props) => {
    const type = props.type || 'info';
    const hideAlertType = props.hideAlertType || false;
    const isInfo = props.type === 'info';
    const isWarn = props.type === 'warning';

    return (
        <div className={classNames(
            'Alert',
            isInfo && 'info',
            isWarn && 'warn'
        )} onClick={props.onClick}>
            <div className="Alert-content-type">
                {!hideAlertType && <span>{props.typeLabel || type}</span>}
                {props.onCloseRequest && <span className="Alert-closer" onClick={props.onCloseRequest}>×</span>}
            </div>
            <div className="Alert-content">{props.children}</div>
        </div>
    )
}


Alert.displayName = 'Alert';