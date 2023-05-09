# BASE_PR_REF="test-branch"
# MAIN_BRANCH_NAME="main"
if [ -z "$BASE_PR_REF" ] || [ -z "$MAIN_BRANCH_NAME" ]; then
    echo '$BASE_PR_REF and $MAIN_BRANCH_NAME must be set'
    exit 1
fi

echo "checking if any available PR from head:$BASE_PR_REF -> base:$MAIN_BRANCH_NAME"
for base_pr_id in $(gh pr list --search "head:$BASE_PR_REF" --json number --jq '.[].number'); do
    if [ $MAIN_BRANCH_NAME == "$( gh pr view $base_pr_id --json baseRefName  --jq '.baseRefName')" ]; then
        echo "Marking pr as draft: #$base_pr_id"
        gh pr ready $base_pr_id --undo
    fi
done