module.exports = ({ github, context }) => {
    console.log('GitHub issue opened', { context, github, issue: context.issue });
    
}