# nginx-conf

A security focused nginx configuration to protect apps and websites.

A set of configuration files to allow easy integration of new apps, modular security and performance features, and easy debugging.

WARNING : If you use these files, please consider understanding their effects. Use them wisely (and chown/chgrp/chmod accordingly).

- [x] Tree of linked files
- [x] Easy inclusion of new apps behind nginx proxy
- [x] High security features by default

### Predefined redirections

- [x] www to non-www
- [x] http/80 to https/443

### Security Features

#### TLS Configuration

- [x] Secure connections only through http/80 redirections to https/443
- [x] Restrict to TLS 1.3 and TLS 1.2
- [x] TLS Key Exchange restricted to ECDHE
- [x] TLS Handshake restricted to ECDSA
- [x] TLS ciphers restricted to ChaCha20-Poly1305 and AES-256
- [x] OCSP Stapling

#### Security Headers

- [x] Always deny X-Frame-Options
- [x] Always "nosniff" X-Content-Type-Options
- [x] XSS Protection
- [x] No permitted Cross-Domain-Policies
- [x] Refferer Policy and Feature Policy to absolut minimum (and easily configurable in snippets/security-rfp.conf)
- [x] Secure Cookie setting (configurable in snippets/security-cookies.conf)
- [x] HSTS header of one year, including subdomains and preloading
- [x] Expect-CT header
- [x] Expect-Staple
- [x] Download Options to noopen

#### Cookie Security

- [x] __Host- security prefix (more powerful than __Secure)
- [x] __Secure- security prefix
- [x] Path=/
- [x] value_locked
- [x] Secure
- [x] HttpOnly
- [x] SameSite=Lax;

##### Not includes Security features

- CSP Headers (to be defined for every page you make)
- X-Robots-Tag to none
- Support for RSA certificate keys (if you have such - shame on you - simply change config accordingly in snippets/tls-params.conf)

### Recommendations

- Secure files correctly (change owner, group, and access modes)
- Use an Elliptic Curve in your server certificate (e.g. Curve25519, or at least secp256k1)
- Must-Staple your server certificate
- Enlist your top domain to the HSTS preload list
