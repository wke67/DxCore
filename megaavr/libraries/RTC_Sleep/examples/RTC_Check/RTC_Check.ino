#include <RTC_Sleep.h>


static uint32_t timer_overflow_count;

void setup()
{
    Serial.begin(115200);
    delay(500);
    Serial.printf("start\n");
    Serial.flush();
    rtc_sleep(1);
    while(rtc_millis() < 3) ; // wait for XTAL start-up
    rtc_set_millis(0);
}

long t=8192, time=0;
long delta=8192;
void loop()
{
    t=2000;// 8192;
    rtc_sleep(t);
    t=rtc_millis();
    delta=t-time;
    Serial.printf("time %ld  %ld  %ld\n", t, delta, timer_overflow_count);
    time=t;
    Serial.flush();
}
