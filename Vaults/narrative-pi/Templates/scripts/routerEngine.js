function processRouting(fileName, personalFolder, workFolder) {
    const day = new Date().getDay();
    const isWeekend = (day === 6 || day === 0); // 6 = Saturday, 0 = Sunday
    
    // Choose the target folder based on the day
    const destinationFolder = isWeekend ? personalFolder : workFolder;
    
    // Return a clean routing string path
    return {
        folder: destinationFolder,
        fullPath: `/${destinationFolder}/${fileName}`
    };
}

module.exports = processRouting;
