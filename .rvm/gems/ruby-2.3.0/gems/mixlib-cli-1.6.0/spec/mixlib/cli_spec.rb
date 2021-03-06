#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
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

require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

describe Mixlib::CLI do
  after(:each) do
    TestCLI.options = {}
    TestCLI.banner("Usage: #{$0} (options)")
  end

  describe "class method" do
    describe "option" do
      it "should allow you to set a config option with a hash" do
        TestCLI.option(:config_file, :short => "-c CONFIG").should == { :short => "-c CONFIG" }
      end
    end

    describe "options" do
      it "should return the current options hash" do
        TestCLI.option(:config_file, :short => "-c CONFIG")
        TestCLI.options.should == { :config_file => { :short => "-c CONFIG" } }
      end
    end

    describe "options=" do
      it "should allow you to set the full options with a single hash" do
        TestCLI.options = { :config_file => { :short => "-c CONFIG" } }
        TestCLI.options.should == { :config_file => { :short => "-c CONFIG" } }
      end
    end

    describe "banner" do
      it "should have a default value" do
        TestCLI.banner.should =~ /^Usage: (.+) \(options\)$/
      end

      it "should allow you to set the banner" do
        TestCLI.banner("Usage: foo")
        TestCLI.banner.should == "Usage: foo"
      end
    end
  end

  context "when configured with default single-config-hash behavior" do

    before(:each) do
      @cli = TestCLI.new
    end

    describe "initialize" do
      it "should set the banner to the class defined banner" do
        @cli.banner.should == TestCLI.banner
      end

      it "should set the options to the class defined options, plus defaults" do
        TestCLI.option(:config_file, :short => "-l LOG")
        cli = TestCLI.new
        cli.options.should == {
          :config_file => {
            :short => "-l LOG",
            :on => :on,
            :boolean => false,
            :required => false,
            :proc => nil,
            :show_options => false,
            :exit => nil,
            :in => nil,
          },
        }
      end

      it "should set the default config value for any options that include it" do
        TestCLI.option(:config_file, :short => "-l LOG", :default => :debug)
        @cli = TestCLI.new
        @cli.config[:config_file].should == :debug
      end
    end

    describe "opt_parser" do

      it "should set the banner in opt_parse" do
        @cli.opt_parser.banner.should == @cli.banner
      end

      it "should present the arguments in the banner" do
        TestCLI.option(:config_file, :short => "-l LOG")
        @cli = TestCLI.new
        @cli.opt_parser.to_s.should =~ /-l LOG/
      end

      it "should honor :on => :tail options in the banner" do
        TestCLI.option(:config_file, :short => "-l LOG")
        TestCLI.option(:help, :short => "-h", :boolean => true, :on => :tail)
        @cli = TestCLI.new
        @cli.opt_parser.to_s.split("\n").last.should =~ /-h/
      end

      it "should honor :on => :head options in the banner" do
        TestCLI.option(:config_file, :short => "-l LOG")
        TestCLI.option(:help, :short => "-h", :boolean => true, :on => :head)
        @cli = TestCLI.new
        @cli.opt_parser.to_s.split("\n")[1].should =~ /-h/
      end

      it "should present the arguments in alphabetical order in the banner" do
        TestCLI.option(:alpha, :short => "-a ALPHA")
        TestCLI.option(:beta, :short => "-b BETA")
        TestCLI.option(:zeta, :short => "-z ZETA")
        @cli = TestCLI.new
        output_lines = @cli.opt_parser.to_s.split("\n")
        output_lines[1].should =~ /-a ALPHA/
        output_lines[2].should =~ /-b BETA/
        output_lines[3].should =~ /-z ZETA/
      end

    end

    describe "parse_options" do
      it "should set the corresponding config value for non-boolean arguments" do
        TestCLI.option(:config_file, :short => "-c CONFIG")
        @cli = TestCLI.new
        @cli.parse_options([ "-c", "foo.rb" ])
        @cli.config[:config_file].should == "foo.rb"
      end

      it "should set the corresponding config value according to a supplied proc" do
        TestCLI.option(:number,
          :short => "-n NUMBER",
          :proc => Proc.new { |config| config.to_i + 2 }
        )
        @cli = TestCLI.new
        @cli.parse_options([ "-n", "2" ])
        @cli.config[:number].should == 4
      end

      it "should set the corresponding config value to true for boolean arguments" do
        TestCLI.option(:i_am_boolean, :short => "-i", :boolean => true)
        @cli = TestCLI.new
        @cli.parse_options([ "-i" ])
        @cli.config[:i_am_boolean].should == true
      end

      it "should set the corresponding config value to false when a boolean is prefixed with --no" do
        TestCLI.option(:i_am_boolean, :long => "--[no-]bool", :boolean => true)
        @cli = TestCLI.new
        @cli.parse_options([ "--no-bool" ])
        @cli.config[:i_am_boolean].should == false
      end

      it "should exit if a config option has :exit set" do
        TestCLI.option(:i_am_exit, :short => "-x", :boolean => true, :exit => 0)
        @cli = TestCLI.new
        lambda { @cli.parse_options(["-x"]) }.should raise_error(SystemExit)
      end

      it "should exit if a required option is missing" do
        TestCLI.option(:require_me, :short => "-r", :boolean => true, :required => true)
        @cli = TestCLI.new
        lambda { @cli.parse_options([]) }.should raise_error(SystemExit)
      end

      it "should exit if option is not included in the list" do
        TestCLI.option(:inclusion, :short => "-i val", :in => %w{one two})
        @cli = TestCLI.new
        lambda { @cli.parse_options(["-i", "three"]) }.should raise_error(SystemExit)
      end

      it "should raise ArgumentError if options key :in is not an array" do
        TestCLI.option(:inclusion, :short => "-i val", :in => "foo")
        @cli = TestCLI.new
        lambda { @cli.parse_options(["-i", "three"]) }.should raise_error(ArgumentError)
      end

      it "should not exit if option is included in the list" do
        TestCLI.option(:inclusion, :short => "-i val", :in => %w{one two})
        @cli = TestCLI.new
        @cli.parse_options(["-i", "one"])
        @cli.config[:inclusion].should == "one"
      end

      it "should change description if :in key is specified" do
        TestCLI.option(:inclusion, :short => "-i val", :in => %w{one two}, :description => "desc")
        @cli = TestCLI.new
        @cli.parse_options(["-i", "one"])
        @cli.options[:inclusion][:description].should == "desc (included in ['one', 'two'])"
      end

      it "should not exit if a required option is specified" do
        TestCLI.option(:require_me, :short => "-r", :boolean => true, :required => true)
        @cli = TestCLI.new
        @cli.parse_options(["-r"])
        @cli.config[:require_me].should == true
      end

      it "should not exit if a required boolean option is specified and false" do
        TestCLI.option(:require_me, :long => "--[no-]req", :boolean => true, :required => true)
        @cli = TestCLI.new
        @cli.parse_options(["--no-req"])
        @cli.config[:require_me].should == false
      end

      it "should not exit if a required option is specified and empty" do
        TestCLI.option(:require_me, :short => "-r VALUE", :required => true)
        @cli = TestCLI.new
        @cli.parse_options(["-r", ""])
        @cli.config[:require_me].should == ""
      end

      it "should preserve all of the commandline arguments, ARGV" do
        TestCLI.option(:config_file, :short => "-c CONFIG")
        @cli = TestCLI.new
        argv_old = ARGV.dup
        ARGV.replace ["-c", "foo.rb"]
        @cli.parse_options()
        ARGV.should == ["-c", "foo.rb"]
        ARGV.replace argv_old
      end

      it "should preserve and return any un-parsed elements" do
        TestCLI.option(:party, :short => "-p LOCATION")
        @cli = TestCLI.new
        @cli.parse_options([ "easy", "-p", "opscode", "hard" ]).should == %w{easy hard}
        @cli.cli_arguments.should == %w{easy hard}
      end
    end
  end

  context "when configured to separate default options" do
    before do
      TestCLI.use_separate_default_options true
      TestCLI.option(:defaulter, :short => "-D SOMETHING", :default => "this is the default")
      @cli = TestCLI.new
    end

    it "sets default values on the `default` hash" do
      @cli.parse_options([])
      @cli.default_config[:defaulter].should == "this is the default"
      @cli.config[:defaulter].should be_nil
    end

    it "sets parsed values on the `config` hash" do
      @cli.parse_options(%w{-D not-default})
      @cli.default_config[:defaulter].should == "this is the default"
      @cli.config[:defaulter].should == "not-default"
    end

  end

  context "when subclassed" do
    before do
      TestCLI.options = { :arg1 => { :boolean => true } }
    end

    it "should retain previously defined options from parent" do
      class T1 < TestCLI
        option :arg2, :boolean => true
      end
      T1.options[:arg1].should be_a(Hash)
      T1.options[:arg2].should be_a(Hash)
      TestCLI.options[:arg2].should be_nil
    end

    it "should not be able to modify parent classes options" do
      class T2 < TestCLI
        option :arg2, :boolean => true
      end
      T2.options[:arg1][:boolean] = false
      T2.options[:arg1][:boolean].should be_false
      TestCLI.options[:arg1][:boolean].should be_true
    end

    it "should pass its options onto child" do
      class T3 < TestCLI
        option :arg2, :boolean => true
      end
      class T4 < T3
        option :arg3, :boolean => true
      end
      3.times do |i|
        T4.options["arg#{i + 1}".to_sym].should be_a(Hash)
      end
    end

    it "should also work with an option that's an array" do
      class T5 < TestCLI
        option :arg2, :default => []
      end

      class T6 < T5
      end

      T6.options[:arg2].should be_a(Hash)
    end

  end

end

#  option :config_file,
#    :short => "-c CONFIG",
#    :long  => "--config CONFIG",
#    :default => 'config.rb',
#    :description => "The configuration file to use"
#
#  option :log_level,
#    :short => "-l LEVEL",
#    :long  => "--log_level LEVEL",
#    :description => "Set the log level (debug, info, warn, error, fatal)",
#    :required => true,
#    :proc => nil
#
#  option :help,
#    :short => "-h",
#    :long => "--help",
#    :description => "Show this message",
#    :on => :tail,
#    :boolean => true,
#    :show_options => true,
#    :exit => 0
