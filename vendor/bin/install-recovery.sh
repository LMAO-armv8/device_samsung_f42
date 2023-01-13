#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71102464:14cba7a63c51ef44e511bb8d832fe8e5884d66cf; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):61865984:c5a0958584a2f511e930ff8cc0677bb775ab43a3 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71102464:14cba7a63c51ef44e511bb8d832fe8e5884d66cf && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

