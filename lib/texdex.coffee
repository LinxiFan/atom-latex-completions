{CompositeDisposable} = require 'atom'
provider = require './provider'

module.exports =
  config:
    customAliases:
      type: 'string'
      default: ''
      description: 'Path to a custom set of completions. Multiple paths may be comma-seperated.'
      order: 1
    enableDefaultCompletions:
      type: 'boolean'
      default: true
      description: 'Disable this to use only custom completions.'
      order: 2
    selector:
      type: 'string'
      default: '.tex, .latex'
      description: 'Enable completions under these scopes:'
      order: 3
    disableForSelector:
      type: 'string'
      default: '.nothing'
      description: 'Disable completions under these scopes:'
      order: 4

  activate: ->
    console.log "I am activated"

    atom.config.get("texdex.enableDefaultCompletions") && provider.load()

    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.config.observe 'texdex.customAliases', (path) =>
      for path in path.split(',')
        provider.load(path)

  provide: -> provider

  deactivate: ->
    @subscriptions.dispose()
