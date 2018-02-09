
###
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
###


# -- Dependencies
fs = require 'fs'
pgn_file = 'eco.pgn'


# -- Loads the PGN file
if not fs.existsSync pgn_file
	console.log 'Please download the source PGN file as described in README.md'
	return
data = fs.readFileSync pgn_file, 'utf8'
data = data.split("\r").join('').split("\n")


# -- Reads the multiple games to build the final PGN
pgn = {}
eco = {}

clear_header = ->
	eco =
		eco : ''
		opening : ''
		variation : ''
		moves : ''
	return

clear_header()
for i in [0..data.length-1]
	input = data[i].trim()

	# Processes the moves
	if input.length is 0
		if eco.moves.length is 0
			continue

		# Processes the moves
		ref_pgn = pgn
		moves = eco.moves.split ' '
		for j in [0..moves.length-1]
			move = moves[j]
			if move.length is 0 or move.match(/^[0-9]+\.+$/)
				continue

			# Creates the node
			if not ref_pgn.hasOwnProperty move
				ref_pgn[move] = {}
			ref_pgn = ref_pgn[move]

		# Adds the comment
		comment = eco.eco
		if eco.opening.length > 0
			comment += " " if comment.length > 0
			comment += eco.opening
		if eco.variation.length > 0
			comment += ", " if comment.length > 0
			comment += eco.variation
		comment = comment.trim()
		if comment.length > 0
			ref_pgn.comment = comment

		# Resets the game
		clear_header()
		continue

	# Processes the header
	regexp = input.match(/^\[([a-z]+) \"(.*)\"\]$/i)
	if regexp isnt null
		eco[regexp[1].toLowerCase()] = regexp[2]
		continue

	# Add the found moves
	if eco.moves.length isnt 0
		eco.moves += ' '
	eco.moves += input


# -- Builds the target PGN content
pgn_explore = (node) ->
	# Checks
	return if typeof node isnt 'object'

	# Comment of the node
	if node.hasOwnProperty('comment')
		buffer += '{'+node.comment+'} '
		delete node.comment

	# Moves of the node
	keys = Object.keys(node)
	return if keys.length is 0

	# Recursively scans
	for i in [0..keys.length-1]
		buffer += '(' if i > 0
		buffer += keys[i] + ' '
		if i > 0
			pgn_explore(node[keys[i]])
		buffer += ') ' if i > 0
	pgn_explore(node[keys[0]])
	return

buffer = """
[Event \"All the chess openings\"]
[Site \"Copyright © To be completed here\"]
[Date \"2018.02.10\"]
[Round \"?\"]
[White \"White\"]
[Black \"Black\"]
[Result \"*\"]
[Termination \"unterminated\"]


"""
pgn_explore(pgn)


# -- Final output
console.log buffer
