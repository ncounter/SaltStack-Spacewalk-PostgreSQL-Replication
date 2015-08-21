base:
  'postgresql*':
    - postgresql-pkg
    - services
    - postgresql-spacewalk
  'spacewalk':
    - pgpool

