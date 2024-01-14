$info_file = "info.txt"
$output_file = "passwords.txt"

# Run the netsh command and filter for lines containing "All User Profile"
$profileNames = netsh.exe wlan show profiles | Where-Object { $_ -match "All User Profile" } | ForEach-Object {
    # Split each line and get the profile name (last element)
    $_ -split ':' | ForEach-Object { $_.Trim() }[-1]
} | Where-Object { $_ -ne "All User Profile" }

# Save the profile names to the info file
$profileNames | Out-File -FilePath $info_file

# Loop through each profile name
foreach ($profileName in $profileNames) {
    # Run netsh command for each profile name
    $output = netsh.exe wlan show profiles name="$profileName" key=clear

    # Append the output to the passwords.txt file
    Add-Content -Path $output_file -Value $output
}
