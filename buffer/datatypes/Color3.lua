local module = {}

local UpdateBuffer = require(script.Parent.Parent.shared).UpdateBuffer

--[[
	Writes a Color3 to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Vector [Color3] the Color3 to be written to the buffer
]]
function module:WriteColor3(Color: Color3, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(3 + Offset) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 3)

	local R, G, B = math.clamp(Color.R, 0, 1) * 255, math.clamp(Color.G, 0, 1) * 255, math.clamp(Color.B, 0, 1) * 255

	buffer.writeu8(self.Buffer, Offset, R)
	buffer.writeu8(self.Buffer, Offset + 1, G)
	buffer.writeu8(self.Buffer, Offset + 2, B)
end

--[[
	Reads a Color3 from the buffer starting from `Offset` + 1 to `Count` + `Offset`
	@param Offset [number] which byte to start reading from
	@return [Color3] the Color3 that has been read
]]
function module:ReadColor3(Offset: number): Color3
	if not self.Buffer then self.Buffer = buffer.create(Offset + 3); return Color3.new(0, 0, 0) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 3)

	local R = buffer.readu8(self.Buffer, Offset)
	local G = buffer.readu8(self.Buffer, Offset + 1)
	local B = buffer.readu8(self.Buffer, Offset + 1)

	return Color3.fromRGB(R, G, B)
end

return module