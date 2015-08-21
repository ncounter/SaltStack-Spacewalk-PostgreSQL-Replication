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

/usr/tmp/spacewalk-config.txt:
  file.managed:
    - source: salt://spacewalk/spacewalk-config.txt

epel-source:
  pkg.installed:
    - sources:
      - epel-release: https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

firewalld:
  service.dead:
    - enable: False

spacewalk-install:
  pkg.installed:
    - name: spacewalk-postgresql
    - require:
      - file: /etc/yum.repos.d/spacewalk-nightly.repo
      - file: /etc/yum.repos.d/spacewalk-source.repo
      - file: /etc/yum.repos.d/spacewalk.repo
      - file: /etc/yum.repos.d/jpackage-generic.repo
      - file: /usr/tmp/spacewalk-config.txt
      - pkg: epel-source
      - service: pgpool-start

spacewalk-setup:
  cmd.run:
    - name: spacewalk-setup --disconnected --external-postgresql --answer-file=/usr/tmp/spacewalk-config.txt
    - creates: /var/log/rhn/rhn_installation.log
    - require:
      - pkg: spacewalk-install
