# lastweekilearned
My little blog and experiments that go with it. 

## Note
When you break the permissions on the server, this fixes them: 

```
# Reset web server directory and file permissions
sudo chown -R www-data:www-data /var/www/lastweekilearned.com/html
sudo find /var/www/lastweekilearned.com/html -type d -exec chmod 755 {} \;
sudo find /var/www/lastweekilearned.com/html -type f -exec chmod 644 {} \;

# Reset parent directory permissions
sudo chmod 755 /var /var/www /var/www/lastweekilearned.com
```