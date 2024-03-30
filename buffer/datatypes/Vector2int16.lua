local module = {}

local UpdateBuffer = require(script.Parent.Parent.shared).UpdateBuffer

--[[
	Writes a Vector2int16 to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Vector [Vector2int16] the Vector2int16 to be written to the buffer
]]
function module:WriteVector2int16(Vector: Vector2int16, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(4 + Offset) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 4)

	buffer.writei16(self.Buffer, Offset, Vector.X)
	buffer.writei16(self.Buffer, Offset + 2, Vector.Y)
end

--[[
	Reads a Vector2int16 from the buffer starting from `Offset` + 1 to `Count` + `Offset`
	@param Offset [number] which byte to start reading from
	@return [Vector2int16] the Vector2int16 that has been read
]]
function module:ReadVector2int16(Offset: number): Vector2int16
	if not self.Buffer then self.Buffer = buffer.create(Offset + 4); return Vector2int16.new() end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 4)

	local X = buffer.readi16(self.Buffer, Offset)
	local Y = buffer.readi16(self.Buffer, Offset + 2)

	return Vector2int16.new(X, Y)
end

return module