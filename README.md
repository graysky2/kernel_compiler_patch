# kernel_compiler_patch

This patch adds additional optimization/tuning for kernel builds by adding more micro-architectures options accessible under:
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
    <td>Intel 3rd Gen 10nm++ Xeon (Sapphire Rapids)</td>
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
