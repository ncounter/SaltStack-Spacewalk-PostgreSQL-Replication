include:
  - services
  - postgresql-spacewalk

pg-packages:
  pkg:
    - installed
    - pkgs:
      - postgresql93-server
      - postgresql93
      - postgresql93-test
      - postgresql-contrib
      - postgresql-pltcl

/var/lib/pgsql/data/postgresql.conf:
  file.managed:
    - source: salt://postgresql-pkg/postgresql.conf
    - user: postgres
    - mode: 700
    - onlyif: ls /var/lib/pgsql/data
    - require:
      - pkg: pg-packages

/var/lib/pgsql/data/pg_hba.conf:
  file.managed:
    - source: salt://postgresql-pkg/pg_hba.conf
    - user: postgres
    - mode: 700
    - onlyif: ls /var/lib/pgsql/data
    - require:
      - pkg: pg-packages
