# Ongaku Ryoho Server

A little Sinatra web server (with Puma) wrapped in a gem specifically for the Ongaku Ryoho client.

## How to use

### Requirements

`Ruby 1.8.7 (or higher)`

### Installation

```bash
gem install ongaku_ryoho_server
```

### Usage

Go to a music directory and run the web server.

```bash
cd ~/Music
ongaku_ryoho_server
```

or create a [launch agent](https://gist.github.com/4106353) (tested on OSX Mountain Lion)


### Options

```
-p           set the port (default: 7000)

--update     update the cached collection

+ all the other puma cli options
```
