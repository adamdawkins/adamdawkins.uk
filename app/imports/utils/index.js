// merge :: [Object] -> Object
export const merge = (...objects) => Object.assign({}, ...objects)

// isObjectEmpty :: Object -> Boolean
export const isObjectEmpty = obj => Object.keys(obj).length === 0 && obj.constructor === Object

/* isNotFilledArray :: any -> Boolean
 * checks if the arg is not an array with something in it (it could be anything else, or nothing)
 */
export const isNotFilledArray = x => (!Array.isArray(x) || !x.length)

/* isFilledArray :: any -> Boolean
 * returns true if the passed argument is an array with at least one item in it.
 */
export const isFilledArray = x => !isNotFilledArray(x)

