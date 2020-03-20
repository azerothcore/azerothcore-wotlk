import React from 'react';
import { copyTextToClipboard } from 'util/copyTextToClipboard';
import { toast } from 'react-toastify';

interface Props {
    coppiedText: string;
}

export function CoppiedToClipboardToastContent({ coppiedText }: Props) {
    return (
        <React.Fragment>
            <p style={{ fontSize: '0.85rem', marginBottom: 6 }}>in your clipboard  <span role='img' aria-label='clipboard icon'>📋</span> </p>
            <code style={{ fontSize: '1.0rem' }}>{coppiedText}</code>
        </React.Fragment>
    )
}

export function copyToClipboardWithToast(text: string) {
    copyTextToClipboard(text);
    toast(<CoppiedToClipboardToastContent coppiedText={text} />, { type: 'info' });
}