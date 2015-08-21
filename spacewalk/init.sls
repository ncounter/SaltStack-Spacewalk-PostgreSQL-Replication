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