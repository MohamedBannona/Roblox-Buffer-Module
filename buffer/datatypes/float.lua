local module = {}

local UpdateBuffer = require(script.Parent.Parent.shared).UpdateBuffer

---------Read---------
--[[
	Reads a 32 bit (4 bytes) floating point number starting after `Offst`
	@param Offset [number] where to start reading from after
	@return [number] the number that was read
]]
function module:ReadF32(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(Offset + 4); return 0 end

	return buffer.readf32(self.Buffer, Offset)
end

--[[
	Reads a 64 bit (8 bytes) floating point number starting after `Offst`
	@param Offset [number] where to start reading from after
	@return [number] the number that was read
]]
function module:ReadF64(Offset: number): number
	if not self.Buffer then self.Buffer = buffer.create(Offset + 8); return 0 end

	return buffer.readf64(self.Buffer, Offset)
end

---------Write---------
--[[
	Write a 32 bit (4 bytes) floating point number starting to the buffer starting after `Offst`
	@param Offset [number] where to start reading from after
	@param Value [number] the number to be written to the buffer
]]
function module:WriteF32(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(Offset + 4) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 4)

	return buffer.readf32(self.Buffer, Offset)
end

--[[
	Write a 64 bit (8 bytes) floating point number starting to the buffer starting after `Offset`
	@param Offset [number] where to start reading from after
	@param Value [number] the number to be written to the buffer
]]
function module:WriteF64(Value: number, Offset: number)
	if not self.Buffer then self.Buffer = buffer.create(Offset + 8) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, 8)

	return buffer.writef64(self.Buffer, Offset, Value)
end

return module