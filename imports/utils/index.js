// merge :: [Object] -> Object
export const merge = (...objects) => Object.assign({}, ...objects)

// isObjectEmpty :: Object -> Boolean
export const isObjectEmpty = obj => Object.keys(obj).length === 0 && obj.constructor === Object
