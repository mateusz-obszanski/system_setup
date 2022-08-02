# run this file as administrator

# enable syncing time on startup - necessary with dual-booting with Linux
# if no such service is found, run `Get-Service` to find a similar one,
# because it could be renamed
# To trigger time sync manually, `use  W32tm /resync /force`.
# It might be a good idea to trigger this at boot by adding it to windows
# shell profile.
Set-Service -Name W32Time -Status running -StartupType Boot
