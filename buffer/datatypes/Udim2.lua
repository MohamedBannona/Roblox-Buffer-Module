local module = {}

local UpdateBuffer = require(script.Parent.Parent.shared).UpdateBuffer

--[[
	Writes a Udim2 to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param UDim2 [UDim2] the Udim2 to be written to the buffer
	@return [number] the number of bytes written
]]
function module:WriteUdim2(UDim: UDim2, Offset: number): number
	--this used to be a ~60 line if statement
    local XScale = UDim.X.Scale
    local YScale = UDim.Y.Scale
    local XOffset = UDim.X.Offset
    local YOffset = UDim.Y.Offset

    local combinedValue = (XScale ~= 0 and 1 or 0) +
						  (YScale ~= 0 and 2 or 0) +
						  (XOffset ~= 0 and 4 or 0) +
						  (YOffset ~= 0 and 8 or 0)


	local size = ((combinedValue//4)*4)+1

	if not self.Buffer then self.Buffer = buffer.create(size + Offset) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, size)

	local addedOffset = 1
	buffer.writeu8(self.Buffer, Offset, combinedValue)
	if XScale ~= 0 then
		buffer.writef32(self.Buffer, Offset + addedOffset, XScale)
		addedOffset += 4
	end
	if YScale ~= 0 then
		buffer.writef32(self.Buffer, Offset + addedOffset, YScale)
		addedOffset += 4
	end
	if XOffset ~= 0 then
		buffer.writei32(self.Buffer, Offset + addedOffset, XOffset)
		addedOffset += 4
	end
	if YOffset ~= 0 then
		buffer.writei32(self.Buffer, Offset + addedOffset, YOffset)
	end
	return size
end

--[[
	Reads a Udim2 from the buffer starting from `Offset` + 1 to
	@param Offset [number] which byte to start reading from
	@return [UDim2] the Udim2 that has been read
]]
function module:ReadUdim2(Offset: number): UDim2
	if not self.Buffer then self.Buffer = buffer.create(Offset + 5); return UDim2.new() end

	local combinedValue = buffer.readu8(self.Buffer, Offset)

	local XScaleStored = bit32.band(combinedValue, 1) == 1
	local YScaleStored = bit32.band(combinedValue, 2) == 2
	local XOffsetStored = bit32.band(combinedValue, 4) == 4
	local YOffsetStored = bit32.band(combinedValue, 8) == 8

	local XScale, YScale, XOffset, YOffset

	local AddedOffset = 1
	if XScaleStored then
		XScale = buffer.readf32(self.Buffer, Offset + AddedOffset)
		AddedOffset += 4
	end
	if YScaleStored then
		YScale = buffer.readf32(self.Buffer, Offset + AddedOffset)
		AddedOffset += 4
	end
	if XOffsetStored then
		XOffset = buffer.readi32(self.Buffer, Offset + AddedOffset)
		AddedOffset += 4
	end
	if YOffsetStored then
		YOffset = buffer.readi32(self.Buffer, Offset + AddedOffset)
	end
	return UDim2.new(XScale or 0, XOffset or 0, YScale or 0, YOffset or 0)
end

return module