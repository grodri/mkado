# Make Ado 

This depository has a set of three commands that I have found useful in 
maintaining the `markstat` source code. 

## `mkado`

The basic idea is to split your program into one or more Stata subcommands
and Mata functions, which you write in separate files so they can easily 
be tested and debugged on their own.

You then list them all in a *manifest*, using a `.` for Stata files and
a `:` for Mata files. The manifest should have the same name as the command
with extension `.mkm` and looks like this:

```
program commandname
	// start the command here, probably with the syntax
	// and calls to Stata subcommands or Mata functions
end

._asubcommand
._another

mata:
:a_mata_function
:another_one
end
```

You then write the Stata subcommands and Mata functions, each in its own
file: `_asubcommand.ado`, `_another.ado`, `a_mata_function.mata` and 
`another_one.mata`.

The `mkado` command goes through the manifest and collates all these files
into a single `.ado` file, which becomes your command.
 
 ## `mkload`
 
 Any Stata subcommand in your manifest can be tested directly by calling it
 with the correct arguments.  The `mkload` command helps load Mata functions
 for testing.
 
 If you call `mkload` with the name of the manifest file (the same as your
 command), it will clear Mata and load all the functions, so you can test 
 them all, including functions that call other functions in the manifest.
 
 Alternatively, calling `mkload` with the name of a Mata function will 
 `capture drop` it and then load it, ready for testing. This strategy can 
 be used for a function with no  dependencies, of even one that calls 
 others that are already loaded. For example you load all functions, 
 discover an  issue on `another_one`, edit the source, and then load just 
 that function.
 
 ## `mksplit`
 
 What if you already have a `.ado` command? The `mksplit` will read the ado
 file, will write each Stata command and Mata function to a  separate file,
 and then write a manifest with the list of names.
 
 *Warning*. This function is highly experimental, relying on simple parsers
 that may fail to identify Stata subprograms or Mata functions, particularly 
 in the case of function arguments that extend to multiple lines. But it does
 work on simple cases.
 
This idea could be extended to ado files that include Python and Java code,
but I have had no need for this yet.

## Installation

To install directly from GitHub type in Stata

```
net from https://raw.githubusercontent.com/grodri/mkado/master/
```

This will print a short description of what's in the depository, with links 
to describe each command (or type `net describe mkado`). Each description
has a link to install the command (or type `net install mkado`).