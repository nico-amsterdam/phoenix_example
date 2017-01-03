# PhoenixExample

## Included example
  * Scrape - Scrape parts of websites and rss-feeds and show them combined on one web page

## Installation

### Install Elixir

Follow the instructions on http://elixir-lang.org/install.html

Also install [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

Also install node (6 or newer) and node package manager (npm)

[ubuntu / debian](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server)
```sh
curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
apt-get install -y nodejs
```

Also install inotify-tools (to detect file changes for live reloading)
```sh
apt-get install -y inotify-tools
```

### Clone project

```sh
$ git clone https://github.com/nico-amsterdam/phoenix_example.git
```

### Compile & run Phoenix

```sh
$ cd phoenix_example
$ mix deps.get
$ mkdir priv/data/mnesia
$ mix ecto.create
$ mix ecto.migrate
$ mix phoenix.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
