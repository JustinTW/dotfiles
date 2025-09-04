# trash
alias rm='trash-put'

# git
alias gpp='git pull && git pull && git push'

# developer tools
alias cw='cd ~/workspace'

alias h='helm'
alias m='make'
alias minicom='TERM=linux minicom'
alias mtr='sudo mtr'
alias p='pulumi'
alias fdns='sudo killall -HUP mDNSResponder'

alias kubectx='kubectl ctx'
alias kubens='kubectl ns'

kubectx_mapping[moxa-cloud-platform-dev-0-eksCluster-b9d1550]="dev"
kubectx_mapping[moxa-cloud-platform-stg-0-eksCluster-f808b62]="stg"
kubectx_mapping[moxa-cloud-platform-prod-0-eksCluster-0f6bf0a]="prod"

# attach aws ssm
alias ssm='aws ssm start-session --region us-west-2 --target'
