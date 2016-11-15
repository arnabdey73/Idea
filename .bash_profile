
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


alias ll='ls -alhrt'

alias ap='ssh root@10.210.16.36'
alias ape='ssh root@10.210.16.44'
alias pb='ssh root@10.210.16.37'
alias indigo='ssh root@10.210.16.41'
alias lnt='ssh root@10.210.16.42'
alias itc='ssh root@10.210.16.43'
alias test='ssh root@10.210.16.47'

alias zebdev1auth='ssh root@54.211.182.84'
alias zebdev1pub='ssh root@54.211.193.196'
alias zebdev1disp='ssh root@54.210.120.23'
alias zebqaauth='ssh root@52.203.196.144'
alias zebqapub='ssh root@52.203.184.213'
alias zebqadisp='ssh root@52.203.195.233'
alias zebstauth='ssh root@52.203.190.185'
alias zebstpub='ssh root@52.203.197.78'
alias zebstdisp='ssh root@52.203.192.226'
alias zebproauth1='ssh root@52.70.116.53'
alias zebproauth2='ssh root@52.202.101.94'
alias zebpropub1='ssh root@52.202.228.54'
alias zebpropub2='ssh root@52.203.177.218'
alias zebprodisp1='ssh root@52.203.188.68'
alias zebprodisp2='ssh root@52.70.76.93'


alias chqaauth='ssh root@52.62.174.80'
alias chqapub='ssh root@52.62.141.84'
alias chqadisp='ssh root@52.62.117.242'
alias chproauth='ssh root@52.62.41.126'
alias chpropub1='ssh root@52.62.38.207'
alias chpropub2='ssh root@52.62.5.19'
alias chprodisp='ssh root@52.62.121.242'


alias approauth='ssh root@104.211.226.84 -p 58943'
alias appropub1='ssh root@104.211.226.84 -p 51149'
alias appropub2='ssh root@104.211.226.84 -p 55929'
alias approweb1='ssh root@52.172.10.123 -p 52364'
alias approweb2='ssh root@52.172.10.123 -p 50986'

alias apuatauth='ssh root@172.25.110.156'
alias apuatpub='ssh root@172.25.110.157'
alias apuatweb='ssh root@172.25.110.167'
