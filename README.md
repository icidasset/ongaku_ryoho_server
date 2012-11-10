# Ongaku Ryoho Server

A little Sinatra web server (with Thin) wrapped in a gem specifically for the Ongaku Ryoho client.

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
```

### Options

```
-p           set the port (default: 3000)
-d           daemonize

--update     update the cached collection

+ all the other thin cli options
```
