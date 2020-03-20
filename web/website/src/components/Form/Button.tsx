import React from 'react';
import './Form.css';
import { classNames } from 'util/classNames';

interface Props {
    dense?: boolean;
    buttonProps?: React.DetailedHTMLProps<React.ButtonHTMLAttributes<HTMLButtonElement>, HTMLButtonElement>;
}

export const Button: React.SFC<Props> = ({
    children,
    dense = false,
    buttonProps
}) => {

    return (
        <button
            className={classNames('Button', dense && 'dense')}
            {...buttonProps}
        >
            {children}
        </button>
    )
} 