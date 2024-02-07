# Set the file name
$file = "myCommits.txt"

# Check if the file exists
if (-not (Test-Path $file)) {
    # Create a new file and append the initial commit message
    Add-Content -Path $file -Value "Commit 1    Date [$((Get-Date).ToString('dd-MM-yyyy'))] Time [$((Get-Date).ToString('hh:mm tt'))]`n"
} else {
    # Append a new commit message to the file
    $commitNumber = ((Get-Content $file) | Measure-Object -Line).Lines + 1
    Add-Content -Path $file -Value "Commit $commitNumber    Date [$((Get-Date).ToString('dd-MM-yyyy'))] Time [$((Get-Date).ToString('hh:mm tt'))]`n"
}

# Pull the latest changes from the remote repository
git pull

# Stage the file for commit
git add $file

# Commit the changes
git commit -m "Add new commit messages"

# Push the changes to the remote repository
git push