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
