# Ongaku Ryoho Server

A little web server (with Puma) wrapped in a gem specifically for the Ongaku Ryoho client.

## How to use

### Requirements

- taglib
- ruby 1.8.7 (or higher)

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
-> https://github.com/puma/puma/blob/v2.8.1/lib/puma/cli.rb#L93

-d           daemonize
```
