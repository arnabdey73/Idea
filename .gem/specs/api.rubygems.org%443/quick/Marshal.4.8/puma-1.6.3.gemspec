u:Gem::SpecificationD	[I"1.8.24:ETiI"	puma; TU:Gem::Version[I"
1.6.3; TIu:	Time� �    :@_zoneI"UTC; TI"\Puma is a simple, fast, and highly concurrent HTTP 1.1 server for Ruby web applications; TU:Gem::Requirement[[[I">=; TU;[I"
1.8.7; TU;	[[[I">=; TU;[I"0; TI"	ruby; F[	o:Gem::Dependency
:
@nameI"	rack; T:@requirementU;	[[[I"~>; TU;[I"1.2; T:
@type:runtime:@prereleaseF:@version_requirementsU;	[[[I"~>; TU;[I"1.2; To;

;I"	rdoc; T;U;	[[[I"~>; TU;[I"	3.10; T;:development;F;U;	[[[I"~>; TU;[I"	3.10; To;

;I"rake-compiler; T;U;	[[[I"~>; TU;[I"
0.8.0; T;;;F;U;	[[[I"~>; TU;[I"
0.8.0; To;

;I"hoe; T;U;	[[[I"~>; TU;[I"3.0; T;;;F;U;	[[[I"~>; TU;[I"3.0; TI"	puma; T[I"evan@phx.io; T[I"Evan Phoenix; TI"�Puma is a simple, fast, and highly concurrent HTTP 1.1 server for Ruby web applications. It can be used with any application that supports Rack, and is considered the replacement for Webrick and Mongrel. It was designed to be the go-to server for [Rubinius](http://rubini.us), but also works well with JRuby and MRI. Puma is intended for use in both development and production environments.

Under the hood, Puma processes requests using a C-optimized Ragel extension (inherited from Mongrel) that provides fast, accurate HTTP 1.1 protocol parsing in a portable way. Puma then serves the request in a thread from an internal thread pool (which you can control). This allows Puma to provide real concurrency for your web application!

With Rubinius 2.0, Puma will utilize all cores on your CPU with real threads, meaning you won't have to spawn multiple processes to increase throughput. You can expect to see a similar benefit from JRuby.

On MRI, there is a Global Interpreter Lock (GIL) that ensures only one thread can be run at a time. But if you're doing a lot of blocking IO (such as HTTP calls to external APIs like Twitter), Puma still improves MRI's throughput by allowing blocking IO to be run concurrently (EventMachine-based servers such as Thin turn off this ability, requiring you to use special libraries). Your mileage may vary. In order to get the best throughput, it is highly recommended that you use a Ruby implementation with real threads like [Rubinius](http://rubini.us) or [JRuby](http://jruby.org).; TI"http://puma.io; TT@[ 