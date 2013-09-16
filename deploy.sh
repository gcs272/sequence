#!/bin/bash
cd public
uglifyjs app.js -c -o app.min.js
rsync -r * sequence.gcs.io:/home/graham/www/ 
