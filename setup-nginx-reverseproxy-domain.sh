SETUP_DOMAIN=true

while true; do
    echo "This will set up a reverse proxy server block for a domain you specify"
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
    echo "Creating server block for" $DOMAIN_NAME

    # Set up nginx domain
    echo ""
    echo "****************************"
    echo "*  Setting up Nginx domain  *"
    echo "****************************"
    echo ""

    sudo bash -c "echo -e \"server {\n\n    listen 80;\n    listen [::]:80;\n\n    server_name $DOMAIN_NAME;\n\n    location / {\n        proxy_pass http://localhost:8080;\n        proxy_http_version 1.1;\n        proxy_set_header Upgrade \x24http_upgrade;\n        proxy_set_header Connection keep-alive;\n        proxy_set_header Host \x24http_host;\n        proxy_cache_bypass \x24http_upgrade;\n    }\n}\" > /etc/nginx/sites-available/$DOMAIN_NAME"

    sudo ln -s /etc/nginx/sites-available/$DOMAIN_NAME /etc/nginx/sites-enabled/

fi