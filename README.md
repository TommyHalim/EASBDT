# EASBDT

## Implementasi MySQL (Wordpress) sebagai db utama dan NoSQL(Redis) sebagai caching data

Menggunakan 4 cluster sama seperti aplikasi wordpress pada repository ETSBDTNDB

| No | IP Address | Hostname | Deskripsi | OS | RAM |
| --- | --- | --- | --- | --- | --- |
| 1 | 192.168.33.11 | clusterdb1 | Master (Redis) & NDB Manager | bento/Ubuntu 18.04 | 512 MB |
| 2 | 192.168.33.12 | clusterdb2 | Node Slave 1 | bento/Ubuntu 18.04 | 512 MB |
| 3 | 192.168.33.13 | clusterdb3 | Node Slave 2 | bento/Ubuntu 18.04 | 512 MB |
| 3 | 192.168.33.14 | clusterdb4 | Proxy SQL | bento/Ubuntu 18.04 | 512 MB |



## 1. Instalasi Wordpress

Melakukan instalasi wordpress dengan langkah sama dengan [ETSBDTNDB](https://github.com/TommyHalim/ETSBDTNDB)


## 2. Instalasi Redis

Melakukan instalasi redis di clusterdb1-3 dengan langkah sama dengan [BDTRedis](https://github.com/TommyHalim/BDTRedis)
Catatan: karena ip node di clusterdb1-3 berbeda dengan redis yang lalu, jangan lupa untuk mengubah ipnya


## 3. Konfigurasi Redis pada Wordpress

Hal ini dilakukan agar wordpress dapat membaca redis. Berikut langkahnya

### a. Menginstal plugin redis pada wordpress di browser
Buka halaman http://192.168.33.14/wordpress/wp-admin/ . Setelah itu, pada tab ```plugin``` di sebelah kiri pilih ```Add New```
![](https://github.com/TommyHalim/EASBDT/blob/master/SS/install_redis_plugin.JPG) 
Pilih plugin ```Redis Object Cache``` dan pilih install. Plugin Redis berhasil diinstal.

### b. Aktifkan plugin Redis Object Cache
Pada tab ```plugin``` , pilih ```Activate``` pada list Redis Object Cache
![](https://github.com/TommyHalim/EASBDT/blob/master/SS/aktifasi.JPG)

### c. Setting Redis Object Cache
Untuk melakukan setting plugin tersebut, maka kita kembali ke clusterdb4 (ProxySQL). Edit ```wp-config.php``` yang ada pada folder /var/www/html/wordpress
~~~
cd var/www/html/wordpress/
sudo nano wp-config.php
~~~
Tambahkan konfigurasi pada wp-config.php
~~~
define( 'WP_REDIS_CLIENT', 'predis' );
define( 'WP_REDIS_SENTINEL', 'mymaster' );
define( 'WP_REDIS_SERVERS', [
    'tcp://192.168.33.11:26379',
    'tcp://192.168.33.12:26379',
    'tcp://192.168.33.13:26379',
] );
~~~

Pada konfigurasi ini hanya ip 11 sampai 13 yang didefinisikan karena redis sendiri hanya diinstal di clusterdb1 sampai dengan clusterdb3. Sedangkan port 26379 sendiri merupakan port sentinel dari Redis
![](https://github.com/TommyHalim/EASBDT/blob/master/SS/wp_config_redis.JPG)
Setelah selesai save dan exit wp-config.php

### d. Enable Redis pada wordpress
Kembali ke Wordpress, masuk ke setting plugin Redis Object Cache Tekan ```Enable Object Cache```
Maka akan muncul tampilan seperti berikut:
![]()


### 4. Testing Redis pada Wordpress

Untuk melihat redis yang sedang berjalan pada clusterdb1 sampai 3 lakukan monitor pada redis-cli
~~~
redis-cli
monitor
~~~
Berikut contoh monitor yang dilakukan padaa saat publish new post:
![](https://github.com/TommyHalim/EASBDT/blob/master/SS/melakukan_publish.JPG)

Sekarang mematikan salah satu redis (boleh master maupun slave) dengan perintah
~~~
redis-cli -p 6379 DEBUG SEGFAULT
~~~
![](https://github.com/TommyHalim/EASBDT/blob/master/SS/mati1.JPG)
Sesuai gambar di atas, Redis masih berjalan walaupun salah satu node redisnya dimatikan. Namun apabila ketiga node dimatikan, maka proses caching tidak akan berjalan karena plugin redis sendiri tidak dapat terkoneksi pada Redis
