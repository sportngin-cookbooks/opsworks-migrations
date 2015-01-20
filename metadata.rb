name             'opsworks-migrations'
maintainer       'Sport Ngin'
maintainer_email 'platform-ops@sportngin.com'
license     "MIT"
version     "0.0.1"
description      'Run Rails migrations on demand for AWS OpsWorks.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.markdown'))
version          '0.1.0'

supports "amazon"

depends "opsworks_initial_setup"
depends "opsworks_commons"
depends "dependencies"
depends "deploy"

