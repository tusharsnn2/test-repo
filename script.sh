for base_pr_id in $(gh pr list --search "head:$BASE_PR_REF" --json number --jq '.[].number'); do
    if [ $MAIN_BRANCH_NAME == "$( gh pr view $base_pr_id --json baseRefName  --jq '.baseRefName')" ]; then
        gh pr ready $base_pr_id --undo
    fi
done