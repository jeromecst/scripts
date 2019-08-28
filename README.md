# scripts
Useful scripts to enhance your Linux experience

---

in order to run the script, you need to set permission `chmod +x script.sh`. 

### ddir.sh

simple script to decrypt all `.gpg` files, recursively, in a folder.

usage : `./ddir.sh folder/`

_example of output :_

```
➜  ~ ddir pictures 
decrypting pictures...
[+] pictures/IMG_20190826_110611.jpg.gpg
[+] pictures/IMG_20190826_110624.jpg.gpg
[+] pictures/IMG_20190826_110626.jpg.gpg
[+] pictures/IMG_20190826_110707.jpg.gpg
[+] pictures/IMG_20190826_110628.jpg.gpg
[+] pictures/IMG_20190826_110711.jpg.gpg
[+] pictures/IMG_20190826_110609.jpg.gpg
[+] pictures/IMG_20190826_214215.jpg.gpg
[+] pictures/IMG_20190826_110612.jpg.gpg
[+] pictures/IMG_20190826_110635.jpg.gpg
[+] pictures/IMG_20190826_110634.jpg.gpg
done
```

### ssh_connection.sh

simple script which output all incoming ssh attempt and connection. the script also print date, ip and location.

_example of output :_

```
2019-08-13@14:00:47 --> 35.203.50.XXX <-- United States | Mountain View
2019-08-13@14:00:52 --> 35.203.50.XXX <-- United States | Mountain View
2019-08-13@14:00:57 --> 35.203.50.XXX <-- United States | Mountain View

2019-08-13@14:09:02 --> 185.220.101.XX <-- Germany | London <new>
2019-08-13@14:09:08 --> 185.220.101.XX <-- Germany | London
2019-08-13@14:09:13 --> 185.220.101.XX <-- Germany | London
2019-08-13@14:09:13 --> 192.42.116.XX <-- Netherlands | Amsterdam <new>
2019-08-13@14:09:19 --> 185.220.101.XX <-- Germany | London
2019-08-13@14:09:19 --> 192.42.116.XX <-- Netherlands | Amsterdam
2019-08-13@14:09:24 --> 185.220.101.XX <-- Germany | London
2019-08-13@14:09:24 --> 192.42.116.XX <-- Netherlands | Amsterdam
2019-08-13@14:09:29 --> 185.220.101.XX <-- Germany | London
2019-08-13@14:09:29 --> 192.42.116.XX <-- Netherlands | Amsterdam
2019-08-13@14:09:34 --> 185.220.101.XX <-- Germany | London
2019-08-13@14:09:34 --> 192.42.116.XX <-- Netherlands | Amsterdam
2019-08-13@14:09:39 --> 185.220.101.XX <-- Germany | London
2019-08-13@14:09:39 --> 192.42.116.XX <-- Netherlands | Amsterdam
2019-08-13@14:09:44 --> 158.69.212.XXX <-- Canada | Montreal <new>
```

usage : `./ssh_connection.sh`
