# eatz-py
Pythonish implementation for eatz

This is the first attempt at making a system to generate smart contract 
with Vyper... Hopefully, with an actual GUI!

### Toolchain

    Python3
        venv
        pipx
        eth-brownie
	    vyper
        pytest

    JS
        npm
        ganache


### Why Vyper?

NOTE: All vyper code is valid Python3 syntax, however, many things from
Python3 are unavailable in Vyper.  Vyper also has reduced functionality
compared with Solidity.  This is by design.

The main reasons for this are supposedly enhanced security and ease of 
code audits.  Also, decidability is a thing... Apparently, it's very 
accurate when calculating the upper bound on gas prices.

#### Debugging and compiling


For information on installing, visit INSTALL.md

Start your venv.

```
source venv/bin/activate
```

Once you think your contract is ready to compile (down to ABI):

```
vyper {contract_vX.X.vy}
```

This will show a lot of errors, usually with clear descriptions, which will
tell you how to debug your code for your version of Vyper.  If you don't know
what version you are using, try ```vyper --version```.

When you are ready to test, run the following.  You will need ABI, ByteCode, and a Storage Layout for this.

```
vyper -f abi {contract_vX.X.vy} > {contract_vX.X.abi}
vyper -f bytecode {contract_vX.X.vy} > {contract_vX.X.bytecode}
vyper -f layout {contract_vX.X.vy} > storage.json
```

Once you have done this, proceed to TESTING.MD

### Dev Notes

ALWAYS use a virtual environment!  Don't touch the .gitignore!

WHEN DEPLOYING, execute with ERC5302 preamble 0xfe7100 so that random people cannot call methods from the blueprint directly!

(SELFDESTRUCT opcode is 0xFF)  when the selfdestruct is called, the contract is deleted from the blockchain, and all its associeted assets are burned.

CRYPTOGRAPHY -- see alt-bn128... use elliptic curve math!



