# My dotfiles

This directory contains the dotfiles for my system
Don’t expect them to be perfect, or even functional.
Sorta-Kinda Maybe Functional Mess™️

> **DISCLAIMER:**  
> If you came here looking for professional, polished instructions, you’re in the wrong place. This README is a dumpster fire of shit, mild anarchy, and absolutely zero professional courtesy. Proceed at your own risk. Seriously. Don’t expect them to be perfect, or even functional.

---
## 🐧 Welcome to the Dotfiles from the Abyss

Congratulations, you found my dotfiles. They’re not just for Hyprland. They’re also for all the cool kids who use Fastfetch, zsh, nvim, and maybe a few other programs I can’t remember right now idgf anyways. Honestly, if you’re looking for a README that’s structured and helpful, hit up ChatGPT or StackOverflow or some shit I don't know. Otherwise, buckle up.

---

⚡️ The Apps I Bothered to Configure

    Hyprland: Because X11 is for the peasants.

    Fastfetch: Because fetch scripts are like virtual peacocks.

    zshrc: Because bash was too mainstream.

    nvim: Because I like pain.

    And probably other random crap: I forget.

## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```bash
git clone https://github.com/andriel300/dotfiles.git
cd dotfiles
```

then use GNU stow to create symlinks

```
stow .
```

or

```
stow --adopt .

```
Pro Tip: If you accidentally nuke your system, that’s on you. I warned you.

🧠 Frequently Unanswered Questions

    Q: Why does this config break my system?
    A: Because chaos is my love language.

    Q: Can I use this on Windows?
    A: Try, but let me know when it inevitably fails.

    Q: Why are your instructions so unhelpful?
    A: Because I’m lazy and you should learn to fish instead of being spoon-fed.


🎉 Final Words

If you made it this far, you deserve a medal or a therapy session. Go forth and rice your desktop — or just reinstall Windows. Either way, thanks for stopping by.

Peace out,
~The Human Behind This Nonsense
