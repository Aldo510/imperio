# Imperio

## Kamal on DigitalOcean

This project is prepared to deploy with Kamal to a DigitalOcean Droplet using DigitalOcean Container Registry and a `DATABASE_URL`-based PostgreSQL connection.

Files added for deployment:

- `config/deploy.yml`
- `.kamal/secrets`
- `.kamal/secrets-common`

Before the first deploy:

1. Install Kamal locally with `gem install kamal`.
2. Edit `config/deploy.yml` and replace:
   - `image` with your DigitalOcean Container Registry path, for example `my-registry/imperio`
   - `203.0.113.10` with your Droplet IP
3. Export these local environment variables before deploying:
   - `KAMAL_REGISTRY_USERNAME`
   - `KAMAL_REGISTRY_PASSWORD`
   - `DATABASE_URL`
   - `S3_ACCESS_KEY`
   - `S3_SECRET_KEY`
   - `S3_REGION`
   - `S3_BUCKET`
4. If you already have a domain pointing to the Droplet, uncomment `host`, `ssl`, and `forward_headers` inside `config/deploy.yml`, then set `APP_HOSTS` and `FORCE_SSL` accordingly.

Useful commands:

- `bundle exec kamal setup`
- `bundle exec kamal deploy`
- `bundle exec kamal app logs`
