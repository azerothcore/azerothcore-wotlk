export function classNames(
    ...classNameOrFalse: Array<string | false>
): string {
    let output = '';

    for (let index = 0; index < classNameOrFalse.length; index++) {
        const element = classNameOrFalse[index];
        if (element === false) {
            continue;
        } else {
            output += ` ${element}`;
        }
    }

    return output;
}