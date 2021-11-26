Build Linux Kernel 
====================================================================================

## Download Repository

```console
shell$ git clone --depth=1 --branch v2021.1.1 https://github.com/ikwzm/ZynqMP-FPGA-Linux.git
shell$ cd ZynqMP-FPGA-Linux
shell$ git lfs pull
shell$ cd ..
```

## Copy linux kernel image

### Ultra96

```console
shell$ cp ZynqMP-FPGA-Linux/target/Ultra96/boot/image-*-v2021.1-*      target/Ultra96/boot/
shell$ cp ZynqMP-FPGA-Linux/target/Ultra96/boot/devicetree-*-v2021.1-* target/Ultra96/boot/
```

### Ultra96-V2

```console
shell$ cp ZynqMP-FPGA-Linux/target/Ultra96-V2/boot/image-*-v2021.1-*      target/Ultra96-V2/boot/
shell$ cp ZynqMP-FPGA-Linux/target/Ultra96-V2/boot/devicetree-*-v2021.1-* target/Ultra96-V2/boot/
```

### Kv260

```console
shell$ cp ZynqMP-FPGA-Linux/target/Kv260/boot/image-*-v2021.1-*      target/Kv260/boot/
shell$ cp ZynqMP-FPGA-Linux/target/Kv260/boot/devicetree-*-v2021.1-* target/Kv260/boot/
```

## Reference

* https://github.com/ikwzm/ZynqMP-FPGA-Linux
  - https://github.com/ikwzm/ZynqMP-FPGA-Linux/blob/v2021.1.1/doc/build/linux-xlnx-v2021.1-zynqmp-fpga.md
