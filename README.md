# config-mgmt
config-mgmt with puppet


List all the certificates on puppetserver
`/opt/puppetlabs/bin/puppetserver ca list --all`

Remove an existing certificate
`/opt/puppetlabs/bin/puppetserver ca clean --certname ubuntu20-1.vagrant.local`