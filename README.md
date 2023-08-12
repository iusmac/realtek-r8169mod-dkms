# r8169 RealTek 8169/8168/8101 Ethernet driver

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/iusmac/realtek-r8169mod-dkms?sort=semver&style=for-the-badge&logo=hackthebox&color=blue&logoColor=aliceblue) ![Kernel support](https://img.shields.io/badge/5.19.x%20%E2%80%94%206.2.x-blue?style=for-the-badge&logo=linux&label=KERNEL&color=green)

This driver is a mod of the _in-tree_ driver `r8169`, incorporating (mainly) all patch fixes from Linux kernel 6.5. Since it's distributed in DKMS way, the driver will survive even after a kernel upgrade.

## Rationale

This RealTek network card may become completely inaccessible due to [ASPM](https://en.wikipedia.org/wiki/Active_State_Power_Management)-related issues, leading to the following behavior:
<details><summary>1. Random RealTek network card timeout (no internet at all)</summary>

```log
NETDEV WATCHDOG: eno1 (r8169): transmit queue 0 timed out
```

<details><summary>and a WATCHDOG warning (tl;dr)</summary>

```log
WARNING: CPU: 4 PID: 0 at net/sched/sch_generic.c:525 dev_watchdog+0x21f/0x230
Modules linked in: rfcomm xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc ccm nvidia_uvm(POE) overlay cmac algif_hash algif_skcipher af_alg bnep snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio zram intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel nvidia_drm(POE) nvidia_modeset(POE) snd_sof_pci_intel_cnl kvm irqbypass snd_sof_intel_hda_common crct10dif_pclmul polyval_clmulni polyval_generic soundwire_intel ghash_clmulni_intel sha512_ssse3 soundwire_generic_allocation aesni_intel crypto_simd cryptd soundwire_cadence snd_sof_intel_hda rapl nvidia(POE) binfmt_misc snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils rtw88_8822be snd_soc_hdac_hda rtw88_8822b snd_hda_ext_core rtw88_pci snd_soc_acpi_intel_match snd_soc_acpi rtw88_core soundwire_bus mei_pxp mei_hdcp intel_rapl_msr nls_iso8859_1
 intel_cstate snd_soc_core i915 snd_hda_codec_hdmi snd_compress ac97_bus mac80211 snd_pcm_dmaengine hp_wmi sparse_keymap platform_profile serio_raw intel_wmi_thunderbolt cmdlinepart wmi_bmof uvcvideo snd_hda_intel spi_nor videobuf2_vmalloc snd_intel_dspcfg snd_seq_midi videobuf2_memops snd_intel_sdw_acpi mtd videobuf2_v4l2 drm_buddy cfg80211 snd_seq_midi_event snd_hda_codec btusb ttm snd_rawmidi libarc4 videodev btrtl snd_hda_core ee1004 drm_display_helper input_leds snd_hwdep btbcm btintel snd_seq videobuf2_common btmtk cec snd_seq_device snd_pcm mc joydev snd_timer bluetooth processor_thermal_device_pci_legacy rc_core processor_thermal_device ecdh_generic snd hid_multitouch ecc processor_thermal_rfim mei_me mei processor_thermal_mbox drm_kms_helper processor_thermal_rapl ucsi_acpi i2c_algo_bit soundcore intel_rapl_common syscopyarea typec_ucsi sysfillrect sysimgblt int3403_thermal intel_soc_dts_iosf typec intel_pch_thermal int340x_thermal_zone int3400_thermal mac_hid
 acpi_thermal_rel hp_accel acpi_tad acpi_pad wireless_hotkey lis3lv02d sch_fq_codel msr parport_pc ppdev lp parport ramoops drm reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic xor raid6_pq libcrc32c hid_lenovo usbhid uas usb_storage hid_generic nvme i2c_i801 spi_intel_pci alcor crc32_pclmul i2c_smbus spi_intel r8169 intel_lpss_pci nvme_core ahci alcor_pci realtek intel_lpss nvme_common xhci_pci libahci idma64 xhci_pci_renesas i2c_hid_acpi i2c_hid hid video wmi pinctrl_cannonlake
CPU: 4 PID: 0 Comm: swapper/4 Tainted: P           OE      6.2.0-26-generic #26~22.04.1-Ubuntu
Hardware name: HP HP Pavilion Gaming Laptop 15-dk0xxx/85FC, BIOS F.33 07/16/2020
RIP: 0010:dev_watchdog+0x21f/0x230
Code: 00 e9 31 ff ff ff 4c 89 e7 c6 05 f5 a9 78 01 01 e8 c6 ff f7 ff 44 89 f1 4c 89 e6 48 c7 c7 08 30 a4 9e 48 89 c2 e8 31 0b 2c ff <0f> 0b e9 22 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffb663c024ce70 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff9788d4e344c8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffb663c024ce98 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff9788d4e34000
R13: ffff9788d4e3441c R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff978a36500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff88cae828 CR3: 000000021c810003 CR4: 00000000003706e0
Call Trace:
 <IRQ>
 ? __pfx_dev_watchdog+0x10/0x10
 call_timer_fn+0x29/0x160
 ? __pfx_dev_watchdog+0x10/0x10
 __run_timers.part.0+0x1fb/0x2b0
 ? ktime_get+0x43/0xc0
 ? __pfx_tick_sched_timer+0x10/0x10
 ? lapic_next_deadline+0x2c/0x50
 ? clockevents_program_event+0xb2/0x140
 run_timer_softirq+0x2a/0x60
 __do_softirq+0xda/0x330
 ? hrtimer_interrupt+0x12b/0x250
 __irq_exit_rcu+0xa2/0xd0
 irq_exit_rcu+0xe/0x20
 sysvec_apic_timer_interrupt+0x96/0xb0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1b/0x20
RIP: 0010:cpuidle_enter_state+0xde/0x6f0
Code: a6 31 62 e8 b4 5f 45 ff 8b 53 04 49 89 c7 0f 1f 44 00 00 31 ff e8 72 3e 44 ff 80 7d d0 00 0f 85 e8 00 00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 0f 02 00 00 4d 63 ee 49 83 fd 09 0f 87 c4 04 00 00
RSP: 0018:ffffb663c015fe28 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffd663bfd00000 RCX: 0000000000000000
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffb663c015fe78 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff9f4c22c0
R13: 0000000000000008 R14: 0000000000000008 R15: 00000037353ef2ee
 ? cpuidle_enter_state+0xce/0x6f0
 cpuidle_enter+0x2e/0x50
 cpuidle_idle_call+0x14f/0x1e0
 do_idle+0x82/0x110
 cpu_startup_entry+0x20/0x30
 start_secondary+0x122/0x160
 secondary_startup_64_no_verify+0xe5/0xeb
 </TASK>
```
</details>
</details>

<details><summary>2. Automatic attempt to reach the RealTek card fails and the <code>r8169</code> driver hangs forever</summary>

```log
r8169 0000:03:00.0 eno1: rtl_chipcmd_cond == 1 (loop: 100, delay: 100).
r8169 0000:03:00.0 eno1: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
r8169 0000:03:00.0 eno1: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
r8169 0000:03:00.0 eno1: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
r8169 0000:03:00.0 eno1: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
r8169 0000:03:00.0 eno1: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
r8169 0000:03:00.0 eno1: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
r8169 0000:03:00.0 eno1: rtl_eriar_cond == 1 (loop: 100, delay: 100).
r8169 0000:03:00.0 eno1: rtl_eriar_cond == 1 (loop: 100, delay: 100).
r8169 0000:03:00.0 eno1: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[...]
```
</details>

<details><summary>3. Manual intervention via <code>rmmod/modprobe r8169</code> fails to bring back this RealTek network card</summary>

```log
r8169 0000:03:00.0: Unable to change power state from D3cold to D0, device inaccessible
r8169 0000:03:00.0: Mem-Wr-Inval unavailable
r8169 0000:03:00.0: unknown chip XID fcf, contact r8169 maintainers (see MAINTAINERS file)
```
</details>

Eventually a system reboot is required to fix the RealTek network card deadlock.

## Requirements
Linux kernel 5.19.x — 6.2.x

## Installation

<b>* Kernel source or headers are required to compile this module *</b>

Download the latest Debian package from the Releases section on the Github repository.

Use `dpkg -i` to install the _.deb_ package, for example:

```bash
sudo dpkg -i realtek-r8169mod-dkms_1.0-0_all.deb
```

If dependency error occurs, try to fix that with apt command.

```bash
sudo apt install --fix-broken
```

Note: installation of the `realtek-r8169mod-dkms` package will replace the _in-tree_ `r8169` module with the _out-of-tree_ `r8169mod` module. To re-enable `r8169`, the `realtek-r8169mod-dkms` package must be purged.

## Verify the module is loaded successfully

After installing the DKMS package, you may not be able to use the `r8169mod` module on the fly. This because the `r8169` is an _in-tree_ module and will be loaded priority to the _out-of-tree_ `r8169mod` module, so that it prevents working of the `r8169mod` module.

Check if the `r8169` module loaded currently.

```bash
lsmod | grep -i r8169
```

If there is a result, maybe the `r8169mod` module wasn't loaded properly. You can check out modules currently in use via `lspci -k` or `dmesg` too.

To prevent `r8169` from loading and switch to the `r8169mod` module explicitly, check out the _blacklist_ section in the `/etc/modprobe.d/realtek-r8169mod-dkms.conf` file that was installed with the DKMS package.

To apply the new blacklist to your kernel, update your initramfs via 

```bash
sudo update-initramfs -u
```

Finally, reboot to take effect.

## Debian package build
You can build yourself this after installing some dependencies including dkms.

```bash
sudo apt install devscripts debmake debhelper build-essential dkms
```

```bash
dpkg-buildpackage -b -rfakeroot -us -uc
```
