import {
    serverMetadataService as realService,
    ServerMetadata
} from './serverMetadataService';
import { sleepRandom } from 'util/sleep';
import { randomInt } from 'util/random';

export const serverMetadataService: typeof realService = {
    async getServerMetadata(): Promise<ServerMetadata> {
        await sleepRandom();
        return {
            isUp: Math.random() > 0.5,
            online: randomInt(12, 100),
            peakOnline: randomInt(50, 300),
            accountCount: randomInt(50, 500),
        }
    }
}