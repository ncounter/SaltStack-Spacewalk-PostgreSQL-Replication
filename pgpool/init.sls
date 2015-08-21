pgpool-source:
  pkg.installed:
    - sources:
      - pgpool-II-release: http://www.pgpool.net/yum/rpms/3.4/redhat/rhel-7-x86_64/pgpool-II-release-3.4-1.noarch.rpm

pgpool-pkg:
  pkg.installed:
    - name: pgpool-II-pg93.x86_64
    - require:
      - pkg: pgpool-source

/etc/pgpool-II/pgpool.conf:
  file.managed:
    - source: salt://pgpool/pgpool.conf
    - user: root
    - mode: 764
    - onlyif: ls /etc/pgpool-II
    - require:
      - pkg: pgpool-pkg

socket-dir:
  cmd.run:
    - user: root
    - mode: 764
    - name: mkdir /var/run/postgresql
    - unless: ls /var/run/postgresql

run-dir:
  cmd.run:
    - user: root
    - mode: 764
    - name: mkdir /var/run/pgpool
    - unless: ls /var/run/pgpool

pgpool-start:
  service.running:
    - name: pgpool
    - enable: True
    - reload: True
    - watch:
      - file: /etc/pgpool-II/pgpool.conf
    - require:
      - pkg: pgpool-pkg
      - cmd: socket-dir
      - cmd: run-dir
