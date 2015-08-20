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
