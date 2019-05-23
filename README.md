# Ruby Firebase Auth

I have a Rails App where I need to authenticate firebase users on the server-side, not just in JavaScript.

I found these instructions from google:
https://firebase.google.com/docs/auth/admin/verify-id-tokens

Unfortunately, it appears Google does not have support for Ruby. So, I made my own auth file!

This gem is an extraction of that file and is still in development. It also will require ruby-jwt 2.2 (https://github.com/jwt/ruby-jwt/releases) to be released.

If you can't wait for the gem to be finished, you're welcome to checkout the lib directory and add the code to your system as needed.
