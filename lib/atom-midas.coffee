AtomMidasView = require './atom-midas-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomMidas =
  atomMidasView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomMidasView = new AtomMidasView(state.atomMidasViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomMidasView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-midas:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomMidasView.destroy()

  serialize: ->
    atomMidasViewState: @atomMidasView.serialize()

  toggle: ->
    console.log 'AtomMidas was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
