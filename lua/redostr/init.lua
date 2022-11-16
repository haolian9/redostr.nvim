local api = vim.api
local unsafe = require("redostr.unsafe")

---@return string
return function()
  local mode = api.nvim_get_mode()
  -- only show in normal mode
  if mode.mode ~= "n" then return "" end

  local cmds = unsafe.get_inserted() or ""
  if #cmds == 0 then return "" end

  -- when exit insert mode, escape often occurs in the tail
  for i = #cmds, 1, -1 do
    local code = string.byte(string.sub(cmds, i, i))
    if code == 0x1b then return ".<ins>" end
  end

  -- .d:lua require'nvim-treesitter.textobjects.select'.select_textobject('@function.inner', 'o')\n
  do
    local found = string.find(cmds, ":lua")
    if found ~= nil then return string.format(".%s<lua>", string.sub(cmds, 1, found - 1)) end
  end

  -- d:cal <SNR>29_HandleTextObjectMapping(1, 0, 0, [line("."), line("."), col("."), col(".")])\n
  do
    local found = string.find(cmds, ":cal")
    if found ~= nil then return string.format(".%s<cal>", string.sub(cmds, 1, found - 1)) end
  end

  return "." .. cmds
end
