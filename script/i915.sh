for driver in skl_guc_49.0.1.bin bxt_guc_49.0.1.bin kbl_guc_49.0.1.bin glk_guc_49.0.1.bin kbl_guc_49.0.1.bin kbl_guc_49.0.1.bin cml_guc_49.0.1.bin icl_guc_49.0.1.bin ehl_guc_49.0.1.bin ehl_guc_49.0.1.bin tgl_huc_7.5.0.bin tgl_guc_49.0.1.bin tgl_huc_7.5.0.bin tgl_guc_49.0.1.bin dg1_dmc_ver2_02.bin
do
sudo wget -O /lib/firmware/i915/$driver https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/$driver
done
sudo update-initramfs -k all -c
