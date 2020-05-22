
# GRAY LOG Installation Guide

1.  Install following pwgn using following command 
        `sudo apt install pwgen`

2. Run following command and copy the output password to use it "password_secret" in the config file.

        `pwgen -N 1 -s 96`

3. In the following command replace your_password_here with your admin password.
        `echo -n your_password_here | shasum -a 256`

It should output similar line as below:
    345616f307c62eaf232f2d5e25c430958023c91436d2ef2caebb5b866b07ecd1
    Copy it and use it as your root_password_sha2 in the config file.

4. Open server.conf file and replace values of password_secret and root_password_sha2 on line 55 and 66 respectively.
5. Open graylog.sh 
6. Replace URL of server.conf file at line 48 with URL of your repo. 
    If server.conf of this Repo is used, following will be the values
      username: admin
      
      password: abcd@1234
7. Run graylog.sh file in Ubuntu. 




