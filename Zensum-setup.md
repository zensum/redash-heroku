# Setup From Scratch
```sh
# Set a app name
app_name=zaker-redash

# Update to heroku beta in order to use manifests
heroku update beta
heroku plugins:install @heroku-cli/plugin-manifest

# Create Heroku app
heroku create $app_name --manifest -t zensum --region eu

# Link git to heroku git
heroku git:remote --app $app_name

# Push to heroku git (heroku builds and does magic)
git push heroku master

# Setup db
heroku run "create_db" --app $app_name
```

# How ?
Heroku is using the config in heroku.yml like the spec in [here](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml)
- Building one image called web
- Adding REDIS and POSTGRES
- Running a web dyno with command `server`
- Running a worker dyno with command `worker`


### Sources

- [Heroku manifest and setup](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml)
- [Redash](https://redash.io/help/open-source/dev-guide/docker)