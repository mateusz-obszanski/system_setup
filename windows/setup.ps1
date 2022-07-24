# run this file as administrator

# enable syncing time on startup - necessary with dual-booting with Linux
# if no such service is found, run `Get-Service` to find a similar one,
# because it could be renamed
Set-Service -Name W32Time -Status running -StartupType automatic
