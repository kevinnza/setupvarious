SETUP_DOMAIN=true

while true; do
    echo "This will set up a server block for a domain you specify"
    echo "Please enter the name of domain to set up on Nginx for this server (leave out the www) eg: example.com"
    read -p "domain: " DOMAIN_NAME

    if [ "$DOMAIN_NAME" = "" ]; then
        while true; do
            read -p "You didn't enter a domain name. Do you still want to set up the domain? (Y/N)" yn
            case $yn in
                [Yy]* ) SETUP_DOMAIN=true; break;;
                [Nn]* ) SETUP_DOMAIN=false; break;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi

    if [ "$DOMAIN_NAME" != "" ]; then
        break;
    fi

    if [ $SETUP_DOMAIN = false ]; then
        break;
    fi                
done  

if [ $SETUP_DOMAIN = true ]; then
    echo "Installing SSL for" $DOMAIN_NAME

    # Set up LetsEncrypt
    echo ""
    echo "****************************"
    echo "*  Setting up LetsEncrypt  *"
    echo "****************************"
    echo ""

    sudo add-apt-repository ppa:certbot/certbot
    sudo apt install python-certbot-nginx         

    sudo certbot --nginx -d $DOMAIN_NAME -d www.$DOMAIN_NAME

fi