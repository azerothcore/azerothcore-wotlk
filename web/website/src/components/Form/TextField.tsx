import React from 'react';
import './Form.css';
import { Labeled, LabeledProps } from './Labeled';
import { classNames } from 'util/classNames';

interface Props extends LabeledProps {
    inputProps?: React.DetailedHTMLProps<React.InputHTMLAttributes<HTMLInputElement>, HTMLInputElement>
}

export function TextField({
    label,
    helper,
    inputProps,
    hasError
}: Props) {
    return (
        <Labeled
            label={label}
            helper={helper}
            hasError={hasError}
        >
            <input
                {...inputProps}
                className={classNames('TextField', inputProps?.className || false )}
            />
        </Labeled>
    )
}