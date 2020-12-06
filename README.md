# README

download backup of old db

heroku create new klemen_nagode_sp

deployaj app - avtomatsko se bo baza zgenerirala

```
rails run rake db:schema:load
rails run rake db:migrate
```


## For Marko:
dobi credentialse od baze
uporabi pg_restore baze na novo lokacijo (google it on heroku)



# Create login user

heroku run rails c
AdminUser.create!(email: 'klemen@example.com', password: 'xxx', password_confirmation: 'password')


# Setup Zapier for Transferwise

Create new ZAP (inpbound email -> Post request (URL: https://mojiracuni.herokuapp.com/mail-processor)

Create new forwarding email in GMAIL: (FROM: @transferwise.com, body: EUR), forward to something similar like: knagode.39393993@zapiermail.com. 

Most recent invoice will be copied, price amount will be updated from the content of the email. Invoice number will be automatically incremented. 




