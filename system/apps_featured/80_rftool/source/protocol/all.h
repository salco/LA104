#include "protocol.h"
#include "weather.h"
#include "oregon2.h"
#include "key360.h"
#include "vw.h"
#include "nexus.h"
#include "gate.h"
#include "hcs200.h"

CWeather weather;
COregon2 oregon;
CKey360 key360;
CVw vw;
CNexus nexus;
CGate gate;
CHcs200 hcs200;
static CProtocol* protocols[] = {&weather, &oregon, &key360, &vw, &nexus, &gate, &hcs200};
