# Complete guide  to learning Nix programming language (mostly focusing on the Syntax & usage of Nix)

*This is an attempt to creating a repo for learning nix programming language although i am not a professional programmer, i have been learning and studying stuffs i like and this might not only be helpful to you guys who are wanting to learn nix from the ground up but for me too. These days most of the developers tend to rely on AI for learning but still i am making this, just for fun. I hope you will provide me with a feedback on how i should takes things forward

## Introduction to Nix Language

Nix is functional programming language what is mainly used for Nix package manager and NixOS configuration. It is not like normal languages you & I know before. First time can be confusing but when you understand the concepts becomes very powerful tool.
Nix provides many useful functionality by itself like creating an isolated environment while creating projects, controlling version collision is what i love the most about it and can be defined in a single file unlike other distros that do not provide isolation between dependencies and when programs need to shuffle between different version of the same dependencies

### Why Learn Nix?

1. **Reproducible builds** - Always get same output, if the input is the same
2. **Declarative** - Say what you want, not how to do
3. **Pure** - No side effects in functions
4. **Great for DevOps** - Managing servers ( containers like docker)

## Basic Concepts

### 1. Simple Values

Nix has basic types like any other programing languages:

```nix
# Numbers
integer = 42;
float = 3.1415;

# Text
string1 = "hello";
string2 = ''
  multi-line
  string
'';

# Boolean
t = true;
f = false;

# Nothing
empty = null;
```
---
# Complete Guide to Nix Programming Language and NixOS

 <p> want explain Nix programming language and NixOS in detail, because it very unique and powerful, but also have challenge. I cover all feature, pros, cons, cool thing like flakes and nix-shells, how to install package, and commands for beginner and intermediate user. I also compare with other Linux distro to show what make Nix special. I try write clear, but English not my first language, so please forgive if some sentence sound simple. I use example from C programming (like your C_guides with GLFW) to make it relate to you.</p></br>

## What Is Nix?
<p>Nix is two thing: a package manager and a programming language. The language is use to describe how to build software, configure system, or set up environment. NixOS is a Linux distro build on Nix, where everything—package, service, even system setting—is define with Nix language. Unlike other distro (like Ubuntu or Arch), Nix focus on reproducibility, meaning same code give same result every time, no matter where you run it.
For example, in your C_guides, you use flake.nix to set up GLFW and OpenGL. With Nix, you write one file, and anyone with Nix can build same environment—same library, same version, no "it work on my machine" problem.
Features of Nix Programming Language</p></br>

Nix language is functional, declarative, and design for system management. Here all feature in detail:
### 1. Functional and Pure

What it mean: Nix is like Haskell—function don’t change outside world (no side effect). Every package build is "pure," mean it only use what you declare, nothing from your system sneak in.
How it work: When you write Nix code, you define input (like source code, dependency), and Nix compute output (like binary). Same input always give same output.
Example: In C_guides, your flake.nix say "use GLFW 3.3.8." Nix build GLFW 3.3.8 exactly, even if system have 3.3.9 install elsewhere.
Why cool: No surprise error like "wrong library version" when you debug C code.

### 2. Declarative Configuration

What it mean: You say what you want, not how to do it. Write one file, and Nix figure out step.
How it work: Instead of apt install gcc, you write pkgs.gcc in a Nix file, and Nix handle download, build, install.
Example: For NixOS, /etc/nixos/configuration.nix list all software and setting (like SSH, desktop). One command (nixos-rebuild switch) make it real.
Why cool: You can copy your C_guides flake.nix to friend, and they get same setup without manual step.

### 3. Reproducibility

What it mean: Same Nix code give same result on any machine, any time.
How it work: Nix use store (/nix/store), where every package have unique path with hash (e.g., /nix/store/abcd123-gcc-12.2.0). Hash include all dependency, so no conflict.
Example: Your GLFW triangle in C_guides build same way on your laptop and my PC, because flake.lock pin exact version.
Why cool: No more "it crash on Ubuntu but work on Arch."

### 4. Atomic Updates and Rollbacks

What it mean: Update system or package is safe—either it work, or nothing change. You can go back to old version easy.
How it work: NixOS create "generation" for each system state. If update fail, boot old generation from GRUB menu.
Example: You add new library to C_guides flake.nix, but it break compile. Run nix flake update --rollback, and you back to working setup.
Why cool: Fearless experiment—try new GLFW version, rollback if it buggy.

### 5. Flakes

What it mean: Flakes is new way to organize Nix project, make them more standard and reproducible.
flakes is still experimental as of till now, but the chances of breaking something after using it is still a no no.
How it work: A flake.nix file define input (like nixpkgs version) and output (like package, shell). A flake.lock pin exact version for everything.

Example: Your C_guides flake.nix:
```Nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };
  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = [ nixpkgs.legacyPackages.x86_64-linux.glfw ];
    };
  };
}
```

Run: 
```bash
nix develop
```

you will get a shell where GLFW is installed. flake.lock ensure same version everywhere.
Why cool: Share C_guides with friend—they get exact same environment. No "I forgot to install X."
Note: Flakes still experimental, so some command need --extra-experimental-features flakes.

