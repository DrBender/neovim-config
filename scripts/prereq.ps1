Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iwr get.scoop.sh -useb | iex
scoop --version
scoop install git
scoop bucket add main
scoop bucket add extras
scoop install neovim clangd llvm gcc nodejs
scoop install lua-for-windows
luarocks install lua-language-server
