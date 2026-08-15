local hostname = vim.fn.hostname()

---@param hosts string|string[]
---@return fun(): boolean
return function(hosts)
  if type(hosts) == "string" then
    hosts = { hosts }
  end
  return function()
    return vim.tbl_contains(hosts, hostname)
  end
end
