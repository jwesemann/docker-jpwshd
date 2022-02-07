# https://dev.to/rhymu/git-renaming-the-master-branch-137b

# 1) Rename your local branch
git branch -m master main

# 2) Push renamed branch upstream and set remote tracking branch
git push -u origin main

Write-Output "3) Now log into the upstream repository host (GitHub, GitLab, Bitbucket, etc.) and change the 'default' branch."

# Wait here for key press
Write-Output ""
Write-Output "Press any key to continue"
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# 4) Delete the old branch upstream
git push origin --delete master

# 5) Update the upstream remote's HEAD
git remote set-head origin -a


<#

That's covers it on your end and where your repository is hosted. Now what do you have to do if it's someone else's repo which renamed a branch, and you're left holding a "dangling" reference (so to speak) to a remote branch that no longer exists?

If you know the branch was renamed, there's nothing to fear. The following steps will get you back on track:

1)    Fetch the latest branches from the remote.

    git fetch --all

2)   Update the upstream remote's HEAD.

    git remote set-head origin -a

3)    Switch your local branch to track the new remote branch.

    git branch --set-upstream-to origin/main

4)  Rename your branch locally.

    git branch -m master main

That's it! Note that it gets much simpler if you have no remote/upstream. It's just git branch -m master main to rename a branch. The other commands are all concerned about matching local branches to remote ones (via tracking branches) and updating the HEAD reference to point to the "default" branch.

#>