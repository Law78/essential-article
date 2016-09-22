Ricorda: Il server si lancia con rails server -p $PORT -b $IP

#Lezione 3

Ho clonato https://github.com/schesnowitz/Ruby-on-Rails-a-Beginners-Guide
Ho fatto: gem install bundler
Ho fatto: bundle install
Ho fatto: rake db:migrate
Ho fatto: rails server -p $PORT -b $IP
Ho creato un mio repo su github
Ho fatto: git init
Ho fatto: git remote add origin https://github.com/Law78/essential-article.git
Ho fatto: git remote -v
Ho fatto: heroku e sono entrato con lordkenzo
Ho fatto: heroku create
Ho fatto: git add -A - git commit -m 'first commit' - git push origin master
Ho fatto: git push heroku master
A questo punto devo creare il DB su Heroku o ottengo un errore
Ho fatto: herouku run rake db:migrate
Faccio il refresh della pagina creata su Heroku e tutto funziona

#Lezione 4

Vado a cambiare il Logo ed il Title della pagina, lavorando sui file application.html.erb 
e _nav.html.erb e index.html.erb in layouts/pages.
Infine sono andato a centrare il titolo della index ed il paragrafo.

#Lezione 5

Creo un utente dal Signup.
Creo un articolo.
Se creo un secondo account  con lo stesso nome, posso avere articoli di utenti diversi
con lo stesso nick.
Vado ad inserire una validazione nello user model in user.rb. Posso verificare che il field
relativo allo username è proprio username in schema.rb. Aggiungo in user.rb:
 
  validates_uniqueness_of :username

ovvero un vincolo di unicità per il field username.

#Lezione 6

Posso creare un articolo vuoto!!! Devo fare una validazione prima. In article.rb (nel model).
Vado a vincolare il title ed il body (field che vedo sempre dallo schema.rb).

  validates :title, length: { minimum: 5 }
  validates :body, length: { minimum: 15 }
 
 Aggiungiamo anche un vincolo che non permette titoli già esistenti:
 
 validates :title, uniqueness: true
 
 che poi è equivalente al precedente:
 
   validates_uniqueness_of :title

In questo modo non posso avere post con lo stesso titolo. Ma posso fare di meglio aggiungendo
un messaggio personalizzato:

  validates :title, uniqueness: { message: "Titolo già presente" }
  

Posso approfondire nella guida di Rails - Active Record Validations

#Lezione 7

Andiamo ad inserire l'orario in cui è stato creato il post. Vado ad aggiungere questa
informazione, in index.html.erb in views/articles:

    <p><span class="glyphicon glyphicon-time"></span>
    <%= article.created_at %>
    </p>

Ma non è il massimo, non è formattato. Vado a modificare:

  <%= time_ago_in_words(article.created_at) %>
    
Poi vado a modificare il numero degli articoli per la PAGINATION in controllers/articles_controller.rb
e vado a cambiare il 2 con il 5.

Adesso nello show degli article vado ad inserire anche qui l'orario, in questo caso devo
mettere @article e non semplicemente article:

    <p><span class="glyphicon glyphicon-time"></span> Was Posted about 
    <%= time_ago_in_words(@article.created_at) %> </p>

#Lezione 8

Ho fatto: git add -A
Ho fatto: git commit -m "validations and views"
Ho fatto: git push origin master
Ho fatto: git push heroku master

Adesso vogliamo proteggere una password dall'inserimento su github. Per farlo utilizzo una GEM
chiamata FIGARO https://rubygems.org/gems/figaro/versions/1.1.1
Inserisco questa GEM nel GEMFILE nel gruppo development:

gem 'figaro', '~> 1.1', '>= 1.1.1'

Ho fatto: bundle install

Adesso, dal github di Figaro, vedo che devo lanciare il comando: bundle exec figaro install

Il comando crea un file application.yml in /config.

#Lezione 9

Andiamo a creare un file .gitignore nella root, questo indicherà a git cosa non inviare al
repository, in cui inserisco:

/.bundle

/db/*.sqlite3
/db/*.sqlite3-journal

/log/*
!/log/.keep
/tmp
/config/application.yml

Ora faccio il git add -A e git commit -m "Added Figaro" e faccio git push origin master

Creo un nuovo branch:

git checkout -b mail

#Lezione 11

In config/initializer ho il file mail.rb che posso editare per inserire i dati dell'SMTP
di GMAIL, in cui vado a fare queste impostazioni:

	:address                =>  'smtp.gmail.com',
...
	:user_name              =>  ENV["GMAIL_USERNAME"],
	:password               =>  ENV["GMAIL_PASSWORD"],
	

Adesso devo settare GMAIL_USERNAME e GMAIL_PASSWORD in application.yml creato da Figaro:

GMAIL_USERNAME: postaforum@gmail.com#L
GMAIL_PASSWORD: lamiapass

Infine in config/environments in developmen.rb, vado a settare il config.action_mailer con il mio indirizzo
di cloud9:

https://essential-articles-lordkenzo.c9users.io

#Lezione 12

Facciamo un test, nel video c'è un errore di scrittura dell'URL in development.rb nel
config.action.

Il problema è che pare che con GMAIL non funzioni. Il problema principale è che con
GMAIL (e in generale con le G-Apps) ho necessità di una connessione SSL.

Questa soluzione non ha funzionato:
Installo: gem install tlsmail e lo inserisco nel GEMFILE e faccio bundle install

In config/initializers/mail.rb vado ad inserire:

```
require 'tlsmail'
```

Provo a settare Yahoo: Niente :(

In development.rb in  config/environments ho messo a true il seguente settaggio:
  config.action_mailer.raise_delivery_errors = true
In questo modo ho un riscontro su eventuali errori di invio.

In config/initializer vado a cambiare in devise.rb:
config.mailer_sender = 'do_not_reply@lorenzofranceschini.com'

Ho trovato questo github:https://github.com/jorgemanrubia/mailgun_rails
Ho inserito in GEMFILE: gem 'mailgun_rails' e fatto bundle install

Poi in development.rb ho inserito:

  config.action_mailer.delivery_method = :mailgun
  config.action_mailer.mailgun_settings = {
    api_key:  ENV['MAILGUN_APIKEY'],
    domain:   ENV['MAILGUN_DOMAIN']
  }
  
e in application.yml ho messo:

MAILGUN_APIKEY: 'key-****'
MAILGUN_DOMAIN: 'sandboxbe****.mailgun.org'

in mail.rb ho rimosso:
ActionMailer::Base.delivery_method = :smtp

e i dati di username e password. Alla fine ho:

ActionMailer::Base.smtp_settings = {
	:address				=>	"smtp.mailgun.org",
	:port                   =>  587,
	:authentication         =>  :plain,
	:enable_starttls_auto   =>	true 
}

#Lezione 13

Ho fatto l'aggiornamento su git di questo nuovo branch mail:

git add -A
git commit -m "Set up Mailgun Service"
git push origin mail

git checkout master
git merge mail
git push origin master

vai a cambiare in production.rb, altrimenti non funzionerà il recupero password:

  config.action_mailer.default_url_options = { host: 'https://mighty-plains-89888.herokuapp.com/' }

git add .
git commit -m "Fix Heroku url"
git push heroku master

In Heroku sono andato sotto la scheda del progetto e in SETTINGS, sono andato a creare
due variabili di environments per il settaggio del MAILGUN_APIKEY e MAILGUN_DOMAIN
altrimenti non manda nulla.
L'email mi è arrivata nello spam :D

Da terminale di Cloud9 posso fare anche:

heroku config:add MAILGUN_APIKEY=...... MAILGUN_DOMAIN=....

