# new_vhost
# inspired from http://rosehosting.com
#     TODO: select which kind of vhost?
#             php or ruby
#           open hosts file, to add more local domains manually
#           check if file already exists
#           restart nginx?

# check Functions
function ok
    set_color green
    echo $argv
    set_color normal
end
function die
    set_color red
    echo $argv
    set_color normal
end
 
function new_vhost -d "create new vhost"
    # set some variables
    set VHOST $argv
    set VHOST_DIR '/usr/local/Cellar/nginx/1.2.1/conf/sites-enabled'
    set WEB_DIR '/Users/juanolon/www'
    set LOG_DIR '/var/log/nginx'
    
    # Sanity check
    # the check works, but then appear "sudo: new_vhost: command not found"
    # if test (id -g) != "0"
    #     die "Script must be run as root."
    # end
    if not test (count $argv) > 0
        die "Usage: (basename $0) domainName"
    end

    if test -e $VHOST_DIR/$VHOST
        echo "File $VHOST_DIR/$VHOST already exists"
        # TODO
        # echo "Do you want to replace it?"
    end
    
    # Create nginx config file
    echo "server{
	    listen 80;
	    server_name $VHOST;

	    access_log $LOG_DIR/$VHOST.access_log;
	    error_log $LOG_DIR/$VHOST.error_log;

	    charset utf-8;

	    allow 127.0.0.1;
	    deny all;

	    location / {
	    root $WEB_DIR/$VHOST;
	    index index.html index.php;
	    }

	    location ~ \.php\$ {
	        fastcgi_pass    127.0.0.1:9000;
	        fastcgi_index   index.php;
	        fastcgi_param   SCRIPT_FILENAME $WEB_DIR/$VHOST$fastcgi_script_name;
	        include         fastcgi_params;
	    }
    }" > $VHOST_DIR/$VHOST.conf
    
    # TODO
    # Restart
    # echo "Do you wish to reload nginx?"
    # select yn in "Yes" "No"; do
    #     case $yn in
    #         Yes ) ngx_relaod; break;;
    #         No ) exit;;
    #     esac
    # done
    # for now, just reload it
    ngx_reload

    # TODO
    # add domain to hosts file. if user require, open the file
    sudo echo "# $VHOST
          127.0.0.1 $VHOST" >> /etc/hosts

    # Do you want to continue editing the created vhost file?
    # vim $VHOST_DIR/$VHOST.conf
    
    mkdir $WEB_DIR/$VHOST
    cd $WEB_DIR/$VHOST

    ok "Site Created for $VHOST"
end
