package=libsnark
$(package)_download_path=https://github.com/radix42/$(package)/archive/
$(package)_file_name=$(package)-$($(package)_git_commit).tar.gz
$(package)_download_file=$($(package)_git_commit).tar.gz

$(package)_sha256_hash=09d406fef55a2463d3a5914927a46e1b927861c3ad4d82c0c1d13294452f5b6f
$(package)_git_commit=7bb402b10066b7c67ef67de5145f8ab734953395

$(package)_dependencies=libsodium

define $(package)_build_cmds
  CXXFLAGS="-DBINARY_OUTPUT -DPTW32_STATIC_LIB -DSTATICLIB -DNO_PT_COMPRESSION=1 -fopenmp -I/home/djm/mpir" LDFLAGS="-L/home/djm/mpir" $(MAKE) lib DEPINST=$(host_prefix) CURVE=ALT_BN128 MULTICORE=1 NO_PROCPS=1 NO_GTEST=1 NO_DOCS=1 STATIC=1 NO_SUPERCOP=1 FEATUREFLAGS=-DMONTGOMERY_OUTPUT OPTFLAGS="-O2 -march=x86-64"
endef

define $(package)_stage_cmds
  $(MAKE) install STATIC=1 DEPINST=$(host_prefix) PREFIX=$($(package)_staging_dir)$(host_prefix) CURVE=ALT_BN128 NO_SUPERCOP=1
endef
