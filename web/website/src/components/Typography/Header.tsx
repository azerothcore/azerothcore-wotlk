import React from 'react';
import './Typography.css';

interface Props {
    subHeaderText?: React.ReactChild;
}

export const Header: React.SFC<Props> = (props) => {
    const hasSubHeader = Boolean(props.subHeaderText);
    return (
        <>
            <h3 className="Header">
                <span className="Header-content">{props.children}</span>
                {hasSubHeader && <span className="Header-subheader">{props.subHeaderText}</span>}
               <div className="Header-underline"></div>
            </h3>
        </>
    )
}

Header.displayName = 'Header';