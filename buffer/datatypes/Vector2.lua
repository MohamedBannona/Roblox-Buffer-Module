local module = {}

local UpdateBuffer = require(script.Parent.Parent.shared).UpdateBuffer

--[[
	Writes a vector3 to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Vector [Vector2] the Vector2 to be written to the buffer
]]
function module:WriteVector2(Vector: Vector2, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(8 + Offset) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 8)

	buffer.writef32(self.Buffer, Offset, Vector.X)
	buffer.writef32(self.Buffer, Offset + 4, Vector.Y)
end

--[[
	Reads a Vector2 from the buffer starting from `Offset` + 1 to `Count` + `Offset`
	@param Offset [number] which byte to start reading from
	@return [Vector2] the Vector2 that has been read
]]
function module:ReadVector2(Offset: number): Vector2
	if not self.Buffer then self.Buffer = buffer.create(Offset + 8); return Vector2.zero end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 8)

	local X = buffer.readf32(self.Buffer, Offset)
	local Y = buffer.readf32(self.Buffer, Offset + 4)

	return Vector2.new(X, Y)
end

return module