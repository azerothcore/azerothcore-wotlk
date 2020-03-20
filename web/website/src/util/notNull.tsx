export function notNull<T>(obj: T | null): T {
    if (obj === null) {
        throw new Error()
    }
    return obj;
}