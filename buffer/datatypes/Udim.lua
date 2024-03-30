local module = {}

local UpdateBuffer = require(script.Parent.Parent.shared).UpdateBuffer

--[[
	Writes a Udim to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param UDim [UDim] the Udim to be written to the buffer
]]
function module:WriteUdim(UDim: UDim, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(8 + Offset) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 8)

	buffer.writef32(self.Buffer, Offset, UDim.Scale)
	buffer.writei32(self.Buffer, Offset + 4, UDim.Offset)
end

--[[
	Reads a Udim from the buffer starting from `Offset` + 1
	@param Offset [number] which byte to start reading from
	@return [UDim] the UDim that has been read
]]
function module:ReadUdim(Offset: number): UDim
	if not self.Buffer then self.Buffer = buffer.create(Offset + 8); return UDim.new(0, 0) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 8)

	return UDim.new(buffer.readf32(self.Buffer, Offset), buffer.readi32(self.Buffer, Offset + 4))
end

return module