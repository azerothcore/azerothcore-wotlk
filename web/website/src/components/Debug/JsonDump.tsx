import React from 'react';

interface Props {
    value: any;
}

export function JsonDump({ value }: Props) {
    return (
        <code>
            {JSON.stringify(value, null, 2)}
        </code>
    )
}