### Git Credential Settings

```
git config --global credential.helper '!aws --profile codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git config --global --edit
```

### AWS Configuration

```
aws iam create-user --user-name sy
ssh-keygen -y -f admin-server.pem
sudo su - sy
chmod 700 .ssh
cd .ssh
touch authorized_keys
chmod 600 authorized_keys
vim authorized_keys
```

### Install _git-remote-codecommit_

Prerequisites: python3, git-remote-codecommit

```
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
pip install git-remote-codecommit
```