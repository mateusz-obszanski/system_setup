# Setup systemd to dual-boot with Windows

Install [rEFInd](https://www.rodsbooks.com/refind/)

**or**

Execute those steps ([https://unix.stackexchange.com/a/628581]):

- Find Windows EFI Partition

`lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT`

- Create Path & Mount Windows EFI Partition

```
sudo mkdir /mnt/win-efi
sudo mount /dev/<found-EFI-partition> /mnt/win-efi
```

- Copy Contents of Windows EFI to POP EFI

`sudo cp -r /mnt/win-efi/EFI/Microsoft /boot/efi/EFI`

- Add timer to bootloader

`sudo <your-text-editor> /boot/efi/loader/loader.conf`

and add a new line timeout 5 or any number of seconds to loader.conf

- Reboot

`sudo reboot`

