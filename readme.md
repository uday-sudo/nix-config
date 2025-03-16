# nix-config

## sops guide
- Put the host age key at ```/var/lib/sops-nix/key.txt```
- Put the user ssh key at ```~/.config/sops/age/keys.txt```

## firefox-config

I use sidebery in my config and am unable to declare it's config fully declaratively. So follow some steps to complete the setup manually:
- Go to ```about:addons``` in firefox url bar, enable all installed extension and themes.
- open sidebery settings, scroll to the bottom (help section),
click on "import addon data",
select "sidebery.json" from the downloaded archive or from [shimmer](https://github.com/nuclearcodecat/shimmer) github repo
keep the toggles at default and click "import".
- Go to ```about:config``` where ```shimmer.disable-collapsing-sidebar``` is set to ```true``` to disable the collapsing sidebar (unfortunately this also requires commenting out some sidebery styles, they are marked in the styles editor inside of sidebery settings). So you have to comment it out manually
- Sometimes the theme is not automatically installed, since it is being installed using policies go to ```about:policies``` to check for any errors.


## servers access 
- ssh: ```<address>:22```
- Syncthing GUI: ```<address>:8384```
- Filebrowser: ```<address>:3030```
- forgejo: ```<address>:3000```
- torrent: ```<address>:7044```
- Owncast: ```<address>:9990```


## Start servers(Not all services are enabled all the time):
- Filebrowser: ```sudo systemctl start filebowser```
- Torrent: ```sudo systemctl start qbittorent```