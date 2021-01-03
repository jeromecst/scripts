# scripts
Useful scripts to enhance your Linux experience

---

### jdecryptdir

simple script to decrypt all `.gpg` files, recursively, in a folder.

usage : `jdecryptdir pictures/`

_example of output :_

```
➜  ~ jdecryptdir pictures 
no user provided, using jerome by default
looking for gpg files in /home/jerome/pictures

	entering /home/jerome/pictures
		[-] 20:10:23 : decrypting 20190728_0001.jpg.gpg ✓
		[-] 20:10:26 : decrypting 20190728_0005.jpg.gpg ✓
		[-] 20:10:26 : decrypting 20190729_0003.jpg.gpg ✓
		[-] 20:10:26 : decrypting 20190729_0002.jpg.gpg ✓
		[-] 20:10:26 : decrypting 20190813_0008.jpg.gpg ✓
		[-] 20:10:26 : decrypting 20190813_0006.jpg.gpg ✓
		[-] 20:10:26 : decrypting 20190813_0009.jpg.gpg ✓
		[-] 20:10:26 : decrypting 20190813_0002.jpg.gpg ✓
		[-] 20:10:26 : decrypting 20190728_0007.jpg.gpg ✓
```

### ssh_connection

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

usage : `ssh_connection.sh`

### bd

script to print the following birthdate of your friends/family in the following days

_example of output :_

```
Yasmine Burns fête ses 18 ans dans 2 jours
Jesse Hutton fête ses 17 ans dans 12 jours
Anniversaire de Krzysztof Howarth dans 23 jours
Hallam Marsden fête ses 55 ans dans 29 jours
Tess Robin fête ses 20 ans dans 38 jours
```

# SOURCES

* https://likegeeks.com/linux-bash-scripting-awesome-guide-part3/
