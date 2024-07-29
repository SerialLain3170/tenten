cd

# Git install
apt-get install -y git zsh

# python install

git clone https://github.com/pyenv/pyenv.git ~/.pyenv

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

sed -Ei -e '/^([^#]|$)/ {a \
export PYENV_ROOT="$HOME/.pyenv"
a \
export PATH="$PYENV_ROOT/bin:$PATH"
a \
' -e ':a' -e '$!{n;ba};}' ~/.profile
echo 'eval "$(pyenv init --path)"' >>~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.profile

sudo apt-get update -y; sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm peco \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev vim tmux wget

cp ./tenten/.tmux.conf .

pyenv install 3.9.12
pyenv local 3.9.12

# zsh setting
mkdir ~/.zsh
cd ./.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git
cd
cp ./tenten/.git-prompt.sh ./.zsh/
cp ./tenten/.zshrc .

# vim setting
mkdir ~/.vim
cd ./.vim
mkdir autoload
cd ./autoload
git clone https://github.com/junegunn/vim-plug.git
mv vim-plug/vim-plug.vim .
cd ../
mkdir colors
cd ./colors
git clone https://github.com/tomasr/molokai.git
mv molokai/colors/molokai.vim .
cd
cp ./tenten/.vimrc .

# ghq setting
git clone https://github.com/asdf-vm/asdf ~/.asdf
chmod +x ~/.asdf/asdf.sh
echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
exec $SHELL -l
source ~/.bashrc
asdf plugin add ghq
asdf install ghq latest
source ~/.zshrc
touch ~/.tool-versions
echo "ghq 1.3.0" >> ~/.tool-versions

cp -r ./tenten/cli .
