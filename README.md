# kernel_compiler_patch

There are two primary types of compiler patches written to add -march= options to the linux kernel hosted here.
1. A patch that introduces the -march=x86-64-v[2,3,4] options.  It is named lite-more-uarches-*.patch
2. A patch that introduces the above in addition to specific values unique to processor families and an option that introduces the -march=native option.  It is named more-uarches-*.patch

Once applied to a kernel source tree, these options are accessible under:
```
 Processor type and features  --->
 Processor family --->
```
## Why a specific patch?
The kernel uses its own set of CFLAGS, KCFLAGS. For example, see:
* [arch/x86/Makefile](https://github.com/torvalds/linux/blob/master/arch/x86/Makefile)
* [arch/x86/Makefile_32.cpu](https://github.com/torvalds/linux/blob/master/arch/x86/Makefile_32.cpu)
* [arch/x86/Kconfig.cpu](https://github.com/torvalds/linux/blob/master/arch/x86/Kconfig.cpu)


### Alternative way to define a -march= option without this patch
As pointed out by codemac in [this topic](https://bbs.archlinux.org/viewtopic.php?id=281639), one can simply export the value/values for the `KCFLAGS` and `KCPPFLAGS` before calling `make` to achieve the same result, see [here](https://github.com/torvalds/linux/blob/88603b6dc419445847923fcb7fe5080067a30f98/Makefile#L1112).
```
export KCFLAGS=' -march=znver3 -mtune=znver3'
export KCPPFLAGS=' -march=znver3 -mtune=znver3'
make all
```

## Expanded CPUs include
<table>
  <tr>
    <th>CPU Family</th>
    <th>-march=</th>
    <th>Min GCC Ver</th>
    <th>Min Clang Ver</th>
  </tr>
  <tr>
    <td>Native optimizations autodetected by GCC</td>
    <td>native</td>
    <td>4.2</td>
    <td>3.8</td>
  </tr>
  <tr>
    <td>Generic 64-bit level v2</td>
    <td>x86-64-v2</td>
    <td>11.1</td>
    <td>12.0</td>
  </tr>
  <tr>
    <td>Generic 64-bit level v3</td>
    <td>x86-64-v3</td>
    <td>11.1</td>
    <td>12.0</td>
  </tr>
  <tr>
    <td>Generic 64-bit level v4</td>
    <td>x86-64-v4</td>
    <td>11.1</td>
    <td>12.0</td>
  </tr>
  <tr>
    <td>AMD Improved K8-family</td>
    <td>k8-sse3</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD K10-family</td>
    <td>amdfam10</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD Family 10h (Barcelona)</td>
    <td>barcelona</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD Family 14h (Bobcat)</td>
    <td>btver1</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD Family 16h (Jaguar)</td>
    <td>btver2</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD Family 15h (Bulldozer)</td>
    <td>bdver1</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD Family 15h (Piledriver)</td>
    <td>bdver2</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD Family 15h (Steamroller)</td>
    <td>bdver3</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD Family 15h (Excavator)</td>
    <td>bdver4</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD Family 17h (Zen)</td>
    <td>znver1</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD Family 17h (Zen 2)</td>
    <td>znver2</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>AMD Family 19h (Zen 3)</td>
    <td>znver3</td>
    <td>10.3</td>
    <td>12.0</td>
  </tr>
  <tr>
    <td>AMD Family 19h (Zen 4)</td>
    <td>znver4</td>
    <td>13.0</td>
    <td>17.0</td>
  </tr>
  <tr>
    <td>AMD Family 19h (Zen 5)</td>
    <td>znver5</td>
    <td>14.1</td>
    <td>???</td>
  </tr>
  <tr>
    <td>Intel Bonnell family Atom</td>
    <td>bonnell</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel Silvermont family Atom</td>
    <td>silvermont</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel Goldmont family Atom (Apollo Lake and Denverton)</td>
    <td>goldmont</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel Goldmont Plus family Atom (Gemini Lake)</td>
    <td>goldmont-plus</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel 1st Gen Core i3/i5/i7-family (Nehalem)</td>
    <td>nehalem</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel 1.5 Gen Core i3/i5/i7-family (Westmere)</td>
    <td>westmere</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel 2nd Gen Core i3/i5/i7-family (Sandybridge)</td>
    <td>sandybridge</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel 3rd Gen Core i3/i5/i7-family (Ivybridge)</td>
    <td>ivybridge</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel 4th Gen Core i3/i5/i7-family (Haswell)</td>
    <td>haswell</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel 5th Gen Core i3/i5/i7-family (Broadwell)</td>
    <td>broadwell</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel 6th Gen Core i3/i5/i7-family (Skylake)</td>
    <td>skylake</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel 6th Gen Core i7/i9-family (Skylake X)</td>
    <td>skylake-avx512</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel 8th Gen Core i3/i5/i7-family (Cannon Lake)</td>
    <td>cannonlake</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel 10th Gen Core i7/i9-family (Ice Lake)</td>
    <td>icelake-client</td>
    <td>9.3</td>
    <td>9.0</td>
  </tr>
  <tr>
    <td>Intel Xeon (Cascade Lake)</td>
    <td>cascadelake</td>
    <td>10.2</td>
    <td>10.0</td>
  </tr>
  <tr>
    <td>Intel Xeon (Cooper Lake)</td>
    <td>cooperlake</td>
    <td>10.2</td>
    <td>10.0</td>
  </tr>
  <tr>
    <td>Intel 3rd Gen 10nm++ i3/i5/i7/i9-family (Tiger Lake)</td>
    <td>cooperlake</td>
    <td>10.2</td>
    <td>10.0</td>
  </tr>
  <tr>
    <td>Intel 4th Gen 10nm++ Xeon (Sapphire Rapids)</td>
    <td>sapphirerapids</td>
    <td>11.1</td>
    <td>12.0</td>
  </tr>
  <tr>
    <td>Intel 11th Gen i3/i5/i7/i9-family (Rocket Lake)</td>
    <td>rocketlake</td>
    <td>11.1</td>
    <td>12.0</td>
  </tr>
  <tr>
    <td>Intel 12th Gen i3/i5/i7/i9-family (Alder Lake)</td>
    <td>alderlake</td>
    <td>11.1</td>
    <td>12.0</td>
  </tr>
  <tr>
    <td>Intel 13th Gen i3/i5/i7/i9-family (Raptor Lake)</td>
    <td>raptorlake</td>
    <td>13.0</td>
    <td>15.0.5</td>
  </tr>
  <tr>
    <td>Intel 5th Gen 10nm++ Xeon (Emerald Rapids)</td>
    <td>emeraldrapids</td>
    <td>13.0</td>
    <td>???</td>
  </tr>
</table>

# Benchmarks
## Setup
A test machine with an AMD Ryzen 9 5950X CPU was used to measure the time it took to `make -j33 bzImage` of the linux kernel source v6.10.10 (`.config` generated by `make x86_64_defconfig` prior).

Three separate kernels (v6.10.10) were first compiled from source patched with [more-uarches-for-kernel-6.8-rc4+.patch](https://github.com/graysky2/kernel_compiler_patch/blob/master/more-uarches-for-kernel-6.8-rc4%2B.patch).
* Kernel 1 used the default menu config option for Processor family = `Generic-x86-64`
* Kernel 2 used the menu config option for Processor family = `AMD-x86-64-v3`
* Kernel 3 used the menu config option for Processor family = `AMD Zen 3`

The machine was booted into each kernel and the make test was conducted.  Then the next kernel was installed and the machine was booted into it to run the test.

## Conclusion
Both of the kernels built with the optimized processor family (AMD-x86-v3 and AMD Zen 3) ran the compile test faster than the kernel compiled with the default processor family (x86-64) by a small but statistically significant amount as measured by this make compilation.

## Discussion
1. All the assumptions for ANOVA are met:
	* Data are normally distributed
	* The population variances are fairly equal
2. The boxplot plot clearly show significance for either pair-wise comparison (x86-64 vs x86-64-v3 or znver3)
	* Pair-wise analysis by Tukey-Kramer shows significance at the p<0.001 level

In other words, x86-64-v3 is significantly different from x86-64 and znver3 is significantly different from x86-64, but x86-64-v3 is not different from znver3.

### Stats
<table>
  <tr>
    <th>Processor family</th>
    <th>Mean compile time</th>
    <th>Std dev</th>
    <th># of replicates</th>
  </tr>
  <tr>
    <td>x86-64 generic</td>
    <td>79.8001 sec</td>
    <td>0.1076 sec</td>
    <td>12</td>
  </tr>
  <tr>
    <td>AMD-x64-64-v3</td>
    <td>79.4559 sec</td>
    <td>0.0772 sec</td>
    <td>12</td>
  </tr>
  <tr>
    <td>AMD Zen 3</td>
    <td>79.4400 sec</td>
    <td>0.0912 sec</td>
    <td>12</td>
  </tr>
</table>

### Box plot
![X9550](https://github.com/graysky2/kernel_compiler_patch/blob/master/benchmark/boxplot.svg)

## References
* Bash script that controls the benchmark: https://github.com/graysky2/bin/blob/master/make_bench.sh
* Log file generated by script: [results.csv](https://github.com/graysky2/kernel_compiler_patch/blob/master/benchmark/results.csv)

## Credit
* Original author: jeroen AT linuxforge DOT net
* Link to original version: http://www.linuxforge.net/docs/linux/linux-gcc.php
* Box plot generated with [statisty.app](https://statisty.app/anova-calculator)

## Legacy support
Find support for older version of the linux kernel and of gcc in the outdated_versions directory.
