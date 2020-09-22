# mcc2ltsmin

Convert query from MCC syntax to LTSmin syntax. Used to test and compare GreatSPN against LTSmin over MCC 2019/2020 queries.

## Usage

Simple translation:

```
./mcc2ltsmin "[query]"
```

Query fuzzing:
```
./mcc2ltsmin --fuzz "[query]"
```

## Building

Requirements:

- D compiler (dmd): https://dlang.org/download.html
- Dub package manager: http://code.dlang.org/

Both can be obtained by running the install script provided by the DLang website: https://dlang.org/install.sh

### Build instructions

From the root of this repository, to build an optimized executable without debug symbols:
```
dub build -b release
```

To build a *debug version* of the executable, with most optimization disabled and debug symbols (DWARF, gdb compatible):
```
dub build
```

To build in debug mode and execute unit test included in the source code:
```
dub test
```