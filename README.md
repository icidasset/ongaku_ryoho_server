# Ongaku Ryoho Server

A little Sinatra web server wrapped in a gem specifically for the [Ongaku Ryoho client](https://github.com/icidasset/ongaku_ryoho).

## How to use

### Requirements

`Ruby 1.9.2`

### Installation

```bash
gem install ongaku_ryoho_server
```

### Usage

Go to a music directory and run the web server.

```bash
cd ~/Music
(rvmsudo) ongaku_ryoho_server (-p 80)
```

### Options

Some Sinatra options, that is.

```
-p port    set the port (default is 4567)
-o addr    set the host (default is 0.0.0.0)
-x         turn on the mutex lock (default is off)
```