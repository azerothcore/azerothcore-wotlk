import React from 'react';
import './HomePage.css';
import { useLoader } from 'hooks/useLoader';
import { serverMetadataService } from 'service/serverMetadataService.mock';
import { Section } from 'components/Typography/Section';
import { Header } from 'components/Typography/Header';
import { Text } from 'components/Typography/Text';
import { Alert } from 'components/Alert/Alert';
import { copyToClipboardWithToast } from 'components/Clipboard/CoppiedToClipboardToastContent';


const REALMLIST = 'set realmlist 138.201.117.25';

interface StatEntryProps {
    _key: string;
    value: React.ReactChild;
}

function StatEntry({ _key: key, value }: StatEntryProps) {
    return (
        <div className="HomePage-Stats-Entry">
            <div className="HomePage-Stats-Entry-Key">
                {key}
            </div>
            <div className="HomePage-Stats-Entry-Gutter" />
            <div className="HomePage-Stats-Entry-Value">
                {value}
            </div>
        </div>
    )
}

export function HomePage() {
    const serverMetadata = useLoader(
        () => serverMetadataService.getServerMetadata()
    );

    function putRealmlistToClipboard() {
        copyToClipboardWithToast(REALMLIST);
    }

    return (
        <div className="HomePage-wrapper">
            <div className='HomePage-left'>
                <Section>
                    <Header
                        subHeaderText={<>8/03/2020 by Staff</>}
                    >
                        News
                    </Header>
                    <Text>
                        News about the server will appear here.
                    </Text>
                </Section>
            </div>
            <div className='HomePage-right'>
                <Alert
                    type='info'
                    typeLabel='click to copy'
                    onClick={putRealmlistToClipboard}
                >
                    <code className="HomePage-right-realmlist">{REALMLIST}</code>
                </Alert>
                {serverMetadata !== null && <div className="HomePage-Stats">
                    <StatEntry _key='Status' value={serverMetadata?.isUp ? 'UP↑' : 'DOWN↓'} />
                    <StatEntry _key='Players online' value={serverMetadata?.online || -1} />
                    <StatEntry _key='Peak players online' value={serverMetadata?.peakOnline || -1} />
                    <StatEntry _key='Accounts made' value={serverMetadata?.accountCount || -1} />
                </div>}
                <iframe
                    title={'DiscordWidget'}
                    src={"https://discordapp.com/widget?id=686257951887196170&theme=dark"}
                    width="350"
                    height="250"
                    frameBorder={0}>
                </iframe>
            </div>
        </div>
    )
}