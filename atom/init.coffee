console.log("%cHello! My PID is %c" + process.pid, "font-size: 20px;", "font-weight: bold; font-size: 20px;")
if atom.devMode
  document.body.classList.add('dev-mode')
  # document.querySelector('meta[http-equiv="Content-Security-Policy"]').remove()

#   dmElem = document.createElement('div')
#   dmElem.textContent = 'dev mode'
#   dmElem.classList.add('dev-mode-indicator')
#   document.body.appendChild(dmElem)

# atom.workspace.onDidAddPaneItem ({item, pane}) ->
#   pane.setPendingItem(null)
#   process.nextTick () => atom.views.getView(item).focus()

  pidEl = document.createElement('div')
  pidEl.textContent = "PID: #{process.pid}"
  pidEl.style.display = "inline-block"
  pidEl.style.paddingLeft = "3px"
  atom.packages.serviceHub.consume 'status-bar', '^1.0.0', (statusBar) ->
    statusBar.addLeftTile(item: pidEl, priority: -100)

handleAutoIndentAfterChangeLine = (evt) ->
  # validCommands = [
  #   'vim-mode-plus:change',
  #   'vim-mode-plus:insert-after-end-of-line'
  # ]
  # return unless evt.type in validCommands
  # editor = atom.workspace.getActivePaneItem()
  # element = editor.getElement()
  # return unless 'insert-mode' in element.classList
  # for cursor in editor.getCursors()
  #   return unless cursor.getBufferColumn() is 0
  # editor.autoIndentSelectedRows()

handleTrimWhitespaceAfterEscape = (evt) ->
  validCommands = [
    'vim-mode-plus:reset-normal-mode'
    'vim-mode-plus:activate-normal-mode'
  ]
  return unless evt.type in validCommands
  editor = atom.workspace.getActivePaneItem()
  for cursor in editor.getCursors()
    row = cursor.getBufferRow()
    text = editor.buffer.getLines()[row]
    if text.match /^\s+$/
      editor.deleteToBeginningOfLine()

markPending = false
markers = []

handleSetVmpMarkPending = (evt) ->
  validCommands = [
    'vim-mode-plus:mark'
  ]
  return unless evt.type in validCommands

  editor = atom.workspace.getActiveTextEditor()
  elem = editor.getElement()
  if elem.classList.contains 'mark-pending'
    markPending = true
    markers = editor.getMarkers()

handleResolveVmpMarks = (evt) ->
  return unless markPending
  markPending = false

  editor = atom.workspace.getActiveTextEditor()
  markersNow = editor.getMarkers()
  newMarkers = markersNow.filter (m) -> markers.indexOf(m) is -1
  console.log('added', newMarkers)

atom.commands.add 'atom-workspace', 'user:toggle-github-tab', =>
  atom.config.set 'github.githubEnabled', !atom.config.get('github.githubEnabled')

atom.commands.onDidDispatch (evt) ->
  handleSetVmpMarkPending(evt)

atom.commands.onWillDispatch (evt) ->
  handleResolveVmpMarks(evt)
  # handleTrimWhitespaceAfterEscape(evt)
