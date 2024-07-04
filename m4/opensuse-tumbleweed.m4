ifelse(TYPE, `obs',
  `define(`BASE', `opensuse/tumbleweed')',
  `define(`BASE', `registry.opensuse.org/opensuse/tumbleweed')')
define(`DEFAULT_TAG', `latest')
