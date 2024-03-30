local module = {}

local UpdateBuffer = require(script.Parent.Parent.shared).UpdateBuffer

--[[
	Writes a Vector3 to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Vector [Vector3] the Vector3 to be written to the buffer
]]
function module:WriteVector3(Vector: Vector3, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(12 + Offset) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 12)

	buffer.writef32(self.Buffer, Offset, Vector.X)
	buffer.writef32(self.Buffer, Offset + 4, Vector.Y)
	buffer.writef32(self.Buffer, Offset + 8, Vector.Z)
end

--[[
	Reads a Vector3 from the buffer starting from `Offset` + 1 to `Count` + `Offset`
	@param Offset [number] which byte to start reading from
	@return [Vector3] the Vector3 that has been read
]]
function module:ReadVector3(Offset: number): Vector3
	if not self.Buffer then self.Buffer = buffer.create(Offset + 12); return Vector3.zero end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 12)

	local X = buffer.readf32(self.Buffer, Offset)
	local Y = buffer.readf32(self.Buffer, Offset + 4)
	local Z = buffer.readf32(self.Buffer, Offset + 8)

	return Vector3.new(X, Y, Z)
end

return module