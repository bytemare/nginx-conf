# nginx-conf

A security focused nginx configuration to protect apps and websites.

A set of configuration files to allow easy integration of new apps, modular security and performance features, and easy debugging.

WARNING : If you use these files, please consider understanding their effects. Use them wisely (and chown/chgrp/chmod accordingly).

## Quick wins using this configuration

- [x] Clear tree of linked files that is easy to maintain and update
- [x] Easy inclusion of new apps behind nginx proxy
- [x] High security features by default
- High evaluation on popular web security scanning tools :
  - Mozilla HTTP Observatory : 135
  - SSLabs : A+
  - Security Headers : A+
  - Hardenize : All green

## Predefined redirections

- [x] www to non-www
- [x] http/80 to https/443

## Security Features

- [x] Secure connections only through http/80 redirections to https/443
- [ ] For OCSP Stapling, resolvers used are Cloudflare (1.1.1.1) and Quad9 (9.9.9.9) - but Google (8.8.8.8 and/or 8.8.4.4) would do well, too

### TLS Configuration

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

### Security Headers

- [x] X-Frame-Options always denied, to protect agains clickjacking (can be overridden with CSP)
- [x] Always "nosniff" X-Content-Type-Options
- [x] XSS Protection
- [x] No permitted Cross-Domain-Policies
- [x] Download Options to noopen
- [x] Refferer Policy and Feature Policy to absolut minimum (and easily configurable in snippets/security-rfp.conf)

### Cookie Security

- [x] __Host- security prefix (more powerful than __Secure)
- [x] __Secure- security prefix
- [x] Path=/
- [x] value_locked
- [x] Secure
- [x] HttpOnly
- [x] SameSite=Lax;

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

## Not includes Security features

- X-Robots-Tag to none
- Support for RSA certificate keys (if you have such - shame on you - simply change config accordingly in snippets/tls-params.conf)

## Recommendations

- Run nginx as low-priviledged user (non-root) on higher, "userland" ports
- Use PF or iptables to redirect traffic from port 80 and 443 internally to nginx
- Secure files correctly (change owner, group, and access modes)
- Use an Elliptic Curve in your server certificate (e.g. Curve25519, or at least secp256k1)
- Must-Staple your server certificate
- Enlist your top domain to the HSTS preload list
- Take some time to mess with your CSP