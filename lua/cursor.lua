local number = require('number')

local cursor = {}

cursor.current_line = function()
  return vim.api.nvim_get_current_line()
end

cursor.current_position = function()
  local y, x = unpack(vim.api.nvim_win_get_cursor(0))
  return x, y
end

cursor.move_at = function(x, y)
  vim.api.nvim_win_set_cursor(0, { y, x })
end

cursor.move_lines_by = function(n)
  local x, y = cursor.current_position()

  local line_count = vim.api.nvim_buf_line_count(
    vim.api.nvim_get_current_buf()
  )
  y = number.clamp(1, line_count, y + n)

  cursor.move_at(x, y)
end

cursor.jump_left_over_text = function()
  local x, y = cursor.current_position()
  local line = cursor.current_line()
  local preceding = line:sub(0, x)

  local separator_x = preceding:reverse():find("[%s,.;:()%[%]{}]")
  local jump_x
  if separator_x then
    jump_x = x - number.at_least(1, separator_x - 1)
  else
    jump_x = 0
  end

  cursor.move_at(jump_x, y)
end

cursor.jump_right_over_text = function()
  local x, y = cursor.current_position()
  local line = cursor.current_line()
  local following = line:sub(x + 1)

  local separator_x = following:find("[%s,.;:()%[%]{}]")
  local jump_x
  if separator_x then
    jump_x = x + number.at_least(1, separator_x - 1)
  else
    jump_x = #line
  end

  cursor.move_at(jump_x, y)
end

return cursor
