import { useRef, useCallback, useEffect } from 'react';

export function useInterval(
    callback: () => void,
    delay: number
) {
    const savedCallback = useRef<() => void>();

    // Remember the latest function.
    useEffect(() => {
        savedCallback.current = callback;
    }, [callback]);

    // Set up the interval.
    useEffect(() => {
        function tick() {
            savedCallback.current!();
        }
        if (delay !== null) {
            let id = setInterval(tick, delay);
            return () => clearInterval(id);
        }
    }, [delay]);
}