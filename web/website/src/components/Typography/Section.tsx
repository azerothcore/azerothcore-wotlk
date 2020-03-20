import React from 'react';
import './Typography.css';

export const Section: React.SFC = (props) => {
    return (
        <section className="Section">
            {props.children}
        </section>
    )
}

Section.displayName = 'Section';