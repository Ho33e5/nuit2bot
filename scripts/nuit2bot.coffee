# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
#
# Commands:
#   hubot regles - Afficher les regles
#   hubot v - try me

fs = require 'fs'
charte = fs.readFileSync( require('path').resolve(__dirname, 'charte.txt')).toString()
console.log charte

module.exports = (robot) ->
#  setInterval ->
#    robot.messageRoom 'accueil', charte,
#    1000*60*60*3 #toutes les 3 heures

  robot.respond /v/i, (res)->
    res.send 'http://i.imgur.com/o3Sn8JV.jpg'

  robot.respond /regles/i, (res) ->
    res.send charte

  lulz = ['lol', 'rofl', 'lmao']

  robot.respond /lulz/i, (res) ->
    res.send res.random lulz

  robot.respond /set-moderator @(\S*) ?.*/i, (res) ->
      user = robot.brain.userForName res.match[1]
      robot.adapter.callMethod 'addRoomModerator', [res.envelope.room, user.id]

  robot.respond /mute @(\S*) ?.*/i, (res) ->
      user = robot.brain.userForName res.match[1]
      robot.adapter.callMethod 'muteUserInRoom', {rid: res.envelope.room, username: user.name}
