define(`DEFAULT_TAG', `16.0')

ifelse(TYPE, `obs',
# 221117: IBS can't handle the registry.suse.com/ prefix  ("unresolvable") 
 `define(`BASE', `bci/bci-base')',
# else clause!
# for local builds, include the secrets / credentials
# BASE = registry.suse.com/bci/bci-base works, too, but only for 15.3 and later
 `define(`BASE', `registry.suse.com/bci/bci-base')
  define(`ADDON_MODS', `PackageHub')
  include(`sles-buildx.m4')')

define(`OBS_PRJ', `TAG')
