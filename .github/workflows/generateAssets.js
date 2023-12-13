const DATA_SUBFOLDERS = [
    'Meshes',
    'Textures',
    'FaceGen',
    'Music',
    'Sound',
    'Sounds',
    'MaxHeights',
    'VIS',
    'Grass',
    'Strings',
    'Materials',
    'LODSettings',
    'Misc',
    'ShadersFX',
    'PlanetData',
    'Space',
    'Terrian',
    'GeoExporter',
    'Noise',
    'Particles',
    'Geometries',
    'Scripts',
    'SFSE',
    'LOD',
    'Video',
    'Interface'
];

const ignoredExts = ['.txt', '.cmd', '.exe', '.md'];

const dataFolderLowercase = DATA_SUBFOLDERS.map(f => f.toLowerCase());

const bsArchData = (filePath) => ({
    "Packing": {
        "ArchiveType": 7,
        "ArchiveFileName": filePath,
        "ArchiveFlags": 0,
        "FileFlags": 0,
        "AutodetectFlags": true,
        "MultiThreaded": true,
        "SharedData": true,
    },
    "Assets": []
});


module.exports = async ({ github, context }) => {
    const fs = require('fs/promises');
    const path = require('path');


    // Function to dig into folders

    const getFilePaths = async (parent, sub) => {
        let fileList = [];
        const subfolderPath = path.join(parent, sub);
        const files = await fs.readdir(subfolderPath);
        fileList = files.filter(f => !ignoredExts.includes(path.extname(f)) && !!path.extname(f))
            .map(f => path.join(subfolderPath, f))
        console.log('Files counted', { subfolderPath, count: fileList.length })
        const folders = files.filter(f => !path.extname(f) && f[0] !== ('.'));
        if (folders.length > 0) {
            for (const lvl2folder of folders) {
                const lvl2Files = await getFilePaths(subfolderPath, lvl2folder);
                fileList = [...lvl2Files, ...fileList];
            }
        }
        return fileList;
    }

    // End Function

    const folderPath = path.resolve(__dirname, '..', '..');
    const directory = await fs.readdir(folderPath);
    const packableFolders = directory.filter(f => !path.extname(f) && dataFolderLowercase.includes(f.toLowerCase()))
    console.log('Directory', { folderPath, packableFolders });

    const outputFilePath = path.join(folderPath, 'StarfieldCommunityPatch - Main.ba2');
    const data = bsArchData(outputFilePath);

    let filesToPack = []
    
    for (const folder of packableFolders) {
        const subFolderFiles = await getFilePaths(folderPath, folder)
        filesToPack =  [...subFolderFiles, ...filesToPack];
    }

    console.log('Files found for packing!', { total: filesToPack.length, filesToPack });
    
}