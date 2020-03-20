import React from 'react';
import './Typography.css';

export const Text: React.SFC = (props) => {
    return (
        <p className="Text">
            {props.children}
        </p>
    )
}

Text.displayName = 'Text';