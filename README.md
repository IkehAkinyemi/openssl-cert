# SSL Certificate Generation Script
This script is a bash shell script that generates SSL certificates for use with web servers. The script generates a self-signed certificate for a certificate authority (CA) and a signed certificate for a web server.

## Requirements
The script requires the OpenSSL library to be installed on the system. It has been tested on Ubuntu and macOS, and should work on other Unix-like systems as well.

## Usage
To use the script, simply run it from the command line with root privileges:

```bash
sudo ./generate_ssl_cert.sh
```

The script performs the following steps:

- Remove any existing `.pem` files in the current directory.
- Generate a private key and a self-signed certificate for the CA.
- Display the self-signed certificate for the CA.
- Generate a private key and a certificate signing request (CSR) for the web server.
- Use the CA's private key to sign the web server's CSR and generate a signed certificate for the web server.
- Display the signed certificate for the web server.
- Verify the signed certificate using the CA's certificate.

The generated files will be saved in the current directory.

## Customization
The script can be customized by modifying the following values:

- The `subj` parameter in the `openssl req` commands can be changed to customize the details of the certificates.
- The `days` parameter in the CA and server certificate generation commands can be changed to adjust the validity period of the certificates.
- The filenames of the generated certificates can be changed by modifying the output file names in the commands.

## Security
This script is designed for generating SSL certificates for development and testing purposes only. It should not be used for production systems. The generated certificates are self-signed and not trusted by any certificate authority. Therefore, they are vulnerable to man-in-the-middle attacks. For production systems, you should use certificates issued by a trusted certificate authority.