require 'test/unit'
require 'wsdl/parser'
module WSDL; module SimpleType


class TestRPC < Test::Unit::TestCase
  DIR = File.dirname(File.expand_path(__FILE__))
  def pathname(filename)
    File.join(DIR, filename)
  end

  def test_rpc
    system("cd #{DIR} && ruby #{pathname("../../../../bin/wsdl2ruby.rb")} --classdef --wsdl #{pathname("rpc.wsdl")} --type client --type server --force")
    compare("expectedDriver.rb", "echo_versionDriver.rb")
    compare("expectedService.rb", "echo_version_service.rb")

    File.unlink(pathname("echo_version_service.rb"))
    File.unlink(pathname("echo_version.rb"))
    File.unlink(pathname("echo_version_serviceClient.rb"))
    File.unlink(pathname("echo_versionDriver.rb"))
    File.unlink(pathname("echo_versionServant.rb"))
  end

  def compare(expected, actual)
    assert_equal(loadfile(expected), loadfile(actual))
  end

  def loadfile(file)
    File.open(pathname(file)) { |f| f.read }
  end
end


end; end
