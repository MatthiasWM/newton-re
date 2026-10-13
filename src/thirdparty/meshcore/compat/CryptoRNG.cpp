/*
	File:		thirdparty/meshcore/compat/CryptoRNG.cpp

	Contains:	rweather's Crypto library's RNG object, which its
				Ed25519::generatePrivateKey and Curve25519::dh1 name.
				MeshCore uses neither (its keys are made by orlp's ed25519
				from its own mesh::RNG, Identity.cpp), so the library's
				RNG.cpp - Arduino's EEPROM and noise sources - is not built,
				and this stands in for it: random bytes from the host
				(HostMeshRandom, hal/host/HostMesh.cpp), so that a call
				that did come here would still be safe.
*/

#include <string.h>
#include <RNG.h>

extern "C" void HostMeshRandom(void* bytes, size_t size);

RNGClass RNG;

RNGClass::RNGClass()
	: credits(0), firstSave(1), initialized(0), trngPending(0), timer(0), timeout(3600000), count(0), trngPosn(0)
{
	memset(block, 0, sizeof(block));
	memset(stream, 0, sizeof(stream));
	memset(noiseSources, 0, sizeof(noiseSources));
}

RNGClass::~RNGClass()
{
}

void
RNGClass::rand(uint8_t* data, size_t len)
{
	HostMeshRandom(data, len);
}
