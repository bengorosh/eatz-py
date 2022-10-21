# Install instructions

You should be doing this in a native linux install or (at the very least)
Windows Subsystem for Linux.  If you're not using a Debian-core distribution, 
we'll assume you've got your own methods.

Begin in the main folder of the eatz-py repository.

NOTE: for using these code blocks in a Jupyter Notebook, you may have to 
install both pip and ipykernel.


Install the stuff.
NOTE: this will install pipx outside of the virtual environment
and change your $PATH accordingly.  Don't worry too much about it.

```
# pipx may be easier to use than venv, but I do not prefer it

python3 -m pip install --user pipx
python3 -m pipx ensurepath

# venv is in the standard library....

python3 -m venv venv
source venv/bin/activate
```

#### Dependencies Option 1

```
pip install vyper
pip install eth-brownie
pip install pytest
```

#### Dependencies Option 2

You may instead prefer to simply install from the requirements file:

```
# FROM INSIDE YOUR VENV

pip install -r requirements.txt

# this file was generated wit pip freeze
```

#### Ganache

You will now need Ganache, installed via Node Package Manager.

```
sudo apt install npm
npm install ganache
```

Now, you can move on to TESTING.md