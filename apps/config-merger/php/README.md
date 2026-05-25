# ==== PHP merger (index.php + merge.php) ====

This is a PHP script for merging a new .dist file with your existing .conf file (worldserver.conf.dist and authserver.conf.dist)

It uses sessions so it is multi user safe, it adds any options that are removed to the bottom of the file commented out, just in case it removes something it shouldn't.
If you add your custom patch configs below "# Custom" they will be copied exactly as they are.

Your new config will be found under $basedir/session_id/newconfig.conf.merge

If you do not run a PHP server on your machine you can read this guide on ["How to execute PHP code using command line?"](https://www.geeksforgeeks.org/how-to-execute-php-code-using-command-line/) on geeksforgeeks.org.

```
php -S localhost:port -t E:\Azerothcore-wotlk\apps\config-merger\php\
```

Change port to an available port to use. i.e 8000

Then go to your browser and type:

```
localhost:8000/index.php
```
