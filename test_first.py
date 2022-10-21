import pytest
from brownie import accounts

INITIAL_VALUE = 0

@pytest.fixture
def storage_contract(first, accounts):
    yield first.deploy(INITIAL_VALUE, {'from': accounts[0]})

def test_initial_state(storage_contract):
    assert storage_contract.storedData() == INITIAL_VALUE

def test_set_state(storage_contract):
    new_value = 42
    storage_contract.set(new_value, {'from': accounts[0]})
    assert storage_contract.storedData() == new_value

    new_value = -5
    storage_contract.set(new_value, {'from': accounts[0]})
    assert storage_contract.storedData() == new_value