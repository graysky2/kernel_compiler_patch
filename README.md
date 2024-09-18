# kernel_compiler_patch

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

## New tunings
These patches adds additional tunings via new x86-64 ISA levels and more micro-architecture options to the Linux kernel in three broad classes.

### 1. New generic x86-64 ISA levels

When compiling the `Generic x86-64` Processor family target, these are selectable under:
```
 Processor type and features ---> x86-64 compiler ISA level
```

* x86-64     A value of (1) is the default and builds with the generic x86-64 ISA level
* x86-64-v2  A value of (2) brings support for vector instructions up to Streaming SIMD Extensions 4.2 (SSE4.2) and Supplemental Streaming SIMD Extensions 3(SSSE3), the POPCNT instruction, and CMPXCHG16B.
* x86-64-v3  A value of (3) adds vector instructions up to AVX2, MOVBE, and additional bit-manipulation instructions.
* x86-64-v4  A value of (4) includes vector instructions from some of the AVX-512 variants.

Users of glibc 2.33 and above can see which level is supported by running one of the follownig:
```
/lib/ld-linux-x86-64.so.2 --help | grep supported
/lib64/ld-linux-x86-64.so.2 --help | grep supported
```
### 2. New micro-architectures levels

These are selectable under:
```
 Processor type and features ---> Processor family
```
<table>
  <tr>
    <th>CPU Family</th>
    <th>-march=</th>
    <th>Min GCC Ver</th>
    <th>Min Clang Ver</th>
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
    <td>19.1 (speculated)</td>
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

## 3. Auto-detected micro-architecture levels

