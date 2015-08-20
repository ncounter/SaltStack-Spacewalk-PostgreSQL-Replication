include:
  - postgresql-pkg
  - postgresql-spacewalk

postgresql:
  service:
    - running
    - enable: True
    - reload: True
    - require:
      - pkg: pg-packages
      - cmd: initdb-service
    - watch:
      - file: /var/lib/pgsql/data/postgresql.conf
      - file: /var/lib/pgsql/data/pg_hba.conf

initdb-service:
  cmd.run:
    - name: systemctl start postgresql && systemctl stop postgresql
    - require:
      - pkg: pg-packages

SuSEfirewall2:
  service.dead:
    - enable: False
