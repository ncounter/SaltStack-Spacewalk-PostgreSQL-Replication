include:
  - pgpool

/etc/yum.repos.d/spacewalk-nightly.repo:
  file.managed:
    - source: salt://spacewalk/spacewalk-nightly.repo

/etc/yum.repos.d/spacewalk-source.repo:
  file.managed:
    - source: salt://spacewalk/spacewalk-source.repo

/etc/yum.repos.d/spacewalk.repo:
  file.managed:
    - source: salt://spacewalk/spacewalk.repo

/etc/yum.repos.d/jpackage-generic.repo:
  file.managed:
    - source: salt://spacewalk/jpackage-generic.repo

epel-source:
  pkg.installed:
    - sources:
      - epel-release: https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
