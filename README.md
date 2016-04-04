# Auto-update-hiteatech

This is auto update script for [Hi Tea Tech](https://github.com/hiteatech/hiteatech.github.io). It will get the user info from Google Spreadsheet and update the website automatically.

## How to use

- Clone this project:
```sh
git clone git@github.com:jk-gan/auto-update-hiteatech.git
```
- Follow Step 1 and 2 of "Authorizing requests with OAuth 2.0" in [this page](https://developers.google.com/drive/v3/web/about-auth) to get a client ID and client secret for OAuth. Set "Application type" to "Other" in the form to create a client ID if you use GoogleDrive.saved_session method as in the example below.
- Next, create a file config.json which contains the client ID and crient secret you got above, which looks like:

```json
  {
    "client_id": "xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com",
    "client_secret": "xxxxxxxxxxxxxxxxxxxxxxxx"
  }
```
You can refer `.config.json.example`.
- Setup environment variables. Check file `.env.example`. [How to get the key?](http://www.coolheadtech.com/blog/use-data-from-other-google-spreadsheets)
