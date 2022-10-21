# First look at compiling smart contracts.... ERC-20 standard
# taken mostly from Takayuki Jimba's old version

from vyper.interfaces import ERC20
implements: ERC20

from vyper.interfaces import ERC20Detailed
implements: ERC20Detailed

event Transfer:
    sender: indexed(address)
    recipient: indexed(address)
    value: uint256

event Approval:
    owner: indexed(address)
    spender: indexed(address)
    value: uint256


decimals: public(uint8)
name: public(String[10])
symbol: public(String[3])

totalSupply: public(uint256)
balanceOf: public(HashMap[address, uint256])
allowance: public(HashMap[address, HashMap[address, uint256]])
minter: address

@external
def __init__(_name: String[10], _symbol: String[3],
             _decimals: uint8, _supply: uint256):

    init_supply: uint256 = _supply * 10 ** convert(_decimals, uint256)
    self.name = _name
    self.symbol = _symbol
    self.decimals = _decimals
    self.totalSupply = init_supply
    self.balanceOf[msg.sender] = init_supply
    self.minter = msg.sender

    log Transfer(empty(address), msg.sender, init_supply)


@external
def transfer(_to: address, _value: uint256) -> bool:
    """
    Transfer tokens from one address to another
    """
    assert _to != empty(address), "Transfer to the zero address"
    assert _value > 0, "Transfer amount must be positive"
    assert self.balanceOf[msg.sender] >= _value, "Insufficient balance"

    self.balanceOf[msg.sender] -= _value
    self.balanceOf[_to] += _value

    log Transfer(msg.sender, _to, _value)
    return True

@external
def transferFrom(_from: address, _to: address, _value: uint256) -> bool:
    """
    Transfer tokens from one address to another on behalf of another
    """
    assert _from != empty(address), "Transfer from the zero address"
    assert _to != empty(address), "Transfer to the zero address"
    assert _value > 0, "Transfer amount must be positive"
    assert self.balanceOf[_from] >= _value, "Insufficient balance"
    assert self.allowance[_from][msg.sender] >= _value, "Insufficient allowance"

    self.balanceOf[_from] -= _value
    self.balanceOf[_to] += _value
    self.allowance[_from][msg.sender] -= _value

    log Transfer(msg.sender, _to, _value)
    return True


@external
def approve(_spender: address, _value: uint256) -> bool:
    """
    Approve the passed address to spend the specified amount of tokens on behalf of msg.sender
    """
    assert _spender != empty(address), "Spender address cannot be the zero address"
    assert _value > 0, "Approval amount must be positive"

    self.allowance[msg.sender][_spender] = _value

    log Approval(msg.sender, _spender, _value)
    return True

@external
def mint(_to: address, _value: uint256):
    """
    Mint the specified amount of tokens for the passed address
    """
    assert self.minter == msg.sender, "Only the minter can mint"
    assert _to != empty(address), "Mint to the zero address"
    assert _value > 0, "Mint amount must be positive"

    self.balanceOf[_to] += _value
    self.totalSupply += _value

    log Transfer(self.minter, _to, _value)
    return

@internal
def _burn(_to: address, _value: uint256):
    """
    Burn the specified amount of tokens for the passed address
    """
    assert _to != empty(address), "Zero address assets don't exist"
    assert _value > 0, "Burn amount must be positive"
    assert self.balanceOf[_to] >= _value, "Insufficient balance"

    self.balanceOf[_to] -= _value
    self.totalSupply -= _value

    log Transfer(msg.sender, _to, _value)
    return

@external
def burn(_value: uint256):
    self._burn(msg.sender, _value)
    return

@external
def burnFrom(_to: address, _value: uint256):
    assert _to != empty(address), "Zero address assets don't exist"
    assert _value > 0, "Burn amount must be positive"
    assert self.balanceOf[_to] >= _value, "Insufficient balance"
    assert self.allowance[_to][msg.sender] >= _value, "Insufficient allowance"

    self.allowance[_to][msg.sender] -= _value
    self._burn(_to, _value)

    log Transfer(msg.sender, _to, _value)
    return