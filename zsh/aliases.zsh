alias reload!='. ~/.zshrc'

# Linux-specific aliases
if [[ "$OSTYPE" == linux* ]]; then
  alias open='xdg-open'
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xclip -selection clipboard -o'
fi

alias grep='grep --color'
