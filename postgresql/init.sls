postgresql:
  pkg:
    - installed
    - pkgs:
      - postgresql93-server
      - postgresql93
      - postgresql93-test
  service:
    - running
    - enable: True
    - reload: True
    - require:
      - pkg: postgresql
      - cmd: initdb-service
    - watch:
      - file: /var/lib/pgsql/data/postgresql.conf
      - file: /var/lib/pgsql/data/pg_hba.conf

initdb-service:
  cmd.run:
    - name: systemctl start postgresql
    - require:
      - pkg: postgresql

pg-pkgs:
  pkg.installed:
    - pkgs:
      - postgresql-contrib
      - postgresql-pltcl
    - require:
      - pkg: postgresql

/var/lib/pgsql/data/postgresql.conf:
  file.managed:
    - source: salt://postgresql/postgresql.conf
    - user: postgres
    - mode: 700
    - onlyif: ls /var/lib/pgsql/data
    - require:
      - pkg: postgresql

/var/lib/pgsql/data/pg_hba.conf:
  file.managed:
    - source: salt://postgresql/pg_hba.conf
    - user: postgres
    - mode: 700
    - onlyif: ls /var/lib/pgsql/data
    - require:
      - pkg: postgresql

SuSEfirewall2:
  service.dead:
    - enable: False

create-sw-db:
  cmd.run:
    - user: postgres
    - name: createdb -E UTF8 spaceschema
    - unless: psql -l | grep spaceschema
    - require:
      - service: postgresql

create-sw-plpgsql-lang:
  cmd.run:
    - user: postgres
    - name: createlang plpgsql spaceschema
    - unless: psql spaceschema -c "\dL" | grep plpgsql
    - require:
      - service: postgresql
      - cmd: create-sw-db

create-sw-pltclu-lang:
  cmd.run:
    - user: postgres
    - name: createlang pltclu spaceschema
    - unless: psql spaceschema -c "\dL" | grep pltclu
    - require:
      - service: postgresql
      - cmd: create-sw-db

create-sw-user:
  cmd.run:
    - user: postgres
    - name: yes spacepw | createuser -P -sDR spaceuser
    - unless: psql -c "\du" | grep spaceuser
    - require:
      - service: postgresql
      - cmd: create-sw-db
