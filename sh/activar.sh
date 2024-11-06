chmod +x ~/scripts/sh/eslint.sh
chmod +x ~/scripts/sh/module.sh
chmod +x ~/scripts/sh/prettier.sh
chmod +x ~/scripts/sh/ts.sh

chmod +x ~/scripts/sh/next-eslint.sh
chmod +x ~/scripts/sh/next-module.sh
chmod +x ~/scripts/sh/next-prettier.sh
chmod +x ~/scripts/sh/next-ts.sh

dos2unix ~/scripts/sh/nest-eslint.sh
dos2unix ~/scripts/sh/nest-module.sh
dos2unix ~/scripts/sh/nest-prettier.sh
dos2unix ~/scripts/sh/nest-ts.sh

dos2unix ~/scripts/sh/next-eslint.sh
dos2unix ~/scripts/sh/next-module.sh
dos2unix ~/scripts/sh/next-prettier.sh
dos2unix ~/scripts/sh/next-ts.sh


chmod +x ~/scripts/sh/clean-cache.sh

dos2unix ~/scripts/sh/clean-cache.sh
# .zshrc
alias next_ts='~/scripts/sh/clean-cache.sh'


# configuracion de scripts windos y linus
eval "$(oh-my-posh init bash)"
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/capr4n.omp.json" | Invoke-Expression

# Configuración del historial de comandos
HISTCONTROL=ignoredups:erasedups
HISTSIZE=1000
HISTFILESIZE=2000


alias eslint='~/scripts/sh/eslint.sh'
alias module='~/scripts/sh/module.sh'
alias prettier='~/scripts/sh/prettier.sh'
alias ts='~/scripts/sh/ts.sh'
alias clean-cache='~/scripts/sh/clean-cache.sh'

# chmod +x ~/scripts/sh/nest-eslint.sh
# chmod +x ~/scripts/sh/nest-module.sh
# chmod +x ~/scripts/sh/nest-prettier.sh
# chmod +x ~/scripts/sh/nest-ts.sh


chmod +x ~/scripts/sh/eslint.sh
chmod +x ~/scripts/sh/module.sh
chmod +x ~/scripts/sh/prettier.sh
chmod +x ~/scripts/sh/ts.sh
chmod +x ~/scripts/sh/clean-cache.sh

# linux


eval "$(oh-my-posh init bash --config ~/AppData/Local/Programs/oh-my-posh/themes/capr4n.omp.json)"


# Configuración del historial de comandos
HISTCONTROL=ignoredups:erasedups
HISTSIZE=1000
HISTFILESIZE=2000

alias eslint='~/scripts/sh/eslint.sh'
alias module='~/scripts/sh/module.sh'
alias prettier='~/scripts/sh/prettier.sh'
alias ts='~/scripts/sh/ts.sh'
alias clean-cache='~/scripts/sh/clean-cache.sh'

# chmod +x ~/scripts/sh/eslint.sh
# chmod +x ~/scripts/sh/module.sh
# chmod +x ~/scripts/sh/prettier.sh
# chmod +x ~/scripts/sh/ts.sh
# chmod +x ~/scripts/sh/clean-cache.sh