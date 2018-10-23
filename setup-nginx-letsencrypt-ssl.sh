INSTALL_SSL = true

while true; do
    echo "Please enter the domain name eg: example.com, subdomain.example.com, etc"
    read -p "domain: " DOMAIN_NAME

    if [ "$DOMAIN_NAME" = "" ]; then
        while true; do
            read -p "You didn't enter a domain name. Do you still want to install the LetsEncrypt SSL certificate? (Y/N)" yn
            case $yn in
                [Yy]* ) INSTALL_SSL=true; break;;
                [Nn]* ) INSTALL_SSL=false; break;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi

    if [ "$DOMAIN_NAME" != "" ]; then
        break;
    fi

    if [ $INSTALL_SSL = false ]; then
        break;
    fi                
done  

if [ $INSTALL_SSL = true ]; then

    # Ask if setup of ssl for the www version of the domain is required as well: eg: www.example.com
    while true; do
        echo "Do you also want a certificate for the www version of your domain ie. www.$DOMAIN_NAME?"
        read -p "(Y/N)" yn
        case $yn in
            [Yy]* ) INSTALL_SSL_WWW=true; break;;
            [Nn]* ) INSTALL_SSL_WWW=false; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done


    if [ $INSTALL_SSL_WWW ]; then
        echo "Installing SSL for $DOMAIN_NAME and www.$DOMAIN_NAME"
    else
        echo "Installing SSL for $DOMAIN_NAME"
    fi
    

    # Set up LetsEncrypt
    echo ""
    echo "****************************"
    echo "*  Setting up LetsEncrypt  *"
    echo "****************************"
    echo ""

    sudo add-apt-repository ppa:certbot/certbot -y
    sudo apt install python-certbot-nginx -y

    if [ $INSTALL_SSL_WWW ]; then
        sudo certbot --nginx -d $DOMAIN_NAME -d www.$DOMAIN_NAME
    else
        sudo certbot --nginx -d $DOMAIN_NAME
    fi

fi