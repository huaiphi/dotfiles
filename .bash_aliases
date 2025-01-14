# alias for ls
if [ -x "$(command -v exa)" ]; then
    alias l='exa'
    alias ll='exa -l'
    alias la='exa -la'
else
    alias l='ls'
    alias ll='ls -l'
    alias la='ls -lA'
fi

if [ -x "$(command -v chromium)" ]; then
    alias chromincognito="chromium --incognito > /dev/null 2>&1 &"
fi
