import React from 'react';
import './Form.css';
import { classNames } from 'util/classNames';

export interface LabeledProps {
    label: React.ReactChild;
    helper?: React.ReactChild;
    hasError?: boolean;
}

export const Labeled: React.SFC<LabeledProps> = ({
    children,
    label,
    helper,
    hasError = false
}) => {

    return (
        <div className="Labeled">
            <label className="Labeled-label">
                <span className="Labeled-label-text">{label}</span>
                <span className="Labeled-label-node">{children}</span>
            </label>
            <div className={classNames(
                'Labeled-helper',
                hasError && 'has-error'
            )}>{helper}</div>
        </div>
    )
}