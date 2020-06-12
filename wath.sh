watchmedo shell-command \
          --patterns="*.rst" \
          --ignore-pattern='_build/*' \
          --recursive \
          --command='sudo make html'
