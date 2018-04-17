# VirtualBox (appliances)

Virtual machines configured for development are available for use with [VirtualBox][1]. 

Virtual machines are configured up to, but not including the `rake db:seed` stage (see [Ubuntu 14.04][5] & [Ubuntu 16.04][6] instructions).

*Available VMs*

* [Ubuntu 14.04.5 LTS][2] (2458 MiB) sha1 [`85246701eec08bb6752c3e6080d8deb9e819c2dc`][7]
* [Ubuntu 16.04.4 LTS][3] (3084 MiB) sha1 [`ea00feb8ac0f8fcd57b290ac82ffdc96e5a63965`][8]
```
User: taxonworks
Pass: taxonworks
```

**IMPORTANT**: Before using TaxonWorks please go to its directory (*~/Projects/taxonworks*) and execute `git pull && bundle && yarn`.

[1]: https://www.virtualbox.org/wiki/Downloads
[2]: http://vm.taxonworks.org/virtual_box/TW_Ubuntu_14_04_5.ova
[3]: http://vm.taxonworks.org/virtual_box/TW_Ubuntu_16_04_4.ova
[4]: https://github.com/SpeciesFileGroup/taxonworks/issues/4
[5]: https://github.com/SpeciesFileGroup/install_taxonworks/blob/master/development/native/ubuntu_14_04.md
[6]: https://github.com/SpeciesFileGroup/install_taxonworks/blob/master/development/native/ubuntu_16_04.md
[7]: https://raw.githubusercontent.com/SpeciesFileGroup/install_taxonworks/master/development/vm/TW_Ubuntu_14_04_5.sha1
[8]: https://raw.githubusercontent.com/SpeciesFileGroup/install_taxonworks/master/development/vm/TW_Ubuntu_16_04_4.sha1
