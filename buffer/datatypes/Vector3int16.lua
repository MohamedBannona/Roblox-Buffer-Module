local module = {}

local UpdateBuffer = require(script.Parent.Parent.shared).UpdateBuffer

--[[
	Writes a Vector3int16 to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param Vector [Vector3int16] the Vector3int16 to be written to the buffer
]]
function module:WriteVector3Int16(Vector: Vector3int16, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(6 + Offset) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 6)

	buffer.writei16(self.Buffer, Offset, Vector.X)
	buffer.writei16(self.Buffer, Offset + 2, Vector.Y)
	buffer.writei16(self.Buffer, Offset + 4, Vector.Z)
end

--[[
	Reads a Vector3int16 from the buffer starting from `Offset` + 1 to `Count` + `Offset`
	@param Offset [number] which byte to start reading from
	@return [Vector3int16] the Vector3int16 that has been read
]]
function module:ReadVector3int16(Offset: number): Vector3int16
	if not self.Buffer then self.Buffer = buffer.create(Offset + 6); return Vector3int16.new() end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 6)

	local X = buffer.readi16(self.Buffer, Offset)
	local Y = buffer.readi16(self.Buffer, Offset + 2)
	local Z = buffer.readi16(self.Buffer, Offset + 4)
	
	return Vector3int16.new(X, Y, Z)
end

return module