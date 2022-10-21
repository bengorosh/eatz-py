### Getting started


READ THE DOCS:
https://vyper.readthedocs.io/en/latest/testing-contracts-brownie.html


First things first.  We need to make a new empty directory in which
to initialize our brownie project. If you aren't in a venv, get in one.

```
mkdir sandbox && cd sandbox
brownie init
```

This generated a handful of new directories:
build, contracts, interfaces, reports, scripts, tests

Place your contract and relevant tests into contracts/ and tests/,
then run:

```
brownie test
```

### Dev notes

make sure you put ```from brownie import accounts``` into your test
