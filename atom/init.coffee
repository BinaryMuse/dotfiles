# auto-indent when changing line or inserting at end of line
atom.commands.onDidDispatch (evt) ->
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
