# add github ip to host
sudo sh -c 'echo "199.232.4.133 raw.githubusercontent.com" >> /etc/hosts'

######################
# config homebrew
######################

## install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

## set up CN source
### switch brew.git
cd "$(brew --repo)" && git remote set-url origin git://mirrors.ustc.edu.cn/brew.git
### or aliyun
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git

### switch homebrew-core.git
cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-core && git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
### or aliyun
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git 

## install homebrew cask
#brew install brew-cask-completion
brew tap homebrew/cask

### switch homebre-cask.git
cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-cask && git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
### or aliyun
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.aliyun.com/homebrew-cask.git

## switch homebrew-bottles
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc

## update config
source ~/.zshrc

## reset to default repo
## reset brew.git:
git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/brew.git

## reset homebrew-core.git:
git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core.git

## reset homebrew-cask.git：
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://github.com/Homebrew/homebrew-cask

## comment the homebrew-bottles in zshrc
vi ~/.zshrc

## install apps
### install apps in app store
brew install mas
### mas install onedrive and parallels client
mas install 823766827 600925318

### install others
brew cask install shadowsocksx-ng-r visual-studio-code 
### after set up ssr, set up proxy for cli
echo "\
# proxy list
alias proxy='export all_proxy=socks5://127.0.0.1:1086'
alias unproxy='unset all_proxy'">>~/.zshrc
### enable proxy
proxy
### install the rest of the apps
brew cask install bettertouchtool vlc docker virtualbox virtualbox-extension-pack
### disable proxy
unproxy
