import { TODO } from "util/TODO"

export interface ServerMetadata {
    isUp: boolean;
    online: number;
    peakOnline: number;
    accountCount: number;
}

export const serverMetadataService = {
    async getServerMetadata(): Promise<ServerMetadata> {
        TODO();
    }
 }