# Automated Deployment Process for WordPress Website using Nginx

This script automates the deployment process for setting up a WordPress website using Nginx as the web server. It includes installation and configuration steps for Nginx, MySQL, PHP, and WordPress, along with additional configurations for server block, caching, gzip compression, and SSL/TLS certificate installation.

## Usage
1. Clone this repository or download the script directly onto your server.
2. Make the script executable:

    ```
    chmod +x deploy_wordpress.sh
    ```
3. Execute the script:

    ```
    ./deploy_wordpress.sh
    ```

## Script Overview
The script performs the following actions:
- Update Apt: Update the package index and upgrade the system packages.
- Install Nginx: Install the Nginx web server.
- Enable and Start Nginx: Enable and start the Nginx service.
- Install MySQL: Install MySQL server and client.
- Configure MySQL Security: Secure MySQL installation by running mysql_secure_installation.
- Create WordPress Database and User: Create a database for WordPress and a corresponding user with necessary privileges.
- Install PHP and PHP-FPM: Install PHP and PHP-FPM for processing PHP files.
- Download and Install WordPress: Download the latest version of WordPress, unzip it, and copy the files to the web root directory.
- Configure Nginx Server Block: Modify the default Nginx server block for WordPress.
- Modify Nginx Configuration: Update Nginx configuration with caching and gzip compression settings.
- Check Nginx Syntax and Restart Nginx: Verify Nginx configuration syntax and restart the Nginx service.
- Install SSL/TLS Certificate: Install SSL/TLS certificates from Let's Encrypt using Certbot.

## Important Notes
- Ensure that the script is executed with appropriate permissions and on a compatible Linux distribution.
- Replace `www.linuxtest.hopto.org` with your domain name in the Nginx server block configuration.
- Update the email address `your_email@gmail.com` in the SSL certificate installation command with your valid email address.

## Author
This deployment script was created by Pramod Kapade. For any inquiries or issues, please contact LinkedIn: [Rushikesh Bhatjire][(https://www.linkedin.com/in/rushikeshbhatjire/)].

Feel free to contribute to this script or provide feedback to improve its functionality. Happy deploying!
