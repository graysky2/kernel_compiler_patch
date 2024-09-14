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
export KCFLAGS=' -march=znver3'
export KCPPFLAGS=' -march=znver3'
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

The test machine measured the time it took to `make bzImage` of the linux kernel source v6.10.10 (`.config` generated by `make x86_64_defconfig` prior).

Three separate test machines were evaluated:
1. AMD Ryzen 9 5950X
2. Intel i7-4790K
3. Intel N100

Separate kernels (v6.10.10) were first compiled from source patched with [more-uarches-for-kernel-6.8-rc4+.patch](https://github.com/graysky2/kernel_compiler_patch/blob/master/more-uarches-for-kernel-6.8-rc4%2B.patch).
* Kernel 1 used the default menu config option for Processor family = `Generic x86-64`
* Kernel 2 used the menu config option for Processor family = `AMD x86-64-v3` or `Intel x86-64-v3`
* Kernel 3 used the menu config option for Processor family = `AMD Zen 3` or `Intel Haswell` or `Intel Alder Lake`

Each machine was booted into its respective kernel and the make test was conducted.  Then the next kernel was installed and the machine was booted into it and the make test was again conducted.

## Conclusion
Consistently across all three test machines, the kernels built with the optimized processor family options introduced by the patch hosted in this repo ran the compile test faster than the kernel compiled with the default processor family option by a small (<1% difference) but statistically significant amount as measured by this make compilation.

## Discussion
1. All the assumptions for ANOVA are met:
	* Data are normally distributed
	* The population variances are fairly equal
2. The boxplot plot clearly show significance for either pair-wise comparison
	* Pair-wise analysis by Tukey-Kramer data shown for all pairs (see tables)

In other words, x86-64-v3 is significantly different from generic x86-64. The various subtargets are also significantly different from x86-64.

### Stats for Machine 1. AMD Ryzen 9 X5950
<table>
  <tr>
    <th>Processor family option</th>
    <th>Mean compile time</th>
    <th>Std dev</th>
    <th># of replicates</th>
  </tr>
  <tr>
    <td>Generic x86-64</td>
    <td>79.800 sec</td>
    <td>0.1076 sec</td>
   <td>12</td>
  </tr>
  <tr>
    <td>AMD x86-64-v3</td>
    <td>79.456 sec</td>
    <td>0.0772 sec</td>
    <td>12</td>
  </tr>
  <tr>
    <td>AMD Zen 3</td>
    <td>79.440 sec</td>
    <td>0.0912 sec</td>
    <td>12</td>
  </tr>
</table>

![X9550](https://github.com/graysky2/kernel_compiler_patch/blob/master/benchmark/boxplot1.svg)

<table>
  <tr>
    <th>Treatment pairs</th>
    <th>Tukey HSD Q stat</th>
    <th>Tukey HSD p-value</th>
    <th>Tukey HSD interfence</th>
  </tr>
  <tr>
    <td>Generic x86-64 vs AMD x86-64-v3</td>
    <td>12.8771</td>
    <td>0.0010053</td>
    <td>** p<0.01</tr>
  </tr>
  <tr>
    <td>Generic x86-64 vs AMD Zen 3</td>
    <td>13.4675</td>
    <td>0.0010053</td>
    <td>** p<0.01</tr>
  </tr>
  <tr>
    <td>AMD x86-64-v3 vs AMD Zen 3</td>
    <td>9.6524</td>
    <td>0.8999947</td>
    <td>insignificant</tr>
  </tr>
</table>

### Stats for Machine 2. Intel i7-4790K
<table>
  <tr>
    <th>Processor family option</th>
    <th>Mean compile time</th>
    <th>Std dev</th>
    <th># of replicates</th>
  </tr>
  <tr>
    <td>Generic x86-64</td>
    <td>344.280 sec</td>
    <td>0.6455 sec</td>
    <td>12</td>
  </tr>
  <tr>
    <td>Intel x86-64-v3</td>
    <td>342.035 sec</td>
    <td>0.4971 sec</td>
    <td>12</td>
  </tr>
  <tr>
    <td>Intel Haswell</td>
    <td>342.189 sec</td>
    <td>0.2415 sec</td>
    <td>12</td>
  </tr>
</table>

![i7-4790k](https://github.com/graysky2/kernel_compiler_patch/blob/master/benchmark/boxplot2.svg)

<table>
  <tr>
    <th>Treatment pairs</th>
    <th>Tukey HSD Q stat</th>
    <th>Tukey HSD p-value</th>
    <th>Tukey HSD interfence</th>
  </tr>
  <tr>
    <td>Generic x86-64 vs Intel x86-64-v3</td>
    <td>28.9652</td>
    <td>0.0010053</td>
    <td>** p<0.01</tr>
  </tr>
  <tr>
    <td>Generic x86-64 vs Intel Haswell</td>
    <td>24.8335</td>
    <td>0.0010053</td>
    <td>** p<0.01</tr>
  </tr>
  <tr>
    <td>Intel x86-64-v3 vs Intel Haswell</td>
    <td>4.1317</td>
    <td>0.0167155</td>
    <td>* p<0.05</tr>
  </tr>
</table>

### Stats for Machine 3. Intel N100
<table>
  <tr>
    <th>Processor family option</th>
    <th>Mean compile time</th>
    <th>Std dev</th>
    <th># of replicates</th>
  </tr>
  <tr>
    <td>Generic x86-64</td>
    <td>589.457 sec</td>
    <td>0.1596 sec</td>
    <td>12</td>
  </tr>
  <tr>
    <td>Intel x86-64-v3</td>
    <td>589.217 sec</td>
    <td>0.1382  sec</td>
    <td>12</td>
  </tr>
  <tr>
    <td>Intel Alder Lake</td>
    <td>588.797 sec</td>
    <td>0.1532  sec</td>
    <td>12</td>
  </tr>
</table>

![N100](https://github.com/graysky2/kernel_compiler_patch/blob/master/benchmark/boxplot3.svg)

<table>
  <tr>
    <th>Treatment pairs</th>
    <th>Tukey HSD Q stat</th>
    <th>Tukey HSD p-value</th>
    <th>Tukey HSD interfence</th>
  </tr>
  <tr>
    <td>Generic x86-64 vs Intel x86-64-v3</td>
    <td>5.5076</td>
    <td>0.0012818</td>
    <td>** p<0.01</tr>
  </tr>
  <tr>
    <td>Generic x86-64 vs Intel Alder Lake</td>
    <td>15.1600</td>
    <td>0.0010053</td>
    <td>** p<0.01</tr>
  </tr>
  <tr>
    <td>Intel x86-64-v3 vs Intel Alder Lake</td>
    <td>9.6524</td>
    <td>0.0010053</td>
    <td>** p<0.01</tr>
  </tr>
</table>

## References
* Bash script that controls the benchmark: https://github.com/graysky2/bin/blob/master/make_bench.sh
* Log file generated by script: [results.csv](https://github.com/graysky2/kernel_compiler_patch/blob/master/benchmark/results.csv)

## Credit
* Original author: jeroen AT linuxforge DOT net
* Link to original version: http://www.linuxforge.net/docs/linux/linux-gcc.php
* Box plot generated with [statisty.app](https://statisty.app/anova-calculator)
* ANOVA stats generated with [astatsa.com](https://astatsa.com/OneWay_Anova_with_TukeyHSD/)

## Legacy support
Find support for older version of the linux kernel and of gcc in the outdated_versions directory.
