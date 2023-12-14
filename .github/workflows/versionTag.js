module.exports = async (type, input) => {
    try {
        console.log('Checking '+type, input)
        if (type === 'tag') return (input ?? 'nightly').toLowerCase()
        else if (type === 'version') return (input ?? 'Nightly')
        else throw new Error('Type must be either "tag" or "version"')
    }
    catch(err) {
        console.warn(err);
        return 'nightly'
    }
}