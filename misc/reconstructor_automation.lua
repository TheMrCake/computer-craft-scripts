local function pulse(direction)
  redstone.setOutput(direction, true)
  sleep(0.3)
  redstone.setOutput(direction, false)
end

local function pulseLeft()
  pulse("left")
end

local function pulseBack()
  pulse("back")
end

local dropper = peripheral.wrap("left") or error("There aint nothin there!!!")
local vaccuum = peripheral.wrap("back") or error("There aint nothin there!!!")

while true do
  local dropperInv = dropper.list()
  if #dropperInv > 0 then
    while #dropperInv > 0 do
      print("DROP")
      pulseLeft()
    end
    pulseBack()
  end
  sleep(0.5)
end
