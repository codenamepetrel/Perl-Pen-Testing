#!/usr/bin/env perl

use strict;
use warnings;
use IO::Socket::INET;

my $network = '192.168.1';
my @tcp_ports = (1..1024);
my @udp_ports = (1..1024);

open(my $fh, '>', 'port_scan_results.txt') or die "Could not open file 'port_scan_results.txt': $!";

for my $i (1..255) {
    my $ip = "$network.$i";
    for my $port (@tcp_ports) {
        my $socket = IO::Socket::INET->new(
            PeerAddr => $ip,
            PeerPort => $port,
            Proto    => 'tcp',
            Timeout  => 0.1,
        );
        if ($socket) {
            print $fh "TCP Port $port is open on $ip\n";
            $socket->close();
        }
    }
    for my $port (@udp_ports) {
        my $socket = IO::Socket::INET->new(
            PeerAddr => $ip,
            PeerPort => $port,
            Proto    => 'udp',
            Timeout  => 0.1,
        );
        if ($socket) {
            print $fh "UDP Port $port is open on $ip\n";
            $socket->close();
        }
    }
}

close($fh);
