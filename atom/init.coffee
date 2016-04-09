# auto-indent after changing line (`c c`)
atom.commands.onDidDispatch (evt) ->
  return unless evt.type is 'vim-mode-plus:change'
  editor = atom.workspace.getActivePaneItem()
  for cursor in editor.getCursors()
    return unless cursor.getBufferColumn() is 0
  element = editor.getElement()
  editor.autoIndentSelectedRows() if 'insert-mode' in element.classList
