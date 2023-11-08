module.exports = async ({ github, context }) => {
    const issueSummary = context.issue; // contains owner, repo, number
    const issue = context.payload.issue; // full object

    // Ignore VASCO, he only posts via the website with labels pre-set.
    if (issue.user.login === 'Constellation-VASCO' || issue.user.login === 'VASCO') {
        console.log('Issue created by VASCO via StarfieldPatch.dev - skipping');
        return;
    }

    let labels = [];

    // Get the issue and split it into lines.
    const splitBody = issue.body.split('\n')
        // .map(l => l.trim()).filter(l => !['', undefined].includes(l));

    const platformLineId = splitBody.findIndex(l => l === '### Platform');
    if (platformLineId !== -1) {
        const platform = splitBody[platformLineId + 2]
        console.log('Detected platform', platform);
        !platform.startsWith('_') 
            ? labels.push(`Platform: ${platform.trim()}`) 
            : null;
    }

    const dlcLineId = splitBody.findIndex(l => l === '### DLCs');
    const categoryLineId = splitBody.findIndex(l => l === '### Category');

    if (dlcLineId !== -1 && categoryLineId !== -1) {
        const dlcs = splitBody.slice(dlcLineId, categoryLineId).filter(d => d.startsWith('- [X]'))
        if (dlcs.length) {
            const dlcLabels = dlcs.map(d => `DLC: ${d.replace('- [X] ', '').trim()}`);
            console.log('Found DLCs', dlcLabels)
            labels = [...dlcLabels, ...labels];
        }
        else console.log('No DLCs detected', splitBody.slice(dlcLineId, categoryLineId))

        const category = splitBody[categoryLineId + 2];
        console.log('Found Category', category)
        !category.startsWith('_')
        ? labels.push(`Type: ${category.trim()}`)
        : null
    }

    const nexusModsIdLine = splitBody.findIndex(l => l === '### Nexus Mods ID (Optional)');
    let nexusModsId = undefined;
    if (nexusModsIdLine !== -1) {
        nxmId = splitBody[nexusModsIdLine + 2].trim();
        if (!isNaN(parseInt(nxmId))) {
            nexusModsId = parseInt(nxmId)
            console.log('Found Nexus Mods ID', nexusModsId)
        }
    }
    else console.log('Nexus Mods ID not found')

    // Apply Labels
    if (labels.length) {
        console.log('Applying labels');
        try {
            await github.rest.issues.addLabels({
                issue_number: context.issue.number,
                owner: context.repo.owner,
                repo: context.repo.repo,
                labels
            })
        }
        catch(err) {
            console.warn('Could not apply labels', err)
            return;
        }
    }
    else console.log('No labels to apply!')

    // Update issue text
    const summaryLine = splitBody.findIndex(l => l === '### Summary');
    if (summaryLine !== -1) {
        let newBody = splitBody.slice(summaryLine + 1).join('\n');
        if (nexusModsId !== undefined) newBody += `\n\n<!-- NexusMods:${nexusModsId} -->`

        try {
            console.log('Updating issue body');
            await github.rest.issues.update({
                issue_number: context.issue.number,
                owner: context.repo.owner,
                repo: context.repo.repo,
                body: newBody,
            })
        }
        catch(err) {
            console.warn('Failed to update issue body', err)            
        }
    }

}