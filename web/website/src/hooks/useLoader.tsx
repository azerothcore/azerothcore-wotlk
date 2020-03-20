import { useState, useEffect, useRef } from 'react';

export function useLoader<T>(
    loader: () => Promise<T>
): T | null {
    const [item, setItem] = useState<T | null>(null);
    const isMounted = useRef(true);

    useEffect(() => {
        loader().then(resp => {
            if (isMounted.current) {
                setItem(resp);
            }
        }).catch(err => {
            console.error('useLoader failed', err);
        })
        return () => {
            isMounted.current = false;
        }
         // eslint-disable-next-line
    }, []);

    return item;
}