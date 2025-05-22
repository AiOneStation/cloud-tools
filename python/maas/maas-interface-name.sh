#!/usr/bin/env python3
#
# 20-maas-01-dhcp-unconfigured-ifaces - Bring up and run DHCP on all interfaces
#
# Copyright (C) 2012-2020 Canonical
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# --- Start MAAS 1.0 script metadata ---
# name: 20-maas-02-dhcp-unconfigured-ifaces
# title: Bring up and run DHCP on all interfaces
# description: Bring up and run DHCP on all interfaces
# script_type: commissioning
# timeout: 10
# --- End MAAS 1.0 script metadata ---

# Run `dhclient` on all the unconfigured interfaces.
# This is done to create records in the leases file for the
# NICs attached to unconfigured interfaces.  This way the leases
# parser will be able to connect these NICs and the networks
# MAAS knows about.

from subprocess import call, check_output, Popen
from time import sleep


def get_iface_list(ifconfig_output):
    ifconfig_output = ifconfig_output.decode()
    return [
        line.split()[1].split(":")[0].split("@")[0]
        for line in ifconfig_output.splitlines()
        if " lo: " not in line
    ]


def has_ipv4_address(iface):
    output = check_output(["ip", "-4", "addr", "list", "dev", iface])
    for line in output.splitlines():
        if line.find(b" inet ") >= 0:
            return True
    return False


def has_ipv6_address(iface):
    no_ipv6_found = True
    output = check_output(["ip", "-6", "addr", "list", "dev", iface])
    for line in output.splitlines():
        if line.find(b" inet6 ") >= 0:
            if line.find(b" inet6 fe80:") == -1:
                return True
            no_ipv6_found = False
    # Bug 1640147: If there is no IPv6 address, then we consider this to be
    # a configured ipv6 interface, since ipv6 won't work there.
    return no_ipv6_found


def dhcp_explore():
    all_ifaces = sorted(
        get_iface_list(check_output(["ip", "-o", "link", "show"]))
    )
    print("INFO: Discovered interfaces - %s" % ", ".join(all_ifaces))
    configured_ifaces = sorted(
        get_iface_list(check_output(["ip", "-o", "link", "show", "up"]))
    )

    print(
        "INFO: configured  interfaces - %s"
        % ", ".join(configured_ifaces)
    )
    # Run dhclient in the background to avoid blocking node_info.  We need to
    # run two dhclient processes (one for IPv6 and one for IPv4) and IPv6 will
    # run into issues if the link-local address has not finished
    # conflict-detection before it starts.  This is complicated by interaction
    # with dhclient -4 bringing the interface up, so we address the issue by
    # running dhclient -6 in a loop that only tries 10 times.  Per RFC 5227,
    # conflict-detection could take as long as 9 seconds, so we sleep 10.
    # See https://launchpad.net/bugs/1447715
    for inx,iface in enumerate(configured_ifaces):
        print("INFO: modify network name %s..." % iface)
        call(["ifdown", iface])
        call(["ip", "link", "set", iface,"name","vth"+str(inx)])
        call(["ifup", iface])


if __name__ == "__main__":
    dhcp_explore()