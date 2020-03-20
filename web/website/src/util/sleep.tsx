import { randomInt } from "./random";

export function sleep(delayInMs: number): Promise<void> {
    return new Promise((resolve, _) => {
        setTimeout(resolve, delayInMs);
    })
}

export function sleepRandom(): Promise<void> {
    return sleep(randomInt(100, 500));
}

