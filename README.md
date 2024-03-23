# Roblox Buffer Module

Roblox Buffer Module V 1.0.0</br>
This module is just a wrapper for the roblox buffer object with support for U64 and I64</br>
If roblox adds support for 64 bit numbers in buffers, this module will become obsolete, please do not use it then.

- [Usage](#example-usage)
- [Installation](#installation)
- [API Reference](#api-reference)
- [QnA](#qna)
- [Plans](#the-future)

## Example Usage:
```lua
	--Example 1
	local BufferModule = require(Path.To.Module)

	local Buff = BufferModule.new(1024) --1 kilobyte is too much for most cases

	local String = "Hello World!"
	local Length = #String

	--Writing starts AFTER the offset
	Buff:WriteU16(Length, 0)
	Buff:WriteString(String, 2)

	print(Buff:ReadString(2, Buff:ReadU16(0))) --Hello World!

	--You could also use Buff:Get() to get the actual buffer object
	print(buffer.readstring(Buff.Buffer, 0, Length)) --Hello World!

	--Example 2
	local BufferModule = require(Path.To.Module)

	local buff = BufferModule.FromBuffer(DataStore:GetAsync("Editors"))
		
	local Start = 0
	for i = 0, buff:Length(), 12 do
		local Id = Buff:ReadF64(i)
		local End = Buff:ReadU32(i+8)

		print(`{Players:GetNameFromUserIdAsync(Id)} Edited from {Start} to {End}`)

		Start = End + 1
	end
```

## Installation
Using Rojo, simply add the module to your project and you're good to go!
Using Roblox, Insert a module script and paste the contents of [init.luau](./buffer/init.luau) into it

## API Reference
- [Constructors](#constructors)
	- [new](#new)
	- [FromBuffer](#FromBuffer)
	- [FromString](#FromString)
- [General](#general)
	- [Length](#Length)
	- [Merge](#Merge)
	- [Get](#Get)

- [Read](#Read)
	- [Signed Integers](#signed-integers)
		- [ReadI8](#ReadI8)
		- [ReadI16](#ReadI16)
		- [ReadI32](#ReadI32)
		- [ReadI64](#ReadI64)

	- [Unsigned Integers](#unsigned-integers)
		- [ReadU8](#ReadU8)
		- [ReadU16](#ReadU16)
		- [ReadU32](#ReadU32)
		- [ReadU64](#ReadU64)

	- [Floats](#floats)
		- [ReadF32](#ReadF32)
		- [ReadF64](#ReadF64)

	- [ReadString](#ReadString)

- [Write](#Write)
	- [Signed Integers](#signed-integers)
		- [WriteI8](#WriteI8)
		- [WriteI16](#WriteI16)
		- [WriteI32](#WriteI32)
		- [WriteI64](#WriteI64)

	- [Unsigned Integers](#unsigned-integers)
		- [WriteU8](#WriteU8)
		- [WriteU16](#WriteU16)
		- [WriteU32](#WriteU32)
		- [WriteU64](#WriteU64)

	- [Floats](#floats)
		- [WriteF32](#WriteF32)
		- [WriteF64](#WriteF64)

	- [WriteString](#WriteString)

## Constructors
### new
Create a new Buffer class with the provided size in bytes
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Size` | `number` | The size in bytes of the Buffer object | ❌ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Buffer` | `Buffer` | The new Buffer made

### FromBuffer
Create a new Buffer class from an existing buffer object
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Buffer` | `buffer` | The buffer object to use | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Buffer` | `Buffer` | The new Buffer made

### FromString
Create a new Buffer class from a string
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `String` | `string` | The string to use | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Buffer` | `Buffer` | The new Buffer made

## General
### Length
Returns the length of the buffer
| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Length` | `number` | The length of the buffer

### Merge
Merges two buffers together
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Buffer` | `buffer` | The buffer to merge | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Buffer` | `Buffer` | The new Buffer made

### Get
Returns the buffer object
| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `Buffer` | `buffer` | The buffer object


## Read
## Signed Integers
### ReadI8
Reads an 8 bit signed integer (1 byte) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadI16
Reads a 16 bit signed integer (2 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadI32
Reads a 32 bit signed integer (4 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadI64
Reads a 64 bit signed integer (8 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

## Unsigned Integers
### ReadU8
Reads an 8 bit unsigned integer (1 byte) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadU16
Reads a 16 bit unsigned integer (2 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadU32
Reads a 32 bit unsigned integer (4 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadU64
Reads a 64 bit unsigned integer (8 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

## Floats
### ReadF32
Reads a 32 bit float (4 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

### ReadF64
Reads a 64 bit float (8 bytes) starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |

| Returns | Type     | Description                |
| :-------- | :------- | :-------------------------
| `number` | `number` | The number that has been read

## ReadString
Reads a string starting after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `Offset` | `number` | Which byte to start reading after | ✅ |
| `Length` | `number` | How many bytes to read | ✅ |

## Write
## Signed Integers
### WriteI8
Writes an 8 bit signed integer (1 byte) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteI16
Writes a 16 bit signed integer (2 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteI32
Writes a 32 bit signed integer (4 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteI64
Writes a 64 bit signed integer (8 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

## Unsigned Integers
### WriteU8
Writes an 8 bit unsigned integer (1 byte) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteU16
Writes a 16 bit unsigned integer (2 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteU32
Writes a 32 bit unsigned integer (4 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteU64
Writes a 64 bit unsigned integer (8 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

## Floats
### WriteF32
Writes a 32 bit float (4 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅ |

### WriteF64
Writes a 64 bit float (8 bytes) after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `number` | `number` | The number to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

## WriteString
Writes a string to the buffer after `Offset`
| Parameter | Type     | Description                | Required |
| :-------- | :------- | :------------------------- | :-: |
| `string` | `string` | The string to write | ✅ |
| `Offset` | `number` | Which byte to start writing from after | ✅

## tostring
Converts each byte (or more) in the string to a character
There is no Buffer:Tostring() method, instead you use tostring(Buffer)
</br>

## QnA

#### When should I use this module?
-	Probably never as f64 can represent higher values than u64

#### When should I not use this module?
- Always

#### Why use buffers over tables?
- buffers use less memory than number arrays and packing strings into and out of buffers is more performant than using string.pack()/unpack

#### Can I store instances in Buffers?
- No, numbers only (strings are stored as UTF-8), serialize.
</br>

## The Future
- Add support for other data types (Vectors, Colors, Cframes, etc.)
- Automatic Serialization and Deserialization for Instances
- FromTable Constructor

</br></br>
You should try and estimate the total amount of data that's going to be stored in the buffer to decrease the amount of times new buffers have to be created
</br>

For more information on Roblox Buffers:
[Api Reference](https://create.roblox.com/docs/reference/engine/libraries/buffer) [Devforum Post](https://devforum.roblox.com/t/introducing-luau-buffer-type-beta/2724894)