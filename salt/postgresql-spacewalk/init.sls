include:
  - postgresql-pkg
  - services

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
