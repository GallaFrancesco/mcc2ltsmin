# mcc2ltsmin

Convert formula from MCC syntax to LTSmin syntax. Used to test and compare GreatSPN against LTSmin over MCC 2019/2020 queries.

## Usage

Simple translation (output is the translated formula on a line to stdout).

```
mcc2ltsmin -q "[formula]"
```

### Formula fuzzing

Input: a CTL (cardinality) formula in MCC format.
Output: Two lines
1. CTL* formula generated by randomly removing a CTL path quantifier (except for the first)
2. LTSmin formula converted from output line 1.

```
mcc2ltsmin -q "[formula]" --fuzz|-f
```

## Building

Requirements:

- D compiler (dmd): https://dlang.org/download.html
- Dub package manager: http://code.dlang.org/

Both dmd and dub can be obtained by running the install script provided by the DLang website: [https://dlang.org/install.html](https://dlang.org/install.html)

### Build instructions

From the root of this repository, build an optimized executable without debug symbols:
```
dub build -b release
```

Build a *debug version* of the executable, with most optimization disabled and debug symbols (DWARF, gdb compatible):
```
dub build
```

Build in debug mode and execute unit test included in the source code:
```
dub test
```