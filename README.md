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

Il comando crea un file application.yml

#Lezione 9

Andiamo a creare un file .gitignore nella root, questo indicherà a git cosa non inviare al
repository.