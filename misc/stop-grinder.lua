
local meatTank = peripheral.wrap("advancedFluidTank_1") or error("MeatTank not found")
local pinkSlimeTank = peripheral.wrap("advancedFluidTank_0") or error("PinkSlimeTank not found")

while true do
  local output = true
  if meatTank.getCapacity() == meatTank.getStored().amount then
    output = false
  end

  redstone.setOutput("bottom", output)
end
