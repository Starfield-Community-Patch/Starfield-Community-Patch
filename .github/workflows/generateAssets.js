module.exports = async ({ github, context }) => {
    const fs = require('fs/promises');
    const path = require('path');
    const directory = await fs.readdir(path.join('./',__dirname));
    console.log('Directory', { directory });
    
}