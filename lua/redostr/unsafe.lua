local M = {}

local ffi = require("ffi")

ffi.cdef([[
  unsigned char *get_inserted(void);
  void xfree(void * p);
]])

local C = ffi.C

---@return string|nil
function M.get_inserted()
  local p = ffi.gc(C.get_inserted(), C.xfree)
  if p == nil then return end
  return ffi.string(p)
end

return M
