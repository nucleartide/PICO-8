
--
-- badass fsm mini-framework
--

local function munpack(t, from, to)
  from = from or 1
  to = to or #t
  if from > to then return end
  return t[from], munpack(t, from+1, to)
end

local function msg(c, s)
  if not c and s then print(s) end
  return c
end

--
-- TODO: Rename to actor.
--

local function new(state, draw, ...)
  local args = {...}
  local u = cocreate(function() state(munpack(args)) end)
  local d = cocreate(function() draw(munpack(args)) end)
  return { update = u, draw = d }
end

return {
  msg = msg,
  new = new,
}
