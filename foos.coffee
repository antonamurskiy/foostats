require('style-bootstrap')
require( './foos.scss')
$ = require('jquery')
store = require('store')
window.st = store

init = ->  
  @template = '<div class="players"></div>'
  render()

render = ->
  document.body.innerHTML = @template
  playerContainer = document.querySelector '.players'

  $(playerContainer).height $(window).height()

  for i, player of store.getAll()
    winPercentage = Math.floor((player.wins*100) / (player.wins+player.losses))

    singlePlayer = $("<div class='player'><div class='name'>#{player.name}</div></div>")
    singlePlayer.css 
      'background-color': player.color
      'height': winPercentage+"%"
      'width': ($(playerContainer).width()/Object.keys(store.getAll()).length)

    stats = $("<div class='stats'><div class='stat'>W: <b>#{player.wins}</b> L: <b>#{player.losses}</b></div></div>")
    percentage = $("<div class='percentage'>#{winPercentage}%</div>")
    controls = $("<div class='controls'><div class='control plus' data-id='#{i}' data-action='plus'>+</div><div class='control minus' data-id='#{i}' data-action='minus'>-</div></div>")

    singlePlayer.prepend percentage
    singlePlayer.append stats, controls
    $(playerContainer).append singlePlayer

  setupActions()


setupActions = ->  
  $('.control').click ->
    id = $(@).attr 'data-id'
    action = $(@).attr 'data-action'

    current = store.get(id)

    if action is 'plus'
      current.wins = current.wins+1
    else 
      current.losses = current.losses+1

    store.set(id, current)
    render()

$ ->
  init()
$(window).resize -> 
  render()