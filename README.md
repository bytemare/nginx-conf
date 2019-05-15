# nginx-conf

A security focused nginx configuration to protect apps and websites and indications to create a neat and robust certificate signed byt Let's Encrypt to use with the server.

A set of configuration files to allow easy integration of new apps, modular security and performance features, and easy debugging.

WARNING :

- If you use these files, please consider understanding their effects. Use them wisely.
- This server DOES NOT protect against vulnerabilities of the webapp your using behind the proxy, nor against misconfiguration of your machine

## Quick wins using this configuration

- [x] Clear tree of linked files that is easy to maintain and update
- [x] Easy inclusion of new apps behind the nginx proxy
- [x] High security features by default
- [x] Content Security Policy for a Ghost Blog

Maximum score on popular web security scanning tools :

- SSLabs : A+
- Security Headers : A+
- Hardenize : All green
- Mozilla HTTP Observatory : 135/100

## Robust Certificate

Joined is a certificate creation script, helping to create a robust certificate for your server.
Make sure to understand how it works. You also may want to automate the renewal process, which can be included, but you'll have to integrate the steps concerning your DNS provider.

- [x] Uses a 256-bit Elliptic Curve
- [x] Auto-renewal
- [x] Signed by Let's Encrypt
- [x] Wildcard-able certificate
- [x] OCSP Must-Staple TLS extension
- [x] Certificate Transparency TLS Extension

## Strong TLS configuration

This configuration is made with paranoia. All configuration parameters are set to the most secure and resilient values. We also add some more layers of security with OCSP Stapling and HSTS.

### Predefined redirections

- [x] www/80 to www/443
- [x] www/443 to non-www/443
- [x] http/80 to https/443, forcing all connections to be secured

### TLS Parameters

- [x] Restrict to TLS 1.3 and TLS 1.2
- [x] TLS Key Exchange restricted to ECDHE
- [x] TLS Handshake restricted to ECDSA
- [x] TLS ciphers restricted to ChaCha20-Poly1305 and AES
- [x] AES modes restricted to GCM and CCM
- [x] OCSP Stapling

### TLS Headers

- [x] HSTS set to 1 year, including subdomains and preloading
- [x] Expect-Staple set to 1 year, include subdomains and preload
- [x] Expect-CT set to 1 year, enforced

## Fully secured NGINX configuration

### Security Headers

- [x] X-Frame-Options always denied, to protect agains clickjacking (can be overridden with CSP)
- [x] Always "nosniff" X-Content-Type-Options
- [x] XSS Protection
- [x] No permitted Cross-Domain-Policies
- [x] Download Options to noopen
- [x] Refferer Policy and Feature Policy to absolut minimum

### Cookie Security

- [x] __Host- security prefix (more powerful than __Secure)
- [x] __Secure- security prefix
- [x] Path=/
- [x] value_locked
- [x] Secure
- [x] HttpOnly
- [x] SameSite=Strict

### CSP - Content Security Policy

Tailored for a Ghost Blog

- [x] default-src to 'none'
- [x] no 'unsafe_inline'
- [x] strict-dynamic script-src
- [x] true random nonces for style-source and script-source elements
- [x] automatic injection of these nonces in scripts, stylesheets and stylesheet evocation
- [x] frame-ancestors control
- [x] Require SRI for scripts and styles
- [x] no 'unsafe-eval' in script-src

## Other Features

- [x] For OCSP Stapling, resolvers used are Cloudflare (1.1.1.1) and Quad9 (9.9.9.9) - but Google (8.8.8.8 and/or 8.8.4.4) would do well, too

## Not included features

- X-Robots-Tag to none
- Support for RSA certificate keys (if you have such - shame on you - simply change config accordingly in snippets/tls-params.conf)

## Recommendations

- Run nginx as low-priviledged user (non-root) on higher, "userland" ports
  - create a unique system account (e.g. "nginx", but not "nobody")
    - groupadd -r nginx
    - useradd nginx -r -g nginx -d /var/cache/nginx -s /sbin/nologin
    - in nginx.conf : "user nginx;"
  - Use PF or iptables to redirect traffic from port 80 and 443 internally to nginx
- Secure files correctly (change owner, group, and access modes)
- If you don't use the given script for your certificates, use an Elliptic Curve in your server certificate (e.g. EdDSA when available, or at least secp256k1)
- Must-Staple your server certificate
- Enlist your top domain to the HSTS preload list and include all subdomains
- Take some time to mess with your CSP