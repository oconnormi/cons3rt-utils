# Cons3rt Utils

Collection of convenience scripts for working within a cons3rt environment

# Installing

cons3rt-utils can be installed via curl:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/oconnormi/cons3rt-utils/master/install.sh)"
```

# Usage

## Locate deployment properties

The `getDeployProps` script will return the path to the cons3rt `deployment.properties` file

This is mostly used by other utility scripts that need access to the deployment properties file

Other uses:
view contents of `deployment.properties` by running `cat $(getDeployProps)`
edit contents of `deployment.properties` by running `vi $(getDeployProps)`

## Get the role assigned to the current system

This utility is straight forward, running `getRole` will return the role
associated with the current system inside a cons3rt deployment

Example:

On system with role set to master
`getRole` will return `master`

## Get a value associated with a property inside a cons3rt deployment

This utility will return the value associated with a property in a cons3rt deployment.
It assumes by default that the property that was requested belongs to the current system's role.

### Retrieving a local property
A local property will be defined here as one that belongs to the current systems assigned role within the cons3rt deployment

Given the following properties file

```
deployment.properties

some.prop.foo.master=bar
some.prop.foo.sut=baz
another.prop.bar=foo
```

running `getProperty some.prop.foo` from the system assinged the role `master` would return `bar`,
while running it from the system assinged the role `sut` would return `bar`

### Retrieving a "remote" property
A remote property will be defined here as a property that belongs to a different system in the cons3rt deployment

Given the following properties file

```
deployment.properties

some.prop.foo.master=bar
some.prop.foo.sut=baz
another.prop.bar=foo
```

running `getProperty -r sut some.prop.foo` from the master node would return `baz`

### Retrieving a "global" property
A global property will be defined here as a a property that does not belong to any specific role within a cons3rt deployment

```
deployment.properties

some.prop.foo.master=bar # Belongs to system with role of master
some.prop.foo.sut=baz    # Belongs to system with role of sut
another.prop.bar=foo     # Global Property (assuming there is not a system with role=bar)
```

Running `getProperty -g another.prop.bar` would return `foo` from any system within the deployment

## Logging

`logMessage` is a simple wrapper around the `logger` command that simplifies the process of logging a message to `logMessage [message]`

This defaults to creating a message of level `INFO` and adds a tag for the parent process.

Logging a higher level message can be done by passing a level to the `-l` or `--level` flag. Valid values are `error`, `warn`, `info`, `debug`

To change the tag (program associated with the log message) pass a value to the `-t` or `--tag` flag.
