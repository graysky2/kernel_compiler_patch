# Kernel_gcc_patch

This kernel patch adds additional CPU options to the Linux kernel accessible under:
```
 Processor type and features  --->
 Processor family --->
```
## Why a specific patch?
The kernel uses its own set of CFLAGS, KCFLAGS. For example, see:
* [arch/x86/Makefile](https://github.com/torvalds/linux/blob/master/arch/x86/Makefile)
* [arch/x86/Makefile_32.cpu](https://github.com/torvalds/linux/blob/master/arch/x86/Makefile_32.cpu)
* [arch/x86/Kconfig.cpu](https://github.com/torvalds/linux/blob/master/arch/x86/Kconfig.cpu)

## Expanded CPUs include
<table>
  <tr>
    <th>CPU Family</th>
    <th>GCC Optimization</th>
    <th>Min GCC Ver</th>
  </tr>
  <tr>
    <td>Native optimizations autodetected by GCC</td>
    <td>-march=native</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Generic 64-bit level v2</td>
    <td>-march=x86-64-v2</td>
    <td>11.0</td>
  </tr>
  <tr>
    <td>Generic 64-bit level v3</td>
    <td>-march=x86-64-v3</td>
    <td>11.0</td>
  </tr>
  <tr>
    <td>Generic 64-bit level v4</td>
    <td>-march=x86-64-v4</td>
    <td>11.0</td>
  </tr>
  <tr>
    <td>AMD Improved K8-family</td>
    <td>-march=k8-sse3</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD K10-family</td>
    <td>-march=amdfam10</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD Family 10h (Barcelona)</td>
    <td>-march=barcelona</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD Family 14h (Bobcat)</td>
    <td>-march=btver1</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD Family 16h (Jaguar)</td>
    <td>-march=btver2</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD Family 15h (Bulldozer)</td>
    <td>-march=bdver1</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD Family 15h (Piledriver)</td>
    <td>-march=bdver2</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD Family 15h (Steamroller)</td>
    <td>-march=bdver3</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD Family 15h (Excavator)</td>
    <td>-march=bdver4</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD Family 17h (Zen)</td>
    <td>-march=znver1</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD Family 17h (Zen 2)</td>
    <td>-march=znver2</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>AMD Family 19h (Zen 3)</td>
    <td>-march=znver3</td>
    <td>10.3</td>
  </tr>
  <tr>
    <td>Intel Bonnell family Atom</td>
    <td>-march=bonnell</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel Silvermont family Atom</td>
    <td>-march=silvermont</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel Goldmont family Atom (Apollo Lake and Denverton)</td>
    <td>-march=goldmont</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel Goldmont Plus family Atom (Gemini Lake)</td>
    <td>-march=goldmont-plus</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel 1st Gen Core i3/i5/i7-family (Nehalem)</td>
    <td>-march=nehalem</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel 1.5 Gen Core i3/i5/i7-family (Westmere)</td>
    <td>-march=westmere</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel 2nd Gen Core i3/i5/i7-family (Sandybridge)</td>
    <td>-march=sandybridge</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel 3rd Gen Core i3/i5/i7-family (Ivybridge)</td>
    <td>-march=ivybridge</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel 4th Gen Core i3/i5/i7-family (Haswell)</td>
    <td>-march=haswell</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel 5th Gen Core i3/i5/i7-family (Broadwell)</td>
    <td>-march=broadwell</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel 6th Gen Core i3/i5/i7-family (Skylake)</td>
    <td>-march=skylake</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel 6th Gen Core i7/i9-family (Skylake X)</td>
    <td>-march=skylake-avx512</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel 8th Gen Core i3/i5/i7-family (Cannon Lake)</td>
    <td>-march=cannonlake</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel 10th Gen Core i7/i9-family (Ice Lake)</td>
    <td>-march=icelake-client</td>
    <td>9.3</td>
  </tr>
  <tr>
    <td>Intel Xeon (Cascade Lake)</td>
    <td>-march=cascadelake</td>
    <td>10.2</td>
  </tr>
  <tr>
    <td>Intel Xeon (Cooper Lake)</td>
    <td>-march=cooperlake</td>
    <td>10.2</td>
  </tr>
  <tr>
    <td>Intel 3rd Gen 10nm++ i3/i5/i7/i9-family (Tiger Lake)</td>
    <td>-march=cooperlake</td>
    <td>10.2</td>
  </tr>
  <tr>
    <td>Intel 3rd Gen 10nm++ Xeon (Sapphire Rapids)</td>
    <td>-march=sapphirerapids</td>
    <td>11.0</td>
  </tr>
  <tr>
    <td>Intel 11th Gen i3/i5/i7/i9-family (Rocket Lake)</td>
    <td>-march=rocketlake</td>
    <td>11.0</td>
  </tr>
  <tr>
    <td>Intel 12th Gen i3/i5/i7/i9-family (Alder Lake)</td>
    <td>-march=alderlake</td>
    <td>11.0</td>
  </tr>
</table>

# Benchmarks
## Intro
Three different machines running a generic x86-64 kernel and an otherwise identical kernel running with the optimized gcc options were tested using a make based endpoint.

## Conclusion
There are small but real speed increases to running with this patch as judged by a make endpoint. The increases are on par with the speed increase that the upstream sanctioned core2 option gives users, so not including additional options seems somewhat arbitrary to me.

## Details
1. Three test machines: Intel Xeon X3360, Intel i7-2620M, Intel Core i7-3660K.
2. All ran the make benchmark (linked below) 35 times while booted into a 'generic' kernel. Then all ran the same make benchmark 35 times after booting into an optimized kernel. Below are the optimizations chosen for each machine.
	* X3360 = core2
	* i7-2620M = sandybridge
	* i7-3660K = ivybridge
3. Results were analyzed for statistical significance via ANOVA plots that clearly show statistically significant albeit small differences.

## Discussion
1. All the assumptions for ANOVA are met:
	* Data are normally distributed as show in the normal quantile plots.
	* The population variances are fairly equal (Levene and Barlett tests).
2. The ANOVA plots clearly show significance.
	* Pair-wise analysis by Tukey-Kramer shows significance at the 0.05 level for all CPUs compared.

Below are the differences in median values:

<table>
  <tr>
    <th>CPU</th>
    <th>Difference in median value</th>
  </tr>
  <tr>
    <td>core2</td>
    <td>+87.5 ms</td>
  </tr>
  <tr>
    <td>sandybridge</td>
    <td>+79.7 ms</td>
  </tr>
  <tr>
    <td>ivybridge</td>
    <td>+257.2 ms</td>
  </tr>
</table>

## References
* Bash script that controls the benchmark: https://github.com/graysky2/bin/blob/master/bench
* Log file generated by script: http://repo-ck.com/bench/compile_time_optimization.txt.gz

## Credit
* Original author: jeroen AT linuxforge DOT net
* Link to original version: http://www.linuxforge.net/docs/linux/linux-gcc.php

## Legacy support
Find support for older version of the linux kernel and of gcc in the outdated_versions directory.

## Data
### Sandybridge vs. Generic
![2620_m](https://user-images.githubusercontent.com/534822/39409974-d2d88a40-4bbd-11e8-9375-ce3aba6113dc.png)

### Ivybridge vs. Generic
![3770_k](https://user-images.githubusercontent.com/534822/39409975-d2e90280-4bbd-11e8-9835-8a005933dcfc.png)

### Core2 vs. Generic
![x3360](https://user-images.githubusercontent.com/534822/39409976-d2fa28ee-4bbd-11e8-957a-ff46ba6f4ffa.png)
