#!/usr/bin/env python3
"""
Socket Stress Test for AzerothCore
Tests authserver and worldserver connection handling under heavy load.

Usage:
    python3 socket_stress_heavy.py [duration_seconds] [auth_threads] [world_threads]

Defaults:
    duration: 300 seconds (5 minutes)
    auth_threads: 100
    world_threads: 150
"""

import socket
import time
import threading
import sys

AUTH_PORT = 3724
WORLD_PORT = 8085
HOST = '127.0.0.1'

stats = {'auth_ok': 0, 'auth_fail': 0, 'world_ok': 0, 'world_fail': 0}
running = True


def stress_auth():
    """Flood authserver with login challenge packets."""
    global stats
    while running:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(1)
            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
            s.connect((HOST, AUTH_PORT))
            # AUTH_LOGON_CHALLENGE packet
            packet = bytes([
                0x00,  # cmd: AUTH_LOGON_CHALLENGE
                0x00,  # error
                0x24, 0x00,  # size (36)
                0x57, 0x6F, 0x57, 0x00,  # 'WoW\0'
                0x03, 0x03, 0x05,  # version 3.3.5
                0x30, 0x30,  # build 12340
                0x78, 0x38, 0x36, 0x00,  # 'x86\0'
                0x6E, 0x69, 0x57, 0x00,  # 'niW\0' (Win reversed)
                0x53, 0x55, 0x6E, 0x65,  # 'SUne' (enUS reversed)
                0x3C, 0x00, 0x00, 0x00,  # timezone
                0x7F, 0x00, 0x00, 0x01,  # IP 127.0.0.1
                0x04,  # account name length
                0x54, 0x45, 0x53, 0x54  # 'TEST'
            ])
            s.sendall(packet)
            s.close()
            stats['auth_ok'] += 1
        except Exception:
            stats['auth_fail'] += 1


def stress_world():
    """Flood worldserver with connection attempts."""
    global stats
    while running:
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(1)
            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
            s.connect((HOST, WORLD_PORT))
            # Wait for SMSG_AUTH_CHALLENGE
            s.recv(64)
            s.close()
            stats['world_ok'] += 1
        except Exception:
            stats['world_fail'] += 1


def main():
    global running

    # Parse arguments
    duration = int(sys.argv[1]) if len(sys.argv) > 1 else 300
    auth_threads = int(sys.argv[2]) if len(sys.argv) > 2 else 100
    world_threads = int(sys.argv[3]) if len(sys.argv) > 3 else 150

    print("=" * 60)
    print("SOCKET STRESS TEST")
    print("=" * 60)
    print(f"Duration:      {duration} seconds")
    print(f"Auth threads:  {auth_threads} -> {HOST}:{AUTH_PORT}")
    print(f"World threads: {world_threads} -> {HOST}:{WORLD_PORT}")
    print("-" * 60)

    threads = []

    for _ in range(auth_threads):
        t = threading.Thread(target=stress_auth, daemon=True)
        t.start()
        threads.append(t)

    for _ in range(world_threads):
        t = threading.Thread(target=stress_world, daemon=True)
        t.start()
        threads.append(t)

    print(f"Started {len(threads)} threads")
    print("-" * 60)

    start = time.time()
    try:
        while time.time() - start < duration:
            elapsed = int(time.time() - start)
            total = stats['auth_ok'] + stats['world_ok']
            rate = total / max(elapsed, 1)
            print(f"\r[{elapsed:3d}s] Auth: {stats['auth_ok']:7d} ok {stats['auth_fail']:5d} fail | "
                  f"World: {stats['world_ok']:7d} ok {stats['world_fail']:5d} fail | "
                  f"Rate: {rate:,.0f}/s  ", end='', flush=True)
            time.sleep(1)
    except KeyboardInterrupt:
        print("\n\nInterrupted by user")

    running = False
    time.sleep(0.5)

    total_ok = stats['auth_ok'] + stats['world_ok']
    total_fail = stats['auth_fail'] + stats['world_fail']
    elapsed = time.time() - start

    print("\n" + "=" * 60)
    print("RESULTS:")
    print(f"  Duration:    {elapsed:.1f} seconds")
    print(f"  Auth:        {stats['auth_ok']:,} ok, {stats['auth_fail']:,} failed")
    print(f"  World:       {stats['world_ok']:,} ok, {stats['world_fail']:,} failed")
    print(f"  Total:       {total_ok:,} ok, {total_fail:,} failed")
    print(f"  Rate:        {total_ok / elapsed:,.0f} connections/sec average")
    if total_fail > 0:
        print(f"  Failure:     {total_fail / (total_ok + total_fail) * 100:.2f}%")
    print("=" * 60)


if __name__ == '__main__':
    main()
