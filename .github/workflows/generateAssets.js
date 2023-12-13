module.exports = async ({ github, context }) => {
    const fs = require('fs');
    const path = require('path');
    const directory = fs.readdir(path.join('./',__dirname));
    console.log('Directory', { directory });
    
}