These are also selectable under:
```
 Processor type and features ---> Processor family
```
They have the  ability to compile by passing the '-march=native' option which, according to the [GCC manual](https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html#index-x86-Options) "selects the CPU to generate code for at compilation time by determining the processor type of the compiling machine. Using -march=native enables all instruction subsets supported by the local machine and will produce code optimized for the local machine under the constraints of the selected instruction set."

Users of Intel CPUs should select the 'Intel-Native' option and users of AMD CPUs should select the 'AMD-Native' option.

## Benchmarks
### Setup

The test machine measured the time it took to `make bzImage` of the linux kernel source (`.config` generated by `make x86_64_defconfig` prior).

Three separate test machines were evaluated:
1. AMD Ryzen 9 5950X
2. Intel i7-4790K
3. Intel N100

Separate kernels were first compiled from source patched with [more-uarches-for-kernel-6.8-rc4+.patch](https://github.com/graysky2/kernel_compiler_patch/blob/master/more-uarches-for-kernel-6.8-rc4%2B.patch).
* Kernel 1 used the default menu config option for Processor family = `Generic x86-64`
* Kernel 2 used the menu config option for Processor family = `x86-64-v3` or `x86-64-v3`
* Kernel 3 used the menu config option for Processor family = `AMD Zen 3` or `Intel Haswell` or `Intel Alder Lake`

Each machine was booted into its respective kernel and the make test was conducted.  Then the next kernel was installed and the machine was booted into it and the make test was again conducted.

## Conclusion
Consistently across all three test machines, the kernels built with the optimized processor family options introduced by the patch hosted in this repo ran the compile test faster than the kernel compiled with the default processor family option by a small (<1% difference) but statistically significant amount as measured by this make compilation.

What does this mean for real-world usage?  Maybe nothing.  The intent was to see if something easily automatable could show some value in applying these micro-arch tunings.  People have historically gravitated to compilation-based benchmarks so that coupled with ease-of-use point is why I settled on it.  If someone has a good kernel-centric benchmark, I am interested to see a controlled comparison.

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
    <td>x86-64-v3</td>
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
    <td>Generic x86-64 vs x86-64-v3</td>
    <td>12.8771</td>
    <td>0.0010053</td>
    <td>$${\color{green} \verb|**|p<0.01}$$</tr>
  </tr>
  <tr>
    <td>Generic x86-64 vs AMD Zen 3</td>
    <td>13.4675</td>
    <td>0.0010053</td>
    <td>$${\color{green} \verb|**|p<0.01}$$</tr>
  </tr>
  <tr>
    <td>x86-64-v3 vs AMD Zen 3</td>
    <td>9.6524</td>
    <td>0.8999947</td>
    <td>$${\color{red}insignificant}$$</tr>
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
    <td>x86-64-v3</td>
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
    <td>Generic x86-64 vs x86-64-v3</td>
    <td>28.9652</td>
    <td>0.0010053</td>
    <td>$${\color{green} \verb|**|p<0.01}$$</tr>
  </tr>
  <tr>
    <td>Generic x86-64 vs Intel Haswell</td>
    <td>24.8335</td>
    <td>0.0010053</td>
    <td>$${\color{green} \verb|**|p<0.01}$$</tr>
  </tr>
  <tr>
    <td>x86-64-v3 vs Intel Haswell</td>
    <td>4.1317</td>
    <td>0.0167155</td>
    <td> $${\color{lightgreen} \verb|*|p<0.05}$$</tr>
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
    <td>x86-64-v3</td>
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
    <td>Generic x86-64 vs x86-64-v3</td>
    <td>5.5076</td>
    <td>0.0012818</td>
    <td>$${\color{green} \verb|**|p<0.01}$$</tr>
  </tr>
  <tr>
    <td>Generic x86-64 vs Intel Alder Lake</td>
    <td>15.1600</td>
    <td>0.0010053</td>
    <td>$${\color{green} \verb|**|p<0.01}$$</tr>
  </tr>
  <tr>
    <td>x86-64-v3 vs Intel Alder Lake</td>
    <td>9.6524</td>
    <td>0.0010053</td>
    <td>$${\color{green} \verb|**|p<0.01}$$</tr>
  </tr>
</table>

### Comparing GCC to Clang
The Ryzen 9 5950X was used to compare kernels built with GCC and Clang each with `Generic x86-64` and `x86-64-v3`.  The results are consistent for both compilers.

<table>
  <tr>
    <th>Processor family option</th>
    <th>Compiler</th>
    <th>Mean compile time</th>
    <th>Std dev</th>
    <th># of replicates</th>
  </tr>
  <tr>
    <td>Generic x86-64</td>
    <td>GCC</td>
    <td>79.4569 sec</td>
    <td>0.0664 sec</td>
   <td>5</td>
  </tr>
  <tr>
    <td>x86-64-v3</td>
    <td>GCC</td>
    <td>79.1403 sec</td>
    <td>0.0580 sec</td>
    <td>5</td>
  </tr>
  <tr>
    <td>Generic x86-64</td>
    <td>Clang</td>
    <td>79.8398 sec</td>
    <td>0.0629 sec</td>
   <td>5</td>
  </tr>
  <tr>
    <td>x86-64-v3</td>
    <td>Clang</td>
    <td>79.0975 sec</td>
    <td>0.0711 sec</td>
    <td>5</td>
  </tr>
</table>

![X9550](https://github.com/graysky2/kernel_compiler_patch/blob/master/benchmark/boxplot4.svg)

## Software versions used

All machines ran Arch Linux with the all stock repo packages with the exception of the kernel (see below).  At the time of work, the following the toolchain versions were used:
* binutils 2.43+r4+g7999dae6961-1
* clang 18.0.1-1
* gcc 14.2.1+r134+gab884fffe3fc-1
* gcc-libs 14.2.1+r134+gab884fffe3fc-1
* glibc 2.40+r16+gaa533d58ff-2
* linux-api-headers 6.10-1

The kernel packages were built on the official Arch Linux PKGBUILD for kernel version 6.10.10-arch1-1 applying the distro config differing only by the modifications introduced by the aforementioned patch from this repo.

The benchmark was compiling the vanilla Linux kernel version 6.10.10 and as mentioned above, the `.config` used was generated by running `make x86_64_defconfig`.

## References
* Script to run the benchmark: [make_bench.sh](https://github.com/graysky2/kernel_compiler_patch/blob/master/benchmark/make_bench.sh)
* Data for three machines: [results.csv](https://github.com/graysky2/kernel_compiler_patch/blob/master/benchmark/results.csv)
* Data for GCC vs Clang: [results2.csv](https://github.com/graysky2/kernel_compiler_patch/blob/master/benchmark/results2.csv)

## Credit
* Original author: jeroen AT linuxforge DOT net
* Link to original version: http://www.linuxforge.net/docs/linux/linux-gcc.php
* Box plot generated with [statisty.app](https://statisty.app/anova-calculator)
* ANOVA stats generated with [astatsa.com](https://astatsa.com/OneWay_Anova_with_TukeyHSD/)

## Legacy support
Find support for older version of the linux kernel and of gcc in the outdated_versions directory.
