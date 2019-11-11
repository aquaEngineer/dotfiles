if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then                                                                                           
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

echo $OS;

curl -Lo ~/.zplug/zplug --create-dirs git.io/zplug
#source ~/dotfiles/.zshrc
git clone https://github.com/zplug/zplug $ZPLUG_HOME
git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/.vim/bundle/Vundle.vim
git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
if [ $OS = 'Mac' ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
	ZPLUG=`brew list | grep zplug`
	if [ -z ${ZPLUG} ]; then
		brew install zplug
	fi
	RANGER=`brew list | grep ranger`
	if [ -z ${RANGER} ]; then
		brew install ranger
	fi


	BAT=`brew list | grep bat`
	if [ -z ${BAT} ]; then
		brew install bat
	fi

	EXA=`brew list | grep exa`
	if [ -z ${EXA} ]; then
		brew install exa
	fi

	
	TMUX=`brew list | grep tmux`
	if [ -z ${TMUX} ]; then
		brew install tmux
	fi

elif [ $OS = 'Linux' ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
	sudo yum -y install wget
	sudo yum install --downloadonly --downloaddir=/tmp wget
	sudo yum install yum install unzip
	sudo yum install --downloadonly --downloaddir=/var/repo/others unzip
	sudo yum -y --enablerepo=epel,rpmforge,remi search pypy
	sudo yum -y --enablerepo=epel,rpmforge,remi info pypy
	sudo yum -y --enablerepo=epel install pypy
	sudo yum -y --enablerepo=epel install pypy-devel
	sudo easy_install-2.6 argparse
	sudo yum install -y python-pip
	#pythonのパッケージ管理ソフトpipをインストールします。
	sudo curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | sudo python
	#pipを用いて、powerline本体をインストールします。
	pip install powerline-status
	#フォントをインストールします。
	wget "https://github.com/powerline/fonts/archive/master.zip"
	unzip master.zip
	fonts-master/install.sh
else
	exit 1
fi
