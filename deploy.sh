# Found in Professor Tuck's notes repo
#!/bin/bash

export MIX_ENV=prod
# Common port range for this is 4000-10,000
# Valid port range for a user app to listen
# on is something like 1025-32767
export PORT=4004
export SECRET_KEY_BASE=lovely

mix deps.get --only prod
mix compile

CFGD=$(readlink -f ~/.config/bulls)

if [ ! -d "$CFGD" ]; then
    mkdir -p "$CFGD"
fi

if [ ! -e "$CFGD/base" ]; then
    mix phx.gen.secret > "$CFGD/base"
fi

SECRET_KEY_BASE=$(cat "$CFGD/base")
export SECRET_KEY_BASE

npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

<<<<<<< HEAD
mix release
=======
mix release
>>>>>>> 6e6d114c85e2f2ba38ef0a10b1cf945ca2990879
