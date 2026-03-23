{ pkgs, lib, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;

    history = {
      size = 50000;
      save = 500000;
      ignoreDups = true;
      share = true;
      extended = true;
      ignoreSpace = true;
    };

    setOptions = [
      "NO_BG_NICE"
      "NO_HUP"
      "NO_LIST_BEEP"
      "LOCAL_OPTIONS"
      "LOCAL_TRAPS"
      "HIST_VERIFY"
      "PROMPT_SUBST"
      "CORRECT"
      "COMPLETE_IN_WORD"
      "IGNORE_EOF"
      "HIST_REDUCE_BLANKS"
      "complete_aliases"
    ];

    shellAliases = {
      # shell
      "reload!" = ". ~/.zshrc";
      grep = "grep --color";

      # ls
      ls = "ls -F --color";
      l  = "ls -lAh --color";
      ll = "ls -l --color";
      la = "ls -A --color";

      # git
      gl   = "git-pull-latest-master";
      glog = "git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
      gp   = "git push origin HEAD";
      gd   = "git diff";
      gc   = "git commit";
      gca  = "git commit -a";
      gco  = "git checkout";
      gcb  = "git copy-branch-name";
      gb   = "git branch";
      gs   = "git status --ignore-submodules";

      # python / django
      djm     = "python manage.py";
      djserve = "python manage.py runserver_plus 0.0.0.0:8000 --keep-meta-shutdown";
      djshell = "python manage.py shell";
      djt     = "REUSE_DB=1 python manage.py test -s";

      # ruby on rails
      sc = "script/console";
      sg = "script/generate";
      sd = "script/destroy";
    } // lib.optionalAttrs pkgs.stdenv.isLinux {
      open    = "xdg-open";
      pbcopy  = "xsel --clipboard --input";
      pbpaste = "xclip -selection clipboard -o";
    };

    sessionVariables = {
      ZSH     = "$HOME/.dotfiles";
      EDITOR  = "et";
      VISUAL  = "et";
      PROJECTS = "$HOME/dev";
      TODOS   = "$HOME/Desktop/todos";
      TODOS_ARCHIVE = "$HOME/.todos_archive";
      LSCOLORS = "exfxcxdxbxegedabagacad";
      CLICOLOR = "true";
      MOZ_USE_XINPUT2 = "1";
      GOOGLE_APPLICATION_CREDENTIALS = "$HOME/.config/gcloud/application_default_credentials.json";
    };

    initContent = ''
      # keybindings
      bindkey -e
      bindkey '^[^[[D' backward-word
      bindkey '^[^[[C' forward-word
      bindkey '^[[5D' beginning-of-line
      bindkey '^[[5C' end-of-line
      bindkey '^[[3~' delete-char
      bindkey '^?' backward-delete-char

      # window title
      function title() {
        a=''${(V)1//\%/\%\%}
        a=$(print -Pn "%40>...>$a" | tr -d "\n")
        case $TERM in
        screen)
          print -Pn "\ek$a:$3\e\\"
          ;;
        xterm*|rxvt)
          print -Pn "\e]2;$3\a"
          ;;
        esac
      }

      # prompt
      autoload colors && colors

      git_branch() {
        echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
      }

      git_prompt_info() {
        ref=$(git symbolic-ref HEAD 2>/dev/null) || return
        echo "''${ref#refs/heads/}"
      }

      git_dirty() {
        if $(! git status -s &> /dev/null); then
          echo ""
        elif [[ $(git status --porcelain --ignore-submodules) == "" ]]; then
          echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
        else
          echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
        fi
      }

      need_push() {
        if [[ $(git cherry -v @{upstream} 2>/dev/null) == "" ]]; then
          echo " "
        else
          echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
        fi
      }

      directory_name() {
        echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
      }

      virtualenv_currentenv() {
        if [[ "$(basename "$VIRTUAL_ENV")" != "" ]]; then
          echo "using %{$fg[yellow]%}($(basename "$VIRTUAL_ENV"))%{$reset_color%} "
        fi
      }

      export PROMPT=$'\n%n@%m:$(directory_name) $(virtualenv_currentenv)$(git_dirty)$(need_push)\n❯  '

      precmd() {
        title "zsh" "%m" "%55<...<%~"
        export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
      }

      c() { cd $PROJECTS/$1; }

      # local private config (secrets, machine-specific vars)
      [[ -f ~/.localrc ]] && source ~/.localrc
    '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "./bin"
    "$HOME/.dotfiles/bin"
  ];
}
