#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71102464:b2a6dd0f502a649bb868f623c7a4809f48494927; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):61865984:2aa39211619920fbffc749abefbd51538ab19998 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71102464:b2a6dd0f502a649bb868f623c7a4809f48494927 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

