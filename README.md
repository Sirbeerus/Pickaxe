# Pickaxe
niv haskell project that runs a curl & wreq request with local redis ping.

redis-server # installed
nix-shell
export NIXPKGS_ALLOW_INSECURE=1
nix-shell
ghcid Main.hs --run       # run inside app folder.
cabal install --lib hedis
"                                    "  # as needed.
niv update
niv add <GITHUB_AUTHOR><GITHUB_REPO_TITLE>
