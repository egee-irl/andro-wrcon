# androgee-coffee ☕

[![Build Status](https://travis-ci.org/egee-irl/androgee-coffee.svg?branch=master)](https://travis-ci.org/egee-irl/androgee-coffee)
[![Maintainability](https://api.codeclimate.com/v1/badges/ae71b9ea55aeb44f67aa/maintainability)](https://codeclimate.com/github/egee-irl/androgee-coffee/maintainability)
[![Discord](https://discordapp.com/api/guilds/183740337976508416/widget.png?style=shield)](https://discord.gg/tVyBHAU)

#### Q: What is this?
**A:** It's a ~~Discord~~ ~~IRC~~ ~~Rcon~~ bot written in CoffeeScript

#### Q: What happened to the ~~JavaScript~~ ~~C#~~ Ruby bot?
**A:** Each language implementation had its own limitation and I am picky about requirements. CoffeeScript offers the best compromise between JavaScript and Ruby.

#### Q: What does it do?
**A:** It plugs into WebSockets & listens on Rcon endpoints and provides updates to a Discord server.

## Dependencies
While androgee-coffee is written in CofeeScript, it's setup as a node module so you don't need to install CoffeeScript to run it. All you need is ``nodejs`` and ``npm``. Running ``npm install`` will install all the required node modules, including CofeeeScript itself.
