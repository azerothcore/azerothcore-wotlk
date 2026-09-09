#!/usr/bin/env python3
"""Print synthetic movement fixtures from the pinned TrinityCore packet sequences."""

import argparse
import json
import re
import struct
import subprocess

PIN = "c699217775d90794158422387b07a917e161b582"


def encode(sequence, sample, always_timestamp=False):
    output = bytearray()
    bits = []

    def flush():
        if bits:
            output.append(sum(value << (7 - index) for index, value in enumerate(bits)))
            bits.clear()

    def bit(value):
        bits.append(int(bool(value)))
        if len(bits) == 8:
            flush()

    inverted = {
        "MovementFlags", "MovementFlags2", "Timestamp", "Orientation", "SplineElevation", "Pitch",
    }
    conditions = {name: bool(sample.get(name, 0)) for name in inverted}
    conditions.update({
        "TransportData": bool(sample.get("TransportGuid", 0)),
        "TransportTime2": bool(sample.get("TransportTime2", 0)),
        "VehicleId": bool(sample.get("TransportVehicleId", 0)),
        "FallData": bool(sample.get("FallTime", 0) or sample.get("MovementFlags", 0) & 0x800),
        "FallDirection": bool(sample.get("MovementFlags", 0) & 0x800),
        "Spline": False, "HeightChangeFailed": False,
    })
    if always_timestamp:
        conditions["Timestamp"] = True
    for element in sequence:
        name = element.removeprefix("MSE")
        if name == "End":
            break
        if name.startswith("HasTransportGuidByte") or name in {"HasVehicleId", "HasTransportTime2"}:
            if not conditions["TransportData"]:
                continue
        if name == "HasFallDirection" and not conditions["FallData"]:
            continue
        guid = re.fullmatch(r"(Has)?(Transport)?GuidByte([0-7])", name)
        if guid:
            presence, transport, index = guid.groups()
            if transport and not conditions["TransportData"]:
                continue
            value = (sample.get("TransportGuid" if transport else "Guid", 0) >> (int(index) * 8)) & 255
            if presence:
                bit(value)
            elif value:
                flush()
                output.append(value ^ 1)
        elif name.startswith("Has"):
            field = name[3:]
            bit(not conditions[field] if field in inverted else conditions[field])
        elif name in {"ZeroBit", "OneBit"}:
            bit(name == "OneBit")
        elif name == "FlushBits":
            flush()
        elif name in {"MovementFlags", "MovementFlags2"}:
            if conditions[name]:
                for shift in reversed(range(30 if name == "MovementFlags" else 12)):
                    bit((sample[name] >> shift) & 1)
        else:
            if name in conditions and not conditions[name]:
                continue
            if name.startswith("Transport"):
                if not conditions["TransportData"]:
                    continue
                if name == "TransportVehicleId" and not conditions["VehicleId"]:
                    continue
            if name.startswith("Fall"):
                if not conditions["FallData"]:
                    continue
                if name in {"FallHorizontalSpeed", "FallCosAngle", "FallSinAngle"} and not conditions["FallDirection"]:
                    continue
            format_code = "f"
            if name in {"Counter", "Timestamp", "FallTime", "TransportTime", "TransportTime2", "TransportVehicleId"}:
                format_code = "I"
            elif name == "TransportSeat":
                format_code = "b"
            flush()
            output.extend(struct.pack("<" + format_code, sample.get(name, 0)))
    flush()
    return output.hex().upper()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--trinity-repo", required=True)
    args = parser.parse_args()
    source = subprocess.check_output([
        "git", "-C", args.trinity_repo, "show", PIN + ":src/server/game/Movement/MovementStructures.cpp",
    ], text=True)
    sequences = {}
    for name in (
        "MovementHeartBeat", "MovementUpdate", "MoveSetRunSpeed", "MovementForceRunSpeedChangeAck",
        "MovementUpdateRunSpeed",
    ):
        body = re.search(r"\b" + name + r"\[\]\s*=\s*\{(.*?)\};", source, re.S).group(1)
        sequences[name] = re.findall(r"\bMSE\w+", body)
    samples = {
        "idle": {"Guid": 0x01020304, "PositionX": 1, "PositionY": 2, "PositionZ": 3, "Timestamp": 0x01020304},
        "sparse": {"Guid": 0x0010000000000001, "PositionX": -1, "PositionY": 2, "PositionZ": 3},
        "optional": {
            "Guid": 0x0807060504030201, "PositionX": 1.25, "PositionY": -2.5, "PositionZ": 3.75,
            "Orientation": 1.5, "Timestamp": 0x11223344, "MovementFlags": 0x02000800, "MovementFlags2": 0x10,
            "TransportGuid": 0x1020304050607080, "TransportPositionX": 6.25, "TransportPositionY": 7.5,
            "TransportPositionZ": -8.75, "TransportOrientation": 2, "TransportSeat": -1,
            "TransportTime": 42, "TransportTime2": 43, "TransportVehicleId": 44,
            "FallTime": 77, "FallVerticalSpeed": -4.25, "FallHorizontalSpeed": 5.5,
            "FallCosAngle": 0.75, "FallSinAngle": -0.5, "Pitch": -0.25, "SplineElevation": 0.25,
        },
    }
    for sample in samples.values():
        sample.update({"Counter": 0x10203040, "ExtraElement": 10.5})
    print(json.dumps({name: {packet: encode(sequence, sample, packet in {"MovementUpdate", "MovementUpdateRunSpeed"})
                            for packet, sequence in sequences.items()}
                      for name, sample in samples.items()}, indent=2))


if __name__ == "__main__":
    main()
