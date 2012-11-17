# Ongaku Ryoho Server

A little Sinatra web server (with Puma) wrapped in a gem specifically for the Ongaku Ryoho client.

## How to use

### Requirements

`Ruby 1.9.2 (or higher)`

### Installation

```bash
gem install ongaku_ryoho_server
```

### Usage

Go to a music directory and run the web server.

```bash
cd ~/Music
ongaku_ryoho_server start
ongaku_ryoho_server stop (must be in the same directory)
```

### Options

```
-p           set the port (default: 7000)
-d           daemonize

--update     update the cached collection

+ all the other puma cli options
```
