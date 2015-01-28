module.exports =
  config:
    enableTypeChecking:
      type: 'boolean'
      default: true
    enableAutoComplete:
      type: 'boolean'
      default: true
    typeCheckerCommand:
      type: 'string'
      default: 'hh_client'
  Subscriptions:[]
  V:{}
  Status:{}
  activate:->
    @V.FS = require('fs')
    @V.Path = require('path')
    @V.SSH = require('node-ssh')
    @V.CP = require('child_process')
    @V.H = require('./h')(this);
    @V.TC = require('./typechecker')(this);
    @V.AC = require('./autocomplete')(this);
    @Status.TypeChecker = false
    @Status.AutoComplete = false
    @V.H.readConfig().then =>
      @V.H.spawn()
      atom.config.observe 'Atom-Hack.enableTypeChecking',(status)=>
        if status
          @V.TC.activate()
        else
          @V.TC.deactivate()
      atom.config.observe 'Atom-Hack.enableAutoComplete',(status)=>
        if status
          @V.AC.activate()
        else
          @V.AC.deactivate()
  deactivate:->
    @V.TC.deactivate();
    @V.AC.deactivate();