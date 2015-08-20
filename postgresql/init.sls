postgresql:
  pkg:
    - installed
    - pkgs:
      - postgresql93-server
      - postgresql93
      - postgresql93-test

pg-pkgs:
  pkg.installed:
    - pkgs:
      - postgresql-contrib
      - postgresql-pltcl
    - require:
      - pkg: postgresql
