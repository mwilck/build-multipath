define(`DEFAULT_TAG', `15.6')

ifelse(TYPE, `obs',
# 221117: IBS can't handle the registry.suse.com/ prefix  ("unresolvable") 
 `define(`BASE', `suse/sle15')',
# else clause!
# for local builds, include the secrets / credentials
# BASE = registry.suse.com/bci/bci-base works, too, but only for 15.3 and later
 `define(`BASE', `registry.suse.com/suse/sle15')
  define(`SLE_SDK', `sle-module-development-tools')
  include(`sles-buildx.m4')
  # SLE15-SP3 and SP4 have cmocka, but only for amd64 (bsc#12055542)
  # On OBS, the package seems to be found
  ifelse(regexp(TAG, `15.[01234]'), 0, `include(`sles-cmocka.m4')')')

# package renames
ifelse(regexp(TAG, `^15.0'), 0, `define(`clang', `clang5')',
       `define(`clang', `clang7')')

define(`OBS_PRJ', `patsubst(TAG, `\([0-9]+\)\.\([0-9]+\)', `sles\1-sp\2')')
