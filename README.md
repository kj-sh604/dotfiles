# my dotfiles

personal collection of config files for my Linux set-up. I mostly use a cringe-looking awesome-WM "rice", neovim, and the `fish` shell.

![Image of my Linux Rice](https://aedrielkylejavier.me/assets/rice.png)

**dotfiles are updated nightly**

### note:

~~i am currently using the coreutils-hybrid package on Arch Linux which integrates the Rust uutils alongside the GNU coreutils. You may want to remove the fish aliases involving the uutils, plan 9 utils, and alternate commands involving the coreutils to make my fish config work on your system.~~


i have reverted back to using the default GNU `coreutils` package from the ***core*** Arch Linux repository. this decision was prompted by the discovery of a bug in the rust-uutils version of the `tr` command, which inadvertently caused some of my scripts to malfunction when attempting to retrieve values from `/dev/urandom`. as a result, my fish shell config should now function correctly on most standard Linux distributions without requiring any modification or the removal of the rust-uutils/plan9 aliases previously present in my `config.fish` file. 


please note that for the pre-aliased `yt-*` commands to work, you will need to have `yt-dlp` or `youtube-dl` installed.
