# Understanding NixOS Configuration Priorities

## The Conflict Problem

When multiple modules set the same option differently:

```nix
# a.nix
services.nginx.enable = true;

# b.nix 
services.nginx.enable = false;
Question: Which value should NixOS choose?
```

The Solution: Priority System
NixOS uses priority functions to resolve conflicts:

mkOverride <priority> <value>
Lower priority numbers win conflicts

Example: mkOverride 100 true

How It Works:
NixOS detects conflicting values

1. Compares their priorities
2. Selects the value with the lowest priority number

Key Points
50 = mkForce (strongest)
100 = Normal assignments
1000 = mkDefault (weakest)
