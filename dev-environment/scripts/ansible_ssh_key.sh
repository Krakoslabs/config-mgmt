USER="ansible"
HOME_DIR="/home/$USER"
adduser -d $HOME_DIR $USER
usermod -aG wheel $USER
passwd -d $USER
mkdir $HOME_DIR/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDj6pQjakenUVocXKC3ei7FYTSgB3EpWAdhs39vj8mATo8HsV4zvIdskJFiyswdqNyl1pZ86fr0YoaOJbLoBOH76W8oWUhVhXehBueapK/Q5OLtDwDs3BfcpCeNjHUUP97gpOltFTm7c3E81Zi9TQgjn5+sXzsYQ/f1uI+ikCDFHRJCW8WK8TLOSpSq4iIyv89G+OvOpXagqhKeHGcSCXfT8EPKiVUstn/um5DftVXjHKnLx+2jhb0b6xF+NA7Zk1NoSN0AZZ6NYP7EzvwP/Ao+2qslso7XXUWziE4Ni0+CBEgqQ11ak1f9ocONJYvLRCFcGaZLWtlVARQjd2iK8EKoHeoSAwGQaxnfTXa0StZD/IQd+jg+lii75V768X468wndR85cHlauoGeI/mbgcILSc2lUYIFW08rE+wkqEGg3AtIuaiptLOpoZnoWweL4ZR1l5daw7DkpmZDdDU8Ee2xLqXmr5x8RB4rmaYRyhW5rwYSpGACcQDNozAVCtyEQ1bxL+dNB8WL5LK2weaokqYnza3NA/O+rQCyxa0IqnozW4Jw/3pOLXpJMQPQSJlzem8ZHoZAKOnQgc5a4jQ88otAve7gN2ViTET6DE7pIXpqBUi/gCMyUo9Ji87ItIKneYtYlpCHQb6M7ihdwln0hlex06cciQen7YlKBrgMpfkEk4w== ansible@cloudops.vm' >  $HOME_DIR/.ssh/authorized_keys
chown -R $USER:root $HOME_DIR/.ssh
chmod 400  $HOME_DIR/.ssh/authorized_keys
sed -i 's/^#\s*\(%wheel\s*ALL=(ALL)\s*NOPASSWD:\s*ALL\)/\1/' /etc/sudoers
