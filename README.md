# push

(C) Martin Väth <martin@mvath.de>
This project is under the BSD license 2.0 (“3-clause BSD license”).
SPDX-License-Identifier: BSD-3-Clause

A POSIX shell function to treat a variable like an array, quoting args.

For installation simply copy the content of bin/ somewhere into your path
with the executable bit being set or execute make (and "make install" as root).

To check from within a POSIX shell script whether Push 2.0 (or newer)
is installed, and sourcing it if it is, you can use something like:

```
if SOME_VARIABLE=`push.sh 2>/dev/null`
then	eval "$SOME_VARIABLE"
else	echo "push.sh not installed" >&2
fi
```

__Remark__: An obsoleted method was to use instead
```
	. push.sh
```
The latter works for older versions of push or if one installs manually,
but unless an appropriate PATH before sourcing is set, it fails when
push.sh is replaced by a wrapper script which happens with the provided
Makefile. Moreover, if push.sh is not available it stops the script.

After this you have the shell function ```Push```.

__Usage__: ```Push [-c] VARIABLE [arguments]```

The arguments will be appended to `VARIABLE` in a quoted manner (with
quotes rarely used - the exact form depends on the version of `push.sh`)
so that an `eval "$VARIABLE"` obtains the collected arguments (see examples).
With option `-c`, `VARIABLE` will be cleared before arguments are appended:
The first call for `VARIABLE` must always be done with `-c`.
The return value is zero if `$VARIABLE` contains at least one pushed argument.

Scripts using Push must not use variables of the form `Push*_` (the reason is
that POSIX does not provide a local name scope, and so `Push` uses internally
global variables of such a form)

## Example 1
```
Push -c foo 'data with special symbols like ()"\' "'another arg'"
Push foo further args
eval "printf '%s\\n' $foo"
# Be aware that not only $foo but the whole command is eval'ed!
```
will output
```
data with special symbols like ()"\
'another arg'
further
args
```

## Example 2
### Remove the last argument from the argument list in a script
```
Push -c args
while [ $# -gt 1 ]
do	Push args "$1"
	shift
done
eval "set -- a $args"; shift
# Note: "set -- $args" can break with some shells if args is empty
```

## Example 3
### Quote a command for "su" correctly
```
Push -c files "$@" && su -c "cat -- $files"
```
uses `su` to `cat` files passed as arguments with root permissions,
even if the arguments contain problematic symbols like spaces, `<`, or quotes.

## Example 4
### Pretty-print a command without loosing exactness
```
set -- source~1 'source 2' "source '3'"
Push -c v cp -- "$@" \~dest
printf '%s\n' "$v"
```
will output a command which reliably can be pasted by the user
into a POSIX shell but which nevertheless is reasonably human-readable.
The exact form of output might be subject to change in different versions
of Push. Currently the output would look like:
```
cp -- source~1 'source 2' 'source '\'3\' '~dest'
```
It is not recommended to rely on any particular form of the output:
Instead, `Push` itself should be used if information is needed as in
the subsequent example.

## Example 5
### Omitting arguments for Push can be useful
```
Push -c data
SomeFunction
Push data || echo 'nothing was pushed to $data in SomeFunction'
```
This has the advantage that you need not rely on the implementation
details of how Push stores the data in the variable (which may depend
on the version of Push).
