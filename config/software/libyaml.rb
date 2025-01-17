#
# Copyright 2012-2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "libyaml"
default_version '0.1.6'

source url: "https://github.com/bpaquet/ppc64le/raw/master/yaml-#{version}.tar.gz",
       md5: 'dc59ee9fb5e1afa2f1833349a9b14fad'

relative_path "yaml-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure --prefix=#{install_dir}/embedded --enable-shared", env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
