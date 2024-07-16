https://www.linuxfromscratch.org/blfs/view/stable/postlfs/profile.html
The Bash Shell Startup Files

## Bash Setup
### Make you bash productive and more beautiful.

Perform all instructions provided on the page.


Also create `/etc/skel` directory and place 4 file which will go to all new users home directory in future.

```bash
mkdir /etc/skel
cp .bash_logout /etc/skel/
cp .bash_profile /etc/skel/
cp .bashrc /etc/skel/
cp .profile /etc/skel/
```

Test it by logging in to newly created user.
```bash
adduser -m testuser
su - testuser
exit
deluser -m testuser
```

