
# Browsable chess openings in PGN format

This script builds a PGN file from an ECO database. It allows you to explore the openings by name like a study.


## Install

- Install NodeJS
- Run once `npm install -g coffeescript`
- Download once [this file](https://raw.githubusercontent.com/pychess/pychess/master/lang/en/eco.pgn) (for example)
- Run `coffee -b -c pgn.coffee`
- Run `node pgn.js > openings.pgn`
- Use `openings.pgn` in your favorite chess application


## Licence

```
Browsable chess openings in PGN format
Copyright (C) 2018, ecrucru

	https://github.com/ecrucru/pgn-openings/
	http://ecrucru.free.fr/?page=ouvertures

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
```
