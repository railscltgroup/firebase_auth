# Ruby Firebase Auth

I have a Rails App where I need to authenticate firebase users on the server-side, not just in JavaScript.

I found these instructions from google:
https://firebase.google.com/docs/auth/admin/verify-id-tokens

Unfortunately, it appears Google does not have support for Ruby. So, I made my own auth file!

## Installation:
#### Using Rubygems:
```
gem install firebase-token-verify
```

#### Using Bundler
Add `gem 'firebase-token-verify'` to your Gemfile and run `bundle install`

## Example use-case scenario:
1) Lookup your firebase id and add it to your Ruby code, for example: `PROJECT_ID = <your_firebase_project_id>`
2) Obtain a user token.  You will need to be connected with JavaScript, or a mobile app, to obtain the user token. I usually obtain a user token using a JavaScript method similar to the one below:
```sh
user.getIdToken(true).then(token => {
  // Send this token to your Ruby application
})
```
3) Setup some Ruby code to process the token
```sh
require 'firebase_ruby_auth'

class FirebaseRubyAuthWrapper
  PROJECT_ID = ENV['<your_firebase_project_id>']

  def initialize
    @auth = FirebaseRubyAuth.new(PROJECT_ID)
  end

  def retrieve_email_from_token(token)
    @auth.decode_token(token)['email']
  end
end
```