### 6. Nix-Shells

What it mean: Temporary environment with specific package, no change to system.
How it work: Run nix-shell -p python3, get Python 3 shell. Exit, and it gone—no mess.
Example: In C_guides, you test new compiler:nix-shell -p gcc13
gcc --version  # GCC 13

Exit, and your system GCC unchanged.
Why cool: Try tool for C project (like clang) without install permanent. Like virtualenv, but for any language.

### 7. Package Isolation

What it mean: Every package live in own folder in /nix/store, no conflict.
How it work: Path like /nix/store/abcd123-gcc-12.2.0 unique for each version and dependency. Two GCC version can exist same time.
Example: In C_guides, you use GLFW 3.3.8 for one project, 3.3.9 for another—no clash.
Why cool: No "dependency hell" when you build game with old library.

### 8. Binary Caching

What it mean: Download pre-built package instead of compile.
How it work: Nix check cache (like cache.nixos.org) for package with same hash. If found, download; if not, build.
Example: Your flake.nix want GLFW. Nix download it in second, no compile.
Why cool: Fast setup for C_guides, even on slow laptop.

### 9. Multi-Version Support

What it mean: Run different version of same software at same time.
How it work: Each version have own /nix/store path, so no overwrite.
Example: You test C_guides with gcc12 and gcc13 in two terminal, no conflict.
Why cool: Compare compiler bug without uninstall/install.

### 10. Lazy Evaluation

What it mean: Nix only compute what needed, not whole file.
How it work: If you change one package in flake.nix, Nix only rebuild that, not everything.
Example: Update GLFW in C_guides, other package (like make) skip rebuild.
Why cool: Save time when tweak big project.

### 11. Module System

What it mean: NixOS use module to organize config, like puzzle piece.
How it work: Each module (e.g., SSH, GNOME) define option. Combine them in configuration.nix.
Example: Enable SSH in NixOS:services.sshd.enable = true;

One line, and SSH run.
Why cool: Simple to add feature to system, no edit 10 file like Arch.

Cool Things Nix/NixOS Do (Not Other Distro)
NixOS and Nix have trick other distro (Ubuntu, Arch, Fedora) can’t do easy:

* System as Code:

Whole NixOS system is one Nix file (configuration.nix or flake.nix). Copy to new PC, run nixos-rebuild switch, get same system.
Example: Your C_guides laptop crash. Restore flake.nix on new PC, and it same as before—same GCC, same GLFW.
Other distro: Need script, manual install, hope it match.


* Dev Environment Sharing:

Flakes let you share exact dev setup. Your C_guides flake.nix give friend same compiler, library, even VS Code plugin.
Other distro: Friend install manual, maybe miss package.


* No Global State:

NixOS don’t use /bin or /usr. Everything in /nix/store. No "package overwrite system file" mess.
Example: Install two GLFW version, no break system.
Other distro: One version at time, or hack with LD_LIBRARY_PATH.


* Atomic System Update:

Update NixOS is all-or-nothing. If fail, system stay old state.
Example: Add broken library to C_guides system, reboot, pick old generation—safe.
Other distro: Update fail, maybe no boot.


* Reproducible Builds:

Same Nix code, same binary, even years later. flake.lock lock dependency.
Example: Build C_guides game in 2025, rebuild in 2030—same result.
Other distro: Old package gone, good luck.


* Nix Shell for Testing:

Try tool temporary, no install. Like Docker, but lighter.
Example: nix-shell -p valgrind to debug C_guides memory leak, exit, gone.
Other distro: Install, maybe conflict, uninstall manual.


Custom Package Easy:

Write Nix file to build any software, no mess with RPM/DEB.
Example:

```nix
pkgs.stdenv.mkDerivation {
  name = "mytool";
  src = ./mytool.tar.gz;
}
```


<p>Other distro: Learn AUR, pray it work.</p>



Try Package Temporary:
```bash
nix-shell -p gcc
```

Get GCC shell, exit to remove. Good for test tool in C_guides.

Install Package (Non-NixOS):
```bash
nix profile install nixpkgs#glfw
```

Add GLFW to user profile, like apt install. search package:
```bash
nix search nixpkgs glfw
```

Find GLFW version for C_guides.
Enter a flake shell
```
nix develop
```

Use C_guides flake.nix to get dev environment.
Update System (NixOS):

```
sudo nixos-rebuild switch
or 
sudo nixos-rebuild switch --flake .#<username> to build the system with flakes
```

Apply configuration.nix change, like add SSH.

## Intermediate Commands

Build Flake Output:nix build .#<your-program>

Build C_guides game from flake.nix.
Update Flake Lock:nix flake update

Refresh C_guides dependency to latest.
Rollback Profile:
```bash
nix profile rollback
```

Undo bad package install.

Garbage Collect:
```bash
nix-collect-garbage
```

Free space by remove old /nix/store file.
Check Flake Syntax:
```bash
nix flake check
```


<p>I hope this help you love Nix like I do! If you want, I can explain more command or debug your C_guides flake.nix. Sorry if my English not perfect, but I try hard to share knowledge.</p>
