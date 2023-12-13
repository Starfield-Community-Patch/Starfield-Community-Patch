module.exports = async ({ github, context }) => {
    const fs = require('fs/promises');
    const path = require('path');
    const folderPath = path.join('../../',__dirname)
    const directory = await fs.readdir(folderPath);
    console.log('Directory', { folderPath, directory });
    
}