module.exports = (type, input) => {
    console.log('Checking version/tag', { type, input })
    if (type === 'tag') return (input ?? 'nightly').toLowerCase()
    else if (type 'version') return (input ?? 'Nightly')
    else throw new Error('Type must be either "tag" or "version"')
}