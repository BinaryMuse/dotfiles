# auto-indent when changing line or inserting at end of line
handleAutoIndentAfterChangeLine = (evt) ->
  validCommands = [
    'vim-mode-plus:change',
    'vim-mode-plus:insert-after-end-of-line'
  ]
  return unless evt.type in validCommands
  editor = atom.workspace.getActivePaneItem()
  element = editor.getElement()
  return unless 'insert-mode' in element.classList
  for cursor in editor.getCursors()
    return unless cursor.getBufferColumn() is 0
  editor.autoIndentSelectedRows()

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

atom.commands.onDidDispatch (evt) ->
  handleAutoIndentAfterChangeLine(evt)

atom.commands.onWillDispatch (evt) ->
  handleTrimWhitespaceAfterEscape(evt)
