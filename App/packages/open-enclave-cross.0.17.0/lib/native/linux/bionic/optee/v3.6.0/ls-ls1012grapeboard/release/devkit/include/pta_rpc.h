/*
 * Copyright (C) Microsoft. All rights reserved.
 */

#ifndef __PTA_RPC_H
#define __PTA_RPC_H

/* PTA UUID: {ad0fd0ae-09e1-464b-98ed-0607ec9ebd8b} */
#define PTA_RPC_UUID { 0xad0fd0ae, 0x09e1, 0x464b, { \
	0x98, 0xed, 0x06, 0x07, 0xec, 0x9e, 0xbd, 0x8b } }

/* Command IDs supported by the RPC PTA */
enum PTA_RPC_COMMANDS {
	PTA_RPC_EXECUTE,
};

#endif /* __PTA_RPC_H */
