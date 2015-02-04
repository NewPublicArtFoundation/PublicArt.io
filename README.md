# Public Art

Internet's largest database of geotagged graffiti.

### Mac startup instructions
`brew install postgresql`
`gem install bundler`
`bundle install`
`rake db:schema:load`
`rake db:migrate RAILS_ENV=development`
`unicorn_rails`

Then go to http://localhost:8080/

### Unicorn stuff

Unicorn will bind to all interfaces on TCP port 8080 by default.
You may use the `--listen/-l` switch to bind to a different address:port or a UNIX socket.

### Reference

https://api.instagram.com/v1/subscriptions?client_secret=[SECRET]&client_id=[ID]
