# A short tour of the m4 code

 - `dockerfile.m4`: The skeleton of the Dockerfile, to be filled out.
 - `runnerfile.m4`: Likewise, for the runtime environment.
 - `multipath.m4`: An example of a package definition. It sets requirements
   for building, devel packages, and runtime requirements.
 - `header.m4`: the "main" file, includes other files in the correct sequence.
 - `macros.m4`: the bulk of the m4 "code".
 - `defaults.m4`: general defaults
 
The other files contain distribution-specific macros and overrides. A dash is
used to separate distribution and release. If you run `m4 -D DISTRO=sles-15`,
the code will include `sles.m4` and (if found) `sles-15.m4`, which may
override some of the generic distribution code.

To add a new PACKAGE, have a look at `multipath.m4`.

To add a new distribution, start with one of existing files, e.g. `alpine.m4`
or `fedora-m4`.
