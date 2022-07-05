web: bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
release: PG_STATEMENT_TIMEOUT=120000 rake db:migrate