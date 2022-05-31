# Dev Containers Experiment

This devcontainer config utilizes the Lando PHP Appserver to leverage all the goodness of that image configuration without the overhead of the rest of Lando.

## Things you lose

There are no recipes, tooling, or proxy. There is no fancy handling of SSH keys (though if you are clever, devcontainer DOES support SSH Agent forwarding which is actually double plus good in the long run. 

This isn't yet setup for NGINX, or fancy Pantheon stuff, and you have to manually auth with Terminus. If you try to run this in Codespaces, you can really only access the appserver, since it seems codespaces needs some funky networking stuff to support forwarding ports for other services.

## Things you gain

This is much lighter weight than Lando because of all the things you are giving up. This should run directly in Github Codespaces, supporting a web UI workflow, and it should easily translate into Github Actions configuration.

## Stuff still to do

1. Make it work super well with Codespaces (like auto configuring Terminus...and maaaaaybe ssh?)
2. Work on supporting the web availability of extra services
3. Moar tooling like behavior
4. 
