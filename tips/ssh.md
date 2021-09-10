# client
## .ssh/config client example
echo "
\# PUBLIC
Host github github.com
 IdentityFile ~/.ssh/id_git
 HostName github.com
 User git

\# GCP (Google Cloud)
Host gcloud
 IdentityFile ~/.ssh/id_cloud
 HostName gcloud 8.8.8.8
 User gc
 
\# PRIVATE
Host ubuntu
 IdentityFile ~/.ssh/id_private
 HostName ubuntu 192.168.0.254
 User ubuntu
" > $HOME/.ssh/config

## copy your sshd-id from client to server
ssh-copy-id -i $HOME/.ssh/id_*.pub server

# server
