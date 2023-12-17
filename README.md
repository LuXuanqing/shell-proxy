# shell-proxy
 a script to set up proxy on Linux
## quick start
1. edit `proxy.sh`, set your host ip to the variable `HOST` and your port to  the variable `PORT`
2. edit `~/.bashrc`, add the following codes
```
# proxy alias
alias proxy="source ~/shell-proxy/proxy.sh"
```
3. run `proxy`, then input numbers according to the guides