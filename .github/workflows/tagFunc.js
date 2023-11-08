module.exports = ({ github, context }) => {
    const issueSummary = context.issue;
    const issueFull = context.payload.issue;
    console.log('GitHub issue opened', { issueSummary, issueFull });

    // github.rest.issue.update({
    //     issue_number: context.issue.number,
    //     owner: context.repo.owner,
    //     repo: context.repo.repo,
    // })
    // github.rest.issues.addLabels({
    //     issue_number: context.issue.number,
    //     owner: context.repo.owner,
    //     repo: context.repo.repo,
    //     labels: ['']
    // })
}